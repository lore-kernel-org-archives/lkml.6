Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EF93C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:52:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEA552145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFZH3kF+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA552145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727303AbeJRWx1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:53:27 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:44007 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726489AbeJRWx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:53:27 -0400
Received: by mail-yw1-f67.google.com with SMTP id j75-v6so11900845ywj.10;
        Thu, 18 Oct 2018 07:52:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TyAKDGJHK+15j+H3G8dduOPWpManal/OwYZXnalI3v0=;
        b=sFZH3kF+UTs0Zt/ZfFyxNdICLRvKiUxbH8j59NAkOB9pFt2g0uMZalFnsaqLLRm/Dp
         E1AyAGHyYrucIIPca8PGnlajsaR225JRy4zh10cASvJR8C+iGlOqgQRrDMCmftqvpj2O
         Xwf6Wns4V0MQtLw0p9dNT2lvGHtWAOp2Rb7EbBMeFtCcSE74UYn6IzlM/DM7e8et/+mw
         jSG9w8saATvOFVxah2G9CqhrgEqN7lKuXJJoDJ0S9uA5fs3LW5X9W5gYgNiXY0lQlmXr
         hFovbniH/BRGZxiyV64MxTVCUGBE5hZYvh+YZrQZ6z6i5mN9kypav6AuOfAl9M8AVha3
         RUpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TyAKDGJHK+15j+H3G8dduOPWpManal/OwYZXnalI3v0=;
        b=QsxH9g0B/+lLrnGb3dZDp27Fkgt9RfqV3zkzVvezXKuUjbDZw9VITii6DH7l875pHa
         E9k4IZZjo95X7yMNYLUB13jYwRiWUgOgqfvMjj5zD9wZ5NHgBfiEDzRx5nZ3BaAlxqiQ
         dnmkVnMVKBlBFtOhjlzb/MJ5g5zp9yBJLLEhVIK/NztmdtVipCRnyJY5wOovld11YQEj
         FWrIFLPxSu/13Bbepw8tg+gLQ5xtnji/MCcF3rxDN8GN2SkCw8WHy3H++5cUkqODWiNZ
         Z2lkUmnkxZXGnKh2sPJ4evgZ6f5DYJDWvsPhJnre1fxOTxPbYT1fPd8KIbEENgSFUJ5b
         +zYQ==
X-Gm-Message-State: ABuFfohG/Yj/ihKdzyKgoQVtotKrd8IsAzQvtO04ifR0F1qRoUZhQ/AZ
        Xm+zv4zUjgkg45f1meWAoJahUfAlLUa1kES6KCjXWXLIuag=
X-Google-Smtp-Source: ACcGV62k4xOFMDo4Ph7fa/fHuhockFrkaHr6E4OKFWD/dY4L0CfIcB2HR+vXCq/qZm7Cuy9gLhDM4Cvi+kwqGXsrDZI=
X-Received: by 2002:a81:ae4e:: with SMTP id g14-v6mr18699759ywk.248.1539874325655;
 Thu, 18 Oct 2018 07:52:05 -0700 (PDT)
MIME-Version: 1.0
References: <20181018131125.6303-1-mszeredi@redhat.com> <20181018131125.6303-2-mszeredi@redhat.com>
In-Reply-To: <20181018131125.6303-2-mszeredi@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 18 Oct 2018 17:51:54 +0300
Message-ID: <CAOQ4uxiFrtphwYhDMpsiENV8zkHHKmthb7cB2T0PKU5BA_YTWw@mail.gmail.com>
Subject: Re: [PATCH 2/3] uapi: get rid of STATX_ALL
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, David Howells <dhowells@redhat.com>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>, fw@deneb.enyo.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 4:11 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> Constants of the *_ALL type can be actively harmful due to the fact that
> developers will usually fail to consider the possible effects of future
> changes to the definition.
>
> Remove STATX_ALL from the uapi, while no damage has been done yet.
>

Look. When Linus says "let's see if somebody notices" and referring to ABI
it means sooner or later someone will upgrade to newer kernel and complain
if something breaks.

But what does it mean with UAPI change?
How often do people re-build existing programs?
I, for one, build master for my testing, but never install uapi
headers from master.
I just can't wrap my head around the backward compatibiltiy nightmare a change
like this could create.

How about just leave  STATX_ALL in uapi header to rot forever
mark it with a "deprecated" comment and #undef it out in include/linux/stat.h,
so we can't use it in the kernel anymore.
No use experimenting with pain.

BTW, man page needs to be fixes as well, because man page promotes
STATX_ALL.

Thanks,
Amir.
