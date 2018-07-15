Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8237CECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 19:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AFA920840
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 19:58:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AFA920840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeGOUWs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Jul 2018 16:22:48 -0400
Received: from mail.ispras.ru ([83.149.199.45]:45662 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726881AbeGOUWs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Jul 2018 16:22:48 -0400
Received: from [192.168.1.6] (unknown [89.252.248.85])
        by mail.ispras.ru (Postfix) with ESMTPSA id C1FEE54008A;
        Sun, 15 Jul 2018 22:58:44 +0300 (MSK)
Subject: Re: [PATCH] Input: pxrc - fix leak of usb_device
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
References: <1531512477-31981-1-git-send-email-khoroshilov@ispras.ru>
 <20180714080920.GA15123@gmail.com> <20180714085109.mbhk6aybpjsbuq6l@penguin>
 <20180715074225.GB15123@gmail.com>
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
Openpgp: preference=signencrypt
Autocrypt: addr=khoroshilov@ispras.ru; prefer-encrypt=mutual; keydata=
 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
 NoYGZfNAuA==
Message-ID: <c50f2947-6660-b1eb-ddd5-6f810b631834@ispras.ru>
Date:   Sun, 15 Jul 2018 22:58:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180715074225.GB15123@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Marcus,

On 15.07.2018 10:42, Marcus Folkesson wrote:
> On Sat, Jul 14, 2018 at 08:51:09AM +0000, Dmitry Torokhov wrote:
>> On Sat, Jul 14, 2018 at 10:09:20AM +0200, Marcus Folkesson wrote:
>>> Hi Alexey,
>>>
>>> Good catch!
>>>
>>> On Fri, Jul 13, 2018 at 11:07:57PM +0300, Alexey Khoroshilov wrote:
>>>> pxrc_probe() calls usb_get_dev(), but there is no usb_put_dev()
>>>> anywhere in the driver.
>>>>
>>>> The patch adds one to error handling code and to pxrc_isconnect().
>>>>
>>>> Found by Linux Driver Verification project (linuxtesting.org).
>>>>
>>>> Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
>>>
>>> Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>
>> Hmm, the biggest question however if we need to "take" the device, as I
>> do not think interface can outlive the device, and whether we actually
>> need to store it in pxrc, as we only need it during set up, as far as I
>> can see.
> 
> Yep, the device is only used during setup.
> I interpret the comments for usb_get_dev() as you should take a
> reference count on the device even if you only use the interface, but I
> could be wrong.
> 
>>From usb_get_dev()::
> 
> 	 * usb_get_dev - increments the reference count of the usb device structure
> 	 * @dev: the device being referenced
> 	 *
> 	 * Each live reference to a device should be refcounted.
> 	 *
> 	 * Drivers for USB interfaces should normally record such references in
> 	 * their probe() methods, when they bind to an interface, and release
> 	 * them by calling usb_put_dev(), in their disconnect() methods.
> 
> I can fix the driver to not take the device if that is what we want.
> If not Alexey want to fix it of course, it is his catch :-)

As far as I can see the proposed solution requires some refactoring of
the init code. So, I believe the author is in the better position to do
that.

Best regards,
Alexey
