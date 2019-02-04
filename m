Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E691AC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B582081B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ksGUQxSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbfBDKMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:12:53 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:42379 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726928AbfBDKMw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:12:52 -0500
Received: by mail-yw1-f65.google.com with SMTP id v201so460862ywa.9;
        Mon, 04 Feb 2019 02:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O4BKZSEhECy32OYAKqpevcOi5Jdx4MPeDb0IAIegxIk=;
        b=ksGUQxSuPZPGd5mfm9hKHA0UYCdFwX3YxKl7CYs6/3hGQijNipDu4jFXB5qT8adGGE
         7EVECF0tP5KtasE8VMhLS0mH4mA+MvnmDagngDDDEHAcpt3DifLNiM917aLf4fHAX/1A
         jL7Ynv9l4dZVmeKy5Dijjx5XF5vRfnJJKnGcYsLAHyWAfMk6Zo/q3s+aTjHfSTaPPwyD
         RsE7nEsha8xr/CrNR8LUlLNGbm4wd1pBZ2YoVZ7V3K+nqIGtI/+df4X0l0E6lPGWi7FV
         4JzK6DL11jFZee07vcuWYX2yemQpAcm10Pe60Qc4IzqHJ05khY/i2y/E6462z93vWWlX
         4/2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O4BKZSEhECy32OYAKqpevcOi5Jdx4MPeDb0IAIegxIk=;
        b=ILNqHmXopveJ82A/LvFMldk1z7yms4f/c4PZ8bByKaaHzRsR+ze51u9on6vo0vOceM
         izZ5jHxzjQ+HrQycBLa95fLOzI8IuLkqcFsjeXYJD3dNIhG6EDVsIIQKT2z+2Zu6Xy+9
         sV0mXwKfqBlesM/yZoklA4QicRuLSHqwQ87T5mdvawsyiZXXqCTmC9eUasmBGTlZ/Mhh
         s9E4rFOAbai1sbFy7hXnEIEuMeNGsWPp8WGLnXeWy6u97a4FjMcOSKlH69wQ+pkW2Y9V
         543QsOhSno3qNHeqmg9xNbAYmIfpAg0vb6i6TZZxf0LnIk9GhguKm3v4ebkM4aW2Trda
         oPPA==
X-Gm-Message-State: AHQUAubnPwtfnioSb3zThlw8h2oW2cR6b5v2yYq5/Yqq5hHNRC9RkZ3Y
        TRticPqi+cBS1y8eQs0NNXT/veu8weZyq46+bA0=
X-Google-Smtp-Source: AHgI3IYRucTa4rCj2H/nJ7s0X5iSEQSdJYE4wZwijUXs4YezCNHYakLMHjKyiDb/H3d2a5vXZWQHLQVtBbsRkui6UDE=
X-Received: by 2002:a0d:e741:: with SMTP id q62mr6034826ywe.34.1549275171245;
 Mon, 04 Feb 2019 02:12:51 -0800 (PST)
MIME-Version: 1.0
References: <20190129113131.751891514@linuxfoundation.org> <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
 <CAOQ4uxiZ2ZPfcVNSX64ZD_JqQuBwz45_WAoNjpYEhfvTuHgZHQ@mail.gmail.com> <20190130193223.GA20667@kroah.com>
In-Reply-To: <20190130193223.GA20667@kroah.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 4 Feb 2019 12:12:39 +0200
Message-ID: <CAOQ4uxhVqttqKDyJjqe-F5JV7_LLcSUP+Xao+WYRDM4azt_4NQ@mail.gmail.com>
Subject: Re: [PATCH 4.14 00/68] 4.14.97-stable review
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>, ltp@lists.linux.it,
        open list <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        lkft-triage@lists.linaro.org,
        linux- stable <stable@vger.kernel.org>,
        chrubis <chrubis@suse.cz>
Content-Type: multipart/mixed; boundary="0000000000003df59c05810ebcd6"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000003df59c05810ebcd6
Content-Type: text/plain; charset="UTF-8"

