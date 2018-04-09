Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+lq6f3RhswHa7fkoTKX0oGKpj9RqFQkLiLv2ZFhs1jhD5LwH9c9101IVCgwnv367CLijT0
ARC-Seal: i=1; a=rsa-sha256; t=1523262112; cv=none;
        d=google.com; s=arc-20160816;
        b=1K76DK8URj+kOj+tVFUk6dUnNhurCzAUVnBLioH7zwNaMTy2d+Rl3LK+Ie+Dnw4xqP
         BaBCe0qHKjgBX2annKI3hnx0VtMg0IV51M2IxHOzDMQdHMjtFJCzSpJkaYqzJ3sJy1ZE
         i0Fa+FMAbIJ4lwe98/lm8lexVcxtvdMvoj+DYQJAgBSDQfe7uGVhJBDC+WJxdieO+NNw
         WSo9YpF1nAnGX7EYnSsf78jBWumg8ARyk+mbqnKq/SV1lxJUtH8Snv4Fc1kLo5DrDCqm
         iXvKicc1PTfEePij49EjA2xgmBAGaqSVi1yO4PugWaCGhSnvaqsB5olEfnxkmY/tmMUp
         Typw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:user-agent:in-reply-to
         :content-transfer-encoding:content-disposition:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :dkim-signature:arc-authentication-results;
        bh=RDVz3lRMd5G/L05AEvIIWRzvvLiwW9QoNzufRonPE28=;
        b=iJrm+nz/ZtTWeMxJxmgRYLLnPk2i77XDpq9B8cwfZwJVDtYsCGrqWtFl4D/IqfS/Ql
         yNkRPcKa7lrnRbI4JcLIJrOC/RV13Nhq2ZP/AJm3C2Nkh5TBzxzkAfA7WX3fjVXag6Qu
         6n/vFlDNbVyMVc30fQifYSNQY576YlbBvDd1xbOcc2erP5TybjAURVagB3uhjnl0UIiL
         NaLeo7wTMPfJQrZj6XeDgLxhd9nTxAWhCB1L2WWDr+500m3zrzocwNAkNIO6EckxQb7Y
         FYGBzmFCTry/2xoPCuQyEDCoKRMuI/sO/M5UqU2LzqjYDFSicq27VO6fD0JjH/jDMFXs
         Cyjw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@ffwll.ch header.s=google header.b=J8g9Kn+Q;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       dkim=neutral (body hash did not verify) header.i=@ffwll.ch header.s=google header.b=J8g9Kn+Q;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbeDIIVh (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 9 Apr 2018 04:21:37 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:39090 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751688AbeDIIVf (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 9 Apr 2018 04:21:35 -0400
Date: Mon, 9 Apr 2018 10:21:31 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>,
        qemu-devel@nongnu.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK"
        <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK"
        <linux-kselftest@vger.kernel.org>, Shuah Khan <shuah@kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK"
        <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2] Add udmabuf misc device
Message-ID: <20180409082131.GF31310@phenom.ffwll.local>
Mail-Followup-To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Gerd Hoffmann <kraxel@redhat.com>, dri-devel@lists.freedesktop.org,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        David Airlie <airlied@linux.ie>,
        open list <linux-kernel@vger.kernel.org>, qemu-devel@nongnu.org,
        "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>
References: <20180316074650.5415-1-kraxel@redhat.com>
 <7547e99b-0e3c-264e-e52b-40ad5d52b49a@gmail.com>
 <20180406093307.s7wkhpmddd5d4r7a@sirius.home.kraxel.org>
 <5d88baad-a956-6bd5-e0d6-aabae6647f3e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d88baad-a956-6bd5-e0d6-aabae6647f3e@amd.com>
X-Operating-System: Linux phenom 4.15.0-1-amd64 
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595079572079958094?=
X-GMAIL-MSGID: =?utf-8?q?1597256092668873071?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 06, 2018 at 02:24:46PM +0200, Christian König wrote:
> Am 06.04.2018 um 11:33 schrieb Gerd Hoffmann:
> >    Hi,
> > 
> > > The pages backing a DMA-buf are not allowed to move (at least not without a
> > > patch set I'm currently working on), but for certain MM operations to work
> > > correctly you must be able to modify the page tables entries and move the
> > > pages backing them around.
> > > 
> > > For example try to use fork() with some copy on write pages with this
> > > approach. You will find that you have only two options to correctly handle
> > > this.
> > The fork() issue should go away with shared memory pages (no cow).
> > I guess this is the reason why vgem is internally backed by shmem.
> 
> Yes, exactly that is also an approach which should work fine. Just don't try
> to get this working with get_user_pages().
> 
> > 
> > Hmm.  So I could try to limit the udmabuf driver to shmem too (i.e.
> > have the ioctl take a shmem filehandle and offset instead of a virtual
> > address).
> > 
> > But maybe it is better then to just extend vgem, i.e. add support to
> > create gem objects from existing shmem.
> > 
> > Comments?
> 
> Yes, extending vgem instead of creating something new sounds like a good
> idea to me as well.

+1 on adding a vgem "import from shmem/memfd" ioctl. Sounds like a good
idea, and generally useful.

We might want to limit to memfd though for semantic reasons: dma-buf have
invariant size, shmem not so much. memfd can be locked down to not change
their size anymore. And iirc the core mm page invalidation protocol around
truncate() is about as bad as get_user_pages vs cow :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
