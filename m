Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45074ECE560
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4192156B
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 23:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dF//vxgg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE4192156B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391667AbeIVFW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 01:22:26 -0400
Received: from mail-pl1-f170.google.com ([209.85.214.170]:43598 "EHLO
        mail-pl1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725766AbeIVFWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 01:22:25 -0400
Received: by mail-pl1-f170.google.com with SMTP id 38-v6so6587882plc.10
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 16:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=sGxU+ZdCT5EqKvYub1OMkqfBWtzLKVW/Krgf29+um5s=;
        b=dF//vxggESahnmpolpZrqa41hZ2UIqf/cIClGA+cQjQwHbCOPCnEA+OecCUMeApQPg
         SPZDorBV6cbjurXRlzvopIOnNZG1bvMktza1tW9Gg+tlrz44PN09cYP0mfpeDxq6coTO
         c8VpgloLU0rYzE/ffYWdpLw3acgWyKS6j/o8xOoVPATlLmJ2VSBUjbHRYAK8OmKoC2qA
         T+jmDZxf3c81dFtFyinNN+Xlogs7C+kr0NeiXCCSmKX5KYuZlAGGHlUZAggdas9agxPO
         qBISIMWLaFgdg+W9G76rLUxzClI68fbbRICaBAv1W6IuMnO5swVKlEp7RosDrwRMmO5W
         R6Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:content-transfer-encoding;
        bh=sGxU+ZdCT5EqKvYub1OMkqfBWtzLKVW/Krgf29+um5s=;
        b=rAdQnnfAq+WxZ796uCsuGiBRbpLYnuFx51blo3doVhICS2pLxt+chtt/IybwYfaU7B
         EFivXIkaik7fbOC+tY5rj1qRDIlEUdSPbn/O9eZtn98KdV4OQXg9BK1CjdSCqKu8pGTj
         Uz6fPBK5QRbSL2W+2FGLG2Y5dpgq7x+qU8v0ks6+mVs+JFAsOLz6rseo65n8lnNdSNPk
         FbGilA4hW3BzEom99rJCBVlIio2MGbQ7kqdxrksE4ypPWZIyHQLGOzp7oFXgkdG8A2l6
         LE+W+QXv5vh1kcKs4JE9CRGL80HW2moxQwc7jkra4n8pJMOTHw6IYF6pEPIrdoI1LZgS
         c7fw==
X-Gm-Message-State: APzg51CqswExidlDA+WsLwgIc+QsDXibEfxUuOp1qTAAheJRZWWr2LJ+
        GPhrrrhJ4d4IbSaGYjPVhFV3GZzHxSXF7IW3WFP9Yho5
X-Google-Smtp-Source: ANB0VdbDwd+kvPaYCXW8tePXDGtSjtHoDi+TEU9adk2geAKoi9rjtJtUrsm3LM8P9HcSpRGuBxLTxUXN8SWEdnIKg14=
X-Received: by 2002:a17:902:4001:: with SMTP id b1-v6mr46408586pld.312.1537572677673;
 Fri, 21 Sep 2018 16:31:17 -0700 (PDT)
MIME-Version: 1.0
References: <e223b198-af0e-123d-49bf-fad7e0f9126e@cantab.net>
 <20180919081812.020f19e3@lwn.net> <72dadc76-44fe-ecb5-e142-0a9129082c93@cantab.net>
 <CAOesGMjgo5zwKvsbi8txGQbvFHR2N7xKphzhTSGOrruN3+RC-Q@mail.gmail.com>
 <93b77a9a-12c3-6f7d-d2c3-0e0d7875a28b@cantab.net> <589966d9cd0ddccc88f33fcb7975bb4464be7696.camel@surriel.com>
 <87zhwbj8xe.fsf@redhat.com> <CAMjeLr-mWag=iO=CoNHeK9pkCu4y6vZUp03_zpJOG+e=n85j+g@mail.gmail.com>
 <20180921231545.GC2966@thunk.org>
In-Reply-To: <20180921231545.GC2966@thunk.org>
From:   "jonsmirl@gmail.com" <jonsmirl@gmail.com>
Date:   Fri, 21 Sep 2018 19:31:05 -0400
Message-ID: <CAKON4Oy3=7H+9WxzK-xK=T7t7rN7L3_PsJ+cdUWTjiKN=BGSRg@mail.gmail.com>
Subject: Re: Code of Conduct: Let's revamp it.
To:     Theodore Tso <tytso@mit.edu>, dreamingforward@gmail.com,
        fche@redhat.com, riel@surriel.com, ec429@cantab.net,
        Olof Johansson <olof@lixom.net>,
        Jonathan Corbet <corbet@lwn.net>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 7:17 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> People can decide who they want to respond to, but I'm going to gently
> suggest that before people think about responding to a particular
> e-mail, that they do a quick check using "git log --author=3Dxyzzy@exampl=
e.com"
> then decide how much someone appears to be a member of the community
> before deciding how and whether their thoughts are relevant.

How does this part apply to email addresses used to commit code?

* Publishing others=E2=80=99 private information, such as a physical or ele=
ctronic
address, without explicit permission

It appears to me that this would conflict with the GPL since the GPL
granted the right to distribute (or even print it in a book) Linux and
Linux contains email addresses.  This also seems contradictory with
the Reply button I used to send this email.

How do you reconcile working on a public project while keeping email
address secret?

>
> There are a lot of strong feelings on this issue, and allowing people
> who aren't members of the Linux kernel development community, to
> escalate the rhetoric --- either in the pro- or anti- CoC direction,
> and whether on mailing lists, github comment threads, Twitter, or
> Reddit --- is not helpful.
>
> For example....
>
> > >* Showing empathy towards other community members
> >
> > Your pussy hurts?  Maybe you should have just accepted that your a boy!
> >
> > I think Linus is perfectly fine in conduct.   I mean, this bullshit
> > pressure comes from corporations and other wierd places (<subtext>all
> > seeing eye</subtext>) that want to "help".
>
> There are people commenting from all sides that are wanting to "help".
> But I hope that it is obvious that the above text is *not* *helpful*.
> Mark, please stop.
>
>                                                 - Ted



--=20
Jon Smirl
jonsmirl@gmail.com
