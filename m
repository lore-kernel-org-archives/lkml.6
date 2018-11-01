Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B73C6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3390122527
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 23:46:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3390122527
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbeKBIvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 04:51:18 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:58112 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbeKBIvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 04:51:17 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1gIMfA-0005bn-BU; Thu, 01 Nov 2018 23:46:08 +0000
Date:   Thu, 1 Nov 2018 23:46:08 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        dhowells@redhat.com
Subject: [git pull] work.afs
Message-ID: <20181101234608.GU32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	AFS series, with some iov_iter bits included.  Backmerge of NFS client
branch is due to conflict between sunrpc changes in there and iov_iter_{k,b}vec()
calling conventions change in iov_iter part; if you prefer to do that yourself,
just merge work.afs^^ and cherry-pick work.afs HEAD into it (or do the fixup
yourself - it's really trivial).  One trivial conflict (also in sunrpc, with nfsd
this time) due to the same commit; merge candidate is in #proposed-merge.  IMO
that one doesn't deserve a backmerge - it does trigger textual conflict, unlike
the NFS client one.

The following changes since commit 331bc71cb1751d78f6807ad8e6162b07c67cdd1b:

  SUNRPC: Convert the auth cred cache to use refcount_t (2018-10-23 12:24:33 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.afs

for you to fetch changes up to 0e9b4a82710220c04100892fb7277b78fd33a747:

  missing bits of "iov_iter: Separate type from direction and use accessor functions" (2018-11-01 18:19:03 -0400)

----------------------------------------------------------------
Al Viro (2):
      Merge tag 'nfs-for-4.20-1' of git://git.linux-nfs.org/projects/trondmy/linux-nfs
      missing bits of "iov_iter: Separate type from direction and use accessor functions"

David Howells (25):
      amd-gpu: Don't undefine READ and WRITE
      iov_iter: Use accessor function
      iov_iter: Separate type from direction and use accessor functions
      iov_iter: Add I/O discard iterator
      afs: Better tracing of protocol errors
      afs: Set up the iov_iter before calling afs_extract_data()
      afs: Improve FS server rotation error handling
      afs: Implement VL server rotation
      afs: Fix TTL on VL server and address lists
      afs: Handle EIO from delivery function
      afs: Add a couple of tracepoints to log I/O errors
      afs: Don't invoke the server to read data beyond EOF
      afs: Increase to 64-bit volume ID and 96-bit vnode ID for YFS
      afs: Commit the status on a new file/dir/symlink
      afs: Remove callback details from afs_callback_break struct
      afs: Implement the YFS cache manager service
      afs: Fix FS.FetchStatus delivery from updating wrong vnode
      afs: Calc callback expiry in op reply delivery
      afs: Get the target vnode in afs_rmdir() and get a callback on it
      afs: Expand data structure fields to support YFS
      afs: Implement YFS support in the fs client
      afs: Allow dumping of server cursor on operation failure
      afs: Eliminate the address pointer from the address list cursor
      afs: Fix callback handling
      afs: Probe multiple fileservers simultaneously

 block/bio.c                               |    2 +-
 drivers/block/drbd/drbd_main.c            |    2 +-
 drivers/block/drbd/drbd_receiver.c        |    2 +-
 drivers/block/loop.c                      |    9 +-
 drivers/block/nbd.c                       |   12 +-
 drivers/fsi/fsi-sbefifo.c                 |    4 +-
 drivers/gpu/drm/amd/display/dc/os_types.h |    2 -
 drivers/isdn/mISDN/l1oip_core.c           |    3 +-
 drivers/misc/vmw_vmci/vmci_queue_pair.c   |    6 +-
 drivers/nvme/target/io-cmd-file.c         |    2 +-
 drivers/target/iscsi/iscsi_target_util.c  |    6 +-
 drivers/target/target_core_file.c         |    6 +-
 drivers/usb/usbip/usbip_common.c          |    2 +-
 drivers/xen/pvcalls-back.c                |    8 +-
 fs/9p/vfs_addr.c                          |    4 +-
 fs/9p/vfs_dir.c                           |    2 +-
 fs/9p/xattr.c                             |    4 +-
 fs/afs/Kconfig                            |   12 +
 fs/afs/Makefile                           |    7 +-
 fs/afs/addr_list.c                        |  209 +--
 fs/afs/afs.h                              |   50 +-
 fs/afs/cache.c                            |    2 +-
 fs/afs/callback.c                         |   17 +-
 fs/afs/cell.c                             |   65 +-
 fs/afs/cmservice.c                        |  287 +++-
 fs/afs/dir.c                              |   75 +-
 fs/afs/dynroot.c                          |    4 +-
 fs/afs/file.c                             |    8 +-
 fs/afs/flock.c                            |   22 +-
 fs/afs/fs_probe.c                         |  270 ++++
 fs/afs/fsclient.c                         |  583 ++++----
 fs/afs/inode.c                            |   37 +-
 fs/afs/internal.h                         |  322 ++++-
 fs/afs/mntpt.c                            |    5 +-
 fs/afs/proc.c                             |  110 +-
 fs/afs/protocol_yfs.h                     |  163 +++
 fs/afs/rotate.c                           |  302 ++--
 fs/afs/rxrpc.c                            |  115 +-
 fs/afs/security.c                         |   13 +-
 fs/afs/server.c                           |  145 +-
 fs/afs/server_list.c                      |    6 +-
 fs/afs/super.c                            |    5 +-
 fs/afs/vl_list.c                          |  340 +++++
 fs/afs/vl_probe.c                         |  273 ++++
 fs/afs/vl_rotate.c                        |  355 +++++
 fs/afs/vlclient.c                         |  195 +--
 fs/afs/volume.c                           |   56 +-
 fs/afs/write.c                            |   30 +-
 fs/afs/xattr.c                            |    2 +-
 fs/afs/yfsclient.c                        | 2184 +++++++++++++++++++++++++++++
 fs/block_dev.c                            |    2 +-
 fs/ceph/file.c                            |    7 +-
 fs/cifs/connect.c                         |    4 +-
 fs/cifs/file.c                            |    4 +-
 fs/cifs/misc.c                            |    4 +-
 fs/cifs/smb2ops.c                         |    4 +-
 fs/cifs/smbdirect.c                       |   17 +-
 fs/cifs/transport.c                       |    8 +-
 fs/direct-io.c                            |    2 +-
 fs/dlm/lowcomms.c                         |    2 +-
 fs/fuse/file.c                            |    2 +-
 fs/iomap.c                                |    2 +-
 fs/nfsd/vfs.c                             |    4 +-
 fs/ocfs2/cluster/tcp.c                    |    2 +-
 fs/orangefs/inode.c                       |    2 +-
 fs/splice.c                               |    7 +-
 include/linux/uio.h                       |   65 +-
 include/trace/events/afs.h                |  213 ++-
 lib/iov_iter.c                            |  125 +-
 mm/filemap.c                              |    2 +-
 mm/page_io.c                              |    2 +-
 net/9p/client.c                           |    2 +-
 net/9p/trans_virtio.c                     |    2 +-
 net/bluetooth/6lowpan.c                   |    2 +-
 net/bluetooth/a2mp.c                      |    2 +-
 net/bluetooth/smp.c                       |    2 +-
 net/ceph/messenger.c                      |    6 +-
 net/netfilter/ipvs/ip_vs_sync.c           |    2 +-
 net/smc/smc_clc.c                         |    4 +-
 net/socket.c                              |    6 +-
 net/sunrpc/svcsock.c                      |    2 +-
 net/sunrpc/xprtsock.c                     |    4 +-
 net/tipc/topsrv.c                         |    2 +-
 net/tls/tls_device.c                      |    4 +-
 net/tls/tls_sw.c                          |    4 +-
 85 files changed, 5631 insertions(+), 1238 deletions(-)
