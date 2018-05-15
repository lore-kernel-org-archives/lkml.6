Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3390743-1526424264-2-6835191386569043538
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='UNK'
X-Spam-charsets: plain='US-ASCII'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526424263; b=MM8uL/v3V8bNrwxppH/NgnfPPhLQwk9OtIQOQRO0WDZwgKxW0F
    +YjOi8cP5HUyWYW5RxuFI/Lv6GgFJLIVEar039u9D06A9j9DtWBQaHABVoO0Bvi+
    WJJ9Z3f7/R8b4EhmPb+akLMV5861XdN71Y0q+RueWXp0dC3nT8uGY6gCTmGTB18c
    TiXf0xCccwLMgW175cV4SzYO9wF+0wKhyp0mQO6+ER+JEsFefN6EKvCLNGxdfpAA
    eLO3PIUILsVtUf98YaLIHz7GPfip9oA+UGPOFuxRYckfAZGsJmoVOP/Ep+zTNtPt
    RtUn7ZlOa6o2/H6CXl9I/YMQb/XVNJJzujtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:in-reply-to
    :message-id:references:mime-version:content-type:sender:list-id;
    s=fm2; t=1526424263; bh=XoCvDIsgMVBgNq0YqbhRFBtXXbnsPD1vimVOgvo
    3GgQ=; b=T9GW5953ttBYkxJT4tG9fvQqKOmpk4xkLm8gBNBVEUb3yRNKm2iMbup
    vNChYrzQYThPzucYg4TsbxrCD5L9w9k5OHTTHp2CFo9+QLK7F+EELGzybBw8N7cz
    IuW9GtqVaVdWwpm7va93yaJ4gjqaiX8cxomKoHlqdkXQxFSbJrkXrjew78gTLVaU
    aAVCqYRfVgbpYdG8bJYipXY5KAGDt3W+0lat7FGvDPrdAlEHasa/WHUjLd5dIFQ7
    6h47CTsTm1fdTD7d85pJ1VCZkBs63k5uqBHouLzC1KifqDA33TbRUNCdLXebwvDJ
    RcbWP865wbwiaHA2C2mgmql0XBP9uyA==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=mips.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=mips.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfICpSA7kRoT4jqqg8tCVUWpwsA+Dye+eYQNy6eWF3cDfPn646IFzjVr91Ej1LhbQTez/L/8hYJn2lN2k210TX3qmiE3OeXykyDLH5zpNR8YjcjkFNbjs
    msZ69EEaEZeU/A82OXWdSsOUFzy8yGCfZ4RskefrGGQdBFOv6p1tjCtKOrnpbVHaZwONu0qcIhTsNZDuXeI1sm8vypOKkOyCrJ2+lAMNH1pkqknnnRGL14XS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=iAo7guES1noA:10 a=kj9zAlcOel0A:10
    a=VUJBJC2UJ8kA:10 a=VwQbUJbxAAAA:8 a=gPJu0pBYAAAA:8 a=k_FO0sCuq7tir4-YhqYA:9
    a=CjuIK1q_8ugA:10 a=AjGcO6oz07-iQ99wixmX:22 a=AlIIF0cMT2hfDT4axODj:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeEOWoW (ORCPT <rfc822;greg@kroah.com>);
        Tue, 15 May 2018 18:44:22 -0400
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:51952 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeEOWoV (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 15 May 2018 18:44:21 -0400
Date: Tue, 15 May 2018 23:32:45 +0100
From: "Maciej W. Rozycki" <macro@mips.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>
CC: Ralf Baechle <ralf@linux-mips.org>,
        <linux-fsdevel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 1/3] binfmt_elf: Respect error return from `regset->active'
In-Reply-To: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
Message-ID: <alpine.DEB.2.00.1805102009380.10896@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1804301557320.11756@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.107]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1526424196-298555-22307-24440-2
X-BESS-VER: 2018.6-r1805102334
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193020
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The regset API documented in <linux/regset.h> defines -ENODEV as the 
result of the `->active' handler to be used where the feature requested 
is not available on the hardware found.  However code handling core file 
note generation in `fill_thread_core_info' interpretes any non-zero 
result from the `->active' handler as the regset requested being active. 
Consequently processing continues (and hopefully gracefully fails later 
on) rather than being abandoned right away for the regset requested.

Fix the problem then by making the code proceed only if a positive 
result is returned from the `->active' handler.

Cc: stable@vger.kernel.org # 2.6.25+
Fixes: 4206d3aa1978 ("elf core dump: notes user_regset")
Signed-off-by: Maciej W. Rozycki <macro@mips.com>
---
Hi,

 Overall we could also use the count returned by ->active to limit the 
size of data requested, i.e. something along the lines of:

	ssize_t size;

	if (regset->active)
		size = regset->active(t->task, regset);
	else
		size = regset_size(t->task, regset);
	if (size > 0) {
		...	

however that would be an optimisation that belongs to a separate change, 
which (due to the need to unload stuff I have in progress already) I am 
not going to make at this point.  Perhaps someone else would be willing 
to pick up the idea.

 Anyway, please apply.

  Maciej
---
 fs/binfmt_elf.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

linux-elf-core-regset-active.diff
Index: linux-jhogan-test/fs/binfmt_elf.c
===================================================================
--- linux-jhogan-test.orig/fs/binfmt_elf.c	2018-03-21 17:14:55.000000000 +0000
+++ linux-jhogan-test/fs/binfmt_elf.c	2018-05-09 23:25:50.742255000 +0100
@@ -1739,7 +1739,7 @@ static int fill_thread_core_info(struct 
 		const struct user_regset *regset = &view->regsets[i];
 		do_thread_regset_writeback(t->task, regset);
 		if (regset->core_note_type && regset->get &&
-		    (!regset->active || regset->active(t->task, regset))) {
+		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size = regset_size(t->task, regset);
 			void *data = kmalloc(size, GFP_KERNEL);
