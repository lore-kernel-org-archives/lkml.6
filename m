Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx4+b/pYEPmq5QG3wxrTwN3Rmckz5zEhr5wlkHTFeO5NkgGQQufz6V1dr6NUcS3PA+UeM9fCK
ARC-Seal: i=1; a=rsa-sha256; t=1522699333; cv=none;
        d=google.com; s=arc-20160816;
        b=YB9uxM4nQCNdO3qj2qHTRSFpEBu3V2LLK2zfyaSXfqU7WP9WpZndw4CN5t6pxiGZeG
         eR/4A/Rrh6Sv47v4M6C/FWks2dXH46Ra/ESfV/2iakrzOl1Kq5rPRDiuFsQ1zhsK1c7T
         kctGdfweuSGWFEkXOoWwnJMmdbDGATMTs4FE2knWCcvLZdhoycY9euBW/PG0fb7PXs03
         rXtSLg0ue4trvUDvKEETI8pBibA8MVmJbmhci+OmHWU5v8ewkmBdBkblDVQkjVMMlV95
         is8H0IW/oNpMfSWhvApQaqEZWowUPKeAki74nxb8aaC4HO7NHoyJrMzVOR5obFJNvEg4
         Ioxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding:mime-version
         :references:in-reply-to:message-id:subject:cc:to:from:date
         :dmarc-filter:arc-authentication-results;
        bh=VUN1vAakLm3OgDuTaEzvrZBjhBptOQCy46l9Qw4Xokc=;
        b=TBN3cjlhelhfXKGREvXcvDSspp7/ii3AqcgE1220YHLl2sDRLkvzaWIPRPu0Zd02kD
         khB1EZSVl0V3JKEAyTFFu9c9Huu03zc/Bb/pS6d6tG7w8aKOxMDtanM0lVpdYwUgQqA/
         TpVS+c+xfg/9TxTGMu1GZDOp/x6W3LnDANQUlc/v9EszH4gRKCOmYFaINW8lR5oLLrOo
         JQ8WkKiaJFLyb6XDyuUJ2m1p6rP0s8yZRfzASXWTKQF6s070SgLTsqKwH6avV4V/0ttW
         cHFKXBn4XIO64HmRa6H7Hb1hmU2kiZdfgj2Kfum8yE8Ai/dwFPM8aIlmN4Z6/ej1Xbyi
         QYpA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932430AbeDBUCL (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Mon, 2 Apr 2018 16:02:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:46870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932412AbeDBUCL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Apr 2018 16:02:11 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501E9214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=rostedt@goodmis.org
Date: Mon, 2 Apr 2018 16:02:07 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-trace-users@vger.kernel.org, linux-kselftest@vger.kernel.org,
        shuah@kernel.org, Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Subject: Re: [PATCH v6 10/21] tracing: probeevent: Return consumed bytes of
 dynamic area
Message-ID: <20180402160207.23c96309@gandalf.local.home>
In-Reply-To: <152129069244.31874.7879658400858676349.stgit@devbox>
References: <152129024033.31874.15800253385376959274.stgit@devbox>
        <152129069244.31874.7879658400858676349.stgit@devbox>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595188955089509902?=
X-GMAIL-MSGID: =?utf-8?q?1596665976233366702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sat, 17 Mar 2018 21:44:52 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> -static nokprobe_inline void
> -fetch_store_string(unsigned long addr, void *dest)
> +static nokprobe_inline int
> +fetch_store_string(unsigned long addr, void *dest, void *base)
>  {
> -	int maxlen = get_rloc_len(*(u32 *)dest);
> -	u8 *dst = get_rloc_data(dest);
> +	int maxlen = get_loc_len(*(u32 *)dest);
> +	u8 *dst = get_loc_data(dest, base);
>  	long ret;
>  
>  	if (!maxlen)
> -		return;
> +		return -ENOMEM;
>  
>  	/*
>  	 * Try to get string again, since the string can be changed while
> @@ -854,19 +851,19 @@ fetch_store_string(unsigned long addr, void *dest)
>  
>  	if (ret < 0) {	/* Failed to fetch string */
>  		dst[0] = '\0';
> -		*(u32 *)dest = make_data_rloc(0, get_rloc_offs(*(u32 *)dest));
> -	} else {
> -		*(u32 *)dest = make_data_rloc(ret, get_rloc_offs(*(u32 *)dest));
> +		ret = 0;

Why do you return 0 here and not the error value? You return -ENOMEM
above if maxlen is zero.

-- Steve

>  	}
> +	*(u32 *)dest = make_data_loc(ret, (void *)dst - base);
> +	return ret;
>  }
