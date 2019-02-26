Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659E0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C9A2173C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 11:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IMGA2rxd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbfBZLbf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 06:31:35 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55140 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfBZLbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 06:31:34 -0500
Received: by mail-wm1-f67.google.com with SMTP id a62so2025893wmh.4;
        Tue, 26 Feb 2019 03:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7TK/BXmCyWSJgz0PH6G1u6q92sJsMrniPSMcfJnhwoc=;
        b=IMGA2rxd/edhXf+vuzNM7mBdYj5H1VFsuNFLeoQi8R66VdArvvWXygDFNYHN0rl7K3
         qIQO9qWbFh1N5oGwadnUiG4uKdhS9D2sQRoh5q0O67/65dWqQtdM3e2Z0xPsk/wma54V
         gfvT/sFVZC3QgxywpwhoLf+C5lgQ7QN+1a88X2zUn19+Bmobv7wiJNEIqB+I6oz6211S
         28lQLlTY8qmUDCMkKYfFKIBnm+3PtGdmIH+zqHidCNsLKP47WgqUz99ZEmUyrZM5hUIq
         D3ntvqrt6jZbjtulEXMzdiwa/bTiqq9uxsYcEvZWCl/4jzWmyS8knpBW4U91i/pQxh4K
         K/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7TK/BXmCyWSJgz0PH6G1u6q92sJsMrniPSMcfJnhwoc=;
        b=nAw56zF56A6ulntONHaiEPO1u3scBwdHp0hpawON5LAHyBnKgAj/PWplkB26oa/6T1
         ukDyBWfemBhH8D95NV//dA9Er0HqGsh4O0L696+4eJ7RrGTpT2zoVfy1EkGRrEnObCWL
         FzdY6p0J4b00PkiUjPkyAAUMTKgD3J12ZcecjVzyCq3fNy25wVaZHvN4jzjK1vINjT/0
         u0R7rDHUsc5xE2pS9+p7A7kRhStT4OQIrE85Y+6LgY9vZVZvzEztYnW8xuYETTo7CfbO
         TN0uycUVPZgGL1mjduPFfshs3FK2H70RcfG3xCUNwefw+7p0qwR53MnFZa06z9oV3AUA
         wEXA==
X-Gm-Message-State: AHQUAuaWYWfctAdF2YmPohFLLaJF83oeSf4/0qvIbZiLdVXZGklSNu25
        i8FCdNoDdn63MAPpdc56IiejrZiL2JSu7q8fJ1k=
X-Google-Smtp-Source: AHgI3Ib2GmCJXGW5VsMfla9a5XMLWvI/RHnakIZn87uPetO9HmW+1wHk9IaEe0DBsxa2Y7rdU/YuGsGuoiUv9qf3G5Y=
X-Received: by 2002:a1c:9692:: with SMTP id y140mr2414761wmd.67.1551180691237;
 Tue, 26 Feb 2019 03:31:31 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYsmC5ckLXfQxSUn-tqxLZ4NofEyb9RA69Q07RUoxc79RQ@mail.gmail.com>
 <34c78d7f-cc3c-853d-b3fd-a70abdb66293@ti.com> <22ccca46-7390-1707-cfca-43b3577b79f2@ti.com>
 <CACVXFVP0h-xvJaW1HaMrhozwhR484x0owc6XX63JT-59N08Fag@mail.gmail.com>
 <236a3ac2-5988-9150-4a53-4a33a45d595e@ti.com> <CACVXFVNqtPnWHp+b0-ED70n1pcv9EkARKYWVKaWtFEEgh0N1XA@mail.gmail.com>
In-Reply-To: <CACVXFVNqtPnWHp+b0-ED70n1pcv9EkARKYWVKaWtFEEgh0N1XA@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Tue, 26 Feb 2019 19:31:19 +0800
Message-ID: <CACVXFVO=Q7AHmmR+aU-BTXiSfef5ZQbQSqoov0FPm633E0pspQ@mail.gmail.com>
Subject: Re: Linux-next 20190218: am57xx-evm: mmc1: ADMA error
To:     Faiz Abbas <faiz_abbas@ti.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-mmc@vger.kernel.org,
        linux-omap@vger.kernel.org, Tero Kristo <t-kristo@ti.com>,
        nm@ti.com, Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Omar Sandoval <osandov@fb.com>, Ming Lei <ming.lei@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Content-Type: multipart/mixed; boundary="0000000000001598f20582ca664a"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000001598f20582ca664a
