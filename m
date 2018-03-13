Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-2215573-1520920284-2-2289139414972580772
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.137', Host='smtp4.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RO'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520920284; b=rWQxqiZBD3Ys2vBRV2CP21kNSiL8GjAz/V3Yk/g0g1DrLaE
    b/FiexZNusqXpbgajdzkh89kQkGuyjkTrbaEzK1ljUKeTKBhW9MfJDZW1+v8DsbU
    4sKf11A/lT7nlsbQHqpyEbuHfA4y63nKK8SFsY46QcIparf44dV3WKjZWc6ngyVe
    U1afM2YpnaAFU48fziU5ebr1PAQMgpccnd5EYdNFWTHdJ0C/k2mQyS6j9esOH7vX
    uMPoz5YKb1QWUOlZdi+HY7FNaX7TntjSmDhKHfmBdW6+34vw2QSewVBMtKj6rbCd
    Tfux+Prn9BesA8JMVVWHWvjCa4dwfqBzZC8NwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520920284; bh=J
    oG1bmVNsVprqydxo7OIHFWjLuyBLEEqZCXmBjcj0Yw=; b=SjjOLEMHYobma3D9Q
    2SHBf1BmP+yBcVZo/NJThhFUQjHXObfPh4wxBs5a+39aZnUlNg3I7FunHO2H4Ay0
    RaCKhTO/nd5+yPq6JaZJm/tY7o3UaCwivxLiTCatDq8LbLwJPVR9Jtn3zAEAMMr9
    fylW4tM9v3StH1NrM7eFATGrmvpAA81Vhuz/Zus1AsPNsS61P6HQumTbph8bw3wk
    CnD1SOJ0ehdL+ccPwAWS235u8aqXvBSYlQDkJGnTtWg37ufK62AQukRiC8ZsK2G5
    B/GypztnvANbT8Y9fOCqgm4nrg2goxgFkMtFiXkRSytzsTFjwvlLx4Ir7QxxRhLf
    h4sKQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=L4cMp3kU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=L4cMp3kU x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.137 (smtp4.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=fraxinus.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=fraxinus.osuosl.org x-ptr-lookup=smtp4.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH v4 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Thread-Topic: [PATCH v4 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Thread-Index: AQHTug+U5raiWiQO4Ue3AwT4ZMsTrKPNqhaA
Date: Tue, 13 Mar 2018 05:51:13 +0000
Message-ID: <AM3PR04MB074309FEAF3FB78917CBE80AE6D20@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <20180312084955.12686-1-razvan.stefanescu@nxp.com>
 <20180312084955.12686-3-razvan.stefanescu@nxp.com>
 <20180312143654.GB21068@lunn.ch>
In-Reply-To: <20180312143654.GB21068@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM3PR04MB1313;
 7:0zeVwIVlYIqc3w9BBZkKk2GvEyDy+Vqv2JtkPUuZlUDLcnH3n7IKIZwjoY2L87bvw30yWwkC1BDJJjYRpzsmP9olOHmjk1TRHTEcD4aFFccHRWkYir1HtvO95/Xj8nsVfQUXZbFi/G06XIQv2wLqjGJ3QdIU1krnI4HzXBrdMJkibf7NauBGdJdvMwGOqwIZ2OtVhxWB1KM5FaNh2Bdk7C7LtM9iTKZfY+TdBleqLUAe8qmd4oWFWSordlNXNzXB
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa160fae-11b4-40b4-7c7c-08d588a66e31
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB1313;
x-ms-traffictypediagnostic: AM3PR04MB1313:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM3PR04MB13135E4C3E2BDFA931E07F0DE6D20@AM3PR04MB1313.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3002001)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);
 SRVR:AM3PR04MB1313; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB1313;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(13464003)(189003)(199004)(6116002)(3846002)(3280700002)(5660300001)(316002)(8676002)(74316002)(25786009)(345774005)(229853002)(305945005)(14454004)(478600001)(7736002)(76176011)(81156014)(106356001)(68736007)(86362001)(81166006)(2906002)(4326008)(39060400002)(7696005)(6916009)(3660700001)(2950100002)(102836004)(33656002)(105586002)(2900100001)(6506007)(97736004)(54906003)(99286004)(6436002)(186003)(53546011)(66066001)(6246003)(26005)(53936002)(9686003)(8936002)(5250100002)(55016002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB1313;
 H:AM3PR04MB0743.eurprd04.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: nPzRHVR9lOnumzw4TUsH9pSdYxLkhwbuS7pLdvtIVKLJo9lz/dYX2O97uVCLQutEatDNutkqjc5s8gclWWWD9KMYKBZmx1PLtMSccow7gfd+2BBqNRTgLwU4u/jwevsO+z7gZDnRAt7V5WPM0s6l5Zn3y9SINgVDTB6q7aRpO7l/GXd5fQV04kDekjh2WLP3b2ZxyKPCkaZo7Hf/QyEukxFKnXx2pXROOVUd+q1/VodYxVws+IlRvSqBXHbgDGz6R3CICQsWutufH/k2tkkrKCE9AGuOlbhnOp1uP1qbZXCF8CfvnBLlJSl0S3Jx3JiU6uWWXUzz9vkIBDynWzu3Ag==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa160fae-11b4-40b4-7c7c-08d588a66e31
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 05:51:13.6228 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1313
X-BeenThere: driverdev-devel@linuxdriverproject.org
X-Mailman-Version: 2.1.24
 <driverdev-devel.linuxdriverproject.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel/>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Cc: "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
 "arnd@arndb.de" <arnd@arndb.de>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 Ioana Ciornei <ioana.ciornei@nxp.com>,
 Alexandru Marginean <alexandru.marginean@nxp.com>,
 Alexander Graf <agraf@suse.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: "devel" <driverdev-devel-bounces@linuxdriverproject.org>
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



> -----Original Message-----
> From: Andrew Lunn [mailto:andrew@lunn.ch]
> Sent: Monday, March 12, 2018 4:37 PM
> To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> Cc: gregkh@linuxfoundation.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; Alexander Graf
> <agraf@suse.de>; arnd@arndb.de; Alexandru Marginean
> <alexandru.marginean@nxp.com>; Ruxandra Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>; stuyoder@gmail.com
> Subject: Re: [PATCH v4 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
> Ethernet Switch driver
> 
> > +static int port_netdevice_event(struct notifier_block *unused,
> > +				unsigned long event, void *ptr)
> > +{
> > +	struct net_device *netdev = netdev_notifier_info_to_dev(ptr);
> > +	struct netdev_notifier_changeupper_info *info = ptr;
> > +	struct net_device *upper_dev;
> > +	int err = 0;
> > +
> > +	if (netdev->netdev_ops != &ethsw_port_ops)
> > +		return NOTIFY_DONE;
> > +
> > +	/* Handle just upper dev link/unlink for the moment */
> > +	if (event == NETDEV_CHANGEUPPER) {
> > +		upper_dev = info->upper_dev;
> > +		if (netif_is_bridge_master(upper_dev)) {
> > +			if (info->linking)
> > +				err = port_bridge_join(netdev);
> > +			else
> > +				err = port_bridge_leave(netdev);
> > +		}
> > +	}
> > +
> > +	return notifier_from_errno(err);
> > +}
> 
> I could be missing something here, but don't you need to pass to
> port_bridge_join() which bridge the port is joining. There can be
> multiple bridges, so you need to ensure the port joins the correct
> bridge.
> 
Thank you for noticing this. I'll add proper checks in next version.

	Razvan

> 	Andrew
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
