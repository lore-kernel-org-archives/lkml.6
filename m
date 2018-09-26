Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17325C004D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8CF21533
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 22:50:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8CF21533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbeI0FFT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 01:05:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:42911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeI0FFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 01:05:19 -0400
Received: from [192.168.178.36] ([95.91.253.176]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjJCt-1fTkkl3dXD-00dSZg; Thu, 27
 Sep 2018 00:50:04 +0200
Subject: Re: hid: microsoft: Add rumble support for Xbox One S controller
To:     Bastien Nocera <hadess@hadess.net>, andrew.smirnov@gmail.com
Cc:     linux-kernel@vger.kernel.org,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        linux-input@vger.kernel.org
References: <20180810001714.14659-1-andrew.smirnov@gmail.com>
 <20180926125130.974-1-dollinger.florian@gmx.de>
 <701e5f0fc3b24adf4b1ca4d817b3091fe73102ba.camel@hadess.net>
 <003401d455ab$c6df5280$549df780$@gmx.de>
 <75590dbdffee5870537a344209af185cdda5de30.camel@hadess.net>
From:   Florian Dollinger <dollinger.florian@gmx.de>
Message-ID: <895230e5-05a8-68f4-5794-28e3d3068e81@gmx.de>
Date:   Thu, 27 Sep 2018 00:50:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <75590dbdffee5870537a344209af185cdda5de30.camel@hadess.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:xNLlDljK5eZpaZa6gjoz6I7c5vKzYJwnpRlRb69Kk5Lse68EUUL
 iaCvcopVwtoGoAGA+31OuduKKtgKbGNQa64Fd6Hg9XxXlXXnLcOIP1hSIle1zupPnv5ULeD
 SyQJMnlA2LfSUQM7mqZ5ctU2VmNDIiDQcJ+jqWJn+O8OWuoRsxnPOP58Ydjs+KVd/FHX//n
 NC4HKND41HnlZ6c1k7TZg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:i5iizHF9A1s=:nDgs9XWpJMoLn1af2jBhoH
 WkYUWYCwNQMLb+X5Dtp2OtuESGguBqgxCozavI2Z+YZ2qRuYvilJbuV2R0/wbCPkHHOAbNll+
 0YUoo9DIK+jXvBtVaWoVl1gTpn7mvpc5h8BhU6hdco7NNhWOZFrVuJo5WeWXPxajvapXuC9iL
 VfCA8Lv1rFfkBtkfIAntVLegOp75RHDgfU9E00mXtX28sYz7KrnPkldf/pBMHIITeIQjnWr6N
 AZ0IunLkTPGnMd0s1lpAxur3parAfxl2xz0QcScJtpStqwBe5ojyL0YELv+VdEliW6aPxVAPs
 xGlmPd/nbVKMLZyzfnfVH0l64dWI9gvOplXf55+b9ogFqkkSfaFqm5kSCFU8dBVFdO5pyVZfi
 Ygb1CRQ51YAVqTWOwf7hMojCrOHY1xmf+GHwpZda1WyS3HvTeuLNkMViS6pDVWxqyCc4+QOi8
 bPPReC1k4cVv5izyZz/CD7Iw0aNPcF09vi0TzEKENKVXNYhxyFeJe2ocE4KJGP/o1iehCMm+V
 +1jiThNx2csXTFkAzOHlUGM+ORX9HuFRYmrlZJdAkr8B7ICA+zrR6M1rWg3+RrD1s/AYHzlBL
 NqVJIvvtAp5pRPaKEOP/ydDpChffYLlHoClDM81qLpGcSpBdzIrY3lmlAWS/R1Fvmkzq3F15P
 Au6QS7Z/TZ48GT6wVGmsT9rc19JjpIY7Rxh4XTyXR4QaQ2REy0VBwfi10mR8ee2/XBjjh2Txd
 VkS/yczFFQkoVBfcZsjAngBGEGQlO5Dq2fhXuipV8764eIhjsuyKDwxDTBbF9+7uTjyU2gz7v
 K90UiHVpa4Gyq/2IkL+FMlVT/2QQyGrM/n+g36w1nxfAtIsqS4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sure it is, but:
> - it's not an "XBox One S controller", it's a variant of the "XBox One
> controller" shipped with the XBox One S.
> - we discussed this on the linux-bluetooth mailing-list in August 2016:
>    https://www.spinics.net/lists/linux-bluetooth/msg68102.html
>    revived the thread in 2017:
>    https://www.spinics.net/lists/linux-bluetooth/msg72750.html
>    and discussed the force feedback in particular in August this year:
>    https://www.spinics.net/lists/linux-input/msg57744.html
> - why would we look for a "driver" when there's already one in the
> kernel that supports all the xbox controllers except this one? :)
> 
> Really, as much as it's nice to find working code for this device, it's
> surprising you didn't contact any kernel developer before, rather than
> us having to find you.

Fair enough :)

> Yes, but that's not the way the drivers are usually arranged. They're
> arranged by vendors, so this driver would need to be merged into the
> "hid-microsoft.c" driver.

That's probably the main reason for not getting in touch earlier, I 
really don't like the idea of putting everything into the same driver 
just because it is the same vendor - or at leas the same name (even if 
Microsoft Xbox has nearly nothing to do with other parts of Microsoft).

> I'm pretty sure that the USB version can also be made to use HID.

I really don't think so, I already gave it a try. At least not "out of 
the box".

> I have no idea how the RF protocol would work though. I imagine it
> requires a dongle, or does it actually use Wi-Fi? (that would be
> surprising...).

In theory it does need one, but it is nothing more than normal Wi-Fi 
(2,4 and 5 GHz) - you can talk to the gamepad using any Wi-Fi card / 
stick you want. The problem is, that the connection is secured somehow.
If you are interested, take a look here: 
https://github.com/atar-axis/xpadneo/wiki/Microsoft-Xbox-One-Wireless-Adapter

> Anyway, I don't have much time to work on it right this minute, but it
> would be great if you could send your Bluetooth patch to start with,
> and we can iterate on that, and fix the other problems as we clear the
> priority list.

Jap, I will do that - Thank you so far!

> Cheers

Dito.
