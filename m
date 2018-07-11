Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC97CC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:10:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AB420C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 19:10:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="NrxptPxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71AB420C0C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389424AbeGKTQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 15:16:02 -0400
Received: from mail-qk0-f169.google.com ([209.85.220.169]:37066 "EHLO
        mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732979AbeGKTQB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 15:16:01 -0400
Received: by mail-qk0-f169.google.com with SMTP id t79-v6so14229693qke.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 12:10:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=e6sLqKw5xamHZuEPSnq0a5iCVuJeFutHYZTI20GjTrQ=;
        b=NrxptPxnI48jiSgJm38yadgJeKCeYJNLqxnobfbZIuT2Bv+o5mKtFwBX5hEAjOQhBc
         ifVVydyqE116IGjRMYhuL2TCl2Zy92860hbeAuCVgwho+8xBVIx+4k/3icNm9t3k4N60
         VMqtFq49/OMmin5bqXL+JOlFRur5bFy3ez8HqDVHVIjYigMBIhExl6sl/E/HhRv5n0OE
         Xi977+l+lBR8yTsZm5uWIcIl1rQlOd/HFOqMQLkqDypF63T1sj3Oa9bZQMyzPexR1NVR
         hgn86EultYyMUo73kTWWQMbnxvi5YbGJx0zUtqAeBUi7G7rhLs+Rm7lik8YdnZhRc1xZ
         mqoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=e6sLqKw5xamHZuEPSnq0a5iCVuJeFutHYZTI20GjTrQ=;
        b=pJ+U/oHC3ZCdQ7STQ0hpyylkRURb7KJt8lB6eg/gI6qeDRXQB2+qKN/9IwE2J7uYim
         Z9jCr4uuwxTYq8giIoAsRQVZQ8NU5sKLZ7WWSmsYi7oo6BRZgF4S1aLGDGU11QiGWM4O
         pcmWDBce1kCnXB5zC7U4UYIPRnqCcmOH51/5ZDe8IULu4DCaj6uTNKvilfR78WZPGQuH
         7TFdnFh3fpwG5WNNnXE44aCUz+hx8O8/LPmgAdnpsEaJO5TxTP5/3t3FtuF2UY3hlZze
         F7tILssZ/hKK9D6BbbERBa+KWN+BQx+AGaOzE0ylyZk9Ys7/kmj1gqanP+KH59F/XBkC
         B2Sw==
X-Gm-Message-State: APt69E1sphb8XW6sEXBq8UU5rt3THDkRQUI7IK/jUfUqlFww2BlerOOM
        PJZoN9QQVEOedChuV7X8jp8hIQ==
X-Google-Smtp-Source: AAOMgpcIvstZnWRYAGxDk+Pn+kvsyL3APeNrSiWVDNFLMGU3kyNjcS3KlleWCivZIPq/XeE8PTZocg==
X-Received: by 2002:a37:1194:: with SMTP id 20-v6mr28174515qkr.379.1531336219321;
        Wed, 11 Jul 2018 12:10:19 -0700 (PDT)
Received: from cakuba.lan ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id t11-v6sm16969705qkt.28.2018.07.11.12.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 12:10:19 -0700 (PDT)
Date:   Wed, 11 Jul 2018 12:10:15 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v4 2/3] bpf: btf: add btf print functionality
Message-ID: <20180711121015.42873aff@cakuba.lan>
In-Reply-To: <20180711032557.728015225@fb.com>
References: <20180711032108.631367556@fb.com>
        <20180711032557.728015225@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you for all the changes made so far.

On Tue, 10 Jul 2018 20:21:10 -0700, Okash Khawaja wrote:
> --- /dev/null
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -0,0 +1,248 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018 Facebook */
> +
> +#include <linux/btf.h>
> +#include <linux/err.h>
> +#include <stdio.h> /* for (FILE *) used by json_writer */
> +#include <linux/bitops.h>
> +#include <string.h>
> +#include <ctype.h>

Again, please sort the headers the way I suggested.  Otherwise as the
list of includes grows it's hard to know what's already there.

> +#include "btf.h"
> +#include "json_writer.h"
> +#include "main.h"
> +
> +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> +#define BITS_ROUNDUP_BYTES(bits) \
> +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> +
> +static int btf_dumper_do_type(const struct btf_dumper *d, __u32 type_id,
> +			      __u8 bit_offset, const void *data);
> +
> +static void btf_dumper_ptr(const void *data, json_writer_t *jw,
> +			   bool is_plain_text)
> +{
> +	if (is_plain_text)
> +		jsonw_printf(jw, "%p", *((unsigned long *)data));
> +	else
> +		jsonw_printf(jw, "%u", *((unsigned long *)data));

Again, please drop the extraneous parens.=20

> +}
> +

> +static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
> +				const void *data, json_writer_t *jw,
> +				bool is_plain_text)
> +{
> +	int left_shift_bits, right_shift_bits;
> +	int nr_bits =3D BTF_INT_BITS(int_type);
> +	int total_bits_offset;
> +	int bytes_to_copy;
> +	int bits_to_copy;
> +	__u64 print_num;
> +
> +	total_bits_offset =3D bit_offset + BTF_INT_OFFSET(int_type);
> +	data +=3D BITS_ROUNDDOWN_BYTES(total_bits_offset);
> +	bit_offset =3D BITS_PER_BYTE_MASKED(total_bits_offset);
> +	bits_to_copy =3D bit_offset + nr_bits;
> +	bytes_to_copy =3D BITS_ROUNDUP_BYTES(bits_to_copy);
> +
> +	print_num =3D 0;
> +	memcpy(&print_num, data, bytes_to_copy);
> +#ifdef __BIG_ENDIAN_BITFIELD
> +	left_shift_bits =3D bit_offset;
> +#else
> +	left_shift_bits =3D 64 - bits_to_copy;
> +#endif
> +	right_shift_bits =3D 64 - nr_bits;

Please include <asm/byteorder.h> as I suggested to you previously.
This is dead code right now, look:

$ git diff
diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index c64465094b92..045add07b721 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -91,7 +91,8 @@ static void btf_dumper_int_bits(__u32 int_type, __u8 bit_=
offset,
=20
        print_num =3D 0;
        memcpy(&print_num, data, bytes_to_copy);
-#ifdef __BIG_ENDIAN_BITFIELD
+#ifndef __LITTLE_ENDIAN_BITFIELD
+#error "abc"
        left_shift_bits =3D bit_offset;
 #else
        left_shift_bits =3D 64 - bits_to_copy;

$ make -C tools/bpf/bpftool/ CC=3Dgcc-8
make: Entering directory '/home/jkicinski/devel/linux/tools/bpf/bpftool'
  CC       btf_dumper.o
btf_dumper.c: In function =E2=80=98btf_dumper_int_bits=E2=80=99:
btf_dumper.c:95:2: error: #error "abc"
 #error "abc"
  ^~~~~
Makefile:96: recipe for target 'btf_dumper.o' failed
make: *** [btf_dumper.o] Error 1
make: Leaving directory '/home/jkicinski/devel/linux/tools/bpf/bpftool'
