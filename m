Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A205C6778C
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:15:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A284225584
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 00:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="cEuekzkd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A284225584
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeGBAPM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 20:15:12 -0400
Received: from ozlabs.org ([203.11.71.1]:49023 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752623AbeGBAPK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 20:15:10 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 41Jnnk59lSz9s3q;
        Mon,  2 Jul 2018 10:15:06 +1000 (AEST)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=canb.auug.org.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1530490508;
        bh=4hKVxhNxTCDGyDaNWNCRoGnVFUIb1poRARihZwgfQAE=;
        h=Date:From:To:Cc:Subject:From;
        b=cEuekzkdxBDVPUgQJduIi0mIaD/8HVxSDZnyyavW34llmZvQQk6WPEn1Qv6UM/KYo
         7T4eENfkZbnfs97abyYj33Y8OtQERlQidJLp7OtQtSqiJbET6/X4FnxFnjeOr7vHzr
         7IyrL8hgA6QeAqWdn/fCbJO6ENs5OYktzlDQIiFRNGquIOxe4f6hVpD13cwnJqCqJM
         aPBvb3DT8EAhlr001hwKEIUKlYKAY36CPhlaRJ5qF5WPR81SVFw+fMc39QQblAgZlf
         aOhLK9xymZTJDCopQbSEvQPfbvckk78YUmgtHDVZmpnoEHfbhRalu6eu1OkZEYrO/6
         XTpcYWQntqp0g==
Date:   Mon, 2 Jul 2018 10:15:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jose Abreu <Jose.Abreu@synopsys.com>
Subject: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20180702101506.6ba3de0e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/jODOqf1DtYm7h3NcT_UXHXA"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jODOqf1DtYm7h3NcT_UXHXA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the net-next tree got conflicts in:

  drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
  drivers/net/ethernet/stmicro/stmmac/hwif.h

between commit:

  4205c88eaf17 ("net: stmmac: Set DMA buffer size in HW")

from the net tree and commit:

  1f705bc61aee ("net: stmmac: Add support for CBS QDISC")

from the net-next tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
index 65bc3556bd8f,6e32f8a3710b..000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.c
@@@ -407,16 -407,19 +407,29 @@@ static void dwmac4_enable_tso(void __io
  	}
  }
 =20
 +static void dwmac4_set_bfsize(void __iomem *ioaddr, int bfsize, u32 chan)
 +{
 +	u32 value =3D readl(ioaddr + DMA_CHAN_RX_CONTROL(chan));
 +
 +	value &=3D ~DMA_RBSZ_MASK;
 +	value |=3D (bfsize << DMA_RBSZ_SHIFT) & DMA_RBSZ_MASK;
 +
 +	writel(value, ioaddr + DMA_CHAN_RX_CONTROL(chan));
 +}
 +
+ static void dwmac4_qmode(void __iomem *ioaddr, u32 channel, u8 qmode)
+ {
+ 	u32 mtl_tx_op =3D readl(ioaddr + MTL_CHAN_TX_OP_MODE(channel));
+=20
+ 	mtl_tx_op &=3D ~MTL_OP_MODE_TXQEN_MASK;
+ 	if (qmode !=3D MTL_QUEUE_AVB)
+ 		mtl_tx_op |=3D MTL_OP_MODE_TXQEN;
+ 	else
+ 		mtl_tx_op |=3D MTL_OP_MODE_TXQEN_AV;
+=20
+ 	writel(mtl_tx_op, ioaddr +  MTL_CHAN_TX_OP_MODE(channel));
+ }
+=20
  const struct stmmac_dma_ops dwmac4_dma_ops =3D {
  	.reset =3D dwmac4_dma_reset,
  	.init =3D dwmac4_dma_init,
@@@ -441,7 -444,7 +454,8 @@@
  	.set_rx_tail_ptr =3D dwmac4_set_rx_tail_ptr,
  	.set_tx_tail_ptr =3D dwmac4_set_tx_tail_ptr,
  	.enable_tso =3D dwmac4_enable_tso,
 +	.set_bfsize =3D dwmac4_set_bfsize,
+ 	.qmode =3D dwmac4_qmode,
  };
 =20
  const struct stmmac_dma_ops dwmac410_dma_ops =3D {
@@@ -468,5 -471,5 +482,6 @@@
  	.set_rx_tail_ptr =3D dwmac4_set_rx_tail_ptr,
  	.set_tx_tail_ptr =3D dwmac4_set_tx_tail_ptr,
  	.enable_tso =3D dwmac4_enable_tso,
 +	.set_bfsize =3D dwmac4_set_bfsize,
+ 	.qmode =3D dwmac4_qmode,
  };
diff --cc drivers/net/ethernet/stmicro/stmmac/hwif.h
index fe8b536b13f8,e2a965790648..000000000000
--- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
+++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
@@@ -183,7 -183,7 +183,8 @@@ struct stmmac_dma_ops=20
  	void (*set_rx_tail_ptr)(void __iomem *ioaddr, u32 tail_ptr, u32 chan);
  	void (*set_tx_tail_ptr)(void __iomem *ioaddr, u32 tail_ptr, u32 chan);
  	void (*enable_tso)(void __iomem *ioaddr, bool en, u32 chan);
 +	void (*set_bfsize)(void __iomem *ioaddr, int bfsize, u32 chan);
+ 	void (*qmode)(void __iomem *ioaddr, u32 channel, u8 qmode);
  };
 =20
  #define stmmac_reset(__priv, __args...) \
@@@ -236,8 -236,8 +237,10 @@@
  	stmmac_do_void_callback(__priv, dma, set_tx_tail_ptr, __args)
  #define stmmac_enable_tso(__priv, __args...) \
  	stmmac_do_void_callback(__priv, dma, enable_tso, __args)
 +#define stmmac_set_dma_bfsize(__priv, __args...) \
 +	stmmac_do_void_callback(__priv, dma, set_bfsize, __args)
+ #define stmmac_dma_qmode(__priv, __args...) \
+ 	stmmac_do_void_callback(__priv, dma, qmode, __args)
 =20
  struct mac_device_info;
  struct net_device;

--Sig_/jODOqf1DtYm7h3NcT_UXHXA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAls5booACgkQAVBC80lX
0GxTmQf9ElKlJ7tu70FtVxLgHVYC8qTnGro8tEmr0pgag7n895ToFcuSABSkoLTy
jgQm+zJPtAlVPYqXkKpIaCdy4W5JCmoL9gTuHjV4j9oXZGCsrcR0HPLcgqXE5Jmz
DHmCzUbhBmVBW0xi5apC1FF7RZ8sdMXmh58qWCrI5vpEjT45Cow3qN59Nwi+ggq9
jD50MfCbdsn/H4k+skjf9T41oa4T4Tk22MPXWW82+z50NoKSjlnHPonDuXIlEWj0
cHxbMVTBPkXbh7rPfl8lxfhGAabpDCIXiescGRzrIeVFroxZcylOwZSSmf7r6mko
BNV2/9sa0jlM7+FA8nqD60uUoCXoyQ==
=EvQ/
-----END PGP SIGNATURE-----

--Sig_/jODOqf1DtYm7h3NcT_UXHXA--
