Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87934ECE560
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:42:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F01220883
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 21:42:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5u6ZCrZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F01220883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeIXDld (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 23:41:33 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38199 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727014AbeIXDld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 23:41:33 -0400
Received: by mail-pf1-f195.google.com with SMTP id x17-v6so8191345pfh.5;
        Sun, 23 Sep 2018 14:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Q+9t6sgfnTSpN9xPtPLFz7mfRvrPV1qRnJb8PdeJm+o=;
        b=Z5u6ZCrZXF8SmtfM8M13AMVNopbAMXHqQGEZUwc/ND68341KOTv4eqP0FRaoea8X8Z
         NbE1Y3utlQul8bW38D/Dv2qs0hsGAyO3c72fOzEun2nz3rybTcPL6v7rvgzvOVTsk9tF
         6UgB6cq4JquQCjvEYlE0wh7vaAjZpxWopY+mJnITVTc5KuMi3pM3wg2OHTWJZZlNx4Jb
         0J7VmtxnBWEZpNl5t2VRUlpvcTsnSn4qAFP+cqNH6x7G4l7+Y2eeDoeKwAq5xXKTBwfA
         lGUX68tt/tHo1vP774iJxGfDsh1FnJn5enA0vQT3RHgKS+7sn7/67bCBM+wQmhR7w3h1
         1BhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Q+9t6sgfnTSpN9xPtPLFz7mfRvrPV1qRnJb8PdeJm+o=;
        b=PDXVyyKuk+28xHdYVohodZzhw+LutwvYjT/ae6zgeqMDhv+rmqzfLdWaOLvcPwndHb
         Uz/FJV5Kq6QCaVlbaYKHjg4mxWnkV/9uwC1jAN7RPdNVvTMnLa4526Bz5wtU+H8sy7p9
         FJvBByXvADylgbbE2CgnuvNgKupEpVmxuqlii4Vz67h4mOBgDlvSA3wFrmtrhro0nHmM
         FHsDa0dz8nnux//rf1VCxzzEOLY76XOFnMT0pxTYdD4P0mGdQ9akmw8Qy8WlJkv59/sO
         ImgqPxv/qUtNYJiZ2jk3x0uyqyYBYk/eh7cWkWWxckesLU7VE31m29mB5iFDI9wmTwDg
         4OEQ==
X-Gm-Message-State: ABuFfogW9BTBgoBowcjk8cIlOyOigAA8Bibg8ebMFoK/qA6HJhn333wk
        /mnrGr2Fm9iTE+ru7mtJGihCdPp9
X-Google-Smtp-Source: ACcGV62AN+JrsioRN9oJ0Co2zP1PCR/BezAKtcfVnjZ7FA5HguAy2mwnwDr2wGkLtAFvsY5eXzNhNQ==
X-Received: by 2002:a63:e0e:: with SMTP id d14-v6mr7087769pgl.38.1537738952287;
        Sun, 23 Sep 2018 14:42:32 -0700 (PDT)
Received: from [192.168.86.235] (c-67-180-167-114.hsd1.ca.comcast.net. [67.180.167.114])
        by smtp.gmail.com with ESMTPSA id 26-v6sm3111260pfs.168.2018.09.23.14.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 23 Sep 2018 14:42:31 -0700 (PDT)
Subject: Re: [PATCH net-next] tcp: expose sk_state in tcp_retransmit_skb
 tracepoint
To:     Yafang Shao <laoar.shao@gmail.com>, edumazet@google.com,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1537732141-22468-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <375c389d-f391-5b72-bc52-9a82d61c6bd7@gmail.com>
Date:   Sun, 23 Sep 2018 14:42:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1537732141-22468-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/23/2018 12:49 PM, Yafang Shao wrote:
> With sk_state, we can know whether this connection is in SYN_SENT state
> or ESTBLISHED state.
> The reason to distinguish between these two scenario is that the
> retransmission in ESTABLISHED state always mean network congestion while
> in SYN_SENT state it always mean server issue, i.e. the syn packet is
> dropped due to syn backlog queue full.

You mean, a packet drop on the remote peer ?

It could also be a packet drop in the network.

Your patch is good, but changelog is quite misleading.
