Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3463848-1520955562-2-12176588699165213963
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
    t=1520955561; b=AQDgyw36lfPLVi4jFofhMJP06AgHvIeeiDdmvcGNm2h34g8
    nSa3rK4zG4hsBBQ/hGnP+man/e352rd5Qfl1uYQGQ7vRCr9ebwjdhZPIH1HOZNiO
    sfyin81t+oqiL+MdkJIMeA4NXjFW73CefAU0EeMZwlya/Iox1HSWif5aK94yfd64
    ZppF3t+XjOtLm6SRSs2gN7zDRPQ1LKKlUaUuPCfPPLGsbyhhKIBoLVXybVs9XTSt
    m83mtqdRFHeGzrV3oxjmnz1inbFsnzeMN+pwFJG2tDj3EOkNjV/bH7mB9w+Ojkwz
    qRAfUmWsEVS8WOUkft/etnts3foM7BhsYwsgZIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1520955561; bh=Bq6Z66VF62gQPV27yqJZwoHslI
    9H+z7+bRRChtNy0u4=; b=JTDuLQammdhYMK6t1dAHE7hKU0aEp4DsFMGlOY5FOI
    2+3+YZ6XZbSORfEfHmwsjebP2cwyfGPydkkUe7NGEOLn0aC00/4nalIvISecFuiG
    JTXc4uxpEuv82bm94Pspl+bQXZ32tymJJ0qI2EiiC/LSVcjeZUymVWZ4I68XWe80
    hiT0BzeBiueuQvwEAprIfrVCAVQUJ5imjXS4aA3ZpJr5ZlL2sfvGvCjqmGQcZX4J
    nWCmGx5sliTsvZIHdiQrP4++m3w2TnMfoSmxGb1NhlJGkC5eY/GJsR/bnC9t6G2F
    8ycG7lb3Zr0y4i0gghAeq62jdUWHrfFSeZCZtTJFaIUQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934649AbeCMPjD (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 11:39:03 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:35158 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933977AbeCMPjB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 13 Mar 2018 11:39:01 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Vacek <neelx@redhat.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Michal Hocko <mhocko@suse.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 085/140] mm/page_alloc: fix memmap_init_zone pageblock alignment
Date: Tue, 13 Mar 2018 16:24:48 +0100
Message-Id: <20180313152503.878363687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180313152458.201155692@linuxfoundation.org>
References: <20180313152458.201155692@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Daniel Vacek <neelx@redhat.com>

commit 864b75f9d6b0100bb24fdd9a20d156e7cda9b5ae upstream.

Commit b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns
where possible") introduced a bug where move_freepages() triggers a
VM_BUG_ON() on uninitialized page structure due to pageblock alignment.
To fix this, simply align the skipped pfns in memmap_init_zone() the
same way as in move_freepages_block().

