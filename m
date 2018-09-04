Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA88C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:40:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7C7B20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:40:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s+ns+3hc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7C7B20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbeIDHDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:03:50 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36532 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIDHDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:03:50 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so911092pfo.3;
        Mon, 03 Sep 2018 19:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=FLySk63nUYnPfBhWcOtMnf2UlcdiW+c1lsQ4o3I15F0=;
        b=s+ns+3hcORvTinpTEoK5P45nFFTl2Gipu8/4xu0O92wLi1PsEYEvviUIMsCNNF4Vvi
         KXc5Z/Jxig7bTy56JY0HliUuz86ON75ldbAluzQwZeKYsO6ijUB00y8fnrauGecT94PL
         ME5sjEYTY+xe6oDhOcnOkorTcobFUf7qGZldPOBA/OIAk1MRFnZTrAcTzuL3e84CREOK
         0MFrCX9SIXFDPuQGthLzt7yPNZreYrVJksDX+scNlfV1ICT5MFrcfZX9djzpr/tlTfej
         0/pO1cwzj9E0Ai8PhU+9ZXbX8n62u9TdGYo35YjaeDj0vJMuDA55eXPzssxW9uLau+vO
         ezjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=FLySk63nUYnPfBhWcOtMnf2UlcdiW+c1lsQ4o3I15F0=;
        b=BycH0Btb3nYY6c7Ocdz7cIODOKqKTjI3/hJ1w82QFrCwtdBzfLIeV7yexH/+m8AkDx
         tI6gk1KfZIrKQr62Khg6/wR9qtiMpYkNchl9qqvb3+g91BdF6tOeWD0PmCT+nu97uctI
         p4WrMKMyv64ChwCsgcUxLIShUieyma4evbFLG5JxFOHkr9ivqn7XDlrJ38T0XYhs3iba
         fDMTfKM/kuTY7PB+6DyvJyNNzb2xWlKc+5W5f9fNBJ8uP+313SUmdiWRIZsR20lSMvyf
         H9uHnMZEt6Zm2tNsrOgZ7muo6RiTTkK1bdDlqVTHJMf7oE9RJ51Gz4bEzjYG7NQemL7M
         MWFw==
X-Gm-Message-State: APzg51BSTyt3ewUgb/6ieojJY6o/LdZLMYkPXF2Xl1iUxEyfO20XELnF
        tAL2pNwsQDR5cSD2NFbs4zdxMLy2
X-Google-Smtp-Source: ANB0VdbzDsVMUpfQAyeKiA+Gx76r11yRUYUOf5Ug0JiBWtQVNcYIRZhecLQTcw3226ZmQ5OUnCauKw==
X-Received: by 2002:a62:de04:: with SMTP id h4-v6mr28704891pfg.258.1536028855948;
        Mon, 03 Sep 2018 19:40:55 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:1145:f235:fa5f:50ca])
        by smtp.googlemail.com with ESMTPSA id t12-v6sm32806802pgg.72.2018.09.03.19.40.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 19:40:54 -0700 (PDT)
Subject: Re: [PATCH] net: ipv6: route: Fix a sleep-in-atomic-context bug in
 ip6_convert_metrics()
To:     Jia-Ju Bai <baijiaju1990@gmail.com>, davem@davemloft.net,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180901111958.26529-1-baijiaju1990@gmail.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <94b1372d-43da-1a9a-9cde-40c855050552@gmail.com>
Date:   Mon, 3 Sep 2018 20:40:52 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180901111958.26529-1-baijiaju1990@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/18 5:19 AM, Jia-Ju Bai wrote:
> The kernel module may sleep with holding a spinlock.
> 
> The function call paths (from bottom to top) in Linux-4.16 are:
> 
> [FUNC] kzalloc(GFP_KERNEL)
> net/ipv6/route.c, 2430: 
> 	kzalloc in ip6_convert_metrics
> net/ipv6/route.c, 2890: 
> 	ip6_convert_metrics in ip6_route_add
> net/ipv6/addrconf.c, 2322: 
> 	ip6_route_add in addrconf_prefix_route
> net/ipv6/addrconf.c, 3331: 
> 	addrconf_prefix_route in fixup_permanent_addr
> net/ipv6/addrconf.c, 3354: 
> 	fixup_permanent_addr in addrconf_permanent_addr
> net/ipv6/addrconf.c, 3358: 
> 	_raw_write_lock_bh in addrconf_permanent_addr
> 
> To fix this bug, GFP_KERNEL is replaced with GFP_ATOMIC.
> 
> This bug is found by my static analysis tool DSAC.

No kernel change is needed. Your static analysis tool and you in sending
out patches need to take into context.

ip6_convert_metrics only calls kzalloc when fc_mx is set. fc_mx is only
set via the RTA_METRICS attribute and only from the userspace call path.
Hence, kzalloc with GFP_KERNEL is the appropriate argument.
