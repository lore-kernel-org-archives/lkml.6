Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9DF9C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6068222469
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 22:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="dyGZlD33"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6068222469
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753388AbeGCWXj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 18:23:39 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46391 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753111AbeGCWXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 18:23:37 -0400
Received: by mail-qt0-f195.google.com with SMTP id h5-v6so3017499qtm.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 15:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rtGgww4yfkrfzuYv0MZhW8sh+wc0pqLVAJGeggss1vg=;
        b=dyGZlD33eV/F/u94rmlp/u9UgsTXoe7s/g8rkxEGt7BQH61FO5ISxwpmTVtZ1MHGlf
         DnKPCD5vpitLHKXQcoZlUiUYvfXUd+fGMwKC7lqUT5K/RliL7y6KFHIqdgm1naQMzkCJ
         rc3tsbfjv0+Oj7jPE1hEdt+KCiJTbSOVqQbs2aLptDjDwy4V8GafGDz3nbhGDaH0Rn3n
         HL9++H/oYZKx2KtM7WbbCqsVM6rJQKLGUWrKiWCIURPesjfGjnYRhipYaalcQ2IW6yCZ
         abPPuch55EebEJznZflrdEbRc7RK9OKbo+/B06drAPYm3cBThBWHC044EIKxVre89k9h
         uHOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rtGgww4yfkrfzuYv0MZhW8sh+wc0pqLVAJGeggss1vg=;
        b=PyHxZKqMQWRnJB/sUYaeO8XKP9uH51BkP8UwcCyeUbYfArRUBrj3un+XQpodxhl62j
         9sMrEQZVIczlolArj9/mNw10WTpDIkO89AhdrtzjEvNwutL1v+GZI61IGXeVZWgbTm+F
         0WpDS+2bRuItRzIR+c0W+L3OlM75T49zqcabk6aq7TZ5uRPXPF6FjgP7XGLykNCJ5lgv
         iWD4KI/vYfZIh2iSqtNsAn+4HubX9DBEVa6uLGVtd6VaLGEQypz6PPq3fmSTzrJJeKPa
         Y4YUM9tLFvgv+Gg/N3w9jLAIUPXZrR3CFLP/pSQfBk4lppMoHWLE478VaxW64DgZHPPO
         hH2w==
X-Gm-Message-State: APt69E1wJlc5FO0KLdP0ZKfa1Q8qkdeiGE6aYxATk0xRvQoHwcnLJzWG
        LNQYlR4my/MCBaug7SyahDKrNw==
X-Google-Smtp-Source: AAOMgpclJ0q/wUHj9HPRQYwKyJV0MJcE4SHdZYdN5hJTN8kgv3wohBzfr3Lk8v7A4sslNdywxhmWKA==
X-Received: by 2002:aed:2798:: with SMTP id a24-v6mr29937082qtd.40.1530656616258;
        Tue, 03 Jul 2018 15:23:36 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id u10-v6sm1815271qki.6.2018.07.03.15.23.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:23:36 -0700 (PDT)
Date:   Tue, 3 Jul 2018 15:23:31 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 2/3] bpf: btf: add btf print functionality
Message-ID: <20180703152331.151d1c4b@cakuba.netronome.com>
In-Reply-To: <20180703214559.GA4448@w1t1fb>
References: <20180702183913.669030439@fb.com>
        <20180702191324.570616684@fb.com>
        <20180702220659.6baa77ba@cakuba.netronome.com>
        <20180703214559.GA4448@w1t1fb>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jul 2018 22:46:00 +0100, Okash Khawaja wrote:
> On Mon, Jul 02, 2018 at 10:06:59PM -0700, Jakub Kicinski wrote:
> > On Mon, 2 Jul 2018 11:39:15 -0700, Okash Khawaja wrote:  
> > > +#define BITS_PER_BYTE_MASK (BITS_PER_BYTE - 1)
> > > +#define BITS_PER_BYTE_MASKED(bits) ((bits) & BITS_PER_BYTE_MASK)  
> > 
> > Perhaps it's just me but BIT_OFFSET or BIT_COUNT as a name of this macro
> > would make it more obvious to parse in the code below.  
> I don't mind either. However these macro names are also used inside
> kernel for same purpose. For sake of consistency, I'd recommend we keep
> them :)

Ugh, okay :)

> > > +	} print_num;
> > > +
> > > +	total_bits_offset = bit_offset + BTF_INT_OFFSET(int_type);
> > > +	data += BITS_ROUNDDOWN_BYTES(total_bits_offset);
> > > +	bit_offset = BITS_PER_BYTE_MASKED(total_bits_offset);
> > > +	bits_to_copy = bits + bit_offset;
> > > +	bytes_to_copy = BITS_ROUNDUP_BYTES(bits_to_copy);
> > > +
> > > +	print_num.u64_num = 0;
> > > +	memcpy(&print_num.u64_num, data, bytes_to_copy);  
> > 
> > This scheme is unlikely to work on big endian machines...  
> Can you give an example how?

On BE:

Input:         [0x01, 0x82]
Bit length:    15
Bytes to copy:  2
bit_offset:     0
upper_bits:     7

