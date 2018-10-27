Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19222ECDE44
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F6E20843
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 16:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MvDJfxsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F6E20843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbeJ1BHm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 21:07:42 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33393 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728732AbeJ1BHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 21:07:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id z21-v6so3952289ljz.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 09:26:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZpbjKgFDxSJMX8InFdI7wu0DHZYYJkESAFKl0FVK5Xk=;
        b=MvDJfxsfFADOF7UaNVqIBm4/rCcfGE4rGArUTWdAo5wdmq5VjgZS1O7K5SQeuoZPf9
         7+OVU+IVtpHjoBegS/Ir4bY+0SpqyHqVhj+F+hs2mdoB9PrNDnEHTywqzFmgAo+Gw9u0
         bcWUu4TKD+FN1Uw+brb5MwVW/1u5TzuOWo36I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZpbjKgFDxSJMX8InFdI7wu0DHZYYJkESAFKl0FVK5Xk=;
        b=W4Aq4hUz7OUZSNqvP26ykCBSu6DOP+sGmYhkquzdjI7iBVC7VQXihHa2kbNR5v8Zsf
         2MtDnRGN6UcLZiLUicFYZNUDZy/AFgIsmrDv7F0JqyAQ30DtR4JN77yzL11/tBMZt8Xu
         fNFjaJE6mzdbcWQpcP7z2pDkjzvdsEjlLD/cmf56qY/IwY1SZWCIDKQKMqJtbK2kksrE
         f2h4a7AmLHRaydTnF1CfVjgs6CUJ6PA6OFmETj+sd9fec0StiU+OO/8lOrO3413ufNo5
         kZN56Vohwb20fm0SaYkM9ZtGmPhM8HJCHSFPVDAwwo1aXxWulrUGr0wgGZaOrfWSnS+g
         XToA==
X-Gm-Message-State: AGRZ1gJtKWdnHAW4fCWNiaNncJsceshcHCFXine3tZSqwcWkRjl6umD+
        UEPu5lY8xri4Tn55F4KEubrAnUwKlAhWRQ==
X-Google-Smtp-Source: AJdET5f33d23Q1kMXn4jkR8ZcnGUXIwZwFOQacsr6L0RqdLHVsRaq/ZDl4uP+AaNDNrz1jJxWEx+kg==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr1522497ljf.127.1540657569136;
        Sat, 27 Oct 2018 09:26:09 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id q24-v6sm2260339lff.65.2018.10.27.09.26.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 27 Oct 2018 09:26:08 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id u21-v6so3927093lja.8
        for <linux-kernel@vger.kernel.org>; Sat, 27 Oct 2018 09:26:08 -0700 (PDT)
X-Received: by 2002:a2e:95c6:: with SMTP id y6-v6mr5046480ljh.59.1540657567675;
 Sat, 27 Oct 2018 09:26:07 -0700 (PDT)
MIME-Version: 1.0
References: <20181026205506.GA14231@piout.net>
In-Reply-To: <20181026205506.GA14231@piout.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Oct 2018 09:25:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZJwUyss4-nUnG1B4dUx1rP+pL9-qHnZ=HGFhvax2L9Q@mail.gmail.com>
Message-ID: <CAHk-=wiZJwUyss4-nUnG1B4dUx1rP+pL9-qHnZ=HGFhvax2L9Q@mail.gmail.com>
Subject: Re: [GIT PULL] RTC for 4.20
To:     alexandre.belloni@bootlin.com
Cc:     linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 1:55 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> Here is the pull-request for the RTC subsystem for 4.20.
>
> This cycle, there were mostly non urgent fixes in drivers. I also
> finally unexported the non managed registration.

Pulled,

               Linus
