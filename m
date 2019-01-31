Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C442C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B62D20B1F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 23:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727947AbfAaXbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 18:31:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34183 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbfAaXbk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 18:31:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id r14so5579908qtp.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 15:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Pe3JfUlwQ9DE+qO37NBAuH3C75mbHhOAYws9WbGZWNg=;
        b=MoasI7B4RYcSX2C8MMGLaM+aiuEwzuqFmOjaLIRF45nNxDYy8v0ySoe7MCmaShcz3E
         4+VfNhv/g2Y/3F1moRtvyxw4YgsSz2fQZFcxxj5UT7yu8WQ04AKjO4nVKO5bf8vgwP7s
         fo9RtzG75KDx8eMw+U1IKi1c6mqPwxToAyuE1pKa0tVifSz76viTaJf40I0w5x2k/K03
         MmNGBcVOZ8uwL1lbxciC8lQHWiMJSYK7muxQn2lIq72jbYBAh7WbAmoT+iO04GBjLkJU
         I7Vi1gyWNvY1mJVi5o5v4UKAGsKtTg/7OTecSRSUW4mFN8KHdPv1jjykTvK7LlvOd9lr
         Qbaw==
X-Gm-Message-State: AJcUukcU/GUIbEGSWSP6novda1mQGtR2uX2muXc063zdTSvDXSlLge9Q
        1JGEcgGMjA+T0pRlIUH+KZCNwA==
X-Google-Smtp-Source: ALg8bN5ogMk6mVWpbzJo181atL+GNdZbtbStLu/AvgDpoPINAR0Qz2RfZynz1upmKiB+yXYnB9ddEQ==
X-Received: by 2002:a0c:f8cb:: with SMTP id h11mr35047361qvo.134.1548977498781;
        Thu, 31 Jan 2019 15:31:38 -0800 (PST)
Received: from localhost (ip72-223-3-97.ph.ph.cox.net. [72.223.3.97])
        by smtp.gmail.com with ESMTPSA id k81sm13053024qkk.18.2019.01.31.15.31.37
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 15:31:38 -0800 (PST)
Date:   Thu, 31 Jan 2019 16:31:36 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: Getting weird TPM error after rebasing my tree to
 security/next-general
Message-ID: <20190131233136.3dhadb7a46lp2nu6@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        tomas.winkler@intel.com, Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <20190129132016.GA1602@linux.intel.com>
 <20190131122606.GA12470@linux.intel.com>
 <20190131160437.GA5629@linux.intel.com>
 <20190131170603.GA18349@linux.intel.com>
 <20190131183530.GA27112@linux.intel.com>
 <CAHk-=wj0pRLS9Z+_LKfiTvnnquGQjOySVuqiObC9sDXp8SCP0A@mail.gmail.com>
 <CAHk-=whEb14V981ziWmMdcqR40x5xfhhDCaB2JYcOBQHnHmsgw@mail.gmail.com>
 <CAHk-=whYtqGO7v7c=Ak0xQfonGVbC_1sRHfxS4xNO-Sa6mFevw@mail.gmail.com>
 <20190131204710.GB354@linux.intel.com>
 <CAHk-=wgPCL9WgkwvK5ehJxg7Df1DHQqGZ0KtBxtjN93QjzUyog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAHk-=wgPCL9WgkwvK5ehJxg7Df1DHQqGZ0KtBxtjN93QjzUyog@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu Jan 31 19, Linus Torvalds wrote:
>On Thu, Jan 31, 2019 at 12:47 PM Jarkko Sakkinen
><jarkko.sakkinen@linux.intel.com> wrote:
>>
>> I'll try it first thing when I wake up tomorrow (11PM in Finland ATM).
>
>Thanks.
>
>> Appreciate for taking time on this.
>
>Hey, it was my commit that broke it for you. Even if it happened to
>work before, and only did so by pure luck, it was a functional
>regression.
>
>I get very upset when other developers don't step up when *their*
>changes break something, and I don't consider "it shouldn't have
>worked in the first place" to be a valid excuse. You broke it, you'd
>better fix it.
>
>So I had better fix my own mess too, in order to not look too hypocritical.
>
>And I was very aware that hardcoding the memcpy_*io() access patterns
>might break something. I just _hoped_ it wouldn't, because we actually
>ended up going back to the very original access patterns (but it was
>from a long long time ago).
>
>In fact, while it's slightly annoying, in many ways it's actually good
>that we found breakage, and could pinpoint exactly *why* it broke.
>That does validate the whole "we shouldn't just depend on the random
>implementation detail of 'memcpy()'" argument.
>
>So I'll wait to hear back whether that patch fixes things for you, but
>I _think_ it will, and we'll be better off in the long range with this
>whole thing.
>
>              Linus

I just did a quick test here of booting and running a couple commands
(tpm2_getcap, tpm2_pcrlist), and the patch seems to work for me. I was
seeing the error during tpm_crb initialization without the patch.
