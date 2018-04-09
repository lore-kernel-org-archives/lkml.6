Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3828464-1523239352-2-13706659900002786975
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, URIBL_SBL 1.623,
  URIBL_SBL_A 0.1, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523239351; b=FnMttjF5SMd5tBY2othTdGAyembT81Oli4brRih5cZApFgXDEL
    Wehb803xHvgmqSmV21oU47Jg534XX/Zu5DWRRLZVZC+7b6QI22hK/jvgXjJePlfr
    0WMAzHVsRZT+1GGOg7T02h6fb7qTWBr4iOK3TlGdGgKCoRG9UVSxRilV1hDhIzJA
    Ayx5LbLEXL+WzdY4BMZB5+GZWL8cje7KNZ7IYSK5GhdwR76ASTSEenKnaFBUKBBW
    2Spq7+ubrU8C8H1c1g9wXplwD3uEAEwTzZN0wwIWjAIjfggesSzbhVoD+r30+0xt
    d8y6M2USDuiMcXBIFQGxCL4akarIPypsl9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :references:in-reply-to:content-type:content-transfer-encoding
    :mime-version:sender:list-id; s=fm2; t=1523239351; bh=oIdgS9vF2i
    J02j2w/3AUPx2TG0SaJE3cZ67FGQYaQMM=; b=GfIZM8eSM358WbZX7riiBj+hHe
    wS8C4wXpM7C9MD97257Rhsd689RZS5KGBvSP0zClWhQS/ypMpPLyJGMSsCyg2Kxf
    xP50crhX5gesmIVXBR1Sjvunr5Dn8xmXcmVCtvo4ItMl4Z3hMxwpAXQrrd3Ttiwc
    15/pERWJqkmVqPfNZf6542p6twgA1TZ4AslDe/xCIPvC8LGS70KJex+PrPzwnKRP
    T98i/swN/Ybl1OBlQLHsB8QDisLSKVtXcO17RGORwvXcvfW7YhODoI4g6sElMGoI
    ZbD46NUINzlYlVCQhHQkCyeTXsLLMlPaq1yVJM8dvWV9bc3h5lz2DqdDJ61Q==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nv+qvJcT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
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
    dkim=pass (1024-bit rsa key sha256) header.d=microsoft.com header.i=@microsoft.com header.b=nv+qvJcT x-bits=1024 x-keytype=rsa x-algorithm=sha256 x-selector=selector1;
    dmarc=pass (p=reject,has-list-id=yes,d=none) header.from=microsoft.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microsoft.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLSahRg2cA1XPmZc0o63dJE+rVXP4SKHcDE+jANitnJ5SK/oj/7WK/CMdLx8j7vTHKOWEzWVhj3cbdumhwE7dDSj//Rfpk8IjRHRixtQ1NbnGw2f0Eh+
    CqOoWsS3J7OvAnIF5rDmpwb6JJ7bdo5g0zYjnOlI+sew/dGiGL3+ZIf7mA1/0AxYaGymTS/KHx9u0G6ldhZGMDgSTmliYgPU/kDZbmv0oUxAibp4TJrcXIzM
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=wRwT6uffUbIA:10 a=t_PdEiP4ckcA:10
    a=mw6kJ3eo-EIA:10 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10 a=Kd1tUaAdevIA:10
    a=Lf-vpJhqX20A:10 a=6rqHouBjAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
    a=yMhMjlubAAAA:8 a=rFzxkE_IBQ0RFgvuSlIA:9 a=wPNLvfGTeEIA:10
    a=Hx1yvPaMooE3kwe23bt7:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757658AbeDICCL (ORCPT <rfc822;greg@kroah.com>);
        Sun, 8 Apr 2018 22:02:11 -0400
Received: from mail-sn1nam01on0103.outbound.protection.outlook.com ([104.47.32.103]:45281
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1756356AbeDIAcK (ORCPT <rfc822;stable@vger.kernel.org>);
        Sun, 8 Apr 2018 20:32:10 -0400
From: Sasha Levin <Alexander.Levin@microsoft.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Dmitry Monakhov <dmonakhov@openvz.org>,
        Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 199/293] block: guard bvec iteration logic
