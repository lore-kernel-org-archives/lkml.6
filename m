Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76054ECE564
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17CA22086E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 07:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="WWukR73b";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="huyeq+ln"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17CA22086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbeIRMm0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 08:42:26 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49430 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIRMm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 08:42:26 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6CD2360C61; Tue, 18 Sep 2018 07:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537254670;
        bh=5jLUauFHAzyO1s6Qo3WUJXffqt5cnBGwfJs5tS1ZftE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=WWukR73bO3WK0vWpdUXGtE/aAy++8Q9t/T5fP4QKnw/u2zYKPclp/3YG2aEuMaO8q
         m8lOD6xxdUexoKd3Qu7C7Ibxh1fcvb2s6ACJQHE4R/PDvZlCYbV529jU9zCTGUO5Zh
         K51YfQmXBFD/HtTqxDTnYfOQJhV0GvJRxulXoVjU=
Received: from [10.79.129.80] (blr-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 358D0607C6;
        Tue, 18 Sep 2018 07:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537254669;
        bh=5jLUauFHAzyO1s6Qo3WUJXffqt5cnBGwfJs5tS1ZftE=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=huyeq+lnj+EAOnZeYWHz0D+PRZTdXIr1QElMlB0yrf/Y1adioIZxVVVpWz6P6IuzC
         4GxkPFbXEe4HpHFxUf3cF45FWLvLty9NqjoFMPzPhbqcM5Bx24Rddr1FGcJZttgaO4
         AmipfblNGGv2WfAac6H/fb01vRiXlUTWSxPlBcJU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 358D0607C6
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 5/6] arm64/io: Add header for instrumentation of io
 operations
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, Laura Abbott <labbott@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Colin Cross <ccross@android.com>,
        Jason Baron <jbaron@akamai.com>,
        Tony Luck <tony.luck@intel.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
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
        Tingwei Zhang <tingwei@codeaurora.org>, mark.rutland@arm.com,
        robin.murphy@arm.com
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <bb322d763aa6c58f036e5209a481c769be92ab9b.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <20180917193940.3d68ef88@gandalf.local.home>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <c6470671-3abf-c296-586e-cca5131cc437@codeaurora.org>
Date:   Tue, 18 Sep 2018 12:40:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180917193940.3d68ef88@gandalf.local.home>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/18/2018 5:09 AM, Steven Rostedt wrote:
> On Sun,  9 Sep 2018 01:57:06 +0530
> Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org> wrote:
> 
>> The new asm-generic/io-instrumented.h will keep arch code
>> clean and separate from instrumented version which traces
>> io register accesses. This instrumented header can later
>> be included in arm as well for tracing io register accesses.
>>
> 
> Looks good to me.
> 
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> 
> -- Steve

Thanks for the ack Steve.

@Will/Mark/Robin Let me know if you have any review comments, thanks.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member
of Code Aurora Forum, hosted by The Linux Foundation
