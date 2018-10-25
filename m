Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE18C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EEF2083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 15:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFlhpi28"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EEF2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeJYXuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 19:50:54 -0400
Received: from mail-yb1-f177.google.com ([209.85.219.177]:36645 "EHLO
        mail-yb1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727400AbeJYXuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 19:50:54 -0400
Received: by mail-yb1-f177.google.com with SMTP id w16-v6so3835049ybp.3;
        Thu, 25 Oct 2018 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oyxUG59ZgBP3CTyLWJMKlGBBlS8NM4cHCi4sVowvIKs=;
        b=PFlhpi282VBPC013nLIHEx0zNrPmWUjMM4trqmisbs+w65N9LD0ZXmNz9urDhPL33e
         58MBQgaJH+Bt8kSGwMKGCjhI09s4K0ax/nIh3gCLspQFCu/cEkIr/J0ezyNQESGLFhdp
         0EmIeNa9EzENl51+b330fF4/lKazsEKVFc88R3Zyc0mnXndwNOaVDsWYOSB7Gj5tkqv4
         HP/M1DnZEPqQpS43S35hN6JYcQltj1XIcDMYxbURr9FaylCbvr2Jq9ElXe81VYrbh6jJ
         gxgH6L5NT5uBtfm49BTVwGur8rrxpa5/zI/6cHsGSglB1eUl3lNtWc2rs7PXpM5TcFbO
         nyWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oyxUG59ZgBP3CTyLWJMKlGBBlS8NM4cHCi4sVowvIKs=;
        b=ovCo4K0V3E0gx0O4XPLMUn3jDSai3GjW2lzFwy/qPys7vcosbdIN2aVYFiX2wVcvOO
         ojtfMwrqpJ8UhsjiQc700JMyX8Ydmqff1X7wYF/WJa4xAWhwlAxCU2UbNB9SdJ9vncHS
         B1v1xPc0EBgn4KFWVYDW+XFfkBCMKIZTyegSph9Rp9noxPfhnio+lcSYLPV+7WJyq7L0
         WzEKCGBMRW67YuET6wapTTWynwgkHCaajg6LAXBiD+g72VRH1uym+NiAg9rBZtI45jTD
         oJVUu9zDFF/z4186wZ9pY4YowwPbCBUA6Vy9mXFJXoJ5dV44h1/8XtUelKvHAG1zPsQt
         7m4g==
X-Gm-Message-State: AGRZ1gLxrSoO4fj6qhAmwS6WgEX5+RyS/Y1yCApgje5hjtrn820VfMWh
        z0OAhnyyMDVxw3Tv9FrwAOg5BWCD5bbc/8MudwM=
X-Google-Smtp-Source: AJdET5dYa/mdE2oZ2c/HgVtyKMUA6GH8BnJ6KXgnJlmIjT+Rr37XOXRjqNOkroZ9b3MxKkhGGHD+W9CQBjtLJRL/YXo=
X-Received: by 2002:a25:fc0d:: with SMTP id v13-v6mr1918499ybd.320.1540480659502;
 Thu, 25 Oct 2018 08:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <0000000000003852440576ef80b2@google.com> <CACT4Y+bR+9vy5ZKDN31gmvKk5hcoNojaBuD9Dz1wswfObyt0uw@mail.gmail.com>
 <CAOQ4uxhxON4EeWqVLN68YF4v=hr5wfQk9wZEZLZLZu7B_XGuUw@mail.gmail.com>
 <20181024090959.s5y3azpsmtswjyn5@mwanda> <CAOQ4uxi84ywY4BXJ1ZYDOQHZhbYr+GjJTrkGZvBbH4XUqR0nPw@mail.gmail.com>
 <09f6038b7642f425eba162ea2239552e12da2045.camel@kernel.org> <20181025150219.GA5539@fieldses.org>
In-Reply-To: <20181025150219.GA5539@fieldses.org>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 25 Oct 2018 18:17:25 +0300
Message-ID: <CAOQ4uxh_WLVPnLt=r5j5wm7gET=C64RKGexGVdNyJK0d0aMr5g@mail.gmail.com>
Subject: Re: KASAN: slab-out-of-bounds Read in string (2)
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        syzbot+376cea2b0ef340db3dd4@syzkaller.appspotmail.com,
        Miklos Szeredi <miklos@szeredi.hu>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs@googlegroups.com, Jan Harkes <jaharkes@cs.cmu.edu>,
        Mark Fasheh <mark@fasheh.com>
Content-Type: multipart/mixed; boundary="0000000000007e9b2e05790f1ae2"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007e9b2e05790f1ae2
Content-Type: text/plain; charset="UTF-8"

On Thu, Oct 25, 2018 at 6:02 PM Bruce Fields <bfields@fieldses.org> wrote:

> > > So I guess it has fallen between the cracks.
> > > Feel free to send a patch to Jeff.
> > >
> > > Thanks,
> > > Amir.
> >
> > Actually, this should probably go to Bruce, as he mostly takes care of
> > lockd. Patch looks correct though.
>
> Yes, if you could resend I'd be happy to handle it.--b.

Attached.
Thanks,
Amir.

--0000000000007e9b2e05790f1ae2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-lockd-fix-access-beyond-unterminated-strings-in-prin.patch"
Content-Disposition: attachment; 
	filename="0001-lockd-fix-access-beyond-unterminated-strings-in-prin.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jnoqdv9q0>
X-Attachment-Id: f_jnoqdv9q0

RnJvbSA0MDAwMGY0ZGNiZDVkZDE4YTgwZWZiNmFlZjAxMGYxMTY0OTg1NTgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBGcmksIDI4IFNlcCAyMDE4IDIwOjQxOjQ4ICswMzAwClN1YmplY3Q6IFtQQVRDSF0gbG9j
a2Q6IGZpeCBhY2Nlc3MgYmV5b25kIHVudGVybWluYXRlZCBzdHJpbmdzIGluIHByaW50cwoKcHJp
bnRrIGZvcm1hdCB1c2VkICUqcyBpbnN0ZWFkIG9mICUuKnMsIHNvIGhvc3RuYW1lX2xlbiBkb2Vz
IG5vdCBsaW1pdAp0aGUgbnVtYmVyIG9mIGJ5dGVzIGFjY2Vzc2VkIGZyb20gaG9zdG5hbWUuCgpT
aWduZWQtb2ZmLWJ5OiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgotLS0KIGZz
L2xvY2tkL2hvc3QuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBk
ZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2xvY2tkL2hvc3QuYyBiL2ZzL2xvY2tkL2hvc3Qu
YwppbmRleCBkMzVjZDZiZTA2NzUuLjkzZmI3Y2YwYjkyYiAxMDA2NDQKLS0tIGEvZnMvbG9ja2Qv
aG9zdC5jCisrKyBiL2ZzL2xvY2tkL2hvc3QuYwpAQCAtMzQxLDcgKzM0MSw3IEBAIHN0cnVjdCBu
bG1faG9zdCAqbmxtc3ZjX2xvb2t1cF9ob3N0KGNvbnN0IHN0cnVjdCBzdmNfcnFzdCAqcnFzdHAs
CiAJfTsKIAlzdHJ1Y3QgbG9ja2RfbmV0ICpsbiA9IG5ldF9nZW5lcmljKG5ldCwgbG9ja2RfbmV0
X2lkKTsKIAotCWRwcmludGsoImxvY2tkOiAlcyhob3N0PSclKnMnLCB2ZXJzPSV1LCBwcm90bz0l
cylcbiIsIF9fZnVuY19fLAorCWRwcmludGsoImxvY2tkOiAlcyhob3N0PSclLipzJywgdmVycz0l
dSwgcHJvdG89JXMpXG4iLCBfX2Z1bmNfXywKIAkJCShpbnQpaG9zdG5hbWVfbGVuLCBob3N0bmFt
ZSwgcnFzdHAtPnJxX3ZlcnMsCiAJCQkocnFzdHAtPnJxX3Byb3QgPT0gSVBQUk9UT19VRFAgPyAi
dWRwIiA6ICJ0Y3AiKSk7CiAKLS0gCjIuMTcuMQoK
--0000000000007e9b2e05790f1ae2--
