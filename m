Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015F3C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994132170B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 20:50:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Mb6Vt6FW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994132170B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728387AbeHQXzL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 19:55:11 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:34680 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeHQXzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 19:55:11 -0400
Received: by mail-it0-f67.google.com with SMTP id d70-v6so2539023ith.1;
        Fri, 17 Aug 2018 13:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iy9fYNG2RDCdUnbcROu+aXuUxjqFFhZ4OcfY6FNAEOI=;
        b=Mb6Vt6FWqx1l+RpdCPSqjJkLnrIflZu45btlOLO2NKtemOpJQgELZQZv0l/DBncLEu
         1jvvr2l3o7mSXaiwxhWEO1Zj5mQ9FVCLQns/0ZJqnwMo9CNfc2+9tmK689QVnbFCxRF8
         UtVBaNPyOvE/8eBwCmi+IwznmxXnTR5RKbvR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iy9fYNG2RDCdUnbcROu+aXuUxjqFFhZ4OcfY6FNAEOI=;
        b=VsgHa+fjXJXZaNWDqG67ef2sBR4OjDKmec0dRnU5LILULb3d5DELG6Q9q9z9y9DF57
         dav6T6cNDApajo3PHBGbSVIoalYD5M5LZs8RFAoHzNIwE8o6LnPbahsX7jTq4joM0mNs
         Lnn7w06XepvuwcuI0zTrOfzuDzd2sJggVRxIxJ2lOC176y+U1E7uNl3uO/KEzzhrnQZw
         Huxzg8mBHr9Gm9GKIttvCXPsRcgD1yk82cqyQvK0v/5b18NgXPJdpBdpnQnAQwDszrkR
         lfpi2o6u52E/p6Ooprahp/+FaidunP1FyO1KX8wjNAYyI13mDEKRP0Tm8L+e+nj5udc1
         j3eg==
X-Gm-Message-State: AOUpUlE6sRPXDhNnbRODTo7dZyC9DM6W8R6qZSyFTijW2tlCA5Yv0ca8
        BK19NMNXeOkMwXlhVOT8gzYbZh0jPe1dntcJPnA=
X-Google-Smtp-Source: AA+uWPyHlWsIWlMp4QH/sfSh39oyBFP40t7KvvIiWpNUdS2hKQuO/GQGR+sL70nVqzWzAfaepeFPgH7LxyFyKXyduBQ=
X-Received: by 2002:a24:4c0b:: with SMTP id a11-v6mr25936583itb.123.1534539017465;
 Fri, 17 Aug 2018 13:50:17 -0700 (PDT)
MIME-Version: 1.0
References: <20180816215726.GA20526@ziepe.ca> <CA+55aFxgT8Hipm6bDrHMZ-nmdk3KZTP=J6D5k10UHTcajXAEHA@mail.gmail.com>
 <CA+55aFxD-Ua_jrrD1X6Y0Wd2gftP9=UVaa0uS=gi53zEEEAf3w@mail.gmail.com>
In-Reply-To: <CA+55aFxD-Ua_jrrD1X6Y0Wd2gftP9=UVaa0uS=gi53zEEEAf3w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Aug 2018 13:50:05 -0700
Message-ID: <CA+55aFyGLKSzS8O3m4JaE69wUm03tGOf+507jCCViTRQaGBGxw@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull RDMA subsystem changes
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 12:44 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Ok, everything but the max_sge thing was trivial. I just took yours.

Oh, and doing the full test compile, I notice there  are new warnings.

That is *NOT* ok.

The whole "x is deprecated" is not a useful warning. If you can't
remove something, making it a reminder for yourself for later is not
an acceptable excuse for  bothering everybody else with the warning,
and possibly having other issues hidden because by the time there are
expected warnings, people will start ignoring the unexpected ones too.

So "__deprecated" is for stuff that really isn't used any more, to
catch possible new users. People have tried to use it for anything
else, but it's always  been a much bigger pain than it is worth.

I've considered just removing the whole deprecation infrastructure. It
has never really worked. Either its used, in which case deprecation
warnings only hide real issues, or it's not used, in which case the
function should just be removed.

               Linus
