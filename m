Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ABFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:39:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4412920873
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 10:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rst1BBKj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4412920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729389AbeK0Vgg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 16:36:36 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:35450 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729087AbeK0Vgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 16:36:36 -0500
Received: by mail-it1-f193.google.com with SMTP id p197so7512986itp.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 02:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=YBhIj9uX87++E/JJfy7G9z/6mbQFpm5TxBdDIdDn/0c=;
        b=Rst1BBKjv8WmOvLYTnMbbUHKNk43fwQ0uOmzNg1hqelklq8SfHITaNZjEmi/hI7/IB
         mrFznkh6YjgJOGGTJobu4y12HCrt4b+qZl82Ss2IiRgcs+b8PuuQgoRZhs4CfQCgVzRp
         wDiPuC0EkEzJqnW6Jh5ypa9EJu0wzQDk2wRm0RKjPbV6eLdALv3l8TuZXgYmodP6bc95
         XBGuKFj+HWvZDIOTjn8SZwvBM3y4ufiSzFJnUpyiG0CrSr/LgdwOIztnPCbdBrz3kS/P
         Ru7EbLBP58zk803q6rPC6CSJ5vAGUG7/Bn/r2+3hLP2JTWrdGbj+MbyVakdv/GT/E5E9
         Agfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=YBhIj9uX87++E/JJfy7G9z/6mbQFpm5TxBdDIdDn/0c=;
        b=DflXCIKyiK92HMidK661UdVoJ5+TEOeh1T8Z5YleCnymM841w5xj+wawizanXODkh3
         IMZfhDUPa08kPDaF3Zkru+k3Hc6UZlQDzrdtXhqf1tADqqEVkMLjXuPGDotntSXkFuVX
         LHsAJ83dOm40h6+gJjqNIVi3lmyEuolYIwPeFKyh66AVUw+wmPgNJG66OdHB+DU7Z3Dx
         nj8DAnuKcP765Bbry42DwZVOjLQ4k81ZtrBcgKgi+208m0OV6Ko8lsdQLRznfHrax1cB
         Qc2afxs+k9RIFSzaAVGYVHxHPbPkJSVquVE5JE+2feH7ukXbqx+o98FKGucwOsmCivb6
         pqsg==
X-Gm-Message-State: AA+aEWY2nYcxeIyYwgapKlbWFuo2Fhspqxsi26fHPXpTdfV9kC3zff4N
        JCdjdcQ/SNfBIgbUwr0hz0YBjf7BGOHMDK89LJYTLApmAnCRQ+Aw
X-Google-Smtp-Source: AFSGD/VtOJR7mC9YHOpxoitN9PFqK/eyRKZ2W0jBzc3pQE6zxHDxaupJTB/FGaf8Txx0mCk2g8hfWuE549x+8dI3sag=
X-Received: by 2002:a24:b009:: with SMTP id d9-v6mr3587359itf.166.1543315147808;
 Tue, 27 Nov 2018 02:39:07 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a02:b003:0:0:0:0:0 with HTTP; Tue, 27 Nov 2018 02:38:47
 -0800 (PST)
In-Reply-To: <30486.1543314330@warthog.procyon.org.uk>
References: <CACT4Y+ajxhUaRg+XSuqQZN8rD96S820yMTWx2GpRVRb9Maz50g@mail.gmail.com>
 <0000000000006082bd05752f92bb@google.com> <29979.1536223287@warthog.procyon.org.uk>
 <23632.1536696987@warthog.procyon.org.uk> <20180912063454.0620abb4@canb.auug.org.au>
 <31735.1536701042@warthog.procyon.org.uk> <CACT4Y+boXfNjHT1M5B6OttHiUFKsvL7AFH2Gfd+DbkNoQD4YVg@mail.gmail.com>
 <30486.1543314330@warthog.procyon.org.uk>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 27 Nov 2018 11:38:47 +0100
Message-ID: <CACT4Y+aeESAk3URSKGDUG4L=awa3X18hypzYzeWjmv-CP2YttQ@mail.gmail.com>
Subject: Re: linux-next boot error (2)
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        syzbot <syzbot+762a577f56cfb1574647@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Levin, Alexander" <alexander.levin@verizon.com>,
        LKML <linux-kernel@vger.kernel.org>, linux@dominikbrodowski.net,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        nikolaus.voss@loewensteinmedical.de,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2018 at 11:25 AM, David Howells <dhowells@redhat.com> wrote:
> Dmitry Vyukov <dvyukov@google.com> wrote:
>
>> Please either use the Reported-by tag (for amended linux-next fixes
>> Tested-by can make more sense and is recognized too), or tell syzbot
>> separately:
>
> It got folded in as that's better than carrying a separate patch.
>
> I'll ask Al how he wants to deal with this since he's carrying the patches
> now.


A similar case in linux-next was discussed recently:
https://groups.google.com/d/msg/syzkaller-bugs/xiSF9GdiikU/uBoyYyf3AQAJ
For such cases it can make more sense to use Tested-by tag instead of
Reported-by to not confuse people that the resulting amended patch
fixes some bug (e.g. stable will try to pick it up).  Tested-by is
also recognized by syzbot.