> > > fanotify09 failed on arm64 devices running 4.14 version kernel
> > > fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
> > > https://bugs.linaro.org/show_bug.cgi?id=4271
> > >
> >
> > fanotify09 was added a new regression test case for commit
> >   b469e7e47c8a: fanotify: fix handling of events on child sub-directory
> >
> > That commit was backported to v4.19. As I wrote in "backport hint", the bug
> > exists in older kernels, but fix does not apply cleanly to older kernels.
>
> If someone were to provide a tested backport to 4.14 and older, I'll be
> glad to queue it up (hint hint hint...)
>

Attached backport applies and tested on 4.14 and 4.9

Thanks,
Amir.

--0000000000003df59c05810ebcd6
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="stable-4.9-fanotify-fix-handling-of-events-on-child-sub-directo.patch"
Content-Disposition: attachment; 
	filename="stable-4.9-fanotify-fix-handling-of-events-on-child-sub-directo.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jrq69tp30>
X-Attachment-Id: f_jrq69tp30

RnJvbSA2OWYzNjRiZDE0MjFkN2U3OWI2M2U2MmNmZDdlYTYwNDQyNDliY2VmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwuY29tPgpE
YXRlOiBUdWUsIDMwIE9jdCAyMDE4IDIwOjI5OjUzICswMjAwClN1YmplY3Q6IFtQQVRDSF0gZmFu
b3RpZnk6IGZpeCBoYW5kbGluZyBvZiBldmVudHMgb24gY2hpbGQgc3ViLWRpcmVjdG9yeQoKY29t
bWl0IGI0NjllN2U0N2M4YTA3NWNjMDhiY2QxZTg1ZDQzNjUxMzRiZGNkZDUgdXBzdHJlYW0uCgpX
aGVuIGFuIGV2ZW50IGlzIHJlcG9ydGVkIG9uIGEgc3ViLWRpcmVjdG9yeSBhbmQgdGhlIHBhcmVu
dCBpbm9kZSBoYXMKYSBtYXJrIG1hc2sgd2l0aCBGU19FVkVOVF9PTl9DSElMRHxGU19JU0RJUiwg
dGhlIGV2ZW50IHdpbGwgYmUgc2VudCB0bwpmc25vdGlmeSgpIGV2ZW4gaWYgdGhlIGV2ZW50IHR5
cGUgaXMgbm90IGluIHRoZSBwYXJlbnQgbWFyayBtYXNrCihlLmcuIEZTX09QRU4pLgoKRnVydGhl
ciBtb3JlLCBpZiB0aGF0IGV2ZW50IGhhcHBlbmVkIG9uIGEgbW91bnQgb3IgYSBmaWxlc3lzdGVt
IHdpdGgKYSBtb3VudCBtYXJrIHRoYXQgZG9lcyBoYXZlIHRoYXQgZXZlbnQgdHlwZSBpbiB0aGVp
ciBtYXNrLCB0aGUgIm9uCmNoaWxkIiBldmVudCB3aWxsIGJlIHJlcG9ydGVkIG9uIHRoZSBtb3Vu
dCBtYXJrLiAgVGhhdCBpcyBub3QKZGVzaXJlZCwgYmVjYXVzZSB1c2VyIHdpbGwgZ2V0IGEgZHVw
bGljYXRlIGV2ZW50IGZvciB0aGUgc2FtZSBhY3Rpb24uCgpOb3RlIHRoYXQgdGhlIGV2ZW50IHJl
cG9ydGVkIG9uIHRoZSB2aWN0aW0gaW5vZGUgaXMgbmV2ZXIgbWVyZ2VkIHdpdGgKdGhlIGV2ZW50
IHJlcG9ydGVkIG9uIHRoZSBwYXJlbnQgaW5vZGUsIGJlY2F1c2Ugb2YgdGhlIGNoZWNrIGluCnNo
b3VsZF9tZXJnZSgpOiBvbGRfZnNuLT5pbm9kZSA9PSBuZXdfZnNuLT5pbm9kZS4KCkZpeCB0aGlz
IGJ5IGxvb2tpbmcgZm9yIGEgbWF0Y2ggb2YgYW4gYWN0dWFsIGV2ZW50IHR5cGUgKGkuZS4gbm90
IGp1c3QKRlNfSVNESVIpIGluIHBhcmVudCdzIGlub2RlIG1hcmsgbWFzayBhbmQgYnkgbm90IHJl
cG9ydGluZyBhbiAib24gY2hpbGQiCmV2ZW50IHRvIGdyb3VwIGlmIGV2ZW50IHR5cGUgaXMgb25s
eSBmb3VuZCBvbiBtb3VudCBtYXJrcy4KCkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KU2ln
bmVkLW9mZi1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3M2lsQGdtYWlsLmNvbT4KU2lnbmVkLW9m
Zi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KW2FtaXI6IGJhY2twb3J0IHRvIHY0LjldClNp
Z25lZC1vZmYtYnk6IEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+Ci0tLQogZnMv
bm90aWZ5L2Zzbm90aWZ5LmMgfCA4ICsrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRp
b25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL25vdGlmeS9mc25vdGlmeS5j
IGIvZnMvbm90aWZ5L2Zzbm90aWZ5LmMKaW5kZXggYTY0YWRjMmZjZWQ5Li41NmI0Zjg1NWZhOWIg
MTAwNjQ0Ci0tLSBhL2ZzL25vdGlmeS9mc25vdGlmeS5jCisrKyBiL2ZzL25vdGlmeS9mc25vdGlm
eS5jCkBAIC0xMDEsOSArMTAxLDkgQEAgaW50IF9fZnNub3RpZnlfcGFyZW50KHN0cnVjdCBwYXRo
ICpwYXRoLCBzdHJ1Y3QgZGVudHJ5ICpkZW50cnksIF9fdTMyIG1hc2spCiAJcGFyZW50ID0gZGdl
dF9wYXJlbnQoZGVudHJ5KTsKIAlwX2lub2RlID0gcGFyZW50LT5kX2lub2RlOwogCi0JaWYgKHVu
bGlrZWx5KCFmc25vdGlmeV9pbm9kZV93YXRjaGVzX2NoaWxkcmVuKHBfaW5vZGUpKSkKKwlpZiAo
dW5saWtlbHkoIWZzbm90aWZ5X2lub2RlX3dhdGNoZXNfY2hpbGRyZW4ocF9pbm9kZSkpKSB7CiAJ
CV9fZnNub3RpZnlfdXBkYXRlX2NoaWxkX2RlbnRyeV9mbGFncyhwX2lub2RlKTsKLQllbHNlIGlm
IChwX2lub2RlLT5pX2Zzbm90aWZ5X21hc2sgJiBtYXNrKSB7CisJfSBlbHNlIGlmIChwX2lub2Rl
LT5pX2Zzbm90aWZ5X21hc2sgJiBtYXNrICYgfkZTX0VWRU5UX09OX0NISUxEKSB7CiAJCXN0cnVj
dCBuYW1lX3NuYXBzaG90IG5hbWU7CiAKIAkJLyogd2UgYXJlIG5vdGlmeWluZyBhIHBhcmVudCBz
byBjb21lIHVwIHdpdGggdGhlIG5ldyBtYXNrIHdoaWNoCkBAIC0yMDcsNiArMjA3LDEwIEBAIGlu
dCBmc25vdGlmeShzdHJ1Y3QgaW5vZGUgKnRvX3RlbGwsIF9fdTMyIG1hc2ssIHZvaWQgKmRhdGEs
IGludCBkYXRhX2lzLAogCWVsc2UKIAkJbW50ID0gTlVMTDsKIAorCS8qIEFuIGV2ZW50ICJvbiBj
aGlsZCIgaXMgbm90IGludGVuZGVkIGZvciBhIG1vdW50IG1hcmsgKi8KKwlpZiAobWFzayAmIEZT
X0VWRU5UX09OX0NISUxEKQorCQltbnQgPSBOVUxMOworCiAJLyoKIAkgKiBPcHRpbWl6YXRpb246
IHNyY3VfcmVhZF9sb2NrKCkgaGFzIGEgbWVtb3J5IGJhcnJpZXIgd2hpY2ggY2FuCiAJICogYmUg
ZXhwZW5zaXZlLiAgSXQgcHJvdGVjdHMgd2Fsa2luZyB0aGUgKl9mc25vdGlmeV9tYXJrcyBsaXN0
cy4KLS0gCjIuNy40Cgo=
--0000000000003df59c05810ebcd6--
