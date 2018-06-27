Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6768EC43144
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13C5A24903
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 21:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IypmtCXU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C5A24903
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755065AbeF0Vo4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Jun 2018 17:44:56 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:46430 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751986AbeF0Voz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jun 2018 17:44:55 -0400
Received: by mail-io0-f202.google.com with SMTP id d189-v6so2670733iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jun 2018 14:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:message-id:subject:from:to:cc;
        bh=urO4q+tiItkRCEIpbjrzywMw7hfVdQdAHx4bAgIywCI=;
        b=IypmtCXUgTyUTwhxq3vPhsCw7J4mbo4XNYAExZZ5j871dFf16lpu3bx50u5UqP+hyW
         ViAPGVokcEbA/hw191bM4cBt5HKEGLiqsyR26AURN1ONJU11cPODD8kFf7EtAyYZcPra
         4ZMeyBKY6ZMnpWuwem7cIDG3FpWtZE+QDlTFYZb0kvQJ4ZazlY0unxhP1yysIxHkfLND
         0zZw4C2j0vQHjzHxL7AUqqrZIJwexKq/lUXWMjuT+Qb0fIBMVa0QPIiepaLSDW6ObcxG
         a11vh4ylrfPOKWt+N5lscp0heDlEzga0P2VShXw5ikAMlFKzHRufujqD6JQtWUiqItA1
         M1BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to:cc;
        bh=urO4q+tiItkRCEIpbjrzywMw7hfVdQdAHx4bAgIywCI=;
        b=N5zYWdrvbjgvEsMBHBcQO7drYOxMjQZERzX5UoWV/FuhhE8z085cNO1gptH0NPFlFh
         jiRx+W0uonUxXGF7TEYJ4g+Z7TWRU0eQzndiVexSeLj0fX5Dws6M7rg8Y4NgTR2U8tEu
         brtttDKnIuixR/KYtGbEGezFpOeJwT3o3MT6ak31oze1VStpBNJeOxCvuJabFC8UOxKG
         lkj7ALkbeHCQkCLW0vpRja2AGmJgQzJNsyPJzJbG1F9T/Yvxe06/cvXGKODXmZSfgcF+
         MFVcL6rVK+b2riRgLtvpYttR+yFT/5GTetKrn2rVHYzIQV8CHNP3lY0QKzzPPZSNwwnt
         3v9Q==
X-Gm-Message-State: APt69E3w8PAbhs5fpD95gUunO1K+XtB82J/r+rEiaNRxO7qtWOpXifCd
        uiEDfqQ78rpB8wbmG1F6PD5tsJcZMYKqQ319OdnlDg==
X-Google-Smtp-Source: ADUXVKJhVx6+2KxG3qCuDdjWOQydkNneiAFdF8I9WGWU57WvXKBnVbntv5xda3oFIl9IWXXNMMGFJj+UnB2UaoEHLWNSVg==
MIME-Version: 1.0
X-Received: by 2002:a24:324d:: with SMTP id j74-v6mr3101177ita.26.1530135894703;
 Wed, 27 Jun 2018 14:44:54 -0700 (PDT)
Date:   Wed, 27 Jun 2018 14:44:47 -0700
Message-Id: <20180627214447.260804-1-cannonmatthews@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH] mm: hugetlb: yield when prepping struct pages
From:   Cannon Matthews <cannonmatthews@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Nadia Yvette Chambers <nyc@holomorphy.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        andreslc@google.com, pfeiner@google.com, gthelen@google.com,
        Cannon Matthews <cannonmatthews@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When booting with very large numbers of gigantic (i.e. 1G) pages, the
operations in the loop of gather_bootmem_prealloc, and specifically
prep_compound_gigantic_page, takes a very long time, and can cause a
softlockup if enough pages are requested at boot.

For example booting with 3844 1G pages requires prepping
(set_compound_head, init the count) over 1 billion 4K tail pages, which
takes considerable time. This should also apply to reserving the same
amount of memory as 2M pages, as the same number of struct pages
are affected in either case.

Add a cond_resched() to the outer loop in gather_bootmem_prealloc() to
prevent this lockup.

Tested: Booted with softlockup_panic=1 hugepagesz=1G hugepages=3844 and
no softlockup is reported, and the hugepages are reported as
successfully setup.

Signed-off-by: Cannon Matthews <cannonmatthews@google.com>
---
 mm/hugetlb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index a963f2034dfc..d38273c32d3b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -2169,6 +2169,7 @@ static void __init gather_bootmem_prealloc(void)
 		 */
 		if (hstate_is_gigantic(h))
 			adjust_managed_page_count(page, 1 << h->order);
+		cond_resched();
 	}
 }
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

