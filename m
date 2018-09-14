Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52920C070C3
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E564320833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 05:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LD41qVfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E564320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbeINKzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 06:55:15 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:35179 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbeINKzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 06:55:15 -0400
Received: by mail-io1-f65.google.com with SMTP id w11-v6so5116195iob.2;
        Thu, 13 Sep 2018 22:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MPu7it5bnpKKINnF5U9ZKGy35EFASmkjLegT7as4uC0=;
        b=LD41qVfP9u4dPWw9yzIDo9EQV6ih4F4d04v2PsLzxnQSOmspRHP5XuTuK5N5f+inOf
         674P6m//WndU0LqgqYAMglZXssBXGZAX0g55YB43OwT5N7CYLdRDSkCt3GJJZXL2ALQc
         xJm/FX463sn9tBPdlgEhd59zvGrkjiPxbHgeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MPu7it5bnpKKINnF5U9ZKGy35EFASmkjLegT7as4uC0=;
        b=hiGkg6J2qgrDvBiv2CZCoUqkcn4iMm3M3kbaoldSmDiJjhi8mtR9SMpHo+7mFF/g6T
         2En3URxLi17HwsXlaWPf3JL8YW0PmK/RA3kn6OIohWrmVQ49wJHMV4Bcz6FcKZyi03iZ
         HbMS4EEUlIPqzCddZCMa2LFwu/NJaVlAphfojAnHMybEkfanfB/hlfhd9fPpNOaP0BYt
         NYN7xsJF6lQRktYMQ78XozgAsBmh/1aix4K73nL7PEHkQLCqSRCPCDWtB6kvVCEhpXr9
         eMbqm+icWXIULd28K8Ru5zfnyrD744xnYfVAkVkrPxPF+1gstEaKcdIotDqTy87+DKtb
         hERA==
X-Gm-Message-State: APzg51AUl8Sd43vRYTzoddMSTGlTqBt4YNcjU1fjPI7okybGzjl4FFnY
        oVUiTkMOb/D2w4Rf+tCTCuaXamKC8D7BaghavWI=
X-Google-Smtp-Source: ANB0VdYLx17Zv901DMP3QrkY6flake5AH43gylIOxLIYe0hqiCfjS9pZSL6pwgNcV+tMiq9755vRALdofdpf3+h3N7A=
X-Received: by 2002:a6b:f609:: with SMTP id n9-v6mr9493947ioh.259.1536903744736;
 Thu, 13 Sep 2018 22:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20180913140149.3c39485c@mschwideX1> <CA+55aFxYR__1rfT--Vxkoh1RyA+g6pQs87H8tk7ajXW9L8p7tg@mail.gmail.com>
 <20180914073756.2c208e55@mschwideX1>
In-Reply-To: <20180914073756.2c208e55@mschwideX1>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 13 Sep 2018 19:42:13 -1000
Message-ID: <CA+55aFyrGaCMJ1HHODieMZCBrNTrPWiQkR9kPgAjaW4cPfNVAg@mail.gmail.com>
Subject: Re: [GIT PULL] s390 patches for 4.19 #3
To:     Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 7:38 PM Martin Schwidefsky
<schwidefsky@de.ibm.com> wrote:
>
> I did push it to keys.gnupg.net, but the sub-key is brand new and
> probably takes some time to sync on the key server network.

That's probably it.

> The key is there on pgp.mit.edu this morning, it that to one you
> are using or do you prefer a different one?

That's the one my laptop is set up to use (I'm on the road right now),
but it didn't receive when I tried it earlier. It's probably a pool of
servers, not a single one, and it just hadn't percolated to them all.
It came in fine now when I tried as a result of this reply, and so now
the signature verifies just fine.

Thanks,

            Linus
