Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932659AbeCOPya (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:54:30 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:53356 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932395AbeCOPy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:54:26 -0400
X-Google-Smtp-Source: AG47ELtl4WWeVCL7n+27UcYhBW2/7g1NFrrUY0JnU8VccwdIU3q13I3buqpaX+ttwX01aUWpUzXRfw==
Message-ID: <1521129262.2686.23.camel@arista.com>
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
From: Dmitry Safonov <dima@arista.com>
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Date: Thu, 15 Mar 2018 15:54:22 +0000
In-Reply-To: <20180315152828.GA11365@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com>
         <20180315134649.skh2aukcmg5ud74y@8bytes.org>
         <1521123183.2686.7.camel@arista.com> <20180315142253.GC5259@8bytes.org>
         <1521124490.2686.16.camel@arista.com> <1521124920.2686.20.camel@arista.com>
         <20180315152828.GA11365@8bytes.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-03-15 at 16:28 +0100, Joerg Roedel wrote:
> On Thu, Mar 15, 2018 at 02:42:00PM +0000, Dmitry Safonov wrote:
> > But even with loop-limit we will need ratelimit each printk()
> > *also*.
> > Otherwise loop-limit will be based on time spent printing, not on
> > anything else..
> > The patch makes sense even with loop-limit in my opinion.
> 
> Looks like I mis-read your patch, somehow it looked to me as if you
> replace all 'ratelimited' usages with a call to __ratelimit(), but
> you
> just move 'ratelimited' into the loop, which actually makes sense.

Oh, ok

> But still, this alone is no proper fix for the soft-lockups you are
> seeing.

Well, I can also limit number of loops with say cap_num_fault_regs().
I didn't do that as on my measures the time spent on clearing a fault
is so small, that I'm not sure if it's possible to stuck in this loop.

-- 
Thanks,
             Dmitry
