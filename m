Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1576849-1517683153-2-9389364690927241625
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES ensvda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517683152; b=eXAgT8CzUs7S1nNNtFuc2UH+0/9fPx+tw2WFeakqpqeGJb3
    2w682ww/2kuj84B3rGpOz9OvvD98CjtKTkYK7ZUgLBM57eTRgEn6uicYGof8RjHX
    ymi3dQBYajjZOgs/96EDoroIyuouswovT0elcRRqdW9CT61MOgv9ZXNIgdGWcw3u
    daNcWyIsKTVhjTfWynDKudBOKetDwxKgjYbsaeFi2xXUgL9WEY0c95OqCVMQtXUL
    Q43/g4086mPiRfA1Oj+SH6YQbYyFi/H22gOMwjYGiInS+LwuqvFnDiOov2V7eP66
    LVvSt6RvMHgnPE7RNVLMy35zMVLxUqDjo10huPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1517683152; bh=1N7Hzu
    7fhFuVzeKWRshBfYuN3yLz6wDM2yWl1v0UHLc=; b=qbS+MvH1ri1eHZ6lK5QcUK
    NItNLh9RKgtuf/RGKP3K3VbRYRxDjhDEoKCagOAgRBu2Gl6y0UzMiElzNPWKFB7B
    tI/2265/+qKzR0lqGKcB4q21OjpOn6/5vPTUlsIu1NkGURYc77d6F5ChQVEs+SLb
    4ydDQHeu2PNE/97ERjoHfW69Ey5EoE3Y8ay0qQml6gcUeoe7BQXLpeqHfcV4V3rR
    MutjOv/ZDJYdzM5GuZCfmOd4NqP3lDPWKM7rdscZt0hGLzH298PQADcbf4VicuBE
    aY8FNwvc11Lh3vys2hK9zvztAfZCRlCBHxzun268t0QGnSk5gc2gNg51sIuatz1w
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kI3jslEk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=kI3jslEk x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754905AbeBCSjJ (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Feb 2018 13:39:09 -0500
Received: from mail-bl2nam02on0129.outbound.protection.outlook.com ([104.47.38.129]:64103
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752793AbeBCSDe (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Feb 2018 13:03:34 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Sunil Challa <sunilkumar.challa@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 098/110] bnxt_en: Fix population of flow_type
 in bnxt_hwrm_cfa_flow_alloc()
Thread-Topic: [PATCH AUTOSEL for 4.14 098/110] bnxt_en: Fix population of
 flow_type in bnxt_hwrm_cfa_flow_alloc()
Thread-Index: AQHTnRkEdrzB378z9kSYywfIFVdPow==
Date: Sat, 3 Feb 2018 18:01:30 +0000
Message-ID: <20180203180015.29073-98-alexander.levin@microsoft.com>
References: <20180203180015.29073-1-alexander.levin@microsoft.com>
In-Reply-To: <20180203180015.29073-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB0993;6:odYu/2gwLirkTsmQi6MbIUi2lYnHA4jGnK/CRnmWJ32poHQ8UU9FnwXinpKfdo0jpVu/44lEortnhQsCbJi94VCaPNLFxvGQKrmO31ZNqixMh8uHAk/PaS/FnQbevtx9jPtYjds7Hj7hvv1SZFxMMgcTF0tjuMywOq3jh8md4Iq7Mp1XqgeSfN8LbY0PqaetjK72IyN+QDoLF5+pPUxZ4pettgRVRjJR7uvlkDF6XEZcfYnMrfJSgbUwn9S+oRbjG0xrAAbsCh5ZY720QU5aZsHYRDwfJwUohRqONU5SVI0ckDT2KtWCxFmdxj+vUP/OcD0sKVPMasIlULUv8gMLJUmpTGLSSjAykaJfRnwiFgAsD5avIAv3ui2OyD1ZKA2F;5:MJhjtI2lMEXMCF7RiCn2hesQMoNTEHiFDRPSWLJ829j0WNt6+74Re0X1VCPAKLB6iS61I0i5JTI34ArnK+TZQgYGQSlVV11FOU18J6qiv3/bp+AGavpIwrjL4KwXIH1ExmEpCo3bNBQaVQeOMBdVCaqisaT0t0NpSL5ealaNeg0=;24:hWhQ9gPYNoyOp3Ea2IpVq69uVR0EXBMZZO9hKA1Tu6dlpP8/liAcCy8JSM9MV5mXwJKUEj1achuzfp95w8KWqtzqMWeGzgiE6OMxSeIluDk=;7:BU3e6mlOAjGJsRG7TMB9Yjj0nquPvYWz0W2bxBR7YPNJLP1a6L1Fv871507X+Z//f99mwwJboUKB8zlpB5g0VrFaPx+clFfh4bUbLXFjIZcviYD5hl0BvUsaetJoYceNMu1AwOiRzr9f+KgmJfWKUqBBlF6PTVFivh1sXDS9RR5CepcA74auzlvq/wK5z8zyVXz3DnZans9OZwVWHmzEjWR4bBcTBWwQKTn8oFhFAehRGAv7oVqR0rhttFj/uolZ
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0540483a-7e93-4648-423d-08d56b3056c2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:BL0PR2101MB0993;
x-ms-traffictypediagnostic: BL0PR2101MB0993:
x-microsoft-antispam-prvs: <BL0PR2101MB0993869BCDB2A9C99293EB4EFBF80@BL0PR2101MB0993.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231101)(2400082)(944501161)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(6072148)(201708071742011);SRVR:BL0PR2101MB0993;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB0993;
x-forefront-prvs: 05724A8921
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(39860400002)(376002)(366004)(396003)(189003)(199004)(6436002)(186003)(3660700001)(8936002)(105586002)(2906002)(6346003)(6116002)(3280700002)(3846002)(97736004)(6486002)(1076002)(2950100002)(6666003)(81156014)(86362001)(76176011)(102836004)(2501003)(5250100002)(26005)(68736007)(10090500001)(81166006)(8676002)(59450400001)(53936002)(5660300001)(22452003)(305945005)(107886003)(7736002)(4326008)(86612001)(36756003)(99286004)(316002)(6512007)(10290500003)(72206003)(6506007)(14454004)(478600001)(25786009)(106356001)(2900100001)(54906003)(110136005)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB0993;H:BL0PR2101MB1027.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-message-info: OyrQcDcvy81rS0e6wpOqTWQv7sKs6xAjAdogSmC441K+lp6D2mAvW+OtXMIPAFbG2WuD5ytgWc3uFl4QBt/NtQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0540483a-7e93-4648-423d-08d56b3056c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2018 18:01:30.3471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0993
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Sunil Challa <sunilkumar.challa@broadcom.com>

[ Upstream commit 7deea450eb912f269d999de62c8ab922d1461748 ]

flow_type in HWRM_FLOW_ALLOC is not being populated correctly due to
incorrect passing of pointer and size of l3_mask argument of is_wildcard().
Fixed this.

Fixes: db1d36a27324 ("bnxt_en: add TC flower offload flow_alloc/free FW cmd=
s")
Signed-off-by: Sunil Challa <sunilkumar.challa@broadcom.com>
Reviewed-by: Sathya Perla <sathya.perla@broadcom.com>
Reviewed-by: Venkat Duvvuru <venkatkumar.duvvuru@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c b/drivers/net/eth=
ernet/broadcom/bnxt/bnxt_tc.c
index 7dd3d131043a..6a185344b378 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_tc.c
@@ -327,7 +327,7 @@ static int bnxt_hwrm_cfa_flow_alloc(struct bnxt *bp, st=
ruct bnxt_tc_flow *flow,
 	}
=20
 	/* If all IP and L4 fields are wildcarded then this is an L2 flow */
-	if (is_wildcard(&l3_mask, sizeof(l3_mask)) &&
+	if (is_wildcard(l3_mask, sizeof(*l3_mask)) &&
 	    is_wildcard(&flow->l4_mask, sizeof(flow->l4_mask))) {
 		flow_flags |=3D CFA_FLOW_ALLOC_REQ_FLAGS_FLOWTYPE_L2;
 	} else {
--=20
2.11.0
