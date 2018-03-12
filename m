Return-Path: <ben@decadent.org.uk>
X-Google-Smtp-Source: AG47ELv8Q/MOvXU0al8Xjrej8prj1/FSBu0n3y6NhpjR0quTPuPjuspTw7GWMXu6davqWb1+zKBm
ARC-Seal: i=1; a=rsa-sha256; t=1520824062; cv=none;
        d=google.com; s=arc-20160816;
        b=O35Lxcv5nyPXkA0TlqUMgjUfuuhIbXLBG/uKztY1tTa8JJ/t05X+J6o8wQPLZTJuw6
         1RvaSdTBSf3Fmdm7qvD6Kgh7dw1AOe0qOT69rb3oE2K0Xmmqx4tI00PcHMEsxdONFjHO
         qWeb5tPNARgFdjZ3Gyll3wBVe5qiIzzEt4i2mMVqwtn+2wx5aB6uL1FOt73rM2cDZDrq
         igutqfjSkIjglwj0J6bqVdW9mMF148OFib5b9sMrJ61KDlPgdczZDtcsTNo4Wxm73whH
         N8zusWjIHYTFWsNuzGrI+xmG6ZQDlNf9G/vJ205WIHDsOL6YUGwhTu+ZqsjFGa9uTiHH
         d6yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=in-reply-to:subject:message-id:date:cc:to:from:mime-version
         :content-transfer-encoding:content-disposition
         :arc-authentication-results;
        bh=zVhZnOx1UuA/iPBNHjyMEhYVu6KoZHalet7sq+gzreU=;
        b=VYedNJUlXx5kDSUOFppUzb/LdoPwHvexwGmkn9viQwTcSzesOJ18iUP94TOgceH8Jq
         r2onVoI2eAR3D4KfmuZqiVil29cMXwwLnM9aCLcv48BUllotOxmzkgSCsEtZo65ZkgTb
         /kgLrvm7kOUcKwAAJ4sX/DXcO4BuSNej/DnccoZzqurZHiB6vQQwT9or/MXKMGOnI3Db
         G4xA+IwsYB1LiW/IOD2tRy5BEHG7LnoC1FEPasH5fk/JncSYAbToFfbPZWEA+inJ0pvY
         SOqEoVM8BKnzULb0pAjTNW7dieykfWGfgFeZ6IU7MGdgHTTXXGSErrTYzqoVz0zPiKFF
         EkEA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of ben@decadent.org.uk designates 88.96.1.126 as permitted sender) smtp.mailfrom=ben@decadent.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
 "Linus Torvalds" <torvalds@linux-foundation.org>,
 "Peter Zijlstra" <peterz@infradead.org>,
 "Christian Borntraeger" <borntraeger@de.ibm.com>,
 "Dan Williams" <dan.j.williams@intel.com>,
 "Josh Poimboeuf" <jpoimboe@redhat.com>,
 "Borislav Petkov" <bp@alien8.de>,
 "Dave Hansen" <dave.hansen@linux.intel.com>,
 "Will Deacon" <will.deacon@arm.com>,
 linux-arch@vger.kernel.org,
 "Andy Lutomirski" <luto@kernel.org>,
 "David Woodhouse" <dwmw2@infradead.org>,
 "Ingo Molnar" <mingo@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Arjan van de Ven" <arjan@linux.intel.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.380113767@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 100/104] nospec: Include <asm/barrier.h> dependency
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594699611670700523?=
X-GMAIL-MSGID: =?utf-8?q?1594699611670700523?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Williams <dan.j.williams@intel.com>

commit eb6174f6d1be16b19cfa43dac296bfed003ce1a6 upstream.

The nospec.h header expects the per-architecture header file
<asm/barrier.h> to optionally define array_index_mask_nospec(). Include
that dependency to prevent inadvertent fallback to the default
array_index_mask_nospec() implementation.

The default implementation may not provide a full mitigation
on architectures that perform data value speculation.

Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: linux-arch@vger.kernel.org
Link: http://lkml.kernel.org/r/151881605404.17395.1341935530792574707.stgit@dwillia2-desk3.amr.corp.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
[bwh: Backported to 3.2: include <asm/system.h> instead]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 include/linux/nospec.h | 1 +
 1 file changed, 1 insertion(+)

--- a/include/linux/nospec.h
+++ b/include/linux/nospec.h
@@ -5,6 +5,7 @@
 
 #ifndef _LINUX_NOSPEC_H
 #define _LINUX_NOSPEC_H
+#include <asm/system.h>
 
 /**
  * array_index_mask_nospec() - generate a ~0 mask when index < size, 0 otherwise
