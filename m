Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8AF5C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 749AF2083F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 22:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NJRD57VA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 749AF2083F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeIADBJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 23:01:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:37170 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbeIADBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 23:01:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id 2-v6so5532072pgo.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z4cH2NFZ0B1D8li6nAQAz5ys7tB0i6uhlaj+iw6wspw=;
        b=NJRD57VASFxh/tTsU6qM6u7o4FEDQxnv00S0vIoylcti1B/RkW/MACRQb6r8wWpWNI
         WtAoOB4MCn6MH2lk9QxS56qaDw4kz9aJqs3hcga3YGCE9yZQdzTvcqbSbM2ijhs8GGd9
         /VDaueMBEzz+12M44u2B2EK95+ATio37Nl6/iK1VbLcmmWmgH+rQISInDx4apWMESP0j
         KJU/7FMBobHBSlcUnj+6N0bx0FG4mPra3oABJKU0QPG59wyU45KpSJoEZtsuKgQ4ckcK
         FoejjxvBLU2hSPCmpWeecVcGtIDsVujuQaLimYltV/dB+do6kZ4a2LZVAqB1XIdJXHEz
         PG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z4cH2NFZ0B1D8li6nAQAz5ys7tB0i6uhlaj+iw6wspw=;
        b=FdLTvTVzsIEI8sOdBt4ZQytFHqzvcH0hAjBtNx07sPO3jpxyKAXwuUw6nfGG+EXREn
         SIPWc1STXaohqckX/yJOJK8m2Aim/iG2F9Uqr7hSSaHgzpECFZEm1OWvmJWVbXYBFnIp
         7K0Da7iZVutaAwtv4MqISNatC3bOGMlzNI4bfunmMOUd4nNkoxzEy1PbFimrhCGkvRr5
         dImQK25LVy8Q7XVSFtUWhBheXBdTN19PyBpS7xtkbQt1nvVlGysh907P/o1hsloTpr/Z
         wyQCktOqiGABJz7hy3zxA+szoaYxWz3Bm4PgBHBIdi/Su7HybyM3pWoGnDUnJoSi9SLu
         aYSA==
X-Gm-Message-State: APzg51CPCIX6enrTvu43I46LVV+Limb5jFCzNh4rgGr/p+wJZ3Zk0aGM
        GcuR3DeNpEJ+h9OUy65Ir/UMCnc6
X-Google-Smtp-Source: ANB0VdYYopezgU0c0QIJ5WqeAa+ezssBPuf4EQlraHnasG16qJkMACbZVnPwsJx4HLwbg60Y7GnElw==
X-Received: by 2002:a63:1d47:: with SMTP id d7-v6mr16405222pgm.180.1535755890772;
        Fri, 31 Aug 2018 15:51:30 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (59-102-81-67.tpgi.com.au. [59.102.81.67])
        by smtp.gmail.com with ESMTPSA id s3-v6sm25201642pgj.84.2018.08.31.15.51.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 31 Aug 2018 15:51:29 -0700 (PDT)
Date:   Sat, 1 Sep 2018 08:51:22 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Matteo Croce <mcroce@redhat.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Subject: Re: VirtIO console hangs
Message-ID: <20180901085122.57bc3df4@roar.ozlabs.ibm.com>
In-Reply-To: <CAGnkfhy9okKAfZVkbO3YWPVmWgVm2LFzR-8=S73OfJ3bK_1FxQ@mail.gmail.com>
References: <CAGnkfhzjeYU_jmhNkLEayL1FSq5rWkT7T+Nm1ky9QS-vWHUhyw@mail.gmail.com>
        <20180829003539.668e514c@roar.ozlabs.ibm.com>
        <CAGnkfhxhV_4JNhCm2s=XP15sp3bKax9O1R+nFwA+oRJXQ53xsg@mail.gmail.com>
        <20180831134943.7f516fed@roar.ozlabs.ibm.com>
        <CAGnkfhy9okKAfZVkbO3YWPVmWgVm2LFzR-8=S73OfJ3bK_1FxQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Aug 2018 15:17:44 +0000
Matteo Croce <mcroce@redhat.com> wrote:

> On Fri, Aug 31, 2018 at 3:49 AM Nicholas Piggin <npiggin@gmail.com> wrote:
> >
> > On Tue, 28 Aug 2018 15:00:14 +0000
> > Matteo Croce <mcroce@redhat.com> wrote:
> >  
> > > On Tue, Aug 28, 2018 at 2:35 PM Nicholas Piggin <npiggin@gmail.com> wrote:  
> > > >
> > > > On Tue, 28 Aug 2018 12:54:08 +0000
> > > > Matteo Croce <mcroce@redhat.com> wrote:
> > > >  
> > > > > With kernel 4.19.0-rc1 virtio_console hangs very often.
> > > > > I can always trigger the bug by pasting some characters in the
> > > > > terminal window, the console will stop receiving keypresses, but I can
> > > > > still see output from the console.
> > > > > Stangely, logging in the VM via SSH and sending lot of data to hvc0,
> > > > > like 'dmesg >/dev/hvc0' will fix the issue until the next paste.
> > > > >
> > > > > I did a git bisect and I've found that this is the offending commit,
> > > > > reverting it fixes it.
> > > > >
> > > > > Cheers,
> > > > >
> > > > > commit ec97eaad1383ab2500fcf9a07ade6044fbcc67f5
> > > > > Author: Nicholas Piggin <npiggin@gmail.com>
> > > > > Date:   Tue May 1 00:55:54 2018 +1000
> > > > >
> > > > >     tty: hvc: hvc_poll() break hv read loop  
> > > >
> > > > Thanks for the report. I can't immediately see what the problem
> > > > is. Can you try get a stack trace of where it is stuck?
> > > >  
> > >
> > > I tried but didn't get one.
> > >  
> > > > Perhaps try this patch if you have time (it's a bit of a shot
> > > > in the dark).
> > > >  
> > >
> > > Yes it seems to fix. Thanks!  
> >
> > Okay sorry for the delay, I can reproduce it here and found a better
> > fix, if I could trouble you to test again.
> >
> > [PATCH] tty: hvc: hvc_poll() fix read loop hang
> >  
> 
> Hi Nicholas,
> 
> the patch works, but now pasting text inside the terminal is extremely
> slow, it feels worse than a 9600 baud serial line.
> 
> Btw, I had to apply the patch by hand as it was corrupted, some lines
> were collapsed into one.

Okay I didn't test a very big paste, I'll work on it.

Thanks,
Nick
