Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241677-5-15203744181476863806
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
    1523241677; b=s9GXo35U1zPoxZs3SostK1Bx9PKFofg+qTH4ZnNR/DIKhk5JIf
    WRAE1BmVgW26gYxiH1+XchAluU94axEnahgweyBYxVGWvyaJsEDAIFDU5MS3NPeq
    C2MhhNvfsGVYNKDkVNiYqMMSkIG9hNtPaD9Q5TAxbJ+oOVB0t+426r5N51xWsdTt
    sk+LopbqhGrKcRwTx/JgRvr7+g74i4LIQ6aYjKBqtxhO/Jgc6Ly16TjalFTK27ca
    nS/MW/bQyOh31xacf+8hNXMT9GRwGuL47rn3kWDBhlnoKYPnwNo/7xJxMNtPMMmC
    rBK5rj6tF4hb5D0halNZJRadf5gwr/cR9TIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241677; bh=+v9WQtyWlt
    Uw9XglfKcpnLZvZU2QF4CRnInjPt8Nkac=; b=fEju2eUA/Xhj2r8O6OfVE3+0Fw
    uEKukWhjiOUKNDkF9McXoF4+FMkKlwLdzzYxbUAi8ZglKb54McFbPbmL6qUluUrq
    cF5Ryoz/0pqIR5oyQhw+0CrrI1KQmOJ5QW3LLKKkXL+xZgcrpAHao61RFY0ORG+B
    VFcEcMW+Mwh1iMCsfWBZM3949+KSP+pfYe8QqmY1414lYAifrwBLzI4Sfx7akNaR
    5MmPMA2HPR4FVW5VfsximHLM7y7F6TCFABnPR46IIbPyiOed72xpOPmxC09XTwXG
    eT5MIPUBGaaDOnu1a4nYHLUIiBB1VpsAxSOMSaK8YNfROp8XHumZgx2I95eA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YynI+1JG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=YynI+1JG x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOib5zwFzUCDVjekLqYIwlg7TOoUbY6PIJ89NzzJkf/n7lUM9pNjMg20uH9vN6yOsAFmV3X12Uxm0CaRlJnSaiZbpN/ls7Wb4nk00v6ugk79Z4QhmmDn
    fakBUc3hjOhlXtQYgqvtUvx78UMuiT/m3xUYtGKWWDPqA1QNYXF+f3pTfuMA4Sz1ZN6qvODRt0seyDEY0uA/UND8wlUggjvolCNlmX1tOZPdo1mK88luRnlX
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=5HukGGecSq8qvLx4TT4A:9 a=wPNLvfGTeEIA:10
    a=T3LWEMljR5ZiDmsYVIUa:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755531AbeDIA1X (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:27:23 -0400
Received: from mail-by2nam03on0102.outbound.protection.outlook.com ([104.47.42.102]:48448
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753174AbeDIA1U (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:27:20 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 031/293] iio: magnetometer: st_magn_spi: fix
 spi_device_id table
Thread-Topic: [PATCH AUTOSEL for 4.9 031/293] iio: magnetometer: st_magn_spi:
 fix spi_device_id table
Thread-Index: AQHTz5jztua/H1mxQkWQ1CIwn7/WZw==
Date: Mon, 9 Apr 2018 00:23:14 +0000
Message-ID: <20180409002239.163177-31-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0885;7:+YWhW8pyAq5z0Z/QqhZPZxIbFJxi3IBGOk9ry4oJpNjWdGJ92ztd5dsT7vxZ7BEZYb23mapJdkw/Y9g9NseA9SK/0W2arcHPQBKW54GEe034nqGEx3ICjRA9a694ohF5r1Vqa53LMQbwCUtnyhMq5+md6hQuzgQ4O4YykJEis53b95mIAkP/vsoqMNTNWPWWqU9St2/MztD4PeU4bDuG1Gy5/xjTNsfggKNPj9a2l3/yTseuNRaWKYqS+VQVpO1O;20:ShwIDBS/pDCwk/8RzZnelxhtJ8fOfDhGIGSaVH675qzLN9P6Tg04VAACc8seXn2HLFaidt8xE0VNfmm+OZYZ7y5zncXFEq6ZEle7foE69t6UHkzCZ4pFKodPW4+VCgU3m3U3PdppXFdtfKIxIayYz6RTuzDZQi3Gk+DWTHohmjI=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 92d3c76c-f646-4d9c-68bb-08d59db0a6c2
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0885;
x-ms-traffictypediagnostic: DM5PR2101MB0885:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB088587879D269BF42D5960DFFBBF0@DM5PR2101MB0885.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB0885;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0885;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(346002)(376002)(396003)(39380400002)(189003)(199004)(2906002)(68736007)(22452003)(316002)(6512007)(5660300001)(6666003)(54906003)(110136005)(486006)(6486002)(102836004)(36756003)(14454004)(99286004)(86612001)(105586002)(72206003)(106356001)(2900100001)(1076002)(97736004)(10090500001)(3280700002)(5250100002)(6436002)(3660700001)(6116002)(575784001)(3846002)(305945005)(86362001)(66066001)(39060400002)(10290500003)(186003)(81166006)(8936002)(478600001)(476003)(25786009)(81156014)(8676002)(4326008)(7736002)(2501003)(107886003)(6506007)(2616005)(26005)(76176011)(446003)(53936002)(11346002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0885;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: sk6NLPIOUdsisr+Tgwh9we6myF1dwK9rROzQ9CBR32Urr9triWuWd5+zLH6ARNFet859gaEd4wg1l550wetV6uXBco7Vu0UiVUEgQauDgHdSTdaVgvxW678Pjoof8ABuKZ3hTQpMH6GmDzWBsOlpNvxHNnO15C/h8NJgtk73sYvGwXXDee9pbmNVsBIDGYMJZGlX/wbSOHG+7Qcpn/eNyrqiAW+5wxG10eB0d/xeaTP8qZZBbDdCcigJXVpOjg2Ju0f++W6/RqaRB9+qo38pvH0MqHChUgEem/24JtJuZs7sFr29p9PMWI8x8ZKV6+NZ+6B4XdPISEPZwA4+Px+zli7yj3x62bHetwvXoDsd8ngww8FUI5t/g0gUT94W/F3JC48GTx4qGNb1hMOlv3fEXqO/v9lVUb1GpErf0mAY/nE=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92d3c76c-f646-4d9c-68bb-08d59db0a6c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:14.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0885
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>

[ Upstream commit c83761ff0aac954aa368c623bb0f0d1a3214e834 ]

Remove LSM303DLHC, LSM303DLM from st_magn_id_table since LSM303DL series
does not support spi interface

Fixes: 872e79add756 (iio: magn: Add STMicroelectronics magn driver)
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/magnetometer/st_magn_spi.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/iio/magnetometer/st_magn_spi.c b/drivers/iio/magnetome=
ter/st_magn_spi.c
index 6325e7dc8e03..f3cb4dc05391 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -48,8 +48,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 }
=20
 static const struct spi_device_id st_magn_id_table[] =3D {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{ LSM303AGR_MAGN_DEV_NAME },
 	{},
--=20
2.15.1
