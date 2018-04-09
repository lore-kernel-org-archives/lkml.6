Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3695087-1523235731-2-4999338126054216509
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
    1523235731; b=D3jgUE2sI+ztMghpwdyPQkgWn8M6oW5eufZIy/y4wMNwFHdEw6
    AWdDLMNEydqc+ubt2llLb4wfZEqwA7ZQ4NkrNxPPP0/+YjuLvDP6to3U2tS5rQB5
    7iButF28yKcGErT2xmeKQgBHKPOKwbuPsV0H/GpjoulC0w9w7MV6koSfm8r9n0HH
    80QsL4vBsfwvBDQsB8yyBMtBf+E0rPW1SBsE7CpuFLsaH79P2mgX1gxtFBsLVFkU
    PRfZs5kqyY7DZkN//hepnNIp3CrqMFyJ8iGwpcNv/KuuiQRg1iGAjgsFwt5fPWuk
    uc8vVj6ueKmVajeczAUMfJ8gDpX9oFipzt0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523235731; bh=XuUgMIZedx
    TEn6jjuUkN+4wEfGDXmW/1HM2m6uUeCFQ=; b=URFWppMkq88YUlUUOTVeaa201N
    7himvR3IWzUxMuOUVZSKX65YccPOCf6P3M2Bm/m1obCEuDkTBXqPqbCo6VGY1DKn
    ot7m00Hx28Hr6axjMyGxFkQ/ijGOG5baDHwQmW0/Nmroo+JaMoTID6rhJhwZXX8M
    SPvxgNhXLeq3PfmadBRlHiYJBTS8saZD8G+BMIUTrntw4M/7ZYPHQRKHat6r5J/2
    I0XecK+bLCw43+Lk7PqxEuV1T7ktHjSptzgHQORMyO8XHbmiiX6jVayp1OEmROrI
    aiO/so05U3/89MFbvo09Oe51Z7h8qz9Z+78zz4X+icn+reRdAXqp6zAF4qtw==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l0g2awh0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=l0g2awh0 x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfPGDduLEzeWzuA60DQ7z9oCz3NfeILvpsD8BNMcSl3tJjxnhxkNdb2hiIwTWX7wlIvJwg9xeukHm12TyCf63sYNdfd7QB3q0jMzbyLBGxZzZLuzX6uxY
    g50r9e3eT2q4SvtZX5JmUZfkw6UknmRouPZaHEYgvGwbFW73l4UB6B4man6GLErAowY5oycRO9kV2Bz6k2ZBrVkDfaBp//hrqyljVXSBEreX0APO3gNE8yUl
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=pGLkceISAAAA:8 a=8b9GpE9nAAAA:8 a=VwQbUJbxAAAA:8
    a=yMhMjlubAAAA:8 a=5HukGGecSq8qvLx4TT4A:9 a=wPNLvfGTeEIA:10
    a=T3LWEMljR5ZiDmsYVIUa:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933584AbeDIBBU (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 21:01:20 -0400
Received: from mail-co1nam03on0103.outbound.protection.outlook.com ([104.47.40.103]:45124
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933169AbeDIAji (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:39:38 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Lorenzo Bianconi <lorenzo.bianconi@st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 3.18 013/101] iio: magnetometer: st_magn_spi: fix
 spi_device_id table
Thread-Topic: [PATCH AUTOSEL for 3.18 013/101] iio: magnetometer: st_magn_spi:
 fix spi_device_id table
Thread-Index: AQHTz5qjTST6QLdQQUCzwYErwH/S4Q==
Date: Mon, 9 Apr 2018 00:35:20 +0000
Message-ID: <20180409003505.164715-13-alexander.levin@microsoft.com>
References: <20180409003505.164715-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409003505.164715-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1047;7:j2YBWETVgyhkh0PwKhezAdkbeVq/6KJBrwDYdp1eYQQ6nucfdcrxJlr6aNj2XTPbiwhDdEJzyB/+id7h3IbiVTBfQ/7p//2Foa3nYn4jW9LQ1y+lyToyst+/W2YaEaNFNFnStgLwsmupiCKU+swChh5fwYMUUcVVSpxfiofq0yiL+fqj4gTFY/u3AFEeow/jnfP13akrfsa16gojNKvktQwsW8fgBExvklIV2M3W54HbX0DAnYnxcy5XLCPW/tjt;20:KeHJCMQJAAvqyyU50FVAAf8bK7m5KXi3w8dx1VzLVZ52xuKTSytyP3+cCeSpmc0K+ilijNvB7VYvrYuKbCQYGyMxaHBWo2hdWkhMI0daafY5JMN0RuQfT29voiYx+qQU3VUodGBCK1sPXwS4C8UvYSaGiHQN1BqGG+mNAXW80V8=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 737dc5d8-77cc-4ee1-7832-08d59db25d96
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1047;
x-ms-traffictypediagnostic: DM5PR2101MB1047:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1047C3C14DEDF15BF01F5B00FBBF0@DM5PR2101MB1047.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(85827821059158);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3231221)(944501327)(52105095)(3002001)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1047;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1047;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(396003)(366004)(39860400002)(346002)(39380400002)(189003)(199004)(97736004)(3660700001)(2900100001)(2906002)(8936002)(11346002)(3280700002)(106356001)(446003)(68736007)(72206003)(1076002)(86612001)(25786009)(3846002)(39060400002)(36756003)(107886003)(6116002)(81166006)(4326008)(486006)(81156014)(6512007)(6436002)(53936002)(14454004)(8676002)(26005)(575784001)(5250100002)(86362001)(105586002)(6666003)(305945005)(186003)(10290500003)(7736002)(10090500001)(102836004)(6486002)(2616005)(5660300001)(316002)(2501003)(66066001)(22452003)(54906003)(99286004)(110136005)(478600001)(476003)(76176011)(6506007)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1047;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: VJEzMm0LAFzYVwQkPSeSps4FNoZJnC8lVcPDo94HbaylAwDcrqFTLgfMzvRVDf2b2SVqLdwxF03AVDuyDMya8FKddTeEVQ8GSAwDlAGTqL//eJ0RerUsqRLvgnu03HHWk2CVhPNPPbR7osOVI6cAKm+9YtLn3Tep+ZzklhqeobhtWOzFVmGKZ3g1NJ4ksBt4Xk9RCLqvxctrMi87OKxngFetpXKHe0Rg18flenDq1PvAEdmLFSKY4Ntl21PM69p2QyDHrlRPICYYToV3de57l3etkQgrzkMej3PKH+VmeFopRg2PEwfMcr7JPGh45lgN51Dr4yU33tQ5BBurmqUZOM3DPCRYut7m4/MM9yP7lU+a5WD0TWHt1ORd+zJV2+uhPIA08tsNLPxEbk3qO/wGMvax/Ph62OCy0xNgcbDbHeU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 737dc5d8-77cc-4ee1-7832-08d59db25d96
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:35:20.3454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1047
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
index a6143ea51dfc..d28685bec34e 100644
--- a/drivers/iio/magnetometer/st_magn_spi.c
+++ b/drivers/iio/magnetometer/st_magn_spi.c
@@ -49,8 +49,6 @@ static int st_magn_spi_remove(struct spi_device *spi)
 }
=20
 static const struct spi_device_id st_magn_id_table[] =3D {
-	{ LSM303DLHC_MAGN_DEV_NAME },
-	{ LSM303DLM_MAGN_DEV_NAME },
 	{ LIS3MDL_MAGN_DEV_NAME },
 	{},
 };
--=20
2.15.1
