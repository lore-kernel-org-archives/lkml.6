Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524077609; cv=none;
        d=google.com; s=arc-20160816;
        b=0fbvA/tV4dNHUaH/Wls2VWEfs47Sw7FTQ+EZ5s70tlAswnRethONbF7Usky+oY16Sj
         C+mhFSlhKfMgnLJ56zCzyKdsQXhhJVYYcw3LS/kO7uecZYzGsE+ISUCQKDwX0JLi6U0r
         yQMpF9tzK5Ek7FUmnE3BGGhXlyK9sHUDrFSJ8jaB8OYsLasa1PGf2VR11L+3j3uk46Oa
         JpnisjmXErIISB367IygU1yBu8zebT7JNDEQM72RbEKe41aVI1YtUXpb3xfGniYYyoR4
         SUd0gd5MQC58k9kr3mNRYGhDecECN9xtCWz0I5F5T/NHth+nQGSc2Ru2P6lo0sfhCIef
         nIgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=EZGWuFfiHqjCbpQnzR64TWy+WxEaujGKaSajXvCUFAc=;
        b=f+cyOtB3SKktAuGKL87rbvTTmmO036a7x5o95GOY4p5pBmigezus40TLCWv8Ptnv7b
         asvrESvbApt4hu1hVSnjTVlm7w8eT+e2oruehreDh5sVnLWFl1snwmk/sCZ/BG0WS+4f
         MEsoyyCtUI64sZhMqgzy/76ixBDF4HZZoEyf6J2aibWhsTY2qPq9kMo+vUrhQUYiIH95
         aHxwAoG3PSKbMZsUzXPPW0biO+eXKhwa4auhSPkWQBYgecA6Ez/Jq0W6Xd71DCpGUSMu
         UELvjA4qLImUMS9LF0Ide5idlOx0JSmO9WnmzVsro317v164Sx0/f3g2HHWI8wSu9s8J
         1ITQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=XoOfHGDK;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=XoOfHGDK;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx4+jqENAWip/MUW3PGvlX0PAg25j/IaqTVI58MpVYsnVtxnKfu+qYLlIBk/+1UQ8zcYiy7iy7A==
From: Andrey Konovalov <andreyknvl@google.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will.deacon@arm.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Mark Rutland <mark.rutland@arm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrey Konovalov <andreyknvl@google.com>,
	James Morse <james.morse@arm.com>,
	Kees Cook <keescook@chromium.org>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@kernel.org>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
	Zi Yan <zi.yan@cs.rutgers.edu>,
	linux-arm-kernel@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Cc: Dmitry Vyukov <dvyukov@google.com>,
	Kostya Serebryany <kcc@google.com>,
	Evgeniy Stepanov <eugenis@google.com>,
	Lee Smith <Lee.Smith@arm.com>,
	Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
	Jacob Bramley <Jacob.Bramley@arm.com>,
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>
Subject: [PATCH 6/6] arm64: update Documentation/arm64/tagged-pointers.txt
Date: Wed, 18 Apr 2018 20:53:15 +0200
Message-Id: <0fdb6332cc5bf333f80212d0b17edadd2bdc9fcf.1524077494.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
In-Reply-To: <cover.1524077494.git.andreyknvl@google.com>
References: <cover.1524077494.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598111203386194872?=
X-GMAIL-MSGID: =?utf-8?q?1598111203386194872?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Add a note that work on passing tagged user pointers to the kernel via
syscalls has started, but might not be complete yet.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 Documentation/arm64/tagged-pointers.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/arm64/tagged-pointers.txt b/Documentation/arm64/tagged-pointers.txt
index a25a99e82bb1..361481283f00 100644
--- a/Documentation/arm64/tagged-pointers.txt
+++ b/Documentation/arm64/tagged-pointers.txt
@@ -35,8 +35,9 @@ Using non-zero address tags in any of these locations may result in an
 error code being returned, a (fatal) signal being raised, or other modes
 of failure.
 
-For these reasons, passing non-zero address tags to the kernel via
-system calls is forbidden, and using a non-zero address tag for sp is
+Some initial work for supporting non-zero address tags passed to the
+kernel via system calls has been done, but the kernel doesn't provide
+any guarantees at this point. Using a non-zero address tag for sp is
 strongly discouraged.
 
 Programs maintaining a frame pointer and frame records that use non-zero
-- 
2.17.0.484.g0c8726318c-goog
