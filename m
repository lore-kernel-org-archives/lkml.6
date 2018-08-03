Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AA8C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99F9A21748
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 19:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HK8O/k+C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99F9A21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729917AbeHCVT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 17:19:59 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:45073 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727953AbeHCVT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 17:19:58 -0400
Received: by mail-io0-f169.google.com with SMTP id k16-v6so5859670iom.12;
        Fri, 03 Aug 2018 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vfiHaVFlxYbn9LOEqSawD9VRCaWcCmA/H4BId/qNLzg=;
        b=HK8O/k+Cj6wg6YZSKUdQ5D1O4XOD2Pwxrx3+2h1UlnK4GZqxIoX+JxcIfTwo9qU7qT
         OCGfG3RGot7ARzKiOg9mncOopKajjByV/fvMOJefBNF3gYFG/nCoN9xKT0gP4YabfEdw
         fc5XnuAXeLLNaiYyTgZhk1rl60CKqDGhrQ3LA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vfiHaVFlxYbn9LOEqSawD9VRCaWcCmA/H4BId/qNLzg=;
        b=jO27bp7nrU65x/35rfd2DsJVoKFYTww4LcllAi35oN+2LA7caJIxT7XM3orA3A7if3
         0m8mGxQoBVqtGxC0l+Q/Ca5EZPdtDRPpqhAhFLzRqOgEClyN0Du+luUSFteKKtaoIJT4
         VUiFLaDOiZt1XSmGNWo4OzC9CfEX+oX5W05bqlt7nm2P85DAoXSlSuPm5zGcZv+Jtqp2
         /MIZmKc8xmPhF5nlYS+Fr3CxY9jA2n9ey0QM0zzL1/qqpDYpn+z56wbEf5Yoh7fqW/fZ
         BmLk1K0LpJev1addtj7jfPpNq+wBvX315YVDafBL9bzfyC9Pfzw5PR/iEVdTgUNnIO1X
         Zw0A==
X-Gm-Message-State: AOUpUlFib010XEeC+URvIbZwo75NRU+9CPN/Ik7sRRb5YxH4FgqekTsI
        GodE4Y7AMn7/xOVVBcpkKclk0KtJX/+vSWn0EsQ=
X-Google-Smtp-Source: AA+uWPyUWdlulDuL4ZWZd2zWs8K4vR+5BlnHuNSCEKX9bLW6WDCdAT0vScR3YMZp/2SBI4aQ6OmpUDf/FwVkwvWr+Uc=
X-Received: by 2002:a6b:7a05:: with SMTP id h5-v6mr7541015iom.238.1533324141184;
 Fri, 03 Aug 2018 12:22:21 -0700 (PDT)
MIME-Version: 1.0
References: <CA+55aFyAox9BTDpRsqLXiROhHOX60aa45LEZ7Azteaumdu11Fw@mail.gmail.com>
 <CAOi1vP-SJO4AMK=XD3Lmja++2dQqoiw6Zn8Vgxf8OfvYgnuC6Q@mail.gmail.com>
 <CA+55aFy2DR9fxHhmGq+azSjX9D71YtLsuFKmoEuYW3uTAUYtJg@mail.gmail.com>
 <d76415de-2056-c7d6-cc88-b896deaa8ead@torlan.ru> <1ec0a220-d5b0-1c27-e63b-c4d3f4ce9d77@torlan.ru>
 <CA+55aFyPVQ5-gA93irsaxPC9BNQxnGWrDDHPMUYai2kxKiaKWQ@mail.gmail.com>
 <20180803133102.GA3092@redhat.com> <20180803152034.GD32066@thunk.org>
 <20180803183932.GA3258@redhat.com> <CA+55aFwGGjs_imFFkEPJ4g99Kseam=4Qppv4G6Q=ZfZXdzF7Vw@mail.gmail.com>
 <20180803190617.GA4498@redhat.com>
In-Reply-To: <20180803190617.GA4498@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 12:22:09 -0700
Message-ID: <CA+55aFzSM6qhZpM4CCpRNR_LWNCbLyRtQQ3hnPwnRrBdDkwWUw@mail.gmail.com>
Subject: Re: LVM snapshot broke between 4.14 and 4.16
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Jens Axboe <axboe@kernel.dk>,
        Sagi Grimberg <sagi@grimberg.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>, dm-devel@redhat.com,
        Ilya Dryomov <idryomov@gmail.com>, wgh@torlan.ru,
        Zdenek Kabelac <zkabelac@redhat.com>
Content-Type: multipart/mixed; boundary="000000000000c3424e05728cd81d"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000c3424e05728cd81d
Content-Type: text/plain; charset="UTF-8"

On Fri, Aug 3, 2018 at 12:06 PM Mike Snitzer <snitzer@redhat.com> wrote:
>
> How does that pass for a fix to this issue?
>
> That'll unilaterally mark all dm device's readonly.

Well, if it wasn't honored before anyway, then...

But yes, a much more targeted patch would be preferred.

And in fact, maybe the right thing to do is to not revert the original
commit entirely, but instead just weaken it a lot. Turn the "you did a
write request on a RO disk" into a WARN_ON_ONCE() instead of a hard
error.

Something like the attached patch.

WGH, do you build your own kernels? Does this attached (untested)
patch make things work for you? It should give a big warning, but let
the old behavior through..

                    Linus

--000000000000c3424e05728cd81d
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jkedkspc0>
X-Attachment-Id: f_jkedkspc0

IGJsb2NrL2Jsay1jb3JlLmMgfCA1ICsrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25z
KCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Jsb2NrL2Jsay1jb3JlLmMgYi9ibG9j
ay9ibGstY29yZS5jCmluZGV4IGY4NGE5YjdiNmY1YS4uOTVjYTQ1YmM0ZmM5IDEwMDY0NAotLS0g
YS9ibG9jay9ibGstY29yZS5jCisrKyBiL2Jsb2NrL2Jsay1jb3JlLmMKQEAgLTIxNTUsMTEgKzIx
NTUsMTIgQEAgc3RhdGljIGlubGluZSBib29sIGJpb19jaGVja19ybyhzdHJ1Y3QgYmlvICpiaW8s
IHN0cnVjdCBoZF9zdHJ1Y3QgKnBhcnQpCiAJaWYgKHBhcnQtPnBvbGljeSAmJiBvcF9pc193cml0
ZShiaW9fb3AoYmlvKSkpIHsKIAkJY2hhciBiW0JERVZOQU1FX1NJWkVdOwogCi0JCXByaW50ayhL
RVJOX0VSUgorCQlXQVJOX09OQ0UoCiAJCSAgICAgICAiZ2VuZXJpY19tYWtlX3JlcXVlc3Q6IFRy
eWluZyB0byB3cml0ZSAiCiAJCQkidG8gcmVhZC1vbmx5IGJsb2NrLWRldmljZSAlcyAocGFydG5v
ICVkKVxuIiwKIAkJCWJpb19kZXZuYW1lKGJpbywgYiksIHBhcnQtPnBhcnRubyk7Ci0JCXJldHVy
biB0cnVlOworCQkvKiBPbGRlciBsdm0tdG9vbHMgYWN0dWFsbHkgdHJpZ2dlciB0aGlzICovCisJ
CXJldHVybiBmYWxzZTsKIAl9CiAKIAlyZXR1cm4gZmFsc2U7Cg==
--000000000000c3424e05728cd81d--
