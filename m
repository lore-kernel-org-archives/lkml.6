Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7B84ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:30:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C81A20854
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 13:30:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U9tAlFIb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C81A20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbeGUOXe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 10:23:34 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33390 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbeGUOXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 10:23:33 -0400
Received: by mail-wr1-f67.google.com with SMTP id g6-v6so13690649wrp.0
        for <linux-kernel@vger.kernel.org>; Sat, 21 Jul 2018 06:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p81dHlAV1syXX2q7OZfs+TlUnB+HDaqhluZ35K3vrBw=;
        b=U9tAlFIbNFLTxWijKiEd9oWUyqkz4vcwHUQTr79PbLEyt8IG6hVzuxTl+mAJRzHmac
         HgUZZZ1OxYLVUG+/3PTLex0ugx96dUxiDp8ra5Xe6aN7o35h/KyenNjM3Ga04EcQIVya
         Hr3tROBTzlzINekw+ouLx/Ay9VxhMQpAWafk0tCOd1TYocSxjS2bEq75kNeD/x3UMIE8
         OZZ2NWpQbHgij6ELiJqv8/uLJFLU/CBuw4R+nNv0ecO0oKg6Cga3418xP5asngSCR1LS
         jpMMJTfP/5Px2nlxiZFdc6uwdBiz/nJ+w0WeJ5ytM6xBtJleV6uz8GLQpauSVe/cdkQs
         Cw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p81dHlAV1syXX2q7OZfs+TlUnB+HDaqhluZ35K3vrBw=;
        b=W1xIoVzwJ+xBiv7McDK5N74UhFu053ZrHOt+Zg2Y0HZnONHQhrTDEow1RSl7JguyHy
         p0c6rOm1QFABhY9LiPWGEX8HGrRq1DVg/mJnnZVSpUZRTb3CQ/nljfeU2MJSoH0fPITW
         XK9ERReXevLsRWxk1omTmVYv+hTi7NKJ8EDfxcepQphN0l2x+4Rh7KmP44ndIxhCz3n2
         KpBhqfNfHR8M5R8tE1T5AwhYBEQhiuDZaeoqHg7IvY46+P7mLUgWyvwMChG0X5Nf6+40
         3JhHrkVb9zKFDyrKxVVCE6I0hNkotKoxWsMDtsrpPmA+qJOluRNiLoSlvxid3o37r9Rs
         r6WQ==
X-Gm-Message-State: AOUpUlFob+mEmZaLlTgEg+pjp68qx4H/CxRNrbQ+/AHmUylX1iuyD5yJ
        Eke8257SpflhZih2qycXJ12nOlPKsOvzuGJ2YnC7hA==
X-Google-Smtp-Source: AAOMgpeSysTgVZlkjT0cRLWUmUgGkSeaYcWmJuSKbYvpp83KpU0asXJBqEvlWdSZytVYXdF2j4aiMEJ2xsAvWNfJXz4=
X-Received: by 2002:adf:e287:: with SMTP id v7-v6mr4206676wri.139.1532179846115;
 Sat, 21 Jul 2018 06:30:46 -0700 (PDT)
MIME-Version: 1.0
References: <20180721125713.88501-1-toddpoynor@gmail.com> <20180721131720.GA4290@kroah.com>
In-Reply-To: <20180721131720.GA4290@kroah.com>
From:   Todd Poynor <toddpoynor@google.com>
Date:   Sat, 21 Jul 2018 06:30:33 -0700
Message-ID: <CAAW3YpbJADPRYcwZFcHMPcbOWqQmdqiXbvPrJwBxC0=uCo0aFw@mail.gmail.com>
Subject: Re: [PATCH 00/14] staging: gasket: assorted cleanups
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     "toddpoynor@gmail.com" <toddpoynor@gmail.com>,
        Rob Springer <rspringer@google.com>,
        John Joseph <jnjoseph@google.com>, benchan@chromium.org,
        devel@driverdev.osuosl.org, frankhu@chromium.org,
        LKML <linux-kernel@vger.kernel.org>, groeck@chromium.org,
        Dmitry Torokhov <dtor@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 21, 2018 at 6:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Jul 21, 2018 at 05:56:39AM -0700, Todd Poynor wrote:
> > From: Todd Poynor <toddpoynor@google.com>
> >
> > Various fixups arising from the chromium review of the gasket and apex
> > drivers.
>
> Didn't I just apply this whole series?  Why resend it?

This is another round of cleanups from the chromium review, I can
update the subject to make that more clear.

>
> confused,
>
> greg k-h
