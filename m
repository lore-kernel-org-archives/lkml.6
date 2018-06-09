Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id tvosHocbG1ucYQAAmS7hNA
	; Sat, 09 Jun 2018 00:19:21 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 36FF8607DC; Sat,  9 Jun 2018 00:19:21 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KYpHUlHE"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id A603E601D2;
	Sat,  9 Jun 2018 00:19:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A603E601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753187AbeFIATS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:19:18 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:37178 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbeFIATQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:19:16 -0400
Received: by mail-it0-f42.google.com with SMTP id l6-v6so4549151iti.2;
        Fri, 08 Jun 2018 17:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eVxwKgFpsU7Gqc27MhhYVRiyxNT+wzy4IBzCYu6HiNg=;
        b=KYpHUlHEahseXre7HB4LExQMwqwqYUKx6TdgQxwD5Unrpl6kk1kWw8zJJvdvlCbKLJ
         VuvRBzW8p/emjQL/2VuBQiGYDTWlAo6rtSVoqbqarFU98TKGADG1S+PLnDco4KoSQbGE
         hMnAWj73lfqvWFsHz/xDA547xIrURFwT4xch0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eVxwKgFpsU7Gqc27MhhYVRiyxNT+wzy4IBzCYu6HiNg=;
        b=aIkxA8uqToxScqLNLpm+CrZxnDB9rbmaoR8hr9CWJzAlMeVZfQLiZp2ncFtHDB6qvE
         sAbHoEw388BS54pdmoNL6Rnq0o+ZL9tGPS/LC0d/y75SkDub2EjYcdkHZnriAxvnZrkH
         bzpj63dyfAZJloChFYnozXFW4uOl2IM47cQRZki3L8tRUL1vbmsqcsM5eebmy9nnOswK
         3oGOVBqFqoE1nM9yN/MPlh6k7qD4Bv6bSxoLBpVWgnpHS4hQhOIo11AXUegCA0J1C6fF
         mrKMgy13YQYmhoHl7UyMv3wH1u/vsw4ZLx9zF1kN6O3bvb96npJn+R1voPUfg9WgEbmf
         z6cA==
X-Gm-Message-State: APt69E3xkwgTA9HKGqmDv/+4qKJonxvyc78TR3ZY1V873AZvmH/sQNLo
        1MAGYlAf/iG0Sj0SArmTZM8w48gLRYoeukY/qk8=
X-Google-Smtp-Source: ADUXVKJ0AOSVEfzFFPl/q9u9UBcWIOLaku5k9p1kSr7fLDx+FGzdRqiDKBxmxgx92Cxf+mJrYHbBye6OzDP0vEV2NCc=
X-Received: by 2002:a24:5b81:: with SMTP id g123-v6mr3590885itb.1.1528503555988;
 Fri, 08 Jun 2018 17:19:15 -0700 (PDT)
MIME-Version: 1.0
References: <1528502307.25740.14.camel@intel.com>
In-Reply-To: <1528502307.25740.14.camel@intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Jun 2018 17:19:05 -0700
Message-ID: <CA+55aFy_fiF2bwW=0gL4g8uL5099hWarL4+Q9djmDEuwRR2KKw@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for 4.18
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 4:58 PM Williams, Dan J <dan.j.williams@intel.com> wrote:
>
> Not included in this pull, but still targeting this cycle, is support
> for handling memory media errors (poison) consumed via userspace dax
> mappings.

Note that since I'm going to be traveling much of next week, I'm going
to be even less open to late pull requests than usual.

If I get stuff that looks at all complex at the end of the merge
window, I will just cackle unpleasantly while I press the big 'D' key
on my keyboard.

          Linus
