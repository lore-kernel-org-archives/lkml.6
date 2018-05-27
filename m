Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2027383-1527382195-2-8862246211573181211
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: plain='utf-8'
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-fsdevel-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527382195; b=eGvJFMx40ItVbZLUsNt6aVgae8ow/3IvkDf7JSmqx+Gp64uHNj
    DoqUzIIMfYhr29orl65FW8T6j9FBmudNiUcFDYZ/A6aB79QItzXNfqAuMUbOTZsN
    L1eWC4732hJfUczXU8PEg8jWqbZp8uKuU1d2dGDpJtecRdtBzPB9f6ZyhylI8H5S
    Ub65ssyhfakuv59PTS6UtD5JdFXOKEtVlavoG34lMAup8NlXJN+7LD578Bd2n8Gz
    W9bZ//akBdCxBd2PDvKfQCZ09sj14IpyeSTy7lip4zbMbcFl+qT/2wcu+vTN9Tdc
    +foKWy9q8xLu/07t99VmRzrLvIGht5PZvenQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:references:cc:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527382195;
    bh=GERnd8eskh+m32zgmimOk6hJDuzb3ZnvycioC44GdhE=; b=Q9iVMTLf3cwk
    WmRiONMEqSXSXo8AKmY2UhngTIyo//SOBgssSwM3ZlZutEea5ieVBKd9EdXGtCs1
    uMJ8reUZr/wKk2uIqQgGG+sVgivsnX7Go1HiRxxaBElMcVUGpS7Uiss4ZVd6YDP3
    PzhS8ySGdFNislLbdKv3+UOtFDD/dl4xy5O/iC5Lv7HvgRmMtCDtOfLD3S0vTmPI
    sK/uuqbcA6uVeojA8H2CuOyyCGfrxlMBKljK33E6qAqccMtYTJWViWwfyxL2ABxD
    FWzMagu943+OqHn8+AbqcFECE8PtpBQ+zVNMSlD3qsYRlxlUv291cVA9bFHo5Q7p
    IkoepuSJSQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
    header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=i-love.sakura.ne.jp header.result=pass
    header_org.domain=sakura.ne.jp header_org.result=pass
    header_is_org_domain=no;
    x-vs=clean score=0 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none)
      header.from=i-love.sakura.ne.jp;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=i-love.sakura.ne.jp header.result=pass
      header_org.domain=sakura.ne.jp header_org.result=pass
      header_is_org_domain=no;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfBmyl958HockRfPg0xBjDsINNoVEx6eothL9e8vr97IgDsq9K2UJ8cxNBURGfdxS+bc/wQgmVNG0asqsWRwiFc6S6mFovldFkiXHZuWlEDNhJ/U8n+86
    BesdTSLO/cWSbBMYG8KPvnu+zhGmweUUAC1Biau8JeugUzEMxJPauDzlvkodtiGVJGIuOI2kxGeH2bRqQbiTC5rhaQrR6r3UF8jzw7/8A4sEf5KYhJ3cRrIR
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=MU6YJCdXpoSFsQY3VYkA:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032477AbeE0Atu (ORCPT <rfc822;linux@kroah.com>);
        Sat, 26 May 2018 20:49:50 -0400
Received: from www262.sakura.ne.jp ([202.181.97.72]:24259 "EHLO
        www262.sakura.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeE0Ats (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 26 May 2018 20:49:48 -0400
Subject: Re: general protection fault in wb_workfn (2)
To: syzbot <syzbot+4a7438e774b21ddd8eca@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, jack@suse.cz
References: <000000000000cbd959056d1851ca@google.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, axboe@kernel.dk, tj@kernel.org,
        david@fromorbit.com, linux-block@vger.kernel.org
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Message-ID: <0c7c5dea-7312-8a59-9d1b-5467f69719bf@I-love.SAKURA.ne.jp>
Date: Sun, 27 May 2018 09:47:54 +0900
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <000000000000cbd959056d1851ca@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
X-Mailing-List: linux-fsdevel@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Forwarding http://lkml.kernel.org/r/201805251915.FGH64517.HVFJOOLFFMQStO@I-love.SAKURA.ne.jp .

Jan Kara wrote:
> > void delayed_work_timer_fn(struct timer_list *t)
> > {
> > 	struct delayed_work *dwork = from_timer(dwork, t, timer);
> > 
> > 	/* should have been called from irqsafe timer with irq already off */
> > 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
> > }
> > 
> > Then, wb_workfn() is after all scheduled even if we check for
> > WB_registered bit, isn't it?
> 
> It can be queued after WB_registered bit is cleared but it cannot be queued
> after mod_delayed_work(bdi_wq, &wb->dwork, 0) has finished. That function
> deletes the pending timer (the timer cannot be armed again because
> WB_registered is cleared) and queues what should be the last round of
> wb_workfn().

mod_delayed_work() deletes the pending timer but does not wait for already
invoked timer handler to complete because it is using del_timer() rather than
del_timer_sync(). Then, what happens if __queue_work() is almost concurrently
executed from two CPUs, one from mod_delayed_work(bdi_wq, &wb->dwork, 0) from
wb_shutdown() path (which is called without spin_lock_bh(&wb->work_lock)) and
the other from delayed_work_timer_fn() path (which is called without checking
WB_registered bit under spin_lock_bh(&wb->work_lock)) ?

wb_wakeup_delayed() {
  spin_lock_bh(&wb->work_lock);
  if (test_bit(WB_registered, &wb->state)) // succeeds
    queue_delayed_work(bdi_wq, &wb->d_work, timeout) {
      queue_delayed_work_on(WORK_CPU_UNBOUND, bdi_wq, &wb->d_work, timeout) {
         if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&wb->d_work.work))) { // succeeds
           __queue_delayed_work(WORK_CPU_UNBOUND, bdi_wq, &wb->d_work, timeout) {
             add_timer(timer); // schedules for delayed_work_timer_fn()
           }
         }
      }
    }
  spin_unlock_bh(&wb->work_lock);
}

delayed_work_timer_fn() {
  // del_timer() already returns false at this point because this timer
  // is already inside handler. But something took long here enough to
  // wait for __queue_work() from wb_shutdown() path to finish?
  __queue_work(WORK_CPU_UNBOUND, bdi_wq, &wb->d_work.work) {
    insert_work(pwq, work, worklist, work_flags);
  }
}

wb_shutdown() {
  mod_delayed_work(bdi_wq, &wb->dwork, 0) {
    mod_delayed_work_on(WORK_CPU_UNBOUND, bdi_wq, &wb->dwork, 0) {
      ret = try_to_grab_pending(&wb->dwork.work, true, &flags) {
        if (likely(del_timer(&wb->dwork.timer))) // fails because already in delayed_work_timer_fn()
          return 1;
        if (!test_and_set_bit(WORK_STRUCT_PENDING_BIT, work_data_bits(&wb->dwork.work))) // fails because already set by queue_delayed_work()
          return 0;
        // Returns 1 or -ENOENT after doing something?
      }
      if (ret >= 0)
        __queue_delayed_work(WORK_CPU_UNBOUND, bdi_wq, &wb->dwork, 0) {
          __queue_work(WORK_CPU_UNBOUND, bdi_wq, &wb->dwork.work) {
            insert_work(pwq, work, worklist, work_flags);
          }
        }
    }
  }
}
