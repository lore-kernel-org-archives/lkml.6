Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C069C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:58:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 373A72083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 16:58:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="X0qcNYyR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 373A72083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728042AbeHaVGf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:06:35 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:33761 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727433AbeHaVGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:06:35 -0400
Received: by mail-io0-f196.google.com with SMTP id r196-v6so10978541iod.0;
        Fri, 31 Aug 2018 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+Cit6qaED8/7NCbaO8dAR+9AMjA8s63By6PHssHD5PQ=;
        b=X0qcNYyR0tr3sO9osED2kh7wCaWY2/LWJUfi/aGzVOknl/1QdVJqSUgTv1wi2kVwpj
         6pewEXAzOzdHn4qzm5/orwwrLI1TgV7ErN7ipF66ayzivRWBVhd5ozFZTKjJ3qoaf+27
         +yqDjP8uX7gXExUomkH6YFWw8hV21gAF8VfqI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+Cit6qaED8/7NCbaO8dAR+9AMjA8s63By6PHssHD5PQ=;
        b=hk0OuGAFJgpZZJm5/LqtMCfrTL8hLBHU6ab62EMcTHuyYYlZZpLp1Tc+L5gjqJi+S1
         pEjuzHrx8DYqTgLwnnC+ncxGEQk6kkAogcAb6E3/MJRfAFP9+1qyrr4ZvoAAWWhBOV4N
         JkNqVrnqI+osW6lBMCgk/QG5GP3nqTs+P8UEFu3LBpWSVSVs+lxplH/vpDW1Ao7ATyzN
         3yJx/H6LSzyu4YZKNyWKzJmPYTZCPdm2bFFoJvnta4rRvVft3CVsDnr1mGTX8jl9cZV8
         0j9T4Sjft7VNKro10d0Ojv6glvgkRXX3+B8da5Qr6UvShSufVDlXAEoUnniVX4LhF+DU
         dFTg==
X-Gm-Message-State: APzg51CK2XnXehnfGmQd9b3jTbw06fosMF08WnJoQSrf5wIeoZ1v6P6+
        ASwPD6/zuVylv95kdMtf9fYmD4YPOkSbBW1tNpE=
X-Google-Smtp-Source: ANB0VdZtdN1WCiU0Z8AzAp8pdurBs1fzEq/EYB2r9fIlUFLe+uxIG+Binh2fTVta5/sPDyZuHA6lmFeTT5Q6T6YK4Ow=
X-Received: by 2002:a6b:f815:: with SMTP id o21-v6mr13504846ioh.203.1535734690979;
 Fri, 31 Aug 2018 09:58:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180830214517.29372-1-tony.luck@intel.com> <CA+55aFxVQqnFVQaCYHbnWnt3kBfVkLWgNvKFkf6qgDWCSDNpEg@mail.gmail.com>
 <CA+8MBbLKWj0RVM5astYB7_htJZ0203cQ65BWJO_o4=WDWn2kAw@mail.gmail.com>
 <CA+55aFy+R8pw1aX84cGNBNbtDgOMANXqX3+-MxAbLZRnUj=0vg@mail.gmail.com> <20180831165506.GA9605@agluck-desk>
In-Reply-To: <20180831165506.GA9605@agluck-desk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Aug 2018 09:57:59 -0700
Message-ID: <CA+55aFyu0gwg4hSmx7yMmryGb0EKYfg7Jp3FE9YafR9U=7v9Ng@mail.gmail.com>
Subject: Re: [PATCH V2] x86/mce: Fix set_mce_nospec() to avoid #GP fault
To:     Tony Luck <tony.luck@intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Peter Anvin <hpa@zytor.com>,
        Borislav Petkov <bp@alien8.de>,
        linux-edac <linux-edac@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ack. This looks good with the big comment and explanation.

             Linus

On Fri, Aug 31, 2018 at 9:55 AM Luck, Tony <tony.luck@intel.com> wrote:
>
> The trick with flipping bit 63 to avoid loading the address of the
> 1:1 mapping of the poisoned page while we update the 1:1 map used
> to work when we wanted to unmap the page. But it falls down horribly
> when we try to directly set the page as uncacheable.
> [ ... ]
