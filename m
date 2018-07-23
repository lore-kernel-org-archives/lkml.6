Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C61ECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A76A720875
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 08:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76A720875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sonarnerd.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388100AbeGWJdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 05:33:12 -0400
Received: from rankki.sonarnerd.net ([194.142.149.154]:27062 "EHLO
        mail.sonarnerd.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387978AbeGWJdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 05:33:11 -0400
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Jul 2018 05:33:11 EDT
Received: from [IPv6:fc00::2] (porkkala.uworld [IPv6:fc00::2])
        by mail.sonarnerd.net (Postfix) with ESMTP id 2158323111A;
        Mon, 23 Jul 2018 11:26:41 +0300 (EEST)
Subject: Re: [PATCH] alsa/usb-audio: Topping DX7s quirk for DSD interface
To:     Yue Wang <yuleopen@gmail.com>, linux-kernel@vger.kernel.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Nobutaka Okabe <nob77413@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Daniel Mack <daniel@zonque.org>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Alberto Aguirre <albaguirre@gmail.com>,
        alsa-devel@alsa-project.org
References: <20180723080208.44235-1-yuleopen@gmail.com>
From:   Jussi Laako <jussi@sonarnerd.net>
Message-ID: <133b10a8-95d0-7882-39dc-c3cf8f80aaab@sonarnerd.net>
Date:   Mon, 23 Jul 2018 11:26:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723080208.44235-1-yuleopen@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> +	case USB_ID(0x152a, 0x8750): /* Topping DX7s */
0x152a is Thesycon's VID and if it's based on XMOS I'd recommend to try 
adding the 0x152a VID to the generic DSD capability auto-detect list 
instead of this old device specific list.

I consider it very likely that it would work that way and at the same 
time also cover all other devices with the same firmware and Thesycon's VID.


Best regards,

	- Jussi
