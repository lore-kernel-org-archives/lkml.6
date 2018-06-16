Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6878CC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E16952088E
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 21:22:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpmUECNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E16952088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933454AbeFPVW5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 17:22:57 -0400
Received: from mail-wr0-f175.google.com ([209.85.128.175]:44511 "EHLO
        mail-wr0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933331AbeFPVWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 17:22:55 -0400
Received: by mail-wr0-f175.google.com with SMTP id x4-v6so13049137wro.11
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jun 2018 14:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=yhueQ+Y4XOJSl3nXMGpL5IIaQRahZm9ulWZvsALww+Y=;
        b=SpmUECNww/MmZECb10yI81D8qUZiJKUb31xl373drrs2/k01A9Ph9Nr7RuspOfTgEZ
         587v2qA7L7a5pDuXPbLsHjcfM8t9CPKUVcoCeUxINkeg3qbh8VbO3tZTs/jMMvVHQYqD
         2oHws6+HwT7IetO3s0jlJbfUgIx3CiOHx6VaeIFOr1i+R2PwPCx8mdgheiyNEgmzgetU
         9hoPlUPuY5Wits5JZPMRtV9cOjiSy1QvnGILlBtYRmgm2ksPVWPCXARwSutv/mPZuDKZ
         nqiDHD5v9L4XD9AL31YxV88opFfJnqEFVnUxneGneTAxFnSJLEMp/gRuYueZvGyua8Ho
         LVnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=yhueQ+Y4XOJSl3nXMGpL5IIaQRahZm9ulWZvsALww+Y=;
        b=m/eSMFhTwTD48DmF4BFqVHbyRUHvnGabnM9Et37Hljy+Vr9RhgkmWjpf9bUy1Ea4IA
         xWzMvl7UuuDol4pNfvBqHJ7WVswjtirpmT4foP0owd47kEWbduY57mfNODBpY9kpKv0I
         WI5uU3Ke7yUlMgknviuMHq8K10GwYGOnn4U3GZTrTHfoIYsZ1MtMIeTaTOnv8eT+PxyK
         qHdoStZQqFiyIOnyFo/QBfhfo92XXn3L9s4RbS320mU9Bn39uhMFm7A67n/lKBvg0yQm
         1odo3CmMYgplXcl6hsW0LXQqTLkYlDLXEefy81ORZci4lFo9dBeJVoh2cCCRswCw6CZH
         uUXA==
X-Gm-Message-State: APt69E0iztqt0D1nGInAtYt0DkedScJlDNYbURV7OJY50vd8HyBIowLS
        TP1VZle2lLxYVMDV3djf9Hs=
X-Google-Smtp-Source: ADUXVKIFE+XPIsy6sdOtz2/EVzSfF31SK3mr6IE6f+ra2vwvGg09GoR6DdhfsdSUAtS8hLzVwZ7AtQ==
X-Received: by 2002:adf:dd03:: with SMTP id a3-v6mr6001950wrm.2.1529184174084;
        Sat, 16 Jun 2018 14:22:54 -0700 (PDT)
Received: from sf (trofi-1-pt.tunnel.tserv1.lon2.ipv6.he.net. [2001:470:1f1c:a0f::2])
        by smtp.gmail.com with ESMTPSA id n17-v6sm10937267wrs.96.2018.06.16.14.22.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 16 Jun 2018 14:22:53 -0700 (PDT)
Date:   Sat, 16 Jun 2018 22:22:50 +0100
From:   Sergei Trofimovich <slyich@gmail.com>
To:     libc-alpha@sourceware.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     "H.J. Lu" <hjl.tools@gmail.com>
Subject: x86_64: movdqu rarely stores bad data (movdqu works fine). Kernel
 bug, fried CPU or glibc bug?
Message-ID: <20180616222250.618cecaa@sf>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/4frW/+mSuJHa5I1vsq5j2QV"; protocol="application/pgp-signature"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4frW/+mSuJHa5I1vsq5j2QV
Content-Type: multipart/mixed; boundary="MP_/LG=cCECd60AIASgpys9hr9K"

--MP_/LG=cCECd60AIASgpys9hr9K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

TL;DR: on master string/test-memmove glibc test fails on my machine
and I don't know why. Other tests work fine.

$ elf/ld.so --inhibit-cache --library-path . string/test-memmove
                        simple_memmove  __memmove_ssse3_rep     __memmove_s=
sse3 __memmove_sse2_unaligned        __memmove_ia32
string/test-memmove: Wrong result in function __memmove_sse2_unaligned dst =
"0x70000084" src "0x70000000" offset "43297733"

https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dstring/test-memmove.=
c;h=3D64e3651ba40604e47ddf6d633f4d0aea4644f60a;hb=3DHEAD

Long story:

I've trimmed __memmove_sse2_unaligned implementation down to
test-memmove-xmm-unaligned.c (attached). It's supposed to show
failed memmove attempts when those happen:

$ gcc -ggdb3 -O2 -m32 test-memmove-xmm-unaligned.c -o test-memmove-xmm-unal=
igned -Wall && ./test-memmove-xmm-unaligned
Bad result in memmove(dst=3D0xe7d44110, src=3D0xe7d44010, len=3D134217728):=
 offset=3D 3786689; expected=3D0039C7C1( 3786689) actual=3D0039C7C3( 378669=
1) bit_mismatch=3D00000002; iteration=3D1
Bad result in memmove(dst=3D0xe7d44110, src=3D0xe7d44010, len=3D134217728):=
 offset=3D 3786689; expected=3D0039C7C1( 3786689) actual=3D0039C7C3( 378669=
1) bit_mismatch=3D00000002; iteration=3D3
Bad result in memmove(dst=3D0xe7d44110, src=3D0xe7d44010, len=3D134217728):=
 offset=3D 5448641; expected=3D005323C1( 5448641) actual=3D005323C3( 544864=
3) bit_mismatch=3D00000002; iteration=3D5
Bad result in memmove(dst=3D0xe7d44110, src=3D0xe7d44010, len=3D134217728):=
 offset=3D29022145; expected=3D01BAD7C1(29022145) actual=3D01BAD7C3(2902214=
7) bit_mismatch=3D00000002; iteration=3D9

$ gcc -ggdb3 -O2 -m64 test-memmove-xmm-unaligned.c -o test-memmove-xmm-unal=
igned -Wall && ./test-memmove-xmm-unaligned
Bad result in memmove(dst=3D0x7fa4658bf110, src=3D0x7fa4658bf010, len=3D134=
217728): offset=3D25257857; expected=3D01816781(25257857) actual=3D01816783=
(25257859) bit_mismatch=3D00000002; iteration=3D43
Bad result in memmove(dst=3D0x7fa4658bf110, src=3D0x7fa4658bf010, len=3D134=
217728): offset=3D28109697; expected=3D01ACEB81(28109697) actual=3D01ACEB83=
(28109699) bit_mismatch=3D00000002; iteration=3D112
Bad result in memmove(dst=3D0x7fa4658bf110, src=3D0x7fa4658bf010, len=3D134=
217728): offset=3D18257633; expected=3D011696E1(18257633) actual=3D011696E3=
(18257635) bit_mismatch=3D00000002; iteration=3D363
Bad result in memmove(dst=3D0x7fa4658bf110, src=3D0x7fa4658bf010, len=3D134=
217728): offset=3D26981249; expected=3D019BB381(26981249) actual=3D019BB383=
(26981251) bit_mismatch=3D00000002; iteration=3D437

Note it is a single-bit corruption happening occasionally (not on every ite=
ration).
-m32 is way more error prone that -m64.

Test example roughly implements these 2 loops:
This fails:
  sfence
  loop {
    movdqu [src++],%xmm0
    movntdq %xmm0,[dst++]
  }
  sfence
This works:
  sfence
  loop {
    movdqu [src++],%xmm0
    movdqu %xmm0,[dst++]
  }
  sfence

Failures happen only on sandybridge CPU:
    Intel(R) Core(TM) i7-2700K CPU @ 3.50GHz
kernel is 4.17.0-11928-g2837461dbe6f.

Problem is not reproducible instantly after reboot. Machine has to be
heavily loaded to start corrupting memory. A few hours of memtest86+
does not reveal any memory failures.

I wonder if anyone else can reproduce this failure or should I start
looking for a new CPU.

=46rom the above it looks like as if movntdq does not play well with XMM
context save/restore and there is an 'mfence' missing somewhere in
interrupt handling.

If there is no obvious problems with glibc's memove() or my small test
what can I do to rule-out/pin-down hardware or kernel problem?

Thanks!

--=20

  Sergei

--MP_/LG=cCECd60AIASgpys9hr9K
Content-Type: text/x-c++src
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment; filename=test-memmove-xmm-unaligned.c

/*
  Test as:
    $ gcc -ggdb3 -O2 -m32 test-memmove-xmm-unaligned.c -o test-memmove-xmm-=
unaligned -Wall && ./test-memmove-xmm-unaligned
  Error example:
    Bad result in memmove(dst=3D0xd7cf5094, src=3D0xd7cf5010, len=3D2684354=
56): offset=3D 8031729; expected=3D007A8DF1( 8031729) actual=3D007A8DF3( 80=
31731) bit_mismatch=3D00000002; iteration=3D2
    Bad result in memmove(dst=3D0xd7cf5094, src=3D0xd7cf5010, len=3D2684354=
56): offset=3D43626993; expected=3D0299B1F1(43626993) actual=3D0299B1F3(436=
26995) bit_mismatch=3D00000002; iteration=3D3
    Bad result in memmove(dst=3D0xd7cf5094, src=3D0xd7cf5010, len=3D2684354=
56): offset=3D25404913; expected=3D0183A5F1(25404913) actual=3D0183A5F3(254=
04915) bit_mismatch=3D00000002; iteration=3D4
    ...
*/

#include <string.h> /* memmove */
#include <stdlib.h> /* exit */
#include <stdio.h>  /* fprintf */

#include <sys/mman.h> /* mlock() */
#include <emmintrin.h> /* movdqu, sfence, movntdq */

typedef unsigned int u32;

static void memmove_si128u (__m128i_u * dest, __m128i_u const *src, size_t =
items) __attribute__((noinline));
static void memmove_si128u (__m128i_u * dest, __m128i_u const *src, size_t =
items)
{
    // emulate behaviour of optimised block for __memmove_sse2_unaligned:
    // sfence
    // loop(backwards) {
    //   8x movdqu  mem->%xmm{N}
    //   8x movntdq %xmm{N}->mem
    // }
    // source: https://sourceware.org/git/?p=3Dglibc.git;a=3Dblob;f=3Dsysde=
ps/i386/i686/multiarch/memcpy-sse2-unaligned.S;h=3D9aa17de99c9c3415a9b5ac28=
fd9f1eb4457f916d;hb=3DHEAD#l244

    // ASSUME: if ((unintptr_t)dest > (unintptr_t)src) {
    dest +=3D items - 1;
    src  +=3D items - 1;
    _mm_sfence();
    for (; items !=3D 0; items-=3D8, dest-=3D8, src-=3D8)
    {
        __m128i xmm0 =3D _mm_loadu_si128(src-0); // movdqu
        __m128i xmm1 =3D _mm_loadu_si128(src-1); // movdqu
        __m128i xmm2 =3D _mm_loadu_si128(src-2); // movdqu
        __m128i xmm3 =3D _mm_loadu_si128(src-3); // movdqu
        __m128i xmm4 =3D _mm_loadu_si128(src-4); // movdqu
        __m128i xmm5 =3D _mm_loadu_si128(src-5); // movdqu
        __m128i xmm6 =3D _mm_loadu_si128(src-6); // movdqu
        __m128i xmm7 =3D _mm_loadu_si128(src-7); // movdqu
        if (0)
        {
          // this would work:
          _mm_storeu_si128(dest-0, xmm0);// movdqu
          _mm_storeu_si128(dest-1, xmm1);// movdqu
          _mm_storeu_si128(dest-2, xmm2);// movdqu
          _mm_storeu_si128(dest-3, xmm3);// movdqu
          _mm_storeu_si128(dest-4, xmm4);// movdqu
          _mm_storeu_si128(dest-5, xmm5);// movdqu
          _mm_storeu_si128(dest-6, xmm6);// movdqu
          _mm_storeu_si128(dest-7, xmm7);// movdqu
        }
        else
        {
          _mm_stream_si128(dest-0, xmm0); // movntdq
          _mm_stream_si128(dest-1, xmm1); // movntdq
          _mm_stream_si128(dest-2, xmm2); // movntdq
          _mm_stream_si128(dest-3, xmm3); // movntdq
          _mm_stream_si128(dest-4, xmm4); // movntdq
          _mm_stream_si128(dest-5, xmm5); // movntdq
          _mm_stream_si128(dest-6, xmm6); // movntdq
          _mm_stream_si128(dest-7, xmm7); // movntdq
        }
    }
    _mm_sfence();
}

static void do_memmove (u32 * buf, size_t buf_elements, size_t iter) __attr=
ibute__((noinline));
static void do_memmove (u32 * buf, size_t buf_elements, size_t iter)
{
  size_t elements_to_move =3D buf_elements / 2;

  // "memset" buffer with 0, 1, 2, 3, ...
  for (u32 i =3D 0; i < elements_to_move; i++) buf[i] =3D i;

  u32 * dst =3D buf + 64;

  // __memmove_sse2_unaligned
  // memmove(dst, buf, elements_to_move * sizeof (u32));
  memmove_si128u((__m128i_u *)dst, (__m128i_u const *)buf, elements_to_move=
 * sizeof (u32) / sizeof (__m128i));

  // validate target buffer buffer with 0, 1, 2, 3, ...
  for (u32 i =3D 0; i < elements_to_move; i++)
  {
    u32 v =3D dst[i];
    if (v !=3D i)
      fprintf (stderr,
               "Bad result in memmove(dst=3D%p, src=3D%p, len=3D%zd)"
               ": offset=3D%8u; expected=3D%08X(%8u) actual=3D%08X(%8u) bit=
_mismatch=3D%08X; iteration=3D%zu\n",
               dst, buf, elements_to_move * sizeof (u32),
               i, i, i, v, v, v^i, iter);
  }
}

int main (void)
{
  size_t size =3D 256 * 1024 * 1024;
  void * buf =3D malloc(size);
  mlock (buf, size);
  // wait for a failure
  for (size_t n =3D 0; ;++n) {
    do_memmove(buf, size / sizeof (u32), n);
  }
  free(buf);
}

--MP_/LG=cCECd60AIASgpys9hr9K--

--Sig_/4frW/+mSuJHa5I1vsq5j2QV
Content-Type: application/pgp-signature
Content-Description: Цифровая подпись OpenPGP

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSZKa0VG5avZRlY01hxoe52YR/zqgUCWyV/qwAKCRBxoe52YR/z
qq9YAJ9pfdHvauOBO9AEnCaomfG18prluACaAqp5694EXrDjdQiNgtGkzxG0hi8=
=sWnM
-----END PGP SIGNATURE-----

--Sig_/4frW/+mSuJHa5I1vsq5j2QV--
