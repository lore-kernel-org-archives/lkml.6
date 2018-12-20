Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72C0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADBFF2084A
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 01:42:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="LuOmXq33"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728792AbeLTBmI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Dec 2018 20:42:08 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34269 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728088AbeLTBmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Dec 2018 20:42:08 -0500
Received: by mail-ot1-f66.google.com with SMTP id t5so125823otk.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Dec 2018 17:42:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=8DJJ6tfz00WAjl0f+jqJpkoVPa0HFPmtJlksB3R29LA=;
        b=LuOmXq33ikXaxXL1zqCKyGG8E8xoy2pw4lmUW61vwi5PSmdX8YElH+DX68x2DOGSjy
         UuF6I2wZNl+RSuhv4kbhi+fWXUezEfDihsDMmyiXb0Sb3aP3t8bRLWzmUTu8AIZjanHF
         zyKL7RGMaYalNVKUlZ0oZfZaUQAoHagTWaF9I+BgblR1TJOlnll/plvV69+EhiFEUlHl
         X/5DjUquQKPettwqv0XPo3U0opfUyv0ea/pcgoDvESrBST31eekmr99eJNSXy7dXQuBx
         xE4BTOI019vB6tsXfsUz06qZd31KcaJ9xbIwHDgaXMpZdcjj3xXj89PSm76cMAUjXrLW
         n82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=8DJJ6tfz00WAjl0f+jqJpkoVPa0HFPmtJlksB3R29LA=;
        b=kbLiovjUI1VBpbNF2da2XMlfoBPdbIUl4V96dtLWNoi2Pr8V2zKDk7Gk5GFPm8Q7ww
         jkh6V71zmmSaFpD2qUTiFtI8iNwu3DoJAd5RMpSQTBVlF4higo3zJU+S9/aD3b/keN5Z
         Nph7geNHuJxo6FXRqzTfQwNqB2te+TC7ZoY4jbXxcoJLgoGbOUKSlErid+5HmVd8UUiA
         gEFIcs+dOSkF6OqlmvnVqdCoR0xLybJhRkcXX/oSZLVH4ABUrcfYTOgg+Ba9x87D7Epf
         Dm2aZddW0bFsHfH8ao2+1APNA6h3jEmDOak8tbb41XtHcjZzNaVpaC5Rr6bR2WLKtkUt
         JkBQ==
X-Gm-Message-State: AA+aEWbD2ssr6Vj4cGPRiWLHQgK22FuWZmMlv9c1uIubUfSb25/hlKDa
        GF46kiZSGRMKYsHON5mCvBJFpbXYmvdHj6glaGNmxw==
X-Google-Smtp-Source: AFSGD/VGJwGUFSGFABAHN4/jU2foKwgE2+mzrBcyjUfX//gHpjiEKtonZJrhpVpuZZasDpeoy9gNJ4lsNpfd3TFSqFM=
X-Received: by 2002:a9d:5cc2:: with SMTP id r2mr16726508oti.367.1545270127114;
 Wed, 19 Dec 2018 17:42:07 -0800 (PST)
MIME-Version: 1.0
References: <46441800c43f029757c70d8386e3112701081503.1534160958.git.yi.z.zhang@linux.intel.com>
 <1534787638.13739.52.camel@intel.com> <89e7bd54-4afa-614d-ec54-49af7928d6c7@intel.com>
 <20180821161657.GA22028@tiger-server> <CAPcyv4gZ8WBhUZkoUd1m6bCrtKW0EmfWfCtpGULvjfM=yJ9_sg@mail.gmail.com>
 <20181213061239.GA43404@tiger-server>
In-Reply-To: <20181213061239.GA43404@tiger-server>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 19 Dec 2018 17:41:56 -0800
Message-ID: <CAPcyv4iYEqrm49Nx78Ax+KaU2CqoZPxaQDQeqCxYzE+PHofr=w@mail.gmail.com>
Subject: Re: [PATCH V2 1/1] device-dax: check for vma range while dax_mmap.
To:     Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>, zwisler@kernel.org,
        Jan Kara <jack@suse.cz>, "Zhang, Yi Z" <yi.z.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 10:12 PM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
>
> On 2018-12-10 at 16:10:31 -0800, Dan Williams wrote:
> > On Tue, Aug 21, 2018 at 12:38 AM Yi Zhang <yi.z.zhang@linux.intel.com> wrote:
> > >
> > > On 2018-08-20 at 12:50:31 -0700, Dave Jiang wrote:
> > > >
> > > >
> > > > On 08/20/2018 10:53 AM, Verma, Vishal L wrote:
> > > > >
> > > > > On Mon, 2018-08-13 at 20:02 +0800, Zhang Yi wrote:
> > > > >> This patch prevents a user mapping an illegal vma range that is larger
> > > > >> than a dax device physical resource.
> > > > >>
> > > > >> When qemu maps the dax device for virtual nvdimm's backend device, the
> > > > >> v-nvdimm label area is defined at the end of mapped range. By using an
> > > > >> illegal size that exceeds the range of the device dax, it will trigger a
> > > > >> fault with qemu.
> > > > >>
> > > > >> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> > > > >> ---
> > > > >>  drivers/dax/device.c | 29 +++++++++++++++++++++++++++++
> > > > >>  1 file changed, 29 insertions(+)
> > > > >>
> > > > >
> > > > > Looks good to me:
> > > > > Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> > > >
> > > > Applied.
> > > Thanks Dava and Vishal's kindly review. Thank you.
> >
> > So, it turns out this patch did not get merged for 4.20. I fumbled it
> > when returning from vacation. However, I'm not sure it is needed. As
> > long as attempts to access the out-of-range capacity results in SIGBUS
> > then the implementation is correct. This is similar to the case where
> > a file is truncated after the vma is established. That size is
> > validated at fault time.
> The problem is that we didn't get the fault at we initial the mapping
> until attempt to access it, then qemu will failed unexpect without any
> output, I think is is better to mention user that we are starting at a
> illegal size, but not faulting at an uncertained time.

That can always happen with mmap'd files. There is no guarantee that a
file range an application successfully mmap'd can be faulted in
without triggering a SIGBUS later. So this change would make
device-dax semantics stricter than regular file semantics. For example
the following program prints "map: pass" and then terminates with
SIGBUS. The "test_data" file is a zero sized file.

int main(void)
{
        int fd = open("test_data", O_RDWR);
        void *addr;

        if (fd < 0)
                return -1;

        addr = mmap(NULL, 1 << 20, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
        printf("map: %s\n", addr == MAP_FAILED ? "fail" : "pass");

        *(char *) addr = 0;

        return 0;
}
