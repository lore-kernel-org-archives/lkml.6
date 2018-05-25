Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936048AbeEYIYQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 04:24:16 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35903 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935921AbeEYIYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 04:24:15 -0400
X-Google-Smtp-Source: ADUXVKK2W8UFR19HVRQx6BIsaLVAUAWF40w1HiSE9MxBcnn6rkdAUewtxpKZ0aKdJ3yueto6lFS1w1g/1SZh30bz020=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
References: <CAKwvOd=jmi_7LvZbS0PA5-zt62m5ZFPUNG7JtMQVmerCR63ebQ@mail.gmail.com>
 <BDEF22F0-84A5-4A36-B153-13E6A4260922@zytor.com> <CAKwvOdnLt5qr_5ah86qdsocTxUbo_3X1y3PPRp1EZwt=__NxnA@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Fri, 25 May 2018 10:24:13 +0200
Message-ID: <CA+icZUW099w_0_UP0-O7N2P29SCMcU--AU15NTtu6Eg6GoV-7A@mail.gmail.com>
Subject: Re: [clang] stack protector and f1f029c7bf
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: hpa@zytor.com, Alistair Strachan <astrachan@google.com>,
        Manoj Gupta <manojgupta@google.com>,
        Matthias Kaehlcke <mka@google.com>,
        Greg Hackmann <ghackmann@google.com>, tstellar@redhat.com,
        LKML <linux-kernel@vger.kernel.org>, Kees Cook <keescook@google.com>
Content-Type: multipart/mixed; boundary="00000000000040ea6c056d037e34"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000040ea6c056d037e34
Content-Type: text/plain; charset="UTF-8"

On Thu, May 24, 2018 at 10:26 PM, Nick Desaulniers
<ndesaulniers@google.com> wrote:
[...]
>> Issue 2: ... The other option is to turn stack canary explicitly off for
> all such functions.
>
> We're looking to add the compiler attribute no_stack_protector.  It's added
> in mainline clang, the llvm bug cited earlier is about getting it
> backported into clang-6.0.1 release.  Sedat has tested/verified a set of
> patches to the kernel that use this new feature in:
> https://marc.info/?l=linux-kernel&m=152697630812366&w=2
>
Hi Nick,

sorry, if I was not clear/precise on this.
You referenced the patches from my 1st tryouts which were wrong in the
sense of "did-not-compile".
I have attached the correct two patches.
The commit-bodies needs some more "massage" to quote Thomas Gleixner,
useful web-links and credits should be added also.
I appreciate your help here.

>From my understanding...
The more correct approach in fixing the issue is to add Clang's
"no_stack_protector" function attribute support and mark
native_save_fl() accordingly.
The 2nd solution partly revert "x86: allow "=rm" in native_save_fl()"
is not favoured as the impact on other parts of the Linux-kernel are
not clear.
The 1st solution requires a Clang >= 7-svn331925.
Is that correct?

What does that mean in fixing the issue?
[ Linux-kernel side ]
I guess GCC and marking native_save_fl() should be OK?
After some rework, do you plan to push patches from the 1st solution
to Linus uptream?
[ LLVM/Clang side ]
What about backporting "no_stack_protector" to LLVM/Clang v6.0.1?

Thanks to all involved people.

Sunshiny greetings from North-West Germany,
- Sedat -

--00000000000040ea6c056d037e34
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-compiler-clang.h-Add-no_stack_protector-function-att.patch"
Content-Disposition: attachment;
	filename="0001-compiler-clang.h-Add-no_stack_protector-function-att.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jhlp9jzm0

