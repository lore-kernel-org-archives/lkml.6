Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B84BC43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 955352075E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 19:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DVeVXRfB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 955352075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729773AbeIGANR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 20:13:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:33728 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727529AbeIGANR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 20:13:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id d4-v6so5792519pfn.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 12:36:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ix8JOal3+5B/3WhMiTQK7BYcXC6+HHq7ZyR5v3G12C8=;
        b=DVeVXRfBs2+8Kw3TTxoS6R0z0ONnxu3NmAxswlNeGZeLjZYl2v5v5mKhR/RUrWXNfr
         1XJzi2Z9BghpV8SPYo93qX74+HT4CtPG/E8e+SLzMgQ8N7X4+EGaTZy33OxjTffOrF7T
         26k4laCEsVgED4iCZHXhkS/2KqdExS9dapetcKwsxRQ1s74fXCdEmbgR5KehyqovDsO1
         z5it6YUZSBRHWCwC9W6sV9+Fgrsep9gPfL2DTM+AhzpPzveBc0B1taWIGJokOq5PdyHt
         kiHwTek+1MervMHEeDuYdDa9QiOxvKZYFn9SJUzkPXRjOgge8k1uuKD+RCzSvXe3cxsu
         8wRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ix8JOal3+5B/3WhMiTQK7BYcXC6+HHq7ZyR5v3G12C8=;
        b=qlleJA4xdLELF8Nsk4beKGCeuuyPPYgbUrU+SwT7r5V3mMboDSp0LLUWvZD6/lWflB
         TkRGc5vWEW/vzp0Ty+Z2+BQy9mRXavCgPZZEEiBp9vHAByDIFGCbvI0pBCxfi2uCrqPT
         4fYllkBIc/aoaPHOzDXEFcFHfIvAjbJR/YGjiFbtTTxlibNfbLNkspjFS0db6YzdS3sH
         02AW5+ibv8QeTJYo3Ow40Mq+h4iWgWZ236Zu6oQ+C3lBCSkVaOjLGygG0MQRlRfUP8/F
         6fViFz5OTxwYLXY0bbuxbMB7sxNSNHjFn0BUEcT2yT8c9NT14nEXp3YTcZQN+RiDkCkm
         TD2w==
X-Gm-Message-State: APzg51BgXhFBasuwXKqWARwntn35gPMzSgBq80mGfhPAI8shHnpCtp3l
        g4N+hWiQk0jEZX2rQuSIt9gCGoKhX2a84ZTzGwRpEA==
X-Google-Smtp-Source: ANB0Vdb0nQm+KKEFgpfNtOqAvQ2wOX93TN7QJjy0ffpwRnPdVhu5m2AxXNsV2ViCR60frkW4spJfqIPG8zEA3oi/XsM=
X-Received: by 2002:a63:5660:: with SMTP id g32-v6mr4297198pgm.227.1536262579086;
 Thu, 06 Sep 2018 12:36:19 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:ac14:0:0:0:0 with HTTP; Thu, 6 Sep 2018 12:35:58
 -0700 (PDT)
In-Reply-To: <CACT4Y+a6Y1N1VbpLoJPyK5DFYyr8RGM_=mqpWwina=yTUEtUvg@mail.gmail.com>
References: <000000000000c178e305749daba4@google.com> <CACT4Y+Z9wmuq=Pb-gxAJauQNi0uZGDUimWEL66UzWGSp_x2uQA@mail.gmail.com>
 <37aec45f-69ad-9705-21f1-64ee4ce4a772@tycho.nsa.gov> <CAHC9VhSeP=b1xxpCT8R-CYLEP3507ezwDwkq2Bsyekfa4otLGw@mail.gmail.com>
 <9537a6ff-daf4-d572-bf93-68230909b68e@tycho.nsa.gov> <4b37e892-4d79-aefb-92ab-7753b89b8963@tycho.nsa.gov>
 <CACT4Y+YOxTTYzEi3uCeLm3gquvSkJNZ+DhPVziEnbXGX6HVkVA@mail.gmail.com>
 <1ea19628-3bbe-2073-d623-824337c15ed6@tycho.nsa.gov> <CACT4Y+ai0do=8smTG0h0QXDnOrWh8PNwaTosJtqOEB_HG59eGg@mail.gmail.com>
 <b2b38348-f3a4-6498-c9b8-1090532f6a23@tycho.nsa.gov> <CACT4Y+bXaLe0FKyGPT=WqGitZPrawvpOXHS-UOVX0ZXTDV+JVQ@mail.gmail.com>
 <6c9112a2-33f3-0c29-c944-1d129a0026e7@tycho.nsa.gov> <CAHC9VhR6gG6_RkT1OEH4PArHpzUGkOjVCpKwAmad+TDfC15sgQ@mail.gmail.com>
 <CACT4Y+YaBpi95Puae3Bjn1opL+UsdUWns2PDaFU-EmamuMusag@mail.gmail.com>
 <e2e02f43-abfe-171e-a5b7-3fb9086cc733@schaufler-ca.com> <CACT4Y+aaF8pLirqA+Yv4RjemDofEZymjPV6z5EEPQk3b7or10g@mail.gmail.com>
 <CACT4Y+a6Y1N1VbpLoJPyK5DFYyr8RGM_=mqpWwina=yTUEtUvg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 6 Sep 2018 21:35:58 +0200
Message-ID: <CACT4Y+YiwOyM7P7jTYi5k7jeycKj=aW+yi0r+jvpqKJ4FjypLA@mail.gmail.com>
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

On Thu, Sep 6, 2018 at 1:19 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
> On Thu, Sep 6, 2018 at 12:59 PM, Dmitry Vyukov <dvyukov@google.com> wrote:
>> On Wed, Sep 5, 2018 at 7:37 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
>>> On 9/5/2018 4:08 AM, Dmitry Vyukov wrote:
>>>> Thanks! I've re-enabled selinux on syzbot:
>>>> https://github.com/google/syzkaller/commit/196410e4f5665d4d2bf6c818d06f1c8d03cfa8cc
>>>> Now we will have instances with apparmor and with selinux.
>>>
>>> Any chance we could get a Smack instance as well?
>>
>> Hi Casey,
>>
>> Sure!
>> Provided you want to fix bugs ;)
>> I've setup an instance with smack enabled:
>> https://github.com/google/syzkaller/commit/0bb7a7eb8e0958c6fbe2d69615b9fae4af88c8ee
>
>
> But just doing default things does not seem to find much. I guess
> common paths through the hooks are well exercised already.
> So perhaps if we do more non-trivial things, it can find more stuff.
> But what are they? Adding/changing/removing xattr's? Which? What are
> the values? Changing security contexts? How? What else?
> selinux has own filesystem and we should touch some files there:
> https://github.com/google/syzkaller/blob/master/sys/linux/selinux.txt
> But we don't anything similar for other modules.


First one that looks smack-specific:
https://syzkaller.appspot.com/bug?id=9eda6092f146cb23cb9109f675a2e2cb743ee48b
