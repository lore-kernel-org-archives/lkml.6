Return-Path: <SRS0=OQvN=N5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E1C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:34:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C793C20815
	for <linux-kernel@archiver.kernel.org>; Sun, 18 Nov 2018 17:34:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="BM6SBNHo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C793C20815
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbeKSDzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 18 Nov 2018 22:55:03 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46631 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbeKSDzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Nov 2018 22:55:03 -0500
Received: by mail-ot1-f67.google.com with SMTP id w25so24920672otm.13
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 09:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0PBAL+n8DOyQqisexveEk2hFrf6dZCpYuhneZeq54U=;
        b=BM6SBNHo8Jtsh3R6v1WoIfUx7/GKRiy2mjys5dTTn9J5fnZDBiGp+wFe3A2o/p19hd
         eoehP3v9X8ybbW6uOs7nqKnyapjkSvFB5XIigSrBleNyW0bbXSHSJmEY1ulWZFUXl/m3
         ZkIlx7ga3DBwMk7///z0tdHBrpuAW7MKSkjuAMIvi7+VPTTGR/zGSw/A4Cczc5tAuCBQ
         lh15T4rDkaw18xX276cPDzyJYDSwH1ulmT9KHGg7nZ0TrwuFc1yYuieOs791SlnB2RL4
         7N//T9/+HUZLjpKlCcA+aRf10RAYQdQewp4UXJ6vI+1eoBY8zKw0B9NRtYXsf8WW0DEF
         IwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0PBAL+n8DOyQqisexveEk2hFrf6dZCpYuhneZeq54U=;
        b=V4fFEiWkdHyxOGI7NwlwUosR4KZ6sYCuNnh29WwxPrFcgIWiWQD5/3Q7Qh8jOjCTGb
         HlO6BpoPkoYFX5pSzTofzIXDLVUIpfe7Pk+FaslI+5Tfnf6mZJ1vWK8A/LPL+bYwiao7
         d6pe07i7/TBqlwAxG09Jly5lCwz+NORBXLOcQsvv+oNXnpsbflcvZG4wShdxO0663OPQ
         UPJf8nLjc+0gvIyl1mkVYEhK1M/Sc+I1Wti9jlB7hyiTTISkBBamMvV6ONp/8aXApDRu
         oZ0aztwonXRHNfzuC0szGAkkeT1G4g62rVm8XfqpnQ8WjJcLZTUHB1ij82fTUZJcXUX8
         aB6Q==
X-Gm-Message-State: AGRZ1gKdP4oivrh06XHaAhS4DVlMHVGHk3M1I4C9voDO8zMSWkaMwd+L
        M5CUNFJJVRGlZFgWWjXGj7QbZ58Kq3mg65EpdoOhUSeS
X-Google-Smtp-Source: AJdET5f80abgJeq8hkKP6bCsXhDzTyi/fcF6Jm1g364OKYEm5XN1fm5LWWm4A+PJcuZBETOSVL3o6Qo/xZpYDyXnn5A=
X-Received: by 2002:a9d:40cd:: with SMTP id t13mr10811195oti.98.1542562452426;
 Sun, 18 Nov 2018 09:34:12 -0800 (PST)
MIME-Version: 1.0
References: <154225759358.2499188.15268218778137905050.stgit@dwillia2-desk3.amr.corp.intel.com>
 <154225760492.2499188.14152986544451112930.stgit@dwillia2-desk3.amr.corp.intel.com>
 <9f6aece0-da64-78b5-0eda-fe039fc1ad09@gmail.com> <20181116040442.3a5ee3b9@silica.lan>
 <CAPcyv4iw78jzLQmX6foUMpVUB4ZSE2ExYhjTd87X2xraaZrkPA@mail.gmail.com>
 <20181118105829.7388cc7d@coco.lan> <CAPcyv4hX_B5HZ8Cj8VmjeeteZVkn-Ax8avAcUwUQqzH6J67ryA@mail.gmail.com>
 <CAPcyv4g0wKdLqDr9R3euzNrzNH5v18GJpBJeEGP4Pg+d8VMD2A@mail.gmail.com>
In-Reply-To: <CAPcyv4g0wKdLqDr9R3euzNrzNH5v18GJpBJeEGP4Pg+d8VMD2A@mail.gmail.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Sun, 18 Nov 2018 09:34:01 -0800
Message-ID: <CAPcyv4iVKYCdOvbwBFboR_z-Fr-8NyALkvAGCReR8EW2Y0iNmw@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [RFC PATCH 2/3] MAINTAINERS, Handbook:
 Subsystem Profile
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Greg KH <gregkh@linuxfoundation.org>, stfrench@microsoft.com,
        "Tobin C. Harding" <me@tobin.cc>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 9:31 AM Dan Williams <dan.j.williams@intel.com> wrote:
> On Sun, Nov 18, 2018 at 9:31 AM Dan Williams <dan.j.williams@intel.com> wrote:
[..]
> > True, will remove. What's the point of stating daily active hours when we already have "Resubmit Cadence" (I think I'll rename it "Follow Cadence") measured in multiple days / weeks.

Apologies, fumble-fingered that last mail. I meant to say "Follow-up
Cadence", and that include a maintainer preference for private pings,
or full patch set to be sent again to the list.
