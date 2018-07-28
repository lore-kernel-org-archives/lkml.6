Return-Path: <SRS0=xGmI=KM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD732C43142
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:15:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 860E320878
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Jul 2018 20:15:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="g9JzTZdM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jM6p9rEM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 860E320878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbeG1Vip (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Jul 2018 17:38:45 -0400
Received: from mail-yw0-f193.google.com ([209.85.161.193]:33772 "EHLO
        mail-yw0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730557AbeG1Vip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Jul 2018 17:38:45 -0400
Received: by mail-yw0-f193.google.com with SMTP id c135-v6so3094626ywa.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Jul 2018 13:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cPMoboKkFV7lwvGjxrHbKH2jYD56z7LFUQwSYJjXuQ8=;
        b=g9JzTZdM+9ufVpk4TCSeCXz7VTcIioJCBYF80Upkoa1A/wAjpE9DR5rmh6PT+8i5ea
         SeBmC9AIDpXDGhtbXmwloVj+54yCWIDIL++rcOtiCCa6lzmPCszPlXnJgi9cQzOkjEq9
         qDA2FWTl6R6aEWd4ARZC7SBre+01lmFg2Mu3nsY15oxqUHcSiOW+PHSreZSlXhyvn9V7
         n3rn52AI/IfS8xsdudcPbRuXiubMa4XDzvgFljh7EIwuhm6BYtBgg2hQ8mOt/CW8+rFK
         YI4nC+EII2oWGkuf57RCz5TdD3aAETE9hJM0VBL9hQv9H+3maIRPb8eqr1JAHw/y+oN0
         IEzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=cPMoboKkFV7lwvGjxrHbKH2jYD56z7LFUQwSYJjXuQ8=;
        b=jM6p9rEMJ5aRlsgdNfYo0paZ3Ca0C/wEKOAEIwFckxVyUvC25xZyiH+7uti8byV69r
         fxXVhhfL7Lzbek40Iddms21wKybOTWAhiUBF3nW6NKYWxa83h3HCWLoaJoxsx6flWC8d
         n1YD/8ankcZHPqpHBg2WL/EbKsw1fOey5+vR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=cPMoboKkFV7lwvGjxrHbKH2jYD56z7LFUQwSYJjXuQ8=;
        b=t2vh5hRigdhv9hQ0Kn43McIA0dKH5Oz3mERjDhNL/zyLkvXG/toh/6kezqOr1ijG29
         HF9Bxgu4xeuzYvX2G6MQ34X4IFbU3htRr9Oee79lP0/BQB/OLmLTglJg7fPDG7evLpdn
         Yix5UqzLbq6rt3wJLBHrpJgjzrJGEYf8gF1TqH4za6gpPop/NQ6Ur52Q4T9V2vEpx4h1
         Px8EN+P7Eeau2OQPqKKnG+t8Q+uTDOv5oZ6lVsl9kKjguW19LbnuJEMUqQnkHB8tPdob
         8g59qVAwMT9NNm3q98xWgrfXpUu/3oF/5NtyAhcTrcgv5lglJJpDIUa3UCnpryFndifC
         Pdyw==
X-Gm-Message-State: AOUpUlGWY5yC9sY/5XnnGcovQyzGQHaTRdkDd2MuSCmfDH6/wZCGrX9z
        lX+GrXmTUFpXSeCzzeg+QJvhKvcHY/l7TFUYTuDBzg==
X-Google-Smtp-Source: AAOMgpc4EAEafm++isfD2OCjn2naYO7Y7w64eS+FYJUM2lNayhGFJJUSf66eRXsw80thUNg07kxXG1yHy97FkKCWsNU=
X-Received: by 2002:a81:2706:: with SMTP id n6-v6mr5733915ywn.88.1532808666448;
 Sat, 28 Jul 2018 13:11:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:6602:0:0:0:0:0 with HTTP; Sat, 28 Jul 2018 13:11:05
 -0700 (PDT)
In-Reply-To: <CAK7LNASyzWvJ6Bf1Zp4k=B-QFOHEg7YqeFErA2Gg9PNZadvuew@mail.gmail.com>
References: <1531935483-30784-1-git-send-email-s.mesoraca16@gmail.com>
 <CAGXu5jK4q6HLDZ6jokTeDABbzVasY85Jo0HFNKYeaKWZYPjPKg@mail.gmail.com> <CAK7LNASyzWvJ6Bf1Zp4k=B-QFOHEg7YqeFErA2Gg9PNZadvuew@mail.gmail.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Sat, 28 Jul 2018 13:11:05 -0700
X-Google-Sender-Auth: a6VCqA5ncmQl7X8EMscit5HvJu4
Message-ID: <CAGXu5jL2s-Dv+4mFV3Wwev51kcQ3h5M02UoH6K71s_NqeXw1yw@mail.gmail.com>
Subject: Re: [RFC] kconfig: add hardened defconfig helpers
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Salvatore Mesoraca <s.mesoraca16@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Laura Abbott <labbott@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 22, 2018 at 6:55 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> 2018-07-20 14:15 GMT+09:00 Kees Cook <keescook@chromium.org>:
>> +lkml, Masahiro, and linux-doc, just for wider review/thoughts.
>
>
> I do not subscribe to kernel-hardening ML.
>
> I do not see the original patch in lkml or kbuild/kconfig ML.

Here's the start of the thread:
http://www.openwall.com/lists/kernel-hardening/2018/07/18/1

-Kees

-- 
Kees Cook
Pixel Security
