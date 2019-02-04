Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E196C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E982147A
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 08:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549269040;
	bh=biANsA5tEKI+/OpjvNPbdWR2u5RNR7VIMA1BdleBaos=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wAzxY/Vr8Nvw/4AmHDLioT/jrkQtf3/0otCZfN2Zy/ZPo4EX9K/d+/9oEbOrNlnjp
	 W5ewIQ5dJM1HK9HzVTmZr/vaIpLcPgogYha31yCz6AL3INJL1Y66TFJ4WPmaalu5sf
	 WE3ynHmDFG9KnuuoQxt0xiWA9vK9eS0BEDL0zFXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728282AbfBDIai (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 03:30:38 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35620 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBDIah (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 03:30:37 -0500
Received: by mail-lf1-f66.google.com with SMTP id l142so1694895lfe.2;
        Mon, 04 Feb 2019 00:30:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+50uRYFZwEAUM0hQa1bPoTyv103SwogYd4svn7yNTLg=;
        b=RsK9rucUPjp0K83TzXQJsP2S3EBbzDYbFksXnx2AIRM77e4BfV1hoDc6YMoMiR7o6T
         JMAbxhhp6MvDhGHs3846x0czsSP4m8SMrsvlVONy3mtHoNaYyBulbVq5mB3tegvAlImS
         qyZX7YBRFnF0AUpdsIuhk5Ycw0oHYX56ONQVPsoLPWu1HHsYIexudFb3JRe1GHyn2/Bb
         LZ8R73avRa9PNf+1uxIHVZGImYAgCUII5xBe3E9YXnNBJDnBd/0sDgeHcton4NBvAl8Q
         i6Nwta37BtMhTmH6duWBCJX+EdGSV8HkU88/etoWhc9cOB43rBMGdEOfm5XBIFxMeL6x
         hrGw==
X-Gm-Message-State: AJcUukfkZfxgQ4rCqctrYWPJIa993Dl0fmnZXt4miokT2EzqjRJQPO+f
        o08XZOYfbcY3I9AXiuH89VQ=
X-Google-Smtp-Source: ALg8bN7kyR1FV3U0BuZqc6CKZhbe62QJ5FJFOCeSD+tlwgReSZkB6nVdt97nm9wzhy4SxTtc6b/K7g==
X-Received: by 2002:a19:c115:: with SMTP id r21mr38239917lff.144.1549269035284;
        Mon, 04 Feb 2019 00:30:35 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id y82sm6356lfd.17.2019.02.04.00.30.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Feb 2019 00:30:34 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gqZeC-0004hi-MU; Mon, 04 Feb 2019 09:30:32 +0100
Date:   Mon, 4 Feb 2019 09:30:32 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org,
        tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm: dts: gta04: add gps support
Message-ID: <20190204083032.GB4686@localhost>
References: <20190131180640.14480-1-andreas@kemnade.info>
 <20190131180640.14480-3-andreas@kemnade.info>
 <20190201100416.GD3691@localhost>
 <20190201200630.2efc9eef@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201200630.2efc9eef@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 08:06:30PM +0100, Andreas Kemnade wrote:
> On Fri, 1 Feb 2019 11:04:16 +0100
> Johan Hovold <johan@kernel.org> wrote:
> 
> > On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
> > > The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> > > which one is mounted so use the compatibility entry for w2sg0004
> > > for all which will work for both.
> > > 
> > > Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> > > ---
> > > Changes in v3:
> > > - converted to a patchset
> > > - added vcc-supply
> > > 
> > > Changes in v2:
> > > - some s/gps/gnss/
> > > - not added vcc-supply because the regulator is not modelled
> > >   in dts at all
> > > 
> > > w2sg0004 bindings are in next-20190129
> > > 
> > >  arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
> > >  1 file changed, 14 insertions(+)
> > > 
> > > diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> > > index 02d8274a2f47..4ea0f7dc37c6 100644
> > > --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> > > +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> > > @@ -320,6 +320,12 @@  
> > >  		>;  
> > >         };
> > >  
> > > +	gps_pins: pinmux_gps_pins {  
> > 
> > s/gps/gnss/ would be more consistent, but whatever.
> > 
> well, gps is already in the file at another place. So it is a bit
> inconsistent in any case, without further cleanup. If someone comes
> up with a strong opinion here I would of course change it.

Up to you. As long as the gnss node is named "gnss" I don't have a
strong opinion on the other names (as long as they follow the spec of
course).

Johan
