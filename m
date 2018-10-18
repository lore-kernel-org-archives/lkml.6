Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6280AECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 326EC20658
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326EC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730716AbeJSCJy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:09:54 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:35447 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728851AbeJSCJy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:09:54 -0400
Received: from null ([172.19.249.151]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M7sQ8-1gIAVq2Q30-0054XD; Thu, 18
 Oct 2018 20:07:24 +0200
Received: from null ([172.19.249.151]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1M7sQ8-1gIAVq2Q30-0054XD; Thu, 18
 Oct 2018 20:07:24 +0200
Date:   Thu, 18 Oct 2018 20:07:23 +0200 (CEST)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        gregkh@linuxfoundation.org
Cc:     eric@anholt.net, linux-rpi-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, tiwai@suse.de,
        devel@driverdev.osuosl.org
Message-ID: <221690011.132173.1539886043161@email.1und1.de>
In-Reply-To: <20181017190156.30010-1-nsaenzjulienne@suse.de>
References: <20181017190156.30010-1-nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 0/7] staging: bcm2835-audio: Cleanups and upgrades
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev39
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:/lB9xM2UaqJYIDiCZZGsZ5TlTRlU4A0oqqEf9e2134My0yeg62y
 1NTA4d2p2rX5Abe4q2vV1xtVaahIv8RzEtMUvR5ktfNhTbdesjnmIXS5+CEvPHkH7nKDmkd
 Wvo4bq984dHpNJGXb6N7ZLqW5b8+gmHS9KoOQbWDTID/opl3kWC1s3PgnJLs78A7WWOeWAj
 LIEnytUZM6i4QifeSjhOw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zv1p1IVGmGA=:aFGJgS1AqIrwkVi98R5NTK
 Xvmqva+O3hXSbXA6Lt5gNGFXJxZ/LnDPdLv8p1fNFmi+GYjxJzCWNEJnZ+43d2axgtF40U0P7
 1gg2RTP4kHSrf3c0awUXWcmBiw5wB5Eys6JY57VXFwcFYrDYh+tjBS7pJAI3U8XVUt3uNhMcA
 3g6yFQ5a3xymdNDTHNIrCo+IDj5T1bI8hOJG3PspCbbX5GVUB5/rA+ER1IXLTV2KWaoVdEIl8
 3fvP5jr29oaHIhhBmjIdBFvHxw6uPMQ4FjaC6P3r+hFkMAw1OpF231vgB0aKp92+fjNAMGswx
 BPMT9P5SvehyC/LiuDY3S8Ht1fc86IhQDAxb3SUIUgzk2czDm+UZVSLfNanxX5ZrquOEnLyax
 3PD/LkijPq1pKxGVglXU/7f2RTQT8y7Ohl4wUhZFW5f6QrCjnGVJF5aC+bXWVemYONz4Q+T8q
 wpKncum804lAqhh/vefqmhuKg9w4+naixOyXpVnaaO/lbR4PHL/GQs9buVb8ik06uOVrFTDFs
 7rISAs5Gin1vHorvxeD/V+EL7qlCO0cxwGJnHDw2PY1UMsfx1o+IXn1xCxgaA9F/HZWM0OxEF
 aFd7Se/uvLaV4NveTiQOvsmayi5P3T5DjC+73h7YcOPRM++98bepc3qOoKQZEbV4KuPhP3xDH
 j74Msgca51eXOLB3V/CrWnikO1Su5xlRof7giR2XHIagF1IjkPk/P0/45php+hsufwCcajtur
 mghs7Scfrm9LDCly
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 17. Oktober 2018 um 21:01 geschrieben:
> 
> 
> Hi,
> 
> I just received a RPi3B+ and decided to have a go at fixing stuff in the
> audio driver. The changes are mostly cosmetic. I also took the liberty
> to update the TODO file.
> 
> The series was developed on top of linux-next and tested on a RPi2B and
> RPi3B+. Sadly I don't have an HDMI monitor with sound so I only tested
> the mini jack output.
> 
> Thanks,
> Nicolas
> 
> v2: Removes the device tree related patches, updates TODO accordingly
>     and adds suggestions from Takashi.
> 

Acked-by: Stefan Wahren <stefan.wahren@i2se.com>

for the rest of the series