RnJvbSBjNjhjZWY5MDQ4ZTk2YWYxMjExYTU3YmQ3YTVmNmNhNmVmZGZjN2IyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAY3JlZGF0aXYuZGU+
CkRhdGU6IEZyaSwgMjUgTWF5IDIwMTggMDk6NDA6MDcgKzAyMDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gY29tcGlsZXItY2xhbmcuaDogQWRkIG5vX3N0YWNrX3Byb3RlY3RvciBmdW5jdGlvbgogYXR0
cmlidXRlIHN1cHBvcnQKCkZyb20gWzFdOgoKIkNsYW5nIHN1cHBvcnRzIHRoZSBfX2F0dHJpYnV0
ZV9fKChub19zdGFja19wcm90ZWN0b3IpKSBhdHRyaWJ1dGUgd2hpY2gKZGlzYWJsZXMgdGhlIHN0
YWNrIHByb3RlY3RvciBvbiB0aGUgc3BlY2lmaWVkIGZ1bmN0aW9uLgpUaGlzIGF0dHJpYnV0ZSBp
cyB1c2VmdWwgZm9yIHNlbGVjdGl2ZWx5IGRpc2FibGluZyB0aGUgc3RhY2sgcHJvdGVjdG9yCm9u
IHNvbWUgZnVuY3Rpb25zIHdoZW4gYnVpbGRpbmcgd2l0aCAtZnN0YWNrLXByb3RlY3RvciBjb21w
aWxlciBvcHRpb24uIgoKVGhpcyBpcyBuZWVkZWQgdG8gbWFyayBuYXRpdmVfc2F2ZV9mbCgpIHdp
dGggX19ub3N0YWNrcHJvdGVjdG9yIGF0dHJpYnV0ZSB0bwpmaXggYSBidWcgaW4gdGhlIHg4Ni9w
YXJhdmlydC9zdGFja3Byb3RlY3RvciBhcmVhIHdpdGggQ2xhbmcgKHNlZSBbMl0gYW5kIFszXSku
CgpOT1RFOiBDbGFuZy03ICg+PSBzdm4zMzE5MjUpIHN1cHBvcnRzIG5vX3N0YWNrX3Byb3RlY3Rv
ciBmdW5jdGlvbiBhdHRyaWJ1dGUuCgpbMV0gaHR0cHM6Ly9jbGFuZy5sbHZtLm9yZy9kb2NzL0F0
dHJpYnV0ZVJlZmVyZW5jZS5odG1sI25vLXN0YWNrLXByb3RlY3Rvci1jbGFuZy1uby1zdGFjay1w
cm90ZWN0b3ItY2xhbmctbm8tc3RhY2stcHJvdGVjdG9yClsyXSBodHRwczovL2J1Z3MubGx2bS5v
cmcvc2hvd19idWcuY2dpP2lkPTM3NTEyClszXSBodHRwczovL2dpdGh1Yi5jb20vQ2xhbmdCdWls
dExpbnV4L2xpbnV4L2lzc3Vlcy8xNgotLS0KIGluY2x1ZGUvbGludXgvY29tcGlsZXItY2xhbmcu
aCB8IDYgKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0
IGEvaW5jbHVkZS9saW51eC9jb21waWxlci1jbGFuZy5oIGIvaW5jbHVkZS9saW51eC9jb21waWxl
ci1jbGFuZy5oCmluZGV4IDA3MGY4NWQ5MmMxNS4uNWY0OWZmMGJmN2VlIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L2NvbXBpbGVyLWNsYW5nLmgKKysrIGIvaW5jbHVkZS9saW51eC9jb21waWxl
ci1jbGFuZy5oCkBAIC0yMSwzICsyMSw5IEBACiAjaWZkZWYgX19ub3JldHBvbGluZQogI3VuZGVm
IF9fbm9yZXRwb2xpbmUKICNlbmRpZgorCisvKiBDbGFuZy03ICg+PSBzdm4zMzE5MjUpIHN1cHBv
cnRzIG5vX3N0YWNrX3Byb3RlY3RvciBmdW5jdGlvbiBhdHRyaWJ1dGUuICovCisjaWZkZWYgX19u
b3N0YWNrcHJvdGVjdG9yCisjdW5kZWYgX19ub3N0YWNrcHJvdGVjdG9yCisjZGVmaW5lIF9fbm9z
dGFja3Byb3RlY3RvciBfX2F0dHJpYnV0ZV9fKChub19zdGFja19wcm90ZWN0b3IpKQorI2VuZGlm
Ci0tIAoyLjE3LjAKCg==
--00000000000040ea6c056d037e34
Content-Type: text/x-patch; charset="US-ASCII";
	name="0002-x86-paravirt-Mark-native_save_fl-with-__nostackprote.patch"
Content-Disposition: attachment;
	filename="0002-x86-paravirt-Mark-native_save_fl-with-__nostackprote.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jhlp9mly1

RnJvbSAyZTFkYzE1OTlhZjZlNTk5YWZkOWVkYTcwZTlkMmQ4MTljYzdkZjBjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAY3JlZGF0aXYuZGU+
CkRhdGU6IFR1ZSwgMjIgTWF5IDIwMTggMTI6MDc6MjQgKzAyMDAKU3ViamVjdDogW1BBVENIIDIv
Ml0geDg2L3BhcmF2aXJ0OiBNYXJrIG5hdGl2ZV9zYXZlX2ZsKCkgd2l0aAogX19ub3N0YWNrcHJv
dGVjdG9yIGF0dHJpYnV0ZQoKRm9yIGRldGFpbHMgcGxlYXNlIHNlZSBbMV0gYW5kIFsyXS4KClRo
aXMgcmVxdWlyZXMgQ2xhbmctNyAoPj0gc3ZuMzMxOTI1KSB3aGljaCBzdXBwb3J0cyBfX25vc3Rh
Y2twcm90ZWN0b3IgYXR0cmlidXRlLgoKWzFdIGh0dHBzOi8vYnVncy5sbHZtLm9yZy9zaG93X2J1
Zy5jZ2k/aWQ9Mzc1MTIKWzJdIGh0dHBzOi8vZ2l0aHViLmNvbS9DbGFuZ0J1aWx0TGludXgvbGlu
dXgvaXNzdWVzLzE2Ci0tLQogYXJjaC94ODYvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaCB8IDIgKy0K
IDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2lycWZsYWdzLmggYi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9pcnFmbGFncy5oCmluZGV4IDg5ZjA4OTU1ZmZmNy4uN2U2NzY1MDk3YWRjIDEwMDY0NAotLS0g
YS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9pcnFmbGFncy5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2lycWZsYWdzLmgKQEAgLTEzLDcgKzEzLDcgQEAKICAqIEludGVycnVwdCBjb250cm9sOgog
ICovCiAKLXN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBuYXRpdmVfc2F2ZV9mbCh2b2lkKQor
c3RhdGljIGlubGluZSBfX25vc3RhY2twcm90ZWN0b3IgdW5zaWduZWQgbG9uZyBuYXRpdmVfc2F2
ZV9mbCh2b2lkKQogewogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKLS0gCjIuMTcuMAoK
--00000000000040ea6c056d037e34--
