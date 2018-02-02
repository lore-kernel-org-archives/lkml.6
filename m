Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2948269-1517591208-2-2290683215563381780
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1517591206; b=UliZ3XqiNRZKjDWCIudWAQ729kLrLzVdhmWyCPIf0VVgI0K
    uKGN1PvVTJpgpL4Xn/XsWh6UH8fnzSVkm9RkqWvOWPwDbVYw71XMs2zRhIl6H3wV
    qKHdIG27Vq5YzsjLMhxOlqv5NQtPLh3CXvHblx2Gxf8kV+k7zAfQ0jzzTwirbjqy
    e31jsRxr0u0i/wm2EeFFmATv+KX3DrLNvrqMwhkBtAMpyR8Nm+XZNmsmquHgjBXZ
    +US4QvI2D4qVauwzzYAaw2yAdQNCXGkPTSAyH0HbEzwCxYlxhkUXzlfKVP9IwKAk
    EzR+h22xDFtwbMq7nlCjC3t2G7KbmnrD3nKitjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1517591206; bh=+bFW8EzfSIj232G6PVWOD0Rb90
    8KOvEV3qGOGwCvwIA=; b=DG4QG/KvIZ9PK9c995tNKAUBJvpzwSStjTzoyeuLWh
    UVe2WtDaDeY4hKOV8Fkl3iunOvR+75nQUpS41LrhWo4VdjdugV1+W2ZCHSbBNvyh
    bYrw9O/4CV4EJYS5CA4jyHOQ8C/cOYyHU7vDLd2SzX8UOD50/U+zot1+7axdLhzU
    6FMJRK/nUsAuR3OD4P6JmaMUPu2kpCZ5aNkdgyhJsYMFQdKDBqxvAOhKKzBxCcq0
    xWG5oKse5x2Q4TTa8+dLlSAGrRPxVRafHllgl5MEfAL6/YKsEcfS6onkJ4ExVxmG
    mj0EGIg3/v2CKUSXmLfF8zgWHdyMqCEtiFzzuEImtk7w==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753114AbeBBRGn (ORCPT <rfc822;greg@kroah.com>);
        Fri, 2 Feb 2018 12:06:43 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:36842 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbeBBRGl (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 2 Feb 2018 12:06:41 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yisheng Xie <xieyisheng1@huawei.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 53/86] kmemleak: add scheduling point to kmemleak_scan()
Date: Fri,  2 Feb 2018 17:58:13 +0100
Message-Id: <20180202140827.143784257@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180202140822.679101338@linuxfoundation.org>
References: <20180202140822.679101338@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Yisheng Xie <xieyisheng1@huawei.com>


[ Upstream commit bde5f6bc68db51128f875a756e9082a6c6ff7b4c ]

kmemleak_scan() will scan struct page for each node and it can be really
large and resulting in a soft lockup.  We have seen a soft lockup when
do scan while compile kernel:

  watchdog: BUG: soft lockup - CPU#53 stuck for 22s! [bash:10287]
 [...]
  Call Trace:
   kmemleak_scan+0x21a/0x4c0
   kmemleak_write+0x312/0x350
   full_proxy_write+0x5a/0xa0
   __vfs_write+0x33/0x150
   vfs_write+0xad/0x1a0
   SyS_write+0x52/0xc0
   do_syscall_64+0x61/0x1a0
   entry_SYSCALL64_slow_path+0x25/0x25

Fix this by adding cond_resched every MAX_SCAN_SIZE.

Link: http://lkml.kernel.org/r/1511439788-20099-1-git-send-email-xieyisheng1@huawei.com
Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/kmemleak.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1442,6 +1442,8 @@ static void kmemleak_scan(void)
 			if (page_count(page) == 0)
 				continue;
 			scan_block(page, page + 1, NULL);
+			if (!(pfn % (MAX_SCAN_SIZE / sizeof(*page))))
+				cond_resched();
 		}
 	}
 	put_online_mems();
