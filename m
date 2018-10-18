Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3639C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F91420866
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 14:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="p6/TP1vz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F91420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbeJRWfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 18:35:48 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:36396 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728253AbeJRWfs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 18:35:48 -0400
Received: by mail-it1-f195.google.com with SMTP id c85-v6so604996itd.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 07:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=bQRHlQoLTxwmrkimcY08YV//USDmQx/epjTInfxcZiw=;
        b=p6/TP1vz33iC/nYMOFCnAQtrhl60PXbapHNlDhPTpp0gQEPGeQ2ekw85X3A9D5ZNvY
         JjFJocOpOpQZMQBcwUBoOGZdG+3BA1/LGpEbc0SMS/IjnZt1cfTUsra+XA9IgMDLRUOQ
         IoT2BYAVHPa0FZ+3UB62nbrYZQnadk45WBIyQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=bQRHlQoLTxwmrkimcY08YV//USDmQx/epjTInfxcZiw=;
        b=Ig6sKqHG9xfep2pqzWra48mTgyAMJI6OERsgJPtkC38IsswStyUF2BDBcfVadAM1sO
         75jKjMwKAgMNL07PpQ03MmBLX3bDsWYK4t7+dTdr61SL2QqE3WX6unk5V00ShbqkC1lh
         I7RMfpF8cZyNf0L6DabSMdyTQjMqJEkpK2Q/60hFYgTN2GvVZaR7fQbqcOaLAkjO2r8a
         8ZQ2/MpnB3axJ4oSUUZ3HDvOsbEVQPp1Djp36jv+iT0V2FeoxfoOI8NeeZ3OPEnGaF/t
         VnFiFB51wL+D3PLlayWhXmCUh4FRbujZomf/OyKx7nDPUd5kt2zboYVyAzR1Afgy52I0
         DkVg==
X-Gm-Message-State: ABuFfohHKLEnqzkDTROpAoQDK3g9EI/5S/b6xXqPJNkSXUi0U/tnKxRl
        CDlEAPxNijGdtOy4PbvmQaSfEwAv+5piglR+vQPbVg==
X-Google-Smtp-Source: ACcGV62+GB7CV/prQNAVpbr5k+IuEv/AxvcMQBzxGjfb9UO3BQZ+E4K6YrFMngzFRVjMs2DBMF0KePL7XSiddSbZbGI=
X-Received: by 2002:a02:1818:: with SMTP id k24-v6mr23122273jad.77.1539873270756;
 Thu, 18 Oct 2018 07:34:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Thu, 18 Oct 2018 07:34:30
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <CAJfpeguM-TU=nxj=T4t1DshniiEFBGq6yo+qo7Cx1QDnoNocMw@mail.gmail.com>
References: <20181018131125.6303-1-mszeredi@redhat.com> <20181018131125.6303-2-mszeredi@redhat.com>
 <875zxzxuo9.fsf@mid.deneb.enyo.de> <CAJfpeguM-TU=nxj=T4t1DshniiEFBGq6yo+qo7Cx1QDnoNocMw@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 18 Oct 2018 16:34:30 +0200
Message-ID: <CAJfpegsW27EGyCkoWMgh5V4hoyU-D3MffLq_2zDgybc66zev2g@mail.gmail.com>
Subject: Re: [PATCH 2/3] uapi: get rid of STATX_ALL
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 18, 2018 at 4:32 PM, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Thu, Oct 18, 2018 at 3:15 PM, Florian Weimer <fw@deneb.enyo.de> wrote:
>> * Miklos Szeredi:
>>
>>>  #define STATX__RESERVED              0x80000000U     /* Reserved for future struct statx expansion */
>>
>> What about this?  Isn't it similar to STATX_ALL in the sense that we
>> don't know yet what it will mean?
>
> Kernel will return -EINVAL if request_mask contains STATX__RESERVED,
> so it's definitely different from other flag values.
>
> Specifying this in the UAPI sort of implies that other flag values
> will *not* need a struct statx expansion, so it's safe to pass in any
> random value not containing STATX__RESERVED on any past or future
> kernel and it will not write beyond the current struct statx boundary.
> Not sure if that's a useful thing or not, but it's not actively
> harmful, like the STATX_ALL flag.

In other words, if STATX_ALL was defined as 0x7fffffff, then that
would mean the same thing, and I wouldn't complain about it.

Thanks,
Miklos
