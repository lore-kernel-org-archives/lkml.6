Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B82C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EF220989
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4qqhgBL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfA1JIk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:08:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35955 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726648AbfA1JIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:08:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id g11-v6so13539291ljk.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 01:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FEn/jn/6ZmaKXY4ewFiv4XfKfXIhmGqV/zM3n2EaLw=;
        b=e4qqhgBLbBj6Y9VthzIU9HCaiYZgOTkYQ45MJk5MFHHnh5rsMCf0a25Rcfv83zKD5n
         gKvpgQt6U7iSdH6NWJExvFu/jTYSvxqUIy+BIKag2R3meY0lF35vMOwUfQTW+ENwsB3d
         EvRGXKMm17E9wYImwE/fL3shvEQ5vpRKeqOjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FEn/jn/6ZmaKXY4ewFiv4XfKfXIhmGqV/zM3n2EaLw=;
        b=VK3eDYC3IBO9pkuVTyNsMqyQQ/BE8npsC1kPQb6AKiPE4GeC4aWHT2PO4hWi6fchhc
         EXP/XTKgiY/cDDCzBgWZhYc7XbSwzeOrmcK3gHHLtwJlgAWkbyyi6UeJEs/DPtcLkHLp
         p5NKtdSoWXFn5BHZY4RawXc0v3M2gC+pYVnxGAO3xedxgJWLz8CmWyX3mXerhJf0PCpY
         50vtkYl/4L4mEYF/G5CSX+3vja6UBAfo+jd8VdcEYK7QKreL5vSU+NmSTehNk33HyubD
         H1ibNqJsJZupaeZVtap4+L9cznZwGVfkPfRgyVhTUQ1zWWh4zlVGG9pxftp3wjS2iQDt
         cxgQ==
X-Gm-Message-State: AJcUukeyeTcoi4iAe31T8XkAqHryvSH6y2+t3VFr7xmfN+YLjaVRVAKJ
        6NJJGR628Vkh7zhOXQ9Nf13Q5QL3RpZphy7ydWHKgA==
X-Google-Smtp-Source: ALg8bN7g8C0muF261PwxkGrap2+4ML4yaUpXFHweRhs0KTimHWgsMyXdOH5tTcvzMOG5/V03nDQiaPLNa1fFJJvOzmQ=
X-Received: by 2002:a2e:131a:: with SMTP id 26-v6mr15950792ljt.107.1548666517943;
 Mon, 28 Jan 2019 01:08:37 -0800 (PST)
MIME-Version: 1.0
References: <20190121143822.20225-1-ramon.fried@linux.intel.com>
In-Reply-To: <20190121143822.20225-1-ramon.fried@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 28 Jan 2019 10:08:26 +0100
Message-ID: <CACRpkdbgq-FdsBghLMgSpPWX0LrEBL4bhSXRh24E1oaQ1OdjiA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl.txt: Remove outdated information
To:     Ramon Fried <ramon.fried@linux.intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 21, 2019 at 3:38 PM Ramon Fried <ramon.fried@linux.intel.com> wrote:

> Returning -EAGAIN is no longer supported by pin_config_group_set()
> since ad42fc6c8479 ("pinctrl: rip out the direct pinconf API")
>
> Remove the relevant section from the documentation.
>
> Signed-off-by: Ramon Fried <ramon.fried@linux.intel.com>

Patch applied!

Yours,
Linus Walleij
