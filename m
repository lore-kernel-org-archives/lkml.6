Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 54DD4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:18:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F28FD20891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 02:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="YGE+tol+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F28FD20891
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933443AbeFMCSl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 22:18:41 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:39954 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932661AbeFMCSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 22:18:39 -0400
Received: by mail-it0-f65.google.com with SMTP id 188-v6so1889053ita.5;
        Tue, 12 Jun 2018 19:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5VE1E1rfk1aKH2aq0M3Nk0RDGajXjvzg4Xctr1+hLhE=;
        b=YGE+tol+kxh6hRKP2rfFJZIP/hWAZZAUEE7oj4PUu4sHVMfcbNbexqYaD7/ylwgLk5
         /nmLSj+3FAtPGLacFLfhAWSxF/x7DxVq3FjDxWmIyociAtuJnur0U+H4cQxk/qJtRESE
         Up1Q8h9Ox/B5fY5XayJQTy6KAoRZpFYE9rPpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5VE1E1rfk1aKH2aq0M3Nk0RDGajXjvzg4Xctr1+hLhE=;
        b=ZVBG8QU79kwwDauOOcd2bdR53MU7L3m1rnVTgsm7QVDpG98WLZRb2aG4qknpwb5BAX
         8ZdPB53+pIihvS3MIUV1sFT6xLabfPXkv2ncRBp6k2hMdqGLecvwPIb9oHMCmyVin7PU
         fgBQZeHVyWR76p/W9220T1Pea0pPTCcBAAI95OSOUWiJRajUzDjCJjLQtEZL8nDI622V
         gCcF2JDPsYeL+0Ck+XnCFolTV1AZJZS/F5o8PCzLtxCtKTTwkiPuX+lU5RCdbeSDfpm2
         2zaeCHtHSFYD/5rJszM7Hojxwj+UaMgc0JYaNVvzspFkSh+rowogPXHAvFAS2TNn73vv
         ghoA==
X-Gm-Message-State: APt69E0r5AGqd45/261KBupOyIMsg7cwyn9WHhC4dwz5vwlPGbGG+i5o
        eJl0mbraM4mwOg5YvziXwg0T0s+/5GFOIlFtM+KPMz3H
X-Google-Smtp-Source: ADUXVKJOTGZLf37AOn2pIuxkVxn4VCasmMCSSAw7MRqzRdcLi16CyjMLDOXwqq0UVeCKVsnTPAZinMakRDBbUvumt6M=
X-Received: by 2002:a24:3cd7:: with SMTP id m206-v6mr2806926ita.113.1528856318658;
 Tue, 12 Jun 2018 19:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1528812229-53043-1-git-send-email-pbonzini@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 12 Jun 2018 19:18:27 -0700
Message-ID: <CA+55aFwvE5G7MV7AV4naAXdbFoszc4JNKEj_QtYqpLFfa2RXtA@mail.gmail.com>
Subject: Re: [GIT PULL] KVM changes for 4.18 merge window
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        KVM list <kvm@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c975d1056e7c99dd"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c975d1056e7c99dd
Content-Type: text/plain; charset="UTF-8"

On Tue, Jun 12, 2018 at 7:03 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> * x86: many bugfixes, implement more Hyper-V super powers,

Uhhuh, I didn't notice this initially, because my basic sanity tests
are with everything enabled, but this breaks the build:

  ERROR: "ms_hyperv" [arch/x86/kvm/kvm-intel.ko] undefined!

The attached patch _may_ be the right thing to do. It's not pretty.

Hmm? And why was this not found before it hit my tree?

                  Linus

--000000000000c975d1056e7c99dd
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jichjl3d0>
X-Attachment-Id: f_jichjl3d0

IGFyY2gveDg2L2t2bS92bXguYyB8IDMgKysrCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspCgpkaWZmIC0tZ2l0IGEvYXJjaC94ODYva3ZtL3ZteC5jIGIvYXJjaC94ODYva3ZtL3ZteC5j
CmluZGV4IGZjNjFlMjU5NjZlNC4uZDBkZDM1ZDU4MmRhIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9r
dm0vdm14LmMKKysrIGIvYXJjaC94ODYva3ZtL3ZteC5jCkBAIC00NDI5LDYgKzQ0MjksNyBAQCBz
dGF0aWMgaW50IGFsbG9jX2xvYWRlZF92bWNzKHN0cnVjdCBsb2FkZWRfdm1jcyAqbG9hZGVkX3Zt
Y3MpCiAJCQlnb3RvIG91dF92bWNzOwogCQltZW1zZXQobG9hZGVkX3ZtY3MtPm1zcl9iaXRtYXAs
IDB4ZmYsIFBBR0VfU0laRSk7CiAKKyNpZiBJU19FTkFCTEVEKENPTkZJR19IWVBFUlYpCiAJCWlm
IChzdGF0aWNfYnJhbmNoX3VubGlrZWx5KCZlbmFibGVfZXZtY3MpICYmCiAJCSAgICAobXNfaHlw
ZXJ2Lm5lc3RlZF9mZWF0dXJlcyAmIEhWX1g2NF9ORVNURURfTVNSX0JJVE1BUCkpIHsKIAkJCXN0
cnVjdCBodl9lbmxpZ2h0ZW5lZF92bWNzICpldm1jcyA9CkBAIC00NDM2LDYgKzQ0MzcsOCBAQCBz
dGF0aWMgaW50IGFsbG9jX2xvYWRlZF92bWNzKHN0cnVjdCBsb2FkZWRfdm1jcyAqbG9hZGVkX3Zt
Y3MpCiAKIAkJCWV2bWNzLT5odl9lbmxpZ2h0ZW5tZW50c19jb250cm9sLm1zcl9iaXRtYXAgPSAx
OwogCQl9CisjZW5kaWYKKwogCX0KIAlyZXR1cm4gMDsKIAo=
--000000000000c975d1056e7c99dd--
