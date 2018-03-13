Return-Path: <driverdev-devel-bounces@linuxdriverproject.org>
X-Cyrus-Session-Id: sloti22d1t05-3393218-1520954451-2-12730526509772938940
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_MED -2.3,
  RCVD_IN_SORBS_WEB 1.5, SPF_PASS -0.001, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='140.211.166.133', Host='smtp2.osuosl.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='RO'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: driverdev-devel-bounces@linuxdriverproject.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520954450; b=toRUtR7u0NB9z7iHfW8YV9BQDSrIe4lg55uq9tT3ymmtvpH
    1ycTFjpA05GGKPf8Shxo8AUZENFW14k6YEsfqCTQhdEOvpdzjjBV+HFfjkB/MQIL
    1sFaIHigiH2sHgJyXKJpYX9nQWAsRbwwDCZDBU+sD1zvdRch/JJsCbc+VHuwlxN6
    7BrwE6s2fcLxuOKlZ8qk1DFJStNOS2Y9ilM+1ln+ZY+Ois32trH8VSo1Vkz7iHf4
    ZGNOOhyiJk0APbYIEaJ+VkB7/PWb+IjlRNRYtZWMsaN9M0Ircf0W5JsgsZKLaij3
    eWmm8yux3eXFF/Dd3Z18vEosKAGVAaDgFAWOXVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:subject:date:message-id
    :references:in-reply-to:mime-version:list-id:list-unsubscribe
    :list-archive:list-post:list-help:list-subscribe:cc:content-type
    :content-transfer-encoding:sender; s=arctest; t=1520954450; bh=l
    ANUro/gu+Y1vysXWbGSaU+Aamgww8CN7DU/GrvdUSs=; b=kJmmulLBVdEC6+QWn
    0YHkm4w6rU19twUrPG517A09ChqnligEoU0HqTEpIXYbqEBlSUad19DewQexoB34
    8XOenSMjdtxndmQuX1tPlov4cguUIhvzYm99wbqsQZNKh92eC2NN3OLilIGlbUka
    nemDBTSy6a4k2DdUR4Xg84aFT4VlFTwhOKhIXcHlh4UtmevV0UekDVQjPDzPejHg
    orB/uEEz2tSBiK3/KwE7M4lg5MD8GCZRHARzvG1DdwS2W2m6+VeoTYff40Zfp7l/
    sFR/NCLeBPUrpBHN2KXA19WTlaMOd1+2sMuetauz80QLjjw9tlXKKmClQOwb/Ikc
    8aQFg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=NI4EGF4w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered; 1024-bit rsa key sha256) header.d=nxp.com header.i=@nxp.com header.b=NI4EGF4w x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=nxp.com;
    iprev=pass policy.iprev=140.211.166.133 (smtp2.osuosl.org);
    spf=pass smtp.mailfrom=driverdev-devel-bounces@linuxdriverproject.org smtp.helo=hemlock.osuosl.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=fail x-ptr-helo=hemlock.osuosl.org x-ptr-lookup=smtp2.osuosl.org;
    x-return-mx=pass smtp.domain=linuxdriverproject.org smtp.result=pass smtp_is_org_domain=yes header.domain=nxp.com header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128
X-Remote-Delivered-To: driverdev-devel@osuosl.org
From: Razvan Stefanescu <razvan.stefanescu@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
Subject: RE: [PATCH v5 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Thread-Topic: [PATCH v5 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
 Ethernet Switch driver
Thread-Index: AQHTutbMhVVZowRKSkyV9LKDFfki76POQC1w
Date: Tue, 13 Mar 2018 15:20:38 +0000
Message-ID: <AM3PR04MB07438DD330E88830AD714339E6D20@AM3PR04MB0743.eurprd04.prod.outlook.com>
References: <20180313135156.3322-1-razvan.stefanescu@nxp.com>
 <20180313135156.3322-3-razvan.stefanescu@nxp.com>
 <20180313142251.GB3814@lunn.ch>
In-Reply-To: <20180313142251.GB3814@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=razvan.stefanescu@nxp.com;
x-originating-ip: [86.34.165.90]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1; AM3PR04MB1380;
 7:ktyLmxvLehtCL2a8bN4Oz1FZq+KmuOEoev6mz/bzB63p6TiErDPalfvcJAmRDdDDr1ITGiEKPBLPdyidg3jCISuFtlxo0Hc9pq+EdfFGswvU11B5KS+K8VtWk9jZI3srSxOKqayUWliGMBeBgVG7XulFsyEvJTKQvmtPnjaboRal6ftL7q0W04rbrqYM4VV2x9vaTKkjp61DxizQBk71Gn3noqYyYtJck7xPBoW9SlYf2eRKnebp4n1VSjrgi1+6
x-ms-exchange-antispam-srfa-diagnostics: SSOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a14ec9fd-215b-4a46-2a4f-08d588f5fa77
x-microsoft-antispam: UriScan:; BCL:0; PCL:0;
 RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);
 SRVR:AM3PR04MB1380;
x-ms-traffictypediagnostic: AM3PR04MB1380:
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-microsoft-antispam-prvs: <AM3PR04MB1380A325A1D169DB583AD45AE6D20@AM3PR04MB1380.eurprd04.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(185117386973197)(85827821059158); 
x-exchange-antispam-report-cfa-test: BCL:0; PCL:0;
 RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501244)(52105095)(6055026)(6041310)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(6072148)(201708071742011);
 SRVR:AM3PR04MB1380; BCL:0; PCL:0; RULEID:; SRVR:AM3PR04MB1380;
