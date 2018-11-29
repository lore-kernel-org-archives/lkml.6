Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EFBC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E84F02082F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 18:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="a8mUc5Rs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E84F02082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbeK3GBm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 01:01:42 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:42141 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbeK3GBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 01:01:42 -0500
Received: by mail-oi1-f193.google.com with SMTP id w13so2543815oiw.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 10:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fqcqhGffcd7J7pK0CaK+ySzwIGebDi050OR3eY0t0KU=;
        b=a8mUc5RspOY04YQh+wJjUZG1zmHMdDDbxzwxhSp4/cOgrlmv4xxSfM2gpy6OmavVNf
         /bui816PlqR1MajcwPlsBaQuPv5mEMPddrmeWDYOb4d/90CT+3m2aJ/P0lje8l6+A3Dj
         tchBeFDQ05WvHTOQQhdIdxmZWTKZZvP3oJhcSxpbHR9A7oslOQdXnJVaPP9KFTX2rDMw
         jUbCMPPXB6aiT0u+iAUGy/6qFF5mCwhSVlZNcwxQpqD1KE9wL55wGI22EzABGryfoocX
         VJAUkFqOxlbkeU3IqQr4F9oWW8UJ/l7EXfcpPmpYhQhgGb/Rp3OFRtOaGP0DejVeiL+6
         MH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fqcqhGffcd7J7pK0CaK+ySzwIGebDi050OR3eY0t0KU=;
        b=Cd5z0znetzMkbkcZdrGBi1NCdTDRycriDHJ4B8ebrelBbxVa5VkMFFzsJ7aRXqF/pF
         uf+teb8aJXVK8+e5mYCJT5+X40qylg/GfTNOllWoytkgl60H9H9QQVwVj4dK/Z0Vv3Y8
         jIDN8OciCxL8QsZilVs5za/JgGAWgPrneuTuY7avKpewlOdg70kWZnfELvwfXtAi/bwr
         ZfK3wKvW0sPKn71x0xJEIy/oIQDMpRqpNyQp18mQxr5cesR26454920WlLsdoUwmfHIi
         jgwlaAOggjZVtGEKXH56PT0OPCuz0pMtMiSLwC0cqNlu/iCJ0dovfSxddwba3VGRsCbz
         Qm/g==
X-Gm-Message-State: AA+aEWb815Z/fBTvN+xIDHkwCgCwpSVxihWNHUTP2wArj8ANlT7lE2WW
        5iqzmsHZ6gaLXERWUvZBxJLN02Nr6/ipPgDM+n/dvA==
X-Google-Smtp-Source: AFSGD/VzkVL8dYBVBEnXzXK8YMxY4B/TeSfs3CL6o8yQHnxedGluYFtOkl+ru6GMrA7G2KolhtfvpPYV36J9ov9/MJ0=
X-Received: by 2002:aca:2dc8:: with SMTP id t191mr1468109oit.235.1543517719116;
 Thu, 29 Nov 2018 10:55:19 -0800 (PST)
MIME-Version: 1.0
References: <154345118835.18040.17186161872550839244.stgit@ahduyck-desk1.amr.corp.intel.com>
 <154345153672.18040.3771035148218843351.stgit@ahduyck-desk1.amr.corp.intel.com>
 <CAPcyv4gMswOJ3VTaY6P7f=iG_jNBKZyynn22CLrEBB13Fq-8vQ@mail.gmail.com> <a5b33ae899fc4131abf0f26af33a6c6b7f462431.camel@linux.intel.com>
In-Reply-To: <a5b33ae899fc4131abf0f26af33a6c6b7f462431.camel@linux.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 29 Nov 2018 10:55:08 -0800
Message-ID: <CAPcyv4j2w6ygzuP-vEKPk6NGLCEB6FcKTVFQkUqr3HC471xJsg@mail.gmail.com>
Subject: Re: [driver-core PATCH v7 2/9] driver core: Establish clear order of
 operations for deferred probe and remove
To:     alexander.h.duyck@linux.intel.com
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Tejun Heo <tj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-pm mailing list <linux-pm@vger.kernel.org>,
        jiangshanlai@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        "Brown, Len" <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        zwisler@kernel.org, Dave Jiang <dave.jiang@intel.com>,
        bvanassche@acm.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 29, 2018 at 10:07 AM Alexander Duyck
<alexander.h.duyck@linux.intel.com> wrote:
>
> On Wed, 2018-11-28 at 17:57 -0800, Dan Williams wrote:
[..]
> > I think the flag should be named "cancel" and set it in the
> > device_del() path. Otherwise this is encoding code flow state in the
> > struct rather than device-state that the code needs to comprehend.
>
> Instead of "cancel" what would you think of "dead"? In my mind once we
> call device_del we are essentially working with a dead device object so
> that might make more sense in terms of a state rather than "cancel"
> which doesn't really tell us what should be canceled.

That sounds good to me.

> Looking over the code I could probably set it before we start calling
> the notifiers for BUS_NOTIFY_DEL_DEVICE. The only thing I am not sure
> about is if we would need to add any sort of synchronization primitives
> around it.
>

I think it needs to be something like a barrier:

    dev->dead;
    device_lock();
    device_unlock();

...where you can be sure that anyone after that device_unlock() has
acted on dev->dead, or will see dev->dead.
