Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1145125-1520116451-2-5418176384780382618
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
    t=1520116451; b=XPClsKzxcnsgstE0/DMkEBtjNU/yFP2sLAZJ4A3j/AzA957
    6qmP8pmF1nd07VzRT3EAcpgzttHCShpxueHYlC+hYBIwV4UNabTDogXCIuIm83qe
    5whECDpp0bvZdofekVEfnIq9VwMWiZEkqigZQ7sW8Sr8tSrEGn4tQX/VAf73aZ4c
    9GV2ToClUQFnXxIp16NhHlhxSfFG/D6UaXKa1fp4cK0AdRZ+dsFBnPTXMAxWLJWh
    E0RyFYdaWEB/2wU8ot7HJJ1I66FSV49b+Vf0CAfyfKncWpwLMHuosJrHpGEIs5TQ
    xyZ97+bMmZ+xlanTIPvNfHA5ipoYr0BC4ZMIZXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520116451; bh=mcNeyS
    oyv7pSeotOxstZwxkW3zBO6dGxXfHZtbfKd0E=; b=fGMGiXjdKDGb3hdDKt6+kX
    qp0x7a/LkTGKhPw5lGtkTF8Kblv7pnUPqmgLxWxFwsDSvA3jgLz5jvFEvJayt23Y
    PXdaAqs/yk+pLhqBpF0sEzS3qN35E1vKlF1zJiGJHFuhiC6T8fiCyxuHC7LZSA5m
    ZFaTZJtcX+8PXIXqiuBpyg0vh3wnt783XxQLHGZGNK2dh20mqvNKuJ0hlvt/XPCN
    v02C33If1sGAug27WQTT6KbnBWxhQdpEfHi2CmFAQPX5MeipTBSLLmdBCUdJmmoL
    qOnT+rBPwjHZH1hHBIHY0sQCvwiSPS48fw0kCZUNRJGki4YNRKeQpgrEdfUz+MXQ
    ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MRQiedbr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=MRQiedbr x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934082AbeCCWd7 (ORCPT <rfc822;greg@kroah.com>);
        Sat, 3 Mar 2018 17:33:59 -0500
Received: from mail-by2nam03on0128.outbound.protection.outlook.com ([104.47.42.128]:37280
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933058AbeCCWd5 (ORCPT <rfc822;stable@vger.kernel.org>);
        Sat, 3 Mar 2018 17:33:57 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Andrey Rusalin <arusalin@dev.rtsoft.ru>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 095/219] NFC: pn533: change order of free_irq
 and dev unregistration
Thread-Topic: [PATCH AUTOSEL for 4.9 095/219] NFC: pn533: change order of
 free_irq and dev unregistration
