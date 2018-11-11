Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F62FC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFBDA20871
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 19:53:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="2NOf1pOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFBDA20871
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbeKLFm7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:42:59 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:43326 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbeKLFm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:42:59 -0500
Received: by mail-ot1-f67.google.com with SMTP id a11so2486838otr.10
        for <linux-kernel@vger.kernel.org>; Sun, 11 Nov 2018 11:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DolMS0/6BCSOy4ZyzRdAwHAE/0S/Va7hCJMFKYe7QEI=;
        b=2NOf1pOXb9T3gNDoORuaV0w8gNY3/7ufnlK9UtHVnW1AfkC7L8lbL47FZLNa+7NAjs
         qRPuBRJ8aiLuoGJZRhzanSkrn7KDacwsDFMJMAnGqAY2lU388b7iMZYRQkXjMDZ/CPH6
         fxRH2UMXDKmypNXJcUWvt96AB8W37LwiyiS9JQhYviSAwifp5W7LjdjFdXXgaxsNV12l
         eSQo3nULzrvAo1fNGaCpfXjLeh79BvyGOVCmih9UZ0Zr4MYbvgLY/ZEP7k11tEFJU9LZ
         N2s2VmqSpHpgSW2YKbkt0K0dAyozWI9p2eeJY6T29CVWpXZ/jEoFJylh/mU4ONSh+poQ
         z0aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DolMS0/6BCSOy4ZyzRdAwHAE/0S/Va7hCJMFKYe7QEI=;
        b=gbsxyHb434J53JnwzkVm1ufM8o5Mh2qHeP7h3wmdaR/9Ghw/U8k4MNwtRgtuFC8Rm+
         4pcfkm38INzb8LBWs+gdHRbxZTLOGMSBFqBrzeOA6ZGFpJWix86FtFszVVkQVuEFkFtF
         wboq5sWynn2pYgRTeip3Q6i23Sl3HodAjZQw2UZx030TTE0tMHsuZPsZ5T0MHGRb+Ysy
         ImKKPxGXRhQ3ZaF8MM3Pjy7YjA9SMkIabzjfbhld6OIUXlt798zeNvjKmSoa+7S+wA7B
         30aDIUftfIwwimrMVzoMagmoStPJCZdba4VZoLZTEc+xqE8o0hrP3/965gejeivC5gjs
         l1XA==
X-Gm-Message-State: AGRZ1gJXtalTY23wEFyEwgg9oLBTYaud6N1rUvp1NEwE2n/5m44G3Mec
        FuUI7vlC1QDktYh/ujl7xiR9t6P0gMD6x4XlSu3BlQ==
X-Google-Smtp-Source: AJdET5fECTDrzy90gpSv1FuJPEXdvNHDVbIG69HZW29uiAP7f7kdu7QFtIuFRV+xdP4uUuaAO2yjSruG3mz/0W0okZQ=
X-Received: by 2002:a9d:775a:: with SMTP id t26mr9704822otl.32.1541966012047;
 Sun, 11 Nov 2018 11:53:32 -0800 (PST)
MIME-Version: 1.0
References: <154170028986.12967.2108024712555179678.stgit@ahduyck-desk1.jf.intel.com>
 <154170041079.12967.13132220574997822111.stgit@ahduyck-desk1.jf.intel.com> <20181111193208.GB8332@kroah.com>
In-Reply-To: <20181111193208.GB8332@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 11 Nov 2018 11:53:20 -0800
Message-ID: <CAPcyv4hofCTYMNN=Ow=o4RRuUPM=GLWajNAT9q6WWkuV47te_w@mail.gmail.com>
Subject: Re: [driver-core PATCH v6 2/9] async: Add support for queueing on
 specific NUMA node
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     alexander.h.duyck@linux.intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Sun, Nov 11, 2018 at 11:32 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Nov 08, 2018 at 10:06:50AM -0800, Alexander Duyck wrote:
> > Introduce four new variants of the async_schedule_ functions that allow
> > scheduling on a specific NUMA node.
> >
> > The first two functions are async_schedule_near and
> > async_schedule_near_domain end up mapping to async_schedule and
> > async_schedule_domain, but provide NUMA node specific functionality. They
> > replace the original functions which were moved to inline function
> > definitions that call the new functions while passing NUMA_NO_NODE.
> >
> > The second two functions are async_schedule_dev and
> > async_schedule_dev_domain which provide NUMA specific functionality when
> > passing a device as the data member and that device has a NUMA node other
> > than NUMA_NO_NODE.
> >
> > The main motivation behind this is to address the need to be able to
> > schedule device specific init work on specific NUMA nodes in order to
> > improve performance of memory initialization.
> >
> > Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> > ---
>
> No one else from Intel has reviewed/verified this code at all?
>
> Please take advantages of the resources you have that most people do
> not, get reviewes from your coworkers please before you send this out
> again, as they can give you valuable help before the community has to
> review the code...

I tend to be suspicious of code that arrives on the mailing list
day-one with a series of company-internal reviewed-by tags. Sometimes
there is preliminary work that can be done internally, but I think we
should prefer to do review in the open as much as possible where it
does not waste community time. Alex and I did reach a general internal
consensus to send this out and get community feedback, but I assumed
to do the bulk of the review in parallel with everyone else. That said
I think it's fine to ask for some other acks before you take a look,
but let's do that in the open.
