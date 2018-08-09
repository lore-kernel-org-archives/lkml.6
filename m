Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D1FC46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD15121476
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 09:23:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD15121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbeHILrk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 07:47:40 -0400
Received: from sauhun.de ([88.99.104.3]:43478 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727579AbeHILrk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 07:47:40 -0400
Received: from localhost (p54B3374D.dip0.t-ipconnect.de [84.179.55.77])
        by pokefinder.org (Postfix) with ESMTPSA id A5A126DE8BC;
        Thu,  9 Aug 2018 11:23:40 +0200 (CEST)
Date:   Thu, 9 Aug 2018 11:23:40 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Yingjoe Chen <yingjoe.chen@mediatek.com>
Cc:     Jun Gao <jun.gao@mediatek.com>, devicetree@vger.kernel.org,
        srv_heupstream@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
Message-ID: <20180809092340.rm4ywre543hpejne@katana>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
 <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
 <20180808205752.llowh4bvu2wkuhga@ninjato>
 <1533806000.3347.6.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="s2qszosqjjnv6gdb"
Content-Disposition: inline
In-Reply-To: <1533806000.3347.6.camel@mtksdaap41>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--s2qszosqjjnv6gdb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> I believe the reason for these api is because some arch changed to can
> not do DMA on stack recently. Maybe we should have dma_mapping to bounce

It is not only arch dependent. You can enable virtual stacks in Kconfig,
too.

> buffer like it bounce un-dma-able address for those arch? or we should
> have a common driver API for this, not just for i2c?

I gave a talk about this problem recently and everyone in the room
agreed the best thing would be to have annotated buffers which can be
used kernel-wide. Someone mentioned DMABUF could be a candidate, but I
haven't looked further into that.

So, yes, a bigger solution is needed but I don't see that coming soon,
so I implemented the I2C part for better safety now. I'd be happy to
remove all that again once we have the annotated buffers. But it is an
effort...

Regards,

   Wolfram


--s2qszosqjjnv6gdb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAltsCBcACgkQFA3kzBSg
KbZVzxAAnp4w8fWF7ktxYnYvC9JFp+Buy8W8d+Qz/WV6hTvKLPiS643wtUno8JxV
lVauE1NnUkoWNxeBv/69HERf0xUBPTRhp41dcMTrWsGdcdDfYNalxTnRjwFrsenQ
n4bqifiwvfuaG4VocYFc4q90lKznz0fjQxAUUkFu3w06LbPNyUXKEQW90QVcePGI
Am/uhr4u6OVDOAq99KUNu0dyykS+2zYYsxNQyCskUQl/Le30MVW/UF8+zBS4NePF
ClZDSm+VQfVsMEo0QvEmGWITY2PsUAIIzzXXQXL+vB5cjn6HZWPaOHbuvyTZPS5E
8w2uGICNtlkHBkBW3h7cNIkq2SMF2Q/6eh8iKfo92KsLz+0+44usgilTgt0fmubj
yohov8vh13Cryzw0zlVVWS7v7ffFV0Yz0hpJY55T2TKJAmz32UKyLGb11dNMtB1+
UbKs/wznm/AjGsMeojP8oLqDurOyXwC7nF2Q3c2dsRFK4mCII87T7+zEPYKAV8dE
hOGP+QhBODTg/ZRt/gCJUHYitFz6ye4rQDa1QGezTqf2t5AcpZJEqlEhb6SmG1s/
WN2RHho6lGiknRteeJ/K3Lmt/eRKzTIVN+YoGtgA6dAmndzm3B+PGwvph4kTf98p
l1gmLpenGuAXB9g6IVtndNCtM4cAOTMmq+nYR+St2nIlQJgcdW0=
=juxY
-----END PGP SIGNATURE-----

--s2qszosqjjnv6gdb--
