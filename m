Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B805C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:38:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE6C208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 18:38:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvT5LUy9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DE6C208E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390191AbeGJSjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 14:39:02 -0400
Received: from mail-qt0-f173.google.com ([209.85.216.173]:43261 "EHLO
        mail-qt0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389765AbeGJSjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 14:39:01 -0400
Received: by mail-qt0-f173.google.com with SMTP id f18-v6so19219847qtp.10;
        Tue, 10 Jul 2018 11:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=ciozfUUkUw51HSO84bCd10JwCGYhqMKeeElqN44Mg8A=;
        b=gvT5LUy9/41c7ImMsse20iFWBg8jSgZybTngD+uo1/Sy7SPjzFKgAlrPV20s+5UA9z
         6zswjLXsQnIRDSJCgDKwx5bn+Ge6aseCt6uE8tWG3klEZsRSUZuR0nhR7P0L9Y6j9uWK
         imeTZdtcU6y2lfVOvUX51WCXCrfqHPMF7/u3PwP3sLwvbUFOCCAdPZtbM/DO1Qqh+yo7
         SMoGZYuzP7xa9SFZ4Cg5QTaV0kK96Sf9X8Z1jnvF5nyuollVLMU5Fxfj0ApQY2LYQ6nL
         5YFAyctWPVVSzK74vQaPwkNl4c9FU1+2x7gDTLtSw1NT88apNvhsaBlZ3gNNSoTUMVep
         TwFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=ciozfUUkUw51HSO84bCd10JwCGYhqMKeeElqN44Mg8A=;
        b=VxZeWbV4QKeJTqciWo4eo//Nv8oi9kdlc6gJCDiMJtHNitIblyxEzXVqWKaBp8H/uz
         L0o0vcsbkQ7zDGvYBse/B6j4Mr6bu61NJdSIFQ2+/BYaVd8XC6lbO4O8fgjVtiY1lU+7
         LEk/2wZTS6ZNljKdQcffjj0FP0ydo2KJTuGk+r7EVOP2aPuhV8IY/DU75jf/1aKAhHby
         5VpIi4I43fGQtocNa/2Fd207gJ27nMxjN3PY3gAl3PlRmjcF2qbwTXdjxiJqqf748qRr
         nA0YJ8ng23JfqBt1vFED+bD8seklDyt8RxcpMJfR9HI3a1EdrA+Vg+6E96D9FgTSv/JB
         7rLw==
X-Gm-Message-State: APt69E1ruKKnbOQKuBwK4DJ/oJ/smHSbEJ2VxekonQD8UTjQoYq1bOE+
        BaxJeBEDp2T2WNH1Gytnajk=
X-Google-Smtp-Source: AAOMgpc3ler2Dk3sM8L6cvgLijPA5wuKIS6CzvdTVARqCwARxGcdPmJJkCnI61KV02y5FZ+UooxCdQ==
X-Received: by 2002:a0c:f386:: with SMTP id i6-v6mr23009010qvk.100.1531247926065;
        Tue, 10 Jul 2018 11:38:46 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id h22-v6sm11091827qkj.84.2018.07.10.11.38.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jul 2018 11:38:45 -0700 (PDT)
Date:   Tue, 10 Jul 2018 15:38:41 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
Message-ID: <20180710183839.abazeghy7he4v2ai@eaf>
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf>
 <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
 <20180709203455.fbmx45ehrsj6yjzr@eaf>
 <CAE5jQCd0dD2jcNLGXK0N1g6TOfNfruyTV-7R6Eh1v65bkoqi1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAE5jQCd0dD2jcNLGXK0N1g6TOfNfruyTV-7R6Eh1v65bkoqi1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2018 at 08:28:37PM +0300, Anatoly Trosinenko wrote:
> Thank you,
> 
> When applied this single patch on v4.18-rc4 and performed "echo >
> /mnt/xyz" on hfsplus_16mb_hang image, I get about 14 pairs of lines
> 
> hfsplus: unable to mark blocks free: error -5
> hfsplus: can't free extent
> 
> Then `echo` exits with "No space left on device" error.

Truncation does not return error codes in hfsplus, hence this weird "No
space left" that comes from somewhere else. This should be fixed, but
it's not as big an issue as the deadlock. Filesystems usually don't need
to worry about protecting a crafted image from acting weird and causing
damage to itself.

>Then it
> permits to perform `rm /mnt/xyz` and on `echo > /mnt/1` it responds
> with no space left on device (but file *is* created and is cattable).
> I don't know what is safer, but now it doesn't deadlock. :) Maybe it
> is even worth to remount FS r/o, I don't know. (Please excuse me for
> speculations)

It's not strange that the /mnt/1 file could be created but not written
to, since the first operation doesn't usually require allocating blocks.

> 
> Thanks,
> Anatoly

OK, I'll take a look at the truncation error codes as soon as I'm done
with the other deadlocks I found. It could take a while.

Thanks for the testing.
Ernest

> пн, 9 июл. 2018 г. в 23:35, Ernesto A. Fernández
> <ernesto.mnd.fernandez@gmail.com>:
> >
> > On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> > > And when I mount hfsplus_16mb_hang and perform `echo > /mnt/xyz`, it hangs.
> >
> > I just sent you a patch for this final report. Let me know if it works
> > for you.
