Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3607359-1523234756-2-9825918063382691969
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523234755; b=wd1QnT+Q4N9kUkEfBYRGamHur1bxSPgsa7rjLbLceIpCUcN34k
    wME0LZjfIBxoU0a8abzqwC//Kag7jNigjXyo4VX4WAD5m2dwcrBu24RowKMX3uoz
    10w95zKB5ZtAq9MCfgfW41kBowITrEme7aCSgcEzk4HnpebuzEt4efCu9k94/wEj
    BmBrbIR3dAY7VDaaeGXtDDz/RmkrYjyr2okV99NwTItE5icqumrKtaRZjxCJo1O8
    /VS7ebQ0QnTNNloTYpieXWhzGzWLRYf8dtxYbAt6aGPRCUMOyoc4kJS8mDyB0yAb
    LWA8KAA627HLeNmisQj+FIplRG0SaysWPANg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523234755; bh=5vwVpFPqDd
    Z2rDNttZYaZn0DDzaHR2OokHcsAU9ARJs=; b=j8X6ByqnBK74WqpdU8IjSsXi64
    b2onqROju6mwIFi+DPM7Kg6Qs6GE5b8J4gngTIsOUJE5nENkyjKFR3vaQZ8z3hcg
    ow+6xcCNcDUA6Dq6ZcFrDI95gUhajzTVxwoyfmNvDks3K7uGPPlxoXvMtBiExrAL
    1aE+uRjp6FoU10ZKswD7sI/uFydsAmBGrDs2zdR+sd5iHofMBnh8tGrGiquvjBQc
    LJthSLfNg1JzmeAagV4/UDTGTk1l/hml8DvT5lAVAIF3yPJDMT9LPG965HWQwcMy
    4mQo+h1xca25MZ82joZhq0AwqPHvpDE8N0+HPVi+qCue+ZnJIRWuWODIaOLg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gZc69Lta x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gZc69Lta x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDeJ/uDu3aIU3hPBm91hdN7ClRhwd0goQ7wHbAA2/jipwUYEaxYlbDbwm7RZ87CTuveEamEYHt0XbYpBggMZT0YU4QNgOQwscnK4BQzSxPgh8iymxpj2
    HeDOaQqJaFwTWB9d8+Q6vqAineqGTyqmhquH4nGkVGMASw3g8kHGfNkyreqGtnl5MJx2FCFZfl6g+0Fxuv0RWD4/y1n07WihuNONLFgJZLh/bBnzEbjs9CJD
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=ZwCpfEX3OczFsJB-QfsA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756920AbeDIApw (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:45:52 -0400
Received: from mail-cys01nam02on0126.outbound.protection.outlook.com ([104.47.37.126]:44046
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756761AbeDIAmZ (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:42:25 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 088/101] IB/ipoib: Fix for potential
 no-carrier state
Thread-Topic: [PATCH AUTOSEL for 3.18 088/101] IB/ipoib: Fix for potential
 no-carrier state
Thread-Index: AQHTz5uJnQWcbM/AQEq/x5WQXcuxFA==
Date: Mon, 9 Apr 2018 00:41:46 +0000
Message-ID: <20180409004042.164920-38-alexander.levin@microsoft.com>
References: <20180409004042.164920-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409004042.164920-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1062;7:ouV+D9qNgFI86U8w+HQQ8OVshRpEqP/U3ePEqqlmr0rE6+eYSZuzOYfXWV1joxjf+MjC1ltGo+9mJ//3dT40dMhF5+ioNoM8OrETa/ZPUtbBXC1sxQEh7I6J0tyUdZWmdaim3gisVYcDKb/WkVb/zJpPFabvgsaKSna1feNZ5zgixhFufFmxCjTRr5FYIA5TXscuQvY6xOI1oEFLNxKLysLICoLc+QQKXA4Gur2d52Xma8uETUBVSyTqQYDBVInN;20:hPf3qUpEDXAAMitEHfZVLUe9yooZe4InO4RP8XL/vGOZwoDFb3T0hOndo5bu2MhJHA5s16zL0zh2JA//KlMRajdojhBUVS88DK8P4jtHf/bs/VBeuQCyRYHYf9AXpEvpbzjkZWw2kgVc4DqbIV7P8MlwgoTka/0EJdmz0Uf1W0g=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: e7951b62-2e9b-4eaa-e10b-08d59db2c0e9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1062;
x-ms-traffictypediagnostic: DM5PR2101MB1062:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1062CAEB86C23FEAB1E4A7CDFBBF0@DM5PR2101MB1062.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1062;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1062;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39860400002)(376002)(39380400002)(396003)(346002)(199004)(189003)(68736007)(6512007)(316002)(486006)(6486002)(6666003)(54906003)(5660300001)(110136005)(102836004)(14454004)(99286004)(36756003)(86612001)(72206003)(105586002)(97736004)(106356001)(2906002)(22452003)(1076002)(2900100001)(10090500001)(6436002)(3660700001)(6116002)(3846002)(305945005)(59450400001)(86362001)(66066001)(10290500003)(3280700002)(5250100002)(25786009)(8676002)(81166006)(8936002)(7736002)(478600001)(476003)(81156014)(26005)(4326008)(186003)(2501003)(107886003)(6506007)(2616005)(76176011)(11346002)(446003)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1062;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: OLinlTYs0JqnIhD7LyrwZn3cyoUNlskkKwBOLhqky1OUBWJIFecERHyiyFxttm2i3MXieneJGuJHkczu0WkvoZq1jl0pVKJxHAENNhUsZl+NfuaQJd7ncANuY9AudlL3bh8bdAeLm9SPWh0rr8niHiXqyduTJBLjgJp5aEoGORVuFS3WDWwQIHiRDX905OpEJgAvdCoz9ZVER8tdKmYh+ka/Lmlb/YTIzPL/gnhqMgmOEtwH2VBNbvlkojLg+VrY23PIAQmdXQQUuKcdHKC11V1Sn5Ktk/cIoa4w7ho/ZvoUSpFvKA0pnhk5lcj1Err9wOdzS3M3EG1Vt0mmINLEUTlF9IYcMUmRAYnHSsL5Dru4EzUj2lTSk2SfjAJV1ZmKQvybErYDzMRog8gdq15dzouIhkiCUldUx4cTyS6Pr38=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7951b62-2e9b-4eaa-e10b-08d59db2c0e9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:41:46.4553
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1062
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Alex Estrin <alex.estrin@intel.com>

[ Upstream commit 1029361084d18cc270f64dfd39529fafa10cfe01 ]

On reboot SM can program port pkey table before ipoib registered its
event handler, which could result in missing pkey event and leave root
interface with initial pkey value from index 0.

Since OPA port starts with invalid pkey in index 0, root interface will
fail to initialize and stay down with no-carrier flag.

For IB ipoib interface may end up with pkey different from value
opensm put in pkey table idx 0, resulting in connectivity issues
(different mcast groups, for example).

Close the window by calling event handler after registration
to make sure ipoib pkey is in sync with port pkey table.

Reviewed-by: Mike Marciniszyn <mike.marciniszyn@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Alex Estrin <alex.estrin@intel.com>
Signed-off-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/ulp/ipoib/ipoib_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_main.c b/drivers/infiniband=
/ulp/ipoib/ipoib_main.c
index dce94ba467b6..0e58a705b37e 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1644,6 +1644,9 @@ static struct net_device *ipoib_add_port(const char *=
format,
 		goto event_failed;
 	}
=20
+	/* call event handler to ensure pkey in sync */
+	queue_work(ipoib_workqueue, &priv->flush_heavy);
+
 	result =3D register_netdev(priv->dev);
 	if (result) {
 		printk(KERN_WARNING "%s: couldn't register ipoib port %d; error %d\n",
--=20
2.15.1
