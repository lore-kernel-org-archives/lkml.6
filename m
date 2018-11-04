Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 512CBECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1968020854
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 16:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p6o9/8YV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1968020854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732027AbeKEB51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 20:57:27 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37789 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732013AbeKEB51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 20:57:27 -0500
Received: by mail-io1-f65.google.com with SMTP id k17-v6so4790874ioc.4;
        Sun, 04 Nov 2018 08:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=l8UcfMMPC1etJE5E51oUIa2EP+LkM+VqvFO09cszmtc=;
        b=p6o9/8YV4XfULgwfTehbitEtirSYkgRwzbRcGj20ewwqoKIhHFniZF1HXgzlNdlPTX
         bwdbO+RmQhl1l126yrMmCCbo9p/vErzUCsiMb+zxAOHUj6sDrqjfBXuQsQZbHFVEprGc
         A4NaLm4nFWlXbPzlcNZ8Ov/skKdhSPFVKKhT22Q/Dy8fPkGZ4/YHx+S2GLiNRDGkfFBV
         945TEKW0F4vEproGEiwSWS0n3EvV/Cfvk9gaaLVp5Mu2O86SMOdowAR8g0cfM2Nhiq+M
         /EIR8WNaLDe6xtAYSS9o4YmxYpp4OYyeh+5cx30itIbSq0u4+STgdGKUCnDi9ch1cVBw
         hZfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=l8UcfMMPC1etJE5E51oUIa2EP+LkM+VqvFO09cszmtc=;
        b=Wq0uHA5ZdGIxpAdSqaYKs1j6MKBU3KN+kY9LUvZYmtvzpB5Fcq+YjvYwAqlskgJcgq
         h9auUl57zZGua7c2Fj7wKc1vbrUJANHahGdr9Be/mmeh4CPCWaOjcp/F8eIYQkdfAMWL
         JxAFvp4PntMkAS4rL5lcqWYnOaIVu77d+NLpaitAK9bFDY9B1yeBzVg9S/YVN6HPLyg8
         ZIRzg+DqpJEcwf4ocDAQ8INDu0MqsPBlVXN9SqWJy2pXfAbpNcpkFHzJqcSYpX9vcHt8
         TEPrD3m0BjUIZvOBXo7XzJwRQI0vXKSP4NG+SSYHDJo7Kjqx/82KTFBfVAwewNImPuQg
         R21w==
X-Gm-Message-State: AGRZ1gI43YECcUPY6YJsuc/KypdJ98cQacfxZ3AEVqeC+R6tDRAsO7cm
        XJfWQyMXyyoXS937Ep2g+PxaTx7Tijyg8IFt2Zo=
X-Google-Smtp-Source: AJdET5fBHaqP19eHf2/0cKIEMCyJE8RYKq5b4mZ9n9UnB0xutnpxVSB4qLsLBwQKjXHtLGxiU/Q3yg9sEl3GZADlop0=
X-Received: by 2002:a5e:8217:: with SMTP id l23-v6mr11552995iom.232.1541349713268;
 Sun, 04 Nov 2018 08:41:53 -0800 (PST)
MIME-Version: 1.0
References: <20181027150910.GA2070@syn-yoga530> <20181030205624.GC13681@bhelgaas-glaptop.roam.corp.google.com>
 <CAHYSBa8rpRS8suDdE-mfem_Gi3HYVXRydTm3PESnkzFVq2LXrA@mail.gmail.com>
In-Reply-To: <CAHYSBa8rpRS8suDdE-mfem_Gi3HYVXRydTm3PESnkzFVq2LXrA@mail.gmail.com>
From:   Elie Morisse <syniurge@gmail.com>
Date:   Sun, 4 Nov 2018 13:41:41 -0300
Message-ID: <CAC_JBqqG0Jq5sB93AZ+2pi3_cac4W+Ed0chU3cmUb17HMeFFbQ@mail.gmail.com>
Subject: Re: [PATCH v7] i2c: Add PCI and platform drivers for the AMD MP2 I2C controller
To:     Tobias Thomer <thomer.tobias@gmail.com>
Cc:     helgaas@kernel.org, linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        sandeep.singh@amd.com, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The errors on module exit and the hang after a read/write timeout should be
fixed in v8, someone else reported the same issue here:
https://github.com/Syniurge/i2c-amd-mp2/issues/1

Weird that despite a lot of trying by doing random stuff with my touchpad a=
nd
touchscreen neither never ever timed out on my Yoga 530.

Le mar. 30 oct. 2018 =C3=A0 18:41, Tobias Thomer <thomer.tobias@gmail.com> =
a =C3=A9crit :
>
> I've tested this patch on a Yoga 530 and it seems to work (sometimes for =
hours) but it randomly dies with a i2c read timeout
>
> [ 9562.237020] i2c_amd_plat_mp2 AMDI0011:00: i2c read timed out
>
> and reloading/removing of the module results in this:
>
> [ 9703.591021] pcie_mp2_amd 0000:03:00.7: length 0 in event doesn't match=
 buffer length 64!
> [ 9703.591030] pcie_mp2_amd 0000:03:00.7: unexpected slave address 0 (exp=
ected: 2c)!
> [ 9703.863740] i2c_amd_plat_mp2 AMDI0011:01: i2c connection timed out
> [ 9707.596826] INFO: task irq/67-WCOM517E:340 blocked for more than 120 s=
econds.
> [ 9707.596838]       Tainted: G           OE     4.19.0-v7 #1
> [ 9707.596841] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disable=
s this message.
> [ 9707.596845] irq/67-WCOM517E D    0   340      2 0x80000080
> [ 9707.596851] Call Trace:
> [ 9707.596868]  ? __schedule+0x29b/0x8b0
> [ 9707.596873]  schedule+0x32/0x90
> [ 9707.596875]  schedule_preempt_disabled+0x14/0x20
> [ 9707.596879]  __mutex_lock.isra.0+0x217/0x520
> [ 9707.596884]  ? __switch_to_asm+0x40/0x70
> [ 9707.596887]  ? __switch_to_asm+0x34/0x70
> [ 9707.596890]  ? __switch_to_asm+0x34/0x70
> [ 9707.596898]  amd_mp2_read+0x4f/0x17b [i2c_amd_pci_mp2]
> [ 9707.596912]  i2c_amd_xfer+0x61/0x150 [i2c_amd_plat_mp2]
> [ 9707.596919]  __i2c_transfer+0x142/0x480
> [ 9707.596922]  ? _raw_spin_unlock_irq+0x1d/0x30
> [ 9707.596926]  ? irq_forced_thread_fn+0x70/0x70
> [ 9707.596929]  i2c_transfer+0x51/0xc0
> [ 9707.596932]  i2c_transfer_buffer_flags+0x4c/0x70
> [ 9707.596937]  i2c_hid_irq+0x3c/0x130 [i2c_hid]
> [ 9707.596941]  irq_thread_fn+0x1f/0x50
> [ 9707.596944]  irq_thread+0xf7/0x1a0
> [ 9707.596946]  ? irq_thread_check_affinity.part.3+0xa0/0xa0
> [ 9707.596949]  ? irq_thread_dtor+0xb0/0xb0
> [ 9707.596953]  kthread+0x112/0x130
> [ 9707.596956]  ? kthread_park+0x80/0x80
> [ 9707.596959]  ret_from_fork+0x22/0x40
