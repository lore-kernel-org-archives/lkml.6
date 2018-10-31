Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_BASE64_TEXT,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 401E6C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:58:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04BAC20823
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sck5c5mL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BAC20823
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbeKAA5J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:57:09 -0400
Received: from mail-yb1-f171.google.com ([209.85.219.171]:43370 "EHLO
        mail-yb1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeKAA5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:57:09 -0400
Received: by mail-yb1-f171.google.com with SMTP id g75-v6so6821475yba.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:mime-version;
        bh=gIuNUifm++NfLKX2FT/u+YlnmoZZ/CHZyOYngG1xAnw=;
        b=sck5c5mLLKTiol3mSr7B4m9l7OMSM55AyW1Q/3v88K9cRuFXSzRchLndxuFwOgIG/h
         a/81nSBKLS1SBW0YBzluzDvhBLqPqP0HdcczfpkkqU/iYJX3TIzfoJNcnNOM/R0BnyOr
         VB+mbUoffYW15SB9nBaG1vpTjCyLruOYVs+NliESJIWto3qUKoeZSeIbFLptoPAR+mx2
         Mp6yP2bjiY5Nah0vEy2G1hIE9zQyruhqT8TtHWN67z2uWwSyjbH5p5FxTQfCazfjWVAg
         FSqQeG12whUVa6vuz16pGN4Xp+p/ifLlonKcYMgN11lMERXUKA71I1FvHZ7u3YyzOJmn
         Eilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:mime-version;
        bh=gIuNUifm++NfLKX2FT/u+YlnmoZZ/CHZyOYngG1xAnw=;
        b=O+6fWPgJ+Cums2tMO7tYulLEmf5m9YDJkgYsF9fGIQ+iwHOL9aSxj61lLCVcVbACN4
         gC4A53wpGtHsxzK5w6/cfiTcGVcTRMsx9cU9JEbr3XRmaiQyfA61bqwdjfSdLyGhlvLq
         WastI2FCWmnclF/o7zSwWRGzauYqFL2d0IMMF7R+nRMTT7TlvdtJcFN9LIK+fzG0xA4m
         Gt9GHDk2Kbzs0LY1jmkJyHJ2LZGe+BpxHDT8c9e+6akhK5QN3YsQgi6cNkACu0QIFJHe
         x37hE/N4IGhKutmCT/rJTmz6YD/vnCRlnq3o+5WVKatS4PtTNH7sCkkuE3uIHsH45409
         gMSQ==
X-Gm-Message-State: AGRZ1gJl94IUjMkGwsZSWRKxyhc3cGU+ggS+Knldla9WPswZseBlDES6
        Qjf0ZsYiI34GqulkB8/cug==
X-Google-Smtp-Source: AJdET5cKytIRtzTO/FOrOtb9EfC0PvGWMOaNw622GLbyzQGEU/AWd7wp8H3u9Ul7oF8e+EQaBdt2MQ==
X-Received: by 2002:a25:fc0d:: with SMTP id v13-v6mr3749876ybd.320.1541001511591;
        Wed, 31 Oct 2018 08:58:31 -0700 (PDT)
Received: from 960 ([130.254.104.55])
        by smtp.gmail.com with ESMTPSA id 207-v6sm7503671yww.21.2018.10.31.08.58.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 08:58:30 -0700 (PDT)
Message-ID: <ae9b5692e758aba6f4077c9d1dd777e9c096518b.camel@gmail.com>
Subject: [PATCH] ALSA:hda: fix front speakers on Huawei MBXP.
From:   ayman.bagabas@gmail.com
To:     perex@perex.cz, tiwai@suse.com, kailang@realtek.com,
        hui.wang@canonical.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Ayman Bagabas <ayman.bagabas@gmail.com>
Date:   Wed, 31 Oct 2018 11:58:30 -0400
Content-Type: multipart/mixed; boundary="=-byBTJOeQLHYICFJ/ioVQ"
X-Mailer: Evolution 3.28.5 (3.28.5-1.fc28) 
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-byBTJOeQLHYICFJ/ioVQ
Content-Type: text/plain
Content-Transfer-Encoding: base64

Cg0K


--=-byBTJOeQLHYICFJ/ioVQ
Content-Disposition: attachment;
	filename="0002-ALSA-hda-fix-front-speakers-on-Huawei-MBXP.patch"
Content-Transfer-Encoding: base64
Content-Type: text/x-patch; name="0002-ALSA-hda-fix-front-speakers-on-Huawei-MBXP.patch";
	charset="UTF-8"

RnJvbSBkNDcyYzA2ODk4Y2Y1YTJhZWJmMWE2ZWY3ZDUwOTVhNjcyZTA4OTAxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBBeW1hbiBCYWdhYmFzIDxheW1hbi5iYWdhYmFzQGdtYWlsLmNv
bT4KRGF0ZTogV2VkLCAzMSBPY3QgMjAxOCAxMTozNDoxNSAtMDQwMApTdWJqZWN0OiBbUEFUQ0gg
Mi8zXSBBTFNBOmhkYTogZml4IGZyb250IHNwZWFrZXJzIG9uIEh1YXdlaSBNQlhQLgoKVGhpcyBw
YXRjaCBlbmFibGVzIHRoZSBmcm9udCBzcGVha2VycyBvbiBIdWF3ZWkgTWF0ZWJvb2sgWCBQcm8g
bGFwdG9wcy4KVGhlc2UgbGFwdG9wcyBjb21lIHdpdGggRG9sYnkgQXRtb3Mgc291bmQgc3lzdGVt
IGFuZCB0aGVzZSBwaW5zCmNvbmZpZ3VyYXRpb24gZW5hYmxlcyB0aGUgZnJvbnQgc3BlYWtlcnMu
CgpTaWduZWQtb2ZmLWJ5OiBBeW1hbiBCYWdhYmFzIDxheW1hbi5iYWdhYmFzQGdtYWlsLmNvbT4K
LS0tCiBzb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyB8IDE4ICsrKysrKysrKysrKysrKysr
KwogMSBmaWxlIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9zb3VuZC9w
Y2kvaGRhL3BhdGNoX3JlYWx0ZWsuYyBiL3NvdW5kL3BjaS9oZGEvcGF0Y2hfcmVhbHRlay5jCmlu
ZGV4IDNhYzdiYTliMzQyZC4uNGY3YTM5Yzc4ODNjIDEwMDY0NAotLS0gYS9zb3VuZC9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYworKysgYi9zb3VuZC9wY2kvaGRhL3BhdGNoX3JlYWx0ZWsuYwpAQCAt
NTQ5Myw2ICs1NDkzLDcgQEAgZW51bSB7CiAJQUxDMjk4X0ZJWFVQX1RQVDQ3MF9ET0NLLAogCUFM
QzI1NV9GSVhVUF9EVU1NWV9MSU5FT1VUX1ZFUkIsCiAJQUxDMjU1X0ZJWFVQX0RFTExfSEVBRFNF
VF9NSUMsCisJQUxDMjU2X0ZJWFVQX0hVQVdFSV9NQlhQX1BJTlMsCiAJQUxDMjk1X0ZJWFVQX0hQ
X1gzNjAsCiAJQUxDMjIxX0ZJWFVQX0hQX0hFQURTRVRfTUlDLAogfTsKQEAgLTYzNDcsNiArNjM0
OCwyMiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGhkYV9maXh1cCBhbGMyNjlfZml4dXBzW10gPSB7
CiAJCS5jaGFpbmVkID0gdHJ1ZSwKIAkJLmNoYWluX2lkID0gQUxDMjY5X0ZJWFVQX0hFQURTRVRf
TUlDCiAJfSwKKwlbQUxDMjU2X0ZJWFVQX0hVQVdFSV9NQlhQX1BJTlNdID0geworCQkudHlwZSA9
IEhEQV9GSVhVUF9QSU5TLAorCQkudi5waW5zID0gKGNvbnN0IHN0cnVjdCBoZGFfcGludGJsW10p
IHsKKwkJCXsweDEyLCAweDkwYTYwMTMwfSwKKwkJCXsweDEzLCAweDQwMDAwMDAwfSwKKwkJCXsw
eDE0LCAweDkwMTcwMTEwfSwKKwkJCXsweDE4LCAweDQxMTExMWYwfSwKKwkJCXsweDE5LCAweDA0
YTExMDQwfSwKKwkJCXsweDFhLCAweDQxMTExMWYwfSwKKwkJCXsweDFiLCAweDkwMTcwMTEyfSwK
KwkJCXsweDFkLCAweDQwNzU5YTA1fSwKKwkJCXsweDFlLCAweDQxMTExMWYwfSwKKwkJCXsweDIx
LCAweDA0MjExMDIwfSwKKwkJCXsgfSwKKwkJfSwKKwl9LAogCVtBTEMyOTVfRklYVVBfSFBfWDM2
MF0gPSB7CiAJCS50eXBlID0gSERBX0ZJWFVQX0ZVTkMsCiAJCS52LmZ1bmMgPSBhbGMyOTVfZml4
dXBfaHBfdG9wX3NwZWFrZXJzLApAQCAtNjU5Miw2ICs2NjA5LDcgQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBzbmRfcGNpX3F1aXJrIGFsYzI2OV9maXh1cF90YmxbXSA9IHsKIAlTTkRfUENJX1FVSVJL
KDB4MTdhYSwgMHg1MTA5LCAiVGhpbmtwYWQiLCBBTEMyNjlfRklYVVBfTElNSVRfSU5UX01JQ19C
T09TVCksCiAJU05EX1BDSV9RVUlSSygweDE3YWEsIDB4NTExZSwgIlRoaW5rcGFkIiwgQUxDMjk4
X0ZJWFVQX1RQVDQ3MF9ET0NLKSwKIAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHg1MTFmLCAiVGhp
bmtwYWQiLCBBTEMyOThfRklYVVBfVFBUNDcwX0RPQ0spLAorCVNORF9QQ0lfUVVJUksoMHgxOWU1
LCAweDMyMDQsICJIdWF3ZWkgTUJYUCIsIEFMQzI1Nl9GSVhVUF9IVUFXRUlfTUJYUF9QSU5TKSwK
IAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHgzYmY4LCAiUXVhbnRhIEZMMSIsIEFMQzI2OV9GSVhV
UF9QQ01fNDRLKSwKIAlTTkRfUENJX1FVSVJLKDB4MTdhYSwgMHg5ZTU0LCAiTEVOT1ZPIE5CIiwg
QUxDMjY5X0ZJWFVQX0xFTk9WT19FQVBEKSwKIAlTTkRfUENJX1FVSVJLKDB4MWI3ZCwgMHhhODMx
LCAiT3JkaXNzaW1vIEVWRTIgIiwgQUxDMjY5VkJfRklYVVBfT1JESVNTSU1PX0VWRTIpLCAvKiBB
bHNvIGtub3duIGFzIE1hbGF0YSBQQy1CMTMwMyAqLwotLSAKMi4xNy4yCgo=


--=-byBTJOeQLHYICFJ/ioVQ--

