Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86287C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4857720700
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="odG5f5cM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4857720700
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388028AbeKFEef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 23:34:35 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38427 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387441AbeKFEef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 23:34:35 -0500
Received: by mail-qk1-f195.google.com with SMTP id d19so16805544qkg.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 11:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IZnWVjgh+r1IbD81wlrwZxXe9WdHN1e3MpPXEAup0nc=;
        b=odG5f5cMI3FkUo50hOsKuTPzKJkvgAt0ffJQZAV2k3QirKsBC8DblSIBzFIRySR7ER
         /JaS2v43Zv9byEX6siIOQllRiT2svJyKznMmdWKYB9I9cgVgmr6sI4DD96lVpK6qf3aS
         chB0zPsz32tKY+0YetWY805RF7WELlrUlfJzBwrg0R9jjz2WbgIpcuZYYqkSeV4YpLtr
         /5uSPe8SX8HfBwnZ9qL8n8MokDsUnPWCpRu/fIM0YrTKd8DnW6/HLHIFwt3Q59DmEMIl
         r8/wVnj62/xSFnjuQJn8q7bLP6+E3xPgoES8Y92FpRAATD66CW0FK7YE8UtqQVyE+a5l
         /w8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IZnWVjgh+r1IbD81wlrwZxXe9WdHN1e3MpPXEAup0nc=;
        b=EIzM+VZlfhMG2GcMKLY6aUQlCfUG2q584LCi7zD7OxuIHKefoxsv5jgCmTdtFK6lTf
         ELhPwraOhExcHdRVpv+TwIdsPgJlbrxnJmu45T8mAUqmI3h3P13NdJTZc/DwgkxrwAo6
         9cpp9Oq8be0kZ8oZ0dAU9QFckKN5hrBOyF3D7oAviPMHv1z6/Qs8EkyDwjb3DkOpCnQw
         KSiebKutgMrQ/HJMV0Z3xCd9x2n6VMdfzbeVSpyhb5DgT17Kf3V2+esijjJMV4S8Y5XN
         3R3gXrhDtaspowTNGevTNFmQUJ9kCRHc6cA1LGe8TEW8XJNrrlAqXo9yGg9TyFDDdKXI
         7AmQ==
X-Gm-Message-State: AGRZ1gJCwZSsrwmgzoxA2gkv47ilWbobGFobhd8SJTzmmk0ON4e1b47N
        hDMycxBdmd5VxxcVHWiypj5+RPcJI22B0uf52K4jKg==
X-Google-Smtp-Source: AJdET5ceCQNIZ5AEI1sikNvhlGpdld7OoNZKMSyUaph755tkyKrzHTjQ4BCwJTKdZMvi3GbqpSxWRqgCP3jZ3wWWvNw=
X-Received: by 2002:a0c:bfd4:: with SMTP id u20mr22888889qvj.113.1541445208601;
 Mon, 05 Nov 2018 11:13:28 -0800 (PST)
MIME-Version: 1.0
References: <20181022222614.41016-1-mikewu@google.com> <20181031093619.24n53lfeink3qsk6@linux-8ccs>
In-Reply-To: <20181031093619.24n53lfeink3qsk6@linux-8ccs>
From:   Ke Wu <mikewu@google.com>
Date:   Mon, 5 Nov 2018 11:13:17 -0800
Message-ID: <CANRnR9Qs0wjAprhLzNTg1COLyyh9pcv_SxtZnKBoadED0RJVjg@mail.gmail.com>
Subject: Re: [PATCH] modsign: use all trusted keys to verify module signature
To:     jeyu@kernel.org
Cc:     dhowells@redhat.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I'm wondering if there is any update for the patch.

Thanks!

On Wed, Oct 31, 2018 at 2:36 AM Jessica Yu <jeyu@kernel.org> wrote:
>
> +++ Ke Wu [22/10/18 15:26 -0700]:
> >Make mod_verify_sig to use all trusted keys. This allows keys in
> >secondary_trusted_keys to be used to verify PKCS#7 signature on a
> >kernel module.
> >
> >Signed-off-by: Ke Wu <mikewu@google.com>
>
> Thanks for the ping, I had missed this patch.
>
> David, could I get an ACK please?
>
> Thanks!
>
> Jessica
>
> >---
> > kernel/module_signing.c | 2 +-
> > 1 file changed, 1 insertion(+), 1 deletion(-)
> >
> >diff --git a/kernel/module_signing.c b/kernel/module_signing.c
> >index f2075ce8e4b3..a8b923ba1a39 100644
> >--- a/kernel/module_signing.c
> >+++ b/kernel/module_signing.c
> >@@ -83,6 +83,6 @@ int mod_verify_sig(const void *mod, struct load_info *info)
> >       }
> >
> >       return verify_pkcs7_signature(mod, modlen, mod + modlen, sig_len,
> >-                                    NULL, VERIFYING_MODULE_SIGNATURE,
> >+                                    (void *)1UL, VERIFYING_MODULE_SIGNATURE,
> >                                     NULL, NULL);
> > }
> >--
> >2.19.1.568.g152ad8e336-goog
> >



-- 
Ke Wu | Software Engineer | mikewu@google.com | Google Inc.
