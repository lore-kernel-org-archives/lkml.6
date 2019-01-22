Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C22EC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF57421726
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 16:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548175930;
	bh=psaVWBmPsheEJ6BJyBMjS8Z+BHNtCIFqQ3cMAJKqmTo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P4r+pAQMvmcOgwR4vK03d8bOdOx0hChkLJeqTAPgXxqUhSzKtShWv+FvP1wXduF/V
	 mbcCJK6CImkzlWp3GmtuR3AVoqskBHeCs25//X5cRoGNHo7lPYqSfv9cCYOT8tXDKG
	 O9EaNhw5W8IVM8mkc/ixQ18BSYXfKewoRC0yLaGQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbfAVQwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 11:52:08 -0500
Received: from mail-oi1-f182.google.com ([209.85.167.182]:45501 "EHLO
        mail-oi1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbfAVQwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 11:52:08 -0500
Received: by mail-oi1-f182.google.com with SMTP id y1so17923287oie.12;
        Tue, 22 Jan 2019 08:52:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lcquk7P9RYTtB49NXyYLu5SF++ESl8Lz8Zlf08rA2OQ=;
        b=L8xu2ZElxIWQ93Kcjbi3KEAt7c0OM7XhPehMSaWSu0ksT6lON+zNlR3l167CFoB4P6
         RMxNh25Oxw6Pi2xFugAD5kfsPC5oBueAKwfvKDXXPL3JbyBEClCO7xw0NYQHRkPT1hRT
         YiqS3VM6pu8dMyn0vmTObYIPklMVY2Dzld6Gklp501VlgeNHMqz1AMrUOp+BxcfJN2f5
         V6ykRKdTkCA8zjKY7HPpnHvaPAJrg7yWmmYQtrZj5Sy5IyYGEA5hjW8lKSDdmwwq0/f5
         xcs9K4bYEPp/ap3R/05FeNvLvgnDkwpFJoZPiGTqMyCEdDRJCvjT10LqnHFmvzu3/gEn
         CfJg==
X-Gm-Message-State: AJcUukcm6YoneR96AN8rpU14kH96l5MdKA5409ByIhS0z4YvUJQJegDF
        8yWCAE9H4mPeHkJ4EYXF+Fv6CGkL0JdockAU6K0=
X-Google-Smtp-Source: ALg8bN7d1xdko8em0OzR4GgCbybm4YWTo08AJPrsbv4p1VXfHzEvo1XpAO/zfpjyfr5Oxm48bn2vYKFcE+hsSI/PdLU=
X-Received: by 2002:aca:195:: with SMTP id 143mr8334859oib.322.1548175927484;
 Tue, 22 Jan 2019 08:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20190116175804.30196-1-keith.busch@intel.com> <20190116175804.30196-6-keith.busch@intel.com>
 <CAJZ5v0jmkyrNBHzqHsOuWjLXF34tq83VnEhdBWrdFqxyiXC=cw@mail.gmail.com>
 <CAPcyv4gH0_e_NFJNOFH4XXarSs7+TOj4nT0r-D33ZGNCfqBdxg@mail.gmail.com>
 <20190119090129.GC10836@kroah.com> <CAJZ5v0jxuLPUvwr-hYstgC-7BKDwqkJpep94rnnUFvFhKG4W3g@mail.gmail.com>
 <20190122163650.GD1477@localhost.localdomain>
In-Reply-To: <20190122163650.GD1477@localhost.localdomain>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 22 Jan 2019 17:51:56 +0100
Message-ID: <CAJZ5v0ggO9DePeYJkEoZ-ymB5VQywBgTnsGBo4WPHD5_JrjKRA@mail.gmail.com>
Subject: Re: [PATCHv4 05/13] Documentation/ABI: Add new node sysfs attributes
To:     Keith Busch <keith.busch@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 5:37 PM Keith Busch <keith.busch@intel.com> wrote:
>
> On Sun, Jan 20, 2019 at 05:16:05PM +0100, Rafael J. Wysocki wrote:
> > On Sat, Jan 19, 2019 at 10:01 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > If you do a subdirectory "correctly" (i.e. a name for an attribute
> > > group), that's fine.
> >
> > Yes, that's what I was thinking about: along the lines of the "power"
> > group under device kobjects.
>
> We can't append symlinks to an attribute group, though.

That's right, unfortunately.

> I'd need to create a lot of struct devices just to get the desired directory hiearchy.

No, you don't need to do that.  Kobjects can be added without
registering a struct device for each of them kind of along the lines
of what cpufreq does for its policy objects etc.  See
cpufreq_policy_alloc() and cpufreq_core_init() for examples.

> And then each of those "devices" will have their own "power" group, which
> really doesn't make any sense for what we're trying to show. Is that
> really the right way to do this, or something else I'm missing?

Above?
