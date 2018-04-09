Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3752604-1523237353-2-1884384871786161496
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523237352; b=FW704iZbIbZ9v25wTLndJMnSpRHnDLXoOZe4kxchUZSNI2Ps4w
    B0Q4nyIitempZYWKXp5SMStLiMAODXwcLmwitvB1hRCeRhibU43y3hBo/U0yIAob
    XPwOklnOUMILhIy7+LO/5H0JRBofcLUOe1wYBQURqqUgseYpjv2NpGxg27Z4SipY
    q23Q8tHufu6F617sFvymHlAtXbhhU29F2HqVKFJOD7PvA+YqvFLiQ1oaswNhMML4
    v1dMKA9KS1PJLeJjTJu46+EGn38pBdaKdOev2xmvlOib8/kdikAIbXc/xp5k2anB
    SH26sTdd1t/JZJobWmXr6v54cMjsC9LyYVMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523237352; bh=ByNqUA8N4j
    hcly1Xe5ElbCvV+k9Gz6NdlhtWxSbc5og=; b=IKCYqvNo46BwEESfD40Rj4ngqK
    wHf9HSw5CQhAJGCE4Kp8KNq4MMJJ+tu/VvCuvFlynJuzwXrv2LF4hu7hF6H33Upp
    PB/m2sl4bgvv4gQxR8REHWjSLyk5g2qN+wPosO5TR9q1E4x1y6LflomjV7bNAmAd
    pRdzLiZPcKmmTsUyUHOHoEhI613ZME0lTwFZXJDEw3avQzv2hEc1ht59Ps3uY/t+
    Sw4jpWQsHYUhzd6ZQHbOZsveJQYM9ZWK0vSuTfc/MBzA4PRBQ4Dn6jnbtsrSO/ZT
    pzTtLIXociTej75jnppon2j/0zvQDVGF4uJb9mkVM4nN1nr0npOAyZzZjyEw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W2Prb3+e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=W2Prb3+e x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfKwH/sqfDC4AQfgOhGZGqKGVaC5JJ/ITlXwsVX/bvdfFSeCqaPTWocH5jhOBc4ex8WfbBuvIuWHqRFoSqXB8C7Y3hhC4jZqGTnoAbAGXYq3tc7OM0lAD
    e7rU2lkfsyQG54u58NzYkByGVTpDJObOevJXs0THsO1T2GOqZtkriuibfXFFhptTzgAdAFueqYiM/vMQ/Z2aV8uBR9vdC4gyrME9i1dJ2rusLMGVHGW8uVsH
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=IpJZQVW2AAAA:8 a=KKAkSRfTAAAA:8 a=yMhMjlubAAAA:8
    a=gAN1_f6cqVVhjMO0EXwA:9 a=wPNLvfGTeEIA:10 a=IawgGOuG5U0WyFbmm1f5:22
    a=cvBusfyB2V15izCimMoJ:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754356AbeDIB25 (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:28:57 -0400
Received: from mail-cys01nam02on0100.outbound.protection.outlook.com ([104.47.37.100]:40736
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756659AbeDIAgD (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:36:03 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Phong LE <ple@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 051/162] mmc: mediatek: Fixed size in
 dma_free_coherent
Thread-Topic: [PATCH AUTOSEL for 4.4 051/162] mmc: mediatek: Fixed size in
 dma_free_coherent
Thread-Index: AQHTz5moirC5NnrsAECwVSVgAoICgQ==
Date: Mon, 9 Apr 2018 00:28:19 +0000
Message-ID: <20180409002738.163941-51-alexander.levin@microsoft.com>
References: <20180409002738.163941-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002738.163941-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1015;7:URBYvWQCh8XH5ibaYRYRMU//510jlEm7QfvzniqoWZYAXi53DF9WAolzNJ2bbnNwG/eKi+4/Cq/tfjVRqgXMQYwJxBce8gxrRWxX1U1JtJt3phNpj8myAFlQFXMLiGYL5yNOEYvezuJqEvU8j9+KmztJGWdxynCsa2fIgvMtqRNhwAEOd0/lasI8lbNyQ83BzHJqv3ZSsv1uizwI6mKGW/CjPuFo5J9MF2x43qHwfC3aSVpe+xW+mQW6M4IimuAT;20:hXr5RmO4qbbhnlAuvEnhAcPhUt6SSlFvmZdoD7OUYPVcFzqflHQ15R9JEfJI0nmtqT6AFi9ZKSnzfR5R/yHm9XnjdQzOVb5FYYz3f2tlTszoJfTzz2CgGh5eCo9164mq1xx3dcUKu9MU0eeWFtp4Xvi4WQpmX7HmCVG7yRaG6Gc=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2c585b71-b4a1-4218-8b20-08d59db1ddf5
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1015;
x-ms-traffictypediagnostic: DM5PR2101MB1015:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1015F79A7322E25D7D79EEEFFBBF0@DM5PR2101MB1015.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1015;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1015;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(39860400002)(39380400002)(376002)(346002)(366004)(189003)(199004)(53936002)(4326008)(478600001)(72206003)(3280700002)(2616005)(14454004)(305945005)(5250100002)(3660700001)(2501003)(2900100001)(54906003)(110136005)(86362001)(1076002)(107886003)(6506007)(36756003)(446003)(68736007)(6512007)(7736002)(486006)(2906002)(5660300001)(6436002)(3846002)(86612001)(6486002)(66066001)(11346002)(575784001)(476003)(6666003)(59450400001)(26005)(10090500001)(316002)(22452003)(8676002)(81156014)(81166006)(6116002)(105586002)(99286004)(186003)(106356001)(76176011)(25786009)(97736004)(10290500003)(102836004)(8936002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1015;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: XHRzJxoaaviaIMR/mvHViYe3qCvLAJ4NyJXdhhzWbEedi7EMrX2t6rfFc7BNJsP5keWMMbXby/SMgv8yiYZAGfVEg1AIeDEZlarbUUKXzpIFvRRA41CuGTScpoC8jM1KhWD4GSKI/C8dKkNjbN/uqAfA3dks0CMk+9s2yhDHB1RyZ5PFxJXjwHXwfAOhQYy/t0gvmyNmwfTzoyRpUI5c3LVCEBVLyk+nfLDMHkWtG4yfD3blmy9RBoRCrFDI0X/YdD7yof0iwwuhdoZhQ3hz0ay6Sch1VnZFh1YFA+NSiVrmINxWG+Esr2twkSW4eWbe1/5/+Q6UqB2ZjN6//NsDOAR3bStzvQSkIJiWaICF/9U/+rYjNoV/D4yY6NfMMuWPTAVheRg4xVNVwEvW1lBCfp7KlTPo61MGeMdGIIiT5W0=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c585b71-b4a1-4218-8b20-08d59db1ddf5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:28:19.3487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1015
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
index 0bf0d0e9dbdb..f701cbac2061 100644
--- a/drivers/mmc/host/mtk-sd.c
+++ b/drivers/mmc/host/mtk-sd.c
@@ -1626,7 +1626,7 @@ static int msdc_drv_remove(struct platform_device *pd=
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
