Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74941C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B6CB2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:42:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="qPtHPNL/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B6CB2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755719AbeFSFmQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:42:16 -0400
Received: from mail-eopbgr700055.outbound.protection.outlook.com ([40.107.70.55]:23728
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S935908AbeFSFmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SjmbKKlRAvWLuG2aGaFDmP3//uNU/sQ/kJLQlGwZfU=;
 b=qPtHPNL/hlzh7V5fJHX7EVTK1m1rm2thmN4QiKLFS2a1Z1Y0sw1QYrDb1htppIF+apwvscRX/Y1um49dlBw+BL2fBxWVdMrbKZGAoCvRsUaSQV2K+6fQTZSoq0DXhFHayCPYZuMN7Pc+fWHKVMzx/6nsMpfEgQlWrmaIyStFy4E=
Received: from DM6PR02MB4361.namprd02.prod.outlook.com (20.176.105.26) by
 DM6PR02MB4507.namprd02.prod.outlook.com (20.176.107.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.16; Tue, 19 Jun 2018 05:42:12 +0000
Received: from DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa]) by DM6PR02MB4361.namprd02.prod.outlook.com
 ([fe80::9cf9:1a80:115a:f9fa%2]) with mapi id 15.20.0863.016; Tue, 19 Jun 2018
 05:42:11 +0000
From:   Radhey Shyam Pandey <radheys@xilinx.com>
To:     Joe Perches <joe@perches.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        Michal Simek <michals@xilinx.com>
CC:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/5] net: emaclite: Balance braces in else statement
Thread-Topic: [PATCH 2/5] net: emaclite: Balance braces in else statement
Thread-Index: AQHUBvqbbqwL+eQlLEO9oLIhJAmn8KRmLdIAgADj+yA=
Date:   Tue, 19 Jun 2018 05:42:11 +0000
Message-ID: <DM6PR02MB436134273D962B3FF3242723C7700@DM6PR02MB4361.namprd02.prod.outlook.com>
References: <1529322610-27215-1-git-send-email-radhey.shyam.pandey@xilinx.com>
         <1529322610-27215-3-git-send-email-radhey.shyam.pandey@xilinx.com>
 <644296b273a76469baf641dd712c7a5451cd34fe.camel@perches.com>
