Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70137C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31E7C21872
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BH2Y9U3R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503439AbfBNWq5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:46:57 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32772 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbfBNWq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:46:57 -0500
Received: by mail-qt1-f194.google.com with SMTP id z39so8914613qtz.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmlsMQDzed+V09W82Eb/0QmK/oC7HZh3wOPBxNFtO+0=;
        b=BH2Y9U3RuetGB5ckuoSU36wiRlTadgGbjW5/QYgnB2dNY2YX5R2N9BMzg7XW8WUf9d
         r60BTy4CuEUNSYZeEuRHWUgg0gEFhV1w4nNhHP0fq6wBukNFOF+CU3wqXCMPxjX8iNv9
         pNB9NbRYSm0C7MxCMtAxJac13zvr7l4JCNzihT6dMVnlxGOPKaWD/Ha9u0K5T67hcmu4
         uEYsgx+yWNJI+tBIZyD4lTHr4EDMHadtu5FiS9ebOjhnCzoQq6bGSxol1d3xRGQAcWR3
         kTNc9FviHdKc35YUZyZZLrtwv6wWQENDBKsXVReMfaNj91hzhE2DWD76pRk7vMKSkOds
         Uz/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmlsMQDzed+V09W82Eb/0QmK/oC7HZh3wOPBxNFtO+0=;
        b=FrATEUzdbigyCJdyGSLovEY0MwaceNzSXk++vCZd9n1lrks3a8J9/WUVlmd9v7zc8O
         Fdp4vnG+xSqavq/lBTUX+noDInceK+3LVkPeAkYjFnhDHj3TCyPmt+Gqo95hr44JdxeU
         4LcCXGu5Z/sYhtrCZgIRn2MNoTNMI25T5Lxj+rNbtlVX1cmawkuZJkLsUOa5rQDx24lU
         pnCqjTxh/wuGkEV+vSqC+JEBv0xZcItfFMaiEARBeWaMXbh5PhMlWKiBJ4ACEwf2Iiwq
         JI95praDaeUZSHyIYAoBP1+4ZCUvu3JCBrPIW8zrepLTHqSeY2FHEUtMFhQPo3wX+Mjs
         a0Hg==
X-Gm-Message-State: AHQUAubkn+Qi2QJJiYOGmkiHiLi0EOiwe8O232/OeKlJtYh1Vn389xCL
        y7JJLWLppmW4Tecn5UvCXjf7azJjFIjoG+F6vFAhgw==
X-Google-Smtp-Source: AHgI3IbROh3IMTTiAW9u7z+OAC7pPkg8k+j+er/awzhO8VmKaHokU546jzrMFclwGjKDCKhYPFZxv3yIg3tS59irTvA=
X-Received: by 2002:ac8:28e4:: with SMTP id j33mr5197502qtj.349.1550184415456;
 Thu, 14 Feb 2019 14:46:55 -0800 (PST)
MIME-Version: 1.0
References: <00000000000048c0060581d8fe23@google.com> <0000000000009e34680581d90c3f@google.com>
 <CAHRSSEx0ifKf-bA9NGwXak0DhWt6Xfxe+SQgfEEdNcyVAPwb_Q@mail.gmail.com>
In-Reply-To: <CAHRSSEx0ifKf-bA9NGwXak0DhWt6Xfxe+SQgfEEdNcyVAPwb_Q@mail.gmail.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 14 Feb 2019 14:46:43 -0800
Message-ID: <CAHRSSEyYx8XLgn+6Vb-a_icEn1xZUKh8=dHTjCHK=6y38gUX6A@mail.gmail.com>
Subject: Re: kernel BUG at drivers/android/binder_alloc.c:LINE! (2)
To:     syzbot <syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com>
Cc:     =?UTF-8?B?QXJ2ZSBIasO4bm5ldsOlZw==?= <arve@android.com>,
        Christian Brauner <christian@brauner.io>,
        "open list:ANDROID DRIVERS" <devel@driverdev.osuosl.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Martijn Coenen <maco@android.com>,
        syzkaller-bugs@googlegroups.com, Todd Kjos <tkjos@android.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: multipart/mixed; boundary="0000000000006c0ccd0581e26f73"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000006c0ccd0581e26f73
Content-Type: text/plain; charset="UTF-8"

Trying again with the correct branch spec...

On Thu, Feb 14, 2019 at 2:34 PM Todd Kjos <tkjos@google.com> wrote:
>
> On Thu, Feb 14, 2019 at 3:35 AM syzbot
> <syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has found a reproducer for the following crash on:
> >
> > HEAD commit:    b3418f8bddf4 Add linux-next specific files for 20190214
> > git tree:       linux-next
> > console output: https://syzkaller.appspot.com/x/log.txt?x=161d2048c00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=8a3a37525a677c71
> > dashboard link: https://syzkaller.appspot.com/bug?extid=55de1eb4975dec156d8f
> > compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd2f1f400000
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com
> >
>
> Testing a fix:
>
#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
master

--0000000000006c0ccd0581e26f73
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_js57r4u90>
X-Attachment-Id: f_js57r4u90

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYyBiL2RyaXZlcnMvYW5kcm9pZC9i
aW5kZXIuYwppbmRleCAyZGJhNTM5ZWI3OTJjLi44Njg1ODgyZGE2NGNkIDEwMDY0NAotLS0gYS9k
cml2ZXJzL2FuZHJvaWQvYmluZGVyLmMKKysrIGIvZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jCkBA
IC0yMDU3LDcgKzIwNTcsNyBAQCBzdGF0aWMgc2l6ZV90IGJpbmRlcl9nZXRfb2JqZWN0KHN0cnVj
dCBiaW5kZXJfcHJvYyAqcHJvYywKIAlzaXplX3Qgb2JqZWN0X3NpemUgPSAwOwogCiAJcmVhZF9z
aXplID0gbWluX3Qoc2l6ZV90LCBzaXplb2YoKm9iamVjdCksIGJ1ZmZlci0+ZGF0YV9zaXplIC0g
b2Zmc2V0KTsKLQlpZiAocmVhZF9zaXplIDwgc2l6ZW9mKCpoZHIpKQorCWlmIChyZWFkX3NpemUg
PCBzaXplb2YoKmhkcikgfHwgIUlTX0FMSUdORUQob2Zmc2V0LCBzaXplb2YodTMyKSkpCiAJCXJl
dHVybiAwOwogCWJpbmRlcl9hbGxvY19jb3B5X2Zyb21fYnVmZmVyKCZwcm9jLT5hbGxvYywgb2Jq
ZWN0LCBidWZmZXIsCiAJCQkJICAgICAgb2Zmc2V0LCByZWFkX3NpemUpOwo=
--0000000000006c0ccd0581e26f73--
