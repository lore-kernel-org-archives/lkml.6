Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8B15C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71AB221855
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 21:03:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jw4Tnn7d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727010AbfAWVDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 16:03:11 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43173 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfAWVDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 16:03:11 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so1611265pgk.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 13:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GIwaEMRKzxnb6kRlUoX4AjXq8zujt0bvbN32eIubOBc=;
        b=jw4Tnn7d+cdlFORADnV4fHvzTEsuKH9PUcz1TG4QwybCM5scoDtiyf0TFXz7RoYnhu
         15TSgEO90GhRuif3wdIZQnZ9aZEai85d7t7yCyOzaPOx+CGvLTWfIKyDLkvSCxzgE2OI
         anOvV8s9CYDNbOf8Ch0HEEQza8YwQJ0d9a4w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GIwaEMRKzxnb6kRlUoX4AjXq8zujt0bvbN32eIubOBc=;
        b=IfQDCOchHKuzin6WHsbD8BNpfxBlHSTgLmzbKSV4JalkSZqpzDd9pik0wtHBnMJeCd
         3kBPeTAH5fqEr11/pimHxXNDOBrUbLMbe6kOyPUSwvqaT6vYfdbyOcDlGzKxgFaZ7XG+
         Cy6jV4hBvwWz8lUW76KrRCajBcBac2iMmrk49hot9eVc/jzXzlL/DlkuF/oPt50tOm9x
         1Uz9kxhxnVOAFzKFX4JV8TziSNoZnz4Dsf0OxPvp1dP1bcL/8rVY3C8C8YvbdmE90oWB
         gs7Z+VQ0tB085Eg9c86kT9s4a3hMw5SxQjdm7H4mHTvf2WmhBW4xno0T3gG8Ecb75CqO
         TIVg==
X-Gm-Message-State: AJcUukeHap8Gx3daMTmgSm4imi5PJWr63jriHVcq8mIryNzHnuwJY9zf
        xcYDB6NpsAktRLDFZxZUm8bTMw==
X-Google-Smtp-Source: ALg8bN6Ibk65HSi4ruiPnRIoOacUpKzIF4tLbRSmz8AoF+PAvtwAeCDJtz4oaio856vh+dYJMUWWNA==
X-Received: by 2002:a62:e044:: with SMTP id f65mr3585000pfh.208.1548277390263;
        Wed, 23 Jan 2019 13:03:10 -0800 (PST)
Received: from xps15 (S0106002369de4dac.cg.shawcable.net. [68.147.8.254])
        by smtp.gmail.com with ESMTPSA id r187sm67184687pfc.63.2019.01.23.13.03.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 Jan 2019 13:03:09 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:03:07 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Leo Yan <leo.yan@linaro.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mike Leach <mike.leach@linaro.org>,
        Robert Walker <robert.walker@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Coresight ML <coresight@lists.linaro.org>
Subject: Re: [PATCH v6 1/8] perf cs-etm: Add last instruction information in
 packet
Message-ID: <20190123210307.GA620@xps15>
References: <20190119014347.27441-1-leo.yan@linaro.org>
 <20190119014347.27441-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190119014347.27441-2-leo.yan@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 09:43:40AM +0800, Leo Yan wrote:
> Decoder provides last instruction related information, these information
> can be used for trace analysis; specifically we can get to know what
> kind of branch instruction has been executed, mainly the information
> are contained in three element fields:
> 
>   last_i_type: this is significant type for waypoint calculation, it
>   indicates the last instruction is one of immediate branch instruction,
>   indirect branch instruction, instruction barrier (ISB), or data
>   barrier (DSB/DMB).
> 
>   last_i_subtype: this is used for instruction sub type, it can be
>   branch with link, ARMv8 return instruction, ARMv8 eret instruction
>   (return from exception), or ARMv7 instruction which could imply
>   return (e.g. MOV PC, LR; POP { ,PC}).
> 
>   last_instr_cond: it indicates if the last instruction was conditional.
> 
> But these three fields are not saved into cs_etm_packet struct, thus
> cs-etm layer don't know related information and cannot generate sample
> flags for branch instructions.
> 
> This patch add corresponding three new fields in cs_etm_packet struct
> and save related value into the packet structure, it is preparation for
> supporting sample flags.
> 
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.c | 9 +++++++++
>  tools/perf/util/cs-etm-decoder/cs-etm-decoder.h | 3 +++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> index 8c155575c6c5..8a19310500d9 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.c
> @@ -290,6 +290,9 @@ static void cs_etm_decoder__clear_buffer(struct cs_etm_decoder *decoder)
>  		decoder->packet_buffer[i].instr_count = 0;
>  		decoder->packet_buffer[i].last_instr_taken_branch = false;
>  		decoder->packet_buffer[i].last_instr_size = 0;
> +		decoder->packet_buffer[i].last_instr_type = 0;
> +		decoder->packet_buffer[i].last_instr_subtype = 0;
> +		decoder->packet_buffer[i].last_instr_cond = 0;
>  		decoder->packet_buffer[i].cpu = INT_MIN;
>  	}
>  }
> @@ -323,6 +326,9 @@ cs_etm_decoder__buffer_packet(struct cs_etm_decoder *decoder,
>  	decoder->packet_buffer[et].instr_count = 0;
>  	decoder->packet_buffer[et].last_instr_taken_branch = false;
>  	decoder->packet_buffer[et].last_instr_size = 0;
> +	decoder->packet_buffer[et].last_instr_type = 0;
> +	decoder->packet_buffer[et].last_instr_subtype = 0;
> +	decoder->packet_buffer[et].last_instr_cond = 0;
>  
>  	if (decoder->packet_count == MAX_BUFFER - 1)
>  		return OCSD_RESP_WAIT;
> @@ -366,6 +372,9 @@ cs_etm_decoder__buffer_range(struct cs_etm_decoder *decoder,
>  	packet->start_addr = elem->st_addr;
>  	packet->end_addr = elem->en_addr;
>  	packet->instr_count = elem->num_instr_range;
> +	packet->last_instr_type = elem->last_i_type;
> +	packet->last_instr_subtype = elem->last_i_subtype;
> +	packet->last_instr_cond = elem->last_instr_cond;
>  
>  	switch (elem->last_i_type) {
>  	case OCSD_INSTR_BR:
> diff --git a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> index a6407d41598f..7cdd6a9c68a7 100644
> --- a/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> +++ b/tools/perf/util/cs-etm-decoder/cs-etm-decoder.h
> @@ -43,6 +43,9 @@ struct cs_etm_packet {
>  	u64 start_addr;
>  	u64 end_addr;
>  	u32 instr_count;
> +	u32 last_instr_type;
> +	u32 last_instr_subtype;
> +	u8 last_instr_cond;
>  	u8 last_instr_taken_branch;
>  	u8 last_instr_size;
>  	int cpu;

Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>

> -- 
> 2.17.1
> 
