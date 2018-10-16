Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA1CCC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:20:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AB2121470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 08:20:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="UiTjMnJ+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AB2121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbeJPQJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 12:09:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34986 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726165AbeJPQJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 12:09:27 -0400
Received: by mail-io1-f67.google.com with SMTP id w11-v6so16006439iob.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 01:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=0/PkxEiBmeplrJQZM8MhZ1A2VMfU1tpmK1LeKSglt04=;
        b=UiTjMnJ+7b06A+48yRpkf9YrdrywzhjQyci0Iw4iNIDA0gtAIsFGu4ZJy/DW2vRjDw
         asp3ygLHV6fIYpQPJMFydBsvl3ZCGbu40cogTwf35WuHNvtMnz6Ncw++7Qc1o6qi5qCM
         xW+bJhspx34PJIJ2V7OIkx06ibJy2vWT7SBhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=0/PkxEiBmeplrJQZM8MhZ1A2VMfU1tpmK1LeKSglt04=;
        b=ugFYH7qHHI0jb/J2Kv3EWB3UpQgsZYrR/2/WzteG4ymuAkDE+rLS9ccs3yW807Wefx
         TjTTCUVxQ9G7LP8ZoNXtv67YwsIBATVDbLXah0QMd0f+hhYiI3pt7/6DvzOvvc5hPo3K
         UBFYC3M2cAI7+WBosex1vKvQ9ZDuUcPyLITwMmI/jn09TuSi4IyU+2VJSQ3ue4GxKmuP
         L26fGo2TsdPoRrPQ4gLipCoLDP48rqOD1ujRreZTlV5Kr2bdogn4CKPqSEj2Gb+d+Z7d
         iPOz+91PJtp5XnrntFJFYIPlJtH6KqfiwAZmBziZUhExWBd0KlT28TRA5cFEmgNqfGVx
         jTHw==
X-Gm-Message-State: ABuFfogIk50D3yqzMml1MTM3HaBoHHR2D7WWurdxY8wT9oUG3bL9mAsO
        n24fmu6WllEPd9+OQXz2/CdHHF0xLj+FDg/8gEsw3A==
X-Google-Smtp-Source: ACcGV606mB+Fai7qindvAlYCpHDV8JtQR9s5YSwviP/PHFrLuBWbeAf8iCdPt1pHkWBbZaxcrwww6+y4YJ1ZGXkVWhQ=
X-Received: by 2002:a6b:fe09:: with SMTP id x9-v6mr13189230ioh.294.1539678011291;
 Tue, 16 Oct 2018 01:20:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Tue, 16 Oct 2018 01:20:10
 -0700 (PDT)
X-Originating-IP: [178.164.242.48]
In-Reply-To: <20181016054723.4dfb83f6@canb.auug.org.au>
References: <20181016054723.4dfb83f6@canb.auug.org.au>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 16 Oct 2018 10:20:10 +0200
Message-ID: <CAJfpegtZF3evQnaA+LWvD8-1fqQrAkn3qbcBOzO5w1PYh0EA8g@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the fuse tree
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 15, 2018 at 8:47 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Miklos,
>
> Commit
>
>   5571f1e65486 ("fuse: enable caching of symlinks")
>
> is missing a Signed-off-by from its author.

Dan,

Maybe you mistakenly left off the SOB tag?  Can I add it for you?

Thanks,
Miklos
