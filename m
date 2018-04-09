Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243007-2-16030573409285708463
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
    1523243006; b=gc/zPlbN3TfMO3+nrRBFmaanwGlU/gyYg/WWzA6jfLgv0h5tuj
    vzJzp7pBNt1/yQ3ptV8vbOEThj+Srp7oTAyoss5VZJJWxSbHb8sRsXbDuRuzkGuB
    gRLya5wR8ubnCVDyqg/bNckQw4rWF084zKEgWt2PMLhlg9HkWHPzsYT6u5f1Bvpk
    WIU84f8DyP1j/AOg8ny8Tg4zJwk9EvLQXTLuCvzLclr/3pMPnyHZn5AN06D/t5cN
    VjRox5jguVv4S3BEuYz1KMALQhDwFiVVhLZze4/sKYdr3SxD8+gp112gj7wMGjex
    yrKiAbRpr6bKZvxpDGvxws1HHnm5ABMNInMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243006; bh=zxpmbro55t
    4js5agZPcVhJ4AarrviDEZpS01YWP7Sf0=; b=N+/xMXu7KiL+53JBk6EHv7Wwz1
    wxwEZP9guFSLxVkPRjtrWbX8xJZhotJGzcr9YR9dSs4npQrBL9SXvxjRPI0A+kec
    kPPziYGdjk7lLx0hFHp8FpE6LaVYgsGMTnnwyQcFCKofqOLiqnRhqkmT8I8it1wu
    FbbM+SgbSFdMzarZp2d668X5WRE2xC4mWWyq/Ty7KpKYb8O3OcitftpxBL0NktS6
    pdur/Gpy3md0n4+c+Cnkz4qJfBa47yvic2yFLkWhw0ffx4IXOPeczJt1gh1f1gxk
    byrl1dlyiRYVF/2aoinQKs60vLqHUsU2n5CGgFpdFKVGyeCQGetXh9MGLHcg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iZkR1l0c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=iZkR1l0c x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPbu10AI4hj8iS2ghrA8CSLotXthL8AC/OVUaHENwcHP8k0jAAD9Cyd4KVz2ZpxZZNM9Pid1uqs1N+1FgGfb7HZioCryYhNdANYCXPw8BwuS9CzABCPP
    BTLQ+lzDewV6ov4xoy+rt+kIaAktd4oXR0UTNsAScpFWLr064ouMLbELIqPEHqFOe6JYNH6Je6J18HrRXEl/9sU0cIZ7mE57i2RXEMrUvDEExxjR6SGeMhkl
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=QyXUC8HyAAAA:8 a=CbDCq_QkAAAA:8 a=yMhMjlubAAAA:8
    a=ZwCpfEX3OczFsJB-QfsA:9 a=wPNLvfGTeEIA:10 a=1qrBK16LubpBFNPVNq2M:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753166AbeDIAY4 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:24:56 -0400
Received: from mail-sn1nam02on0128.outbound.protection.outlook.com ([104.47.36.128]:23328
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755105AbeDIAYy (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:24:54 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Alex Estrin <alex.estrin@intel.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 110/161] IB/ipoib: Fix for potential
 no-carrier state
Thread-Topic: [PATCH AUTOSEL for 4.14 110/161] IB/ipoib: Fix for potential
 no-carrier state
Thread-Index: AQHTz5iwNWI6wOkZp0ehajj9vGv+LA==
Date: Mon, 9 Apr 2018 00:21:22 +0000
Message-ID: <20180409001936.162706-110-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0983;7:3Hs3AXIIvl+bh2LrnLwSAMkE72ZiR7v6r0hVlr2im+KzfrMzG4NQ5gss0APccqivdm87zXZfkUySfVOpDHoNzn4Eb7JVMiFo/tZb2o+iZb/IF+tkhqKXzKXCv5htJPKNYySLAuoxQCr1w1DvsNd0q2XdC/CoL+yNoIaHcfh8jA5LbwAGAiB8wgwjMIiJzS/4oq67kxJ27mL+p+VRiFOonjK4dar3BhoGVNz85ZbaOzmK/U8h2tzmKrnr/lUdohXJ;20:9q71y28ahHzaWa5GUcTCIxfrA74Hf33alfmHdsqKBoFspbODOyNhb/yVVVsZFiZNDAr9BHFxko4InNERpaKK5Qi8PStnqicLO1YoWkmdSfOk8J/EMFlbbXU+RsIOhg5IRHi6QQmApNJCLZItBaJ6SXJUAqk+BjnAaA71c5I/ehU=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 596ea7e3-ab8c-416a-e146-08d59db04d90
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0983;
x-ms-traffictypediagnostic: DM5PR2101MB0983:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0983961268EEC3685E003C47FBBF0@DM5PR2101MB0983.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0983;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0983;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(346002)(376002)(39380400002)(366004)(199004)(189003)(478600001)(59450400001)(72206003)(10290500003)(3846002)(102836004)(6506007)(6116002)(25786009)(6436002)(66066001)(99286004)(54906003)(86612001)(6666003)(105586002)(53936002)(76176011)(316002)(486006)(7736002)(22452003)(3660700001)(86362001)(97736004)(106356001)(8936002)(110136005)(5660300001)(11346002)(446003)(81166006)(81156014)(2906002)(8676002)(2900100001)(1076002)(476003)(2616005)(10090500001)(6486002)(107886003)(36756003)(4326008)(2501003)(68736007)(186003)(305945005)(3280700002)(5250100002)(6512007)(26005)(14454004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0983;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: MYNiJTkaILg8tZYAgqpcRl0+EBVIVN3hOUEuhvIjuPh2f702dE0KtiRJvrQ+LxC8Z4b1Wdp3AauKXLziBYxXfGKu93ojjAwqFQkCB3W7PXHLDAVhChzZR1VOuycL/VapKDZu/7nzty8EX08SGomP8OVN72tlwiHOYE2JG092U7EUTIAD/Kez7OUjHSAT3wPD6ZzGKYazAzM+waQd1EnL0IJYD4bmKplLgtC1zRDIHuroTc0NDA7PgEFvEciZ79rLs2Rdd0GfEtLLbvkQLXjR0NEwpeVBzOIGHQKtV0UO7o+fRSHfmLlIDKqAB5ntVIWrGUoB/a7xAsz20A0V7n7xjXsQqQWquzvv3O8SA0cai9ouDXrQ2cRgcyIEoJSEKXk6xIipK9f2ZkoZEUibYGFrxhtR2+Jj+1Vi9D4RPxXdYpk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596ea7e3-ab8c-416a-e146-08d59db04d90
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:21:22.3156
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0983
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
index a009e943362a..6bc9a768f721 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_main.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_main.c
@@ -2273,6 +2273,9 @@ static struct net_device *ipoib_add_port(const char *=
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
