Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64C10C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DABA21B18
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 22:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rOjj091M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408121AbfBNWe2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 17:34:28 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43141 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393758AbfBNWe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 17:34:28 -0500
Received: by mail-qt1-f194.google.com with SMTP id y4so8800958qtc.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 14:34:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Os4dMXp/JN1Nc3XgF1tbzn0Bwa6VCs7Hf6YdFUJ4wrk=;
        b=rOjj091Mk2BQ7qni93XaJxrBrrge2Tgr+rNE7Dqqr3Ho7gxrCBUs/Hrb9y6beAFXZg
         5rztpbFxRSIR4qbSd2+kFMEzNW7VFDCKGwDbtmeyXxHBev5Q1WiQ6Pd9s5IAgT2rGi1D
         xL5JNtQNHSODxI8nBWQoLv175KfRkVUwWCBCHoCwkFDRN/85uopTS3Uaw78bkixloHX0
         EMEizH5D7KuBXNy34NXuHHTPPDgDWxcQj/29/Oh01MVRwBaod7TlN6jsVX1Q6Js6B91W
         wapQmTuGrE9MwGqSk8HBrog4/oyyGAVDweF36g1+U4FdlD+aHPHAmJIsqN02M7mg2IQf
         /KtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Os4dMXp/JN1Nc3XgF1tbzn0Bwa6VCs7Hf6YdFUJ4wrk=;
        b=GVAMOCq9FUBJ00PHQrb4dfTFgVU/xZYXcS2OstvHUZowU+0oUyGk6a2xoe0rtz7Mz3
         HD7wJQSN5g3wR/Z6Xhidx60Os3Af9l56goFhR3QNKghyhuPdaXR7C7zVpRygOVcg/NSN
         YuHw29GGKmfMzAeQUTA23FzlCbezqRIDzUOR/9AZCRBY4YSdUgYT3APe1kyhMYz6VxQi
         k1l7Ydk6FHJ6P4uYvwotadgYWkUW43jYAuTszhBFLd7ddqckNDQg8VFFafpPtjYDjjH9
         SOGCUevMNW7dS9O4QYg4W/EqO1OksOvDDjLQPa/JllAtbKcs75G6/rFHU4LgnRKphqYp
         lTRQ==
X-Gm-Message-State: AHQUAuaRhep8neiG1wvB2DxDEiX11aw/bL7RjGnb7F/iVOTClZ5u+721
        z9R99vrI+Zd/oDikK7O6+sf+jG3/TjsACwKb8Q2MAg==
X-Google-Smtp-Source: AHgI3IYCAsip/I2Qk2tIqeVyD5ouBAltf8oXdQNbJnoZd69txH9Ul7TeSSwbJfAVFh20DaDIOHp9jeKObGPfCQCSk8Q=
X-Received: by 2002:ac8:3227:: with SMTP id x36mr5147138qta.56.1550183666648;
 Thu, 14 Feb 2019 14:34:26 -0800 (PST)
MIME-Version: 1.0
References: <00000000000048c0060581d8fe23@google.com> <0000000000009e34680581d90c3f@google.com>
In-Reply-To: <0000000000009e34680581d90c3f@google.com>
From:   Todd Kjos <tkjos@google.com>
Date:   Thu, 14 Feb 2019 14:34:15 -0800
Message-ID: <CAHRSSEx0ifKf-bA9NGwXak0DhWt6Xfxe+SQgfEEdNcyVAPwb_Q@mail.gmail.com>
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
Content-Type: multipart/mixed; boundary="000000000000c9f9120581e24298"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c9f9120581e24298
Content-Type: text/plain; charset="UTF-8"

On Thu, Feb 14, 2019 at 3:35 AM syzbot
<syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following crash on:
>
> HEAD commit:    b3418f8bddf4 Add linux-next specific files for 20190214
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=161d2048c00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8a3a37525a677c71
> dashboard link: https://syzkaller.appspot.com/bug?extid=55de1eb4975dec156d8f
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd2f1f400000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+55de1eb4975dec156d8f@syzkaller.appspotmail.com
>

Testing a fix:

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
linux-next

--000000000000c9f9120581e24298
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_js574pdo0>
X-Attachment-Id: f_js574pdo0

CmRpZmYgLS1naXQgYS9kcml2ZXJzL2FuZHJvaWQvYmluZGVyLmMgYi9kcml2ZXJzL2FuZHJvaWQv
YmluZGVyLmMKaW5kZXggMmRiYTUzOWViNzkyYy4uODY4NTg4MmRhNjRjZCAxMDA2NDQKLS0tIGEv
ZHJpdmVycy9hbmRyb2lkL2JpbmRlci5jCisrKyBiL2RyaXZlcnMvYW5kcm9pZC9iaW5kZXIuYwpA
QCAtMjA1Nyw3ICsyMDU3LDcgQEAgc3RhdGljIHNpemVfdCBiaW5kZXJfZ2V0X29iamVjdChzdHJ1
Y3QgYmluZGVyX3Byb2MgKnByb2MsCiAgICAgICAgc2l6ZV90IG9iamVjdF9zaXplID0gMDsKIAog
ICAgICAgIHJlYWRfc2l6ZSA9IG1pbl90KHNpemVfdCwgc2l6ZW9mKCpvYmplY3QpLCBidWZmZXIt
PmRhdGFfc2l6ZSAtIG9mZnNldCk7Ci0gICAgICAgaWYgKHJlYWRfc2l6ZSA8IHNpemVvZigqaGRy
KSkKKyAgICAgICBpZiAocmVhZF9zaXplIDwgc2l6ZW9mKCpoZHIpIHx8ICFJU19BTElHTkVEKG9m
ZnNldCwgc2l6ZW9mKHUzMikpKQogICAgICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgYmlu
ZGVyX2FsbG9jX2NvcHlfZnJvbV9idWZmZXIoJnByb2MtPmFsbG9jLCBvYmplY3QsIGJ1ZmZlciwK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBvZmZzZXQsIHJlYWRfc2l6ZSk7
Cg==
--000000000000c9f9120581e24298--
