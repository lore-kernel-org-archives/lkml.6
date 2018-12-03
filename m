Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC6FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB79A21486
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 09:55:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ntek37qY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB79A21486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbeLCJz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 04:55:57 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36279 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeLCJz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 04:55:56 -0500
Received: by mail-wm1-f65.google.com with SMTP id a18so4961710wmj.1;
        Mon, 03 Dec 2018 01:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=oquu/FLEYKFqheu1MmlHCc7UFKoKcnbDa1+fz6cQYyw=;
        b=ntek37qYIOE2AVdo9ePJ3B97NwFWQmBmJN4ubwhG5SC2ZZGvqCGyWR13GR3bHuR7fJ
         EG6DjBBZOTruN4/bgRJ+YquY5MN+2bL6VIM1g8p/5Ly5HLahYCcGEOMWBQBjCd+WXAcl
         LJEvVWzBso39+Nd1UUjF8tZQFcvFKbONy7fYwuQbENg9ebcwF3D9bP2C2yAUoquf/kQ6
         Ov/dKLZJiopX/TQY2He6daotI+/qCOSEcON6MOMBt2e+UnTU0Hjb9HYarpW7JPR2QycV
         ZvP4LmfQ/FcWpi5ZSLpIsjNGQHWE2dlLDeRRD4GcULjf2gAX3sfve8pTm+7mQVLlYNRM
         zYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=oquu/FLEYKFqheu1MmlHCc7UFKoKcnbDa1+fz6cQYyw=;
        b=RaQoA0EKAYqGX3ct4UHpIGryMvFP6AOXNJzf8k99g6HvYpyv11N7WltSuXy5CNs/6k
         o7HPZM163ftiM4SOsuFhJUQINXcuLJhPqxx2dACrJCl9GUvOTFgc+hJ+hjXcebyllUcn
         uuFSqRyMr8lqW6spD3qElRH0z4L75R2O+xtxI1elNocDke+j4KgGDHLeFelpWEc5Ek17
         XZ7OYB+HN+dS4XgJdbABQVrU7vi5BTzCXYKAP1djVdjJF7mUpE5OS6XUcn4Q/3uc93YQ
         BzJ59ftd3CHCcAvtheOlnD4CkKCcNHMg5veYAwL9fl8+C6RGVrjfaSeWgTPTQjLuFpJr
         258g==
X-Gm-Message-State: AA+aEWasxpJykL79r5SNtUfNdb9/q6BNcrYN3b+yjpO86H06slnxOMoV
        FQ/IRIVr+sy4kSExHIq3xSYN/LWUcPQpt9WsUCo5KQ==
X-Google-Smtp-Source: AFSGD/W2lNCq5ymchhm8sH+YHYqBKeodnuPpszYR5lQAk4WGsHD/8ASSIjF/IotoDkKc7nYnSn/7Fq9iNz/ZYrQ1dv0=
X-Received: by 2002:a1c:934b:: with SMTP id v72mr4250395wmd.5.1543830935350;
 Mon, 03 Dec 2018 01:55:35 -0800 (PST)
MIME-Version: 1.0
References: <CAK+_RLnYbyDrqRbm6-AyRmG4=iFrqqL_UrzHuhPO1_jD1F9WSQ@mail.gmail.com>
 <CAK+_RLk=WL1SxtNF7YRw5eLGjcCc9o2dcHodgFw7SoFPSm25Xw@mail.gmail.com>
In-Reply-To: <CAK+_RLk=WL1SxtNF7YRw5eLGjcCc9o2dcHodgFw7SoFPSm25Xw@mail.gmail.com>
From:   Tigran Aivazian <aivazian.tigran@gmail.com>
Date:   Mon, 3 Dec 2018 09:55:23 +0000
Message-ID: <CAK+_RLmJTrc3P0q0rzjoo4LD=g2cyA0eRwoVUtg-V8kPYEg7eg@mail.gmail.com>
Subject: Re: [patch set 4.19.6] BFS updates
To:     torvalds@linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org, gregkh@linuxfoundation.org
Content-Type: multipart/mixed; boundary="0000000000007ede09057c1b2647"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000007ede09057c1b2647
Content-Type: text/plain; charset="UTF-8"

Re-sending the patches with the "Cc: stable@vger.kernel.org" included
in the sign-off area, as per Option 1 of the rules Greg referred me
to. I hope that now I have done everything by the rules.

On Sun, 2 Dec 2018 at 21:42, Tigran Aivazian <aivazian.tigran@gmail.com> wrote:
>
> just wanted to add: although the subject says "4.19.6" the patches
> apply perfectly to the top of "torvalds/linux" tree from github.
> On Sun, 2 Dec 2018 at 21:01, Tigran Aivazian <aivazian.tigran@gmail.com> wrote:
> >
> > Hi Linus,
> >
> > I attached two incremental patches for BFS:
> >
> > 1. Make inode bitmap allocation static (applies on top of 4.19.6)
> > 2. Strengthen the superblock sanity checking code (applies on top of 1. above)
> >
> > Kind regards,
> > Tigran

