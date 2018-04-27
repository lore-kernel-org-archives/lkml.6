Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-284719-1524838393-2-2651703304747469064
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524838392; b=Qdhme/xEsADAdv6ekxwV75Tvbi7my/gPUkcsAPRxfcm0bqLIAd
    mwzLk7s+MXn6y3lPJUjHHpBnurwXZgCNjz3L19iWxDnQdFIREdWTQpFuFrwj1KWm
    7HYT2sddF+rKRqGoVujHEGTbTFhjd/Lre/cMh/rQBwPg9Ulc85IJzO18qn6H26pb
    CFerI55V5FuxAswFnLQb38S15SGcjEpSfyYRKdqqUj7Gpdc5c1CUwhRqY3x2Bb5S
    BkgkcfVJ4VIHNNkdsMgebYVAK0R0+EbQYG0rP16C66ZxbuOMnZ024v68IazrDB6c
    +CxZi+Kgk4DLR+34vL+tGLCkACLZHTxMCO8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524838392; bh=yE77Og4ci4bBmgDXS+j3pJ+3KLo+61
    RfJJM3DkTbmJA=; b=aoMlVsRixJch/1g+Muc0NyRpb4ZjVViO6UmiNlBUdGHfKw
    3t4mnhKFZ5HSn5GN+wa5nx9G4B+qy4fxZaudC1ohjoilJ///548JoHM+HX1s0s2E
    UmezcyBn43oeGq93vKQeRgMLwVo6i9uGkXwitwumPvpxJ7Xw+lXP8k90MtoxaQJa
    zZ/LNoX9pj9YXh29MsoqgcPExMtvObrHe+Lv9ZsY1zRNdUb4RzZssCsj5NgLwiqD
    fYRtYXvYuNfUNmAQaLZuGJY9rlzHvdPY7BWlPb7m0Lx9jxhgmWaxWat2b5p9xiOA
    bLyGPPfOPm7xtUNG/LPrJB5ZqsJwJ+/RfHYmcYqg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBJoi+PRUPwWLDghh35BNMSgSSu6h1Wo1YiGmr2Ous2schjh7kyvidHaaUHm+WAmzVRjK5jtakjmzlQdxL0QRP0XQUFp8iAunLMJi+6/cujM/1ASKRuK
    j6F4LgdRldUTi4EEaEkk7j2nBVCYTbdLvGCtnxHvfPcCz6W2vLaiMqWNePfI8qJ5LBxYbmjIBr0mg97uwr3XijXqRPP7KzPNyCbkQIF+BjdnMgXFX14CCFyP
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=8981fWPbAAAA:8 a=20KFwNOVAAAA:8 a=VwQbUJbxAAAA:8 a=CjxXgO3LAAAA:8
    a=ag1SF4gXAAAA:8 a=t3Etx5NInMrR6of4Y5sA:9 a=qGbTWmQTrKO4e156:21
    a=UsiH1dCW4psV9jwG:21 a=QEXdDO2ut3YA:10 a=o72u2rHnfW5qNJ_4I8LD:22
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934914AbeD0ONE (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57434 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935277AbeD0ONC (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:13:02 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1761218BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Stan Johnson <userm57@yahoo.com>,
        Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 4.16 72/81] block/swim: Fix IO error at end of medium
Date: Fri, 27 Apr 2018 15:59:14 +0200
Message-Id: <20180427135747.472667321@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Finn Thain <fthain@telegraphics.com.au>

commit 5a13388d7aa1177b98d7168330ecbeeac52f844d upstream.

Reading to the end of a 720K disk results in an IO error instead of EOF
because the block layer thinks the disk has 2880 sectors. (Partly this
is a result of inverted logic of the ONEMEG_MEDIA bit that's now fixed.)

Initialize the density and head count in swim_add_floppy() to agree
with the device size passed to set_capacity() during drive probe.

Call set_capacity() again upon device open, after refreshing the density
and head count values.

Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: stable@vger.kernel.org # v4.14+
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Acked-by: Laurent Vivier <lvivier@redhat.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/block/swim.c |   13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

--- a/drivers/block/swim.c
+++ b/drivers/block/swim.c
@@ -612,7 +612,6 @@ static void setup_medium(struct floppy_s
 		struct floppy_struct *g;
 		fs->disk_in = 1;
 		fs->write_protected = swim_readbit(base, WRITE_PROT);
-		fs->type = swim_readbit(base, TWOMEG_MEDIA);
 
 		if (swim_track00(base))
 			printk(KERN_ERR
@@ -620,6 +619,9 @@ static void setup_medium(struct floppy_s
 
 		swim_track00(base);
 
+		fs->type = swim_readbit(base, TWOMEG_MEDIA) ?
+			HD_MEDIA : DD_MEDIA;
+		fs->head_number = swim_readbit(base, SINGLE_SIDED) ? 1 : 2;
 		get_floppy_geometry(fs, 0, &g);
 		fs->total_secs = g->size;
 		fs->secpercyl = g->head * g->sect;
@@ -656,6 +658,8 @@ static int floppy_open(struct block_devi
 		goto out;
 	}
 
+	set_capacity(fs->disk, fs->total_secs);
+
 	if (mode & FMODE_NDELAY)
 		return 0;
 
@@ -808,10 +812,9 @@ static int swim_add_floppy(struct swim_p
 
 	swim_motor(base, OFF);
 
-	if (swim_readbit(base, SINGLE_SIDED))
-		fs->head_number = 1;
-	else
-		fs->head_number = 2;
+	fs->type = HD_MEDIA;
+	fs->head_number = 2;
+
 	fs->ref_count = 0;
 	fs->ejected = 1;
 
