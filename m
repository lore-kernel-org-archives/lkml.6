Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CFEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DFAD217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 10:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AawJCJ67"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfBZKBG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 05:01:06 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37779 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbfBZKBG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 05:01:06 -0500
Received: by mail-pf1-f195.google.com with SMTP id s22so6006334pfh.4;
        Tue, 26 Feb 2019 02:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=eU4SrHrTD4l1C+c+Qp24wQHg+cUFF4vnAb/JtJYtZh4=;
        b=AawJCJ673fwccZpi/k3chFhsrXKs6IZH4rX1IgAlYKNTO8/2VlKLLxYwR7yBImduCM
         gNELots6NOZKa/sxo+f/fUH6XJkqNEWTJy5tEDyRNVPXuMSmpUIjre8lt0wAzwnoYJsy
         Xjli+IdQVP9QdJCsQNhZodUTZUzXt2aU4IOwE/VuliEhdrgjtiGUK2WCCDfFD142rGKI
         FIPzznupH+uM04PoAIONImgjnNDmLf/idyEN9WqJfJVHe3QIqX265Adr+hRilgOE5WZD
         5RpMt3klwk1N8ggBbRTfyBwDSMunOTLvhkPceK1yzxq8B0Oi+BDRPN/PJMQ/7WSzTjGN
         dJnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=eU4SrHrTD4l1C+c+Qp24wQHg+cUFF4vnAb/JtJYtZh4=;
        b=o8UviOBNzufrGqWMB6kBmOFtYVHsI6RbrIkFvmPpfzktm57McZ/etZl4Qw2g0ibVj6
         3D3+MnmvlhajpLgEum4PAFIFHctYZmYIYdZANQu8Baz8jA2KNWdBda+GXNoz6Ai56lz7
         F9f6DJkdro76w7WaIjN+CvuDsdLYAfrW4sbVJqZ0HcWIoaxaWwqC1BMqBWx0m8nQBSvM
         DqwhieAcEBCQB+zdPCiUJsMahaPQgGbAKPuoWnz2VK4Z/rcCp34qHa2F2BYnf09PtmQS
         /pdDDhjBsNVENQnw0Ze/iM2thN2JzFPg5xdCUWBjTiNywg6anOaYG6h7V5uHCriil9jJ
         l48w==
X-Gm-Message-State: AHQUAuYI8gumO1rF7574mrCZjIG/kHR2e0dU1z0MsT5IPFpd91gs+CPm
        tbZqPloneNlJUuO0sk9ikqwiszZ8
X-Google-Smtp-Source: AHgI3IY5R83RsyvDFX6uq2Qm7m6heae7/qwXSu+pJLM81cqcPMOPNRacBjvm7oOsCie0tx8xifVyIw==
X-Received: by 2002:a63:dc54:: with SMTP id f20mr23807975pgj.410.1551175264723;
        Tue, 26 Feb 2019 02:01:04 -0800 (PST)
Received: from localhost ([43.224.245.180])
        by smtp.gmail.com with ESMTPSA id e8sm7698005pfn.103.2019.02.26.02.01.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 02:01:04 -0800 (PST)
Date:   Tue, 26 Feb 2019 18:01:02 +0800
From:   Geliang Tang <geliangtang@gmail.com>
To:     Coly Li <colyli@suse.de>,
        Kent Overstreet <kent.overstreet@gmail.com>
Cc:     linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] bcache: use kmemdup_nul for CACHED_LABEL buffer
Message-ID: <20190226100102.GA10363@OptiPlex>
References: <04ff7c6d5cdd8b389d471989704c2f9dc3def554.1548840161.git.geliangtang@gmail.com>
 <04ebd070-3c9c-0cd4-f2d8-d7b078ea2582@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04ebd070-3c9c-0cd4-f2d8-d7b078ea2582@suse.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 04:37:36PM +0800, Coly Li wrote:
> On 2019/1/30 5:29 下午, Geliang Tang wrote:
> > This patch uses kmemdup_nul to create a NUL-terminated string from
> > dc->sb.label. This is better than open coding it.
> > 
> > With this, we can move env[2] initialization into env[] array to make
> > code more elegant.
> > 
> > Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> 
> Hi Geliang,
> 
> In general I am OK with your idea. But I feel there might be some
> regression with your change. I comment your patch in line, correct me if
> I am wrong.
> 
> 
> > ---
> >  drivers/md/bcache/super.c | 10 ++++------
> >  1 file changed, 4 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
> > index 4dee119c3664..84ab241c8516 100644
> > --- a/drivers/md/bcache/super.c
> > +++ b/drivers/md/bcache/super.c
> > @@ -906,21 +906,18 @@ static int cached_dev_status_update(void *arg)
> >  void bch_cached_dev_run(struct cached_dev *dc)
> >  {
> >  	struct bcache_device *d = &dc->disk;
> > -	char buf[SB_LABEL_SIZE + 1];
> > +	char *buf = kmemdup_nul(dc->sb.label, SB_LABEL_SIZE, GFP_KERNEL);
> 
> If kdumdup_null() is failed, buf will be NULL.
> 
> >  	char *env[] = {
> >  		"DRIVER=bcache",
> >  		kasprintf(GFP_KERNEL, "CACHED_UUID=%pU", dc->sb.uuid),
> > -		NULL,
> > +		kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf ? : ""),
> 
> If buf is NULL, env[2] here is pointed to "" which is allocated in
> read-only data segment, and not a dynamic memory.

Hi Coly,

Sorry for my late reply.

If buf is NULL, env[2] is kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", "");
In this case, env[2] is also a dynamic memory, a string like this, "CACHED_LABEL=".
So we can use kfree() to free it. There is no problem.

And here is a test case:

$ cat test.c 
#include <linux/init.h>
#include <linux/module.h>
#include <linux/slab.h>

static int __init test_init(void)
{
	char *env = kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", "");
	pr_info("env = [%s]\n", env);
	kfree(env);
	return 0;
}

static void __exit test_exit(void)
{
}

module_init(test_init);
module_exit(test_exit);

MODULE_LICENSE("GPL");

$ sudo insmod test.ko
$ dmesg
[ 3026.072298] env = [CACHED_LABEL=]
$ sudo rmmod test

Thanks.

-Geliang

> 
> >  		NULL,
> >  	};
> >  
> > -	memcpy(buf, dc->sb.label, SB_LABEL_SIZE);
> > -	buf[SB_LABEL_SIZE] = '\0';
> > -	env[2] = kasprintf(GFP_KERNEL, "CACHED_LABEL=%s", buf);
> > -
> >  	if (atomic_xchg(&dc->running, 1)) {
> >  		kfree(env[1]);
> >  		kfree(env[2]);
> 
> Then kfree() here will try to release a read-only memory segment. I
> guess this is problematic.
> 
> > +		kfree(buf);
> >  		return;
> >  	}
> >  
> > @@ -944,6 +941,7 @@ void bch_cached_dev_run(struct cached_dev *dc)
> >  	kobject_uevent_env(&disk_to_dev(d->disk)->kobj, KOBJ_CHANGE, env);
> >  	kfree(env[1]);
> >  	kfree(env[2]);
> 
> Same problem might happen here for env[2].
> 
> > +	kfree(buf);
> >  
> >  	if (sysfs_create_link(&d->kobj, &disk_to_dev(d->disk)->kobj, "dev") ||
> >  	    sysfs_create_link(&disk_to_dev(d->disk)->kobj, &d->kobj, "bcache"))
> > 
> 
> 
> -- 
> 
> Coly Li