x-forefront-prvs: 0610D16BBE
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(366004)(396003)(39860400002)(39380400002)(376002)(346002)(13464003)(189003)(199004)(6916009)(7736002)(2906002)(2900100001)(7696005)(66066001)(316002)(5250100002)(3846002)(6116002)(81166006)(81156014)(3280700002)(76176011)(8936002)(68736007)(9686003)(55016002)(6436002)(5660300001)(106356001)(53546011)(102836004)(59450400001)(97736004)(54906003)(229853002)(86362001)(99286004)(105586002)(33656002)(4326008)(2950100002)(8676002)(6506007)(3660700001)(25786009)(74316002)(478600001)(26005)(14454004)(53936002)(305945005)(6246003)(186003)(39060400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:AM3PR04MB1380;
 H:AM3PR04MB0743.eurprd04.prod.outlook.com; FPR:; SPF:None; PTR:InfoNoRecords;
 MX:1; A:1; LANG:en;
x-microsoft-antispam-message-info: OkgXs2pK+NjlEdF/7VvxcBEjzEZJ+2FWGk9oaSFIPnfenRDnjzuwAutPW/6/DembOR/Z20AEjwwFs7LQY3tt1rB73Edop3jxznBpEzQ9yGQ8WAU3Wti89oWcu30subNVC36kNUqwf0TPPndsq6GPX82xLxNdVgWs4AH2TKBCX64lV+SAOlG1X3YZyKkruEUGul9C/jsD5S/4vZYtIm5RRExDEz0WBwRbHMoG4+MddShspYs5Pyk8+OwEddimqwp8cP/WOmO1TAKOoF2wDmJbknE7EmWxiFtk+5c6vnhIOGQNrnM0qzH47se9xHynOgikfO35wJMsPitdMJWpf5aOUA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a14ec9fd-215b-4a46-2a4f-08d588f5fa77
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Mar 2018 15:20:38.7178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM3PR04MB1380
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
> Sent: Tuesday, March 13, 2018 4:23 PM
> To: Razvan Stefanescu <razvan.stefanescu@nxp.com>
> Cc: gregkh@linuxfoundation.org; devel@driverdev.osuosl.org; linux-
> kernel@vger.kernel.org; netdev@vger.kernel.org; Alexander Graf
> <agraf@suse.de>; arnd@arndb.de; Alexandru Marginean
> <alexandru.marginean@nxp.com>; Ruxandra Ioana Ciocoi Radulescu
> <ruxandra.radulescu@nxp.com>; Ioana Ciornei <ioana.ciornei@nxp.com>;
> Laurentiu Tudor <laurentiu.tudor@nxp.com>; stuyoder@gmail.com
> Subject: Re: [PATCH v5 2/6] staging: fsl-dpaa2/ethsw: Add Freescale DPAA2
> Ethernet Switch driver
> 
> > +/* For the moment, only flood setting needs to be updated */
> > +static int port_bridge_join(struct net_device *netdev,
> > +			    struct net_device *upper_dev)
> > +{
> > +	struct ethsw_port_priv *port_priv = netdev_priv(netdev);
> > +	struct ethsw_core *ethsw = port_priv->ethsw_data;
> > +	int i, err;
> > +
> > +	for (i = 0; i < ethsw->sw_attr.num_ifs; i++)
> > +		if (ethsw->ports[i]->bridge_dev &&
> > +		    (ethsw->ports[i]->bridge_dev != upper_dev)) {
> > +			netdev_err(netdev,
> > +				   "Another switch port is connected to %s\n",
> > +				   ethsw->ports[i]->bridge_dev->name);
> > +			return -EINVAL;
> > +		}
> > +
> > +	/* Enable flooding */
> > +	err = ethsw_port_set_flood(port_priv, 1);
> > +	if (!err)
> > +		port_priv->bridge_dev = upper_dev;
> > +
> > +	return err;
> > +}
> 
> Hi Razvan
> 
> That is not what i was meaning.
> 
> brctl addbr br0
> brctl addbr br1
> brctl addif br0 lan0
> brctl addif br0 lan1
> brctl addif br1 lan2
> brctl addif br1 lan3
> 
> Is there somewhere in the code which sets the scope for the flooding?
> lan0 can flood to lan1, but it should not flood to lan2 or lan3, since
> they are in a different bridge. I was expecting that
> ethsw_port_set_flood() takes upper_dev, in order to configure which
> ports it should flood to.
> 
>       Andrew

Hello Andrew,

The current driver implementation uses only a single FDB for the switch,
so  it is not possible configure multiple flooding domains to accommodate
ports partitioning.
 
The configuration that you mentioned will be possible when support for
multiple FDBs in the switch is added. Ports added to the same bridge
will have their flooding domain limited to a specific FDB.

Switch ports partitioning is a feature on the roadmap. I will add this
information to the TODO list.

Best regards,
Razvan Stefanescu
_______________________________________________
devel mailing list
devel@linuxdriverproject.org
http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel
