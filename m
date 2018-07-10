Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B5CFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:56:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7FD72089D
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 03:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="RAFf/y07"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7FD72089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933258AbeGJD4Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 23:56:25 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:36956 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932939AbeGJD4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 23:56:17 -0400
Received: by mail-qt0-f195.google.com with SMTP id a18-v6so17266295qtj.4
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 20:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=N2bIMLBRer2sJ0az0bP6suUKNeFiMUaQuwosJTdvjYk=;
        b=RAFf/y07Zqf1utFZsIOAO5RQodc4F0F8RRPSA4lHLrAlrLfJDh0fpJcSOsB4bgo0BF
         LtvfTyRAjnzUZOI6Fq0+ZjtKhoqcPyeH03ysBs3EiEF3O5k2y77LWmPNlc+tQ23RM8hc
         wXIqHPOwsWXtMXcR6CB447CdoMAs9ZuZ8ejd7u7sVVnN1jhR0YPQsbQtdeVnZgFiWhC8
         NCw/w5LS6XvjVlP6KRkvzpIS8J7PEoqdYB/3MSdbzUZdIaqATpfFoA/lgxorbwoxOtCv
         1StV/udkI7bYoQc3oViQfvZsVcX0FKWSv93L6cm4oLSlxqDipoLKzcx2IEroHv7ymNtg
         S/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=N2bIMLBRer2sJ0az0bP6suUKNeFiMUaQuwosJTdvjYk=;
        b=Ri1Ayoki4/qOf2NIKMJBq/6uQhr1qWR4bkwrGTtOICk/CFKq/cAvyl+XOT2YEBzq9U
         4eO0Ohx6ay61ySXkKqG9Nwvd5HXC8qkJLiGT4pRwmwyPxBP66nwo5eaw2YSnJMU6ZOLp
         T2Xs06aEGJ0Uj3IFRY8GWKDQ9V9L3gtc6Tz2GqLL7RNPXB2ge4rnN/D11tFgDZcrJTyy
         aoKcfLiu9g+djUT0HyJ4Yr8HZhA+tbBLVUqzqjQxPfoM76tH3e032qWR2jsJlzYXc65K
         MmXqVOY+gC8AMNQdUOYwlr1xqH+41DeEYZySHmHHKsTc9NDtvr3TQzdq1iP0h6gktMhM
         b+uA==
X-Gm-Message-State: APt69E1tH9Tev5MVJamqimlZfTeiEaL/wreJS6rJum1Jn4IoWoUbW60O
        9vEXStd4paTPqCvN6Pq3sW2KYA==
X-Google-Smtp-Source: AAOMgpcukdqj/vEIY/V3agQB8utlfiJQarGbyi+xM3m92Wkfm1MUM2kslnKckqIjrOsj9xgt47fTEw==
X-Received: by 2002:a0c:91b5:: with SMTP id n50-v6mr20129404qvn.90.1531194976542;
        Mon, 09 Jul 2018 20:56:16 -0700 (PDT)
Received: from cakuba.lan ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id n25-v6sm11823326qtl.25.2018.07.09.20.56.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 20:56:16 -0700 (PDT)
Date:   Mon, 9 Jul 2018 20:56:12 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 2/3] bpf: btf: add btf print functionality
Message-ID: <20180709205612.5041acc9@cakuba.lan>
In-Reply-To: <20180708203336.433372958@fb.com>
References: <20180708203002.543403467@fb.com>
        <20180708203336.433372958@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2018 13:30:04 -0700, Okash Khawaja wrote:
> This consumes functionality exported in the previous patch. It does the
> main job of printing with BTF data. This is used in the following patch
> to provide a more readable output of a map's dump. It relies on
> json_writer to do json printing. Below is sample output where map keys
> are ints and values are of type struct A:
> 
> typedef int int_type;
> enum E {
>         E0,
>         E1,
> };
> 
> struct B {
>         int x;
>         int y;
> };
> 
> struct A {
>         int m;
>         unsigned long long n;
>         char o;
>         int p[8];
>         int q[4][8];
>         enum E r;
>         void *s;
>         struct B t;
>         const int u;
>         int_type v;
>         unsigned int w1: 3;
>         unsigned int w2: 3;
> };
> 
> $ sudo bpftool map dump id 14
> [{
>         "key": 0,
>         "value": {
>             "m": 1,
>             "n": 2,
>             "o": "c",
>             "p": [15,16,17,18,15,16,17,18
>             ],
>             "q": [[25,26,27,28,25,26,27,28
>                 ],[35,36,37,38,35,36,37,38
>                 ],[45,46,47,48,45,46,47,48
>                 ],[55,56,57,58,55,56,57,58
>                 ]
>             ],
>             "r": 1,
>             "s": 0x7ffd80531cf8,
>             "t": {
>                 "x": 5,
>                 "y": 10
>             },
>             "u": 100,
>             "v": 20,
>             "w1": 0x7,
>             "w2": 0x3
>         }
>     }
> ]
> 
> This patch uses json's {} and [] to imply struct/union and array. More
> explicit information can be added later. For example, a command line
> option can be introduced to print whether a key or value is struct
> or union, name of a struct etc. This will however come at the expense
> of duplicating info when, for example, printing an array of structs.
> enums are printed as ints without their names.
> 
> Signed-off-by: Okash Khawaja <osk@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
> ---
>  tools/bpf/bpftool/btf_dumper.c |  253 +++++++++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/main.h       |   15 ++
>  2 files changed, 268 insertions(+)
> 
> --- /dev/null
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -0,0 +1,253 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright (c) 2018 Facebook */
> +
> +#include <linux/btf.h>
> +#include <linux/err.h>
> +#include <stdio.h> /* for (FILE *) used by json_writer */
> +#include <linux/bitops.h>
> +#include <string.h>
> +#include <ctype.h>

fwiw: the preferred ordering would have been:

#include <ctype.h>
#include <stdio.h> /* for (FILE *) used by json_writer */
#include <string.h>
#include <linux/bitops.h>
#include <linux/btf.h>
#include <linux/err.h>

> +#include "btf.h"
> +#include "json_writer.h"
> +#include "main.h"
> +
> +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> +#define BITS_ROUNDUP_BYTES(bits) \
> +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> +const int one = 1;
> +#define is_big_endian() ((*(char *)&one) == 0)

Could we try to do this at compilation time?  Without the variable? :(

#include <asm/byteorder.h>

#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
	return true;
#else
	return false;
#endif

We could also just include endian.h, but since it's a non-standard
extension perhaps using kernel header is a safer bet.

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

nit: I think you missed these parenthesis

> +}
> +

> +static void btf_dumper_int_bits(__u32 int_type, __u8 bit_offset,
> +				const void *data, json_writer_t *jw,
> +				bool is_plain_text)
> +{
> +	int left_shift_bits, right_shift_bits;
> +	int nr_bits = BTF_INT_BITS(int_type);
> +	int total_bits_offset;
> +	int bytes_to_copy;
> +	int bits_to_copy;
> +	__u64 print_num;
> +
> +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> +	bits_to_copy = bit_offset + nr_bits;
> +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> +
> +	print_num = 0;
> +	memcpy(&print_num, data, bytes_to_copy);
> +	if (is_big_endian()) {
> +		left_shift_bits = bit_offset;
> +		right_shift_bits = 64 - nr_bits;
> +	} else {
> +		left_shift_bits = 64 - bits_to_copy;
> +		right_shift_bits = 64 - nr_bits;
> +	}

Or you can just put the #if here, since it's the only use.

> +	print_num <<= left_shift_bits;
> +	print_num >>= right_shift_bits;
> +	if (is_plain_text)
> +		jsonw_printf(jw, "0x%llx", print_num);
> +	else
> +		jsonw_printf(jw, "%llu", print_num);
> +}
> +
> +static int btf_dumper_int(const struct btf_type *t, __u8 bit_offset,
> +			  const void *data, json_writer_t *jw,
> +			  bool is_plain_text)
> +{
> +	__u32 *int_type;
> +	__u32 nr_bits;
> +
> +	int_type = (__u32 *)(t + 1);
> +	nr_bits = BTF_INT_BITS(*int_type);
> +	/* if this is bit field */
> +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> +	    BITS_PER_BYTE_MASKED(nr_bits)) {
> +		btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> +				    is_plain_text);
> +		return 0;
> +	}
> +
> +	switch (BTF_INT_ENCODING(*int_type)) {
> +	case 0:
> +		if (BTF_INT_BITS(*int_type) == 64)
> +			jsonw_printf(jw, "%lu", *((__u64 *)data));

nit: more parenthesis here

> +		else if (BTF_INT_BITS(*int_type) == 32)
> +			jsonw_printf(jw, "%u", *((__u32 *)data));
> +		else if (BTF_INT_BITS(*int_type) == 16)
> +			jsonw_printf(jw, "%hu", *((__u16 *)data));
> +		else if (BTF_INT_BITS(*int_type) == 8)
> +			jsonw_printf(jw, "%hhu", *((__u8 *)data));
> +		else
> +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> +					    is_plain_text);
> +		break;
> +	case BTF_INT_SIGNED:
> +		if (BTF_INT_BITS(*int_type) == 64)
> +			jsonw_printf(jw, "%ld", *((long long *)data));
> +		else if (BTF_INT_BITS(*int_type) == 32)
> +			jsonw_printf(jw, "%d", *((int *)data));
> +		else if (BTF_INT_BITS(*int_type) == 16)
> +			jsonw_printf(jw, "%hd", *((short *)data));
> +		else if (BTF_INT_BITS(*int_type) == 8)
> +			jsonw_printf(jw, "%hhd", *((char *)data));
> +		else
> +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> +					    is_plain_text);
> +		break;
> +	case BTF_INT_CHAR:
> +		if (*((char *)data) == '\0')

nit: here too, etc..

> +			jsonw_null(jw);

I don't think the null is good.  I thought I mentioned that?  Look for
example at Python:

>>> import json
>>> thing = json.loads('{"a": [97, 98, 99, 100]}')
>>> bytearray(thing["str"]).decode('utf-8')
'abcd'
>>> "".join(map(chr, thing["str"]))
'abcd'
>>> thing = json.loads('{"str": [97, 98, 99, 100, null]}')
>>> bytearray(thing["str"]).decode('utf-8')
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: an integer is required
>>> "".join(map(chr, thing["str"]))
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: an integer is required (got type NoneType)

If you start putting nulls into the array the conversion to a string
will become more difficult, won't it?  Do you have a use case where
this helps?  Maybe my Python-foo is not strong enough?

> +		else if (isprint(*((char *)data)))
> +			jsonw_printf(jw, "\"%c\"", *((char *)data));
> +		else
> +			if (is_plain_text)
> +				jsonw_printf(jw, "0x%hhx", *((char *)data));
> +			else
> +				jsonw_printf(jw, "\"\\u00%02hhx\"",
> +					     *((char *)data));
> +		break;
> +	case BTF_INT_BOOL:
> +		jsonw_bool(jw, *((int *)data));
> +		break;
> +	default:
> +		/* shouldn't happen */
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
> +static int btf_dumper_struct(const struct btf_dumper *d, __u32 type_id,
> +			     const void *data)
> +{
> +	const struct btf_type *t;
> +	struct btf_member *m;
> +	int ret = 0;
> +	int i, vlen;
> +
> +	t = btf__type_by_id(d->btf, type_id);
> +	if (!t)
> +		return -EINVAL;
> +
> +	vlen = BTF_INFO_VLEN(t->info);
> +	jsonw_start_object(d->jw);
> +	m = (struct btf_member *)(t + 1);
> +
> +	for (i = 0; i < vlen; i++) {
> +		const void *data_off = data +
> +				       BITS_ROUNDDOWN_BYTES(m[i].offset);

nit: empty line between variable declaration and code, perhaps also
don't init inline since it doesn't fit that way?

> +		jsonw_name(d->jw, btf__name_by_offset(d->btf, m[i].name_off));
> +		ret = btf_dumper_do_type(d, m[i].type,
> +					 BITS_PER_BYTE_MASKED(m[i].offset),
> +					 data_off);
> +		if (ret)
> +			break;
> +	}
> +
> +	jsonw_end_object(d->jw);
> +
> +	return ret;
> +}

Thanks for all the changes you've made so far!
