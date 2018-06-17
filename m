Return-Path: <SRS0=XTOn=JD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C10DC5CFC1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:36:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD9AD2086A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Jun 2018 17:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="s3VNVuAc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q5TyX9LF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9AD2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933815AbeFQRgl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Jun 2018 13:36:41 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:38988 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751462AbeFQRgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jun 2018 13:36:39 -0400
Received: by mail-yb0-f194.google.com with SMTP id m137-v6so5194559ybm.6
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jun 2018 10:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=e8fzZIfvrWMu9g/aqE5RH4pFlwjRGIalLIvgzoa3+SA=;
        b=s3VNVuAc0Pfp4qTCExwSURok8Tgw6wX/W/qLsf2svRWZKpEUrc1cVOCadN/T21CcgW
         vkmtGlMM/+D7bBdUVHE3JC7HCoVa4NzS18HONw7Lxm2Q/oytTJTZ5qrbid2A9M1DsZX8
         5jP/sy9K6ekjL73iTFsf/qECQvdtM1qIMa/xx/UechqJU4twfabxzBMPUglIIueKJt6Z
         sNwEUuCjxy2ioywZ4bnsp6413zfz685xnyp3C/7efa6DMDI6CIX2XUsYhGBLYo8cjdcT
         LrP4zK6TO+3tfK1cUO6pyrIpC3TaYfff2lcyES2+oKFB2arh7jT0yip+nwD3E+e/g3he
         b5zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=e8fzZIfvrWMu9g/aqE5RH4pFlwjRGIalLIvgzoa3+SA=;
        b=Q5TyX9LFB4nrrd2AnR6Ea4CwG15LsREP6QcVUTCTw4wSCOsJtXTA3rwxPCIYmoPgVO
         CmmPQdlJuMPf0rZ7sF7ITYbv4V6xQVJVLbw76p9jqMtMuZncyiDo5gW/y9czIgi4fgNn
         Cr/SXeF/QB/zDmW+qsh3k/ONM24vZwuVibmpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=e8fzZIfvrWMu9g/aqE5RH4pFlwjRGIalLIvgzoa3+SA=;
        b=NeOPi9GJUkFL5nc+6CrF9vlwNfRzN2MAZPylDfEItFKx7XBr4UWHED7PDyvkqv4kd9
         CM1rncXRP4/SdEnFC7aVjG8gFUYiXlGje+68nZHlIzgSZ/6pWZ0QZsasNIg0+625ot8o
         qXWYGAcSNxeZrnQD6vFz5ImEbXIfJoK/N/ahOdQ3yNfbPOUHYCS5pT8buQ8XVm1DMLe+
         3UK8JRSe2FkfB9KZ0YJ70s5WQg+4qPveXwNh7WB7D/8lS9NfPcNX/O9va68LwpVgPZnc
         8aiX+9xJjbWAPUIckRpNnLHIqtp33bE8Ge9tRJmRInhXPTSDp6FsmfUeK4qaIjzs0mlM
         S8Kw==
X-Gm-Message-State: APt69E3bCWidhaVmJgJi3ATDWHOZ6ZrnlH3LPeWMQcq4Rs5qaCQYRsp4
        PypCf4WiAiLOxgZjzotZi7V/WWB/yGiEsk2ufYSGYQ==
X-Google-Smtp-Source: ADUXVKJbH5dD8gDPgI55+yJWOEqep+/5LU7FE4K3olLcgmp3JAaiqj2JgJcp8EgGDKEuNVC0+ahiIIIc9vKvlOZ0xfk=
X-Received: by 2002:a25:a301:: with SMTP id d1-v6mr5113446ybi.193.1529256998513;
 Sun, 17 Jun 2018 10:36:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:d6c5:0:0:0:0:0 with HTTP; Sun, 17 Jun 2018 10:36:37
 -0700 (PDT)
In-Reply-To: <1529186697.2784.2.camel@gmail.com>
References: <1529182886.3450.3.camel@gmail.com> <1529186697.2784.2.camel@gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sun, 17 Jun 2018 10:36:37 -0700
X-Google-Sender-Auth: L9KOPrkCPL91MLX7ogNRH59a_g4
Message-ID: <CAGXu5jLwA37YJWi50i7bQZ6N7MtctvbXjsVg337zgD11AQ=9SA@mail.gmail.com>
Subject: Re: wmi: usercopy: Kernel memory overwrite attempt detected to spans
 multiple pages (offset 0, size 4104)
To:     =?UTF-8?B?TWloYWkgRG9uyJt1?= <mihai.dontu@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 3:04 PM, Mihai Don=C8=9Bu <mihai.dontu@gmail.com> w=
rote:
> On Sun, 2018-06-17 at 00:01 +0300, Mihai Don=C8=9Bu wrote:
>> While trying to adjust the keyboard backlight mode, I hit this BUG:
>>
>> Jun 16 22:16:07 mdontu-l kernel: usercopy: Kernel memory overwrite attem=
pt detected to spans multiple pages (offset 0, size 4104)!

CONFIG_HARDENED_USERCOPY_PAGESPAN=3Dy is really only useful for
debugging special cases. For now, I recommend leaving it disabled,
since there are a lot of cases it still trips over.

> I eventually sprinkled some printk-s and got this:
>
>  855         if (copy_from_user(buf, input, wblock->req_buf_size)) {
>  856                 dev_dbg(&wblock->dev.dev, "Copy %llu from user faile=
d\n",
>  857                         wblock->req_buf_size);
>  858                 ret =3D -EFAULT;
>  859                 goto out_ioctl;
>  860         }

However, since you tracked this one down, I think this would be fixed
by adjusting the handler_data allocation:


diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 8e3d0146ff8c..ea6bf98f197a 100644
--- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -918,8 +918,8 @@ static int wmi_dev_probe(struct device *dev)
                }

                count =3D get_order(wblock->req_buf_size);
-               wblock->handler_data =3D (void *)__get_free_pages(GFP_KERNE=
L,
-                                                               count);
+               wblock->handler_data =3D (void *)
+                       __get_free_pages(GFP_KERNEL | __GFP_COMP, count);
                if (!wblock->handler_data) {
                        ret =3D -ENOMEM;
                        goto probe_failure;


But in looking further, I don't know why this is using
__get_free_pages() instead of kmalloc? In fact, there is a kfree() in
the error path, which looks wrong:

        kfree(wblock->handler_data);

I think this should just be converted to using kmalloc/kfree everywhere.

-Kees

--=20
Kees Cook
Pixel Security
