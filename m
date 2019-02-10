Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43D7AC282C2
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:43:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7301620844
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 17:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rA8lMsLX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfBJRnd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 12:43:33 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:45920 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725896AbfBJRnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 12:43:33 -0500
Received: by mail-ot1-f66.google.com with SMTP id 32so13809030ota.12;
        Sun, 10 Feb 2019 09:43:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NoXOBdW1wdvK98H/T5FufBYVwps1nmyAk94yhjmbHhU=;
        b=rA8lMsLXVF9Hi32xVQHR8inh7xFON5AnM3oLGR/vz8bf/WLBfqEA/f5Dift3Cp99Dd
         bSq3nwUyGyhbQ5VENiDpZKwuWBFREq5y0zU0lbf6SZlHXzijglQP207YR67f4p0iisDm
         c+9835/XtI/Wc88RjgXdS3Ke8FdQ39gie/Ck0b8H0racjRjXVhlHnSTFpc5tzSKVPUsz
         EMnZIc1aTwDsgPKtmc92sw1UzRFJ3Fo01i+eAt4JkC25VLFDF7BreW8yDAwpmnhpdQjJ
         +Ctvs0SxUC9mzj7dc3RYPk25CZU5P5hT4XhxUVqM+x6B0XML1PDAZoOxzR8x487BcTfv
         j0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NoXOBdW1wdvK98H/T5FufBYVwps1nmyAk94yhjmbHhU=;
        b=NHO8OyQY/4FuU90R5t57V5RvJMlciR6CNqlhyUlkDey/T0Qrw9+4w3rVY/LkmvS3sL
         4tqu3VOyoFV1QHjAuox03gxlQCapetOIB0qbaWsYLmggWevTLRVtORMA3w/34qpetw/F
         N/1cpazc5d4kdISEMKA/snSY2MHOoLCl6Lc5vafHdh5r5kyO7WVplLuuL+y4t28jtTev
         vHKo+x4MyxzYXgAsui+3eC46+enNbGyBetk1q6X18rbwWCSFL6RTlbYush9tC6lKsKLj
         Yo8OipwT5fxkyTEive0KPNTtLLTNXRxg79ljj9VjUJc6xZrBekl90/1R6BEG9XjzkRf4
         3lPA==
X-Gm-Message-State: AHQUAuYrxxMpIpgYTahROIp2wjnCi2OgR7FTJDM556xJT73zFlIXNs7y
        +8Y/UnKH7brRKPgiPn5niYnRuWUmDnt6hf4XZcs=
X-Google-Smtp-Source: AHgI3IZbHiFLPyNiRmFa0c7xuLAIgpysMVcdaEoWm8fX5jqEDnlmJ9uWiifQpFSGQI1uB17Sig91V9qpKEWP4NoWVqw=
X-Received: by 2002:a9d:6a50:: with SMTP id h16mr9684106otn.95.1549820612480;
 Sun, 10 Feb 2019 09:43:32 -0800 (PST)
MIME-Version: 1.0
References: <20190207224650.GA49861@dtor-ws>
In-Reply-To: <20190207224650.GA49861@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Sun, 10 Feb 2019 12:43:21 -0500
Message-ID: <CAGngYiXytDjjAVh_gAaqJa0qLZAM-cTko92s6=PjS4tjZMvfHg@mail.gmail.com>
Subject: Re: [PATCH] Input: matrix_keypad - use flush_delayed_work()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Thu, Feb 7, 2019 at 5:46 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> We should be using flush_delayed_work() instead of flush_work() in
> matrix_keypad_stop() to ensure that we are not missing work that is
> scheduled but not yet put in the workqueue (i.e. its delay timer has not
> expired yet).
>

Could the following scenario cause a use-after-free?
(I am adding comments on lines starting with -->)

a) user closes the device handle:

static void matrix_keypad_stop(struct input_dev *dev)
{
        struct matrix_keypad *keypad = input_get_drvdata(dev);

        spin_lock_irq(&keypad->lock);
        keypad->stopped = true;
        spin_unlock_irq(&keypad->lock);

        flush_work(&keypad->work.work);
-->
--> new interrupt comes in, and schedules new delayed keypad->work (1)
-->
        /*
         * matrix_keypad_scan() will leave IRQs enabled;
         * we should disable them now.
         */
        disable_row_irqs(keypad);
}

b) user removes the keypad, or unloads the module:

static int matrix_keypad_remove(struct platform_device *pdev)
{
        struct matrix_keypad *keypad = platform_get_drvdata(pdev);

        matrix_keypad_free_gpio(keypad);
        input_unregister_device(keypad->input_dev);
        kfree(keypad);

-->
--> delayed keypad->work scheduled at (1) above executes anywhere past here,
--> and causes a user-after-free.
-->

        return 0;
}
