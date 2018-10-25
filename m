Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A54BC46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 128262084A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 18:46:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hjzf0Qzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128262084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbeJZDUu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 23:20:50 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46945 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727449AbeJZDUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 23:20:50 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so9189377lji.13
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4P7XH1Uc7ztDM77A1ZONZNQ+kutFtSOcnmClhXPOFM=;
        b=Hjzf0QzlgE7pah8KVOYCpSHGcrPcKfMYkf+QhU1e+zUoLvZ0FfM52zqUOnd/fRg1Ut
         INTaf5AL2kw5Rt+FP+JfQt+0D6nZkmZ+dQuZ7YI8xygXMnYYwFiN7ZSySTk1Bxuwh7RK
         46ol1Jnj3W04uncOfcnjUlueEKiXChOI/fWgY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4P7XH1Uc7ztDM77A1ZONZNQ+kutFtSOcnmClhXPOFM=;
        b=GJ+oxe3Db2cEnIc+8+3DzgziMCCyTkiFthyLtUN0KwRK2e+xS4f7lBBqG2HNn/wCEH
         V32TigB1dp5DrWMRHkPMlrVYs2zaDmQa72JRgBNvjz75BHUhwbAAr4UpBopoE+Yap/sT
         D7V94ol9SXViMhtAMUYnC+KhEpCk+3NJdOPtSyOKjJHbzBAAv4mqfjxsZ6PAhOwPN9Sv
         HV/z+Km364gIRseOpgjeVyxefqyGGwPwg01d9djHIucVncCU+NrXJBL4mZLIOei+moeu
         A07/ccpUR8oWrHfZOu1YZMsAFdKQLMkQAWuZCnaVpWuK5bboz+UjKCi5YCGKMyJ0ZZM2
         6kJA==
X-Gm-Message-State: AGRZ1gKOvxNSBgc1QSxXN7IO5FFbmU+Db0+PvWTRsBH2FQSrybJqRy/M
        ZjPEf4MwB55mj5/tnJCSYWzP1nE04vac5g==
X-Google-Smtp-Source: AJdET5fSHHpV7JFp0ctucvxEV415Uvq6waE2I4y9Q002jWIBXixR+NUdX63/4gX6WY7ECOfSQ72KHg==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr254788ljb.176.1540493211693;
        Thu, 25 Oct 2018 11:46:51 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 71-v6sm1467641lja.90.2018.10.25.11.46.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Oct 2018 11:46:50 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id h192so2660532lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Oct 2018 11:46:50 -0700 (PDT)
X-Received: by 2002:a19:3fcf:: with SMTP id m198mr243460lfa.106.1540493210185;
 Thu, 25 Oct 2018 11:46:50 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.1810240954100.1645@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1810240954100.1645@nanos.tec.linutronix.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 25 Oct 2018 11:46:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjAZGhJXjhGv6yDhe3Q6ECe9JxFtmFUxPap3Nkxu8GsuQ@mail.gmail.com>
Message-ID: <CAHk-=wjAZGhJXjhGv6yDhe3Q6ECe9JxFtmFUxPap3Nkxu8GsuQ@mail.gmail.com>
Subject: Re: [GIT pull] irq updates for 4.20
To:     tglx@linutronix.de
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 2:00 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> The interrupt brigade came up with the following updates:

Pulled (along with the other pull request for timekeeping),

                   Linus
