Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752943AbeDLQua (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 12:50:30 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:39434 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752558AbeDLQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 12:50:28 -0400
X-Google-Smtp-Source: AIpwx4+Iod0hwv2/+7pCR1i6M36IlIE23fs83NIcWNe9Nl8O/V4jnBNyrgA5ha1tl3CUpWJtGjVycGqolHXYNmtqXa4=
MIME-Version: 1.0
In-Reply-To: <20180412131404.GE16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org> <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk> <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk> <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 09:50:26 -0700
X-Google-Sender-Auth: wFyfWXyp-VN6ptEMKyRrxEiTY1k
Message-ID: <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: "Dmitry V. Levin" <ldv@altlinux.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: multipart/mixed; boundary="001a114a4cf279af070569a98d65"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a114a4cf279af070569a98d65
Content-Type: text/plain; charset="UTF-8"

Does this attached patch perhaps fix the ARM case?

It just uses FPE_FLTUNK as the default si_code for SIGFPE, which seems
sane enough. And then gets rid of FPE_FIXME, which should resolve the
nasty case.

Hmm? Entirely untested, and I didn't really look at the test-case in
question since I can't really run it anyway.

Well, I could run it all on x86-64, but it doesn't have that FPE_FIXME
case at all.

                 Linus

--001a114a4cf279af070569a98d65
Content-Type: text/x-patch; charset="US-ASCII"; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jfwr8nhj0

IGFyY2gvYXJtL2luY2x1ZGUvdWFwaS9hc20vc2lnaW5mby5oIHwgNyAtLS0tLS0tCiBhcmNoL2Fy
bS92ZnAvdmZwbW9kdWxlLmMgICAgICAgICAgICB8IDQgKystLQogMiBmaWxlcyBjaGFuZ2VkLCAy
IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vaW5j
bHVkZS91YXBpL2FzbS9zaWdpbmZvLmggYi9hcmNoL2FybS9pbmNsdWRlL3VhcGkvYXNtL3NpZ2lu
Zm8uaAppbmRleCBkMDUxMzg4MGJlMjEuLmQ4N2JlZWVkYjRjNCAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vaW5jbHVkZS91YXBpL2FzbS9zaWdpbmZvLmgKKysrIGIvYXJjaC9hcm0vaW5jbHVkZS91YXBp
L2FzbS9zaWdpbmZvLmgKQEAgLTMsMTEgKzMsNCBAQAogCiAjaW5jbHVkZSA8YXNtLWdlbmVyaWMv
c2lnaW5mby5oPgogCi0vKgotICogU0lHRlBFIHNpX2NvZGVzCi0gKi8KLSNpZmRlZiBfX0tFUk5F
TF9fCi0jZGVmaW5lIEZQRV9GSVhNRQkwCS8qIEJyb2tlbiBkdXAgb2YgU0lfVVNFUiAqLwotI2Vu
ZGlmIC8qIF9fS0VSTkVMX18gKi8KLQogI2VuZGlmCmRpZmYgLS1naXQgYS9hcmNoL2FybS92ZnAv
dmZwbW9kdWxlLmMgYi9hcmNoL2FybS92ZnAvdmZwbW9kdWxlLmMKaW5kZXggNGMzNzVlMTFhZTk1
Li4wMTJjNmU2OTAzMDMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL3ZmcC92ZnBtb2R1bGUuYworKysg
Yi9hcmNoL2FybS92ZnAvdmZwbW9kdWxlLmMKQEAgLTI1MSwxMyArMjUxLDEzIEBAIHN0YXRpYyB2
b2lkIHZmcF9wYW5pYyhjaGFyICpyZWFzb24sIHUzMiBpbnN0KQogICovCiBzdGF0aWMgdm9pZCB2
ZnBfcmFpc2VfZXhjZXB0aW9ucyh1MzIgZXhjZXB0aW9ucywgdTMyIGluc3QsIHUzMiBmcHNjciwg
c3RydWN0IHB0X3JlZ3MgKnJlZ3MpCiB7Ci0JaW50IHNpX2NvZGUgPSAwOworCWludCBzaV9jb2Rl
ID0gRlBFX0ZMVFVOSzsKIAogCXByX2RlYnVnKCJWRlA6IHJhaXNpbmcgZXhjZXB0aW9ucyAlMDh4
XG4iLCBleGNlcHRpb25zKTsKIAogCWlmIChleGNlcHRpb25zID09IFZGUF9FWENFUFRJT05fRVJS
T1IpIHsKIAkJdmZwX3BhbmljKCJ1bmhhbmRsZWQgYm91bmNlIiwgaW5zdCk7Ci0JCXZmcF9yYWlz
ZV9zaWdmcGUoRlBFX0ZJWE1FLCByZWdzKTsKKwkJdmZwX3JhaXNlX3NpZ2ZwZShzaV9jb2RlLCBy
ZWdzKTsKIAkJcmV0dXJuOwogCX0KIAo=
--001a114a4cf279af070569a98d65--
