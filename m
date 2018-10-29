Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA135C0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:50:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F2B420657
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 13:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR3fZTti"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F2B420657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbeJ2Wjn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 18:39:43 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:41103 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbeJ2Wjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 18:39:43 -0400
Received: by mail-qt1-f196.google.com with SMTP id l41-v6so9205972qtl.8;
        Mon, 29 Oct 2018 06:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n/Ms3r39f4kt4aL4UuphCtuvRGXEN4bFd4b6BRRBwcs=;
        b=fR3fZTtiwil3ujPl/3Rp4gEqITqpKL2oDVbKzXWsQHDybpx9q4Xytc+3a5wMQkJOIu
         HYkhL7GyrHCs1BFjlEcm93qHJcMOBQOtI8CJkiOOJER62uUN1FjEOcW9CTK3JrVA3Qdf
         sOrpXXyxLpHRmNSP1c9Hr9yg/mv78PKepVF+s+KJOleAxsVPoQk7rEMsJnUsNQapfoVD
         9TfU3axtXnbEA/44ZVTTMq4LzA7l8pldupbWCUt6BtIVq9v9KMhjAfu7161wmqHAOgKA
         DQX1p5QKyCYXSAIbncZRH0vQihJupVttcnwuDG0wy1c93qaHHxVmFO6mzFiZgjOPCPLC
         hNpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n/Ms3r39f4kt4aL4UuphCtuvRGXEN4bFd4b6BRRBwcs=;
        b=cz+N5iQUVtyOtH5rCNZhwnnoBSdUef4K28E3vvt8DbXnEX/WfYdJZEb0sYiIYWZnT6
         R+/ribYzJt6Y0gagddZcasd5e/psY+CdDR+84dgmh596ayhWgEDIskgaxhQMIF+QOy5x
         LtV4zr5dAgoLlqYVVRcPEQSkdGpYzH0X4od4sO82tkNfvsyqYdX30l9Ds6hlMkLhyOzX
         vbPHeNxEXMZ1uHEqfme/WOC1CYF5viteZyklsV90qJ1GfsnJSMpURALOROond6FAKD4F
         /DiSxVoP79FDsIXh50MJCfN54qAdRJ7ysyg6b7DFFfIA6z50Lmz551Xc5AP0sgLvY0+X
         ktkQ==
X-Gm-Message-State: AGRZ1gLlwbtkksko+ugIFkH73/rJMe7pT+/hGHYmzqSoz897v6e2CgXb
        zHDsQQgYLeTcJBZcR90HORoFsqZV0kTUGlTtCnI=
X-Google-Smtp-Source: AJdET5f/daUD2MkIjCbiAhG6YJZMRxyKoEjr1vIKhKzjMTatfFPKo3lzkLba3v4EpNqdmSdolOwXP3IEHnaDBTu9+Pg=
X-Received: by 2002:a0c:d268:: with SMTP id o37mr13193139qvh.136.1540821056655;
 Mon, 29 Oct 2018 06:50:56 -0700 (PDT)
MIME-Version: 1.0
References: <1539237571-28926-1-git-send-email-zhang.xianwei8@zte.com.cn> <201810181029439681669@zte.com.cn>
In-Reply-To: <201810181029439681669@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 29 Oct 2018 15:50:45 +0200
Message-ID: <CAHp75Vcug+8nW7h_35L9zOY7tj2g_42sLwfD65wAsoe_yr=84A@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Change the keymap for
 Favorites hotkey
To:     zhang.xianwei8@zte.com.cn
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        ibm-acpi-devel@lists.sourceforge.net,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        zhong.weidong@zte.com.cn, Yi Wang <wang.yi59@zte.com.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 5:30 AM <zhang.xianwei8@zte.com.cn> wrote:
>
> Could you take a little time to review the patch? Thanks
>

Pushed to my review and testing queue, thanks!


> ------------------Original Mail------------------
> Sender: zhang xianwei10129966
> To: ibm-acpi@hmh.eng.br <ibm-acpi@hmh.eng.br>dvhart@infradead.org <dvhart=
@infradead.org>andy@infradead.org <andy@infradead.org>
> CC: ibm-acpi-devel@lists.sourceforge.net <ibm-acpi-devel@lists.sourceforg=
e.net>platform-driver-x86@vger.kernel.org <platform-driver-x86@vger.kernel.=
org>linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>zhong weidon=
g10001088;zhang xianwei10129966;
> Date: 2018/10/11 13:52
> Subject: [PATCH] platform/x86: thinkpad_acpi: Change the keymap for Favor=
ites hotkey
> The keycode KEY_FAVORITES(0x16c) used in thinkpad_acpi driver is too
> big (out of range > 255) for xorg to handle.
> xkeyboard-config has already mapped KEY_BOOKMARKS(156) to
> XF86Favorites:
>
> keycodes/evdev:
> <I164> =3D 164;   // #define KEY_BOOKMARKS           156
>
> symbols/inet:
> key <I164>   {      [ XF86Favorites         ]       };
>
> So change the keymap to KEY_BOOKMARKS for Favorites hotkey.
>
> Signed-off-by: Zhang Xianwei <zhang.xianwei8@zte.com.cn>
> ---
> drivers/platform/x86/thinkpad_acpi.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/=
thinkpad_acpi.c
> index fde08a9..a86cf47 100644
> --- a/drivers/platform/x86/thinkpad_acpi.c
> +++ b/drivers/platform/x86/thinkpad_acpi.c
> @@ -3457,7 +3457,7 @@ static int __init hotkey_init(struct ibm_init_struc=
t *iibm)
> KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN, KEY_UNKNOWN,
> KEY_UNKNOWN,
> -        KEY_FAVORITES,       /* Favorite app, 0x311 */
> +        KEY_BOOKMARKS,       /* Favorite app, 0x311 */
> KEY_RESERVED,        /* Clipping tool */
> KEY_CALC,            /* Calculator (above numpad, P52) */
> KEY_BLUETOOTH,       /* Bluetooth */
> --
> 2.9.5



--=20
With Best Regards,
Andy Shevchenko
