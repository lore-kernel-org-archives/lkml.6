Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D49EFC3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 887C820881
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 04:06:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="KIOzEips"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887C820881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751091AbeGJEGZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 00:06:25 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46916 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750998AbeGJEGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 00:06:14 -0400
Received: by mail-qt0-f193.google.com with SMTP id d4-v6so1781803qtn.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jul 2018 21:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=Cs92v38MW/9XTms1FQq7hMmw4/fYzhdSEncPwhPuyBk=;
        b=KIOzEipsgWzMVYkDHNYqL+qYPDu4eaafnJWXnBFIXKALajX+R9rMzI0UBHPEYQ01rL
         XDGMmdARON6Eqkh/EAes3uB1v0X1t4AiQhKtuLDzMrueEQIZTsQblA7j4m4E5S1ttDD5
         CegghOOznPrysGkV5bGFQE7qlR7H3OQsdB2cbpSagSpQbpishs24Zb2nFvURYbe6uuIz
         zQcEOYO7pSRIRu5aN+YQSpPMMXpa6Rs/wPRsLRFTUE1v7WZUFLCXhw4u6S1FPCG8kGb1
         CAeLY77nlzZLjroHX3nLXdyuATjxPHR2Y1ZeD4h6LCUehAkmuNG7FHsYwwF4xrZNfbMF
         5Wdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=Cs92v38MW/9XTms1FQq7hMmw4/fYzhdSEncPwhPuyBk=;
        b=LetfTOr565KggWbg2odPAvzyiW0qNBDYYDKapfssN0ZpPe2IVMcQ8ikaSzMJVO3P25
         D8bPMupg/0QgyiFRm8kKL/NTsLuAJP4m4gH1YwCbBBgh39Pk6Dc4wBxsMEd2NRXhHrax
         Y6XhMSm4SvBsJbBS7o0HyzYxMVj31hHZN3NAU6zyIpMuALy8QQl7TszqHXSfZ02iRenH
         mUW11MCQWTtyrwTNw/uX1aUlI208XNfcZS9NdQmEs6It7n33qsZBqX/6fWs4xELlaol0
         U2F295Rkv8ZfvI5U7i4cOGAyjskaCH1W01c5GAzPDoSag0yWgJ1iR6WEgNCPL1DDPzCG
         Hjfw==
X-Gm-Message-State: APt69E0G/zwqnNV1QHFMtpLBHS3rzT9WSdYkS5gXB6os9ekkZe1fqHGS
        1Bt2ZuLQS0GNVWGvSxpj/vFBrw==
X-Google-Smtp-Source: AAOMgpc5IGWsnY4nLmXxZRYOacVl7Xu8sJXqKwDSodw+WbnTrJuAT9NNYlpE8sXA1Q/A4+uCDTuc7w==
X-Received: by 2002:ac8:19db:: with SMTP id s27-v6mr22706174qtk.215.1531195573773;
        Mon, 09 Jul 2018 21:06:13 -0700 (PDT)
Received: from cakuba.lan ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id 8-v6sm880084qtz.46.2018.07.09.21.06.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Jul 2018 21:06:13 -0700 (PDT)
Date:   Mon, 9 Jul 2018 21:06:09 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Quentin Monnet <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v3 3/3] bpf: btf: print map dump and lookup
 with btf info
Message-ID: <20180709210609.284b29f7@cakuba.lan>
In-Reply-To: <20180708203336.570589830@fb.com>
References: <20180708203002.543403467@fb.com>
        <20180708203336.570589830@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 8 Jul 2018 13:30:05 -0700, Okash Khawaja wrote:
> This patch augments the output of bpftool's map dump and map lookup
> commands to print data along side btf info, if the correspondin btf
> info is available. The outputs for each of  map dump and map lookup
> commands are augmented in two ways:
> 
> 1. when neither of -j and -p are supplied, btf-ful map data is printed
> whose aim is human readability. This means no commitments for json- or
> backward- compatibility.
> 
> 2. when either -j or -p are supplied, a new json object named
> "formatted" is added for each key-value pair. This object contains the
> same data as the key-value pair, but with btf info. "formatted" object
> promises json- and backward- compatibility. Below is a sample output.
> 
> $ bpftool map dump -p id 8
> [{
>         "key": ["0x0f","0x00","0x00","0x00"
>         ],
>         "value": ["0x03", "0x00", "0x00", "0x00", ...
>         ],
>         "formatted": {
>                 "key": 15,
>                 "value": {
>                         "int_field":  3,
>                         ...
>                 }
>         }
> }
> ]
> 
> This patch calls btf_dumper introduced in previous patch to accomplish
> the above. Indeed, btf-ful info is only displayed if btf data for the
> given map is available. Otherwise existing output is displayed as-is.
> 
> Signed-off-by: Okash Khawaja <osk@fb.com>

> +static struct btf *get_btf(struct bpf_map_info *map_info)
> +{
> +	struct bpf_btf_info btf_info = { 0 };
> +	__u32 len = sizeof(btf_info);
> +	struct btf *btf = NULL;
> +	__u32 last_size;
> +	int btf_fd;
> +	void *ptr;
> +	int err;
> +
> +	btf_fd = bpf_btf_get_fd_by_id(map_info->btf_id);
> +	if (btf_fd < 0)
> +		return NULL;
> +
> +	/* we won't know btf_size until we call bpf_obj_get_info_by_fd(). so
> +	 * let's start with a sane default - 4KiB here - and resize it only if
> +	 * bpf_obj_get_info_by_fd() needs a bigger buffer.
> +	 */
> +	btf_info.btf_size = 4096;
> +	last_size = btf_info.btf_size;
> +	ptr = malloc(last_size);
> +	if (!ptr) {
> +		p_err("unable to allocate memory for debug info");
> +		goto exit_free;

I don't think we can continue working after a p_err() call :S
Or p_info() for that matter.  Something else may call p_err() again and
we'll end up with multiple "error" members in JSON.

Could you return an error and make the callers fail where you do goto
exit_free?  The case there is no BTF is okay to return NULL, but other
cases should really not happen, and I think it's OK to just error out
completely.

> +	}
> +
> +	bzero(ptr, last_size);
> +	btf_info.btf = ptr_to_u64(ptr);
> +	err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
> +
> +	if (!err && btf_info.btf_size > last_size) {
> +		void *temp_ptr;
> +
> +		last_size = btf_info.btf_size;
> +		temp_ptr = realloc(ptr, last_size);
> +		if (!temp_ptr) {
> +			p_err("unable to re-allocate memory for debug info");
> +			goto exit_free;
> +		}
> +		ptr = temp_ptr;
> +		bzero(ptr, last_size);
> +		btf_info.btf = ptr_to_u64(ptr);
> +		err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
> +	}
> +
> +	if (err || btf_info.btf_size > last_size) {
> +		p_info("can't get btf info. debug info won't be displayed. error: %s",
> +		       err ? strerror(errno) : "exceeds size retry");
> +		goto exit_free;
> +	}
> +
> +	btf = btf__new((__u8 *)btf_info.btf,
> +		       btf_info.btf_size, NULL);
> +	if (IS_ERR(btf)) {
> +		p_info("error when initialising btf: %s\n",
> +		       strerror(PTR_ERR(btf)));
> +		btf = NULL;
> +	}
> +
> +exit_free:
> +	close(btf_fd);
> +	free(ptr);
> +
> +	return btf;
> +}

> @@ -549,9 +681,18 @@ static int do_dump(int argc, char **argv
>  
>  		if (!bpf_map_lookup_elem(fd, key, value)) {
>  			if (json_output)
> -				print_entry_json(&info, key, value);
> +				print_entry_json(&info, key, value, btf);
>  			else
> -				print_entry_plain(&info, key, value);
> +				if (btf) {
> +					struct btf_dumper d = {
> +						.btf = btf,
> +						.jw = btf_wtr,
> +						.is_plain_text = true,
> +					};

nit: new line missing here and in another place

> +					do_dump_btf(&d, &info, key, value);
> +				} else {

