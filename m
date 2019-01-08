Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4D5C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D712087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 16:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728873AbfAHQER convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:04:17 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44483 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728483AbfAHQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 11:04:16 -0500
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ggtrS-0005YM-MA
        for linux-kernel@vger.kernel.org; Tue, 08 Jan 2019 16:04:14 +0000
Received: by mail-pg1-f200.google.com with SMTP id o17so2270073pgi.14
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 08:04:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=rIM7bb97GwACYHLECJ4EObB0Md2UkL3PJGaw6qeRryQ=;
        b=IZxcI/JfoZfwawqSRgIh4RcgV1i8UyobN6qZbjeKAYT60QXtkhIxQO5f0r5buEAmjk
         yJ2ak8hnkF0p5EgsorVgMQibCZOIdBvpCvCIuacZy0RBKVf5f707FsSXjYSmhAUTBN9t
         cwG0XCcZEZeTmFpBGLWOE5s7rg4/DEtHSuF+wxUcykqJcuFaNy4W+bzFJv54lzThwyOv
         XcnWbykyUXnK3DYHpMslgsr4BTsnas5ahWuH0GLWzPdhFneKRYw4z2sC/B6C9AjX8ptM
         tqdWrcJGDSparoBnbWNgIJbRzwqYDYh6hKRliuI7iVSLKJ59qqwfmQF50FaVgVvNE8rk
         989Q==
X-Gm-Message-State: AJcUukczfLJKVKPpVtGv21sIyHorMCXVcfZCN2kO6JRY/52QuCrrWz+w
        OQJ+nJG1a58cOIAUVf9JXu0xkCjvzN+sd7BTVPrBC/HjcU0MbmGkDv673Ez/Un0xCq2/ASbaA3X
        t2Tz5xwXQuTQCHUSmCE8ICelEtndfTk1RSGKqKiCsYg==
X-Received: by 2002:a63:9041:: with SMTP id a62mr1951564pge.163.1546963452414;
        Tue, 08 Jan 2019 08:04:12 -0800 (PST)
X-Google-Smtp-Source: ALg8bN6yWM8naAAxEKTLQnAkBu5G3lzGpSOk/Cx3ulVHaNGQjHxTMbTwIMHcJQoVZvlKS6aQSExnwA==
X-Received: by 2002:a63:9041:: with SMTP id a62mr1951549pge.163.1546963452136;
        Tue, 08 Jan 2019 08:04:12 -0800 (PST)
Received: from [192.168.1.215] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id b68sm106793098pfg.160.2019.01.08.08.04.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:04:11 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH v4] USB: Don't enable LPM if it's already enabled
From:   Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20190108154157.GA20561@kroah.com>
Date:   Wed, 9 Jan 2019 00:04:08 +0800
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <98BF2E31-2F7F-47FA-B591-40B2FFBC65F1@canonical.com>
References: <20181203102643.22690-1-kai.heng.feng@canonical.com>
 <20190108154157.GA20561@kroah.com>
To:     Greg KH <gregkh@linuxfoundation.org>
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 8, 2019, at 11:41 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> On Mon, Dec 03, 2018 at 06:26:43PM +0800, Kai-Heng Feng wrote:
>> USB Bluetooth controller QCA ROME (0cf3:e007) sometimes stops working
>> after S3:
>> [ 165.110742] Bluetooth: hci0: using NVM file: qca/nvm_usb_00000302.bin
>> [ 168.432065] Bluetooth: hci0: Failed to send body at 4 of 1953 (-110)
>> 
>> After some experiments, I found that disabling LPM can workaround the
>> issue.
>> 
>> On some platforms, the USB power is cut during S3, so the driver uses
>> reset-resume to resume the device. During port resume, LPM gets enabled
>> twice, by usb_reset_and_verify_device() and usb_port_resume().
>> 
>> So let's enable LPM for just once, as this solves the issue for the
>> device in question.
>> 
>> Also consolidate USB2 LPM functions to usb_enable_usb2_hardware_lpm()
>> and usb_disable_usb2_hardware_lpm().
> 
> I thought I asked for this to be two different patches.  One that does
> the "consolidation", and then one that fixes the bug.  You are mixing
> two different things here together, making it harder to review.
> 
> Can you please break this up and send a patch series, with the correct
> "Fixes:" tag added to the second patch that actually fixes the issue?

The consolidation itself is the fix, so I am not sure how to break this up.

In reset-resume case, LPM gets enabled twice, by
usb_reset_and_verify_device() and usb_port_resume().

If it’s a normal resume, LPM only gets enabled once, by
usb_port_resume().

Since all three checks (capable, allowed and enabled) are merged to
a single place, enabling LPM twice can be avoided, hence fixing the
issue.

Kai-Heng

> 
> thanks,
> 
> greg k-h

