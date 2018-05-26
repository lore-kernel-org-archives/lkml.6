Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030901AbeEZALP (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 20:11:15 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:43356 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030723AbeEZALO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 20:11:14 -0400
Date: Sat, 26 May 2018 01:11:11 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: aio poll and a new in-kernel poll API V13
Message-ID: <20180526001111.GL30522@ZenIV.linux.org.uk>
References: <20180523192022.1703-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180523192022.1703-1-hch@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 23, 2018 at 09:19:49PM +0200, Christoph Hellwig wrote:
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
> This series sits on top of the aio-fsync series that also includes
> support for io_pgetevents.

OK, I can live with that, except for one problem - the first patch shouldn't
be sitting on top of arseloads of next window fodder.

Please, rebase the rest of the series on top of merge of vfs.git#fixes
(4faa99965e02) with your aio-fsync.4 and tell me what to pull.
