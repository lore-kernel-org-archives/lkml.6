Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752713AbeDQRVs (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 13:21:48 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36008 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeDQRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 13:21:46 -0400
X-Google-Smtp-Source: AIpwx49H17VV7gKcrV+ffkP149YLIHCXwIbkb9V1KvTeLTLSnZKrS1SwCYzbq9ZBPi5BnnUDtQGpLXi+4o6liB2XVRc=
MIME-Version: 1.0
From: Sebastian Kuzminsky <seb.kuzminsky@gmail.com>
Date: Tue, 17 Apr 2018 11:21:44 -0600
Message-ID: <CAOTh5U2NwGU68cwzX2amhzPyj_=f0pm4CO4biR4m1DX49MJkUw@mail.gmail.com>
Subject: fix for bnx2x panic during ethtool reporting
To: linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="001a113ada8899ae69056a0e92ca"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a113ada8899ae69056a0e92ca
Content-Type: text/plain; charset="UTF-8"

"ethtool -i" on a bnx2x interface causes kernel panic when the
firmware version is longer than expected.  The attached patch fixes
the problem by simplifying the string handling in bnx2x_fill_fw_str().
It applies cleanly to 4.14 and 4.17-rc1.

--
Sebastian Kuzminsky

--001a113ada8899ae69056a0e92ca
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-bnx2x-make-fw-str-in-a-non-crazy-way.patch"
Content-Disposition: attachment;
	filename="0001-bnx2x-make-fw-str-in-a-non-crazy-way.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jg3xqlgz0

RnJvbSA3NmFkN2E0MWU4NDY3NDUxOWQyZDVmNDdlNDJjODQ2OTdlYTNmMjNjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWJhc3RpYW4gS3V6bWluc2t5IDxzZWJAaGlnaGxhYi5jb20+
CkRhdGU6IE1vbiwgMTYgQXByIDIwMTggMjM6MjQ6MDcgKzAwMDAKU3ViamVjdDogW1BBVENIXSBi
bngyeDogbWFrZSBmdyBzdHIgaW4gYSBub24tY3Jhenkgd2F5CgpUaGlzIGZpeGVzIGFuIHVudGVy
bWluYXRlZCBzdHJpbmcgYnVnIHdoZW4gdGhlIGZpcndtYXJlIHZlcnNpb24KKGJwLT5md192ZXIp
IGlzIGxvbmdlciB0aGFuIHRoZSBwYXNzZWQtaW4gYnVmZmVyIChidWYvYnVmX2xlbikuCi0tLQog
ZHJpdmVycy9uZXQvZXRoZXJuZXQvYnJvYWRjb20vYm54MngvYm54MnhfY21uLmMgfCA2ICsrKy0t
LQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRpZmYg
LS1naXQgYS9kcml2ZXJzL25ldC9ldGhlcm5ldC9icm9hZGNvbS9ibngyeC9ibngyeF9jbW4uYyBi
L2RyaXZlcnMvbmV0L2V0aGVybmV0L2Jyb2FkY29tL2JueDJ4L2JueDJ4X2Ntbi5jCmluZGV4IDY3
ZmUzZDgyNjU2Ni4uNTUzNGNlZTBhYWI4IDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC9ldGhlcm5l
dC9icm9hZGNvbS9ibngyeC9ibngyeF9jbW4uYworKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9i
cm9hZGNvbS9ibngyeC9ibngyeF9jbW4uYwpAQCAtMTUwLDkgKzE1MCw5IEBAIHZvaWQgYm54Mnhf
ZmlsbF9md19zdHIoc3RydWN0IGJueDJ4ICpicCwgY2hhciAqYnVmLCBzaXplX3QgYnVmX2xlbikK
IAkJcGh5X2Z3X3ZlclswXSA9ICdcMCc7CiAJCWJueDJ4X2dldF9leHRfcGh5X2Z3X3ZlcnNpb24o
JmJwLT5saW5rX3BhcmFtcywKIAkJCQkJICAgICBwaHlfZndfdmVyLCBQSFlfRldfVkVSX0xFTik7
Ci0JCXN0cmxjcHkoYnVmLCBicC0+ZndfdmVyLCBidWZfbGVuKTsKLQkJc25wcmludGYoYnVmICsg
c3RybGVuKGJwLT5md192ZXIpLCAzMiAtIHN0cmxlbihicC0+ZndfdmVyKSwKLQkJCSAiYmMgJWQu
JWQuJWQlcyVzIiwKKwkJc25wcmludGYoYnVmLCBidWZfbGVuLAorCQkJICIlcyBiYyAlZC4lZC4l
ZCVzJXMiLAorCQkJIGJwLT5md192ZXIsCiAJCQkgKGJwLT5jb21tb24uYmNfdmVyICYgMHhmZjAw
MDApID4+IDE2LAogCQkJIChicC0+Y29tbW9uLmJjX3ZlciAmIDB4ZmYwMCkgPj4gOCwKIAkJCSAo
YnAtPmNvbW1vbi5iY192ZXIgJiAweGZmKSwKLS0gCjIuMTEuMAoK
--001a113ada8899ae69056a0e92ca--
