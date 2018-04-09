Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4029176-1523245471-2-10892292918513055708
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523245471; b=bb5bdNZ/ddDMha9JHd6hBgYSPCYKZGo74LSPqu7dflsGc7jJKB
    cCXp5SlvH2r/sbIwQ6t3NgN/YwNRhru4Swa29LllR7GDKVvNcXtdHGvDcrt8lp/Q
    vQK5zrpvtj1mnedN1mnMTU1MPU77sjTO+6arpFt1qCrZ7UKbfLJ7iGRFbmZxV981
    Wa0kLAUZsSM0/uz8WCsqz1Jwektf4jihTQSKG2uRmM0Xixett5jfvwUDHxeCk6rY
    5TzPL+ZUXeDL+OyEbID5l1xvk7nE4ddPhTNk5aN8g9RGACmzXSDY0FWUrYtCCjEa
    6oDiOh3RXjA4ASU6J/CfGzjFsrPWdBdKryjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523245471; bh=rMklTFOLG0
    2uQ6r+vxstth6xIrmsUAT90vlR4ABaOFw=; b=h8xqJ99NDuawApZxlJPJ7SAEoH
    bgUZCP1pgP1RfdyX9KD/W7odoh+4rGPu4axJ5R7aB4NlZwg8WqQ3TlsDpDjs4PDX
    s4nftbmOm4lxuchl+Vj4l+BszBIZ0kfrV6gTWVjh6HKZ63X4asS+u4L6t0zCd4Lk
    hfq1GUHYV8dQnegbV1RgcOGZgOEcn3s5BdJh30Ii+aw2StkygGeO7g+FP4j7gKkE
    7OAJrVsoWqneQCv3sWzVI+i/sFIHdEGC2qufz9JYHBDDDjhvhU8wNrfUzKOGcsc+
    8m3fcWLbO3Ek/mjbAM2OOAb0h6XMI5LogM30T/hkkF/0gLYayN/biVC0Rgow==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UEHx+mIu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UEHx+mIu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOuofCf0mOOiH5w46pxAyzbQGM/Z/dvmzXP6AiNdnyC9OUPrpeGlW2FTVMD8sk4DjzCMPFeH0PkRifQNlTT1i8YvecpCqSiNYzu85qh1sYmKrnCaWl52
    Qzj+1WdOPW/rltrh9beAnO6WEdjsL9FEgkK1sEwKU124XcPN0bYIs4WivdLTrL+FFZxcpQhTo8fSzNu+CYwKS1n3Ue1yT1ALCVdYbcw6nrKodqe47FkhgqiC
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=ZwCpfEX3OczFsJB-QfsA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754207AbeDIAUX (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:20:23 -0400
Received: from mail-cys01nam02on0123.outbound.protection.outlook.com ([104.47.37.123]:10471
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754208AbeDIAUT (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:20:19 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 133/189] IB/ipoib: Fix for potential
 no-carrier state
Thread-Topic: [PATCH AUTOSEL for 4.15 133/189] IB/ipoib: Fix for potential
 no-carrier state
Thread-Index: AQHTz5hLbz1Ug7clKU2PxT0lc+eMDA==
Date: Mon, 9 Apr 2018 00:18:33 +0000
Message-ID: <20180409001637.162453-133-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1110;7:yhkqQjmNmBoaj0cogo3TGK3a3f8ffdwyRMtUyILCpvOEYPDZk5QkRe1SrC7eRG3sXgdECWmLQx2R77gMSeNO23IR1bw/2+qljUTfVJqprTYg5Y2KETXTOLds1l+95RtJ4YGGtGLShUnhnGq7tvZqTEe2qMK/1Xuv0eyH3eltXPS/EASToOIVEgXbcatKGXut0/pzE/WtkWOYC9h64I12RHw1rXbKFbabt0e/Sf2RNF4EPcMgl0PW/y4w5JVraRG8;20:RuLl250qYQQ7R3PfAyhN9U3ARSlAIxaa7LkxMBrzAQC++35Nj59dkQ9zA4+bOO3z7sZHiOLtyaf6UPe9ZCKRUi0XhOMxkHZVvCqit0IzOjpKEr9wRNGOKuCIKqGJ8KTWQT3Lk+BpRW7ohqcUtKXc7FW73ngH8VEyCDbvINWgCWw=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: cd0c6705-881b-41a8-826b-08d59dafa913
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1110;
x-ms-traffictypediagnostic: DM5PR2101MB1110:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB11104A08CAC3266350E61025FBBF0@DM5PR2101MB1110.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB1110;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1110;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(366004)(346002)(396003)(39380400002)(39860400002)(199004)(189003)(5660300001)(478600001)(86612001)(3846002)(6116002)(106356001)(6486002)(72206003)(25786009)(10290500003)(8936002)(6436002)(76176011)(2616005)(6506007)(2900100001)(97736004)(486006)(26005)(36756003)(10090500001)(81166006)(8676002)(81156014)(59450400001)(102836004)(2906002)(99286004)(11346002)(476003)(3660700001)(66066001)(6512007)(86362001)(53936002)(105586002)(186003)(5250100002)(14454004)(22452003)(6666003)(2501003)(446003)(7736002)(316002)(1076002)(110136005)(3280700002)(54906003)(68736007)(107886003)(4326008)(305945005)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1110;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 8bDb5Q8Npmr8TvAY18rm+ufA+bRh8IrRZvJ5u9fP0i0uTNOXZAzntXLaSSvaEtIdd6cIGkdL/ibszm7Qi9JvyWHBbSWe6+chK8dlMLrq5pC31prOpLw5QVNHaF/ZfpLqWn4gQxhitlm17Af+e1Sk+jO1QlUZM9scS2yzQxtxHULHZh94DdShHuIxlq3pMX248MKGsuNnY2+2hTq0c1ZNt2OoFR5Gx4AAbDQqfpcb6ctPrMSKJ0ipvARLylFso92j7jLXWGGosv0BS6EOwLTjPAB2+oEpnMmOYQTY42eVUz9KBmN3WpX2Tlj0ySV12MHRpJas819eM/VvBoIqiyM9EvKNAfapjUoRLF8qRA0uhqzIJGFV8YzKuebAWnZ7/cJGiXP8imXfBAlyfuETKXiCeViACBjWEmnFyKimAU+lbs0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd0c6705-881b-41a8-826b-08d59dafa913
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:18:33.7068
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1110
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
index 160c5d9bca4c..4e75848f7a35 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2287,6 +2287,9 @@ static struct net_device *ipoib_add_port(const char *=
format,
 			      priv->ca, ipoib_event);
 	ib_register_event_handler(&priv->event_handler);
=20
+	/* call event handler to ensure pkey in sync */
+	queue_work(ipoib_workqueue, &priv->flush_heavy);
+
 	result =3D register_netdev(priv->dev);
 	if (result) {
 		printk(KERN_WARNING "%s: couldn't register ipoib port %d; error %d\n",
--=20
2.15.1