Thread-Topic: [PATCH AUTOSEL for 4.9 199/293] block: guard bvec iteration
 logic
Thread-Index: AQHTz5lDrae7ZH+8K0ycsFbaLTq56Q==
Date: Mon, 9 Apr 2018 00:25:29 +0000
Message-ID: <20180409002239.163177-199-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;DM5PR2101MB0870;7:14gI5Q5Z+DKzfV0CTMwdKKThmt+sHxT+sxt4pKQv5cEzM9Vp0vQtnZo4vOSNf2CsirdpR1FXyyfs+tJiVx8lL2M90Hmg3BdEzXEgUqfgsFsIB7cux/FRMwp+fAn785NdLhdJJuaebXWFcNkkoHhnQuUq8n/zRlKCNG6rLdgja097536SYzqW49lm81MSPytxa1B3x3hheTz/7wSzdTWFICdDhXJsmry0qPAfVCptm1MoLYIvuCdMDl2GbUbKcsS+;20:DlM9U3PPy6nfpRfu3TWD0s42l2D6sTMRIlmtDG4FykBTSn8uOmudd/p/1m6yHMyzeU/9GAWirUylGrqUVXo82zNFUUV3Urxl4AexidrHh2NtBtFdgOIBHsASsRUsYC5zo/j47EIVRLchfFhtBfd0FdLlri4epYLM6GDtlLuX0RQ=
x-ms-office365-filtering-ht: Tenant
X-MS-Office365-Filtering-Correlation-Id: 11953471-8584-4edb-d11d-08d59db152d9
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4604075)(3008032)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR2101MB0870;
x-ms-traffictypediagnostic: DM5PR2101MB0870:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com;
x-microsoft-antispam-prvs: <DM5PR2101MB0870DBC5CE0626CBA7D2DD2FFBBF0@DM5PR2101MB0870.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(146099531331640);
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(61425038)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231221)(944501327)(52105095)(93006095)(93001095)(6055026)(61426038)(61427038)(6041310)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR2101MB0870;BCL:0;PCL:0;RULEID:;SRVR:DM5PR2101MB0870;
x-forefront-prvs: 0637FCE711
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(346002)(39860400002)(366004)(396003)(39380400002)(376002)(199004)(189003)(53936002)(2906002)(6512007)(102836004)(2616005)(76176011)(14454004)(446003)(10090500001)(11346002)(476003)(486006)(107886003)(2900100001)(97736004)(66066001)(6506007)(6436002)(106356001)(99286004)(105586002)(3660700001)(6116002)(86612001)(3280700002)(6666003)(2501003)(10290500003)(26005)(8676002)(8936002)(478600001)(68736007)(5250100002)(5660300001)(316002)(4326008)(72206003)(186003)(110136005)(6486002)(7736002)(25786009)(3846002)(86362001)(36756003)(22452003)(81156014)(81166006)(305945005)(54906003)(1076002)(22906009)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR2101MB0870;H:DM5PR2101MB1032.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam-message-info: /YElMYFTmGNLEDLq7ZqaWFFwYGmOd8c+Fp3QBO/23Wpe35ele7+sOxNahycJeoixamU2Qla6PBYQ3aolkaeguLsUDeanJm+ZeBvog1HipOUKM96Z3G/HWedvv55HWeUJbJUPn092QE7SYhggcqzY6DkWI0Qboa2rYvSBYTGoBHB6RRbBFqRESoIZO8FZPivZKuttwOUG0g+Cju3mo6OJrZJwAbsSQKOPFr3APQH+LynEpeUbYgWZjRjqfbSSXy2FZYQmZEjsEM9QJhC/0hP0+3gh5fmeIDsubI0z7T/Mf2QETVk5wwP0oZqXoPaTLWaoW+VRUjVdKOu6p/STUsCT8kNt8jKd/XRLwD+PIhgOBht1I4rrxCGuyIl0wMsFr3ipGVxOHbVhtDnu9FXyoaAhEBFeW6PMaq9WQzrRHslDRns=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11953471-8584-4edb-d11d-08d59db152d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Apr 2018 00:25:29.5033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR2101MB0870
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Dmitry Monakhov <dmonakhov@openvz.org>

