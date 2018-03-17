Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753301AbeCQXho (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 19:37:44 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:34696 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbeCQXhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 19:37:41 -0400
X-Google-Smtp-Source: AG47ELulYaJ8TZlv/wC2LnBhPbf7bxL0ccju5q2rGcLC9eMZvLUz+VWtQz0yVNmkhyikC3zqyCZBGfFhnFKSHh5XSAM=
MIME-Version: 1.0
In-Reply-To: <CALyZvKx0aqhobdrvSUNptE4m3Gsf6+mZgm4G3BnVWKtwKSMfwg@mail.gmail.com>
References: <CALyZvKx0aqhobdrvSUNptE4m3Gsf6+mZgm4G3BnVWKtwKSMfwg@mail.gmail.com>
From: Jason Vas Dias <jason.vas.dias@gmail.com>
Date: Sat, 17 Mar 2018 23:37:39 +0000
Message-ID: <CALyZvKycERiszrH2k=HbdQSn4tWhFQKYpUvW-TKpKfX6D1BUmA@mail.gmail.com>
Subject: Re: [PATCH v4.16-rc5 (2)] x86/vdso: VDSO should handle
 clock_gettime(CLOCK_MONOTONIC_RAW) without syscall
To: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        x86@kernel.org, mingo@kernel.org, peterz@infradead.org,
        andi@firstfloor.org
Content-Type: multipart/mixed; boundary="000000000000f4278a0567a43507"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f4278a0567a43507
Content-Type: text/plain; charset="UTF-8"

fixed typo in timer_latency.c affecting only -r <repeat> printout
:

$ gcc -DN_SAMPLES=1000 -o timer timer_latency.c
CLOCK_MONOTONIC ( using rdtscp_ordered() ) :

$ ./timer -m -r 10
sum: 67615
Total time: 0.000067615S - Average Latency: 0.000000067S N zero
deltas: 0 N inconsistent deltas: 0
sum: 51858
Total time: 0.000051858S - Average Latency: 0.000000051S N zero
deltas: 0 N inconsistent deltas: 0
sum: 51742
Total time: 0.000051742S - Average Latency: 0.000000051S N zero
deltas: 0 N inconsistent deltas: 0
sum: 51944
Total time: 0.000051944S - Average Latency: 0.000000051S N zero
deltas: 0 N inconsistent deltas: 0
sum: 51838
Total time: 0.000051838S - Average Latency: 0.000000051S N zero
deltas: 0 N inconsistent deltas: 0
sum: 52397
Total time: 0.000052397S - Average Latency: 0.000000052S N zero
deltas: 0 N inconsistent deltas: 0
sum: 52428
Total time: 0.000052428S - Average Latency: 0.000000052S N zero
deltas: 0 N inconsistent deltas: 0
sum: 52135
Total time: 0.000052135S - Average Latency: 0.000000052S N zero
deltas: 0 N inconsistent deltas: 0
sum: 52145
Total time: 0.000052145S - Average Latency: 0.000000052S N zero
deltas: 0 N inconsistent deltas: 0
sum: 53116
Total time: 0.000053116S - Average Latency: 0.000000053S N zero
deltas: 0 N inconsistent deltas: 0
Average of 10 average latencies of 1000 samples : 0.000000053S


CLOCK_MONOTONIC_RAW ( using rdtscp() ) :

$ ./timer  -r 10
sum: 25755
Total time: 0.000025755S - Average Latency: 0.000000025S N zero
deltas: 0 N inconsistent deltas: 0
sum: 21614
Total time: 0.000021614S - Average Latency: 0.000000021S N zero
deltas: 0 N inconsistent deltas: 0
sum: 21616
Total time: 0.000021616S - Average Latency: 0.000000021S N zero
deltas: 0 N inconsistent deltas: 0
sum: 21610
Total time: 0.000021610S - Average Latency: 0.000000021S N zero
deltas: 0 N inconsistent deltas: 0
sum: 21619
Total time: 0.000021619S - Average Latency: 0.000000021S N zero
deltas: 0 N inconsistent deltas: 0
sum: 21617
Total time: 0.000021617S - Average Latency: 0.000000021S N zero
deltas: 0 N inconsistent deltas: 0
sum: 21610
Total time: 0.000021610S - Average Latency: 0.000000021S N zero
deltas: 0 N inconsistent deltas: 0
sum: 16940
Total time: 0.000016940S - Average Latency: 0.000000016S N zero
deltas: 0 N inconsistent deltas: 0
sum: 16939
Total time: 0.000016939S - Average Latency: 0.000000016S N zero
deltas: 0 N inconsistent deltas: 0
sum: 16943
Total time: 0.000016943S - Average Latency: 0.000000016S N zero
deltas: 0 N inconsistent deltas: 0
Average of 10 average latencies of 1000 samples : 0.000000019S

--000000000000f4278a0567a43507
Content-Type: text/x-csrc; charset="US-ASCII"; name="timer_latency.c"
Content-Disposition: attachment; filename="timer_latency.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: file1

LyoKICogUHJvZ3JhbSB0byBtZWFzdXJlIGhpZ2gtcmVzIHRpbWVyIGxhdGVuY3kuCiAqCiAqLwoj
aW5jbHVkZSA8c3RkaW50Lmg+CiNpbmNsdWRlIDxzdGRib29sLmg+CiNpbmNsdWRlIDxzeXMvdHlw
ZXMuaD4KI2luY2x1ZGUgPHVuaXN0ZC5oPgojaW5jbHVkZSA8dGltZS5oPgojaW5jbHVkZSA8ZXJy
bm8uaD4KI2luY2x1ZGUgPGFsbG9jYS5oPgojaW5jbHVkZSA8c3RyaW5nLmg+CiNpbmNsdWRlIDxz
dGRpby5oPgojaW5jbHVkZSA8c3RkbGliLmg+CgojaWZuZGVmIE5fU0FNUExFUwojZGVmaW5lIE5f
U0FNUExFUyAxMDAKI2VuZGlmCiNkZWZpbmUgX1NUUihfU18pICNfU18KI2RlZmluZSBTVFIoX1Nf
KSBfU1RSKF9TXykKCiNkZWZpbmUgVFMyTlMoX1RTXykgKCgoKHVuc2lnbmVkIGxvbmcgbG9uZyko
X1RTXykudHZfc2VjKSoxMDAwMDAwMDAwVUxMKSArICgoKHVuc2lnbmVkIGxvbmcgbG9uZykoKF9U
U18pLnR2X25zZWMpKSkpIAoKaW50IG1haW4oaW50IGFyZ2MsIGNoYXIgKmNvbnN0KiBhcmd2LCBj
aGFyICpjb25zdCogZW52cCkKeyBzdHJ1Y3QgdGltZXNwZWMgc2FtcGxlW05fU0FNUExFUysxXTsK
ICB1bnNpZ25lZCBpbnQgY250PU5fU0FNUExFUywgcz0wICwgYXZnX249MDsKICB1bnNpZ25lZCBs
b25nIGxvbmcKICAgIGRlbHRhcyBbIE5fU0FNUExFUyBdCiAgICAsIHQxLCB0Miwgc3VtPTAsIHpk
PTAsIGljPTAsIGQKICAgICwgdF9zdGFydCwgYXZnX25zLCAqYXZncz0wOwogIGNsb2NraWRfdCBj
bGsgPSBDTE9DS19NT05PVE9OSUNfUkFXOwogIGJvb2wgZG9fZHVtcCA9IGZhbHNlOwogIGludCBh
cmduPTEsIHJlcGVhdD0xOwogIGZvcig7IGFyZ24gPCBhcmdjOyBhcmduKz0xKQogICAgaWYoIGFy
Z3ZbYXJnbl0gIT0gTlVMTCApCiAgICAgIGlmKCAqKGFyZ3ZbYXJnbl0pID09ICctJykKCXN3aXRj
aCggKihhcmd2W2FyZ25dKzEpICkKCXsgY2FzZSAnbSc6CgkgIGNhc2UgJ00nOgoJICAgIGNsayA9
IENMT0NLX01PTk9UT05JQzsKCSAgICBicmVhazsKCSAgY2FzZSAnZCc6CgkgIGNhc2UgJ0QnOgoJ
ICAgIGRvX2R1bXAgPSB0cnVlOwoJICAgIGJyZWFrOwogICAgIAkgIGNhc2UgJ3InOgogICAgICAJ
ICBjYXNlICdSJzoKCSAgICBpZiggKGFyZ24gPCBhcmdjKSAmJiAoYXJndlthcmduKzFdICE9IE5V
TEwpKQoJICAgICAgcmVwZWF0ID0gYXRvaShhcmd2W2FyZ24rPTFdKTsKCSAgICBicmVhazsKCSAg
Y2FzZSAnPyc6CgkgIGNhc2UgJ2gnOgoJICBjYXNlICd1JzoKCSAgY2FzZSAnVSc6CgkgIGNhc2Ug
J0gnOgoJICAgIGZwcmludGYoc3RkZXJyLCJVc2FnZTogdGltZXJfbGF0ZW5jeSBbXG5cdC1tIDog
dXNlIENMT0NLX01PTk9UT05JQyBjbG9jayAobm90IENMT0NLX01PTk9UT05JQ19SQVcpXG5cdC1k
IDogZHVtcCB0aW1lc3BlYyBjb250ZW50cy4gTl9TQU1QTEVTOiAiIFNUUihOX1NBTVBMRVMpICJc
blx0IgoJICAgICAgICAgICAgIi1yIDxyZXBlYXQgY291bnQ+XG5dXHQiCgkgICAgICAgICAgICAi
Q2FsY3VsYXRlcyBhdmVyYWdlIHRpbWVyIGxhdGVuY3kgKG1pbmltdW0gdGltZSB0aGF0IGNhbiBi
ZSBtZWFzdXJlZCkgb3ZlciBOX1NBTVBMRVMuXG4iCgkgICAgICAgICAgICk7CgkgICAgcmV0dXJu
IDA7Cgl9CiAgaWYoIHJlcGVhdCA+IDEgKQogIHsgYXZncz1hbGxvY2Eoc2l6ZW9mKHVuc2lnbmVk
IGxvbmcgbG9uZykgKiAoTl9TQU1QTEVTICsgMSkpOwogICAgaWYoICgodW5zaWduZWQgbG9uZykg
YXZncykgJiA3ICkKICAgICAgYXZncyA9ICgodW5zaWduZWQgbG9uZyBsb25nKikoKCh1bnNpZ25l
ZCBjaGFyKilhdmdzKSsoOC0oKHVuc2lnbmVkIGxvbmcpIGF2Z3MpICYgNykpKTsKICB9CiAgZG8g
ewogICAgY250PU5fU0FNUExFUzsKICAgIHM9MDsKICBkbwogIHsgaWYoIDAgIT0gY2xvY2tfZ2V0
dGltZShjbGssICZzYW1wbGVbcysrXSkgKQogICAgeyBmcHJpbnRmKHN0ZGVyciwib29wcywgY2xv
Y2tfZ2V0dGltZSgpIGZhaWxlZDogJWQ6ICclcycuXG4iLCBlcnJubywgc3RyZXJyb3IoZXJybm8p
KTsKICAgICAgcmV0dXJuIDE7CiAgICB9CiAgfXdoaWxlKCAtLWNudCApOwogIGNsb2NrX2dldHRp
bWUoY2xrLCAmc2FtcGxlW3NdKTsKICBmb3Iocz0xOyBzIDwgKE5fU0FNUExFUysxKTsgcys9MSkK
ICB7IHQxID0gVFMyTlMoc2FtcGxlW3MtMV0pOwogICAgdDIgPSBUUzJOUyhzYW1wbGVbc10pOwog
ICAgaWYgKCAodDEgPiB0MikKICAgICAgIHx8KHNhbXBsZVtzLTFdLnR2X3NlYyA+IHNhbXBsZVtz
XS50dl9zZWMpCiAgICAgICB8fCgoc2FtcGxlW3MtMV0udHZfc2VjID09IHNhbXBsZVtzXS50dl9z
ZWMpCiAgICAgICAgJiYoc2FtcGxlW3MtMV0udHZfbnNlYyA+IHNhbXBsZVtzXS50dl9uc2VjKQog
ICAgICAgICApCiAgICAgICApCiAgICB7IGZwcmludGYoc3RkZXJyLCJJbmNvbnNpc3RlbmN5OiAl
bGx1ICVsbHUgJWx1LiVsdSAlbHUuJWx1XG4iLCB0MSAsIHQyCiAgICAgICAgICAgICwgc2FtcGxl
W3MtMV0udHZfc2VjLCBzYW1wbGVbcy0xXS50dl9uc2VjCiAgICAgICAgICAgICwgc2FtcGxlW3Nd
LnR2X3NlYywgICBzYW1wbGVbc10udHZfbnNlYwogICAgICApOwogICAgICBpYys9MTsKICAgICAg
Y29udGludWU7CiAgICB9CiAgICBkID0gdDIgLSB0MTsKICAgIGlmICggZCA9PSAwICkKICAgIHsg
IHpkICs9IDE7CiAgICB9CiAgICBkZWx0YXNbcy0xXSA9IGQ7CiAgICBpZihkb19kdW1wKQogICAg
ICBmcHJpbnRmKHN0ZGVyciwgIiVsdSAlbHUgJWxsdVxuIiwKICAgICAgICAgICAgICBzYW1wbGVb
c10udHZfc2VjLCBzYW1wbGVbc10udHZfbnNlYywgZAogICAgICAgICAgICAgKTsKICB9CiAgZm9y
KHMgPSAwLCBzdW09MDsgcyA8IE5fU0FNUExFUzsgcys9MSkKICAgIHN1bSArPSBkZWx0YXNbc107
CiAgZnByaW50ZihzdGRlcnIsInN1bTogJWxsdVxuIixzdW0pOwogIGF2Z19ucyA9IHN1bSAvIE5f
U0FNUExFUzsKICB0X3N0YXJ0ID0gVFMyTlMoc2FtcGxlWzBdKTsKICB0MT0odDIgLSB0X3N0YXJ0
KTsKICBwcmludGYoIlRvdGFsIHRpbWU6ICUxLjFsbHUuJTkuOWxsdVMgLSBBdmVyYWdlIExhdGVu
Y3k6ICUxLjFsbHUuJTkuOWxsdVMgTiB6ZXJvIGRlbHRhczogJXUgTiBpbmNvbnNpc3RlbnQgZGVs
dGFzOiAldVxuIiwKICAgICAgICAgIHQxIC8gMTAwMDAwMDAwMCwgICAgICAgdDEgJSAxMDAwMDAw
MDAwLAogICAgICAgICAgYXZnX25zIC8gMTAwMDAwMDAwMCwgICBhdmdfbnMgJSAxMDAwMDAwMDAw
ICwKICAgICAgICAgIHpkLCBpYwogICAgICAgICk7CiAgaWYgKGF2Z3MgIT0gKCh2b2lkKikwVUwp
KQogIHsgIGF2Z3NbYXZnX24rK10gPSBhdmdfbnM7CiAgfQogIH0gd2hpbGUgKC0tcmVwZWF0KTsK
ICBpZiAoYXZncyAhPSAoKHZvaWQqKTBVTCkpCiAgeyBmb3IoIHM9MCwgc3VtPTA7IHMgPCBhdmdf
bjsgcys9MSkKICAgICAgc3VtICs9IGF2Z3Nbc107CiAgICBwcmludGYoIkF2ZXJhZ2Ugb2YgJXUg
YXZlcmFnZSBsYXRlbmNpZXMgb2YgIiBTVFIoTl9TQU1QTEVTKSAiIHNhbXBsZXMgOiAlMS4xbGx1
LiU5LjlsbHVTXG4iCiAgICAgICAgICAsIGF2Z19uLCAoc3VtIC8gMTAwMDAwMDAwMExMVSkvYXZn
X24sIChzdW0gJSAxMDAwMDAwMDAwTExVKS9hdmdfbgogICAgICAgICAgKTsKICB9CiAgcmV0dXJu
IDA7Cn0KCg==
--000000000000f4278a0567a43507--
