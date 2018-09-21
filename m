Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64274C46472
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC42221550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 15:28:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="D5QUgEQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC42221550
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390470AbeIUVRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 17:17:46 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:38676 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390111AbeIUVRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 17:17:45 -0400
Received: by mail-it1-f171.google.com with SMTP id p129-v6so2301990ite.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 08:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D9/GEtgl+LG4gkvsNGTC0CK6q4I40vIhsemOKcBgVtg=;
        b=D5QUgEQTZEhZ3qRi2LoezB9K+5nfO1LwisKMJrHIINdUv6vzEG2wV9QzeheW4zlHYt
         FgwsDQm5/ZsEi576EyDIWgmHNEXJXGRVeDb/neUv77hU7rPdUWxphj4k5HEpMbixl1bP
         32qVdj8W2PhVs3zIQSAoE/GLo8PSa0T9N3vEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D9/GEtgl+LG4gkvsNGTC0CK6q4I40vIhsemOKcBgVtg=;
        b=C4eZQV0CHeAsBiGLrWdsIaB2HKMor9y4KTyyKuFbtFA1nZX6cXO3D1x1X+jOvQs0hr
         yYPXdcMrxmVWtOjmf6+LIVymNubg22n5TGuoBXeiQ4lD/hQQ78JDnR71f9ZoQd5x4enm
         qosv+2uC/a46nc5s7sX/c5C6MTpgm/05hWeZk5Q6N7iJkiKSfVNi87O36WOt/xpQKayx
         tMp0ohIE8Cv1BzyEXFpmT9CO6Jyg+0lBEmqIfzNJp63zYgHw9IN0Ey1o2zwo394n7dbw
         uPXMWzE0T+puQsaw/JoqCySKqLnFbOc67hjo+AuOpVVCBXc/hqPx4za0MW0rgC53k31z
         IMAw==
X-Gm-Message-State: APzg51DMJ+9PTvYBCdFApl3lBM6T76ADLiHkOu9TOWi1mHTB8/m7Tgx6
        0xX3rbhgcrtUQAlURC4MwXvvew5FcA7W+/zCS8ig3g==
X-Google-Smtp-Source: ANB0Vdbmbb6PpjOhhyFHq0PeGb2wtcnZE/QZvZvfJyiAM0BffBd3Ae7KYq+cFQcn5xvPOV3ZurCBNWr22K0cHBJawUc=
X-Received: by 2002:a24:e084:: with SMTP id c126-v6mr6350185ith.136.1537543701910;
 Fri, 21 Sep 2018 08:28:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bf41:0:0:0:0:0 with HTTP; Fri, 21 Sep 2018 08:28:21
 -0700 (PDT)
X-Originating-IP: [212.96.48.140]
In-Reply-To: <17157.1537542475@warthog.procyon.org.uk>
References: <20180920151214.15484-1-mszeredi@redhat.com> <20180920151214.15484-6-mszeredi@redhat.com>
 <17157.1537542475@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 21 Sep 2018 17:28:21 +0200
Message-ID: <CAJfpegtw9pYrWv3zcWMJ6SMADcQ-JsSsE4UW3sEb1QM89U+WJg@mail.gmail.com>
Subject: Re: [PATCH 5/6] fsmount: do not use legacy MS_ flags
To:     David Howells <dhowells@redhat.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 5:07 PM, David Howells <dhowells@redhat.com> wrote:
> Miklos Szeredi <mszeredi@redhat.com> wrote:
>
>> What happens if we introduce new flags for fsmount(2) and are already out
>> of flags for mount(2)?  I see a big mess that way.
>>
>> So let's instead start a clean new set, to be used in the new API.
>
> If we must.  But let's not call them just M_* please.  Let's call them
> MOUNT_ATTR_* or something.

Oh well.

>> The MS_RELATIME flag was accepted but ignored.  Simply leave this out of
>> the new set, since "relatime" is the default.
>
> Can we make RELATIME, STRICTATIME and NOATIME an enum rather than individual
> flags?

Sure.

>
>         #define MOUNT_ATTR_RDONLY       0x01
>         #define MOUNT_ATTR_NOSUID       0x02
>         #define MOUNT_ATTR_NODEV        0x04
>         #define MOUNT_ATTR_NOEXEC       0x08
>         #define MOUNT_ATTR_RELATIME     0x00
>         #define MOUNT_ATTR_NOATIME      0x10
>         #define MOUNT_ATTR_STRICTATIME  0x20
>         #define MOUNT_ATTR_ATIME_MASK   0x30
>         #define MOUNT_ATTR_NODIRATIME   0x40
>
> We can also use these for a mount_setattr() syscall:
>
>         mount_setattr(int dfd, const char *path, unsigned int atflags,
>                       unsigned int attr_values,
>                       unsigned int attr_mask);
>
> where atflags can potentially include AT_RECURSIVE.

Indeed.  Also, shouldn't these include the propagation flags?

Thanks,
Miklos
