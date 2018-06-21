Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EA04C43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AA620837
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:43:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="K2aF+2Em"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2AA620837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754252AbeFUKnF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:43:05 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52957 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752650AbeFUKnD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:43:03 -0400
Received: by mail-wm0-f66.google.com with SMTP id p126-v6so4365947wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 03:43:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jEVNVT8bRjLAtxYqW96hAulFo+XlqBPqoVGfM0syxJk=;
        b=K2aF+2EmCSig30QZzJM1F/xUL5Hl0pnsQpAeAGg6PNrMxvlKmbCfHGk6EPaOfmWRGT
         KhBKRAi7E0DaDBow97HfaatWv34mvCu99W9bEQmEjNvjGEBSzylb4ZcGHLhYhdVr7H3M
         TGaukepNrBLla3P8TASEdqXmo/N/B3CNZFDjMJdlI+vszrvZCyntlNe21ZAAylJIAyS5
         yWq/nZBkE++3dGni+pneoeYQ+mIQNuHkm41VEFXXTruftUgbtEOnsq3PdtPgZYWTXcjf
         5ajIUnBS1c9NExyHJMZ+7S1JYH+RCC4niyKkQMa3T4GMuV4c8Ck3ZZz0UJmmprMDdnDw
         xhmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=jEVNVT8bRjLAtxYqW96hAulFo+XlqBPqoVGfM0syxJk=;
        b=rprLcFDbyx3+iPXU9Ki9LAyDYs3EjBCGZvC5QVAIfBp7cT1cQOWmD+pd+I6yvq+8YQ
         vbZKm7KO7y7sJKkgQYpvnb0ZwBD6SgXnnm08UWKEoODL46LT5HLLjFWEXEwqEZtw0Vt4
         Qf/QplTBolrC1x7wHpiAi6zEFeEDL54rQs6h3/sS5bDfustn2BMGbAXkthRaJfEgMXEf
         mWOKWg6cxv4o0ih5OrpDpHRZgtoADTlXLJ9RpEIsd+HB4329zyOMso6umEv10Hc8ln8C
         IVwZXCW6+hdXve16LYD1WcvFQcaCp444RPGDXh/p/MI+5H0BS/fq1xHbvFmE6Ful9YyG
         KdQA==
X-Gm-Message-State: APt69E2S+GBIjzpwP6WDBD6O8NAkak5mlOFmzZ2Mrb95XzXWel2KyIvA
        e9b0MzUkqgV3WhDplqxW4AVfvmqZ
X-Google-Smtp-Source: ADUXVKKj5Jx4BFzQmIsloUVTA2NSVPhQgnCilOGO8t9AdHxL10m6exIIdRDZMNow8BI4ST4dY7v5xA==
X-Received: by 2002:a1c:bfc8:: with SMTP id o69-v6mr5068058wmi.8.1529577781503;
        Thu, 21 Jun 2018 03:43:01 -0700 (PDT)
Received: from [172.20.1.93] (host-79-78-33-110.static.as9105.net. [79.78.33.110])
        by smtp.gmail.com with ESMTPSA id b80-v6sm7197260wmf.2.2018.06.21.03.42.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 03:43:00 -0700 (PDT)
Subject: Re: [PATCH bpf-next 2/3] bpf: btf: add btf json print functionality
To:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20180620203051.223156973@fb.com>
 <20180620203703.101156292@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <3db6047a-101a-2ed1-9ca3-9e90b45ea00f@netronome.com>
Date:   Thu, 21 Jun 2018 11:42:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620203703.101156292@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Okash,

2018-06-20 13:30 UTC-0700 ~ Okash Khawaja <osk@fb.com>
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
> $ sudo bpftool map dump -p id 14
> [{
>         "key": 0
>     },{
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
>             "s": 0x7ffff6f70568,

Hexadecimal values, without quotes, are not valid JSON. Please stick to
decimal values.

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
>  tools/bpf/bpftool/btf_dumper.c |  247 +++++++++++++++++++++++++++++++++++++++++
>  tools/bpf/bpftool/btf_dumper.h |   18 ++
>  2 files changed, 265 insertions(+)
> 
> --- /dev/null
> +++ b/tools/bpf/bpftool/btf_dumper.c
> @@ -0,0 +1,247 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2018 Facebook */
> +
> +#include <linux/btf.h>
> +#include <linux/err.h>
> +#include <stdio.h> /* for (FILE *) used by json_writer */
> +#include <linux/bitops.h>
> +#include <string.h>
> +#include <ctype.h>
> +
> +#include "btf.h"
> +#include "json_writer.h"
> +
> +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)
> +#define BITS_ROUNDDOWN_BYTES(bits) ((bits) >> 3)
> +#define BITS_ROUNDUP_BYTES(bits) \
> +	(BITS_ROUNDDOWN_BYTES(bits) + !!BITS_PER_BYTE_MASKED(bits))
> +
> +static int btf_dumper_do_type(const struct btf *btf, uint32_t type_id,
> +		uint8_t bit_offset, const void *data, json_writer_t *jw);
> +
> +static void btf_dumper_ptr(const void *data, json_writer_t *jw)
> +{
> +	jsonw_printf(jw, "%p", *((uintptr_t *)data));
> +}
> +
> +static int btf_dumper_modifier(const struct btf *btf, uint32_t type_id,
> +		const void *data, json_writer_t *jw)
> +{
> +	int32_t actual_type_id = btf__resolve_type(btf, type_id);
> +	int ret;
> +
> +	if (actual_type_id < 0)
> +		return actual_type_id;
> +
> +	ret = btf_dumper_do_type(btf, actual_type_id, 0, data, jw);
> +
> +	return ret;
> +}
> +
> +static void btf_dumper_enum(const void *data, json_writer_t *jw)
> +{
> +	jsonw_printf(jw, "%d", *((int32_t *)data));
> +}
> +
> +static int btf_dumper_array(const struct btf *btf, uint32_t type_id,
> +		const void *data, json_writer_t *jw)
> +{
> +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> +	struct btf_array *arr = (struct btf_array *)(t + 1);
> +	int64_t elem_size;
> +	uint32_t i;
> +	int ret;
> +
> +	elem_size = btf__resolve_size(btf, arr->type);
> +	if (elem_size < 0)
> +		return elem_size;
> +
> +	jsonw_start_array(jw);
> +	for (i = 0; i < arr->nelems; i++) {
> +		ret = btf_dumper_do_type(btf, arr->type, 0,
> +				data + (i * elem_size), jw);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	jsonw_end_array(jw);
> +
> +	return 0;
> +}
> +
> +static void btf_dumper_int_bits(uint32_t int_type, uint8_t bit_offset,
> +		const void *data, json_writer_t *jw)
> +{
> +	uint16_t total_bits_offset;
> +	uint32_t bits = BTF_INT_BITS(int_type);

Nit: Please use reverse-Christmas-tree here.

As for patch 3 you also have a number of continuation lines not aligned
on the opening parenthesis from the first line, throughout the patch
(please consider running checkpatch in "--strict" mode for the list).

> +	uint16_t bytes_to_copy;
> +	uint16_t bits_to_copy;
> +	uint8_t upper_bits;
> +	union {
> +		uint64_t u64_num;
> +		uint8_t u8_nums[8];
> +	} print_num;
> +
> +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> +	bits_to_copy = bits + bit_offset;
> +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> +
> +	print_num.u64_num = 0;
> +	memcpy(&print_num.u64_num, data, bytes_to_copy);
> +
> +	upper_bits = BITS_PER_BYTE_MASKED(bits_to_copy);
> +	if (upper_bits) {
> +		uint8_t mask = (1 << upper_bits) - 1;
> +
> +		print_num.u8_nums[bytes_to_copy - 1] &= mask;
> +	}
> +
> +	print_num.u64_num >>= bit_offset;
> +
> +	jsonw_printf(jw, "0x%llx", print_num.u64_num);
> +}
> +
> +static int btf_dumper_int(const struct btf_type *t, uint8_t bit_offset,
> +		const void *data, json_writer_t *jw)
> +{
> +	uint32_t *int_type = (uint32_t *)(t + 1);
> +	uint32_t bits = BTF_INT_BITS(*int_type);
> +	int ret = 0;
> +
> +	/* if this is bit field */
> +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> +			BITS_PER_BYTE_MASKED(bits)) {
> +		btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> +		return ret;
> +	}
> +
> +	switch (BTF_INT_ENCODING(*int_type)) {
> +	case 0:
> +		if (BTF_INT_BITS(*int_type) == 64)
> +			jsonw_printf(jw, "%lu", *((uint64_t *)data));
> +		else if (BTF_INT_BITS(*int_type) == 32)
> +			jsonw_printf(jw, "%u", *((uint32_t *)data));
> +		else if (BTF_INT_BITS(*int_type) == 16)
> +			jsonw_printf(jw, "%hu", *((uint16_t *)data));
> +		else if (BTF_INT_BITS(*int_type) == 8)
> +			jsonw_printf(jw, "%hhu", *((uint8_t *)data));
> +		else
> +			btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> +		break;
> +	case BTF_INT_SIGNED:
> +		if (BTF_INT_BITS(*int_type) == 64)
> +			jsonw_printf(jw, "%ld", *((int64_t *)data));
> +		else if (BTF_INT_BITS(*int_type) == 32)
> +			jsonw_printf(jw, "%d", *((int32_t *)data));
> +		else if (BTF_INT_BITS(*int_type) ==  16)
> +			jsonw_printf(jw, "%hd", *((int16_t *)data));
> +		else if (BTF_INT_BITS(*int_type) ==  8)
> +			jsonw_printf(jw, "%hhd", *((int8_t *)data));
> +		else
> +			btf_dumper_int_bits(*int_type, bit_offset, data, jw);
> +		break;
> +	case BTF_INT_CHAR:
> +		if (*((char *)data) == '\0')
> +			jsonw_null(jw);
> +		else if (isprint(*((char *)data)))
> +			jsonw_printf(jw, "\"%c\"", *((char *)data));
> +		else
> +			jsonw_printf(jw, "%hhx", *((char *)data));
> +		break;
> +	case BTF_INT_BOOL:
> +		jsonw_bool(jw, *((int *)data));
> +		break;
> +	default:
> +		/* shouldn't happen */
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +static int btf_dumper_struct(const struct btf *btf, uint32_t type_id,
> +		const void *data, json_writer_t *jw)
> +{
> +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> +	struct btf_member *m;
> +	int ret = 0;
> +	int i, vlen;
> +
> +	if (t == NULL)
> +		return -EINVAL;
> +
> +	vlen = BTF_INFO_VLEN(t->info);
> +	jsonw_start_object(jw);
> +	m = (struct btf_member *)(t + 1);
> +
> +	for (i = 0; i < vlen; i++) {
> +		jsonw_name(jw, btf__name_by_offset(btf, m[i].name_off));
> +		ret = btf_dumper_do_type(btf, m[i].type,
> +				BITS_PER_BYTE_MASKED(m[i].offset),
> +				data + BITS_ROUNDDOWN_BYTES(m[i].offset), jw);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	jsonw_end_object(jw);
> +
> +	return 0;
> +}
> +
> +static int btf_dumper_do_type(const struct btf *btf, uint32_t type_id,
> +		uint8_t bit_offset, const void *data, json_writer_t *jw)
> +{
> +	const struct btf_type *t = btf__type_by_id(btf, type_id);
> +	int ret = 0;
> +
> +	switch (BTF_INFO_KIND(t->info)) {
> +	case BTF_KIND_INT:
> +		ret = btf_dumper_int(t, bit_offset, data, jw);
> +		break;
> +	case BTF_KIND_STRUCT:
> +	case BTF_KIND_UNION:
> +		ret = btf_dumper_struct(btf, type_id, data, jw);
> +		break;
> +	case BTF_KIND_ARRAY:
> +		ret = btf_dumper_array(btf, type_id, data, jw);
> +		break;
> +	case BTF_KIND_ENUM:
> +		btf_dumper_enum(data, jw);
> +		break;
> +	case BTF_KIND_PTR:
> +		btf_dumper_ptr(data, jw);
> +		break;
> +	case BTF_KIND_UNKN:
> +		jsonw_printf(jw, "(unknown)");
> +		break;
> +	case BTF_KIND_FWD:
> +		/* map key or value can't be forward */
> +		ret = -EINVAL;
> +		break;
> +	case BTF_KIND_TYPEDEF:
> +	case BTF_KIND_VOLATILE:
> +	case BTF_KIND_CONST:
> +	case BTF_KIND_RESTRICT:
> +		ret = btf_dumper_modifier(btf, type_id, data, jw);
> +		break;
> +	default:
> +		jsonw_printf(jw, "(unsupported-kind");
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	return ret;
> +}
> +
> +int32_t btf_dumper_type(const struct btf *btf, json_writer_t *jw,
> +		uint32_t type_id, const void *data)
> +{
> +	if (!jw)
> +		return -EINVAL;
> +
> +	return btf_dumper_do_type(btf, type_id, 0, data, jw);
> +}
> --- /dev/null
> +++ b/tools/bpf/bpftool/btf_dumper.h
> @@ -0,0 +1,18 @@
> +/* SPDX-License-Identifier: GPL-2.0 */

I believe SPDX tag in header files should use C++ style comments (//)?

> +/* Copyright (c) 2018 Facebook */
> +
> +#ifndef BTF_DUMPER_H
> +#define BTF_DUMPER_H
> +
> +/* btf_dumper_type - json print data along with type information
> + * @btf: btf instance initialised via btf__new()
> + * @jw: json writer used for printing
> + * @type_id: index in btf->types array. this points to the type to be dumped
> + * @data: pointer the actual data, i.e. the values to be printed
> + *
> + * Returns zero on success and negative error code otherwise
> + */
> +int32_t btf_dumper_type(const struct btf *btf, json_writer_t *jw,
> +		uint32_t type_id, void *data);
> +
> +#endif
> 

Thanks,
Quentin
