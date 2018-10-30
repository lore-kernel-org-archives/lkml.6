Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AE3C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:01:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD8520827
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 12:01:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp4dzD3c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD8520827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbeJ3Uyy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 16:54:54 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35486 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727763AbeJ3Uyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 16:54:54 -0400
Received: by mail-pf1-f196.google.com with SMTP id z2-v6so3136610pfe.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 05:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=OuYIINrjySJD1JGbLstZALDDWLoQ3+u/7/4Fp4ClFOU=;
        b=Yp4dzD3cFy+QT7PJpBsyhK3FDXhb7FYAnuHKfF+s2mlTJ2bza3s6BMpnUN4e5amGE0
         AdmdlSmh5RfxEyRqM5yOufvAtrsItzX4tiENgHigq6uXjQYQqBuUocoqBAHoM8VCNMvB
         B/T5jRCXcrUH+hs3t14hYKKczI/R6INqg6DXFbWfl18vmB4X+se+NRja3uwLqn2DGq7R
         51Bbqz3kHtULGbZUQyjMuJQOsGnWM134ngoobimqp4gAn7vjAYQzjb3Wt0SDGpCu+SPW
         3SWfTHHq8bfQDS6+Bk/VBbASxXLQgO+p6PA2NYk8av5vi5kw7sJV+pDU4Yumpm9Mlv6n
         UXLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=OuYIINrjySJD1JGbLstZALDDWLoQ3+u/7/4Fp4ClFOU=;
        b=P8zGP2ssF4vS1yAUbtqNfmPsPTvykvYVV5sg/kmex7OqasKOCb2GQ1Ku1WtJUia3GH
         oEsEiQ4nT+3Pbe2Um9eegjG1hA4i9OrI7H5yZnmBjTVSfR07BkEu+t/FdMIQfGEhFkQG
         ejQFfIyZJXuB/IeD+oSzygUg6cJ22nSyVA9Jd6AYeLykNHQ13VNHGL3+Oqzkbq/EPGw/
         XFzIx1jaj93mwwoPgDHP4FUU6ovH3F1BwfIH7BxX5+R8cndugmUIAuBs2vPDx/f7PIpZ
         qFYzMRvDMYAh8D8VSBZWEf5EUKAFaGoOuGobx8kIXq9eLQ9KqelLTOtlaN3EeqHNGiHR
         CeXQ==
X-Gm-Message-State: AGRZ1gIXek38lBkYDLh2CAKH9OOrbZKI5a//H2mjNQjixnDCJAqzsQki
        Z9EL+lKB755vZA4f/I3R6xs=
X-Google-Smtp-Source: AJdET5ctar8n2pTBY/biaEzXHF02X+WpnTisyAZzPc/aKzH236YnIaNJIlz4uPgHn2vjQ0UorztTHw==
X-Received: by 2002:a63:db04:: with SMTP id e4-v6mr17803294pgg.280.1540900902199;
        Tue, 30 Oct 2018 05:01:42 -0700 (PDT)
Received: from localhost.localdomain ([191.101.9.198])
        by smtp.gmail.com with ESMTPSA id s80-v6sm27378369pfa.114.2018.10.30.05.01.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Oct 2018 05:01:41 -0700 (PDT)
From:   Bo YU <tsu.yubo@gmail.com>
To:     gregkh@linuxfoundation.org, rafael@kernel.org
Cc:     linux-kernel@vger.kernel.org, Bo YU <tsu.yubo@gmail.com>
Subject: [PATCH 0/3] kobject: fix warnings from ehcekpatch.pl
Date:   Tue, 30 Oct 2018 08:01:13 -0400
Message-Id: <cover.1540886346.git.tsu.yubo@gmail.com>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,this is a series of patches which fix warning from checkpatch.pl.
I do not know which tree should apply these patches,so i git format-patch
from linus' s kernel tree.

Bo YU (3):
  kobject: drop unnecessary cast "%llu" for u64
  kobject: Fix warnings in lib/kobject_uevent.c
  kobject: fix warnings use pr_* to replace  printk

 lib/kobject_uevent.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--
2.11.0

