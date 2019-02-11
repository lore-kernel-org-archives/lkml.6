Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16D2C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75F992184E
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 13:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="SzdXdxJO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfBKN0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 08:26:30 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:56004 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbfBKN03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 08:26:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id r17so17570999wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 05:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hxhUFIRrG/up9AJoPUFf4pUzOvWOPEMUdMQ2+xvVcRE=;
        b=SzdXdxJOKfuNzbF2d4FH3qmaqKLEWM7h6y/fDdPEHPlL+2w4XkdgB5xcHWVb1c+wHV
         NR5a13kR52w7IMiwcBx2bqAfSpTPLxAPWw6lUuTl39kI2dQ2Pb3/yBmxQOP5TO0OBwkJ
         xzSlF8IAXtIIhzee1vvht/bJhKAk2WM7r6PnUO5hmLaz0Gx3jQeqCZnhb1tXUdDPmysD
         nz+LJc7xYCS+qYvGPQFnMXp3SBsXk2w3xNoK9llnDfjTi1OoJvdM/v8bSMRoPYSvIRUG
         8hNY82UkvQWfnTk7YYk5GSKOrgDBaBuSDSJWg4ZzM0VE/Nd0/r2dBX+buhbupUKaEGRd
         HSlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=hxhUFIRrG/up9AJoPUFf4pUzOvWOPEMUdMQ2+xvVcRE=;
        b=BgAZOGtQfBWFzt+whS5l32C2rJLeMH+PtY5vy6B0tUX3ULGdRCTGXGdj5QCz5n0YOl
         Z0gYPU6kgiP5feryRX5YuFhXCeg4+VTndptqbRCG0Bt7oXpTREpcML4uMfJT/sj9Tw0y
         1ABaHY/rQMqmZkax4o7tlMrolBBEXhEqKr+P3Y/b+4ygaPkedpVE3chzisjkWHqzNjMy
         T/uHEunQ/bI5zdKNtW7AicokAnck5oJimZ7kxcQEJwpEayvClX+HmiGeP+OiuJYEjqWb
         6x2rx7cg/V/xtfCHKNjnpWOsV6bxhkdEjJ+8RcJbmJPbbXeArWSt+EoouvYijcbuJKg/
         w0mA==
X-Gm-Message-State: AHQUAuY3g46kQUYM+U9yLPE+6w319oU6qhIKQl8OCu6cmyx3KfJoH49k
        iCQMuWO0TEZ2G6yoWvtlqKAB1g==
X-Google-Smtp-Source: AHgI3Ib8U6DNSd+6/i94MMHv5ncrWTL2aycmbBNuGZF9Krcawv0/5jyYtbZ2Tt+OAkwfJE7gW5+qjA==
X-Received: by 2002:a1c:6c01:: with SMTP id h1mr9176506wmc.113.1549891586875;
        Mon, 11 Feb 2019 05:26:26 -0800 (PST)
Received: from [172.20.1.107] ([217.38.71.146])
        by smtp.gmail.com with ESMTPSA id u14sm6340517wmf.38.2019.02.11.05.26.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 05:26:26 -0800 (PST)
Subject: Re: [PATCH] bpf: bpftool, fix documentation for attach types
To:     Alban Crequy <alban.crequy@gmail.com>, ast@kernel.org,
        daniel@iogearbox.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.fastabend@gmail.com, alban@kinvolk.io
References: <20190211125426.21072-1-alban@kinvolk.io>
From:   Quentin Monnet <quentin.monnet@netronome.com>
Openpgp: preference=signencrypt
Autocrypt: addr=quentin.monnet@netronome.com; prefer-encrypt=mutual; keydata=
 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
 RHhSHGnKaQ6MfrTge5Q0h5A=
Message-ID: <208650eb-37bf-228b-43f8-de5027747db9@netronome.com>
Date:   Mon, 11 Feb 2019 13:26:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211125426.21072-1-alban@kinvolk.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2019-02-11 13:54 UTC+0100 ~ Alban Crequy <alban.crequy@gmail.com>
> From: Alban Crequy <alban@kinvolk.io>
> 
> bpftool has support for attach types "stream_verdict" and
> "stream_parser" but the documentation was referring to them with
> "skb_verdict" and "skb_parse". The inconsistency comes from commit
> b7d3826c2ed6 ("bpf: bpftool, add support for attaching programs to
> maps").
> 
> This patch changes the documentation to match the implementation.
> 
> Signed-off-by: Alban Crequy <alban@kinvolk.io>
> ---
>  tools/bpf/bpftool/prog.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
> index 0640e9bc0ada..dfaa019a60f0 100644
> --- a/tools/bpf/bpftool/prog.c
> +++ b/tools/bpf/bpftool/prog.c
> @@ -1198,7 +1198,7 @@ static int do_help(int argc, char **argv)
>  		"                 cgroup/bind4 | cgroup/bind6 | cgroup/post_bind4 |\n"
>  		"                 cgroup/post_bind6 | cgroup/connect4 | cgroup/connect6 |\n"
>  		"                 cgroup/sendmsg4 | cgroup/sendmsg6 }\n"
> -		"       ATTACH_TYPE := { msg_verdict | skb_verdict | skb_parse |\n"
> +		"       ATTACH_TYPE := { msg_verdict | stream_verdict | stream_parser |\n"
>  		"                        flow_dissector }\n"
>  		"       " HELP_SPEC_OPTIONS "\n"
>  		"",
> 

Thanks Alban!

Could you please fix the man page and the bash completion file at the
same time?

Quentin
