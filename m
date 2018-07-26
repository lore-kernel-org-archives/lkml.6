Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B941BC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:01:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C9E20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 16:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="i/288t9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71C9E20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732022AbeGZRTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:19:18 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44987 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731801AbeGZRTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:19:17 -0400
Received: by mail-io0-f193.google.com with SMTP id q19-v6so1752440ioh.11
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jul 2018 09:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UXQCLx8fFGVGtEC44eD18OIiQ7bMYC9c9FfC9bhjjuU=;
        b=i/288t9+B90eu8IDW0nawTnWegpr84UgCYIiM1G3a5L9cnLw6jEABSJuqNJfFYV3ez
         +Ha3fCdLWiTPG7cMJtpR0Fpc5ekynP5BuFyk71Zl5iZzCtIkALJwiu6eC3U81cvhTncA
         dCdlKHcaa28vWJHxDaHTWoqDwPBeg2k0IX8X4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UXQCLx8fFGVGtEC44eD18OIiQ7bMYC9c9FfC9bhjjuU=;
        b=iYeRYx/PsLFIbUy2jQx3tbl7S9AutWfe8GTISUGdwMPu6Ob/JozLRsdXBpbrIUXQkF
         gYPt4/l3yy0RIbhiiRIuCSrRXBw/SiyLGeAcr/2tziV7nvATu+G5U6ParlwTa4sCb4P/
         yqnKN/rjql6dN+KFKm6gHwOSQcF0n7BQtxZU9y8yJ26YQ1iOXl9crfyZPmxXV809KZe2
         SLmKkwVtQG854yw2QFqd3HyRo1HeuUuawMsmcj4N2Puj2guqu23jxBQhiXKxRGFv/Q9x
         sVTYr79gxZXtwTmqT4mRt3mFkciWTey4FM9moJdYS1LOHTPU5v84aZxJI61BJvdlhNmu
         FmuA==
X-Gm-Message-State: AOUpUlHBpYsJoN/1/dNhZA24yJwDMAss0n656JM97jSQMN8rwvYMJhAx
        69B7mlXq9A0OiIpQBFbPycsjbuu4CteKAViyHlrBGA==
X-Google-Smtp-Source: AAOMgpfEUQV7bzXwjuThBiwYyWj5Kv3xPU3EYXWSy8BITI8P/QgRLakBuNOU/BoWN82iipFPrtfdiTCrLbitqup3XSs=
X-Received: by 2002:a6b:be83:: with SMTP id o125-v6mr1029625iof.173.1532620908352;
 Thu, 26 Jul 2018 09:01:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:ac05:0:0:0:0:0 with HTTP; Thu, 26 Jul 2018 09:01:47
 -0700 (PDT)
In-Reply-To: <20180726131424.nqkalmmncnfcrh2q@linutronix.de>
References: <20180726090449.hfvtey3ruzzhzdaz@linutronix.de>
 <CAKv+Gu_+t_VwY3xDq3nWbnOTfzBc6OtQeRD2GKsseO2uK-uruw@mail.gmail.com>
 <20180726121504.ba35z3j3wsesryy3@linutronix.de> <5052E25B-9942-40C1-BD53-86E3D7014557@linaro.org>
 <20180726124613.xgmidioqd4mcqpiw@linutronix.de> <8640BE46-B141-44F9-BD92-58A21A2B0EA7@linaro.org>
 <20180726131323.ffecgeqnry6th4mp@linutronix.de> <20180726131424.nqkalmmncnfcrh2q@linutronix.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 26 Jul 2018 18:01:47 +0200
Message-ID: <CAKv+Gu8FgcPZDDKWnC03eWVFH2npJz5_XQDoOzkGdDxxSqCj8g@mail.gmail.com>
Subject: Re: [PATCH RT] rtc: Disable RTC_DRV_EFI on RT
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users@vger.kernel.org,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Anna-Maria Gleixner <anna-maria@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 July 2018 at 15:14, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 2018-07-26 15:13:23 [+0200], To Ard Biesheuvel wrote:
>> On 2018-07-26 14:52:21 [+0200], Ard Biesheuvel wrote:
>> > We could also make it the default on -rt, but not disable it entirely, so that efi=runtime can be used to re-enable it.
>>
>> Oh. I like that. We have something similar for RCU. So I would need
>> that:
> and then I could make it default off:
>
> ----- >8
>
> Subject: [PATCH] efi: Disable runtime services on RT
>
> Based on meassurements the EFI functions get_variable /
> get_next_variable take up to 2us which looks okay.
> The functions get_time, set_time take around 10ms. Those 10ms are too
> much. Even one ms would be too much.
> Ard mentioned that SetVariable might even trigger larger latencies if
> the firware will erase flash blocks on NOR.
>
> The time-functions are used by efi-rtc and can be triggered during
> runtimed (either via explicit read/write or ntp sync).
>
> The variable write could be used by pstore.
> These functions can be disabled without much of a loss. The poweroff /
> reboot hooks may be provided by PSCI.
>
> Disable EFI's runtime wrappers.
>
> This was observed on "EFI v2.60 by SoftIron Overdrive 1000".
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  drivers/firmware/efi/efi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> index 232f4915223b..62c6e4b6ce3e 100644
> --- a/drivers/firmware/efi/efi.c
> +++ b/drivers/firmware/efi/efi.c
> @@ -84,7 +84,7 @@ struct mm_struct efi_mm = {
>         .mmlist                 = LIST_HEAD_INIT(efi_mm.mmlist),
>  };
>
> -static bool disable_runtime;
> +static bool disable_runtime = IS_ENABLED(CONFIG_PREEMPT_RT_BASE);
>  static int __init setup_noefi(char *arg)
>  {
>         disable_runtime = true;
> --
> 2.18.0
>

Yes, that's what I was thinking. This way, you can still reboot into
the same kernel occasionally with EFI runtime services enabled to,
e.g., use efibootmgr.

Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

for both patches if you queue them in the -rt tree. If you want them
in mainline, please resend them as proper patches once
CONFIG_PREEMPT_RT_BASE has been declared in mainline as well.
