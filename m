Return-Path: <neilb@suse.com>
X-Google-Smtp-Source: AH8x224tTIiE1o+5vyH3udsjI24Oipihjr0or7zIdcHUb5hUOBqxPwZByMMGlSXSBa8tvyq54a39
ARC-Seal: i=1; a=rsa-sha256; t=1519093459; cv=none;
        d=google.com; s=arc-20160816;
        b=N6w9pxNOYaqfQcmwHtuE1EvmvbXaOHN3LLRwzI7azOt5C2aDAEbkO/P8Hrm/I9eVVh
         Rt4EctMAcGe0g7IdlPVjeOohH3uIyX5mqYlpIIMbBnrGYpGNzeziIis4CxfWEh/q4/U5
         B1paokXkg3kFCVrer4f0Pb0EILGdwWL8LedBJfFMlHeK2/Bx1/Rsf7udsf4UQTzgjaaG
         4HDiU7gKeBeJ41w5u3et+KGCyQd/Po6jBS1WJvCArplDht0dqsj8AbuthsaNes7JcMDf
         zDMDzlRlLU/erBuuI7SwdDnnTekcQz2qf5ixDW/WmIHJFdHVbfc8Fhj8VY3kYmnvrk33
         TwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:mime-version:user-agent:message-id:cc
         :subject:date:to:from:arc-authentication-results;
        bh=nWIdAaUPUc54/w6q5dQwD4SHpSlHjRE0ZUcu9qikv9s=;
        b=iVelqAQqmcuWG96Dxhpu15txDCINnP9je+mWuuPdwbFQwrv4Zt60RMVfPL158HQQae
         goxIJ01LUOAYdmwqKIKbOm0Amp3pNCgt0iXluTuzIF5LRVv9JHJBjcHm/Ed5eKjgzjmc
         eWQCr1fEqcuNq9+od26Al+CTzEVw/bGEzrizgLk9GbPyW8vY2MesYM8FUKO7sSrpvfkB
         8+Q45k48P65+Q8Pi275kGIhugI8hCGUGSLLCL8yZBCf1qi7v0CC2Ir8fd2f6BEZ7TyVt
         Yaq/AM/wC0rx9LN+sEtlbpeqA5D/0iMrQ4fycVvdx1vGUov6k2scYC5XEcYp/I7e8D6o
         s2Cw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of neilb@suse.com designates 195.135.220.15 as permitted sender) smtp.mailfrom=neilb@suse.com
From: NeilBrown <neilb@suse.com>
To: Oleg Drokin <oleg.drokin@intel.com>, James Simmons <jsimmons@infradead.org>,
 Andreas Dilger <andreas.dilger@intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Tue, 20 Feb 2018 13:23:37 +1100
Subject: [PATCH 00/21] staging: assorted lustre clean-up
Cc: lkml <linux-kernel@vger.kernel.org>, lustre <lustre-devel@lists.lustre.org>
Message-ID: <151909308778.25814.9912662268627044409.stgit@noble>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592884943787540243?=
X-GMAIL-MSGID: =?utf-8?q?1592884943787540243?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Following are assorted patches which clean up parts of lustre.
One or two tiny buglets are fixed, but mostly the patches
just make the code more readable, often by removing distractions.

The first several patches remove content from libcfs, completely
removing 3 files.
There are some list_for_each improvements in ptlrpc, and some
code simplification in fid.
Finally a small simplification in socklnd.

(lnd ?? Lustre Networking Domain??)

Thanks,
NeilBrown


---

