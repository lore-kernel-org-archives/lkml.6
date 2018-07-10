Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 116CEC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:57:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B787D208FA
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:57:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeRPPYg2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B787D208FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732601AbeGJS57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:57:59 -0400
Received: from mail-oi0-f51.google.com ([209.85.218.51]:43206 "EHLO
        mail-oi0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732299AbeGJS57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:57:59 -0400
Received: by mail-oi0-f51.google.com with SMTP id b15-v6so44617525oib.10;
        Tue, 10 Jul 2018 11:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LYm0GEBhYZ4T1CqCXK8I908YDeIYsq02MIuzMGia8dM=;
        b=TeRPPYg2rXeieYO1BNYlVUTidWOnlR9RnEq2pMj2WaVdDmvNQraDNV1GJxMBATZPjK
         pNHhqFBUlndujySq5illB24bztBLw6/t767OBdfrH4VQoa8eoif6oB4OwQYuux9VHPUW
         timvtEkBOPOTc8K7oD+AQOiTuOylBkBA4P+t0HrL8CKdl8u2iKsuP+UGa2arMTloNaC7
         bLxik3nEKH6cKHSvinO4hrliwojAjkJcL0LGikaAkFAq3eLNZucKaUlPqAiUYzTH09Zo
         ww+TJ3wLuZPN0l6IVzTpW+Wy/rBoz7c2ciE149M6YJZA9vWZye3qrxy/qHJoqSMj6RtB
         bZQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LYm0GEBhYZ4T1CqCXK8I908YDeIYsq02MIuzMGia8dM=;
        b=SPYUvsZsY3VfGkY2/2XSnYg5iW5+moGB05bBvoORLDTXm2uYtYRAvpyacT2XaXasin
         4wwAte/FhuERsuoN9rSu0PY7I2EvWV4nnzGdjYq9xtDokjp3MQVXz6uqN2GYGHYBYY+v
         5RGLvOOjRFac7eWn38HieTpd76u3HfEo3xnfqo/cjDskrGnzrNEL/dpO8U/8me1kvce3
         crhCTS/kSJwxa7zKop/ZNhd7P+RhgFZyJfp/E7OCaLGoDxNBFObV+B6LGERHmB5s8GE4
         gmgYD1X0yCqCcLSCs+acJXlcH8/vl/9vKfp7t8jnPZZ+9XrhyodnM7AcK2kR/dXmfOTp
         4uuw==
X-Gm-Message-State: APt69E01rNlsyBhptv6n70gQ5n6TaSCULLFiliJhnioO0DoBa3rmtCyr
        4aOpACoS7n7gHCMPMeTJGfG945R0TpH8PXh4EHA=
X-Google-Smtp-Source: AAOMgpdH84ZQabQpZaFyql0DBuU4fy8rQP99nVpk+6cBzC/ezepHhlM/29JybDSub9UKbZaRgcKMUHNhtoqlUwzrpiU=
X-Received: by 2002:aca:3546:: with SMTP id c67-v6mr30616063oia.249.1531249058124;
 Tue, 10 Jul 2018 11:57:38 -0700 (PDT)
MIME-Version: 1.0
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf> <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
 <20180709203455.fbmx45ehrsj6yjzr@eaf> <CAE5jQCd0dD2jcNLGXK0N1g6TOfNfruyTV-7R6Eh1v65bkoqi1g@mail.gmail.com>
 <20180710183839.abazeghy7he4v2ai@eaf>
In-Reply-To: <20180710183839.abazeghy7he4v2ai@eaf>
From:   Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Date:   Tue, 10 Jul 2018 21:57:27 +0300
Message-ID: <CAE5jQCeidbWG5A8MTk+zo8UtRLCw84pHfJzumgx1JMineK89MA@mail.gmail.com>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
To:     "Ernesto A. Fernandez" <ernesto.mnd.fernandez@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This should be fixed, but
> it's not as big an issue as the deadlock. Filesystems usually don't need
> to worry about protecting a crafted image from acting weird and causing
> damage to itself.

I just thought that deadlocking a single thread is not much worse than
further damaging already damaged FS and is not very dangerous (since
it's not a NULL dereference or something like this). If it is or only
malicious image can probably be damaged this way then I have no
objections or further requests, so please excuse me for unclear
wordings.

Thanks,
Anatoly
=D0=B2=D1=82, 10 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 21:38, Ernesto A. =
Fern=C3=A1ndez
<ernesto.mnd.fernandez@gmail.com>:
>
> On Tue, Jul 10, 2018 at 08:28:37PM +0300, Anatoly Trosinenko wrote:
> > Thank you,
> >
> > When applied this single patch on v4.18-rc4 and performed "echo >
> > /mnt/xyz" on hfsplus_16mb_hang image, I get about 14 pairs of lines
> >
> > hfsplus: unable to mark blocks free: error -5
> > hfsplus: can't free extent
> >
> > Then `echo` exits with "No space left on device" error.
>
> Truncation does not return error codes in hfsplus, hence this weird "No
> space left" that comes from somewhere else. This should be fixed, but
> it's not as big an issue as the deadlock. Filesystems usually don't need
> to worry about protecting a crafted image from acting weird and causing
> damage to itself.
>
> >Then it
> > permits to perform `rm /mnt/xyz` and on `echo > /mnt/1` it responds
> > with no space left on device (but file *is* created and is cattable).
> > I don't know what is safer, but now it doesn't deadlock. :) Maybe it
> > is even worth to remount FS r/o, I don't know. (Please excuse me for
> > speculations)
>
> It's not strange that the /mnt/1 file could be created but not written
> to, since the first operation doesn't usually require allocating blocks.
>
> >
> > Thanks,
> > Anatoly
>
> OK, I'll take a look at the truncation error codes as soon as I'm done
> with the other deadlocks I found. It could take a while.
>
> Thanks for the testing.
> Ernest
>
> > =D0=BF=D0=BD, 9 =D0=B8=D1=8E=D0=BB. 2018 =D0=B3. =D0=B2 23:35, Ernesto =
A. Fern=C3=A1ndez
> > <ernesto.mnd.fernandez@gmail.com>:
> > >
> > > On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> > > > And when I mount hfsplus_16mb_hang and perform `echo > /mnt/xyz`, i=
t hangs.
> > >
> > > I just sent you a patch for this final report. Let me know if it work=
s
> > > for you.
