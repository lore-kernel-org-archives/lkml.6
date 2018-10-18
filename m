Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4013ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B7D2098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 22:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="w5iIxgLL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B7D2098A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbeJSGwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 02:52:25 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:40153 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbeJSGwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 02:52:25 -0400
Received: by mail-oi1-f195.google.com with SMTP id j68-v6so25384407oib.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 15:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KtnOWMZFGHoMfgxsfPt1NXHVT7qrHLYEWM/3o5DRSqk=;
        b=w5iIxgLLdzFM9qOLUnVGaDerP8nbW0mceb55YaFQ/la76l8O5SJGaVUH/USvn5o+6s
         g7RyhS3p9ef5jQjCm6mAp/Cn9CrVWO0yTfk7E25+Yh1coVkoPxVTxAP5FPmLA6JovgLZ
         vlA3Nl76ecXf1yBi9NGO4tfFwsB2ITWXpWwuBYave1C3VTiH9AvYSmE0jaC4l1AXdRUa
         dGwUgQ29rhF0v+4lfADwA9REsQz+Hu+P9/fwXaUJO7i7peo6Y0e73M8Cv+BznpnRPNNM
         8f5FWQMJChm2hgfJYFj+TSwjf2n0f4v2y53vzvPu9yeSHPmsqWBLYIvamyp3EiyNDYeN
         lALw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KtnOWMZFGHoMfgxsfPt1NXHVT7qrHLYEWM/3o5DRSqk=;
        b=SEr3n5ujAGUChdls87Sb9vjoGBYwD4dwe7ueWX7zUmd0ITlL5DX836IUJ0vr7uZYoT
         hSQCLCnpcl0xgg7oLiwTNkNuOF6Dsfc6OR/oGIyfplOb7VGPlOwexyqdaWWIX6d2ZtKW
         YKbf4z7DUHY6wQArMurNOiqAD0av8Y1GUYqQO0VW9Uq1d6IYykRdlKbV+xNmj8SRTUDx
         8UjN4NOU6O7Q+UElR/gbYIty3W4k7qUTAlDj0my94s/q+nzFMGTR4NjlEDm/qKi9XNk4
         ShyBs/2M3SkQ5e/S2YcwW1Empoc+2udOQGIwy+AHlJXy96VILES3+HBBh0jVm2y7mmW5
         1WIg==
X-Gm-Message-State: ABuFfoiXRrJwf1B17w7lrTq+CFSQb95nfEqAHFdyXQr8hVDgJyXo9rMs
        rhViEiuoXOKgOp8Tkqfmc1WM6AIo7IMbHaI44XO/5A==
X-Google-Smtp-Source: ACcGV62pChxWQVJVZPnflneJlqXFkw+my4EDxwydEc6l8im6K6jmrId9jhAZopid/GqsGkKXGX2yrdSuM7mnAzu7k48=
X-Received: by 2002:a54:4516:: with SMTP id l22-v6mr18014187oil.0.1539902954529;
 Thu, 18 Oct 2018 15:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20181018002924.GA42803@beast> <CAPcyv4g_W5KJq8vrVdi8-Hij4zQLLjZdZMkmP7oWABSrmGfLRw@mail.gmail.com>
 <CAGXu5jK5GrgoHSC_peChp9Uzx-_EbPqZgtpDC=F+V1cP92cKxA@mail.gmail.com>
 <CAPcyv4gO2zN-ixVE1eLpe4RT1Vkkyp_C+LbGnNVT+gnJG=h3KQ@mail.gmail.com>
 <CAGXu5jKUc0+EnV0m1ii_aRVa2XJSDtKY4Xq77Q+an1Z1VUqV7w@mail.gmail.com>
 <CAPcyv4jzic5zd1AJci439zWzJ0-nP_vf3k7Xzkm7AGvvge8SEA@mail.gmail.com>
 <CAGXu5j+Ne7cJBWp0Tzp++c+iOTgT5SeZCE0wVOR1xcmaQJDKiw@mail.gmail.com>
 <CAPcyv4hyZFRog8EBvhnO0bz3ryVNX=udupgnFUSZDgUBN23YWg@mail.gmail.com>
 <CAGXu5j+q4_+vQx8fcJgGUzne0PH33isZofkQ3YR6eL2kUO=Njg@mail.gmail.com> <3908561D78D1C84285E8C5FCA982C28F7D4195E1@ORSMSX107.amr.corp.intel.com>
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7D4195E1@ORSMSX107.amr.corp.intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Thu, 18 Oct 2018 15:49:03 -0700
Message-ID: <CAPcyv4iNRzsCX2eeuU4JN9UBjTgNPXetT_khpho9GncG0EYHTg@mail.gmail.com>
Subject: Re: [PATCH] pstore/ram: Clarify resource reservation labels
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>, joel@joelfernandes.org,
        zwisler@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 3:43 PM Luck, Tony <tony.luck@intel.com> wrote:
>
> > If the filesystem existed on the namespace before the user specified
> > the ramoops command line then ramoops will clobber the filesystem and
> > the user will only find out when mount later fails. All the kernel
> > will say is:
> >
> >     dev_warn(dev, "could not reserve region %pR\n", res);
> >
> > ...from the pmem driver, and then the only way to figure who the
> > conflict is with is to look at /proc/iomem, but the damage is already
> > likely done by that point.
>
> When you set up a ramoops region in pmem, write a magic header block
> at the start of the area.  Then when pstore/ramoops goes to find the
> region, it checks for the magic header.  Not there? Don't write to the
> region. Problem solved.

That's effectively what this registration proposal will do. However,
with the caveat that the user never gets to write that magic header
without going through the nvdimm infrastructure to set it up, and
assert there is nothing there already.
