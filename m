Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7398DC43144
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 10:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4E824B81
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Jun 2018 10:57:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B4E824B81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lichtvoll.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751769AbeFWK5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Jun 2018 06:57:22 -0400
Received: from mondschein.lichtvoll.de ([194.150.191.11]:55311 "EHLO
        mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751490AbeFWK5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jun 2018 06:57:21 -0400
Authentication-Results: auth=pass smtp.auth=martin smtp.mailfrom=martin@lichtvoll.de
Received: from 127.0.0.1 (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.lichtvoll.de (Postfix) with ESMTPSA id C679234C95D;
        Sat, 23 Jun 2018 12:57:18 +0200 (CEST)
From:   Martin Steigerwald <martin@lichtvoll.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Linux on Intel x86: How to disable Hyperthreading
Date:   Sat, 23 Jun 2018 12:57:18 +0200
Message-ID: <1554914.aCy3vs9hif@merkaba>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q2O0ZCBwZW9wbGUgZm9yIFg4NiBhcmNoaXRlY3R1cmUgaW4gTUFJTlRBSU5FUlMuCgoKSGkhCgpB
Y2NvcmRpbmcgdG8KCmh0dHBzOi8vd3d3Lmt1a2V0ei1ibG9nLmRlL3RsYmxlZWQtbmV1ZS1zaWNo
ZXJoZWl0c2x1ZWNrZW4tYmVpLWludGVsLWNwdXMvCgppbgoKaHR0cHM6Ly93d3cuYmxhY2toYXQu
Y29tL3VzLTE4L2JyaWVmaW5ncy9zY2hlZHVsZS8jdGxibGVlZC13aGVuLXByb3RlY3RpbmcteW91
ci1jcHUtY2FjaGVzLWlzLW5vdC1lbm91Z2gtMTAxNDkKCihGaXJlZm94IGFuZCBDaHJvbWl1bSB3
aXRoIGN1cnJlbnQgc2V0dGluZ3MgYW5kIGFkZC1vbnMgd2ViYnJvd3NlcnMgZG8gCm5vdCBkaXNw
bGF5IHRoZSBjb250ZW50cyBvZiB0aGUgcGFnZSkKCm9uZSBjYW4gcmVhZDoKCj4gT3VyIFRMQmxl
ZWQgZXhwbG9pdCBzdWNjZXNzZnVsbHkgbGVha3MgYSAyNTYtYml0IEVkRFNBIGtleSBmcm9tCj4g
bGliZ2NyeXB0ICh1c2VkIGluIGUuZy4gR1BHKSB3aXRoIGEgOTglIHN1Y2Nlc3MgcmF0ZSBhZnRl
ciBqdXN0IGEKPiBzaW5nbGUgb2JzZXJ2YXRpb24gb2Ygc2lnbmluZyBvcGVyYXRpb24gb24gYSBj
by1yZXNpZGVudCBoeXBlcnRocmVhZAo+IGFuZCBqdXN0IDE3IHNlY29uZHMgb2YgYW5hbHlzaXMg
dGltZS4ACgoKQW5kIHRoaXMgcHJvYmFibHkgd291bGQgZXhwbGFpbiB0aGUgZGlzYWJsaW5nIG9m
IGl0IGluIE9wZW5CU0QuCgpXaGF0IGlzIHlvdXIgdGFrZSBvbiB0aGlzPwoKCkFsc28gaG93IHdv
dWxkIHlvdSBkaXNhYmxlIGl0IGluIGNhc2UgeW91IHdvdWxkPwoKSSBjdXJyZW50bHkgdGVzdCBy
dW4gd2l0aCB0aGUgc2NyaXB0IEkgZm91bmQgb246CgpodHRwczovL3NlcnZlcmZhdWx0LmNvbS9x
dWVzdGlvbnMvMjM1ODI1L2Rpc2FibGUtaHlwZXJ0aHJlYWRpbmctZnJvbS13aXRoaW4tbGludXgt
bm8tYWNjZXNzLXRvLWJpb3MKCkp1c3QgdG8gc2VlIHdoZXRoZXIgSSBub3RpY2UgYSBzaWduaWZp
Y2FudCBwZXJmb3JtYW5jZSBkcm9wLgoKVGhhbmtzLgotLSAKTWFydGlu




