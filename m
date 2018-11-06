Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 865E5C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FA9520685
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 14:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCkTD4s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FA9520685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389029AbeKGAWm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:22:42 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56173 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388851AbeKGAWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:22:41 -0500
Received: by mail-wm1-f68.google.com with SMTP id s10-v6so11513838wmc.5;
        Tue, 06 Nov 2018 06:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Au5ScHTI2Gb+GmgJF7KkEGBz7R1QJ63Hu8hupGWNwrI=;
        b=rCkTD4s6V8qEzugDh4du9P3lmZpYz6eZAEN8QjcKb3c8YmNTYewiAhYNoMlK9Rih5A
         ASHiU7D9JEZXcvgGPgn1+pApEy6qZVS3PlJTIHYVdaHmH4wNR/h6uFGP92sFdtZk1Oh5
         H+oUOLY/OJgFSayZf/hYXiAiuuHerF0oTwywg0F32lGgitHFZTS1KonAaGFNok6KN3Xm
         0wSIW8XRKFrpidk9TvIohLsWSspEM8uZW9uTBn6RcXp650UyiJC4SNhqXMtv7QPN00bu
         wQ6CkLFcl7IXOCgJ69u4LbohFCju6tNTald+AOp+w2fCsWyTKhNpGVlOMg9KgRAUrLLG
         8Upg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Au5ScHTI2Gb+GmgJF7KkEGBz7R1QJ63Hu8hupGWNwrI=;
        b=C2TcK52jr6qdI8h4R63PzsbQnx9lJtWvuF9U2absGdFRGbkS/RJm99RoWuVtXTp+c0
         1hC7e7HWMQWSluFLb8HwMtPWTmOoNo+78eLsBPF7yb/3WnU1aD64BhyNqPmA+1XLHVho
         WIe9ZEyCfYRsKup0X9t4RIevpk7dwbvVoP3pmhXP/dzTsyL8NCM+NtUqoZqGx5hVIyyo
         U+FydOSBphJpPoj+6TBQy+A6BnYGfZp6j8pjswY309pz16Soh22EsHjuFr5cFRC95KTh
         Mz//KuT5z1BdjgN3agVVc0xo5TwamoxPZ8gbhA753avzQQZ8IFLFKTQ+7m5h9V/iKj2X
         arrw==
X-Gm-Message-State: AGRZ1gIOS8b5X2wdxAH4qNeYzLrzd1wVeTSdJbuCpZRkPCkfRgDwCppd
        gk8FtqFZrEGi3zbBg0+4c2svAZEsRzyzbvpzQkhZ8SIIl4c=
X-Google-Smtp-Source: AJdET5fszoblgGGggx0+twxZAfsx2STGgbfjo/E6KTxzezPpDP4CMUar+u5S2Qf56BaHLrQtCveaoGDcBJEPYmXpK5A=
X-Received: by 2002:a1c:e03:: with SMTP id 3-v6mr2251101wmo.13.1541516224588;
 Tue, 06 Nov 2018 06:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20181105102301.9752-1-jthumshirn@suse.de> <20181105105548.GC12367@ming.t460p>
 <7c649b43-f952-cf94-93d6-44fb153acced@suse.de> <20181105120153.GD12367@ming.t460p>
 <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
In-Reply-To: <3c3dd9c2-4240-7bb5-c0ff-af6f2e479c31@suse.de>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 6 Nov 2018 22:56:52 +0800
Message-ID: <CACVXFVNOAc1HEPmfu9n8vMjqY2hK8fVqe4Em-g+dvSRLavpO8w@mail.gmail.com>
Subject: Re: [PATCH] block: respect virtual boundary mask in bvecs
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 6, 2018 at 8:35 PM Johannes Thumshirn <jthumshirn@suse.de> wrote:
>
> On 05/11/2018 13:01, Ming Lei wrote:
> > If you mean the real huge page, this patch shouldn't have made a difference
> > because bio_vec->bv_offset is in [0, PAGE_SIZE), and iSer sets virt
> > boundary as 4K - 1.
> >
> > However, things will change after multipage bvec is introduced.
>
>
> Hi Ming,
>
> I've received a blktrace from our customer showing the issue [1].
>
> In this example trace they've submitted (contiguous) 64K I/Os and
> without this patch, they're seeing a lot of splits as indicated by the
> trace.
>
> With the patch applied the I/O is directly issued to the LLDD without
> the splits.
>
> [1] http://beta.suse.com/private/jthumshirn/blktrace.txt

blktrace won't help on this issue because .bv_offset isn't recorded.

This patch makes sense on >4KB PAGE_SIZE. If your issue happens on
ARCH with 4K PAGE_SIZE, maybe you should root cause why it makes a
difference on iSer. And it is highly possible there is bug somewhere.

As I mentioned, the description of huge page part in the commit log is
misleading,
and it has to be fixed. Otherwise, the patch itself is fine:

Reviewed-by: Ming Lei <ming.lei@redhat.com>

Thanks
Ming Lei
