Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753031AbeAaRXs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 12:23:48 -0500
Received: from mail-it0-f52.google.com ([209.85.214.52]:52437 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbeAaRXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 12:23:46 -0500
X-Google-Smtp-Source: AH8x227wYc7Xndlo4vEPVXfNXpbDFqb01h0Yad9Pm2CkfG0/QD7KY5hoMs64XARRSw4RkG9xDR4etgj/zbumDYYiYMc=
MIME-Version: 1.0
From: Joel Fernandes <joelaf@google.com>
Date: Wed, 31 Jan 2018 09:23:44 -0800
Message-ID: <CAJWu+opcuaeBHJPTOc2N-UyCe9r+jvhbVhq4pTTYoYa9_YLABQ@mail.gmail.com>
Subject: Re: possible deadlock in shmem_file_llseek
To: Dmitry Vyukov <dvyukov@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+8ec30bb7bf1a981a2012@syzkaller.appspotmail.com>,
        Hugh Dickins <hughd@google.com>, Linux-MM <linux-mm@kvack.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="001a1143f624d64363056415bd91"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a1143f624d64363056415bd91
Content-Type: text/plain; charset="UTF-8"

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
master

--001a1143f624d64363056415bd91
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-ashmem-Fix-lockdep-issue-during-llseek.patch"
Content-Disposition: attachment;
	filename="0001-ashmem-Fix-lockdep-issue-during-llseek.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jd127f2q1

RnJvbSBlN2Q3MzM2MmVkMzc4NDk5Nzk1ZjI3ZTJkYTYxODRkMGIyNDJiODljIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKb2VsIEZlcm5hbmRlcyA8am9lbGFmQGdvb2dsZS5jb20+CkRh
dGU6IFdlZCwgMjQgSmFuIDIwMTggMDk6NDc6MjMgLTA4MDAKU3ViamVjdDogW1BBVENIXSBhc2ht
ZW06IEZpeCBsb2NrZGVwIGlzc3VlIGR1cmluZyBsbHNlZWsKCmFzaG1lbV9tdXRleCBjcmVhdGUg
YSBjaGFpbiBvZiBkZXBlbmRlbmNpZXMgbGlrZSBzbzoKCigxKQptbWFwIHN5c2NhbGwgLT4KICBt
bWFwX3NlbSAtPiAgKGFjcXVpcmVkKQogIGFzaG1lbV9tbWFwCiAgYXNobWVtX211dGV4ICh0cnkg
dG8gYWNxdWlyZSkKICAoYmxvY2spCgooMikKbGxzZWVrIHN5c2NhbGwgLT4KICBhc2htZW1fbGxz
ZWVrIC0+CiAgYXNobWVtX211dGV4IC0+ICAoYWNxdWlyZWQpCiAgaW5vZGVfbG9jayAtPgogIGlu
b2RlLT5pX3J3c2VtICh0cnkgdG8gYWNxdWlyZSkKICAoYmxvY2spCgooMykKZ2V0ZGVudHMgLT4K
ICBpdGVyYXRlX2RpciAtPgogIGlub2RlX2xvY2sgLT4KICBpbm9kZS0+aV9yd3NlbSAgIChhY3F1
aXJlZCkKICBjb3B5X3RvX3VzZXIgLT4KICBtbWFwX3NlbSAgICAgICAgICh0cnkgdG8gYWNxdWly
ZSkKClRoZXJlIGlzIGEgbG9jayBvcmRlcmluZyBjcmVhdGVkIGJldHdlZW4gbW1hcF9zZW0gYW5k
IGlub2RlLT5pX3J3c2VtIGNhdXNpbmcgYQpsb2NrZGVwIHNwbGF0IFsyXSBkdXJpbmcgYSBzeXpj
YWxsZXIgdGVzdCwgdGhpcyBwYXRjaCBmaXhlcyB0aGUgaXNzdWUgYnkKcmVtb3ZpbmcgdGhlIHVz
ZSBvZiB0aGUgbXV0ZXguCgpUaGUgbXV0ZXggaXNuJ3QgbmVlZGVkIGFzIGxsc2Vla3MgYXJlIHN5
bmNocm9uaXplZCB3aXRoIG90aGVyIGxsc2Vla3MKYW5kIHJlYWRzIGR1ZSB0byBmZGdldF9wb3Mg
YXMgQWwgbWVudGlvbmVkIFsxXS4gRnVydGhlciBhc21hLT5maWxlCmFuZCBhc21hLT5zaXplIGRv
bid0IGNoYW5nZSBvbmNlIHRoZXkncmUgc2V0dXAsIGFuZCB0aGVyZSdzIGEgdW5pcXVlCmFzbWEt
PmZpbGUgcGVyIGZpbGUuCgpbMV0gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wYXRjaC8x
MDE4NTAzMS8KWzJdIGh0dHBzOi8vbGttbC5vcmcvbGttbC8yMDE4LzEvMTAvNDgKCkNjOiBUb2Rk
IEtqb3MgPHRram9zQGdvb2dsZS5jb20+CkNjOiBBcnZlIEhqb25uZXZhZyA8YXJ2ZUBhbmRyb2lk
LmNvbT4KQ2M6IEFsIFZpcm8gPHZpcm9AemVuaXYubGludXgub3JnLnVrPgpDYzogR3JlZyBLcm9h
aC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KUmVwb3J0ZWQtYnk6IHN5emJv
dCs4ZWMzMGJiN2JmMWE5ODFhMjAxMkBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29tClNpZ25lZC1v
ZmYtYnk6IEpvZWwgRmVybmFuZGVzIDxqb2VsYWZAZ29vZ2xlLmNvbT4KLS0tCiBkcml2ZXJzL3N0
YWdpbmcvYW5kcm9pZC9hc2htZW0uYyB8IDMgLS0tCiAxIGZpbGUgY2hhbmdlZCwgMyBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3N0YWdpbmcvYW5kcm9pZC9hc2htZW0uYyBiL2Ry
aXZlcnMvc3RhZ2luZy9hbmRyb2lkL2FzaG1lbS5jCmluZGV4IDBmNjk1ZGYxNGM5ZC4uOGM5YzY5
YTkzZmE0IDEwMDY0NAotLS0gYS9kcml2ZXJzL3N0YWdpbmcvYW5kcm9pZC9hc2htZW0uYworKysg
Yi9kcml2ZXJzL3N0YWdpbmcvYW5kcm9pZC9hc2htZW0uYwpAQCAtMzMxLDggKzMzMSw2IEBAIHN0
YXRpYyBsb2ZmX3QgYXNobWVtX2xsc2VlayhzdHJ1Y3QgZmlsZSAqZmlsZSwgbG9mZl90IG9mZnNl
dCwgaW50IG9yaWdpbikKIAlzdHJ1Y3QgYXNobWVtX2FyZWEgKmFzbWEgPSBmaWxlLT5wcml2YXRl
X2RhdGE7CiAJaW50IHJldDsKIAotCW11dGV4X2xvY2soJmFzaG1lbV9tdXRleCk7Ci0KIAlpZiAo
YXNtYS0+c2l6ZSA9PSAwKSB7CiAJCXJldCA9IC1FSU5WQUw7CiAJCWdvdG8gb3V0OwpAQCAtMzUx
LDcgKzM0OSw2IEBAIHN0YXRpYyBsb2ZmX3QgYXNobWVtX2xsc2VlayhzdHJ1Y3QgZmlsZSAqZmls
ZSwgbG9mZl90IG9mZnNldCwgaW50IG9yaWdpbikKIAlmaWxlLT5mX3BvcyA9IGFzbWEtPmZpbGUt
PmZfcG9zOwogCiBvdXQ6Ci0JbXV0ZXhfdW5sb2NrKCZhc2htZW1fbXV0ZXgpOwogCXJldHVybiBy
ZXQ7CiB9CiAKLS0gCjIuMTYuMC5yYzEuMjM4Lmc1MzBkNjQ5YTc5LWdvb2cKCg==
--001a1143f624d64363056415bd91--
