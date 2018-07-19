Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95E3ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:26:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632F920856
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 03:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aHTjcFWa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632F920856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbeGSEHV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 00:07:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:46856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbeGSEHV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 00:07:21 -0400
Received: from dragon (unknown [45.56.152.101])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB14720854;
        Thu, 19 Jul 2018 03:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531970784;
        bh=H1xyYKMKIeMbsgxyV2t+jQ1UaZPlIOJot2EKaqD4a5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aHTjcFWaJ7NSetKx+ffgZ7xUPviPUxtY1JHcZNn8Sj6BuiquyK0U4mBftwXFIpCYF
         xuS9tmtidFP9SsekyY38nHl6vXjQ6kt1NZ5Kn9EFiJP5gP5SMB44nR94fTiqTC81VG
         ET6QKGz8CuhnB01V65+m38P8t/is5hEMeNMyBlAQ=
Date:   Thu, 19 Jul 2018 11:26:10 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Anson Huang <Anson.Huang@nxp.com>, s.hauer@pengutronix.de,
        kernel@pengutronix.de, fabio.estevam@nxp.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] ARM: dts: imx7d: add missing OPP property for cpu0
Message-ID: <20180719032609.GV4576@dragon>
References: <1531896889-21377-1-git-send-email-Anson.Huang@nxp.com>
 <20180719032002.GT4576@dragon>
 <20180719032454.2bxp4eil7lfaijji@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180719032454.2bxp4eil7lfaijji@vireshk-i7>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 19, 2018 at 08:54:54AM +0530, Viresh Kumar wrote:
> On 19-07-18, 11:20, Shawn Guo wrote:
> > On Wed, Jul 18, 2018 at 02:54:49PM +0800, Anson Huang wrote:
> > > Commit b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> > > added "operating-points" property for all CPUs, but missed i.MX7D's cpu0,
> > > this patch adds it.
> > > 
> > > Fixes: b97872d4eb22 ("ARM: dts: imx: Add missing OPP properties for CPUs")
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > 
> > In general, when you send a patch fixing a commit, you should have the
> > author of that commit copied.  I added Viresh here.
> > 
> > It looks like a wrong fix to me.  It seems that commit b97872d4eb22
> > shouldn't change imx7d.dtsi at all.  So the correct fix would be
> > reverting the change on imx7d.dtsi, @Viresh?
> 
> Wow! Can't believe such a stupid mistake got merged and no one noticed
> :(
> 
> Please revert that patch and I will resend the right fix Shawn.

Please just send a incremental fix patch for that commit.

Shawn
