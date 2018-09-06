Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33893C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC3BB20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 14:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=thunk.org header.i=@thunk.org header.b="BEmUUIgl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC3BB20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mit.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729355AbeIFSnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 14:43:37 -0400
Received: from imap.thunk.org ([74.207.234.97]:58650 "EHLO imap.thunk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729085AbeIFSnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 14:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org;
         s=ef5046eb; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tTSkC5GsQeu3N4jVk395IrIa9J7+W9L/SlK3Tg93FzY=; b=BEmUUIgllDgG/ekOof7brruhuy
        RDPfQNDSqni/Is7TsLFlWMjcp15kAkInR0nDg/qq3encHMkLJgQoKdz2BDhhbZumZT+dr7r5rIUdK
        UJ0mJUsCxz5K8ds+zKulCN8sE61QRokbABxrmRqiY7LuHNadhk82tlvckxSOlStzztBM=;
Received: from root (helo=callcc.thunk.org)
        by imap.thunk.org with local-esmtp (Exim 4.89)
        (envelope-from <tytso@thunk.org>)
        id 1fxuwj-0003uw-MU; Thu, 06 Sep 2018 14:07:45 +0000
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A226C7A5670; Thu,  6 Sep 2018 10:07:44 -0400 (EDT)
Date:   Thu, 6 Sep 2018 10:07:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Souptick Joarder <jrdr.linux@gmail.com>, Jan Kara <jack@suse.cz>,
        syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mgorman@techsingularity.net, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com, zwisler@kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: linux-next test error
Message-ID: <20180906140744.GB5098@thunk.org>
Mail-Followup-To: "Theodore Y. Ts'o" <tytso@mit.edu>,
        Souptick Joarder <jrdr.linux@gmail.com>, Jan Kara <jack@suse.cz>,
        syzbot+87a05ae4accd500f5242@syzkaller.appspotmail.com,
        ak@linux.intel.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        mgorman@techsingularity.net, syzkaller-bugs@googlegroups.com,
        tim.c.chen@linux.intel.com, zwisler@kernel.org,
        Matthew Wilcox <willy@infradead.org>
References: <0000000000004f6b5805751a8189@google.com>
 <20180905085545.GD24902@quack2.suse.cz>
 <CAFqt6zZtjPFdfAGxp43oqN3=z9+vAGzdOvDcgFaU+05ffCGu7A@mail.gmail.com>
 <20180905133459.GF23909@thunk.org>
 <CAFqt6za5OvHgONOgpmhxS+YsYZyiXUhzpmOgZYyHWPHEO34QwQ@mail.gmail.com>
 <20180906083800.GC19319@quack2.suse.cz>
 <CAFqt6zZ=uaArS0hrbgZGLe38HgSPhZBHzsGEJOZiQGm4Y2N0yw@mail.gmail.com>
 <20180906131212.GG2331@thunk.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180906131212.GG2331@thunk.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

P.S.  This is the second time the vm_fualt_t change has broken things.
The first time, when it went through the ext4 tree, I NACK'ed it after
a 60 seconds smoke test showed it was broken.  This time it went
through the mm tree...

In the future, even for "trivial" changes, could you *please* run the
kvm-xfstests[1] or gce-xfstests[2][3]?

[1] https://github.com/tytso/xfstests-bld/blob/master/Documentation/kvm-quickstart.md
[2] https://github.com/tytso/xfstests-bld/blob/master/Documentation/gce-xfstests.md
[3] https:/thunk.org/gce-xfstests

Or if you're too lazy to run the smoke tests, please send it through
the ext4 tree so *I* can run the smoke tests.

						- Ted
