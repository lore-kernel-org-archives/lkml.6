Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9AFFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAE752064C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 18:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eBLRSxGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE752064C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727784AbeKBDyO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 23:54:14 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:37127 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbeKBDyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 23:54:14 -0400
Received: by mail-lf1-f66.google.com with SMTP id p17so8483439lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mEZX+Xy1PJ/Qdco0xjSl1xLI6O5H2esuxGmsbrkouMc=;
        b=eBLRSxGb9gsT6KT8Q4DsNN06E3wtslDlT2HYT429L6+S9lRSmZG+HGJsztC0Q1FIZF
         pq2v1bAYCydQg3YUlUTa7LdQawD8Y/cj9Wda5SOZ/h42Js0l2LbYHdhyMDwkewUzI3OX
         UeogQ9LY5bZM6lDclRrhEZ5p6diZmjcdNa9Ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mEZX+Xy1PJ/Qdco0xjSl1xLI6O5H2esuxGmsbrkouMc=;
        b=WoAG74NMUEV+ilxqhrnQUUncQCCMWqnNt/85dcclSEkfW6ayrH5Digz0ojMqfNmiQQ
         YEc9XFif3FqQ5oC3i6iPeAef9G05XMWPjw5zY+OCJiAcKezu8cZKSTG8XaRXWOJwHMSD
         3XOwiaykMHlWltBWfBCP6KHpvOuuoTvLJA9eCo157BhCrW/ar5PVxdmuC5G5A19ftoiv
         zFA0bUM86fw490cekjhSxJZN4gr1sEAur00Geo2DVNhs0ra9LObVUWZUfz6mc9dAELgM
         1iJTteGJOTU0yNjGguItifBUmgZhKgSRw/Wkg+k8XXUhvEkhyKX2/sx0MnIriP9dstbr
         3xoA==
X-Gm-Message-State: AGRZ1gIACmFQqGH/OdtPAdVd3JEE4PAyfblN4YzU4tnNEiP80Swih2yZ
        6n5nKCMDOqlFoiil5Me0ix8wZfQlq9ewvw==
X-Google-Smtp-Source: AJdET5dyI2CeRYkkRVqD+L0y09Po0TzMs4wX7KWcoqXrxZVHo1NxgTA3rluwHOConlMhYLQdR1vniw==
X-Received: by 2002:a19:cc46:: with SMTP id c67mr5010587lfg.145.1541098201179;
        Thu, 01 Nov 2018 11:50:01 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id n3-v6sm4812892lfe.8.2018.11.01.11.49.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 11:50:00 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id c16so14936541lfj.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 11:49:59 -0700 (PDT)
X-Received: by 2002:a19:288c:: with SMTP id o134-v6mr5409425lfo.124.1541098199400;
 Thu, 01 Nov 2018 11:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20181024191413.GA24294@beast>
In-Reply-To: <20181024191413.GA24294@beast>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Nov 2018 11:49:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGbJH905FXQbnP9VG=-mmgrj0boUb4QVxKECv7W7on4g@mail.gmail.com>
Message-ID: <CAHk-=wjGbJH905FXQbnP9VG=-mmgrj0boUb4QVxKECv7W7on4g@mail.gmail.com>
Subject: Re: [GIT PULL] gcc-plugin stackleak for v4.20-rc1
To:     Kees Cook <keescook@chromium.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alex.popov@linux.com, dave.hansen@linux.intel.com,
        Ingo Molnar <mingo@kernel.org>, labbott@redhat.com,
        tglx@linutronix.de, tycho@tycho.ws
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:14 PM Kees Cook <keescook@chromium.org> wrote:
>
> Please pull this new GCC plugin, stackleak, for v4.20-rc1. This plugin
> was ported from grsecurity by Alexander Popov. It provides efficient
> stack content poisoning at syscall exit. This creates a defense against
> at least two classes of flaws:

I'm still not a huge fan, but I didn't hate it enough not to pull it. So pulled,

                  Linus
