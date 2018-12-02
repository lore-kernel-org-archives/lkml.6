Return-Path: <SRS0=9INQ=OL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72526C04EB8
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:01:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DB3A206B7
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Dec 2018 21:01:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WdojGIPy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DB3A206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbeLBVBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Dec 2018 16:01:18 -0500
Received: from mail-wr1-f41.google.com ([209.85.221.41]:40803 "EHLO
        mail-wr1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbeLBVBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Dec 2018 16:01:18 -0500
Received: by mail-wr1-f41.google.com with SMTP id p4so10094750wrt.7
        for <linux-kernel@vger.kernel.org>; Sun, 02 Dec 2018 13:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=JyvUJ8IrBgLEmCM9Gtx2ahzJACnxQICBl2Zr6DKzte8=;
        b=WdojGIPyyEJaaceAYbutzhFmadugrrnhHLS+qbMXM+6HwnNmQgjkUsz8+xLI1t/7Uf
         9ExftsxpY5DiRR7+JVf1hl6Hx9TAYNex4itqRXgHSnpbqxODKLSXPMQmXeEagwYjUIha
         uoNQ6gTg4EysIfePl6D/4vXzHVh/KyvroEvpFXnWtVx+3jRMqn+LBvFTDaZwCsbu/U0j
         7gHy/Mho6osL6DVQHbVQQtSMlhg+6Zgt4jMD4o2J3uG8AsTCM7v3qpCg3F+cq+jTnNNq
         GQGQ3OnHuIyIXNpg10kSwvNjqi8aqjNqqh4LEWV9rwI9tF+4i+UjX9XrcruhOnMNXW0D
         UpFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=JyvUJ8IrBgLEmCM9Gtx2ahzJACnxQICBl2Zr6DKzte8=;
        b=oCOixrlFNt3A+ER8TGaD114KabG7QVgt7wsnnvjUY01i1/M6gjUCfM+rVmRrXNnz4g
         9RWOWSjD9K4UlNjUddzYM4urJIdUcTeJrWiISezyWk9gmSFzThVSH0Lu/QZVxrl93av4
         Y4L0h/48mmI+wTJ8Q+GZMKrJzpybHoNN5bvFK8aZr+Mwxp41C0fl32diWePpBwBnwbLS
         hKAmejUbnsjKHs8Ov/si6Eq6sbHzLiEHuVLpNaU4ZZE1iyUKbBFwkPPToUq6w8s8dl5Y
         07/d6g7KuSFnvukAQzV/zshcsn2v0qVgx/sYCkIsZafkevVO4bVkYdj6CuuB70jKZAh0
         eVCg==
X-Gm-Message-State: AA+aEWYaEIFoi24OQwYvJckPle/fcLxQPmc+CMUdF9Z0k3gAj1tD7cS9
        4AZVNSROCsTAxNehY6wh/yf8u7s9nNXmqjD7mvNm+VOD
X-Google-Smtp-Source: AFSGD/W9yl0sN5EivU/W5Mt/u/5/N99qAMNx31iVekkONSc8dDcTOc+Fe1PHBbeZPL6KsGZDJhQuKdGnH35Y9ohlrCk=
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr12476955wrr.67.1543784473515;
 Sun, 02 Dec 2018 13:01:13 -0800 (PST)
MIME-Version: 1.0
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Sun, 2 Dec 2018 21:01:01 +0000
Message-ID: <CAK+_RLnYbyDrqRbm6-AyRmG4=iFrqqL_UrzHuhPO1_jD1F9WSQ@mail.gmail.com>
Subject: [patch set 4.19.6] BFS updates
To:     torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000027909b057c105565"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000027909b057c105565
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

I attached two incremental patches for BFS:

1. Make inode bitmap allocation static (applies on top of 4.19.6)
2. Strengthen the superblock sanity checking code (applies on top of 1. above)

Kind regards,
Tigran

--00000000000027909b057c105565
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="bfs-4.19.6-1-of-2-static-inode-bitmap.patch"
Content-Disposition: attachment; 
	filename="bfs-4.19.6-1-of-2-static-inode-bitmap.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jp7d9p8i0>
X-Attachment-Id: f_jp7d9p8i0

RnJvbTogVGlncmFuIEFpdmF6aWFuIDxhaXZhemlhbi50aWdyYW5AZ21haWwuY29tPgpTdWJqZWN0
OiBbUEFUQ0ggNC4xOS42IDEvMl0gQkZTIHVwZGF0ZXMKCk1ha2UgaW4tY29yZSBpbm9kZSBiaXRt
YXAgc3RhdGljIHBhcnQgb2Ygc3VwZXJibG9jayBpbmZvIHN0cnVjdHVyZSBhbi4KcHJpbnQgYSB3
YXJuaW5nIHdoZW4gbW91bnRpbmcgYSBCRlMgZmlsZXN5c3RlbSBjcmVhdGVkIHdpdGggIi1OIDUx
MiIKb3B0aW9uIGFzIG9ubHkgNTEwIGZpbGVzIGNhbiBiZSBjcmVhdGVkIGluIHRoZSByb290IGRp
cmVjdG9yeS4KClNpZ25lZC1vZmYtYnk6IFRpZ3JhbiBBaXZhemlhbiA8YWl2YXppYW4udGlncmFu
QGdtYWlsLmNvbT4KLS0tCgogYmZzLmggICB8ICAgIDkgKysrKysrKystCiBpbm9kZS5jIHwgICAy
NyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0
aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgotLS0gZnMvYmZzL2Jmcy5oLjAJMjAxOC0xMi0wMiAy
MDozMzowMi4yNTI3MTAyOTEgKzAwMDAKKysrIGZzL2Jmcy9iZnMuaAkyMDE4LTEyLTAyIDIwOjM0
OjM0LjA0MTI0NjQ4OSArMDAwMApAQCAtOCw2ICs4LDEzIEBACiAKICNpbmNsdWRlIDxsaW51eC9i
ZnNfZnMuaD4KIAorLyogSW4gdGhlb3J5IEJGUyBzdXBwb3J0cyB1cCB0byA1MTIgaW5vZGVzLCBu
dW1iZXJlZCBmcm9tIDIgKGZvciAvKSB1cCB0byA1MTMgaW5jbHVzaXZlLgorICAgSW4gYWN0dWFs
IGZhY3QsIGF0dGVtcHRpbmcgdG8gY3JlYXRlIHRoZSA1MTJ0aCBpbm9kZSAoaS5lLiBpbm9kZSBO
by4gNTEzIG9yIGZpbGUgTm8uIDUxMSkKKyAgIHdpbGwgZmFpbCB3aXRoIEVOT1NQQyBpbiBiZnNf
YWRkX2VudHJ5KCk6IHRoZSByb290IGRpcmVjdG9yeSBjYW5ub3QgY29udGFpbiBzbyBtYW55IGVu
dHJpZXMsIGNvdW50aW5nICcuLicuCisgICBTbywgbWtmcy5iZnMoOCkgc2hvdWxkIHJlYWxseSBs
aW1pdCBpdHMgLU4gb3B0aW9uIHRvIDUxMSBhbmQgbm90IDUxMi4gRm9yIG5vdywgd2UganVzdCBw
cmludCBhIHdhcm5pbmcKKyAgIGlmIGEgZmlsZXN5c3RlbSBpcyBtb3VudGVkIHdpdGggc3VjaCAi
aW1wb3NzaWJsZSB0byBmaWxsIHVwIiBudW1iZXIgb2YgaW5vZGVzICovCisjZGVmaW5lIEJGU19N
QVhfTEFTVEkJNTEzCisKIC8qCiAgKiBCRlMgZmlsZSBzeXN0ZW0gaW4tY29yZSBzdXBlcmJsb2Nr
IGluZm8KICAqLwpAQCAtMTcsNyArMjQsNyBAQAogCXVuc2lnbmVkIGxvbmcgc2lfZnJlZWk7CiAJ
dW5zaWduZWQgbG9uZyBzaV9sZl9lYmxrOwogCXVuc2lnbmVkIGxvbmcgc2lfbGFzdGk7Ci0JdW5z
aWduZWQgbG9uZyAqc2lfaW1hcDsKKwlERUNMQVJFX0JJVE1BUChzaV9pbWFwLCBCRlNfTUFYX0xB
U1RJKzEpOwogCXN0cnVjdCBtdXRleCBiZnNfbG9jazsKIH07CiAKLS0tIGZzL2Jmcy9pbm9kZS5j
LjAJMjAxOC0xMi0wMiAyMDozNDowMy4yMTE3NDA4NzcgKzAwMDAKKysrIGZzL2Jmcy9pbm9kZS5j
CTIwMTgtMTItMDIgMjA6MzY6NTQuNTA4OTYzODEzICswMDAwCkBAIC0yMTQsNyArMjE0LDYgQEAK
IAkJcmV0dXJuOwogCiAJbXV0ZXhfZGVzdHJveSgmaW5mby0+YmZzX2xvY2spOwotCWtmcmVlKGlu
Zm8tPnNpX2ltYXApOwogCWtmcmVlKGluZm8pOwogCXMtPnNfZnNfaW5mbyA9IE5VTEw7CiB9CkBA
IC0zMjIsNyArMzIxLDcgQEAKIAlzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoLCAqc2JoOwogCXN0cnVj
dCBiZnNfc3VwZXJfYmxvY2sgKmJmc19zYjsKIAlzdHJ1Y3QgaW5vZGUgKmlub2RlOwotCXVuc2ln
bmVkIGksIGltYXBfbGVuOworCXVuc2lnbmVkIGk7CiAJc3RydWN0IGJmc19zYl9pbmZvICppbmZv
OwogCWludCByZXQgPSAtRUlOVkFMOwogCXVuc2lnbmVkIGxvbmcgaV9zYmxvY2ssIGlfZWJsb2Nr
LCBpX2VvZmYsIHNfc2l6ZTsKQEAgLTM1NiwxMyArMzU1LDExIEBACiAJCWdvdG8gb3V0MTsKIAl9
CiAKLQlpbmZvLT5zaV9sYXN0aSA9IChsZTMyX3RvX2NwdShiZnNfc2ItPnNfc3RhcnQpIC0gQkZT
X0JTSVpFKSAvCi0JCQkJCXNpemVvZihzdHJ1Y3QgYmZzX2lub2RlKQotCQkJCQkrIEJGU19ST09U
X0lOTyAtIDE7Ci0JaW1hcF9sZW4gPSAoaW5mby0+c2lfbGFzdGkgLyA4KSArIDE7Ci0JaW5mby0+
c2lfaW1hcCA9IGt6YWxsb2MoaW1hcF9sZW4sIEdGUF9LRVJORUwgfCBfX0dGUF9OT1dBUk4pOwot
CWlmICghaW5mby0+c2lfaW1hcCkgewotCQlwcmludGYoIkNhbm5vdCBhbGxvY2F0ZSAldSBieXRl
c1xuIiwgaW1hcF9sZW4pOworCWluZm8tPnNpX2xhc3RpID0gKGxlMzJfdG9fY3B1KGJmc19zYi0+
c19zdGFydCkgLSBCRlNfQlNJWkUpIC8gc2l6ZW9mKHN0cnVjdCBiZnNfaW5vZGUpICsgQkZTX1JP
T1RfSU5PIC0gMTsKKwlpZiAoaW5mby0+c2lfbGFzdGkgPT0gQkZTX01BWF9MQVNUSSkKKwkJcHJp
bnRmKCJXQVJOSU5HOiBmaWxlc3lzdGVtICVzIHdhcyBjcmVhdGVkIHdpdGggNTEyIGlub2Rlcywg
dGhlIHJlYWwgbWF4aW11bSBpcyA1MTEsIG1vdW50aW5nIGFueXdheVxuIiwgcy0+c19pZCk7CisJ
ZWxzZSBpZiAoaW5mby0+c2lfbGFzdGkgPiBCRlNfTUFYX0xBU1RJKSB7CisJCXByaW50ZigiSW1w
b3NzaWJsZSBsYXN0IGlub2RlIG51bWJlciAlbHUgPiAlZCBvbiAlc1xuIiwgaW5mby0+c2lfbGFz
dGksIEJGU19NQVhfTEFTVEksIHMtPnNfaWQpOwogCQlnb3RvIG91dDE7CiAJfQogCWZvciAoaSA9
IDA7IGkgPCBCRlNfUk9PVF9JTk87IGkrKykKQEAgLTM3MiwxMiArMzY5LDEyIEBACiAJaW5vZGUg
PSBiZnNfaWdldChzLCBCRlNfUk9PVF9JTk8pOwogCWlmIChJU19FUlIoaW5vZGUpKSB7CiAJCXJl
dCA9IFBUUl9FUlIoaW5vZGUpOwotCQlnb3RvIG91dDI7CisJCWdvdG8gb3V0MTsKIAl9CiAJcy0+
c19yb290ID0gZF9tYWtlX3Jvb3QoaW5vZGUpOwogCWlmICghcy0+c19yb290KSB7CiAJCXJldCA9
IC1FTk9NRU07Ci0JCWdvdG8gb3V0MjsKKwkJZ290byBvdXQxOwogCX0KIAogCWluZm8tPnNpX2Js
b2NrcyA9IChsZTMyX3RvX2NwdShiZnNfc2ItPnNfZW5kKSArIDEpID4+IEJGU19CU0laRV9CSVRT
OwpAQCAtMzkxLDcgKzM4OCw3IEBACiAJaWYgKCFiaCkgewogCQlwcmludGYoIkxhc3QgYmxvY2sg
bm90IGF2YWlsYWJsZTogJWx1XG4iLCBpbmZvLT5zaV9ibG9ja3MgLSAxKTsKIAkJcmV0ID0gLUVJ
TzsKLQkJZ290byBvdXQzOworCQlnb3RvIG91dDI7CiAJfQogCWJyZWxzZShiaCk7CiAKQEAgLTQy
OSw3ICs0MjYsNyBAQAogCiAJCQlicmVsc2UoYmgpOwogCQkJcmV0ID0gLUVJTzsKLQkJCWdvdG8g
b3V0MzsKKwkJCWdvdG8gb3V0MjsKIAkJfQogCiAJCWlmICghZGktPmlfaW5vKSB7CkBAIC00NDgs
MTEgKzQ0NSw5IEBACiAJYmZzX2R1bXBfaW1hcCgicmVhZF9zdXBlciIsIHMpOwogCXJldHVybiAw
OwogCi1vdXQzOgorb3V0MjoKIAlkcHV0KHMtPnNfcm9vdCk7CiAJcy0+c19yb290ID0gTlVMTDsK
LW91dDI6Ci0Ja2ZyZWUoaW5mby0+c2lfaW1hcCk7CiBvdXQxOgogCWJyZWxzZShzYmgpOwogb3V0
Ogo=
--00000000000027909b057c105565
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="bfs-4.19.6-2-of-2-strengthen-sanity-checking.patch"
Content-Disposition: attachment; 
	filename="bfs-4.19.6-2-of-2-strengthen-sanity-checking.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jp7d9p8w1>
X-Attachment-Id: f_jp7d9p8w1

RnJvbTogVGlncmFuIEFpdmF6aWFuIDxhaXZhemlhbi50aWdyYW5AZ21haWwuY29tPgpTdWJqZWN0
OiBbUEFUQ0ggNC4xOS42IDIvMl0gQkZTIHVwZGF0ZXMKClN0cmVuZ3RoZW4gdGhlIHN1cGVyYmxv
Y2sgc2FuaXR5IGNoZWNraW5nIChzdXBlcnNlZGVzIHRoZSBjb2RlCnRoYXQgd2VudCBpbnRvIDQu
MTkuNikuCgpTaWduZWQtb2ZmLWJ5OiBUaWdyYW4gQWl2YXppYW4gPGFpdmF6aWFuLnRpZ3JhbkBn
bWFpbC5jb20+Ci0tLQoKIGlub2RlLmMgfCAgICAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkKCi0tLSBmcy9iZnMvaW5vZGUuYy4wCTIwMTgtMTItMDIg
MjA6NDk6MDAuNTI1NDYxMzU0ICswMDAwCisrKyBmcy9iZnMvaW5vZGUuYwkyMDE4LTEyLTAyIDIw
OjQ5OjUxLjA1NDY4Njc3OSArMDAwMApAQCAtMzUwLDcgKzM1MCw3IEBACiAJcy0+c19tYWdpYyA9
IEJGU19NQUdJQzsKIAogCWlmIChsZTMyX3RvX2NwdShiZnNfc2ItPnNfc3RhcnQpID4gbGUzMl90
b19jcHUoYmZzX3NiLT5zX2VuZCkgfHwKLQkgICAgbGUzMl90b19jcHUoYmZzX3NiLT5zX3N0YXJ0
KSA8IEJGU19CU0laRSkgeworCSAgICBsZTMyX3RvX2NwdShiZnNfc2ItPnNfc3RhcnQpIDwgc2l6
ZW9mKHN0cnVjdCBiZnNfc3VwZXJfYmxvY2spICsgc2l6ZW9mKHN0cnVjdCBiZnNfZGlyZW50KSkg
ewogCQlwcmludGYoIlN1cGVyYmxvY2sgaXMgY29ycnVwdGVkXG4iKTsKIAkJZ290byBvdXQxOwog
CX0K
--00000000000027909b057c105565--
