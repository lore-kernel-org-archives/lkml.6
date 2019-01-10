Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1392EC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:16:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93C220874
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 17:16:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D04geNb/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729579AbfAJRQc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 12:16:32 -0500
Received: from mail-lj1-f173.google.com ([209.85.208.173]:45098 "EHLO
        mail-lj1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729434AbfAJRQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 12:16:32 -0500
Received: by mail-lj1-f173.google.com with SMTP id s5-v6so10368095ljd.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:16:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kh6lfATGNE04kp24xyvj29KmBErjfJlwRCvsAdeL/XI=;
        b=D04geNb/XMSSU3He3/nMi2h8e1Ev1pObvheIHeyWItZweYBZbXtgD708TuOeAPKFkG
         TWjkGMph9E/V9WtfXCk8lHfgIbtxQZxo1i5HnM+i2ciRLGRzZKUDXbYBVsjHl0gHnR7V
         c5crM0J6uBE/hOmOblKkcqRfECN3c25ku5Z8U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kh6lfATGNE04kp24xyvj29KmBErjfJlwRCvsAdeL/XI=;
        b=Y7KSA5q3gL6zF1SBMs7cuxQxRb+4Am+KQKgw/KVtr1pNoBwgA7jXoVFrnkfeOZXap1
         xX5IhYWiFcxObu0+tbuYUf0hFtwZ4S+AOqqbkiVdm58W2pKv5mc6QOfgXWknLmiioYSh
         1bJw463oCy9MlJxfWzFCNLfqJOweAOb7FLroErZKNsMQWkpfF6KYiquOsd/HtUjUCEc2
         yvo4ZKKFn5b/1sO/pKA4DlYZdnRNxc5ooIwKXYJWHvDaztLs9Y4mQPq9HwK8twYS7QGm
         acqo/I6//UbZ0qm9n2gUt4GB3q+2xTpctpZTAtRLJUhhrEQfwk18tHItZ7FR59TrUF5r
         x6kw==
X-Gm-Message-State: AJcUukdRMKzs3AdJejOModQsc+hITtFoLh99bPe2yZhByOoackWoWOPv
        S7diqTfbBpoewlzdTUL8o5G5M/J0sRI=
X-Google-Smtp-Source: ALg8bN6p41mwr/khQzuoTVJZUZe/qCQ8pbypb7+CsWwJ3wjNfxxfbRG58zJAdoyRwT0a2gWyLS7L6Q==
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr6572036ljs.118.1547140590075;
        Thu, 10 Jan 2019 09:16:30 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id i75sm14460366lfb.58.2019.01.10.09.16.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 09:16:29 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id g11-v6so10412925ljk.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 09:16:29 -0800 (PST)
X-Received: by 2002:a2e:9983:: with SMTP id w3-v6mr7025842lji.133.1547140588733;
 Thu, 10 Jan 2019 09:16:28 -0800 (PST)
MIME-Version: 1.0
References: <20190110092531.766738a0@bbrezillon>
In-Reply-To: <20190110092531.766738a0@bbrezillon>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Jan 2019 09:16:12 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgKMPd0R9dXkJ+49s-rt+=YHTKgBX2WhBieFzi88_=ZYQ@mail.gmail.com>
Message-ID: <CAHk-=wgKMPd0R9dXkJ+49s-rt+=YHTKgBX2WhBieFzi88_=ZYQ@mail.gmail.com>
Subject: Re: [GIT PULL] mtd: Fixes for 5.0-rc2
To:     Boris Brezillon <bbrezillon@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Marek Vasut <marex@denx.de>,
        David Woodhouse <dwmw2@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 12:25 AM Boris Brezillon <bbrezillon@kernel.org> wrote:
>
> MTD Fixes:
> - Fix a bug introduced when exposing MTD devs as NVMEM providers and
>   check for add_mtd_device() return code everywhere

Ahh, and this should fix the reported NULL pointer thing in sysfs.

Thanks, pulled.

               Linus
