Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03130ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6A1A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 18:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="BvmcBHwH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A1A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=netronome.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeGRS67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 14:58:59 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38915 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729215AbeGRS66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 14:58:58 -0400
Received: by mail-pg1-f193.google.com with SMTP id g2-v6so2367027pgs.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jul 2018 11:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=MSbKYAMIU6EsKJxhvFHArp1Gp/2l4cYJvXqXvd/wmK8=;
        b=BvmcBHwH5x7O0FcrTx54B3mF2OzfVjQhSXkSnlxWBH9KPfBykiqayoyLo0+onpXXbx
         b2pY3K4dkndaywH6/VCC3tmz9psTkXNvhnMcS44VJu9k9nI7GP9xEyK0dVhIMMOX28FD
         q8Lp3McqzqHruNE8Y8pvSD0NlMc9jGtcHbYgoIfQCBR78rzM36So2kHly9nCYYbvquC1
         niXbFT4Rqv1Yhb5lJx0npT+8b1KKTh2XP6jPqZLu0dGe+cc1AVamag/36sAlQEbwPI+f
         CuXU2cCAot1BLQZ4kLUxTpgot2FdotbnisvsW+ZSIymyM8jQuZOVitD3CjMyaf8//LRZ
         P7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=MSbKYAMIU6EsKJxhvFHArp1Gp/2l4cYJvXqXvd/wmK8=;
        b=lSe8P1KDM4EebRrEVSzxVE6816j809/FBjFITotVsekYDEaXLBJEHOUUiL2cJTSNM+
         6cx9jj8mSAiMnkSVJaq6azRDSbiqWSzBx7kSuHROgdHwtUiTH4Kq1ib0xuzUI9nTfnkn
         zNZ60X1ZZwl0TkMMDUsJMV1s831Dk3nkmK9h9HafQb7WafrMCUs/kbefpxmTnuHTo9w3
         ZPXNQP+uyTTahNi8FERO/60D02Q80HIvnfWwf4GsBN//HJD9o1n1SeilA5wIzRWh0WYs
         rjdqLXMgOL7Ht06NHODFYSBA9g8QCKaivl9gHWOPoZY1985uYlcn+77blPRk669CqFvr
         vt2g==
X-Gm-Message-State: AOUpUlHor7EW1nrXymxeVewecX815Dsh5l62lv+HtOUO6RhWKxqA5ttm
        I9lASpf0v2pPiEDy3jhwPpPFVq2t
X-Google-Smtp-Source: AAOMgpfLnsb/r9IJHGN+e+lWfFXsZHWeviKXecexWPLE6MrbojXS0mmUVdgDVK0Ey2OjMdBtSBKtfg==
X-Received: by 2002:a63:64c2:: with SMTP id y185-v6mr6745734pgb.126.1531937992801;
        Wed, 18 Jul 2018 11:19:52 -0700 (PDT)
Received: from cakuba.lan (c-73-231-89-118.hsd1.ca.comcast.net. [73.231.89.118])
        by smtp.gmail.com with ESMTPSA id s27-v6sm14038964pfk.133.2018.07.18.11.19.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Jul 2018 11:19:52 -0700 (PDT)
Date:   Wed, 18 Jul 2018 11:19:49 -0700
From:   Jakub Kicinski <jakub.kicinski@netronome.com>
To:     Taeung Song <treeze.taeung@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] tools/bpftool: Fix segfault case regarding 'pin'
 arguments
Message-ID: <20180718111949.325c985b@cakuba.lan>
In-Reply-To: <20180718133526.19669-2-treeze.taeung@gmail.com>
References: <20180718133526.19669-1-treeze.taeung@gmail.com>
        <20180718133526.19669-2-treeze.taeung@gmail.com>
Organization: Netronome Systems, Ltd.
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Jul 2018 22:35:26 +0900, Taeung Song wrote:
> Arguments of 'pin' subcommand should be checked
> at the very beginning of do_pin_any().
> Otherwise segfault errors can occur when using
> 'map pin' or 'prog pin' commands, so fix it.
> 
>   # bpftool prog pin id
>   Segmentation fault
> 
> Fixes: 71bb428fe2c1 ("tools: bpf: add bpftool")
> Cc: Jakub Kicinski <jakub.kicinski@netronome.com>
> Reported-by: Taehee Yoo <ap420073@gmail.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>
> ---
>  tools/bpf/bpftool/common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/common.c b/tools/bpf/bpftool/common.c
> index 32f9e397a6c0..b1e1ba9e1c90 100644
> --- a/tools/bpf/bpftool/common.c
> +++ b/tools/bpf/bpftool/common.c
> @@ -217,6 +217,14 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
>  	int err;
>  	int fd;
>  
> +	if (argc < 3) {
> +		p_err("too few arguments, id PROG_ID and FILE path is required");

Thanks for the fix!  You can't say PROG_ID here, because this function
is also called by bpftool map pin id X.  How about s/PROG_ID/ID/ ?

> +		return -1;
> +	} else if (argc > 3) {
> +		p_err("too many arguments");
> +		return -1;
> +	}
> +
>  	if (!is_prefix(*argv, "id")) {
>  		p_err("expected 'id' got %s", *argv);
>  		return -1;
> @@ -230,9 +238,6 @@ int do_pin_any(int argc, char **argv, int (*get_fd_by_id)(__u32))
>  	}
>  	NEXT_ARG();
>  
> -	if (argc != 1)
> -		usage();
> -
>  	fd = get_fd_by_id(id);
>  	if (fd < 0) {
>  		p_err("can't get prog by id (%u): %s", id, strerror(errno));

