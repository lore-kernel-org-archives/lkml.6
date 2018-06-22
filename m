Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6AFAC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6204B248F4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 21:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Qsapz7ri"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6204B248F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754562AbeFVVRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 17:17:48 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:34040 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754363AbeFVVRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 17:17:47 -0400
Received: by mail-pg0-f65.google.com with SMTP id q4-v6so3492296pgr.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 14:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=subject:date:message-id:cc:from:to;
        bh=9s3jW+ayIwlUYjcQmfz3VIV35cWrKYC6yvxc6lOVimM=;
        b=Qsapz7rilgNuU1TwB+hDiPs+3VmylwThoJuVLND9bmbhgDanrfoo/7SS16M78vittl
         S6gdo5QdmOqEjOYuIq/zXcVdlPplsbTgmLxUzDnb1S8JiETn1OVmy/+8eFGJZYShh+so
         0pre1otqb6qcG5kJ2FJVqLKTjxHKiifcWzHrZj2DzIgVncfdZwhguSbPjWKCSc1IgjQj
         46k2aDVU1+IcnLWBESMQmeQp15sVWFHpQVqDOckvkzNZ+7Yrh0diqOP8UTpkVzYRHvrt
         nuYC7x4UPWzlQA0TfsejZ2dXZqshvUGMYItlXp9JoDJZtHTjkNY3IJUZ7HPP7/J6AfI9
         msyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:date:message-id:cc:from:to;
        bh=9s3jW+ayIwlUYjcQmfz3VIV35cWrKYC6yvxc6lOVimM=;
        b=AOe++olfwQBNP8zNrvVjE1OnwVrU6vJl2vwkAmFDIJbRyQQ1rD2iDqtUgpuGolw7gy
         CEZGwqTznYacJAU9sbjBVnWgbtIUq6dL/rOJnee9IGkQblCTwA10poT+4YdgZepibstJ
         V8A4zGl5j2ErKDHcvlWF3ZXXBQJGx6wrtt0iOxgRaAzCIGEACbey03XX+WX7+FOwUrd3
         Voubt2qUVHqyL6LOhuQrX86wBkimjXGGJphE1/a55pxskYlLp0H3iHuhGdALIrYKm1iH
         RRyp4eUMNBR0UVJSSDuOyG9Unz9qVMPBC1+Pb8NtwkhyRVdqbQkpyyyPWBHCkohkiGgC
         prDQ==
X-Gm-Message-State: APt69E2oxxio2jKZdThmLlQ/j83egmQP7GytL6pTIhT2eDgs3/Gpzcnx
        UJkE/sjCmAf1Y6fUV6ZLYj0LIQ==
X-Google-Smtp-Source: ADUXVKKGtk6SuniJaDFH0qWvsNpWEoX3HYWiMoXCvRnnh9mc2prypftoDXY5ki0jknJkRfJpksRAPQ==
X-Received: by 2002:a62:3c96:: with SMTP id b22-v6mr3236969pfk.235.1529702266472;
        Fri, 22 Jun 2018 14:17:46 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id 9-v6sm20031558pfn.129.2018.06.22.14.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 14:17:45 -0700 (PDT)
Subject: [PATCH] MAINTAINERS: Add Daniel Lustig as a LKMM reviewer
Date:   Fri, 22 Jun 2018 14:17:03 -0700
Message-Id: <20180622211703.4121-1-palmer@sifive.com>
X-Mailer: git-send-email 2.16.4
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@sifive.com>,
        Daniel Lustig <dlustig@nvidia.com>
From:   Palmer Dabbelt <palmer@sifive.com>
To:     stern@rowland.harvard.edu, andrea.parri@amarulasolutions.com,
        Will Deacon <will.deacon@arm.com>, peterz@infradead.org,
        boqun.feng@gmail.com, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        paulmck@linux.vnet.ibm.com, akiyks@gmail.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan runs the RISC-V memory model working group.  I've been forwarding
him LKMM emails that end up in my inbox, but I'm far from an expert in
this stuff.  He requested to be added as a reviewer, which seem sane to
me as it'll take a human out of the loop.

CC: Daniel Lustig <dlustig@nvidia.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..b980635220e5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8316,6 +8316,7 @@ M:	Jade Alglave <j.alglave@ucl.ac.uk>
 M:	Luc Maranget <luc.maranget@inria.fr>
 M:	"Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
 R:	Akira Yokosawa <akiyks@gmail.com>
+R:`	Daniel Lustig <dlustig@nvidia.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
-- 
2.16.4

