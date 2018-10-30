Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2D98C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794462081B
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 16:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="TJNZKGWd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 794462081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=usp.br
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728012AbeJaBv3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 21:51:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:47039 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbeJaBv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 21:51:29 -0400
Received: by mail-io1-f65.google.com with SMTP id y22-v6so7692790ioj.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 09:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzSyGcuP3+rZkBx7Wx42qeEn+OZuOP856LiRE8Irvuo=;
        b=TJNZKGWdJ0r2J4zaw5BIfePhIeiwpV+LNRNnz+4WfIYrM5SbDl+eF+2QtMH06HOw4t
         iFkvONpPUrG8/mohwVlR34Wx1wUkgYJPlZLpIIOe9HD+SMn7wR+WFOsfLzTWlQ80lXzZ
         EZVKP0yvMoruZcjFKXEho6GH38akLA4NvyLjj97OWuMuGcPuMhf5n6sKY8WQik3/Zegj
         Q0291kLdBa5UD0yDIakqE0JoyMMxeqelws5XFT1XBa8HO0ons4uqWuPCIha4fD/NDYXv
         MA7YDDO3uLiV+ijjDBU0UQ7YCzjVTKyAMIJXaF56lz+AA2qQwYwSMc6KJ97WyzoslCpA
         lNkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzSyGcuP3+rZkBx7Wx42qeEn+OZuOP856LiRE8Irvuo=;
        b=UhPlWzfwfAbt5MS1DIrew2bD2VDPGgkcLq7tfOTdzncQsrgovEmIkODRFsTolFCbYc
         2AJng3SNKY1v/pOMe06WzCo/mh8jE+IRD3r6FfOYbStKbol0vLBoup2KFARcHgJQxnIv
         3kTz97FjiyUuolOI58ZOJ506aXyUzoPiKz2fi4jojvS52Kw1TbCDDJdd0gVjQ9qpDLOr
         ev9b29MeHBF8WqDaQaU3cP4j2YNhWWQ7czg+MjAuK+uwHU9dfD0rX7PmXN3ZFU7FINk2
         //V3ZBRzR+KYYLQY+4YIum9mwMq5iZdCIgt74bQfXqVwOOyLOqVLtlHecIVCL5i6Y2/V
         dRCw==
X-Gm-Message-State: AGRZ1gKr+HQSJs1NEXzU++/O4pLjNjXXBfTacdFD+LVBJKN6mGO6Hhgw
        fQJZ08A9zVOxm8CHQoDAOQwfEDEx1yGeZkFf22+HMw==
X-Google-Smtp-Source: AJdET5ecolWoiNW1pTscX1PqoXYwy0a7Ci2tmE0di6NBaKKSc1aVNw1KeZVURojlmgwaft4Soxpb9yE9TMzVogIgD4g=
X-Received: by 2002:a6b:abc6:: with SMTP id u189-v6mr6991931ioe.229.1540918632391;
 Tue, 30 Oct 2018 09:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20181027020005.3140-1-matheus.bernardino@usp.br> <20181028165202.52ee89b3@archlinux>
In-Reply-To: <20181028165202.52ee89b3@archlinux>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 30 Oct 2018 13:57:00 -0300
Message-ID: <CAHd-oW58oc6=YOFdXDhPMJ9d1U19W3mc1essNzy1F8wakPLJnw@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] staging:iio:ad2s90: Add scale info and improve
 error handling
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 28, 2018 at 1:52 PM Jonathan Cameron <jic23@kernel.org> wrote:
>
> On Fri, 26 Oct 2018 22:59:59 -0300
> Matheus Tavares <matheus.bernardino@usp.br> wrote:
>
> > This patch set adds scale info to ad2s90's single channel, improve
> > error handling in it's functions and fix a possible race condition
> > issue.
> >
> > The goal with this patch set is to address the points discussed in the
> > mailing list in an effort to move ad2s90.c out of staging.
> Thanks,
>
> A good series in general.  A few suggested improvements.
> If I haven't commented on a patch, usually it means I'm happy with it
> and will pick it up with the rest of the series.
>
> Jonathan
>

Thanks for the review, Jonathan. We will address the necessary changes in v3!

Matheus

> >
> > Changes in v2:
> >  - Added my S-o-B in patch 5.
> >
> > Matheus Tavares (5):
> >   staging:iio:ad2s90: Make read_raw return spi_read's error code
> >   staging:iio:ad2s90: Make probe handle spi_setup failure
> >   staging:iio:ad2s90: Remove always overwritten assignment
> >   staging:iio:ad2s90: Move device registration to the end of probe
> >   staging:iio:ad2s90: Check channel type at read_raw
> >
> > Victor Colombo (1):
> >   staging:iio:ad2s90: Add IIO_CHAN_INFO_SCALE to channel spec and
> >     read_raw
> >
> >  drivers/staging/iio/resolver/ad2s90.c | 55 ++++++++++++++++++---------
> >  1 file changed, 37 insertions(+), 18 deletions(-)
> >
>
