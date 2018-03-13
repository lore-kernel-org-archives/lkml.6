Return-Path: <msuchanek@suse.de>
X-Google-Smtp-Source: AG47ELvX6ejp1jabSwsxdgsaVO1Q2lhWnyQ5W9aHAvYj4Q/8MQphBwCOMu/2/dZmNXEG28uUXX6p
ARC-Seal: i=1; a=rsa-sha256; t=1520966031; cv=none;
        d=google.com; s=arc-20160816;
        b=yklAtDcJ0JYVPSfHkfLwOv1at+THowTiTjXDzqI/2xvCuzAuc8vtrPLsXLoHHIxpBP
         cQM1WmHF5S1l3lGvBD2F3L3YyIzOgLEJZ7hs9RwWF2gRd6k3ENkVNoBWJMHUo5JYX3xI
         4jNQ3HZ5+yZvSnCr88TwnTOXx++Y4fhgnJEooM/1y2cy23VMXPYD2Y+2Sisc3A51ol9R
         Ctx0gdny8VcdblLP8ooO22KAPUXmjHWEma10xvdE+hnZmPQ3jViT0oZzfkmMgceGqA9K
         Q7qLTFf+NK4VldbpEu18PWuNUq9pGjQ0N9T4kdMyfYJllqCY3WBlaUMkwk0YPGYDiI77
         nv9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:arc-authentication-results;
        bh=aZ5FTHPU/ylRTZiCgLf/mH9jA0Dpyhx7KIT258nAZfw=;
        b=sgIUH497fGT8wXTpGxXu1hUGIOtaALR/UcXWcC1+MoCdcVPn5I9FCR521+McJWdpAo
         Plwa/hsCM8FvZYmf1KlA/6R94NPdNzYiOcE7R9GeueWRSdm2A3FFCxBtVUFOnqAF14OM
         AWLGjvm1Bj9FW8diTRUez0xHhdxiLydoO2t0EdvsOZk5anLTg849WNnaCU96r67/z+Dy
         xwz3xWfhEpD08bvphavJO8U+g+kaOkiCsRIugwCamAdUz9RRPYWvXLrkQganytFIW0CQ
         EHpUBieOd0Kaw+zdXOng6nmZXU5Us5XsQnFa8PHa8iI3xoAy9cAEGEbwjMMJ3XguY1vs
         LZzA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of msuchanek@suse.de designates 195.135.220.15 as permitted sender) smtp.mailfrom=msuchanek@suse.de
From: Michal Suchanek <msuchanek@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Peter Zijlstra <peterz@infradead.org>,
	Michal Suchanek <msuchanek@suse.de>,
	Kate Stewart <kstewart@linuxfoundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Philippe Ombredanne <pombredanne@nexb.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Tobin C. Harding" <me@tobin.cc>,
	Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
	David Gibson <david@gibson.dropbear.id.au>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Michael Neuling <mikey@neuling.org>,
	"Oliver O'Halloran" <oohall@gmail.com>,
	"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
	Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Balbir Singh <bsingharora@gmail.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	Christophe Leroy <christophe.leroy@c-s.fr>,
	Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
	Daniel Axtens <dja@axtens.net>,
	Russell Currey <ruscur@russell.cc>,
	Joe Perches <joe@perches.com>,
	"Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
	=?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 0/8] powerpc barrier_nospec
Date: Tue, 13 Mar 2018 19:32:58 +0100
Message-Id: <cover.1520965380.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.13.6
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594848477176520721?=
X-GMAIL-MSGID: =?utf-8?q?1594848477176520721?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello,

this is patchset adding barrier_nospec on powerpc. It is based on the
out-of-tree gmb() patch and the existing rfi patches.

I do not have the tests for the Spectre/Meltdown issues available so this is
untested.

Feedback on the general approach as well as actual effectivity is welcome.

Thanks

Michal


Michal Suchanek (8):
  powerpc: Add barrier_nospec
  powerpc: Use barrier_nospec in copy_from_user
  powerpc/64: Use barrier_nospec in syscall entry
  powerpc/64s: Add support for ori barrier_nospec
  powerpc/64: Patch barrier_nospec in modules
  powerpc/64: barrier_nospec: Add debugfs trigger
  powerpc/64s: barrier_nospec: Add hcall triggerr
  powerpc/64: barrier_nospec: Add commandline trigger

 arch/powerpc/include/asm/barrier.h        |  9 ++++
 arch/powerpc/include/asm/feature-fixups.h |  9 ++++
 arch/powerpc/include/asm/setup.h          | 11 +++++
 arch/powerpc/include/asm/uaccess.h        | 11 ++++-
 arch/powerpc/kernel/entry_64.S            |  3 ++
 arch/powerpc/kernel/module.c              |  6 +++
 arch/powerpc/kernel/setup_64.c            | 72 +++++++++++++++++++++++++++++++
 arch/powerpc/kernel/vmlinux.lds.S         |  7 +++
 arch/powerpc/lib/feature-fixups.c         | 38 ++++++++++++++++
 arch/powerpc/platforms/pseries/setup.c    | 38 ++++++++++------
 10 files changed, 190 insertions(+), 14 deletions(-)

-- 
2.13.6
