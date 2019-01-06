Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E6EC43444
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:51:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF720222CC
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 01:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Um4YEyAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726405AbfAFBvX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 20:51:23 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41321 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726377AbfAFBvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 20:51:22 -0500
Received: by mail-lf1-f66.google.com with SMTP id c16so27835300lfj.8
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 17:51:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcswdOBczXk+iMEaWZLv2123bIfAtssmPcZQKRLxpec=;
        b=Um4YEyAt8jYVvSh/qfFiqPF+GCGUMUEdHNIOKX3UpSSg+Jiiq+gkn8CZUF4jdBJxd5
         ZcIyf17YCpILnvKPAgOoflI/KyDQRA5TVSSZoMnoaUCNfSp9CUyGyNuqDxtLhGzrhKXo
         B7zTL8Hn+Ok5KsEFJHpktWBjGUYOLesmk/W0o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcswdOBczXk+iMEaWZLv2123bIfAtssmPcZQKRLxpec=;
        b=nSrO/JVME32GYDhbr1rkUodQ2el8eu/vDPQnEts6BzyCeLrX5QiVqUHc3pquA/gPHC
         dYlFgzyGfY7SeC0SNqtKdzII7kJLxzlM1/rKU1GRfV8nJRvG1shaen9+joOKRJE6+gko
         WyJkcg+Ej9eEBlLdBk3HiArfCdyJb9nQn7Jojqfgvm82IC445wT112i1MAuJ0UHfozb7
         oedO/F4dBqvdH0Dq4EGDGBd7IIzpntQ9WJCvnrqqAIa+Ujc/40U5vN6dn8Ls26sb26CD
         nj9wEuKSFHuznVag4/92i7Sy2j03bzBXbuBsBPw53NCaoRTyOWdBJHuUxlo5BaaBu6Gb
         yr3A==
X-Gm-Message-State: AA+aEWYGiSvSFykULRalJA1QZg7U9slXUiLSgfgl5QzYF+UX9BFRoEaQ
        gq/YPnOXLT9xeYwlo8La9EF9qRr4ih4=
X-Google-Smtp-Source: AFSGD/VUjSMkWayynn/i3gfQOL1Ra1I2mh57PZPM4ykDWAxEnQguzrWbXwRpPeYR2UCTl3qSR0K8vA==
X-Received: by 2002:a19:f204:: with SMTP id q4mr30174927lfh.133.1546739479368;
        Sat, 05 Jan 2019 17:51:19 -0800 (PST)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id z6sm12043232lfd.50.2019.01.05.17.51.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 05 Jan 2019 17:51:16 -0800 (PST)
Received: by mail-lf1-f49.google.com with SMTP id i26so27882305lfc.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Jan 2019 17:51:16 -0800 (PST)
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr30297686lfc.124.1546739475480;
 Sat, 05 Jan 2019 17:51:15 -0800 (PST)
MIME-Version: 1.0
References: <nycvar.YFH.7.76.1901051817390.16954@cbobk.fhfr.pm>
 <CAG48ez2jAp9xkPXQmVXm0PqNrFGscg9BufQRem2UD8FGX-YzPw@mail.gmail.com>
 <CAHk-=whL4sZiM=JcdQAYQvHm7h7xEtVUh+gYGYhoSk4vi38tXg@mail.gmail.com>
 <CAHk-=wg5Kk+r36=jcGBaLUj+gjopjgiW5eyvkdMqvn0jFkD_iQ@mail.gmail.com>
 <CAHk-=wiMQeCEKESWTmm15x79NjEjNwFvjZ=9XenxY7yH8zqa7A@mail.gmail.com>
 <20190106001138.GW6310@bombadil.infradead.org> <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
