Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-375845-1522856600-2-9879803208823914033
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522856599; b=MNI0YzaK0kIUz3wQFNE1+/y9GAupCwJBfMRyjy2rUIsrMK81v2
    5e8mk/GMeB6OLkXUbCbrc1nqv/Mg+OLAJDUQOYJAjPMOavzsmN2PT+pZw4gn4vOl
    N8dxP/hkeA5nYTMKrVJyD2Yyshp5oP/hbOatIF4n3/F9GjcOgCYupt2sSauSpUFd
    GYOXIwhNtMyoO4ZfGoNiAUt3NyipReIcid9JA9qD//dA2mzjaAJM0VUUeQ5vTi5b
    +5r9WQJQ32dt7r93TlLSr6sVv9fXqrdT/eo9trYV03oLu9rNofbv1xG5Ln9y8V+v
    QzFPBLmTd5K//K3wIDCUCZg/BVrDgUmPsAtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1522856599; bh=Ffxejga7SEOx+cdIhfsO0QDZ4/cJg9
    paIhxiN2T+LMw=; b=NHk2BNXY93xv0nnK7UgQ6ivx59ou1181p7YhBGfI9gzi01
    Q+s8zxOWxPnMkNS+Z+gpD7+ndKEp3ZT8RNVCS5plh81al51vsDFBoupFKDmR9ZVW
    66/2WxpalYSMVyki+pq21SRF4kViAp/Qy3LxLe2HauxXsblEcZ3FW+XSuiz9VhV2
    CjIqzD+Mr4kbzh9dqSJtLz3De3ZpMrKEyaXxlxP4Txko99aTlTIHOHym3uk4NIB9
    hyT0hSeIomfyRidS+2OTc/SJ1jHK5vxkkGh/nuhKG1501cPtiB8WtQKnU4nwOHm6
    wNDapUk3de2QM7pi2tlG0sRLDbI8aAwsmXufvgfQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfA7O53jCRmsANQjmthkbwRsWoXbmS8h4r8lgDCxtIa7GVdFKU2XqCS+9i8x5Mtw3le/9D2BLR4DjEVtnb73GoFYGyOVQrlYSN3DQc0llXefm25iZ2//5
    c4X36YIuxyKMzOYuw6YV2X+5MvlY1N3tAtB2qMEtler6MA+QHu9eeFVBeCJSBXGFZdLEtRNP5znK27/tiTYJgI1YvuQAM8m6B4WxO70Tog3MaaIbHNQpbQMA
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=TYBLyS7eAAAA:8 a=VwQbUJbxAAAA:8 a=TAu22Ok865csWW7xEhUA:9 a=CjuIK1q_8ugA:10
    a=1R1Xb7_w0-cA:10 a=OREKyDgYLcYA:10 a=zvYvwCWiE4KgVXXeO06c:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751588AbeDDPnR (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 11:43:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47632 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbeDDPnQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Apr 2018 11:43:16 -0400
Date: Wed, 4 Apr 2018 17:43:16 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Kirill Tkhai <ktkhai@virtuozzo.com>
Cc: peterz@infradead.org, mingo@redhat.com, stable@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/qrwlock: Give priority to readers with irqs
 disabled to prevent deadlock
Message-ID: <20180404154316.GC31981@kroah.com>
References: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152285543936.4080.5025412328012618076.stgit@localhost.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 04, 2018 at 06:24:39PM +0300, Kirill Tkhai wrote:
> The following situation leads to deadlock:
> 
> [task 1]                          [task 2]                         [task 3]
> kill_fasync()                     mm_update_next_owner()           copy_process()
>  spin_lock_irqsave(&fa->fa_lock)   read_lock(&tasklist_lock)        write_lock_irq(&tasklist_lock)
>   send_sigio()                    <IRQ>                             ...
>    read_lock(&fown->lock)         kill_fasync()                     ...
>     read_lock(&tasklist_lock)      spin_lock_irqsave(&fa->fa_lock)  ...
> 
> Task 1 can't acquire read locked tasklist_lock, since there is
> already task 3 expressed its wish to take the lock exclusive.
> Task 2 holds the read locked lock, but it can't take the spin lock.
> 
> The patch makes queued_read_lock_slowpath() to give task 1 the same
> priority as it was an interrupt handler, and to take the lock
> dispite of task 3 is waiting it, and this prevents the deadlock.
> It seems there is no better way to detect such the situations,
> also in general it's not good to wait so long for readers with
> interrupts disabled, since read_lock may nest with another locks
> and delay the system.
> 
> Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
> ---
>  kernel/locking/qrwlock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>
