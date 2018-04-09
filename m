Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3968184-1523243782-2-10243236603010265017
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES enro, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523243781; b=K3Q8u4n26MdbEmtOPRe4FIk5k8v655DlVUNE4KLsTRzwQ4KnWJ
    OZ/8L7d/JYiw+Z68ck30xIFgqgYCsP7K0wgt8yX3Gwqd7Go6h7vyb6umtFcwL4zR
    8U5JlKIcuZGCuQPc2xvwmxh8px/QTQVzM4dU9355z6qqrQvsbNXUBR4k/1YoIr/3
    dxrxoMCniv3cnSQNLI5zN4WjmvgoyxWLdVLZhbq/MwWs1/GGunacBPivAM4nVk5R
    kc37zS8poHyt6mW3C4uZZEmrC1J7s9Z+prbgABwoD9d7y8KeJ8NAKZ7aNs10xCL4
    +QQkGegbRAc4YAW9uQLZuUpTI3A9BtsCz2fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523243781; bh=y5eJ2+EXUh
    +ml/yO8K6OADz3i4EjVfOUKEqh13qpwLo=; b=ZvQbBtML4Nd6dQuQLraE13M4jn
    cg/aBSNhNPht9+qOnbczQhybKRPWxBJCEaCFBT0z4IlkYr/wbfDMa2dn3q8E0Pp6
    ZgPNJ6IHY71/yI2ZDGNwsvNpt1UP4r+jQ1WERF6E1CHvUf/l+G6m6U7tacge+hFH
    waWXAMtXMwnRjpkyr0mVdHZ9KqqGxJQdr/GClogcahDccwULP5Cl8TJp6s81Z2/+
    duyMM+iymu0+B1fG5FjXisPqDl9aFDK9yv4Q8VSEGkMFW30tyLCrB5FahGh/+KA4
    5eh0cUj0GzGTw8wQV0O19wFZZu5F4/G59wKj2/JQnKYvr22PwXqkxzHf5oYg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jSIub8Lp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=jSIub8Lp x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNTLzEJZRfy8u8i7NQRWpP/UwFFbqnbil7xLFOqYprPdLJHGPKmvKwn8afwk0k93woN7Xauh245Z05Mh/0UlhF6eRylzct/Yv76bWR+JaYWgQXvqm3nc
    tCobXmS4Hi6KOi9mDoLEjNGCcZQiP4E3GblIbP+tyAYsaDvlwIstR+HLVfelHLMsGjBI874nG/SN6oNXkTnzB7guBwOe8utJ+klJ0SXo45vvUlclfnntLCuz
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=5G9JfAGruNMbQEjIFG4A:9
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752925AbeDIDQE (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 23:16:04 -0400
Received: from mail-by2nam03on0115.outbound.protection.outlook.com ([104.47.42.115]:29467
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754903AbeDIAXo (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:23:44 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.14 064/161] block: Set BIO_TRACE_COMPLETION on
 new bio during split
Thread-Topic: [PATCH AUTOSEL for 4.14 064/161] block: Set BIO_TRACE_COMPLETION
 on new bio during split
Thread-Index: AQHTz5iVe6HGmBR6N0iTQfUkI28N3A==
Date: Mon, 9 Apr 2018 00:20:38 +0000
Message-ID: <20180409001936.162706-64-alexander.levin@microsoft.com>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001936.162706-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1080;7:kDuFWB77e8uwrkDIrnHGGlNRgvlvyW0DaxN0RkzLfHnidVKV9oG+eCOL+F7BtFsyMOhCKCrR7uHnTATp9FEqGIX29hPNdAhbnLjeAYy6kr8fZIriptgrrq3vqpHMBDhhTyYJ8Z2NV6p/EphoA9AbBCBIbFy4QqijfAf+khTax5w7jzmp1pR2dER8wbXSM9xFh+7OehETWlMg4rsJMdFlEo7vsOeT+o+X4rbn4HmpYh3hZ7zQMYAlbrwYOmxBcLzP;20:KIowMC79JkyLrQy1ceoVeqJaMrWbIkDe4b55kAKC3ay9yUJMGEj7KppJ7F8BSdcqAF52zcoizvOkFELE153KLYuaokzgF4hFLUMQTWRiW1VGUZH6O1wXmD01FPeLvp7zHI21P0ji8VSJdGFfoc0ZMFzRbB6T+mCKuUCaYHD38Mk=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: f4df6a22-a2ef-43a5-9d53-08d59db02402
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1080;
x-ms-traffictypediagnostic: DM5PR2101MB1080:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1080FA1BAB0C40DF229FF892FBBF0@DM5PR2101MB1080.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231221)(944501327)(52105095)(6055026)(61426038)(61427038)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:DM5PR2101MB1080;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1080;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39380400002)(366004)(39860400002)(199004)(189003)(2501003)(5250100002)(8936002)(10090500001)(5660300001)(3660700001)(446003)(107886003)(14454004)(36756003)(6436002)(476003)(3280700002)(2616005)(11346002)(4326008)(53936002)(6512007)(22452003)(305945005)(10290500003)(316002)(102836004)(2906002)(6116002)(66066001)(6506007)(3846002)(7736002)(486006)(54906003)(110136005)(186003)(72206003)(26005)(1076002)(105586002)(2900100001)(6486002)(97736004)(478600001)(81156014)(81166006)(86612001)(8676002)(106356001)(99286004)(86362001)(76176011)(59450400001)(68736007)(25786009)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1080;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: 4z8obTp0pr7peekijgBkgNsslScC2YrTNU2HGZSigBPiJsID/7k2RkDWKuCdN5vyD52BDP6RX5M0d4x3IJotLhG2uX8EdhXcp/WLiPruoLGcuQwjtEUaiu3Lfj1MOEHgFfhuMmI75Zc+xbB0m7vSOi6/PNZbeQFVbaZR+p7ORPKDrWDj+jJHC0V26wwST1qof1WNzB57WALBQtvR23wKRQfMa6q0kTS2FKIg18zG+kWlf0qvpIfiUM6kE0LumIQ2cb38z9qf8aTQz1/IzFSd6kzA3HqK/fviIS3rKeBMoIEkz6OHs9ntUUPZ54whXuiQJUkJ0CDKwVqNoXJbYhL44G+9a/URt9xsJFcZ2Z4JpiVJash8LFHaHWqAgZ1My/Jy70Zc4sn/8v0MrBa+8tOf2M7x0B+sdMpbAUPbqxhxAak=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4df6a22-a2ef-43a5-9d53-08d59db02402
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:20:38.2535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1080
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

[ Upstream commit 20d59023c5ec4426284af492808bcea1f39787ef ]

We inadvertently set it again on the source bio, but we need
to set it on the new split bio instead.

Fixes: fbbaf700e7b1 ("block: trace completion of all bios.")
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 block/bio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bio.c b/block/bio.c
index 7f978eac9a7a..6efb23370956 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1893,7 +1893,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
 	bio_advance(bio, split->bi_iter.bi_size);
=20
 	if (bio_flagged(bio, BIO_TRACE_COMPLETION))
-		bio_set_flag(bio, BIO_TRACE_COMPLETION);
+		bio_set_flag(split, BIO_TRACE_COMPLETION);
=20
 	return split;
 }
--=20
2.15.1
