Return-Path: <andreyknvl@google.com>
ARC-Seal: i=1; a=rsa-sha256; t=1522169877; cv=none;
        d=google.com; s=arc-20160816;
        b=IoZpU2svHUvil6pRXiTc0nPI8jPMahp6VcJlzG/Ykf5/9NrISCXty7Dwf7vqYKM/8O
         ROBwQdW+g8ZGWWatPc8Sqf0a+ZWpyz3PwDUi2shxzwcPQIw6ckZLJX3PXIs4GSdjlTGe
         WxLV8oWEVV3U1B34xDAWrtstZ6dkMkJsE0lR/6aYpr2WBjRftVqwSGC7OM7GMLuALT3w
         Ax9TANBIBCaJnLycEdI489CqE2/MtokU3ywfyptUbG7gSvEHV0jCDzJBrmm+pOBhbxnV
         EXcMNqqddi5kwDgW0poWWf+K+ELnY6m7e4fZZamtAjBObbVI+mTNq4F4cmmiR7M3+aGj
         4Kcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=TrPsSA82+Wc4vKs2A+va2uJYYyXutDQZXj+lR7R4i7Y=;
        b=SLnQuJaiOaO0Kb/FOt+Fko9auh+jhgxEH4OuSfyj6gLQHpdO8iWGTSPygXHrq5dBat
         HsZrvu+uaurqd3ZMi8UyCga5NVcKQa1uDF+PWbUnPDehUWomvHSe1WKxOenQc6NDdGWk
         +/2EuFOXOnsx8f4tUH6oZWcHaSsY961MqKJqGfbjTjtQPe7IRWHZ87XWk37QXJG/194y
         2VjbHDCGQa+0JdL6L/+gGWzuQEVYivevlnhMsMbwCdcsh+W2UZVHLz9zp5L0UrcFbLzJ
         beVp51X0yl/8orwxPAhuvYzIGY9xiaNoxceupPNUCJ5dqT/TF5su3TQgasTELmp2Ho4e
         El1A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=hGaHk3rT;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@google.com header.s=20161025 header.b=hGaHk3rT;
       spf=pass (google.com: domain of andreyknvl@google.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andreyknvl@google.com;
       dmarc=pass (p=REJECT sp=REJECT dis=NONE) header.from=google.com
X-Google-Smtp-Source: AIpwx48mmB0IcT064n10LjGGUrdOaAg2hz0T4aQdm7Lr/dGWIh29GAk/0bOK3XWMNVpO7eivSW7BnQ==
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
Subject: [RFC PATCH v2 6/6] arm64: update Documentation/arm64/tagged-pointers.txt
Date: Tue, 27 Mar 2018 18:57:42 +0200
Message-Id: <080040fac18377cb6b9cd418668a10e1113b3c2a.1522169685.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.17.0.rc0.231.g781580f067-goog
In-Reply-To: <cover.1522169685.git.andreyknvl@google.com>
References: <cover.1522169685.git.andreyknvl@google.com>
In-Reply-To: <cover.1522169685.git.andreyknvl@google.com>
References: <cover.1522169685.git.andreyknvl@google.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596110800969348216?=
X-GMAIL-MSGID: =?utf-8?q?1596110800969348216?=
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
2.17.0.rc0.231.g781580f067-goog
