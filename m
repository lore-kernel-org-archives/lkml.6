Return-Path: <SRS0=hDTa=OZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ECE3C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6E56217FA
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Dec 2018 11:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T/3yjGjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeLPLZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Dec 2018 06:25:43 -0500
Received: from mail-lj1-f178.google.com ([209.85.208.178]:44577 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729821AbeLPLZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Dec 2018 06:25:43 -0500
Received: by mail-lj1-f178.google.com with SMTP id k19-v6so8519727lji.11;
        Sun, 16 Dec 2018 03:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YY86rs8UXj9qXx/Ix1vCn6wJq+GYJ1EeoTu4u4YUQTQ=;
        b=T/3yjGjzUr3h0DNciJ8glMejlktrYj5fUerjCTMlF4x+HG6glfQJf9lZp/51p/1J4n
         H0/dV3kSVOFpIUR8qKYDUM9uH60LFFXJ8wfrtS18R5OtTiXyzhHVzOj2g6Wfj4j7FyU6
         0qgymyUW/dNZ7SQaX8/HsTeJnNm0HzoneHvDccICujMrICbiwbiuK33se+0mLH6H/qnx
         G47wjwbUfRilo3lv+Txw8MmL6KAVAZY2YygAgKksfFkHpe8EsTHsZx6fsCt+O42LT8Ji
         y0Kmp66MSulIE84WYZG9YxLDWU256Jat6/XqKUzzkTriIKz/47sN/fmJFDvSAMlM8wxL
         chkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YY86rs8UXj9qXx/Ix1vCn6wJq+GYJ1EeoTu4u4YUQTQ=;
        b=dsid/4L2+OYBuAi1vCFP1pcAyKDENnbXm7VePRwfm28Qq43lvGcjZHGhjY4pnqdqHe
         vn9C0Wl1VjYRppbyBRPOBkl13S+LZcRAWcK+Cp60UiR9BaKmpOOp6wng+hQ1iEboFsco
         Dg+iUjjc8AoIrxMgRH4UeKjKq0A27Pc8r5BOZToao860Ny4Z3YXrloqxYFIzt39qf4Zw
         m4Nqhm8DR8TArZsTLFnlDchFJHz8sRfrGty/wsT0Xv2sQ0VYMzRAxifU3d+fkSmiKHEx
         kwjCAy3fr1QaYU6gNkbqDL+Aawrq4yzACgOC2wcJXHbMdwt7mTf9har/NevJmfPgu69R
         KqYA==
X-Gm-Message-State: AA+aEWZDTX5ffboPGH6do0+vlFuzAHYvctKfAyxy5gm8nbFPexXXPvF7
        z+Sihd8XyJysbgksqZCYNtQXHi0HG+T32YNPgGEGI9ZY
X-Google-Smtp-Source: AFSGD/XPEp2Nz3bvn7WhOMWv3clYvYBZu49ltiAUmvR98fenDlb8Qa3ak4J9iLFxsyLe67sRU0o/9Alj7tOowoCgYyg=
X-Received: by 2002:a2e:908b:: with SMTP id l11-v6mr2314178ljg.150.1544959540225;
 Sun, 16 Dec 2018 03:25:40 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72=EefCCj=ErujVHZesn0aiO5aDT2tKobzUCVw3aTsRS0A@mail.gmail.com>
 <20181216162345.24fa1876@canb.auug.org.au>
In-Reply-To: <20181216162345.24fa1876@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 16 Dec 2018 12:25:29 +0100
Message-ID: <CANiq72=BCcBwY9thw8H6qWOAxd856rHf=TYJF3QMuyFNoKfbqg@mail.gmail.com>
Subject: Re: [linux-next] Request to add auxdisplay tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sun, Dec 16, 2018 at 6:23 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Added from Monday.

Thanks!

> Out of interest, will this tree be sent directly to
> Linus or merged vi some other tree?

It is sent directly to Linus.

Cheers,
Miguel
