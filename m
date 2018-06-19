Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A242C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 931E1204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 13:38:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OI19vRsI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 931E1204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937652AbeFSNiJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 09:38:09 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:45948 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937544AbeFSNiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 09:38:07 -0400
Received: by mail-oi0-f67.google.com with SMTP id 188-v6so18117083oid.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 06:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7B944rtyd0KCi0Tn8YiVjEv8VuiCvdS6xVS1TjV0X6A=;
        b=OI19vRsIhAjQLbrC4tba7jfO2hYHEg74RPsrmCj5pzP8umem0poh+kTsi1YzjHIVjV
         6n6UZajkaGosPSr8vjigJsquwY6wLB6GHWblGKE8Jyk5cWUoLo/k5Q9y4Phm3GbAVBvX
         nS4hEQNzXnQ0+vuemd2goe41U4AOEb5Vgsv08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7B944rtyd0KCi0Tn8YiVjEv8VuiCvdS6xVS1TjV0X6A=;
        b=suSfZlQ0nxhJxVEdLNhsmVqNDV0L34HbfwZcuw/wX0mzEdfEe+phI71YLg5egxGHhy
         ti9HWluez0arZw9ziC2lT3sV5xasp8dCpSQUovBTkCCYEZxJm9w5JsOrHQqFQmaZpNPp
         N9xxYPL9gETBPg+jwtsirTgIQLEGhLzAywGMPs8q8BPHngQnrw8OUJFemVlQ2vJuUl0n
         YDdkZaKyJnyfY5Av2OuC+sY3BtcN092LsTdPKiAzbPmuZo3f5uBrPlBxVjIG4P2jLkTB
         k6m8We21cm6/kG40Fneyummfs5OHd0bgXg0EYWIc5SHnTShch6ySBSI1c92VYSsR9dPp
         wLvQ==
X-Gm-Message-State: APt69E16lzFQGvNaolvGyvQWsz0Kxh53pRHVrllYBZT4GdjWIpU8BQoc
        sChVwCWmw3TnaERU82WAR+IH3TeD3a7E/Nzj/m2fSQ==
X-Google-Smtp-Source: ADUXVKL0p+4r/PL6NKlnyv1Pp1AmrxosaEc+3JezugVZ47mNnS0Cn814Wq/ouedV0TvazOW9AkfSInVIqDC7dH0LoQg=
X-Received: by 2002:aca:df54:: with SMTP id w81-v6mr9814210oig.104.1529415486599;
 Tue, 19 Jun 2018 06:38:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 06:38:05
 -0700 (PDT)
X-Originating-IP: [176.63.54.97]
In-Reply-To: <22145.1529397638@warthog.procyon.org.uk>
References: <20180619112140.58be35dd@canb.auug.org.au> <22145.1529397638@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 19 Jun 2018 15:38:05 +0200
Message-ID: <CAJfpegvjM3Eh4ZPdepB240UyAVwca8qw+v4sGyEHRO1YBYyNSg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the vfs tree with the overlayfs tree
To:     David Howells <dhowells@redhat.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 10:40 AM, David Howells <dhowells@redhat.com> wrote:
> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>>  /* These sb flags are internal to the kernel */
>>  #define MS_SUBMOUNT     (1<<26)
>> -#define MS_NOREMOTELOCK      (1<<27)
>>  #define MS_NOSEC     (1<<28)
>>  #define MS_BORN              (1<<29)
>>  #define MS_ACTIVE    (1<<30)
>
> Ummm...  Can MS_NOREMOTELOCK be removed?  I know it's listed in the internal
> flags section, but all of these have been exposed to userspace for over a
> year.  Ideally, I'd remove all of these from UAPI, but can anyone guarantee
> that no pieces of userspace refer to them?

The number of potential users of these flags is pretty low, so I think
we can try and remove them and hope nothing breaks.

Probably best left after the dust settles.

Thanks,
Miklos
