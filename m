Return-Path: <jpoimboe@redhat.com>
X-Google-Smtp-Source: AB8JxZqx1wq1JDnp+/Ib4IY/h4xRN+oD9w9WLIrC+AetUG3QSu5VSYFgCCR+DyZPO/7V3oEy3Pdg
ARC-Seal: i=1; a=rsa-sha256; t=1525923580; cv=none;
        d=google.com; s=arc-20160816;
        b=a1e6Kaib2x8g/0fV7iQ+tIaMzCghifSpGvNZ6CN9WvqjI58dUd3iqpMTbrgbak90Dg
         wiO7oRR66va2CyeWPMmWR04sjce4XNdzfRuIpCvnNTO8oaGpCKjcRWoQeiQHn7xgukDt
         rbQKPjyFNoyit9bg4nNbt/25W3USy95qij3gIunqGt/Z7IiIFLDtql/Vnqx2qDX5Xt4O
         5zIHidjTJB3f+Yx37zc6jPkwYvpQcjoRZ0Brc3KvgsFYuLreuSVAaZV4w3NL/aBrvu8J
         NJwawawRaglQ+VXivLrY8ts31c1uDbWCEJ6k3031mlUj7yO6JVAU0tGkN9qra+BMrqi1
         bT+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=HaiJ9egw3RGLTaDbqQfWJLW2Yl3HPju12l/HM+iWiRI=;
        b=jmNgC8X7RB8gTvKs3ma2tQAKnAtKE3zbCLhm7vsnY8S4QsrrrFriAdfY3Y1LLO2wlZ
         O9HQYzWYtsi2OK1hp7XXNxveK62kmxyj0RlS3zYHT3iqNxjfS+HQQbuX3KMdhFprT+Ua
         l/4ooBNFfOc/F8OvAgsVMNHt9Qgrn7R8TW5wmuwA+R7k/VT3BELo4XI6UZBrmZRqPGSh
         H+CX3F6VFI3FSlWHXCHtgsPMa+6S/08gTgcU9/xPslR1brdOe5swOQeRWGxKSXDbG7lO
         cc1di9vpNTxQOYsV99F8FS+k1txca4AeOkcNeAlJCW9/JjXRhuKAWj0QPqwVKnPZK5V/
         YrkA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jpoimboe@redhat.com designates 66.187.233.73 as permitted sender) smtp.mailfrom=jpoimboe@redhat.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=redhat.com
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Greg KH <gregkh@linuxfoundation.org>,
	David Laight <David.Laight@ACULAB.COM>,
	damian <damian.tometzki@icloud.com>
Subject: [PATCH 0/3] objtool: GCC 8 support
Date: Wed,  9 May 2018 22:39:13 -0500
Message-Id: <cover.1525923412.git.jpoimboe@redhat.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600046844298026117?=
X-GMAIL-MSGID: =?utf-8?q?1600046844298026117?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Now that GCC 8 is out, several people have complained about a bunch of
objtool warnings.  These patches fix all known warnings.

Patch 1 is a repost of a previous fix -- unrelated to GCC 8, but a
prereq for the following two patches.

Patch 2 fixes the vast majority of the warnings, caused by GCC 8's new
usage of "cold" subfunctions for unlikely text.

Patch 3 fixes a few more warnings, related to switch tables.

Josh Poimboeuf (3):
  objtool: Fix "noreturn" detection for recursive sibling calls
  objtool: Support GCC 8 cold subfunctions
  objtool: Support GCC 8 switch tables

 tools/objtool/check.c | 125 ++++++++++++++++++++++++++----------------
 tools/objtool/elf.c   |  42 +++++++++++++-
 tools/objtool/elf.h   |   2 +
 3 files changed, 121 insertions(+), 48 deletions(-)

-- 
2.17.0
