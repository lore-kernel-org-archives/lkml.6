Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1282308-1520493023-2-10663791188402458731
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520493023; b=cxaG5Awgbir1B4AZbHwBmTBvcrm5urN1WDaJpopVssf1UeI
    9h9mXujYfvYisXdMdp6z4KevAtVhBl5p8DChQmUnD0nOIEIYC2PPS0XFYkdpMpPp
    qvNDTZg7DHp4lakdQj16FQ2HRND5NNtWas5XlutTUBY4tJvoh/knTyERkogS4XuH
    3Q/PgWfEtZU/+XnFJ8n6pCNAS/qPrcAMqzFi4SdN+Wthp+RGBruAQR882fli/6hp
    GIORJAsebRaa5SENK+DVAudJlEAVUIwc1GOMGx8Wibmt+Tya/uB3D9wNv6fS2rQw
    oGqXlHZ76P1id2wpXMQLMJ+fScFAaWN2eHv4q4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1520493023; bh=gqZm32
    ynXOG1fG0354HtOGN0O84M+TDu/l+nswJEHgw=; b=JHzozkv26e1dIBmiQuWFYi
    LmtDuGEm3sCzX6F9CBWHQ0UU55w4Z2EW1Gk2B7YAxQkfLGWrQ88gV5Q5Hn43F5T2
    /tu+S+0+AKtj//jyUj+1WBs6tBWn6gUZSQinoEn1i41KMIFhGFtUbBHZkbBVE/8n
    6UMnz3diS46OHVpx2Y5Y9GdFCDoyf0ZU82Bx1LOoOnfzJ+x8hNlSEPNS60LQ83zJ
    /q68+a0ithRdUaihigYw5tgO3k3hd2H/CtUhaRhDKx4OsDCcPKoEHCafva3pZHTT
    P9A1M3necujX30djZiOL7reFbdIMAK6+8K3yU+6Qi3AWzGraK65NVFP1asmrkeuQ
    ==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HGeDnaVD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=HGeDnaVD x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755378AbeCHHJe (ORCPT <rfc822;greg@kroah.com>);
        Thu, 8 Mar 2018 02:09:34 -0500
