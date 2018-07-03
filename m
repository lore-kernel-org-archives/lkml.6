Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF112C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F91C24D6B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 05:29:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="TJfdSQlL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F91C24D6B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753999AbeGCF3X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 01:29:23 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44660 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753822AbeGCF3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 01:29:21 -0400
Received: by mail-qt0-f195.google.com with SMTP id b15-v6so571202qtp.11
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 22:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=rwU9pFNNv9L/MnrMA0kZnm5scorxyWFO0MXGe31BueM=;
        b=TJfdSQlLG5UhzH+q4c0QoxTqaNBiCcqWZLlL034OA+u/8rNls5dBVuEkc+otWRyITn
         CEkkC6vvkp59YIscs6ogyHy070ebInhFvdrehsGUBiM/otIgl8BDhiDGqUDJWHOaaUDW
         Q8PD2Or9Kpt6KoT3JHKeJ+Y7vAJ+1Cu/8wX1hZ1VtwHli/p4cgCmcB96T9L1f41xKeta
         DlAlnYVyudtWG74uGuEY2+1wY03cFz7TTSoKn2lCMeNgyM8DoAt2GcZNHE819R7WH1X3
         Omld1b69Y5RlChLtWdvpB8vLq6kF9SrOEUyHwKGipYpXJq92riY8GcTFt+BbeQJ5qquK
         KFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=rwU9pFNNv9L/MnrMA0kZnm5scorxyWFO0MXGe31BueM=;
        b=YekM0jgw75KbHEKxtvRs4UYWpYq7ZKujOhv1aFb6MYryH3LttRo0X1XlqSwM/zOkK3
         xmc4CrAJpMomN+TF6UVjjz211128BUyTbcpvQ5leXWODHBgdc3Jy7mH6Cecqmaq7epu3
         aIIeyLSqbxlLZxciodCiX+P8B21LRI5MCY2R0dsmMckMvypm+eTFqdyMKU2c3glFa4ht
         92rFxZlyKjIx2XsDkYfqfdZrpe7r7dMNyACRBmMN3irbCffIwg4OFVcuA18yuq188rPd
         Ss0Aqyl4aGHJqcyQUXMD54d5Fb8+HUHhlq9DopnLPDXEf8GVxeNrTvWKq5RJsKu/Mffa
         ME0w==
X-Gm-Message-State: APt69E3S1jZM1XMA1PcX3Fk4jJNVLwx1WiztEekbMM/yZBzwQ4aR5iKm
        OpK/Wn11XVeiBD6zSANbW0UZ7w==
X-Google-Smtp-Source: AAOMgpfKeJ6m5rJPk92jJiHxEaKzGBqHhYmYgJx3Gkt0SAOLpt8BpeLokcQBynFz6mcyQM62JETw7g==
X-Received: by 2002:a0c:c309:: with SMTP id f9-v6mr24832060qvi.104.1530595760755;
        Mon, 02 Jul 2018 22:29:20 -0700 (PDT)
Received: from cakuba.netronome.com ([75.53.12.129])
        by smtp.gmail.com with ESMTPSA id g64-v6sm192597qkd.77.2018.07.02.22.29.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 Jul 2018 22:29:20 -0700 (PDT)
Date:   Mon, 2 Jul 2018 22:29:16 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Okash Khawaja <osk@fb.com>
Cc:     Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Yonghong Song <yhs@fb.com>,
        "Quentin Monnet" <quentin.monnet@netronome.com>,
        "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        <kernel-team@fb.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH bpf-next v2 3/3] bpf: btf: print map dump and lookup
 with btf info
Message-ID: <20180702222916.295e8012@cakuba.netronome.com>
In-Reply-To: <20180702191324.683291855@fb.com>
References: <20180702183913.669030439@fb.com>
        <20180702191324.683291855@fb.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 11:39:16 -0700, Okash Khawaja wrote:
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
> 
> ---
>  tools/bpf/bpftool/map.c |  174 +++++++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 166 insertions(+), 8 deletions(-)
> 
> --- a/tools/bpf/bpftool/map.c
> +++ b/tools/bpf/bpftool/map.c
> @@ -41,9 +41,13 @@
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

Please keep the headers in alphabetical order.

