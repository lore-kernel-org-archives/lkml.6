Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752074AbeCLIbC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 04:31:02 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39550 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLIbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 04:31:01 -0400
X-Google-Smtp-Source: AG47ELtqa9+1mtS0HgLiKLmBHpW19BwydRx6WFWkTmZ3VnxHK2+pTl/2w9MSzGNZwtE5Tg8cxwhB4xndvAWpQGGawrM=
MIME-Version: 1.0
In-Reply-To: <CALyZvKx0AfVvhD3gs7mWMA_PE08JHoFSzk4rJWSozsCU9YLWmg@mail.gmail.com>
References: <d109lwfe.fsf@gmail.com> <alpine.DEB.2.21.1803112350190.1485@nanos.tec.linutronix.de>
 <20180312072413.toyd5ztkgaah35xg@gmail.com> <CALyZvKx0AfVvhD3gs7mWMA_PE08JHoFSzk4rJWSozsCU9YLWmg@mail.gmail.com>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Mon, 12 Mar 2018 08:30:59 +0000
Message-ID: <CALyZvKxnSXat40mqyQFEaKLzAVOd6xjf1teO3GTeP76_ShEtuQ@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc4 1/2] x86/vdso: on Intel, VDSO should handle CLOCK_MONOTONIC_RAW
To: x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, andi <andi@firstfloor.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: multipart/mixed; boundary="001a113cd4f637bfe6056732f6b7"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--001a113cd4f637bfe6056732f6b7
Content-Type: text/plain; charset="UTF-8"

Good day -

On 12/03/2018, Ingo Molnar <mingo@kernel.org> wrote:
>
> * Thomas Gleixner <tglx@linutronix.de> wrote:
>
>> On Mon, 12 Mar 2018, Jason Vas Dias wrote:
>>
>> checkpatch.pl still reports:
>>
>>    total: 15 errors, 3 warnings, 165 lines checked
>>

Sorry I didn't see you had responded until 40 mins ago .

I finally found where checkpatch.pl is and it now reports :

WARNING: Possible unwrapped commit description (prefer a maximum 75
chars per line)
#2:
--- linux-4.16-rc5.1/arch/x86/entry/vdso/vclock_gettime.c.4.16-rc5	2018-03-12
00:25:09.000000000 +0000

WARNING: struct  should normally be const
#55: FILE: arch/x86/entry/vdso/vclock_gettime.c:282:
+notrace static __always_inline int do_monotonic_raw(struct timespec *ts)


I don't know how to fix that, since 'ts' cannot be a const pointer.


ERROR: Missing Signed-off-by: line(s)


I guess that disappears once someone OKs the patch.

total: 1 errors, 2 warnings, 127 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

../vdso_vclock_gettime_CLOCK_MONOTONIC_RAW-4.16-rc5#1.patch has style
problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


