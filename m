Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB66C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65CD8205C9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 18:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OACZ0iVo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65CD8205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726978AbeJPCmK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 22:42:10 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33732 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJPCmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 22:42:10 -0400
Received: by mail-lj1-f193.google.com with SMTP id z21-v6so18522218ljz.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 11:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VBp6u3EeccKYoQDrZJNonCfxmd28m0otTC0MIIAp820=;
        b=OACZ0iVo2Sq0HdtoBn1zZimO68B/G95O4qswV1XALiso+Ie0zBej8y28UKO5yxxnsy
         NGq4m873Y88k6pQGeB2J0I+1Z3CnVptAvUY+WqBQVGGEZfrOW8rP5ju0LqD/URxV6jJs
         uKj4YPfHr8hCrQsNmrqMpMuEXH75YoVSr4vQEOiQhRXCKOFq8/iizLRANKK2UxN6FFxN
         qrIpjPfkRKfL4DPawEKkvBYvgQ6CcZa5B1iMhObPDKF0/qREzC/KZlJZa6Mca7F/BiTt
         +L4Y27rTE7C/gPaYmcB/f4cBmAFqC/MXmTPfEGel1F9XhIVo6q8b2/qxtIiO9dxpivCu
         4OQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VBp6u3EeccKYoQDrZJNonCfxmd28m0otTC0MIIAp820=;
        b=pZ9G2vwvJWuojb35ywEi/BKHOb1d44xZBXOShPcXRolA25YdNYIuSCtTqdWsYcJlEa
         o4zFJyI1MT/YWf01ervtaSm1AD4f6G8Q+ZoHGGm7+iC4i9KbDWs+bl+69HVqQh5s7mvv
         Fh5nctKGBIC836dyP2uTqC0u7R1RuUf5Iz/J/tJK3WgnR3ORjTJp888YFDc7lYmlKFUC
         x/6/pzCD00R9aK/cGIgqV8XdFW1OjGlqEuasYiOmZ2tnkopcDQenGFQo1LgyL6LoFPvg
         iMHhic+wRHb5f7q5r5LJny3ve4nryzzAJ5mP0dYTIKwLCk6Ssa8mpaCwFp16741+O6D2
         V2Mw==
X-Gm-Message-State: ABuFfoj5oRcQNW84GQXI4F1dRuzANzeXxOHzpkZ3/a8vj2BK+Qx86viD
        AneNsJRq2YTTHGtDGaibIqLbLy8FShBQjrn40a3ibQ==
X-Google-Smtp-Source: ACcGV62MjlZeiiqNIw/y4KiznvFYYgGNkvJ/Tx/gdbIY6VVEIJ/1ZArLZegaBvEq3kr2kiKDmrQpaJNq/3AS/VCW2DE=
X-Received: by 2002:a2e:7109:: with SMTP id m9-v6mr11577876ljc.176.1539629737932;
 Mon, 15 Oct 2018 11:55:37 -0700 (PDT)
MIME-Version: 1.0
References: <20181003171720.169953-1-rkir@google.com> <20181003171720.169953-9-rkir@google.com>
 <20181015183807.GA6905@kroah.com>
In-Reply-To: <20181015183807.GA6905@kroah.com>
From:   Roman Kiryanov <rkir@google.com>
Date:   Mon, 15 Oct 2018 11:55:26 -0700
Message-ID: <CAOGAQeo31ggKCHsJw3D297J6Ya1kq8MptTaDR7q6H7-q99sdGw@mail.gmail.com>
Subject: Re: [PATCH v3 09/15] platform: goldfish: pipe: Move goldfish_pipe to goldfish_pipe_v2
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is the v2 driver. v1 will be added later.
>
> If you want to add a new driver later, great, but don't change the name
> of an existing driver for no good reason.

I want our "v2" driver to be in a "v2" file and our "v1" driver in a
"v1" file. I think this is reasonable.