>  static const char * const map_type_name[] = {
> @@ -148,8 +152,99 @@ int map_parse_fd_and_info(int *argc, cha
>  	return fd;
>  }
>  
> +static int do_dump_btf(const struct btf_dumper *d,
> +		       struct bpf_map_info *map_info, void *key,
> +		       void *value)
> +{
> +	int ret;
> +
> +	/* start of key-value pair */
> +	jsonw_start_object(d->jw);
> +
> +	jsonw_name(d->jw, "key");
> +
> +	ret = btf_dumper_type(d, map_info->btf_key_type_id, key);
> +	if (ret)
> +		return ret;

goto err_end_obj;

> +	jsonw_name(d->jw, "value");
> +
> +	ret = btf_dumper_type(d, map_info->btf_value_type_id, value);

err_end_obj:

> +	/* end of key-value pair */
> +	jsonw_end_object(d->jw);
> +
> +	return ret;
> +}
> +
> +static struct btf *get_btf(struct bpf_map_info *map_info)
> +{
> +	int btf_fd = bpf_btf_get_fd_by_id(map_info->btf_id);

No failing functions in initializers please.

> +	struct bpf_btf_info btf_info = { 0 };
> +	__u32 len = sizeof(btf_info);
> +	void *ptr = NULL, *temp_ptr;
> +	struct btf *btf = NULL;
> +	uint32_t last_size;
> +	int err;
> +
> +	if (btf_fd < 0)
> +		return NULL;
> +
> +	/* we won't know btf_size until we call bpf_obj_get_info_by_fd(). so
> +	 * let's start with a sane default - 4KiB here - and resize it only if
> +	 * bpf_obj_get_info_by_fd() needs a bigger buffer. the do-while loop
> +	 * below should run a maximum of two iterations and that will be when
> +	 * we have to resize to a bigger buffer.
> +	 */
> +	btf_info.btf_size = 4096;
> +	do {
> +		last_size = btf_info.btf_size;
> +		temp_ptr = realloc(ptr, last_size);
> +		if (!temp_ptr) {
> +			p_err("unable to allocate memory for debug info");
> +			goto exit_free;
> +		}
> +
> +		ptr = temp_ptr;
> +		bzero(ptr, last_size);
> +		btf_info.btf = ptr_to_u64(ptr);
> +		err = bpf_obj_get_info_by_fd(btf_fd, &btf_info, &len);
> +	} while (!err && btf_info.btf_size > last_size && last_size == 4096);
> +
> +	if (err || btf_info.btf_size > last_size) {
> +		p_info("can't get btf info. debug info won't be displayed. error: %s",
> +		       err ? strerror(errno) : "exceeds size retry");
> +		goto exit_free;
> +	}

This "run me twice while handling realloc failure" loop seems very
unappealing.  Could you just open code this?

> +	btf = btf__new((uint8_t *)btf_info.btf,
> +		       btf_info.btf_size, NULL);
> +	if (IS_ERR(btf)) {
> +		printf("error when initialising btf: %s\n",
> +		       strerror(PTR_ERR(btf)));

printfs are not allowed, they break JSON.

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
> +static json_writer_t *get_btf_writer(void)
> +{
> +	json_writer_t *jw = jsonw_new(stdout);
> +
> +	if (!jw)
> +		return NULL;
> +	jsonw_pretty(jw, true);
> +
> +	return jw;
> +}
> +
>  static void print_entry_json(struct bpf_map_info *info, unsigned char *key,
> -			     unsigned char *value)
> +			     unsigned char *value, struct btf *btf)
>  {
>  	jsonw_start_object(json_wtr);
>  
> @@ -158,6 +253,15 @@ static void print_entry_json(struct bpf_
>  		print_hex_data_json(key, info->key_size);
>  		jsonw_name(json_wtr, "value");
>  		print_hex_data_json(value, info->value_size);
> +		if (btf) {
> +			struct btf_dumper d = {
> +				.btf = btf,
> +				.jw = json_wtr,
> +				.is_plain_text = false,
> +			};

Empty line after variables, please fix everywhere.

> +			jsonw_name(json_wtr, "formatted");
> +			do_dump_btf(&d, info, key, value);
> +		}
>  	} else {
>  		unsigned int i, n;
>  
> @@ -508,10 +612,12 @@ static int do_show(int argc, char **argv
>  
>  static int do_dump(int argc, char **argv)
>  {
> +	struct bpf_map_info info = {};
>  	void *key, *value, *prev_key;
>  	unsigned int num_elems = 0;
> -	struct bpf_map_info info = {};
>  	__u32 len = sizeof(info);
> +	json_writer_t *btf_wtr;
> +	struct btf *btf = NULL;
>  	int err;
>  	int fd;
>  
> @@ -537,8 +643,22 @@ static int do_dump(int argc, char **argv
>  	}
>  
>  	prev_key = NULL;
> +
> +	btf = get_btf(&info);
>  	if (json_output)
>  		jsonw_start_array(json_wtr);
> +	else
> +		if (btf) {
> +			btf_wtr = get_btf_writer();
> +			if (!btf_wtr) {
> +				p_info("failed to create json writer for btf. falling back to plain output");
> +				btf__free(btf);
> +				btf = NULL;
> +			} else {
> +				jsonw_start_array(btf_wtr);

Do we need to start array for non-JSON output?

> +			}
> +		}
> +
>  	while (true) {
>  		err = bpf_map_get_next_key(fd, prev_key, key);
>  		if (err) {
> @@ -549,9 +669,18 @@ static int do_dump(int argc, char **argv
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
> +					do_dump_btf(&d, &info, key, value);
> +				} else {
> +					print_entry_plain(&info, key, value);
> +				}
>  		} else {
>  			if (json_output) {
>  				jsonw_name(json_wtr, "key");
> @@ -574,14 +703,19 @@ static int do_dump(int argc, char **argv
>  
>  	if (json_output)
>  		jsonw_end_array(json_wtr);
> -	else
> +	else if (btf) {
> +		jsonw_end_array(btf_wtr);
> +		jsonw_destroy(&btf_wtr);
> +	} else {
>  		printf("Found %u element%s\n", num_elems,
>  		       num_elems != 1 ? "s" : "");
> +	}
>  
>  exit_free:
>  	free(key);
>  	free(value);
>  	close(fd);
> +	btf__free(btf);
>  
>  	return err;
>  }
> @@ -637,6 +771,8 @@ static int do_lookup(int argc, char **ar
>  {
>  	struct bpf_map_info info = {};
>  	__u32 len = sizeof(info);
> +	json_writer_t *btf_wtr;
> +	struct btf *btf = NULL;
>  	void *key, *value;
>  	int err;
>  	int fd;
> @@ -662,10 +798,31 @@ static int do_lookup(int argc, char **ar
>  
>  	err = bpf_map_lookup_elem(fd, key, value);
>  	if (!err) {
> -		if (json_output)
> -			print_entry_json(&info, key, value);
> -		else
> +		btf = get_btf(&info);
> +		if (json_output) {
> +			print_entry_json(&info, key, value, btf);
> +		} else if (btf) {
> +			/* if here json_wtr wouldn't have been initialised,
> +			 * so let's create separate writer for btf
> +			 */
> +			btf_wtr = get_btf_writer();
> +			if (!btf_wtr) {
> +				p_info("failed to create json writer for btf. falling back to plain output");
> +				btf__free(btf);
> +				btf = NULL;
> +				print_entry_plain(&info, key, value);
> +			} else {
> +				struct btf_dumper d = {
> +					.btf = btf,
> +					.jw = btf_wtr,
> +					.is_plain_text = true,
> +				};
> +				do_dump_btf(&d, &info, key, value);
> +				jsonw_destroy(&btf_wtr);
> +			}
> +		} else {

This is way too much code in a if (!err) branch.

Please refactor so that err = bpf_map_lookup_elem(fd, key, value); is
followed by error handling and the actual printing is non-indented.

>  			print_entry_plain(&info, key, value);
> +		}
>  	} else if (errno == ENOENT) {
>  		if (json_output) {
>  			jsonw_null(json_wtr);
> @@ -682,6 +839,7 @@ exit_free:
>  	free(key);
>  	free(value);
>  	close(fd);
> +	btf__free(btf);
>  
>  	return err;
>  }
> 

