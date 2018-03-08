Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-981117-1520486521-2-3077520605543803259
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
    t=1520486520; b=BEuFuaL976ht79W3UHacnhtIjCfXF6H1nsn+iQiJXjuAQ4v
    6WhHfBD/VnW1AHygUX+keTIG/1IpLh5RCT0Uui6frlqQNvgYCFdh5g0c5Q6V5oeX
    VJPzs/Y6zn6cj5KS/Y/9Cugc/xdCx1BBrkO3q7BMEUCyaEOacc0lIiszzxyYcUCH
    RrVkO4V8aZnh+jChKn0vguEyi5t/80CfykTa1hniCCqtg7QNSEabTaG0DcehBAc1
    DxmqwF/NI2xx5ji+Y3HJNTrwVIjtTGAUOMEUJz+BYOKvyAwG94bQUWpvsxut6ZTH
    FaQYM9/6qfc0Qzd8CgKgj64ybtNC7lYVDldFryA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520486520; bh=Z7U3nj
    sNhuZ1/3KiMNYTshiXKEcQrkFkAsRTiXoSQA8=; b=HLYJsOCBM1+xMlYZf50L3D
    +H/465ly9TomJrAZa9secAzWz6RnwGd8FMWxPYZRnSgxJjtssDyIqnGIyTx3/yYM
    ShFRsTuoWimIl1Sz3dp8F/7+mpUhn1qyti9kE6wqyYRTY/dvJbCPep5562f2A3Db
    z+kkOAcsufTVS/6+BoRHP5yA7bD+lqQldFruR/lK8FHCfYeQz6YAzNPF3SsCfGPl
    OOfvKAOSrNyIr9I30WIib49N8c+Y5v6emeFRTr0fReZmrlRXAjs8ry75fqxndI2d
    GqdsB3PiWHt0bzs3O1rotyzr0rj/qpi4qxPFPuSNJ+s8aayksZFGsfM5Dh/vv4LA
    ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UOBMYl+v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=UOBMYl+v x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966461AbeCHFVr (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 00:21:47 -0500
Received: from mail-bl2nam02on0136.outbound.protection.outlook.com ([104.47.38.136]:43456
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966685AbeCHFIG (ORCPT <rfc822;stable@vger.kernel.org>);
        Thu, 8 Mar 2018 00:08:06 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Vignesh R <vigneshr@ti.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 101/101] dmaengine: ti-dma-crossbar: Fix event
 mapping for TPCC_EVT_MUX_60_63
Thread-Topic: [PATCH AUTOSEL for 4.4 101/101] dmaengine: ti-dma-crossbar: Fix
 event mapping for TPCC_EVT_MUX_60_63
Thread-Index: AQHTtpqh8ow0/ZXAY0yfWbSQA26Tzw==
Date: Thu, 8 Mar 2018 05:02:17 +0000
Message-ID: <20180308050023.8548-101-alexander.levin@microsoft.com>
References: <20180308050023.8548-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308050023.8548-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0727;7:FNjfy29dRqinO+zF7xlDEc3sOzkkYXHXV7B2Y8FusivU7gMrvNMXuQAH7BulrbzKNrMC943i9DICy4xTCUbWEKKFlPlj4GR/EPpSOZ8FZr+7bb3SeXbE5y8SdHQ893d0TJeHfEDEEpwp+aDUxCFYkX9TBhVL3jvPzEG7tU3xDXeiCAf1c1882tET197mjaW+8IFmAYj2v62+Sg84U0idrtw2UMI057jfO18nCAfGOO92rmbxPLZf7S/TOpW9poga;20:0kPA6YYkAfRHaM2oPWzBYnapGo6lyHPj3Slt4Hd9bAddL2VZdVa+TegFRoVaEQyj2tKsRSXEtHROX7dNQPvZYG2EoY8DEr4MXpI/fu4XTfevRihAfbzn/NoNDpsaaI4xhiwMypNHY3AWO6PS4bxai1yI68SbizvnHR+yN9kooTc=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f08593d3-1df9-467d-a46d-08d584b29027
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0727;
x-ms-traffictypediagnostic: DM5PR2101MB0727:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB072730CCC84148EBD371E2D3FBDF0@DM5PR2101MB0727.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(31051911155226)(89211679590171)(228905959029699);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR2101MB0727;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0727;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(396003)(366004)(376002)(346002)(199004)(189003)(81156014)(4326008)(97736004)(105586002)(2906002)(6666003)(8676002)(26005)(10290500003)(76176011)(186003)(110136005)(22452003)(7736002)(54906003)(25786009)(2950100002)(3280700002)(305945005)(81166006)(2900100001)(8936002)(59450400001)(102836004)(6506007)(68736007)(106356001)(10090500001)(1076002)(6512007)(86362001)(3846002)(2501003)(14454004)(478600001)(99286004)(72206003)(6116002)(3660700001)(5250100002)(53936002)(107886003)(6436002)(15760500003)(5660300001)(316002)(6486002)(36756003)(86612001)(66066001)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0727;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
x-microsoft-antispam-message-info: jMtCWx4FecDy31My/la67ZX4+nC8VlH8MAWmEHv8GJ4o+i0/iUioYX7Ug+s7aroZ/odU3x4NhWm/UZDldPwZbR6MKnvqfMm48PbzgBUgnTiywsg9GMPZ1vL5m5KwQdUiwmfUdIbZnUZl6mRShMkXhlDYBuk91PTgyo3FBSN1ggUmD8TPMooaVpPcC/6QuKJmHaqqeCKXVCbr5Loub97QJ2LZiOIkxdcQyrUrC3WKf8xCF5CYghD9VSVDJofTsT4GA1o1+7EjPmomo2Hqb0qe0YVVhRo/1UFf0rFjRiD6lcp40c8F0RYiPLAI5HfY7osiD/Tz5RY62mjf0uLbmjlvYQ==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08593d3-1df9-467d-a46d-08d584b29027
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 05:02:17.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0727
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Vignesh R <vigneshr@ti.com>

[ Upstream commit d087f15786021a9605b20f4c678312510be4cac1 ]

Register layout of a typical TPCC_EVT_MUX_M_N register is such that the
lowest numbered event is at the lowest byte address and highest numbered
event at highest byte address. But TPCC_EVT_MUX_60_63 register layout is
different,  in that the lowest numbered event is at the highest address
and highest numbered event is at the lowest address. Therefore, modify
ti_am335x_xbar_write() to handle TPCC_EVT_MUX_60_63 register
accordingly.

Signed-off-by: Vignesh R <vigneshr@ti.com>
Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/dma/ti-dma-crossbar.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/dma/ti-dma-crossbar.c b/drivers/dma/ti-dma-crossbar.c
index 8100ede095d5..c7bd1c5315f4 100644
--- a/drivers/dma/ti-dma-crossbar.c
+++ b/drivers/dma/ti-dma-crossbar.c
@@ -51,7 +51,15 @@ struct ti_am335x_xbar_map {
=20
 static inline void ti_am335x_xbar_write(void __iomem *iomem, int event, u8=
 val)
 {
-	writeb_relaxed(val, iomem + event);
+	/*
+	 * TPCC_EVT_MUX_60_63 register layout is different than the
+	 * rest, in the sense, that event 63 is mapped to lowest byte
+	 * and event 60 is mapped to highest, handle it separately.
+	 */
+	if (event >=3D 60 && event <=3D 63)
+		writeb_relaxed(val, iomem + (63 - event % 4));
+	else
+		writeb_relaxed(val, iomem + event);
 }
=20
 static void ti_am335x_xbar_free(struct device *dev, void *route_data)
--=20
2.14.1
