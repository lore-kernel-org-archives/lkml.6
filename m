Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9453FC6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:42:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583A620672
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 22:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544568168;
	bh=W6RSb1WGGAa/lFOMjAsKChAv1Ly0uGWRltzbgtWIrXA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TP1LpNWSoNyuKu/Nsu2ouf+HNaqThmRlK2Po/HG/hJXcEzK84dLjNk054Bgga/FQU
	 aBzVfE4vFMgGoxa3ZEGNYMFk95hvdkwo8x/eyJQfoxrBQtXXG1yNzAJF4x8xharDZj
	 n9moKO2gVtlcXgXFUiCcXMjjjBln+rPgl2svkqJw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 583A620672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLKWmr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 17:42:47 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45465 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbeLKWmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 17:42:44 -0500
Received: by mail-ot1-f65.google.com with SMTP id 32so15719837ota.12;
        Tue, 11 Dec 2018 14:42:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7Bt+DwbFZ+TeQMvGL0PtpTseNkOQeR/h9ziJF2avlrQ=;
        b=Iq3hUl7D0GJpHLcbIdGHPKq7lFoxX5jksJirQX6JwZGXtRsHQA+kgJkPEr28LBS9L0
         HmRRja2vH27R+ORx4g53eumZ0i/7au7PuUbwJ0ZbUMm38M1aJGCREny57Sc6/c2k27bj
         9dMk3BpGtiCb9kwsBI4RPNkOAnGI4GcwqE3HxLUjLrQlSVCy/Te/WKycBOMcBU8bBJv9
         5Kj/V/nexHzP8S0nmzEs03hwsSQAkitx6HMKX3XhzVRuAH4Kv0K1L9XFTSUZZ/NSZlrf
         RibSiOM4RCYhQfd//sliDxfkAZU0GxhwU3EqHPf1u2ml1d8RO9PSpa6VCQVsvciAakRI
         kGJQ==
X-Gm-Message-State: AA+aEWZjUjFfbOfBkd2TbgljYhX+UipwlupsBntjUNhnK06Qx9hi8Ypq
        7gWrUWATufLgVscRqqamHQ==
X-Google-Smtp-Source: AFSGD/WZ2a+JaQ2eO8BVMKHFG6CiZRmNJl3GIq3eZGZtOhCOffHixkpyfkVz8y7BHR906k+RLe9JFA==
X-Received: by 2002:a9d:69d7:: with SMTP id v23mr13224444oto.96.1544568163338;
        Tue, 11 Dec 2018 14:42:43 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id g4sm8332135otp.53.2018.12.11.14.42.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Dec 2018 14:42:42 -0800 (PST)
Date:   Tue, 11 Dec 2018 16:42:42 -0600
From:   Rob Herring <robh@kernel.org>
To:     "David R. Piegdon" <lkml@p23q.org>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Kay Sievers <kay@vrfy.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: Re: [RFC PATCH 0/2] USB: DTS: allow suggesting busnumber for
 platform USB bus via DTS alias
Message-ID: <20181211224242.GA21950@bogus>
References: <20181127165705.GA13460@lagavulin.indurad.x>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127165705.GA13460@lagavulin.indurad.x>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 04:57:05PM +0000, David R. Piegdon wrote:
> Hi,
> 
> on our embedded systems we rely on systemd's persistent netdev names.
> Those currently do not work for USB netdevs that are connected to a
> platform USB bus.
> 
> In https://github.com/systemd/systemd/pull/7273 a systemd patch was
> suggested that would allow exactly this, but it was (rightfully) said
> that numbering of theses busses is not guaranteed. Internally we used
> the patch for a while now, but exactly that has happened with one of our
> platforms across different kernel revisions.
> 
> The following kernel patches allow suggesting a USB busnumber for each
> USB platform bus via a DTS alias, as can be done similarly for many
> other devices.
> In combination with above systemd patch, these changes allow use of
> persistent netdev names also on platform USB busses.

I don't think this is doing what was suggested in the link above. Though 
I'm not familiar with what ACPI provides. Userspace would still be 
relying on the Linux enumeration numbering. How would userspace tell if 
that numbering is persistent or not other than looking at the DT itself 
(which isn't a good solution either)?

I don't understand though why userspace needs anything more that the mac 
address of a net device to provide a persistent name.

Rob