Content-Type: text/plain; charset="UTF-8"

On Tue, Feb 26, 2019 at 6:06 PM Ming Lei <tom.leiming@gmail.com> wrote:
>
> On Tue, Feb 26, 2019 at 2:47 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
> >
> > Hi Ming Lei,
> >
> > On 26/02/19 7:11 AM, Ming Lei wrote:
> > > On Mon, Feb 25, 2019 at 9:14 PM Faiz Abbas <faiz_abbas@ti.com> wrote:
> > >>
> > >> Hi Naresh,
> > >>
> > >> + Commit authors.
> > >>
> > >> On 19/02/19 6:38 PM, Faiz Abbas wrote:
> > >>> Hi Naresh,
> > >>>
> > >>> On 18/02/19 6:57 PM, Naresh Kamboju wrote:
> > >>>> Do you see this error on am57xx-evm running Linux next 20190218 ?
> > >>>> I have tested on multiple devices and found this error.
> > >>>> Please find the full boot log [1].
> > >>>> Am i missing any pre required configs [2] ?
> > >>>>
> > >>>> [    5.620263] mmc1: ADMA error
> > >>>> [    5.623266] mmc1: sdhci: ============ SDHCI REGISTER DUMP ===========
> > >>>> [    5.629740] mmc1: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> > >>>> [    5.636215] mmc1: sdhci: Blk size:  0x00000200 | Blk cnt:  0x0000ffff
> > >>>> [    5.642690] mmc1: sdhci: Argument:  0x002cec70 | Trn mode: 0x00000033
> > >>>> [    5.649162] mmc1: sdhci: Present:   0x01f00000 | Host ctl: 0x00000010
> > >>>> [    5.655634] mmc1: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > >>>> [    5.662108] mmc1: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> > >>>> [    5.668582] mmc1: sdhci: Timeout:   0x0000000c | Int stat: 0x00000000
> > >>>> [    5.675055] mmc1: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> > >>>> [    5.681529] mmc1: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > >>>> [    5.688002] mmc1: sdhci: Caps:      0x21e90080 | Caps_1:   0x00000f77
> > >>>> [    5.694474] mmc1: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> > >>>> [    5.700949] mmc1: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0xffffffef
> > >>>> [    5.707423] mmc1: sdhci: Resp[2]:   0x0f5903ff | Resp[3]:  0xd04f0132
> > >>>> [    5.713896] mmc1: sdhci: Host ctl2: 0x00000004
> > >>>> [    5.718364] mmc1: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xab868218
> > >>>>
> > >>>
> > >>> I see this as well on my setup. Trying to bisect now. Will keep you posted.
> > >>
> > >>
> > >> Reverting the following commit fixes this.
> > >> commit 07173c3ec276cbb18dc0e0687d37d310e98a1480
> > >> Author: Ming Lei <ming.lei@redhat.com>
> > >> Date:   Fri Feb 15 19:13:20 2019 +0800
> > >>
> > >>     block: enable multipage bvecs
> > >>
> > >>     This patch pulls the trigger for multi-page bvecs.
> > >>
> > >>     Reviewed-by: Omar Sandoval <osandov@fb.com>
> > >>     Signed-off-by: Ming Lei <ming.lei@redhat.com>
> > >>     Signed-off-by: Jens Axboe <axboe@kernel.dk>
> > >
> > > Hi,
> > >
> > > Thanks for your report & bisect.
> > >
> > > Could you test the following patch?
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commit/?h=for-5.1/block&id=8f4e80da764ec1ca44c83f3e17dbc9bf0209bccc
> > >
> > > Or  simply run the latest -next?
> >
> > That didn't fix it for me. Still see ADMA error.
> >
> > [   13.126186] mmc0: ADMA error
> > [   13.129084] mmc0: sdhci: ============ SDHCI REGISTER DUMP ===========
> > [   13.135552] mmc0: sdhci: Sys addr:  0x00000000 | Version:  0x00003302
> > [   13.142019] mmc0: sdhci: Blk size:  0x00000200 | Blk cnt:  0x00000000
> > [   13.148485] mmc0: sdhci: Argument:  0x00000089 | Trn mode: 0x00000033
> > [   13.154952] mmc0: sdhci: Present:   0x00000000 | Host ctl: 0x00000012
> > [   13.161418] mmc0: sdhci: Power:     0x0000000f | Blk gap:  0x00000000
> > [   13.167885] mmc0: sdhci: Wake-up:   0x00000000 | Clock:    0x00000107
> > [   13.174351] mmc0: sdhci: Timeout:   0x0000000a | Int stat: 0x00000000
> > [   13.180817] mmc0: sdhci: Int enab:  0x027f000b | Sig enab: 0x027f000b
> > [   13.187282] mmc0: sdhci: ACmd stat: 0x00000000 | Slot int: 0x00000000
> > [   13.193748] mmc0: sdhci: Caps:      0x25e90080 | Caps_1:   0x00000f77
> > [   13.200215] mmc0: sdhci: Cmd:       0x0000123a | Max curr: 0x00000000
> > [   13.206682] mmc0: sdhci: Resp[0]:   0x00000900 | Resp[1]:  0x3b377f80
> > [   13.213148] mmc0: sdhci: Resp[2]:   0x5b590000 | Resp[3]:  0x400e0032
> > [   13.219613] mmc0: sdhci: Host ctl2: 0x00000000
> > [   13.224073] mmc0: sdhci: ADMA Err:  0x00000007 | ADMA Ptr: 0xae857288
> > [   13.230538] mmc0: sdhci: ============================================
>
> OK, I will write a debug patch to dump the sg data and see if it is
> generated as wrong.

