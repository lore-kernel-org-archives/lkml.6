Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2152363-1523980686-2-6453970198403930424
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523980686; b=l4vF0tRwGGTj/r4Li+eIYnJPdZ6Q1VrQABTLMqcRLsBjGXKTlV
    yaBCvLq6EuybaV+7riGM/pNe/kl6cZqf2d7lrYCxveNCMJx/v/vTZAvbR2ZxasY1
    PiHEjY1gyrrFIeWTc5us4fnsQKu613i7rImkwYBlXnKUv1fMONdm9aYGHs6J7O7C
    Qn9wjp9sr8RFhmhFAzyp2irDrBXd9yPpwyxHO5ON/xY0K+KcDrqOk/ilY1owaLG7
    GK8gU0VARAiGWO039MowoHH8FclCERrIigvQECcg/5tcky6nuPgrJxZoTQwT0JCf
    fHyB7n1vVmu2wsRtWJfB6v9GIXrh+FG+C0bA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1523980686; bh=l+eemrpP5D7
    YMYbcqrFsYT7CXN0FQ6PMF4fPoN+e3rM=; b=Y/ealJUipYcPyr3ZLBg1ZuaN9FW
    gvZyChKQuJvC361o+HpEULlIB2CUXtv3XFsDGY7VZrWlIlZSkXrwdzx62a9WrM1I
    IvJAmlLYUzOReU0Qp7fXR3Lkyq893HWz0PsfYHI+DnRKYyCqGy6cyFBy+LfyRWag
    M5OB+XUGA5mFIubdLqPB4F5Wd4p+vMpOS3ALJD5TyoQEbg/SVbW51FgFavTKRU/0
    qjggV83LY6GXg/DBzQ8UI3ftbY6FcscBBs66NrjmFrvcfbZOiPdt+sZ4It2X+WQs
    nMaEcSr3tCwK2WHVr2nUv3syASab61zanTOYNYzERrwIcagBWkZ7cBKJqjQ==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=suse.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=suse.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNYWltlXSa03DbFV+TW/VWFoQoZ/OI9bZlLdLtRWUFU030u7J/2V2nYL+Fvk0RAsBduKIfgBM5kLO/VvecG53xQFiIR5VC/HdEdRwBYQCzZLIW1++RUf
    Wwr4f5B6REq3LU4MMpx1oIdgZZTbFKqf8jpUgXHwY9j/VtfKnIQlGgGKkAu3YI9fwytKBdNvdDhPfVBIcsr8F/sYL/J1VKRN/2yX9l2Yw+pQPUGZOyvf7GlI
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=iox4zFpeAAAA:8 a=HQ_B14XTsyJMtPaU2CgA:9 a=QEXdDO2ut3YA:10
    a=WzC6qhA0u3u7Ye7llzcV:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbeDQP6D (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 11:58:03 -0400
Received: from mx2.suse.de ([195.135.220.15]:36238 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751187AbeDQP6C (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 17 Apr 2018 11:58:02 -0400
Date: Tue, 17 Apr 2018 17:58:01 +0200
From: Jan Kara <jack@suse.cz>
To: Pavlos Parissis <pavlos.parissis@gmail.com>
Cc: Jan Kara <jack@suse.cz>, mszeredi@redhat.com, amir73il@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: kernel 4.14.x crash around fsnotify_mark_connector
Message-ID: <20180417155801.y4boo2nnoznn6sg6@quack2.suse.cz>
References: <e7323798-3175-3d27-fdd1-349f1422cb26@gmail.com>
 <20180417140231.75fi4ek2q77qilta@quack2.suse.cz>
 <3016af7f-97f0-e28d-96cd-e49fada3e88d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3016af7f-97f0-e28d-96cd-e49fada3e88d@gmail.com>
User-Agent: NeoMutt/20170421 (1.8.2)
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue 17-04-18 16:15:07, Pavlos Parissis wrote:
> On 17/04/2018 04:02 μμ, Jan Kara wrote:
> > On Tue 17-04-18 12:39:32, Pavlos Parissis wrote:
> >> In one of our production servers where we run kernel version 4.14.32, I noticed
> >> the following:
> > 
> > OK, I was looking into this for some time and couldn't find a problem in
> > 4.14.32 code. Can you try running a kernel with CONFIG_DEBUG_SLAB and
> > CONFIG_DEBUG_PAGEALLOC enabled to hopefully catch the problem earlier?
> > Thanks!
> > 
> 
> I can certainly do that, but I can't reproduce that specific crash. So,
> it may take days before we get a similar crash. Having said that, the
> soft lockup issue, which I mentioned in another thread, happens once per
> day, so I hope running a kernel with those debug settings will help you.

Yes, the hope is debug checks will trigger faster than the actual data
corruption (or softlockup) you've hit.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