Seen in one of the RHEL reports:

  crash> log | grep -e BUG -e RIP -e Call.Trace -e move_freepages_block -e rmqueue -e freelist -A1
  kernel BUG at mm/page_alloc.c:1389!
  invalid opcode: 0000 [#1] SMP
  --
  RIP: 0010:[<ffffffff8118833e>]  [<ffffffff8118833e>] move_freepages+0x15e/0x160
  RSP: 0018:ffff88054d727688  EFLAGS: 00010087
  --
  Call Trace:
   [<ffffffff811883b3>] move_freepages_block+0x73/0x80
   [<ffffffff81189e63>] __rmqueue+0x263/0x460
   [<ffffffff8118c781>] get_page_from_freelist+0x7e1/0x9e0
   [<ffffffff8118caf6>] __alloc_pages_nodemask+0x176/0x420
  --
  RIP  [<ffffffff8118833e>] move_freepages+0x15e/0x160
   RSP <ffff88054d727688>

  crash> page_init_bug -v | grep RAM
  <struct resource 0xffff88067fffd2f8>          1000 -        9bfff	System RAM (620.00 KiB)
  <struct resource 0xffff88067fffd3a0>        100000 -     430bffff	System RAM (  1.05 GiB = 1071.75 MiB = 1097472.00 KiB)
  <struct resource 0xffff88067fffd410>      4b0c8000 -     4bf9cfff	System RAM ( 14.83 MiB = 15188.00 KiB)
  <struct resource 0xffff88067fffd480>      4bfac000 -     646b1fff	System RAM (391.02 MiB = 400408.00 KiB)
  <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff	System RAM (480.00 KiB)
  <struct resource 0xffff88067fffd640>     100000000 -    67fffffff	System RAM ( 22.00 GiB)

  crash> page_init_bug | head -6
  <struct resource 0xffff88067fffd560>      7b788000 -     7b7fffff	System RAM (480.00 KiB)
  <struct page 0xffffea0001ede200>   1fffff00000000  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
  <struct page 0xffffea0001ede200> 505736 505344 <struct page 0xffffea0001ed8000> 505855 <struct page 0xffffea0001edffc0>
  <struct page 0xffffea0001ed8000>                0  0 <struct pglist_data 0xffff88047ffd9000> 0 <struct zone 0xffff88047ffd9000> DMA               1       4095
  <struct page 0xffffea0001edffc0>   1fffff00000400  0 <struct pglist_data 0xffff88047ffd9000> 1 <struct zone 0xffff88047ffd9800> DMA32          4096    1048575
  BUG, zones differ!

Note that this range follows two not populated sections
68000000-77ffffff in this zone.  7b788000-7b7fffff is the first one
after a gap.  This makes memmap_init_zone() skip all the pfns up to the
beginning of this range.  But this range is not pageblock (2M) aligned.
In fact no range has to be.

  crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b787000 7b788000
        PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
  ffffea0001e00000  78000000                0        0  0 0
  ffffea0001ed7fc0  7b5ff000                0        0  0 0
  ffffea0001ed8000  7b600000                0        0  0 0	<<<<
  ffffea0001ede1c0  7b787000                0        0  0 0
  ffffea0001ede200  7b788000                0        0  1 1fffff00000000

Top part of page flags should contain nodeid and zonenr, which is not
the case for page ffffea0001ed8000 here (<<<<).

  crash> log | grep -o fffea0001ed[^\ ]* | sort -u
  fffea0001ed8000
  fffea0001eded20
  fffea0001edffc0

  crash> bt -r | grep -o fffea0001ed[^\ ]* | sort -u
  fffea0001ed8000
  fffea0001eded00
  fffea0001eded20
  fffea0001edffc0

Initialization of the whole beginning of the section is skipped up to
the start of the range due to the commit b92df1de5d28.  Now any code
calling move_freepages_block() (like reusing the page from a freelist as
in this example) with a page from the beginning of the range will get
the page rounded down to start_page ffffea0001ed8000 and passed to
move_freepages() which crashes on assertion getting wrong zonenr.

  >         VM_BUG_ON(page_zone(start_page) != page_zone(end_page));

Note, page_zone() derives the zone from page flags here.

>From similar machine before commit b92df1de5d28:

  crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
        PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
  fffff73941e00000  78000000                0        0  1 1fffff00000000
  fffff73941ed7fc0  7b5ff000                0        0  1 1fffff00000000
  fffff73941ed8000  7b600000                0        0  1 1fffff00000000
  fffff73941edff80  7b7fe000                0        0  1 1fffff00000000
  fffff73941edffc0  7b7ff000 ffff8e67e04d3ae0     ad84  1 1fffff00020068 uptodate,lru,active,mappedtodisk

All the pages since the beginning of the section are initialized.
move_freepages()' not gonna blow up.

The same machine with this fix applied:

  crash> kmem -p 77fff000 78000000 7b5ff000 7b600000 7b7fe000 7b7ff000
        PAGE        PHYSICAL      MAPPING       INDEX CNT FLAGS
  ffffea0001e00000  78000000                0        0  0 0
  ffffea0001e00000  7b5ff000                0        0  0 0
  ffffea0001ed8000  7b600000                0        0  1 1fffff00000000
  ffffea0001edff80  7b7fe000                0        0  1 1fffff00000000
  ffffea0001edffc0  7b7ff000 ffff88017fb13720        8  2 1fffff00020068 uptodate,lru,active,mappedtodisk

At least the bare minimum of pages is initialized preventing the crash
as well.

Customers started to report this as soon as 7.4 (where b92df1de5d28 was
merged in RHEL) was released.  I remember reports from
September/October-ish times.  It's not easily reproduced and happens on
a handful of machines only.  I guess that's why.  But that does not make
it less serious, I think.

Though there actually is a report here:
  https://bugzilla.kernel.org/show_bug.cgi?id=196443

And there are reports for Fedora from July:
  https://bugzilla.redhat.com/show_bug.cgi?id=1473242
and CentOS:
  https://bugs.centos.org/view.php?id=13964
and we internally track several dozens reports for RHEL bug
  https://bugzilla.redhat.com/show_bug.cgi?id=1525121

Link: http://lkml.kernel.org/r/0485727b2e82da7efbce5f6ba42524b429d0391a.1520011945.git.neelx@redhat.com
Fixes: b92df1de5d28 ("mm: page_alloc: skip over regions of invalid pfns where possible")
Signed-off-by: Daniel Vacek <neelx@redhat.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/page_alloc.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5307,9 +5307,14 @@ void __meminit memmap_init_zone(unsigned
 			/*
 			 * Skip to the pfn preceding the next valid one (or
 			 * end_pfn), such that we hit a valid pfn (or end_pfn)
-			 * on our next iteration of the loop.
+			 * on our next iteration of the loop. Note that it needs
+			 * to be pageblock aligned even when the region itself
+			 * is not. move_freepages_block() can shift ahead of
+			 * the valid region but still depends on correct page
+			 * metadata.
 			 */
-			pfn = memblock_next_valid_pfn(pfn, end_pfn) - 1;
+			pfn = (memblock_next_valid_pfn(pfn, end_pfn) &
+					~(pageblock_nr_pages-1)) - 1;
 #endif
 			continue;
 		}
