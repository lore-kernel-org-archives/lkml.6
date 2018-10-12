Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AFB2C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF2020868
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 09:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="wibu2jX2";
	dkim=pass (1024-bit key) header.d=emlid.com header.i=@emlid.com header.b="C99gi8HL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF2020868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emlid.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbeJLRHN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 13:07:13 -0400
Received: from forward101o.mail.yandex.net ([37.140.190.181]:50808 "EHLO
        forward101o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728104AbeJLRHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 13:07:13 -0400
Received: from mxback14j.mail.yandex.net (mxback14j.mail.yandex.net [IPv6:2a02:6b8:0:1619::90])
        by forward101o.mail.yandex.net (Yandex) with ESMTP id F06F31343FCF;
        Fri, 12 Oct 2018 12:35:28 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback14j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id iKME9nwAU6-ZRmCZnQW;
        Fri, 12 Oct 2018 12:35:28 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539336928;
        bh=q9rzQg/RRM8PekrIaQxbrtckEUlHk6xUQmonWjcu5SY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To;
        b=wibu2jX2REIz1yLHiMlnDKkF+vyPGfS5tfDhq7TWh4kDZjgwoeM7vETJjmDbhOWzS
         lGuTOAQxIDfbcGgBQCimZ1GiJO0NFGz6HWRzBpbCJt5FR3F2nJw9XgWnEmmeNlXq+I
         Y3u6lzbb15nwkuY4tTcAkN/Rn2hmas5LARzqkftY=
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id 4whhjU2oR3-ZPMCOgb7;
        Fri, 12 Oct 2018 12:35:25 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emlid.com; s=mail; t=1539336925;
        bh=q9rzQg/RRM8PekrIaQxbrtckEUlHk6xUQmonWjcu5SY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:In-Reply-To;
        b=C99gi8HLD3IxNc3CaYhoj5Iue5q2lkV0KxwpiHDsY9XeNeRLdlyGQygrQqojXUn5/
         lRrE0pCMtTz/y6bILcB+uisqkUawaL7a/EYJjClExJQOrEQOBWPHkiqDycv7wP0ySY
         PoXwcTwkOp1EsW89pPweMUBJHYirB0l0OZxuuMVw=
Authentication-Results: smtp2o.mail.yandex.net; dkim=pass header.i=@emlid.com
Date:   Fri, 12 Oct 2018 12:35:23 +0300
From:   Aleksandr Aleksandrov <aleksandr.aleksandrov@emlid.com>
To:     Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        David Lechner <david@lechnology.com>,
        Thierry Reding <treding@nvidia.com>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        Johan Hovold <johan@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3] arm64: new board - Emlid Neutis N5
Message-ID: <20181012093523.GA29014@imagebutcher>
References: <1538745949-13188-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-1-git-send-email-aleksandr.aleksandrov@emlid.com>
 <1539012044-29998-2-git-send-email-aleksandr.aleksandrov@emlid.com>
 <20181010144957.exrlupoph7ovsmdw@flea>
 <9398571539259289@myt4-929fb874f3f2.qloud-c.yandex.net>
 <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2d09d6c0-0404-589d-2c34-da846cff4fb8@suse.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> >>      +/ {
> >>      + model = "Emlid Neutis N5 Developer board";
> >>      + compatible = "emlid,emlid-neutis-n5-devboard",
> >>      + "emlid,emlid-neutis-n5",
> >>
> >> Do you need the two emlid there? What comes before the comma is the
> >> vendor, while what is after is the model.
> >  
> > I think emlid-neutis-n5 module could be useful in the future, no need
> > this now.
> 
> You misunderstand: The point would be to use, e.g., "emlid,neutis-n5"
> instead of "emlid,emlid-neutis-n5" with duplicate "emlid,emlid-". It is
> orthogonal to having multiple compatible strings.

Oh, I agree. No need to duplicate "emlid". Thank you!

> >>  +&uart1 {
> >>  + pinctrl-names = "default";
> >>  + pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
> >>  + status = "okay";
> >>  +};
> >>
> >> I guess this is for bluetooth? Have you tested serdev drivers?
> >>
> > Yes, bluetooth is connected over uart1.
> > You mean if I have tested bluetooth stack via serial device?
> 
> Not quite, we're missing a child node within uart1 for a serdev driver.
> Is there no such driver yet for your Bluetooth chipset, or did you not
> yet check?

Got it. I haven't checked a serdev driver.

Maxim, the SoM can't be run without a motherboard. According to your last message
I don't change dts files, right?

Aleksandr 

