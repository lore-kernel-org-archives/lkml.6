Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A9FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA8E20685
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 11:14:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5LDYAcg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA8E20685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727239AbeIZR00 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 13:26:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:46323 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbeIZR0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 13:26:25 -0400
Received: by mail-qt1-f193.google.com with SMTP id h22-v6so8755480qtr.13;
        Wed, 26 Sep 2018 04:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T2QwmtGowTCamIEGtEgBGuep7x/hEYpcq79fjd3AIDQ=;
        b=a5LDYAcgphPS8ydeCju2jco38wnF6jjPcWNkQTYbCKyK3QripUKjXHGOdZ/+hRogAc
         LptydAp1+EmxW/snizrFh5fPqNU1/Lo3mQh6sIUMm1cSb2mnt+PA7DByPhF5Fn9FuE89
         avpMlJESkjsYWKFH+ej44fSnMEUNnT8DRYXjkyWbThdeNi3Iqik7ZveN7Gri9T8cX4pd
         8sXA2DxTZycAOsJxG3gALQmUAe0tL+nhvdRH1PYn6wtJF1x3NEdCl7b1n76qdjEm6Nfa
         VV9sgCyuJ4lQRPy3fUzj9v2PFqcdPGfMwhcDiYBaB47PQsTbd4W8sa8y5d9GWSk2IiX0
         zbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T2QwmtGowTCamIEGtEgBGuep7x/hEYpcq79fjd3AIDQ=;
        b=gopcOkZ0z9JuATLl88JBmo/234Wx2FK5pk3zZOu8MUbtzIphVulvDBPTPsR28yw2Fd
         WBL4SAES+nf3MzYyuZbuzw7K11J02EOfXEDwsJ+XiVuI9Fkb3aZe8L1VZzg3mpjDIMcx
         nEY6K69NhcUwSb3XCRg4VZKjoEB/2QgUmci+zgYvyZS238ANGHI+jm5Z1OdtwhDvlDl0
         3PilK+tI0BbF30dKIrPBZ8jl81ybpeexudlVEsRCGfZbblcrjD2M5UxvCpVDRGgfenqZ
         n6/5BxqXKCV7YbhnbqKUP5DywoLWDf1zo7y4UYEzw4lcZwN9Yk3CB7eiKi1bmNgVbsil
         MD6g==
X-Gm-Message-State: ABuFfogGQZ9SfjF/wOpJ+RZ/5ADULujWDld4m32IgyDRIIKQq1Q+InB5
        Nwd9Zd3GZg10onQyAH8zeXWv0Wt9eS5tNxsKC0s=
X-Google-Smtp-Source: ACcGV63ELFQOd8FJKyXS7Xq7CQwb9ID8sGpmjWeIYwBBA2aDSkoYHRW0tfcaa6XZyK/24Dg2gGsiMkY3ZWRdFf+UwPA=
X-Received: by 2002:ac8:2f86:: with SMTP id l6-v6mr3968217qta.83.1537960437892;
 Wed, 26 Sep 2018 04:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20180921014421.30804-1-paul.gortmaker@windriver.com>
 <f401b6fed813afb86f5442c7707bf9fb@piie.net> <CAHp75Vd3L2BQX02NQVM=ZTMkv4WpM=AXXVMyG0Cyc0SjjUU55g@mail.gmail.com>
In-Reply-To: <CAHp75Vd3L2BQX02NQVM=ZTMkv4WpM=AXXVMyG0Cyc0SjjUU55g@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 26 Sep 2018 14:13:47 +0300
Message-ID: <CAHp75VecQvirM=XXFCHQ7qn_hh+ix2u2HFq9u+JOOzcmjeRrdQ@mail.gmail.com>
Subject: Re: [PATCH 0/6] platform/x86: acerhdf: new BIOS string, better
 modparam handling
To:     peter@piie.net
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 2:09 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Sep 21, 2018 at 9:20 AM Peter Feuerer <peter@piie.net> wrote:
> >
> > Hi,
> >
> > 21. September 2018 03:45, "Paul Gortmaker" <paul.gortmaker@windriver.com> schrieb:
> >
> > > I came across this older netbook over the xmas holidays, and noticed the
> > > acerhdf driver wouldn't load. Turns out the BIOS string was too new,
> > > and not listed in the driver. There were module params for overrides,
> > > but I found their use isn't quite clear without reading the source.
> > >
> > > Here I clarify some of the module parameter usage, and then add the new
> > > BIOS string, so they won't be needed for this particular platform. Some
> > > probe code is also shifted out to be __init to reduce the driver size a
> > > bit. Further details can be found in the respective commit logs.
> > >
> > > Since it was months ago when I created these patches, I retested on top
> > > of tree to ensure things still work, as can be seen below.
> >
> > Thanks a lot for your work and this set of changes.  This improves quality.
> > I reviewed all 6 patches.
> >
> > Reviewed-by: Peter Feuerer <peter@piie.net>
> >
> > Please also add CC: Boris Petkov <bp@suse.de> for review.
>
> Shall I wait for Boris'  tags?

Anyway, all suggested changes look good to me, I go ahead and push
them to my review and testing queue.
If nothing happens during let's say a week, I will move them forward.

Thanks!

-- 
With Best Regards,
Andy Shevchenko
