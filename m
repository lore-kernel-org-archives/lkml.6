Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AIpwx4/+z3FBI3N2zH7JIbS28Jo0HnGbzrfmsIES7peyEh4c/xgI6NkxmTbMS3dFEpfTNGUBU6dr
ARC-Seal: i=1; a=rsa-sha256; t=1523839382; cv=none;
        d=google.com; s=arc-20160816;
        b=JZCJiUwLEIDuKwap/zacQt4LcGM9Wek6qXNLOnLxgbwHNdlhP6B0+km0EvHcbvy0E6
         8nytoxEka59StSdic5c8jHIV0pOEtzm7tc9N3qKa87YzRrc3eLUyvWS+bY3FzLy81UxP
         HanahzBsb4gSFUf5MvOMmva6BKyoBymFgSpy64HEMI4nbUrNfhr2fsKAsbhx09OL03/p
         lWVu+qwXSv+2VgQqo5RxTZ/USB1yzRCRLa8zFU/H1C4TRnywWRHBcVNxizg51IuNKBef
         MJzQ0YIzGui2a19XyofEKDK/z9ug1ft9X5HpHC5MGjzVMZTtxfMiNL9ceBEDCWkjMoeP
         Shgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=e6mAZ2XBa5jbLmLyDrNHYenRnpuei/ib+xx3kgJTi/A=;
        b=zqPmiVCdbzp3rmDl2DGHLWFfZG9/jKYleDCGoY9TkoDF2x44ouEN7uZEkGi8ukR+oO
         7p9m+YpieYRtzqrBPgSUWlEpmK4BgsZJ1fpclJFFTxvW1Xd5dzFarO0iq2jmqqRM3NtT
         ShxKxGFbZnLQ5MYc2nsm9Tg6LAWI/kTvU9dNySnRE04F5kqlpeMWifYjOKOa+HyehFLi
         NUQrnPqQLP0rFEOIeRZOlHlaX/fbNNeUgMvbnenfbuwR3kdcoBAJavHtiMy0efDFoyqv
         vKHTzR6n4l8DY1fTsPS7f0Dm7csOOb6N054/BSDlxzMVw5C9FyFlmDKZ4irMN2+vw4dC
         q5UA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>
Date: Mon, 16 Apr 2018 10:42:37 +1000
Subject: [PATCH 0/6] staging: lustre: code rearrangement
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Lustre Development List <lustre-devel@lists.lustre.org>
Message-ID: <152383910760.23409.2327082725637657049.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597861403511346786?=
X-GMAIL-MSGID: =?utf-8?q?1597861403511346786?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

This series rearranges some code and manages to delete four
files in the process, all from directories called "linux".
This results in
  drivers/staging/lustre/include/linux/libcfs/linux
becoming empty, so it disappears too.

These patches depend on
  [PATCH] staging: lustre: libcfs: use dynamic minors for /dev/{lnet,obd}
which James posted on 30th March.

Thanks,
NeilBrown

---

NeilBrown (6):
      staging: lustre: move stack-check macros to libcfs_debug.h
      staging: lustre: remove libcfs/linux/libcfs.h
      staging: lustre: remove include/linux/libcfs/linux/linux-cpu.h
      staging: lustre: rearrange placement of CPU partition management code.
      staging: lustre: move misc-device registration closer to related code.
      staging: lustre: move remaining code from linux-module.c to module.c


 .../staging/lustre/include/linux/libcfs/libcfs.h   |   48 +
 .../lustre/include/linux/libcfs/libcfs_cpu.h       |  206 +++-
 .../lustre/include/linux/libcfs/libcfs_debug.h     |   32 +
 .../lustre/include/linux/libcfs/linux/libcfs.h     |  114 --
 .../lustre/include/linux/libcfs/linux/linux-cpu.h  |   78 -
 drivers/staging/lustre/lnet/libcfs/Makefile        |    2 
 drivers/staging/lustre/lnet/libcfs/libcfs_cpu.c    |  961 +++++++++++++++++-
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   | 1079 --------------------
 .../lustre/lnet/libcfs/linux/linux-module.c        |  196 ----
 drivers/staging/lustre/lnet/libcfs/module.c        |  162 +++
 10 files changed, 1344 insertions(+), 1534 deletions(-)
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/libcfs.h
 delete mode 100644 drivers/staging/lustre/include/linux/libcfs/linux/linux-cpu.h
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-cpu.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-module.c

--
Signature
