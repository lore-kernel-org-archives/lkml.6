Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AE8BECDFBB
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11C702084E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 02:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=aj.id.au header.i=@aj.id.au header.b="Fpoqz7zc";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="B6DxDb3e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C702084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aj.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGSDJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 23:09:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44723 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730329AbeGSDJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 23:09:10 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id DEC3C21BA9;
        Wed, 18 Jul 2018 22:28:23 -0400 (EDT)
Received: from web5 ([10.202.2.215])
  by compute4.internal (MEProxy); Wed, 18 Jul 2018 22:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aj.id.au; h=cc
        :content-transfer-encoding:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=sQwRwOuagXf0xfCpdiTKeB4RhjIMJ
        R2Fz4r9mfvU6ss=; b=Fpoqz7zcVRoJYHAtH9AV3S1RDJWWnDmMAWaMDO+CogxqD
        /hbgWIUpyF1Ty0W33JhhVs07CW4EcXVWwWEZMJmNDNdIwVa8PiWhSB0cHa8Fh1Lq
        sm6KuJVAT2HrITnjYnYaonnQC1JNskJMZk5z2Tgp1KkNb6WID7ue3KILYykA49pU
        m+qfFUP0dT9DU3vTuUIF3i4Zb9NbK9eNioMiIOQCG7YUKFuqm5aEihvS5iQCGs8+
        flOZiyryY72PKs5ZVal9rvoOgFfP4f1lzTuFTue12HFNSn2Q47P9iPdcHHjAqu4O
        IKBepWFdnml7T+0ABdqEy+wymIIjzG8hYnqphIm1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=sQwRwO
        uagXf0xfCpdiTKeB4RhjIMJR2Fz4r9mfvU6ss=; b=B6DxDb3erB3/LNGJa+0vWV
        q9EsnnYdYlHmKfqGWFJlym/k/qLNofpo1/3EGOkjXd7xSVKZsFzQfSh1tWq2+6O2
        uxYNwP4WTkx85vQ0SRT45sLGedHgPuAwgbBj1ftY8OoCli9k+VhLSzcD7zXwNV98
        frnD07OU1xvbLmPXea1obUO1gdAv3StKu3OtZNDByMRNksXXvA0v4UQ/lv0FMrdL
        q/pIrkhC2N2bLcaKekSXVWfvycoT5F3eh79YX/zAbQkhjTI7Fk8b16CLVc5e8NV6
        biSf52CyyX71LezhKGZ+3B65GKkyU0b8keOypWmmEvEZ6OpYFHAnyinIITZiomsg
        ==
X-ME-Proxy: <xmx:RvdPW3MTPo6uuqT1BNZKEtfMXrXVb6-vycKxjLMRhv3yj_uh5oGw8w>
    <xmx:RvdPWz8v7-0x7d-evmbiXsIXQwUTBomCYMYGrteYQQeY5NTDGSLP1Q>
    <xmx:RvdPW6iiwAVb80HBpDS4xr7jmSazjznQmhT6Yat2DTrFgKa3PzP9FA>
    <xmx:RvdPW2r3iblJinR14lNm2VyywFhFJn7L1FC3U3EwcGyh0hdq0H2V1w>
    <xmx:RvdPW0MrZ5UoAc8ABnQkA4OlhpMSfpTintvy4RZQB1OdLpqM_LZXfg>
    <xmx:R_dPW4TKRCQwAWn9cc2DidKXTAaz_6NoKw020WScl66OqiJr-Gd6aA>
X-ME-Sender: <xms:RvdPW_1_Yj8SeIs4ZrgL3YCW_JvjJp5h6Kc6MYslNf7csu3DJiYHnQ>
Received: by mailuser.nyi.internal (Postfix, from userid 99)
        id 632C69E0D2; Wed, 18 Jul 2018 22:28:22 -0400 (EDT)
Message-Id: <1531967302.2140539.1445583600.0F5ED287@webmail.messagingengine.com>
From:   Andrew Jeffery <andrew@aj.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Rob Herring <robh@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Eugene.Cho@dell.com, a.amelkin@yadro.com,
        linux-kernel@vger.kernel.org, Joel Stanley <joel@jms.id.au>,
        stewart@linux.ibm.com, OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Mailer: MessagingEngine.com Webmail Interface - ajax-e74bb3a0
In-Reply-To: <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
Date:   Thu, 19 Jul 2018 11:58:22 +0930
Subject: Re: [RFC PATCH v2 1/4] dt-bindings: misc: Add bindings for misc. BMC
 control fields
