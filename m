Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752478AbeE0W1f (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 18:27:35 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:50932 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751879AbeE0W1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 18:27:33 -0400
Date: Sun, 27 May 2018 23:27:30 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: Avi Kivity <avi@scylladb.com>, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: aio poll and a new in-kernel poll API V13
Message-ID: <20180527222730.GS30522@ZenIV.linux.org.uk>
References: <20180523192022.1703-1-hch@lst.de>
 <20180526001111.GL30522@ZenIV.linux.org.uk>
 <20180526070937.GA4188@ZenIV.linux.org.uk>
 <20180526072306.GA17313@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526072306.GA17313@lst.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

	OK, it's in -next now; there are several cleanups I'd put
into vfs.git#work.aio:
      aio: all callers of aio_{read,write,fsync,poll} treat 0 and -EIOCBQUEUED the same way
      aio_read_events_ring(): make a bit more readable
      aio: shift copyin of iocb into io_submit_one()
      aio: fold do_io_submit() into callers
Those are *not* on -next yet and if anybody has objections against
any of those, please yell.  Individual patches in followups...
