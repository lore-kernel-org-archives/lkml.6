Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7A4C282D8
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D22EA20989
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 12:45:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730829AbfA3MpP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 07:45:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:41318 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbfA3MpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 07:45:14 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 412F8AE4B;
        Wed, 30 Jan 2019 12:45:13 +0000 (UTC)
From:   Vlastimil Babka <vbabka@suse.cz>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-api@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jann Horn <jannh@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Andy Lutomirski <luto@amacapital.net>,
        Cyril Hrubis <chrubis@suse.cz>, Daniel Gruss <daniel@gruss.cc>,
        Dave Chinner <david@fromorbit.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jiri Kosina <jikos@kernel.org>, Jiri Kosina <jkosina@suse.cz>,
        Kevin Easton <kevin@guarana.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>, Tejun Heo <tj@kernel.org>
Subject: [PATCH 0/3] mincore() and IOCB_NOWAIT adjustments
Date:   Wed, 30 Jan 2019 13:44:17 +0100
Message-Id: <20190130124420.1834-1-vbabka@suse.cz>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've collected the patches from the discussion for formal posting. The first
two should be settled already, third one is the possible improvement I've
mentioned earlier, where only in restricted case we resort to existence of page
table mapping (the original and later reverted approach from Linus) instead of
faking the result completely. Review and testing welcome.

The consensus seems to be going through -mm tree for 5.1, unless Linus wants
them alredy for 5.0.

Jiri Kosina (2):
  mm/mincore: make mincore() more conservative
  mm/filemap: initiate readahead even if IOCB_NOWAIT is set for the I/O

Vlastimil Babka (1):
  mm/mincore: provide mapped status when cached status is not allowed

 mm/filemap.c |  2 --
 mm/mincore.c | 54 ++++++++++++++++++++++++++++++++++++++++------------
 2 files changed, 42 insertions(+), 14 deletions(-)

-- 
2.20.1

