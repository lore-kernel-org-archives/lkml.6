Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B028AC0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714B220827
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 22:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Q5j21HPu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 714B220827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388140AbeKFHhy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 02:37:54 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:39136 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387768AbeKFHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 02:37:54 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so6386342ljh.6
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fh1DzKcTg+my8Sf3cJ+GG7pWGx2dxGfqU9Cr5DahywA=;
        b=Q5j21HPu23D3mhGG4zR+mh1Jb1VigC9sc+5LQ9B/iGenrkNtB3BMgghuFT9wit3+Ca
         gKFuQtpWy4TooYY5dO34RBagewHuH9pTTc2WWec6jp+jpMUxHGhXhV/ThdszhlGGQv4f
         bd9oPq0SLn//EY2yK7Q+LruogjWIeYt5tkt2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fh1DzKcTg+my8Sf3cJ+GG7pWGx2dxGfqU9Cr5DahywA=;
        b=G/ZLoP6z7ujQFQ8ac8gdeeuJ7D840f0CreP19WKKCYylPiIxaYtJWkKuo8kUXWn4RY
         QuJNDUxxmU9Z3NGB9//sQgS0y2YOzN1pmtu2Uj+iOBjHVMKMaQPLVHW4xxY/v/xdG9WF
         gq8xhMURMTmpNeYflD9L1LO4Iz1X1lJi25Bjm7JgmztwiFW/YwASFenA8a3xNS+tzyLG
         qK7o4QGirEIsDW5J3sCqLkdLL+2DcK8ov43ENvJSCgqBy5Yxr9ZtsOdgKCCS7o7juVaM
         acfmT/BSir+nW+3GMFVxHOblma2MRINsrSB12MRmg7Ms2HkY47lYssinB836Ypj8G700
         QJ0A==
X-Gm-Message-State: AGRZ1gLWcPnzgnSmPLausqQ27Zy1+eY6mCLNEIxlEp+yyvh3wXVOBX1A
        PUILgW+XUalxCP1vGS7iGJsVjzTKwOc4zA==
X-Google-Smtp-Source: AJdET5d4+5Yc/dpBt8+3efIajnpDDb0XO9CdRE0zfOEqHaeVjkXYqPNfeTSho7kG85dJ0fFkvpaWNg==
X-Received: by 2002:a2e:63cd:: with SMTP id s74-v6mr14888532lje.117.1541456159929;
        Mon, 05 Nov 2018 14:15:59 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id w21-v6sm2792590lfe.73.2018.11.05.14.15.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 14:15:59 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id s15-v6so9585655lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Nov 2018 14:15:58 -0800 (PST)
X-Received: by 2002:a2e:2416:: with SMTP id k22-v6mr10379473ljk.80.1541456158170;
 Mon, 05 Nov 2018 14:15:58 -0800 (PST)
MIME-Version: 1.0
References: <20181105070337.GX24195@shao2-debian> <CAHk-=wgHY5EdhvPoS458Wu8iUfC9C8UBG8GzEO72=0prT2nVcw@mail.gmail.com>
 <20181105180004.GA4923@bombadil.infradead.org> <20181105220847.GA16465@bombadil.infradead.org>
In-Reply-To: <20181105220847.GA16465@bombadil.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 5 Nov 2018 14:15:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjLuxr_WAKgpc1JZcTnV+5GfprtAW-W9jmRRMKDzO_XLQ@mail.gmail.com>
Message-ID: <CAHk-=wjLuxr_WAKgpc1JZcTnV+5GfprtAW-W9jmRRMKDzO_XLQ@mail.gmail.com>
Subject: Re: [LKP] [xarray] 0e9446c35a: WARNING:at_include/linux/xarray.h:#xa_mk_value
To:     Matthew Wilcox <willy@infradead.org>
Cc:     rong.a.chen@intel.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 5, 2018 at 2:08 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Let's give the automated testers a couple of days to chew on this before
> I send you a real pull request?

Sure. I see no major hurry with this,

                  Linus
