Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 684C8C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:42:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38E68218A6
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 12:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IWiD04B0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbfBKMmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 07:42:40 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:33869 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727191AbfBKMmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 07:42:40 -0500
Received: by mail-ot1-f65.google.com with SMTP id 98so4511131oty.1;
        Mon, 11 Feb 2019 04:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0p7R5ccWX7Wh4n4cFrXlgkXgGkmo1nTEtywc6I+NpE=;
        b=IWiD04B0cgb8IRwjkCADRJq3tAldp72DGPwHlkvTHrircLni3fKk8wiXFNFx4tm9Lj
         xAqODXZyEtO2HI+IvZCojQZ6CgFauzGWYzBiYROnDLo9yXLsACHHlgpyEZYlQr8Ou+fQ
         YGWb0dgXj0TVDMvfzOJYIhDObIQ17oL9fqhiRJ9z5oB5w1C5Oz/Tx4vQVKu16vmX750I
         cZk4j9c5JotvjbYPTm0uZ81I2CWQjdKuN+eCO7h2l+CmmiiAXzVqAQ5RjAl1PwfNd6H8
         /NR/ms2mrxDu4+FUEa2AUkiV5QrjLCMNWqyWNNR3yIhQ1RbOG0CrDoVOtDJKwgyHtp5N
         wv5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0p7R5ccWX7Wh4n4cFrXlgkXgGkmo1nTEtywc6I+NpE=;
        b=DvJZqqdyAHfEsxDqTU9Gucjw9d6bQuFNPU3HeIdqOuWOHhDaav7AtPXcD1qnciRKQj
         ladV3c3XJByYufmDsDSArZicLys9PsONDRu3HROiW3nqnrufhVNVR7ABiOrUVgarA+It
         G8MkXJAXjkN/7wnN1iFO6opGxFD+UAwMrNdZ2mWfP5AjrJ9Tko5I9yr+4Tt3ah7khr05
         8VQ3Ky+DMUAk4dUnYHpVj4vYokibi05EGeDocU99zKg4gxmpKQfHW+KLUtXOrohPMhbO
         XViDXtt66yY8HSXS1jHie+gu0xgZfxpjiXhOegDhkF9y0Ou5pfH4Znudr8C19Ni4OxZW
         0bkg==
X-Gm-Message-State: AHQUAuZz5TNtZH176gc9Bn8SY/nwEB/XDlrPfAQ6CDlVJdhqi6YmaLn0
        NTZ7zMsLbzcdz58oVzjKYQe+7aiiAlMpO6sE5aA=
X-Google-Smtp-Source: AHgI3IYXVhPE6p7VkjxlCCE0Q+lNMNC/dtysQfSN+HfbU7S815WQQ+KX02lLOGemOYt7PanwwGak33hK6mV6fOwIsk0=
X-Received: by 2002:a9d:61c8:: with SMTP id h8mr26164342otk.279.1549888959247;
 Mon, 11 Feb 2019 04:42:39 -0800 (PST)
MIME-Version: 1.0
References: <20190207224650.GA49861@dtor-ws> <CAGngYiXytDjjAVh_gAaqJa0qLZAM-cTko92s6=PjS4tjZMvfHg@mail.gmail.com>
 <20190211082902.GA95126@dtor-ws>
In-Reply-To: <20190211082902.GA95126@dtor-ws>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Mon, 11 Feb 2019 07:42:27 -0500
Message-ID: <CAGngYiXZ-vgX4MTJENRaPPoj12gBNFffjOef2F8NeOy0RT8hTw@mail.gmail.com>
Subject: Re: [PATCH] Input: matrix_keypad - use flush_delayed_work()
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     linux-input@vger.kernel.org, Tejun Heo <tj@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 3:29 AM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:
>
> It will not schedule new work because we check keypad->stopped flag
> in ISR.
>

Yes, you are correct. Sorry for the confusion.

Reviewed-by: Sven Van Asbroeck <TheSven73@gmail.com>
