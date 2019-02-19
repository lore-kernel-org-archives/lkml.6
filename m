Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1C0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:38:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36CFB2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iq6FOybL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730049AbfBSXig (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:38:36 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:38191 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728753AbfBSXig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:38:36 -0500
Received: by mail-ot1-f65.google.com with SMTP id m1so37141215otf.5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 15:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JTEHxB85X7mXy+xnotDPHC+lAi11j10avRqG+prbNps=;
        b=Iq6FOybLXiD4S1XABXuua7GzVXHjNGMMs1NwtPi5+XGORhjLam1vo289vhL8XFKiBB
         c+roae7BQ2eR7SnNN6s6M+/jKi6VpIGxFrNcn9kI//+gPzJVaGs8nur1eZJd3+nKki5v
         dqPj1/RRDad2SSWkO/0K9sONug3CUf8NO2ojuv+leICfJ3fsYvbjhhE3MV3xK/iU99gv
         rvoSS9S8h0GWiLWPCzrq6QimynYt3+dFJqroTuzAaMRSd01L9qw5sXtW+pWzP5obp8WQ
         byHgObOxiVZrwH0nQ6p/ZiiAU6kPPbucegWhF2uG0c5OxZFl/DpARZc2AayED9mALPG/
         eDXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JTEHxB85X7mXy+xnotDPHC+lAi11j10avRqG+prbNps=;
        b=DFvo786FvMkdE7JmvNCqu49cd96azb2U7i6Qs9V/O3fyE0IX3DuxvECrHINOWMHcfW
         ipMBcFj0+iFava19DYeYQN46CPlYNPpB5B2Iul/LqlayEVRyOIRfceghlWq7n8T6nWIX
         RydCQ1j6cCyTuA55Gvt0v9lyzPha6qLk4sBXUfyGkH0DzoQG5PHCaznE0ycRyLdJ2d9f
         c4boI8UOF3kRdotfV9lBumqrE//k3aB03Ep3/ikvoiSkEyYv1XmocWEBgumPHFoxH6FS
         77axW71tH43xD9j7wceVSuCq2dnxFo6aJVwqKDBJFazTTXAjrj7Oh9nhFo5AvLWWTqo3
         Y9gA==
X-Gm-Message-State: AHQUAuZ5Ou9Rwqeqj1z0oigC2YrSvjmXK/bXH6nj/O1+xyprGm7QKbqr
        Okn0izGP17+RcPKrn4R+LX3degyjtCiWjuZ7gK+okQ==
X-Google-Smtp-Source: AHgI3IY83shXXQ0XEvn1nU4EQnoUhkyGP811n9a6zXoWVQ1MffCxS6zqAz7E8RADtzxjr4sMPytLxh40Acn3zD2TRIs=
X-Received: by 2002:aca:c6d5:: with SMTP id w204mr4184704oif.137.1550619514888;
 Tue, 19 Feb 2019 15:38:34 -0800 (PST)
MIME-Version: 1.0
References: <20190216004647.206431-1-brendanhiggins@google.com>
 <eabdd156-62f4-fadb-bfa4-ecbb5ba65527@gmail.com> <fcb92f73-f49b-03b8-32ca-ee89b962a765@gmail.com>
In-Reply-To: <fcb92f73-f49b-03b8-32ca-ee89b962a765@gmail.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Tue, 19 Feb 2019 15:38:24 -0800
Message-ID: <CAFd5g47FStOYc_KXBfYYmfCV_RCjHtSiD39K4Z2sjaHEEMMv8w@mail.gmail.com>
Subject: Re: [PATCH v2] of: unittest: unflatten device tree on UML when testing
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2019 at 6:35 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2/15/19 6:18 PM, Frank Rowand wrote:
> > On 2/15/19 4:46 PM, Brendan Higgins wrote:
> >> UML supports enabling OF, and is useful for running the device tree
> >> tests, so add support for unflattening device tree blobs so we can
> >> actually use it.
> >>
> >> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> >> ---
> >>  drivers/of/unittest.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> >> index 84427384654d5..6de34d5fa0e85 100644
> >> --- a/drivers/of/unittest.c
> >> +++ b/drivers/of/unittest.c
> >> @@ -2527,6 +2527,9 @@ static int __init of_unittest(void)
> >>      }
> >>      of_node_put(np);
> >>
> >> +    if (IS_ENABLED(CONFIG_UML))
> >> +            unittest_unflatten_overlay_base();
> >> +
> >
> > This is still the wrong location.  It should be at the top of the function.

Oh sorry, I figured since this only sets up the overlay_base that the
dependency order didn't matter. I will send an updated patch shortly.

> >
> > I'll try moving it to the top and see if it still works -- should only
> > take me a few minutes.
>
> Yep, see below.
>
>
> > -Frank
> >
> >>      pr_info("start of unittest - you will see error messages\n");
> >>      of_unittest_check_tree_linkage();
> >>      of_unittest_check_phandles();
> >>
> >
> >
>
> This is probably white space damaged because I used cut and paste,
> but this is what I meant above.
>
> Tested on 5.0-rc3.
>
> Applied patches 1-14 of series:
>
>    [RFC v4 00/17] kunit: introduce KUnit, the Linux kernel unit testing framework
>
> booted uml, saw the expected 219 pass, 1 fail.
>
> Applied the following patch, saw the expected 224 pass, 0 fail.
>
> I did not apply patch 15 of the other series, but applying patch 15
> should still result in errors on boot, as I reported in the mail
> thread for that patch series.

Sure, I will address that there.

Thanks!
