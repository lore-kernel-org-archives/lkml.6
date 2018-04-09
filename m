Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3878504-1523241168-2-8929157096641164044
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES roenda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523241168; b=ObSlQFNgVtn6+NNic2EBUeArEYIfP2cZitppXFCwnZ7XEq3S3s
    6HkLTl9AearM6UuRNp/fO+ErPbUb+WSQ/DYbA3hv7P5rkPS2T6E/3OcOFsp3LqsO
    g7KHSPxm8Sf+BFyfsCa+OCVbiOIzDsMeXt3ZtVwZr/mjm/Nou/VEp5fq5PmjDW3v
    fNPMpT66H1eo/1mFPDHrcjbxV4svMgTz9/xfmfcai3wdeSD/f4ORTd2eyeEC9Rb/
    6yeqwAsJx8g2Gl5gvuLZNFRptvQ5g4pmd3O8CzdWLtbzWunF2xOYw+0cplUg/TPE
    JJlsGQloUneIlAKTM41177QffQ4OvvgvNSCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523241168; bh=BbyOzSqRxc
    xq+F/dfFtFPPEaM9BIrWI61eegAr5f0qw=; b=OW+Fb0uVdcD3OxkW4N2MK3gBx3
    Vnq0bhcNToKMGySDIQyvZeG0Xf0hfPgiCwd6d3iINvmzT4mn69V3bJ1zmo6DX3Kf
    72p1jFtO1y+TrbH4X7XOZlnCMh+sZ8WzMM7Jl/9X7nX4tQecYHsKtG0UCusLPqYZ
    IRuxZis/4hPg8AdsxdPKcQIp4n+B8ZS3tO7USsrUXitJFFvkPuB+c5scnfvhOaYE
    1qdjkvizmGaWz66RRIDM/pcAC0I7KKQnO9dpx0Y9nb2xgUuFTpWiAO0WoM20Gy6C
    5e6WrwwgTEBRlIId8EDDVSCuWrLDTJl4mrejAGYVkLjJvG2AP3Pu+vBqOflw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=crwrjMpZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=crwrjMpZ x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOGqM7LksyLQdbYSwVf0KSd1yHs1FOcX7A66LheE3YyEMsUPgzLce98y3PAp/NiL8rm6+CRwLvYexZ7SCFyn72nJJVspw3rErkFM/YUYSDuPClVkaEU8
    1osNkObfggwSE5ED/16NVIUQh/vej1nKUvg2XSxhRJWWJCdVUDXgyDKUmVSl7F0rQdIXFX15yVVQMDjIW2iBythVq8qQcPDGGlvcc/5cbRspbKh5dK/93zJR
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=wkFzPVxRAAAA:8 a=VwQbUJbxAAAA:8 a=yMhMjlubAAAA:8
    a=DvmbRTN8j3nyG2U6GGMA:9 a=wPNLvfGTeEIA:10 a=vI-w7cdEEOKAU97EXJah:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755922AbeDICce (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:32:34 -0400
Received: from mail-sn1nam02on0097.outbound.protection.outlook.com ([104.47.36.97]:15008
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755743AbeDIA2M (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:28:12 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Phil Reid <preid@electromag.com.au>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 065/293] iio: buffer-dmaengine: Add missing
 header buffer_impl.h
Thread-Topic: [PATCH AUTOSEL for 4.9 065/293] iio: buffer-dmaengine: Add
 missing header buffer_impl.h
Thread-Index: AQHTz5kEYKl90hYBYUWLmuuY4mFY4A==
Date: Mon, 9 Apr 2018 00:23:43 +0000
Message-ID: <20180409002239.163177-65-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0871;7:JO/DLuVNA+gZhhmpuJOixLCpwsz5fOYvowDJQsbZNVmbhbpOnNRitDAl0Iroy8StHHkXtx2wKnwHGgcybII3M2UW/xOkTFjbw36/A3lgjvEqKkg1uSOvugqCD3NBoM3sKecI6116ilpBja9x4iwE3NrgOq/6xX/CiUp6VLtsCFbypZs7si4KLg7n8mCwYyXH4w431QxcR5IZAo6GEkcmDgXU/69y5apff9ojxA0HH6LgN4q16S8AZxnAfj93lwsi;20:47WxREj9FL7iRuQ8ORcS0H6KdMuqfgNCRUj1sJJnUtUIWAoROL43IO5qV7K3+FiPryTP7vbLX9yjS/hZz4k6W+W93SSkk3Y5WZTOytK2ktQA8kLp038XD5l4hN02yZV/dTLSCyP6OnbkG0kDtxfXdOGYiHeLZOC/5573u8+YylI=
X-MS-Office365-Filtering-Correlation-Id: 62f91b91-d9a9-4f68-f080-08d59db0c4e0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(3008032)(48565401081)(2017052603328)(7193020);SRVR:DM5PR2101MB0871;
x-ms-traffictypediagnostic: DM5PR2101MB0871:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0871B832991490B68CC4DAF0FBBF0@DM5PR2101MB0871.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(46150409022019);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0871;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0871;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(366004)(396003)(39380400002)(376002)(39860400002)(199004)(189003)(105586002)(8676002)(3660700001)(3280700002)(6506007)(81156014)(81166006)(14454004)(99286004)(72206003)(110136005)(8936002)(54906003)(305945005)(2906002)(316002)(10290500003)(478600001)(7736002)(53936002)(6512007)(486006)(11346002)(4326008)(86362001)(446003)(3846002)(102836004)(76176011)(476003)(25786009)(22452003)(36756003)(107886003)(6666003)(10090500001)(5660300001)(6486002)(86612001)(6436002)(2616005)(68736007)(26005)(1076002)(186003)(2501003)(5250100002)(2900100001)(106356001)(66066001)(6116002)(97736004)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0871;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: Tyd+/xRK1S5za3177YZ5t9tfjlAKjZeW8j47qe5+DR3XyDtbz3Dmf5CqztQNvrJkE3QHm4RI3ZEvz52yGVMQ3euKXIzeRAVGkGeGj1VydtNhDeV8DQ9WXzXDp7ZcEfS958zHhI0RtW9mpV2dHIwzf6rm8IkB3sOJ+u2OhcwOIVzYmv8gZ1PocR+oYjEQbRg7FU8VJaqtFp4sSXP5JwBCGWFpjZ8M4aOCWQTW8uKjnsDVieRSlPCVwXq1Y+TrifSQzeTAXFS04Pu+xfUKBwkq7nX85NOjg0vvLBsZPTPyQTqwFJL3G74K1eOo5W+gTZ3WPPjS057NXrBC4Pk2FuanaROzajon2llGlAhaqOKNJtsUaFGgkG6rz/UNk5TusGbMUtDCI50kFKxQg+WOmcPVNGat1iIn6MUEv+wbPOUV+/U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62f91b91-d9a9-4f68-f080-08d59db0c4e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:23:43.6905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0871
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Phil Reid <preid@electromag.com.au>

[ Upstream commit 7981dc07fe317e3506d706e5ef91b94da02656f4 ]

Add buffer_impl.h as buffer.h was split into interface for using and
for internals. Without this industrialio-buffer-dmaengine.c fails
to compile.

Fixes:
commit 33dd94cb972175249258329c4aaffddcc82c2005 ("iio:buffer.h - split
into buffer.h and buffer_impl.h")

Signed-off-by: Phil Reid <preid@electromag.com.au>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/iio/buffer/industrialio-buffer-dmaengine.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/buffer/industrialio-buffer-dmaengine.c b/drivers/i=
io/buffer/industrialio-buffer-dmaengine.c
index 9fabed47053d..2b5a320f42c5 100644
--- a/drivers/iio/buffer/industrialio-buffer-dmaengine.c
+++ b/drivers/iio/buffer/industrialio-buffer-dmaengine.c
@@ -14,6 +14,7 @@
=20
 #include <linux/iio/iio.h>
 #include <linux/iio/buffer.h>
+#include <linux/iio/buffer_impl.h>
 #include <linux/iio/buffer-dma.h>
 #include <linux/iio/buffer-dmaengine.h>
=20
--=20
2.15.1
