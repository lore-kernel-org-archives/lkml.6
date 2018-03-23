Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521803850-2-6389365604905781526
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
    t=1521803850; b=AFwYKI7UKD77E/mEzB13TzvQqCaLZ57bwPLrFvXy68VrUo2
    WbAgSGltsw0xLT87tbd5nDE6GnE9eTGVmbdIwEFVd9ngeP3AnFMHWSvHEk0eavVM
    DK5BE4SEyKGzhNGyRpCp/xure28OgMC/keb7qCk4cutQQpO8+qqBTOpgpVMfhOGQ
    Bt6/j1hVOUGn3aA74esDdf83CGI7QJ+CfPukKYCFxPWkIHg8ro8td+rivQqetqzu
    VaUJWUb19fIWFe3VQXFdzSkQ5MI1u4enBD4y+OvhyDBC5vShG1NRfU3aV0w/IDkL
    +H3VGDSvVdZo5lq0reBRNlW2WvYZ1eNqYkOrAwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521803850; bh=lfJA7WZNvp8pNqmHqOBJj6+26R
    N/Vq25R4wJdg+pfKw=; b=m7azOwqE/KJPZ3OgBr98ILxcmv3QKJLcsE7gyy41hk
    u6L++zuhwOJ4EgsYthQlVWN8GSDs2AW7Ac94U1LsYGW5Rnovr4M5wFDJshr+YEzj
    ap4VR81V/i0xtLopl4DL+kPxBOIi/DWAn7bHH8I58Qfyj3Bi23eo12e9RKtV9YDf
    7UsQ2EtUNSPyoskvgSfugbdnSdbmpXXPW7aSHPKUA9Z+f/9tk5XpKDuGE7FZddWM
    bt950+mradWjdsl7dXtee+AMt9GRgHZCl+nT3MaaUcVlOfAzgvx7r6jMjpursg53
    TRA3UWkphmOnrACd3xhXVGjmxnCOq6oCl5ZEUUYKRIQQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932464AbeCWKJ0 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 06:09:26 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:42044 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755749AbeCWKJV (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:09:21 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Max Gurtovoy <maxg@mellanox.com>,
        Moni Shoua <monis@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 115/177] IB/rxe: Dont clamp residual length to mtu
Date: Fri, 23 Mar 2018 10:54:03 +0100
Message-Id: <20180323094210.328894806@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Thumshirn <jthumshirn@suse.de>


[ Upstream commit d52418502e288b5c7e9e2e6cf1de5f1d3d79d2e1 ]

When reading a RDMA WRITE FIRST packet we copy the DMA length from the RDMA
header into the qp->resp.resid variable for later use. Later in check_rkey()
we clamp it to the MTU if the packet is an  RDMA WRITE packet and has a
residual length bigger than the MTU. Later in write_data_in() we subtract the
payload of the packet from the residual length. If the packet happens to have a
payload of exactly the MTU size we end up with a residual length of 0 despite
the packet not being the last in the conversation. When the next packet in the
conversation arrives, we don't have any residual length left and thus set the QP
into an error state.

This broke NVMe over Fabrics functionality over rdma_rxe.ko

The patch was verified using the following test.

 # echo eth0 > /sys/module/rdma_rxe/parameters/add
 # nvme connect -t rdma -a 192.168.155.101 -s 1023 -n nvmf-test
 # mkfs.xfs -fK /dev/nvme0n1
 meta-data=/dev/nvme0n1           isize=256    agcount=4, agsize=65536 blks
          =                       sectsz=4096  attr=2, projid32bit=1
          =                       crc=0        finobt=0, sparse=0
 data     =                       bsize=4096   blocks=262144, imaxpct=25
          =                       sunit=0      swidth=0 blks
 naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
 log      =internal log           bsize=4096   blocks=2560, version=2
          =                       sectsz=4096  sunit=1 blks, lazy-count=1
 realtime =none                   extsz=4096   blocks=0, rtextents=0
 # mount /dev/nvme0n1 /tmp/
 [  148.923263] XFS (nvme0n1): Mounting V4 Filesystem
 [  148.961196] XFS (nvme0n1): Ending clean mount
 # dd if=/dev/urandom of=test.bin bs=1M count=128
 128+0 records in
 128+0 records out
 134217728 bytes (134 MB, 128 MiB) copied, 0.437991 s, 306 MB/s
 # sha256sum test.bin
 cde42941f045efa8c4f0f157ab6f29741753cdd8d1cff93a6b03649d83c4129a  test.bin
 # cp test.bin /tmp/
 sha256sum /tmp/test.bin
 cde42941f045efa8c4f0f157ab6f29741753cdd8d1cff93a6b03649d83c4129a  /tmp/test.bin

Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Max Gurtovoy <maxg@mellanox.com>
Acked-by: Moni Shoua <monis@mellanox.com>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/sw/rxe/rxe_resp.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/infiniband/sw/rxe/rxe_resp.c
+++ b/drivers/infiniband/sw/rxe/rxe_resp.c
@@ -471,8 +471,6 @@ static enum resp_states check_rkey(struc
 				state = RESPST_ERR_LENGTH;
 				goto err;
 			}
-
-			qp->resp.resid = mtu;
 		} else {
 			if (pktlen != resid) {
 				state = RESPST_ERR_LENGTH;