--0000000000007ede09057c1b2647
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="bfs-4.19.6-1-of-2-static-inode-bitmap.patch"
Content-Disposition: attachment; 
	filename="bfs-4.19.6-1-of-2-static-inode-bitmap.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jp84ycg10>
X-Attachment-Id: f_jp84ycg10

RnJvbTogVGlncmFuIEFpdmF6aWFuIDxhaXZhemlhbi50aWdyYW5AZ21haWwuY29tPgpTdWJqZWN0
OiBbUEFUQ0ggNC4xOS42IDEvMl0gQkZTIHVwZGF0ZXMKCk1ha2UgaW4tY29yZSBpbm9kZSBiaXRt
YXAgc3RhdGljIHBhcnQgb2Ygc3VwZXJibG9jayBpbmZvIHN0cnVjdHVyZSBhbi4KcHJpbnQgYSB3
YXJuaW5nIHdoZW4gbW91bnRpbmcgYSBCRlMgZmlsZXN5c3RlbSBjcmVhdGVkIHdpdGggIi1OIDUx
MiIKb3B0aW9uIGFzIG9ubHkgNTEwIGZpbGVzIGNhbiBiZSBjcmVhdGVkIGluIHRoZSByb290IGRp
cmVjdG9yeS4KClNpZ25lZC1vZmYtYnk6IFRpZ3JhbiBBaXZhemlhbiA8YWl2YXppYW4udGlncmFu
QGdtYWlsLmNvbT4KQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKLS0tCgogYmZzLmggICB8ICAg
IDkgKysrKysrKystCiBpbm9kZS5jIHwgICAyNyArKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0K
IDIgZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pCgotLS0g
ZnMvYmZzL2Jmcy5oLjAJMjAxOC0xMi0wMiAyMDozMzowMi4yNTI3MTAyOTEgKzAwMDAKKysrIGZz
L2Jmcy9iZnMuaAkyMDE4LTEyLTAyIDIwOjM0OjM0LjA0MTI0NjQ4OSArMDAwMApAQCAtOCw2ICs4
LDEzIEBACiAKICNpbmNsdWRlIDxsaW51eC9iZnNfZnMuaD4KIAorLyogSW4gdGhlb3J5IEJGUyBz
dXBwb3J0cyB1cCB0byA1MTIgaW5vZGVzLCBudW1iZXJlZCBmcm9tIDIgKGZvciAvKSB1cCB0byA1
MTMgaW5jbHVzaXZlLgorICAgSW4gYWN0dWFsIGZhY3QsIGF0dGVtcHRpbmcgdG8gY3JlYXRlIHRo
ZSA1MTJ0aCBpbm9kZSAoaS5lLiBpbm9kZSBOby4gNTEzIG9yIGZpbGUgTm8uIDUxMSkKKyAgIHdp
bGwgZmFpbCB3aXRoIEVOT1NQQyBpbiBiZnNfYWRkX2VudHJ5KCk6IHRoZSByb290IGRpcmVjdG9y
eSBjYW5ub3QgY29udGFpbiBzbyBtYW55IGVudHJpZXMsIGNvdW50aW5nICcuLicuCisgICBTbywg
bWtmcy5iZnMoOCkgc2hvdWxkIHJlYWxseSBsaW1pdCBpdHMgLU4gb3B0aW9uIHRvIDUxMSBhbmQg
bm90IDUxMi4gRm9yIG5vdywgd2UganVzdCBwcmludCBhIHdhcm5pbmcKKyAgIGlmIGEgZmlsZXN5
c3RlbSBpcyBtb3VudGVkIHdpdGggc3VjaCAiaW1wb3NzaWJsZSB0byBmaWxsIHVwIiBudW1iZXIg
b2YgaW5vZGVzICovCisjZGVmaW5lIEJGU19NQVhfTEFTVEkJNTEzCisKIC8qCiAgKiBCRlMgZmls
ZSBzeXN0ZW0gaW4tY29yZSBzdXBlcmJsb2NrIGluZm8KICAqLwpAQCAtMTcsNyArMjQsNyBAQAog
CXVuc2lnbmVkIGxvbmcgc2lfZnJlZWk7CiAJdW5zaWduZWQgbG9uZyBzaV9sZl9lYmxrOwogCXVu
c2lnbmVkIGxvbmcgc2lfbGFzdGk7Ci0JdW5zaWduZWQgbG9uZyAqc2lfaW1hcDsKKwlERUNMQVJF
X0JJVE1BUChzaV9pbWFwLCBCRlNfTUFYX0xBU1RJKzEpOwogCXN0cnVjdCBtdXRleCBiZnNfbG9j
azsKIH07CiAKLS0tIGZzL2Jmcy9pbm9kZS5jLjAJMjAxOC0xMi0wMiAyMDozNDowMy4yMTE3NDA4
NzcgKzAwMDAKKysrIGZzL2Jmcy9pbm9kZS5jCTIwMTgtMTItMDIgMjA6MzY6NTQuNTA4OTYzODEz
ICswMDAwCkBAIC0yMTQsNyArMjE0LDYgQEAKIAkJcmV0dXJuOwogCiAJbXV0ZXhfZGVzdHJveSgm
aW5mby0+YmZzX2xvY2spOwotCWtmcmVlKGluZm8tPnNpX2ltYXApOwogCWtmcmVlKGluZm8pOwog
CXMtPnNfZnNfaW5mbyA9IE5VTEw7CiB9CkBAIC0zMjIsNyArMzIxLDcgQEAKIAlzdHJ1Y3QgYnVm
ZmVyX2hlYWQgKmJoLCAqc2JoOwogCXN0cnVjdCBiZnNfc3VwZXJfYmxvY2sgKmJmc19zYjsKIAlz
dHJ1Y3QgaW5vZGUgKmlub2RlOwotCXVuc2lnbmVkIGksIGltYXBfbGVuOworCXVuc2lnbmVkIGk7
CiAJc3RydWN0IGJmc19zYl9pbmZvICppbmZvOwogCWludCByZXQgPSAtRUlOVkFMOwogCXVuc2ln
bmVkIGxvbmcgaV9zYmxvY2ssIGlfZWJsb2NrLCBpX2VvZmYsIHNfc2l6ZTsKQEAgLTM1NiwxMyAr
MzU1LDExIEBACiAJCWdvdG8gb3V0MTsKIAl9CiAKLQlpbmZvLT5zaV9sYXN0aSA9IChsZTMyX3Rv
X2NwdShiZnNfc2ItPnNfc3RhcnQpIC0gQkZTX0JTSVpFKSAvCi0JCQkJCXNpemVvZihzdHJ1Y3Qg
YmZzX2lub2RlKQotCQkJCQkrIEJGU19ST09UX0lOTyAtIDE7Ci0JaW1hcF9sZW4gPSAoaW5mby0+
c2lfbGFzdGkgLyA4KSArIDE7Ci0JaW5mby0+c2lfaW1hcCA9IGt6YWxsb2MoaW1hcF9sZW4sIEdG
UF9LRVJORUwgfCBfX0dGUF9OT1dBUk4pOwotCWlmICghaW5mby0+c2lfaW1hcCkgewotCQlwcmlu
dGYoIkNhbm5vdCBhbGxvY2F0ZSAldSBieXRlc1xuIiwgaW1hcF9sZW4pOworCWluZm8tPnNpX2xh
c3RpID0gKGxlMzJfdG9fY3B1KGJmc19zYi0+c19zdGFydCkgLSBCRlNfQlNJWkUpIC8gc2l6ZW9m
KHN0cnVjdCBiZnNfaW5vZGUpICsgQkZTX1JPT1RfSU5PIC0gMTsKKwlpZiAoaW5mby0+c2lfbGFz
dGkgPT0gQkZTX01BWF9MQVNUSSkKKwkJcHJpbnRmKCJXQVJOSU5HOiBmaWxlc3lzdGVtICVzIHdh
cyBjcmVhdGVkIHdpdGggNTEyIGlub2RlcywgdGhlIHJlYWwgbWF4aW11bSBpcyA1MTEsIG1vdW50
aW5nIGFueXdheVxuIiwgcy0+c19pZCk7CisJZWxzZSBpZiAoaW5mby0+c2lfbGFzdGkgPiBCRlNf
TUFYX0xBU1RJKSB7CisJCXByaW50ZigiSW1wb3NzaWJsZSBsYXN0IGlub2RlIG51bWJlciAlbHUg
PiAlZCBvbiAlc1xuIiwgaW5mby0+c2lfbGFzdGksIEJGU19NQVhfTEFTVEksIHMtPnNfaWQpOwog
CQlnb3RvIG91dDE7CiAJfQogCWZvciAoaSA9IDA7IGkgPCBCRlNfUk9PVF9JTk87IGkrKykKQEAg
LTM3MiwxMiArMzY5LDEyIEBACiAJaW5vZGUgPSBiZnNfaWdldChzLCBCRlNfUk9PVF9JTk8pOwog
CWlmIChJU19FUlIoaW5vZGUpKSB7CiAJCXJldCA9IFBUUl9FUlIoaW5vZGUpOwotCQlnb3RvIG91
dDI7CisJCWdvdG8gb3V0MTsKIAl9CiAJcy0+c19yb290ID0gZF9tYWtlX3Jvb3QoaW5vZGUpOwog
CWlmICghcy0+c19yb290KSB7CiAJCXJldCA9IC1FTk9NRU07Ci0JCWdvdG8gb3V0MjsKKwkJZ290
byBvdXQxOwogCX0KIAogCWluZm8tPnNpX2Jsb2NrcyA9IChsZTMyX3RvX2NwdShiZnNfc2ItPnNf
ZW5kKSArIDEpID4+IEJGU19CU0laRV9CSVRTOwpAQCAtMzkxLDcgKzM4OCw3IEBACiAJaWYgKCFi
aCkgewogCQlwcmludGYoIkxhc3QgYmxvY2sgbm90IGF2YWlsYWJsZTogJWx1XG4iLCBpbmZvLT5z
aV9ibG9ja3MgLSAxKTsKIAkJcmV0ID0gLUVJTzsKLQkJZ290byBvdXQzOworCQlnb3RvIG91dDI7
CiAJfQogCWJyZWxzZShiaCk7CiAKQEAgLTQyOSw3ICs0MjYsNyBAQAogCiAJCQlicmVsc2UoYmgp
OwogCQkJcmV0ID0gLUVJTzsKLQkJCWdvdG8gb3V0MzsKKwkJCWdvdG8gb3V0MjsKIAkJfQogCiAJ
CWlmICghZGktPmlfaW5vKSB7CkBAIC00NDgsMTEgKzQ0NSw5IEBACiAJYmZzX2R1bXBfaW1hcCgi
cmVhZF9zdXBlciIsIHMpOwogCXJldHVybiAwOwogCi1vdXQzOgorb3V0MjoKIAlkcHV0KHMtPnNf
cm9vdCk7CiAJcy0+c19yb290ID0gTlVMTDsKLW91dDI6Ci0Ja2ZyZWUoaW5mby0+c2lfaW1hcCk7
CiBvdXQxOgogCWJyZWxzZShzYmgpOwogb3V0Ogo=
--0000000000007ede09057c1b2647
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="bfs-4.19.6-2-of-2-strengthen-sanity-checking.patch"
Content-Disposition: attachment; 
	filename="bfs-4.19.6-2-of-2-strengthen-sanity-checking.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_jp84ycge1>
