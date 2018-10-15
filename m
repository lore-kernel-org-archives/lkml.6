Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21572C71133
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:40:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF61E20881
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 17:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z7ln0Xkk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF61E20881
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbeJPB1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 21:27:05 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:37405 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726713AbeJPB1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 21:27:05 -0400
Received: by mail-it1-f193.google.com with SMTP id e74-v6so28826707ita.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 10:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=3eCzK1Bo+xaQCcLmm3vpxCUDuyIxwcw0AorZBpOgZfg=;
        b=Z7ln0XkkrY1/QHHqMrQkNOWKV5tGFwt8qWF+n/p6zcUt5Opd0YFLvtXvEtS2YzWHx2
         E17P/ivRw677r7bwiZbzGugCbGexKDk3222F1SYRNqYyoDqS0us/IBbTK98jrRYAMQbC
         Pb31Rv+s86jUg/zzrBQv2YcR1hVVBI4/IqZ8JsY5Q1IMbKwPBWdU6IlYv4HN+ifm4WUp
         q7gy/NM5w6ImZyHmmYi96hXMWshGbKOdGWdj8gqLABJRu4Z6ovQMFaFJcZ4hxtl1giA1
         3tdEtm2xJ6CUhRtfwsu9A/b8owcZaBAvqhAHJLYRpvUZiBBgVeJ/fjFYQ3oVdy/7uvf5
         FBUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=3eCzK1Bo+xaQCcLmm3vpxCUDuyIxwcw0AorZBpOgZfg=;
        b=L1AnR3je/Ms7/dQ6QmwpzRSUFY1b3Si1SygCZjhZWWB7zxlX5Dp+nTTN+x3YTBeGCP
         l8JVfV1jXGLEh6IKikIaoiQBhxIBiUe+CiFU9laQxPKkPyP5Qa8v1R+21s2ZAbYmaAGT
         55ZTi0Tv9whABh67Gxp3p7rhALFQ60+iJResmur7J7eznrj6BqXxeW190FoC1PesPXIe
         5Yec5PBqVzTxUTe5I70JQnEp+Z8TMZvIGfTfwqdU3xyKxKIgzGu6nZYabT9LisS7+xMo
         wKjEO0LJTTrNP6lwXyUPheyuVksAaJweDSRpth+dgRoZubbZ1uisxbGbbLl4H8zWo9ru
         7lJg==
X-Gm-Message-State: ABuFfoi5zf0/nydXVz3wr2ZT1VR1j0I1bzfrT2Fw1iWXZ5fY31CP9APT
        j1g7jQOReG4LLfoJRQHghSNGHjKZoMgxVkPzR+8i8Q==
X-Google-Smtp-Source: ACcGV63Z01p5ylZlGeP68kEHqYTSWFmj9Yj53rjkVwOjR94XeMGlgqU/9tjNhZYdyQEhE34Pt7EpVjNMeMIavBgX/Vc=
X-Received: by 2002:a02:565c:: with SMTP id o89-v6mr13704350jab.51.1539625250619;
 Mon, 15 Oct 2018 10:40:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:3d47:0:0:0:0:0 with HTTP; Mon, 15 Oct 2018 10:40:49
 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.44L0.1810151309030.1394-100000@iolanthe.rowland.org>
References: <CAAeHK+zc-JyzxTAtv7tuVAw8Aut2uAfGP7FfNmseALY1ZBgcNQ@mail.gmail.com>
 <Pine.LNX.4.44L0.1810151309030.1394-100000@iolanthe.rowland.org>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Mon, 15 Oct 2018 19:40:49 +0200
Message-ID: <CAAeHK+wJVFv-8AHFG3V3tOdkzw9D63Ztot_tb=oR-QVNXWPoXw@mail.gmail.com>
Subject: Re: WARNING in usb_submit_urb (3)
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     syzbot <syzbot+24a30223a4b609bb802e@syzkaller.appspotmail.com>,
        Thinh.Nguyen@synopsys.com,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        "Gustavo A . R . Silva" <garsilva@embeddedor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Oliver Neukum <oneukum@suse.com>
Content-Type: multipart/mixed; boundary="0000000000002723b3057847f028"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002723b3057847f028
Content-Type: text/plain; charset="UTF-8"

On Mon, Oct 15, 2018 at 7:12 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> Ah, I see the problem.  In fact it is the same issue, but the commit
> mentioned above contains an error (is_in gets tested too soon).  The
> fix is below; can you check it?

You can ask syzbot to do this:

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

--0000000000002723b3057847f028
Content-Type: text/x-patch; charset="US-ASCII"; name="usb_submit_urb.patch"
Content-Disposition: attachment; filename="usb_submit_urb.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jnal3y1h0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2NvcmUvZGV2aW8uYyBiL2RyaXZlcnMvdXNiL2NvcmUv
ZGV2aW8uYwppbmRleCAyNDQ0MTdkMGRmZDEuLmZmY2NkNDBlYTY3ZCAxMDA2NDQKLS0tIGEvZHJp
dmVycy91c2IvY29yZS9kZXZpby5jCisrKyBiL2RyaXZlcnMvdXNiL2NvcmUvZGV2aW8uYwpAQCAt
MTQ3NCw4ICsxNDc0LDYgQEAgc3RhdGljIGludCBwcm9jX2RvX3N1Ym1pdHVyYihzdHJ1Y3QgdXNi
X2Rldl9zdGF0ZSAqcHMsIHN0cnVjdCB1c2JkZXZmc191cmIgKnV1cmIKIAl1ID0gMDsKIAlzd2l0
Y2ggKHV1cmItPnR5cGUpIHsKIAljYXNlIFVTQkRFVkZTX1VSQl9UWVBFX0NPTlRST0w6Ci0JCWlm
IChpc19pbikKLQkJCWFsbG93X3Nob3J0ID0gdHJ1ZTsKIAkJaWYgKCF1c2JfZW5kcG9pbnRfeGZl
cl9jb250cm9sKCZlcC0+ZGVzYykpCiAJCQlyZXR1cm4gLUVJTlZBTDsKIAkJLyogbWluIDggYnl0
ZSBzZXR1cCBwYWNrZXQgKi8KQEAgLTE1MDUsNiArMTUwMyw4IEBAIHN0YXRpYyBpbnQgcHJvY19k
b19zdWJtaXR1cmIoc3RydWN0IHVzYl9kZXZfc3RhdGUgKnBzLCBzdHJ1Y3QgdXNiZGV2ZnNfdXJi
ICp1dXJiCiAJCQlpc19pbiA9IDA7CiAJCQl1dXJiLT5lbmRwb2ludCAmPSB+VVNCX0RJUl9JTjsK
IAkJfQorCQlpZiAoaXNfaW4pCisJCQlhbGxvd19zaG9ydCA9IHRydWU7CiAJCXNub29wKCZwcy0+
ZGV2LT5kZXYsICJjb250cm9sIHVyYjogYlJlcXVlc3RUeXBlPSUwMnggIgogCQkJImJSZXF1ZXN0
PSUwMnggd1ZhbHVlPSUwNHggIgogCQkJIndJbmRleD0lMDR4IHdMZW5ndGg9JTA0eFxuIiwK
--0000000000002723b3057847f028--
