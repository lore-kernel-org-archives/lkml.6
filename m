Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABD50C43144
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D90527A59
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 23:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NnAbqEyU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D90527A59
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936256AbeF1XZN (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 19:25:13 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:44247 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933904AbeF1XZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 19:25:11 -0400
Received: by mail-pl0-f54.google.com with SMTP id m16-v6so3490407pls.11;
        Thu, 28 Jun 2018 16:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4DRMZy1k4x3LuKPaDgoecfOVhIU6MJmOAEbkNxAzmSg=;
        b=NnAbqEyUI0wrW2X73ZVaLhkyqyCIbZWYgBoPe1t4DzelT8rufe2TxHgFrV3gfOkozz
         qdqp58iY2j+0HEUr5IoBlwAf7rM4DHgY0/WRgEMsM9oLvM6IFKOn7hMsaUyhafiaCXO+
         CHF5c6clG+fHkBmjflnkBWXSD06zhWuV5gfVEfuZR8f7wPPYU9Vifj0GmU2qzmX9kwEh
         vWF7l8X1syqjn1R9pj3C57WyoklkI3p5r9q5pBfPglCyvh0DtOHeDeC5SuPvq0Vk0VxR
         JMQPOrSB6LHlLxyLCVq+GDDzxtF0B9FrV1nE9Zd3K/IK6g4ajauUL7JzLjEdj7Jci6nt
         DBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4DRMZy1k4x3LuKPaDgoecfOVhIU6MJmOAEbkNxAzmSg=;
        b=E0BxpcxM09i2mM6Zyq8Evf7cmUiPBHIWcYVW5Rx4d8aVnQBohVmtXFnLSmW3LSfAXK
         pguBOM3Af6WzczXA/ffgXJa1WHCmow7CJExXPDon1HSJ8YPe7UPxbjH1uee9xOp4VMPJ
         f324fMYXD/IPNI2IoQbXres7pXpx7Hh2FUJiZowS5lMrZelG49TuJAlof4KUamvCQyPP
         sDbum5Zqc4bUZD5dTlTm3Z8QirGOPDEey41Z3sctJ72oPTo1GuHrxe4dwdvoa2wSAOS3
         jPI6hlzLtObZklkb1yqQ5jdVC9Nd5F2Cwvo43jQThFazRXk3kDlFmo6aBipx7RmZzYXY
         GPBg==
X-Gm-Message-State: APt69E0cZq6DVjQzrHstrssEjISpuTnVnV4uyWDBH+PE9JpMBPEG+Q0e
        XHHz26BKJriTAB8sJqanev0kMbF6gF1aAzm6mgg=
X-Google-Smtp-Source: ADUXVKKGYgC0L+2SjJt3ffFnb+hgj8zhMRB96ijaTNQGkMjYFV8ys1/omOsGnc03xROiFFx2hdaVRNcEczqhuOtPM6A=
X-Received: by 2002:a17:902:14b:: with SMTP id 69-v6mr12436194plb.184.1530228311018;
 Thu, 28 Jun 2018 16:25:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msV1hBAGgqtMFh6P=OGPV3RKjVAER=5bg-6Y+vW5BEJwQ@mail.gmail.com>
 <20180628225857.GB1231@thunk.org> <CAN05THStuq+RLzb_oNiD2TvN6MjMMnTdCxNiHuYWHRueQ46=_A@mail.gmail.com>
In-Reply-To: <CAN05THStuq+RLzb_oNiD2TvN6MjMMnTdCxNiHuYWHRueQ46=_A@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 28 Jun 2018 18:24:59 -0500
Message-ID: <CAH2r5mui9WLBC6ne+iqVeYDGKEMKTabHPTf57STM9_aPGfM0sA@mail.gmail.com>
Subject: Re: config files and how to have persistent Linux kernel Driver/File
 System configuration info saved
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Theodore Tso <tytso@mit.edu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 28, 2018 at 6:21 PM ronnie sahlberg
<ronniesahlberg@gmail.com> wrote:
>
> On Fri, Jun 29, 2018 at 8:58 AM, Theodore Y. Ts'o via samba-technical
> <samba-technical@lists.samba.org> wrote:
> > On Thu, Jun 28, 2018 at 05:37:15PM -0500, Steve French wrote:
> >> Ronnie brought up an interesting point about the problems consistently
> >> configuring file systems (or any Linux module for that matter) so that
> >> reboot doesn't wipe away security or performance tuning changes.
> >
> > In general it's considered best practice to make the file system
> > auto-tune itself as much as possible, because the sad fact is that
> > 99.9999% of the customers aren't going to bother to add any tuning
> > parameters.  So there hasn't been a push to try to create something
> > more complex, because it's generally not needed.
>
> True, but in these cases I think we are more looking at server or
> mountpoint specific options than
> actual fs tuning.
>
> For example nfsmount.conf can be used to say "only use NFSv4 when
> accessing server abc" etc.
> For the case of CIFS I could imagine that an administrator might want
> to set "disable smb1 protocol globally"

Or perhaps
  "disable smb1 on " ... various public networks but allow it on
private networks

-- 
Thanks,

Steve
