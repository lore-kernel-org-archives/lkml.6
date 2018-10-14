Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31BF3C6787C
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D696E2064E
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 07:59:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cFN2KHgm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D696E2064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbeJNPjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 11:39:31 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:1861 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbeJNPja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 11:39:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1539503960; x=1571039960;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MQnPTHTRncj01iAbVrX6qcAHKpPIqJW2SfE+ut1M7T4=;
  b=cFN2KHgmuSTHO6UXOri7SCyLE2YiYYIRM8qpO0MN6BBUMCI2zCOmS0KG
   aJuglGhpcJtenuaHNWv1d3Wgno5YtC+KLY62yZzyUlQ8Gvt4uCCjKPqXI
   xEKp/WJavXWyVtNmyxp3Wj1a56mJUjMLrAEDcFXDRADMGE6RS5iUGPK00
   s=;
X-IronPort-AV: E=Sophos;i="5.54,380,1534809600"; 
   d="scan'208";a="763853740"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 14 Oct 2018 07:59:18 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2b-a7fdc47a.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9E7xC85010799
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 14 Oct 2018 07:59:17 GMT
Received: from EX13D22EUA002.ant.amazon.com (10.43.165.125) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 14 Oct 2018 07:59:17 +0000
Received: from EX13D22EUA004.ant.amazon.com (10.43.165.129) by
 EX13D22EUA002.ant.amazon.com (10.43.165.125) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 14 Oct 2018 07:59:16 +0000
Received: from EX13D22EUA004.ant.amazon.com ([10.43.165.129]) by
 EX13D22EUA004.ant.amazon.com ([10.43.165.129]) with mapi id 15.00.1367.000;
 Sun, 14 Oct 2018 07:59:16 +0000
From:   "Kiyanovski, Arthur" <akiyano@amazon.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>,
        Networking <netdev@vger.kernel.org>
CC:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: linux-next: manual merge of the net-next tree with the net tree
Thread-Topic: linux-next: manual merge of the net-next tree with the net tree
Thread-Index: AQHUYbyMjM4EeOrNHUGNnUiynyOyEqUeYrHA
Date:   Sun, 14 Oct 2018 07:58:46 +0000
Deferred-Delivery: Sun, 14 Oct 2018 07:58:12 +0000
Message-ID: <d8dffd253dc143169c9bef29c519b963@EX13D22EUA004.ant.amazon.com>
References: <20181012104501.063dcc4a@canb.auug.org.au>
In-Reply-To: <20181012104501.063dcc4a@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.62]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Sent: Friday, October 12, 2018 2:45 AM
> To: David Miller <davem@davemloft.net>; Networking
> <netdev@vger.kernel.org>
> Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>; Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org>; Kiyanovski, Arthur
> <akiyano@amazon.com>
> Subject: linux-next: manual merge of the net-next tree with the net tree
>=20
> Hi all,
>=20
> Today's linux-next merge of the net-next tree got a conflict in:
>=20
>   drivers/net/ethernet/amazon/ena/ena_eth_com.c
>=20
> between commit:
>=20
>   248ab77342d0 ("net: ena: fix auto casting to boolean")
>=20
> from the net tree and commit:
>=20
>   cb36bb36e1f1 ("net: ena: use CSUM_CHECKED device indication to report
> skb's checksum status")
>=20
> from the net-next tree.
>=20
> I fixed it up (see below) and can carry the fix as necessary. This is now=
 fixed
> as far as linux-next is concerned, but any non trivial conflicts should b=
e
> mentioned to your upstream maintainer when your tree is submitted for
> merging.  You may also want to consider cooperating with the maintainer o=
f
> the conflicting tree to minimise any particularly complex conflicts.
>=20
> --
> Cheers,
> Stephen Rothwell
>=20
> diff --cc drivers/net/ethernet/amazon/ena/ena_eth_com.c
> index 2b3ff0c20155,6f8e15b9b3cf..000000000000
> --- a/drivers/net/ethernet/amazon/ena/ena_eth_com.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_eth_com.c
> @@@ -245,11 -349,14 +349,14 @@@ static inline void ena_com_rx_set_flags
>   		(cdesc->status &
> ENA_ETH_IO_RX_CDESC_BASE_L4_PROTO_IDX_MASK) >>
>   		ENA_ETH_IO_RX_CDESC_BASE_L4_PROTO_IDX_SHIFT;
>   	ena_rx_ctx->l3_csum_err =3D
>  -		(cdesc->status &
> ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_MASK) >>
>  -		ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_SHIFT;
>  +		!!((cdesc->status &
> ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_MASK) >>
>  +		ENA_ETH_IO_RX_CDESC_BASE_L3_CSUM_ERR_SHIFT);
>   	ena_rx_ctx->l4_csum_err =3D
>  -		(cdesc->status &
> ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_MASK) >>
>  -		ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_SHIFT;
>  +		!!((cdesc->status &
> ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_MASK) >>
>  +		ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_ERR_SHIFT);
> + 	ena_rx_ctx->l4_csum_checked =3D
> + 		!!((cdesc->status &
> ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_CHECKED_MASK) >>
> + 		ENA_ETH_IO_RX_CDESC_BASE_L4_CSUM_CHECKED_SHIFT);
>   	ena_rx_ctx->hash =3D cdesc->hash;
>   	ena_rx_ctx->frag =3D
>   		(cdesc->status &
> ENA_ETH_IO_RX_CDESC_BASE_IPV4_FRAG_MASK) >>

Hi Stephen,=20

The merge looks good.
I will know to mention conflicts in my future upstream releases.
Sorry for the trouble caused.

Thanks,
Arthur

