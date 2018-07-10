Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DB7C5CFEB
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:41:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30FE52064D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 00:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Pup+Aggq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30FE52064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754639AbeGJAlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 20:41:53 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:35920 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754582AbeGJAlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 20:41:46 -0400
Received: by mail-io0-f196.google.com with SMTP id k3-v6so18749544iog.3;
        Mon, 09 Jul 2018 17:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IwSpVBpE0y2egaTgMUoAQt0MBSbqtHckdzgevhex1qo=;
        b=Pup+Aggqifwgt2WYJR5e6rVLfy4DqbietT6B2bCeKhXgoQ/kH6i5HR4j4gTWs5VVz8
         EmrOeqcU492fXawEyfTVDNZl5tPbJL7AjLtO7zwL6FMZwu+1Wz8uat89NeZCE4z3MBhh
         /tnLYRvTl/Iee7jW9MKubmMalRt2KuRWSD9pQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IwSpVBpE0y2egaTgMUoAQt0MBSbqtHckdzgevhex1qo=;
        b=Bt+g9oWWvoLM3cv3rjL+9oyveq/RFkqnMJynaCNEW5NkCqxS08J7hOZ5Y9uusLiFVC
         AnIkzYvDLw3Lz42RAh8FYC+e7cqQnJdGu63Q/7kAQ8lt7+u9lFwqrlv/2I8xzcQiRkrP
         0lpjrHsHqhlwRudUwHhF2c1NWyZSScA7lCmctKqMy5yhfUnD/fz0FgYCC+hQ/QCepd0z
         dynOAat60/DMuQteoztwHsX08eTZb3I04cVIthZZdQ1HUOAfz0mfXJY9WxlfRAhuQ8tz
         KH9GI6Bz0Eom9xoG9Dl1ApIcDGzYzZv0fd4kz68U0zK5vO1PYD3yn18H2yiSBHTvpMVe
         wGFw==
X-Gm-Message-State: APt69E0UrKqjrLD4wlMpIy9ux1TkScg9Yv6+puQPv9NcxMIbBpPyCmxk
        +v0pm7r1Zpv+UJuzTCuJXFd5y3r7uoHe97oZvc8=
X-Google-Smtp-Source: AAOMgpe1oZlJZ/ZkIQgyCfh036CM7qb6f8Q2HeBdRBiTOw5cDobowCi+d7jw+e9r3PSzhrUJWVw3HeU2TfxBWroX6DI=
X-Received: by 2002:a6b:1502:: with SMTP id 2-v6mr20153538iov.203.1531183305992;
 Mon, 09 Jul 2018 17:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <1530913134.3135.2.camel@HansenPartnership.com>
 <CA+55aFy-o3fRtkQnJU=0zv7CPUtgfKiwhfQi_05K25Y_-mx+_w@mail.gmail.com>
 <CA+55aFxQ8QzGTWsVdVQVok9cLbgZDFjG2g3JZtWJd+G9jHkYoQ@mail.gmail.com>
 <CA+55aFxAy__3hE1OoUFPKZfptLT1cXuoujsnSGXBMzJPQ+Qjzg@mail.gmail.com> <1530940958.3135.4.camel@HansenPartnership.com>
In-Reply-To: <1530940958.3135.4.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 9 Jul 2018 17:41:34 -0700
Message-ID: <CA+55aFwg-2GP4ASTdd1pusmZkF7c8AN9febVDCaioDxzYJSLfw@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 4.18-rc3
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000a608f05709a656b"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000000a608f05709a656b
Content-Type: text/plain; charset="UTF-8"

On Fri, Jul 6, 2018 at 10:22 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> We did discuss removing the r/w interface, but, as you say, it's been
> around for ages so it's not clear what regressions would surface if we
> did.

So since nobody else followed up on this, the attached patch is what I
was thinking of just committing.

It removes the warnings from the access check, and just puts them
(unconditionally) at the top of the read/write function instead.

Hmm?

                 Linus

--0000000000000a608f05709a656b
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jjeyztoj0>
X-Attachment-Id: f_jjeyztoj0

