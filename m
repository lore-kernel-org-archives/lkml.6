Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E531ECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACDF2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 05:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="FsLdYsac";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ksQg71/A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACDF2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeJSNvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 09:51:04 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58483 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726987AbeJSNvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 09:51:04 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 703C721F11;
        Fri, 19 Oct 2018 01:46:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 19 Oct 2018 01:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=3TsSiTjFrIc2A5dU/o+dQzsLgSj
        9A4woQmlNj1u87Hg=; b=FsLdYsacAvGwN/j/JwHOoAi2HbnSlUzbMuem1KwwPgj
        2z8y37gne+3yfJ82KXU3tV/gGs3ujqApL9eG9Wl+iPLC0Mp43sf/fAMWIfOCWw84
        lC36pIMC1QXpdN31oNxzSvGkLHZQe26Vj3047b7ubZeQ66PY+DvQsZedYH7CA32K
        +Cd+FBQbl8Szz7HYep1nwWpAs5P1e28qBH/06RXQ4dxHacpCZboBOXHrk93UQdlB
        ZORu8NuM518ZMkWvB0O4z/sQKGcXMUgM+IKswwORHSVwrQ1dwrqSDGhN3CXKiiHX
        iN/G1YdjXa/+aRwPsFKbY4Mg6yPIcI0bSSlIqc7qFBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=3TsSiT
        jFrIc2A5dU/o+dQzsLgSj9A4woQmlNj1u87Hg=; b=ksQg71/A+CLjbmIqjbfwCp
        FKftzBENBDGd6ErOxIxzFZPcml96NCDd5ug4nUSqWeYaUGZfNpN4B/V3I5DGkkiu
        /rMv1ofn14GMX0wy4uKjbnjDen0zilEAOp4lqFU3hKrCcfJbv4+tmqPaGCvYjTro
        LdxgpEolsh1mrp4B9gMn1Q0vG+fmfltT3c7z9EVPdCIz91FQptuEWHeGgaGfiQ79
        wTwh4NOlT3lwZcSPQ4ygUTdQUMZR82xGyh8poOcgua/Iz3d1Uz6R5lL328suAK0g
        KTmiob/n6FEo/+Z4TXBNh30ra0lAFcBBXr7ESZMyaRwBqomhZm10+cUuzUqPZKUA
        ==
X-ME-Sender: <xms:t2_JWxKNvzJNpmWUOi5HXlmvuCOY5sBZ-od2xAcfuZfh-UHG38GBvg>
X-ME-Proxy: <xmx:t2_JW2gORoJNuaL1L7oP5qVeJahxkCGfvdJZXnGLUk0lWD96GSGQEQ>
    <xmx:t2_JW_wtzn2VRawblv5Pn9m9L00oiXzcrm7rhR64XLf4TLgFQyHmhw>
    <xmx:t2_JW8wbCQXSoe7_mMk1_qA9tFOfOBd872btss3ovnQydUK1P3VDpg>
    <xmx:t2_JWxq1BD5otn5k9_KLLxFofS1G_vwG3UvZwbPW09IFw_6geGdvJw>
    <xmx:t2_JW3k3Zb48HjdU9dIjmMeiYrBwv8blA8V5M-N-bFJgWn7drPLD-Q>
    <xmx:uG_JW8_iv37iBz8DbmdstCTO61gWkeyiiKpvEqYailodTHsxxWC0Tw>
Received: from jelly (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 18126E4408;
        Fri, 19 Oct 2018 01:46:29 -0400 (EDT)
Date:   Fri, 19 Oct 2018 15:46:24 +1000
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: synaptics - avoid using uninitialized variable
 when probing
Message-ID: <20181019054624.GA2783@jelly>
References: <20181017001443.GA232819@dtor-ws>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181017001443.GA232819@dtor-ws>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 16, 2018 at 05:14:43PM -0700, Dmitry Torokhov wrote:
> synaptics_detect() does not check whether sending commands to the
> device succeeds and instead relies on getting unique data from the
> device. Let's make sure we seed entire buffer with zeroes to make sure
> we not use garbage on stack that just happen to be 0x47.
> 
> Reported-by: syzbot+13cb3b01d0784e4ffc3f@syzkaller.appspotmail.com
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

doh, was just about to send out the same patch.

Reviewed-by: Peter Hutterer <peter.hutterer@who-t.net>

Cheers,
   Peter

> ---
>  drivers/input/mouse/synaptics.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
> index 55d33500d55e..5e85f3cca867 100644
> --- a/drivers/input/mouse/synaptics.c
> +++ b/drivers/input/mouse/synaptics.c
> @@ -99,9 +99,7 @@ static int synaptics_mode_cmd(struct psmouse *psmouse, u8 mode)
>  int synaptics_detect(struct psmouse *psmouse, bool set_properties)
>  {
>  	struct ps2dev *ps2dev = &psmouse->ps2dev;
> -	u8 param[4];
> -
> -	param[0] = 0;
> +	u8 param[4] = { 0 };
>  
>  	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
>  	ps2_command(ps2dev, param, PSMOUSE_CMD_SETRES);
> -- 
> 2.19.1.331.ge82ca0e54c-goog
> 
> 
> -- 
> Dmitry
