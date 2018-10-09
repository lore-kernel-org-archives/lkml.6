Return-Path: <SRS0=T/cj=MV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7E2ECDE3A
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82222075C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Oct 2018 16:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHRCjovn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A82222075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJIXjQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Oct 2018 19:39:16 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38388 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbeJIXjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Oct 2018 19:39:16 -0400
Received: by mail-pg1-f193.google.com with SMTP id f8-v6so1056179pgq.5;
        Tue, 09 Oct 2018 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=puxlPuMk288kKHPHTeZA6u4dEIDz5FZjlt+fgwCwMuA=;
        b=XHRCjovnBoIEwZHJdoMR7Ox6nUzxFI33lbIFBtdW2GDsdulNbU5FfOg++vMpA3I/Jl
         Rs3gFPTO37tQP3AwnxJhIHyx4Y7wkKLWsw57sg0JgHNX/Fq5e3kiGrLQZrImr3mcI0Mt
         UX1o4ZJgcWJftrcPv/+kFiF6wrp7cDdc+49k2z06kWb5NCTZo6F/oJVe9V/WWf/C5gI8
         PEIPHDY4P1YV/oluHjGt15MiHmqeZbBUB9uvfMcsaCxMYPi3crOr6JGLqUntEuj6pCqc
         G57ToxOBljuoCaZZi1noHQtuFzLNrba5cfl8xsgp2VRtwweaRtfhi9npqe32h0cLbvqh
         cZlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=puxlPuMk288kKHPHTeZA6u4dEIDz5FZjlt+fgwCwMuA=;
        b=iTh3cCAwZSQ6OJlpyWk4c9fWa35vr0uXqfnFWvUj+td5yBevIgHu2ugJ/CMU+JNs/k
         R3jnn+kl4R2XYSH/Gh4lwjTDZgoAcWWFFgwVV1Ffrv9CpAn1DIlKFPFh4KGI4EOxvDbO
         vmVVqrmfZEV/3MKQHHrmrX1aT+2lViLJ7pVs0+8xWEsrF9eCF9kGdpyc95uB8iTuP+i3
         a1HPA2dTGA74RKSpgSo5vFB8KU6T/RWhsRs4Xr4dj82d/1IPB59lw7A0aaXXhYG6Zeu+
         pFUdYvhLK3XUU0G3BwUTj2fy4nEzmA3ksV7s0kEuTAVHdmuYYDlBIA/AhhhtLSrLSEPh
         gIPA==
X-Gm-Message-State: ABuFfohFPHGryGTfM3uz7sz3yp42bKbkrP3b/8VGsyGzoU4vjjKq/kGk
        sLoKWNWYNLarwVFF0yGx7KY+BiPq
X-Google-Smtp-Source: ACcGV611OL5C7OwTwO47Y+dEp78CLXDGAAehVlPh/4/NgZ9Y4E065y3OKz5poA2fRdV/W3hHYqrXIg==
X-Received: by 2002:a62:dd01:: with SMTP id w1-v6mr30566704pff.129.1539102093203;
        Tue, 09 Oct 2018 09:21:33 -0700 (PDT)
Received: from ?IPv6:2601:284:8200:5cfb:c54f:5aee:a291:8def? ([2601:284:8200:5cfb:c54f:5aee:a291:8def])
        by smtp.googlemail.com with ESMTPSA id l129-v6sm32192824pfc.155.2018.10.09.09.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 09:21:32 -0700 (PDT)
Subject: Re: [PATCH net-next] rtnetlink: mpls: ip_valid_fib_dump_req()
 requires CONFIG_INET
To:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Kirill Tkhai <ktkhai@virtuozzo.com>,
        Christian Brauner <christian@brauner.io>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181009161031.1003047-1-arnd@arndb.de>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <e86775fb-ecf2-676e-0d36-9236c8e70f24@gmail.com>
Date:   Tue, 9 Oct 2018 10:21:30 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181009161031.1003047-1-arnd@arndb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/18 10:10 AM, Arnd Bergmann wrote:
> The newly added call to ip_valid_fib_dump_req() causes a link error
> in configurations that enable MPLS but not IPv4:
> 
> net/mpls/af_mpls.o: In function `mpls_dump_routes':
> af_mpls.c:(.text+0xed0): undefined reference to `ip_valid_fib_dump_req'
> 
> With the added IS_ENABLED() check we get the previous behavior
> back in that configuration, and skip the check.
> 
> Fixes: e8ba330ac0c5 ("rtnetlink: Update fib dumps for strict data checking")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/mpls/af_mpls.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
> index 7f891ffffc05..99ff6114d513 100644
> --- a/net/mpls/af_mpls.c
> +++ b/net/mpls/af_mpls.c
> @@ -2041,7 +2041,7 @@ static int mpls_dump_routes(struct sk_buff *skb, struct netlink_callback *cb)
>  
>  	ASSERT_RTNL();
>  
> -	if (cb->strict_check) {
> +	if (IS_ENABLED(CONFIG_INET) && cb->strict_check) {
>  		int err = ip_valid_fib_dump_req(nlh, cb->extack);
>  
>  		if (err < 0)
> 

If INET is not defined then mpls will need its own valid_dump_req
function to ensure strict_check semantics are managed. I'll send a patch.
