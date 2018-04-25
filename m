Return-Path: <tglx@linutronix.de>
X-Google-Smtp-Source: AB8JxZrWlURE/O3YqpSM6AA1D7CHtaQVU7XqeeYdMwDQbFA8sTSOvSo3txRQ13ETT/r6z9R53MuY
ARC-Seal: i=1; a=rsa-sha256; t=1524689625; cv=none;
        d=google.com; s=arc-20160816;
        b=H/HBXzz/Z3BI+R3ARgJStz2t8DxlBsdUgd4Rc+JAqbDMtH3QnImj6A+5YmrkvZ0IP9
         yRX9x+5OOIaSoeVAfs6YiOLP1v9HMzb1niR2ZMhqWtx6YROuadormjBXWItQyNERP/lz
         4bbjF9mUeAT307ha850EEUWxfH7mzCsLNzwewlLqSjbqWrrrizKdh/SVauOedlJpByid
         /5O5QvO1zKmvExW2GPuahZOQtyGByNDMGa5/tvMwGIkdiomcwV+DUUxV2TllCl9pGVSW
         9QsmFhJawjOzfMekenYeOZ4dcMxXX6Qylm/iJFzoy32hOK96N5VutqO6JRDb0sQNzglb
         FdWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=subject:cc:to:from:date:user-agent:message-id
         :arc-authentication-results;
        bh=jS3TCs25YJrmHjTqGcGo3XZ7Y8W58ClLbdYY47cFgFk=;
        b=H17xTgMlPLCYYzAgMY1R13kRAXU05FlyA8yJ80Y1AlsEmPp7mzJ3NGu97wUZoZj9dy
         NPwVZftQLpumLT/rgBnXr9RT4J6wB4qid4Sm/Mu9DLhQyR2y54sirkT5dFu/KHlVZVfk
         NoFOX40pLZB2+tq/M+/+4SqzW5nRxP9U3bW0Paot/5zuvtBrp0KPuYxnacPX9lcH4RWK
         vw+H62tOua1s99KX1T4LGrx8mhi1Gi44EAaAtacKyioDLUXAhxq/rEPvjsOjfW2+FbIJ
         eRyBaXoyTANnLbuxYNi/wQL3nOO26rbbbsmRPqbbeFukJl3TsDKIsrwII+g0IudYhnVW
         99ew==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of tglx@linutronix.de designates 2a01:7a0:2:106d:700::1 as permitted sender) smtp.mailfrom=tglx@linutronix.de
Message-Id: <20180425203020.594959448@linutronix.de>
User-Agent: quilt/0.63-1
Date: Wed, 25 Apr 2018 22:30:20 +0200
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jonathan Corbet <corbet@lwn.net>, Hans Verkuil <hans.verkuil@cisco.com>,
 Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 Christoph Hellwig <hch@lst.de>
Subject: [patch V2 0/7] LICENSES: Add missing License Text and provide a
 checker script
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752949204959654?=
X-GMAIL-MSGID: =?utf-8?q?1598752949204959654?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There are a few bogus SPDX identifiers in various files and SPDX
Identifiers used in tree or about to be used which have no corresponding
License Text file in the LICENSES directory or use the new variant of the
GPL-2.0[+] license identifiers which are not mentioned in the GPL-2.0
Valid-License-Identifiers: tags.

There is no tool which can be used to scan the tree and also nothing which
helps people who submit patches to check their stuff before submission.

The following series cleans that up:

 - Add GPL-2.0-only and GPL-2.0-or-later identifiers to the GPL2.0 license
   and the Linux-syscall-note exception

 - Add X11, Apache-2.0, CC-BY-SA-4.0, CCDL-1.0, Linux-OpenIB license texts
   to the LICENSES directory along with the required documentation texts

 - Add a checker script which can read a single file or even a patch from
   the command line or does a full git tree scan

Changes vs. V1:

  - Fix whitespace and UTF-8 damage in various licenses
  
  - Add the GPL-2.0-only/or-later ids to the valid licenses for the
    Linux-syscall-note exception to make the checker work

  - Add a checker script

  - Dropped the patches for the bogus identifiers as they have been picked
    up by the maintainers

8<-------------
 LICENSES/exceptions/Linux-syscall-note |    2 
 LICENSES/preferred/GPL-2.0             |    6 
 b/LICENSES/other/Apache-2.0            |  183 +++++++++++++++
 b/LICENSES/other/CC-BY-SA-4.0          |  397 +++++++++++++++++++++++++++++++++
 b/LICENSES/other/CDDL-1.0              |  364 ++++++++++++++++++++++++++++++
 b/LICENSES/other/Linux-OpenIB          |   26 ++
 b/LICENSES/other/X11                   |   37 +++
 b/scripts/spdxcheck.py                 |  260 +++++++++++++++++++++
 8 files changed, 1274 insertions(+), 1 deletion(-)
