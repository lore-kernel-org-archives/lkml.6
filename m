Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E8CEC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 331E3216FC
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 15:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="SJ2IRX3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331E3216FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbeI0WPD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 18:15:03 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44318 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727282AbeI0WPD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 18:15:03 -0400
Received: by mail-oi1-f193.google.com with SMTP id u74-v6so2584967oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 27 Sep 2018 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pcwHlhuTNn6bcbXxwdbtw3qezeIwUyXF8lUnTN92Rrw=;
        b=SJ2IRX3u5kLDI0UmAubfmtEnvEYL51DyZhZ0yUUgm9rE3fBnkxwSrZvl8XUgiAkhig
         yUvFFiiejqgLzfOnHGJwSu78h0LM9J+pLxwP6SsTmZrM3ZKNf5os+jxsm3+QVaitG24a
         wuPVTewPG/VXh4KVXAEllCYW6PeuwZ1l4jo6szqymIXKcO798fOrAIwaByBZeXvuTHVo
         433Kwjh63BxuM0V/xb4wbrtQ5A0CNJ0kjZOQFDLG9AUohd9wEvvkPaqB2ntg+xyBUI11
         cixjFCszpSCVTBhnGQJp22VCjkXY3u/4FLFIf25vDOHNS+/ITx39LeA0Gz6F48waVI1S
         Es3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcwHlhuTNn6bcbXxwdbtw3qezeIwUyXF8lUnTN92Rrw=;
        b=M4qAGmBW/Nzay77xGYTu2Z0E2VFdobQ3us8Y3Z0wpCXzbjCbpEcXaO53pJ5W2FsBH8
         y0iAA3l2SAjhE2nuhGaccU9JW8FL6Nlz953qunM3SC0fUUoGu1V++1FuRf8qOKr0BPUW
         hYx0eW6QnuDhvm+A7pyLqOoLT964cBT7lLOJq9kUF2EFjnI5fTg1htsSyhRHZKIOQJE8
         L/4sjDlLJu6J8AOT1aVH7ZCOBuv9EOFIwx2XgVJYCoJ9oBVXFi771+k4pQvxZ9a2KrnT
         6dxsiWKYb9DPoh7YDk1KWWcaTAyuOA8aJqBxGp+u3m03sF0tspV/2UJFbwSZl6eFnxI3
         /Ajw==
X-Gm-Message-State: ABuFfogCQ2tZlJskxy7a0g64B21zW2hD/yrrVs+ru0lZXlL9Bv3o/n0O
        45LomeZY1Ivh739CE7Efg+6BX8J20lRkhcHFY1CkQQ==
X-Google-Smtp-Source: ACcGV622D5qJgQbq6RO9giQIxjzUWcPVPXb7qMHJR4X6Ek+0byWO6F8S2j14BVFHvkBoxiuuts+wxsxx7mrDSNwElpY=
X-Received: by 2002:aca:dc55:: with SMTP id t82-v6mr3254202oig.159.1538063768336;
 Thu, 27 Sep 2018 08:56:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180831133019.27579-1-pagupta@redhat.com> <20180831133019.27579-4-pagupta@redhat.com>
 <CAPcyv4gy-ONZz=PnXN92xYnyRX0rhu7Oq-_jPWJekbYQjNKRiw@mail.gmail.com>
 <1204243972.15515798.1537782119951.JavaMail.zimbra@redhat.com> <435471901.16563045.1538053600799.JavaMail.zimbra@redhat.com>
In-Reply-To: <435471901.16563045.1538053600799.JavaMail.zimbra@redhat.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 27 Sep 2018 08:55:56 -0700
Message-ID: <CAPcyv4gvPhi4oe-KOo1HH+QbE-9whOvP7TypDshbbx3XZXh9=A@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-pmem: Add virtio pmem driver
To:     Pankaj Gupta <pagupta@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        Qemu Developers <qemu-devel@nongnu.org>,
        linux-nvdimm <linux-nvdimm@ml01.01.org>, Jan Kara <jack@suse.cz>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Nitesh Narayan Lal <nilal@redhat.com>,
        Kevin Wolf <kwolf@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Zwisler, Ross" <ross.zwisler@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        niteshnarayanlal@hotmail.com, lcapitulino@redhat.com,
        Igor Mammedov <imammedo@redhat.com>,
        Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 27, 2018 at 6:07 AM Pankaj Gupta <pagupta@redhat.com> wrote:
[..]
> > We are plugging VIRTIO based flush callback for virtio_pmem driver. If pmem
> > driver (pmem_make_request) has to queue request we have to plug "blk_mq_ops"
> > callbacks for corresponding  VIRTIO vqs. AFAICU there is no existing
> > multiqueue
> > code merged for pmem driver yet, though i could see patches by Dave upstream.
> >
>
> I thought about this and with current infrastructure "make_request" releases spinlock
> and makes current thread/task. All Other threads are free to call 'make_request'/flush
> and similarly wait by releasing the lock.

Which lock are you referring?

> This actually works like a queue of threads
> waiting for notifications from host.
>
> Current pmem code do not have multiqueue support and I am not sure if core pmem code
> needs it. Adding multiqueue support just for virtio-pmem and not for pmem in same driver
> will be confusing or require alot of tweaking.

Why does the pmem driver need to be converted to multiqueue support?

> Could you please give your suggestions on this.

I was expecting that flush requests that cannot be completed
synchronously be placed on a queue and have bio_endio() called at a
future time. I.e. use bio_chain() to manage the async portion of the
flush request. This causes the guest block layer to just assume the
bio was queued and will be completed at some point in the future.
