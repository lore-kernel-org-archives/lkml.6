Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EA7ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7014220C0A
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 15:30:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="H4Ab8Ph3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7014220C0A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbeIYViW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 17:38:22 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34193 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729355AbeIYViT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 17:38:19 -0400
Received: by mail-ot1-f66.google.com with SMTP id i12-v6so24910452otl.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1vtPj2cweEHfx09draKz54f3s29z2mO8XMlA53AsfW4=;
        b=H4Ab8Ph3fkXKdw/LfBrPlP/zIoTAiAyW9oGtlB++gR+O5+q8wAf7ggFUH71IVrireA
         vq8Gso4R5XEzj/wRd/VdMc3tG6qwfCmNzP5CYdnvPr7mGnIEKDLgGoueAA07Ng+0hpqn
         lhpcx8iseG88jya9gm+qFaU0UWVGhgBrF6CIiYam682jmIXQWu5CDPoMFrORTZKav9gu
         SRVLkhEi6FGwYEYJJoOBKe0lY9UUEaE2xBPYD30veV5kteEINkvYqKJu54J1rZfWHO7i
         UiSNPQR8NZUhvv9hZUTvlr2nox6jvJL4c/G1a27UnMa45ZwWYOPl7loq1I9SJUUCjh1e
         IlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1vtPj2cweEHfx09draKz54f3s29z2mO8XMlA53AsfW4=;
        b=l+atskAfy5yxxxnea9SGrHBPDw6IMGwUnPzcbCY3bqhyO9+X0f/ZZ0VqMGVwLVJfdb
         dvn3J4c+EUQewJEieAmZDEo4w2u41jHvJdRV15PCu7u3Yd/H+UICEh4Pd5U4DViytt6R
         viS8k/E1vbeC2btNsCQQ3Pl9cj5tA7gkktq4lYA8ntu7jm+zd1Ded0RD8kDAJgez52FZ
         U6xJOIi/pNjXSuqPRApa+6IOm2aUWR83QUV+96QotPYsJ1x01drcph6/5xs2ZvOzXhDQ
         DSMGpfRnzkxNvOr0e01YumsRt5KFKowuXhXkwl88N8hfAyg+uOmuYAOsWeceAulJegJN
         Cy9Q==
X-Gm-Message-State: ABuFfohfgE8YPWQvzNOQLLW/+u/TEbA6w9qClIEp/Hjbp/dX1gnCAt8G
        /g4BPr3lqC9953ywxoGnKO+gAAMobpXrlD4JSX/1yA==
X-Google-Smtp-Source: ACcGV62tCWbEnSBkuPKpHF5gRin9XtSar+GaMlw3wrrJltH7gF+6TogFT1l+qbTYMgZTJSJcYcih6MZin+a2WGFEj3o=
X-Received: by 2002:a9d:128a:: with SMTP id g10-v6mr1032239otg.119.1537889417772;
 Tue, 25 Sep 2018 08:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <1537832042.7585.16.camel@intel.com> <20180925091900.GB21972@kroah.com>
In-Reply-To: <20180925091900.GB21972@kroah.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Sep 2018 08:30:06 -0700
Message-ID: <CAPcyv4jbP1yG+L9wUKTJhBgGV0_3e5pW8tB_Wfk6iT+ShB+qXQ@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm/dax fixes for 4.19-rc6
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 25, 2018 at 2:22 AM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Mon, Sep 24, 2018 at 11:34:04PM +0000, Williams, Dan J wrote:
> > Hi Greg, please pull from...
> >
> >   git://git.kernel.org/pub/scm/linux/kernel/git/nvdimm/nvdimm libnvdimm-fixes
>
> That isn't a signed tag.  Did you mean to not sign it?  Your previous
> pull requests did have signed tags :(

Ah, I have elided signed tags on small fixes branches on kernel.org
during -rc's. No worries, I'll resend signed.
