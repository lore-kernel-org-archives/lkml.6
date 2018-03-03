Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1379734-1520124435-2-10873368122453052091
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520124435; b=iovGlrSuJnfywPuo9zCBNcQFfGuH4FVPZTF0yynlHOPB7iB
    NOzWbuoH7ZIHJWwswqLNu29GOgujogwc9YOBZNIbmBJ9SZsSqjufw03p+9iGpTaV
    q43AGkEz21eF4J9EXMA95d/yT2+r4mHgsg2Uvr4PpC8Fc35cHLHqL1TdJws3+/AV
    IDbgIozxj4eQqPHc73aH3nC2p8bTU/cUOHQN1Md5H0sELulzSrPcY+1OOYyfhvg1
    WGQqwZABA73z2TPc9IWfV2XI/Ox2xRhNlJmTcKdxC9ZHogEIVg9pFuihg0vovDek
    anZwMpGpSiK0hkyevTYbkJkwh4xvFsDRJMu22wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520124435; bh=9uvtqR
    qhL/xTiMeKkIAoehXlTJPI3YL36FU8zfZTdHU=; b=Odl+4g2sN/sOSK3lknVFXB
    ph7zaBAzhBtdcV9Zdq/0F17P6Bxp246OXg6P7yaQFs1T29i0lkqHLCsGmclpS0SN
    YjKe0K8xQLR5btAl8V+jKxkIDAxmxIQ3FEQwCPSiHru+seUBt3W5MTwGgUqk+1td
    AcjW6Sfd6DhVdXqlHM24y7kn3A/rPX8GAbk6L48CAwGtV6p3BucAnYCxlLAh+YLV
    7ATl9BmhV6Ai6XS04gGHmQbBqVH2Lm7+iqjZbG72EZw9Zx54e3h409G9PVdfxX9c
    VdR/l5CwWtJ10aMQkem7LgOdZ0S8wJYK1dnPXRxFrk1nB9/Mt/8Ahg4LgoMr/lbA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ct2vQpS0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Ct2vQpS0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932374AbeCDAqk (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:46:40 -0500
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:48208
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932350AbeCCWYu (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:24:50 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 024/102] crypto: cavium - fix memory leak on
 info
Thread-Topic: [PATCH AUTOSEL for 4.15 024/102] crypto: cavium - fix memory
 leak on info
Thread-Index: AQHTsz5hzRLF5hcFck+xssfPYUK71w==
Date: Sat, 3 Mar 2018 22:24:23 +0000
Message-ID: <20180303222318.26006-24-alexander.levin@microsoft.com>
References: <20180303222318.26006-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222318.26006-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB0970;7:Kxi107s+C9i9lOlQzWgJ+kRbCvLIP6r9nKWD00msxB+kBXH2rCFElDIuTMtGp2/qyz9jUP61PS3ylEGUZPu4A1S32vF+X9LY6VcZ8WrN/HgSm4Lc7Fe2KodMp6S/eaIx850OGf8AzgAHtU7GcwgU+Xi5ZGoDQY6yPqsrp+V9wnGG2lFX9wAMteloTXGYuyY1n6piYXi+y1WT2/IlaQP1gt3ID92z+dK6f/TfJe2A62j9NnjMCqRbZ+8twXc9TaAB
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 68403832-a4ef-4a68-c5ef-08d58155929f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB0970;
x-ms-traffictypediagnostic: MW2PR2101MB0970:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB0970B24AA3745D2BE1E2CE2CFBC40@MW2PR2101MB0970.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB0970;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB0970;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(39380400002)(376002)(396003)(199004)(189003)(3660700001)(10290500003)(2950100002)(3846002)(2900100001)(22452003)(10090500001)(86612001)(6116002)(6666003)(68736007)(105586002)(5660300001)(5250100002)(106356001)(97736004)(2501003)(66066001)(8936002)(1076002)(99286004)(2906002)(36756003)(575784001)(86362001)(14454004)(6506007)(110136005)(4326008)(102836004)(6512007)(81156014)(305945005)(81166006)(7736002)(8676002)(53936002)(72206003)(59450400001)(6436002)(316002)(478600001)(76176011)(25786009)(6486002)(26005)(54906003)(3280700002)(186003)(107886003)(22906009)(2304002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB0970;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: x4NuNYkOpbUbhmh3Ztv4vWhnfDzFvBBPXFGC2Ez8l8Qx5nG/29Jq87/rRCOVhM/0CfHme7bRRszAjSNYnRZPZu3WuJmONqydqQrbPJfLu7OXetZOdHsoU6uzw2BY/EnkYsJBKNHUzAdOGqgCpc6wu9WLx6zmpMquqGV+o6TEGx8=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68403832-a4ef-4a68-c5ef-08d58155929f
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:24:23.3690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB0970
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 87aae50af730a28dc1d8846d86dca5e9aa724a9f ]

The object info is being leaked on an error return path, fix this
by setting ret to -ENOMEM and exiting via the request_cleanup path
that will free info.

Detected by CoverityScan, CID#1408439 ("Resource Leak")

Fixes: c694b233295b ("crypto: cavium - Add the Virtual Function driver for =
CPT")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/cavium/cpt/cptvf_reqmanager.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/cavium/cpt/cptvf_reqmanager.c b/drivers/crypto/=
cavium/cpt/cptvf_reqmanager.c
index 169e66231bcf..b0ba4331944b 100644
--- a/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
+++ b/drivers/crypto/cavium/cpt/cptvf_reqmanager.c
@@ -459,7 +459,8 @@ int process_request(struct cpt_vf *cptvf, struct cpt_re=
quest_info *req)
 	info->completion_addr =3D kzalloc(sizeof(union cpt_res_s), GFP_KERNEL);
 	if (unlikely(!info->completion_addr)) {
 		dev_err(&pdev->dev, "Unable to allocate memory for completion_addr\n");
-		return -ENOMEM;
+		ret =3D -ENOMEM;
+		goto request_cleanup;
 	}
=20
 	result =3D (union cpt_res_s *)info->completion_addr;
--=20
2.14.1
