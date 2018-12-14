Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6943C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:28:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2569206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 17:28:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZTFSiWra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbeLNR2w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 12:28:52 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46102 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726662AbeLNR2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 12:28:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id t13so3009046ply.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 09:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MWnPJgwsKNPqyFIyZqGRK3rRCDVyBFkQPh3SDdco/KY=;
        b=ZTFSiWraZ6/6FMvPKaL8NuIQyVPjXCi/NYevE+kqMGDNtDxuiWvFJQXTs7Li1UP/MA
         KcM4Gkc7Cs8+1wvBBcuJAoYtKHMewUSEl+DF98AvYWW87RGDCBA/29Nli5Zpth4sstX4
         OyYEVMImarup0joV2lBwxHtyWmBjleWaviVU1aGLONeJLhE3kGsRw79YEJYMpEmW6at9
         SVrAvsrbwNWQULFpu4XiRASxNnty86vNpf8wHA7Adet0EuVT23Wi6huJZjqb/ms6E6+D
         7X37ppSTApPSGZJLsjSIFZiF+oVNBThDUl6BS1Wfla1m+qHaede2GCgBCusfmqAn4+yf
         g7BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MWnPJgwsKNPqyFIyZqGRK3rRCDVyBFkQPh3SDdco/KY=;
        b=WXQahr8oQi9EMDPvlnEEk9ma1n8cfCgjN7Gr5yV0S8D5DEelFQg0rwqkGSzgL2h+1w
         Rovkf+7ezNdUVOsrBXeom+lu4oNlC9FUPk9VP+8qytRcLIQWwMvd4UBMDQnHpbVaqKIF
         yJRxX+BASmtXJCpTHcdO0R2nWMQUJURvUohoNAJeoGf0JuC6nOETBakk2cFsBVJU2i5d
         UyQC/UAPkMF8BN2e5UOvw2ngWnGQQuhfDv5Q4bp9Kj1VsyoK0GWy/y8iBCdMpm3yaoZx
         qmcpB/qnzi0KROGC2CfqX7aA/bIoiFBkSDna967pHtyOiF8S77Yb1rum9stYaou+UurI
         pi9g==
X-Gm-Message-State: AA+aEWZPD+5LV3sJKcBaUANO89Jw4U6x/0obGqPDC+ZOqQcSbd/YmWiI
        SjhVDSVq3GCtBloTX5QVfUXu5oS9
X-Google-Smtp-Source: AFSGD/VN02xNdg0Kq/Mt5KFgrA3cI8kWCWESz/nFpp6yVvFrjHUvYHlnoUeJuzLlFP2T2twWyDzM/A==
X-Received: by 2002:a17:902:264:: with SMTP id 91mr3705418plc.108.1544808531160;
        Fri, 14 Dec 2018 09:28:51 -0800 (PST)
Received: from himanshu-Vostro-3559 ([103.233.116.134])
        by smtp.gmail.com with ESMTPSA id m67sm7325609pfm.73.2018.12.14.09.28.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Dec 2018 09:28:50 -0800 (PST)
Date:   Fri, 14 Dec 2018 22:58:43 +0530
From:   Himanshu Jha <himanshujha199640@gmail.com>
To:     Joe Perches <joe@perches.com>
Cc:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, niklas.cassel@linaro.org
Subject: Re: [PATCH] checkpatch: add Co-Developed-by to signature tags
Message-ID: <20181214172843.GA18703@himanshu-Vostro-3559>
References: <1544792494-15485-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
 <839c1d04000164e27dff9742e3efc3bcff3025b6.camel@perches.com>
 <20181214161604.GA17456@himanshu-Vostro-3559>
 <8ae5c67a5c4516a783579e449313d1d59fe3a47d.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ae5c67a5c4516a783579e449313d1d59fe3a47d.camel@perches.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2018 at 08:27:33AM -0800, Joe Perches wrote:
> On Fri, 2018-12-14 at 21:46 +0530, Himanshu Jha wrote:
> > On Fri, Dec 14, 2018 at 07:52:15AM -0800, Joe Perches wrote:
> > > On Fri, 2018-12-14 at 14:01 +0100, Jorge Ramirez-Ortiz wrote:
> > > > As per Documentation/process/submitting-patches, Co-developed-by is a
> > > > valid signature.
> > > > 
> > > > This commit removes the warning.
> > > 
> > > Your commit message doesn't match your subject.
> > > 
> > > A couple variants have been documented and only
> > > one should actually be used.
> > > 
> > > $ git grep -i co-developed-by Documentation/process/
> > > Documentation/process/5.Posting.rst: - Co-developed-by: states that the patch was also created by another developer
> > > Documentation/process/submitting-patches.rst:12) When to use Acked-by:, Cc:, and Co-Developed-by:
> > > Documentation/process/submitting-patches.rst:A Co-Developed-by: states that the patch was also created by another developer
> > > 
> > > $ git log --grep="co-developed-by:" -i | \
> > >   grep -ohiP "co-developed-by:" | sort | uniq -c | sort -rn
> > >      80 Co-developed-by:
> > >      40 Co-Developed-by:
> > > 
> > > So which should it be?
> > > 
> > > btw: I prefer neither as I think Signed-off-by: is sufficient.
> > 
> > OK, but does multiple Signed-off-by: in the commits imply that
> > the patch was created by all those developers ?
> > 
> > I don't think so, perhaps this was the reason to introduce
> > Co-developed-by: tag.
> 
> Perhaps, but a sign-off is also a recognition that the
> patch was passed-through by individuals

Yes, Agreed!

> Effectively, there's no real difference.
> 
> "Co-developed-by:" is just another word for "Authored-by:"
> where multiple "Authorship" is the thing being notated.
> 
> Is it really important to specify things like 75% / 25%
> authorship crediting?

IDK how that ratio came up into this discussion ?

Anyway, I saw on IIO list that a bunch of students were involved
in driver cleaning with the help of developers from Analog Devices
Inc who intially wrote some code snippets.

And that authorship crediting for Analog Devices folks would be
helpful distinguishing that it was not just passed-through and rather
they spent their time on it.

> I don't really care about attribution so the concept is
> not particularly valuable to me.

Well, it might not be valuable to you but it is for others and I saw
one such example in the past during my project.

At least I do care about those developers who spent a considerable
time on IIO list guiding students aside from their mainline work.


FYI, IIO has already +1'd for "Co-developed-by:"

-- 
Himanshu Jha
Undergraduate Student
Department of Electronics & Communication
Guru Tegh Bahadur Institute of Technology
