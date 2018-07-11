Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D5BC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:01:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EBD020C0C
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 17:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaVyHl3J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EBD020C0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389992AbeGKRGd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 13:06:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:36854 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbeGKRGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 13:06:32 -0400
Received: by mail-pl0-f66.google.com with SMTP id a7-v6so9424500plp.3;
        Wed, 11 Jul 2018 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=k+zAhmil+9lgRJv90gr9XQ28qx9ejR8w8cpaK7UxjHg=;
        b=BaVyHl3JKlmmCOlFjVepWvafZCPiNpgaGkTASSGf6fy+sm8bk25iOKKX2gYHKVwoQp
         1m/E2bQS0AXpQjAw852M3hqFw4+5j9xnZAKz5PHn7YObGgxHkNNa/bnF5tl1bOY5yegW
         43xrLWyb4wsVO0JOatbrZYAP2j+vinbfzhqK9y8DNfdrlSHDMbrR8dL2dr1fC7/TaObI
         5cVBhYxTjzFAUP1nlLDmP51dTvYmD2GqRGeE52w1KEEOSxFH40wYbh96srYaF89CAlg7
         cHeHJqlse3r5lG9rdF9RgHW/tHzAhwvc0RkoeTekvcG99u58ZbT8IhnvA4alwbh9aFOv
         A7dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=k+zAhmil+9lgRJv90gr9XQ28qx9ejR8w8cpaK7UxjHg=;
        b=bA4bVQvgqs/ysJOS5vp67jol14oSVUD1YtR9qoiTcXTSN6aiHVh4vu6LYhtv8mee3A
         dbBB34FkJZRmmjSbgdDnYbVmnCbVDINxxvVHH9BIT0uQvDBdPrVRypVydqzDh7NX6+/t
         eZDYucjrCgOSCxUI1GhFAUT25umMWfxg7dbRgqwp9LU0SS75+otCVqkcMBXYwtwdBLvW
         Adm6OjPEEL7J2kPDJLxqW809ISt7f8AFAt/HaLhJ2YxIf9J2MwnJ2qNFtUVctv0IitFj
         YTLDlmAsHzyPkelHTrIQV2nNVIdpp8HbBdh7XWaFFuKLH1ry2xYjVOU+ZYxt6S6abBWQ
         WJ6A==
X-Gm-Message-State: APt69E0xbmwz4aydYbAvVR59voJNjbFRvKR6Bumq9WMnekIejbGMVIpF
        AF3Z7YIawmYNTOaluR43YoQ=
X-Google-Smtp-Source: AAOMgpdSe+F5hNZdlrgmi2bx6LoIvVxQuamnAGbPpRUZoJGqoEdhJU+/G0KcAm/eG5M5aFkYfPVEEA==
X-Received: by 2002:a17:902:7e43:: with SMTP id a3-v6mr29204801pln.151.1531328478647;
        Wed, 11 Jul 2018 10:01:18 -0700 (PDT)
Received: from ?IPv6:2620:15c:2c1:200:55c7:81e6:c7d8:94b? ([2620:15c:2c1:200:55c7:81e6:c7d8:94b])
        by smtp.gmail.com with ESMTPSA id m10-v6sm28638268pgq.89.2018.07.11.10.01.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 10:01:17 -0700 (PDT)
Subject: Re: [PATCH net-next 1/2] tcp: remove redundant rcv_nxt update
To:     Yafang Shao <laoar.shao@gmail.com>, davem@davemloft.net,
        edumazet@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        shaoyafang@didichuxing.com
References: <1531315019-3553-1-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <eric.dumazet@gmail.com>
Message-ID: <e51e4a18-5e4d-f276-3d39-304424853351@gmail.com>
Date:   Wed, 11 Jul 2018 10:01:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1531315019-3553-1-git-send-email-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/11/2018 06:16 AM, Yafang Shao wrote:
> tcp_rcv_nxt_update() is already executed in tcp_data_queue().
> This line is redundant.
> 
> See bellow,
> 	tcp_queue_rcv
> 		tcp_rcv_nxt_update(tcp_sk(sk), TCP_SKB_CB(skb)->end_seq);
> 	tcp_rcv_nxt_update(tp, TCP_SKB_CB(skb)->end_seq); <<<< redundant
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---

This patch is fine (but not the following)

Signed-off-by: Eric Dumazet <edumazet@google.com>

Thanks.



