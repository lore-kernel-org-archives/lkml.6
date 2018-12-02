Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C8FC04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B80732081C
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 08:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhshaSvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B80732081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725799AbeLBIp7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 03:45:59 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35504 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbeLBIp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 03:45:59 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so4442525itp.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 00:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3bWKE5JSALxoJQI1liVvsuuMJC0VzlUP/kNW2jboTMw=;
        b=qhshaSvjY82dhjjMS4YeVV252/5UOPwD6v6GWBRDYsxhcjhZradz9m/ZRkho43FLj9
         pGV2h98XNv/s42d1J2irEMEPhThp5GvGTWgSH7gYqOLfc2L8lGvJb8llHJ20+NpYZmev
         X2xboe3D//Cpig90yCcecIv6sZ/Vbii49IR94D7qS9MRVKFFQ1PgbFRzM2H08OuCwr4+
         DD2osoZR8c2Q91fFkehXxApkGoZMZ+ckTCZCbzB5gUAzSaa2lz0kCyFhF9UinHyXDeSe
         jnBa3r6GgVKDJG8bcS65LVPqWlnOWBGtHUrBbX/FmK1Acss7iCiz/MtPKAxLBlIyWJkd
         g7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3bWKE5JSALxoJQI1liVvsuuMJC0VzlUP/kNW2jboTMw=;
        b=kZZ4Awr9MhRbcJ6UC08CdHV6k8O9s5Rst9W/Nu7SXOJH6fGzf6Rx0w2HA8P+p3Aeca
         WLJdO4pNjKQLV3WUdkRDkSg5NkVHPg2bVpnOb0SXa4UZ5g2oDc9c9J1COrZu4RbgfCyi
         wqt0DKKuwm4GYgTeyxydNqWgUcoeX+tDAR0jyCO7BQt4YWCopuwZYGV7h+dFcgorM1fP
         D0sTqk7Isa9OnqugVOLq0/RvQENPLqHiCsWm6ePXZI5r4b2y/svYIi/i1LVQhLLUkmo6
         SsRXCOTJUAn2G07vEnS9zQdTFBqDUwSp6z042ePwkWariNJDs8NnMawXSl8I/m27AYvl
         ZWeg==
X-Gm-Message-State: AA+aEWYexbd2BuGtnm3cc0dVK/GdNsQzGA8nGDpCsbeShunYyj26U9b+
        O/8/WVheSZDUl154BHYsevKc2uD+H8Xk4WFHTFk=
X-Google-Smtp-Source: AFSGD/W2JmfXgV9ZcHU+1WS0me+0pWgzrHvOnfFWNRPeVSVC3MsFnv8Kr42sEIANW8yhcsWLpotE6bvcJ2Bt2h+7gig=
X-Received: by 2002:a05:660c:250:: with SMTP id t16mr4204632itk.78.1543740351623;
 Sun, 02 Dec 2018 00:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20181202083358.10896-1-tiny.windzz@gmail.com> <20181202093958.6419fd24@bbrezillon>
In-Reply-To: <20181202093958.6419fd24@bbrezillon>
From:   Frank Lee <tiny.windzz@gmail.com>
Date:   Sun, 2 Dec 2018 16:45:28 +0800
Message-ID: <CAEExFWvqhFBEO2eGm9UQsE9w3-cdkN7dRCk96YdBFzA6HjN0zA@mail.gmail.com>
Subject: Re: [PATCH] mtd: use DEFINE_SHOW_ATTRIBUTE() instead of open-coding it
To:     boris.brezillon@bootlin.com
Cc:     robert.jarzmik@free.fr, David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        =?UTF-8?B?TWFyZWsgVmHFoXV0?= <marek.vasut@gmail.com>,
        richard@nod.at, miquel.raynal@bootlin.com,
        Kees Cook <keescook@chromium.org>,
        Shreeya Patel <shreeya.patel23498@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 2, 2018 at 4:40 PM Boris Brezillon
<boris.brezillon@bootlin.com> wrote:
>
> Should be [PATCH v4]
>
> On Sun,  2 Dec 2018 03:33:58 -0500
> Yangtao Li <tiny.windzz@gmail.com> wrote:
>
> > DEFINE_SHOW_ATTRIBUTE macro can help us simplify the code,so change
> > to it.And change the DEBUGFS_RO_ATTR macro defined in some file to a
> > standard macro.
>
> You still don't put spaces after commas or periods
>
> >
> > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > ---
>
> and you miss a changelog here.
---
Changes in v2:
-Remove a missing DEBUGFS_RO_ATTR

Changes in v3:
-remove the blank line between the function
 definition and DEFINE_SHOW_ATTRIBUTE()

Changes in v4:
-update subject and changelog
---

Yours,
Yangtao
>
> Anyway, no need to send a new version, I'll fix the commit message when
> applying the patch.
>
> Thanks,
>
> Boris
