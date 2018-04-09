Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3836577-1523240686-2-10594852146839962426
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523240686; b=d+1MxWYbOvT3mf0CBK5daeTyoP7t7Nx6WJ+WKuCU18J3H0ux2B
    TpnlopJWyOPgIt7e/hGF1qNdIZoCcKzvPhD37p+jSLaErNXdDJIC54WCxJRk0QAT
    aURhM4ck2U06oRRrcjKk7HigcDTUfrZkIQyP612FrsZLqwkWOAomffHjCcKdnFUQ
    TIpCf0Xr232Azp3uZ5ooGa6Kp1zFxdGHnuhJWgQ1GbnF4CPVBLsaYwsXVDKH2i9Y
    rtAAFKa+AytR+VXypQKBW2YFKur2pWDP+iPOGo1+KXPl3fLCRyA674nskK5tLXM9
    poU817Bm7oSWgTOtPX0BJ5v8SktSLHbPaG9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523240686; bh=ka32UgextI
    xWMQtTU72qOcE9glpKSNJqI7BEF6Ge8pM=; b=JPptSO+NXRkactuFdhT+exzrOm
    CWweV0Ct6n2wAXtkL5K5KyvO6DgYto9w4cb8480WSvHCT2ZvrMkQ7SH5dXscwEbQ
    1aCWRlm2J0/NR9xYtH3eCz4kQJtnRqdHTNzz5rUqjlT8Fp4TtwoZJ1Kdb+RChDuN
    AgUIE5IDIe83vq3CMVeSg+e6VR00u1EbpeZPsNXfym+3bxkj2ZVU6PjkBvjIogRh
    eCwWMQ6K3EsFBVYtee04Jfe/fLTH8PuE+jByIwvRb1u29g8lM2v2e0ak5RCdHr4e
    EK8uf/dDqBMAC56Bpc2cmmDNkXS2jHjC+5tKpzslnN5sEEtuqvHLIFnfzDLg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Oxg/qkFx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=Oxg/qkFx x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPvzX91ppaGJGzy6r+u9gmYJjYj+MPd2VFwV2kkjNlzC7HHi37Ya2OBpqCta0h/a1uoyvCNbXm6YQo1MckwlxoNkLqx3aB185pnuIjGV9Jw7a9lPVPoW
    pWnRO4EQlTBOEFqjiZeveStrxWhy+Je/kj158FkmiWw4rRnMJPFH57oB3fA7aVt4R+LDpBIf9KFEXkb2m4BfBZj8RbwB+apGghw6N5Was05fkiOBjdSKPB2o
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=IpJZQVW2AAAA:8 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
    a=gAN1_f6cqVVhjMO0EXwA:9 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754635AbeDIA3Z (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:29:25 -0400
Received: from mail-by2nam03on0132.outbound.protection.outlook.com ([104.47.42.132]:47327
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753073AbeDIA3X (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:29:23 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 099/293] mmc: mediatek: Fixed size in
 dma_free_coherent
Thread-Topic: [PATCH AUTOSEL for 4.9 099/293] mmc: mediatek: Fixed size in
 dma_free_coherent
Thread-Index: AQHTz5kUr+wAACslL0i0zZ1N7AWofw==
Date: Mon, 9 Apr 2018 00:24:11 +0000
Message-ID: <20180409002239.163177-99-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0967;7:pQQmFq41dY/iacJ5AvA7K4TXtZUIU56XxCx30kBcJPlEBUeJpJFo3KCgqZi3DjHR2Y9B0N9iiH0PQQh61mvRubYGRPaiJEQHj8I74+fh9Eyt/UqBmgirQsLYrsl22np9vFF8eJIJc1Cxd5xSLsBeDfuSlAKvsjyWMbaWsxhXp1xGLqESWGoMGHfV6NW6xaeCGh4CA7jhNVvV27pNlE+MD5jaW0qhZDwCSAt9fC+Vz6q6ekBUJk0ANKgiig6K0sL0;20:CjoyiH9ZvU5BdxUVlvbIhRbw/dIIpaJLvvKJllwY0ITtbIjfcvdk4KmSaLVvIMefRPOUFOHMvIQlMaTRT9ifgVfiP0nTKEGHnwGCRxL9IxE9IzbzNYGe5VG5kexFYmNzZGz5ovV3nOgAkK6UoKiI6tjUXLBzjjj7cFLwD+6ZHmQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 73750d54-5e97-43b2-efee-08d59db0ebaf
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0967;
x-ms-traffictypediagnostic: DM5PR2101MB0967:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0967DB986235567CD082EE2AFBBF0@DM5PR2101MB0967.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0967;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0967;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(366004)(376002)(39380400002)(346002)(199004)(189003)(6506007)(486006)(575784001)(86362001)(14454004)(59450400001)(68736007)(102836004)(99286004)(26005)(3846002)(6116002)(186003)(476003)(2616005)(1076002)(3280700002)(86612001)(72206003)(4326008)(446003)(54906003)(76176011)(11346002)(2906002)(22452003)(3660700001)(110136005)(97736004)(316002)(5660300001)(478600001)(8676002)(6512007)(8936002)(107886003)(6486002)(53936002)(81166006)(36756003)(81156014)(10290500003)(6436002)(10090500001)(25786009)(66066001)(106356001)(305945005)(7736002)(2501003)(5250100002)(105586002)(2900100001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0967;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: vPPlRsdomHbDMsm0LJ5/Vhx4veXOw5KVWwS5Ec8UpMjMNfPuzayWbkdw0mCvGQot7yZhvUaGPPkghSbZdiHMjxSyP8sm0rZ8UkGnKjmpT5IKR8qKN9slqfRSmX4uAiHGf75Wnjc6PU63kamTE0JHBmqfbFuvQDMnxiXAm8pUewpiIVJhjBJyugx0ZJkUcIaZMNbHK5+MpaWkpQg8xb/Jqmf+aMU/RNpT/vc0i8b/9vQTP6DEF5cMptVX9tq+iA4ra+A3qxPCmxfxhPrm/kO+OGuVw86/8rcCaMsDbStqno0dsmK7qT8U5lDeEziNLe6r/jWzF+XKSVYqZlCfaiPAyv1GVCpSQTBdXLF+8cL+zK+cKZHLOgm3aGWWbzzdo2ONlsqi/HTouWiA9RXKUu6sLV5Yp17hTppb1wlGbskMbjU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73750d54-5e97-43b2-efee-08d59db0ebaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:24:11.0343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0967
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Phong LE <ple@baylibre.com>

[ Upstream commit 16f2e0c6ffdfaf964bb0a6d5e67253a1c8116f0e ]

The dma gpd dma_free_coherent call size in invalid.

Fixes: 208489032bdd ("mmc: mediatek: Add Mediatek MMC driver")
Signed-off-by: Phong LE <ple@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/mtk-sd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mtk-sd.c b/drivers/mmc/host/mtk-sd.c
index 6f9535e5e584..a04ebef80abe 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1647,7 +1647,7 @@ static int msdc_drv_remove(struct platform_device *pd=
ev)
 	pm_runtime_disable(host->dev);
 	pm_runtime_put_noidle(host->dev);
 	dma_free_coherent(&pdev->dev,
-			sizeof(struct mt_gpdma_desc),
+			2 * sizeof(struct mt_gpdma_desc),
 			host->dma.gpd, host->dma.gpd_addr);
 	dma_free_coherent(&pdev->dev, MAX_BD_NUM * sizeof(struct mt_bdma_desc),
 			host->dma.bd, host->dma.bd_addr);
--=20
2.15.1
