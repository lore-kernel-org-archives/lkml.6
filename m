Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D5BC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71FB2218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:28:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSj1Iwff"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728682AbfBFR2z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:28:55 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44989 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbfBFR2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:28:55 -0500
Received: by mail-lf1-f68.google.com with SMTP id z13so5944264lfe.11
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ka79cc6MJH0OieTR/HXOXJAkfsrfoLYsu3B1pRe0KUk=;
        b=iSj1IwffGfHETNh70cQhSCWZq7NftUqzFCwaoKw8+tO/RRd8LE8/VCdslGeBfyAq61
         dOR5X6nltY4sccvTydH91g8ldPrYj/KnACjvr8GD0XGkCwEpd9qUxyy0/KQmQ4hPFAz0
         TvxMYM53ZMwk3lNdr8afXbaJC2trFtQ7lKwWw6BqzZ2gDxH7N3owQYVoPIB4jY2sRVV9
         EXQw9cxaqJey3G7ITAlhNXU38qAqh99bDouYLW5TEHfGA/IGwNoX5nDiPpKw4c2/mSu/
         /Oqf+jImV0kXlUApVRECbExKc5knnHFhdi7Qg6YW4pxRCyBy+1me5mLwm9gfHal/UouH
         MbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ka79cc6MJH0OieTR/HXOXJAkfsrfoLYsu3B1pRe0KUk=;
        b=oOIfbHQ7+hd1rJtNevjZRAljnVl5wkkMKNoT2gn6zRKegIexanoyXSKp3SS5FT6SKt
         +16F/M8Yz4uO0CAiB8F84OJqDUXsXu+tNkW9QF4tS0ui3/PIcwHrNfxe44qvlmI1/lME
         iAzrJs5MVyo/NxKbS40Yd4JLE5YZ9pg/v0mJblKUBWNqpAje64OU6df4g69QjsOIeErJ
         jL0jP895YJwYz2YWtVhV2hsWPxVDWvIoqOFph916nPBykyx70uXom80248J8Nog6wK3K
         ak6OjSgF92wMJEaex4+w67ZL3MoisC5kjEY1t9RcSZ+RIpjVlA9UboIjvZ2I/ynpHeWF
         4z5Q==
X-Gm-Message-State: AHQUAuZc5enTYXT9TeID1aySGwMN0rMKLSQqA+UaGEDd4gtzo9aDPfkw
        lMIj6oc64Al9LfMIZBXgKDqpcPiXOFiPOiKrxps=
X-Google-Smtp-Source: AHgI3IYM926McE+DoWUaxnLCdA8Jwl4Onz5VAKpN+clhWLU4WdYQczo0uBVWZ8UxpU8vjv8LYyjrPmZZo3F/g17ZkZ4=
X-Received: by 2002:a19:a84e:: with SMTP id r75mr6502378lfe.45.1549474133390;
 Wed, 06 Feb 2019 09:28:53 -0800 (PST)
MIME-Version: 1.0
References: <20190123173707.GA16603@gmail.com> <20190131142221.GA26303@linux-8ccs>
 <CANiq72m8VuD_dsA+=0q88FRJgVnnSS1pt1SAFf9upGS7RFjT_g@mail.gmail.com>
 <20190204150852.GA24444@linux-8ccs> <CANiq72=cK0oMFtMejAsphNyJmQ8KvG5=70Gyt7idbvp4ScoxgA@mail.gmail.com>
In-Reply-To: <CANiq72=cK0oMFtMejAsphNyJmQ8KvG5=70Gyt7idbvp4ScoxgA@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 6 Feb 2019 18:28:42 +0100
Message-ID: <CANiq72nBHnsHu_XCjrhrLow08gx0XHszDrm9gGL-r663Ne7rHw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/module.h: mark init/cleanup_module aliases
 as __cold
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Laura Abbott <labbott@redhat.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 5:31 PM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Feb 4, 2019 at 4:08 PM Jessica Yu <jeyu@kernel.org> wrote:
> >
> > IMHO I think annotating with __init is more straightforward, instead
> > of cherry-picking attributes (we wouldn't know at first glance why the
> > aliases are specifically annotated with __cold without looking at git
> > history). Plus the actual module init function and alias declarations
> > would be consistent. Just looking at the __init attributes:
> >
> >     #define __init              __section(.init.text) __cold  __latent_entropy __noinitretpoline

By the way, note that we also need to annotate the exit ones. To do
something similar, for __exit we have:

    #define __exit          __section(.exit.text) __exitused __cold notrace

__exitused expands to nothing when MODULE is defined.

notrace is either hotpatch(0,0) or no_instrument_function; and they
shouldn't matter in the alias since we are not generating code (and
anyway they disable the extra code, instead of enabling).

So I will also use __exit there instead of only __cold too.

Cheers,
Miguel
