Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A77C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D8512147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SgcwCMkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729214AbfBSTGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:06:01 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43253 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726610AbfBSTGB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:06:01 -0500
Received: by mail-pg1-f195.google.com with SMTP id v28so10551406pgk.10
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 11:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nrk4QYLpo4qvuxxWH/lg1WeZY/SrvgqAwlsmSMHY39k=;
        b=SgcwCMkfbVSA488eLFY30t6OTq/ozpLACZntUyGESHAvwr849VCjoS3b6hULDTBF+c
         B2BVb1RzNoG/zLpvCAe7F0UXvnMBw/B4HaAnAe1W1enRhQxCS4G/qPgoDeYB0UsWdUqS
         ilijjN0POsDyGVH0FKlkOcyZ3VwkUGtTdFIDM4Mjk4eIyQn3tGXbRLZPZScxN4eiURLM
         9l/ce0SuCTU/BJS5Z0m8zFwDViuBjJrgPMhFZLpFQtBM5wY1IfqaLK4tUPL8hvacogow
         K9pfE7t5jABmnYUTwSTvwz3fF8XdS6nlhwFFdzaI85WlNdi67BX3nBNMyepPGGXUCJtj
         GLBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nrk4QYLpo4qvuxxWH/lg1WeZY/SrvgqAwlsmSMHY39k=;
        b=osycPgQr8d5A2j6aBlXWNIoIyI3Hain0X6U7lKbTvlJJ5obkzU4LTQMkHY22TLiy9l
         Q5B2KJZz/aysy2/Ddik/j4xXiFFKZki2kBj6PC6g4LAF8UkAoQ9SDOuO0QvmfatPCRvm
         59bPEqhH7QbEOuL3PtRdr89ySMQ9MpiPKgKVWOLYOeufqkAXgDCs53VSIEo4rdF787p1
         RSpWk2etuAFh3Wrl4fok6jCgsfrs6BDeRBm6gjsPgRrkyAJ9umDhZY5ayuIkSlVolp9e
         staOFjYkgr5YTIFqNxWTpO49ZfxluoTWzH5Q76XPOvw+YWmamiZGv9/ZRUXnOI6o08kO
         qF7g==
X-Gm-Message-State: AHQUAuZk3vRR274Feo/CHJ2M1jdLUSvRwOQEpllxKLoPRXnKg4i7CkZY
        qyuv6+TUd8H8JCRc5nmuXz/BnyoBoDTzMJvW5Vnyfg==
X-Google-Smtp-Source: AHgI3IZf074hanX/iTBIzRRiZjGrwMeArSAXfkjKELtEgCQhDvOE4tbH7DvXQkq9qjv1ElNy3WPtGe1O1ti4mWxGpCM=
X-Received: by 2002:a63:5506:: with SMTP id j6mr1721996pgb.202.1550603160395;
 Tue, 19 Feb 2019 11:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20190219182105.19933-1-natechancellor@gmail.com>
In-Reply-To: <20190219182105.19933-1-natechancellor@gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 19 Feb 2019 11:05:49 -0800
Message-ID: <CAKwvOdmFE0kQoxvRDcarT+kYLXxqKYJfVHo4uTiYm7-wDefrrw@mail.gmail.com>
Subject: Re: [PATCH] iwlwifi: mvm: Use div64_s64 instead of do_div in iwl_mvm_debug_range_resp
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Intel Linux Wireless <linuxwifi@intel.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 19, 2019 at 10:21 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Clang warns:
>
> drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c:465:2: warning:
> comparison of distinct pointer types ('typeof ((rtt_avg)) *' (aka 'long
> long *') and 'uint64_t *' (aka 'unsigned long long *'))
> [-Wcompare-distinct-pointer-types]
>         do_div(rtt_avg, 6666);
>         ^~~~~~~~~~~~~~~~~~~~~
> include/asm-generic/div64.h:222:28: note: expanded from macro 'do_div'
>         (void)(((typeof((n)) *)0) == ((uint64_t *)0));  \
>                ~~~~~~~~~~~~~~~~~~ ^  ~~~~~~~~~~~~~~~
> 1 warning generated.
>
> do_div expects an unsigned dividend. Use div64_s64, which expects a
> signed dividend.

Eh, IIRC, signed vs unsigned division has implications for rounding
towards zero or not, but I doubt that the round trip time average (RTT
avg) should ever be negative.  General rule of thumb for C is to keep
arithmetic signed (even when working with non zero values), so rather
than make the literal (6666) a unsigned long, I agree with your change
to keep the division signed as well.  Thanks for the fix.
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

>
> Fixes: 937b10c0de68 ("iwlwifi: mvm: add debug prints for FTM")
> Link: https://github.com/ClangBuiltLinux/linux/issues/372
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
> index e9822a3ec373..92b22250eb7d 100644
> --- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
> +++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
> @@ -462,7 +462,7 @@ static void iwl_mvm_debug_range_resp(struct iwl_mvm *mvm, u8 index,
>  {
>         s64 rtt_avg = res->ftm.rtt_avg * 100;
>
> -       do_div(rtt_avg, 6666);
> +       div64_s64(rtt_avg, 6666);
>
>         IWL_DEBUG_INFO(mvm, "entry %d\n", index);
>         IWL_DEBUG_INFO(mvm, "\tstatus: %d\n", res->status);
> --
> 2.21.0.rc1
>


-- 
Thanks,
~Nick Desaulniers
