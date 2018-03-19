Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3444635-1521483542-2-16854640425683653561
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521483542; b=KlfpGH+otBhSqqx2ufM+uFuqA6gmbbYkb4BarJ7Fkv/PWd2
    EK0iZZlHc4hvJN4FTw6Z92/3L7aJz31mzHdfblwAOdxKTHbBgnCQ256734EeT4cf
    YfUFkfMP8rWYcI7ww5EwbYvJyTxu9BM4Xr5tz/Cci4en1quBTROX8jeIx2GyLwnb
    XJ51rn9jeNn32SvSrf1UjbR7OsuqmjuO3J93dEp63wvT+l7wVBGWRSeKqrU4dasq
    0k5z/xo9IVkJYO03WSapwkK6IoAgGU6gqYMfFWLzvWs/Nxa0tU2+h35WZ0K6+JOK
    06K8QJTIFmy4vGDCBWXTMcVoEtkIrsbml3Hb/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521483542; bh=QSWNyvGwLqA7C166ixnFHYZPNL
    HpfyOdXYcbrMN9dRI=; b=dynf7NsTtl+gxWMQ7z/jI/9kIAJTeakIfdfe19XYtk
    XZCNz9kG7p7sZ2BWTHPxnc5hEoOJ/tB4o9ysJzo1hPr/hl8pmM0RdGxRBmrrgwk7
    0mLvH4mfg4lN4PTdFc+GD/i5IaNUGo0EQ4+7KnzyePygzAZZ2v887gysySouo/hH
    Dn8USwuxBjKAq90F6ftVv2SdNpX5lZ8fSB8SvVO6Z3NhYiF159nP36DHCgo2u6zc
    T7W81WPtcuyXYFyHOkcOGK2vkQM7kXAyxKpmr09zJH5iAyV53zhuUSe78M1deZU6
    tCXi+X17A7tiOFe6ETERIb5L8tPUbCzL1QZfrPWZB4yg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepgedvuddtnecuvehluhhsthgvrhfuihiivgepudef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0 spamcause=gggruggvucftvghtrhhoucdtuddrgedtgedrudefgdduudduucdltddurdegtdefrddttddmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgjfhgfgggtshhpjeesthdtfedtreerjeenucfhrhhomhepifhrvghgucfmrhhorghhqdfjrghrthhmrghnuceoghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgqeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppedvtdelrddufedvrddukedtrdeijedpledtrdelvddriedurddvtddvnecurfgrrhgrmhepihhnvghtpedvtdelrddufedvrddukedtrdeijedphhgvlhhopehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhmrghilhhfrhhomhepoehsthgrsghlvgdqohifnhgvrhesvhhgvghrrdhkvghrnhgvlhdrohhrghequceuqfffjgepkeeukffvoffkoffgucfukfgkgfepgedvuddtnecuvehluhhsthgvrhfuihiivgepudef;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030656AbeCSSSq (ORCPT <rfc822;greg@kroah.com>);
        Mon, 19 Mar 2018 14:18:46 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030567AbeCSSSo (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Mar 2018 14:18:44 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dmitry Safonov <dsafonov@virtuozzo.com>,
        0x7f454c46@gmail.com, linux-mm@kvack.org,
        Andy Lutomirski <luto@kernel.org>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Borislav Petkov <bp@suse.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 020/241] x86/mm: Make mmap(MAP_32BIT) work correctly
Date: Mon, 19 Mar 2018 19:04:45 +0100
Message-Id: <20180319180752.005376139@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dmitry Safonov <dsafonov@virtuozzo.com>


[ Upstream commit 3e6ef9c80946f781fc25e8490c9875b1d2b61158 ]

mmap(MAP_32BIT) is broken due to the dependency on the TIF_ADDR32 thread
flag.

For 64bit applications MAP_32BIT will force legacy bottom-up allocations and
the 1GB address space restriction even if the application issued a compat
syscall, which should not be subject of these restrictions.

For 32bit applications, which issue 64bit syscalls the newly introduced
mmap base separation into 64-bit and compat bases changed the behaviour
because now a 64-bit mapping is returned, but due to the TIF_ADDR32
dependency MAP_32BIT is ignored. Before the separation a 32-bit mapping was
returned, so the MAP_32BIT handling was irrelevant.

Replace the check for TIF_ADDR32 with a check for the compat syscall. That
solves both the 64-bit issuing a compat syscall and the 32-bit issuing a
64-bit syscall problems.

[ tglx: Massaged changelog ]

Signed-off-by: Dmitry Safonov <dsafonov@virtuozzo.com>
Cc: 0x7f454c46@gmail.com
Cc: linux-mm@kvack.org
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Cyrill Gorcunov <gorcunov@openvz.org>
Cc: Borislav Petkov <bp@suse.de>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Link: http://lkml.kernel.org/r/20170306141721.9188-5-dsafonov@virtuozzo.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/sys_x86_64.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -100,7 +100,7 @@ out:
 static void find_start_end(unsigned long flags, unsigned long *begin,
 			   unsigned long *end)
 {
-	if (!test_thread_flag(TIF_ADDR32) && (flags & MAP_32BIT)) {
+	if (!in_compat_syscall() && (flags & MAP_32BIT)) {
 		/* This is usually used needed to map code in small
 		   model, so it needs to be in the first 31bit. Limit
 		   it to that.  This means we need to move the
@@ -175,7 +175,7 @@ arch_get_unmapped_area_topdown(struct fi
 		return addr;
 
 	/* for MAP_32BIT mappings we force the legacy mmap base */
-	if (!test_thread_flag(TIF_ADDR32) && (flags & MAP_32BIT))
+	if (!in_compat_syscall() && (flags & MAP_32BIT))
 		goto bottomup;
 
 	/* requesting a specific address */
