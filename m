Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534E3C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E86E208A3
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 19:13:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="kLh1u2p0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E86E208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbeKQF1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 00:27:05 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:32850 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725729AbeKQF1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 00:27:04 -0500
Received: by mail-oi1-f194.google.com with SMTP id c206so14981524oib.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 11:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FzV4CuiUsv8BSsXygli4GKcLH9tEzNxECJrpQQ1j7HQ=;
        b=kLh1u2p0tvFHs9D+qySwvPnyEueoDHW7hYb3/dffdwJk3YLpg1vq4RqEF4r4QMt7e7
         VqdIHycMZ32a0/gJ6RsZxD9OwgXm10KVkYljjezBX5p5GtlmU18qC+ubP/cxawrujbUn
         3La7YBPSez2SCTkMbKtaBZgLB1XwxXjmqhf/+FtuKiZDemAR2xXFsRKp7y8jBI1dOVP2
         o3m0b+OjVKtNCvqVM9zscCIpTUq84GoMv8U0D0sMyEZ+sQPV8Qv+c3cyoS5ydAqHWwm9
         /M7Vu2ArqFaeBgW2414aQftXGot111rqMUBZQWQwctyHbYNaekvrJvKEV173y1pvB0Ps
         iS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FzV4CuiUsv8BSsXygli4GKcLH9tEzNxECJrpQQ1j7HQ=;
        b=Rw8mGCpc9qDuXzfXOCI/2mlwDLcNcDLBMAmQsOgYhKC4bkVD7cNWOhCmyY6OP+dI4q
         K14Lw/VZ/TOwIwfhZeobITCEZB76dcS5yA5waERuktT1TEf/5yxyRwZAdRz91TbWIAw5
         Xuwes27z5SoD/ppGx+rRtsx1KrvRfCD7NbNdHZSKH0GcBQyafwZ0j46OohDHL6YKS37F
         NySDUOpmyoIWAtCummGmW6a80HfvI0dCziB7TZHmEUxEaMsxvVWJwz5vjKMZsEpCUFyE
         tJnDWH/05ubWVoJy+38niLX43m7BAG6NtwCQQBGm6jQxiqtWAV41nRRnN+XCPDYakx0W
         LGyA==
X-Gm-Message-State: AGRZ1gKFP/7VuqKse/J7iPC++7CtiZjJBr/OgJ6x52eNGgzOA8+8P8r7
        uEnEjR5npDxLGyqvwU5qpSHsktFUf3JNKSRJvLsTIg==
X-Google-Smtp-Source: AJdET5dAK+7kuNUM78bBJJyh3cSdsjzc3AEZqv+BK1+UxF0CLa5h3FYfhqsHQ+koudfgtx0dbyCWgjtsvmtq3DMHZpM=
X-Received: by 2002:aca:745:: with SMTP id 66-v6mr1595280oih.280.1542395606493;
 Fri, 16 Nov 2018 11:13:26 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225761038.2499188.1270468803677883744.stgit@dwillia2-desk3.amr.corp.intel.com>
 <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
In-Reply-To: <CAMuHMdVOJsM=66RrnbOzVthsT9=dFRQtL2rv99tCPC02M=hiXw@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 16 Nov 2018 11:13:15 -0800
Message-ID: <CAPcyv4iSWMhNLeBGQsusgmQ99=duN88aNF8k1+BJn1ROAk=2OA@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 3/3] libnvdimm, MAINTAINERS:
 Subsystem Profile
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>, zwisler@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 12:03 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Dan,
>
> On Thu, Nov 15, 2018 at 6:06 AM Dan Williams <dan.j.williams@intel.com> wrote:
> > Document the basic policies of the libnvdimm subsystem and provide a
> > first example of a Subsystem Profile for others to duplicate and edit.
> >
> > Cc: Ross Zwisler <zwisler@kernel.org>
> > Cc: Vishal Verma <vishal.l.verma@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Thanks for your patch!
>
> > --- /dev/null
> > +++ b/Documentation/nvdimm/subsystem-profile.rst
>
> > +Trusted Reviewers
> > +-----------------
> > +Johannes Thumshirn
> > +Toshi Kani
> > +Jeff Moyer
> > +Robert Elliott
>
> Don't you want to add email addresses?

I do, but I had not cleared this designation with these folks ahead of
time. Will resolve that for v2.

> Only the first one is listed in MAINTAINERS.

Correct, the intent is that these individuals can be sought out for
advice when the maintainer may not have the bandwidth to engage with a
contributor on a given timeframe. These are individuals that can
provide a second opinion.

> > +Time Zone / Office Hours
> > +------------------------
> > +8:00am to 5:00pm Pacific Time Zone
>
> UTC-???
>
> People are not familiar with all time zones.

Yes, will fix.
