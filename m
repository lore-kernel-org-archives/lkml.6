Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A762BC67863
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51C4B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 20:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THHXDL9l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C4B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727278AbeJSEKC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 00:10:02 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46709 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeJSEKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 00:10:01 -0400
Received: by mail-lj1-f195.google.com with SMTP id x3-v6so28864227lji.13;
        Thu, 18 Oct 2018 13:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3GUAY5V0x4vuuUuv+vFMbNl2mWcSDPX0oSrtK5r3HXA=;
        b=THHXDL9l/tPtFZC5B19CL+jnZ8RNHlMC/cp84BW7gyhPLnpwtT36HQyLOHi2XX6fUP
         V/+pXTQK6x7qx64/STiIFU41OIhXpHONtZY7isKN+mZcHxqFf3rAA6KlV46WyIf7l8Oy
         VIC1Z3Zo0NCy1G5M/6XHt9vFUh+uVHhrY1fTKzbsuzM5L9EJFkNk2nCPhrhMz4a487Vl
         jlLt5lpB9W20qgF0cFpjbiSa5iW+lQV3p6+230huYOS41u4dfG29zetH0eTZqrZnkibM
         WdZAvmw+iHt1qCnH/GbsAtcWvJ2gusA23SP04NUZ6zwVdrbPCZ+CJ2hjkTE0fEQieJeB
         OJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3GUAY5V0x4vuuUuv+vFMbNl2mWcSDPX0oSrtK5r3HXA=;
        b=neG8OV2c9eHCyjbrq8ccKEyZHCfFh6sYy8ymx1etQVZ3Hhbp9mQUykg11Oh0V120ZE
         oBpCNk44drltiIU0c7OV29JPZTm2Qc9+ngXLVUGEL8DxE8YXoqz9PXpVHmlj7+ps2VKq
         zl3ID2yn5fX5YZ7mbxJiOUFhVss2oZ/I9XfYHVmz+6mSWtv1iG/vMhRfZyfuej/RAuG7
         Pb3Qf/9Zy6l1ndsyCMqrRPZnm1nPc0SC9GdITdwt94h37dUhOiyWc0v9L3/IyJKHhpg6
         HPqB8lTea1IVh4B9257YhTcQY8BD6EPSOXtJCZMoEmPyUJxN58d5YhAb3weSbLY35GqR
         uvbQ==
X-Gm-Message-State: ABuFfohl9qprWi0JLs5UcJbfdGgq4NgJ1rd77VyP+5pkO7iwEdAud81W
        lQOi0KVb2ZOjQHPFciFctnp5bFh0X3TII7oNovtPq6yD
X-Google-Smtp-Source: AJdET5enYYYU0+ZwuOuaWt4ZkENyK3zUusz/CBnSiZzkAhuj8gl9jdTiNC8jmtk2IDHo+SQGmxNl0nEt+bhTYaiFyXE=
X-Received: by 2002:a2e:810e:: with SMTP id d14-v6mr2594232ljg.170.1539893242744;
 Thu, 18 Oct 2018 13:07:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181016111313.GA28307@embeddedor.com> <20181016172107.GA230131@dtor-ws>
 <ead3e95a-1acb-362a-0ee2-d02dbc4f378c@embeddedor.com> <26EEA6BC-43B0-42F7-A237-572D32EB2309@gmail.com>
 <2856297d-9af0-e005-f926-e9596d437fad@embeddedor.com> <20181018204344.4c135203@alans-desktop>
In-Reply-To: <20181018204344.4c135203@alans-desktop>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Thu, 18 Oct 2018 13:07:10 -0700
Message-ID: <CAKdAkRScDtz4_=j=km5N0DkcSkwSb4pPZroaB60Oca8VegTwLg@mail.gmail.com>
Subject: Re: [PATCH] Input: uinput - fix Spectre v1 vulnerability
To:     One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 12:43 PM Alan Cox <gnomes@lxorguk.ukuu.org.uk> wrote:
>
> On Tue, 16 Oct 2018 20:12:43 +0200
> "Gustavo A. R. Silva" <gustavo@embeddedor.com> wrote:
>
> > On 10/16/18 8:09 PM, Dmitry Torokhov wrote:
> >
> > >
> > > /dev/uinput
> >
> > I've got it. This explains it all. :)
> >
> > > must be 0600, or accessible to equally privileged user, or you'll be opening your system to much mischief.
>
> Still a correct change.
>
> CAP_SYS_RAWIO is not the same as being root, especially in a container.

Giving access to uinput in an unprivileged container is nutty as well.

Thanks.

-- 
Dmitry
