Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38E8C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899DA20869
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 03:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6y7IuLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899DA20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbeIDHeg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:34:36 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38123 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbeIDHeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:34:36 -0400
Received: by mail-pg1-f195.google.com with SMTP id f4-v6so919881pgq.5;
        Mon, 03 Sep 2018 20:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Jh3oiuthoRCvTV33QReAUz+4EZDRg63Ld/Q4XkprJzU=;
        b=Z6y7IuLRA5TR/7UdbGynkXE+0O1g6vt4nq42k8aGqQ8WzAOSyb3vmw7tB4H0HaeArV
         muHDoTAqQJnEEWXENp2Ny6Bl/ww6mHZ0TQJWcLeIrTgCGriKS2h3fA+wVsMZ+2UzXKgj
         OYx/yc1mLgEvYNomaiK2bG+woSrCuCJiOxU1m59aoWuHYsvnfCyHFgPRtFIkJ9RyBlEi
         EYrMLlsB/bUdVkWPQmA3O3PNv2SZI+qFJkHBB3RHP6kWKcPnyXWepsQHiIhdAzJLhNZS
         PdRBztUm/k2PwTOyCXRIwojRREkl+NXeY4nSWoPv1RyYUWvWGtTvx67jFqgZYxbl/uC8
         pt7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Jh3oiuthoRCvTV33QReAUz+4EZDRg63Ld/Q4XkprJzU=;
        b=gBGJkMsyd8Knsl1zsk30NFLP/gaoV7WVkwn+zoqaPoCSdm/gT2WD1EFRyHkDbmQ+YV
         SJsFQD7vRPkYSlp2QQpcwTYPaL8BNiSvuoLoCMfetItLoDE9uiRZx8pQT0HewBTNEgYc
         JGFenfh+qLf+VkEERHrGFtSH66E9UD87vVbcokDZWLiwouK3VyyI5nFOyFGDKRt6hzuX
         hpGLAAni6ryAPxCCiCJCYccNMt84KD69W12Y6BkcdbrsiPDj0IVtm54ZxfKRhUGbsISG
         g+BzuTHZAUKUwdgoFEPh0Ka2nag8aW7yKy1nEEGQZKdqQ5hbCBOlmj/lZ+q6uSG5NOxZ
         CXsg==
X-Gm-Message-State: APzg51AnQz4oAoUolVH0+4E1Db0Sq9Jt9A1ufoUbpzf3dRxx6xtd5h2g
        G3MTjN0xUruUY3LAW84AMKA=
X-Google-Smtp-Source: ANB0Vdb68GdLe5xO11ttIN1vD1OUlqBSPesQhyxb7v5HbZZtZxsKnP13iiqwYHIotRDIPC9rc7UhhQ==
X-Received: by 2002:a62:5047:: with SMTP id e68-v6mr32194188pfb.157.1536030695289;
        Mon, 03 Sep 2018 20:11:35 -0700 (PDT)
Received: from dsa-mb.local ([2601:282:800:fd80:1145:f235:fa5f:50ca])
        by smtp.googlemail.com with ESMTPSA id h4-v6sm32434526pfe.49.2018.09.03.20.11.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 20:11:34 -0700 (PDT)
Subject: Re: [PATCH net-next v1 3/5] ipv4: enable IFA_IF_NETNSID for
 RTM_GETADDR
To:     Christian Brauner <christian@brauner.io>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        pombredanne@nexb.com, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, fw@strlen.de, ktkhai@virtuozzo.com,
        lucien.xin@gmail.com, jakub.kicinski@netronome.com,
        jbenc@redhat.com, nicolas.dichtel@6wind.com
References: <20180903043717.20136-1-christian@brauner.io>
 <20180903043717.20136-4-christian@brauner.io>
From:   David Ahern <dsahern@gmail.com>
Message-ID: <a4282d46-4c17-b395-dec0-7c8ac10cbf97@gmail.com>
Date:   Mon, 3 Sep 2018 21:11:30 -0600
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:52.0)
 Gecko/20100101 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180903043717.20136-4-christian@brauner.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/18 10:37 PM, Christian Brauner wrote:
> - Backwards Compatibility:
>   If userspace wants to determine whether ipv4 RTM_GETADDR requests support
>   the new IFA_IF_NETNSID property they should verify that the reply after
>   sending a request includes the IFA_IF_NETNSID property. If it does not
>   userspace should assume that IFA_IF_NETNSID is not supported for ipv4
>   RTM_GETADDR requests on this kernel.

Can only use it once per message type, but NLM_F_DUMP_FILTERED is a flag
that can be set to explicitly say the request is filtered as requested.
See 21fdd092acc7e. I would like to see other filters added for addresses
in the same release this gets used. The only one that comes to mind for
addresses is to only return addresses for devices with master device
index N (same intent as 21fdd092acc7e for neighbors).
