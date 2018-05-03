Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525356959; cv=none;
        d=google.com; s=arc-20160816;
        b=UKaCftdvxfqWmC7ac7fGHuz4CMRvM0nrFE7v8WUb/oiVAzCyRg6UD9WYEMf4WMNrnd
         JJs1IYmPh6uD2wfRl459gNsKxUnnHGbGrc4fMI/SVrD0D58gWKGEQ2p0rwOcyptp/mNS
         ilWwLJNYXlaAEat+QLc32i48KqzYgFaO6tAEXxvDCq3fXadf4nAdT6zjMR3OG34GdJHF
         zo6a8WkVdIhINAHqSPOZeDpKpBp6Tp7CtUlDbA6poPngGTVwpI3FupyFNFqP7uypYTtE
         3et0ZNFcQnTERvkh3FmlVGNiE1xtFTrCj8MFUnnhY+LCU59d0AKo8HPWoDdkosp3gztd
         qbmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=UK5wc6DlUcroqlO7Swx8mX58fL3XtYOgQeE0FdL7+yM=;
        b=bdwP28d0gAai1XPCmA2oBWC4kwiIO7saP+eBeIfAG91sr+LpnRiWsYGHctZ5vmWSny
         s0ogjCYiDNuj+KfdH4lLXCt5L/ywQd3u77ZOQbtiQNjjqRWvnVILlmKmkm4wrO/hFWsd
         fVXvi70KpBzxJk0ivJ6Vunom4DmvH9JMgzYgpjx2kZE8+76aT0QMK5xj0CtAdwAtFBgl
         6x+1LGbVpe1p3zCNVT5M/mOAMrIX4YZSU/2usTbgR9dPl6VH2XeI9blFWG9Go5+8oCVO
         /MFTonHvFz2QfcAt5sRpyjVwBhHGM60AMhxg+bj+QqyQO6uIkvsvKEb3QWkmKo4HNVrX
         YIfA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SCYKEXLS;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=SCYKEXLS;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AB8JxZp3MQmZZ6oNm3X5fe1bQ1T4o6Ql+t77Nx3UuR1G4D5mj7PNDW0sv4E6Oua5EgFMYH61+7XlKQ==
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
	Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
	Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v2 6/6] arm64: update Documentation/arm64/tagged-pointers.txt
Date: Thu,  3 May 2018 16:15:44 +0200
Message-Id: <1a708210a8056aa356407e72973e00970523e7e2.1525356769.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
In-Reply-To: <cover.1525356769.git.andreyknvl@google.com>
References: <cover.1525356769.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599452699569642930?=
X-GMAIL-MSGID: =?utf-8?q?1599452699569642930?=
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
2.17.0.441.gb46fe60e1d-goog