Hi Faiz,

Could you apply the attached debug patch and post the dmesg log?

Also please provide us the following log.

     (cd  /sys/block/mmcblk0/queue && find . -type f -exec grep -aH . {} \;)

Thanks,
Ming Lei

--0000000000001598f20582ca664a
Content-Type: text/x-patch; charset="US-ASCII"; name="mmc-dbg.patch"
Content-Disposition: attachment; filename="mmc-dbg.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jsloww050>
X-Attachment-Id: f_jsloww050

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYyBiL2RyaXZlcnMvbW1jL2NvcmUv
YmxvY2suYwppbmRleCBhZWYxMTg1ZjM4M2QuLmJhOWNmODg4YWE4NyAxMDA2NDQKLS0tIGEvZHJp
dmVycy9tbWMvY29yZS9ibG9jay5jCisrKyBiL2RyaXZlcnMvbW1jL2NvcmUvYmxvY2suYwpAQCAt
MTU5NSw2ICsxNTk1LDggQEAgc3RhdGljIHZvaWQgbW1jX2Jsa19yd19ycV9wcmVwKHN0cnVjdCBt
bWNfcXVldWVfcmVxICptcXJxLAogCXN0cnVjdCBtbWNfYmxrX2RhdGEgKm1kID0gbXEtPmJsa2Rh
dGE7CiAJYm9vbCBkb19yZWxfd3IsIGRvX2RhdGFfdGFnOwogCisJYnJxLT5tcnEucnEgPSByZXE7
CisKIAltbWNfYmxrX2RhdGFfcHJlcChtcSwgbXFycSwgZGlzYWJsZV9tdWx0aSwgJmRvX3JlbF93
ciwgJmRvX2RhdGFfdGFnKTsKIAogCWJycS0+bXJxLmNtZCA9ICZicnEtPmNtZDsKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpp
bmRleCBlYmE5YmNjOTJhZDMuLjQwZTg0MjRkOGVhZiAxMDA2NDQKLS0tIGEvZHJpdmVycy9tbWMv
aG9zdC9zZGhjaS5jCisrKyBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kuYwpAQCAtMjg0Miw2ICsy
ODQyLDMxIEBAIHN0YXRpYyB2b2lkIHNkaGNpX2NtZF9pcnEoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QsIHUzMiBpbnRtYXNrLCB1MzIgKmludG1hc2tfcCkKIAkJc2RoY2lfZmluaXNoX2NvbW1hbmQo
aG9zdCk7CiB9CiAKKyNpbmNsdWRlIDxsaW51eC9ibGtkZXYuaD4KK3N0YXRpYyB2b2lkIHNkaGNp
X2R1bXBfc2coc3RydWN0IHNkaGNpX2hvc3QgKmhvc3QpCit7CisJc3RydWN0IHNjYXR0ZXJsaXN0
ICpzZzsKKwlzdHJ1Y3QgcmVxdWVzdCAqcnEgPSBob3N0LT5kYXRhLT5tcnEtPnJxOworCXN0cnVj
dCByZXFfaXRlcmF0b3IgcnFfaXRlcjsKKwlzdHJ1Y3QgYmlvX3ZlYyB0bXA7CisJaW50IGkgPSAw
OworCisJcHJpbnRrKCIlczogZHVtcCBzZyBsaXN0XG4iLCBfX2Z1bmNfXyk7CisJZm9yIChzZyA9
IGhvc3QtPmRhdGEtPnNnOyBzZzsgc2cgPSBzZ19uZXh0KHNnKSkKKwkJcHJpbnRrKCJcdCAlZDog
JWx1ICV1ICV1XG4iLAorCQkJaSsrLAorCQkJKHVuc2lnbmVkIGxvbmcpcGFnZV90b19wZm4oc2df
cGFnZShzZykpLAorCQkJc2ctPm9mZnNldCwgc2ctPmxlbmd0aCk7CisKKwlwcmludGsoIiVzOiBk
dW1wIHJlcXVlc3QgYnZlY1xuIiwgX19mdW5jX18pOworCWkgPSAwOworCXJxX2Zvcl9lYWNoX2J2
ZWModG1wLCBycSwgcnFfaXRlcikKKwkJcHJpbnRrKCJcdCAlZDogJWx1ICV1ICV1XG4iLAorCQkJ
aSsrLAorCQkJKHVuc2lnbmVkIGxvbmcpcGFnZV90b19wZm4odG1wLmJ2X3BhZ2UpLAorCQkJdG1w
LmJ2X29mZnNldCwgdG1wLmJ2X2xlbik7Cit9CisKIHN0YXRpYyB2b2lkIHNkaGNpX2FkbWFfc2hv
d19lcnJvcihzdHJ1Y3Qgc2RoY2lfaG9zdCAqaG9zdCkKIHsKIAl2b2lkICpkZXNjID0gaG9zdC0+
YWRtYV90YWJsZTsKQEAgLTI5NDEsNiArMjk2Niw3IEBAIHN0YXRpYyB2b2lkIHNkaGNpX2RhdGFf
aXJxKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1MzIgaW50bWFzaykKIAllbHNlIGlmIChpbnRt
YXNrICYgU0RIQ0lfSU5UX0FETUFfRVJST1IpIHsKIAkJcHJfZXJyKCIlczogQURNQSBlcnJvclxu
IiwgbW1jX2hvc3RuYW1lKGhvc3QtPm1tYykpOwogCQlzZGhjaV9hZG1hX3Nob3dfZXJyb3IoaG9z
dCk7CisJCXNkaGNpX2R1bXBfc2coaG9zdCk7CiAJCWhvc3QtPmRhdGEtPmVycm9yID0gLUVJTzsK
IAkJaWYgKGhvc3QtPm9wcy0+YWRtYV93b3JrYXJvdW5kKQogCQkJaG9zdC0+b3BzLT5hZG1hX3dv
cmthcm91bmQoaG9zdCwgaW50bWFzayk7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L21tYy9j
b3JlLmggYi9pbmNsdWRlL2xpbnV4L21tYy9jb3JlLmgKaW5kZXggMTM0YTY0ODMzNDdhLi4yNTU2
NWU2NDBiZmEgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvbW1jL2NvcmUuaAorKysgYi9pbmNs
dWRlL2xpbnV4L21tYy9jb3JlLmgKQEAgLTE2OCw2ICsxNjgsNyBAQCBzdHJ1Y3QgbW1jX3JlcXVl
c3QgewogCWJvb2wJCQljYXBfY21kX2R1cmluZ190ZnI7CiAKIAlpbnQJCQl0YWc7CisJc3RydWN0
IHJlcXVlc3QJCSpycTsKIH07CiAKIHN0cnVjdCBtbWNfY2FyZDsK
--0000000000001598f20582ca664a--
