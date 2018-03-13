Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2602457-1520927192-2-13892285682052469438
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520927191; b=BkSArnsUgUHD8/vBvwB3wCkhcFOXZRzRzh0FGer0ZAOCUCu
    HntNflB1eJO5l7/ba2h8h3m7KBNfAGxE3WoHdyJKomQG0PGs+C3X36C3Bn7jHPf5
    KU4dvd7Jt3b7pttCAH8mKNdqnqeO4JEYg7DDUXkHe0ZzKyf6NANdwfqfaYZyLYBQ
    CTuZDypKlACIwKWfWlaD4v77JtJcqgy9EdVADlA7ekQrCFoFdvxfq/rc9aEvkTNT
    Xz2fEMNHeFI+vQVrxjGebZGYdyzw24C71ie+xy4R1nydYYmn936w6HUoSFy/2JqF
    Xdd1u1W5G0dvhR3y7fFMoc7z1cmEyVtkRI7LQFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1520927191; bh=9sI3MDZ8AbwPa425SWLt0BGDpv
    NFHuBc0peWpkT9MiA=; b=Ve29SyX+bhWhAErFDRpQbzLt8ZMGMaeGRIu7fzdi5u
    d7cStk1e2in8L5jtTdGbgKLJGMF7XymQyyT32IZWXymWcGyPgJSmbAuV45EjCB1W
    HyFPy8qiexOoACtf8d9XdTsy1pXVIs3m5pFkyPCtF0BY0dj4XikLKhOWjycF1itb
    WH1G6S3y7sV5Udv3I132gprIDBLHi5e/sXlCzx7fXe8gS2Dp5OCQAy8zA53v7O99
    oWcSEtcs8zvdkBaZ2a8Q3ReqRalq9zMUJSk/3ChZWBn8Q7VjGhMshYgBI3dm3pHY
    o58CRaD8aXSZTEwi5oFlH43GEd8V10zCboRO750z1I1w==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=lst.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=0 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=lst.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbeCMHq2 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 13 Mar 2018 03:46:28 -0400
Received: from verein.lst.de ([213.95.11.211]:56481 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751615AbeCMHq2 (ORCPT <rfc822;linux-api@vger.kernel.org>);
        Tue, 13 Mar 2018 03:46:28 -0400
Date: Tue, 13 Mar 2018 08:46:26 +0100
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: aio poll, io_pgetevents and a new in-kernel poll API V5
Message-ID: <20180313074626.GA32614@lst.de>
References: <20180305212743.16664-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305212743.16664-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

ping?

On Mon, Mar 05, 2018 at 01:27:07PM -0800, Christoph Hellwig wrote:
> Hi all,
> 
> this series adds support for the IOCB_CMD_POLL operation to poll for the
> readyness of file descriptors using the aio subsystem.  The API is based
> on patches that existed in RHAS2.1 and RHEL3, which means it already is
> supported by libaio.  To implement the poll support efficiently new
> methods to poll are introduced in struct file_operations:  get_poll_head
> and poll_mask.  The first one returns a wait_queue_head to wait on
> (lifetime is bound by the file), and the second does a non-blocking
> check for the POLL* events.  This allows aio poll to work without
> any additional context switches, unlike epoll.
> 
> To make the interface fully useful a new io_pgetevents system call is
> added, which atomically saves and restores the signal mask over the
> io_pgetevents system call.  It it the logical equivalent to pselect and
> ppoll for io_pgetevents.
> 
> The corresponding libaio changes for io_pgetevents support and
> documentation, as well as a test case will be posted in a separate
> series.
> 
> The changes were sponsored by Scylladb, and improve performance
> of the seastar framework up to 10%, while also removing the need
> for a privileged SCHED_FIFO epoll listener thread.
> 
>     git://git.infradead.org/users/hch/vfs.git aio-poll.5
> 
> Gitweb:
> 
>     http://git.infradead.org/users/hch/vfs.git/shortlog/refs/heads/aio-poll.5
> 
> Libaio changes:
> 
>     https://pagure.io/libaio.git io-poll
> 
> Seastar changes (not updated for the new io_pgetevens ABI yet):
> 
>     https://github.com/avikivity/seastar/commits/aio
> 
> Changes since V4:
>  - rebased ontop of Linux 4.16-rc4
> 
> Changes since V3:
>  - remove the pre-sleep ->poll_mask call in vfs_poll,
>    allow ->get_poll_head to return POLL* values.
> 
> Changes since V2:
>  - removed a double initialization
>  - new vfs_get_poll_head helper
>  - document that ->get_poll_head can return NULL
>  - call ->poll_mask before sleeping
>  - various ACKs
>  - add conversion of random to ->poll_mask
>  - add conversion of af_alg to ->poll_mask
>  - lacking ->poll_mask support now returns -EINVAL for IOCB_CMD_POLL
>  - reshuffled the series so that prep patches and everything not
>    requiring the new in-kernel poll API is in the beginning
> 
> Changes since V1:
>  - handle the NULL ->poll case in vfs_poll
>  - dropped the file argument to the ->poll_mask socket operation
>  - replace the ->pre_poll socket operation with ->get_poll_head as
>    in the file operations
---end quoted text---