print_num.u64_num = 0;
# [0, 0, 0, 0,   0, 0, 0, 0]

memcpy(&print_num.u64_num, data, bytes_to_copy);  
# [0x01, 0x82, 0, 0,   0, 0, 0, 0]

mask = (1 << upper_bits) - 1;
# mask = 0x7f

print_num.u8_nums[bytes_to_copy - 1] &= mask;
# [0x01, 0x02, 0, 0,   0, 0, 0, 0]

printf("0x%llx", print_num.u64_num);
# 0x0102000000000000 AKA 72620543991349248
# expected:
# 0x0102             AKA 258

Am I missing something?

> > > +	upper_bits = BITS_PER_BYTE_MASKED(bits_to_copy);
> > > +	if (upper_bits) {
> > > +		uint8_t mask = (1 << upper_bits) - 1;
> > > +
> > > +		print_num.u8_nums[bytes_to_copy - 1] &= mask;
> > > +	}
> > > +
> > > +	print_num.u64_num >>= bit_offset;
> > > +
> > > +	if (is_plain_text)
> > > +		jsonw_printf(jw, "0x%llx", print_num.u64_num);
> > > +	else
> > > +		jsonw_printf(jw, "%llu", print_num.u64_num);
> > > +}
> > > +
> > > +static int btf_dumper_int(const struct btf_type *t, uint8_t bit_offset,
> > > +			  const void *data, json_writer_t *jw,
> > > +			  bool is_plain_text)
> > > +{
> > > +	uint32_t *int_type = (uint32_t *)(t + 1);
> > > +	uint32_t bits = BTF_INT_BITS(*int_type);
> > > +	int ret = 0;
> > > +
> > > +	/* if this is bit field */
> > > +	if (bit_offset || BTF_INT_OFFSET(*int_type) ||
> > > +	    BITS_PER_BYTE_MASKED(bits)) {
> > > +		btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > > +				    is_plain_text);
> > > +		return ret;
> > > +	}
> > > +
> > > +	switch (BTF_INT_ENCODING(*int_type)) {
> > > +	case 0:
> > > +		if (BTF_INT_BITS(*int_type) == 64)
> > > +			jsonw_printf(jw, "%lu", *((uint64_t *)data));
> > > +		else if (BTF_INT_BITS(*int_type) == 32)
> > > +			jsonw_printf(jw, "%u", *((uint32_t *)data));
> > > +		else if (BTF_INT_BITS(*int_type) == 16)
> > > +			jsonw_printf(jw, "%hu", *((uint16_t *)data));
> > > +		else if (BTF_INT_BITS(*int_type) == 8)
> > > +			jsonw_printf(jw, "%hhu", *((uint8_t *)data));
> > > +		else
> > > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > > +					    is_plain_text);
> > > +		break;
> > > +	case BTF_INT_SIGNED:
> > > +		if (BTF_INT_BITS(*int_type) == 64)
> > > +			jsonw_printf(jw, "%ld", *((int64_t *)data));
> > > +		else if (BTF_INT_BITS(*int_type) == 32)
> > > +			jsonw_printf(jw, "%d", *((int32_t *)data));
> > > +		else if (BTF_INT_BITS(*int_type) ==  16)  
> > 
> > Please drop the double space.  Both for 16 where it makes no sense and
> > for 8 where it's marginally useful but not really.
> >   
> > > +			jsonw_printf(jw, "%hd", *((int16_t *)data));
> > > +		else if (BTF_INT_BITS(*int_type) ==  8)
> > > +			jsonw_printf(jw, "%hhd", *((int8_t *)data));
> > > +		else
> > > +			btf_dumper_int_bits(*int_type, bit_offset, data, jw,
> > > +					    is_plain_text);
> > > +		break;
> > > +	case BTF_INT_CHAR:
> > > +		if (*((char *)data) == '\0')
> > > +			jsonw_null(jw);  
> > 
> > Mm.. I don't think 0 char is equivalent to null.  
> Yes, thanks. Will fix.
> 
> >   
> > > +		else if (isprint(*((char *)data)))
> > > +			jsonw_printf(jw, "\"%c\"", *((char *)data));  
> > 
> > This looks very suspicious.  So if I see a "6" for a char field it's
> > either a 6 ('\u0006') or a 54 ('6')...  
> It will always be 54. May be I missed your point. Could you explain why
> it would be other than 54?

Ah, I think I missed that %c is in quotes...

> > > +		else
> > > +			if (is_plain_text)
> > > +				jsonw_printf(jw, "%hhx", *((char *)data));

This seems to be missing a "0x" prefix?

> > > +			else
> > > +				jsonw_printf(jw, "%hhd", *((char *)data));  
> > 
> > ... I think you need to always print a string, and express it as
> > \u00%02hhx for non-printable.  
> Okay that makes sense

Yeah, IDK, char can be used as a byte as well as a string.  In eBPF
it may actually be more likely to just be used as a raw byte buffer...
Either way I think it may be nice to keep it consistent, at least for
the JSON output could we do either always ints or always characters?
