Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C75DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21A712088E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=bidouilliste.com header.i=@bidouilliste.com header.b="B+h2HpAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A712088E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bidouilliste.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbeGZJQJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:16:09 -0400
Received: from mail.blih.net ([212.83.177.182]:46203 "EHLO mail.blih.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728675AbeGZJQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:16:09 -0400
Received: from mail.blih.net (mail.blih.net [212.83.177.182])
        by mail.blih.net (OpenSMTPD) with ESMTP id be2b78ce;
        Thu, 26 Jul 2018 10:00:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; s=mail;
         bh=sOYkw3A9aEkFzO0q0dZEC1KXWdE=; b=B+h2HpAy4y/ylrRnA0Ri+zU2oKW6
        sOLo1boTUL55RgxQztKtiwEHMqusrqCHDE/px26GdxUpsfr5mlNLm5jC0fiCjMQ3
        jAk1jFgex8LoP/DiNrjrg5quV1fuHaE/TXjpDPI06c2Eq5NZMNSjUnRavHUUC6zJ
        wOxrTWs9FlWcHNY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=bidouilliste.com; h=date
        :from:to:cc:subject:message-id:in-reply-to:references
        :mime-version:content-type:content-transfer-encoding; q=dns; s=
        mail; b=pELAROFxeR2Ewe28QoTano6U4t1zeeyZPwt/pZ7I0DzJbh1eNpAuLAu6
        5rGSI1DIFnBeBljUGdvp6lrpri/vwowWQ58ayEtekLseSOnLHnk2Fhgw337n3KX4
        PcmiKQ4l3IuH7boMSvW51eTRZ4jl3Euv059o4M0DmV4BGLHAqJk=
Received: from skull.home.blih.net (ip-9.net-89-3-105.rev.numericable.fr [89.3.105.9])
        by mail.blih.net (OpenSMTPD) with ESMTPSA id acf3350a
        TLS version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO;
        Thu, 26 Jul 2018 10:00:29 +0200 (CEST)
Date:   Thu, 26 Jul 2018 10:00:28 +0200
From:   Emmanuel Vadot <manu@bidouilliste.com>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Akash Gajjar <Akash_Gajjar@mentor.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>, icenowy@aosc.xyz,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: dts: allwinner: activate spi flash on pine64 LTS
 board
Message-Id: <20180726100028.071eae1c96fbe1e013b871b9@bidouilliste.com>
In-Reply-To: <20180726073138.fexu4nxaamqmrbzb@flea>
References: <Akash_Gajjar@mentor.com>
        <1532587906-5415-1-git-send-email-Akash_Gajjar@mentor.com>
        <20180726072924.bnvljmd2sf6bf5ae@flea>
        <20180726073138.fexu4nxaamqmrbzb@flea>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; amd64-portbld-freebsd12.0)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 Jul 2018 09:31:38 +0200
Maxime Ripard <maxime.ripard@bootlin.com> wrote:

> On Thu, Jul 26, 2018 at 09:29:24AM +0200, Maxime Ripard wrote:
> > 1;5202;0c
> > On Thu, Jul 26, 2018 at 12:21:46PM +0530, Akash Gajjar wrote:
> > > This board has SPI flash. add spi flash support in device tree.
> > > Tested on pine64 LTS.
> > > 
> > > Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> > 
> > Queued for 4.20, thanks!
> 
> No, sorry, I ended up droping that patch.
> 
> You mention that the Pine64 LTS has an SPI flash, yet you change the
> sopine baseboard dts. Why is that?

 There is still no dts for Pine64-LTS (Andre latest serie address that).
 Note that the sopine.dtsi already have the SPI node, the patch is
present in sunxi/dt64-for-4.19

> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com


-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
