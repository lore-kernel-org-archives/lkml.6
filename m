Return-Path: <SRS0=KDb5=I5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 0E02FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7E1F2086D
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jun 2018 21:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C44984j9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7E1F2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933876AbeFKVwi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jun 2018 17:52:38 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:33750 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932230AbeFKVwf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 17:52:35 -0400
Received: by mail-ot0-f194.google.com with SMTP id h6-v6so25663056otj.0;
        Mon, 11 Jun 2018 14:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=XyPbqVuScJglDySmIXdE7l9rpzjOQMA1Ui06yBBJp8Y=;
        b=C44984j9TqINqq4dDvzjX43HUGD1IxfjgS+MvZTrZF9McS6o8OIJ93cE9+GJut7Xm/
         RKTIvVg9lb8KpQQ5kdJysDYkOuznATrKfrWYuzntIDpSxCF6TXuNMyUNAnqFFMH9kZdi
         OtkuR76Lvx47N7oqN11eArsXDPFw4uHhkTYqiRhgNtuqPf+0y45xUfZBHSjmxgr2WSCB
         /s/jZQlIT+eczTy1r4SrylBeksNuLwgZRp0ofyZn1M4XgNJtLx2/asJGDhnkt5Q/x572
         cA4i052M1jzPlSA+U1TEGvsBep2EKLv2bDmgL1b8mTE3XTAwmlw+fMRo/l5aRPUtKIL/
         CKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=XyPbqVuScJglDySmIXdE7l9rpzjOQMA1Ui06yBBJp8Y=;
        b=oPlnbGYo+cHsWnAdtnV4YfaaXGYglyLzws7uMCB975ueSgXBGQMZUKGIU2AXBXyWwO
         bc66m32tu4NwZ5GI4+75kq7zco1hbfuFZ9G2JhNQyVrgHups4hoyB0bPOWHSSdkAqO3D
         DO5dOg6F3nf4Rf+JYlSBCIBoVQcvT2FdoTIqBbe/QS9wklM0INbCdWhSg3eeEgb2WnJ9
         VH36NrYAC4A7KZSHqVkoIjcvzmnM1FK3KbskHMqRgC5+FSL4obJLOwX7frAzF5JJupOw
         ztLh4QFQ07C57sf2hZWJuH8Xr2G4PbGdSyxt4n99LMnUHIgoaDNS6vN6FYRTcrETeZyL
         3kAw==
X-Gm-Message-State: APt69E2zq4pRH1YsQvGR5YruNTADrF8+28vf1ju7yWCIcYmfnOtuLCEf
        u+j7M4rS1D5d6VDJk4KoVhMwc1k1iyHCvN/G4pQ=
X-Google-Smtp-Source: ADUXVKLEBehAH5W7FQve3RnP8RBcPUk+u4gX2B3+R4WY1JTq6IMQ0SXGvKG+UQOGkvkGLL/GR4vpOg7tsKj0H34I2pg=
X-Received: by 2002:a9d:cc7:: with SMTP id o7-v6mr604181otd.291.1528753955017;
 Mon, 11 Jun 2018 14:52:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 11 Jun 2018 14:52:34
 -0700 (PDT)
In-Reply-To: <CAJZ5v0iyNo+ZZ1O0_j4p6w-+eS1W9MUYs-vjeNHVENFVhReGzw@mail.gmail.com>
References: <DEA1AE84-B0FD-481E-8E0D-788CD4EF59AE@canonical.com> <CAJZ5v0iyNo+ZZ1O0_j4p6w-+eS1W9MUYs-vjeNHVENFVhReGzw@mail.gmail.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 11 Jun 2018 23:52:34 +0200
X-Google-Sender-Auth: UqG1_o5hdI4Q6-lQbVvexS3KHM4
Message-ID: <CAJZ5v0jiWugSt98MXOLUKAsig=uWFsTHK1Mntvy6z0JfiWt9sQ@mail.gmail.com>
Subject: Re: Possible regression caused by commit a192aa923b66a
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        P HeLiOn <perryhelionsemail@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000703623056e64c488"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000703623056e64c488
Content-Type: text/plain; charset="UTF-8"

