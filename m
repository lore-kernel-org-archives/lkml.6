Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62969C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:39:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAAE2145D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 03:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/RA4OV5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1EAAE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727343AbeKPNuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 08:50:13 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38753 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726718AbeKPNuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 08:50:13 -0500
Received: by mail-ot1-f67.google.com with SMTP id u3so15048076ota.5;
        Thu, 15 Nov 2018 19:39:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJ6ju7gh6Fyow3jj/W/eZaGGuXcDDGTd1h5CQ/O4+3c=;
        b=e/RA4OV51fN62SQcDkQ2JDP8PisMnL3C5FT+JgCGVQatlEiyNVp+hH8kGnMIgmFyCa
         aHrUnGjpwxOXX0p03fjtNLIzKwdAzYHRdtSo+2n2q8TelncFvPSPFgEgjnILSbeNoCNC
         zhfvhyaIhAPam4hXQvSsfX1T/Lkr/NAwDhcZ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJ6ju7gh6Fyow3jj/W/eZaGGuXcDDGTd1h5CQ/O4+3c=;
        b=idNzsQKWeYV0KEjxMfXaLE6J7ifpq4xijcYMgxKIJXlmp0xX4Wh1ATyococ23Qdzp6
         AVA7Q1K+FEbXAdvUOwenvfmONBu5Qm3zkLmC0qp8b9hhdxIN8nR15X6ixUB/zvKDLhow
         d9fchfQSwu04Wa4hxn/a1IoBjVpf8TjsyC4+Xo4SbXUm3+Gwr3prnmtS1JpPSoWgEbjc
         0es7V0ODj9t8oQg0QCMVBrdty5vUXEmRXhYBkvme7s394klWN8wpSYVN0UkdkWPzVIKg
         R0JOvQqAufkBW8184QVcS0BKDE77YA0aVisTvbSxsu/R3yvGez0LkHUgplqUs1whoCsO
         IgvQ==
X-Gm-Message-State: AGRZ1gK03UqrCZI6gR64gsO+k7QOL4EeyNMpkHgyrpCNnuWtJaPYUUDX
        6QzwMuQV7Ln9JQkFI3YPMkNTrQ+ZdLtFY75sYTc=
X-Google-Smtp-Source: AJdET5dC8fHFsB8934QOq3fYsoq5yZAzoDeRZkKk6qr54M+gYYEnA8jvasxQdhfFYZPVSjsv96VMUBF2xF2G4KeZkK0=
X-Received: by 2002:a9d:7ac6:: with SMTP id m6mr2518619otn.62.1542339572289;
 Thu, 15 Nov 2018 19:39:32 -0800 (PST)
MIME-Version: 1.0
References: <472db11e-49a6-a1ee-e298-791ee1bbb10b@codeaurora.org>
 <20181016141610.639b9000@gandalf.local.home> <accdce6d-8fd2-9f15-d4cd-704cbf0b32eb@codeaurora.org>
 <20181016144123.24c47b38@gandalf.local.home> <7781815e-cba2-9e36-db6d-268298747876@codeaurora.org>
 <20181016150328.3450d718@gandalf.local.home> <c94103d2-ed5d-bf43-fc71-c60e108f303e@codeaurora.org>
 <20181017223334.29ca2837@vmware.local.home> <58d2474c-53cd-e6cb-2d25-db38d1a88da6@codeaurora.org>
 <20181018091706.62310b38@gandalf.local.home> <20181019041740.GB141835@joelaf.mtv.corp.google.com>
 <8a75f2d5-f1bd-504e-b545-ae2e2f61ca8f@codeaurora.org> <20181019095122.0f1c0946@gandalf.local.home>
 <9cafe321-87f6-98a3-3bda-c2f7a3d7fc67@codeaurora.org> <20181019111205.5c8e98e8@gandalf.local.home>
 <1e6cc1fa5263b9edfcf7567d3f9f65fd@codeaurora.org> <38099043-f5ed-6d81-bf94-13f61cfa8507@linaro.org>
 <8f65f83b-8cd9-5e35-c324-30b86390906e@codeaurora.org> <ed648cc5-0748-8bcc-5ebb-ce6dbc7d4fee@linaro.org>
In-Reply-To: <ed648cc5-0748-8bcc-5ebb-ce6dbc7d4fee@linaro.org>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri, 16 Nov 2018 09:09:20 +0530
Message-ID: <CAOh2x=kHQ_PfZqcoDE1+jx-ArMOh4hAFqXxiiKJ9=3JZUySQEw@mail.gmail.com>
Subject: Re: Crash in msm serial on dragonboard with ftrace bootargs
To:     srinivas.kandagatla@linaro.org
Cc:     saiprakash.ranjan@codeaurora.org,
        Steven Rostedt <rostedt@goodmis.org>, sboyd@kernel.org,
        joel@joelfernandes.org, bjorn.andersson@linaro.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Jiri Slaby <jslaby@suse.com>,
        Kees Cook <keescook@chromium.org>, geliangtang@gmail.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        gpramod@codeaurora.org,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        linux-serial@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        vivek.gautam@codeaurora.org, sibis@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 15, 2018 at 4:23 PM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:

> Yes, this is not the solution, but it proves that the hand-off between
> booloaders and kernel is the issue.
>
> In general there is wider issue with resources hand-off between
> bootloader and kernel.
>
> There has been some proposal in the past by Viresh for a new framework
> called boot-constriants (https://lkml.org/lkml/2017/12/14/440) which am
> not sure if its still actively looked at. But something similar should
> be the way to address such issues.

It isn't dead code yet and I am waiting to gain few more use-cases
before I attempt
to convince Greg again :)

Here is the code..

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/linux.git boot-constraint

--
viresh
