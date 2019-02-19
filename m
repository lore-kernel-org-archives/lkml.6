Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D5BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DB7C217F5
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 00:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LjyqOG+t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732547AbfBSAwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 19:52:25 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42500 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfBSAwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 19:52:24 -0500
Received: by mail-lj1-f193.google.com with SMTP id d14so4752695ljl.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mQ15dWMzdeIJV0QyN3sXfgI0K25FIbNtjsDp+cSliYE=;
        b=LjyqOG+tKP/E2cyZ/EcKraYv3nBh28GGG261GIgOlcYdtEFi7J3WyZHuHz+8dFTWNR
         NDJ9drxMlfVAGrVqusCeIoVkAco1wTZikNNf8KazPz3ejRFUy6j1KGFhHvVFq/kKBG82
         duVBtfQ5PFwXzbQDq9F0XJvlF91dgP+ewyyqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mQ15dWMzdeIJV0QyN3sXfgI0K25FIbNtjsDp+cSliYE=;
        b=JUMOWfxiVN3uP21kr/cTgbhirYTZZC7xPKiKvQ8WXnLpig6Jr+tR/EtOQ2Wd/rCJZe
         Xp02Qqst4P232CNLNcmxtop0E72H8pAHPRrfkEmGUOLU3Fx7ZVIro6KVjo+NFAtHF2FK
         IpNgS78d/wTyZTRDAuw64Qe8VwfMSYwZXPGBbG159DLkBYwjw/6xaNSRmnogwIAYY4TC
         m67omaBotxk30UZbzjGzGUXVf6G67eh9TUAQ2/LXLr564B3YuR99Zav3TD/LilVXyeHi
         D8Af21TC1LHZzTow6C48pByW8uqqXkiLNTGajEnibwwtUmV9x+k8cFiZ+HwSLYz6t6fO
         pqNA==
X-Gm-Message-State: AHQUAuYjdtqEu+oJX8gwKVlyakbaqIUKfbr/srpsjQfmz5lTb/38fAka
        g5fvZ5oRVF81ARnUle5iOBjZojylU28=
X-Google-Smtp-Source: AHgI3IZvmOb0xOzYyG5AEE0xrew/hI4Wv23B20E6DEdqDDIsbF/cTcAYa9ycl4F71gAk/5MWGuyPxw==
X-Received: by 2002:a2e:9ac8:: with SMTP id p8mr10380112ljj.142.1550537542310;
        Mon, 18 Feb 2019 16:52:22 -0800 (PST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o191sm2607605lff.30.2019.02.18.16.52.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Feb 2019 16:52:21 -0800 (PST)
Received: by mail-lf1-f46.google.com with SMTP id g2so13598416lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 16:52:21 -0800 (PST)
X-Received: by 2002:a19:24d5:: with SMTP id k204mr15078132lfk.88.1550537540956;
 Mon, 18 Feb 2019 16:52:20 -0800 (PST)
MIME-Version: 1.0
References: <20190219003648.GA26354@beast>
In-Reply-To: <20190219003648.GA26354@beast>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 18 Feb 2019 16:52:05 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjbNaTu+ktipPdM=_7PEmQ=-ue08zShjDASCsYSTzo1Mw@mail.gmail.com>
Message-ID: <CAHk-=wjbNaTu+ktipPdM=_7PEmQ=-ue08zShjDASCsYSTzo1Mw@mail.gmail.com>
Subject: Re: [PATCH v5] exec: load_script: Do not exec truncated interpreter path
To:     Kees Cook <keescook@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 4:36 PM Kees Cook <keescook@chromium.org> wrote:
>
> This attempts the protection again, but allows arguments to
> remain truncated. In an effort to improve readability, helper functions
> and comments have been added.

Applied directly, in the (maybe naive) belief that this can't possibly
break anything, and let's just get it fixed for 5.0 rather than wait
another release.

Famous last words.

               Linus
