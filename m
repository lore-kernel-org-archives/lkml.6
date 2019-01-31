Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937C9C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 638F0218AF
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 19:44:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HAfAlXHO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbfAaTo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 14:44:57 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40846 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbfAaTo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 14:44:56 -0500
Received: by mail-lf1-f68.google.com with SMTP id v5so3259161lfe.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3O6+mW390YadLdupkgOmKJ6lTtJzd5frs40Oi0myp1Y=;
        b=HAfAlXHOWCKdkzefTwjCpLd4PSPmDvKl1rru0q0QlJABD4Xa1H5AU3hp8yMoSW/N6x
         bmTZZ3wo/0THtPijueGlRZkIznMK9MRBdX5pGX+WzXtvcQ7e92AzgYZ7RD4y5C/NpC74
         qDsXYt9+AvrPD8BAzkNIRK9YCb/9B/BGeziSQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3O6+mW390YadLdupkgOmKJ6lTtJzd5frs40Oi0myp1Y=;
        b=Pdm3cuw2Qu6IkgFH5ocjtvvunV2L8cGSek9EyFX7leQe6oVVMeEN/Nb0QMhMrpINjI
         bcdCmqq5ksUPtKn4txMrZ+ZOXywskNxpouB+5TnA664PgVAWVFIcJkcezHsNZXXDXIDm
         A0K9abq4UfDrjTiQxjm56ZXX4Rhm48cKtl67Sxi6x+klizQtiMmZzPReDjOreUvESZDr
         AtCvygI3s8/RF1BbpgW+Ff52Ng7Cq5iuI0i/VAhpbsrnWGFTcqiG+PgHQu1w9a+jFnOk
         S6wvJei0JgBXFaqz4okSVc9wt3ubW0ijRjB90MWT8IWaV28PuHNZiVBXfjeMfbOPsZMT
         oOgA==
X-Gm-Message-State: AJcUukeO4hP7owmjPEVNTAVccF8EURkbKS09qbqw8BRjNxwxBcYRQFfd
        tYaZLpxfJ37MOmyE5JOqnH1j1GKBKU0=
X-Google-Smtp-Source: ALg8bN7dedgg5J1eGAzCW68Vp9Ilr2b0XSJU6dKtN+wiyI8fSOY8wrcrb0cMbmMFwBcCKRJlA71XCA==
X-Received: by 2002:a19:be16:: with SMTP id o22mr29043470lff.22.1548963893852;
        Thu, 31 Jan 2019 11:44:53 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id d23sm994948lfc.11.2019.01.31.11.44.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 11:44:52 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id x201so1956028lff.10
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 11:44:52 -0800 (PST)
X-Received: by 2002:a19:1a14:: with SMTP id a20mr27695264lfa.1.1548963892246;
 Thu, 31 Jan 2019 11:44:52 -0800 (PST)
MIME-Version: 1.0
References: <20190130203036.11220-1-agruenba@redhat.com> <CAHk-=wg87Y=39-_caKv6apLx4dfyC3ZdaoLvd3xz5zjONbw_Nw@mail.gmail.com>
 <CAHc6FU5smDjaQpwhyZrJBQwE5doPAcbNUfFxOSWk0jbUEG2URA@mail.gmail.com>
In-Reply-To: <CAHc6FU5smDjaQpwhyZrJBQwE5doPAcbNUfFxOSWk0jbUEG2URA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Jan 2019 11:44:36 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi81-AGZJ3rDdmPbxOnZV5Vujr9t0wM0L6nDfB+2tssQA@mail.gmail.com>
Message-ID: <CAHk-=wi81-AGZJ3rDdmPbxOnZV5Vujr9t0wM0L6nDfB+2tssQA@mail.gmail.com>
Subject: Re: [PATCH] gfs2: Revert "Fix loop in gfs2_rbm_find"
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        cluster-devel <cluster-devel@redhat.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 11:12 AM Andreas Gruenbacher
<agruenba@redhat.com> wrote:
>
> That patch just hasn't seen enough testing to make me comfortable
> sending it yet.

Ok, I'll just apply the revert.

Thanks,

              Linus
