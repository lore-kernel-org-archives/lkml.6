Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32EC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:23:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAB1320BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LeK2WAwe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB1320BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbeHVVtR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 17:49:17 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53972 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727694AbeHVVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 17:49:17 -0400
Received: by mail-it0-f65.google.com with SMTP id 72-v6so4079379itw.3;
        Wed, 22 Aug 2018 11:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xpUbR1yKZyu2O64eILWWzaE0UAphEbqXNyvk4QhWo4k=;
        b=LeK2WAweglltj1to72a80BYi0LtDfTBGWhJLMB2fKzShU3g5c8GLPjsqU7xC0bC9fZ
         1XcTAOsQRn/rym52CGmzDWbVnm9O9ex7YNYvyUYhlk0D58zyC8uNDIfNcdbzaKGg3wIp
         zXMNttzq6ZPsgvfbmhYEeSjkXMuSlZZLaa9EHVbITITXGEwmotSE1hUchviPbxEhfZHh
         bbjL1tpUK6jDyYbFKKxzQM9NbkMnsv3o5qYVDOrdm2MWJyEGKdy3RYFgFKk5yxtlcJLD
         V/m7nO3R9U4C2dlaSbV9t8yrQv1l4FhDYG2NTHzm59oH6CIy9y02Tpx58OAcN2zFMSSO
         wjRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xpUbR1yKZyu2O64eILWWzaE0UAphEbqXNyvk4QhWo4k=;
        b=aNQPyt8a7WApILAEGi/oXpvgvK0+O6AnY6fpnn59zeGCEQAkJiZE2y07do2shYtSP+
         hsVadfkQycqbsaFB2WeNwjmHLHlc3c5syDP+IP4T8d04wbm8hae7QYDF7Rm/868GJ/HF
         gykZfL1Wt9xclmohr9x/twGnC3NDGdbp1Gyy6Y0t5/LW+/qEK3Nv9GcWpwR6S2Xn6/D6
         HwLmP89Op2XEbC/sIpyMQ07Rnj3y0exTiHfw0yGGJE2pkdFv4RnqxXaAQWLqPEgOj+mb
         QmCnkvRcEbN1UFBtq3e2hTiLYPPbyXAyhxe6Nk4bs1jIZ7Ag2qUx73WhsHYuJp0zoPCA
         usow==
X-Gm-Message-State: APzg51Dq2xPI9Jde6cWbNBRZHpSLKuY5mVKAcutcMmJtIM1nPrHbqug8
        4YIwafJ0m0QDQ0mz7vsZD9ltp86ZUidxc1dhKMiQKw==
X-Google-Smtp-Source: ANB0VdbIUATzcnYcuILrbbj9UlzUAsMZc+d5A2hQFqAOcMzar9YOt07O0XfQ+rkGd6JJEiufkpiPWG25jHPNv/ACeWs=
X-Received: by 2002:a24:4cd0:: with SMTP id a199-v6mr1270476itb.142.1534962199484;
 Wed, 22 Aug 2018 11:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161357.GB1199@bombadil.infradead.org> <0100016562b90938-02b97bb7-eddd-412d-8162-7519a70d4103-000000@email.amazonses.com>
 <CA+55aFzN3aq1P8ykE1+XuAR9pbH7nETOyMoBi-N52Ef=WjrFLA@mail.gmail.com>
In-Reply-To: <CA+55aFzN3aq1P8ykE1+XuAR9pbH7nETOyMoBi-N52Ef=WjrFLA@mail.gmail.com>
From:   Dan Williams <dan.j.williams@gmail.com>
Date:   Wed, 22 Aug 2018 11:23:02 -0700
Message-ID: <CAA9_cmdCj6EqipbxMwy9Mm+Vg+HOPZCRpCpbmvWr=A7En+MUiQ@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 4.19
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     cl@linux.com, Matthew Wilcox <willy@infradead.org>,
        linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 10:43 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, Aug 22, 2018 at 10:40 AM Christopher Lameter <cl@linux.com> wrote:
> >
> > Is this going in this cycle? I have a bunch of stuff on top of this to
> > enable slab object migration.
>
> No.
>
> It was based on a buggy branch that isn't getting pulled

To be clear, I don't think the problem you identified can be triggered
in practice. We are under the equivalent of the page lock for dax in
that path, and if ->mapping is NULL we would bail before finding that
the mapping-size helper returns zero.

> so when I
> started looking at it, the pull request was rejected before I got much
> further.

For the record I think skipping the entirety of the libnvdimm pull
request for this cycle due to that misuse of ilog2() is overkill, but
it's not my kernel.

Andrew, I think this means we need to lean on you to merge
dax-memory-failure and Xarray for 4.20 rather than try to coordinate
our own git branches for these specific topics.

At a minimum for 4.19 I think we should disable MADV_HWPOISON for dax
mappings this cycle to at least close that trivial method to crash the
kernel when using dax.

Dave, I recommend dropping dax-memory-failure and sending the other
libnvdimm topics for 4.19 that have been soaking in -next.
