Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C323AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E8724018
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 14:46:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="ZIYw1rvr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E8724018
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753680AbeGEOqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 10:46:07 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:43559 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753353AbeGEOqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 10:46:06 -0400
Received: by mail-oi0-f67.google.com with SMTP id b15-v6so17325374oib.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 07:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+2YmyfrGSvDA6b30DNU6Pz84CKjEKGFGead64atq2nA=;
        b=ZIYw1rvrXdSWlWQ3YKkHdU1sbXiddWzQgqd3Sqb8ZnG44qGftZxqIT/3FqcsmgQmWR
         RY52utzNAk5z9glOkG/YbGTWSym0N1/IvUPM57zdJ6T3gRvdqBefWWOV43J/2w3RVycO
         mEV00ccP3oPh+x3GJSKslaBfgbd6VlFJVOOLocutPeC38jCRB3ZbRi4/cCKRmuoyG9wr
         uj0dmc1yGt3BYEnuJKw9z4YiQiBTMskLwEhbMn8/eDJvy1OH+aATZ3MkivwLd5ZhorFk
         y1DuSwLHr7g8ZrXgK/LX2dkLk2hPKlOpEPaCzoalRi3BURD/Sq2SBsjJJ5N4JYiQ1Iyi
         Whzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+2YmyfrGSvDA6b30DNU6Pz84CKjEKGFGead64atq2nA=;
        b=l5+5A0xme+zYC1wl6Jix8s3xntp4zkT5bU4V2gzHsI5MZN723VT8V1WcAywEgpAMa8
         tXLgW1afbpGjlLmyWT7Xz/dvHIPwZM+PRFPDyJwPf9J5NS8kUUgh2Kcxn0y8eaTEp9vv
         Y2WIAr42L4W1Um4iSUaYvQOIpsQhFncU2zxLmajP3mFaPVY+1ZXwK/hDSw5gkei+CWyC
         3BLm80cAJ6yQNxG7MGR0cxbNb3Whi49KJixvcbLVORGorC0MSwQb/v5M+z4Q+B78vWVn
         P5vmk3iiJy54cOmuG2SmXIwMYAi1/j7ycTX4J0D6r6PSzpgteYGiLtS85g6Kx+vdYApx
         oeLg==
X-Gm-Message-State: APt69E1q+xaUbHEljvH6XFjUesK7Mq/KrPXR2OIyhTy58PzZLgLyhgcI
        u76N5ULrzKyvQ9HNxNy3qhWYiAKKFPRK3aJNDYYScw==
X-Google-Smtp-Source: AAOMgpcqx6zlBIvtkw43SFg7S62cmru0EJ94J75FuGlom01xRkIWc69M3DDlRCCrRAN8flFfcPG+WRb3s0zbe5kINDc=
X-Received: by 2002:aca:5f56:: with SMTP id t83-v6mr7487841oib.115.1530801965640;
 Thu, 05 Jul 2018 07:46:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3495:0:0:0:0:0 with HTTP; Thu, 5 Jul 2018 07:46:05 -0700 (PDT)
In-Reply-To: <20180705082931.echvdqipgvwhghf2@linux-x5ow.site>
References: <153077334130.40830.2714147692560185329.stgit@dwillia2-desk3.amr.corp.intel.com>
 <153077341292.40830.11333232703318633087.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20180705082931.echvdqipgvwhghf2@linux-x5ow.site>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 5 Jul 2018 07:46:05 -0700
Message-ID: <CAPcyv4h1L6ZMCqWXhWD_ZJ=sH7SVzuUGMG2Ln=6Cy6sR4S=VUw@mail.gmail.com>
Subject: Re: [PATCH 13/13] libnvdimm, namespace: Publish page structure init
 state / control
To:     Johannes Thumshirn <jthumshirn@suse.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jeff Moyer <jmoyer@redhat.com>, Christoph Hellwig <hch@lst.de>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 5, 2018 at 1:29 AM, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> On Wed, Jul 04, 2018 at 11:50:13PM -0700, Dan Williams wrote:
>> +static ssize_t memmap_state_store(struct device *dev,
>> +             struct device_attribute *attr, const char *buf, size_t len)
>> +{
>> +     int i;
>> +     struct nd_pfn *nd_pfn = to_nd_pfn_safe(dev);
>> +     struct memmap_async_state *async = &nd_pfn->async;
>> +
>> +     if (strcmp(buf, "sync") == 0)
>> +             /* pass */;
>> +     else if (strcmp(buf, "sync\n") == 0)
>> +             /* pass */;
>> +     else
>> +             return -EINVAL;
>
> Hmm what about:
>
>         if (strncmp(buf, "sync", 4))
>            return -EINVAL;
>
> This collapses 6 lines into 4.

...but that also allows 'echo "syncAndThenSomeGarbage" >
/sys/.../memmap_state' to succeed.
