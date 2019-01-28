Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F28AAC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEAF72171F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 18:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="W5TF4sAw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727808AbfA1Sms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 13:42:48 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34711 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726667AbfA1Smr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 13:42:47 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so12703204lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Znl+NPIbrx1THJsQbFmcrfNitgIwAywBHxLYzt7KnVg=;
        b=W5TF4sAwaLRFBomrYb8oJXfsmJgrAQtYY4s7V2bCfWm5yK0Uk3OxgYhyyxvCcMyTQt
         ixN1PYki8DHrutZNR+eMT8cJ/G7IuuXLv9FOLsfvy4F7tVCiMBwBEqYea7NBEQ0dj3Mc
         h/aewXosrfLGugQCCjG4GiIpjuBohNDDVFH2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Znl+NPIbrx1THJsQbFmcrfNitgIwAywBHxLYzt7KnVg=;
        b=lDoi8M5HlXkq1lLfG67aIkNSqovaDbmflqUtT3OnBLgCirO66n+7ixbamn//GzvexU
         AuLQTYFJzzY9Y5RgSpOeh7kkSYr46FoI/Nbg/NGa1ARTRO6ymVnhik2/IdtXnR5YZA5/
         aPRRYuQXqr2MFUJq3zthU5HjDtLsTgzWsrLAJZqOJMovSpXV0cSUt32O9o+6I8+DsfwO
         Y81tAsQWFyJ/cCTUDJJTuOEoHqZXk4ZrAP26vqTqdk3FEZs3bqF30ZqAeXaRKFhTWlyO
         s8NexfoL1uHZSxeQBvlSOdtQJTm/JSYgFlr3qNtitRXsnCAvPnzYjc0YPEsDt1VojHi1
         nzgg==
X-Gm-Message-State: AJcUukcCI1FYUWvjRgkty+/FcGICue6S0/RZuanyTfJ+pFutYMdpRJ9x
        bs/lxo/y4ijdpa74qAsMM9iRcBFCRi0=
X-Google-Smtp-Source: ALg8bN4zz4M/PSkt0/sTjzG9q1wz4nipMLULY1tD0DTYpC2glujYicRdXKgUIpbpslHkOEMC/EqS+g==
X-Received: by 2002:a19:cbcc:: with SMTP id b195mr17332888lfg.117.1548700964692;
        Mon, 28 Jan 2019 10:42:44 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id x24-v6sm3454101ljc.54.2019.01.28.10.42.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 10:42:42 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id p6so12703066lfc.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 10:42:42 -0800 (PST)
X-Received: by 2002:a19:24c6:: with SMTP id k189mr17584867lfk.77.1548700961992;
 Mon, 28 Jan 2019 10:42:41 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wh-1wB_X2MG0vW5e755rWJ5pBN8yyXLo2syOdcMV6qYoQ@mail.gmail.com>
 <20190125073704.GC3560@dhcp22.suse.cz> <20190125081924.GF3560@dhcp22.suse.cz>
 <20190125082952.GG3560@dhcp22.suse.cz> <CADfvbxqOOt_07hyeReEH_gCmTxxMYJr0-CSkqdX57wGTWisNTA@mail.gmail.com>
 <20190125155810.GQ3560@dhcp22.suse.cz> <CADfvbxp8sER_Xjkm-g8+BH87Ne8oUBirSWx6mmL=Z3XwyYoQHA@mail.gmail.com>
 <20190125163938.GA20411@dhcp22.suse.cz> <20190125173315.GC20411@dhcp22.suse.cz>
 <20190125181549.GE20411@dhcp22.suse.cz> <20190128114358.GH18811@dhcp22.suse.cz>
In-Reply-To: <20190128114358.GH18811@dhcp22.suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Jan 2019 10:42:25 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh3iWk6nu1u2OZ9JeyM-aJ_nCm1tMihPir8Yu3Q08f4aA@mail.gmail.com>
Message-ID: <CAHk-=wh3iWk6nu1u2OZ9JeyM-aJ_nCm1tMihPir8Yu3Q08f4aA@mail.gmail.com>
Subject: Re: kernel panic due to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2830bf6f05fb3e05bc4743274b806c821807a684
To:     Michal Hocko <mhocko@kernel.org>
Cc:     robert shteynfeld <robert.shteynfeld@gmail.com>,
        Mikhail Zaslonko <zaslonko@linux.ibm.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Steven Sistare <steven.sistare@oracle.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Bob Picco <bob.picco@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 28, 2019 at 3:44 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> >
> > Linus, could you take the revert please?
>
> or should I post the patch as a reply to make your life easier?

I've taken that revert now, but yes, in general, it's much better if a
patch is sent separately from the discussion as a very explicit patch
(ie subject line has that usual "[PATCH] ..." format etc) simply
because I get too much email and I can often miss things otherwise.
Particularly inside a thread where the developers are discussing
things, I go "ah, good, things are still being discussed" without
looking any closer into the details.

That's particularly true when traveling - I only noticed this one on
this second reminder email.. I'm home now, but Friday, when you sent
it originally, was 45 hours long for me with 24 hours on airplanes and
airports, so I had entirely missed the original email back then.

Thanks,

            Linus
