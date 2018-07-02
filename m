Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50E98C3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3F0121E23
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 11:38:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3F0121E23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maciej.szmigiero.name
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030558AbeGBLih (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 07:38:37 -0400
Received: from vps-vb.mhejs.net ([37.28.154.113]:34064 "EHLO vps-vb.mhejs.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753356AbeGBLid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 07:38:33 -0400
Received: by vps-vb.mhejs.net with esmtps (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1fZxA5-0005ht-Ih; Mon, 02 Jul 2018 13:38:29 +0200
Subject: Re: [RESEND][PATCH v6 3/6] cx25840: add pin to pad mapping and output
 format configuration
To:     Dan Carpenter <dan.carpenter@oracle.com>, kbuild@01.org
Cc:     kbuild-all@01.org, Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org, Hans Verkuil <hverkuil@xs4all.nl>
References: <20180702055548.4puqbtjzgf2afyyb@mwanda>
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Openpgp: preference=signencrypt
Autocrypt: addr=mail@maciej.szmigiero.name; prefer-encrypt=mutual; keydata=
 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
Message-ID: <80ad8df5-f826-67bf-8ec5-f30aa70cf426@maciej.szmigiero.name>
Date:   Mon, 2 Jul 2018 13:38:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702055548.4puqbtjzgf2afyyb@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

On 02.07.2018 07:55, Dan Carpenter wrote:
> Hi Maciej,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> url:    https://github.com/0day-ci/linux/commits/Maciej-S-Szmigiero/Add-analog-mode-support-for-Medion-MD95700/20180630-050341
> base:   git://linuxtv.org/media_tree.git master
> 
> New smatch warnings:
> drivers/media/i2c/cx25840/cx25840-core.c:468 cx25840_s_io_pin_config() warn: bitwise AND condition is false here
> 
> Old smatch warnings:
> drivers/media/i2c/cx25840/cx25840-core.c:497 cx25840_s_io_pin_config() warn: bitwise AND condition is false here
> drivers/media/i2c/cx25840/cx25840-core.c:526 cx25840_s_io_pin_config() warn: bitwise AND condition is false here
> 
> # https://github.com/0day-ci/linux/commit/64372f380e540a77b73d4628a585c9c92956a7fd
> git remote add linux-review https://github.com/0day-ci/linux
> git remote update linux-review
> git checkout 64372f380e540a77b73d4628a585c9c92956a7fd
> vim +468 drivers/media/i2c/cx25840/cx25840-core.c
> 
> 64372f38 Maciej S. Szmigiero 2018-06-29  435  
> 64372f38 Maciej S. Szmigiero 2018-06-29  436  static int cx25840_s_io_pin_config(struct v4l2_subdev *sd, size_t n,
> 64372f38 Maciej S. Szmigiero 2018-06-29  437  				   struct v4l2_subdev_io_pin_config *p)
> 64372f38 Maciej S. Szmigiero 2018-06-29  438  {
> 64372f38 Maciej S. Szmigiero 2018-06-29  439  	struct i2c_client *client = v4l2_get_subdevdata(sd);
> 64372f38 Maciej S. Szmigiero 2018-06-29  440  	unsigned int i;
> 64372f38 Maciej S. Szmigiero 2018-06-29  441  	u8 pinctrl[6], pinconf[10], voutctrl4;
> 64372f38 Maciej S. Szmigiero 2018-06-29  442  
> 64372f38 Maciej S. Szmigiero 2018-06-29  443  	for (i = 0; i < 6; i++)
> 64372f38 Maciej S. Szmigiero 2018-06-29  444  		pinctrl[i] = cx25840_read(client, 0x114 + i);
> 64372f38 Maciej S. Szmigiero 2018-06-29  445  
> 64372f38 Maciej S. Szmigiero 2018-06-29  446  	for (i = 0; i < 10; i++)
> 64372f38 Maciej S. Szmigiero 2018-06-29  447  		pinconf[i] = cx25840_read(client, 0x11c + i);
> 64372f38 Maciej S. Szmigiero 2018-06-29  448  
> 64372f38 Maciej S. Szmigiero 2018-06-29  449  	voutctrl4 = cx25840_read(client, 0x407);
> 64372f38 Maciej S. Szmigiero 2018-06-29  450  
> 64372f38 Maciej S. Szmigiero 2018-06-29  451  	for (i = 0; i < n; i++) {
> 64372f38 Maciej S. Szmigiero 2018-06-29  452  		u8 strength = p[i].strength;
> 64372f38 Maciej S. Szmigiero 2018-06-29  453  
> 64372f38 Maciej S. Szmigiero 2018-06-29  454  		if (strength != CX25840_PIN_DRIVE_SLOW &&
> 64372f38 Maciej S. Szmigiero 2018-06-29  455  		    strength != CX25840_PIN_DRIVE_MEDIUM &&
> 64372f38 Maciej S. Szmigiero 2018-06-29  456  		    strength != CX25840_PIN_DRIVE_FAST) {
> 64372f38 Maciej S. Szmigiero 2018-06-29  457  
> 64372f38 Maciej S. Szmigiero 2018-06-29  458  			v4l_err(client,
> 64372f38 Maciej S. Szmigiero 2018-06-29  459  				"invalid drive speed for pin %u (%u), assuming fast\n",
> 64372f38 Maciej S. Szmigiero 2018-06-29  460  				(unsigned int)p[i].pin,
> 64372f38 Maciej S. Szmigiero 2018-06-29  461  				(unsigned int)strength);
> 64372f38 Maciej S. Szmigiero 2018-06-29  462  
> 64372f38 Maciej S. Szmigiero 2018-06-29  463  			strength = CX25840_PIN_DRIVE_FAST;
> 64372f38 Maciej S. Szmigiero 2018-06-29  464  		}
> 64372f38 Maciej S. Szmigiero 2018-06-29  465  
> 64372f38 Maciej S. Szmigiero 2018-06-29  466  		switch (p[i].pin) {
> 64372f38 Maciej S. Szmigiero 2018-06-29  467  		case CX25840_PIN_DVALID_PRGM0:
> 64372f38 Maciej S. Szmigiero 2018-06-29 @468  			if (p[i].flags & V4L2_SUBDEV_IO_PIN_DISABLE)
> 
> V4L2_SUBDEV_IO_PIN_DISABLE is zero.  It's sometimes used as a bit zero
> BIT(V4L2_SUBDEV_IO_PIN_DISABLE) and presumably that's what is intended
> here.

Good catch, thanks.
Before commit 4eb2f55728abbe ("media: v4l2-subdev: better document IO pin configuration flags")
these identifiers were bit masks, now they are bit numbers.

This wasn't caught in testing since the cxusb driver always passes zero
as flags anyway.

Maciej
