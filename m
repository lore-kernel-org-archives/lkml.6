Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36EB3C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEF7D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="gjk+w3oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEF7D2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbeJRPmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:42:02 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54883 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbeJRPmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:42:01 -0400
Received: by mail-it1-f196.google.com with SMTP id l191-v6so5480011ita.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 00:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=22M500sfgMIP1n4i/C/OLVOxgSVvN2ro60oCQqNUGFk=;
        b=gjk+w3oLY/4lEqBtgIdfQDGAaWsyt/AIALChKxzx+JS74iIYbBXFA3jQ0ZzSfV4eEC
         1FW8AqwzfdLfNNl3p0728kd5WUQAvroX9FdYvYPVG96erNOiXDUaO8ATd6Se+bY9pwXz
         ljbetlAE6FbLNsqaF9Ew6/WJS9aPSDaC5Ztwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=22M500sfgMIP1n4i/C/OLVOxgSVvN2ro60oCQqNUGFk=;
        b=gAI+q3J2Eo1OV4wCEz18Jkr+4i+zap7f6l+/wNaXYxMa8K+t64eIHbb+5IGiSfBQmQ
         dMshUygywjoIRL5NIAOvHEOISMi3YSt0OpbC5DClIEShUVMVT2FTaWDyQUkZeF0qI5jN
         FEckxPPmNT0f4exjcueQNW/E3JHNnUsldnl29kVIef2tyVb0s3A8fNxNsBZzGkoxVCCY
         O6pTpEB2PJV2CS2wUNHdIXyVgZwJk014CFu271XU6k7dsmnt6xcPafo1AeS/dvs7A3Yi
         JI4hw1+JXCTvDh5hml8XpHPaPLUD3ECOeIlQ/8vLbEFVQYcZsGMknt8MC/BAOmbIxGXl
         je1g==
X-Gm-Message-State: ABuFfojBs0QOs+ldkacRSKdbhpkaINX3LjpAen/a4VLrL19nVsXSEbjO
        ZTszQ6wNzSJuaYd9372JYn0rTO1K1jbAW/k7J+I36w==
X-Google-Smtp-Source: ACcGV628XecVjusBQKeb4/RFuvKFDek5zW+Y7UTEGbRJQpS39nxBs4TZELpZg6QsB5kE2jC24+EofqCvNiGkLiQ3LyU=
X-Received: by 2002:a24:75d6:: with SMTP id y205-v6mr4143781itc.1.1539848537620;
 Thu, 18 Oct 2018 00:42:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 00:42:17
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <87sh13ya8m.fsf@mid.deneb.enyo.de>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
 <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca> <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
 <E9903911-9289-4038-9835-9353762A3BAF@dilger.ca> <878t2wb4dr.fsf@mid.deneb.enyo.de>
 <CAJfpegscdd7Q7waB4me7RMC_SJv4=rQwEGXBYNGAr2F3WE5=zA@mail.gmail.com> <87sh13ya8m.fsf@mid.deneb.enyo.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 18 Oct 2018 09:42:17 +0200
Message-ID: <CAJfpegseDedv47mSWE=Noue+Y2e6xBDPe2WVb+tU=Y-Cq-zcyw@mail.gmail.com>
Subject: Re: statx(2) API and documentation
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 9:39 AM, Florian Weimer <fw@deneb.enyo.de> wrote:
> * Miklos Szeredi:
>
>> On Thu, Oct 18, 2018 at 12:22 AM, Florian Weimer <fw@deneb.enyo.de> wrote:
>>> * Andreas Dilger:
>>>
>>>>> So what's the point exactly?
>>>>
>>>> Ah, I see your point...  STATX_ALL seems to be mostly useful for the kernel
>>>> to mask off flags that it doesn't currently understand.  It doesn't make
>>>> much sense for applications to specify STATX_ALL, since they don't have any
>>>> way to know what each flag means unless they are hard-coded to check each of
>>>> the STATX_* flags individually.  They should build up a mask of STATX_* flags
>>>> based on what they care about (e.g. "find" should only request attributes
>>>> based on the command-line options given).
>>>
>>> Could you remove it from the UAPI header?  I didn't want to put it
>>> into the glibc header, but was overruled.
>>
>> To summarize Linus' rule of backward incompatibility: you can do it as
>> long as nobody notices.  So yeah, we could try removing STATX_ALL from
>> the uapi header, but we'd have to put it back in, once somebody
>> complains.
>
> I don't recall a rule about backwards-incompatible API changes.  This
> wouldn't impact ABI at all.

Right, API rules maybe are softer.   I'll do some patches...

Thanks,
Miklos
