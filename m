Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F9ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:13:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8F49214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ayio3f/X";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DCDd/XsJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8F49214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeIQWlq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:41:46 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:45770 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQWlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:41:45 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 2CFF460C60; Mon, 17 Sep 2018 17:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537204408;
        bh=x6qDd0Hsb4iG+S4oQsgOz+JtPgkFAMppMye7tv2iLZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ayio3f/XcxEM11Fj+zcrqZBX9eUCFWGjxygSVRxbY3FKfVq+TM4iGP+IrcyRTLRQ4
         tDh3xYmX3CDWjddTR0AsOIlfJYsEqeFMwVs2VDx8FtBde8QCv0YOc3YjcfTO7be817
         fSacXc0MUxDKrYIRsGGd4MXGMkA/ejUsNG8KHzf0=
Received: from [192.168.43.47] (unknown [27.59.117.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32415605BD;
        Mon, 17 Sep 2018 17:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537204406;
        bh=x6qDd0Hsb4iG+S4oQsgOz+JtPgkFAMppMye7tv2iLZc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DCDd/XsJZ/7q7nIi+jMkslzzgrvWpUzZdmhkXgCCok5TY647RgzoUnrBMIWXnceth
         k/2WaQQlJLj9uftq+JQmVRVl3+icFS/cd79WqDGdQq4xwd3MhgceEiSQBQkeaptAv/
         MKmJnkwwG/VIA4qXu+ZxjqdwO5DAaApx6lgl1PlU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32415605BD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Joel Fernandes <joel@joelfernandes.org>
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
        Will Deacon <will.deacon@arm.com>,
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
        Tingwei Zhang <tingwei@codeaurora.org>, robh@kernel.org
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <141901b8-0a9a-2e7a-f7a4-cdefd157f4c6@codeaurora.org>
 <CAEXW_YSPNqVgoYWjVAMvGg_WoRV4SC2xDH1wQWTdQfBUOMQbbQ@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <90b4b568-2c46-b256-1704-18762e680453@codeaurora.org>
Date:   Mon, 17 Sep 2018 22:43:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAEXW_YSPNqVgoYWjVAMvGg_WoRV4SC2xDH1wQWTdQfBUOMQbbQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/16/2018 7:25 PM, Joel Fernandes wrote:
> Sorry for the top post. I've been wanting to do this as well for some 
> time. It's quite useful. I am out of office this week and away from work 
> machine. I will take a look at your patches next week once I'm back at 
> work. Thanks.
> 
> Best,
> J
> 

Cool, thanks Joel.

