Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 106D3C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:15:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F4220844
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 19:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="I4P4C9IP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8F4220844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeIGX5w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 19:57:52 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:46731 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbeIGX5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 19:57:52 -0400
Received: by mail-io1-f68.google.com with SMTP id y12-v6so2367470ioj.13
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 12:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gfg6ISZaZNpZ8Q79IXSwnUlsNEeCWFHxWTTFk3Vs1+Y=;
        b=I4P4C9IPpQHNyJ09laFgNm6oicOk7PF4WiEqlfg8i1ku8Ym2LwXN3NJp/ptbf8liv8
         jR+m6aDgZ6NzE+8+NhABDs3JvlMazPbSVDHcGrw2kOhKJlbxYFrqFJBy48sZhgVvDDBh
         xcUFltHeoeVhVZDlOZYSQsvOysfwTpQp+/vbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gfg6ISZaZNpZ8Q79IXSwnUlsNEeCWFHxWTTFk3Vs1+Y=;
        b=bsuqHt+tEeD15yCALmmK19ew23+hTLOAW+Z8gppwDLRwuv7vLdz+h+j9W3PKEKsVra
         k8D73i+x1Z3Xo+/WO817C9jnZZ7go5fNCCO/TDWPBFnnA2oiv9pNqPEofZsj1Zf4954/
         YKm6Zf/VeK+eno0rpuV2Kv/WyqikgEmVt2O98hTTdmz0JUVfwvvBv1Rwx/9reo+twDDy
         4LpOi8UZEVLnREhkLN2SCU0G5XauqGz6FMrOYbd2VUEHHffghsWRtDh292sn5HvUyWv/
         jvLSZxV8bge3ZDK8OHMhYpmteOXPj6kXHwOZ7t9ck55mj68kWyhovsdGWxI0zOARbpQ7
         vHqA==
X-Gm-Message-State: APzg51C2jXr0v9G9gKaJHkXzwHDdv+Eza5t95nB6sb8PYPQ11+zy2bL1
        6qx0LieBl5AOd0w+/nWKq60PGV6LidcrIYnMEpY=
X-Google-Smtp-Source: ANB0VdbewwbZc+SAw51KRTbQHTlhRMVP3gIKplyAinZGSgcg3zfn/mAbXJiAzrvxjIc0qyDy5UcPvGHa+Khl7VkV0NU=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr8163107ioh.203.1536347731962;
 Fri, 07 Sep 2018 12:15:31 -0700 (PDT)
MIME-Version: 1.0
References: <4cb8dd19-a252-10c1-8dea-5479ced463fb@synopsys.com>
In-Reply-To: <4cb8dd19-a252-10c1-8dea-5479ced463fb@synopsys.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 7 Sep 2018 12:15:21 -0700
Message-ID: <CA+55aFyQiPApQeMOP9EG8Km+Y-aUBwxXc_8bqRyeSVMSy0nF_w@mail.gmail.com>
Subject: Re: [GIT PULL] ARC updates for 4.19-rc3
To:     Vineet Gupta <Vineet.Gupta1@synopsys.com>
Cc:     Will Deacon <Will.Deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Eugeniy.Paltsev@synopsys.com, Christoph Hellwig <hch@lst.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 7, 2018 at 11:21 AM Vineet Gupta <Vineet.Gupta1@synopsys.com> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/vgupta/arc.git/ tags/arc-4.19-rc3

That "tags/arc-4.19-rc3" actually a real signed tag from you, but it
doesn't point to any of your new work. In fact, it just points to my
"Linux 4.15-rc1" commit from last year.

Which is presumably also why your pull request didn't contain a diffstat.

Hmm?

               Linus
