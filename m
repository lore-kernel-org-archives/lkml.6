Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeC2NxE (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 09:53:04 -0400
Received: from mail-it0-f53.google.com ([209.85.214.53]:52730 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751908AbeC2NxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 09:53:03 -0400
X-Google-Smtp-Source: AIpwx4+bpJqTouBxeL53zqY2NtuyvWARZVI5qnT2yvb54me7Oce8+hbPUzNFbmzU1sE6Kxlv8uko/8+dOBpI4iYdp+s=
MIME-Version: 1.0
In-Reply-To: <20180329085017.tkdtx77u4khiuqhw@8bytes.org>
References: <20180215191729.15777-1-dima@arista.com> <20180315134649.skh2aukcmg5ud74y@8bytes.org>
 <1521123183.2686.7.camel@arista.com> <20180315142253.GC5259@8bytes.org>
 <1521124490.2686.16.camel@arista.com> <1521124920.2686.20.camel@arista.com>
 <20180315152828.GA11365@8bytes.org> <1521579013.2686.83.camel@arista.com> <20180329085017.tkdtx77u4khiuqhw@8bytes.org>
From: Dmitry Safonov <0x7f454c46@gmail.com>
Date: Thu, 29 Mar 2018 14:52:41 +0100
Message-ID: <CAJwJo6aav1Ggsat2o9H8HL0bjTzTcjtwKPL5EU0iJQo6v5-WQA@mail.gmail.com>
Subject: Re: [PATCHv3] iommu/intel: Ratelimit each dmar fault printing
To: Joerg Roedel <joro@8bytes.org>
Cc: Dmitry Safonov <dima@arista.com>,
        open list <linux-kernel@vger.kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-29 9:50 GMT+01:00 Joerg Roedel <joro@8bytes.org>:
> On Tue, Mar 20, 2018 at 08:50:13PM +0000, Dmitry Safonov wrote:
>> Hmm, but this fixes my softlockup issue, because it's about time spent
>> in printk() inside irq-disabled section, rather about exiting the dmar-
>> clearing loop.
>> And on my hw doesn't make any difference to limit loop or not because
>> clearing a fault is much faster than hw could generate a new fault.
>> ITOW, it fixes the softlockup for me and the loop-related lockup can't
>> happen on hw I have (so it's the other issue, [possible?] on other hw).
>
> It might solve your issue, but someone else might still run into it with
> a different setup. An upstream fix needs to solve it for everyone.

Ok, I'll resend v4 with an additional patch to limit the loop.

Thanks,
             Dmitry
