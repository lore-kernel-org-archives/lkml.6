Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F92C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC7AA206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 10:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547636191;
	bh=EmVv4PRqc59GVua72fpWk4YU37fiYG4eLvUoBNf6s/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yRsTQkAxj+3924TvMYw+GfCPoN2JaYap0yXV+sZ9Gkl7Tt1GLoOGA5l5VaS7DnqDz
	 3HQKuZz9sDz+tFDW83n8sIY/4uuxj3ywwhAmR2x7M2r7QOxTUt+PiSaxVpkrvWZQ5v
	 rAGsUpzs4/V+X3sV7N8Nl4Zh1G4dhEsiaDDcu1SQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392258AbfAPK4a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 05:56:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:60800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392245AbfAPK41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 05:56:27 -0500
Received: from dragon (61-216-91-114.HINET-IP.hinet.net [61.216.91.114])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 17462206C2;
        Wed, 16 Jan 2019 10:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547636187;
        bh=EmVv4PRqc59GVua72fpWk4YU37fiYG4eLvUoBNf6s/8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tfmS5C5RNv1FdUMRVbW5SdxFFa7l37bl6Ve10XPriQ026BXh1iY8Kvw97Gc14+d0v
         GiEgeDom+xK0L+DRZgJVlQi5U+jefFnWVDPvWJ+zA2BPfysxFOdj8414V4s1/jQp3k
         NPf1xkD8uJNdTX8ZpgWYXSpgQIBHgZPl7WUWX8r8=
Date:   Wed, 16 Jan 2019 18:56:01 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Ioana Ciornei <ioana.ciornei@nxp.com>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ioana Ciocoi Radulescu <ruxandra.radulescu@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
 platforms
Message-ID: <20190116105559.GM15808@dragon>
References: <1545406240-3061-1-git-send-email-ioana.ciornei@nxp.com>
 <1545406240-3061-2-git-send-email-ioana.ciornei@nxp.com>
 <20190112024725.GO32649@dragon>
 <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR0402MB2800E8F9F1884EB0669EE9F0E0820@VI1PR0402MB2800.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 16, 2019 at 10:02:01AM +0000, Ioana Ciornei wrote:
> > Subject: Re: [PATCH 1/3] arm64: dts: add dpaa2-console node for DPAA2
> > platforms
> > 
> > On Fri, Dec 21, 2018 at 03:31:09PM +0000, Ioana Ciornei wrote:
> > > Add the dpaa2-console device tree node for the following
> > > DPAA2 based platforms: LS1088A, LS2080A and LS2088A.
> > >
> > > Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> > 
> > DTS patch generally goes to the last in a series.
> 
> Should I resend this with the DTS patch the last?

You do not have to resend the series only for this.  It's pretty much a
suggestion for future posting.

Shawn
