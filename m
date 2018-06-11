Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id LPzkHcYtHlssWQAAmS7hNA
	; Mon, 11 Jun 2018 08:08:37 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 125D5607E4; Mon, 11 Jun 2018 08:08:37 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="SE/3zlEa"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9D5CB605A5;
	Mon, 11 Jun 2018 08:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9D5CB605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932365AbeFKIIe (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:08:34 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:43533 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbeFKIIb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:08:31 -0400
Received: by mail-ot0-f196.google.com with SMTP id i19-v6so22736280otk.10
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=FpTTIKkOane+I4capCYDktNntDMiKJ+XoY5kZucG7L0=;
        b=SE/3zlEaoLos5ao2n0h0Xhne34moNI4AvZRLSvi8VTMbEK9XHlPjp/IZBJNoqjIgEA
         ZkoCW92ol5fo6WOMng8X0xikfTSxpOMHu1ckpMsZL+wmlSsnp2i6YrWu4TW/7xaQI9OX
         PeR6gH0WmWI0dD44j5rE1udttiuWDx8cYJdCc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=FpTTIKkOane+I4capCYDktNntDMiKJ+XoY5kZucG7L0=;
        b=JltoarhBr7oWUA4aMBXIVHRVxnNj75Wku1t6q3JRsu14SObS1374BBf7V2UlWa0uo2
         KaM5v7YKaTUI+uPpyIWi+dAXnHvhP4b/Yjs3ssRVOaBFNNhprh0oSdGABC9zFDOK6xj3
         48gM/ZarVz54JjEzXVa5tqO5i/EIVG8zcch4dyc8PnO/R9qoSBlyi7O3QcWuxe0ng8iq
         YpouqRUa6LUdwD7AmH3FBoZPhmOfb/a+z5Y49FadEMVkJ4zN4JwztnqAzBfhwvLtu3mb
         ulpELDizLKH/7ZUrM8Jl1Xfn3v69NhILE4aSwRWnHRv2ytX1ctVCZbpyNUFce/Wfxypj
         NxMQ==
X-Gm-Message-State: APt69E0Z7OXkns22zF4dYISQliOkbKshXhWOfMDXp624va5YFkxL19Ty
        gflHr+FOHcfBCChlf3BoVyJaPH0KCrTSU14ty0xLBg==
X-Google-Smtp-Source: ADUXVKLUmMumNDgQpp4bfjKl2JNRXRkzLdX7EvqhAf0JK7r1YuQYWVeZzapB/B4lGKTQNBgCrPshxJfnjWukD8Tw8vg=
X-Received: by 2002:a9d:19e8:: with SMTP id k95-v6mr8719786otk.368.1528704511062;
 Mon, 11 Jun 2018 01:08:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:08:30
 -0700 (PDT)
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180610053128.GO30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-24-mszeredi@redhat.com>
 <20180610053128.GO30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Jun 2018 10:08:30 +0200
Message-ID: <CAJfpegteZatDXOV+6FQKOE9pOA=_FErGRn1Jj1fHUYm_QLb4ew@mail.gmail.com>
Subject: Re: [PATCH 23/39] ovl: add O_DIRECT support
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 7:31 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, May 29, 2018 at 04:43:23PM +0200, Miklos Szeredi wrote:
>> Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
>> ---
>>  fs/overlayfs/file.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
>> index 3f610a5b38e4..e5e7ccaaf9ec 100644
>> --- a/fs/overlayfs/file.c
>> +++ b/fs/overlayfs/file.c
>> @@ -110,6 +110,9 @@ static int ovl_open(struct inode *inode, struct file *file)
>>       if (IS_ERR(realfile))
>>               return PTR_ERR(realfile);
>>
>> +     /* For O_DIRECT dentry_open() checks f_mapping->a_ops->direct_IO */
>> +     file->f_mapping = realfile->f_mapping;
>
> Umm...  What happens if upper layer doesn't allow O_DIRECT, while the lower one does?

Will get EINVAL on read(2) after copy up.  Not sure if it can be
called a regression, since it's a corner case of a corner case.

I think proper solution is to support O_DIRECT unconditionally on
upper (and for the likes of shmfs, just fall back to "cached" I/O).

Thanks,
Miklos