Received: from mail-by2nam03on0091.outbound.protection.outlook.com ([104.47.42.91]:63552
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755095AbeCHE4O (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 7 Mar 2018 23:56:14 -0500
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 14/78] hv_netvsc: Fix the TX/RX buffer
 default sizes
Thread-Topic: [PATCH AUTOSEL for 4.15 14/78] hv_netvsc: Fix the TX/RX buffer
 default sizes
Thread-Index: AQHTtpnExjhNwQjKSEqQw2kcAcl7Tg==
Date: Thu, 8 Mar 2018 04:56:07 +0000
Message-ID: <20180308045525.7662-14-alexander.levin@microsoft.com>
References: <20180308045525.7662-1-alexander.levin@microsoft.com>
In-Reply-To: <20180308045525.7662-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0902;7:sY/0cz8YAszj1iRMOUCyQV77dL4gD0m0bFWkBfNFk7T/7WKQiBvO5c3paMiqIPmwytpuZTTVZKweqdf9N0hz/BHA2QGL9IKUq4cVFor2otsVIySZGaoJEoLeFzkgsQE2pylY83mPsBqJxWuMx+8cvn+Sktko6KetD6I2TfIsK+1EvhYaArqmk6qBPrvLX/gDIwrEESVd0jJ4VxgBDpERS3uDgxJIuuZ6ltxErVp1+sY45B/iQeM3ZFrTpHt539H3;20:WMAy/ntX+zD5FeGTyPm14Eco/mY6m4hEzLUPPvepNToioBSSjPspA0/Ukvrj5I7Mzxg3ukyw1s5vw2+dtfQMqs5NUFaOXfKU4oXOce9swBYfqeJqFEKm9pWpArCH9SY8q9TQmcpbKHBF+57+ZNaT2eBx8Tksbu9nebIprFVdrd4=
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: daea9200-f126-43c8-fadc-08d584b0e75f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0902;
x-ms-traffictypediagnostic: DM5PR2101MB0902:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB090217F4820EEC9AE3824965FBDF0@DM5PR2101MB0902.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231220)(944501244)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0902;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0902;
x-forefront-prvs: 060503E79B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(39380400002)(376002)(366004)(396003)(189003)(199004)(8936002)(81156014)(81166006)(7736002)(5250100002)(8676002)(99286004)(26005)(107886003)(186003)(2950100002)(106356001)(10090500001)(575784001)(305945005)(66066001)(97736004)(2501003)(86362001)(3846002)(3660700001)(72206003)(6436002)(1076002)(6486002)(5660300001)(54906003)(110136005)(68736007)(53936002)(14454004)(36756003)(25786009)(478600001)(10290500003)(6506007)(2900100001)(102836004)(76176011)(6512007)(22452003)(6116002)(316002)(4326008)(105586002)(86612001)(2906002)(3280700002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0902;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
x-microsoft-antispam-message-info: xl+dqBt8fZThcY98ji1rxeKX7YhWjOh0d8hrFUmaeM0bKrGUBOZfSy86fgHpP2PL14PwLi7DgcvQGDTUXEQzmXIDuTOPhM1+cbFIK3xOX5sPw6g/0Y1LCG09MG7Luly6JhLVzpuFI0lVidq5Wc3WK26Gycgva8VoI1wRw6Te+224BPsfyHs65oLJVu/DyCFUIfbHZAl7h1/08wiLRvc5ssDg7deoOo1fuiS6QmMwkCtphNLnHCo531HGu0m8eu21G0ywpG2EK2FPdZGY02oN3jB3ZCtVjhGCRjJ6eWukgS/hOejlDPOu93fQfTiLRGybY+SStOR3l65dtPFTnFBfPw==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daea9200-f126-43c8-fadc-08d584b0e75f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2018 04:56:07.0128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0902
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Haiyang Zhang <haiyangz@microsoft.com>

[ Upstream commit 41f61db2cd24d5ad802386719cccde1479aa82a6 ]

The values were not computed correctly. There are no significant
visible impact, though.

The intended size of RX buffer is 16 MB, and the default slot size is 1728.
So, NETVSC_DEFAULT_RX should be 16*1024*1024 / 1728 =3D 9709.

The intended size of TX buffer is 1 MB, and the slot size is 6144.
So, NETVSC_DEFAULT_TX should be 1024*1024 / 6144 =3D 170.

The patch puts the formula directly into the macro, and moves them to
hyperv_net.h, together with related macros.

Fixes: 5023a6db73196 ("netvsc: increase default receive buffer size")
Signed-off-by: Haiyang Zhang <haiyangz@microsoft.com>
Signed-off-by: Stephen Hemminger <sthemmin@microsoft.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/hyperv/hyperv_net.h | 13 ++++++++++++-
 drivers/net/hyperv/netvsc_drv.c |  4 ----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_ne=
t.h
index dab27e91b83b..c2653ac499e1 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -638,13 +638,24 @@ struct nvsp_message {
 /* Max buffer sizes allowed by a host */
 #define NETVSC_RECEIVE_BUFFER_SIZE		(1024 * 1024 * 31) /* 31MB */
 #define NETVSC_RECEIVE_BUFFER_SIZE_LEGACY	(1024 * 1024 * 15) /* 15MB */
-#define NETVSC_SEND_BUFFER_SIZE			(1024 * 1024 * 15)   /* 15MB */
+#define NETVSC_RECEIVE_BUFFER_DEFAULT		(1024 * 1024 * 16)
+
+#define NETVSC_SEND_BUFFER_SIZE			(1024 * 1024 * 15)  /* 15MB */
+#define NETVSC_SEND_BUFFER_DEFAULT		(1024 * 1024)
=20
 #define NETVSC_INVALID_INDEX			-1
=20
 #define NETVSC_SEND_SECTION_SIZE		6144
 #define NETVSC_RECV_SECTION_SIZE		1728
=20
+/* Default size of TX buf: 1MB, RX buf: 16MB */
+#define NETVSC_MIN_TX_SECTIONS	10
+#define NETVSC_DEFAULT_TX	(NETVSC_SEND_BUFFER_DEFAULT \
+				 / NETVSC_SEND_SECTION_SIZE)
+#define NETVSC_MIN_RX_SECTIONS	10
+#define NETVSC_DEFAULT_RX	(NETVSC_RECEIVE_BUFFER_DEFAULT \
+				 / NETVSC_RECV_SECTION_SIZE)
+
 #define NETVSC_RECEIVE_BUFFER_ID		0xcafe
 #define NETVSC_SEND_BUFFER_ID			0
=20
diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_dr=
v.c
index 5129647d420c..dde3251da004 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -46,10 +46,6 @@
 #include "hyperv_net.h"
=20
 #define RING_SIZE_MIN		64
-#define NETVSC_MIN_TX_SECTIONS	10
-#define NETVSC_DEFAULT_TX	192	/* ~1M */
-#define NETVSC_MIN_RX_SECTIONS	10	/* ~64K */
-#define NETVSC_DEFAULT_RX	10485   /* Max ~16M */
=20
 #define LINKCHANGE_INT (2 * HZ)
 #define VF_TAKEOVER_INT (HZ / 10)
--=20
2.14.1