>> > +notrace static u64 vread_tsc_raw(void)
>> > +{
>> > +	u64 tsc, last=gtod->raw_cycle_last;
>> > +	if( likely( gtod->has_rdtscp ) )
>> > +		tsc	= rdtscp((void*)0);
>>
>> Plus I asked more than once to split that rdtscp() stuff into a separate
>> patch.

I misunderstood - I thought you meant the rdtscp implementation
which was split into a separate file - but now it is in a separate patch ,
(attached).

>>
>> You surely are free to ignore my review comments, but rest assured that
>> I'm
>> free to ignore the crap you insist to send me as well.
>

I didn't mean to ignore any comments, and I'm really trying to fix this problem
the right way and not produce crap.


> In addition to Thomas's review feedback I'd strongly urge the careful
> reading of
> Documentation/SubmittingPatches as well:
>
>  - When sending multiple patches please use git-send-mail
>
>  - Please don't send several patch iterations per day!
>
>  - Code quality of the submitted patches is atrocious, please run them
> through
>    scripts/checkpatch.pl (and make sure they pass) to at least enable the
> reading
>    of them.
>
>  - ... plus dozens of other details described in
> Documentation/SubmittingPatches.
>
> Thanks,
>
> 	Ingo
>

I am reading all those documents and cannot see how the code in
the attached patch contravenes any guidelines / best practices -
if you can, please clarify phrases like "atrocious style" - I cannot
see any style guidelines contravened, and I can prove that
the numeric output produced in 16-30ns is just as good
as that produced before the patch was applied in 300-700ns .

Aside from any style comments, any content comments ?

Sorry I am new to latest kernel  guidelines.
I needed to get this problem solved the right way for use at work today.

Thanks for your advice,
Best Regards
Jason

--001a113cd4f637bfe6056732f6b7
Content-Type: application/octet-stream;
	name="vdso_vclock_gettime_CLOCK_MONOTONIC_RAW-4.16-rc5#1.patch"
Content-Disposition: attachment;
	filename="vdso_vclock_gettime_CLOCK_MONOTONIC_RAW-4.16-rc5#1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: file0

ZGlmZiAtdXAgbGludXgtNC4xNi1yYzUuMS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3ZjbG9ja19nZXR0
aW1lLmMuNC4xNi1yYzUgbGludXgtNC4xNi1yYzUuMS9hcmNoL3g4Ni9lbnRyeS92ZHNvL3ZjbG9j
a19nZXR0aW1lLmMKLS0tIGxpbnV4LTQuMTYtcmM1LjEvYXJjaC94ODYvZW50cnkvdmRzby92Y2xv
Y2tfZ2V0dGltZS5jLjQuMTYtcmM1CTIwMTgtMDMtMTIgMDA6MjU6MDkuMDAwMDAwMDAwICswMDAw
CisrKyBsaW51eC00LjE2LXJjNS4xL2FyY2gveDg2L2VudHJ5L3Zkc28vdmNsb2NrX2dldHRpbWUu
YwkyMDE4LTAzLTEyIDA4OjEyOjE3LjExMDEyMDQzMyArMDAwMApAQCAtMTgyLDYgKzE4MiwxOCBA
QCBub3RyYWNlIHN0YXRpYyB1NjQgdnJlYWRfdHNjKHZvaWQpCiAJcmV0dXJuIGxhc3Q7CiB9CiAK
K25vdHJhY2Ugc3RhdGljIHU2NCB2cmVhZF90c2NfcmF3KHZvaWQpCit7CisJdTY0IHRzYworCSAg
LCBsYXN0ID0gZ3RvZC0+cmF3X2N5Y2xlX2xhc3Q7CisKKwl0c2MJICAgICAgPSByZHRzY19vcmRl
cmVkKCk7CisJaWYgKGxpa2VseSh0c2MgPj0gbGFzdCkpCisJCXJldHVybiB0c2M7CisJYXNtIHZv
bGF0aWxlICgiIik7CisJcmV0dXJuIGxhc3Q7Cit9CisKIG5vdHJhY2Ugc3RhdGljIGlubGluZSB1
NjQgdmdldHNucyhpbnQgKm1vZGUpCiB7CiAJdTY0IHY7CkBAIC0yMDMsNiArMjE1LDI3IEBAIG5v
dHJhY2Ugc3RhdGljIGlubGluZSB1NjQgdmdldHNucyhpbnQgKm0KIAlyZXR1cm4gdiAqIGd0b2Qt
Pm11bHQ7CiB9CiAKK25vdHJhY2Ugc3RhdGljIGlubGluZSB1NjQgdmdldHNuc19yYXcoaW50ICpt
b2RlKQoreworCXU2NCB2OworCWN5Y2xlc190IGN5Y2xlczsKKworCWlmIChndG9kLT52Y2xvY2tf
bW9kZSA9PSBWQ0xPQ0tfVFNDKQorCQljeWNsZXMgPSB2cmVhZF90c2NfcmF3KCk7CisjaWZkZWYg
Q09ORklHX1BBUkFWSVJUX0NMT0NLCisJZWxzZSBpZiAoZ3RvZC0+dmNsb2NrX21vZGUgPT0gVkNM
T0NLX1BWQ0xPQ0spCisJCWN5Y2xlcyA9IHZyZWFkX3B2Y2xvY2sobW9kZSk7CisjZW5kaWYKKyNp
ZmRlZiBDT05GSUdfSFlQRVJWX1RTQ1BBR0UKKwllbHNlIGlmIChndG9kLT52Y2xvY2tfbW9kZSA9
PSBWQ0xPQ0tfSFZDTE9DSykKKwkJY3ljbGVzID0gdnJlYWRfaHZjbG9jayhtb2RlKTsKKyNlbmRp
ZgorCWVsc2UKKwkJcmV0dXJuIDA7CisJdiA9IChjeWNsZXMgLSBndG9kLT5yYXdfY3ljbGVfbGFz
dCkgJiBndG9kLT5yYXdfbWFzazsKKwlyZXR1cm4gdiAqIGd0b2QtPnJhd19tdWx0OworfQorCiAv
KiBDb2RlIHNpemUgZG9lc24ndCBtYXR0ZXIgKHZkc28gaXMgNGsgYW55d2F5KSBhbmQgdGhpcyBp
cyBmYXN0ZXIuICovCiBub3RyYWNlIHN0YXRpYyBpbnQgX19hbHdheXNfaW5saW5lIGRvX3JlYWx0
aW1lKHN0cnVjdCB0aW1lc3BlYyAqdHMpCiB7CkBAIC0yNDYsNiArMjc5LDI3IEBAIG5vdHJhY2Ug
c3RhdGljIGludCBfX2Fsd2F5c19pbmxpbmUgZG9fbW8KIAlyZXR1cm4gbW9kZTsKIH0KIAorbm90
cmFjZSBzdGF0aWMgX19hbHdheXNfaW5saW5lIGludCBkb19tb25vdG9uaWNfcmF3KHN0cnVjdCB0
aW1lc3BlYyAqdHMpCit7CisJdW5zaWduZWQgbG9uZyBzZXE7CisJdTY0IG5zOworCWludCBtb2Rl
OworCisJZG8geworCQlzZXEgPSBndG9kX3JlYWRfYmVnaW4oZ3RvZCk7CisJCW1vZGUgPSBndG9k
LT52Y2xvY2tfbW9kZTsKKwkJdHMtPnR2X3NlYyA9IGd0b2QtPm1vbm90b25pY190aW1lX3Jhd19z
ZWM7CisJCW5zID0gZ3RvZC0+bW9ub3RvbmljX3RpbWVfcmF3X25zZWM7CisJCW5zICs9IHZnZXRz
bnNfcmF3KCZtb2RlKTsKKwkJbnMgPj49IGd0b2QtPnJhd19zaGlmdDsKKwl9IHdoaWxlICh1bmxp
a2VseShndG9kX3JlYWRfcmV0cnkoZ3RvZCwgc2VxKSkpOworCisJdHMtPnR2X3NlYyArPSBfX2l0
ZXJfZGl2X3U2NF9yZW0obnMsIE5TRUNfUEVSX1NFQywgJm5zKTsKKwl0cy0+dHZfbnNlYyA9IG5z
OworCisJcmV0dXJuIG1vZGU7Cit9CisKIG5vdHJhY2Ugc3RhdGljIHZvaWQgZG9fcmVhbHRpbWVf
Y29hcnNlKHN0cnVjdCB0aW1lc3BlYyAqdHMpCiB7CiAJdW5zaWduZWQgbG9uZyBzZXE7CkBAIC0y
NzcsNiArMzMxLDEwIEBAIG5vdHJhY2UgaW50IF9fdmRzb19jbG9ja19nZXR0aW1lKGNsb2NraWQK
IAkJaWYgKGRvX21vbm90b25pYyh0cykgPT0gVkNMT0NLX05PTkUpCiAJCQlnb3RvIGZhbGxiYWNr
OwogCQlicmVhazsKKwljYXNlIENMT0NLX01PTk9UT05JQ19SQVc6CisJCWlmIChkb19tb25vdG9u
aWNfcmF3KHRzKSA9PSBWQ0xPQ0tfTk9ORSkKKwkJCWdvdG8gZmFsbGJhY2s7CisJCWJyZWFrOwog
CWNhc2UgQ0xPQ0tfUkVBTFRJTUVfQ09BUlNFOgogCQlkb19yZWFsdGltZV9jb2Fyc2UodHMpOwog
CQlicmVhazsKZGlmZiAtdXAgbGludXgtNC4xNi1yYzUuMS9hcmNoL3g4Ni9lbnRyeS92c3lzY2Fs
bC92c3lzY2FsbF9ndG9kLmMuNC4xNi1yYzUgbGludXgtNC4xNi1yYzUuMS9hcmNoL3g4Ni9lbnRy
eS92c3lzY2FsbC92c3lzY2FsbF9ndG9kLmMKLS0tIGxpbnV4LTQuMTYtcmM1LjEvYXJjaC94ODYv
ZW50cnkvdnN5c2NhbGwvdnN5c2NhbGxfZ3RvZC5jLjQuMTYtcmM1CTIwMTgtMDMtMTIgMDA6MjU6
MDkuMDAwMDAwMDAwICswMDAwCisrKyBsaW51eC00LjE2LXJjNS4xL2FyY2gveDg2L2VudHJ5L3Zz
eXNjYWxsL3ZzeXNjYWxsX2d0b2QuYwkyMDE4LTAzLTEyIDA3OjU4OjA3Ljk3NDIxNDE2OCArMDAw
MApAQCAtNDUsNiArNDUsMTEgQEAgdm9pZCB1cGRhdGVfdnN5c2NhbGwoc3RydWN0IHRpbWVrZWVw
ZXIgKgogCXZkYXRhLT5tdWx0CQk9IHRrLT50a3JfbW9uby5tdWx0OwogCXZkYXRhLT5zaGlmdAkJ
PSB0ay0+dGtyX21vbm8uc2hpZnQ7CiAKKwl2ZGF0YS0+cmF3X2N5Y2xlX2xhc3QJPSB0ay0+dGty
X3Jhdy5jeWNsZV9sYXN0OworCXZkYXRhLT5yYXdfbWFzawkJPSB0ay0+dGtyX3Jhdy5tYXNrOwor
CXZkYXRhLT5yYXdfbXVsdAkJPSB0ay0+dGtyX3Jhdy5tdWx0OworCXZkYXRhLT5yYXdfc2hpZnQJ
PSB0ay0+dGtyX3Jhdy5zaGlmdDsKKwogCXZkYXRhLT53YWxsX3RpbWVfc2VjCQk9IHRrLT54dGlt
ZV9zZWM7CiAJdmRhdGEtPndhbGxfdGltZV9zbnNlYwkJPSB0ay0+dGtyX21vbm8ueHRpbWVfbnNl
YzsKIApAQCAtNzQsNSArNzksOCBAQCB2b2lkIHVwZGF0ZV92c3lzY2FsbChzdHJ1Y3QgdGltZWtl
ZXBlciAqCiAJCXZkYXRhLT5tb25vdG9uaWNfdGltZV9jb2Fyc2Vfc2VjKys7CiAJfQogCisJdmRh
dGEtPm1vbm90b25pY190aW1lX3Jhd19zZWMgID0gdGstPnJhd19zZWM7CisJdmRhdGEtPm1vbm90
b25pY190aW1lX3Jhd19uc2VjID0gdGstPnRrcl9yYXcueHRpbWVfbnNlYzsKKwogCWd0b2Rfd3Jp
dGVfZW5kKHZkYXRhKTsKIH0KZGlmZiAtdXAgbGludXgtNC4xNi1yYzUuMS9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9tc3IuaC40LjE2LXJjNSBsaW51eC00LjE2LXJjNS4xL2FyY2gveDg2L2luY2x1ZGUv
YXNtL21zci5oCi0tLSBsaW51eC00LjE2LXJjNS4xL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5o
LjQuMTYtcmM1CTIwMTgtMDMtMTIgMDA6MjU6MDkuMDAwMDAwMDAwICswMDAwCisrKyBsaW51eC00
LjE2LXJjNS4xL2FyY2gveDg2L2luY2x1ZGUvYXNtL21zci5oCTIwMTgtMDMtMTIgMDg6MDE6MjUu
NDAwMjg5NTU0ICswMDAwCkBAIC0yMTgsNyArMjE4LDcgQEAgc3RhdGljIF9fYWx3YXlzX2lubGlu
ZSB1bnNpZ25lZCBsb25nIGxvbgogCXJldHVybiByZHRzYygpOwogfQogCi0vKiBEZXByZWNhdGVk
LCBrZWVwIGl0IGZvciBhIGN5Y2xlIGZvciBlYXNpZXIgbWVyZ2luZzogKi8KKy8qIERlcHJlY2F0
ZWQsIGtlZXAgaXQgZm9yIGEgY3ljbGUgZm9yIGVhc2llciBtZXJnaW5nOiAqL28KICNkZWZpbmUg
cmR0c2NsbChub3cpCWRvIHsgKG5vdykgPSByZHRzY19vcmRlcmVkKCk7IH0gd2hpbGUgKDApCiAK
IHN0YXRpYyBpbmxpbmUgdW5zaWduZWQgbG9uZyBsb25nIG5hdGl2ZV9yZWFkX3BtYyhpbnQgY291
bnRlcikKZGlmZiAtdXAgbGludXgtNC4xNi1yYzUuMS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92Z3Rv
ZC5oLjQuMTYtcmM1IGxpbnV4LTQuMTYtcmM1LjEvYXJjaC94ODYvaW5jbHVkZS9hc20vdmd0b2Qu
aAotLS0gbGludXgtNC4xNi1yYzUuMS9hcmNoL3g4Ni9pbmNsdWRlL2FzbS92Z3RvZC5oLjQuMTYt
cmM1CTIwMTgtMDMtMTIgMDA6MjU6MDkuMDAwMDAwMDAwICswMDAwCisrKyBsaW51eC00LjE2LXJj
NS4xL2FyY2gveDg2L2luY2x1ZGUvYXNtL3ZndG9kLmgJMjAxOC0wMy0xMiAwNzo0NDoxNy45MTA1
Mzk3NjAgKzAwMDAKQEAgLTIyLDYgKzIyLDEwIEBAIHN0cnVjdCB2c3lzY2FsbF9ndG9kX2RhdGEg
ewogCXU2NAltYXNrOwogCXUzMgltdWx0OwogCXUzMglzaGlmdDsKKwl1NjQJcmF3X2N5Y2xlX2xh
c3Q7CisJdTY0CXJhd19tYXNrOworCXUzMglyYXdfbXVsdDsKKwl1MzIJcmF3X3NoaWZ0OwogCiAJ
Lyogb3BlbiBjb2RlZCAnc3RydWN0IHRpbWVzcGVjJyAqLwogCXU2NAkJd2FsbF90aW1lX3Nuc2Vj
OwpAQCAtMzIsNiArMzYsOCBAQCBzdHJ1Y3QgdnN5c2NhbGxfZ3RvZF9kYXRhIHsKIAlndG9kX2xv
bmdfdAl3YWxsX3RpbWVfY29hcnNlX25zZWM7CiAJZ3RvZF9sb25nX3QJbW9ub3RvbmljX3RpbWVf
Y29hcnNlX3NlYzsKIAlndG9kX2xvbmdfdAltb25vdG9uaWNfdGltZV9jb2Fyc2VfbnNlYzsKKwln
dG9kX2xvbmdfdAltb25vdG9uaWNfdGltZV9yYXdfc2VjOworCWd0b2RfbG9uZ190CW1vbm90b25p
Y190aW1lX3Jhd19uc2VjOwogCiAJaW50CQl0el9taW51dGVzd2VzdDsKIAlpbnQJCXR6X2RzdHRp
bWU7Cg==
--001a113cd4f637bfe6056732f6b7--
