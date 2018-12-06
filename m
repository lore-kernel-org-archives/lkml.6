Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D09C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1EE2146F
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544128213;
	bh=rUZJ2vK8aAMnT+hvSY2coPeITsasyRxkM+He3XY+Ly4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LGo4xdMmmUGirYiHcrnGm0eDbd66ApzpWgEUVhnm28ZnQtZmUgxNI/pT9fKX6LlU+
	 EgG2wNqBvAQdqujhktCVLAWe1ctXlFQIqwTwuFSRWGwwu4Cl1tEYwySoC9jq53JErv
	 ez4oyI4FjYjiFD2yemJA0KTnBQT5LEOdVoS7Ifms=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C1EE2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726096AbeLFUaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 15:30:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:43816 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFUaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 15:30:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=uu0YAyYEY643TdPRgWmAazr8rnR98z/B40PCWyaIBew=; b=Xp+np2u7RM6rG0Qw2EL4rocPb
        bI7CqIr31ebzaMMymu5Gve8N7vpum7popVYA9MlS7E/ilKo0uinzlfY0tOzA3sZHKTAaz7sUH8LeW
        s/Hf4ZbuQ1OwTjKPw5wF9BXd9lGPG1AdHhD7PEQ4DcYztcZUkJlwwa2QVYtWv4UEZvKVk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gV0HU-0001jG-Fd; Thu, 06 Dec 2018 20:29:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0FAEE11252F7; Thu,  6 Dec 2018 20:29:56 +0000 (GMT)
Date:   Thu, 6 Dec 2018 20:29:56 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Vignesh R <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "computersforpeace@gmail.com" <computersforpeace@gmail.com>,
        "frieder.schrempf@exceet.de" <frieder.schrempf@exceet.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 0/7] spi: add support for octal mode
Message-ID: <20181206202956.GG3084@sirena.org.uk>
References: <1543826226-30898-1-git-send-email-yogeshnarayan.gaur@nxp.com>
 <20181203101937.7b01a0ad@bbrezillon>
 <214dadd9-859c-ca88-1aff-1c83fcfa3c0b@ti.com>
 <20181205134618.56223758@bbrezillon>
 <VI1PR04MB572646B71C6CB7BAAB4A1E1999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
 <20181206074554.0ec0aecb@bbrezillon>
 <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Wtrm9ATX0sn6fFKv"
Content-Disposition: inline
In-Reply-To: <VI1PR04MB572620BB57CB01A352904BB999A90@VI1PR04MB5726.eurprd04.prod.outlook.com>
X-Cookie: You will be successful in love.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Wtrm9ATX0sn6fFKv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 06, 2018 at 06:49:08AM +0000, Yogesh Narayan Gaur wrote:

> Sorry for ignorance. Did patches needs to be applied by Mark Brown, should I resend the patch series again?
> Also can you please review the series [1] and add your Reviewed-by tag.

As I said in my reply earlier today in the same thread:

| I don't have this any more, it looked like this was stuck behind the
| otehr MTD changes which seemed to have problems.  If someone could
| resend?

so please resend.

--Wtrm9ATX0sn6fFKv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlwJhsMACgkQJNaLcl1U
h9BxUwf/VXXXtAILeX5fLDCHtNVLqX9fo3DPdIf/7DKJkI4KipztYRdwnXr1gyWL
PR//PfTDevtSYPomTWiO4oFiJ6dq8AKfE9HZl4SYBvNVO5W5DQwfa070uPVc/jGh
Il9aC3h1wwb1de9+Y2x+Nfy1YJ485Em7sboYr6Zqra4viyht3EqXRcNup9JKsSUN
IU3/wVOq00MFhxhqdevBClFHBQ8O/YfDQeRRU/yUcrTnr3L+x1OGoGMtkQKb+1M5
jhTQd97LgT0Unlh69N67ofameyu+nVtp1HkgU2JbgF9eKZUqDq3ANGpK7XFRzmpU
hBp/WucrDVjytmprJvexzb4Fz8BDbw==
=rcQD
-----END PGP SIGNATURE-----

--Wtrm9ATX0sn6fFKv--
