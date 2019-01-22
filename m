Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 665CFC37124
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2141721721
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 01:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548119674;
	bh=p0JQnfeEP4mkw1em73uUqAiW6/YjHu7GJrbU3dr2msA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=KjD0F0yUtHhA5nv6rU8J1AyW39DSh5FJ1FriwSlbeg1CGhyraVzLvj80aD51aMYbr
	 44nkx/utxLHAs22Lc7xxwJJiQ0Ccs7iOc572ZwUtOD5oOi2p0mZb25FKcrudmRgZea
	 Yv8JueWUBEqAlz3uwpwlhYIJ5Pd0nGcaEDd7mnAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbfAVBOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 20:14:32 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42001 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfAVBOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 20:14:31 -0500
Received: by mail-oi1-f194.google.com with SMTP id w13so16065361oiw.9;
        Mon, 21 Jan 2019 17:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wgJ1G6St49wbVw0VgIAlB9lWWvpxL3qtTHgYiuXYdZA=;
        b=sG00dWvFbTE6HrsHvk1IsaSFsR2J5B/pDWIFMo+1EPO4q1sgU5my05E9Y0W0cY7OEY
         MB3Mh4n7BNgiXMxcyU8jMsJ6QjPTiUBcheDqdGgCHfn16TQbM+76ncSwvwCTsmXhQKVy
         N70BbydEReXF3wmsyN6jr1utd/kiW/qnoE15LfK+FF1N6rl3WldAaT7M+bGERUUMtVyv
         CbpK3Q/mKPbUbxFFElbo+8JqS1ktSM+k77BpG09qZw8KfOAbvfiKbPApfyPER9ZeVpN+
         wMkVGU/SwH44/iDr1fqSA4nkMtXWKSvYC40SToIyHmRjsrJ2Gks8Af4IO307WW01B3Sc
         Lf/Q==
X-Gm-Message-State: AJcUukcySbY4iIBwMwKT7Yw2fDbwTORZK9yx/Xqphh3MlIfjgJ/KdkPj
        PbvyQy+UXMpng64bLKJsuA==
X-Google-Smtp-Source: ALg8bN4utbZqAhmfqs4+0qX8BONSTaIcX2rXacBWk9gOxC6S+ByTMVo1nzSwvVox8k0m1XZRvo8fkA==
X-Received: by 2002:aca:720a:: with SMTP id p10mr6723543oic.169.1548119670567;
        Mon, 21 Jan 2019 17:14:30 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 30sm6170166ots.52.2019.01.21.17.14.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 17:14:29 -0800 (PST)
Date:   Mon, 21 Jan 2019 19:14:29 -0600
From:   Rob Herring <robh@kernel.org>
To:     Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Cc:     Biju Das <biju.das@bp.renesas.com>,
        Simon Horman <horms@verge.net.au>,
        Magnus Damm <magnus.damm@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thierry Reding <treding@nvidia.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Johan Hovold <johan@kernel.org>,
        Lukasz Majewski <lukma@denx.de>,
        Michal Simek <monstr@monstr.eu>,
        Michal =?utf-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Ben Whitten <ben.whitten@gmail.com>,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Chris Paterson <Chris.Paterson2@renesas.com>,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ebiharaml@si-linux.co.jp
Subject: Re: [PATCH 01/11] dt-bindings: Add vendor prefix for Silicon Linux.
Message-ID: <20190122011429.GA3176@bogus>
References: <1547663874-29411-1-git-send-email-fabrizio.castro@bp.renesas.com>
 <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547663874-29411-2-git-send-email-fabrizio.castro@bp.renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Jan 2019 18:37:44 +0000, Fabrizio Castro wrote:
> From: Biju Das <biju.das@bp.renesas.com>
> 
> Add Silicon Linux to the list of devicetree vendor prefixes.
> 
> Website: http://www.si-linux.co.jp
> 
> Signed-off-by: Biju Das <biju.das@bp.renesas.com>
> Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
