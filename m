Return-Path: <SRS0=AzW9=NE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74801C004D3
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28F3A2064A
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Oct 2018 10:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NW5feS0a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F3A2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeJXSeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Oct 2018 14:34:37 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:35341 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbeJXSeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Oct 2018 14:34:36 -0400
Received: by mail-yb1-f194.google.com with SMTP id k132-v6so1872692ybc.2;
        Wed, 24 Oct 2018 03:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=38knXe9PORHuogEUSTm05eFJNSZhHKE2Qs+GaIqXOcM=;
        b=NW5feS0ad/C+/B/fZ4Qi3wj4YCBb4ZJ1wBA45Lf8Pr/rACcX8DJYMMr8GZU8Mi2Etx
         Cp69q4dF4pKFTvUxlbTQ08PLYnKedWTSF3l5xBzjQ1/yaZQKq8sQK27csrAcrp/wFxJH
         eSeYGFYYj7yVDCFYNpnJRDvN87kGpub1y1hbo0C5L9gxs0/OB1TlgBNOUa0bA/yM/KYN
         d5ZeLZLc37J5pI39+FfR+Msqk7hD6hK9zHM7JtoQ6905/KRpafF2e0RRpIOR4hBHkBvY
         psk2zpCbbpJ/CuIHMtIBVY4B50vhWr8XLky/zV7g2WjWu/6tz449NInf4p8uFatxk19d
         Y7HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=38knXe9PORHuogEUSTm05eFJNSZhHKE2Qs+GaIqXOcM=;
        b=nRtq8W+srgDyW2qExkiXKjeG/byrCzEW42wKFvLkt3xWrRHAhs70+NTVrt4SBzTaH2
         ghBq5q8YRgUOSp6v4QHWNthLwcaIfLFiIefJEk2vZ+3rQfpUsfwDF5L7fUWgAJtpsJsO
         FZqCIpp+rD3pDHe5w4X+FJmHhtxRx1xX54LWKHz6ObwDTs1E05zKXy4ZWTzoNdJPPKbs
         DNWfy1XwPN//kP5oFS4a8xeiY+77xbrhQ7wCizF0W75+iQRM7VFcJAhYA3yRBCncoSJS
         D6/6E/JyYD7kI/GMysYLncwMLnKRf2qDJJF3qDRxf/z6ASdjO8llJ/SOMPBF2J8nKymV
         sc3Q==
X-Gm-Message-State: AGRZ1gKSqtbBBoXLEFDW536GJUwGQcInxU0pAwDvpb+LZXSKjDMqNt1g
        /JokD2LskNP794J5c3OHXlTY+wgoUtf3hnmhL7U=
X-Google-Smtp-Source: AJdET5f9b89FmnrphcLYOKi6/O9WIzO2FSen0gHl3rmTPnhgDsJAbNcZwv9K32LxTV5VQZwkjW7lwojPGTfMfurq2LM=
X-Received: by 2002:a25:6607:: with SMTP id a7-v6mr1553996ybc.507.1540375628672;
 Wed, 24 Oct 2018 03:07:08 -0700 (PDT)
MIME-Version: 1.0
References: <20181023201953.GA15687@pathfinder> <CAOQ4uxjfChxZyAUiYKQ-UiVjmxsosR+KG1ZSBu2TOeuAX3vJnA@mail.gmail.com>
 <20181024082134.GA14565@pathfinder> <CAOQ4uxjQwE2nhS7KccL_P+jUnz4vGwTpxjQquvbaZ0zZpJqGtA@mail.gmail.com>
 <20181024093103.GA19623@pathfinder> <CAOQ4uxjyTtjPk1OaWCSKs3Larqog+vmqLSth1kKWdOA5oRTtAA@mail.gmail.com>
 <20181024095601.GA19974@pathfinder>
In-Reply-To: <20181024095601.GA19974@pathfinder>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 24 Oct 2018 13:06:57 +0300
Message-ID: <CAOQ4uxjJz+WLGdhW8_y715h0BRdhitUzdSAQHn74_4X==zp+3g@mail.gmail.com>
Subject: Re: [RFC][PATCH v3 01/10] fs: common implementation of file type
To:     Phillip Potter <phil@philpotter.co.uk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 24, 2018 at 12:56 PM Phillip Potter <phil@philpotter.co.uk> wrote:
>
> On Wed, Oct 24, 2018 at 12:44:50PM +0300, Amir Goldstein wrote:
...
> > Well, I did request to change some content (the location and the comment
> > above BUILD_BUG_ON section) which is relevant for several patches.
> > However, so far affected patched did not get any Reviewed-by.
> >
> > Thanks,
> > Amir.
>
> Sorry, I missed that bit at the end, was too keen to click through to the
> note about the alleged ext2 bug :-) I will make sure those changes are made
> as well. By location do you mean the location of the v3, v2, etc. stuff and
> your point about including it in the main [0/10] message rather than the
> patches themselves? Again, thank you for your feedback and for being patient
> with me, I really do appreciate it.
>

By location I meant place BUILD_BUG_ON() at the beginning of
ext2_set_de_type() and not nested inside inner scope of ext2_readdir().
And find similar appropriate places for other patches.

And one more thing for next posting - LKML is probably a too wide forum for
this filesystems cleanup series.

Cheers,
Amir.
