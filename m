Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELslJH6IPASYPF9mciZy946ADNrJB8dw76CdVBELY5jr7eHQRta+YYBmJ0lpIN8LRb5c7qLI
ARC-Seal: i=1; a=rsa-sha256; t=1521141380; cv=none;
        d=google.com; s=arc-20160816;
        b=Yyfr0nEiX7T9/5Hn/35CB/A8zu1Pe1LaCHUyuO7Xxgi7Q2JDHXqDm382qr7lBa/bAO
         iCsv2N+5Zwjg3KmmvbqOatyX1tg4liWkUs4DWN14cVkgH2Pq9ZBo7roVRk1TvnvJS41v
         GOWTzpPlmb5mLc4hONB2ya6CpE2HsCassK3psyTO05M4kyh3CQ+XGpSxLXDKfWML4RaS
         GUbFhsIFDzS96vr0x+y2Wu6OSZ/t1npZ1knJ2RrGrbuQBAXTjpxEQxMTY70FZJ8HNo8s
         MKajIjDfrB/a7+ifJ1nBhsZxOL1pBg/1hAEPBf/jjFsAHYgqpVNPM+n8p26u9FxFRZmr
         DjhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8ieE+khBH5jALyL7Pqni9NQ0LlR7Dwf3Fo29WFf8V8c=;
        b=tpnftWCGg3vWvygKfcZ6rn2wDETmjZGFHzp6oTjLlYfCyucW6sjWX4xAmzJSvtl+ob
         GiSmNSEwKAh/M15juyuC4G1EvhzUOKgFlsn8OUvD7eorGopGjGZUftlxFZE9qAQ4036I
         r2ic64J2/S9ISknIJcbcOl0CqWElYnNQdyCEekfHO2zgklYpkxpf0881EQAeEjTetFGo
         0UKpPMfFPuwh5Rz/5CwWiEAh85KK357iWXrAvuJ6EiK8NJmv1FcxXl8AMKT1eGPXwcTy
         CKnXo59gIUP0vTtFj7xAmxnGGmTd+ngkpdLHJgtRx6j6UgYvZ6bOYmcG7SKw8VrBX6xV
         OuCw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Kate Stewart <kstewart@linuxfoundation.org>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Paul Mackerras <paulus@samba.org>,
	Michael Neuling <mikey@neuling.org>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Nicholas Piggin <npiggin@gmail.com>,
	Al Viro <viro@zeniv.linux.org.uk>,
	David Gibson <david@gibson.dropbear.id.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Joe Perches <joe@perches.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Tobin C. Harding" <me@tobin.cc>,
	Michal Suchanek <msuchanek@suse.de>
Subject: [PATCH RFC rebase 0/9] powerpc barrier_nospec
Date: Thu, 15 Mar 2018 20:15:49 +0100
Message-Id: <cover.1521141122.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595032344364253632?=
X-GMAIL-MSGID: =?utf-8?q?1595032344364253632?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Yes, it is good idea to add some commit messages.

Also I rebased the patches on top v3 of series

Setup RFI flush after PowerVM LPM migration

Thanks

Michal

Michal Suchanek (9):
  powerpc: Add barrier_nospec
  powerpc: Use barrier_nospec in copy_from_user
  powerpc/64: Use barrier_nospec in syscall entry
  powerpc/64s: Use barrier_nospec in RFI_FLUSH_SLOT
  powerpc/64s: Add support for ori barrier_nospec patching
  powerpc/64: Patch barrier_nospec in modules
  powerpc/64: barrier_nospec: Add debugfs trigger
  powerpc/64s: barrier_nospec: Add hcall triggerr
  powerpc/64: barrier_nospec: Add commandline trigger

 arch/powerpc/include/asm/barrier.h        |  9 ++++
 arch/powerpc/include/asm/exception-64s.h  |  2 +-
 arch/powerpc/include/asm/feature-fixups.h |  9 ++++
 arch/powerpc/include/asm/setup.h          | 11 ++++
 arch/powerpc/include/asm/uaccess.h        | 11 +++-
 arch/powerpc/kernel/entry_64.S            |  3 ++
 arch/powerpc/kernel/module.c              |  6 +++
 arch/powerpc/kernel/setup_64.c            | 87 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |  7 +++
 arch/powerpc/lib/feature-fixups.c         | 47 ++++++++++++++---
 arch/powerpc/platforms/pseries/mobility.c |  2 +-
 arch/powerpc/platforms/pseries/pseries.h  |  2 +-
 arch/powerpc/platforms/pseries/setup.c    | 37 +++++++++----
 13 files changed, 213 insertions(+), 20 deletions(-)

-- 
2.13.6
