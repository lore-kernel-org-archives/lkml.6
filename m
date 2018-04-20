Return-Path: <dave.hansen@linux.intel.com>
X-Google-Smtp-Source: AIpwx4+W+aoi5ZT5ADR2kpquXGsa8ZQ5JuxV/VWeqGHp7/jTDnQ+kkXKIWm6vyoXJYcpx9Ko7Z/2
ARC-Seal: i=1; a=rsa-sha256; t=1524263050; cv=none;
        d=google.com; s=arc-20160816;
        b=UDuxVrPdx7l9Ye4PTlUkas+SDxyEc8vQWwJw8/650x+DTYYZTpQFq+D0zBtuR9qwja
         3Vb+VcDBfyhc2k23R4t/10DDDdu4y+nDIJvch7oisQfXzyyyE6o4sDprx+c1TuEQVJgr
         34JC3YAfZbi6a5HAtFB566a6bb5C+mPFv4AblRfOHNKBhviMdEKTvO3d7Z+BFbk5zdhv
         GmzyhGws6cdJaPSFOoP9BED47RKOn1syhCprJpETMZTBHtPsYuO0nPxT6vPEZad1NbN2
         MBYJA5AHU4c+yo+joNi6Bh7Wj1Ptg3UrogUOfnA+JDvW5i7X3MMHjvzyE9l+qp3RtA0y
         tBkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:from:cc:to:subject:arc-authentication-results;
        bh=urkGZpF2si0/B/Ly+/w0Z40PTALL4Cww3K2vCxGcuj0=;
        b=emVG9zEQnG3jnvzlVpt8PF8Scxp4EF3eC9rj8pTxWgkk99GPSTF2H4NIybQ5qiRdsH
         4+B06opqCtnm3lVbSZ/lAxJgUJN4VUTLB/6UvfokStVFHWQOswT2xkgDX0PN03Zd8Cdj
         NrgQS8VsWRPjiBBL7otkan5dCuzbBXIiWCHRt4yKlh4rfGuarJwDwsXNp06S+01ybmvK
         xdSrPGHN6b6bvb+y7T6YTp6m792EE6nj5lsrqfURvmvRDzAVOtMog36B0rVnGW6m942W
         I3Nv6zNWD8kwKUeyXgyS3JRovwJxgs4wmlfNJp2WPDVZvT8aZMs5EFatYsCQ50qZ8xXY
         BZeQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of dave.hansen@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=dave.hansen@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,303,1520924400";
   d="scan'208";a="35245650"
Subject: [PATCH 0/5] x86, mm: PTI Global page fixes for 4.17
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,Dave Hansen <dave.hansen@linux.intel.com>,aaro.koskinen@nokia.com,aarcange@redhat.com,luto@kernel.org,arjan@linux.intel.com,bp@alien8.de,dan.j.williams@intel.com,dwmw2@infradead.org,fengguang.wu@intel.com,gregkh@linuxfoundation.org,hughd@google.com,mingo@kernel.org,jpoimboe@redhat.com,jgross@suse.com,keescook@google.com,torvalds@linux-foundation.org,mceier@gmail.com,namit@vmware.com,peterz@infradead.org,tglx@linutronix.de,vbabka@suse.cz
From: Dave Hansen <dave.hansen@linux.intel.com>
Date: Fri, 20 Apr 2018 15:20:18 -0700
Message-Id: <20180420222018.E7646EE1@viggo.jf.intel.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598305652548573336?=
X-GMAIL-MSGID: =?utf-8?q?1598305652548573336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

There have been a number of reports about issues with the patches that
restore the Global PTE bit when using KPIT.  This set resolves all of
the issues that have been reported.

These have been pushed out to a git tree where 0day should be chewing
on them.  Considering the troubles thus far, we should probably wait
for 0day to spend _some_ time on these fixes before these get merged.

Cc: Aaro Koskinen <aaro.koskinen@nokia.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mariusz Ceier <mceier@gmail.com>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: linux-mm@kvack.org
