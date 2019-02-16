Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE643C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8004721A4C
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 19:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="liMRL9Kh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="W4oWlprQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732893AbfBPTsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 14:48:03 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36161 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730086AbfBPTsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 14:48:03 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 5C11620F12;
        Sat, 16 Feb 2019 14:48:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sat, 16 Feb 2019 14:48:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=RunhRhXMrYdZMzT9X1durEBXRYA
        YBuiNhzwGGT6gkd0=; b=liMRL9KhoaYzN2AWuSHmieOfZ14+9NNPGcXBKue3RNT
        gYBjwVV1s5La86MKqtLlhCtbryYHc0Fk1yhKzmC03scRMx6Xf4HCEhKDvoEqNHV5
        yxFnN1eSxrdgNmupXeYh7qF+xl9pITqu+SVM3PwrYCrfUOZfOz2K+3bb/9QB0qKh
        OsM5YJC8IJ3ey8WImPcTZI3W2azxnRoO6rpLV3Z6vvuOc+7p1ITtMEuSp63fu29e
        ofnOf7Mh6TCEBwbzH3wHADSMf/GYR+E+8Qnvrhf047qQ35xPYLqwWtRylp5aXbVp
        yLz+J1NSLNkCPulvpo6mHENeyYDyltl0XCjQ7bzE/0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=RunhRh
        XMrYdZMzT9X1durEBXRYAYBuiNhzwGGT6gkd0=; b=W4oWlprQDFBtg2wvhjDPKh
        q1vy1pkFp3ATBXNh76yAdUaSHizCgX+iRb6VN0LQ6ZEa9cuXG6SHJa0zSrQB8NBz
        xt5p57aUjhFQkfjdfaUmFzSitkRGTnMWJsY0SSEGFEpjX2WuANbaQuX5j7cdoDSj
        nnelKatI51Np/UVH7QpYJuPXdnPtIVG+vfjom0xmjTwQqxkmXx9ePcZoz307IKG/
        P/Sow/0EG09EdsEoVkeLu35+q4X3Pfft8RRk8d7KG/g/rqbaQAW0+vhShHZVEHru
        p1vHxtD1qm0MdHSBF6xJI99pby1Ht9iA38vJf3PzDwZ5co83Bg92pV8Xrs7UFkWQ
        ==
X-ME-Sender: <xms:8WhoXFeefX94WVskdUFQAwyprmGSB6Cg-q8JgxiWivDsPqpGXw3RKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledruddtledgudefvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfhuthenuceurghilhhouhhtmecu
    fedttdenucenucfjughrpeffhffvuffkfhggtggujggfsehttdertddtredvnecuhfhroh
    hmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgtohhmqeenucfkphepuddtledr
    jedrieegrdduleenucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehkrhhorghhrd
    gtohhmnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:8WhoXIee8Z10dtk455mDJxR9zbfLxCKUWar43EuXGDd_n0G2gwffsQ>
    <xmx:8WhoXANpVWMWwU5Jt6et_eOZSJ5kLCdx5o9V-NaB54Np-8GuHx9XCA>
    <xmx:8WhoXHJew6Tmaaj2TIxdsG15J08Bxwtg9T8MsPFaDk7U7OPPsn5-_g>
    <xmx:8mhoXBJtlVvZgm_mVbeXMyzDf8W6eYaR4gQ2ugXZ6pzvhqlq3ojh5Q>
Received: from localhost (19.64.7.109.rev.sfr.net [109.7.64.19])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2FEC5E4511;
        Sat, 16 Feb 2019 14:48:00 -0500 (EST)
Date:   Sat, 16 Feb 2019 20:47:58 +0100
From:   Greg KH <greg@kroah.com>
To:     Nix <nix@esperi.org.uk>
Cc:     johan@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: 4.20.7: pl2303 not working (post-4.19 regression) (limited info
 so far, not yet bisected)
Message-ID: <20190216194758.GA10756@kroah.com>
References: <87o97bu2bt.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o97bu2bt.fsf@esperi.org.uk>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 16, 2019 at 04:26:30PM +0000, Nix wrote:
> So I just tried to connect up to my ancient Soekris firewall's serial
> console to try to bisect a problem where it stopped booting in 4.20, and
> found I couldn't.
> 
> minicom says:
> 
> minicom: cannot open /dev/ttyUSB0: Input/output error
> 
> and in the dmesg we see
> 
> [705576.028170] pl2303 ttyUSB0: failed to submit interrupt urb: -28
> 
> Booting to 4.19, everything works fine. (A random GalliumOS Chromebook
> running 4.9.4 works fine too, not that that confirmation is terribly
> useful.)
> 
> This is an extremely preliminary report in case it's instantly obvious
> what's going on: I'll do enough investigation to produce an actually
> useful bug report, including bisecting this, after I've bisected the
> *other* non-booting bug, but that might not be until next weekend. (All
> this for a firewall I was trying to decommission! bah :) )

bisection would be great, thanks!

greg k-h
