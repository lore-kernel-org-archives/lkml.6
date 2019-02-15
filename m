Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CBBC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 364192192B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 16:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Iy55SPZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729150AbfBOQj6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 11:39:58 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:46307 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbfBOQj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 11:39:58 -0500
Received: by mail-lj1-f193.google.com with SMTP id v16so8862875ljg.13
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VxhDXCq/XG63Fm2q09H9BDB5XSF2RvxSHOs58SOGrxE=;
        b=Iy55SPZ0M9/eNB6yqqqQ3HjIddZb0D45Y3Z/mzsAbGpNO/5xu9vOIlwKsscMV4LMcu
         Vml3kLLawm13HXts1zZIWC87ocSBjvD/a3unJIaaBwzf4umZ/WqD5qi0ZKH2mOSVPziB
         z0frax+ZWvHyhsIo6WMOFz0IdOO8hl7J/InkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VxhDXCq/XG63Fm2q09H9BDB5XSF2RvxSHOs58SOGrxE=;
        b=Ym8rbnAH9S9PNs0cCKFzE5ZbIiiLgtgWobtCSWB4T8jVGd3aeb5WKZa6L3/eyw9ThN
         mxVcxi+gc5w6xdDDYvVjEjoY9MsURF9ApY1rFLKQOyvMEueafMoFooXygCYeoY4TQiLZ
         YhoCl45QB2bBK5WH3+VjY1qX8algjCiMrOgohO6hxCfgRFH0Ra440LhKmCNYYsXgby6/
         9VHldLeY2N8eOSzeziFTiIvCbBSgVysRdJhgW0WTnF2Uyzi0WXesFUREefa+S4unkIO1
         i5ns5AyJ1KOatd0AGdNUd8mmWafh0j2QPrH2ToRwE+oDZfn9jDznRMCnW2ury8b4KhVQ
         DHtg==
X-Gm-Message-State: AHQUAubF9nuYhZpfzILxM2LqyBxPiTiZOjtrNSOgsfMzYXppx+WgiDul
        2YkRBt3iFTXCoX8ybQYwDQctZgHpuhY=
X-Google-Smtp-Source: AHgI3IaAk8eixgDnEovcFRNln9U4kHNLdUXEq2bAh6P3CeMefpA91KJmUQfPLihp1idf5Hnfwg0Faw==
X-Received: by 2002:a2e:3509:: with SMTP id z9-v6mr6105852ljz.28.1550248795521;
        Fri, 15 Feb 2019 08:39:55 -0800 (PST)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id n21sm1686464lfb.81.2019.02.15.08.39.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 08:39:54 -0800 (PST)
Received: by mail-lj1-f172.google.com with SMTP id w6so4128259ljd.7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Feb 2019 08:39:54 -0800 (PST)
X-Received: by 2002:a2e:91c8:: with SMTP id u8mr5305570ljg.185.1550248793963;
 Fri, 15 Feb 2019 08:39:53 -0800 (PST)
MIME-Version: 1.0
References: <20190215031758.GA18776@beast> <CAHk-=wg7DRUqWvbCS2dm=mpdSNJry92Fo0OHDVi67bi8BMqt4A@mail.gmail.com>
 <CAGXu5jLi+zcOoi+Ti=OyR3MfF8s_S35EEmT_DoCzYPepOcn+Ow@mail.gmail.com>
 <CAGXu5jJXFP-1rEeYtMfqrSUz2oz8TWcjr89zL6-MPsNS7rwywg@mail.gmail.com> <20190215161851.GA8804@redhat.com>
In-Reply-To: <20190215161851.GA8804@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Feb 2019 08:39:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjk29MeO9PuyirONZMr75-H6LtfNe6WghOXT7n+f5-RTA@mail.gmail.com>
Message-ID: <CAHk-=wjk29MeO9PuyirONZMr75-H6LtfNe6WghOXT7n+f5-RTA@mail.gmail.com>
Subject: Re: [PATCH v3] exec: load_script: Do not exec truncated interpreter path
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Samuel Dionne-Riel <samuel@dionne-riel.com>,
        Richard Weinberger <richard.weinberger@gmail.com>,
        Graham Christensen <graham@grahamc.com>,
        Michal Hocko <mhocko@suse.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000adb93e0581f16c44"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000adb93e0581f16c44
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 15, 2019 at 8:18 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Not sure. Consider a script file which has a single line
>
>         #!/path/to/interpreter
>
> WITHOUT '\n' at the end.

Heh. I'm not sure how valid that is, but it's an interesting case for sure.

But it's actually fairly easy to fix with the franken-approach I did
that combines mine and Kees' patches.

Does this work?

                  Linus

--000000000000adb93e0581f16c44
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_js6a2sss0>
X-Attachment-Id: f_js6a2sss0

