Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD162C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB6C20827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 21:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZowDBYDr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EB6C20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbeJaGmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 02:42:43 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40003 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbeJaGmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 02:42:42 -0400
Received: by mail-qk1-f195.google.com with SMTP id f18-v6so8283362qkm.7;
        Tue, 30 Oct 2018 14:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt+zxYm1Hjtk8t5DvE019D4czZAbeBACkllR7mN1znU=;
        b=ZowDBYDrn56gIyHC1bmQ30BlxUInui9uyNDqBeXviCEJE648OmNQ224IXcOW0wcimx
         xp+Wup8xn8svDeJu3Cbe4Ao8gjooCnfnM6NN4hO6TXXfFaytUT/vGoeXaAK1pSRXCCCs
         34xc5XXjtYrir292o9liKHvKBkpSWI1eUW7B0SWOIwNQe+KgTipS86qotfTHetuxhi83
         Ou+z5cPH6JOhkgMnjKkSQYcFiO+PD0/TIKI4S7KVuzFtRdPcmRFj0k+SiD6hau6DE9kj
         ZA4t0EbmIwq5Er7NxwAnRaFmyqn2Gnxmj5I+iho/oYOJFQdDY5GCFmQSGadhHI6j3XDf
         KWag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt+zxYm1Hjtk8t5DvE019D4czZAbeBACkllR7mN1znU=;
        b=B/8CaxS7oTU7DWrY2g/g2VuGjSsfph1SXh97YlACIgfaROZ6R1jwX/iVBoz913XYIK
         1Jeeo30WdPeFR84zvpVL9u7RDDBKwS0eLwfVJSkdPn2jTvj3hiYB5rbyY2UI/iOIyfm5
         chxfE/7Zz2S8l5HgG6jd6qYG9+V1vzVwrdGiR8Ea/xd6Oa6FSORv/i449hXcU56aHO/D
         w8iY5MZycv56VUv9xaWoJb3F6l+sFn1YfPgb5UfLTyKLaeQMDXaiDw5IN9Z2JXZSZAcP
         VN5utjXSaG+Jz9qfUnz7TpBQqzs7DaZt5VuggYFoRYTkEKqenzdUKAIbfHBO5vRQzkLS
         8zJA==
X-Gm-Message-State: AGRZ1gJgunMjDoZl+qVJQFyFBuEOIDqUAByNKHGJjS51Xdu8MK4vXRCX
        d+bck8aggtfVeB+Cx9o+J1GiY5+s2qgoZ6zq2YQ=
X-Google-Smtp-Source: AJdET5fJJ1fUIgzjSt4MLfGpWn5k9GLXJX085ua7kR2vQnxFlnCFx0BUG8ykyU+nJReVDkH8OUkNdKDrJF8KJJk/Lnk=
X-Received: by 2002:a37:d91:: with SMTP id 139mr447609qkn.26.1540936051869;
 Tue, 30 Oct 2018 14:47:31 -0700 (PDT)
MIME-Version: 1.0
References: <20181027150910.GA2070@syn-yoga530> <20181030205624.GC13681@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20181030205624.GC13681@bhelgaas-glaptop.roam.corp.google.com>
From:   Tobias Thomer <thomer.tobias@gmail.com>
Date:   Tue, 30 Oct 2018 22:47:20 +0100
Message-ID: <CAHYSBa-QNtqZ9f__ysG9cz33LiCEpjVBHrPvHhgPn2gzVUhv8Q@mail.gmail.com>
Subject: Re: [PATCH v7] i2c: Add PCI and platform drivers for the AMD MP2 I2C controller
To:     helgaas@kernel.org
Cc:     syniurge@gmail.com, linux-i2c@vger.kernel.org, wsa@the-dreams.de,
        Nehal-bakulchandra.Shah@amd.com, Shyam-sundar.S-k@amd.com,
        sandeep.singh@amd.com, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've tested v7 on a Yoga 530 and it seems to work (sometimes for
hours) but it randomly dies with a i2c read timeout

[ 9562.237020] i2c_amd_plat_mp2 AMDI0011:00: i2c read timed out

and reloading/removing of the module results in this:

[ 9703.591021] pcie_mp2_amd 0000:03:00.7: length 0 in event doesn't
match buffer length 64!
[ 9703.591030] pcie_mp2_amd 0000:03:00.7: unexpected slave address 0
(expected: 2c)!
[ 9703.863740] i2c_amd_plat_mp2 AMDI0011:01: i2c connection timed out
[ 9707.596826] INFO: task irq/67-WCOM517E:340 blocked for more than 120 seconds.
[ 9707.596838]       Tainted: G           OE     4.19.0-v7 #1
[ 9707.596841] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
disables this message.
[ 9707.596845] irq/67-WCOM517E D    0   340      2 0x80000080
[ 9707.596851] Call Trace:
[ 9707.596868]  ? __schedule+0x29b/0x8b0
[ 9707.596873]  schedule+0x32/0x90
[ 9707.596875]  schedule_preempt_disabled+0x14/0x20
[ 9707.596879]  __mutex_lock.isra.0+0x217/0x520
[ 9707.596884]  ? __switch_to_asm+0x40/0x70
[ 9707.596887]  ? __switch_to_asm+0x34/0x70
[ 9707.596890]  ? __switch_to_asm+0x34/0x70
[ 9707.596898]  amd_mp2_read+0x4f/0x17b [i2c_amd_pci_mp2]
[ 9707.596912]  i2c_amd_xfer+0x61/0x150 [i2c_amd_plat_mp2]
[ 9707.596919]  __i2c_transfer+0x142/0x480
[ 9707.596922]  ? _raw_spin_unlock_irq+0x1d/0x30
[ 9707.596926]  ? irq_forced_thread_fn+0x70/0x70
[ 9707.596929]  i2c_transfer+0x51/0xc0
[ 9707.596932]  i2c_transfer_buffer_flags+0x4c/0x70
[ 9707.596937]  i2c_hid_irq+0x3c/0x130 [i2c_hid]
[ 9707.596941]  irq_thread_fn+0x1f/0x50
[ 9707.596944]  irq_thread+0xf7/0x1a0
[ 9707.596946]  ? irq_thread_check_affinity.part.3+0xa0/0xa0
[ 9707.596949]  ? irq_thread_dtor+0xb0/0xb0
[ 9707.596953]  kthread+0x112/0x130
[ 9707.596956]  ? kthread_park+0x80/0x80
[ 9707.596959]  ret_from_fork+0x22/0x40
