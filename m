Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752030AbeERMr6 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 08:47:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57594 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751112AbeERMrz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 08:47:55 -0400
Date: Fri, 18 May 2018 15:47:53 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, linux-kernel@vger.kernel.org,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] kvm: rename HINTS_DEDICATED to KVM_HINTS_REALTIME
Message-ID: <20180518154721-mutt-send-email-mst@kernel.org>
References: <1526568841-35372-1-git-send-email-mst@redhat.com>
 <20180517184658.GA1543@localhost.localdomain>
 <a95b2a12-f3a9-b930-49fe-46c2278df34d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a95b2a12-f3a9-b930-49fe-46c2278df34d@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 11:41:23AM +0200, Paolo Bonzini wrote:
> On 17/05/2018 20:46, Eduardo Habkost wrote:
> > My understanding of the original patch is that the intention is
> > to tell the guest that it is very unlikely to be preempted, so it
> > can choose a more appropriate spinlock implementation.  This
> > description implies that the guest will never be preempted, which
> > is much stronger guarantee.
> > 
> > Isn't this new description incompatible with existing usage of
> > the hint, which might include people who just use vCPU pinning
> > but no mlock?
> 
> If you use hugetlbfs and vhost-user you don't really need mlock for the
> QEMU process, do you?  The QEMU process is not doing much in that case
> and hugetlbfs gives you pinned memory automatically.
> 
> Paolo

Same with PCI device passthrough: VFIO pins all guest memory right now.

-- 
MST
