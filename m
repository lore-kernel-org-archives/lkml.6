Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1BCC282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:41:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A92D12084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 10:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548067304;
	bh=6iwYf6hcNTv39sTRXQs64i6Rh6fBxySBg+z9AcnULdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kLAA4un34BDiMi9esh7KDPra+BnlmTMSg0O94ROzNw0dA2txoKcGUJxsVYajDpFMf
	 kQrkWn0x3gFfLS2FjDiYoXhfFMaK15Z4qGtDSpj5pPBZO729ssnRtKQuqPs6HcRh79
	 VA7TewExfvxBSglCqcHhJSyFMA7BUUWoYQZLvMlo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727442AbfAUKln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 05:41:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:42158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726670AbfAUKlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 05:41:42 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6524F20663;
        Mon, 21 Jan 2019 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548067302;
        bh=6iwYf6hcNTv39sTRXQs64i6Rh6fBxySBg+z9AcnULdE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sjmSMrfzlw+qFiqlrU64iahDZX3o3hyjg8L5Sic0IauWg7OwvCZjoS9PkIvDi2BSY
         iXwecyesSjWIyNyNRbW3+Vs/F6o5h+oqiWioNe56ZZ6iUgSRpNu9RkqjZB3RKp+2N/
         0u1K8sATnNzFBgctGcvKBSCblYlaK06dZOMLNTgs=
Date:   Mon, 21 Jan 2019 11:41:39 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     stable@vger.kernel.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] arm64: dts: marvell: armada-ap806: reserve PSCI
 area
Message-ID: <20190121104139.GA16002@kroah.com>
References: <20181221164503.5128-1-xypron.glpk@gmx.de>
 <874lagpycx.fsf@FE-laptop>
 <2c42946c-8bc1-d4cf-b6af-da54aba61c94@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c42946c-8bc1-d4cf-b6af-da54aba61c94@gmx.de>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 20, 2019 at 03:14:05PM +0100, Heinrich Schuchardt wrote:
> On 1/10/19 12:04 PM, Gregory CLEMENT wrote:
> > Hi Heinrich,
> >  
> >  On ven., déc. 21 2018, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
> > 
> >> The memory area [0x4000000-0x4200000[ is occupied by the PSCI firmware. Any
> >> attempt to access it from Linux leads to an immediate crash.
> >>
> >> So let's make the same memory reservation as the vendor kernel.
> >>
> >> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > 
> > 
> > Applied on mvebu/fixes
> > 
> > I added a comment about the use with a mainline /U-Boot
> > 
> > Thanks,
> > 
> > Gregory
> > 
> > 
> 
> 
> Hello Greg,
> 
> please, consider
> 
> arm64: dts: marvell: armada-ap806: reserve PSCI area
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v5.0-rc2&id=132ac39cffbcfed80ada38ef0fc6d34d95da7be6
> 
> for backporting to v4.19.
> 
> This patch is needed to run Linux on the MACCHIATObin and other boards.

Now queued up, thanks.

greg k-h