X-Attachment-Id: f_jp84ycge1

RnJvbTogVGlncmFuIEFpdmF6aWFuIDxhaXZhemlhbi50aWdyYW5AZ21haWwuY29tPgpTdWJqZWN0
OiBbUEFUQ0ggNC4xOS42IDIvMl0gQkZTIHVwZGF0ZXMKClN0cmVuZ3RoZW4gdGhlIHN1cGVyYmxv
Y2sgc2FuaXR5IGNoZWNraW5nIChzdXBlcnNlZGVzIHRoZSBjb2RlCnRoYXQgd2VudCBpbnRvIDQu
MTkuNikuCgpTaWduZWQtb2ZmLWJ5OiBUaWdyYW4gQWl2YXppYW4gPGFpdmF6aWFuLnRpZ3JhbkBn
bWFpbC5jb20+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCi0tLQoKIGlub2RlLmMgfCAgICAy
ICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCi0tLSBm
cy9iZnMvaW5vZGUuYy4wCTIwMTgtMTItMDIgMjA6NDk6MDAuNTI1NDYxMzU0ICswMDAwCisrKyBm
cy9iZnMvaW5vZGUuYwkyMDE4LTEyLTAyIDIwOjQ5OjUxLjA1NDY4Njc3OSArMDAwMApAQCAtMzUw
LDcgKzM1MCw3IEBACiAJcy0+c19tYWdpYyA9IEJGU19NQUdJQzsKIAogCWlmIChsZTMyX3RvX2Nw
dShiZnNfc2ItPnNfc3RhcnQpID4gbGUzMl90b19jcHUoYmZzX3NiLT5zX2VuZCkgfHwKLQkgICAg
bGUzMl90b19jcHUoYmZzX3NiLT5zX3N0YXJ0KSA8IEJGU19CU0laRSkgeworCSAgICBsZTMyX3Rv
X2NwdShiZnNfc2ItPnNfc3RhcnQpIDwgc2l6ZW9mKHN0cnVjdCBiZnNfc3VwZXJfYmxvY2spICsg
c2l6ZW9mKHN0cnVjdCBiZnNfZGlyZW50KSkgewogCQlwcmludGYoIlN1cGVyYmxvY2sgaXMgY29y
cnVwdGVkXG4iKTsKIAkJZ290byBvdXQxOwogCX0K
--0000000000007ede09057c1b2647--