NeilBrown (21):
      staging: lustre: replace all CFS_CAP_* macros with CAP_*
      staging: lustre: opencode cfs_cap_{raise,lower,raised}
      staging: lustre: remove linux-curproc.c
      staging: lustre: remove unnecessary cfs_block_allsigs() calls
      staging: lustre: lnet: remove cfs_block_allsigs calls.
      staging: lustre: simplify linux-prim.c
      staging: lustre: improve API and implementation of blocking signals.
      staging: lustre: make signal-blocking functions inline
      staging: lustre: discard libcfs_kvzalloc_cpt()
      staging: lustre: discard lu_buf allocation library.
      staging: lustre: improve some libcfs_kvzalloc calls.
      staging: lustre: discard libcfs_kvzalloc and linux-mem.c
      staging: lustre: remove phantom struct cfs_crypto_hash_desc
      staging: lustre: fix assorted checkpatch errors
      staging: lustre: ptlrpc: list_for_each improvements.
      staging: lustre: fid: convert lcs_mutex to a spinlock
      staging: lustre: fid: use wait_event_cmd()
      staging: lustre: fid: remove seq_fid_alloc_fini() and simplify
      staging: lustre: fid: fix up debugfs access to ->lcs_space
      staging: lustre: fid: perform sanity checks before commiting
      staging: lustre: socklnd: simplify ksnc_rx_iov_space


 .../staging/lustre/include/linux/libcfs/curproc.h  |   37 ++-----
 .../staging/lustre/include/linux/libcfs/libcfs.h   |   27 +++--
 .../lustre/include/linux/libcfs/libcfs_crypto.h    |   11 +-
 drivers/staging/lustre/include/linux/lnet/api.h    |    1 
 .../staging/lustre/lnet/klnds/o2iblnd/o2iblnd_cb.c |    6 -
 .../staging/lustre/lnet/klnds/socklnd/socklnd.h    |   11 --
 .../staging/lustre/lnet/klnds/socklnd/socklnd_cb.c |   10 --
 .../lustre/lnet/klnds/socklnd/socklnd_lib.c        |    2 
 drivers/staging/lustre/lnet/libcfs/Makefile        |    4 -
 .../staging/lustre/lnet/libcfs/linux/linux-cpu.c   |    2 
 .../lustre/lnet/libcfs/linux/linux-crypto.c        |   29 ++---
 .../lustre/lnet/libcfs/linux/linux-curproc.c       |  108 -------------------
 .../staging/lustre/lnet/libcfs/linux/linux-mem.c   |   51 ---------
 .../staging/lustre/lnet/libcfs/linux/linux-prim.c  |  113 --------------------
 drivers/staging/lustre/lnet/lnet/acceptor.c        |    2 
 drivers/staging/lustre/lnet/lnet/api-ni.c          |   15 +--
 drivers/staging/lustre/lnet/lnet/lib-eq.c          |   10 +-
 drivers/staging/lustre/lnet/lnet/router.c          |    2 
 drivers/staging/lustre/lnet/selftest/timer.c       |    2 
 drivers/staging/lustre/lustre/fid/fid_request.c    |  106 ++++++-------------
 drivers/staging/lustre/lustre/fid/lproc_fid.c      |   44 +++++---
 drivers/staging/lustre/lustre/include/lu_object.h  |    7 -
 drivers/staging/lustre/lustre/include/lustre_fid.h |    2 
 drivers/staging/lustre/lustre/include/lustre_lib.h |   18 ++-
 drivers/staging/lustre/lustre/include/lustre_sec.h |    3 -
 drivers/staging/lustre/lustre/include/obd_class.h  |    8 +
 .../staging/lustre/lustre/include/obd_support.h    |    2 
 drivers/staging/lustre/lustre/llite/dcache.c       |    2 
 drivers/staging/lustre/lustre/llite/dir.c          |   10 +-
 drivers/staging/lustre/lustre/llite/file.c         |   12 +-
 drivers/staging/lustre/lustre/llite/llite_lib.c    |    8 +
 drivers/staging/lustre/lustre/llite/llite_mmap.c   |    8 +
 drivers/staging/lustre/lustre/llite/xattr.c        |    2 
 drivers/staging/lustre/lustre/lmv/lmv_obd.c        |    4 -
 drivers/staging/lustre/lustre/lov/lov_ea.c         |    2 
 drivers/staging/lustre/lustre/lov/lov_io.c         |    2 
 drivers/staging/lustre/lustre/lov/lov_lock.c       |    2 
 drivers/staging/lustre/lustre/lov/lov_object.c     |    4 -
 drivers/staging/lustre/lustre/lov/lov_pack.c       |    2 
 drivers/staging/lustre/lustre/lov/lov_request.c    |    2 
 drivers/staging/lustre/lustre/mdc/mdc_locks.c      |    2 
 drivers/staging/lustre/lustre/mdc/mdc_request.c    |    6 +
 drivers/staging/lustre/lustre/obdclass/linkea.c    |   16 ++-
 .../lustre/lustre/obdclass/linux/linux-module.c    |    4 -
 drivers/staging/lustre/lustre/obdclass/llog.c      |   22 ++--
 drivers/staging/lustre/lustre/obdclass/lu_object.c |   70 ------------
 .../lustre/lustre/obdclass/lustre_handles.c        |    4 -
 .../staging/lustre/lustre/obdecho/echo_client.c    |    8 +
 drivers/staging/lustre/lustre/osc/osc_cache.c      |    4 -
 drivers/staging/lustre/lustre/osc/osc_page.c       |    2 
 drivers/staging/lustre/lustre/osc/osc_request.c    |    2 
 drivers/staging/lustre/lustre/ptlrpc/client.c      |   93 +++++-----------
 drivers/staging/lustre/lustre/ptlrpc/import.c      |   34 ++----
 drivers/staging/lustre/lustre/ptlrpc/layout.c      |    2 
 drivers/staging/lustre/lustre/ptlrpc/pinger.c      |    8 -
 drivers/staging/lustre/lustre/ptlrpc/ptlrpcd.c     |   15 +--
 drivers/staging/lustre/lustre/ptlrpc/recover.c     |   28 ++---
 drivers/staging/lustre/lustre/ptlrpc/sec.c         |    4 -
 drivers/staging/lustre/lustre/ptlrpc/sec_bulk.c    |    4 -
 drivers/staging/lustre/lustre/ptlrpc/sec_null.c    |    8 +
 drivers/staging/lustre/lustre/ptlrpc/sec_plain.c   |    8 +
 drivers/staging/lustre/lustre/ptlrpc/service.c     |   27 ++---
 62 files changed, 295 insertions(+), 769 deletions(-)
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-curproc.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-mem.c
 delete mode 100644 drivers/staging/lustre/lnet/libcfs/linux/linux-prim.c

--
Signature
