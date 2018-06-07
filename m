Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id IwZLICL5GFuAYwAAmS7hNA
	; Thu, 07 Jun 2018 09:21:38 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 66D8B608B8; Thu,  7 Jun 2018 09:21:38 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mfWfV8De"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 77A8B605A2;
	Thu,  7 Jun 2018 09:21:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 77A8B605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753686AbeFGJVf (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 05:21:35 -0400
Received: from mail-he1eur01on0048.outbound.protection.outlook.com ([104.47.0.48]:22880
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753121AbeFGJVc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 05:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O19scUCFFB2yh26Sdo5CaEyPsqnS8x2aBDPDjxvxdJY=;
 b=mfWfV8De5Lx91OTcCBYZhyfr4UyN7NaxKgtIY8gw3RJd/v77/s0M+uNCAJ38xa+NgBBMW9FjB3C/QZ6XCsGEhTOO72V+10zY7J3bYehidMHFWlh5juwSZTfrT76YP3yZD2b3IGH6XR3nVbK8wUEDgDdk33BXFJSssArX0rZdn3o=
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com (10.169.224.151) by
 DB6PR0401MB2469.eurprd04.prod.outlook.com (10.169.224.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.820.14; Thu, 7 Jun 2018 09:21:28 +0000
Received: from DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::c860:bdbd:3a07:8580]) by DB6PR0401MB2536.eurprd04.prod.outlook.com
 ([fe80::c860:bdbd:3a07:8580%5]) with mapi id 15.20.0797.020; Thu, 7 Jun 2018
 09:21:28 +0000
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [v2, 09/10] dpaa_eth: add support for hardware timestamping
Thread-Topic: [v2, 09/10] dpaa_eth: add support for hardware timestamping
Thread-Index: AQHT/g8iPthuHS016UuT35rVkpvytaRUdaiAgAAPMEA=
Date: Thu, 7 Jun 2018 09:21:28 +0000
Message-ID: <DB6PR0401MB2536E1848289D45F5C77FEF7F8640@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180607032256.39802-1-yangbo.lu@nxp.com>
 <20180607032256.39802-10-yangbo.lu@nxp.com>
 <AM6PR04MB40080865F823C7C57716818FEC640@AM6PR04MB4008.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB40080865F823C7C57716818FEC640@AM6PR04MB4008.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2469;7:Jnc9UupUcFZBEc6T2lrpkhUyyKGLg/yF1+ynu56+W3+owdgrehmelPSoXC5nbjTsmWVslckSa/OO5L2n7em39NK9YqtL6KLw7q3cXM1VtSvGRbPjS2IKJlYDv3g8aPXdWtpmd4m6zqdWFHLzyquuBCUgBJj2c1qlIKStA6Ll3Wqm9kNvmIZb/yoVApNW2BYHwridXxpVk7GmwIO4PCpnEnm8zv8hCZ+9eDqAybveTsGIVOtnK5vNH8WeNhzGw+ZI
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2469;
x-ms-traffictypediagnostic: DB6PR0401MB2469:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com;
x-microsoft-antispam-prvs: <DB6PR0401MB246960B815272186755BBFBFF8640@DB6PR0401MB2469.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2469;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2469;
x-forefront-prvs: 06968FD8C4
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(376002)(39860400002)(39380400002)(346002)(189003)(199004)(13464003)(7696005)(99286004)(68736007)(2900100001)(9686003)(5660300001)(53936002)(478600001)(76176011)(3846002)(6116002)(486006)(11346002)(110136005)(53546011)(316002)(39060400002)(6246003)(476003)(4326008)(54906003)(2906002)(3660700001)(2501003)(446003)(3280700002)(25786009)(74316002)(305945005)(66066001)(8676002)(7736002)(102836004)(81166006)(81156014)(5250100002)(6506007)(55016002)(97736004)(8936002)(6436002)(14454004)(86362001)(105586002)(229853002)(26005)(106356001)(33656002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2469;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: OO/LxJOT0y77CfUloR2Vql14tUHN7jF6Of4ygkvOfITjf9su02lKahiLlRl/+dMXwbYHnoiRIVHjgJZ+sKX1dBTDs+BoQ/8stDUu33bfyb4Fu7xDhf9nOwxMwaJagnjh3KK+x3qUVi1s18J/ZzOfzIPnmD+azkGXN8vDtLyHy9XgX4d3Kgb7IEdF+ltk6HRx
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5d001171-1ca1-4693-2347-08d5cc580ccc
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d001171-1ca1-4693-2347-08d5cc580ccc
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2018 09:21:28.5592
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Madalin,

> -----Original Message-----
> From: Madalin-cristian Bucur
> Sent: Thursday, June 7, 2018 4:24 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>; netdev@vger.kernel.org; Richard Cochran
> <richardcochran@gmail.com>; Rob Herring <robh+dt@kernel.org>; Shawn
> Guo <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>
> Cc: devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; Y.b. =
Lu
> <yangbo.lu@nxp.com>
> Subject: RE: [v2, 09/10] dpaa_eth: add support for hardware timestamping
>=20
> > -----Original Message-----
> > From: Yangbo Lu [mailto:yangbo.lu@nxp.com]
> > Sent: Thursday, June 7, 2018 6:23 AM
> > Subject: [v2, 09/10] dpaa_eth: add support for hardware timestamping
> >
> > This patch is to add hardware timestamping support for dpaa_eth. On
> > Rx, timestamping is enabled for all frames. On Tx, we only instruct
> > the hardware to timestamp the frames marked accordingly by the stack.
> >
> > Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> > ---
> > Changes for v2:
> > 	- Removed ifdef for timestamp code.
> > 	- Minor fixes for code style.
> > ---
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.c |  101
> > ++++++++++++++++++++++-
> >  drivers/net/ethernet/freescale/dpaa/dpaa_eth.h |    3 +
> >  2 files changed, 99 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > index fd43f98..bd589ac 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
> > @@ -1168,7 +1168,7 @@ static int dpaa_eth_init_tx_port(struct
> > fman_port *port, struct dpaa_fq *errq,
> >  	buf_prefix_content.priv_data_size =3D buf_layout->priv_data_size;
> >  	buf_prefix_content.pass_prs_result =3D true;
> >  	buf_prefix_content.pass_hash_result =3D true;
> > -	buf_prefix_content.pass_time_stamp =3D false;
> > +	buf_prefix_content.pass_time_stamp =3D true;
> >  	buf_prefix_content.data_align =3D DPAA_FD_DATA_ALIGNMENT;
> >
> >  	params.specific_params.non_rx_params.err_fqid =3D errq->fqid; @@
> > -1210,7 +1210,7 @@ static int dpaa_eth_init_rx_port(struct fman_port
> > *port, struct dpaa_bp **bps,
> >  	buf_prefix_content.priv_data_size =3D buf_layout->priv_data_size;
> >  	buf_prefix_content.pass_prs_result =3D true;
> >  	buf_prefix_content.pass_hash_result =3D true;
> > -	buf_prefix_content.pass_time_stamp =3D false;
> > +	buf_prefix_content.pass_time_stamp =3D true;
> >  	buf_prefix_content.data_align =3D DPAA_FD_DATA_ALIGNMENT;
> >
> >  	rx_p =3D &params.specific_params.rx_params;
> > @@ -1592,6 +1592,16 @@ static int dpaa_eth_refill_bpools(struct
> > dpaa_priv
> > *priv)
> >  	return 0;
> >  }
> >
> > +static int dpaa_get_tstamp_ns(struct net_device *net_dev, u64 *ns,
> > +			      struct fman_port *port, const void *data) {
> > +	if (!fman_port_get_tstamp_field(port, data, ns)) {
> > +		be64_to_cpus(ns);
>=20
> Please move this endianness conversion in the fman API.

[Y.b. Lu] Ok. Will move to fman API in next version.

>=20
> > +		return 0;
> > +	}
> > +	return -EINVAL;
> > +}
> > +
> >  /* Cleanup function for outgoing frame descriptors that were built on
> > Tx path,
> >   * either contiguous frames or scatter/gather ones.
> >   * Skb freeing is not handled here.
> > @@ -1607,14 +1617,29 @@ static int dpaa_eth_refill_bpools(struct
> > dpaa_priv
> > *priv)
> >  {
> >  	const enum dma_data_direction dma_dir =3D DMA_TO_DEVICE;
> >  	struct device *dev =3D priv->net_dev->dev.parent;
> > +	struct skb_shared_hwtstamps shhwtstamps;
> >  	dma_addr_t addr =3D qm_fd_addr(fd);
> >  	const struct qm_sg_entry *sgt;
> >  	struct sk_buff **skbh, *skb;
> >  	int nr_frags, i;
> > +	u64 ns;
> >
> >  	skbh =3D (struct sk_buff **)phys_to_virt(addr);
> >  	skb =3D *skbh;
> >
> > +	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags &
> > SKBTX_HW_TSTAMP) {
> > +		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> > +
> > +		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
> > +					priv->mac_dev->port[TX],
> > +					(void *)skbh)) {
> > +			shhwtstamps.hwtstamp =3D ns_to_ktime(ns);
> > +			skb_tstamp_tx(skb, &shhwtstamps);
> > +		} else {
> > +			dev_warn(dev, "dpaa_get_tstamp_ns failed!\n");
> > +		}
> > +	}
> > +
> >  	if (unlikely(qm_fd_get_format(fd) =3D=3D qm_fd_sg)) {
> >  		nr_frags =3D skb_shinfo(skb)->nr_frags;
> >  		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) + @@ -2086,6
> > +2111,11 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct
> > net_device *net_dev)
> >  	if (unlikely(err < 0))
> >  		goto skb_to_fd_failed;
> >
> > +	if (priv->tx_tstamp && skb_shinfo(skb)->tx_flags &
> > SKBTX_HW_TSTAMP) {
> > +		fd.cmd |=3D FM_FD_CMD_UPD;
>=20
> The fd.cmd field is big endian, please use this:
>=20
> +		fd.cmd |=3D cpu_to_be32(FM_FD_CMD_UPD);
>=20

[Y.b. Lu] Thanks a lot for pointing out this issue. This fixes TX timestamp=
 issue on ARM platform.
By now, I have verified both PowerPC platform and ARM platform. The PTP clo=
ck driver and timestamping worked fine.
I will send out v3 patch-set for reviewing.

> > +		skb_shinfo(skb)->tx_flags |=3D SKBTX_IN_PROGRESS;
> > +	}
> > +
> >  	if (likely(dpaa_xmit(priv, percpu_stats, queue_mapping, &fd) =3D=3D 0=
))
> >  		return NETDEV_TX_OK;
> >
> > @@ -2227,6 +2257,7 @@ static enum qman_cb_dqrr_result
> > rx_default_dqrr(struct qman_portal *portal,
> >  						struct qman_fq *fq,
> >  						const struct qm_dqrr_entry
> > *dq)
> >  {
> > +	struct skb_shared_hwtstamps *shhwtstamps;
> >  	struct rtnl_link_stats64 *percpu_stats;
> >  	struct dpaa_percpu_priv *percpu_priv;
> >  	const struct qm_fd *fd =3D &dq->fd;
> > @@ -2240,6 +2271,7 @@ static enum qman_cb_dqrr_result
> > rx_default_dqrr(struct qman_portal *portal,
> >  	struct sk_buff *skb;
> >  	int *count_ptr;
> >  	void *vaddr;
> > +	u64 ns;
> >
> >  	fd_status =3D be32_to_cpu(fd->status);
> >  	fd_format =3D qm_fd_get_format(fd);
> > @@ -2304,6 +2336,18 @@ static enum qman_cb_dqrr_result
> > rx_default_dqrr(struct qman_portal *portal,
> >  	if (!skb)
> >  		return qman_cb_dqrr_consume;
> >
> > +	if (priv->rx_tstamp) {
> > +		shhwtstamps =3D skb_hwtstamps(skb);
> > +		memset(shhwtstamps, 0, sizeof(*shhwtstamps));
> > +
> > +		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
> > +					priv->mac_dev->port[RX],
> > +					vaddr))
> > +			shhwtstamps->hwtstamp =3D ns_to_ktime(ns);
> > +		else
> > +			dev_warn(net_dev->dev.parent,
> > "dpaa_get_tstamp_ns failed!\n");
> > +	}
> > +
> >  	skb->protocol =3D eth_type_trans(skb, net_dev);
> >
> >  	if (net_dev->features & NETIF_F_RXHASH && priv->keygen_in_use &&
> @@
> > -2523,11 +2567,58 @@ static int dpaa_eth_stop(struct net_device
> > *net_dev)
> >  	return err;
> >  }
> >
> > +static int dpaa_ts_ioctl(struct net_device *dev, struct ifreq *rq,
> > +int cmd) {
> > +	struct dpaa_priv *priv =3D netdev_priv(dev);
> > +	struct hwtstamp_config config;
> > +
> > +	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
> > +		return -EFAULT;
> > +
> > +	switch (config.tx_type) {
> > +	case HWTSTAMP_TX_OFF:
> > +		/* Couldn't disable rx/tx timestamping separately.
> > +		 * Do nothing here.
> > +		 */
> > +		priv->tx_tstamp =3D false;
> > +		break;
> > +	case HWTSTAMP_TX_ON:
> > +		priv->mac_dev->set_tstamp(priv->mac_dev->fman_mac,
> > true);
> > +		priv->tx_tstamp =3D true;
> > +		break;
> > +	default:
> > +		return -ERANGE;
> > +	}
> > +
> > +	if (config.rx_filter =3D=3D HWTSTAMP_FILTER_NONE) {
> > +		/* Couldn't disable rx/tx timestamping separately.
> > +		 * Do nothing here.
> > +		 */
> > +		priv->rx_tstamp =3D false;
> > +	} else {
> > +		priv->mac_dev->set_tstamp(priv->mac_dev->fman_mac,
> > true);
> > +		priv->rx_tstamp =3D true;
> > +		/* TS is set for all frame types, not only those requested */
> > +		config.rx_filter =3D HWTSTAMP_FILTER_ALL;
> > +	}
> > +
> > +	return copy_to_user(rq->ifr_data, &config, sizeof(config)) ?
> > +			-EFAULT : 0;
> > +}
> > +
> >  static int dpaa_ioctl(struct net_device *net_dev, struct ifreq *rq,
> > int cmd)  {
> > -	if (!net_dev->phydev)
> > -		return -EINVAL;
> > -	return phy_mii_ioctl(net_dev->phydev, rq, cmd);
> > +	int ret =3D -EINVAL;
> > +
> > +	if (cmd =3D=3D SIOCGMIIREG) {
> > +		if (net_dev->phydev)
> > +			return phy_mii_ioctl(net_dev->phydev, rq, cmd);
> > +	}
> > +
> > +	if (cmd =3D=3D SIOCSHWTSTAMP)
> > +		return dpaa_ts_ioctl(net_dev, rq, cmd);
> > +
> > +	return ret;
> >  }
> >
> >  static const struct net_device_ops dpaa_ops =3D { diff --git
> > a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> > b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> > index bd94220..af320f8 100644
> > --- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> > +++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.h
> > @@ -182,6 +182,9 @@ struct dpaa_priv {
> >
> >  	struct dpaa_buffer_layout buf_layout[2];
> >  	u16 rx_headroom;
> > +
> > +	bool tx_tstamp; /* Tx timestamping enabled */
> > +	bool rx_tstamp; /* Rx timestamping enabled */
> >  };
> >
> >  /* from dpaa_ethtool.c */
> > --
> > 1.7.1