Thread-Index: AQHTsz8BZ0T9FqAouUmrjY7EwYMT/A==
Date: Sat, 3 Mar 2018 22:28:50 +0000
Message-ID: <20180303222716.26640-95-alexander.levin@microsoft.com>
References: <20180303222716.26640-1-alexander.levin@microsoft.com>
In-Reply-To: <20180303222716.26640-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;MW2PR2101MB1065;6:1M3IixIYXMUMi2Km8VztjBPnFlJDFJleSz5O192AR9GrrZ6gdoVKIMAayL6LznpP1kCEuCu9tT9yq+Wah6geSTwq4L7WPUu9KtrF1ExMTrZFYNcUxa/1L3SBO+ZgBbtZyh/VmGJaith3/1w7/Hgh5idV7U4HXeiFjJ9dw02EYFjpOg+crpLumtqYR/tIgAODU20qlTkzV+bzmbcS3sq4MZqLdEg/ssJEe5CqsmaASi2CuJE5WsJi/Bn5J/h+yBVYTuBEnZJB0u486bkHZFCOAnDowo+XrxPhETlNqUzbQ3MOu9Nvpq15flp+UUVsjmVH0GYHS0MHHkonu6pYLnvJuRz3cP52qP0nb5p7qDX1/ZLCX3Uaaz7AteBo9VkPmGXz;5:Id63/s4nqCbCPHQiuJs88NYz0CupoePjIGFdy9zhxsMHkvjX+/sKyscH+SMJ68K4AWJ3yUnZR132CZrhNPBVLaoxtSqS6hE4PtHVV5d9c/1d06YTRmhfBKzuKvi3b1urWtSbPAA2BW57Mz3DCLfwABP4/JuDBtNf8yJpSbJWuNU=;24:vzpEIlyqwRGN0RikmQwt19zDIqltBTlxuAQu09jqG7+e3Nl3KkiLggwyRMLh0WRbGw9NdnrcBplzLFkk1th1q1ZX+PzDaMJEZTNjvIRMXzE=;7:bq1IdYi293bKMgVwb6xyzOdnQhZrZd6R1SsKEsuvx83q63XGznfxMIYSdcFXGswQ4W8VrtU4WbTGOF+o0ijO/qrc9WtPhmKq7x+GVo7Ot2/VAYdvsPBBOm3EPMILeWm7jpLL21/+cNF2aYT7mV510ierVHlxRjKnFUFk14OhCagBETL5k/itOn+Gp8i/eoOHTZvcg7Ht7+RZeJwrrRRbjXq65SoB2CoGxqsSDG2ozGmZVJqdzYZCCTAPKKxeTmtC
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 186b0d05-9698-40f8-0ba0-08d58156d7f0
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(5600026)(4604075)(3008032)(2017052603307)(7193020);SRVR:MW2PR2101MB1065;
x-ms-traffictypediagnostic: MW2PR2101MB1065:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <MW2PR2101MB106533C4725693D1AABC18CEFBC40@MW2PR2101MB1065.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231220)(944501244)(52105095)(6055026)(61426038)(61427038)(6041288)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:MW2PR2101MB1065;BCL:0;PCL:0;RULEID:;SRVR:MW2PR2101MB1065;
x-forefront-prvs: 0600F93FE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(346002)(376002)(396003)(39380400002)(39860400002)(189003)(199004)(6506007)(22452003)(54906003)(25786009)(186003)(2950100002)(102836004)(5250100002)(2501003)(110136005)(97736004)(316002)(2900100001)(36756003)(76176011)(6436002)(59450400001)(6486002)(26005)(4326008)(99286004)(68736007)(4477795004)(6512007)(6116002)(10090500001)(106356001)(105586002)(478600001)(66066001)(107886003)(3660700001)(305945005)(86612001)(14454004)(81166006)(7736002)(86362001)(1076002)(72206003)(2906002)(10290500003)(8676002)(8936002)(81156014)(3846002)(5660300001)(3280700002)(53936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:MW2PR2101MB1065;H:MW2PR2101MB1034.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: mYjuxkukcFeWeagLt0Rl08oOLr4QTX215fKscGB/6Yk1/2vQn1TYVo2ucW1GSQ6mPuMZeAeSsxRT6nE+S78+k6DzFs4JvO460/TzB9ldEkfhPGYrBLXso2VMfATR9eUFeiY4lUUZHT8CbScYRaJREy7MH6W+YjHi9c4JdRARpCk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 186b0d05-9698-40f8-0ba0-08d58156d7f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2018 22:28:50.8382
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR2101MB1065
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Andrey Rusalin <arusalin@dev.rtsoft.ru>

[ Upstream commit 068a496c4525c638ffab56449d905b88ef97fe32 ]

Change order of free_irq and dev unregistration.
It fixes situation when device already unregistered and
an interrupt happens and nobody can handle it.

Signed-off-by: Andrey Rusalin <arusalin@dev.rtsoft.ru>
Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nfc/pn533/i2c.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nfc/pn533/i2c.c b/drivers/nfc/pn533/i2c.c
index 1dc89248e58e..11d78b43cf76 100644
--- a/drivers/nfc/pn533/i2c.c
+++ b/drivers/nfc/pn533/i2c.c
@@ -242,10 +242,10 @@ static int pn533_i2c_remove(struct i2c_client *client=
)
=20
 	dev_dbg(&client->dev, "%s\n", __func__);
=20
-	pn533_unregister_device(phy->priv);
-
 	free_irq(client->irq, phy);
=20
+	pn533_unregister_device(phy->priv);
+
 	return 0;
 }
=20
--=20
2.14.1
