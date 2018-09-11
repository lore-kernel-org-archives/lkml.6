Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE3F6C6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76D0A2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 16:12:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="hc/nHqLX";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Cghb0jHj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76D0A2086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeIKVMM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 17:12:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbeIKVMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 17:12:12 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9C45460A9B; Tue, 11 Sep 2018 16:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536682331;
        bh=+YDIQC2k8XYCN0901vwH8KyjqWHAARTADBoLIXk0sPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=hc/nHqLXrz6I9UMa3Xc7Z0jNDGhfP15PSRWRyihs/xUukEA7XEb1+8ysu3UE7YTIH
         BX6bR3xDXNj1Ccp0G0sL+dpnZPkUwVxPg9xITFiNwoN2GivuhnwINc7g1gZPOBN9L2
         /rwsadx3tzpnQ/YZQi+6U3SGsZ4V5vDu8nijpOqI=
Received: from [192.168.1.102] (unknown [157.49.253.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82FE2606AC;
        Tue, 11 Sep 2018 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536682330;
        bh=+YDIQC2k8XYCN0901vwH8KyjqWHAARTADBoLIXk0sPk=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Cghb0jHjWISfQXT2y8GSq9UlTxfeI3qCGYogiLFEOtm97K1eA+vk0Fpk1E4l4tkhf
         EAkVTNspfv8npSNTB2qwCkFXoLlTmAAHMi0UBdMF05OIhyK31sVh5Fv9Dm6Rbr15Di
         XKkvgE4svs9k19yBHfVySc8wETe/bHTw9XkrN5ck=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 82FE2606AC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 0/6] Tracing register accesses with pstore and dynamic
 debug
To:     Will Deacon <will.deacon@arm.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Joe Perches <joe@perches.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Sibi Sankar <sibis@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20180911151148.GI2651@arm.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <2714af83-d2f7-473e-c234-428d2b8a84f0@codeaurora.org>
Date:   Tue, 11 Sep 2018 21:41:55 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180911151148.GI2651@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/2018 8:41 PM, Will Deacon wrote:
> Hello,
> 
> On Sun, Sep 09, 2018 at 01:57:01AM +0530, Sai Prakash Ranjan wrote:
>> This patch series adds Event tracing support to pstore and is continuation
>> to the RFC patch introduced to add a new tracing facility for register
>> accesses called Register Trace Buffer(RTB). Since we decided to not introduce
>> a separate framework to trace register accesses and use existing framework
>> like tracepoints, I have moved from RFC. Details of the RFC in link below:
>>
>> Link: https://lore.kernel.org/lkml/cover.1535119710.git.saiprakash.ranjan@codeaurora.org/
> 
> The arm64 backend bits look fine to be, but they're mixed up with core
> changes that I haven't looked at closely.
> 
Hi Will,

Thanks for the review. Let me know if you have any suggestions or points 
regarding this patch, I will be happy to incorporate it.
