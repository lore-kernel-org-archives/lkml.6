Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718B0C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:02:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 13F64214D5
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:02:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SK67DrW+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13F64214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbeIZJNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:13:13 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34631 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726213AbeIZJNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:13:12 -0400
Received: by mail-wr1-f68.google.com with SMTP id t15so17424700wrx.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 20:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WeaFRzxU94eXXuuaIPfbkkQ53C9lwaGkIdzJIootau8=;
        b=SK67DrW+L5tHXU4KIhCPkZsqTCQ05HVXkTLJwn+I1loKpx6ZiKfGQZqj6R32mVue/l
         IQ6YQ7XlOSr6Bwv59C3zMkaQ3+udmFylHlchNBziIMpeyXvx0u6/0n67XFFXN9hSB66r
         nqjorhKLl6zdkIh8DBaJcbjDKObIoxs+klqBs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WeaFRzxU94eXXuuaIPfbkkQ53C9lwaGkIdzJIootau8=;
        b=FtuFarQLwp/owK9RfPqlUGOY4ZY3uabF+//QIKL34Qlw2pZTgcLmMEEM9tZvfIIZrh
         Hub1Z2VI37PxpkiJRkE1KirdHPUknjh2G8pbAS44E1kWlRmU/eD5+YVdpiszCGlm+xp0
         HWMmKb+StZNhfV08vZGRBL9mOJjCWXoJs4RLy+lNWNiheW4D8hpFGFMWqlXgZwq9j+iH
         nPDMeQDRHSJglOjqYDRfdtiOBcVNs4E6zONbuDBIXG8w/xF02KD2E732A9GoJK/4GoJx
         hcEhRBQbYHsEoit94DUYcylOSsjEhJbWFD1MO8qMbdQvWkljyGlM3hCE9M4TGBjRevF9
         al0A==
X-Gm-Message-State: ABuFfoiTPsTRA7fuPvWsteWhXe+7DC7C/16KNAtPHWMztQAUPxmY5ixl
        26qcmpajlehF40DohuikMtj3gt1jIw49gq22wkFb+Q==
X-Google-Smtp-Source: ACcGV61q4+WaPiiKXu5BjKY3m5HXMzwlhQVWYsJmqwLlR3NIlEE3O0dBPQAnLNxQm2H4L92PNt6eOaQ5S4d9m4g2rGo=
X-Received: by 2002:adf:e211:: with SMTP id j17-v6mr3295560wri.205.1537930950273;
 Tue, 25 Sep 2018 20:02:30 -0700 (PDT)
MIME-Version: 1.0
References: <20180924113114.334025954@linuxfoundation.org> <20180925090733.GB21224@kroah.com>
 <20180926002857.ajqqxi2qcfcwsg7g@xps.therub.org>
In-Reply-To: <20180926002857.ajqqxi2qcfcwsg7g@xps.therub.org>
From:   Rafael Tinoco <rafael.tinoco@linaro.org>
Date:   Wed, 26 Sep 2018 00:01:53 -0300
Message-ID: <CADtBP2Do8u9Em2kUeb9nuux+kD=sjUpQ2XLetYO3vrdPxiYNKA@mail.gmail.com>
Subject: Re: [PATCH 4.14 000/173] 4.14.72-stable review
To:     gregkh@linuxfoundation.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Cc:     ohad@wizery.com, bjorn.andersson@linaro.org,
        linux-remoteproc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Suman Anna <s-anna@ti.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

> > > This is the start of the stable review cycle for the 4.14.72 release.
> > > There are 173 patches in this series, all will be posted as a response
> > > to this one.  If anyone has any issues with these being applied, please
> > > let me know.
> > >
> > > Responses should be made by Wed Sep 26 11:30:10 UTC 2018.
> > > Anything received after that time might be too late.
> > >
> > > The whole patch series can be found in one patch at:
> > >     https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc1.gz
> > > or in the git tree and branch at:
> > >     git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> > > and the diffstat can be found below.
> >
> > -rc2 is out to resolve some reported problems:
> >       https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.72-rc2.gz
>
> -rc2 looks good. There is a problem on dragonboard during boot that was
> introduced in v4.14.71 that I didn't notice last week. We'll bisect it
> and report back later this week. dragonboard on the other branches (4.9,
> 4.18, mainline) looks fine.

As Dan pointed out, during validation, we have bisected this issue on
a dragonboard 410c (can't find root device) to the following commit
for v4.14:

[1ed3a9307230] rpmsg: core: add support to power domains for devices

There is an on-going discussion on "[PATCH] rpmsg: core: add support
to power domains for devices" about this patch having other
dependencies and breaking something else on v4.14 as well.

Do you think we could drop this patch, for now, in a possible -rc3 for
v4.14.72 ? Dragonboards aren't being tested, because of this, since
v4.14.70. Hopefully it isn't too late for this release =).

BTW, I have just tested removing the commit from -rc2 and the board boots okay.

Thank you
-Rafael
