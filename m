Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7766DC46460
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19F72223B8
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 02:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKtIzjI0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F72223B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727160AbeHJEaY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 00:30:24 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41189 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeHJEaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 00:30:24 -0400
Received: by mail-pf1-f194.google.com with SMTP id y10-v6so3737174pfn.8;
        Thu, 09 Aug 2018 19:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Mfswak1zEji05YffRKB1yd5fbflV++cN7UbyuxT2104=;
        b=rKtIzjI0EdHoDD6RxxrgmDTnBRlXnDh6Dlg0B18y0TgLSPV/cBQg6h84IP1bdr6bpX
         VxFX4kbMtl/oEswar60b7GYg5tHyt/uHyvpGZ6fzMFOt4R9qal/3ru443TMSFxAWNeuF
         izdnLQpAsuL5mRvd93mCEqkBMPBlKdzbiP+tLsoNkNbS+noI2WEGzova/fCdIKitAb/Y
         545pJYDzClKP16Qj8sltJCLe/Yuyl3573kfpagXgTyGJlDgaXFrPv34bO/WIAQLbH+yj
         pfy/Llmz36RuPjPkxsMf/H0yiLgAybMAd3X1qCoMnH+vOBRzyoHpymAlnU0/F21s+6Cl
         jbxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Mfswak1zEji05YffRKB1yd5fbflV++cN7UbyuxT2104=;
        b=d7H/D7cArbQn8Whait1Sn53cQ5YvoiOHlmNOyymukp4qAJrMNCSCUEMd+Hwk7+T9Pk
         J7k5ohRUo8xmy0V1yLt6jA6+hcedfMWLtPF9xIXFFx6smztOWVwohS2KrOHjiCw4i2NT
         nNpxk4ZnEMwAst5Pd0bwMYLva4b8zDEWVZ3H8HaJbWHnCG2P0WdZ+3uM0nscqNxzu1nR
         EYMND3HoFmHOX8VHF3AGIsFylgRlox2kteEWDVc5hNIn7c9hDl5o6Xa2p2VaX17r/tzu
         uUvXLd4l7RSlY7e1k5fDMQyg/S7HeDeTJi4FXnKGz1EyVy6oX/rrdWHlWUEV1auM1I5t
         2Hmg==
X-Gm-Message-State: AOUpUlErILL81rhYJRMaR2PmjLN/IK/nY3MGuOCZIdEADSRW7Huk4Y6J
        FsSzXZD4xJDvRfL+w00tGryAfuSP
X-Google-Smtp-Source: AA+uWPwvB1jLONF+tQFzXQ3M1NE9jxrOPvpgS7dBnqdY0ChhFGw2AmBq/5Srluji3QirovTi//p0rw==
X-Received: by 2002:a62:6948:: with SMTP id e69-v6mr4826961pfc.166.1533866565603;
        Thu, 09 Aug 2018 19:02:45 -0700 (PDT)
Received: from ?IPv6:2402:f000:1:4414:ec41:2410:dee4:3bda? ([2402:f000:1:4414:ec41:2410:dee4:3bda])
        by smtp.gmail.com with ESMTPSA id m15-v6sm15829483pfk.149.2018.08.09.19.02.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 19:02:44 -0700 (PDT)
From:   bai <baijiaju1990@gmail.com>
Subject: [BUG] net: xfrm: Two possible sleep-in-atomic-context bugs
To:     steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <b74ebf58-16c0-4a51-a004-7ce9e6abde7a@gmail.com>
Date:   Fri, 10 Aug 2018 10:02:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code may sleep in interrupt handler.
xfrm_trans_reinject() is an interrupt handler set in tasklet_init().
The function call paths (from bottom to top) in Linux-4.16 are:

[FUNC] schedule_timeout
net/core/sock.c, 2044: schedule_timeout in sock_wait_for_wmem
net/core/sock.c, 2083: sock_wait_for_wmem in sock_alloc_send_pskb
net/core/sock.c, 2102: sock_alloc_send_pskb in sock_alloc_send_skb
net/ipv6/mcast.c, 1989: sock_alloc_send_skb in igmp6_send
net/ipv6/mcast.c, 2391: igmp6_send in igmp6_join_group
net/ipv6/mcast.c, 670: igmp6_join_group in igmp6_group_added
net/ipv6/mcast.c, 914: igmp6_group_added in ipv6_dev_mc_inc
net/ipv6/ndisc.c, 379: ipv6_dev_mc_inc in pndisc_constructor
net/core/neighbour.c, 640: [FUNC_PTR]pndisc_constructor in pneigh_lookup
net/ipv6/ip6_output.c, 483: pneigh_lookup in ip6_forward
./include/net/dst.h, 449: [FUNC_PTR]ip6_forward in dst_input
net/ipv6/ip6_input.c, 71: dst_input in ip6_rcv_finish
net/xfrm/xfrm_input.c, 511: [FUNC_PTR]ip6_rcv_finish in xfrm_trans_reinject

[FUNC] kmalloc(GFP_KERNEL)
net/core/neighbour.c, 630: kmalloc in pneigh_lookup
net/ipv6/ip6_output.c, 483: pneigh_lookup in ip6_forward
./include/net/dst.h, 449: [FUNC_PTR]ip6_forward in dst_input
net/ipv6/ip6_input.c, 71: dst_input in ip6_rcv_finish
net/xfrm/xfrm_input.c, 511: [FUNC_PTR]ip6_rcv_finish in xfrm_trans_reinject

Note that [FUNC_PTR] means a function pointer call is used.

I do not find a good way to fix them, so I only report.
These possible bugs are found by my static analysis tool (DSAC) and 
checked by my code review.


Best wishes,
Jia-Ju Bai
