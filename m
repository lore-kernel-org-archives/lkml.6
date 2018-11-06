Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8659FC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 333C92086B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 23:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vP34rVtX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 333C92086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730992AbeKGIvK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 03:51:10 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40446 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbeKGIvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 03:51:10 -0500
Received: by mail-qk1-f194.google.com with SMTP id y16so18372015qki.7
        for <linux-kernel@vger.kernel.org>; Tue, 06 Nov 2018 15:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JzT+g1DyVK0RCYgiq7kipbM1x/+NWgJ0z8J8CTpmR94=;
        b=vP34rVtXDRsGguxG8GY2V2poJXhxcPEX36ALqT0JmA57/l6gYrEbxj+Zyxkq6j9Okw
         VOzv6dqFN6N1FuAx7Ek58+SZHl6/ngXHnnXHwuqA/9xatb+36qrc4w3/mxEw11ew5JnK
         TUlNq1pfNmQ0euHUjM3sjLQ8RCFoSc64pLGERsyM3wUkR17TkhJEr5wlAvsU2wuLwIkZ
         WYRtwsAMGBlKZgwinwxF/sTRBwoPKVJ8GOI/Ez5MBLhWFNZfJgw6nohZsybZ1T5scK8W
         gnjmPdhMYI69VPX145t8zi+LjVTrvgjKLeZ/ixrI1k8lcOsT7lipfVvJdQGn2MfxMiYI
         geFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JzT+g1DyVK0RCYgiq7kipbM1x/+NWgJ0z8J8CTpmR94=;
        b=OuV4biQ+7icJ3kyCan7PTamFSabv+eUY7uc7R2jywjEL7r9caSx8LyBMLdCW3CmEv3
         Vofze0ncJf4bnEx2agpUqDrCVQp86CulVyAgZ2xgYltjo/8vsDDc80ksEk5f+QcdbC4A
         NtuU5no8puD7JOxV4HRocEwHCfcL8ciSM+q0ZXwrp/aYxepRiI+QPZrFhB4sbA6P6qCr
         eO8c5VGCWO8yS5cdG75P7ba3zkGKjYZqyCHLlbgrC5kpmoLW4mHfMlPQy148hJTaj1i/
         y/4/elPylOHWDWbYRz6iRbmEDOJ/QwvAX2b8HdznBQZVp+8SCFNvl6kvLTfoA40krznw
         xfHQ==
X-Gm-Message-State: AGRZ1gKwlU5bCNBMggXc6tPzCEs6yrkTs1KX3neUUkp0VgMIi0gvPIGV
        1O9zoT5UL/Px2ZXPFshGJTO/NgoVXLsV2qZ1Zny2IA==
X-Google-Smtp-Source: AJdET5eDmo7ilLkJyEr942I8c680YRvWyOE3kVNfuxG91ZpJCHV7Th4T9nqC7EBHXwlIK6zMITsEozK+9o8aOc3EeUY=
X-Received: by 2002:a37:d4d9:: with SMTP id s86mr26733675qks.190.1541546610786;
 Tue, 06 Nov 2018 15:23:30 -0800 (PST)
MIME-Version: 1.0
References: <20181022222614.41016-1-mikewu@google.com> <20181106232130.33932-1-mikewu@google.com>
In-Reply-To: <20181106232130.33932-1-mikewu@google.com>
From:   Ke Wu <mikewu@google.com>
Date:   Tue, 6 Nov 2018 15:23:19 -0800
Message-ID: <CANRnR9QkiiNNxSBzLUeFHw--xPGVEd5E0RfqNTgj4ji8LmVz7g@mail.gmail.com>
Subject: Re: [PATCH v2] modsign: use all trusted keys to verify module signature
To:     jeyu@kernel.org, dhowells@redhat.com
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the comment! I switched to use
VERIFY_USE_SECONDARY_KEYRING, please take a look.

On Tue, Nov 6, 2018 at 3:21 PM Ke Wu <mikewu@google.com> wrote:
>
> Make mod_verify_sig to use all trusted keys. This allows keys in
> secondary_trusted_keys to be used to verify PKCS#7 signature on a
> kernel module.
>
> Signed-off-by: Ke Wu <mikewu@google.com>
> ---
> Changelog since v1:
> - Use VERIFY_USE_SECONDARY_KEYRING rather than (void *)1UL
>
>  kernel/module_signing.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> index f2075ce8e4b3..6b9a926fd86b 100644
> --- a/kernel/module_signing.c
> +++ b/kernel/module_signing.c
> @@ -83,6 +83,7 @@ int mod_verify_sig(const void *mod, struct load_info *info)
>         }
>
>         return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> -                                     NULL, VERIFYING_MODULE_SIGNATURE,
> +                                     VERIFY_USE_SECONDARY_KEYRING,
> +                                     VERIFYING_MODULE_SIGNATURE,
>                                       NULL, NULL);
>  }
> --
> 2.19.1.930.g4563a0d9d0-goog
>


-- 
Ke Wu | Software Engineer | mikewu@google.com | Google Inc.
