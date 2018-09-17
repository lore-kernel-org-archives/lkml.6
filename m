Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 255DEECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23DE2151C
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 17:17:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="JxytkBCx";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="Ssc2NbW4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23DE2151C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728301AbeIQWpm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 18:45:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51116 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbeIQWpl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 18:45:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 8C67E60C60; Mon, 17 Sep 2018 17:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537204643;
        bh=PjDTBL7LKg8ktgKcI0HYuZpXiLodA2xKCkxLs1OM1TY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=JxytkBCxgwNBC7SDw/wLL50Z6UdQeG5Zi6qcTYkGPYLNuzN+iMpE3P0qKDxquAwqo
         W0jIuYVSqQMtD1dT1zrzoXrnVutFOPYgZQmV/gSN1V8M1rJOHod2KrhMwmX5N3mHo9
         ej4X4gWwGS9+0YzSHkJdjQGf40vEGTucfW2f84ys=
Received: from [192.168.43.47] (unknown [27.59.117.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A383E6031A;
        Mon, 17 Sep 2018 17:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537204641;
        bh=PjDTBL7LKg8ktgKcI0HYuZpXiLodA2xKCkxLs1OM1TY=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Ssc2NbW4B2r4UF+GcDPEuNyN15c8g3OIXmzfj37EpnqRAP16VICGy5F8Yw4q3juxt
         +vy+MJ8PKe7fatW1+NUEjbT7pOE2Q+vMz3LSXJOdQwcikpJGuduP4UyiYqhp2scq06
         mAg98pnd6bdXsXTRCk1ZuYLDUDvA2nrsRZQXs9g8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A383E6031A
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=saiprakash.ranjan@codeaurora.org
Subject: Re: [PATCH 2/6] pstore: Add event tracing support
To:     Kees Cook <keescook@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Laura Abbott <labbott@redhat.com>,
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
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        tsoni@codeaurora.org, Bryan Huntsman <bryanh@codeaurora.org>,
        Tingwei Zhang <tingwei@codeaurora.org>,
        Rob Herring <robh@kernel.org>
References: <cover.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <b9b60ff2864a17fb05481aa33f90114ab051d6ce.1536430404.git.saiprakash.ranjan@codeaurora.org>
 <141901b8-0a9a-2e7a-f7a4-cdefd157f4c6@codeaurora.org>
 <CAEXW_YSPNqVgoYWjVAMvGg_WoRV4SC2xDH1wQWTdQfBUOMQbbQ@mail.gmail.com>
 <CAGXu5jLkE+mZkVSFPeOq75im0Kozm+NzfqL9CD-OMe7b7=3O5g@mail.gmail.com>
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
Message-ID: <edd40dff-fc1e-6370-0839-7672ada4db54@codeaurora.org>
Date:   Mon, 17 Sep 2018 22:47:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGXu5jLkE+mZkVSFPeOq75im0Kozm+NzfqL9CD-OMe7b7=3O5g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/17/2018 8:24 PM, Kees Cook wrote:
> On Sun, Sep 16, 2018 at 6:55 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
>> On Sun, Sep 16, 2018, 12:08 AM Sai Prakash Ranjan
>> <saiprakash.ranjan@codeaurora.org> wrote:
>>>
>>> On 9/9/2018 1:57 AM, Sai Prakash Ranjan wrote:
>>>> Currently pstore has function trace support which can be
>>>> used to get the function call chain with limited data.
>>>> Event tracing has extra data which is useful to debug wide
>>>> variety of issues and is heavily used across the kernel.
>>>>
>>>> Adding this support to pstore can be very helpful to debug
>>>> different subsystems since almost all of them have trace
>>>> events already available. And also it is useful to debug
>>>> unknown resets or crashes since we can get lot more info
>>>> from event tracing by viewing the last occurred events.
>>>
>>> Anyone here?
>>
>> Sorry for the top post. I've been wanting to do this as well for some time.
>> It's quite useful. I am out of office this week and away from work machine.
>> I will take a look at your patches next week once I'm back at work. Thanks.
> 
> If Steven agrees this shouldn't live in ftrace directly and Joel
> reviews these patches, I think it should be fine. I'm travelling, but
> I can review it hopefully later this week.
> 

Thank you Kees.

- Sai

