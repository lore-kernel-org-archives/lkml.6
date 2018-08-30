Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AEFC433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31EC320834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 17:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="paKy4Cgu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EC320834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeH3Vfh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 17:35:37 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34285 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbeH3Vfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 17:35:36 -0400
Received: by mail-oi0-f67.google.com with SMTP id 13-v6so16913734ois.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QOJVtfipmbwMYZzchxc1hpcdX6TtRx5mAqETOOVnPWE=;
        b=paKy4CgurCN6s/btqs5/nPuD/e9r214OUNSD2m1AbnzYZUTOG9RxsVdm90OEc2D0ms
         NXTKRZ3r0EMtaU9+IQ1mLbz+NuCSNgIfxYH1Uua0Y4uwrZhuEywHaOt8er74S83Dn4Y8
         L8KH2TLOcKSVZ3NX22OiHraialu1ZrXchbkOb/SaNJQ5F4LT4TvMHUUUw5Hh6JFnomWh
         c88ufVj0tmOUKd+KhBGN7MONz+rtlVZ+4G1Al6FmSDOvxHagd7cbNBxFMXKRby8qcTjw
         xlBTMlptzNtIaArH9KvoW8/5gawWEOoGyAKd67WxVU+MCKi5OrIdcOy6bKdaVhc5iWid
         sA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QOJVtfipmbwMYZzchxc1hpcdX6TtRx5mAqETOOVnPWE=;
        b=UjIPboHHLd55bfX9anBEMk/CoUK9Q0T9BL9XAAj1kXUqvmi+myOGjT+GSsgKhPT/Tv
         AdUQmw4MEgRKRBT8dvLwK1Yy+D8S6cRtCmP6EnbhZLvYgb6I/Q4lJ0y4hxUJ04I9+8Gx
         zZb3sbKFr/7mIVNYA8z3uo4l/eDX0CDmZwDFP+KPgtUWUitP/prRx2puzRAL3qhpngV/
         Kx9+dvYYcfIahJPQz8h8HEKumifIOZSA0CYHDDtm+X/OkFQWtY9seE+ANn4NG079atDI
         a3sHVR6KxPvZvRfF6lBZE3Aek/FllONm37itfXr5hItp1yzbzckm6LGyKWzLdf3sKlal
         z0Tg==
X-Gm-Message-State: APzg51CTEO1/cbrS8l64++qNFul7I8rwycgtIZt6nViINiuUYme4ufQq
        2Uy4ZP7oU/qVduLUAAprFCtiTSwpwOixCV0WceVPVQ==
X-Google-Smtp-Source: ANB0VdYUXAZoVMMaoTr3ksK3UCbKVghF6htlJp6WY3T9MQ6wGd4EZF9MiOnH8sZKhSvY1Wpyr3d0rFGbvbja8ImcXOs=
X-Received: by 2002:aca:e80c:: with SMTP id f12-v6mr3209449oih.38.1535650344145;
 Thu, 30 Aug 2018 10:32:24 -0700 (PDT)
MIME-Version: 1.0
From:   Ray Clinton <mr.ray.clinton@gmail.com>
Date:   Thu, 30 Aug 2018 13:32:20 -0400
Message-ID: <CAPMnawv9f0EAWcoZ9oP3DkyR0X0QaJxkuVXxrPNjASzMXKuA5g@mail.gmail.com>
Subject: [PATCH 3/4] staging: comedi: Correct multiline dereference as per TODO
To:     greg@kroah.com
Cc:     abbotti@mev.co.uk, hsweeten@visionengravers.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using checkpatch.pl I was able to find a multiline dereference which goes
again the coding style for the kernel. I'm still working on my email client so
the indentation looks bad here (in gmail) but the arguments for
ni_tio_set_mite_channel should go just under the opening (


Signed-off-by: Ray Clinton <mr.ray.clinton@gmail.com>
---
 drivers/staging/comedi/drivers/ni_mio_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/comedi/drivers/ni_mio_common.c
b/drivers/staging/comedi/drivers/ni_mio_common.c
index 4dee2fc..5de3a20 100644
--- a/drivers/staging/comedi/drivers/ni_mio_common.c
+++ b/drivers/staging/comedi/drivers/ni_mio_common.c
@@ -723,9 +723,9 @@ static void ni_release_gpct_mite_channel(struct
comedi_device *dev,

                ni_set_bitfield(dev, NI_E_DMA_G0_G1_SEL_REG,
                                NI_E_DMA_G0_G1_SEL_MASK(gpct_index), 0);
-               ni_tio_set_mite_channel(&devpriv->
-                                       counter_dev->counters[gpct_index],
-                                       NULL);
+               ni_tio_set_mite_channel(
+                                  &devpriv->counter_dev->counters[gpct_index],
+                                  NULL);
                mite_release_channel(mite_chan);
        }
        spin_unlock_irqrestore(&devpriv->mite_channel_lock, flags);
--
2.7.4
