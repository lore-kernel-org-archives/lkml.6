Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC24C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66ED4217CC
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 18:07:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NOQWjI6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66ED4217CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbeHDUJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 16:09:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45522 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728054AbeHDUJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 16:09:06 -0400
Received: by mail-wr1-f65.google.com with SMTP id f12-v6so8370086wrv.12;
        Sat, 04 Aug 2018 11:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=s5vU1vcLq+X4EJCKGqllvaYdGfk0wzCbvfiomwaPH4Y=;
        b=NOQWjI6zP66xGIm1oR67dxv1rjGEjIaffq259+IN8LALezeowlcWw+0dao06oIi6s0
         EreSelGSJG/9mZyYxH/VVb6SX7HBxJgCC0ommNtdiNZNfANscEn19PZDKZqmXHRk1sog
         ri2WkL4o84vogxb5uqG1wEiA4WWb1EBRmFuardTqxVuY39JEsA6hCfUjXLGqT0IwQSo8
         rVFtO7SXa7Nf5KvM/6gPVBml0jNyBmG+VPaoDX8gmphY9s7kqi2HoqH10EEm9xUDfdXh
         hwoVDidiwvUydgNcjq2iaHWJgWBfDWaZtslfYOJBWjlC8tcp4XeCiQLVC2q2+3orfIG2
         YNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s5vU1vcLq+X4EJCKGqllvaYdGfk0wzCbvfiomwaPH4Y=;
        b=VUSXgE0ehEGFJsvUO0t1ajNSfrKwKF6Ucoxzx67yfUcA0ekTZkVZDT6hVE0SSkXDfv
         BB1DKbjjmJmiZF44PWTUgbGts8n0R1Xz9OSzn9AiCpKxXwALqsKh9xiWiKLXCQwIqnCC
         yJYgZMQHWpIBblPdtnDEO32v9YpWtyJjUjhWANH9h9VH49R4blf6rsU1z4o+r0E0Wev2
         Z15jtJiEiWd3Ec8WpTSECGLBCf+UoYCyYURPjJmbO+R/9Fu4ZSNXoaDMfrAkn54neFBR
         rpybBZykewX19ifNzROqIuooRmby6sE3aKoeGwvsSsbWIFRivZKEoXDwPI4DcV0pWrCk
         RhAw==
X-Gm-Message-State: AOUpUlHOUd4JuOWRtbOxLErz6K6nTmx4CGzsPeXJuNiDkeTXj1uTGe6u
        /gdfyI0A9VhJk0tYJVfyZ2o=
X-Google-Smtp-Source: AAOMgpc6tq+J/vHJgeQpPTkvIfuB/CshwJ+ujz5BI4iNv/LR+wXovxgu6I/sdZvXfVFe8mT+4L0ISg==
X-Received: by 2002:a5d:4a07:: with SMTP id m7-v6mr5928294wrq.8.1533406056373;
        Sat, 04 Aug 2018 11:07:36 -0700 (PDT)
Received: from flashbox ([2a01:4f8:10b:24a5::2])
        by smtp.gmail.com with ESMTPSA id t19-v6sm1905773wmi.42.2018.08.04.11.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 04 Aug 2018 11:07:35 -0700 (PDT)
Date:   Sat, 4 Aug 2018 11:07:34 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        netdev@vger.kernel.org, Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH 4.4 106/124] netlink: Do not subscribe to non-existent
 groups
Message-ID: <20180804180734.GA25546@flashbox>
References: <20180804082702.434482435@linuxfoundation.org>
 <20180804082706.427556290@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180804082706.427556290@linuxfoundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 11:01:35AM +0200, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Dmitry Safonov <dima@arista.com>
> 
> [ Upstream commit 7acf9d4237c46894e0fa0492dd96314a41742e84 ]
> 
> Make ABI more strict about subscribing to group > ngroups.
> Code doesn't check for that and it looks bogus.
> (one can subscribe to non-existing group)
> Still, it's possible to bind() to all possible groups with (-1)
> 
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: Steffen Klassert <steffen.klassert@secunet.com>
> Cc: netdev@vger.kernel.org
> Signed-off-by: Dmitry Safonov <dima@arista.com>
> Signed-off-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  net/netlink/af_netlink.c |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -983,6 +983,7 @@ static int netlink_bind(struct socket *s
>  		if (err)
>  			return err;
>  	}
> +	groups &= (1UL << nlk->ngroups) - 1;
>  
>  	bound = nlk->bound;
>  	if (bound) {
> 
> 

Hi Greg,

I am so sorry I didn't catch this in my initial report but this commit
along with ba7aaf93ef2f ("netlink: Don't shift with UB on nlk->ngroups")
breaks mobile data on both the Pixel 2 XL and OnePlus 6. There is signal
but it just never connects to 3G/LTE. Reverting those two commits fixes
the issue.

Nothing stands out to me in dmesg unfortunately and iven neither device
is running a vanilla kernel, I cannot say if this is a problem in mainline
or not but I just wanted to make you aware of it.

Thanks!
Nathan
