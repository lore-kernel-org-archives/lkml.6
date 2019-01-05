Return-Path: <SRS0=xVxK=PN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0977C43387
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 09:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9074520874
	for <linux-kernel@archiver.kernel.org>; Sat,  5 Jan 2019 09:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fHtYM2ji"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbfAEJmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 04:42:03 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36116 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726026AbfAEJmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 04:42:03 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so34318120ljk.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 01:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05KPk084pYyNVRc+3Ydu832vKJQqNZFZltG+sBTAris=;
        b=fHtYM2jianD/y2raD5vGQpMvqJoiupHLmlrjC70Jx3+QWpN+v+HMW7217rngo9Rr67
         4bxUghOgytkjQdVjnHKnyK0iAA9+46stgQHM2OmX0WjYSeC56e0tD2UpACnHvcZLOiPh
         D6dx1Xs+4hksI1ygjEdcxQvRP3MTV/v23ldgRGlFJaO/6yxXTsUDoeRabG8dvA/51ZD6
         EuqbwX5OkBGUHpOgrWR707CDtPB/jgsdTl/pNuVYPSLt4RGIaDVbD6eUekzPX0bw97KE
         59Oy/huhI9vwzZV6Z6AYZ4SFXH2oAagc2DYQNf+By1ExWsVQ/u03DwTH9KteUnOk3OZP
         R/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05KPk084pYyNVRc+3Ydu832vKJQqNZFZltG+sBTAris=;
        b=ZO40SuW0VCpdsu0eQ5BPwbAG14vfrzSsbL5V/YtnsqMmFDZNjdrS/Nnd0Ung44qroU
         nSLVWsOTAtz2DXbboC1V7zl12uyOZJnRllyES6E/6Die4FR+kRXaa081KNaXopvjbY1c
         PSerb7+rkFWnJ04k729839g/7sADDy9tuufFqoZdx018QIUTWwfraJdLhw7KyC/JBBir
         0SAARnD8HJjiHYdbOg0uoXxJTbaYBspUYkA0WivONnNHfkolWHrzs4dj3wy98HOnR8cN
         /711TUgKphZw3BEJlko+zwi0fmNEMpSDM3M4C/I/sEFwLTDU8QFfQwMzrVuWifDX6XaA
         xDuQ==
X-Gm-Message-State: AJcUukcPrgKRqwYPYrr7Zrjw6AO6uZYimHVbJ046EM3k285Rd1Zi1p6G
        9PNcWa5L8LH3tOFKgQslOipiYuDC6yj/xt4LGAxOu1aa1VM=
X-Google-Smtp-Source: AFSGD/Xa+sAQl5Gke5SDyZFAttviZaCGCvDp807PS14HDVBkl0mMQCoytT9zeTezBicgPK5R8IjIp/ZYsnJDNT2YZfw=
X-Received: by 2002:a2e:9b84:: with SMTP id z4-v6mr30409509lji.93.1546681320129;
 Sat, 05 Jan 2019 01:42:00 -0800 (PST)
MIME-Version: 1.0
References: <20190104021311.38194-1-rkir@google.com> <20190105090019.GC13941@kroah.com>
In-Reply-To: <20190105090019.GC13941@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Sat, 5 Jan 2019 01:41:48 -0800
Message-ID: <CAOGAQepi+iY7JPH+LpjwMn6xUZTaSOmvkS6bRe=CToPTyoZojw@mail.gmail.com>
Subject: Re: [PATCH] drivers: misc: goldfish_address_space: add a driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi. Thank you for looking into my patch.

> If they can not, then just remove the
> WARN_ON check as it is not needed at all.

No, these things don't happen. I will remove these lines.
