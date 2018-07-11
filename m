Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4472C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:57:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55A8E20883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:57:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GIONX+d9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55A8E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388340AbeGKPBz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 11:01:55 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:33923 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732901AbeGKPBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 11:01:55 -0400
Received: by mail-io0-f195.google.com with SMTP id l7-v6so23874764ioj.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jul 2018 07:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fNcr76WxkzXm0MxrwIaDvvzRiUO9GTZEDhVF60OLBuk=;
        b=GIONX+d9096rfJtDOyj7kUwFM/DguOeKQPonazvyepB7hFXz2r/SyBhk8daD2/pnDr
         /Z5D/thWL9P/grolVAuXzxrsH/ECijVCFgmPzDCgTQFugjzMpvDVY2jdLQXTlZS8qOXA
         JqZa1nUANG5P2NYy65eQBuNmaEHW6mxJL76TvbFSRinnL2wSqn2Kcst2STxJ8tjNh2Uo
         QvH0QXMHMJuG+Cyvhd0NlzYXOkbBHwOug4W1g2V2vb97r/bp7gNQp3ewRPV3g7Vkm2ay
         kyOMM4mwW6gu1E4gTuscnbeXG5Vz55zn+qCLLbBiaeGW9mFeqizz+Xs8FtYq8ih4odQt
         JxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fNcr76WxkzXm0MxrwIaDvvzRiUO9GTZEDhVF60OLBuk=;
        b=eR8MuRph8B7siqNIEI3vR9ERoDtDQxRLhaYLWa6VZ4YFLYdmewzJZprN5D2clngQ9g
         eCfa8ZbZfa2Trf/Zv5yIT2G5FHZtza7SYUT3dbuWpnZjufDcI0mR9em+Ox2wh8Wd0Wx6
         XxBZH9nySFwXf2ENTAuI5xjsfAFgkIC4kQdwASkbKzAYstM+pUi4iR3/CSq2d4iPhffJ
         g0qJs3hRUL0Q8wcbTZviX2Xi8mQb+PSQZ8vseg3O1vTcJNcERqrEVKVS743tSEJL2Myp
         vbn8mAUR5AtS4P+ECGftWXK0Cu2Zez1yi5tb0aR/2wER+sQNgiYBFkE37x6Y3eTeZfiO
         UZ3A==
X-Gm-Message-State: AOUpUlGIP/Ayo5ApNknaPSiRE8coQfCnxYzzhvgkLEdXHq06kDA1vJi4
        vdPZLh2xj39r7glh8lmnm4g1dwMAAtRvM/VKlua2WA==
X-Google-Smtp-Source: AAOMgpfvmUZM1FPN/+QDDhMqG9R5i3cJO/Uv6DFiu+WkriSAb+Y2jwMIDLJMbXPs/2+R4treTjMxGzAjmSoItG/URsE=
X-Received: by 2002:a6b:f10f:: with SMTP id e15-v6mr22946612iog.271.1531321031722;
 Wed, 11 Jul 2018 07:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <1531315019-3553-1-git-send-email-laoar.shao@gmail.com> <1531315019-3553-2-git-send-email-laoar.shao@gmail.com>
In-Reply-To: <1531315019-3553-2-git-send-email-laoar.shao@gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 11 Jul 2018 07:56:59 -0700
Message-ID: <CANn89iLkt+WC36QRKeB7N+DsqCmERnRj5a21+uBjATT7RzyLAA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: refactor tcp_queue_rcv
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     David Miller <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, shaoyafang@didichuxing.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yafang
On Wed, Jul 11, 2018 at 6:17 AM Yafang Shao <laoar.shao@gmail.com> wrote:
>
> There're are some code similar to tcp_queue_rcv() in tcp_ofo_queue(),
> so refactor tcp_queue_rcv() to make it be used in tcp_ofo_queue().
>
> After this change, skb->sk is set when skb is moved from ofo queue into
> receive queue instead of when queued into ofo queue.

Why would you do that ???

I urge you to test this on hosts connected to the wild Internet :/
