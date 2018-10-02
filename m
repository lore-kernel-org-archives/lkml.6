Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FEFC64EBC
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DD7B205C9
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 22:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uWZa9/1e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DD7B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbeJCF0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 01:26:11 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37212 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbeJCF0L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 01:26:11 -0400
Received: by mail-pl1-f193.google.com with SMTP id az3-v6so2436664plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Oct 2018 15:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=19SUMWNxtpnlsJ60whnOpKgAKmOm2LeRRRDPAsunJHI=;
        b=uWZa9/1e8sBvsfy8v/ijdRtBMKeP/L0iX+uRJFgYlJvQPc7yAy301Ahq8/L6fGWLji
         x5TWZ7PDE+BGzLwFUPbErezDnMbSNvsrXk4Nzih5tXMKLZBnnu2qylTEHOiAfcHO7CQR
         13mLtnPimSHpg48bIMMh2ytyNmdn7Q4IpcNZUE6TFlxXtlMJ25ubzTnCSbXU4sjkqm8q
         7L0dvO436zjXFKJhGohNPDKazkOP0eDQxWoY3yghk6C5OfGO/pyuz1jtSCq7oM46nj5q
         +7Fwh8zWyDeQ9f3B/buVJgLwqKd3AWAzb/yFWI6nYtBJmzXZQ3tLQSfjDHkWxBhfk91Q
         SYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=19SUMWNxtpnlsJ60whnOpKgAKmOm2LeRRRDPAsunJHI=;
        b=bojS0S2O0+aA5+gaYtKEkbFk1bSuRNzsUj1NeduQccjIjVaIIwg6a7h55VehUbe+hK
         GmpOhFTV4f31zd/JoM+BOT4XspjViYvHqYZqe4pd9O4/Eg197m9LYDxfa2UnSnDTxpIh
         2OKznuTND/rCDIQIxwbZfA4yABuenY8/mAWJsHoS+yZ977BhTs7Y9T+NysYqi9zBoptL
         BA89Y9132iJxA3Ed/oaFbpQMWu5gc1PjbSqTIQX7jqhQ0q7MwRNi7k16gSX3voeCgRx0
         gXBdDsqu+Js45gr2ti2z2CyQ/ZEbiYzDJOhPbwsrpDnWBlrz5vR27kRZQKgBUpuMNybs
         0aZQ==
X-Gm-Message-State: ABuFfogGRpF9da8U3fsYf6lkreJ+Dl0VSJ/HH/p+DsQ0dfplazYqf81U
        VskFM0LtYGlvF405Zo7dPfcyqyNq17Ka1MCR0iC8Mg==
X-Google-Smtp-Source: ACcGV61XrBuBHdTWIOLNxxQKbOFYY5bZMdmp0WYlsFIrUPjmln7OfjRAmE7VFh77/l991Quywjdt/hYDXaNagHNCggQ=
X-Received: by 2002:a17:902:82c9:: with SMTP id u9-v6mr12548562plz.320.1538520031549;
 Tue, 02 Oct 2018 15:40:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181002223457.7564-1-natechancellor@gmail.com>
In-Reply-To: <20181002223457.7564-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 2 Oct 2018 15:40:19 -0700
Message-ID: <CAKwvOdnbnw-yciWkuuKMye=57qwpXDX4oPaoNUoeYvbpn-Tavw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq / CPPC: Mark acpi_ids as used
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     rjw@rjwysocki.net, Viresh Kumar <viresh.kumar@linaro.org>,
        linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 2, 2018 at 3:35 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/cpufreq/cppc_cpufreq.c:431:36: warning: variable 'cppc_acpi_ids'
> is not needed and will not be emitted [-Wunneeded-internal-declaration]
> static const struct acpi_device_id cppc_acpi_ids[] = {
>                                    ^
> 1 warning generated.
>
> Mark the definition as used so that Clang understands we don't want this
> warning while not inhibiting Clang's dead code elimination from removing
> the unreferenced internal symbol when moving the data it contains to the
> globally available symbol via MODULE_DEVICE_TABLE.
>
> $ nm -S drivers/cpufreq/cppc_cpufreq.o | grep acpi | tail -1
> 0000000000000000 0000000000000040 R __mod_acpi__cppc_acpi_ids_device_table
>
> Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
> Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/cpufreq/cppc_cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
> index 30f302149730..fd25c21cee72 100644
> --- a/drivers/cpufreq/cppc_cpufreq.c
> +++ b/drivers/cpufreq/cppc_cpufreq.c
> @@ -428,7 +428,7 @@ MODULE_LICENSE("GPL");
>
>  late_initcall(cppc_cpufreq_init);
>
> -static const struct acpi_device_id cppc_acpi_ids[] = {
> +static const struct acpi_device_id cppc_acpi_ids[] __used = {
>         {ACPI_PROCESSOR_DEVICE_HID, },
>         {}
>  };
> --
> 2.19.0
>

LGTM, thanks Nathan.  For other reviewers,
https://lkml.org/lkml/2018/9/27/91 might provide more insight into why
this is the correct fix for this particular bug.
-- 
Thanks,
~Nick Desaulniers
