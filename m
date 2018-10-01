Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69881C43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:18:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15061208D9
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 14:18:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ARpJNTnx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15061208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbeJAU4v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 16:56:51 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:46603 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729272AbeJAU4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 16:56:50 -0400
Received: by mail-yb1-f194.google.com with SMTP id o8-v6so5620602ybk.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Oct 2018 07:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LrJny2D7G8TrRM7Pj4vZAH082sZGQ9KUTUGuSTqu2Kw=;
        b=ARpJNTnxNTtz+Y+GSEsJMYTXIabyIhZ5B2zS9GZgYibDdxwnJ17gf5WS1IL6kJS8mJ
         WNYrxOOav3X9Ts5bz05UhOj0Tp8clkPv+RoZ2MO+ge/F6DoBzYIeDHvLv8tfV5pMoqVA
         s1sjohJEGDd1b9lWgYTKGmmCLeuGvS5FmQmQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LrJny2D7G8TrRM7Pj4vZAH082sZGQ9KUTUGuSTqu2Kw=;
        b=P31f0jX+KxDyYsxR6lP0RxTkTvkRC8m4tsO+AQKs31ldmNs8F67b4v5UTbl2ehpca2
         xfMCSb+ax0bFSHtEMNAZhfZR3gQlCpflyXTVDai4Njw5Y//I+io21aOcHV35SMXqmfaG
         hqm+e7H589If5LVEEAM831P34NPrh4knGDBEPTLi7QEc86QITEWyiqjDey/9RTDfTpQz
         06W/VQAUCdsFtueaM5VfLuyJTIA4DwhH4rss24+OB+mgUoo60UpPdoUfCYA6L8HKN7It
         O5NtUEl2errHPisqFs/U8Emb99Kbs7mTHtHFAeLZnrZh5TLYLdTzArjLzfO0VY7qTgq7
         rByw==
X-Gm-Message-State: ABuFfohQwnBQM33lfSOuO9VRdg1iLj7Ump7gm27tX/GWLfXRWkTtRzXZ
        hugqRdMbP9HLPwSy0xL8lrjpF8ZAUyiuOB39SLzu8A==
X-Google-Smtp-Source: ACcGV61r0YSRdn1N8yhoSP2w3/q5MLRxN34ZReMWTGc5HNsJDLEoAr/FuPN9x0muzs9BWNRKb66xeuv/QTt5V5VYpDs=
X-Received: by 2002:a25:9709:: with SMTP id d9-v6mr6225905ybo.77.1538403528887;
 Mon, 01 Oct 2018 07:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <1538057720-3392-1-git-send-email-firoz.khan@linaro.org>
 <1538057720-3392-2-git-send-email-firoz.khan@linaro.org> <CAK8P3a3zhVOymM4--mJ5dfbee3buhp2vw4uxQHgxVoDCDTuR2w@mail.gmail.com>
In-Reply-To: <CAK8P3a3zhVOymM4--mJ5dfbee3buhp2vw4uxQHgxVoDCDTuR2w@mail.gmail.com>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Mon, 1 Oct 2018 19:48:37 +0530
Message-ID: <CALxhOnjiKpnON7rGnf5a4Enbj3cTagD4DgvTyt-3XFxXk-Ps+A@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] ia64: add __NR_old_getpagesize macro
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     linux-ia64@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

On Fri, 28 Sep 2018 at 17:41, Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Thu, Sep 27, 2018 at 4:16 PM Firoz Khan <firoz.khan@linaro.org> wrote:
> >
> > Add __NR_old_getpagesize in order to not break old user space
> > as it is reserved for backwards compatibility with old __NR_
> > getpagesize.
>
> That description doesn't really make sense here.

Sure I'll some more details. But rest of the patch looks good?
This is some I was bit confused! In header there is no entry, but
in system call table has the entry for the system call.

- Firoz

>
>         Arnd
