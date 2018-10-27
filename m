Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96580C46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:20:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25D2520856
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 08:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="muKQwXu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25D2520856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728299AbeJ0RAn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 13:00:43 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52964 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727643AbeJ0RAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 13:00:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=r7pcUE8ZYRjkrOxqSGW41abNyHoWl4gSq+v5SHUSiGw=; b=muKQwXu95MlJ5Nlzqu2sPSvjl
        MmVeVCOcwVjka0ItvRcBsyMpDHdjxZVRs9HXDbFOpQfjiVU5pBx8j+ESIBmrf3L9QxLltWUGm8eti
        2wDFuZq0uBneG1aqi0EbJsJHnzIJOcGVvHoQ4srhWcCX8KJ9jHifsDX62ugOUfwSmnSBSKzpcg9Fi
        6pzl0z5Tn+jkNH+tMvVnplcr+3R3ni7APP8YDehDX2XsTOrI1jsqBgjw1N+ik+wq2v07/WH+Kqd5L
        b4UnEQpnUG3PqCnHpjrc/CG2d9X/bch3unVs+sVYQF4YyFzxncueuz4i/tTbrNpvyh/QIMb1+QQ1n
        Krs9+uI5w==;
Received: from 089144192143.atnat0001.highway.a1.net ([89.144.192.143] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gGJpa-0006Fx-9y; Sat, 27 Oct 2018 08:20:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     ooo@electrozaur.com, martin.petersen@oracle.com
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        osd-dev@open-osd.org, linux-scsi@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: remove exofs and the T10 OSD code V2
Date:   Sat, 27 Oct 2018 10:20:17 +0200
Message-Id: <20181027082019.20838-1-hch@lst.de>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only real user of the T10 OSD protocol, the pNFS object layout
driver never went to the point of having shipping products, and we
removed it 1.5 years ago.  Exofs is just a simple example without
real life users.

The code has been mostly unmaintained for years and is getting in the
way of block / SCSI changes, so I think it's finally time to drop it.

Quote from Boaz:

"As I said then. It is used in Universities for studies and experiments.
Every once in a while. I get an email with questions and reports.

But yes feel free to remove the all thing!!

I guess I can put it up on github. In a public tree.

Just that I will need to forward port it myself, til now you guys
been doing this for me ;-)"