[ Upstream commit b1fb2c52b2d85f51f36f1661409f9aeef94265ff ]

Currently if some one try to advance bvec beyond it's size we simply
dump WARN_ONCE and continue to iterate beyond bvec array boundaries.
This simply means that we endup dereferencing/corrupting random memory
region.

Sane reaction would be to propagate error back to calling context
But bvec_iter_advance's calling context is not always good for error
handling. For safity reason let truncate iterator size to zero which
will break external iteration loop which prevent us from unpredictable
memory range corruption. And even it caller ignores an error, it will
corrupt it's own bvecs, not others.

This patch does:
- Return error back to caller with hope that it will react on this
- Truncate iterator size

Code was added long time ago here 4550dd6c, luckily no one hit it
in real life :)

Signed-off-by: Dmitry Monakhov <dmonakhov@openvz.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
[hch: switch to true/false returns instead of errno values]
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 drivers/nvdimm/blk.c |  3 ++-
 drivers/nvdimm/btt.c |  3 ++-
 include/linux/bio.h  |  4 +++-
 include/linux/bvec.h | 14 +++++++++-----
 4 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/nvdimm/blk.c b/drivers/nvdimm/blk.c
index 77db9795510f..ac6d6771d47c 100644
--- a/drivers/nvdimm/blk.c
+++ b/drivers/nvdimm/blk.c
@@ -106,7 +106,8 @@ static int nd_blk_rw_integrity(struct nd_namespace_blk =
*nsblk,
=20
 		len -=3D cur_len;
 		dev_offset +=3D cur_len;
-		bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
+		if (!bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len))
+			return -EIO;
 	}
=20
 	return err;
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 0c46ada027cf..add695bc2cb9 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1075,7 +1075,8 @@ static int btt_rw_integrity(struct btt *btt, struct b=
io_integrity_payload *bip,
=20
 		len -=3D cur_len;
 		meta_nsoff +=3D cur_len;
-		bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len);
+		if (!bvec_iter_advance(bip->bip_vec, &bip->bip_iter, cur_len))
+			return -EIO;
 	}
=20
 	return ret;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 97cb48f03dc7..9a804d65a50e 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -171,8 +171,10 @@ static inline void bio_advance_iter(struct bio *bio, s=
truct bvec_iter *iter,
=20
 	if (bio_no_advance_iter(bio))
 		iter->bi_size -=3D bytes;
-	else
+	else {
 		bvec_iter_advance(bio->bi_io_vec, iter, bytes);
+		/* TODO: It is reasonable to complete bio with error here. */
+	}
 }
=20
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
diff --git a/include/linux/bvec.h b/include/linux/bvec.h
index 89b65b82d98f..de317b4c13c1 100644
--- a/include/linux/bvec.h
+++ b/include/linux/bvec.h
@@ -22,6 +22,7 @@
=20
 #include <linux/kernel.h>
 #include <linux/bug.h>
+#include <linux/errno.h>
=20
 /*
  * was unsigned short, but we might as well be ready for > 64kB I/O pages
@@ -66,12 +67,14 @@ struct bvec_iter {
 	.bv_offset	=3D bvec_iter_offset((bvec), (iter)),	\
 })
=20
-static inline void bvec_iter_advance(const struct bio_vec *bv,
-				     struct bvec_iter *iter,
-				     unsigned bytes)
+static inline bool bvec_iter_advance(const struct bio_vec *bv,
+		struct bvec_iter *iter, unsigned bytes)
 {
-	WARN_ONCE(bytes > iter->bi_size,
-		  "Attempted to advance past end of bvec iter\n");
+	if (WARN_ONCE(bytes > iter->bi_size,
+		     "Attempted to advance past end of bvec iter\n")) {
+		iter->bi_size =3D 0;
+		return false;
+	}
=20
 	while (bytes) {
 		unsigned iter_len =3D bvec_iter_len(bv, *iter);
@@ -86,6 +89,7 @@ static inline void bvec_iter_advance(const struct bio_vec=
 *bv,
 			iter->bi_idx++;
 		}
 	}
+	return true;
 }
=20
 #define for_each_bvec(bvl, bio_vec, iter, start)			\
--=20
2.15.1
