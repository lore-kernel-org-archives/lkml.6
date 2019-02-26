Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C191C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:04:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C851213A2
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 09:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="fqu0GlMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfBZJES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 04:04:18 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39389 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfBZJES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 04:04:18 -0500
Received: by mail-wm1-f66.google.com with SMTP id z84so1448243wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Feb 2019 01:04:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=pgopdYdTTPUq7eXB2PZD/NhiRK6Z81r5jUjaaQ5mpdg=;
        b=fqu0GlMQl/JJ59Zn4rRd6PbgCso4/MMd8XK21j3MfijS+3q5sTBEFdATmL/dQKZblY
         JtMisvj35DiVtnuh4ZZstdnU06P6UNS7viqwtrKIaSJK8IbtJ4OWIH2xj7rNItfkysEf
         oale4R1/+hySE5UjKbOaKfHJsXrtwp6b1CJve1JxpZUtKCsDNqa+uiP901k39cQkByAw
         qdC5csbtKaNiYNt4Ps7MeATFFur8bLTi8H3k2fXGIQAchWM1AuUwLsb8oPELviENBFCB
         AzvUsM0FDtqa+sHs8f3RaFfVfC0ywbPgwn+o1sq3/Il0jtYhbMk3xZtFExxB5cyZ7p7U
         yHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=pgopdYdTTPUq7eXB2PZD/NhiRK6Z81r5jUjaaQ5mpdg=;
        b=X0tD1FFNnAR9coiy8UaciCq7tfq9DF6dwJrMS+pdYEsWMFbtZoBXsg50lr2rN9O+v8
         8i3UP32f8N+TygHBtjEHMF0j3zsj09hy3Em1NOmfclShz0ONYzjLfV/+7AIqWsV1MEUX
         CRmGbvbgHIqHMl9FdeLezYRUK/pdutiNQO/R35WN2togezoZmNF0wXVUjfqz6/TV8ycY
         Vr5uSTRMjQGpLl19CX7t3IsE4OcNXqFQ0/TUUInn54mY/1/XZuGnBSu4eafXwqbAlOFi
         eNCPTcvNTkQRhoam4StmUQ3ZHSx6lr9dpbpeZdJwGyFsYB1wHZ4KTA/wjy84m9JMU8zD
         XAvA==
X-Gm-Message-State: AHQUAubnoo5KoB9JsBELHWOlhNQfB6M/+DxO0r1xlZbcYeAR8NswUVcg
        aKVx6U0fZUOS/L79xUcSVx4xLlZgkyDVxA==
X-Google-Smtp-Source: AHgI3IZSKvDP+X0tuPQiNM7o2RRSyU1qPXI0nhgRBx/RJSyi6yOcIUBHSe7W4J6Vp22ljEbDpq5udQ==
X-Received: by 2002:a1c:30b:: with SMTP id 11mr1864878wmd.110.1551171856408;
        Tue, 26 Feb 2019 01:04:16 -0800 (PST)
Received: from localhost ([2001:718:603:100a:93d:1bfc:765a:ba68])
        by smtp.gmail.com with ESMTPSA id d24sm28634176wrb.47.2019.02.26.01.04.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 26 Feb 2019 01:04:16 -0800 (PST)
Date:   Tue, 26 Feb 2019 09:54:25 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc:     Jiri Pirko <jiri@mellanox.com>, Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] mlxsw: spectrum: acl: Use struct_size() in
 kzalloc()
Message-ID: <20190226085425.GA5451@nanopsycho>
References: <20190225190132.GA23478@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190225190132.GA23478@embeddedor>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Feb 25, 2019 at 08:01:32PM CET, gustavo@embeddedor.com wrote:
>One of the more common cases of allocation size calculations is finding
>the size of a structure that has a zero-sized array at the end, along
>with memory for some number of elements for that array. For example:
>
>struct foo {
>    int stuff;
>    struct boo entry[];
>};
>
>size = sizeof(struct foo) + count * sizeof(struct boo);
>instance = kzalloc(size, GFP_KERNEL)
>
>Instead of leaving these open-coded and prone to type mistakes, we can
>now use the new struct_size() helper:
>
>instance = kzalloc(struct_size(instance, entry, count), GFP_KERNEL)
>
>Notice that, in this case, variable alloc_size is not necessary, hence
>it is removed.
>
>This code was detected with the help of Coccinelle.
>
>Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
