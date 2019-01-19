Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E07B6C61CE4
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:30:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A26D02086A
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 21:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l+nPEr7q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbfASVaE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 16:30:04 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38557 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729056AbfASVaD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 16:30:03 -0500
Received: by mail-lf1-f66.google.com with SMTP id a8so12937971lfk.5
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 13:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gOdp/a8VRIhMpLYKBwMAhn3s1PbrMmW8hlSxY5qE+iM=;
        b=l+nPEr7qOyuxK5hlxgaminoHnk2bKXdoMCekI2aOkSnWX4L4mocMMsl7BfFl4o0vEX
         pizdjfGeJZzsMrj50+oBqCZRGxMuGYQSII881L6PaB18XlPwr2SPKM7cf7vbpsjGTCVo
         GjkJ4XwsZRORCE5TT5sgrUg+HuEnB+7sYkDV8DqIfsVISjBSyQvF/I9O82kea/WRjckU
         Ld7WzQVJfkP+iul+T1Rf/53LKpTppx78dCGYQi0mX8rko5hVtX0afhHVsdmH/QMZAHo8
         811eDgPboQPOxdIlAXWs618WmgTKYoiKld0cEQgGXFj5J9hknpBn80ZoOPmPfdnaq++m
         qNZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gOdp/a8VRIhMpLYKBwMAhn3s1PbrMmW8hlSxY5qE+iM=;
        b=HWZisJwu050geIJfwZzODG0GhYnpnY8xVHmOpBoCqRBbWg+RgYwWzSeiXwZePuo9FE
         xmYpLMvVoBI/W8wS1UMHSjjLHHdI1M11MekmRPvdWZrXaBdxLMceopfaOAklB8+leazi
         gbtU93J7lONXdHkKQDXVBXvQ0b6mjeczsuZ0ReTYJkKVV8OLFPBkglo1OsiJHKuJRP+B
         lJVHlxmVXKn3jch09E7+n2egDfyThSuLtph1Y1navhCF1dIK7HlyJphyEYjX6Pe4dkus
         z7VIxkT+knLRmGChF7UxfE5SzAnrCILScQyXhlUxKDihJDu0mp/HUtGqLolHI2S2G3Ha
         z0Ig==
X-Gm-Message-State: AJcUukfub/87IQC2FSXH9Z6ZRE4Y1OmS03OqlFxjogYEs0MmPX5xPYXk
        8YGZlpy/Awd3WdZ/A8fQrT+rZb4CotfeS1sBGKI=
X-Google-Smtp-Source: ALg8bN7nLPHA6dYaqr4jG8Tg5Qo75IABE7gzjiPGj17O09s06lEIxkWOq30vR7WiLCu69uGMyVUa1L7fzcihttGts8o=
X-Received: by 2002:a19:aace:: with SMTP id t197mr15004978lfe.7.1547933401567;
 Sat, 19 Jan 2019 13:30:01 -0800 (PST)
MIME-Version: 1.0
References: <20190118225658.GA28312@ziepe.ca> <CANiq72=o_7d63MXJJn6dEnt76viF0YV4svp-5VBHk7JKyjXJDw@mail.gmail.com>
 <a5eab6ca68ee1eb837c8c86b69b4696846af719b.camel@perches.com>
 <CANiq72nAX=UjAZnmh7zk+0PUnGBfAjTUfZ1YsXmkeVZ+eMJuHQ@mail.gmail.com> <2324fe307d1e077225171e7436ff1a4fc96292f5.camel@perches.com>
In-Reply-To: <2324fe307d1e077225171e7436ff1a4fc96292f5.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 19 Jan 2019 22:29:50 +0100
Message-ID: <CANiq72md_UVj2ZYXhmnqK29CNvCOdwOHU0Gfy-Kr50hNDJ7rXg@mail.gmail.com>
Subject: Re: [PATCH] clang-format: Update .clang-format with the latest
 for_each macro list
To:     Joe Perches <joe@perches.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On Sat, Jan 19, 2019 at 8:45 PM Joe Perches <joe@perches.com> wrote:
>
> I suggest clang-format's ForEachMacros statement vector
> be expanded to support regexes ala
>
> ForEachMacros:
>   - Regex:           '\b(?:(?:[a-z0-9_]+_)?for_each(?:_[a-z_]+)|[a-z0-9_]+_for_each)\b'

Ah, yeah, of course. And it should be easy, because there is already
support for regexes in the IncludeCategories option. However, the
configuration file was intended for clang-format >= 4 (when I added
the file, the intention was to make it usable as easily as possible,
i.e. taking into account the availability of clang-format in distros).

Actually, if we were to change clang-format and then require in the
kernel the latest release, we could go a bit further and add the
missing features needed to match the kernel style almost completely. I
have been trying to allocate some time to start that project in my
backlog, but... :-)

Cheers,
Miguel
