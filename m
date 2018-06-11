Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GrPVI8MuHlsqXAAAmS7hNA
	; Mon, 11 Jun 2018 08:11:47 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6ABAA607A4; Mon, 11 Jun 2018 08:11:47 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="B7WSfjEQ"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id DA61D606FA;
	Mon, 11 Jun 2018 08:11:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DA61D606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=szeredi.hu
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754133AbeFKILp (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 04:11:45 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:33128 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754053AbeFKILn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 04:11:43 -0400
Received: by mail-ot0-f196.google.com with SMTP id h6-v6so22764339otj.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jun 2018 01:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4U5fA8bZ2v7pR/pTYqty+yTdhBVClsTEYlT8g5psnbQ=;
        b=B7WSfjEQ2KGcf/v0X6eorSNZyNEnCLMnJPGEfIXQxIEBc7JOCyi7e0uUcqN6r5QJ8s
         9fO0HThMnCDe3e2AoEWJIvb+16X38Ahv79x3KCjPOlEO14ePvuX088iyhqvsgRFwaiBo
         gs7OhciD5q/Lih6ahq/xLOGD1TW6CAc0yXPdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4U5fA8bZ2v7pR/pTYqty+yTdhBVClsTEYlT8g5psnbQ=;
        b=nwhnfFyeikbWTNWDQCLNaIZs7L0KCJrXUm1nja5TAkkcjXvZ/t/i48hvP8WFjGpa5z
         /0g84EO3tyJpwwrEpdi2AInLW54N2mNZM32F5rPf+DoXwGfF2CX0cXM3CDokEsOEmh2N
         TAdAbibRS2/FuN5yn0bVvDZ5Hot4CKWaTb3JkS8n/sJrpJXbioWGasfN8y8kvPknrnrz
         yTIWaa/seROZ2nmbAlByYoiIvz4lTXdDWYEl02hEYCCkBGM8s22FIWmHuk+KzPKV4EZF
         2CQDAW7UTbQsfeZitRbXRnS9WnnKKYY44MVEdKehqJVBL07BeTs7YqmWLpH8tXG56L1u
         VQHg==
X-Gm-Message-State: APt69E1Js9SuWtBWWifS/8YYQCL6PzIEKIAvDqvaKP6f8m1nxE89XFHV
        eqvJV+fIGWvCdMDvz0QjOKCS5jcUjRnvCQLeuBOT3A==
X-Google-Smtp-Source: ADUXVKIVofD5P6mDMLZDXyoHmTfCS9+4HzadI4WK4+a6967AwIFALPXjj4h5d70l8ghJXjpr6kfzHkapEKMjgReEf5M=
X-Received: by 2002:a9d:1bd6:: with SMTP id v22-v6mr9850946otv.85.1528704702739;
 Mon, 11 Jun 2018 01:11:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1123:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 01:11:42
 -0700 (PDT)
X-Originating-IP: [194.176.227.33]
In-Reply-To: <20180610054156.GP30522@ZenIV.linux.org.uk>
References: <20180529144339.16538-1-mszeredi@redhat.com> <20180529144339.16538-16-mszeredi@redhat.com>
 <20180610054156.GP30522@ZenIV.linux.org.uk>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 11 Jun 2018 10:11:42 +0200
Message-ID: <CAJfpegvoF=kMH1qx3nbegDAEcnSYQgGDiDOKxTiwq7rsR4hbog@mail.gmail.com>
Subject: Re: [PATCH 15/39] ovl: add helper to return real file
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 10, 2018 at 7:42 AM, Al Viro <viro@zeniv.linux.org.uk> wrote:
> On Tue, May 29, 2018 at 04:43:15PM +0200, Miklos Szeredi wrote:
>> In the common case we can just use the real file cached in
>> file->private_data.  There are two exceptions:
>>
>> 1) File has been copied up since open: in this unlikely corner case just
>> use a throwaway real file for the operation.  If ever this becomes a
>> perfomance problem (very unlikely, since overlayfs has been doing most fine
>> without correctly handling this case at all), then we can deal with that by
>> updating the cached real file.
>
> See the ovl_mmap() problem.  FWIW, I would probably suggest something along
> the lines of
>         ->private_data either points to struct file, or is 1 | address of
> 2-element array of struct file *
>         odd value => mask bit 0 away, cast to struct file ** and dereference
>         even value and it's still in the right layer => use that
>         even value and it is in the wrong layer =>
>                 allocate a two-pointer array
>                 open in the right layer
>                 stick that into array[0] and original - into array[1]
>                 cmpxchg array | 1 into ->private_data
>                 if that succeeds
>                         return array[0]
>                 else
>                         fput array[0], free array, then use the value returned
>                         by cmpxchg - mask bit 0 away, cast and dereference

Iff we really need that complexity, then yes, that's a nice solution.
But I think we don't:  see incremental posted for ->mmap() issue + for
plain I/O we don't really care about this case, since it happens so
rarely.  Maybe later...

Thanks,
Miklos
