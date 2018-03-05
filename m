Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2624115-1520285270-2-15503634340419781531
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520285270; b=AYByjvs8W061H455Mjs5+ezdVoBtUscWUH6T4Wnh5saGISI
    6C8p75xG8fEg1XmcHDqYGPQSitFON/hP3qH2Wl+RKCUAYzpj56JkqG+Ob2KgyDI/
    xx1eI6ixadsDqKlCM/t1eADpav9lptPTC9f5/JGr/kF8wr5zy/E0S8+q8dPgBL3U
    dagomFIF+wgDJiu9yULc+pMCgsqFeM6TCXtWR+ES1mr5BKjgzTOvKZe0fYzs6coZ
    9P1MyHkQerc80MgOso8rJJjcoq4mmTfAcLPt7rTlGxLhZk6G/wzuRRAgXA1XTejI
    AT3dNHoCoLm10m9jXict80+AjH23lBJNJNx/bSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id:sender
    :list-id; s=arctest; t=1520285270; bh=Yq754Dm+LiXI+jgM0QLS4ioB3w
    7+Tkqtug1DjbOEFjA=; b=prg5eqBw/s/QBGByRq9bJEPd+JWPp2rHACPbtt2f8E
    AlOe7eAnDPZuT7MJ0O0oVolJ97eT07114ST0zJml9foXbwyQmIosanUKbVIhBzxo
    lERHiSP6r9yacElm88lCeVVRzazzn0oht7WdLUL+IJCYLm7oe6Ee/rik69mRsT2S
    8Rx8ysF41BPq+l1xbfGWTgz0rTkPe/FiGnw9WQ+HsBHWQ1qtQiFEcb1h0vM7pyvM
    yem2agEhj8OY1DgQjloTnEdL0ITXqkQnP85TS09SpZxI+C8FSXv/mdyumhlKbiWa
    bI4cfXQ4rBenV0HwxFd5gypc0EHwIQjMbyRm2xHdpdjg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=jOXw+fBj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered; 2048-bit rsa key sha256) header.d=infradead.org header.i=@infradead.org header.b=jOXw+fBj x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=bombadil.20170209;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeCEV1r (ORCPT <rfc822;greg@kroah.com>);
        Mon, 5 Mar 2018 16:27:47 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:60546 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751275AbeCEV1q (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 5 Mar 2018 16:27:46 -0500
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: aio poll, io_pgetevents and a new in-kernel poll API V5
Date: Mon,  5 Mar 2018 13:27:07 -0800
Message-Id: <20180305212743.16664-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi all,

this series adds support for the IOCB_CMD_POLL operation to poll for the
readyness of file descriptors using the aio subsystem.  The API is based
on patches that existed in RHAS2.1 and RHEL3, which means it already is
supported by libaio.  To implement the poll support efficiently new
methods to poll are introduced in struct file_operations:  get_poll_head
and poll_mask.  The first one returns a wait_queue_head to wait on
(lifetime is bound by the file), and the second does a non-blocking
check for the POLL* events.  This allows aio poll to work without
any additional context switches, unlike epoll.

To make the interface fully useful a new io_pgetevents system call is
added, which atomically saves and restores the signal mask over the
io_pgetevents system call.  It it the logical equivalent to pselect and
ppoll for io_pgetevents.

The corresponding libaio changes for io_pgetevents support and
documentation, as well as a test case will be posted in a separate
series.

The changes were sponsored by Scylladb, and improve performance
of the seastar framework up to 10%, while also removing the need
for a privileged SCHED_FIFO epoll listener thread.

    git://git.infradead.org/users/hch/vfs.git aio-poll.5

Gitweb:

    http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll.5

Libaio changes:

    https://pagure.io/libaio.git io-poll

Seastar changes (not updated for the new io_pgetevens ABI yet):

    https://github.com/avikivity/seastar/commits/aio

Changes since V4:
 - rebased ontop of Linux 4.16-rc4

Changes since V3:
 - remove the pre-sleep ->poll_mask call in vfs_poll,
   allow ->get_poll_head to return POLL* values.

Changes since V2:
 - removed a double initialization
 - new vfs_get_poll_head helper
 - document that ->get_poll_head can return NULL
 - call ->poll_mask before sleeping
 - various ACKs
 - add conversion of random to ->poll_mask
 - add conversion of af_alg to ->poll_mask
 - lacking ->poll_mask support now returns -EINVAL for IOCB_CMD_POLL
 - reshuffled the series so that prep patches and everything not
   requiring the new in-kernel poll API is in the beginning

Changes since V1:
 - handle the NULL ->poll case in vfs_poll
 - dropped the file argument to the ->poll_mask socket operation
 - replace the ->pre_poll socket operation with ->get_poll_head as
   in the file operations
