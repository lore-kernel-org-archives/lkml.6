Return-Path: <SRS0=szhz=OQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1839C07E85
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:18:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FD132083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Dec 2018 16:18:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD132083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbeLGQS3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Dec 2018 11:18:29 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:35032 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726041AbeLGQS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Dec 2018 11:18:29 -0500
Received: by mail-qt1-f194.google.com with SMTP id v11so5065527qtc.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Dec 2018 08:18:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Df634iB6rDrlCHdHrxVJhVDr8O/j4jT7pr9VYF/WG3Q=;
        b=gipceuqJk0zFs1zpb6VvlJuO+pkwaAwvYhM6WIaTdG5f1hsTTAFoc9isf0BNorkIfP
         n92VTBxyhsstA/YNzeCy2rkz8LjevyyTieuUAMVFaY+CfH0gunMtXwmjmOl24eiCEJlt
         2kuzpUtnBeYEEvTK9CuCpdq05Za4SwJ5tQcf4EHHIoHpYorsJwd+xWefkywRT87/Re2E
         92PLwRZeSiPLVX99Y7up/qkaHn1A8k86BILEVj8BRkxM+Il1zqwSshWO/0C0NsA03eHZ
         6fTpDtxYUW9lppczCWQSsUX9PnzwNGBdITtYRt8/yUvFCvOfcCzPDAdss8qgECrhM/+z
         toKA==
X-Gm-Message-State: AA+aEWYHF825q1ePAYvZSlRt8FUiGPbyvGro8f3V2S2YnbwUACTHp8VC
        Bhr2/lnXEZ73DwjEhmdg/B1Ho/1tIumc0JBKT86BRA==
X-Google-Smtp-Source: AFSGD/VNfuIimVt0mZQVIjbN6yUaJQ5CG+5TLWMsAn9nB5p93cEPUiOysgVkMYq8LChqemznolEXlqZjoeyf6YaVNYM=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr2607617qtl.343.1544199508310;
 Fri, 07 Dec 2018 08:18:28 -0800 (PST)
MIME-Version: 1.0
References: <20181205004228.10714-1-peter.hutterer@who-t.net> <CA+jURcugFhSt9GGRZELQUCnupOf2Ns96Ao5ZruWfVtq=z_7ytw@mail.gmail.com>
In-Reply-To: <CA+jURcugFhSt9GGRZELQUCnupOf2Ns96Ao5ZruWfVtq=z_7ytw@mail.gmail.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Fri, 7 Dec 2018 17:18:16 +0100
Message-ID: <CAO-hwJLO8o-nZ4H_it5q1fm4YQQBmoGvF2vSmBft3WiGdDx+JA@mail.gmail.com>
Subject: Re: [PATCH v3 0/8] HID: MS and Logitech high-resolution scroll wheel support
To:     hcutts@chromium.org
Cc:     Peter Hutterer <peter.hutterer@who-t.net>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 10:57 PM Harry Cutts <hcutts@chromium.org> wrote:
>
> On Tue, 4 Dec 2018 at 16:42, Peter Hutterer <peter.hutterer@who-t.net> wrote:
> >
> > A full explanation of why and what is in the v1, v2 patch thread here:
> > https://lkml.org/lkml/2018/11/22/625
> >
> > v3 adds a better commit messages, m560 REL_HWHEEL_HI_RES support and a patch
> > moved in the ordering. This is a full patch sequence because Benjamin's
> > magic scripts struggle with singular updates ;)
>
> I've retested with the same Logitech mice as before, except for the MX
> Anywhere 2S, which is currently not available to me. So, for
> reference, that's the MX Master 2S, Performance MX, M560, Anywhere MX,
> and the M325 (to check low-resolution scrolling).
>
> Verified-by: Harry Cutts <hcutts@chromium.org>

Thanks everybody, especially Peter for respinning and re-writing the
series, and writing the tests in hid-tools.

I was a little bit afraid when I checked `libinput debug-gui` as the
low res cursor was not moving if I were to scroll back and forth of
just one notch. However, checking debug-events of a non high-res aware
libinput showed that the low res wheel events were correctly emitted.
So I guess this is a debug-gui issue.

I have now queued this for 4.21. I do hope this will be smoother this time.

Cheers,
Benjamin
