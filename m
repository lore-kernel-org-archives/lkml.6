Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 050D6C67877
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B76002077C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 17:15:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gQDfm7IN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76002077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbeJMAsd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 20:48:33 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44794 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbeJMAsc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 20:48:32 -0400
Received: by mail-pl1-f195.google.com with SMTP id p25-v6so6217881pli.11
        for <linux-kernel@vger.kernel.org>; Fri, 12 Oct 2018 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ujwWbrimNp669KOEB8if5RkxRpiCrikk2Qz5VOA/j6M=;
        b=gQDfm7IN81M960Ohrzsq4aoqd93BSCaPEZcF2sfrgrANy7gC5gGxReonl2EwxTCl/k
         dKWs62xXYmi/xdzeol/ZBE6rjEo507pq6v855f+7UQG0Nj7xPAkdnbjrmpG+tGsqcMPl
         EmgMn3sFwOc0BMqiGHt/wFuRT2DzC/RWT5OsKL9S+HkUeq1DTCiazsVWgm+NFoCZAGgN
         VL98vlVj9jyJ32CfxNOa9WxO43zjU0mWyKaFEpSm1hhU4a1Rje4aLCA4+TIe6BtA/x6V
         IOtVuHnlgmNSdd3dXe8rEXJAOmSsVvCveIFNHd9J0P692EbuhukRr8P/R8IpqID+qijz
         IfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ujwWbrimNp669KOEB8if5RkxRpiCrikk2Qz5VOA/j6M=;
        b=BPfj4xchlRxGlw4t760GmUr4dfklihj0rO5yXqcPN3FmzavfB0Pc66+SQ23/whM6Fg
         Yj/FTsTnRpOXPgGKkVYqMBry3VNE2IF7zU4h16C0G7R/dAQeBEKj/y7O6YPCXy73WvUV
         McK7g33K1zWq0SChqxXMhsjJIE0aragBrNHYhb3YtPJVn1P1eb/rCdsZgx5sqNDjZOWA
         AMnTRFh542N5EA0coOsct8EzJCSkgk7wU+JChFaCetMFHPpw+AOfsj/BGQOgoZ86wbEd
         ewaq2nxu9gtnfk6dg1YQXUPiwF5CHSMrj7RYxaKjEiiesjmnGxTHLKriz+bhwKQfSqkR
         Bn8g==
X-Gm-Message-State: ABuFfoiQdVWgYJMEBN/83FIlDhIupR7OELJDLRcCyaB/D7eZHF52MM1h
        NBFwUYgA21NK76M0myb8M+TjBAuHCpOzUB1jqQqs0Q==
X-Google-Smtp-Source: ACcGV60ERIB98QcruqfKMFipjqMuswzQ8amsEZFbwBlxZ/1c8Cdo0y84gfK978KgSLEqvymaf9Jr0YLKYlRwq+xWXuw=
X-Received: by 2002:a17:902:109:: with SMTP id 9-v6mr6664670plb.320.1539364503709;
 Fri, 12 Oct 2018 10:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <1539274203.2623.56.camel@linux.vnet.ibm.com> <20181011203126.15338-1-ndesaulniers@google.com>
 <f83893d2-ed9b-613f-2768-1a975d28fe8b@gmail.com> <1539356751.2656.5.camel@linux.ibm.com>
 <fc23168b-7275-bae0-6039-04e261b3cbad@gmail.com> <1539357759.2656.7.camel@linux.ibm.com>
 <16de2bb3-815a-f534-4618-af854c906017@gmail.com> <1539359181.2656.13.camel@linux.ibm.com>
 <da2a675f-bd2d-a1f3-6a67-5579e75bdb76@gmail.com> <1539360075.2656.18.camel@linux.ibm.com>
In-Reply-To: <1539360075.2656.18.camel@linux.ibm.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 12 Oct 2018 10:14:52 -0700
Message-ID: <CAKwvOdnejRka4hP66zCGS+MSXx_z335qZUTU8J0UbEq-boRYjQ@mail.gmail.com>
Subject: Re: [PATCH] KEYS: trusted: fix -Wvarags warning
To:     jejb@linux.ibm.com
Cc:     denkenz@gmail.com, dhowells@redhat.com,
        Nathan Chancellor <natechancellor@gmail.com>,
        Eric Biggers <ebiggers@google.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 12, 2018 at 9:01 AM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Fri, 2018-10-12 at 10:53 -0500, Denis Kenzior wrote:
> > Hi James,
> >
> > > >   From the links provided in the patch it seems that one cannot
> > > > pass char/float/short to va_start().  Fair enough.  So if we make
> > > > h3 an unsigned int, the issue goes away, no?
> > >
> > > For the current version of clang, yes.  However, if we're fixing
> > > this for good a char * pointer is the only guaranteed thing because
> > > it mirrors current use in printf.
> > >
> >
> > All right.  I guess I wasn't aware that non-printf like variadic
> > functions are now considered harmful or of the impending crusade
> > against them :)
>
> It's not, it's just a maintainer issue: The original problem is because
> we coded for gcc specifically; it doesn't complain and does the right
> thing, so everyone was happy.  Now Clang comes along and is unhappy
> with this, so the question a good maintainer should ask is "how do I
> fix this so it never comes back again?", not "what's the easiest
> bandaid to get both Clang and gcc to work?" because the latter is how
> we got here in the first place.

Clang is simply pointing out that this is explicitly undefined
behavior by the C90 spec.  As such, not only may the implementation be
different between compilers, but it is free to change between versions
of the same compiler (I haven't witnessed such a case yet in my
limited career, but I would never say never when it comes to relying
on undefined behavior).

>
> James
>
> > But in the context of this patch, can we please use something less
> > invasive than changing all the arguments around?  Promoting h3 to a
> > bool (if possible) or int/unsigned int would get my vote.
> >
> > Regards,
> > -Denis
> >
>


-- 
Thanks,
~Nick Desaulniers
