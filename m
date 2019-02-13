Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EE7C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B937F222BB
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 09:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIMY0KrK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391087AbfBMJBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 04:01:39 -0500
Received: from mail-yb1-f180.google.com ([209.85.219.180]:35220 "EHLO
        mail-yb1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727206AbfBMJBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 04:01:38 -0500
Received: by mail-yb1-f180.google.com with SMTP id v2so634958ybm.2;
        Wed, 13 Feb 2019 01:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nOxAq2jgYrMbNTBlWFr73Rc+ViApmre//M8IaWoP5S0=;
        b=VIMY0KrK4iSNyI1HGmm4jPV9TrQ8QlHaQh+ToWWJjoo8CPj15twvFmLLdUrKhTAEuC
         biSzvOM4rUQMNMRSLiF8FC5/cdnQm8YeFA83kwKe9KrxnJpJ/H1JqWy0QIeMiUnEFmOH
         AoGIq6s8Hf8lnYLG+tbwxlDl3CX3zGKbHSkAvuelpni4+TJUfm3tTR/sEgAK5F7qCN7J
         X+B+k2wB5QutnnTROe8xnwDeO0DIPSvEa3LTswwjR/YISSO4/IgEqSio+8bUdv5vFCCy
         KuM/DtIYgwC5ImjMq7rtXguacejHqDPZc+bsS2Te3hQ0t9AREltbQK1D8ba7bAqaH85v
         k4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nOxAq2jgYrMbNTBlWFr73Rc+ViApmre//M8IaWoP5S0=;
        b=CUkdbqv50GTUcxGmRjdNST62SVIA45LNwRQYASxfLyuYZJXX+Fm2d/mqoh6AybvDgB
         62Bfl+v86TR5kVDfJVGPLbtW4pfgfCD69tLIhnYA4gJrsGWUdnxpk1DzVXfQGwU8B+ZQ
         m0o/ZZx1D6VTMF6MYxads+7+DTUaCRJFh0mSAPTZvtR1PTW5SxDY0m5y983D4PbffsR6
         241YSpEnvrdGjE87nwy07MRn0yT/Rb2a+UV2ZK9RrzxDz3xg5NQFuhQ1fXZ4m6tC3vD1
         j9QLHV4+HIW2UjLtkVRj7DFB51iDFspH8PkL74IStAow4SzEoYsGh8gMli8HnwsArENj
         4mlA==
X-Gm-Message-State: AHQUAuZcEJTbtktCqkmBMdawBaZ0fWCI2VZboQdyFN+/dLqns0pxuEjm
        hjikQzlo1VkyS/RZfRJW/vHQ5LwFN6rGFh89dVQ=
X-Google-Smtp-Source: AHgI3IZIW2qaSfMP7UCdKZdSY60xgXrV4aT4hPX+oDKBJgV5JMHXw6PQsG1u07u6EgbYCN/CakP8YSOXqaenfqEulHM=
X-Received: by 2002:a25:9c09:: with SMTP id c9mr6796704ybo.462.1550048497909;
 Wed, 13 Feb 2019 01:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20190212170012.GF69686@sasha-vm> <CAH2r5mviqHxaXg5mtVe30s2OTiPW2ZYa9+wPajjzz3VOarAUfw@mail.gmail.com>
 <CAOQ4uxjMYWJPF8wFF_7J7yy7KCdGd8mZChfQc5GzNDcfqA7UAA@mail.gmail.com> <20190213073707.GA2875@kroah.com>
In-Reply-To: <20190213073707.GA2875@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 13 Feb 2019 11:01:25 +0200
Message-ID: <CAOQ4uxgQGCSbhppBfhHQmDDXS3TGmgB4m=Vp3nyyWTFiyv6z6g@mail.gmail.com>
Subject: Re: [LSF/MM TOPIC] FS, MM, and stable trees
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Steve French <smfrench@gmail.com>, Sasha Levin <sashal@kernel.org>,
        lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 9:37 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Feb 13, 2019 at 09:20:00AM +0200, Amir Goldstein wrote:
> > I never saw an email from you or Greg saying, the branch "stable-xxx" is
> > in review. Please run your tests.
>
> That is what my "Subject: [PATCH 4.9 000/137] 4.9.156-stable review"
> type emails are supposed to kick off.  They are sent both to the stable
> mailing list and lkml.
>
> This message already starts the testing systems going for a number of
> different groups out there, do you want to be added to the cc: list so
> you get them directly?
>

No thanks, I'll fix my email filters ;-)

I think the main difference between these review announcements
and true CI is what kind of guaranty you get for a release candidate
from NOT getting a test failure response, which is one of the main
reasons that where holding back xfs stable fixes for so long.

Best effort testing in timely manner is good, but a good way to
improve confidence in stable kernel releases is a publicly
available list of tests that the release went through.

Do you have any such list of tests that you *know* are being run,
that you (or Sasha) run yourself or that you actively wait on an
ACK from a group before a release?

Thanks,
Amir.
