Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C75C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9E4A20878
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 07:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9E4A20878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932710AbeGJHU3 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 03:20:29 -0400
Received: from www62.your-server.de ([213.133.104.62]:37204 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750937AbeGJHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 03:20:28 -0400
Received: from [78.46.172.3] (helo=sslproxy06.your-server.de)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcmwh-0006SX-RQ; Tue, 10 Jul 2018 09:20:23 +0200
Received: from [2a02:120b:c3f4:b8b0:b5ea:3969:d380:aafd] (helo=linux.home)
        by sslproxy06.your-server.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <daniel@iogearbox.net>)
        id 1fcmwh-000Jgo-Ma; Tue, 10 Jul 2018 09:20:23 +0200
Subject: Re: [PATCH v2] samples/bpf: Fix tc and ip paths in xdp2skb_meta.sh
To:     Taeung Song <treeze.taeung@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>
Cc:     Jesper Dangaard Brouer <brouer@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180709175121.3355-1-treeze.taeung@gmail.com>
From:   Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <d8b2fa86-957f-679e-36c8-6af7c45ab5aa@iogearbox.net>
Date:   Tue, 10 Jul 2018 09:20:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20180709175121.3355-1-treeze.taeung@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.100.0/24739/Tue Jul 10 06:45:06 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/09/2018 07:51 PM, Taeung Song wrote:
> The below path error can occur:
> 
>   # ./xdp2skb_meta.sh --dev eth0 --list
>   ./xdp2skb_meta.sh: line 61: /usr/sbin/tc: No such file or directory
> 
> So just use command names instead of absolute paths of tc and ip.
> In addition, it allow callers to redefine $TC and $IP paths
> 
> Fixes: 36e04a2d78d9 ("samples/bpf: xdp2skb_meta shows transferring info from XDP to SKB")
> Reviewed-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Taeung Song <treeze.taeung@gmail.com>

Applied to bpf, thanks Taeung!
