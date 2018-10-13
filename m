Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10763C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF3920895
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 09:11:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rc2QHsnu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF3920895
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbeJMQr0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 12:47:26 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:41542 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726123AbeJMQrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 12:47:25 -0400
Received: by mail-ua1-f68.google.com with SMTP id m7so408579uao.8;
        Sat, 13 Oct 2018 02:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=0gDOkoiJUjld+PXiiXevRwIaKP7GgxhN0O0sa1VhFe4=;
        b=Rc2QHsnudOydd71JCECcq45RItJ6HHj4VktSKpEL5tbSD/7h+hNZV9rTT+9G7CGk8S
         0QW9s1INC9z4mzgXJujzu49TpiukElRqnMpicxdlvpJraPbDuoAiunZHVRyj1ZqEaMQl
         HviPmFLvlInK+ZeaIpG/v+mGlcg11gULaEYcOcqPfv1pyKWam80K6WkneFKkx5vl3Tgk
         k/rwO2KDGVNewjfVHdw6rP3qCGPadQ0Lnqy1Kcaxm+WYjZVwjCOy1jM+xrk7Ah457H+k
         /NP2gfMoJHZaTZKptmrVimdje1DkbHUqw/bt99dSydiOnoeRMXrbaGRSCgsxJ5m+dqyt
         jMvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=0gDOkoiJUjld+PXiiXevRwIaKP7GgxhN0O0sa1VhFe4=;
        b=p4reLSBYy1lLDnhVIf7F5MjsjQPTuokBcsY9KLlgCqBeg9snYZcEmtuM+FF0JvXJyT
         KbVq+hg0B+PzXdcEJYWB8XU07Y8KCNaOUDvfVoYytfNtXkIWLC0GkLvh8ENOwAgSfciz
         KJvxhxKSk9MXc+dFHZdKecLIjbsTX18rJ8ZvRAlhN5wJCqrMmsAjpnqCKzd7n350a0t5
         eqDgUT+yewbXENjyCeYtZPPd96mv+8EdniCDVguCBwveFUY/aLzL9DNnL7sNCphgWuMN
         j/Pv4urm+X9/aqp8wLHFUIu26JP0O02jCwmETfQQCxqgUoWNYWBfZgzpflfZxyeSDk6a
         qQHQ==
X-Gm-Message-State: ABuFfojRbcFkAUxWcV71mv8Bw8rkOmhX09Dgw0PP4Yfh0gEGPvHQ09rL
        aEvRdItpNPKyRGOpLv3A4SHNMNPYiK7hYcSu4MEpuXHb
X-Google-Smtp-Source: ACcGV63KDU3foqEZX/lCkwrzWWrrU5GdWbXmO8MciQtxRY8EF4vaa1C09ZuaUemptPOBLPHmb1WtgDuPjW1u9/DDXXU=
X-Received: by 2002:ab0:30d3:: with SMTP id c19mr3957815uam.58.1539421861419;
 Sat, 13 Oct 2018 02:11:01 -0700 (PDT)
MIME-Version: 1.0
From:   Da Shi Cao <dscao999@gmail.com>
Date:   Sat, 13 Oct 2018 17:10:50 +0800
Message-ID: <CAG3POB=BYJ_+iYy-xNygzp2RVOaUY2qEhRn9kTSNXYUo=9a5Og@mail.gmail.com>
Subject: [PATCH] Add support of TI ICDI to USB simple serial device
To:     linux-usb@vger.kernel.org, linux-terminal@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In-Circuit Debug Interface is a debugging interface for TI ARM
microcontrollers. It has three USB interfaces and two of them are
presented as standard ACM serial device. The 3rd interface is the
debugging interface and it can be driven as a Linux USB simple
terminal. With it, debugging session and firmware up/down loading are
supported on Linux.

Signed-off-by: Dashi Cao <dscao999@hotmail.com, dscao999@gmail.com>
---
 drivers/usb/serial/usb-serial-simple.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/serial/usb-serial-simple.c
b/drivers/usb/serial/usb-serial-simple.c
index 4d0273508043..ae43088b659e 100644
--- a/drivers/usb/serial/usb-serial-simple.c
+++ b/drivers/usb/serial/usb-serial-simple.c
@@ -109,6 +109,11 @@ DEVICE(suunto, SUUNTO_IDS);
        { USB_DEVICE(0x908, 0x0004) }
 DEVICE(siemens_mpi, SIEMENS_IDS);

+/* TI In-Circuit Debug Interface */
+#define ICDI_IDS()              \
+       { USB_DEVICE_INTERFACE_CLASS(0x1cbe, 0x00fd, USB_CLASS_VENDOR_SPEC) }
+DEVICE(ti_icdi, ICDI_IDS);
+
 /* All of the above structures mushed into two lists */
 static struct usb_serial_driver * const serial_drivers[] = {
        &carelink_device,
@@ -124,6 +129,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
        &hp4x_device,
        &suunto_device,
        &siemens_mpi_device,
+       &ti_icdi_device,
        NULL
 };

@@ -141,6 +147,7 @@ static const struct usb_device_id id_table[] = {
        HP4X_IDS(),
        SUUNTO_IDS(),
        SIEMENS_IDS(),
+       ICDI_IDS(),
        { },
 };
 MODULE_DEVICE_TABLE(usb, id_table);
--
2.11.0
