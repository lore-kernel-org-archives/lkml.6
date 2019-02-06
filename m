Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3581C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7380220844
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 13:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="fNPEboNM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfBFNUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:20:06 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42628 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730734AbfBFNTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 08:19:52 -0500
Received: by mail-wr1-f68.google.com with SMTP id q18so7491691wrx.9
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 05:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=J8lqrL7gwd6zqf8nREYDPeflogYy0ihHELh3zKpvW+k=;
        b=fNPEboNMomT8fIe71IqtehfE3FXE4kYmFiCm/g33WHLSI94jCcG2tLQi4BnYfeW52D
         OTwASUoFQjp7RNltppNXT5VvahQ/NSboEqUsY5A1kuoch7AA6LRAQkz8OT0/0077CFYe
         Asmizke6qWkut+RhU0m4Wngg8bdj/gx6RVRWrYJCkr27IoAOiGL6UxYaU/KwTb4Zwxr6
         P8xFM9gB2tt8/q3NJhEjbtzEbnuCr86AL4hy7IUVILsMLbZq0RunaM2L/IetiVLvKfSB
         ODzq3zM+pg162GVJw1Mz3zF1iFZAq0E5APWs2bij/TkzpDdw1vFX1VxZweHmr7hSm6Co
         Ew2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=J8lqrL7gwd6zqf8nREYDPeflogYy0ihHELh3zKpvW+k=;
        b=N6Z7VNIFlkqBerG3NI1U/hGDerESzQxLkWqRQtEFy9atVQrxPomgYyYTgKvLruIQ6q
         J4seVu2amvuEN6v8UU2DrEXPncjcMW45aNfP1JLK3xqAdePkrRLVxoH7qU6Wfr+HmfdY
         P6RGWIgmkiynU0j5CyjXg6qV3kkiG37253hwM3OHLPgXQaB05GQglaHNp4QwvR9HSDcM
         ojZtk0ySsfP4az6OdegqIsZYd3rL+gQ5PUJ/AckgsVFE2EZy0h0p27jHwqBAwnUmbRW+
         GQ3PLr4p/m0zJqzqqovnMgpVMbNGPBbTCab3bumZ2kdU2hpFsPkKVTBPLLI9LMU0y8id
         dx0w==
X-Gm-Message-State: AHQUAubfJ1UxnXH4stFU/RU7f3tXv4t8/WKHylVkgpup9g/fT0GPT18o
        jF1w9OfjAUBpzlDYzRZfbLOqFw==
X-Google-Smtp-Source: AHgI3IbmuNLOVDiNekk+3t7qYfNsrEB4tAbsouKVSkLNAfttZVY/5HySTMXf0sd2spikynP13TERuw==
X-Received: by 2002:a5d:4004:: with SMTP id n4mr7610255wrp.80.1549459190284;
        Wed, 06 Feb 2019 05:19:50 -0800 (PST)
Received: from localhost (mail.chocen-mesto.cz. [85.163.43.2])
        by smtp.gmail.com with ESMTPSA id c129sm15177795wma.48.2019.02.06.05.19.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Feb 2019 05:19:49 -0800 (PST)
Date:   Wed, 6 Feb 2019 14:10:38 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:MELLANOX MLX5 core VPI driver" 
        <linux-rdma@vger.kernel.org>,
        "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@netronome.com>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>
Subject: Re: [PATCH net-next v3 03/12] liquidio: Implement
 ndo_get_port_parent_id()
Message-ID: <20190206131038.GD2189@nanopsycho>
References: <20190205235326.14600-1-f.fainelli@gmail.com>
 <20190205235326.14600-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190205235326.14600-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, Feb 06, 2019 at 12:53:17AM CET, f.fainelli@gmail.com wrote:
>Liquidio only supports SWITCHDEV_ATTR_ID_PORT_PARENT_ID, which makes it
>a great candidate to be converted to use the ndo_get_port_parent_id()
>NDO instead of implementing switchdev_port_attr_get().
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
