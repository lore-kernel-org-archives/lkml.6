Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60AF6C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2529B2081C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 11:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="Eom9dVq+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2529B2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbeKIVF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 16:05:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:39762 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727537AbeKIVF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 16:05:57 -0500
Received: by mail-it1-f195.google.com with SMTP id m15so2678406itl.4
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 03:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Y7zcvEmrMR7aebBpQCJwpOsJG+lgvUoEtFAQS6mXEU=;
        b=Eom9dVq+WefCA5ZM6xTRNPyKB8vlv9eq4YsR5ig7oPbVtk8/S3voqrSMCeTuVceqhy
         +GkdxvYhWk6GxTrroCpi69diR6wFO2pYXri0oVxE450+kp3KB0Tw8NVQnGUCx/EDtFIJ
         LrwLtAm1O9RQnQtMXhccZkMiB96AWtHaXnlccW+M/pwca3ASy8guXZuBN5OkxJMTIIen
         AyZJnzDcJb4CYa6o8NzyFMi0Pp1rymZ64pB/hfGP11vBVpC64J0dj3fBoLE4e66mROat
         mg82VPHON5UiD2E2CsFCzC4o0aXVbVXgmL0J5W/wxb0voTBPai9qkLPeNOIBpzHXg01k
         YbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Y7zcvEmrMR7aebBpQCJwpOsJG+lgvUoEtFAQS6mXEU=;
        b=AXodkWqBLsn4taaCsgZV1K+E53qCIT6noNysH5yuEm0ooySvBfr4kS0tQoAZKSbiJ9
         VYmftxjN//ik6mEarO9MvY9zk9oFbsbAKt/I1zQQNrKWhfvmfDyFNp6NWCxFZOMYb9+8
         9DG/1MDe2DoS3b1+b8wFlKuEwfYDwnv004BxoXfpY6QDPoExZZNk3lUIq1+xD9ppYHRa
         E2u8lqlXDZ9paJU43oRerK0n//2F1b8Ps5g7zU90i5W0Uh+Mgw7oyY3EyOnQKe+61k68
         RiahcECUwjf1YP26mVI2Wwkui3ndsjpUvj1+brFj4PoggwmZNdb14jhZq9O/RS3QPp6S
         ejYw==
X-Gm-Message-State: AGRZ1gJNz4RvQc5HL9P+EE1g01JvM+tKpSiTf7YgJULbGygZ5LgnYXw4
        vHNWkfmEA9uJNFYKQ3mD9Ela+mD8mimejtltfrc+zg==
X-Google-Smtp-Source: AJdET5dm0lQYmBpbSHmx4ETvF7I6MkHoE7enxE4iEJN837+rWhsvzkx75sRHwZf6zOTaxTYfOqP8G9+8RMlilEeRYcA=
X-Received: by 2002:a24:f44a:: with SMTP id u10-v6mr1945472iti.53.1541762745643;
 Fri, 09 Nov 2018 03:25:45 -0800 (PST)
MIME-Version: 1.0
References: <20181108215129.641434673@linuxfoundation.org> <20181108215129.753982396@linuxfoundation.org>
 <CAMRc=MdckdCj=dwn8J6Y5O1gPPykGrzK50td24_iFOa-MwEEJQ@mail.gmail.com> <20181109111604.GB26335@kroah.com>
In-Reply-To: <20181109111604.GB26335@kroah.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 9 Nov 2018 12:25:34 +0100
Message-ID: <CAMRc=Mep_vQfKjep4Z3Qf_=b5dCkuNqSY7-4RdfkUB96Cc5RvA@mail.gmail.com>
Subject: Re: [PATCH 4.14 01/31] eeprom: at24: Add support for address-width property
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     bunk@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        "Chiang, AlanX" <alanx.chiang@intel.com>,
        "Yeh, Andy" <andy.yeh@intel.com>, sashal@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 9 lis 2018 o 12:16 Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napisa=C5=82(a):
>
> On Fri, Nov 09, 2018 at 08:48:32AM +0100, Bartosz Golaszewski wrote:
> > czw., 8 lis 2018 o 23:08 Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> napisa=C5=82(a):
> > >
> > > 4.14-stable review patch.  If anyone has any objections, please let m=
e know.
> > >
> >
> > Hi Greg,
> >
> > this looks like a new feature, not a fix. Are you sure this should go
> > into the stable branch?
>
> Adrian Bunk asked for it to be included as he said it was a good "quirk"
> support for some hardware enablement issues.
>
> If you think it should be dropped, I'll be glad to do so, but it seems
> harmless to me.
>

Nah I'm fine, it just seemed like it didn't really fulfill the
requirements for stable.

Bart