On Mon, Jun 11, 2018 at 10:09 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Mon, Jun 11, 2018 at 8:26 AM, Kai-Heng Feng
> <kai.heng.feng@canonical.com> wrote:
>> Hi Rafael,
>>
>> There's a regression report [1] that says commit a192aa923b66a ("ACPI /
>> LPSS: Consolidate runtime PM and system sleep handling") is the first bad
>> commit.
>>
>> From the looks of it, it didn't introduce any behavioral change. So your
>> help is appreciated.
>>
>> [1] https://bugs.launchpad.net/bugs/1774950
>
> Well, the only difference is the iosf quirk AFAICS, but that should be
> easy enough to check.  I'll try to cut a patch for that later today.

If the iosf quirk is the source of the problem, the attached patch should help.

--000000000000703623056e64c488
Content-Type: text/x-patch; charset="US-ASCII"; name="acpi-lpss-pm-debug.patch"
Content-Disposition: attachment; filename="acpi-lpss-pm-debug.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jiasl9xg0

LS0tCiBkcml2ZXJzL2FjcGkvYWNwaV9scHNzLmMgfCAgIDE3ICsrKysrKysrKystLS0tLS0tCiAx
IGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKCkluZGV4OiBs
aW51eC1wbS9kcml2ZXJzL2FjcGkvYWNwaV9scHNzLmMKPT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtcG0u
b3JpZy9kcml2ZXJzL2FjcGkvYWNwaV9scHNzLmMKKysrIGxpbnV4LXBtL2RyaXZlcnMvYWNwaS9h
Y3BpX2xwc3MuYwpAQCAtOTQwLDkgKzk0MCwxMCBAQCBzdGF0aWMgdm9pZCBscHNzX2lvc2ZfZXhp
dF9kM19zdGF0ZSh2b2lkCiAJbXV0ZXhfdW5sb2NrKCZscHNzX2lvc2ZfbXV0ZXgpOwogfQogCi1z
dGF0aWMgaW50IGFjcGlfbHBzc19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgYm9vbCB3YWtl
dXApCitzdGF0aWMgaW50IGFjcGlfbHBzc19zdXNwZW5kKHN0cnVjdCBkZXZpY2UgKmRldiwgYm9v
bCBydW50aW1lKQogewogCXN0cnVjdCBscHNzX3ByaXZhdGVfZGF0YSAqcGRhdGEgPSBhY3BpX2Ry
aXZlcl9kYXRhKEFDUElfQ09NUEFOSU9OKGRldikpOworCWJvb2wgd2FrZXVwID0gcnVudGltZSB8
fCBkZXZpY2VfbWF5X3dha2V1cChkZXYpOwogCWludCByZXQ7CiAKIAlpZiAocGRhdGEtPmRldl9k
ZXNjLT5mbGFncyAmIExQU1NfU0FWRV9DVFgpCkBAIC05NTUsMTMgKzk1NiwxNCBAQCBzdGF0aWMg
aW50IGFjcGlfbHBzc19zdXNwZW5kKHN0cnVjdCBkZXZpCiAJICogd3Jvbmcgc3RhdHVzIGZvciBk
ZXZpY2VzIGJlaW5nIGFib3V0IHRvIGJlIHBvd2VyZWQgb2ZmLiBTZWUKIAkgKiBscHNzX2lvc2Zf
ZW50ZXJfZDNfc3RhdGUoKSBmb3IgZnVydGhlciBpbmZvcm1hdGlvbi4KIAkgKi8KLQlpZiAobHBz
c19xdWlya3MgJiBMUFNTX1FVSVJLX0FMV0FZU19QT1dFUl9PTiAmJiBpb3NmX21iaV9hdmFpbGFi
bGUoKSkKKwlpZiAocnVudGltZSAmJiBscHNzX3F1aXJrcyAmIExQU1NfUVVJUktfQUxXQVlTX1BP
V0VSX09OICYmCisJICAgIGlvc2ZfbWJpX2F2YWlsYWJsZSgpKQogCQlscHNzX2lvc2ZfZW50ZXJf
ZDNfc3RhdGUoKTsKIAogCXJldHVybiByZXQ7CiB9CiAKLXN0YXRpYyBpbnQgYWNwaV9scHNzX3Jl
c3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpCitzdGF0aWMgaW50IGFjcGlfbHBzc19yZXN1bWUoc3Ry
dWN0IGRldmljZSAqZGV2LCBib29sIHJ1bnRpbWUpCiB7CiAJc3RydWN0IGxwc3NfcHJpdmF0ZV9k
YXRhICpwZGF0YSA9IGFjcGlfZHJpdmVyX2RhdGEoQUNQSV9DT01QQU5JT04oZGV2KSk7CiAJaW50
IHJldDsKQEAgLTk3MCw3ICs5NzIsOCBAQCBzdGF0aWMgaW50IGFjcGlfbHBzc19yZXN1bWUoc3Ry
dWN0IGRldmljCiAJICogVGhpcyBjYWxsIGlzIGtlcHQgZmlyc3QgdG8gYmUgaW4gc3ltbWV0cnkg
d2l0aAogCSAqIGFjcGlfbHBzc19ydW50aW1lX3N1c3BlbmQoKSBvbmUuCiAJICovCi0JaWYgKGxw
c3NfcXVpcmtzICYgTFBTU19RVUlSS19BTFdBWVNfUE9XRVJfT04gJiYgaW9zZl9tYmlfYXZhaWxh
YmxlKCkpCisJaWYgKHJ1bnRpbWUgJiYgbHBzc19xdWlya3MgJiBMUFNTX1FVSVJLX0FMV0FZU19Q
T1dFUl9PTiAmJgorCSAgICBpb3NmX21iaV9hdmFpbGFibGUoKSkKIAkJbHBzc19pb3NmX2V4aXRf
ZDNfc3RhdGUoKTsKIAogCXJldCA9IGFjcGlfZGV2X3Jlc3VtZShkZXYpOwpAQCAtOTk0LDEyICs5
OTcsMTIgQEAgc3RhdGljIGludCBhY3BpX2xwc3Nfc3VzcGVuZF9sYXRlKHN0cnVjdAogCQlyZXR1
cm4gMDsKIAogCXJldCA9IHBtX2dlbmVyaWNfc3VzcGVuZF9sYXRlKGRldik7Ci0JcmV0dXJuIHJl
dCA/IHJldCA6IGFjcGlfbHBzc19zdXNwZW5kKGRldiwgZGV2aWNlX21heV93YWtldXAoZGV2KSk7
CisJcmV0dXJuIHJldCA/IHJldCA6IGFjcGlfbHBzc19zdXNwZW5kKGRldiwgZmFsc2UpOwogfQog
CiBzdGF0aWMgaW50IGFjcGlfbHBzc19yZXN1bWVfZWFybHkoc3RydWN0IGRldmljZSAqZGV2KQog
ewotCWludCByZXQgPSBhY3BpX2xwc3NfcmVzdW1lKGRldik7CisJaW50IHJldCA9IGFjcGlfbHBz
c19yZXN1bWUoZGV2LCBmYWxzZSk7CiAKIAlyZXR1cm4gcmV0ID8gcmV0IDogcG1fZ2VuZXJpY19y
ZXN1bWVfZWFybHkoZGV2KTsKIH0KQEAgLTEwMTQsNyArMTAxNyw3IEBAIHN0YXRpYyBpbnQgYWNw
aV9scHNzX3J1bnRpbWVfc3VzcGVuZChzdHIKIAogc3RhdGljIGludCBhY3BpX2xwc3NfcnVudGlt
ZV9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQogewotCWludCByZXQgPSBhY3BpX2xwc3NfcmVz
dW1lKGRldik7CisJaW50IHJldCA9IGFjcGlfbHBzc19yZXN1bWUoZGV2LCB0cnVlKTsKIAogCXJl
dHVybiByZXQgPyByZXQgOiBwbV9nZW5lcmljX3J1bnRpbWVfcmVzdW1lKGRldik7CiB9Cg==
--000000000000703623056e64c488--
