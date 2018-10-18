Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D68DECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:37:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E36342098A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 07:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="iQCvZglx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E36342098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbeJRPh1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 11:37:27 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:44757 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727451AbeJRPh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 11:37:26 -0400
Received: by mail-io1-f67.google.com with SMTP id s6-v6so9804071ioa.11
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 00:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=zIToDANcLzdfTXfdQ2fxssyyuElQmEGyksjO/ROD6qY=;
        b=iQCvZglxBiKQYaGS2PxepADudzXJPbk8gXUGRu9B2xuUcpYCx/P+YD9kdHxENYElv6
         3J7fC6qNTrjP0aymNFMSnDCsGwSxBk3g5xa0G6jO4otzzo/gcfV57iq6WXnucHuyZl+8
         X6Ug4URDVD0oYlBH0N1roSfq7lmv4bYkLPUkw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=zIToDANcLzdfTXfdQ2fxssyyuElQmEGyksjO/ROD6qY=;
        b=ciVKKoq3tBgU8YFavk6JDMHuqu71PkZNLCDgsX1smyxNiuYIKBZafTT27ciTLxlYcP
         Vzt0m42tdXnqK86rtwFSUlhskX/CtV788dP/ImOOakVjFRCvsez3FWxA5C6uUWKS4lo9
         RR+nz474yOB/zVvUX4/uXAI8LdrpVGsA6C1Fo5FcCkLp8v+vo/1yeZIT9b5htvAP3WL9
         8TZ26yuAFk/DfVS64GY1jVY7CYoaKvoqbRcskeJifdWlNSwCYYWiA4m4xi5d8EU8DvV5
         rBuEJ6S3OEgAifyfmNk1gBW6JhKvd+ZMvUM1gKfMODKIQnr4EQ81myS/WpXsAg0u83r9
         t65A==
X-Gm-Message-State: ABuFfogXLKySkfsb+g52M6x1brTF1ZuIffuwEq+qEcfWmTDwdpHQ50ZU
        IN0hB9cvblwNst+Sq+Gg27aQFEiCkFmVpRQE70FOCQ==
X-Google-Smtp-Source: ACcGV60+LjTaTqRI2bPdSAgmloh+dmsciGsEfkmNiLTatDfsawQv672Uvo/8Sr8nJ09+QG/tEaresdP/aebztwkI758=
X-Received: by 2002:a6b:fe09:: with SMTP id x9-v6mr18439315ioh.294.1539848264781;
 Thu, 18 Oct 2018 00:37:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 00:37:44
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <878t2wb4dr.fsf@mid.deneb.enyo.de>
References: <CAJfpegsxFUGeczcC-pzK0WWROjv48_PvXtNun-f5QJMoUDn1Dw@mail.gmail.com>
 <006890C4-64D4-4DE2-A1F0-335FFFD585BB@dilger.ca> <CAJfpeguvJZbP83mSULc74Yhpp_CPMBW1XvcgbvCbLnF7QCncUA@mail.gmail.com>
 <E9903911-9289-4038-9835-9353762A3BAF@dilger.ca> <878t2wb4dr.fsf@mid.deneb.enyo.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 18 Oct 2018 09:37:44 +0200
Message-ID: <CAJfpegscdd7Q7waB4me7RMC_SJv4=rQwEGXBYNGAr2F3WE5=zA@mail.gmail.com>
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

On Thu, Oct 18, 2018 at 12:22 AM, Florian Weimer <fw@deneb.enyo.de> wrote:
> * Andreas Dilger:
>
>>> So what's the point exactly?
>>
>> Ah, I see your point...  STATX_ALL seems to be mostly useful for the kernel
>> to mask off flags that it doesn't currently understand.  It doesn't make
>> much sense for applications to specify STATX_ALL, since they don't have any
>> way to know what each flag means unless they are hard-coded to check each of
>> the STATX_* flags individually.  They should build up a mask of STATX_* flags
>> based on what they care about (e.g. "find" should only request attributes
>> based on the command-line options given).
>
> Could you remove it from the UAPI header?  I didn't want to put it
> into the glibc header, but was overruled.

To summarize Linus' rule of backward incompatibility: you can do it as
long as nobody notices.  So yeah, we could try removing STATX_ALL from
the uapi header, but we'd have to put it back in, once somebody
complains.

Thanks,
Miklos
