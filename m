Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3689844-1523236235-2-1549774058551672303
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
    1523236234; b=Ke3uD/jj8+OlkCXBPk63rQbX4mgRim6aKXPHvBoJCpu5LQK7tr
    02XFGILNhbjovssPBW9m48/tyLj5pevK6qZXpwiAiPjV+/omhySI9Xk+8W2LY8zG
    S3A4r835s/Ch4fq/s/Ss3yi5ZCoAVMBsPJWu5+dprzo4+rx60yED1qcSpt4Q5ZfD
    cZZmRhtjjjDPpXd4id/G7lsV5lETAPwQs3UCRO9ScmkIG+hk0bqvrIZJSG35yZRX
    3+Z3rwMPZ14dU9awomyKCgVmbg+bSNOwMEtHtaU01HfIauP8UExNjO1LmdN9yPzD
    yI1vjAD40Brkd8Uy+nE6zIeHdnjruVEKQ1Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523236234; bh=01tefSB7UG
    mR7ZSmgLynSSrY86btdS6R856B3DqLrMM=; b=AOqgC8er6iO5SnwM1oPad2+vAZ
    t2xuAuES2EdSY0uksdz8oJ3914nZSLEZaX7XQxrPxCCeTpj79G8+SiKVKV/3klvb
    2/pu8JoeqWCI/hZCaeBJhpl0+43gOX/fFjIGohfR6LUPDr3i9UeGgg58lzb7iVwI
    RgSJy6RyJshx7rot5hbDGfgPXSvuYrGn56g9aSqnFKSY579aBFWyMfMG18Tz63jf
    hZhaK9Sh37tRIrqUcAMzzMXyZ3diNIoY6feXVHrosgFDGMtg4v31z1zG+uGljiwf
    bmbhO8ocq9Mcc8m11NhdunnKL5OnefXITvd3LK4gYc4pwZQNj7c8lsWS0fcg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k/Lbag3g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=k/Lbag3g x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEfWddqB7TpEm1KdJyrv+9UZJqpS2yTlAhJfLNBzksHYx/zvlQUgChR3KnuEzFnoRZ9PHxYNnhfvbc0gxgqG6vXZtV+yIyBD6b8lR6p0qqwyBQ97bFz/
    81mPMgJvNbZOPBTMs4IeGqSvY6VkxuInCDvAz7hmGqRHvysbNpZuHHgTDIXvxj4BUpWddEKAk5hj7UsdrMiM1RicdW28KskHRvz47ygSbp97AckCT3+px5Bw
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=ZwCpfEX3OczFsJB-QfsA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757063AbeDIBJu (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:09:50 -0400
Received: from mail-co1nam03on0120.outbound.protection.outlook.com ([104.47.40.120]:40064
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933014AbeDIAiq (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:38:46 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 143/162] IB/ipoib: Fix for potential
 no-carrier state
Thread-Topic: [PATCH AUTOSEL for 4.4 143/162] IB/ipoib: Fix for potential
 no-carrier state
Thread-Index: AQHTz5nYd7NY66+zIkCxNWAMCajxIQ==
Date: Mon, 9 Apr 2018 00:29:40 +0000
Message-ID: <20180409002738.163941-143-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1125;7:3M/CwNv/NzSRcnO9V/0COfj1rQpE3+lnBtJn+MIAWY3jnFKP9p1oibPhUOkZWd4R3p5IbkQHTUpqOu5dpeyS/LS9eU+1yFvI7v4XT5iWKFR5N6XL+E48r9k3Tcdk09J978l6VGO0t9ZILntrpiKxtrq6sjpLx4px5fPVhuHPIPvAG4nv+++Phaxxp1lzKh66L4Tuw03R7Kr5/Tcf1douMiW/Hy2o2dcFkrlFWWFppzKkgGrLm8gh6pI9MC+whYUH;20:uucG0jtEmhMPumevxhgeAST2Ed9+RXkk8TaA+PKLcp8JXc2m6FCqcSjE90dRVN3MS7e1ufthgRHcuN/kfYY8a6GhGdGOaC5hRqQ2rs5tuXfzPJ0g3G6s7frDPSLOxOlRkNFUyjCbBGR+qNDaE49j+E/6ZaHq1F96GJJugZ1heAo=
X-MS-Office365-Filtering-Correlation-Id: 06183cf7-d41b-4d6e-e850-08d59db23fa2
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB1125;
x-ms-traffictypediagnostic: DM5PR2101MB1125:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1125B531FD00532190B0D247FBBF0@DM5PR2101MB1125.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1125;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1125;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(366004)(376002)(396003)(189003)(199004)(2906002)(25786009)(6512007)(10090500001)(3280700002)(10290500003)(6666003)(3660700001)(316002)(110136005)(54906003)(11346002)(107886003)(2616005)(476003)(446003)(36756003)(99286004)(86612001)(53936002)(4326008)(486006)(6436002)(3846002)(81156014)(305945005)(5250100002)(1076002)(102836004)(14454004)(66066001)(7736002)(105586002)(81166006)(59450400001)(106356001)(8676002)(97736004)(6116002)(6506007)(6486002)(5660300001)(186003)(76176011)(22452003)(72206003)(478600001)(2501003)(2900100001)(26005)(86362001)(8936002)(68736007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1125;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: bp+oNzjugMLyC6WL6ZyzwfCbXFWPwG74ytIkKhTlWoYeYiGJ7ouGY2H9SuqD5W+zCM7RFs1HzTpP2B2aTWMhTpZbbEAsjorIVJuOmBpzuw4KWQ+YNA7Rmsp4nbH2cazxjMhcOlXeSN7HOWRrrQktW8l3jt1qw6LkkdRDipvHHn1Y4xL5Z6JkMi6hfn+1wvyONFIrxtnzZV1j0WDEQyRTsyLFMxOQgK3vetOm+t99Avg7eA1vb3UdVNIJlfwUz2c20NrHAMYAzm02ioDtrzJoUEkiOJVH7fNKaIYEzoy1bSYbFxkojAB1Mzrkp8kx5ipb7FknuSgB+mOwQ/dDSzzgg7EWXQLM/IcKWDHezTNATf2bXcU8UZg4GeH85lb9zM7EcIpnlM0MNj0wmI0/bMb0bNJlnqJcW4Kpbem2s4cLPCE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06183cf7-d41b-4d6e-e850-08d59db23fa2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:29:40.3651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1125
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
index 37b42447045d..fcb18b11db75 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -1953,6 +1953,9 @@ static struct net_device *ipoib_add_port(const char *=
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
