Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D07C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A08D12064D
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 08:37:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hYrYsW3i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A08D12064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeIENGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 09:06:50 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:39155 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeIENGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 09:06:50 -0400
Received: by mail-oi0-f50.google.com with SMTP id c190-v6so12091485oig.6;
        Wed, 05 Sep 2018 01:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zxlSGjdux2i6IgUjBbfJPsPiifmkQHS2tdUKZHgz66M=;
        b=hYrYsW3idi2dmHoVOQgsZyDIfa+QxYnJusxvzVmHS7QbnV7AEVFn0maaJOZdWCzE4T
         3rXfeeOkQlUQ6p1QdFBFwXYv8UvXME3GSw301pZngVrVy+u5ldixFLQmLjUlqdJ+1aPo
         WHlGlDb/+sDTOL37rg3ryDBsEsZ6WXk7Hd69koIl914V7sRUwmff7FkYtK9PYqygrm9N
         Vdal297SRaXZwoASpL7Gt+dQglPtIxv3puQ2xWX+k1HFpSluqbHFqJAjEFpo0ls73H4B
         /E9E4cfyqXHBb/7NoP+FyxYyzi1KabbxHW9BGykBJZyQjNxBhq7rKJLUChPWRGRO18yn
         vptA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zxlSGjdux2i6IgUjBbfJPsPiifmkQHS2tdUKZHgz66M=;
        b=MlsTMmzetP07HI/UCFiOxhmHWPxGJAQGTYNfNwfEPmMd0b/NkKqD5fD4v3s5vr9AYT
         Q949re3ltOdiakPQGs9JANKbhZbZ8Zedv5iOt7UG46XUSJuyFTilHgha/vl5AqkOs+kg
         KleVB2LydMRKZfMMuYnU7fc07EsK8OxozlSzbpHE8PnwXcw71awRgPp77uniC/qUoMSe
         ELEaxRcYGynU7QL7uHIsIYtP3HHpAXhWWFaJeWKr/6ILVMqMMEM+8ByqBnmoxcFXYCE/
         k0L7z1XaLdPZrzVk9RXAq/XlcTQSdxXk8RRXDdwZzBvq0mGj9yzp/H8kVc23k7VkVNf2
         fpjQ==
X-Gm-Message-State: APzg51B8WGLPh28v+NJG2m8GBWNI2KQh/FoqyfTIhyCed/jANdN00Kq1
        3PL/sPgu10B77oHhNYWLcLADIxmLlGQWdl2mp0c+SLPNuLZHUQ==
X-Google-Smtp-Source: ANB0VdZxaSFiSQF5yRlTN73dOJosvI6bT0K3+HBdXy/Fm7qTwLXb0I5YqCfvkEm+JUJsscGs4SrNK74dvNaOc+v8TsQ=
X-Received: by 2002:aca:aa06:: with SMTP id t6-v6mr30251522oie.152.1536136661732;
 Wed, 05 Sep 2018 01:37:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAJDTihz-rFb2SGaxZsQnXGnee_2qW_ynhPe=tZ4yzQBSV_KQ1g@mail.gmail.com>
 <cd137e88c9e882200c08c7336aa7b5a1c84a7ba3.camel@redhat.com>
 <20180905070847.GC24519@BitWizard.nl> <3805399.0d8HT3LL4o@merkaba> <20180905080444.GD24519@BitWizard.nl>
In-Reply-To: <20180905080444.GD24519@BitWizard.nl>
From:   =?UTF-8?B?54Sm5pmT5Yas?= <milestonejxd@gmail.com>
Date:   Wed, 5 Sep 2018 16:37:30 +0800
Message-ID: <CAJDTihya-DxyjzPJfh0LX+qOs2jvwr5TakcmRr8_U7h3pdw6cg@mail.gmail.com>
Subject: Re: POSIX violation by writeback error
To:     R.E.Wolff@bitwizard.nl
Cc:     martin@lichtvoll.de, jlayton@redhat.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 4:04 PM Rogier Wolff <R.E.Wolff@bitwizard.nl> wrote:
>
> On Wed, Sep 05, 2018 at 09:39:58AM +0200, Martin Steigerwald wrote:
> > Rogier Wolff - 05.09.18, 09:08:
> > > So when a mail queuer puts mail the mailq files and the mail processo=
r
> > > can get them out of there intact, nobody is going to notice.  (I know
> > > mail queuers should call fsync and report errors when that fails, but
> > > there are bound to be applications where calling fsync is not
> > > appropriate (*))
> >
> > AFAIK at least Postfix MDA only reports mail as being accepted over SMT=
P
> > once fsync() on the mail file completed successfully. And I=C2=B4d expe=
ct
> > every sensible MDA to do this. I don=C2=B4t know how Dovecot MDA which =
I
> > currently use for sieve support does this tough.
>

Is every implementation of mail editor really going to call fsync()? Why
they are going to call fsync(), when fsync() is meant to persist the file
on disk which is apparently unnecessary if the delivering to SMTP task
won't start again after reboot?

> Yes. That's why I added the remark that mailers will call fsync and know
> about it on the write side. I encountered a situation in the last few
> days that when a developer runs into this while developing, would have
> caused him to write:
>   /* Calling this fsync causes unacceptable performance */
>   // fsync (fd);
>
> I know of an application somewhere that does realtime-gathering of
> call-records (number X called Y for Z seconds). They come in from a
> variety of sources, get de-duplicated standardized and written to
> files. Then different output modules push the data to the different
> consumers within the company. Billing among them.
>
> Now getting old data there would be pretty bad. And calling fsync
> all the time might have performance issues....
>
> That's the situation where "old data is really bad".
>
> But when apt-get upgrade replaces your /bin/sh and gets a write error
> returning error on subsequent reads is really bad.

At this point, the /bin/sh may be partially old and partially new. Execute
this corrupted bin is also dangerous though.

>
> It is more difficult than you think.
>
>         Roger.
>
> --
> ** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 *=
*
> **    Delftechpark 26 2628 XH  Delft, The Netherlands. KVK: 27239233    *=
*
> *-- BitWizard writes Linux device drivers for any device you may have! --=
*
> The plan was simple, like my brother-in-law Phil. But unlike
> Phil, this plan just might work.
