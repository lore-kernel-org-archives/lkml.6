Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF3BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5182F20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 10:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="T2bDpiVj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5182F20883
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932848AbeFUKZF (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 06:25:05 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38664 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753725AbeFUKZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 06:25:02 -0400
Received: by mail-wr0-f195.google.com with SMTP id e18-v6so2598935wrs.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 03:25:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=G1R+gDgROUyz6dnch1sW+RR9RWq/CHvzkrtmMnnpSSo=;
        b=T2bDpiVjNxQExxXUaZ6FVfCnSU1TYogxkZK0dxB8QrYEQ7JaX6qdJnTq/IzLRVAa+0
         v433A97xl5SfZS5oGKXhS0jR6HX3IOvTlUZLi8LAvH5VG5A3/ovj5Vazx5ZeUYYiheZG
         O+soAzONk+QSvpnG8UJYZZrBqhN7x7JvG5ResmMk2iwiH40vrA0uoQI5tOtumyrlqkX6
         c/Hzitc3VbHZvbFSsRW1JriXOoWW3RRo6n4eYpHxRYIZWGH4Y6+qpIO6RUnRMfXWQrK9
         ejypTY/gyUFrMN//DKc9QaZLuC3WPnlVe1Yo/upr8PrQCRELhTk86tTxeJsTFkEek6xD
         rJhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=G1R+gDgROUyz6dnch1sW+RR9RWq/CHvzkrtmMnnpSSo=;
        b=nSShJSUqywc2X3RYw/WxpcXwVF3ZHMcf1p3zLw6YZpagaM69Ecc/aRFiA9e3rBDnBl
         wp+jzRmbijIG8DqHcSlIojsHQcZ8G3HG4M3F0hor3YwiJEFRSqzklMG2+EsPiz/x9gY7
         MTO2g1otdEqZroS/I5MIgWF6dxrhEXNNWOwjYc4IGslgPmAV6ZTQYHkUFLO0CdvOtBMD
         UWlcLp7NMnv/Hhv92uFESWrgwTTfpbn9BvFsDNytU5mFKD5x1offwLNHxT1GpCi7mZoe
         84sioneTNXNxt/FJFPsSMEtlrFbjqFQk9Z0YG65aNayQ3qsjcGVBXfTc6jPPYqBzke8M
         260g==
X-Gm-Message-State: APt69E2XC6/Osbc7ubPK642J9breYaLBA2Fnaxs836Y/Yq5S0Iz1O2aP
        YN45re+nS/vqf5BsQvnk6aUHr2Uw
X-Google-Smtp-Source: AAOMgpcS6yuNo2RVZ8wKK8G3wDv73tlJ+NE1Y/Nha0sqs8PKxYIb4FYeNk+IWo5qOdpuVvfE/iWsyw==
X-Received: by 2002:adf:acc3:: with SMTP id o61-v6mr526134wrc.34.1529576701104;
        Thu, 21 Jun 2018 03:25:01 -0700 (PDT)
Received: from [172.20.1.93] (host-79-78-33-110.static.as9105.net. [79.78.33.110])
        by smtp.gmail.com with ESMTPSA id h77-v6sm8164679wmd.9.2018.06.21.03.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 03:25:00 -0700 (PDT)
Subject: Re: [PATCH bpf-next 3/3] bpf: btf: json print map dump with btf info
To:     Okash Khawaja <osk@fb.com>, Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
References: <20180620203051.223156973@fb.com>
 <20180620203703.208599277@fb.com>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <86ae5059-54c8-d078-4f6b-b212285dbfec@netronome.com>
Date:   Thu, 21 Jun 2018 11:24:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620203703.208599277@fb.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Okash,

Thanks for the patch! Please find some nitpicks inline below.

2018-06-20 13:30 UTC-0700 ~ Okash Khawaja <osk@fb.com>
> This patch modifies `bpftool map dump [-j|-p] id <map-id>` to json-
> print and pretty-json-print map dump. It calls btf_dumper introduced in
> previous patch to accomplish this.
> 
> The patch only prints debug info when -j or -p flags are supplied. Then
> too, if the map has associated btf data loaded. Otherwise the usual
> debug-less output is printed.
> 
> Signed-off-by: Okash Khawaja <osk@fb.com>
> Acked-by: Martin KaFai Lau <kafai@fb.com>
> 
> ---
>  tools/bpf/bpftool/map.c |   94 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 91 insertions(+), 3 deletions(-)
> 
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -43,9 +43,13 @@
>  #include <unistd.h>
>  #include <sys/types.h>
>  #include <sys/stat.h>
> +#include <linux/err.h>
>  
>  #include <bpf.h>
>  
> +#include "json_writer.h"
> +#include "btf.h"
> +#include "btf_dumper.h"
>  #include "main.h"
>  
>  static const char * const map_type_name[] = {
> @@ -508,6 +512,83 @@ static int do_show(int argc, char **argv
>  	return errno == ENOENT ? 0 : -1;
>  }
>  
> +
> +static int do_dump_btf(struct btf *btf, struct bpf_map_info *map_info,
> +		void *key, void *value)

Nit: Please align the second line on the opening parenthesis.

> +{
> +	int ret;
> +
> +	jsonw_start_object(json_wtr);
> +	jsonw_name(json_wtr, "key");
> +
> +	ret = btf_dumper_type(btf, json_wtr, map_info->btf_key_type_id, key);
> +	if (ret)
> +		goto out;
> +
> +	jsonw_end_object(json_wtr);
> +
> +	jsonw_start_object(json_wtr);
> +	jsonw_name(json_wtr, "value");
> +
> +	ret = btf_dumper_type(btf, json_wtr, map_info->btf_value_type_id,
> +			value);

Same comment.

> +
> +out:
> +	/* end of root object */
> +	jsonw_end_object(json_wtr);

This is not the root JSON object, which is not produced in that
function, so I find the comment misleading.

I also find it confusing that it closes the first JSON object of this
function if there is an error, but the second if "btf_dumper_type()"
succeeds. What about the following: closing the first object in all
cases, before evaluating the value of "ret", and if "ret" is non-null
returning immediately; and completely removing the "goto" from this
function?

> +
> +	return ret;
> +}
> +
> +static struct btf *get_btf(struct bpf_map_info *map_info)
> +{
> +	int btf_fd = bpf_btf_get_fd_by_id(map_info->btf_id);
> +	struct bpf_btf_info btf_info = { 0 };
> +	__u32 len = sizeof(btf_info);
> +	uint32_t last_size;
> +	int err;
> +	struct btf *btf = NULL;
> +	void *ptr = NULL, *temp_ptr;

Nit: please sort declarations in reverse-Christmas-tree order.

> +
> +	if (btf_fd < 0)
> +		return NULL;
> +
> +	btf_info.btf_size = 4096;
> +	do {
> +		last_size = btf_info.btf_size;
> +		temp_ptr = realloc(ptr, last_size);
> +		if (!temp_ptr) {
> +			p_err("unable allocate memory for debug info.");

"unable *to* allocate"?
(Also most other error messages do not end with a period, but here this
is just me being fussy.)

> +			goto exit_free;
> +		}
> +
> +		ptr = temp_ptr;
> +		bzero(ptr, last_size);
> +		btf_info.btf = ptr_to_u64(ptr);
> +		err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
> +	} while (!err && btf_info.btf_size > last_size && last_size == 4096);

If I understand correctly, the first time you try to retrieve up to 4096
bytes, and if the btf_info is larger than this, you try a second time
with the size returned in btf_info.btf_size instead. I don't find it
intuitive (but maybe this is just me?), do you think you could add a
comment above this bloc maybe?

> +
> +	if (err || btf_info.btf_size > last_size) {
> +		p_info("can't get btf info. debug info won't be displayed. error: %s",
> +				err ? strerror(errno) : "exceeds size retry");

Nit: Please align the second line on the opening parenthesis.

> +		goto exit_free;
> +	}
> +
> +	btf = btf__new((uint8_t *) btf_info.btf,

Nit: No space between the cast and the name of the variable.

> +			btf_info.btf_size, NULL);

Same remark on parenthesis here...

> +	if (IS_ERR(btf)) {
> +		printf("error when initialising btf: %s\n",
> +				strerror(PTR_ERR(btf)));

... and here.

> +		btf = NULL;
> +	}
> +
> +exit_free:
> +	close(btf_fd);
> +	free(ptr);
> +
> +	return btf;
> +}
> +
>  static int do_dump(int argc, char **argv)
>  {
>  	void *key, *value, *prev_key;
> @@ -516,6 +597,7 @@ static int do_dump(int argc, char **argv
>  	__u32 len = sizeof(info);
>  	int err;
>  	int fd;
> +	struct btf *btf = NULL;

Reverse-Christmas-tree order, please.

>  
>  	if (argc != 2)
>  		usage();
> @@ -538,6 +620,8 @@ static int do_dump(int argc, char **argv
>  		goto exit_free;
>  	}
>  
> +	btf = get_btf(&info);
> +
>  	prev_key = NULL;
>  	if (json_output)
>  		jsonw_start_array(json_wtr);
> @@ -550,9 +634,12 @@ static int do_dump(int argc, char **argv
>  		}
>  
>  		if (!bpf_map_lookup_elem(fd, key, value)) {
> -			if (json_output)
> -				print_entry_json(&info, key, value);
> -			else
> +			if (json_output) {
> +				if (btf)
> +					do_dump_btf(btf, &info, key, value);
> +				else
> +					print_entry_json(&info, key, value);
> +			} else
>  				print_entry_plain(&info, key, value);

Please add brackets around "print_entry_plain()" (to harmonise with the
"if" of the same bloc).

>  		} else {
>  			if (json_output) {
> @@ -584,6 +671,7 @@ exit_free:
>  	free(key);
>  	free(value);
>  	close(fd);
> +	btf__free(btf);
>  
>  	return err;
>  }
> 

Thanks,
Quentin
