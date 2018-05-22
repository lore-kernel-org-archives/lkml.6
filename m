Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbeEVIFA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:05:00 -0400
Received: from mail-lf0-f44.google.com ([209.85.215.44]:33816 "EHLO
        mail-lf0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750709AbeEVIEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:04:55 -0400
X-Google-Smtp-Source: AB8JxZqu9h8Fy9hlxkdB8ZwD53+vQurpgO25pFv6jd+T8cYSYysk7KAws+O6krP7P6VwAi5+VronbqDcJ+YU0kvgcZM=
MIME-Version: 1.0
Reply-To: sedat.dilek@gmail.com
In-Reply-To: <CA+icZUVsV=5jvTcXVWqMs6ROhT3mv+7zBOoJ0JkUy5Mf+a4GNw@mail.gmail.com>
References: <CA+icZUUPGQsRWpdmASzPQAdjmSFmhBwPKGh_CO65C9ot9+nOSQ@mail.gmail.com>
 <20180423174224.GA243180@google.com> <CA+icZUUpxh=99JP5K_R1KpxouqDW4KY5BjCn5VTcmyByEb0R5w@mail.gmail.com>
 <20180424230645.GB243180@google.com> <CA+icZUWhLNvjbyMv+2dB9iXgHnkLZwy5+_GZYG7-sk2b_TJa8Q@mail.gmail.com>
 <20180507174909.GF19594@google.com> <CA+icZUUCBoHiuK+qCPX-H3=4Si2UXxMBMwQCmzWmq=U1sHebRg@mail.gmail.com>
 <CAH7mPviH3EiozBxkdZ685ZOo1bNJLLaOPFYwbn2NvD77w=P3Aw@mail.gmail.com> <CA+icZUVsV=5jvTcXVWqMs6ROhT3mv+7zBOoJ0JkUy5Mf+a4GNw@mail.gmail.com>
From: Sedat Dilek <sedat.dilek@gmail.com>
Date: Tue, 22 May 2018 10:04:53 +0200
Message-ID: <CA+icZUUfmgJPmmjuaVckvdLwWuWOPDAuFFyLq_ZPkc__LZbtSA@mail.gmail.com>
Subject: Re: Clang patch stacks for LTS kernels (v4.4 and v4.9) and status update
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Matthias Kaehlcke <mka@chromium.org>,
        lkml <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Manoj Gupta <manojgupta@chromium.org>,
        AlistairStrachan <astrachan@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Content-Type: multipart/mixed; boundary="00000000000097d0a8056cc6dfba"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000097d0a8056cc6dfba
Content-Type: text/plain; charset="UTF-8"

On Tue, May 22, 2018 at 9:39 AM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On Sat, May 19, 2018 at 12:54 AM, Nick Desaulniers
> <nick.desaulniers@gmail.com> wrote:
>> Sedat,
>> Thanks for the report.  We have a fix ready in
>> https://bugs.llvm.org/show_bug.cgi?id=37512.  Can you report what
>> version of clang you were using and if earlier versions of clang have
>> this issue?
>> Thanks,
>
> Can you give some advices on how to implement
> "attribute((no_stack_protector))" for Clang?
>
> I looked on how this is done for GCC...
>
> [ include/linux/compiler-gcc.h ]
>
> #if GCC_VERSION >= 40400
> #define __optimize(level)       __attribute__((__optimize__(level)))
> #define __nostackprotector      __optimize("no-stack-protector")
> #endif /* GCC_VERSION >= 40400 */
>
> [ include/linux/compiler_types.h ]
>
> #ifndef __nostackprotector
> # define __nostackprotector
> #endif
>
> LLVM-bug #37512 says:
>
> "GCC option for this is: attribute((optimize("no-stack-protector")))
> and the equivalent clang syntax would be: attribute((no_stack_protector))"
>
> So, there should be a define in "include/linux/compiler-clang.h" for this?
>
> [ include/linux/compiler-clang.h ]
>
> #define __nostackprotector attribute((no_stack_protector))
>
> Looks that good to you?
>

I am trying with the attached files and...

CONFIG_PARAVIRT=y
CONFIG_CC_STACKPROTECTOR_STRONG=y

- Sedat -

--00000000000097d0a8056cc6dfba
Content-Type: text/x-patch; charset="US-ASCII";
	name="0001-compiler-clang.h-Add-__nostackprotector-function-att.patch"
Content-Disposition: attachment;
	filename="0001-compiler-clang.h-Add-__nostackprotector-function-att.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jhhe63g20

RnJvbSBlZDA3ZmYzNmFlN2FlMTIxZTQ4ZDZjMDU3OWZmM2ZkNTc5NmJmNTdhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAY3JlZGF0aXYuZGU+
CkRhdGU6IFR1ZSwgMjIgTWF5IDIwMTggMDk6NDY6MTggKzAyMDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gY29tcGlsZXItY2xhbmcuaDogQWRkIF9fbm9zdGFja3Byb3RlY3RvciBmdW5jdGlvbgogYXR0
cmlidXRlCgotLS0KIGluY2x1ZGUvbGludXgvY29tcGlsZXItY2xhbmcuaCB8IDUgKysrKysKIDEg
ZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2NvbXBpbGVyLWNsYW5nLmggYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWNsYW5nLmgKaW5kZXgg
MDcwZjg1ZDkyYzE1Li4xZGE5NTdjMzMxNDAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgvY29t
cGlsZXItY2xhbmcuaAorKysgYi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVyLWNsYW5nLmgKQEAgLTIx
LDMgKzIxLDggQEAKICNpZmRlZiBfX25vcmV0cG9saW5lCiAjdW5kZWYgX19ub3JldHBvbGluZQog
I2VuZGlmCisKKy8qIEZvciBkZXRhaWxzIHNlZSA8aHR0cHM6Ly9idWdzLmxsdm0ub3JnL3Nob3df
YnVnLmNnaT9pZD0zNzUxMj4uCisgKiBUaGlzIGZlYXR1cmUgcmVxdWlyZXMgQ2xhbmcgdmVyc2lv
biA3ID49IHN2bjMzMTkyNS4KKyAqLworI2RlZmluZSBfX25vc3RhY2twcm90ZWN0b3IgYXR0cmli
dXRlKChub19zdGFja19wcm90ZWN0b3IpKQotLSAKMi4xNy4wCgo=
--00000000000097d0a8056cc6dfba
Content-Type: text/x-patch; charset="US-ASCII";
	name="0002-x86-paravirt-Mark-native_save_fl-with-__nostackprote.patch"
Content-Disposition: attachment;
	filename="0002-x86-paravirt-Mark-native_save_fl-with-__nostackprote.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jhhe6ale1

RnJvbSA2ZmY0MzcxOWQyZjIyNWVlOTAzNjRjZTA1NGE5NTU1OTBhMDdlOTExIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTZWRhdCBEaWxlayA8c2VkYXQuZGlsZWtAY3JlZGF0aXYuZGU+
CkRhdGU6IFR1ZSwgMjIgTWF5IDIwMTggMDk6NTI6MTUgKzAyMDAKU3ViamVjdDogW1BBVENIIDIv
Ml0geDg2L3BhcmF2aXJ0OiBNYXJrIG5hdGl2ZV9zYXZlX2ZsKCkgd2l0aAogX19ub3N0YWNrcHJv
dGVjdG9yIGF0dHJpYnV0ZQoKLS0tCiBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9pcnFmbGFncy5oIHwg
MiArLQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZm
IC0tZ2l0IGEvYXJjaC94ODYvaW5jbHVkZS9hc20vaXJxZmxhZ3MuaCBiL2FyY2gveDg2L2luY2x1
ZGUvYXNtL2lycWZsYWdzLmgKaW5kZXggODlmMDg5NTVmZmY3Li42ZGVmMDQzMjExODEgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL2lycWZsYWdzLmgKKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vaXJxZmxhZ3MuaApAQCAtMTMsNyArMTMsNyBAQAogICogSW50ZXJydXB0IGNvbnRy
b2w6CiAgKi8KIAotc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIG5hdGl2ZV9zYXZlX2ZsKHZv
aWQpCitzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxvbmcgX19ub3N0YWNrcHJvdGVjdG9yIG5hdGl2
ZV9zYXZlX2ZsKHZvaWQpCiB7CiAJdW5zaWduZWQgbG9uZyBmbGFnczsKIAotLSAKMi4xNy4wCgo=
--00000000000097d0a8056cc6dfba--
