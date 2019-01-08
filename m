Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C10C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0613520827
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 17:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EJ0T+txC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729137AbfAHRew (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 12:34:52 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44128 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbfAHRev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 12:34:51 -0500
Received: by mail-lj1-f193.google.com with SMTP id k19-v6so4082358lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3+c/iSAWkyckmdJB6osdVXbVSK2QjMmepJfo9YtUYBc=;
        b=EJ0T+txC9MhBF53rvnGnx4oFP7zqslyjXVAVe6yASBnl2JL/OMPMjFgpZ22oGbYr8c
         pIAGDi2dIWmDDUMBT2VGHvPkb+aNtwAeGP5YnsrPTYSxSAGgG5L8Y9qZRwl/QFfcmTUA
         iusjGr/3vmqkFlUh/w1BBweSTmsc5a1nOWmEM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3+c/iSAWkyckmdJB6osdVXbVSK2QjMmepJfo9YtUYBc=;
        b=e12cpSSGX67kwgAp144IYZ2bPA2rGrPG9hsgkzrE8NptccaJs5/GgYHph6jIUUIcK0
         gxaI55y3/wMGj0eNB9V/ZIVnCgkcJ3O4EpXuWnHNovYGzKtzbSaqgsD3BGtcd7strI2Z
         Yevl0FHmArHMvF/Hz6jIeoNRViLXisx1ttfu6B8MB4ULgokVsmt+1PAVGGQ336zx9U3Y
         rUQxW8n/ZE9/sQzv3v12vATa2Vu2phdQmoDwqdNHKhnBlFnJRfrcDIFdfrhushGrhXiA
         zrP3+u8Gt1cHB6xRpn8bm6AgPJLXCfPw5HMvytHLLVfPuEu7tuao9Dnb3gbqr/qs2TbH
         XEPA==
X-Gm-Message-State: AJcUukf8fRKIMM4ltXLA+yVr48ffWBF95AwKj5LMW+uB3BZy/v6pyeZ3
        g8HmcKKxOGVISAHBXXK3P5ID8fwLKSI=
X-Google-Smtp-Source: ALg8bN6cG5dNhkQPCPsY+5jR2uPANSL11NLfQNZwLBhzMjOPd6GZ4jeTs8pLaWvviv/1x/cwtQACqg==
X-Received: by 2002:a2e:9107:: with SMTP id m7-v6mr1600958ljg.23.1546968889239;
        Tue, 08 Jan 2019 09:34:49 -0800 (PST)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id z7-v6sm14343719lji.42.2019.01.08.09.34.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 09:34:48 -0800 (PST)
Received: by mail-lf1-f47.google.com with SMTP id i26so3566950lfc.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 09:34:47 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr1672866lfc.124.1546968887575;
 Tue, 08 Jan 2019 09:34:47 -0800 (PST)
MIME-Version: 1.0
References: <20181223124859.GA26860@zn.tnic> <CAHk-=wiX_6f+7DUaG-x2cQHctjtSHdMrtAeixitOQkbswq2scA@mail.gmail.com>
 <20181226205616.GA4557@zn.tnic> <20181228124904.GC20003@gmail.com> <20190108171401.GC12235@zn.tnic>
In-Reply-To: <20190108171401.GC12235@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 8 Jan 2019 09:34:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg6U4SxGOH8zE94MZ2zE2Ara12eMMt1MKcqa7SZGDVFgA@mail.gmail.com>
Message-ID: <CAHk-=wg6U4SxGOH8zE94MZ2zE2Ara12eMMt1MKcqa7SZGDVFgA@mail.gmail.com>
Subject: Re: [PATCH] x86/cache: Rename config option to CONFIG_X86_RESCTRL
To:     Borislav Petkov <bp@suse.de>
Cc:     Ingo Molnar <mingo@kernel.org>, x86-ml <x86@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        James Morse <james.morse@arm.com>,
        Babu Moger <babu.moger@amd.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Tony Luck <tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 9:14 AM Borislav Petkov <bp@suse.de> wrote:
>
> Will queue to x86/urgent if no issues.

Thanks,

                 Linus
