Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1585BC37125
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:11:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FDB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 23:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548112273;
	bh=SdfkfeL0Hx9UK1yOgwR+2v7dBrhtwwld04EGUa2LR5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ytYUHeIM86xANRiQynC2AD7a+ySr3Ul1Px3f8s67YUk701vim/hyIKF5K4Xy6Qj8Z
	 CxHTXTpp0aavDt6bTlru5qwxuUkSJaCMTZvV9ST9Q7iijrlEorxn0moRrF2I/C2SBv
	 QvLOr7V3V/mCh21H7CGWiayU8OWRirY9taiy1gRA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727931AbfAUXLJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 18:11:09 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40758 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfAUXLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 18:11:08 -0500
Received: by mail-oi1-f195.google.com with SMTP id t204so15880695oie.7;
        Mon, 21 Jan 2019 15:11:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NwNeLn0NpBVarhMV52VLX7e0pWYxS9hGh57kuH7rECo=;
        b=dfpxx+zB2XrTQiAJIV4InP7GDgek68mJUWjQVxvrOHtpFZXbWnVoLVmHwC7rr/loh3
         641jtQRBzOMooXyh5xl24onN4gJMuncbUba5uPiRvmCBGAZ5TxCJwnMl8d69e0sP1zwM
         48JFBsanxIGK7GACfKg6j6rg7b7quFVE772Be8KhCFkDRIeOiCb8Gb8X1v/n3OKcmytY
         uKllrcI8LHbs0bQHXa0HWMNCg9vTRmDm9lSZKgW7EEMg9mywfYX+CkjX6T0T3AvtEbMZ
         ICQcpQuMIZFR3wOECin4gejlwDhrQ6rx8NDn51jPTQwZbUCgrnPvK5+ouzUh+HCux9ik
         5DhQ==
X-Gm-Message-State: AJcUukel2lAzvvQzLxcMtjpH+ouMOHO5bcYM1c1wTsvzWmBGZR8imdqt
        l3w4kkWWbI0TWKnHHr25atPCVvgZmA==
X-Google-Smtp-Source: ALg8bN6p+y2XEyno1sJgniFlSuloOmBoju0jcHaQK3PjbzOpfgdfm1vh2Q3q60fbYjwLzMxepeOmtQ==
X-Received: by 2002:aca:abcd:: with SMTP id u196mr7058419oie.29.1548112267236;
        Mon, 21 Jan 2019 15:11:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id 30sm6047743ots.52.2019.01.21.15.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 15:11:06 -0800 (PST)
Date:   Mon, 21 Jan 2019 17:11:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com, linux-pwm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Praveen Kumar B <praveen.b@broadcom.com>
Subject: Re: [PATCH 1/3] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-kona
Message-ID: <20190121231105.GA928@bogus>
References: <1547184076-20521-1-git-send-email-sheetal.tigadoli@broadcom.com>
 <1547184076-20521-2-git-send-email-sheetal.tigadoli@broadcom.com>
 <20190111204801.2ytdeblcai7lg3on@pengutronix.de>
 <f1ec3121-a8e7-a1c0-008a-ea4ae6028157@broadcom.com>
 <20190112150515.i7mwq7rtd62wlifh@pengutronix.de>
 <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <faadc46d-94b5-a32c-79ae-4206fbc26608@broadcom.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 04:14:21PM -0800, Scott Branden wrote:
> Hi Uwe,
> 
> On 2019-01-12 7:05 a.m., Uwe Kleine-König wrote:
> > Hello Scott,
> > 
> > On Fri, Jan 11, 2019 at 01:28:45PM -0800, Scott Branden wrote:
> > > On 2019-01-11 12:48 p.m., Uwe Kleine-König wrote:
> > > > On Fri, Jan 11, 2019 at 10:51:14AM +0530, Sheetal Tigadoli wrote:
> > > > > From: Praveen Kumar B <praveen.b@broadcom.com>
> > > > > 
> > > > > Add new compatible string for new version of pwm-kona
> > > > > 
> > > > > Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
> > > > > Reviewed-by: Ray Jui <ray.jui@broadcom.com>
> > > > > Reviewed-by: Scott Branden <scott.branden@broadcom.com>
> > > > > Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
> > > > > ---
> > > > >    Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
> > > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > index 8eae9fe..d37f697 100644
> > > > > --- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > +++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
> > > > > @@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
> > > > >    This controller has 6 channels.
> > > > >    Required Properties :
> > > > > -- compatible: should contain "brcm,kona-pwm"
> > > > > +- compatible: should contain "brcm,kona-pwm" or "brcm,kona-pwm-v2"
> > > > Is v2 used on a newer generation of kona SoCs? On i.MX these variants
> > > > are usually named after the first SoC that came with the new variant. Is
> > > > this sensible here, too?
> > > It doesn't make as much sense here as different revs of the IP block are
> > > picked up based on various decisions.
> > > 
> > > A new SoC could decide to use an old version.
> > IMHO this is no reason to not use the name of the oldest SoC with this
> > variant. I don't know how the SoC names are in the broadcom family, but
> > if they were (in order of age, oldest first):
> > 
> > 	ant
> > 	bear
> > 	crocodile
> > 
> > and ant and crocodile use the same IP block we would have
> > 
> > a) with v1, v2:
> > 
> > 	ant:
> > 		compatible = "brcm,kona-pwm-v1";
> > 	bear:
> > 		compatible = "brcm,kona-pwm-v2";
> > 	crocodile:
> > 		compatible = "brcm,kona-pwm-v1";

Version numbers can be fine, but generally only as fallbacks as even the 
same IP version can be integrated into an SoC differently.

The other issue with versions is they should be meanful such as 
corresponding to version tags in IP repos. Often, I'd guess anything 
with a 'v1' is just what some s/w person made up. Of course, we only 
can really know that for opensource IP or programmable logic IP.

If you do use versions, document what the versioning scheme is.

> > 
> > ; and
> > 
> > b) with the SoC naming:
> > 
> > 	ant:
> > 		compatible = "brcm,kona-ant-pwm";
> > 	bear:
> > 		compatible = "brcm,kona-bear-pwm";
> > 	crocodile:
> > 		compatible = "brcm,kona-crocodile-pwm", "brcm,kona-ant-pwm";

This is the recommended practice.

> > 
> > (If you want, drop "brcm,kona-crocodile-pwm", but keeping it is more
> > defensive.)

Generally, you should have "brcm,kona-crocodile-pwm" in case there's 
some difference found later. Then you can support the bug or feature 
without a DT change.

> > 
> > I like b) (with "...-crocodile-...") better than a). crocodile using
> > "...-ant-..." is not more ugly than crocodile using "...-v1". This is
> > also a tad more robust because if broadcom releases kona-dolphin and
> > someone finds a minor difference between the IPs used on ant and
> > crocodile it depends on the order of these events who gets v3, while
> > with the SoC naming the result is clear.
> > 
> > (OK, and given that "brcm,kona-pwm" is already fixed, both approaches
> > need slight adaption, but I guess you still get what I meant.)
> 
> Thanks for your thoughts and explanation.
> 
> It is unfortunate devicetree has no proper guidelines or documentation on
> 
> binding naming.  In the interest of getting this upstream we can name it

Surely we've captured that somewhere...

> 
> "brcm, omega-pwm".  We can drop kona from the binding name as that
> architecture
> 
> is really no more - only IP derived from it is - hence the name kona-v2
> previously.
> 
> > 
> > Best regards
> > Uwe
> > 
> > 
> Cheers,
> Scott
