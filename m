Return-Path: <SRS0=+3zQ=OY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=BODY_SINGLE_WORD,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BDAC43387
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:32:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5244C206A2
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Dec 2018 08:32:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uzkyc5Eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729993AbeLOIcJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Dec 2018 03:32:09 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:42539 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728675AbeLOIcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Dec 2018 03:32:08 -0500
Received: by mail-io1-f54.google.com with SMTP id x6so6327445ioa.9;
        Sat, 15 Dec 2018 00:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=uzkyc5EuxmUYSHlpsKLitWrK4CjcSAbt43UQVGiUc6w6BJsbqYk0iAPY0Qu8V+u6up
         AgUiXsAwBS2EQiVZD5PznGPE7BwQbNjKJACH3FzPUtGqsgf233HyepU5PEEqk1kqjyym
         fW9j1NC66K6p8BT4mCvD14TOlJlVwbmoWxSGcFDrrFS3iqadRAmgaGFtJSmi/PacJDFu
         yrew67hNxS5Tq+j+Sg2qHGsVqiCU1UIIIAjkCdFqu8Xb+5t3pzJYPOnIWffkeFvIvqk1
         S4OEFVdTWrZK0aS8H+xqV0rMCSNmetLVESvFgA5On8DdMYBNcyFnYhj30xHDyv1va3wS
         Unbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Lx6jElU+VgfY4Bhw8zy9GLpHJyyAtrcr2M9tyhr/Psc=;
        b=ZJbSp/IEq43MtLOKy9QrmyUJ/Fu64A7AjocjV1LwRgkE0E/Cr55uEjlj0WKsyOqavs
         HMulRumDmMGHCxpLogCwPpWqTgWwlM87gJG8YqZ1hH2dRgDQ+EIC/qoSdrVLStxcmu2R
         i3VNH9wkzajuYUG66tO+I0gtVBmu13ZLeNhSYJ/igZdgS+kHCXQh444M/a/w8XylsuQu
         Yg4fim0ga3cfOuAFvL6iB/bXIXTb1k1umhsKf8hZqqA+pQwqjlZWpDlql66+fGC2SBdm
         lum8eGCsA8fOHEG+pxcEFD/ASB9ufo8JLBrFU1sDw/9bBnO5Vyz0Y9ItrS95b60M50O2
         qREA==
X-Gm-Message-State: AA+aEWbiWgPQ8ksfRmm41oKvHEPywQFTmtZdCJN+3kRDt9D4arHsiVai
        Jwoe6NBGmJ8LoEpYTJCoTszc660bzeyiWX5XOoWctXr4
X-Google-Smtp-Source: AFSGD/WE50kMJeazQCzsdVor4W+XkrOkACmhkn1khozXMuCp/7+UhX026s3sQ2as3o4b7axjLIcMn5wKA3dcpE7Xeyg=
X-Received: by 2002:a6b:9355:: with SMTP id v82mr5261914iod.40.1544862727047;
 Sat, 15 Dec 2018 00:32:07 -0800 (PST)
MIME-Version: 1.0
References: <20181105144717.6233-1-tiny.windzz@gmail.com>
In-Reply-To: <20181105144717.6233-1-tiny.windzz@gmail.com>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sat, 15 Dec 2018 16:31:56 +0800
Message-ID: <CAEExFWvoF+Rj43emhQQ7NpAXY_A_w0wTTNMjQ2JeHmYrBU0Y0w@mail.gmail.com>
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Change to use DEFINE_SHOW_ATTRIBUTE macro
To:     paulus@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au
Cc:     kvm-ppc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ping...
