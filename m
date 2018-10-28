Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7482ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BE320870
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 15:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mpjnwcTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BE320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeJ2A3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 20:29:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36510 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727339AbeJ2A3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 20:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=O2Rkp9XcHFdJb+bA3sa04gAwLx2vSFjEhXNmvFqdJN4=; b=mpjnwcTg3rV4QAYU8gQ/MdGjg
        7SXLxal9kdwxyITtbQRgUHXabih1nWx1w0+nmwZTvXTj6SSoJY528hIkMrXk4xOlG0KSrhyAPesD1
        Lylq8FDGxQ5iVZ6ooJUAlWEtQc8+A5zYk5urg6iT4hzwUpUn2AtatIFONWFxE84RF7DTiBndXvdPC
        bTCYtYdOiejRRF46HicEKEHl/xu73Rfp9g2H4scBhL9dfPUMaQ/rII0ZLaB5DxkQKVeB/K8JTDauf
        5WfaPChhhcO0n9a370aXsZIVmQi8TGt0BkC7Hns1jErg5d/vkjtJQie9sWlUhjnjH50EsRu/hYhNP
        eZ2LqDdIQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGnEU-00076J-62; Sun, 28 Oct 2018 15:44:06 +0000
Date:   Sun, 28 Oct 2018 08:44:06 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        ooo@electrozaur.com, Nathan Chancellor <natechancellor@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        linux-scsi@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        hch@infradead.org
Subject: Re: [PATCH] libosd: Remove ignored __weak attribute
Message-ID: <20181028154405.GA26300@infradead.org>
References: <20181025225548.GA10326@flashbox>
 <CAKwvOdnwmf47_m_0K5OCLmXbrkLNnekpNOPCCMeJqkuqKUbQ-A@mail.gmail.com>
 <1540576908.66186.103.camel@acm.org>
 <CAKwvOdnYx60JkJHJkD7CYA9yx5Oa7Tn9q4aZ3-tcZGx++yoduQ@mail.gmail.com>
 <1540589437.66186.124.camel@acm.org>
 <CAKwvOdm-xYRqCBXhLC1ceC44_rEmggW4qiSgGpRkpL+p-NadVg@mail.gmail.com>
 <1540591147.66186.127.camel@acm.org>
 <CAKwvOdmUhtK10cbYFoEJJp4O8LA_F-+f68A_NcL_fm_FH6QodA@mail.gmail.com>
 <1540592684.66186.136.camel@acm.org>
 <yq1o9bfcydm.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1o9bfcydm.fsf@oracle.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 27, 2018 at 09:28:21AM -0400, Martin K. Petersen wrote:
> The OSD protocol failed to get traction in the industry, adoption was
> very limited. If the code just plugged straight into existing kernel
> interfaces it would be easier to justify keeping it around. However, the
> OSD support requires bidirectional command support so we carry a bunch
> of additional plumbing in both block and SCSI to accommodate it. There
> are no other users of these interfaces, so dropping OSD would mean we
> could simplify some (hot) code paths. That would be a win in my book.
> Consequently, if a patch were to materialize that disentangled and
> removed OSD, I'd be inclined to merge it.

In addition to the exofs and osd removal I sent out I've also done the
SCSI cleanup here:

http://git.infradead.org/users/hch/misc.git/shortlog/refs/heads/remove-scsi-osd

unfortunately the bsg-lib code also uses the block bidi support, but
then again at least for the blk-mq case that code isn't too bad,
and Jens is about to remove the legacy request code.
