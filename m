Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S971829AbeCSU55 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 16:57:57 -0400
Received: from mail-ot0-f169.google.com ([74.125.82.169]:42827 "EHLO
        mail-ot0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S971562AbeCSU5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 16:57:48 -0400
X-Google-Smtp-Source: AG47ELuBYff0IREI5oA9vLPglFlX+ljagjQ8TKRUur5xmYJZAR72tXuXKWboMYSybdHrPv2w9WdRlT8eHkmlsEGRLxI=
MIME-Version: 1.0
From: "H.J. Lu" <hjl.tools@gmail.com>
Date: Mon, 19 Mar 2018 13:57:46 -0700
Message-ID: <CAMe9rOp4_=_8twdpTyAP2DhONOCeaTOsniJLoppzhoNptL8xzA@mail.gmail.com>
Subject: [PATCH] x86-64: Force linker to use 2MB page size
To: LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d11cb20567ca35db"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000d11cb20567ca35db
Content-Type: text/plain; charset="UTF-8"

Binutils 2.31 will enable -z separate-code by default for x86 to avoid
mixing code pages with data to improve cache performance as well as
security.  To reduce x86-64 executable and shared object sizes, the
maximum page size is reduced from 2MB to 4KB.  But x86-64 kernel must
be aligned to 2MB.  Pass -z max-page-size=0x200000 to linker to force
2MB page size regardless of the default page size used by linker.

Tested with Linux kernel 4.15.6 on x86-64.

Signed-off-by: H.J. Lu <hjl.tools@gmail.com>

-- 
H.J.

--000000000000d11cb20567ca35db
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-x86-64-Force-linker-to-use-2MB-page-size.patch"
Content-Disposition: attachment;
	filename="0001-x86-64-Force-linker-to-use-2MB-page-size.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jeypoaok0

RnJvbSBjNWMyN2I4MmQyZTE5YWRkNTM3MmE2YjJlYWEwMDExOWU4OTZkOWZmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiAiSC5KLiBMdSIgPGhqbC50b29sc0BnbWFpbC5jb20+CkRhdGU6
IEZyaSwgMTYgRmViIDIwMTggMTQ6MDc6MzggLTA4MDAKU3ViamVjdDogW1BBVENIXSB4ODYtNjQ6
IEZvcmNlIGxpbmtlciB0byB1c2UgMk1CIHBhZ2Ugc2l6ZQoKQmludXRpbHMgMi4zMSB3aWxsIGVu
YWJsZSAteiBzZXBhcmF0ZS1jb2RlIGJ5IGRlZmF1bHQgZm9yIHg4NiB0byBhdm9pZAptaXhpbmcg
Y29kZSBwYWdlcyB3aXRoIGRhdGEgdG8gaW1wcm92ZSBjYWNoZSBwZXJmb3JtYW5jZSBhcyB3ZWxs
IGFzCnNlY3VyaXR5LiAgVG8gcmVkdWNlIHg4Ni02NCBleGVjdXRhYmxlIGFuZCBzaGFyZWQgb2Jq
ZWN0IHNpemVzLCB0aGUKbWF4aW11bSBwYWdlIHNpemUgaXMgcmVkdWNlZCBmcm9tIDJNQiB0byA0
S0IuICBCdXQgeDg2LTY0IGtlcm5lbCBtdXN0CmJlIGFsaWduZWQgdG8gMk1CLiAgUGFzcyAteiBt
YXgtcGFnZS1zaXplPTB4MjAwMDAwIHRvIGxpbmtlciB0byBmb3JjZQoyTUIgcGFnZSBzaXplIHJl
Z2FyZGxlc3Mgb2YgdGhlIGRlZmF1bHQgcGFnZSBzaXplIHVzZWQgYnkgbGlua2VyLgoKVGVzdGVk
IHdpdGggTGludXgga2VybmVsIDQuMTUuNiBvbiB4ODYtNjQuCgpTaWduZWQtb2ZmLWJ5OiBILkou
IEx1IDxoamwudG9vbHNAZ21haWwuY29tPgotLS0KIGFyY2gveDg2L01ha2VmaWxlIHwgNiArKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9hcmNoL3g4
Ni9NYWtlZmlsZSBiL2FyY2gveDg2L01ha2VmaWxlCmluZGV4IDY4ZjQ5NjM1MDFhZS4uZGMyNDE5
ODgzYzk3IDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9NYWtlZmlsZQorKysgYi9hcmNoL3g4Ni9NYWtl
ZmlsZQpAQCAtMjI5LDYgKzIyOSwxMiBAQCBLQlVJTERfQUZMQUdTICs9ICQoY2ZpKSAkKGNmaS1z
aWdmcmFtZSkgJChjZmktc2VjdGlvbnMpICQoYXNpbnN0cikgJChhdnhfaW5zdHIpCiBLQlVJTERf
Q0ZMQUdTICs9ICQoY2ZpKSAkKGNmaS1zaWdmcmFtZSkgJChjZmktc2VjdGlvbnMpICQoYXNpbnN0
cikgJChhdnhfaW5zdHIpICQoYXZ4Ml9pbnN0cikgJChhdng1MTJfaW5zdHIpICQoc2hhMV9uaV9p
bnN0cikgJChzaGEyNTZfbmlfaW5zdHIpCiAKIExERkxBR1MgOj0gLW0gZWxmXyQoVVRTX01BQ0hJ
TkUpCitpZmRlZiBDT05GSUdfWDg2XzY0CisjIFg4Ni02NCBrZXJuZWwgbXVzdCBiZSBhbGlnbmVk
IHRvIDJNQi4gIFBhc3MgLXogbWF4LXBhZ2Utc2l6ZT0weDIwMDAwMCB0bworIyBsaW5rZXIgdG8g
Zm9yY2UgMk1CIHBhZ2Ugc2l6ZSByZWdhcmRsZXNzIG9mIHRoZSBkZWZhdWx0IHBhZ2Ugc2l6ZSB1
c2VkCisjIGJ5IGxpbmtlci4KK0xERkxBR1MgKz0gJChjYWxsIGxkLW9wdGlvbiwgLXogbWF4LXBh
Z2Utc2l6ZT0weDIwMDAwMCkKK2VuZGlmCiAKICMgU3BlZWQgdXAgdGhlIGJ1aWxkCiBLQlVJTERf
Q0ZMQUdTICs9IC1waXBlCi0tIAoyLjE0LjMKCg==
--000000000000d11cb20567ca35db--
