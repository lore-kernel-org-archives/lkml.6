Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F20FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF40A20821
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 06:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sxfmzaPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF40A20821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeJaPNp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 11:13:45 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:35747 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeJaPNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 11:13:45 -0400
Received: by mail-ed1-f67.google.com with SMTP id d6-v6so4518695edi.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 23:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ZZOFFUs936+hSIkanoo8JJtk0Q1HK1cpfw52Y66WUo=;
        b=sxfmzaPwL8r1ouFBdOCqCGmySivp5jY/tzYHO/WvSyEN5eN/gEPDWYkB9iszYVqTtz
         0MX1T2MfmLTmYAOLQydqpEwrHQLiI4oAsdBXCVKPj+2FRkATN1mCPq9XXwHIIRl5ZJBC
         A5ti9YAi+cDd7oqZm2chufqRsHvr9BEo33q2+Xh1cQaaUZ/Y5O56PGlViJrzfOiLPerB
         cuTkuejqxNdgI7ZBnLebAZq5ApuXtfjlnsZxqJbsaDXKjvzPsRAbhxsNuFvCEKFsyxlC
         ngR8FpZtksTZOvJ/gAhvrW5ZMqG8uAqswB1LQuDcmc3eeT1jzk7XoCyVF2sCMWPmbUHU
         +Nfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ZZOFFUs936+hSIkanoo8JJtk0Q1HK1cpfw52Y66WUo=;
        b=SSHJTjw6ygKp49k2bzm7WkQ0JjedYnrKlon0P2znEJtt1cbwF5dSAqc3qwnSRgbN09
         hPq3vngnTkZL4BG4csH2kXGXX+nth6K0vj04hL2ljmhFf/YwuQM0e4kCSLvN6wUMBW+C
         nhXLX1EOZSGnb2oVzg4ClvhV0ztEGzsqQPT5HzUkTnOgsgHVCiYt6UpzDL3E8hyZkD5S
         2NgwF/YYjMry02Pec29XqAn8co102yiohQdsU20kpZMqOnlpI4ctKnz4QvQwaIXRGRnZ
         wLKe2ehpnHcGdwvw3HZB71crwGUS9eKrVlhBnYwGhYuSiByts4nPTfMatPK145oVDVx4
         eL9w==
X-Gm-Message-State: AGRZ1gJFpieiYR7ZkiDBLTSDm9OimrpNdj4dJi1K7Cg1Hl2S8KHH9zrZ
        9fmb5cOIAMP3MxPw8Mqc0pZbiNurqtCI9X1q3A==
X-Google-Smtp-Source: AJdET5emSv4QqoR+QWTDUnJHb7Kf4XO3nJwzuupXozsI9yVdnWLHgiGWS7tUCgJ9S2vyv3cagOkcDSzKGt2H5vcbs2g=
X-Received: by 2002:aa7:c743:: with SMTP id c3-v6mr932953eds.253.1540966621818;
 Tue, 30 Oct 2018 23:17:01 -0700 (PDT)
MIME-Version: 1.0
References: <20180427090045.532014306@redhat.com> <20180427091410.GA25338@dhcp-128-65.nay.redhat.com>
 <20180507024833.GA3895@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20180507024833.GA3895@dhcp-128-65.nay.redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Wed, 31 Oct 2018 14:16:50 +0800
Message-ID: <CAFgQCTvqVX8pNGiWFjv2xfMMHXtrca0-Hgmgy123n=KVOeipkg@mail.gmail.com>
Subject: Re: [PATCH 1/2] kdump/x86: crashkernel=X try to reserve below 896M
 first then below 4G and MAXMEM
To:     Dave Young <dyoung@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I encounter a case where crashkernel=384M, and kaslr is enabled.
During the test, sometimes, the system may fail to reserve region for
crash kernel, although there is much free space above 896MB. It is
caused by the truncation of the candidate region by kaslr kernel. It
raises confusion to the end user that sometimes crashkernel=X works
while sometimes fails.
So can we have this patch to fix the issue?

Thanks,
Pingfan
On Mon, May 7, 2018 at 10:49 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 04/27/18 at 05:14pm, Dave Young wrote:
> > Hi,
> >
> > This is a resend of below patches:
> > http://lists.infradead.org/pipermail/kexec/2017-October/019569.html
> >
> > I dropped the original patch 1 since Baoquan is not happy with it.
> > For patch 2 (the 1st patch in this series), there is some improvement
> > comment from Baoquan to create some generic memblock iteration function.
> > But nobody has time to work on it for the time being.  According to
> > offline discussion with him.  That can be done in the future if someone
> > is interested.  We can go with the current kdump only fixes.
> >
> > Other than above,  the patches are just same.
>
> Hi Andrew, do you have concerns about the patches?  It has been used for
> long time in Red Hat kernel, since people do not object them, could you
> pick them if no other concerns?
>
> Thanks
> Dave
