Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217E3C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA0A920811
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 00:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kudzu-us.20150623.gappssmtp.com header.i=@kudzu-us.20150623.gappssmtp.com header.b="WFeJjedJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA0A920811
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kudzu.us
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728527AbeLMA0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:26:06 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:33198 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbeLMA0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 19:26:06 -0500
Received: by mail-it1-f193.google.com with SMTP id m8so14994201itk.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 16:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BNCWB2j/mOsS5wh7iHEhoV5iEvYN25YQOiBAMC8icO8=;
        b=WFeJjedJaoYAcFsE7AbFuoXJqBqTe2wYNnWQWTDoTwru+Fmx5tQnT4I11zLdv2vgaX
         XtFuYpskFcs5AEKV4A7wwcfrn/1GJstc1BpkQmgqSGcFPE5IU9UqiGISvwe0IG5RZSvw
         tC8KeaC/Q2HkUzE9W0yXtA76ttVpmNIpSxl9b7QQ8M/iVYPavJzvPFciQ+xdBClvAeOg
         BUQhBgp+/4KEXjLOU2TlLRK1aBnslxPEA95/qV10eMayoT+gljVpF5ddhW2f0hRmB2wp
         ZmgrVRhWvPTpx6+1ZoxtnJEs+XXXXXuAUSY+0drXAHRZCmxZmCdTVlwt/KFEFTAZrT7O
         jdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BNCWB2j/mOsS5wh7iHEhoV5iEvYN25YQOiBAMC8icO8=;
        b=Y6+DB7A+NT0f6iNCKfqdepwM2ifyprO48R3uORofL1i45md5Nyq/vowAczUxIrPgeU
         WzSEDlsuc6m4GMRptsNIrPvUj8jVMvrR2C6u61OTXjT+6YlkT8D6JX9F04lpRGeNb+mI
         2T9vPoYV6wQGImMhy7Hv3372cKmHXjwyFNNyByR0TR+Ayee1qCeh34oUmjfN9g0AhMrd
         aYddsEEx9SXSUUhR0bq7zw7QC2M7szeI0Xtbe/zvChMlk22jlT7SHlMgT+3RolXbJQrL
         24ROb44iPIXv6upGmOcu+HTNzk66aKOazyS3+QFHmvmQsr/aYdQlZetRVhnZAvcnSHyC
         pcJQ==
X-Gm-Message-State: AA+aEWYZ2amVg3C9kFgQbTjUA9q6rIrZ5+dLZMcZXB67JBejlgxeft6r
        pi2Eqd/rowF/wk0euoEc/HBJyALy1cDEihPCJa7rHQ==
X-Google-Smtp-Source: AFSGD/WL2CReQnV26bVrp9aiuI679sCz5ebzIYni0oHETsGJYkh+3q6ktrLBclhp35dOlHt3kD2uaDsUHTwJC1yBzwQ=
X-Received: by 2002:a24:168f:: with SMTP id a137mr8712919ita.71.1544660764980;
 Wed, 12 Dec 2018 16:26:04 -0800 (PST)
MIME-Version: 1.0
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
 <CAPoiz9yN9zHXxyuwmopfSwBLGr39bQ1SJjGq_ku-w_b9V13OFQ@mail.gmail.com>
 <f22b6112-920b-37f1-68fe-f43164a18f05@deltatee.com> <CAPoiz9xesBdtgVg1UGF8LuD28tjMp6VpVuHVjdwcWJq93Phi3w@mail.gmail.com>
 <ff7019a0-bac2-2de2-d06c-d54a82286b90@deltatee.com>
In-Reply-To: <ff7019a0-bac2-2de2-d06c-d54a82286b90@deltatee.com>
From:   Jon Mason <jdmason@kudzu.us>
Date:   Wed, 12 Dec 2018 19:25:53 -0500
Message-ID: <CAPoiz9wB4d6bL9=C9uQWrkeo8PwdXoWN0ridoEyiC1yHAg32Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ntb_hw_switchtec: Added support of >=4G memory windows
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     wesley.sheng@microchip.com,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org,
        linux-ntb@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        wesleyshenggit@sina.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 12, 2018 at 7:01 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-12-12 4:57 p.m., Jon Mason wrote:
> > On Wed, Dec 12, 2018 at 6:42 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>
> >>
> >> On 2018-12-12 4:00 p.m., Jon Mason wrote:
> >>> So, you based your patches on a series of patches not in the
> >>> ntb/ntb-next branch?  Please don't do this.  I see nothing in these
> >>> patches which requires that series, which makes this even more
> >>> unnecessary.  Since these are fairly trivial, I'm taking them and
> >>> pushing to the ntb-next branch to give these more time to be tested
> >>> (due to not being tested on the proper branch).  I would really
> >>> appreciate you testing the ntb-next branch as a sanity check.
> >>
> >> The NTB test tools don't work with switchtec hardware without that patch
> >> set, so there's no way to test the changes without that branch.
> >
> > Then let's get those patches in.  IIRC, I asked you to split up the
> > patch series to be bugfixes and features (or at least reorder the
> > series so I can split it up that way in my branches).  Also, I think
> > Serge had some comments that may/may not need to be addressed.  Could
> > you please reorder and resend (and Serge can comment as needed on the
> > resend)?
>
> I resent a while back and responded to all the feedback. Every patch in
> that series fixes a bug. None of them add features.

Per https://lkml.org/lkml/2018/6/12/552, I asked the series be split
up and the comments to be cleaned-up.  You repushed without addressing
this (or Serge's comments), which caused me to ignore the series.
Again, I'm happy to take it as a single series and split it up on my
end, I just need the patches reordered to have the bugfixes I
specified in the front to allow for this to be easily done.

Alternatively, you can rebase and resend them as-is to the ntb mailing
list and we can rehash it out there.

Thanks,
Jon

>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/ff7019a0-bac2-2de2-d06c-d54a82286b90%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
