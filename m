Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3357373-1521480940-2-8324898922305043154
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
    t=1521480939; b=s/N0G1BaWj5xJG+RRMNEhD4974/0PCIb73jPWA/JDJ7WcrL
    3+Z8HexOCrh+NglDCAUNOHaaV03d3VT6VMTpjjKJlaGwZpoprkhH6kZz1RzvRK5X
    O1d15IEvKTFNBqoOVM1eL5x5RbCZW0kaVDUeatpKE3NITta8aNAJbNCFZDUmdhob
    Y3IzgPIRpLHsmqc06eEOQUOoLYxki1ZcU7I+zRDSr1lig/dymlCrOpTDC+E6MRnX
    9sqH4hbZCTyZbFdZNnT0ln+vjYVNEQvQGaemZfrLMpLfQKvK/6EzPuAGQNBAY9zO
    fOubxbGyzyZcVYpXS89fsHsW9/JGURL4ZeVySNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=arctest; t=1521480939; bh=BAmM+V
    dbFEjXZsYdKIVTcU9m5HwZY9g18JsLBKfjJ0c=; b=Noqg9Hqm7xVIT9VcueGtWD
    Ecg6JOHthlkRYskMh6q47d3zZxcHWzGJ0nyDpnFCfLEF8D9daxel1HutZrYjEQUM
    BTcOQ/HQ4nBuyp7UIvMcAXgxnhHXYCVYWXMfQ84uLiEZCRfCXHFw2/vUJpdgtETL
    5jq1BmT7SS0z4OoUrzXlcWM54BwD/vR50KeCjUWOPcEM4TgtN6t1/TEly13y6I7O
    Ycaz7zvQyMbVuxP1wfWb2QVGCbDAgQxRgvKFlZnxSh/1+Nv00pZFQcVUYSf/lmgM
    GygeNM8KS5fwJssqKnt2tztOp8KhBznAuGdesbIVS4YOwlMu1Y6rFLt1apnAbXeQ
    ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lyf301hh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedujeenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=lyf301hh x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgddutddvucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffuthffkfhfjghitgfggghsphejsehtqhertddttddunecuhfhrohhmpefurghshhgrucfnvghvihhnuceotehlvgigrghnuggvrhdrnfgvvhhinhesmhhitghrohhsohhfthdrtghomheqnecukfhppedvtdelrddufedvrddukedtrdeijedphedvrdduieekrdehgedrvdehvddpfhgvkedtmeemfegulegsmeejlegvjeemleegvggsmeehugeivdenucfrrghrrghmpehinhgvthepvddtledrudefvddrudektddrieejpdhhvghlohepvhhgvghrrdhkvghrnhgvlhdrohhrghdpmhgrihhlfhhrohhmpeeoshhtrggslhgvqdhofihnvghrsehvghgvrhdrkhgvrhhnvghlrdhorhhgqecuuefqffgjpeekuefkvffokffogfcuuffkkgfgpeejgedujeenucevlhhushhtvghrufhiiigvpeehhe;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934158AbeCSRff (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 13:35:35 -0400
Received: from mail-by2nam03on0113.outbound.protection.outlook.com ([104.47.42.113]:31931
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S966029AbeCSQGr (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 19 Mar 2018 12:06:47 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: Kees Cook <keescook@chromium.org>,
        Daniel Micay <danielmicay@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.4 009/167] bna: Avoid reading past end of buffer
Thread-Topic: [PATCH AUTOSEL for 4.4 009/167] bna: Avoid reading past end of
 buffer
Thread-Index: AQHTv5waTOU7F+MYj0mdg0DLTgr0nQ==
Date: Mon, 19 Mar 2018 16:05:31 +0000
Message-ID: <20180319160513.16384-9-alexander.levin@microsoft.com>
References: <20180319160513.16384-1-alexander.levin@microsoft.com>
In-Reply-To: <20180319160513.16384-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0920;7:3oj2X+yuCPUJcfZe0GRl5F0eClhnLwy9sAdzofyaSLYEB7L9r6r0lgULYhEZXNgrBq8LmTIy8E6mxjhPMWse1mA9yrI9DcFas3VSSOaS+7cQf3dTb97oQkrzc99rhNsoc93GcygmHyYynGMyHEy47r8PjGyfJI6XmyKbezXMwSbzYZ5DgPNNnhR31+t/gOH2OrOCutx5Wf7Wxfe5MVhor8fPPnW64p5DFdo4ZoutdDI2NatehWTs4ySSctmRKPTG;20:WL8ncNmzRDIDfZZ9e4R+RciNWssMJOc91C+9sbNY+s4CKxECx+OlbzX8vmeykPeVfohuIr3sMDF1KD+AYu9vJfD8R2ZUfG0erZSEzOKW530+FdMYFhJwOxSr7qOkxMIYOS+yeh/ZfrZys0alzWqho8fc8Ftp+TGSlUHgx8GnwpE=
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9b3cd8f4-1b61-4aec-20ff-08d58db36897
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0920;
x-ms-traffictypediagnostic: DM5PR2101MB0920:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0920D501D91624DB5ED830DBFBD40@DM5PR2101MB0920.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(5005006)(8121501046)(3231221)(944501300)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM5PR2101MB0920;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0920;
x-forefront-prvs: 06167FAD59
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(979002)(346002)(39380400002)(396003)(376002)(39860400002)(366004)(189003)(199004)(6512007)(14454004)(2906002)(2900100001)(8936002)(186003)(86362001)(5250100002)(316002)(97736004)(2501003)(6116002)(1076002)(3846002)(81166006)(6436002)(6506007)(59450400001)(6486002)(26005)(72206003)(81156014)(53936002)(102836004)(478600001)(10290500003)(8676002)(107886003)(6666003)(39060400002)(4326008)(3660700001)(66066001)(25786009)(2950100002)(86612001)(36756003)(54906003)(110136005)(3280700002)(7736002)(305945005)(5660300001)(76176011)(68736007)(22452003)(10090500001)(105586002)(106356001)(99286004)(22906009)(217873001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0920;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: Ou3c4Uf7U92iXa0vqsZHC3okAw7GF6V1ce7tmr9xNwmaWLq0umKyjb2lGENDc2IZlxFZsY20Dl6qY1QzkZXpok+Gug9OWGfS34f2/plRfHNb/O/dYEhzrWF9QN6GbAFdEHFHcec2j836KUDWBp5QrIs2sQTzz/2E+Vaqg2dlqy738kqql6YfYD6XVcIvdvc4h3741gaT4SPt2fFwB2DzrB1eD6JTEMUrF6a3Nbv2Zc8eqRBr0A1UWFqpCMeEl1c5Wz9cw3FvDxFjJAtskAZy3C8t2OxHvj7cFDe7S1pSUAO9FLP8dVUgTT8b4wgDEedcGJZbDxq/oudxk0ImiB7ekg==
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3cd8f4-1b61-4aec-20ff-08d58db36897
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Mar 2018 16:05:31.1947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0920
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 9e4eb1ce472fbf7b007f23c88ec11c37265e401c ]

Using memcpy() from a string that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. Instead, use strncpy() which will fill the trailing bytes
with zeros.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/brocade/bna/bfa_ioc.c b/drivers/net/ether=
net/brocade/bna/bfa_ioc.c
index 0f6811860ad5..a36e38676640 100644
--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -2845,7 +2845,7 @@ bfa_ioc_get_adapter_optrom_ver(struct bfa_ioc *ioc, c=
har *optrom_ver)
 static void
 bfa_ioc_get_adapter_manufacturer(struct bfa_ioc *ioc, char *manufacturer)
 {
-	memcpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
+	strncpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
 }
=20
 static void
--=20
2.14.1
