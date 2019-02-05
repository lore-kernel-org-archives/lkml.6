Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E6AC282CB
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17D3A2083B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FYri8D4s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727847AbfBETMn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 14:12:43 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45253 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfBETMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 14:12:43 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so7598500ota.12
        for <linux-kernel@vger.kernel.org>; Tue, 05 Feb 2019 11:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IQR0sfSThGdJf7JiIGKx9tMd5nrBfoTCzFkFA6biSt0=;
        b=FYri8D4sHeg6mx7W7/Xy00rPudH/SzGGgldFZDshCaNudomF3JUNib7ba+L3BplJJf
         Z7j3p94FIUN4+Ojdye8EsTy4xh2SIfa7tQQVvbLkFgl4ZH7X7aqHKFWxCnRA1cbZSaor
         qfCDk1X9Ly3OZ4UvmP05httMr9Jn9c7GWfRj/L1FFrYRncmMo/0LEWdg46oeq5XNSGNR
         kn2NkJ2e4osrAPKjFEk9dl/TUwY+uFUJZ0qkfTwYBxgkTjptzdpDbTqxBfxn9qH6c+Df
         9UEWz84rNjqcl5FBZb923lvN406zpjmnbr3IowbpB+WkBuur/VmqODTL25lrDriCeE1/
         bYmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IQR0sfSThGdJf7JiIGKx9tMd5nrBfoTCzFkFA6biSt0=;
        b=L88CHlGEaHC6H8zimiBK1BnfWmiU3xm2DaK2hIMoXfUiAbhHkFhonWu+8kHdDVn00J
         wWUts+uKHH4EWUVkThy6E6k6vtf1mdM0JVJD+n2O+cB9T17eEyzv4NjlY6rHshXvTtti
         glfmNzCOqQ/c+F00Mh1/4lvwpkU9lnvqc5eohxhj7fOk8LkobnQA4LZbOCv/Twtb2X1K
         7sTOrEyjO3kC3pK3Z0in1aOifRLFxAJgUAOYVm1zyYoO7yp6geNTwhRPXfG27svnf4oa
         C/322Y8hvUHobRsU2jFDNLHeu1DxCS901wrgpOSK+2kq5Mk2NXCDUTC0dcDibHU+Kiyq
         pAGA==
X-Gm-Message-State: AHQUAuZ4aqa8/3EeCNpfh/DQxjaT4LLuDEs8Uf2r7OS5JCc6Qk/8GuBE
        EnwtHKAyyhZgHdUezstZsevJzb7fmmOGbq11mUw=
X-Google-Smtp-Source: AHgI3IZGKr/kTbVp8L9sjxbQ308iZQetu8O01W1DkhA5yOCmIK91pWfJCgsPpJTZTP93gCsrmjGaMKED0ZqWDYlz02A=
X-Received: by 2002:aca:d705:: with SMTP id o5mr3278441oig.124.1549393962349;
 Tue, 05 Feb 2019 11:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20190204220952.30761-1-TheSven73@googlemail.com>
 <CAGXu5jJ0g1FUd3mX=RkJCN=BazaWWybAuapvjngpLcWtz3FQGw@mail.gmail.com>
 <CAGngYiUsq55EUKa0rYCeQ62VanhwNUxs-pfkJxUwqd4HO3m-Lg@mail.gmail.com> <20190205184355.GC22198@kroah.com>
In-Reply-To: <20190205184355.GC22198@kroah.com>
From:   Sven Van Asbroeck <thesven73@gmail.com>
Date:   Tue, 5 Feb 2019 14:12:31 -0500
Message-ID: <CAGngYiUMuM_ZxHKVWRihDHZcMncvTwR6Sz1zGNJLrGpyhhT1uQ@mail.gmail.com>
Subject: Re: [RFC v1 0/3] Address potential user-after-free on module unload
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 5, 2019 at 1:43 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
>
> It really should happen when the device is removed (if it is a driver
> that binds to a device.)

Absolutely. That's why I'm advocating adding a devm_init_work(),
which will take care of this automatically.

But it's of course not universally applicable. Not all drivers use devm.

> If this is not a driver, then there should be
> some way to scan that cancel_work_sync() is never called or not, right?

Are you saying the same thing as Kees, that ideally there should be
infrastructure that WARN()s if work isn't cleaned up properly?

I guess for that to work, the code would need to 'know' what resources
the work function is touching. And warn if one of the resources is freed
without cancelling the work.

Also, cancel_work_sync() is only really needed when running the work
on a global or shared workqueue. If it's a private one, then destroy_workqueue()
is good enough to cancel the work.

Sounds like more of a job for static code analysis? Coccinelle?