In-Reply-To: <CAHk-=wiT=ov+6zYcnw_64ihYf74Amzqs67iVGtJMQq65PxiVYw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 5 Jan 2019 17:50:59 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
Message-ID: <CAHk-=wg1A44Roa8C4dmfdXLRLmNysEW36=3R7f+tzZzbcJ2d2g@mail.gmail.com>
Subject: Re: [PATCH] mm/mincore: allow for making sys_mincore() privileged
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jann Horn <jannh@google.com>, Jiri Kosina <jikos@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>, Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ff4c37057ec05817"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000ff4c37057ec05817
Content-Type: text/plain; charset="UTF-8"

On Sat, Jan 5, 2019 at 4:22 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> But I think my patch to just rip out all that page lookup, and just
> base it on the page table state has the fundamental advantage that it
> gets rid of code. Maybe I should jst commit it, and see if anything
> breaks? We do have options in case things break, and then we'd at
> least know who cares (and perhaps a lot more information of _why_ they
> care).

Slightly updated patch in case somebody wants to try things out.

Also, any comments about the pmd_trans_unstable() case?

                    Linus

--000000000000ff4c37057ec05817
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
Content-ID: <f_jqk8qbng0>
X-Attachment-Id: f_jqk8qbng0

IG1tL21pbmNvcmUuYyB8IDk0ICsrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyks
IDgxIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL21tL21pbmNvcmUuYyBiL21tL21pbmNvcmUu
YwppbmRleCAyMTgwOTliNWVkMzEuLmYwZjkxNDYxYTlmNCAxMDA2NDQKLS0tIGEvbW0vbWluY29y
ZS5jCisrKyBiL21tL21pbmNvcmUuYwpAQCAtNDIsNzIgKzQyLDE0IEBAIHN0YXRpYyBpbnQgbWlu
Y29yZV9odWdldGxiKHB0ZV90ICpwdGUsIHVuc2lnbmVkIGxvbmcgaG1hc2ssIHVuc2lnbmVkIGxv
bmcgYWRkciwKIAlyZXR1cm4gMDsKIH0KIAotLyoKLSAqIExhdGVyIHdlIGNhbiBnZXQgbW9yZSBw
aWNreSBhYm91dCB3aGF0ICJpbiBjb3JlIiBtZWFucyBwcmVjaXNlbHkuCi0gKiBGb3Igbm93LCBz
aW1wbHkgY2hlY2sgdG8gc2VlIGlmIHRoZSBwYWdlIGlzIGluIHRoZSBwYWdlIGNhY2hlLAotICog
YW5kIGlzIHVwIHRvIGRhdGU7IGkuZS4gdGhhdCBubyBwYWdlLWluIG9wZXJhdGlvbiB3b3VsZCBi
ZSByZXF1aXJlZAotICogYXQgdGhpcyB0aW1lIGlmIGFuIGFwcGxpY2F0aW9uIHdlcmUgdG8gbWFw
IGFuZCBhY2Nlc3MgdGhpcyBwYWdlLgotICovCi1zdGF0aWMgdW5zaWduZWQgY2hhciBtaW5jb3Jl
X3BhZ2Uoc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsIHBnb2ZmX3QgcGdvZmYpCi17Ci0J
dW5zaWduZWQgY2hhciBwcmVzZW50ID0gMDsKLQlzdHJ1Y3QgcGFnZSAqcGFnZTsKLQotCS8qCi0J
ICogV2hlbiB0bXBmcyBzd2FwcyBvdXQgYSBwYWdlIGZyb20gYSBmaWxlLCBhbnkgcHJvY2VzcyBt
YXBwaW5nIHRoYXQKLQkgKiBmaWxlIHdpbGwgbm90IGdldCBhIHN3cF9lbnRyeV90IGluIGl0cyBw
dGUsIGJ1dCByYXRoZXIgaXQgaXMgbGlrZQotCSAqIGFueSBvdGhlciBmaWxlIG1hcHBpbmcgKGll
LiBtYXJrZWQgIXByZXNlbnQgYW5kIGZhdWx0ZWQgaW4gd2l0aAotCSAqIHRtcGZzJ3MgLmZhdWx0
KS4gU28gc3dhcHBlZCBvdXQgdG1wZnMgbWFwcGluZ3MgYXJlIHRlc3RlZCBoZXJlLgotCSAqLwot
I2lmZGVmIENPTkZJR19TV0FQCi0JaWYgKHNobWVtX21hcHBpbmcobWFwcGluZykpIHsKLQkJcGFn
ZSA9IGZpbmRfZ2V0X2VudHJ5KG1hcHBpbmcsIHBnb2ZmKTsKLQkJLyoKLQkJICogc2htZW0vdG1w
ZnMgbWF5IHJldHVybiBzd2FwOiBhY2NvdW50IGZvciBzd2FwY2FjaGUKLQkJICogcGFnZSB0b28u
Ci0JCSAqLwotCQlpZiAoeGFfaXNfdmFsdWUocGFnZSkpIHsKLQkJCXN3cF9lbnRyeV90IHN3cCA9
IHJhZGl4X3RvX3N3cF9lbnRyeShwYWdlKTsKLQkJCXBhZ2UgPSBmaW5kX2dldF9wYWdlKHN3YXBf
YWRkcmVzc19zcGFjZShzd3ApLAotCQkJCQkgICAgIHN3cF9vZmZzZXQoc3dwKSk7Ci0JCX0KLQl9
IGVsc2UKLQkJcGFnZSA9IGZpbmRfZ2V0X3BhZ2UobWFwcGluZywgcGdvZmYpOwotI2Vsc2UKLQlw
YWdlID0gZmluZF9nZXRfcGFnZShtYXBwaW5nLCBwZ29mZik7Ci0jZW5kaWYKLQlpZiAocGFnZSkg
ewotCQlwcmVzZW50ID0gUGFnZVVwdG9kYXRlKHBhZ2UpOwotCQlwdXRfcGFnZShwYWdlKTsKLQl9
Ci0KLQlyZXR1cm4gcHJlc2VudDsKLX0KLQotc3RhdGljIGludCBfX21pbmNvcmVfdW5tYXBwZWRf
cmFuZ2UodW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBsb25nIGVuZCwKLQkJCQlzdHJ1Y3Qg
dm1fYXJlYV9zdHJ1Y3QgKnZtYSwgdW5zaWduZWQgY2hhciAqdmVjKQotewotCXVuc2lnbmVkIGxv
bmcgbnIgPSAoZW5kIC0gYWRkcikgPj4gUEFHRV9TSElGVDsKLQlpbnQgaTsKLQotCWlmICh2bWEt
PnZtX2ZpbGUpIHsKLQkJcGdvZmZfdCBwZ29mZjsKLQotCQlwZ29mZiA9IGxpbmVhcl9wYWdlX2lu
ZGV4KHZtYSwgYWRkcik7Ci0JCWZvciAoaSA9IDA7IGkgPCBucjsgaSsrLCBwZ29mZisrKQotCQkJ
dmVjW2ldID0gbWluY29yZV9wYWdlKHZtYS0+dm1fZmlsZS0+Zl9tYXBwaW5nLCBwZ29mZik7Ci0J
fSBlbHNlIHsKLQkJZm9yIChpID0gMDsgaSA8IG5yOyBpKyspCi0JCQl2ZWNbaV0gPSAwOwotCX0K
LQlyZXR1cm4gbnI7Ci19Ci0KIHN0YXRpYyBpbnQgbWluY29yZV91bm1hcHBlZF9yYW5nZSh1bnNp
Z25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAogCQkJCSAgIHN0cnVjdCBtbV93YWxr
ICp3YWxrKQogewotCXdhbGstPnByaXZhdGUgKz0gX19taW5jb3JlX3VubWFwcGVkX3JhbmdlKGFk
ZHIsIGVuZCwKLQkJCQkJCSAgd2Fsay0+dm1hLCB3YWxrLT5wcml2YXRlKTsKKwl1bnNpZ25lZCBj
aGFyICp2ZWMgPSB3YWxrLT5wcml2YXRlOworCXVuc2lnbmVkIGxvbmcgbnIgPSAoZW5kIC0gYWRk
cikgPj4gUEFHRV9TSElGVDsKKworCW1lbXNldCh2ZWMsIDAsIG5yKTsKKwl3YWxrLT5wcml2YXRl
ICs9IG5yOwogCXJldHVybiAwOwogfQogCkBAIC0xMjcsOCArNjksOSBAQCBzdGF0aWMgaW50IG1p
bmNvcmVfcHRlX3JhbmdlKHBtZF90ICpwbWQsIHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQg
bG9uZyBlbmQsCiAJCWdvdG8gb3V0OwogCX0KIAorCS8qIFdlJ2xsIGNvbnNpZGVyIGEgVEhQIHBh
Z2UgdW5kZXIgY29uc3RydWN0aW9uIHRvIGJlIHRoZXJlICovCiAJaWYgKHBtZF90cmFuc191bnN0
YWJsZShwbWQpKSB7Ci0JCV9fbWluY29yZV91bm1hcHBlZF9yYW5nZShhZGRyLCBlbmQsIHZtYSwg
dmVjKTsKKwkJbWVtc2V0KHZlYywgMSwgbnIpOwogCQlnb3RvIG91dDsKIAl9CiAKQEAgLTEzNywy
OCArODAsMTcgQEAgc3RhdGljIGludCBtaW5jb3JlX3B0ZV9yYW5nZShwbWRfdCAqcG1kLCB1bnNp
Z25lZCBsb25nIGFkZHIsIHVuc2lnbmVkIGxvbmcgZW5kLAogCQlwdGVfdCBwdGUgPSAqcHRlcDsK
IAogCQlpZiAocHRlX25vbmUocHRlKSkKLQkJCV9fbWluY29yZV91bm1hcHBlZF9yYW5nZShhZGRy
LCBhZGRyICsgUEFHRV9TSVpFLAotCQkJCQkJIHZtYSwgdmVjKTsKKwkJCSp2ZWMgPSAwOwogCQll
bHNlIGlmIChwdGVfcHJlc2VudChwdGUpKQogCQkJKnZlYyA9IDE7CiAJCWVsc2UgeyAvKiBwdGUg
aXMgYSBzd2FwIGVudHJ5ICovCiAJCQlzd3BfZW50cnlfdCBlbnRyeSA9IHB0ZV90b19zd3BfZW50
cnkocHRlKTsKIAotCQkJaWYgKG5vbl9zd2FwX2VudHJ5KGVudHJ5KSkgewotCQkJCS8qCi0JCQkJ
ICogbWlncmF0aW9uIG9yIGh3cG9pc29uIGVudHJpZXMgYXJlIGFsd2F5cwotCQkJCSAqIHVwdG9k
YXRlCi0JCQkJICovCi0JCQkJKnZlYyA9IDE7Ci0JCQl9IGVsc2UgewotI2lmZGVmIENPTkZJR19T
V0FQCi0JCQkJKnZlYyA9IG1pbmNvcmVfcGFnZShzd2FwX2FkZHJlc3Nfc3BhY2UoZW50cnkpLAot
CQkJCQkJICAgIHN3cF9vZmZzZXQoZW50cnkpKTsKLSNlbHNlCi0JCQkJV0FSTl9PTigxKTsKLQkJ
CQkqdmVjID0gMTsKLSNlbmRpZgotCQkJfQorCQkJLyoKKwkJCSAqIG1pZ3JhdGlvbiBvciBod3Bv
aXNvbiBlbnRyaWVzIGFyZSBhbHdheXMKKwkJCSAqIHVwdG9kYXRlCisJCQkgKi8KKwkJCSp2ZWMg
PSAhIW5vbl9zd2FwX2VudHJ5KGVudHJ5KTsKIAkJfQogCQl2ZWMrKzsKIAl9Cg==
--000000000000ff4c37057ec05817--
