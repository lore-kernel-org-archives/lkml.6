Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4483C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B328F20685
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 22:05:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B328F20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbeI2EbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 00:31:16 -0400
Received: from smtprelay0142.hostedemail.com ([216.40.44.142]:54842 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726332AbeI2EbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 00:31:15 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 901AE837F243;
        Fri, 28 Sep 2018 22:05:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: push79_2fca33478e35a
X-Filterd-Recvd-Size: 3695
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:05:28 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Stefan Hajnoczi <stefanha@redhat.com>, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>
Subject: Bad MAINTAINERS pattern in section 'VIRTIO AND VHOST VSOCK DRIVER'
Date:   Fri, 28 Sep 2018 15:05:26 -0700
Message-Id: <20180928220527.32038-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	15660	VIRTIO AND VHOST VSOCK DRIVER
	15661	M:	Stefan Hajnoczi <stefanha@redhat.com>
	15662	L:	kvm@vger.kernel.org
	15663	L:	virtualization@lists.linux-foundation.org
	15664	L:	netdev@vger.kernel.org
	15665	S:	Maintained
	15666	F:	include/linux/virtio_vsock.h
	15667	F:	include/uapi/linux/virtio_vsock.h
	15668	F:	include/uapi/linux/vsockmon.h
	15669	F:	include/uapi/linux/vm_sockets_diag.h
	15670	F:	net/vmw_vsock/diag.c
	15671	F:	net/vmw_vsock/af_vsock_tap.c
	15672	F:	net/vmw_vsock/virtio_transport_common.c
	15673	F:	net/vmw_vsock/virtio_transport.c
	15674	F:	drivers/net/vsockmon.c
	15675	F:	drivers/vhost/vsock.c
-->	15676	F:	drivers/vhost/vsock.h
	15677	F:	tools/testing/vsock/

Commit that introduced this:

commit 433fc58e6bf2c8bd97e57153ed28e64fd78207b8
 Author: Asias He <asias@redhat.com>
 Date:   Thu Jul 28 15:36:34 2016 +0100
 
     VSOCK: Introduce vhost_vsock.ko
     
     VM sockets vhost transport implementation.  This driver runs on the
     host.
     
     Signed-off-by: Asias He <asias@redhat.com>
     Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
     Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
 
  MAINTAINERS                |   2 +
  drivers/vhost/vsock.c      | 722 +++++++++++++++++++++++++++++++++++++++++++++
  include/uapi/linux/vhost.h |   5 +
  3 files changed, 729 insertions(+)

Last commit with drivers/vhost/vsock.h

commit 8ac2837c89c8c0fcad557e4380aeef80580390f9
Author: Stefan Hajnoczi <stefanha@redhat.com>
Date:   Wed Dec 9 10:51:12 2015 +0800

    Revert "Merge branch 'vsock-virtio'"
    
    This reverts commit 0d76d6e8b2507983a2cae4c09880798079007421 and merge
    commit c402293bd76fbc93e52ef8c0947ab81eea3ae019, reversing changes made
    to c89359a42e2a49656451569c382eed63e781153c.
    
    The virtio-vsock device specification is not finalized yet.  Michael
    Tsirkin voiced concerned about merging this code when the hardware
    interface (and possibly the userspace interface) could still change.
    
    Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
    Signed-off-by: David S. Miller <davem@davemloft.net>

 drivers/vhost/Kconfig                   |    4 -
 drivers/vhost/Kconfig.vsock             |    7 -
 drivers/vhost/Makefile                  |    4 -
 drivers/vhost/vsock.c                   |  630 ---------------
 drivers/vhost/vsock.h                   |    4 -
 include/linux/virtio_vsock.h            |  209 -----
 include/net/af_vsock.h                  |    2 -
 include/uapi/linux/virtio_ids.h         |    1 -
 include/uapi/linux/virtio_vsock.h       |   89 ---
 net/vmw_vsock/Kconfig                   |   18 -
 net/vmw_vsock/Makefile                  |    2 -
 net/vmw_vsock/af_vsock.c                |   70 --
 net/vmw_vsock/virtio_transport.c        |  466 -----------
 net/vmw_vsock/virtio_transport_common.c | 1272 -------------------------------
 14 files changed, 2778 deletions(-)
