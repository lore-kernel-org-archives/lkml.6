Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7684AC5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3529B208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3529B208C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935012AbeFMAIy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:08:54 -0400
Received: from www62.your-server.de ([213.133.104.62]:51342 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932596AbeFMAIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:08:52 -0400
Received: from [178.197.248.16] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fStLG-0004QG-Gm; Wed, 13 Jun 2018 02:08:50 +0200
Subject: Re: [PATCH] selftests: bpf: config: add config fragments
To:     Anders Roxell <anders.roxell@linaro.org>, ast@kernel.org,
        shuah@kernel.org
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, William Tu <u9012063@gmail.com>
References: <20180612110510.11731-1-anders.roxell@linaro.org>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d6851756-ae3b-09ec-f487-1eeece6bd4c6@iogearbox.net>
Date:   Wed, 13 Jun 2018 02:08:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180612110510.11731-1-anders.roxell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24657/Tue Jun 12 22:48:09 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 01:05 PM, Anders Roxell wrote:
> Tests test_tunnel.sh fails due to config fragments ins't enabled.
> 
> Fixes: 933a741e3b82 ("selftests/bpf: bpf tunnel test.")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
> 
> All tests passes except ip6gretap that still fails. I'm unsure why.
> Ideas?

William (Cc) might be able to help you out.

Applied the one below in the mean-time to bpf, thanks!

> Cheers,
> Anders
> 
>  tools/testing/selftests/bpf/config | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/tools/testing/selftests/bpf/config b/tools/testing/selftests/bpf/config
> index 1eefe211a4a8..7eb613ffef55 100644
> --- a/tools/testing/selftests/bpf/config
> +++ b/tools/testing/selftests/bpf/config
> @@ -7,3 +7,13 @@ CONFIG_CGROUP_BPF=y
>  CONFIG_NETDEVSIM=m
>  CONFIG_NET_CLS_ACT=y
>  CONFIG_NET_SCH_INGRESS=y
> +CONFIG_NET_IPIP=y
> +CONFIG_IPV6=y
> +CONFIG_NET_IPGRE_DEMUX=y
> +CONFIG_NET_IPGRE=y
> +CONFIG_IPV6_GRE=y
> +CONFIG_CRYPTO_USER_API_HASH=m
> +CONFIG_CRYPTO_HMAC=m
> +CONFIG_CRYPTO_SHA256=m
> +CONFIG_VXLAN=y
> +CONFIG_GENEVE=y
> 