IGRyaXZlcnMvc2NzaS9zZy5jIHwgMjIgKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDExIGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvc2NzaS9zZy5jIGIvZHJpdmVycy9zY3NpL3NnLmMKaW5kZXggY2QyZmRhYzAwMGM5Li4w
OTMyNWI4ZmJjOWYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9zZy5jCisrKyBiL2RyaXZlcnMv
c2NzaS9zZy5jCkBAIC0yMjIsMTggKzIyMiwxMiBAQCBzdGF0aWMgdm9pZCBzZ19kZXZpY2VfZGVz
dHJveShzdHJ1Y3Qga3JlZiAqa3JlZik7CiAgKiBUaGlzIGZ1bmN0aW9uIHByb3ZpZGVzIHByb3Rl
Y3Rpb24gZm9yIHRoZSBsZWdhY3kgQVBJIGJ5IHJlc3RyaWN0aW5nIHRoZQogICogY2FsbGluZyBj
b250ZXh0LgogICovCi1zdGF0aWMgaW50IHNnX2NoZWNrX2ZpbGVfYWNjZXNzKHN0cnVjdCBmaWxl
ICpmaWxwLCBjb25zdCBjaGFyICpjYWxsZXIpCitzdGF0aWMgaW50IHNnX2NoZWNrX2ZpbGVfYWNj
ZXNzKHN0cnVjdCBmaWxlICpmaWxwKQogewotCWlmIChmaWxwLT5mX2NyZWQgIT0gY3VycmVudF9y
ZWFsX2NyZWQoKSkgewotCQlwcl9lcnJfb25jZSgiJXM6IHByb2Nlc3MgJWQgKCVzKSBjaGFuZ2Vk
IHNlY3VyaXR5IGNvbnRleHRzIGFmdGVyIG9wZW5pbmcgZmlsZSBkZXNjcmlwdG9yLCB0aGlzIGlz
IG5vdCBhbGxvd2VkLlxuIiwKLQkJCWNhbGxlciwgdGFza190Z2lkX3ZucihjdXJyZW50KSwgY3Vy
cmVudC0+Y29tbSk7CisJaWYgKGZpbHAtPmZfY3JlZCAhPSBjdXJyZW50X3JlYWxfY3JlZCgpKQog
CQlyZXR1cm4gLUVQRVJNOwotCX0KLQlpZiAodWFjY2Vzc19rZXJuZWwoKSkgewotCQlwcl9lcnJf
b25jZSgiJXM6IHByb2Nlc3MgJWQgKCVzKSBjYWxsZWQgZnJvbSBrZXJuZWwgY29udGV4dCwgdGhp
cyBpcyBub3QgYWxsb3dlZC5cbiIsCi0JCQljYWxsZXIsIHRhc2tfdGdpZF92bnIoY3VycmVudCks
IGN1cnJlbnQtPmNvbW0pOworCWlmICh1YWNjZXNzX2tlcm5lbCgpKQogCQlyZXR1cm4gLUVBQ0NF
UzsKLQl9CiAJcmV0dXJuIDA7CiB9CiAKQEAgLTQyMSwxMSArNDE1LDE0IEBAIHNnX3JlYWQoc3Ry
dWN0IGZpbGUgKmZpbHAsIGNoYXIgX191c2VyICpidWYsIHNpemVfdCBjb3VudCwgbG9mZl90ICog
cHBvcykKIAlzdHJ1Y3Qgc2dfaGVhZGVyICpvbGRfaGRyID0gTlVMTDsKIAlpbnQgcmV0dmFsID0g
MDsKIAorCXByX2Vycl9vbmNlKCJwcm9jZXNzICVkICglcykgZG9lcyBkaXJlY3QgcmVhZCBvbiAv
ZGV2L3NnIiwKKwkJdGFza190Z2lkX3ZucihjdXJyZW50KSwgY3VycmVudC0+Y29tbSk7CisKIAkv
KgogCSAqIFRoaXMgY291bGQgY2F1c2UgYSByZXNwb25zZSB0byBiZSBzdHJhbmRlZC4gQ2xvc2Ug
dGhlIGFzc29jaWF0ZWQKIAkgKiBmaWxlIGRlc2NyaXB0b3IgdG8gZnJlZSB1cCBhbnkgcmVzb3Vy
Y2VzIGJlaW5nIGhlbGQuCiAJICovCi0JcmV0dmFsID0gc2dfY2hlY2tfZmlsZV9hY2Nlc3MoZmls
cCwgX19mdW5jX18pOworCXJldHZhbCA9IHNnX2NoZWNrX2ZpbGVfYWNjZXNzKGZpbHApOwogCWlm
IChyZXR2YWwpCiAJCXJldHVybiByZXR2YWw7CiAKQEAgLTYxOCw3ICs2MTUsMTAgQEAgc2dfd3Jp
dGUoc3RydWN0IGZpbGUgKmZpbHAsIGNvbnN0IGNoYXIgX191c2VyICpidWYsIHNpemVfdCBjb3Vu
dCwgbG9mZl90ICogcHBvcykKIAl1bnNpZ25lZCBjaGFyIGNtbmRbU0dfTUFYX0NEQl9TSVpFXTsK
IAlpbnQgcmV0dmFsOwogCi0JcmV0dmFsID0gc2dfY2hlY2tfZmlsZV9hY2Nlc3MoZmlscCwgX19m
dW5jX18pOworCXByX2Vycl9vbmNlKCJwcm9jZXNzICVkICglcykgZG9lcyBkaXJlY3Qgd3JpdGUg
b24gL2Rldi9zZyIsCisJCXRhc2tfdGdpZF92bnIoY3VycmVudCksIGN1cnJlbnQtPmNvbW0pOwor
CisJcmV0dmFsID0gc2dfY2hlY2tfZmlsZV9hY2Nlc3MoZmlscCk7CiAJaWYgKHJldHZhbCkKIAkJ
cmV0dXJuIHJldHZhbDsKIAo=
--0000000000000a608f05709a656b--
