Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7415C07520
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:02:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 756E92133F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 22:02:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="wD0iz80w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 756E92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728068AbeIMDJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 23:09:27 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:35494 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbeIMDJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 23:09:27 -0400
Received: by mail-oi0-f66.google.com with SMTP id m11-v6so6912051oic.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 15:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=or5SJx6rQudOsf9JcAvzAs0Mtqt3Vh+6b1ypOUavq4E=;
        b=wD0iz80wRGstvqjnsP9Q9RshsNUCt4y2WKwzsMnfU+fxx2GoGY1G4E72FQjO7K92qb
         JYPRc/sVmITViqTUos9DVsxrHZcPDOykLcUie19ta2lh+c/zafmMZAqY9/WaAZ3HZ4G6
         ZxfN7W+U1d8HNWlM5IVq/1xOt+5MKSa2qsJgmDAWPjBGip+G+vmKILyB1nqyAyoLg1zV
         2SD7aI+tLg4Vdqu9jEM05tCycgDXUDEgKYpEM18jNuPA2vP1gjvRa/BfxohXjl6H566y
         +lY7arLo8L7ArVS6TCj/zS7PgkkZZLu/OjIavz+AUJ/XX2f1mErUeIbEYXg05kbj3PWM
         CTJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=or5SJx6rQudOsf9JcAvzAs0Mtqt3Vh+6b1ypOUavq4E=;
        b=Wc3NPLy1HJw6Ufzef0gXbiYmXg/yMX8LhfYvWpUavPnwBx0eZOKLvVgw7jcRd+5fdp
         LWxkOG4NQ0aaAHa1oG26M9EB5yVZEHnmHh+0moa53fk+ZQhdtg8a+R3UEKkxzGejbDSu
         +tqUilpSnJ/vxU1aIg670Sk6UcyrU8SPFB7ut+0aeRB0LLpMNe9DcBz521ZFOAZNogMG
         mG2GbuC7qw3o/VD5bqntXFe2aOnkVpvs9ihqWtYo5dWgDvce1bFw+c/r4RDYmBoTRuo/
         QTscdqBFNXIZD/toIjunqGNxuHTNGPuX9NNtAs+znBBgM8ozX8jON5Ktt9vH3BRJqbNf
         jdAg==
X-Gm-Message-State: APzg51D9OdvXX6x9oxCGROk2COYN7zlK0rZm+yGWUw+hhRI3oP/VbGji
        7gg3bfMENAU4qDXI+C58c+VzY8VQnDoxopVQWFMXKQ==
X-Google-Smtp-Source: ANB0VdYkT58b1Ek0gBpRFnCuWZVmwhySRevff+kVcGF1J2i0Trjk8FCRQ0mtmwxvlGD/Zitl0FhRTwKpDMur3jFo+7o=
X-Received: by 2002:aca:4083:: with SMTP id n125-v6mr3953132oia.167.1536789776903;
 Wed, 12 Sep 2018 15:02:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:8e85:0:0:0:0:0 with HTTP; Wed, 12 Sep 2018 15:02:56
 -0700 (PDT)
In-Reply-To: <20180912215759.GA3000@kroah.com>
References: <153617950046.33664.13445188581267552601.stgit@djiang5-desk3.ch.intel.com>
 <20180912074850.GA362@kroah.com> <CAPcyv4j9CooFiUpJnQvp2tP26u_Sys4AP4JmGtNBZf5R5ug8xg@mail.gmail.com>
 <20180912215759.GA3000@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 12 Sep 2018 15:02:56 -0700
Message-ID: <CAPcyv4ju1v1fw2KQdq_xEToUjgqzTuVf+LPbksMgp+vUOtD_8w@mail.gmail.com>
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

On Wed, Sep 12, 2018 at 2:57 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
> On Wed, Sep 12, 2018 at 02:51:53PM -0700, Dan Williams wrote:
>> On Wed, Sep 12, 2018 at 12:48 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
>> > On Wed, Sep 05, 2018 at 01:31:40PM -0700, Dave Jiang wrote:
>> >> copy_to_iter_mcsafe() is passing in the is_source parameter as "false"
>> >> to check_copy_size(). This is different than what copy_to_iter() does.
>> >> Also, the addr parameter passed to check_copy_size() is the source so
>> >> therefore we should be passing in "true" instead.
>> >>
>> >> Fixes: 8780356ef630 ("x86/asm/memcpy_mcsafe: Define copy_to_iter_mcsafe()")
>> >> Cc: Fan Du <fan.du@intel.com>
>> >> Reported-by: Wenwei Tao <wenwei.tww@alibaba-inc.com>
>> >> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> >> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
>> >> Cc: stable <stable@vger.kernel.org>
>> >> ---
>> >>  include/linux/uio.h |    2 +-
>> >
>> > I am not the maintainer of this file, sorry, please work with the -mm
>> > developers for this.
>>
>> Likely this is get_maintainer.pl's fault:
>>
>> $ ./scripts/get_maintainer.pl  -f include/linux/uio.h
>> Greg Kroah-Hartman <gregkh@linuxfoundation.org> (maintainer:USERSPACE I/O (UIO))
>> linux-kernel@vger.kernel.org (open list)
>>
>> Maybe a MAINTAINERS update like the following is warranted, because I
>> don't think -mm developers are right either, Al seems to be authority
>> on iov_iter apis:
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index d870cb57c887..0018e19b4d8e 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -15344,13 +15344,18 @@ F:    arch/x86/um/
>>  F:     fs/hostfs/
>>  F:     fs/hppfs/
>>
>> +USERSPACE ACCESS (uaccess, copy_{to,from}_iter)
>> +M:     Alexander Viro <viro@zeniv.linux.org.uk>
>> +S:     Maintained
>> +F:     include/linux/uio*.h
>> +F:     lib/iov_iter.c
>> +
>>  USERSPACE I/O (UIO)
>>  M:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>  S:     Maintained
>>  T:     git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
>>  F:     Documentation/driver-api/uio-howto.rst
>>  F:     drivers/uio/
>> -F:     include/linux/uio*.h
>
> Don't drop that line, uio_driver.h is what it should just say, right?
>

Ah, yep, I missed that. Thanks.
