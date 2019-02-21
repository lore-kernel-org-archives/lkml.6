Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 852B1C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 511FB2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 10:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20150623.gappssmtp.com header.i=@resnulli-us.20150623.gappssmtp.com header.b="z95l4Z7u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbfBUKGt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 05:06:49 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39070 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727632AbfBUKGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 05:06:48 -0500
Received: by mail-wr1-f66.google.com with SMTP id l5so28168777wrw.6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 02:06:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LAoywJAAlkFAtNPWZUkwVXefRjBjRsXyhPE5Sil3CNY=;
        b=z95l4Z7uGsiOZAMNCbNeqfPXujz/MNrQ9XDf3vH+asLErgWTWESsRHpnJJjgBl2TbZ
         ovdHDXI8EOPXbnwbqx9cXEeULf10YbYVUIPNn9y92x6v/jWVEpHFHB/RXoPbtmu1wn2Q
         DUw3GhGE0MtuN4v7SlPOsFpv/9WT87S2ggM7HFXLXd5mH+RCeY7Nem8WAx5hEXyhhvBX
         wVuf8mNoFFksb9EOmVG2WsAsUxkBJdH1f4/rGQ14wehqwpEhtElOshwW9ID1GHElSD1e
         Rf8+PNVCa6gmystC4xF1hKB3vuWDcMhGFSPE9u/eNuDfxGUMNtyTOsFJmDbScYNHti7l
         b1RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LAoywJAAlkFAtNPWZUkwVXefRjBjRsXyhPE5Sil3CNY=;
        b=CF0/YyIstSQVyQdS/TNP5S0bK0FmBdtr/UhdFN8fVGVQKHz8oU1bw+cYwP6ENnoKBp
         mcj9CjZP+NjhBXu9tUEs0fekbdkXIJ0E4LC2V2stOtczOV3TC8sX9ifTAiloZ5RjC2I9
         YnmzhdIdAKf8GT+TIOVIAmcyaddDWqhIpsvqxlJuOZj+cEedpUJq4po3Dej+6+ePd9m+
         qydrHQs2pEPFYkiox8Cv78f4En0dfZuziWKcvX5tLeFNqFNOiIaaGgSp+k6AW9iarfpv
         LYf+CSP9f9yT4BewCiDyYZ6pY30VHXvW7r6FlDy+HXAm0PVn6EHgmDToOkf98O/Ih3dH
         TtlQ==
X-Gm-Message-State: AHQUAuYWsQjV9OHqKf0FG+VXTGxfWdNCo2RzkfXAag8NjWCEHDyChHge
        DC+JVxBwW9FEYoL7M4Lu2IlhLA==
X-Google-Smtp-Source: AHgI3IaP2RPX2geFMIYZI53mrOiQDRrt+u1ZT0pa+HkNr930Eye3ab3MryCV/u2a8hXi2i/nPv/5qQ==
X-Received: by 2002:adf:d4cd:: with SMTP id w13mr27431036wrk.35.1550743606867;
        Thu, 21 Feb 2019 02:06:46 -0800 (PST)
Received: from localhost (ip-89-102-139-73.net.upcbroadband.cz. [89.102.139.73])
        by smtp.gmail.com with ESMTPSA id 12sm17007881wme.25.2019.02.21.02.06.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 02:06:46 -0800 (PST)
Date:   Thu, 21 Feb 2019 10:57:07 +0100
From:   Jiri Pirko <jiri@resnulli.us>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Ido Schimmel <idosch@mellanox.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:STAGING SUBSYSTEM" <devel@driverdev.osuosl.org>,
        "moderated list:ETHERNET BRIDGE" <bridge@lists.linux-foundation.org>,
        jiri@mellanox.com, andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next v3 3/8] staging: fsl-dpaa2: ethsw: Handle
 PORT_PRE_BRIDGE_FLAGS
Message-ID: <20190221095707.GF2312@nanopsycho>
References: <20190221005826.26317-1-f.fainelli@gmail.com>
 <20190221005826.26317-4-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190221005826.26317-4-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thu, Feb 21, 2019 at 01:58:21AM CET, f.fainelli@gmail.com wrote:
>In preparation for removing SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS_SUPPORT,
>handle the SWITCHDEV_ATTR_ID_PORT_PRE_BRIDGE_FLAGS attribute and check
>that the bridge port flags being configured are supported.
>
>Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Acked-by: Jiri Pirko <jiri@mellanox.com>
