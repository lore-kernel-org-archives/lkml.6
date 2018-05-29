Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754731AbeE2G5s (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 02:57:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:36196 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751444AbeE2G5q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 02:57:46 -0400
Date: Tue, 29 May 2018 08:57:25 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 4.16 231/272] fanotify: Avoid lost events due to ENOMEM
 for unlimited queues
Message-ID: <20180529065725.GA2473@kroah.com>
References: <20180528100240.256525891@linuxfoundation.org>
 <20180528100259.797799079@linuxfoundation.org>
 <CAOQ4uxi9emdAqr1JPYgC_T52SjCtpAbac4pSzfZ7vqtmg6nFMg@mail.gmail.com>
 <20180528125257.bppijdymfnsr3yqz@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528125257.bppijdymfnsr3yqz@quack2.suse.cz>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 02:52:57PM +0200, Jan Kara wrote:
> On Mon 28-05-18 15:39:04, Amir Goldstein wrote:
> > On Mon, May 28, 2018 at 1:04 PM, Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > > 4.16-stable review patch.  If anyone has any objections, please let me know.
> > >
> > 
> > I do not have objections for applying this patch to stable, but AFAIK
> > it is a correctness patch that doesn't fix any bug and it was mainly added
> > as a prerequisite to memcg accounting of event allocations, which is not
> > yet merged and not destined for stable.
> > 
> > Jan? do you agree with my statements above?
> 
> Yes, you are correct. The problem this patch tries to fix is theoretical in
> nature at this point. However my feeling is stable tree has got rather
> benevolent in accepting patches in last months and Greg wishes it stays that
> way so I'm objecting only to patches I know introduce regressions at this
> point.

I am getting "more benevolent", but the patch should be there for at
least some good reason.  This one was picked by the "semi-automatic"
checker, and at first glance seems like it is a real bugfix.  But, as
you mention, it was only needed in preparation for a future patch, then
this patch is not needed in the stable trees, and I'll go drop it now.

thanks,

greg k-h
