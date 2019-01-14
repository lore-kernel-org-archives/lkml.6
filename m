Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D40C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:47:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D90C2205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="uhoDVn/t";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XGggvW4D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfANWrC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 17:47:02 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:44221 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726618AbfANWrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 17:47:02 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jan 2019 17:47:01 EST
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 96472286D8;
        Mon, 14 Jan 2019 17:41:19 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 14 Jan 2019 17:41:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=NHgrd3T5V4ufClGBUWgbNL6MNfQ
        lMqZicW1/D9DPrSs=; b=uhoDVn/tYuaCz5+JIJu1PtmSVDFSPOVkHg7CtGfLgwH
        DgfPxfy+hd4kLyTuC9rHnuiJ4FmZ1nChaDdk8JWOXGlsqQTUaFWhRioLtjR9u8zM
        6+OgrttBSHU5tA9BZ4gTHxK+MxPNx1DJ99aVZe+zcWA2bHcVHy4jNyyvP0ZZKmZj
        Gzx/ih0dygF1EgiW63U9wmTtM7XAzT/AyizN+IJubYWHUJozI/zvhqoLXtIowndX
        E4M+pAF6+7CzrmyWllqIaG7iKq1Q7Ls5uW1cJM+14BqH+uDLrBHSpK2u4yW5jiH6
        dyc/tGP4O1QGxJoDMH6uI0oIASy+0yz2Dy57qg0rhUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=NHgrd3
        T5V4ufClGBUWgbNL6MNfQlMqZicW1/D9DPrSs=; b=XGggvW4DY7tyzuclzDgQ8K
        W3DtqS8xWPmbd7pw4FinnwOLd6+EV6MX9g/3gxdcOHOJ7nV0zA7pE3L3J65IlzB6
        sspohyesln34T3YguhRSOhxiyeYpWBfWVyWDqOFOWqmQZyXaQsncdmL4DyUWIKIM
        IzIcyydRRzmzHFBDYVWNqCHOYUT1OTA+e4HmJe7fEv8D/jnaeBbnSwoT/7/+OMOC
        epNh4y5TM98kGlK5WNlG7PTSrB0UsBbibxgHAS5N4uADQ4zkCOathVVS43gARRsT
        0zOHUpWXn1gsxTjGyzAkd+dvrTQe6YmUuajkm/vr0t34cfyq0o4miTSf/ovFYH4Q
        ==
X-ME-Sender: <xms:DhA9XCNo57FqGivUdNSWPq3uUK_qZlFbvOnmmbVjjRr94_ZuUD_e0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrgedugdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefrvghtvghrucfjuhhtthgvrhgvrhcu
    oehpvghtvghrrdhhuhhtthgvrhgvrhesfihhohdqthdrnhgvtheqnecukfhppeduieejrd
    dujeelrdduieeirddvleenucfrrghrrghmpehmrghilhhfrhhomhepphgvthgvrhdrhhhu
    thhtvghrvghrseifhhhoqdhtrdhnvghtnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:DxA9XH5n81Cf8x8DYQzFfVG5W7qoqqoMj29u13K_ORVqu9Sh6vJSbA>
    <xmx:DxA9XE2qLgjYL1GfVI2UDpsQP143y-iVvti_gnM6dS4V9CdceMdCMQ>
    <xmx:DxA9XEz4NesGUXPEYNFcUeVKs5z1f1sjz4uX8ZpdN3hDf2LpTOi4Dw>
    <xmx:DxA9XPn1Xoa-AiGahoTQPscmgt1xRk3JXip5ssLDyQLAqhb5DWDEjQ>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8A613E40E1;
        Mon, 14 Jan 2019 17:41:16 -0500 (EST)
Date:   Tue, 15 Jan 2019 08:41:14 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Byoungyoung Lee <lifeasageek@gmail.com>, rydberg@bitmath.org,
        DaeRyong Jeong <threeearcat@gmail.com>,
        syzkaller@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix undefined behavior in
 uinput_validate_absinfo()
Message-ID: <20190114224114.GA18464@jelly>
References: <20190114220448.GA241112@dtor-ws>
 <20190114220756.GF117329@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114220756.GF117329@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 02:07:56PM -0800, Dmitry Torokhov wrote:
> On Mon, Jan 14, 2019 at 02:04:48PM -0800, Dmitry Torokhov wrote:
> > An integer overflow may arise in uinput_validate_absinfo() if "max - min"
> > can't be represented by an "int". We should check for overflow before
> > trying to use the result.
> > 
> > Reported-by: Kyungtae Kim <kt0755@gmail.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  drivers/input/misc/uinput.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/input/misc/uinput.c b/drivers/input/misc/uinput.c
> > index 8ec483e8688b..26ec603fe220 100644
> > --- a/drivers/input/misc/uinput.c
> > +++ b/drivers/input/misc/uinput.c
> > @@ -39,6 +39,7 @@
> >  #include <linux/init.h>
> >  #include <linux/fs.h>
> >  #include <linux/miscdevice.h>
> > +#include <linux/overflow.h>
> >  #include <linux/input/mt.h>
> >  #include "../input-compat.h"
> >  
> > @@ -405,7 +406,7 @@ static int uinput_open(struct inode *inode, struct file *file)
> >  static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
> >  				   const struct input_absinfo *abs)
> >  {
> > -	int min, max;
> > +	int min, max, range;
> >  
> >  	min = abs->minimum;
> >  	max = abs->maximum;
> > @@ -417,7 +418,7 @@ static int uinput_validate_absinfo(struct input_dev *dev, unsigned int code,
> >  		return -EINVAL;
> >  	}
> >  
> > -	if (abs->flat > max - min) {
> > +	if (check_sub_overflow(max, min, &range) && abs->flat > range) {
> 
> This should be !check_sub_overflow(...) of course.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net> with that in place,
thanks.

Cheers,
   Peter
 

> >  		printk(KERN_DEBUG
> >  		       "%s: abs_flat #%02x out of range: %d (min:%d/max:%d)\n",
> >  		       UINPUT_NAME, code, abs->flat, min, max);
> > -- 
> > 2.20.1.97.g81188d93c3-goog
> > 
> > 
> > -- 
> > Dmitry
> 
> -- 
> Dmitry
