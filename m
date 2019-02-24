Return-Path: <SRS0=zeyH=Q7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9BBBC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8930820651
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Feb 2019 20:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551038838;
	bh=DZlba4MMda0HCxvvDDNxGjlswGy5+GvbYo5OXHRmCVg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=U7QAi2H1SXlHtUXKCMYjZvqB+Qvlt4K8uvYWhQb3yGGDgFRAk4x4Huu8LMmbO4S30
	 VoFO3o4umVYnrF3zQ7X43D6Jjrjp9lexsLENV4OMy0MNJ9BIqrt8MdeV2Laz4+kffO
	 E5gn49RItanJiZ/xTVjuvlj6wW1Bup+0Rkzq0QT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfBXUHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 15:07:16 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36837 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbfBXUHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 15:07:16 -0500
Received: by mail-ot1-f68.google.com with SMTP id v62so6133503otb.3;
        Sun, 24 Feb 2019 12:07:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y0IqkcdgngY/YGpOiQL7ywzKAqFIW/9T4EnT6V1cf8g=;
        b=k8AEqHikP9XYIQlWxuqWYsi5cSd3js2ANQZcX114gozLjKjo99yYigKRP5lBfSeN/M
         QomdhrqkXDHxZeRHDm2ysMgaQ60OghnSov3T7C8//NPr11E8TN1pD+8dOy2ghJNCFn7x
         Q1zE098C8ouS3VrzNpp3668BunE5k/iODiC3JbcKXk/c1pI3EXO2+UuTrDGPiq7CQtg8
         fnRyUzU9qckVwJk9eqPa1NQnFmey/RPpCY77gNp8kmvAIWonkEAvWaedsJhJNLRP5I/z
         Xo1nTjnFlmBFha1rOMWEXOeHMMPJUMr4ofx9yLyKZjCs2NrILb+7efV3errKzH5Gcj45
         sSSA==
X-Gm-Message-State: AHQUAuaVR2+JDUVDLOxinL3cQsCHqSaXRPdaqbZJN5CguGV2QBZkB4vS
        4QcVMEAC+HmcyLcdIHxUr5MtpkFtLX5yTVGtmaM=
X-Google-Smtp-Source: AHgI3IaHNS0WJfmSh2GiAwYr+yAYriNEsAvhKyb20CHj7QW3/rrWdSxXlK3Ty5fEaxR2f/Qsz2WXeKqI25AUWRh0+Lk=
X-Received: by 2002:a9d:7cd3:: with SMTP id r19mr9880945otn.139.1551038834827;
 Sun, 24 Feb 2019 12:07:14 -0800 (PST)
MIME-Version: 1.0
References: <20190214171017.9362-1-keith.busch@intel.com> <20190214171017.9362-8-keith.busch@intel.com>
 <CAJZ5v0gjv0DZvYMTPBLnUmMtu8=g0zFd4x-cpP11Kzv+6XCwUw@mail.gmail.com>
 <20190222184831.GF10237@localhost.localdomain> <CAPcyv4jpP0CP-QxWDc_E1QwL736PLwh8ZPrnKJzVnYrAk++93g@mail.gmail.com>
In-Reply-To: <CAPcyv4jpP0CP-QxWDc_E1QwL736PLwh8ZPrnKJzVnYrAk++93g@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Sun, 24 Feb 2019 21:07:03 +0100
Message-ID: <CAJZ5v0gyEJ59qSno_MKjr97zeYaLp=v1=ZYz1twM1eZJCP_DTw@mail.gmail.com>
Subject: Re: [PATCHv6 07/10] acpi/hmat: Register processor domain to its memory
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Keith Busch <keith.busch@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux API <linux-api@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Hansen <dave.hansen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 8:21 PM Dan Williams <dan.j.williams@intel.com> wrote:
>
> On Fri, Feb 22, 2019 at 10:48 AM Keith Busch <keith.busch@intel.com> wrote:
> >
> > On Wed, Feb 20, 2019 at 11:02:01PM +0100, Rafael J. Wysocki wrote:
> > > On Thu, Feb 14, 2019 at 6:10 PM Keith Busch <keith.busch@intel.com> wrote:
> > > >  config ACPI_HMAT
> > > >         bool "ACPI Heterogeneous Memory Attribute Table Support"
> > > >         depends on ACPI_NUMA
> > > > +       select HMEM_REPORTING
> > >
> > > If you want to do this here, I'm not sure that defining HMEM_REPORTING
> > > as a user-selectable option is a good idea.  In particular, I don't
> > > really think that setting ACPI_HMAT without it makes a lot of sense.
> > > Apart from this, the patch looks reasonable to me.
> >
> > I'm trying to implement based on the feedback, but I'm a little confused.
> >
> > As I have it at the moment, HMEM_REPORTING is not user-prompted, so
> > another option needs to turn it on. I have ACPI_HMAT do that here.
> >
> > So when you say it's a bad idea to make HMEM_REPORTING user selectable,
> > isn't it already not user selectable?
> >
> > If I do it the other way around, that's going to make HMEM_REPORTING
> > complicated if a non-ACPI implementation wants to report HMEM
> > properties.
>
> Agree. If a platform supports these HMEM properties then they should
> be reported.

Well, I'm not sure if everybody is in agreement on that.

> ACPI_HMAT is that opt-in for ACPI based platforms, and
> other archs can do something similar. It's not clear that one would
> ever want to opt-in to HMAT support and opt-out of reporting any of it
> to userspace.

In my view, ACPI_HMAT need not be an opt-in in the first place.  The
only reason to avoid compiling HMAT parsing it would be if there were
no users of it in the kernel IMO.
