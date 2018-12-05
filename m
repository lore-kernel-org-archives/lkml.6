Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93FE9C07E85
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58B0F214E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 10:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rk5DwmnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58B0F214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbeLEKEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 05:04:48 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40049 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbeLEKEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 05:04:47 -0500
Received: by mail-qk1-f193.google.com with SMTP id y16so11465340qki.7;
        Wed, 05 Dec 2018 02:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0H82vPBHxXDvhII49rdh0+2yut/3tmCh5GZcaw8Ltk=;
        b=Rk5DwmnVPbGgQ9Vmf8Ol07i+Q3CL++BBW0zkTduOIp1Owpw1EONnzT7+WsNx0FGzJc
         iyeCtwzHDUvFLdWQBjoTPVXGpc/C/S3dNImx01JqzwqsC9txfVTvpbl4pfwgzJyDUFzf
         G9tPlK61RpK3ymmXr6tLwP51KCcdQj/UkBDWh22VKKLyiNUBOtUXWH+ruqt9YSy488DM
         4PZP63S3fEktavUfQ8/gsoWzqNR34vKyJht01OxM6GkdWiAWDtUMyY75BwIi329uK7Rg
         hHTkDzN7peJLxfUJz1MzWi3sm7UmPnWNVvUz2EICndQuDXQoV22HP+3hrrUlEvTTK1Ml
         gdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0H82vPBHxXDvhII49rdh0+2yut/3tmCh5GZcaw8Ltk=;
        b=cSb7nTZ18U6QnS1yup+vm5yq68sseuTjWchvUkmCxoNbF3TtmOU0fR3N7X7ZxjK35z
         /ScmZ/QbjlzrBUkzX7+wC/fwWCkSWVCz5qR7Ei9x6zSEma3LLQVix5uuoHwD01fAWz4g
         NSXNAvr4kPj3n1OoQmOM27axL834mTIxZnc41jg+o8OMkaYBpCOqruAtCY+SdCrTwZ/W
         2DG/3ojVrvI0Jry8c+iMHyuDaUjPC9y2I0hU4RAT0CStp7lDTTo3pQ2zkcFwwEDuaGr0
         /Z2uEZNIxGtDcZVVeH/8LExnrvHW1tuYR20foL9faSBjsd9/yWOdbegA/Hgi/9fvHwFF
         tzyQ==
X-Gm-Message-State: AA+aEWbMNNxpQ9lTzAPrNUUesmRF2rKXcJJHlRM15uZyFd73TGMuIMVh
        0+Y1fAN5xGB9PzgzsCschj5wmikENKmunlgOFs0=
X-Google-Smtp-Source: AFSGD/UT6Ut5ODCwmPrtKEuyI2RCsVF7+Zx45zkSmqsT/hk72i++S/1omsoFDvZZ+o4dZNlDsStU2enXN8ZqqiISi8c=
X-Received: by 2002:a37:6005:: with SMTP id u5mr20667093qkb.219.1544004285328;
 Wed, 05 Dec 2018 02:04:45 -0800 (PST)
MIME-Version: 1.0
References: <20181201155229.8532-1-tiny.windzz@gmail.com> <CAHp75VdEbr9YfaCgHXNqScZC-KMobF2fU8rZb29nhZPBJvm2gg@mail.gmail.com>
 <CAEExFWvRFrS-ZTSkrS5Npe7g-rxtxfCfk+AyTz00Lx4oAWhQ_g@mail.gmail.com>
 <CAHp75VcSVEakAK4MeoG8zA7MaCWNoL2fOr48iFmxTsjbBpa5XA@mail.gmail.com>
 <CAEExFWtE7Yi8D+Dr=J7B3zqBRet0AX=ABHnUrJkZ2LO3aHdNeg@mail.gmail.com>
 <CAHp75Vc7Xfqnid9WLvQMPPWcFnRG0T4ZoHweA6Q-1ypWn29J2Q@mail.gmail.com>
 <CAEExFWso=uBKj4geVTr2zWOd74V1p5EWq=7r6AATSPh63MQ=mg@mail.gmail.com>
 <CAHp75VcXO0YNd32PVfk+BE68+OUCy=THNi9buU2Wu=PUZhPt8g@mail.gmail.com>
 <CAEExFWtxJrGnoCq1_Nx3uMCW009Qe3LksG4e10s6nW3=p=UWiw@mail.gmail.com>
 <CAHp75Vd1Nzd+CDArk+26vwJvq=rULXxOHfq5rQEQjByJtWjH9w@mail.gmail.com> <20181205084540.GA20250@raj-desk2.iind.intel.com>
In-Reply-To: <20181205084540.GA20250@raj-desk2.iind.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 5 Dec 2018 12:04:33 +0200
Message-ID: <CAHp75Ve-E38KpO865f1rffAD1cSei5GFbBhzh2gg0h=Fg-h_Tg@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: convert to DEFINE_SHOW_ATTRIBUTE
To:     Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc:     tiny.windzz@gmail.com,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        David Box <david.e.box@linux.intel.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 5, 2018 at 10:56 AM Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:

> Hi Andy, i was thinking of having it split into two patches as it touches
> two unrelated files. What is your opinion?

If it is the case, I agree with you.
Since patch didn't applied clearly I even had no chance to look at it closer.

> Functionality wise, it looks good to me.
Thanks.

-- 
With Best Regards,
Andy Shevchenko
