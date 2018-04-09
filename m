Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243530-2-10074035414428169745
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
    1523243530; b=ePavLyWbuSSSTjLdhom12gEiOyvtG5l80Kbm6DzpODgYva8V6n
    1icUJt3ZcosEjyEMpYWFZEbC+PFWmdqFfKssSDL0dUzsbweNHY2U4OWXU3BKs/ti
    KLwe1W6vEy8D/lF4dRC9G0/Vz3AK5fFLUmYPygQyEHkKm99ibAqArCIVK7bO70UU
    44JexkSIr4tGYWNEJ8m5PUzqjf1BI8gCynnhZmFymPjv24IoEITeeTEa9wYs9tUs
    Thmn3D02tjkMxrT1BdMv+Bwj+xu+SQYoE8aHVx5pipXshLQOzyyj1NlB8Y8vmNuu
    CX7B7Kev67kn1kVg1JeHx0AOTFnuLRiDqZeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243530; bh=QDiIq7HlLk
    8Q8TKxkmKX/JAStV+qZIpbW7ub5eSgeQA=; b=XqPCofM7vOF27J8xQoS5WVJZhM
    B6Rv9QCa5vO7b6Oh1vNt+wCik3wI8v5CcnKFRs3oIlcG3igAn/xXfridHBTm5qOr
    Z5JoQ2oNx6+4mAZiGixggxZk067SHT1MzUsDFyoj3DegTMJNq1Ivt9t/H2OU2kdp
    QAJkUsHt/36LjThSV+MDCSyh6WgxhAPfkjLKuXcovXIp4E1UD0oiDwglyaHFm9zE
    myOnjKR7CfbowZWW0ZAV8BSKCpdUEg32POYbW79URC56kVdZzvXb0JKfND0B9L0C
    9G/l74UIrdv8fAl7wJlClDKCXZyJQXG5DtMpUD6SJCQIA2/ay7WIuY209Svg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=irlLpjTy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=irlLpjTy x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA1FPaxgXCjMwo/mJAQHRmjT7p0E5ZI5Ohi8jgkuhHrlLp7Dwz67MuFZHNpKk94kGDZi23qNXP7KqiUxKxTs2MgSI//2KKBWnKozs8L0wkeJLc53Riv6
    2fA2QnyIYR4V/ftdoj3btFqogk+TQcEI1m1oke9yW+kwxId8eNz/FIB1/fZCwdkbpTBG7rShJmcE6xPpydMbHC6QIZDqpDrKfhzdmirGS9Rp6rvMWXVVXDKv
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=FNyBlpCuAAAA:8 a=yMhMjlubAAAA:8
    a=Z87lGJRClcBCUypFOmcA:9 a=wPNLvfGTeEIA:10 a=RlW-AWeGUCXs_Nkyno-6:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754701AbeDIDMG (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:12:06 -0400
Received: from mail-dm3nam03on0092.outbound.protection.outlook.com ([104.47.41.92]:13920
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754966AbeDIAXz (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:55 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Corentin LABBE <clabbe.montjoie@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 078/161] crypto: artpec6 - remove select on
 non-existing CRYPTO_SHA384
Thread-Topic: [PATCH AUTOSEL for 4.14 078/161] crypto: artpec6 - remove select
 on non-existing CRYPTO_SHA384
Thread-Index: AQHTz5ideoep7nGgHUm5aa6VyoyTmQ==
Date: Mon, 9 Apr 2018 00:20:50 +0000
Message-ID: <20180409001936.162706-78-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0984;7:GQr4DOlTDNKB79iXd78mYg1E2EZop5jTdpRPlAtOwGw+DWOtqaQrIV72k14bZ1+nxzuGaBpDIRW1mQN6LlYaUazT/w0QpPtdmwoF/wCMLIa6ybqJCsJODKoJ2nmTxp0fmcZKotMH31QTLNjdxOOaiL2GZejC0JehW1bZkli3mCxhsaaa9CkDSySQmpC4aqYbyo+HqwrR0B0YD/JcGkiEiKJ3ZiNSY5V6oNYdaVsP8LvgYC7YEbalm4rnwNWQV6rT;20:hdpLCbiOm2b4Y5ib0Lq1njf5tU2eJIgzhasQdRcKJUfuevTyBO4HT5bIxeKXxEuAyU/JaTCNI7/JPnu+/jxVo6I0AULQQ5od7v925QK1Ob+jx5gxNjyLrt+tJRDTSjqGzyVavpV2HA4b45k8vl/bdaMCIGAW/CFO2AwQb+vy5JQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: a55e1695-dc98-4884-4b01-08d59db02ccd
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0984;
x-ms-traffictypediagnostic: DM5PR2101MB0984:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB09840B41D9B4DA8B0937A9F1FBBF0@DM5PR2101MB0984.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0984;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0984;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(346002)(376002)(366004)(39860400002)(396003)(52314003)(189003)(199004)(5250100002)(2501003)(110136005)(54906003)(6116002)(6436002)(11346002)(39060400002)(1076002)(486006)(25786009)(105586002)(2900100001)(102836004)(86612001)(3846002)(68736007)(107886003)(316002)(10290500003)(5660300001)(86362001)(2616005)(305945005)(4326008)(446003)(6486002)(22452003)(7736002)(476003)(8676002)(81156014)(81166006)(8936002)(6512007)(10090500001)(186003)(3280700002)(106356001)(76176011)(2906002)(99286004)(26005)(97736004)(59450400001)(14454004)(478600001)(53936002)(6506007)(36756003)(72206003)(66066001)(3660700001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0984;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: 1+j02U1QyqDQOlw5rn6cl5jxbXzYlUIEycoWMQotL0Byc7idZcIUfNBKnMz0zYgTL6ij9wwBfz8OfhQKGTK/k+vbGS8/ivjoDW3acVsGGb6n2qdp6mPPKs6ykpKOanQaGLHtiRIJGqwiwx6w5OKn3K6rwQBZpeJtFPzxgUJe3HQPf4QjI0FNUhwb4Nb0wVlu6MuBMtFP8XGtsV4zmc8kGPHxo1k7HgrwDHRsXcR/NSKv7xWdhK/tsH2epailKSN4pVlY6lWJ58+KDjWeZUxX79yAcxd3PMiwwFrCsGhSvWvAniWLWFbr761kEw3aOy0Zf5Ft8+5AD2pTTU5CdfKm/5bcMtrev6Ipc09OVFH0J0lco1jRRD2mpGGdqgF1jbUI586w9/lS0o1CbQfcHCg/t1zAPg2tQVJRyf89p47NQhE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a55e1695-dc98-4884-4b01-08d59db02ccd
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:50.2846
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0984
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Corentin LABBE <clabbe.montjoie@gmail.com>

[ Upstream commit 980b4c95e78e4113cb7b9f430f121dab1c814b6c ]

Since CRYPTO_SHA384 does not exists, Kconfig should not select it.
Anyway, all SHA384 stuff is in CRYPTO_SHA512 which is already selected.

Fixes: a21eb94fc4d3i ("crypto: axis - add ARTPEC-6/7 crypto accelerator dri=
ver")
Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/crypto/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index fe33c199fc1a..143f8bc403b9 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -721,7 +721,6 @@ config CRYPTO_DEV_ARTPEC6
 	select CRYPTO_HASH
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
-	select CRYPTO_SHA384
 	select CRYPTO_SHA512
 	help
 	  Enables the driver for the on-chip crypto accelerator
--=20
2.15.1
