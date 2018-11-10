Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDEAFC43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:29:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1F9F20840
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 06:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mekR8m2i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1F9F20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728918AbeKJQM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 10 Nov 2018 11:12:56 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:44323 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbeKJQM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Nov 2018 11:12:56 -0500
Received: by mail-lf1-f65.google.com with SMTP id z13so2847032lfe.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Nov 2018 22:29:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=++QUv3iBN4w/trCtCZ4eLUVDxEyVFLOcwF/7UJEh3G8=;
        b=mekR8m2ixvzaqlEEvyS5iV1NrCo45tsLnNhc26WyxzECQTZNuyzz1fepIEa4ES0K9W
         LmMOFzSX9AQkXqtYUR+d9UiMKS1BIzD+7zK6RQtfhaoZ2yjmU/GqIzcp/X/pVMZ1ffbh
         ytb77cLlruN1DPY7pyrZzHXMJIgdxTK4FmzzQ7ZiTj0e3o0NChqUxWh5ehxH6nyXV2Jz
         FgGn/zlYhW+rVFjdP0WfaBQzGCEwNERy9iF/Zre98YOPjBZK2fI8Y5HK0ynwL2qzKuSl
         nbQekzYR1eOYtQpfnQd5P/7hyubLgtoSNid/d/hmk8ar3iGF1E/HO/wBdDfAKjN3lC8E
         SngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=++QUv3iBN4w/trCtCZ4eLUVDxEyVFLOcwF/7UJEh3G8=;
        b=GaeZxtQ3H2BG3ZW5/MYBfLY+K7veRsRLNDOklEf3w4qugYYukyPv2SvimgWBamRJnY
         H1jYdnkrXQejkP3YbjhH9MsJyPVysWEgfAE3kBRG6laGiuTNWbreMA15Hbj0g2J1Kvcp
         /RmqXrpNtpxsVUCtG+3rqMvsUUnNYNErT7foLdXS36KyexNJYaET23e7WkYSM3+jSi8H
         KfDiGr3AhAi0LyHfB2QxPHd9EInO/4Ns+fTM2Tz5dQPHAotZliudw62UaWWEMpdiBuq5
         2wX6whJznOmQ+sWLid9ryUca0zSPVKs+Uhydr0n3i6Kt9ADH67sESDGKst9FIMaCIBnk
         ADIQ==
X-Gm-Message-State: AGRZ1gIhVl5J9s2Wj377olzA2dhivKWN7BWWy53/G4ttwfCdDIwr6r+o
        lV8D6bn94DrijivhimOXpUamxe5RONH050LGcnQ=
X-Google-Smtp-Source: AJdET5f+GIQWN+LHZ7y2caOpHgs3DFJgwut8JC9s/TwptBs9bC8ShkuU5Ql3u69sMwMLR65/+METR+Y0hciGaPZuoFg=
X-Received: by 2002:a19:ee08:: with SMTP id g8mr7256637lfb.72.1541831343766;
 Fri, 09 Nov 2018 22:29:03 -0800 (PST)
MIME-Version: 1.0
References: <20181109041425.GA2950@hp-pavilion-15-notebook-pc-brajeswar>
 <201811092225.ABFKAgV4%fengguang.wu@intel.com> <20181109144724.GA20089@kroah.com>
In-Reply-To: <20181109144724.GA20089@kroah.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Sat, 10 Nov 2018 11:58:51 +0530
Message-ID: <CAFqt6zbHOBmN44=TWX4E_UM0-4=3Dm9qg=DQyLBKpcL9SrwnLQ@mail.gmail.com>
Subject: Re: [PATCH] drivers/android/binder.c: Remove duplicate header
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        kbuild test robot <lkp@intel.com>,
        devel@driverdev.osuosl.org, tkjos@android.com,
        Sabyasachi Gupta <sabyasachi.linux@gmail.com>,
        linux-kernel@vger.kernel.org, arve@android.com, kbuild-all@01.org,
        joel@joelfernandes.org, maco@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 9, 2018 at 8:17 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Nov 09, 2018 at 10:40:14PM +0800, kbuild test robot wrote:
> > Hi Brajeswar,
> >
> > Thank you for the patch! Yet something to improve:
> >
> > [auto build test ERROR on staging/staging-testing]
> > [also build test ERROR on v4.20-rc1 next-20181109]
> > [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> >
> > url:    https://github.com/0day-ci/linux/commits/Brajeswar-Ghosh/drivers-android-binder-c-Remove-duplicate-header/20181109-154717
> > config: i386-allmodconfig (attached as .config)
> > compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> > reproduce:
> >         # save the attached .config to linux build tree
> >         make ARCH=i386
> >
> > All errors (new ones prefixed by >>):
>
> <snip>
>
> Yeah, I was right :(
>
> Always test-build your patches.

Sorry about it. It was a mistake from our side.
