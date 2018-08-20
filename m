Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B94C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7461A21735
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aZvlBUAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7461A21735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726493AbeHTWu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 18:50:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43783 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbeHTWu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 18:50:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id f135-v6so11768025lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 20 Aug 2018 12:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AzWkE8n6146GGXKGkZkvxiS3oOclWa9uBB0aDqHRPNk=;
        b=aZvlBUAd4E+z/XY0mBxl9FwmP1s/wgICKDY3u7yN7vjKVp8zVNtoR5GVg9h4qeBlko
         5YuffRi1TgBwy7ut2E1R/GbrxT+1u5Vklo5BIhbQomwNF0rSeGVbNsTqV3eo0nclsQ14
         aZlia99KCbSE7OCDG1JD+yk8XpQvOHxIQ7TOQ2SDVeYUawoOMnikriMD+GYeUQt+JyhT
         Vfb/03CcQQFC7W0/brfK7BL9dyR2rKzZq4o6M0WE/EZY51eiN4nXpenL7bC3ZQHe42EC
         Q+P4angFh/jX7NoiZgIKh3IAu6ZCdYLQGyRAmcBZlEeLPPPEfpKFOV/wq9w45plCpx7G
         JvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AzWkE8n6146GGXKGkZkvxiS3oOclWa9uBB0aDqHRPNk=;
        b=oGw8BJ39n7YOxsN3M4pOinRfw92KCKRkxXV1xq1KpMQCZZZ2NMo7FPpvgxEuzQxIa1
         TSC78rhsrLB1cUb2P6l0bFd4vqF06f4hFZz+cdgQ46BxJVtt94oP7JWhopJZaDXFVq2O
         9ALo1AvPtotc8HKpDUNCJDaSkxWzcPEntBRMvUOmYVTz2dkzLhpVMUwNTzT1YKLA0Gbo
         vjWOArmuHVRmOR+FjatMboiwNDIYRhcnY02/PP24cyQE0YNoGvN+RT1aeMxUSuyaOgQV
         A4fsubKtF7zx5+02NmY6fz5P+27VP4odgMfRp+0GwJxZwVZeN2ZpHxuJp9plYPdW7OnK
         5Uxw==
X-Gm-Message-State: AOUpUlGkt9gH36wvu2rM3DPTz6wMiwUy6H9qhFxd8SJmpTxNf9Yhew1U
        XW5pXv8L6fD5bakPMIPOtIYCfM0E+SmLFFvmBslgmZ+H
X-Google-Smtp-Source: AA+uWPypiLNs79/QqMfr6TonpKBStgCjHn+vRZSJ4eVRDeGh0adm/0GPOHMWKgoL9nnOmCyDcqK02ZYGMByzg0dJGq8=
X-Received: by 2002:ac2:4141:: with SMTP id c1-v6mr6461936lfi.11.1534793641603;
 Mon, 20 Aug 2018 12:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <1534784987-16107-1-git-send-email-srikar@linux.vnet.ibm.com> <20180820192247.GA20101@kroah.com>
In-Reply-To: <20180820192247.GA20101@kroah.com>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Mon, 20 Aug 2018 12:33:50 -0700
Message-ID: <CAKdAkRT3OfvcvHdNC4Jn1RfM76TUHohcXVFDA0QfsSPdTW348Q@mail.gmail.com>
Subject: Re: [PATCH] kobject: Access kobject name with caution if state is not initialized
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     srikar@linux.vnet.ibm.com, lkml <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 20, 2018 at 12:22 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Aug 20, 2018 at 10:39:47PM +0530, Srikar Dronamraju wrote:
> > If kobject state is not initialized, then its not even certain that
> > kobject'name is initialized. Hence when accessing the kobject's name
> > tread carefully.
> >
> > A stupid module test like
> > https://github.com/srikard/tests/blob/master/modules/kobject_test.c
> > can panic the system.
>
> Lots of stupid modules can do dumb things.  Just don't do that.  The
> kernel is not built to keep you from doing stupid things in kernel code
> :)
>
> So I fail to see why this patch is needed.  What in-kernel code path is
> trying to print a kobject's name before it is initialized?  Why not fix
> that obvious bug instead of forcing the kernel core to protect from
> stupid code?

Kay decided to add some guards in:

commit 0f4dafc0563c6c49e17fe14b3f5f356e4c4b8806
Author: Kay Sievers <kay.sievers@vrfy.org>
Date:   Wed Dec 19 01:40:42 2007 +0100

   Kobject: auto-cleanup on final unref
...

+       if (!kobj->state_initialized) {
+               printk(KERN_ERR "kobject '%s' (%p): tried to add an "
+                      "uninitialized object, something is seriously wrong.\n",
+                      kobject_name(kobj), kobj);
+               dump_stack();
+               return -EINVAL;

Given that we have dump_stack() we can probably simply drop
kobject_name(kobj) instead of building even more elaborate checks. Or
just drop the whole check. Adding kobjects is somewhat uncommon
operation, plus "gabage in, garbage out".

Thanks.

-- 
Dmitry
