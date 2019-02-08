Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1D8C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 397D820855
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esoa4Y35"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727876AbfBHPVo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:21:44 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46762 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbfBHPVn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:21:43 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so1789357pfe.13;
        Fri, 08 Feb 2019 07:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T9TD3TSIfUp0NXx+cWLGYn/vif+y1yE35pHOG9P6+QE=;
        b=Esoa4Y35P+df5rN/f32r2qB0ROFsurb5y2+VIPpHcHmOBPVUPJuxUewohLz4RwVCDV
         ceRSXadtL6d9LbtmJPleU8/hdLBN4Z3ZaBp2ufKULCXiiTWWR+spClchnSyBmESxqXY3
         v2TsniQvU0yZDnGswcmssVzX1Oellnzx8O9+UJI6AlPOs/3Kgz2l4uRYc7+XHzRPJiwJ
         6zLETkhPjUlSWJxl224t+7BJKjUfivs1NtxaMU9iD+qLnysMO8KRiu7mYVKiH0zukiUi
         P6FTxHF9R9RkroLjXAT2wSxq3xHJjNzP31agqnoOb9emGOszpX8LGCOPeO5sQHS+fdiT
         0SOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T9TD3TSIfUp0NXx+cWLGYn/vif+y1yE35pHOG9P6+QE=;
        b=i39tRSOr548i+Sbx2C1Pm05Ua776LeUe7wtpdAmPHcLTqW30lv8zKoN/MhIix0WxWv
         RhNZheiI/+5f9sUnc2XYQdqFUq+1GsLEt7GliHMKF8j1NTqX5bsnpxMOPLntPri4bUIh
         NblW3zvsowRQZA3yek5VRvsvPWKKlxGpKvMXtgFUa2uy2tNsnfsoSpp0XH8SRXxzS8wk
         ttMzjeL8F/RiEzfq9MkgIER4pGWOfMcFhFHaZPTdy9ykgOolCvy6CWtNaz6w/HiPcLKn
         s/pGt6YZ6KBzaTOyApqM18pmEnkGQ17895KnAmCZW1maFyot1HOtM16UTAzFbMS2tNHP
         m+ow==
X-Gm-Message-State: AHQUAuYBkEPG+Y4gx0m6CkpbhWKWsmVyu6QyUmUJDv1cfSH0hY6/jUc6
        RrUMfyWsmPyuNQhy3fU6Bd4YjG/MZOVXUnqabiA=
X-Google-Smtp-Source: AHgI3IYu9rIs2gJTrX+yWRNWxxFItwQQwR6B1sfwsROuPTc4EvOg6JwK4PLhuadXnzCJbniJGz8h4xooluzfQJ1voyM=
X-Received: by 2002:a63:4a21:: with SMTP id x33mr21436958pga.428.1549639302982;
 Fri, 08 Feb 2019 07:21:42 -0800 (PST)
MIME-Version: 1.0
References: <1549588593-4856-1-git-send-email-lkml@metux.net>
 <1549588593-4856-2-git-send-email-lkml@metux.net> <CACRpkdaFJyGYeDZ83LQBG4pr3tgtYPkDQ3RGrrGPM==Sw1vE2w@mail.gmail.com>
In-Reply-To: <CACRpkdaFJyGYeDZ83LQBG4pr3tgtYPkDQ3RGrrGPM==Sw1vE2w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 8 Feb 2019 17:21:31 +0200
Message-ID: <CAHp75VdtyxpxhiMSYxG=HyzN7PKaw30-5kJd3ubfejZcCgjTfQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] x86: pcengines apuv2 gpio/leds/keys platform driver
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Enrico Weigelt, metux IT consult" <info@metux.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        platform-driver-x86 <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 8, 2019 at 4:31 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Fri, Feb 8, 2019 at 2:16 AM Enrico Weigelt, metux IT consult
> <lkml@metux.net> wrote:

> Andy can provide more details on this patch here are some quick
> remarks:

Already done this on the first submission of the same patch.

-- 
With Best Regards,
Andy Shevchenko
