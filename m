Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB38C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D27D620866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:34:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MJ31KTYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D27D620866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730819AbeJQBMg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:12:36 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44903 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729543AbeJQBMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:12:35 -0400
Received: by mail-pf1-f195.google.com with SMTP id r9-v6so11774665pff.11;
        Tue, 16 Oct 2018 10:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AlrWtG14U6jmyuUiph7Qq88b1WaQvj99KvqoG3hVNM8=;
        b=MJ31KTYEGEeXMDmNqdgRj+t2y9WyKexy6eEUXfmWbf+95PaSSS8r5Vo1DsCwZkYOT4
         Z9UpqbGWC3oxQbIogs2ICzWxSBXa4qUvcFYfv8lxmQXlYz23YpqNz84Q+0meursWUJpE
         RkJfQ766Kw74FuYsIEUYM1Q8islqNYYFL0KeW0mnXQnhXl/Iv2Jivu5Z/jByyjnmrbNJ
         lNavG+KooisvsD9MmXC+wypfPwjrjYWUu+o+/n+ZdJKKuvbLq7WBf+DQv374DQv3OeDu
         xUXLZV6W7mpEVND9+Dm6PW7b3fEpj+rFB+uNQcvjCM0DvtCZtdciawhbAL/iEj7l/cQH
         HygA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AlrWtG14U6jmyuUiph7Qq88b1WaQvj99KvqoG3hVNM8=;
        b=c6F5dAvSpcXo90tb3tTLPUZug5MzN3NDEgyqxbBA6YcSju/i+OEFNj7fBSL8ydWJCy
         yLLKH3RGUwHKtN+2ADf4j0Y87wOO14WHhbq0CWTJN+KOIxrwyi/TZ3RZbYes8+bLiymh
         7z4/mlnRfG3gi5aNKBCCSa5zk//KS2wSGPw2oE1e3qbvMoJ7uBr0lu7sD3uLud7YKw2o
         imfVTC6Dcx5sDN1R0P2/XtMjX3+9+n+UGwLiXHw4+p4kOhsFg8/ioW49QIJzdoFTiyC9
         TRJLL6+l63LFtlIrO8bJ8ee5nNSVKi6wNLBH2a4sJ2wCXlPT+dOLdbx5xdlMk5ujrjA/
         jwJQ==
X-Gm-Message-State: ABuFfoiraAd03WYOvjGiJK+LXnVRlXMOM9GyU0XfzGKm7JHwYIgX5/DQ
        r/0loCABrfELg3t2Io40E+Q=
X-Google-Smtp-Source: ACcGV61bp9HiLhd79KgmxLZCie8On3OHLGHnImsO0af+2Th8bucmN7ixbFheVhsLY46n32snsbbpDA==
X-Received: by 2002:a62:da1a:: with SMTP id c26-v6mr11934438pfh.52.1539710470388;
        Tue, 16 Oct 2018 10:21:10 -0700 (PDT)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id o12-v6sm16359813pgv.7.2018.10.16.10.21.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 10:21:09 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:21:07 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
Message-ID: <20181016172107.GA230131@dtor-ws>
References: <20181016111313.GA28307@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016111313.GA28307@embeddedor.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gustavo,

On Tue, Oct 16, 2018 at 01:13:13PM +0200, Gustavo A. R. Silva wrote:
> setup.code can be indirectly controlled by user-space, hence leading to
> a potential exploitation of the Spectre variant 1 vulnerability.
> 
> This issue was detected with the help of Smatch:
> 
> drivers/input/misc/uinput.c:512 uinput_abs_setup() warn: potential
> spectre issue 'dev->absinfo' [w] (local cap)
> 
> Fix this by sanitizing setup.code before using it to index dev->absinfo.

So we are saying that attacker, by repeatedly calling ioctl(...,
UI_ABS_SETUP, ...) will be able to poison branch predictor and discover
another program or kernel secrets? But uinput is a privileged interface
open to root only, as it allows injecting arbitrary keystrokes into the
kernel. And since only root can use uinput, meh?

Thanks.

-- 
Dmitry
