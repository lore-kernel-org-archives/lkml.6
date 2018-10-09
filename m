Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3474DC64EAD
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7350214D5
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 11:02:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7350214D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=the-dreams.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbeJISSi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 14:18:38 -0400
Received: from sauhun.de ([88.99.104.3]:49246 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726415AbeJISSi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 14:18:38 -0400
Received: from localhost (p54B336A7.dip0.t-ipconnect.de [84.179.54.167])
        by pokefinder.org (Postfix) with ESMTPSA id 67FDB2C310A;
        Tue,  9 Oct 2018 13:02:11 +0200 (CEST)
Date:   Tue, 9 Oct 2018 13:02:10 +0200
From:   Wolfram Sang <wsa@the-dreams.de>
To:     Silesh C V <svellattu@mvista.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-i2c@vger.kernel.org, linux-rdma@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-spi@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Lijun Ou <oulijun@huawei.com>,
        "Wei Hu(Xavier)" <xavier.huwei@huawei.com>,
        Yisen Zhuang <yisen.zhuang@huawei.com>,
        Salil Mehta <salil.mehta@huawei.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v3 1/2] Driver core: add bus_find_device_by_fwnode
Message-ID: <20181009110210.i6xphyuy5jkcfaug@katana>
References: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="2kw4ja7bxzg6suol"
Content-Disposition: inline
In-Reply-To: <1539080245-25818-1-git-send-email-svellattu@mvista.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2kw4ja7bxzg6suol
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 09, 2018 at 03:47:24PM +0530, Silesh C V wrote:
> Some drivers need to find the device on a bus having a specific firmware
> node. Currently, such drivers have their own implementations to do this.
> Provide a helper similar to bus_find_device_by_name so that each driver
> does not have to reinvent this.
>=20
> Signed-off-by: Silesh C V <svellattu@mvista.com>

Looks good in general, however:

We recently had this discussion in I2C world about using the parent if
the (logical) device has a NULL fw_node [1]. I don't know if the other
subsystems you modify use logical devices as well? If no, it seems we
need an additional check for the parent in the I2C core only. If yes,
this might be considered in your patchset?

Thanks,

   Wolfram

[1] http://patchwork.ozlabs.org/patch/974584/


--2kw4ja7bxzg6suol
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAlu8iq4ACgkQFA3kzBSg
Kba9zBAAmif214EXlc2zjh1MYjDh1OoEsqplhQXatiWNmmlKVMyiKT3Ly3m4LoKj
q5SC8ML3c0a+QQnG6UEBPDvN71Rtf9c+w+rkHtXJOpVTyyvELZa8G67aKfy41nq0
tb4CSMxFXpImxJC0vSNh2HlkLgIYvlVCjYdelmAard/KMdcgrTjLLbxYLLIDNO50
vHjJm/QHjbtKoJlXIZ+YNf6p+/OCs9gbPZBtrOzyRcD/LxFAtBgTr08dpmMyxCSK
gghR7mL7SuO2fX1vQJNZF5XzxZts09RBEjh6Gcrzmun3709EZWOuPiz1G+1Ezplq
J/SgCQvpWC4T5HX7/yrHp1hhWZdLDIRmcNcfQpfhD/BY4VmQ5ztO+lTNHeuPrk9A
lVI4736ggmQvA+nPLyi8gMD2w8dWY9NPf0W04sAl8Ai1AtNPDcMOrFIkcwsQnvpG
SvOiutxWN2posnQ3DnOHUQKe2fwU077Yr2TOVSdhVcDROAx2mJHsPeDDd2tNDLzc
V6azlnxvdYHYnf+WWKTZCFrGuffAp+6jnD1KkKBhhrrVcCwonlnXZrH1YH0FftKj
bGoUK6si2olqa2vkf0FVjfgS4aBv7dMAujj9jFHWZNt8GuKKmcQ+E2iobbpz0E3Z
C+BmvxhxFZkYEjS4GQLhY1oTZ0lNxZcrAmtB/hvwxrrGk2AeyQ8=
=9ef9
-----END PGP SIGNATURE-----

--2kw4ja7bxzg6suol--
