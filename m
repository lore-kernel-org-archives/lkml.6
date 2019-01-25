Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354C6C41518
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE4B3218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 23:15:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TV1E/e3I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729465AbfAYXP6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 18:15:58 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35886 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfAYXP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 18:15:57 -0500
Received: by mail-lf1-f68.google.com with SMTP id a16so8107399lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vzt1OQRxiiWxaGppo6zUfVpqlye5EGaOLiqVOtohNtQ=;
        b=TV1E/e3Im+byL358sBlB17dH//PCVmtZd6z9Vs40OLmZgrNJDziE+DZ3z3dGJCieHB
         W5yOKEjMJrAoLGWJrjuBB1c26Wz+n7iYahOZXXyXfuP0UoXGp7+VXOV+bbCPdKD0aMrr
         TUdDahhtMtDbcoXaaoz/YjT5K68jg+3/1bQ18=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vzt1OQRxiiWxaGppo6zUfVpqlye5EGaOLiqVOtohNtQ=;
        b=ElHnG0a/AAn5TJGYNzmTgjwlSrHavO1cicXh1sXZznwDT1sOf7gchJKszxw4iAHUs8
         8mVFz0h3WpyVn9tkaca45W0cmsXb6yJfGPlH+CIAURcERzwbf1c3fKon9yOWB+wruFQ0
         I1rNbn0z8iMN3Skso8bNOBbGt5QYFWakEC7yKsSwPPLihr2CpddHse1L2PBxbwA2Loe3
         SFJ0H+t7iImRvGALEXntTry7JXAA1affT45ZE801jlg52teRezajk1FQbBB/Ese8IS8L
         416ZOSbvKHag9JNzLbkgYaNhNRF10t8bi8Hao7CgReNowYu8TvLOGMl9s552P5G/1Y40
         GkNQ==
X-Gm-Message-State: AJcUukfwTULK74Lz3F/gRbJAgw9BzUdvhAY3QWNghQ0h8sp0ivh0bWyU
        kf4ZZIFzqliEVEQwxxKQTxV+t1MkqD0XkQ==
X-Google-Smtp-Source: ALg8bN5A1U3pirQqTGaBPtWaUVgx9EAogXurXZabXtf9SFEbEEvyWkSA8m/kPNahHieRwVqNQj790g==
X-Received: by 2002:a19:f813:: with SMTP id a19mr9971357lff.67.1548458155101;
        Fri, 25 Jan 2019 15:15:55 -0800 (PST)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id a2-v6sm1779338lji.13.2019.01.25.15.15.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 15:15:53 -0800 (PST)
Received: by mail-lf1-f43.google.com with SMTP id f5so8069875lfc.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 15:15:53 -0800 (PST)
X-Received: by 2002:a19:ef15:: with SMTP id n21mr10082658lfh.21.1548458153334;
 Fri, 25 Jan 2019 15:15:53 -0800 (PST)
MIME-Version: 1.0
References: <20190125.115827.1407196401514719611.davem@davemloft.net>
In-Reply-To: <20190125.115827.1407196401514719611.davem@davemloft.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Jan 2019 13:15:37 -1000
X-Gmail-Original-Message-ID: <CAHk-=whgEt4tUaF=6FstoETUKRzCD5WFzWvE_w9Jb7Kp1rbUFg@mail.gmail.com>
Message-ID: <CAHk-=whgEt4tUaF=6FstoETUKRzCD5WFzWvE_w9Jb7Kp1rbUFg@mail.gmail.com>
Subject: Re: [GIT] Networking
To:     David Miller <davem@davemloft.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Netdev <netdev@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 9:58 AM David Miller <davem@davemloft.net> wrote:
>
> Please pull, thanks a lot!

Why?

You don't even *mention*  the changes to the qlogic driver that are
completely new and over a thousand lines.

What is  going on here? There's no explanation for these huge  "fixes"
that aren't even mentioned.

             Linus
