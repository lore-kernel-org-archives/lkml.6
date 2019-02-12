Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424F8C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:11:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0919121773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 15:11:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEttoiCF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729635AbfBLPL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 10:11:26 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:46326 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbfBLPL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 10:11:26 -0500
Received: by mail-yw1-f65.google.com with SMTP id n12so1103666ywn.13;
        Tue, 12 Feb 2019 07:11:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=a9rnqhx0MmyKplCHgTJzq9RDKPIlU/pbDmKII2ZnyvY=;
        b=YEttoiCFUkH/E5lWCMDuumnHb1uKzLal2uTYyQ7OZcwGLFWXYs/oGYbuF0XuAEpv9I
         8ImIgdcnwXj2HCHwr3pOIqi7QkaWll1rcVlK9SL63ilz5ZB81Mpd1/7x9ZXOaUcNgV++
         gkPIiq2vsukmsQkV0tM0Vi3lhU1pUNmfVeX7f3Oo+6Cm0cA1y7Phw628sbWxqZcSyLlh
         yfGuXS7JFRh6166ipkN/h/U5UPYT4PXq58IH51OYeGqoeNEcD6B0SuFTfgKgzHK9T4vE
         e+KryeiVnz8DW1i96+21jw6hg2DS41tkvEuFypfK7io24HdrSQQgC2NHWyFW80BfohZ9
         05rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=a9rnqhx0MmyKplCHgTJzq9RDKPIlU/pbDmKII2ZnyvY=;
        b=cog4GzMHQcqaFKXrAQ7ZzOJPQXWP4Cr/KhRO746VAhXVmjZgEIkJMqP0pfCpSyBiIm
         IFgDTCjZ+TMJHxr8SO9j5O82eRu1VndqypjW35CIOLRSNvu4a2BFSpccZ8Yzvb018Lhf
         kMdryYFuFPXd/qL3wUZ+ZuAsHRe/Wk5W47SbPGqfhcqPOTcWyOyWg6wplUy0pb5OE9vc
         XgxnYCpRWVwPmgDLXj+yRMGZTeIu49E18OOU3q4hNUrgHQ2DZZ2W2p2swgLrQEuho4VS
         NKvBFHE/p2pBobCsiuV8/G0CEu/th0FnEWPWl32OKXBiW/URtymH1cSQ3m6KUngQRJQt
         Zntg==
X-Gm-Message-State: AHQUAuY1SDeh6cl3MPpSw3yMUmAF7sx3lh4U3wuLxxHHtlS+amybnfA2
        4rzvQ5/rFq4u/hY7eLDRotk=
X-Google-Smtp-Source: AHgI3Ibl5sS8ZEm1CdBv7zMqKJB6vvWwGpZzWp15mOLScc0NesvOcdjBETl1Fqi4no3EZFQwDojriA==
X-Received: by 2002:a81:7d5:: with SMTP id 204mr397873ywh.143.1549984284018;
        Tue, 12 Feb 2019 07:11:24 -0800 (PST)
Received: from [192.168.86.235] (c-73-241-150-70.hsd1.ca.comcast.net. [73.241.150.70])
        by smtp.gmail.com with ESMTPSA id z2sm4893231ywe.32.2019.02.12.07.11.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 07:11:22 -0800 (PST)
Subject: Re: [bpf-next 2/2] bpf: add BPF_SOCK_OPS_STATS_CB for tcp_stats()
To:     Yafang Shao <laoar.shao@gmail.com>, daniel@iogearbox.net,
        ast@kernel.org
Cc:     yhs@fb.com, brakmo@fb.com, edumazet@google.com,
        davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, shaoyafang@didiglobal.com
References: <1549971097-12627-1-git-send-email-laoar.shao@gmail.com>
 <1549971097-12627-3-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e5fabb00-4fad-183a-5c2d-e22ed58006c7@gmail.com>
Date:   Tue, 12 Feb 2019 07:11:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1549971097-12627-3-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2019 03:31 AM, Yafang Shao wrote:
> Introuce this new op BPF_SOCK_OPS_STATS_CB for tcp_stats() such that it
> can be traced via BPF on a per socket basis.
> There's one argument in BPF_SOCK_OPS_STATS_CB, which is Linux MIB index
> LINUX_MIB_* to indicate the TCP event.
> All these Linux MIBs are defined in include/uapi/linux/snmp.h.
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/uapi/linux/bpf.h | 5 +++++
>  net/ipv4/tcp_input.c     | 1 +
>  2 files changed, 6 insertions(+)
> 
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 1777fa0..0314ddd 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2894,6 +2894,11 @@ enum {
>  	BPF_SOCK_OPS_TCP_LISTEN_CB,	/* Called on listen(2), right after
>  					 * socket transition to LISTEN state.
>  					 */
> +	BPF_SOCK_OPS_STATS_CB,		/*
> +					 * Called on tcp_stats().
> +					 * Arg1: Linux MIB index
> +					 * 	 LINUX_MIB_*
> +					 */
>  };
>  
>  /* List of TCP states. There is a build check in net/ipv4/tcp.c to detect
> diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> index 88deb1f..4acf458 100644
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -3557,6 +3557,7 @@ static u32 tcp_newly_delivered(struct sock *sk, u32 prior_delivered, int flag)
>  static void tcp_stats(struct sock *sk, int mib_idx)
>  {
>  	NET_INC_STATS(sock_net(sk), mib_idx);
> +	tcp_call_bpf(sk, BPF_SOCK_OPS_STATS_CB, 1, &mib_idx);
>  }
>  
>  /* This routine deals with incoming acks, but not outgoing ones. */
> 

If the plan is to add to all NET_INC_STATS() calls in TCP an additional tcp_call_bpf()
I will say no.

So far, tcp_call_bpf() has not been used in fast path.

