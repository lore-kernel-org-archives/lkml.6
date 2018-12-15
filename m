Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3345C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B13C320672
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:32:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gH50E7u8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730033AbeLOIcc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:32:32 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:53140 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbeLOIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:32:32 -0500
Received: by mail-it1-f176.google.com with SMTP id g76so12377193itg.2;
        Sat, 15 Dec 2018 00:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=gH50E7u8YnTSnx0BCX5h4dFs2f3nXKXK5B9jeigPXk3FQCft35/i9wpnfb+lotFT8u
         8IbvODabqXWkrmqEOIJpkYKy3Kit9hnVns3exzhXyTM09oMZsXYPrwaOmukAqQYAQS4j
         R3gUqii7NlrJm5jWXmbI2p8/pt2HHzWXNFPm9yvkV4BuFJLeHGfEcYmBge2nModytx6C
         Fwbk5Oh1rNDTeiQVvaxnhgZy/XsbUEfTS/CMMGhY6XS1b8/5aM7Qj6NCI+Vw4KfF9ixw
         253/j0bx2fylF0lRyu7SUJ87V+3bfAKJ/m+1c/xQJAnyKREnYyJqDbhN7hLyzcP9RSNV
         /r6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WASiI+LGr+j54QgtHqz/Mb0c0vmWaC6GIOI+FQCQgEU=;
        b=d7FJNj+pIFU+QR4DSn+LmRaLV13l7XEREnGhIelxftU3fQXNNxjJtcjEghgbW/Fm1T
         6edI0vczvcY+n3BrNYYdrc4iH3F2yf6ZwIiIXil0R4LNJxCR2BCdMcG5mBqsdeTYzPIf
         NZxjnBAUjM9EqRfl3tso1yHDEYTpVsH26chzFNJAn+AnEayY9mzqiGdvLOaTTTYGvhjU
         /RJIQCWfwLTYnqrZ65QFKsqxo2DH2tmuK1eA11Ry9b350wSf3mDtHkwJ0Tb/vtOVxbmL
         fcJnLdEL9H6BX/qpLElwlbYAyMooGiLBq29FB2WdEw0dOYlZV0taYzUXK/tyld1t5h5R
         ZrxQ==
X-Gm-Message-State: AA+aEWYKSXYq0giSIRuF7r7dSguM4JShXbTJlSeCSDnt7vFKFWni+uv/
        Du1Lsf06sNIGM4Lcwu8jx6brxbophorEiZxb/dk=
X-Google-Smtp-Source: AFSGD/UKfmC1se6bQ32QB2O6E+MfiMvqBfqLbvLXLIMhbosaGBfC+O4uV44jnaINVr3LtOPNAvE/le1La93OLQ3Dlb0=
X-Received: by 2002:a02:5184:: with SMTP id s126mr5300931jaa.12.1544862751432;
 Sat, 15 Dec 2018 00:32:31 -0800 (PST)
MIME-Version: 1.0
References: <20181106144030.8663-1-tiny.windzz@gmail.com>
In-Reply-To: <20181106144030.8663-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 15 Dec 2018 16:32:20 +0800
Message-ID: <CAEExFWs36ntEoj5jhgJbVDF+xNdyjkbKpu=Y+f5M+9w2BNG4zw@mail.gmail.com>
Subject: Re: [PATCH] sh: mm: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     Yoshinori Sato <ysato@users.sourceforge.jp>, dalias@libc.org
Cc:     linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping......
