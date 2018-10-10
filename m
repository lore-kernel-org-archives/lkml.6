Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B09FC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F6D12086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 11:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="ai8e9Zyj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F6D12086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbeJJTJA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 15:09:00 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:50696 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726562AbeJJTI6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 15:08:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ROQ22YeAzEH+f9FA3bsiBp4avpbqC1fjIQ2vUuWWnf0=; b=ai8e9ZyjSGX50WZkNc9jIr39k
        +fA1jCZ2xWwvMswFptr+8n9v+ymWhs101AlhjxsnZzttg6DMzrCCJNn2qbqktlQRtWw694FvCgAbq
        zCnM/WBiyjybezGaxzv0d11VFDjCjTWpf6MBmLiLQkBTRvfGmYeoWfaxxRY7iVWGs/fR0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gACxH-0007je-I6; Wed, 10 Oct 2018 11:47:07 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 9CA4C1122392; Wed, 10 Oct 2018 12:27:53 +0100 (BST)
Date:   Wed, 10 Oct 2018 12:27:53 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Talel Shenhar <talel@amazon.com>
Cc:     linux-spi@vger.kernel.org, robh+dt@kernel.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ronenk@amazon.com, barakw@amazon.com,
        David Woodhouse <dwmw@amazon.co.uk>
Subject: Re: [PATCH 1/2] dt-bindings: spi: dw: add cs-override property
Message-ID: <20181010112753.GC6294@sirena.org.uk>
References: <1539155293-21750-1-git-send-email-talel@amazon.com>
 <20181010101825.GA6294@sirena.org.uk>
 <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XWOWbaMNXpFDWE00"
Content-Disposition: inline
In-Reply-To: <dbac7f00-e9cc-ddac-5734-9763b5985ead@amazon.com>
X-Cookie: Phasers locked on target, Captain.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XWOWbaMNXpFDWE00
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 10, 2018 at 02:23:40PM +0300, Talel Shenhar wrote:
> On 10/10/2018 01:18 PM, Mark Brown wrote:
> > On Wed, Oct 10, 2018 at 10:08:12AM +0300, Talel Shenhar wrote:

> >> The dw spi controller has an auto-deselect of Chip-Select, in case there is
> >> no data inside the Tx FIFO. While working on platforms with Alpine chips,

> > Why would we ever want to use this behaviour?  It will be broken for any
> > non-trivial SPI message such as those made with multiple transfers
> > anyway.  Why not just unconditionally control it manually?

> This behavior (auto-deselect of Chip-Select) is the default behavior of dw spi controller hw.
> On Alpine chip there is additional behavior added to the dw spi controller hw that allows the sw to disable this behavior.
> This patch allows the dw driver to enable this hw workaround and add the needed sw manual control for it.

If this is a modified IP with additional features then it should be
given a new compatible string rather than having a property - it's not
just configuration of the existing IP, it's a new thing and we may find
there are other quirks that have to be taken care of for it.

--XWOWbaMNXpFDWE00
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlu94jgACgkQJNaLcl1U
h9ApoQf/bZoqz6AzEschlNCke1wLPI98oWSDZLffCSfz9cw1bkrYYqkHInTWRcH6
kDWI4TUt7/y/Vfe2KZOB5B14B05XJh5y4NB21zLNc7BQCbmY1TPNHKb4Q/ums5qp
cPnz+jyFf2wUrRBsu9MZ6G5LbwameBAjy0aw1YlIzvtMHovsT1TCoAcazwCWrZoD
5oe0ZTvJ5L8ht6ML7RQl2nRBVLlTlVmmxqlZwmomnhQ+meM9TkYORREI4AmfM5V1
CUMMwpg8BB7WA5SYhvgtdd4mZIw3uVrY66Xh1gIOq+zrIOxMDwzvva0pHoWYiuPn
oiwyTZEzTYPdn4p3yum2O4EvASuj7g==
=hB4N
-----END PGP SIGNATURE-----

--XWOWbaMNXpFDWE00--
