Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751490AbeFEDfe (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 23:35:34 -0400
Received: from mail-eopbgr00088.outbound.protection.outlook.com ([40.107.0.88]:58544
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751326AbeFEDfc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 23:35:32 -0400
From: "Y.b. Lu" <yangbo.lu@nxp.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        Madalin-cristian Bucur <madalin.bucur@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
Thread-Topic: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
Thread-Index: AQHT+9MtmNWDOxXFrU61CgMXgIYqmaRQHgYAgADk+qA=
Date: Tue, 5 Jun 2018 03:35:28 +0000
Message-ID: <DB6PR0401MB2536376432EC481473A5B4A3F8660@DB6PR0401MB2536.eurprd04.prod.outlook.com>
References: <20180604070837.19265-1-yangbo.lu@nxp.com>
 <20180604070837.19265-10-yangbo.lu@nxp.com>
 <20180604134920.ezhe6jz5ntpnqyzj@localhost>
In-Reply-To: <20180604134920.ezhe6jz5ntpnqyzj@localhost>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=yangbo.lu@nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DB6PR0401MB2597;7:mfKOm2BrtYLdgq8mi054PNn7hM0Oa19gv8B6jp+C+yivvFxt8Mv40TaScupRJhhIUhF6yGuaoQE9Lx52fRilN457JuL/2EC0rKpDoSpAs8fHGCLVFmoFihjCN+oVuib14/XH3eC7g3mVVQCAIp9OdaH0Q6Ottpp4OhIeVvSvKvLwTj1YZdigOtNglD8rCik0EERkmjgiQmyjgYmPapXeoFEyJSvcvDNFSG2jUljqiNJ3MAU+mQ8KeRdv0wGzTlnm
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0401MB2597;
x-ms-traffictypediagnostic: DB6PR0401MB2597:
x-microsoft-antispam-prvs: <DB6PR0401MB259759702C3766D33898E899F8660@DB6PR0401MB2597.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(278428928389397)(9452136761055)(65623756079841)(185117386973197)(85827821059158)(258649278758335);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:DB6PR0401MB2597;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0401MB2597;
x-forefront-prvs: 0694C54398
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(39380400002)(366004)(346002)(13464003)(189003)(199004)(2900100001)(26005)(68736007)(106356001)(5250100002)(33656002)(186003)(3280700002)(229853002)(6246003)(14454004)(3660700001)(53936002)(39060400002)(305945005)(74316002)(2906002)(25786009)(1411001)(4326008)(9686003)(81156014)(7736002)(478600001)(8676002)(105586002)(8936002)(81166006)(97736004)(86362001)(6916009)(54906003)(316002)(53546011)(6506007)(6116002)(3846002)(55016002)(11346002)(446003)(7696005)(6436002)(5660300001)(476003)(486006)(66066001)(102836004)(99286004)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0401MB2597;H:DB6PR0401MB2536.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: c0rxCnI6Gd1cplvKGm/E9xj0P9HDUqUzOmiGtxipfufMwFTN6RdokKcZOsKLpLm0Du7uRYn3R3dUaIWIm5tDRRNndSrlxJ8EO/0pTCEUnybY7ruBnENvoJMDpP04aUKp9DzcJadVYyTqLiTkO2vDEiUGe/01p37vZ/tYwcvTIc5qs/6P9ZVdEAIl72T2AYgH
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cd643388-adff-4a78-dfda-08d5ca956245
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd643388-adff-4a78-dfda-08d5ca956245
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jun 2018 03:35:28.9540
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2597
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w553Zd6K005719

Hi Richard,

> -----Original Message-----
> From: Richard Cochran [mailto:richardcochran@gmail.com]
> Sent: Monday, June 4, 2018 9:49 PM
> To: Y.b. Lu <yangbo.lu@nxp.com>
> Cc: netdev@vger.kernel.org; Madalin-cristian Bucur
> <madalin.bucur@nxp.com>; Rob Herring <robh+dt@kernel.org>; Shawn Guo
> <shawnguo@kernel.org>; David S . Miller <davem@davemloft.net>;
> devicetree@vger.kernel.org; linuxppc-dev@lists.ozlabs.org;
> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 09/10] dpaa_eth: add support for hardware timestamping
> 
> On Mon, Jun 04, 2018 at 03:08:36PM +0800, Yangbo Lu wrote:
> 
> > +if FSL_DPAA_ETH
> > +config FSL_DPAA_ETH_TS
> > +	bool "DPAA hardware timestamping support"
> > +	select PTP_1588_CLOCK_QORIQ
> > +	default n
> > +	help
> > +	  Enable DPAA hardware timestamping support.
> > +	  This option is useful for applications to get
> > +	  hardware time stamps on the Ethernet packets
> > +	  using the SO_TIMESTAMPING API.
> > +endif
> 
> You should drop this #ifdef.  In general, if a MAC supports time stamping and
> PHC, then the driver support should simply be compiled in.
> 
> [ When time stamping incurs a large run time performance penalty to
>   non-PTP users, then it might make sense to have a Kconfig option to
>   disable it, but that doesn't appear to be the case here. ]

[Y.b. Lu] Actually these timestamping codes affected DPAA networking performance in our previous performance test.
That's why we used ifdef for it.

> 
> > @@ -1615,6 +1635,24 @@ static int dpaa_eth_refill_bpools(struct
> dpaa_priv *priv)
> >  	skbh = (struct sk_buff **)phys_to_virt(addr);
> >  	skb = *skbh;
> >
> > +#ifdef CONFIG_FSL_DPAA_ETH_TS
> > +	if (priv->tx_tstamp &&
> > +	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
> 
> This condition fits on one line easily.

[Y.b. Lu] Right. I will use one line in next version.

> 
> > +		struct skb_shared_hwtstamps shhwtstamps;
> > +		u64 ns;
> 
> Local variables belong at the top of the function.

[Y.b. Lu] Ok, will move them to the top in next verison.

> 
> > +		memset(&shhwtstamps, 0, sizeof(shhwtstamps));
> > +
> > +		if (!dpaa_get_tstamp_ns(priv->net_dev, &ns,
> > +					priv->mac_dev->port[TX],
> > +					(void *)skbh)) {
> > +			shhwtstamps.hwtstamp = ns_to_ktime(ns);
> > +			skb_tstamp_tx(skb, &shhwtstamps);
> > +		} else {
> > +			dev_warn(dev, "dpaa_get_tstamp_ns failed!\n");
> > +		}
> > +	}
> > +#endif
> >  	if (unlikely(qm_fd_get_format(fd) == qm_fd_sg)) {
> >  		nr_frags = skb_shinfo(skb)->nr_frags;
> >  		dma_unmap_single(dev, addr, qm_fd_get_offset(fd) + @@ -2086,6
> > +2124,14 @@ static int dpaa_start_xmit(struct sk_buff *skb, struct
> net_device *net_dev)
> >  	if (unlikely(err < 0))
> >  		goto skb_to_fd_failed;
> >
> > +#ifdef CONFIG_FSL_DPAA_ETH_TS
> > +	if (priv->tx_tstamp &&
> > +	    skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) {
> 
> One line please.

[Y.b. Lu] No problem.

> 
> > +		fd.cmd |= FM_FD_CMD_UPD;
> > +		skb_shinfo(skb)->tx_flags |= SKBTX_IN_PROGRESS;
> > +	}
> > +#endif
> > +
> >  	if (likely(dpaa_xmit(priv, percpu_stats, queue_mapping, &fd) == 0))
> >  		return NETDEV_TX_OK;
> >
> 
> Thanks,
> Richard
