Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DB2C070C3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:51:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0978A20C0A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 21:51:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="vuKI0UDo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0978A20C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbeIMC6W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 22:58:22 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:42050 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726176AbeIMC6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 22:58:22 -0400
Received: by mail-oi0-f68.google.com with SMTP id v198-v6so6802678oif.9
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 14:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ALkFOeQ37im8L8uAn9HDwcS95BLXMFaKckpLjG311BE=;
        b=vuKI0UDoho+gl4aLm0EWR5GRcw470jirBxA+OlnuAU0hws1+TvW7J0AIeAjS2DhiFq
         nw/hnlyPWYKOyNOAaBGotp3XZjzDFDV3/IgUeR5f3g9+KTPEWVgDPA6OrFSTmtPTM3t0
         kqIMjbPasl2UAhJ84mKrJeKnc4CFRKyHXrYU45nL3DL7uefCJo040tZsgZDj9432zmWc
         CIoj/8OeFOQ2FDxluSjgD+JxjqYtoH6nhaoEuPG/x8evB3y1Iz0sDneO8HKp4owLbd/t
         c9yri5phbjfPh9uVn7B++yWUw4r/Of5wUPPkAoV0NjRJ5OefyC2t5yKfC+yERSdYeeb/
         pzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ALkFOeQ37im8L8uAn9HDwcS95BLXMFaKckpLjG311BE=;
        b=ap6PkwH8WJqHYMDaS+Umuo65V4xcdFh7vo7UIHbPXwgTYvrXVM4qlLsPH1cxZNeebS
         v7gWRsOYAczwxu0+Aqqk0FGS3elULVvrpkoCF5fLZ7+ZW8G3H4+WXpc8dMCl0YzCztvq
         pJS9J80u6H/zbVb9bFLZ6SpY8k8H39DvQ4vgNP4XnhaHUSwfMGR0KQNdrL6jBepCjnzJ
         29PVJ+SrbSwNbiGDwzIaO/1p2WjRWOugbrBC5rGkbD7XiGdFbfyJ9phA3A7vOKonszkA
         5BGGFRxiEkMybDFgzHTNsLNL6pJvUtHsGFph8iAuRb53xPVprtqt1WftWNOiWF3RZx24
         x3zg==
X-Gm-Message-State: APzg51DWMBjHmZE17860GLq1IpMA78g6tPac/vWZOelBiPywaMriZMgm
        kpzoYHFTb7uoOdGFI8W6VI9x+t1H3rAZ0HRVTMbvfA==
X-Google-Smtp-Source: ANB0VdYzmmHJg5K3u+mgQCxse82vVbw1Nwsi8BvcKHMkL0bvFeY0wnB/tCnQ08xvwPTcaR9YkGd8ukNMEMA1jmlv35Q=
X-Received: by 2002:aca:4507:: with SMTP id s7-v6mr3963645oia.200.1536789113724;
 Wed, 12 Sep 2018 14:51:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 14:51:53
 -0700 (PDT)
In-Reply-To: <20180912074850.GA362@kroah.com>
References: <153617950046.33664.13445188581267552601.stgit@djiang5-desk3.ch.intel.com>
 <20180912074850.GA362@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Sep 2018 14:51:53 -0700
Message-ID: <CAPcyv4j9CooFiUpJnQvp2tP26u_Sys4AP4JmGtNBZf5R5ug8xg@mail.gmail.com>
Subject: Re: [PATCH] uio: fix is_source param for check_copy_size() in copy_to_iter_mcsafe()
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Du, Fan" <fan.du@intel.com>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 12:48 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Sep 05, 2018 at 01:31:40PM -0700, Dave Jiang wrote:
>> copy_to_iter_mcsafe() is passing in the is_source parameter as "false"
>> to check_copy_size(). This is different than what copy_to_iter() does.
>> Also, the addr parameter passed to check_copy_size() is the source so
>> therefore we should be passing in "true" instead.
>>
>> Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
>> Cc: Fan Du <fan.du@intel.com>
>> Reported-by: Wenwei Tao <wenwei.tww@alibaba-inc.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
>> Cc: stable <stable@vger.kernel.org>
>> ---
>>  include/linux/uio.h |    2 +-
>
> I am not the maintainer of this file, sorry, please work with the -mm
> developers for this.

Likely this is get_maintainer.pl's fault:

$ ./scripts/get_maintainer.pl  -f include/linux/uio.h
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:USERSPACE I/O (UIO))
linux-kernel@vger.kernel.org (open list)

Maybe a MAINTAINERS update like the following is warranted, because I
don't think -mm developers are right either, Al seems to be authority
on iov_iter apis:

diff --git a/MAINTAINERS b/MAINTAINERS
index d870cb57c887..0018e19b4d8e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15344,13 +15344,18 @@ F:    arch/x86/um/
 F:     fs/hostfs/
 F:     fs/hppfs/

+USERSPACE ACCESS (uaccess, copy_{to,from}_iter)
+M:     Alexander Viro <viro@zeniv.linux.org.uk>
+S:     Maintained
+F:     include/linux/uio*.h
+F:     lib/iov_iter.c
+
 USERSPACE I/O (UIO)
 M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 S:     Maintained
 T:     git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
 F:     Documentation/driver-api/uio-howto.rst
 F:     drivers/uio/
-F:     include/linux/uio*.h

 UTIL-LINUX PACKAGE
 M:     Karel Zak <kzak@redhat.com>

---

In any event, the patch in question is a trivial one liner, I feel
confident sending it along to Linus with some other pending fixes.
