Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B88F2C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D75720652
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 10:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gJNgR6Tv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D75720652
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728246AbeIFPes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 11:34:48 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35078 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727789AbeIFPer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 11:34:47 -0400
Received: by mail-pg1-f193.google.com with SMTP id 7-v6so5054706pgf.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 03:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SbxAfneVOh4m/VEpJ89KknkWcsQrFUSObn45Y1o0IqA=;
        b=gJNgR6TveZZoEywjzrWUJsNatfeYLz4i2BO6m9kFO3ryISyoJKLHlHHeOUDxdAR7so
         wJUY6UUq0BwRFvaE5JiHe+5336G+d5NwIu2skpbD78BIJZkSFzIqm1JS24iBQYdyVZF6
         WcEU7PvVe3fFIlfTN6PsNQi0M6YT90N0zS9fWuYKhe7Md7PrpF5zXQKQCjDZrSttL+TI
         88UXcxPNVnxtMRthTUOroRmf21mpjSxYiHkcViL1w/3bsoJFpOcrxSlBEM40/sEqDFmi
         xJFdb22hInfKHMjJaUwb4d8GSZkE7uiqDb5zejKE2Gq9Bd93gHD3zB71MYeahDkwx1pT
         vZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SbxAfneVOh4m/VEpJ89KknkWcsQrFUSObn45Y1o0IqA=;
        b=fu2LyVCMpdBuYHumjna/pf9UzJEBg8rNE7xkE/dPBdRrZFLf5nz7F5hfgortLZuKbl
         oh93bagPBwYZreszjtM3FrIDh5IHG+TMgfARY5Ama/7Ra2nku4jmIsNx+WB7IlDhxhxp
         BXs5Ak/Cm86cKEJou91NtV9Jk0whenJ2cPvsGvj+AscEkBG5HEypnGOpkKWthsC9io92
         FX37XQo9HQFWZKdPZwCspIs7XUyYH5BO9CSUV2hZO5jGSCXU2OJHZYljRXAQIeqMoXr0
         X65Ghdy0di6aqcGCp0VzUl86GhmZ7XE6WUxxY/Xg1aWEA1bZ2Xw3u1EtJfc5KPkZzOTh
         MijA==
X-Gm-Message-State: APzg51CHIxvhMwbEkjUcPJ1vipxyToABVJiCtak/eq7uuHtWZD9BWZ+W
        pKvJmlRfZUu4dPEJ064FKbAZAOcHdGFxFYRK8vMweg==
X-Google-Smtp-Source: ANB0VdZPhgNMq5k/+3YNyVY6DKtUuyf2y+3voqtCZ01s6F6gm1hcqYVdv7ajM4e1r3euRO2MJIJ7P1W1PsSGQxeuSGU=
X-Received: by 2002:a62:571b:: with SMTP id l27-v6mr2184393pfb.29.1536231592965;
 Thu, 06 Sep 2018 03:59:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 6 Sep 2018 03:59:32
 -0700 (PDT)
In-Reply-To: <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov> <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov> <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com> <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Sep 2018 12:59:32 +0200
Message-ID: <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
Subject: Re: WARNING in apparmor_secid_to_secctx
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        syzbot <syzbot+21016130b0580a9de3b5@syzkaller.appspotmail.com>,
        tyhicks@canonical.com, John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org,
        Serge Hallyn <serge@hallyn.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        SELinux <selinux@tycho.nsa.gov>,
        Russell Coker <russell@coker.com.au>,
        Laurent Bigonville <bigon@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 5, 2018 at 7:37 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/5/2018 4:08 AM, Dmitry Vyukov wrote:
>> Thanks! I've re-enabled selinux on syzbot:
>> https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
>> Now we will have instances with apparmor and with selinux.
>
> Any chance we could get a Smack instance as well?

Hi Casey,

Sure!
Provided you want to fix bugs ;)
I've setup an instance with smack enabled:
https://github.com/google/syzkaller/commit/0bb7a7eb8e0958c6fbe2d69615b9fae4af88c8ee
