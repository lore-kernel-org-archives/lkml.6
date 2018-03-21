Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-440706-1521655430-2-17151133862118682289
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521655429; b=XLZfs/Edx9ZbWhVffPVdHM3oG7NAVXlc2Vfxz4c7gxblCCy
    SaKeaT5r3Q8xO2emrHAbhiDpAbF8YZgsl/Vq+vrmbah1wtIwr3M4Bcw2SR4DBL+H
    OT48zlUX12M96evmHEXqWsj0lTfVKt1AlzFJFhVTC6MoqiBIiOAPIvhyjctr/beb
    kBHTtgu7F9gUFIYRqxftXazcwq95rqBfqu4uEfhgVhdhfmshKoyKQHFAdlFxrsNK
    Qi/fKrmcK0C/CvpXclF9zSZfFE4Pkx/HCVvu+4QWrKrU+06WpUaq3ABCRx+iVPX3
    Br5WHc3StyV1lQ9F9yp+Jwk2HMMVTiBaQPW6VpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=arctest; t=1521655429; bh=mxq8BBX
    oQ+Yw1ta6BX+d0KUUwBzJBxnScB+P7m4jD9g=; b=fgDaWkrFrhBXNPxzopunWWC
    J00/a/S2GpofxsedsUiaYA6Jhh9deArwv8182qtfo2+X7CwT3tFaiJUDilU0XjD3
    BbdteO31+otwIKbSJUt1N00H0Ls46pmXXQIMAPI+LSOc4mBBXmeAwp/LUFxPu+7n
    XQ3IxRrwo+9/GM4MqPF6HGITrEDLmXZUxRBuZ4L6KqqbCcfQtjKRIvxSPhYZRon0
    xHtxuXg1la+QDHM5uyzFL+29StsEY/vEEIWa9ndh30yFXj/XgcaaY/u8BsIKdLL9
    IiNO6KHsLs0HtAxwoP6PUAHNol14I2ahjA+0Zb1cs4gk3qc5OojKjf4EjEyZOhg=
    =
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752454AbeCUSDq (ORCPT <rfc822;greg@kroah.com>);
        Wed, 21 Mar 2018 14:03:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52832 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751877AbeCUSDp (ORCPT <rfc822;stable@vger.kernel.org>);
        Wed, 21 Mar 2018 14:03:45 -0400
Date: Wed, 21 Mar 2018 14:03:42 -0400
From: Jerome Glisse <jglisse@redhat.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org,
        Ralph Campbell <rcampbell@nvidia.com>, stable@vger.kernel.org,
        Evgeny Baskakov <ebaskakov@nvidia.com>,
        Mark Hairgrove <mhairgrove@nvidia.com>
Subject: Re: [PATCH 03/15] mm/hmm: HMM should have a callback before MM is
 destroyed v2
Message-ID: <20180321180342.GE3214@redhat.com>
References: <20180320020038.3360-1-jglisse@redhat.com>
 <20180320020038.3360-4-jglisse@redhat.com>
 <d89e417d-c939-4d18-72f5-08b22dc6cff0@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d89e417d-c939-4d18-72f5-08b22dc6cff0@nvidia.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 20, 2018 at 09:14:34PM -0700, John Hubbard wrote:
> On 03/19/2018 07:00 PM, jglisse@redhat.com wrote:
> > From: Ralph Campbell <rcampbell@nvidia.com>
> > 
> > The hmm_mirror_register() function registers a callback for when
> > the CPU pagetable is modified. Normally, the device driver will
> > call hmm_mirror_unregister() when the process using the device is
> > finished. However, if the process exits uncleanly, the struct_mm
> > can be destroyed with no warning to the device driver.
> > 
> > Changed since v1:
> >   - dropped VM_BUG_ON()
> >   - cc stable
> > 
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
> > Cc: stable@vger.kernel.org
> > Cc: Evgeny Baskakov <ebaskakov@nvidia.com>
> > Cc: Mark Hairgrove <mhairgrove@nvidia.com>
> > Cc: John Hubbard <jhubbard@nvidia.com>
> > ---
> >  include/linux/hmm.h | 10 ++++++++++
> >  mm/hmm.c            | 18 +++++++++++++++++-
> >  2 files changed, 27 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/hmm.h b/include/linux/hmm.h
> > index 36dd21fe5caf..fa7b51f65905 100644
> > --- a/include/linux/hmm.h
> > +++ b/include/linux/hmm.h
> > @@ -218,6 +218,16 @@ enum hmm_update_type {
> >   * @update: callback to update range on a device
> >   */
> >  struct hmm_mirror_ops {
> > +	/* release() - release hmm_mirror
> > +	 *
> > +	 * @mirror: pointer to struct hmm_mirror
> > +	 *
> > +	 * This is called when the mm_struct is being released.
> > +	 * The callback should make sure no references to the mirror occur
> > +	 * after the callback returns.
> > +	 */
> > +	void (*release)(struct hmm_mirror *mirror);
> > +
> >  	/* sync_cpu_device_pagetables() - synchronize page tables
> >  	 *
> >  	 * @mirror: pointer to struct hmm_mirror
> > diff --git a/mm/hmm.c b/mm/hmm.c
> > index 320545b98ff5..6088fa6ed137 100644
> > --- a/mm/hmm.c
> > +++ b/mm/hmm.c
> > @@ -160,6 +160,21 @@ static void hmm_invalidate_range(struct hmm *hmm,
> >  	up_read(&hmm->mirrors_sem);
> >  }
> >  
> > +static void hmm_release(struct mmu_notifier *mn, struct mm_struct *mm)
> > +{
> > +	struct hmm *hmm = mm->hmm;
> > +	struct hmm_mirror *mirror;
> > +	struct hmm_mirror *mirror_next;
> > +
> > +	down_write(&hmm->mirrors_sem);
> > +	list_for_each_entry_safe(mirror, mirror_next, &hmm->mirrors, list) {
> > +		list_del_init(&mirror->list);
> > +		if (mirror->ops->release)
> > +			mirror->ops->release(mirror);
> 
> Hi Jerome,
> 
> This presents a deadlock problem (details below). As for solution ideas, 
> Mark Hairgrove points out that the MMU notifiers had to solve the
> same sort of problem, and part of the solution involves "avoid
> holding locks when issuing these callbacks". That's not an entire 
> solution description, of course, but it seems like a good start.
> 
> Anyway, for the deadlock problem:
> 
> Each of these ->release callbacks potentially has to wait for the 
> hmm_invalidate_range() callbacks to finish. That is not shown in any
> code directly, but it's because: when a device driver is processing 
> the above ->release callback, it has to allow any in-progress operations 
> to finish up (as specified clearly in your comment documentation above). 
> 
> Some of those operations will invariably need to do things that result 
> in page invalidations, thus triggering the hmm_invalidate_range() callback.
> Then, the hmm_invalidate_range() callback tries to acquire the same 
> hmm->mirrors_sem lock, thus leading to deadlock:
> 
> hmm_invalidate_range():
> // ...
> 	down_read(&hmm->mirrors_sem);
> 	list_for_each_entry(mirror, &hmm->mirrors, list)
> 		mirror->ops->sync_cpu_device_pagetables(mirror, action,
> 							start, end);
> 	up_read(&hmm->mirrors_sem);

That is just illegal, the release callback is not allowed to trigger
invalidation all it does is kill all device's threads and stop device
page fault from happening. So there is no deadlock issues. I can re-
inforce the comment some more (see [1] for example on what it should
be).

Also it is illegal for the sync callback to trigger any mmu_notifier
callback. I thought this was obvious. The sync callback should only
update device page table and do _nothing else_. No way to make this
re-entrant.

For anonymous private memory migrated to device memory it is freed
shortly after the release callback (see exit_mmap()). For share memory
you might want to migrate back to regular memory but that will be fine
as you will not get mmu_notifier callback any more.

So i don't see any deadlock here.

Cheers,
Jérôme

[1] https://cgit.freedesktop.org/~glisse/linux/commit/?h=nouveau-hmm&id=93adb3e6b4f39d5d146b6a8afb4175d37bdd4890
