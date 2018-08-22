Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3451AC4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:41:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA432098B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 18:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Kpa5TCNL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFA432098B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeHVWHY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 18:07:24 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:51652 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728029AbeHVWHY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 18:07:24 -0400
Received: by mail-it0-f68.google.com with SMTP id e14-v6so4167524itf.1;
        Wed, 22 Aug 2018 11:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c++evWjHrJM6ajH8NNvCWcYLzI9MT/YrJ24m8WFGFU8=;
        b=Kpa5TCNLJQMg3UsxWQfyO5JIQ8PFgfpyvrL/EgAEdaRMnQKLWMk2bE6SYNu4RSZvgz
         pg+OBTEqF4sShtXDxJ7lc/eQSlX3TBKsLc4oLruVj8nme6iIo7vUy/ZbIZcCF/msDNC8
         T5iFFsk8YLX9yzvnGYUQslONMjtcMCQABHius=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c++evWjHrJM6ajH8NNvCWcYLzI9MT/YrJ24m8WFGFU8=;
        b=IQFvdYc/CMsRUf69WU7XzPyIGJJ7+hERD4GjQXLoYyH8PBUGk8z7N4mZJgC/btE0Ph
         31ABAtmvPYfTDuYzzs3vTC8f8Dyx4YJFo4EYh+W4Y0CGAAkY8wJGaZq+9GjDCqvd9Usm
         r8n3mwqbO49hY9cWImjNYx1VA8qv7kAOP+N4uHcBznz6kDL4IiK3+KwcGJWTF7VhdYqF
         M6/9BYYLFtRJctsT3dyhATWM1WGOh2Lod8BomY8yHiORkVjAVrW1KjdG34BAekYLTyXz
         C6WJTw7xQwZdeMiORbw/v/lcY4+Y/9fT6yVHcE0qVEO0Vbd4Bg6+/w+81TPU2fzfJ/An
         W90g==
X-Gm-Message-State: APzg51Br3hgPea4k7tPS+3Uds+xxtmmum7lKq6D8nZWK6Jlry1vFQi+w
        GRFLGGmD8RPwpgoRXmctXdeXwR5KV3ULoMWPGdw=
X-Google-Smtp-Source: ANB0VdbWzKNETeYM6tJRwbzn7M29bjHHzJ8oJkTc4xg1MrT7ceMumSaKWgzeXjzjjpT24aIkMXCaEge6BJ0fCpTiPoY=
X-Received: by 2002:a24:8309:: with SMTP id d9-v6mr3718346ite.123.1534963282438;
 Wed, 22 Aug 2018 11:41:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180813161357.GB1199@bombadil.infradead.org> <CA+55aFxFjAmrFpwQmEHCthHOzgidCKnod+cNDEE+3Spu9o1s3w@mail.gmail.com>
 <20180822025040.GA12244@bombadil.infradead.org> <CA+55aFw+dwofadgvzrM-UCMSih+f1choCwW+xFFM3aPjoRQX_g@mail.gmail.com>
 <20180822182338.GA19458@bombadil.infradead.org>
In-Reply-To: <20180822182338.GA19458@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Aug 2018 11:41:11 -0700
Message-ID: <CA+55aFyLmwm2CDcXXhUpmovKjYaFfeP+95Bx5OZDsYT5iiHTCQ@mail.gmail.com>
Subject: Re: [GIT PULL] XArray for 4.19
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-mm <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 22, 2018 at 11:23 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> Dan added an entirely new function here:
>
> http://git.infradead.org/users/willy/linux-dax.git/commitdiff/c2a7d2a115525d3501d38e23d24875a79a07e15e
>
> which needed to be converted to XArray.  So I should have pulled in his
> branch as a merge somewhere close to the end of my series, then done a
> fresh patch on top of that to convert it?

No, it doesn't matter if you rebase on top of a broken branch, or you
merge it in. Either way, it's broken and I can't merge your end
result.

You should simply NOT CARE about other branches. Particularly not
other branches that might not even get merged in the first place!

You should care about *YOUR* work.  You should make sure *your* work
is rock solid, and that it is based on a rock solid base. Not some
random shifting quick-sand of somebody elses development branch.

Sure, then linux-next will give a merge conflict, but at that point
YOU DO NOT REBASE OR MERGE. You tell linux-next how to merge it, and
mention it to me in the pull request.

Because at that point, I have the *choice* of merging just one of the
branches or both.  Or I can merge them in either order, and test them
independently?

See how that is fundamentally different from you tying the two
branches together and handing me a fait accompli?

Yes, yes, sometimes you have to tie branches together because one
branch fundamentally depends on the features the other branch offers.
But that should be avoided like a plague if at all possible.

And it damn well isn't an issue for something like xarray, which has a
life entirely independently of libnvdimm (and vice versa), and the
conflict was just random happenstance, not some "my changes
fundamentally rely on the new features you provide".

              Linus
