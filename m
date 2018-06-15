Return-Path: <SRS0=sQLo=JB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15E3C5CFC1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56F30208B5
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Jun 2018 23:36:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=hmh.eng.br header.i=@hmh.eng.br header.b="dV6g02Cb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="s1abkV2Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56F30208B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hmh.eng.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756814AbeFOXgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Jun 2018 19:36:35 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45405 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753761AbeFOXgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jun 2018 19:36:33 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id BE12921ADD;
        Fri, 15 Jun 2018 19:36:32 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 15 Jun 2018 19:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hmh.eng.br; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=3D8IXBVKGho4LrCfyWOM9rIj0BpUy
        voEi9d61zauNJs=; b=dV6g02CbZ3/JfbGFKxV+uZu5kS9ZCewppUapmOBfcffod
        +IB/JvXW9Vf2s/4HwaK9+V8xgYdCBMdSf6haa3Mz9+Igz1uscHjaH79U5DqjbjyI
        jD7nz2whhpV3k63iknZZ7eCJi2FBkneOrV0dKFZDpk+p7f/8xxTDmYMjkUydNFV7
        LREzWxdpBui/5k1ELSf3LcDLfEm7L6dIBEVREtzKRhsEyjAzK0jYUnNyk/F+VLk2
        W6Y88OLc7rXEns2FXl9N9AGLF4I0vMQdTJpOv+3qg9kglTxt1WNwNpr0ipVTtbvP
        7IJJq/gWjdM1wXnSOJ4NP26jvvFck/AZUsRBSKjrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=3D8IXB
        VKGho4LrCfyWOM9rIj0BpUyvoEi9d61zauNJs=; b=s1abkV2YB13oD/qUDhNRk6
        IztrGuhSTGkoJC9yssDmH1VcTTugP4GJbdqsNVO+7AjAsZGY28fYej3mz2AlpErI
        JbFAjAWjPtnVAetBtMCXucCDoZl8ykmCyKR4xrErRDleH3JByrjURTQv/yvAuFCk
        sRPLWBv/OXNtLq/2REunPB8rXIF++xJOMJWcbj/8jvTA9WHTmflmOj2Q0kETT+1H
        LKEqcgIKh397GVLFmoRVnG/p2BLQNDcQykYLwM75kJlPaKyjoENy1GoTLrlMcz6E
        I+XtPeWM1oeYK7Vzet4APz28Ly+OnBIKD/ooEb3gr04TqBNsIdcXSFJjm3GwGAug
        ==
X-ME-Proxy: <xmx:gE0kW9zbbf0AeInCN-24ajDrOBnf-QInp2CUyc_YJjagh2BnQgEvXg>
    <xmx:gE0kW9d3R5aCAapA4UuHD82oPRRTboi_ad2PjwqCFcHZ0mndeIrhOg>
    <xmx:gE0kW1o_vLsAyBAD5G_PUL0s5qMeHebAnYy2363G7LJj2GAgDeMKFA>
    <xmx:gE0kW9Qk5KLY-WlGEkJYen5G1uDbgVDijYm2MzjxJsS-FUgt0h9kzw>
    <xmx:gE0kWxYZPIATqJfgyz561ToJL9k7yDw6QsvL_SESxIoA0-Uiz1nzcQ>
    <xmx:gE0kW1RG3uKpq5Ep5rFsgkEHqrVXPQneq8b5twfxhdsF4VYCgRmuMw>
X-ME-Sender: <xms:gE0kWy0_3Bkgh5Gf2U5dlKZ6K86Cf4Y1hqvz3gQpYZMTem9tWsud-g>
Received: from khazad-dum.debian.net (unknown [201.53.245.99])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4279BE43A3;
        Fri, 15 Jun 2018 19:36:32 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by localhost.khazad-dum.debian.net (Postfix) with ESMTP id 0AEF03401327;
        Fri, 15 Jun 2018 20:36:30 -0300 (-03)
X-Virus-Scanned: Debian amavisd-new at khazad-dum.debian.net
Received: from khazad-dum.debian.net ([127.0.0.1])
        by localhost (khazad-dum2.khazad-dum.debian.net [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id SbaA053qn5n1; Fri, 15 Jun 2018 20:36:28 -0300 (-03)
Received: by khazad-dum.debian.net (Postfix, from userid 1000)
        id BEE933400BEA; Fri, 15 Jun 2018 20:36:28 -0300 (-03)
Date:   Fri, 15 Jun 2018 20:36:28 -0300
From:   Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        ibm-acpi-devel@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ThinkPad T480s & LED_MUTE, LED_MICMUTE
Message-ID: <20180615233628.gy2ffgupctheyqof@khazad-dum.debian.net>
References: <20180608111057.4wxpg7m7nm7suf6n@pali>
 <20180615112606.GA3986@amd>
 <20180615113728.h7snxhe2juaqvjyx@pali>
 <20180615123007.nxsymdvr3nj3it5i@khazad-dum.debian.net>
 <20180615190915.cdntdeesc52ei35u@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180615190915.cdntdeesc52ei35u@pali>
X-GPG-Fingerprint1: 4096R/0x0BD9E81139CB4807: C467 A717 507B BAFE D3C1  6092
 0BD9 E811 39CB 4807
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jun 2018, Pali Rohár wrote:
> This means that kernel should not export any led class device. Or when
> exported, then "set" operation should always fail.

"not export" is right.

> > 2. Otherwise implement it in-kernel, so that userspace cannot unmute
> >    when the human has activated the "mute" switch, and the LED cannot be
> >    controlled by userspace to lie (report mute when it is not mute).
> 
> This looks like a good candidate to use led "trigger" interface. Create
> a mute trigger and attach it to that led device.

Maybe, as long as done in-kernel and not possible to mess with from
userspace.

> means set. What is SHDA doing, I have not figured out. It does not

Look at the HDA mixer state, SHDA is likely to be directly messing with
it.

-- 
  Henrique Holschuh
