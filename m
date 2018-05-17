Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752304AbeEQJYv (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:24:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45682 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752509AbeEQJYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:24:47 -0400
Date: Thu, 17 May 2018 11:24:43 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>,
        "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390: vfio-ccw: push down unsupported IDA check
Message-ID: <20180517112443.0b39d7d9.cohuck@redhat.com>
In-Reply-To: <20180517010925.GA30480@bjsdjshi@linux.ibm.com>
References: <20180516173342.15174-1-pasic@linux.ibm.com>
        <20180517010925.GA30480@bjsdjshi@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 09:09:25 +0800
Dong Jia Shi <bjsdjshi@linux.ibm.com> wrote:

> * Halil Pasic <pasic@linux.ibm.com> [2018-05-16 19:33:42 +0200]:
> 
> Nitpick for Subject prefix (?):
> s/s390: vfio-ccw:/vfio: ccw:/

Trivial to fix up while applying.

> 
> > There is at least one relevant guest OS that doesn't set the IDA flags in
> > the ORB as we would like them, but never uses any IDA. So instead of
> > saying -EOPNOTSUPP when observing an ORB, such that a channel program
> > specified by it could be a not supported one, let us say -EOPNOTSUPP only
> > if the channel program is a not supported one.
> > 
> > Of course, the real solution would be doing proper translation for all
> > IDA. This is possible, but given the current code not straight forward.
> > 
> > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> > ---
> > ---  
> Leftover?

git am will drop this anyway :)

> 
> >  drivers/s390/cio/vfio_ccw_cp.c | 19 ++++++++++++++++---
> >  1 file changed, 16 insertions(+), 3 deletions(-)
> >   
> 
> Reviewed-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>

Thanks!
