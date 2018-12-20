Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F034C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CCB021741
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 12:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vau83I6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731816AbeLTMOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 07:14:38 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:34472 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbeLTMOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 07:14:37 -0500
Received: by mail-oi1-f196.google.com with SMTP id r62so1533419oie.1;
        Thu, 20 Dec 2018 04:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vKIQFe8ZjyOwG1eWECy8KySg8iaG6d+j0IMILEa5uDo=;
        b=vau83I6osaW3AzidcrCr6epFjwT5bmSkh5+/YbfsvbLDiFckCH/aP5J8SA8hTKLhTV
         lmXDtEfEIkG/Kqj9X9Tzv3L/EEimyqx7W7k1pGj/yjOsicPlQew6CR2msrCQoSKYT2u6
         dC87CzvIL5P13bYK2q19aC0NfiauEJmlFq2kJ7q1wv7aKLD6MBGqXNi/Z5bj11Skttmo
         5iQbzLIPFQxAEboncODIoj1q5oK2+HltmDpBF6jJp3sbqh0MulvpuKLNlCQxJyI2+YQV
         IbCXoItq2Qsa5imtGO/xv/i6GksLIz1yVz53KLfr9REFAdA5N9QR0WzTGcLp/IkonF6G
         YH4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vKIQFe8ZjyOwG1eWECy8KySg8iaG6d+j0IMILEa5uDo=;
        b=KjZjc/qRCiHI51HTvI2adWA/zpj+W8QbQ7bog/i+4cYUwZtFewJHeITYD6o7RT/sg9
         hV6tZpXtJMZTderVk6MpcpX6xMsseImdCjr9vjGNZGjxe/lA0p1hihE3yTBUvu88h41a
         Qf3bYBSxXG49U2/twrfgRsb1JMUqfgJ/WXyH1bZldf6qhGG4IDuNPS3B1p9cCY1gd3lP
         BKxSySIjNDzqLMU94Gv7d+wZXqN7ptOvRimC2kIBnXCRgEsOBp1DHfqaZt7Ly1FauFU8
         exnCA/TR0RFEXEylflgH32IRLdjs4wD8vmWlAdfRRsbSrSd0PMdWaYk7Silhw9Yq+j7X
         +Bbw==
X-Gm-Message-State: AA+aEWYcHi1jPSjIH5M2RQfc2f6WxC+TM05tX01XsqgoNOdXNTUqjcWD
        mFyes4AFpTLAoP9dQUkeLNjTsFNhCzQOO9B1EfAKTWtw
X-Google-Smtp-Source: AFSGD/XzBJ6ARiWqBtn+YYCqG+9x45cO3S2QUjkyrO6Ct3Jlz4UcJtdqQv9G006CbqnbGKzgSMiEbvfBZ4cMiV6HwCM=
X-Received: by 2002:aca:3345:: with SMTP id z66mr2087063oiz.91.1545308076519;
 Thu, 20 Dec 2018 04:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20181220085922.332225035@linuxfoundation.org> <20181220085923.488666294@linuxfoundation.org>
In-Reply-To: <20181220085923.488666294@linuxfoundation.org>
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date:   Thu, 20 Dec 2018 12:14:00 +0000
Message-ID: <CADVatmPEbBoEeVvAOMkcrsge19ceAkDT5fzEZbMAdTnD5wg6eA@mail.gmail.com>
Subject: Re: [PATCH 4.14 29/72] locking/qspinlock, x86: Provide liveness guarantee
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Stable <stable@vger.kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        andrea.parri@amarulasolutions.com, longman@redhat.com,
        Ingo Molnar <mingo@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Thu, Dec 20, 2018 at 9:28 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> 4.14-stable review patch.  If anyone has any objections, please let me know.
>
> ------------------
>
> commit 7aa54be2976550f17c11a1c3e3630002dea39303 upstream.

Another upstream commit fixes this.
b987ffc18fb3 ("x86/qspinlock: Fix compile error")


-- 
Regards
Sudip
