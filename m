Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752166AbeBFDQB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 22:16:01 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54259 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750999AbeBFDPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 22:15:55 -0500
X-Google-Smtp-Source: AH8x225MikRvoLzBZFK9gUjJFhFcQLKU5bpPi+UEmtemxftsjGsmJX8IVVUWNIZ6vRrIxugo6tVC7CbUYVXqhwoVEms=
MIME-Version: 1.0
From: ping xie <xpinglsr@gmail.com>
Date: Tue, 6 Feb 2018 11:15:53 +0800
Message-ID: <CAL6vEvr6ZQ-0bqFA=epdxXTJFVSRHfOa7anaVjTD_c2iCPEczg@mail.gmail.com>
Subject: [PATCH] linux 2.6.36 netfilter conntrack: Fix conntrack table full
 error when low memory
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="089e08282f20b26f6705648298cc"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--089e08282f20b26f6705648298cc
Content-Type: text/plain; charset="UTF-8"



--089e08282f20b26f6705648298cc
Content-Type: application/octet-stream;
	name="0001-linux2.6.36-netfilter-conntrack-Fix-conntrack-table-full-error-w.patch"
Content-Disposition: attachment;
	filename="0001-linux2.6.36-netfilter-conntrack-Fix-conntrack-table-full-error-w.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jdb2l33o0

RnJvbSA5OTU3OWRiMWVmMWRhOTVkOTgyNDVlNWU5YWRkODI0MzA0MGY2OGUzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiB4aWVwaW5nIDx4cGluZ2xzckBnbWFpbC5jb20+CkRhdGU6IE1v
biwgNSBGZWIgMjAxOCAxOTowNzoyMiArMDgwMApTdWJqZWN0OiBbUEFUQ0hdIGxpbnV4IDIuNi4z
NiBuZXRmaWx0ZXIgY29ubnRyYWNrOiBGaXggY29ubnRyYWNrIHRhYmxlIGZ1bGwgZXJyb3Igd2hl
biBsb3cKIG1lbW9yeQoKbmV0LT5jdC5jb3VudCB3aWxsIGJlIGluY3JlYXNlZCBhdCB0aGUgYmVn
aW5uaW5nIG9mIG5mX2Nvbm50cmFja19hbGxvYy4gRm9yCm5mX2N0X3pvbmUgPSBuZl9jdF9leHRf
YWRkKGN0LCBORl9DVF9FWFRfWk9ORSwgR0ZQX0FUT01JQykgd2hlbiBpbiBsb3cgbWVtb3J5LAog
bmZfY3Rfem9uZSB3aWxsIGJlIE5VTEwgYW5kIGdvdG8gb3V0X2ZyZWUgLiBJbiB0aGlzIGNhc2Us
IG5ldC0+Y3QuY291bnQgc2hvdWxkCmJlIGRlY3JlYXNlZC4KClNpZ25lZC1vZmYtYnk6IHhpZXBp
bmcgPHhwaW5nbHNyQGdtYWlsLmNvbT4KLS0tCiBuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19j
b3JlLmMgfCAgICAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQogbW9kZSBjaGFu
Z2UgMTAwNjQ0ID0+IDEwMDc1NSBuZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19jb3JlLmMKCmRp
ZmYgLS1naXQgYS9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19jb3JlLmMgYi9uZXQvbmV0Zmls
dGVyL25mX2Nvbm50cmFja19jb3JlLmMKb2xkIG1vZGUgMTAwNjQ0Cm5ldyBtb2RlIDEwMDc1NQpp
bmRleCBhMzdhNmIxLi5jMTZlZTQ0Ci0tLSBhL25ldC9uZXRmaWx0ZXIvbmZfY29ubnRyYWNrX2Nv
cmUuYworKysgYi9uZXQvbmV0ZmlsdGVyL25mX2Nvbm50cmFja19jb3JlLmMKQEAgLTYzOSw2ICs2
MzksNyBAQCBzdHJ1Y3QgbmZfY29ubiAqbmZfY29ubnRyYWNrX2FsbG9jKHN0cnVjdCBuZXQgKm5l
dCwgdTE2IHpvbmUsCiAKICNpZmRlZiBDT05GSUdfTkZfQ09OTlRSQUNLX1pPTkVTCiBvdXRfZnJl
ZToKKwlhdG9taWNfZGVjKCZuZXQtPmN0LmNvdW50KTsKIAlrbWVtX2NhY2hlX2ZyZWUobmV0LT5j
dC5uZl9jb25udHJhY2tfY2FjaGVwLCBjdCk7CiAJcmV0dXJuIEVSUl9QVFIoLUVOT01FTSk7CiAj
ZW5kaWYKLS0gCjEuNy45LjUKCg==
--089e08282f20b26f6705648298cc--
