Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1025811-1520488978-2-17294699924813323817
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520488978; b=LGtxQ2zV3XmcRDnQV3FYTWni4094D7c6ImHmKVpCqoNbWPU
    o9HAr3PQV6Vy+Era1hw1dI6tyu9xSs9tatz0fyAwGI2bFC46+voWQbRi+kJYcPMR
    uuyxJbcznONpkhyB/e7f1t6tR+6CQ1CdRuYyQrhPfUQ7F4LoGWc4/b7fwMcks0+z
    04xpDayiWGXF6vquDowVfg4c4G4h6xQzWywgM2D/SwL8vl+SrZaleu66Qz+2Y1bm
    c3hwTvMwBM77gCcPvAVjeD/oL2kR6fUa4vQUqoeanUovBE8p3D2dDQPqxHuWTcyT
    C12/lI80tnKmjXLQem2vlD0DHvVxBsCUck/lerA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520488978; bh=4GWn7K
    8ND7NwFYMiLy6wenjFxs8SsKykl0xn0V3OTiQ=; b=FpDRLZN1xwqOabHxRbhRgh
    RSWGLG5gzo7o5TpHi21rAyrDotX6/j/Z4m2ETCC//0bVWY6t7T8n6zOLMPhDPISO
    vsrNDb04e37mHNnVU2HWYQKunGaSBy/RDg+iJ/VkPPenM5qLl1uvJHUwxk6TDHlA
    KEyluFNPLpjldtPCVNP5xaNlIyOV7by+VALKmH+1upKOEfUg9EdOuEOq3USItuwS
    blexcqxoS3iRtBWaetd4Ur47H0DoUOVOgaHZdd8Zt2k2+Irvfe5vHFqsfNnvHAxS
    zwOLeS1b21aC3HHQZ96Hej1uhBn+lxqqozzSlB7vsKghrmt76tj3tKY7aVno7D3w
    ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kOV1v4tM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kOV1v4tM x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755375AbeCHFCe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:02:34 -0500
Received: from mail-bl2nam02on0104.outbound.protection.outlook.com ([104.47.38.104]:33440
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S965893AbeCHFC3 (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:02:29 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 112/190] IB/rdmavt: restore IRQs on error path
 in rvt_create_ah()
Thread-Topic: [PATCH AUTOSEL for 4.9 112/190] IB/rdmavt: restore IRQs on error
 path in rvt_create_ah()
Thread-Index: AQHTtppE1UypIBPmU0WVaSaR/Q6Ihg==
Date: Thu, 8 Mar 2018 04:59:41 +0000
Message-ID: <20180308045810.8041-112-alexander.levin@microsoft.com>
References: <20180308045810.8041-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045810.8041-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0997;7:9hgjiTqGbpGM+31avFgT9XXws0hPRe6IEfJjebzk973nc68y6eUM79jCf2b8lFsUjzjTVSg5pQpD/0C8WfPcTVRw39rRF2RlW8ZdhDjNcAHumyCjEOO6QRF7LReNvS9nzLTZmI4s1cEAzDsnzs7Z9eWC9byTbCXtiNxDKVSiYNrNzfoscs5YNTrNt6iE72S6+QTlRndoMo1cNSDs+odx+ZcaOpISITcs4tyiwp08FxnZEIlUlDRoFcR/3XFGfMK5;20:eLtm+BKZ8CyQTLWRy4UVKFB16vTMnGkooD+2D9OMn11356Au4r9DBBSjIGPX5PsKHjOFUlrHE+8kb5n0zkXgeFvKa+uaejwfQM/tD101fluS50MHDsBboIUwjcOcqV/+Z7RIeXw0jZXY8G49f7NiEroE3RWiSIxbLXaYQHXcDS4=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 2300852d-dd7c-4822-171d-08d584b1c354
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0997;
x-ms-traffictypediagnostic: DM5PR2101MB0997:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB099758B5FF36C47A3D24C196FBDF0@DM5PR2101MB0997.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0997;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0997;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(376002)(366004)(346002)(189003)(199004)(97736004)(54906003)(76176011)(2900100001)(106356001)(99286004)(110136005)(316002)(3280700002)(22452003)(10290500003)(105586002)(36756003)(25786009)(72206003)(66066001)(3846002)(6116002)(3660700001)(4326008)(14454004)(1076002)(478600001)(2906002)(10090500001)(5250100002)(6486002)(86362001)(575784001)(5660300001)(186003)(305945005)(8936002)(81166006)(2501003)(26005)(2950100002)(107886003)(81156014)(6512007)(86612001)(6666003)(8676002)(102836004)(6506007)(53936002)(59450400001)(68736007)(7736002)(6436002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0997;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: 40VIQAeDRx0Gf9bcrSoCXcedj36i5V64ma9Q/iXQ51XUbeE4LEqeFqQxaR7+su3NqbdQF3PCigvMxht+6KKKMfyxB35ZR/PoK6fIFzLbNI4XHzCCi7yrJ0zLNw8BhFGLcqYYimEYY90KHZDjpHEdgJIH+mbsF2XrvulcXTgyZv9WPULt6Yv+VN35nOkoO4DOZqZGwjjgtXMR77iPzLrULQmJ+hKtogDTmlM3/5Yb4FIa6ElnBCIkNdLVa81GDpzoCZj7yXePgcBXM6ZTNAS1o1+2yZgcCSo0hzQwqutNHLrE30mEU8t2PjtPh8209TkFriC0QE4wSCQkfriRtCx0aA==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2300852d-dd7c-4822-171d-08d584b1c354
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:59:41.2271
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0997
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit f0bb2d44ca26b7090dc7bade8877b77005f07dfc ]

We need to call spin_unlock_irqrestore() instead of vanilla
spin_unlock() on this error path.

Fixes: 119a8e708d16 ("IB/rdmavt: Add AH to rdmavt")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Acked-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/infiniband/sw/rdmavt/ah.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/ah.c b/drivers/infiniband/sw/rdma=
vt/ah.c
index 16c446142c2a..b0f09fb45c72 100644
--- a/drivers/infiniband/sw/rdmavt/ah.c
+++ b/drivers/infiniband/sw/rdmavt/ah.c
@@ -119,7 +119,7 @@ struct ib_ah *rvt_create_ah(struct ib_pd *pd,
=20
 	spin_lock_irqsave(&dev->n_ahs_lock, flags);
 	if (dev->n_ahs_allocated =3D=3D dev->dparms.props.max_ah) {
-		spin_unlock(&dev->n_ahs_lock);
+		spin_unlock_irqrestore(&dev->n_ahs_lock, flags);
 		kfree(ah);
 		return ERR_PTR(-ENOMEM);
 	}
--=20
2.14.1
