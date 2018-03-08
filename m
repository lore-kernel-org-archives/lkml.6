Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520487325-2-12426825396535623071
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
    t=1520487325; b=VHJMClYaXUsf+jP4bbItEMw+x1RONqxmrXS8RYeX3q6HReM
    VZ82HjLYv2qbYM573tFHQt981NbH8MO3ON0EmWdbF1iWB47oFC0GFL1nmyymXd2D
    oYfjy0PdyKBon1bKRg3L3+ZCu3GagrykQ0LX8iihpXlG6wXBmZY0OaP76tz+pMgf
    iENULCkhAq/v+usB7Lvh4OC72WPa8OdvylXaeDPGA0RMw0lmYvD9Wbm3Bsk8qEdn
    T5pN6c/B+gbLACAd52hoRBDUu9Mey8JHZo4LlRoVWVW1+nmIVhguJ/+X09eHZ7S9
    qhujDFXbFkFXIbN6ViSd01ysHAbwLgJAq6tnFUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520487325; bh=auOoV1
    TeTpxuGFEFfo3omzXTcf3O3x1vkfkn/IK0jZ0=; b=wcX6mT17W3eylDByigNxAV
    /ExiDlDSlmsKouO+KlwW4qXQGDHAHP30SIWhWa1bL2EYHhYWzI+GLoC3oMUtfWX0
    5iHOjpF+4OTDaFZZd5oN4Zv+whTiZlXu8M2Gsas9XHyZSxXlOXUCZ3Bv2RdCY3YR
    dUPr078yfjHvMgTfjPXyW1a7K99REb0JPQQBoMbb2hhLAVEQI8xe70YtE/a9d/1L
    jxwPDdW0mL0khlI3F+ukq8YshbMYbFMRRDXzJXMkIyk2zkr413nSWxEj1d3aokGp
    CXvQuECK0yODnbP/ThZsTVE4IkUaWnTOebVjHZlMnDThQ0/vU2g2lYkUBDE71oJg
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b40SDK2F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=b40SDK2F x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966381AbeCHFfK (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:35:10 -0500
Received: from mail-by2nam03on0122.outbound.protection.outlook.com ([104.47.42.122]:7628
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966342AbeCHFGC (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:06:02 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Dan Carpenter <dan.carpenter@oracle.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 045/101] mmc: host: omap_hsmmc: checking for
 NULL instead of IS_ERR()
Thread-Topic: [PATCH AUTOSEL for 4.4 045/101] mmc: host: omap_hsmmc: checking
 for NULL instead of IS_ERR()
Thread-Index: AQHTtpqNW8nqTLKVkkm4uf/4Hgb+1g==
Date: Thu, 8 Mar 2018 05:01:43 +0000
Message-ID: <20180308050023.8548-45-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0917;20:eEo0PiePiw3UnDS6ysoHylLhCkOqnWDlehp5mvwJVHnYINJBl6t5XFmwYvUOZ1a+dPG0U4mS9RFg9mtMSS5qSMKaAgEijdOEZKWFEgTjGZOFbET3izgIlhK5nhiVeLcdb/pNIBiUhXZmrx3w0MSB4t9Pju3QRB/iFXsktViI8OE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8cea0ba5-c2de-4060-8c3d-08d584b24962
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0917;
x-ms-traffictypediagnostic: DM5PR2101MB0917:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0917B991204E736BF9EDCE45FBDF0@DM5PR2101MB0917.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231220)(944501244)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041288)(20161123560045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0917;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0917;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(396003)(376002)(346002)(39860400002)(39380400002)(189003)(199004)(478600001)(2906002)(6512007)(6116002)(1076002)(7736002)(3280700002)(5250100002)(2501003)(6436002)(3846002)(186003)(99286004)(86612001)(53936002)(26005)(36756003)(305945005)(22452003)(6486002)(102836004)(10290500003)(72206003)(76176011)(110136005)(4326008)(10090500001)(105586002)(316002)(25786009)(97736004)(107886003)(6506007)(81156014)(14454004)(81166006)(54906003)(8936002)(68736007)(8676002)(106356001)(6666003)(3660700001)(5660300001)(66066001)(2900100001)(2950100002)(86362001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0917;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: i7ctavAeT0503PO/BjhGPz6Hyv2RDRVqMQuWrG0D8iWpIa+VOZ3kP3pf7Rc1/6Bq29fk+CQy+PnnHFHo+GZ/8uA/gfTL321KVNgs+J9RvsxtIF+nCGdhgXN+t8VIOjj3YX1qVflezglPCMm+CXTdtkw7pHeOzo/VYaWSJqIbj34FfM1svOvelB7PTmu06JWzb/cRq8hDqSsEYMySiZU1re75rBMIv+16knuaEdXNUYF5wo9HxYt3h8zhbUBYhd3pOZ/OLQ1g53f6Fz5NrmmU5UlCTgsoN2wOyhsC3zNQp/7p64JSKn0rHZ0cl19Gp773LhNx/LMxvWdTw0HqzIeiZQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cea0ba5-c2de-4060-8c3d-08d584b24962
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:01:43.6067
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0917
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit ec5ab8933772c87f24ad62a4a602fe8949f423c2 ]

devm_pinctrl_get() returns error pointers, it never returns NULL.

Fixes: 455e5cd6f736 ("mmc: omap_hsmmc: Pin remux workaround to support SDIO=
 interrupt on AM335x")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Reviewed-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/mmc/host/omap_hsmmc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/host/omap_hsmmc.c b/drivers/mmc/host/omap_hsmmc.c
index 7fb0753abe30..6b814d7d6560 100644
--- a/drivers/mmc/host/omap_hsmmc.c
+++ b/drivers/mmc/host/omap_hsmmc.c
@@ -1776,8 +1776,8 @@ static int omap_hsmmc_configure_wake_irq(struct omap_=
hsmmc_host *host)
 	 */
 	if (host->pdata->controller_flags & OMAP_HSMMC_SWAKEUP_MISSING) {
 		struct pinctrl *p =3D devm_pinctrl_get(host->dev);
-		if (!p) {
-			ret =3D -ENODEV;
+		if (IS_ERR(p)) {
+			ret =3D PTR_ERR(p);
 			goto err_free_irq;
 		}
 		if (IS_ERR(pinctrl_lookup_state(p, PINCTRL_STATE_DEFAULT))) {
--=20
2.14.1
