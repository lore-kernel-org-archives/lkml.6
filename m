Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E29C004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136AB20833
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 11:41:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bitmath.org header.i=@bitmath.org header.b="WBBO/LSe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 136AB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitmath.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728324AbeI3SGY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 14:06:24 -0400
Received: from mailrelay2-1.pub.mailoutpod1-cph3.one.com ([46.30.210.183]:24464
        "EHLO mailrelay2-1.pub.mailoutpod1-cph3.one.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728192AbeI3SGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 14:06:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitmath.org; s=20140924;
        h=content-transfer-encoding:content-type:in-reply-to:mime-version:date:
         message-id:from:references:cc:to:subject:from;
        bh=CaItNcofPfUagJ7SBl5AX4lFAmvsbLCRw7WcSJTDhuw=;
        b=WBBO/LSe05tlIV/TidhIvb8NJguHcTptrEMo0VW8RskzFKP3tJv53vF9lP4clytEegDJ7KZ+c2AK2
         jt/nfS28bQdb2y/GOr3URnPckodVOw5esaoXdG0rFXc5Briu+KbKihD1d5MYpHSG/vjL4f4ynmtfHF
         D7/LmHLwSeXHmhUU=
X-HalOne-Cookie: 55723b98f5ffd7750dbec58da6caeb56d2f57900
X-HalOne-ID: af78ab84-c4a4-11e8-9b9d-d0431ea8a290
Received: from [192.168.19.13] (unknown [79.136.64.225])
        by mailrelay2.pub.mailoutpod1-cph3.one.com (Halon) with ESMTPSA
        id af78ab84-c4a4-11e8-9b9d-d0431ea8a290;
        Sun, 30 Sep 2018 11:33:43 +0000 (UTC)
Subject: Re: [PATCH] [v3] HID: add support for Apple Magic Trackpad 2
To:     Sean O'Brien <seobrien@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     marek.wyborski@emwesoft.com, linux-kernel@vger.kernel.org,
        dmitry.torokhov@gmail.com, linux-input@vger.kernel.org,
        Jiri Kosina <jikos@kernel.org>, claudio@ponyfleisch.ch
References: <20180920231308.237277-1-seobrien@chromium.org>
 <CAOOzhkosyZpr+B1xwZcG3viNbWZFWr9WQtgGdP13i_+_Ocdgmg@mail.gmail.com>
From:   Henrik Rydberg <rydberg@bitmath.org>
Message-ID: <b3a3b9f8-3f74-d2d4-fb12-2cf46d756232@bitmath.org>
Date:   Sun, 30 Sep 2018 13:34:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <CAOOzhkosyZpr+B1xwZcG3viNbWZFWr9WQtgGdP13i_+_Ocdgmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sean,

> Gentle reminder, thank you!
>
> On Thu, Sep 20, 2018 at 4:13 PM Sean O'Brien <seobrien@chromium.org> wrote:
>> USB device
>>          Vendor 05ac (Apple)
>>          Device 0265 (Magic Trackpad 2)
>> Bluetooth device
>>          Vendor 004c (Apple)
>>          Device 0265 (Magic Trackpad 2)
>>
>> Add support for Apple Magic Trackpad 2 over USB and bluetooth, putting
>> the device in multi-touch mode.
>>
>> Signed-off-by: Claudio Mettler <claudio@ponyfleisch.ch>
>> Signed-off-by: Marek Wyborski <marek.wyborski@emwesoft.com>
>> Signed-off-by: Sean O'Brien <seobrien@chromium.org>
>> ---
>>
>>   drivers/hid/hid-ids.h        |   1 +
>>   drivers/hid/hid-magicmouse.c | 149 +++++++++++++++++++++++++++++++----
>>   2 files changed, 134 insertions(+), 16 deletions(-)

This version looks good.

Reviewed-by: Henrik Rydberg <rydberg@bitmath.org>

Thank you!

Henrik


