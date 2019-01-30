Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F79DC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1079820881
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 23:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qj7NMenm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbfA3XTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:19:41 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46283 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbfA3XTl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 18:19:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so523632pfe.13;
        Wed, 30 Jan 2019 15:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=uLrGv32OAsu5hxU0ZZv/booutnheOKWF6T9iFMfuAFI=;
        b=Qj7NMenmN+fYwXSguI65ODKuj+9K/kkLYdMEruLq59Er7GoHVUPG6m+qI3gnoXGj9k
         Hxsd22UpnpPPNEnVtEb+aFkN9BDQgMTVfyrpnBIx1coBm5pHfuSn4DZFosLGQSivP8NJ
         8qJ6QGmLGE3/IESV6uDfZDBnHy0rffGDiyRkZ+lmqcI5LgAW8K6M0sB9TNdz9PuYTo2B
         +SufcenGi44unIoPhtuNqWec2TGPeqV4yQqvXtf/cPuHbKgTExfmg7LWuDALhB/GJgoi
         GJIc3z+eMnLq4i/5T0sLcwYOKgrIpxT56nKv5Um/R60YZqGF3hYvY2FH5iasxivVjyyQ
         vNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=uLrGv32OAsu5hxU0ZZv/booutnheOKWF6T9iFMfuAFI=;
        b=ZOtx9mapzw3mszT20Ape0TgKbzVtgzlVPycC0HHDfVAfhms5syvs1YBHMU45xXPVzU
         baYsVW4514+r2CALrjRaubpRk33IFqGAba5dtE6gp61d7YBFbrhYOrvhFgwyaDr7dUBw
         8yqwcq2QNKZ5DiX+XKUAAWDqos4shqgpm0Q7LXbki//W2azjCEkj7ywT3VfzSYuuCfQE
         QbB8wLWHj4r+v9y/WDV/QN4T7YVjJ7ygdrxPjJW9nIdPU4rrgewGDKLuw+9Q9K1FOsPo
         Q2w1O5B+b7Ecm1ixeuxC60CEDoZVuHYG2HDqZYS0zrYNC7s+GhM05gDt6rfiMkcnepdt
         YSSw==
X-Gm-Message-State: AJcUuke9yOzLV8xbJPL9WH6OunmNuYzqnN1QzPkYRt5ypT9342YhGw3R
        GbVHI8qqZfhG6cH7a3B6jBz/recP
X-Google-Smtp-Source: ALg8bN50exHxFFA3uT8QHlfjcp3GSmzSeT1ajMXrQMhNkkr6rxp2wt8yctXgyoqauQMDc741Nls2EA==
X-Received: by 2002:a62:2c81:: with SMTP id s123mr32206788pfs.174.1548890379856;
        Wed, 30 Jan 2019 15:19:39 -0800 (PST)
Received: from ?IPv6:2601:282:800:fd80:25a3:bebf:496f:8788? ([2601:282:800:fd80:25a3:bebf:496f:8788])
        by smtp.googlemail.com with ESMTPSA id z7sm3493931pga.6.2019.01.30.15.19.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 15:19:38 -0800 (PST)
Subject: Re: [PATCH] selftests: net: fix "from" match test in
 fib_rule_tests.sh
To:     Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190130181903.16465-1-marcelo.cerri@canonical.com>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <07230159-a2e3-31a9-6ada-d9bd24313d13@gmail.com>
Date:   Wed, 30 Jan 2019 16:19:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190130181903.16465-1-marcelo.cerri@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/30/19 11:19 AM, Marcelo Henrique Cerri wrote:
> Fix the IPv4 address of the dummy0 interface and ensure that ip_forward
> is enabled in the network space to get a valid response when checking
> for routes between the gateway and other hosts.

you need a Fixes tag and to cc the author of said commit.

> 
> Signed-off-by: Marcelo Henrique Cerri <marcelo.cerri@canonical.com>
> ---
>  tools/testing/selftests/net/fib_rule_tests.sh | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/net/fib_rule_tests.sh b/tools/testing/selftests/net/fib_rule_tests.sh
> index d4cfb6a7a086..552a9784e759 100755
> --- a/tools/testing/selftests/net/fib_rule_tests.sh
> +++ b/tools/testing/selftests/net/fib_rule_tests.sh
> @@ -54,9 +54,11 @@ setup()
>  
>  	$IP link add dummy0 type dummy
>  	$IP link set dev dummy0 up
> -	$IP address add 198.51.100.1/24 dev dummy0
> +	$IP address add 192.51.100.1/24 dev dummy0
>  	$IP -6 address add 2001:db8:1::1/64 dev dummy0
>  
> +	ip netns exec testns sysctl -w net.ipv4.ip_forward=1

ip_forward is not relevant for this test. It just adds routes and rules
and uses ip route get to verify; no traffic is actually genrated.
