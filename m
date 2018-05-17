Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeEQJnC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 05:43:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51942 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751293AbeEQJnA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 05:43:00 -0400
Date: Thu, 17 May 2018 11:42:56 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] s390: vfio-ccw: push down unsupported IDA check
Message-ID: <20180517114256.0ee945c1.cohuck@redhat.com>
In-Reply-To: <20180516173342.15174-1-pasic@linux.ibm.com>
References: <20180516173342.15174-1-pasic@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 19:33:42 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> There is at least one relevant guest OS that doesn't set the IDA flags in
> the ORB as we would like them, but never uses any IDA. So instead of
> saying -EOPNOTSUPP when observing an ORB, such that a channel program
> specified by it could be a not supported one, let us say -EOPNOTSUPP only
> if the channel program is a not supported one.
> 
> Of course, the real solution would be doing proper translation for all
> IDA. This is possible, but given the current code not straight forward.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Thanks, applied.
