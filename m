Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3555CC4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:15:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3F1521746
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 18:15:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RG2IghpE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3F1521746
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbeHRVYD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 17:24:03 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:35347 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbeHRVYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 17:24:03 -0400
Received: by mail-io0-f171.google.com with SMTP id w11-v6so9490708iob.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Aug 2018 11:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AD+j7lH31EpN1GwpFVZhUEPPEU9OXbMOIScaiBgiQMQ=;
        b=RG2IghpEd7y5gjcH7BiP40PpKVMD+g+lykB1smGVA0G5XvM5aFVthg9CejIXNCwL1W
         c5xkBSCBGQXodqubbzhc0u0zFo5K4+k7k0bOc71JiQo6QFhzyXZ7EGA8kGjvRGQQnu9R
         zWzHzk3NTbONgbspeZwL8Tn+A6u4WJPys/qmg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AD+j7lH31EpN1GwpFVZhUEPPEU9OXbMOIScaiBgiQMQ=;
        b=Eb9qR8vjW40BkgFYosegKhkYZSnvDIHi5vTFDY6UCuJkInc204WHR0/u/iJVE0SZgG
         hOFJ2eTIjOrE6Jy1zI4QzglQelJENameh0ZL9LvUTb+712MHoikLt8lUZWoftZ/L4rgl
         jzf3los44VgqJnn8yCuAnp43rDVwwwqkYuG/kksWXkhEIvIA1qneMnk1IVxw5Y0rwb0t
         bJLXijcg8BJ9gnYYXl+W5Zjv0OfR50dZWZHXzkBx9Nb1vdUuDcXgBeErTutirpCwVKwe
         doOJNg9s8cBul5eZfIwb+sF1MAfSmw4PlkqUarIZg3RmUxzqu4Ft6c1Jk66lweRTdWX3
         EhqQ==
X-Gm-Message-State: AOUpUlEEWkGMNIkGujDmkzqLazUSMe15EyXUu7TnEWQSyCf/U+yKpLMU
        q8EqzLlaRxikIEKtCXSkwMk6KRjiXyCpEW9YWLU=
X-Google-Smtp-Source: AA+uWPxplLm7GTLMJxWWO7ByqZOWRAZZwdG2Pb8hlikicl2Fbxl5UUSbjyfk+0mmBh8sDslticXusmyBD4Xx/AqIIQU=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr17290364ioh.259.1534616129493;
 Sat, 18 Aug 2018 11:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <mhng-4afb9897-29ed-4eb4-88d7-6cfb09a0a65c@palmer-si-x1c4>
In-Reply-To: <mhng-4afb9897-29ed-4eb4-88d7-6cfb09a0a65c@palmer-si-x1c4>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Aug 2018 11:15:18 -0700
Message-ID: <CA+55aFz8Zt8-3iq-Gop-hJ4FDmK9DVq_pyvuo5Bw=kQHy1VvOA@mail.gmail.com>
Subject: Re: [GIT PULL] RISC-V Updates for the 4.19 Merge Window
To:     Palmer Dabbelt <palmer@sifive.com>
Cc:     linux-riscv@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 1:28 PM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> I remember having sent this on Wednesday, but for some reason I don't see it in
> your tree or my outbox so I might be crazy.

You might indeed have been having hallucinations. I don't see any
other pull request from you in my mailbox than this one.

Google does find a posting from you saying

 "Below is the pull request I plan to submit on Wednesday morning"

on the RISC-V development google group list, so I think you just
remembered your _plan_, not your actual email ...

Anyway, I can confirm that this new pull request is now in my queue
even if I don't see any earlier ones.

               Linus