IGZzL2JpbmZtdF9zY3JpcHQuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKysrKysrKystLQog
MSBmaWxlIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZnMvYmluZm10X3NjcmlwdC5jIGIvZnMvYmluZm10X3NjcmlwdC5jCmluZGV4IDdjZGUz
ZjQ2YWQyNi4uNDFiZTE1NzAxMzgzIDEwMDY0NAotLS0gYS9mcy9iaW5mbXRfc2NyaXB0LmMKKysr
IGIvZnMvYmluZm10X3NjcmlwdC5jCkBAIC0xNCw2ICsxNCwyOSBAQAogI2luY2x1ZGUgPGxpbnV4
L2Vyci5oPgogI2luY2x1ZGUgPGxpbnV4L2ZzLmg+CiAKKy8qCisgKiBEbyB3ZSBoYXZlIGEgdGVy
bWluYXRpbmcgY2hhcmFjdGVyIGJldHdlZW4gJ2ZpcnN0JyBhbmQgJ2xhc3QnCisgKiAoaW5jbHVz
aXZlKS4gVGhpcyBpcyB0aGUgIndlIGFyZSB0cnVuY2F0aW5nIHRoZSBzY3JpcHQgY29tbWFuZAor
ICogbGluZSIgY2FzZSwgYW5kIHdlIGtub3cgZmlyc3QgPCBsYXN0LgorICoKKyAqIFdlIHNraXAg
bGVhZGluZyB3aGl0ZXNwYWNlLCBhbmQgdGhlbiB2ZXJpZnkgdGhlcmUncyBhIHNwYWNlL3RhYgor
ICogb3IgTlVMIGJlZm9yZSB0aGUgZW5kLgorICovCitzdGF0aWMgaW5saW5lIGJvb2wgdGFic3Bj
KGNoYXIgYykgeyByZXR1cm4gYyA9PSAnICcgfHwgYyA9PSAnXHQnOyB9CitzdGF0aWMgaW5saW5l
IGJvb2wgbm9fdGFiX29yX3NwYWNlKGNvbnN0IGNoYXIgKmZpcnN0LCBjb25zdCBjaGFyICpsYXN0
KQoreworCS8vIFNraXAgbGVhZGluZyBzcGFjZQorCWZvciAoO3RhYnNwYygqZmlyc3QpIDsgZmly
c3QrKykKKwkJaWYgKCEqZmlyc3QgfHwgZmlyc3QgPT0gbGFzdCkKKwkJCXJldHVybiBmYWxzZTsJ
Ly8gb25seSBzcGFjZQorCS8vIE9rLCAnZmlyc3QnIHBvaW50cyB0byBmaXJzdCBub24tc3BjL3Rh
Yi9OVUwKKwkvLyBDYW4gd2UgZmluZCBhbm90aGVyIHRlcm1pbmF0b3IgYWZ0ZXIgdGhpcz8KKwl3
aGlsZSAoKytmaXJzdCA8PSBsYXN0KQorCQlpZiAoISpmaXJzdCB8fCB0YWJzcGMoKmZpcnN0KSkK
KwkJCXJldHVybiB0cnVlOworCXJldHVybiBmYWxzZTsKK30KKwogc3RhdGljIGludCBsb2FkX3Nj
cmlwdChzdHJ1Y3QgbGludXhfYmlucHJtICpicHJtKQogewogCWNvbnN0IGNoYXIgKmlfYXJnLCAq
aV9uYW1lOwpAQCAtNDIsOSArNjUsMTIgQEAgc3RhdGljIGludCBsb2FkX3NjcmlwdChzdHJ1Y3Qg
bGludXhfYmlucHJtICpicHJtKQogCWZwdXQoYnBybS0+ZmlsZSk7CiAJYnBybS0+ZmlsZSA9IE5V
TEw7CiAKLQlicHJtLT5idWZbQklOUFJNX0JVRl9TSVpFIC0gMV0gPSAnXDAnOwotCWlmICgoY3Ag
PSBzdHJjaHIoYnBybS0+YnVmLCAnXG4nKSkgPT0gTlVMTCkKKwljcCA9IHN0cm5jaHIoYnBybS0+
YnVmLCBCSU5QUk1fQlVGX1NJWkUsICdcbicpOworCWlmICghY3ApIHsKIAkJY3AgPSBicHJtLT5i
dWYrQklOUFJNX0JVRl9TSVpFLTE7CisJCWlmIChub190YWJfb3Jfc3BhY2UoYnBybS0+YnVmKzIs
IGNwKSkKKwkJCXJldHVybiAtRU5PRVhFQzsKKwl9CiAJKmNwID0gJ1wwJzsKIAl3aGlsZSAoY3Ag
PiBicHJtLT5idWYpIHsKIAkJY3AtLTsK
--000000000000adb93e0581f16c44--
