Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1312649-1520123146-2-5071212718301380369
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
    t=1520123146; b=GeITJ+bM4DwtR3HpRSDKwQZcG9odKOeKx/WBvT77Rd1AETV
    3joPfUzS9agTM8h4zx87rnmVdZ6hOPz39nGpMizVq9TzzLoIdCEOlhboB+iUeWoY
    pJbp3TA+SgvCFmyy2qeOtT8DU8tq4PFFna7lxxCtr4DUHCpl/jvPXDttHTQIoO+L
    nxUPojvVoCaRRIaC7jY/4XMLQE5TNprtqubQjDOINW92yyrApHTYyRUXPdCKbgoJ
    YN9flZByJMI2+EnB8V4b5wuS2h0t5bylysLX3JvI9GzjjswEZ/LqRFkJ8L2NjwJi
    R7QOoQeA1ljkyxivriAlJuus2rULiReAlOFkZGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520123146; bh=9uvtqR
    qhL/xTiMeKkIAoehXlTJPI3YL36FU8zfZTdHU=; b=CYrOik3uPPZeKptNEuVCDf
    nu+3uPBijLwLR4IPXV9im9kX5RJoFDB+T1vvaxlyYfbrDLsPOKrezZHR2NuDMTe3
    sHAFJC70TTzGLD3OeSUf/O2HlnAJ1Yk28yWC1QTaSeM9kDD0Pka8fi5WiDakUvkR
    Pc8/3pU+Jh2JNEqYlana1NNKGFc7+4YRRLGog7wbagRcJzsFG0dIRij77bfBhZX9
    qzDNhgu5nq1GrMsWocGrQcVqBEpPMUznikbLPtKj3tG+6nfY2UrvGr2S3hRuAAfU
    sGnxGfc8r3PVi33saySbQ6+OivQXRNMNgEv3HxJr7Nbav2povgpMEuwgn+ppc9cg
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gNKoHWCu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=gNKoHWCu x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932507AbeCDAZh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 19:25:37 -0500
Received: from mail-by2nam01on0106.outbound.protection.outlook.com ([104.47.34.106]:13662
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932269AbeCCW2O (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:28:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Colin Ian King <colin.king@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 17/84] crypto: cavium - fix memory leak on
 info
Thread-Topic: [PATCH AUTOSEL for 4.14 17/84] crypto: cavium - fix memory leak
 on info
Thread-Index: AQHTsz6hQBorxprDK0mrs++OHbtRpQ==
Date: Sat, 3 Mar 2018 22:26:09 +0000
Message-ID: <20180303222518.26271-17-alexander.levin@microsoft.com>
References: <20180303222518.26271-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222518.26271-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2SPR01MB06;7:ru31dB659En5VMybhYQtDt2B6KXs2vDYx0Ez1eXj0yy5HoAj7dpgpxLwowbr2nvoQ8Mp1B5LJOqGcZ5HFiRtHBBotTGZMtvL618E5BirEw5iBmq9AbuOYteub5EPQxgpEwDuDe62DkzrgtCVsRMbhcF+rbcmu0wwQlThJrCX0vJCZnaWIojAuLpboVMXWcjgDwUkhM16uvhvXWiNoxVkVuuhOiv0MqQ8dXeTMnpc8TWnnc3fuF02O1YCxA13kcJX
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b5185df7-587f-4325-832c-08d581560c5b
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2SPR01MB06;
x-ms-traffictypediagnostic: MW2SPR01MB06:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2SPR01MB06BF4762990E8BF11EBF10FBC40@MW2SPR01MB06.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(198206253151910);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:MW2SPR01MB06;BCL:0;PCL:0;RULEID:;SRVR:MW2SPR01MB06;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(396003)(39860400002)(39380400002)(366004)(376002)(189003)(199004)(3660700001)(575784001)(8936002)(72206003)(5660300001)(14454004)(110136005)(6512007)(4326008)(6506007)(26005)(2501003)(66066001)(86362001)(7736002)(54906003)(305945005)(25786009)(10290500003)(53936002)(6436002)(2906002)(81156014)(59450400001)(8676002)(478600001)(102836004)(106356001)(316002)(186003)(5250100002)(81166006)(6486002)(76176011)(86612001)(2900100001)(3846002)(68736007)(97736004)(36756003)(1076002)(107886003)(2950100002)(105586002)(99286004)(6116002)(3280700002)(22452003)(10090500001)(22906009)(2304002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2SPR01MB06;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: XeVzmHrbX0oLcY9rFZsZaNp/OalcfapUwc1GXPXdNIOkUrMKLkdwp+wlVKfzXYjA4OF0hLWAqBcuCIPKKJ0hCoIDuiSpTJpvd/z5sQYewU2Fd8i23DCr41Pw3wVnIVAIabMhdBNaJ12GAtk18qy5B0FMowo6AmHy8ZnmHhkBEWg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5185df7-587f-4325-832c-08d581560c5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:26:09.9004
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2SPR01MB06
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
