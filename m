Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8250FC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 01:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 266202075E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 01:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="vd9os+eM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mDBY04Hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 266202075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbeIHGfj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 02:35:39 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:50803 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725731AbeIHGfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 02:35:38 -0400
X-Greylist: delayed 424 seconds by postgrey-1.27 at vger.kernel.org; Sat, 08 Sep 2018 02:35:38 EDT
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8BD1123E3;
        Fri,  7 Sep 2018 21:44:50 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 07 Sep 2018 21:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=wI7ypbBB7BnF4vjGcagm+y/ylDhOPeawrD3tmVo/lH4=; b=vd9os+eM
        bStoEzkuiWYpGoTAhdeU3LftdNQpT+bhQzrCtZbSJUMw2F4NmADuZGS5VHMZHSN9
        cEuhpkdJ3+AyLlZGaNK46fm1PjWGijZR2n11XKYjSCHl8iULFUm2Pfq9TInb3UlI
        y229ZnLVIqcCAciFQp5FZPGRTBDu0ulbpV7Ea6n3xryfZKvX16xjasNtnJoeucp/
        jPYtoSM4dA0fCV1j8rgNtK/pb5Plu2GI8+YSx79R6suC8TmheTYRn86OrQnQVpi6
        q2Mwx9xfKHR4nog5/4H+QvkR18OcSlxXELK7O+wg2kgaSiXiqqa0BBimq3o5gcbq
        4lZ8pkhT2utvRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=wI7ypbBB7BnF4vjGcagm+y/ylDhOP
        eawrD3tmVo/lH4=; b=mDBY04Hrg63gy+8TJosRANgqZpAyxAMXvQkz8YkxYA4sa
        nynwVM5leotmFIaZpazCNtTFEQB+1/xNEK0klon2kbIfDTqeUUKh0Qw3TYauUW0H
        DovG0b+Tf6n/hiqR03fSWPkI62MxYekOVAZpzXn4XQZ/FRBm1XibEFOVE/9Wiuve
        08MTxCij+9GNVctF6+e73poWseDSwTOyljM5b9/eKk1cwtmg6+6H+QM7VPQty2Gj
        SeHMoMjIHxkA+uTumwX5Wwbtad214S5wAdNikJ4Ls7B+88QrQl9d5eDBg1ud9CAt
        VgMn9i7+56Vs5zB+jojVFtJZVfsoLiOh5SUh9pR5w==
X-ME-Proxy: <xmx:kSmTW7GWjFI0vQdCprJcrUz57ssWUi3gQXIkR7mpCzk42TP9IrJS9Q>
    <xmx:kSmTW9XMkCStc3eBUhTfwjlNi6g1CvVjyZQrcxkmAu6a6wOTqWzrwA>
    <xmx:kSmTW-Bbd09kKCMVJrvwLsblKqihI4z0h1S_3ImsJSv6D98EE6HLlQ>
    <xmx:kSmTW-2hm9ngu7Uk7nLBhiIRpGRDp5lr9yDr7V_M13Lo56UIp1LBew>
    <xmx:kSmTW-Q2c11l4EIV_dhr2Yn2-CnwHnGp7yYrpOAYr_cXQfUeUyXJ2Q>
    <xmx:kimTW2ptlet526e-sWFMocwnphjAcyKtczZ-9FHiA4meirBDoHTS0A>
X-ME-Sender: <xms:kSmTWxGr8_SQa4lYzskbxXZsH5OQTTKXRE38JVS5KHj8Z6zcoyuXbg>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80B691028D;
        Fri,  7 Sep 2018 21:44:47 -0400 (EDT)