In-Reply-To: <644296b273a76469baf641dd712c7a5451cd34fe.camel@perches.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=radheys@xilinx.com; 
x-originating-ip: [182.72.145.30]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM6PR02MB4507;7:yJuw5KGSkAJ7QejfIh8LyhQML+m8NSd656wpITchIEI6I0K/Pc/SLWNpYvkNt5JDtEAMvG1ZLW6TvlOqxfuW1bEzoi5RCstNLp8SqPck1zorKNsQoRIQLtsd8ROgHFaFVPhH0g+vJbUZtSJcDNfFnRkoK+bjCHsHm2/ExRYfijpF2jH4mQW+Z5NDEnCElpgzT0LpiVZrbrLHUo7WUwMcnTaBASGl0dyPKwjHJs5n09DSnWGKc4yGeP+QYZefuV6S
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(376002)(346002)(366004)(39860400002)(39380400002)(396003)(51914003)(199004)(189003)(13464003)(2501003)(11346002)(486006)(14454004)(476003)(53936002)(25786009)(7696005)(8936002)(4326008)(3846002)(6116002)(81166006)(5660300001)(81156014)(446003)(8676002)(6246003)(5250100002)(99286004)(110136005)(2201001)(86362001)(316002)(3660700001)(54906003)(6636002)(76176011)(478600001)(55016002)(6436002)(26005)(102836004)(55236004)(9686003)(186003)(229853002)(2900100001)(7736002)(68736007)(53546011)(3280700002)(6506007)(59450400001)(66066001)(305945005)(106356001)(74316002)(105586002)(33656002)(97736004)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4507;H:DM6PR02MB4361.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: b3770c55-05c0-4ddf-a3fd-08d5d5a7675c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM6PR02MB4507;
x-ms-traffictypediagnostic: DM6PR02MB4507:
x-microsoft-antispam-prvs: <DM6PR02MB4507F0CBBF00D03C940F350DC7700@DM6PR02MB4507.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(258649278758335)(192813158149592);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4507;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4507;
x-forefront-prvs: 07083FF734
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: 5H80bbKMVxyT3SLNaLYcBhBFGmOLAodVZPcFxhNcdei5ErXLaE7iQ6z29ZiQXkzMDZl9buT+paNPWlpNUMK/NOBdtf6koSUBN8jyYqd3TKG9svdJvUXY06msCKXSkwbIU43FDS+vtuRKoioMxGOH9cmFNlWIQ0PdkePxqhu0aHu33hNqQ/mJ/TfAkybvCXkhiVbKKXGdZqUn9FU73Y6fNB3fmXEhkDzUXOIHXE0cjW4IXbFJ+N79MTYQKy+Ox45fBKcuZj5Hyi3EIYstxbpxkSohO+u1f6ICXf7ItJTY3AnWUAEp8o2gsd4j1U8rIqlqlmjaxTQKAVtC1J2g+L49oA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3770c55-05c0-4ddf-a3fd-08d5d5a7675c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2018 05:42:11.2547
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4507
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Joe Perches [mailto:joe@perches.com]
> Sent: Monday, June 18, 2018 9:33 PM
> To: Radhey Shyam Pandey <radheys@xilinx.com>; davem@davemloft.net;
> andrew@lunn.ch; Michal Simek <michals@xilinx.com>
> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH 2/5] net: emaclite: Balance braces in else statement
>=20
> On Mon, 2018-06-18 at 17:20 +0530, Radhey Shyam Pandey wrote:
> > Remove else as it is not required with if doing a return.
> > Fixes below checkpatch warning.
>=20
> > WARNING: else is not generally useful after a break or return
>=20
> checkpatch is stupid and doesn't understand code flow.
> Always try to improve code flow instead of merely
> following brainless instructions from a script.
>=20
> So:
>=20
> > diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
> []
> > @@ -569,13 +569,11 @@ static void xemaclite_tx_handler(struct net_devic=
e
> *dev)
> >  					(u8 *) lp->deferred_skb->data,
> >  					lp->deferred_skb->len) !=3D 0)
> >  			return;
> > -		else {
> > -			dev->stats.tx_bytes +=3D lp->deferred_skb->len;
> > -			dev_kfree_skb_irq(lp->deferred_skb);
> > -			lp->deferred_skb =3D NULL;
> > -			netif_trans_update(dev); /* prevent tx timeout */
> > -			netif_wake_queue(dev);
> > -		}
> > +		dev->stats.tx_bytes +=3D lp->deferred_skb->len;
> > +		dev_kfree_skb_irq(lp->deferred_skb);
> > +		lp->deferred_skb =3D NULL;
> > +		netif_trans_update(dev); /* prevent tx timeout */
> > +		netif_wake_queue(dev);
> >  	}
> >  }
>=20
> If you really want to redo this function, perhaps something like:
Thanks for the review. Yes, In v2 I will refactor the code to have
failure path return early.

>=20
> static void xemaclite_tx_handler(struct net_device *dev)
> {
> 	struct net_local *lp =3D netdev_priv(dev);
>=20
> 	dev->stats.tx_packets++;
>=20
> 	if (!lp->deferred_skb)
> 		return;
>=20
> 	if (xemaclite_send_data(lp, (u8 *)lp->deferred_skb->data,
> 				lp->deferred_skb->len))
> 		return;
>=20
> 	dev->stats.tx_bytes +=3D lp->deferred_skb->len;
> 	dev_kfree_skb_irq(lp->deferred_skb);
> 	lp->deferred_skb =3D NULL;
> 	netif_trans_update(dev); /* prevent tx timeout */
> 	netif_wake_queue(dev);
> }
>=20
> > @@ -1052,13 +1050,13 @@ static bool get_bool(struct platform_device
> *ofdev, const char *s)
> >  {
> >  	u32 *p =3D (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
> >
> > -	if (p) {
> > +	if (p)
> >  		return (bool)*p;
> > -	} else {
> > -		dev_warn(&ofdev->dev, "Parameter %s not found,"
> > +
> > +	dev_warn(&ofdev->dev, "Parameter %s not found,"
> >  			"defaulting to false\n", s);
> > -		return false;
> > -	}
> > +
> > +	return false;
> >  }
>=20
> And this function has backward logic as the failure paths
> are the ones that should return early or use a goto.
>=20
> Perhaps something like:
Yes, will change it.=20

>=20
> static bool get_bool(struct platform_device *ofdev, const char *s)
> {
> 	u32 *p =3D (u32 *)of_get_property(ofdev->dev.of_node, s, NULL);
>=20
> 	if (!p) {
> 		dev_warn(&ofdev->dev,
> 			 "Parameter '%s' not found, defaulting to false\n", s);
> 		return false;
> 	}
>=20
> 	return *p;
> }

