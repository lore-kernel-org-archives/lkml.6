Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4122441-1523246215-2-6430277505886243088
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES enhr.us-ascii, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523246214; b=hcYYWOy/NmHtkrTXnYFc0EZqTcoNuNpwX/dja54ubFMiaEJcuL
    879xWxNWOVkfLUFkJZFpI2sdHyZen50+j6knl9putq+adIfNUow8kT2Q6hHW95qf
    nFG2Um+69/gO4K1gLjGmmgTVlFbz/sThhxitl2sGATE4CX2Y+G4X05this5EtJ3F
    +8/aBOSSR70lqf6vuGAnlWlbIWE6P5+SLdmXguZKlHxSWpNGJxyvA2q8tdp3+4Bb
    mggI/VJoFAopZm9KpJhqIa8jVmA5Xe25vakWHcNb6Wbvo32bnw1QqRcitevJ9YQ3
    B6wtkK8hJ6H0Ln8N8zHBPRuzWZcjri0SxFBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523246214; bh=PGApOi8Ezn
    gCIdN/cfg9o9IBHtNiGxVT4NtEdodg6tU=; b=C1ZnuCg5El95V712XFD6yJt76K
    1gVdTWPGMd/YMh3VoKvi+CVZfDXXlO5tvPCUq1GixfykejZuOU/TLpyuJzwpl+EC
    hV2zhHXoBt5z2Rp+x8gLJq+2WhLKTh5JybqJamzPcNWXo7idGS05Pg/2tb3c8FbW
    yGhaiaj7PKtufw7pizc5YE9cgMieOpSNU7Gqp7PXj/89YtEBCjah0f9eZYT2Umk4
    feW+J4rxzaNlo1GnWcBGyBO/D0JU1uOXKJuGGkmKh6oadUeYn6dtxenETcykIdnE
    FjbEDKJWcFUfBYWM8BU4WXQVHUJKRXyae4OBQfo990gjtmuAncsf6H3HYYHA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IcwbtW4D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=IcwbtW4D x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfI1k9CoFB9yXrVztini4lOnMyw/9ysJdxHI1+ddHAVZlj6rdcsft/hqonOClbEWkwycMm85iikLd/38AbkmWUdHyE4+qWNYBL3jHZi/SB+I4I3RyI8KC
    bfUHVf6WXuYdabtoY7YRzN1EGwXQEt6s0XjGv/igsSPgqAmN3yjL+swk0906D8lNh8E4nbgzlaekDBDkNxuySEjioJ7XA1KsIIXLYsyW8Dt8cimylB8PuWiz
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=iox4zFpeAAAA:8 a=yMhMjlubAAAA:8 a=5G9JfAGruNMbQEjIFG4A:9
    a=wPNLvfGTeEIA:10 a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeDIASo (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 20:18:44 -0400
Received: from mail-bn3nam01on0092.outbound.protection.outlook.com ([104.47.33.92]:62923
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753651AbeDIASl (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:18:41 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.15 075/189] block: Set BIO_TRACE_COMPLETION on
 new bio during split
Thread-Topic: [PATCH AUTOSEL for 4.15 075/189] block: Set BIO_TRACE_COMPLETION
 on new bio during split
Thread-Index: AQHTz5gusTsGu93jskapBv62s/4JcQ==
Date: Mon, 9 Apr 2018 00:17:44 +0000
Message-ID: <20180409001637.162453-75-alexander.levin@microsoft.com>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409001637.162453-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB1128;7:hSyzAG0wzqjbM9dEQK24hEcuK3IlUu2xYVmQQgWZeGRJsqqqD8YEvd7luoCMK2toj/bK0EwzyJIl2IKiGoDZDOXii7FdKvpG6eL7G9byjbdRXeQagKSebl8Upp23Gdggj+q77CB78TC4+10GrzPFZ51Iad34qyX+f5Yoz7q0dIxiC+riEA/oO8y+VT/KJYrbhRtViVCvh72fQObMkC9J1yR881mUhuPtpIScuSX0yv9HrGtwBAptTxuwfo2xOGXm;20:yWQbPmmjHwjohb8GqWZpkwf0+/l8m4aH92HiQhII65tQDQRN+1ScpAojA+ASLG2D08AdXzuzLl+xVwReRYEZxUS+NzW610cxzwSti31nKrx1k8I5jkI/S/TTtgUcZ+WvrJ3BRWho/VlWft7jL9762ETuu2njXX3kpXfHf9ccIu0=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: d968ed18-f930-4fbe-b797-08d59daf6f6f
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB1128;
x-ms-traffictypediagnostic: DM5PR2101MB1128:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB1128E0E7770A0FDC5E4C27C9FBBF0@DM5PR2101MB1128.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(61426038)(61427038)(6041310)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB1128;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB1128;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(396003)(376002)(366004)(39380400002)(199004)(189003)(66066001)(86362001)(59450400001)(3660700001)(3280700002)(2900100001)(25786009)(36756003)(6506007)(76176011)(2906002)(6486002)(86612001)(99286004)(102836004)(1076002)(7736002)(97736004)(2616005)(446003)(486006)(11346002)(476003)(26005)(305945005)(6666003)(6512007)(4326008)(107886003)(478600001)(6436002)(5660300001)(10290500003)(5250100002)(22452003)(316002)(105586002)(186003)(8676002)(110136005)(54906003)(72206003)(53936002)(2501003)(68736007)(14454004)(6116002)(8936002)(3846002)(81156014)(10090500001)(106356001)(81166006)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB1128;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: j/bfYRJCrQAFSybVStc0VwIKy1TphE27m6dTQ2Ugnq1dVm2Wmw4P9Yteugeb5LkfmXIToFDk6r6LKQGPasgO3xL8mjGIC9kl9j+0E5L1s2evBpJGJKsGKfF5mszVYKyi4dx4bHuZLuA6jLcQYKX/9axA02wVF2NOzgcmbbF1DwxJb4gPo2MSMJgiBtwBwTQXic5j2wpJ6LdzU8RuzR0dVk/2Hovwuu5Exkse02/FnGP3r/PXkblrHvTDSG7GblpFYAzLhjRbe8saewlTbEB+MfRyhcP8BeBB3y9YkvhEa7/4wvaFmpA8g5o45SaCvxpZ/cjJBUGxxt920raaAjsf7hjCR0ptJTZgWirgWlTku0fCt7NeNDPL9t+yAe+VrWVbWMMSRUkPaOsEvaJ6gAx2CXGO7rzz3/+R5N+LHRdhi7M=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d968ed18-f930-4fbe-b797-08d59daf6f6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:17:44.0394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB1128
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
index 9ef6cf3addb3..7d38b769fde2 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1838,7 +1838,7 @@ struct bio *bio_split(struct bio *bio, int sectors,
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
