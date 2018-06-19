Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F3AC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:55:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C340C205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:55:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C340C205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ZenIV.linux.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966353AbeFSOzA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:55:00 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:53028 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937707AbeFSOy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:54:59 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.87 #1 (Red Hat Linux))
        id 1fVI1z-0000JF-D2; Tue, 19 Jun 2018 14:54:51 +0000
Date:   Tue, 19 Jun 2018 15:54:51 +0100
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/39] vfs: export vfs_ioctl() to modules
Message-ID: <20180619145451.GQ30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com>
 <20180529144339.16538-8-mszeredi@redhat.com>
 <20180604084904.GF11333@infradead.org>
 <20180610045657.GM30522@ZenIV.linux.org.uk>
 <CAJfpegtGtAR25qWgpNisvL8F51h3K6s44zkWBSVVbqecut6tBQ@mail.gmail.com>
 <20180611162412.GA7574@infradead.org>
 <CAJfpegvxHs+MvC3N2Cbocp0UNrM47_GEUSV+mAx=8VVNDz7r_g@mail.gmail.com>
 <20180619142421.GA16151@infradead.org>
 <CAJfpegt7QYa1SD=uJ84RE9qLbJLMCW+viV=FN_TJJjCK4BERLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJfpegt7QYa1SD=uJ84RE9qLbJLMCW+viV=FN_TJJjCK4BERLQ@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 04:34:33PM +0200, Miklos Szeredi wrote:
> On Tue, Jun 19, 2018 at 4:24 PM, Christoph Hellwig <hch@infradead.org> wrote:
> > On Tue, Jun 19, 2018 at 04:04:41PM +0200, Miklos Szeredi wrote:
> >> FS_IOC*
> >>
> >> Haven't looked deeply.  For now overlayfs just implements
> >> FS_IOC_{GET|SET}FLAGS because some of these flags are quite generic
> >> and implementing them on the overlay is easy.
> >>
> >> Yes, turning into a method makes sense.
> >
> > Do you want to do this or should I send a patch?
> 
> Do it.  You are much more familiar with regular fs that implement
> these ioctls.  Untangling overlap between FS_IOC_...FLAGS and
> FS_IOC_...XATTR looks "interesting".

Suggestion: have that go through ->setattr(); that's what
ATTR_ATTR_FLAG was supposed to be for, IIRC.
