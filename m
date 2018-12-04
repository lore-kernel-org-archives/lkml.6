Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E18F5C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0A0520851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 08:46:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0A0520851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725901AbeLDIqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 03:46:34 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40561 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbeLDIqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 03:46:34 -0500
Received: by mail-ot1-f66.google.com with SMTP id s5so14416395oth.7;
        Tue, 04 Dec 2018 00:46:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S0k1toQy8X+pcn8e5FQaDvxoUuVDJ89U+ALoV+0Cvhg=;
        b=ID3lnsK+5R1/9MCfrHlw6e5240kNrA1G1IUzMveo/txDQMmkctbGrH6T2Q/9x6/pnr
         cgwqNIKfRuzYZn7vryUZtU/o+gzdGbXpbEztr2lcFi2aQwrxY5klKTeKmFlU6bi7xBpP
         dPm0k8tAnWB/rKRp1+TniFQjdPjueJt0bTCLWapn5srJBoNKT5aNoLpOtc5Iyam1yzrb
         j5HZXdkIoxdDFFTVjNgTYADr7BXRy9vyLs3mrKR4lHINzgC6bOiifgT0DtP5dCiQq9y2
         /TZMfQiW0Z3rozuxV6N0xurmiN1Vpt/m6kAmF8tuq3J6iBAyazVe1GXZdowdeJLAunE6
         ukhA==
X-Gm-Message-State: AA+aEWbkheyEt2T/psGaohzo9RPzEzBMIcoBlT2McLFXZYseMHLMxkVZ
        cVDO3jsAlMUsKwIKpKDTW4zZrzMWfGNR3tZukdMWTQ==
X-Google-Smtp-Source: AFSGD/XylzhtE7SQ2iUb2Ns1OnMF9p7btTVIqyAfxB+Rn89bilpiyEGAAwUi0h8NPK6hsOXXWV+YVuPjoEFp5ZUD/dc=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr12775466otg.139.1543913193306;
 Tue, 04 Dec 2018 00:46:33 -0800 (PST)
MIME-Version: 1.0
References: <20181130142557.2623-1-tiny.windzz@gmail.com> <CAJZ5v0hPPWx6ZbTPRLRMj_0zSF91ApS3BWgYGj31GqzhX45sYw@mail.gmail.com>
 <CAEExFWuZmcTLF+hFahucUuHzp81OXTxm5sJu_AooCz+jZJUnvA@mail.gmail.com>
In-Reply-To: <CAEExFWuZmcTLF+hFahucUuHzp81OXTxm5sJu_AooCz+jZJUnvA@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 4 Dec 2018 09:46:21 +0100
Message-ID: <CAJZ5v0iApdOc+kgpUrJGSvtmTsXfCFksWg2PsNekOKHaZbffrA@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: nforce2: Remove meaningless return
To:     tiny.windzz@gmail.com
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 4, 2018 at 2:15 AM Frank Lee <tiny.windzz@gmail.com> wrote:
>
> On Mon, Dec 3, 2018 at 5:14 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Fri, Nov 30, 2018 at 3:26 PM Yangtao Li <tiny.windzz@gmail.com> wrote:
> > >
> > > In a function whose return type is void, returning on the last line is
> > > not required.So remove it.Also move the module declaration to the end.
> >
> > The last piece is not reflected by the subject.
> >
> > Also, why do you move the MODULE_ stuff around at all?
> When writing a driver, in most cases MODULE_  are put to the end.
> Why not modify this? it is more in line with the habits of most people.

If you write a new driver, then yes.

But why do you want to modify existing drivers this way?  What value
do you see in those changes, exactly?