References: <20180711053122.30773-1-andrew@aj.id.au>
 <20180711053122.30773-2-andrew@aj.id.au>
 <20180711200450.GB17291@rob-hp-laptop>
 <1531356830.3551458.1437853280.551CA8C5@webmail.messagingengine.com>
 <CAL_JsqKpXxR4t_-3BOy-0mFePXkaSck_4PfHRD=OZQ-_-T5P=w@mail.gmail.com>
 <b6ced4cad4d7ff78330181b2c893855c23103953.camel@kernel.crashing.org>
 <1531463489.747186.1439263128.075AECE1@webmail.messagingengine.com>
 <CAL_JsqLZo-=7UkuvvUFYdCR4asBBiWyC=Q1ryH=-HLU6vzf9tA@mail.gmail.com>
 <ece91112ecfdc7218184c4c4519e455cf9397e11.camel@kernel.crashing.org>
 <CAL_JsqL_bMXLAA0091-g8PmhXR5g5Pf2y2=ey7Ss5ofHm46sWw@mail.gmail.com>
 <c69d0e7c3a95d83da87b566a62619462671a233b.camel@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I agree
> > that not using /dev/mem is a good thing, but there are several ways
> > you could do that independent of any DT binding.
> 
> Such as ? The only other option is to have one or more kernel drivers
> that have built-in the precise and complete list of those tunables that
> need to be exposed.
> 
> It's not impossible, but I worry that it's not going to scale terribly
> well, and that vendors will constantly "fork" that driver to add
> different things to that list.

Picking on that last point, "different things" doesn't necessarily mean "different fields in the SoC" (though it may). We could just need to use different initial values for the fields already described. So taking that into account, the field descriptions could vary wildly from platform to platform - where "platform" here is the combination of the BMC, its host system, and the host system's required configuration - not just referring to the BMC in isolation.  That in turn may cause a fork of the driver (changes that are incompatible with other platforms), or not scale terribly well as Ben suggests.

The initial value concept can help reduce the impact on userspace as userpace may no-longer need to care about it, so I think it's a desirable property. With respect to devicetree, the field definitions will stay in the SoC dtsi, but the initial values would be described on a per-platform basis in the dts.

> 
> I might be wrong here, so I'd like for Eugene (Dell) and Alexander
> (Yadro) to chime in, but experience with BMCs has shown that we
> regularily , as we add a feature or rewrite something, need to find
> another new magic SoC tunable the HW manufacturer hid somewhere that
> will make our stuff work.
> 
> > > Now, updating the device-tree in the board flash with whatever vendor
> > > specific information is needed is a LOT easier than getting the kernel
> > > driver constantly updated. The device-tree after all is there to
> > > reflect among other things system specific ways in which the SoC is
> > > wired and configured. This is rather close...
> > 
> > Sadly, updating my kernel is easier than updating my PC firmware
> > (though packaged firmware on my current laptop changes that). I can
> > assure you that ARM boards are generally much worse in that regard.
> > BTW, you may want to pay attention to EBBR[1][2]. Not sure how much
> > you care for BMCs, but there may be some interest.
> 
> You are conflating your host kernel and your BMC here. The BMC kernel
> is part of the "firmware", as is its DTS and the BMC userspace.
> 
> (Again this isn't the host DTS, this is the BMC DTS).
> 
> They get all updated together. My point isn't about the ease or
> difficulty for a *user* to udpate their BMC, in that case the solutions
> above are equivalent.
> 
> The point is from a system vendor perspective. A system vendor using
> OpenBMC will *customize* their BMC build in various ways. Typically
> they *will* have a custom DT since this is what represents their
> specific system and they will have some specific userspace bits.
> 
> However, we are trying very hard for them *not* to fork the kernel, and
> if possible move OpenBMC towards a fully upstream kernel (still working
> on getting all the SoC drivers cleaned up and pushed up but it's moving
> in the right direction).
> 
> So from a vendor perspective, such as us IBM, we *alread* have custom
> DTs and customized userspace, that's part of the normal flow of
> deploying a BMC.
> 
> However, we are trying *NOT* to have a custom kernel (and we don't, at
> the moment there is an OpenBMC kernel accross vendors, though it's not
> *yet* fully upstream).
> 
> So if the solution proposed is prone to requiring frequent changes to a
> kernel driver, that solution makes the above a lot more difficult and
> will encourage vendors to keep forking kernels.
> 
> This is what we are trying to avoid.

Well described. Thanks Ben.

Andrew
