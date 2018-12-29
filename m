Return-Path: <SRS0=F2HD=PG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF9CC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7195121019
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Dec 2018 05:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="CDx12Q3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbeL2F5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Dec 2018 00:57:49 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44804 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeL2F5t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Dec 2018 00:57:49 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so20142828lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 21:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WN8MPjHKb0AXeL8SJWg6BqqJAqX7p9H76ejfhUJtnsE=;
        b=CDx12Q3AYyFlWNU9CPZYsXHEEiwJttT5ghFbmRHaAJlYE+D9p2znHEs2mGVqzu6Lom
         ECyqRfnuuj+V/Vk7rZKZ+D31yMUo+7CXiqiaUo8hUWigaMLJRQVjIvC66gJb06stEVq/
         bF97PQCoNfFG4RxcaqC0skBpTta6+W+i9LHVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WN8MPjHKb0AXeL8SJWg6BqqJAqX7p9H76ejfhUJtnsE=;
        b=cN2MtAUxfsvPSGDTIewFsCzwqKcGnorPro8xRm9MF9nvnCCSKXeekTMMkgxzUFNoEB
         Lfj9HigIvRvIgZveCM0NYPEXW1/dF+lWvdjFUlgdqkTB2mSpGrPHwan7mlGu7IVjYQtL
         eY9LQTL4xWzLqv1RSbX0d9g3HQsb3CpGTiSHkv/awKCdaR15B2hGMfUfOAqbsHVTGqp6
         4GdyEPjXCOGgpCQoDZUwEW7elaFNJMXqFkt342+CQStJwh0UGbzi32srlXhOEfBCA6WL
         JR/USrbf5KRPeI3OBSz/oDHP5/Jon0j3otacIRwW393okKo4EVomIjQs6zzJVGFO9TcA
         iOQw==
X-Gm-Message-State: AJcUukcXIO0YX7c8fhS/H9WcKpG57wMjoyWaoN7qU/gA5wyrjqOCC2iH
        OVepOo6TjlZ7pZxOGzoMFJAzOCViG88=
X-Google-Smtp-Source: ALg8bN6C8i67DCFjBOHyBVs6K9P/K3Rhg6RV5pEItg+ddOAhovSdRTqoTBVsLaWJ2BN0aX4J9y1mmw==
X-Received: by 2002:a2e:1f01:: with SMTP id f1-v6mr16374304ljf.129.1546063065388;
        Fri, 28 Dec 2018 21:57:45 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id j25-v6sm8822913lji.77.2018.12.28.21.57.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 21:57:44 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id p6so15723229lfc.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 21:57:44 -0800 (PST)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr14547326lfa.106.1546063063802;
 Fri, 28 Dec 2018 21:57:43 -0800 (PST)
MIME-Version: 1.0
References: <4880b31d0d32c38a675048be903814a062907125.camel@intel.com>
In-Reply-To: <4880b31d0d32c38a675048be903814a062907125.camel@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 28 Dec 2018 21:57:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgMfBXdiaeAxYrdTq9VoaVgN26T8MU7+3EnvJP_e0byuw@mail.gmail.com>
Message-ID: <CAHk-=wgMfBXdiaeAxYrdTq9VoaVgN26T8MU7+3EnvJP_e0byuw@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for 4.21
To:     "Williams, Dan J" <dan.j.williams@intel.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm.

This pull request doesn't seem to have gotten an automatic pr-tracker
reply, even though I pulled it, and even though it was cc'd to lkml.

Konstantin, any idea why the automation didn't trigger? I'm not seeing
anything all that odd about it.

[ looks around ]

Oh, I notice that I can't seem to find this message on lore.kernel.org
either, despite seeing that lkml cc when I look at my copy of the
email.

Does lkml hate Dan?

Headers say

  To: "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>
  CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
"linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>
  ...
  Date: Fri, 28 Dec 2018 05:04:27 +0000
  Message-ID: <4880b31d0d32c38a675048be903814a062907125.camel@intel.com>

but when I try to look it up on lore.kernel.org, I get:

  Message-ID <4880b31d0d32c38a675048be903814a062907125.camel@intel.com>
  not found

Weird.

               Linus

On Thu, Dec 27, 2018 at 9:04 PM Williams, Dan J
<dan.j.williams@intel.com> wrote:
>
> Hi Linus, please pull from:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm tags/libnvdimm-for-4.21
>
> ...to receive the libnvdimm update for 4.21.
[...]
