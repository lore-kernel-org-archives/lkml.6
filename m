Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE2CC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:26:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B29A62082D
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 11:26:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmuF3Kez"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29A62082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbeJYT6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 15:58:36 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39308 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727208AbeJYT6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 15:58:36 -0400
Received: by mail-qt1-f196.google.com with SMTP id g10-v6so9322614qtq.6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 04:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MriBhy+Xabpy4XyzJ1uF26JAHOVj28bskisgUQ8tX8=;
        b=SmuF3KezGM995a6uBNDpgyH+q6ZRU5VfOkwuMfAev8wmadP/041nIIX7lJju40Pnxl
         d3hxD6cpgqgeD//5IP7IaYGX366Figac3HEyhXTfb65+LSo0yBmSBaIlx/atIoEzcVIC
         THHeXFdbWnZ9h00eJZ5rKbTB3BIKJ77ywuBlVyNP4qePyxPFpa+ZVSs7i5zgF3+gdSWX
         pWDLqdl7MGFu+N87wPk6r8E5xjuAKd5HCjSomrQ9wrdpsvTr+2SEwNpwEBTjswcf8PD9
         abbxVTzD4s6878lovnMHCiKJH3p0YDnukoNfVrKsSsIA1G0G8t/nLEsCpVuD7vQwAPq8
         23Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MriBhy+Xabpy4XyzJ1uF26JAHOVj28bskisgUQ8tX8=;
        b=ZYtHiq7MjzuQarz9Z4K2eOZTtSVAAlVCrBu0Qq9xxnq1/cCKLVuLjWpz+f383smpWK
         2h9C8waMUTSyM6Ri5Fv88WrtpaYFEKb3SBnqKUMu5FO874FOZbihpy6fW7ZiLl2YgNJM
         bYNrKeA6CGFCeV+VayYbFDsVkdYlZqX31JjqireqeDGNZABVeZ+IyKi8oxIAXKohYWIR
         OHL1t9J1PkAx4ndXpdgeIRdUUf9C6Jw/RNHgKow00OKlGxL/Vl248itySdabgt+pWPvl
         cayvv5y+4sznrA7tPMKIGao8HIR7q3eNIyr5l7ZpgWuo10CIrAfSVH/mKET1QQ0oDwOP
         X9rA==
X-Gm-Message-State: AGRZ1gIC5FuvpEKolZSmACmZL/rGaspZ7tuVuGtj2R4EgnA6h+/UQfTA
        S/PxjEGHoLbDj63ecjPMuLw2iO5B0Wr3PJsfjk8=
X-Google-Smtp-Source: AJdET5dA/cBCOQqIN5zbYjMadQ1WMAID0lPqPFDscCJiPvacI6eR679dvB5F3zYFIR9IFXBaub1TJJhkgl7+tqfejtA=
X-Received: by 2002:a0c:c3c8:: with SMTP id p8mr1061384qvi.90.1540466774243;
 Thu, 25 Oct 2018 04:26:14 -0700 (PDT)
MIME-Version: 1.0
References: <CADa=ObrwYaoNFn0x06mvv5W1F9oVccT5qjGM8qFBGNPoNuMUNw@mail.gmail.com>
 <20181022083322.GE32333@dhcp22.suse.cz> <20181022150815.GA4287@tower.DHCP.thefacebook.com>
 <20181022170146.GI18839@dhcp22.suse.cz>
In-Reply-To: <20181022170146.GI18839@dhcp22.suse.cz>
From:   Sasha Levin <levinsasha928@gmail.com>
Date:   Thu, 25 Oct 2018 07:26:02 -0400
Message-ID: <CA+1xoqe-Q-vZ1TjyvRNfycnzr-Q3OWQa3WnWOgOvskWi9CC7cw@mail.gmail.com>
Subject: Re: Memory management issue in 4.18.15
To:     Michal Hocko <mhocko@kernel.org>
Cc:     guro@fb.com, Sasha Levin <alexander.levin@microsoft.com>,
        dairinin@gmail.com,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        riel@surriel.com, hannes <hannes@cmpxchg.org>,
        vdavydov.dev@gmail.com, shakeelb@google.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-mm <linux-mm@kvack.org>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 22, 2018 at 1:01 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Mon 22-10-18 15:08:22, Roman Gushchin wrote:
> [...]
> > RE backporting: I'm slightly surprised that only one patch of the memcg
> > reclaim fix series has been backported. Either all or none makes much more
> > sense to me.
>
> Yeah, I think this is AUTOSEL trying to be clever again. I though it has
> been agreed that MM is quite good at marking patches for stable and so
> it was not considered by the machinery. Sasha?

I've talked about it briefly with Andrew, and he suggested that I'll
send him the list of AUTOSEL commits separately to avoid the noise, so
we'll try that and see what happens.


--
Thanks.
Sasha