Date:   Sat, 8 Sep 2018 11:44:42 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Benjamin Tissoires <benjamin.tissoires@gmail.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] Input: reserve 2 events code because of HID
Message-ID: <20180908014442.GA16029@jelly>
References: <20180907085115.30242-1-benjamin.tissoires@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907085115.30242-1-benjamin.tissoires@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 07, 2018 at 10:51:15AM +0200, Benjamin Tissoires wrote:
> From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> 
> Prior to commit 190d7f02ce8e ("HID: input: do not increment usages when
> a duplicate is found") from the v4.18 kernel, HID used to shift the
> event codes if a duplicate usage was found. This ended up in a situation
> where a device would export a ton of ABS_MISC+n event codes, or a ton
> of REL_MISC+n event codes.
> 
> This is now fixed, however userspace needs to detect those situation.
> Fortunately, ABS_MISC+1 was never assigned a code, and so libinput
> can detect fake multitouch devices from genuine ones by checking is
> ABS_MISC+1 is set.

sorry, this isn't quite correct. we use ABS_MT_SLOT - 1 (0x2e) for the
detection of fake MT devices, i.e.
  if (ABS_MT_SLOT and not ABS_MT_SLOT-1) then multitouch

That gives you up to ABS_MISC + 6 for legitimate usage. this is handled by
libevdev, not libinput directly. libevdev adjusts the various bits on "is
this device an MT device" based on whether ABS_MT_SLOT-1 is set.

I can change this to also check for (ABS_MISC and not ABS_MISC+1) but that
obviously will depend on updated libraries then. Though I guess it won't
really be an issue until we fill up the other codes up to including 0x2e
with real values and expect userspace to handle those.

None of the bits I maintain have special code for REL_MISC+n so that bit
works fine, IMO.

One request though: instead of just having the value reserved, can we make
it REL_RESERVED and ABS_RESERVED please? Or ABS_CANARY :) Much easier than
hardcoding the numeric value.

Cheers,
   Peter


> Now that we have REL_WHEEL_HI_RES, libinput won't be able to differentiate
> true high res mice from some other device in a pre-v4.18 kernel.
> 
> Set in stone that the ABS_MISC+1 and REL_MISC+1 are reserved and should not
> be used so userspace can properly work around those old kernels.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
> 
> Hi,
> 
> while reviewing my local tree, I realize that we might want to be able
> to differentiate older kernels from new ones that export REL_WHEEL_HI_RES.
> 
> I know Dmitry was against adding several REL_MISC, so I hope just moving
> REL_WHEEL_HI_RES by one and reserving the faulty event codes would be good
> this time.
> 
> This patch applies on top of the branch for-4.20/logitech-highres from
> Jiri's tree. It should go through Jiri's tree as well.
> 
> Cheers,
> Benjamin
> 
>  include/uapi/linux/input-event-codes.h | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/include/uapi/linux/input-event-codes.h b/include/uapi/linux/input-event-codes.h
> index 29fb891ea337..30149939249a 100644
> --- a/include/uapi/linux/input-event-codes.h
> +++ b/include/uapi/linux/input-event-codes.h
> @@ -708,7 +708,12 @@
>  #define REL_DIAL		0x07
>  #define REL_WHEEL		0x08
>  #define REL_MISC		0x09
> -#define REL_WHEEL_HI_RES	0x0a
> +/*
> + * 0x0a is reserved and should not be used.
> + * It was used by HID as REL_MISC+1 and usersapce needs to detect if
> + * the next REL_* event is correct or is just REL_MISC + n.
> + */
> +#define REL_WHEEL_HI_RES	0x0b
>  #define REL_MAX			0x0f
>  #define REL_CNT			(REL_MAX+1)
>  
> @@ -745,6 +750,12 @@
>  
>  #define ABS_MISC		0x28
>  
> +/*
> + * 0x29 is reserved and should not be used.
> + * It was used by HID as ABS_MISC+1 and usersapce needs to detect if
> + * the next ABS_* event is correct or is just ABS_MISC + n.
> + */
> +
>  #define ABS_MT_SLOT		0x2f	/* MT slot being modified */
>  #define ABS_MT_TOUCH_MAJOR	0x30	/* Major axis of touching ellipse */
>  #define ABS_MT_TOUCH_MINOR	0x31	/* Minor axis (omit if circular) */
> -- 
> 2.14.3
> 
