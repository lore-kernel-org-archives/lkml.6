Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1537FECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:18:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D114321473
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 13:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pjTst/hd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D114321473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728200AbeJRVTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 17:19:34 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:35787 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727615AbeJRVTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 17:19:34 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14-v6so27700532ljj.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 06:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=Y0QRf+P/QkZfVap8Av3i3+THUaj4Oa/fNo8fLfC1vZw=;
        b=pjTst/hdDBH8e50nwJgGU+tYmjiGpEO2xLRjHd+6rZcICXjRYLIkcHrwqCl0QwvsSr
         DQfulhDwjFBY9RQ7hr4WuZpzImRrGMCa1kcrlRGabVHqsy/yVGOfTB4zUIy1Q+N356rH
         lIGkbbhV6+SaJlmhBuozO0KLx/h0Jfryxo98evrEu1XAr/HmxFU3CyA/lw+n3l7qjGKI
         uZpLkMzGI+0MuxFhjdmgnvbL+W7IpaNdArNeBbKj0zzYxCKfCLmE+t2aeeuTyR2mLg38
         tmlhj2vvWRPp1FslCuNABpSuZTI9wzB8A4Pf+S/yCxmIopAmUB7JvmWAa9rp6/Kqn8jN
         L2+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=Y0QRf+P/QkZfVap8Av3i3+THUaj4Oa/fNo8fLfC1vZw=;
        b=BFefyRTQ8kOf7ZJmYgRB1iYchQMVTpOC5X3AGdUnasXI0yeemkD8DbWgbYkXVxLpZH
         3NJ/smBfbAXyuojMvJAaFEqijG/g7v3W5udytmWXMKqqPZSvhfHqecZdRkuflEJN/Ngk
         +WiF6o+gK7Un/naVRDBfvgo//detKhlt441uZvapCQ8foaSSlTiWjlHQ6cx3mkjLGRIy
         2JMc9bCTXVXQ5WxhMZ/LQuxLWdURxiUExbKnTZ0+h9B9+0GnEAvo9m1Cu0EOe4hx/dra
         WvdeglzZXbADiw72nR7UioS5Xt6yWsTKb2hfZyF2zXi/ziHxgloTgjjheb/0AM8LvnlP
         G6JA==
X-Gm-Message-State: AGRZ1gJzSNjgX6Tpi38/IwC+g9SDKyI4aJEYbEDgAkg4Mzz9RzWRAMj8
        dwsTfZA3XrzqhduqDBz5K18bwni/0T68mHm4Rq4=
X-Google-Smtp-Source: AJdET5fhRB6ChUe8DnWGcmQwSiFdk0zcVAR+Sky7ycyuXEyThOaGJ6k/RgL3YUXmWMLuAsca8GjfhNw6ipI2iUaf8Ss=
X-Received: by 2002:a2e:5109:: with SMTP id f9-v6mr1579092ljb.155.1539868712474;
 Thu, 18 Oct 2018 06:18:32 -0700 (PDT)
MIME-Version: 1.0
From:   Jaejoong Kim <climbbb.kim@gmail.com>
Date:   Thu, 18 Oct 2018 22:18:20 +0900
Message-ID: <CAL6iAa+5a1UW31+egVXnDw=O4RePmFpvV_1qHXyjPFBnhkOWWg@mail.gmail.com>
Subject: kmemleak in nvkm_iccsense_oneinit
To:     bskeggs@redhat.com, airlied@linux.ie
Cc:     dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

## I forgot the write email without checking the enable text mode. So,
send email again. Sorry for send E-mail twice.

Hi

I got a kmemleak and it is pointing to nvkm_iccsense_oneinit().
Please refer to the below kmemleak message.

# uname -a
Linux climb 4.19.0-rc1+ #4 SMP Thu Sep 20 11:48:55 KST 2018 x86_64
x86_64 x86_64 GNU/Linux

# HW
LG Notebook. (Model Name:lg15n54)

# kmemleak mesage
unreferenced object 0xffff8801e9c58388 (size 96):
  comm "systemd-udevd", pid 130, jiffies 4294895052 (age 295965.560s)
  hex dump (first 32 bytes):
    02 05 00 6b 6b 6b 6b 6b 6b 6b 10 00 02 15 6b 6b  ...kkkkkkk....kk
    6b 6b 6b 6b 6b 6b 6b 6b 00 00 00 6b 6b 6b 6b 6b  kkkkkkkk...kkkkk
  backtrace:
    [<000000000f9caea9>] nvkm_iccsense_oneinit+0x231/0x1cf0 [nouveau]
    [<00000000d7f5cb68>] nvkm_subdev_init+0x155/0x9a0 [nouveau]
    [<00000000b2b0e9d8>] nvkm_device_init+0x332/0x5a0 [nouveau]
    [<000000003b736a7c>] nvkm_udevice_init+0x93/0xe0 [nouveau]
    [<00000000cc1011dc>] nvkm_object_init+0xcb/0x610 [nouveau]
    [<0000000006253ff8>] nvkm_ioctl_new+0x412/0x9a0 [nouveau]
    [<00000000db03ae9a>] nvkm_ioctl+0x3b4/0xbe0 [nouveau]
    [<00000000ac40bf7e>] nvif_object_init+0x2df/0x530 [nouveau]
    [<00000000e98baaae>] nvif_device_init+0x12/0xe0 [nouveau]
    [<000000006d050b26>] nouveau_cli_init+0x4e7/0x15b0 [nouveau]
    [<00000000d3f314bc>] nouveau_drm_load+0x118/0x1380 [nouveau]
    [<000000009823b666>] drm_dev_register+0x2c5/0x5a0 [drm]
    [<000000001a870888>] drm_get_pci_dev+0x16d/0x4b0 [drm]
    [<000000004d6e667f>] nouveau_drm_probe+0x459/0x620 [nouveau]
    [<00000000ad85fd78>] local_pci_probe+0xde/0x1a0
    [<00000000c07cf5fe>] pci_device_probe+0x419/0x590

Jaejoong
