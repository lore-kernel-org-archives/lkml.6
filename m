Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id bJJhMeASHlt9WwAAmS7hNA
	; Mon, 11 Jun 2018 06:19:24 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id DC01260792; Mon, 11 Jun 2018 06:19:23 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=dev-mellanox-co-il.20150623.gappssmtp.com header.i=@dev-mellanox-co-il.20150623.gappssmtp.com header.b="vTwGMrpA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0110D602FC;
	Mon, 11 Jun 2018 06:19:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0110D602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=dev.mellanox.co.il
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753984AbeFKGTV (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:19:21 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41071 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753901AbeFKGTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:19:19 -0400
Received: by mail-wr0-f194.google.com with SMTP id h10-v6so18989674wrq.8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jun 2018 23:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=394+hVvcGa4pWm8jxIaoAShrnRnqUW7qk+mXNAdG/1c=;
        b=vTwGMrpA/gvjRbDcL7Dt9Cp57KR+ucrxS2D8s5oMR4is1dWaNDUNyRPnZCtU/aAHiN
         hr43x2y+g/sTqOa/LlrGXLOnrXR5plMdziBRxc7bzhXBnmBHgJYX8c6ZzC2Sm3F+WBcW
         dyPJfOpW60DYd4tXwaJX4uLfKAT/cJobPhj2buDIutPL+GDDkb4oTkILq125IqfmoyKK
         3FuPV4K+hpxQUyKK2xbDO+GPNkfWk+odm7ssOzbF7rt9Lm3aALL5JKo0zpioNAga/sbq
         cwRW8aWh+QjRmRYX/kGFMp9LdJ/4PYErW1L1lyQDLhSOJJu32QzM/2Kf6/+KhAWIwtQf
         t8Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=394+hVvcGa4pWm8jxIaoAShrnRnqUW7qk+mXNAdG/1c=;
        b=MjZm38qvnvSIvEiAFGc5ecYcBySe00PvgMxWEI5eksQ3C17upMbnGXXNZmBVZJ40SO
         ApDkcDqAGv4YxBZVFq6y0r0CCC2KE6cD8LlJzC5qCvJbHnShfd2+Stk/RP4XHdejXeA1
         j2ME7Sf/6t1pQmTpARoyYvDQuiEbgdGiGcUwqNrPmnsYtVJGr3BCzYBol7QWHz/Z9DPL
         31jdvznoojwBdTgDD/EfgFAR25MyE8LXRzmonpiLHx/cQDXYFY3UIIX/nnVhq+uMY+Ee
         tp8YQTEh9leOjiPvQQNqUo9mjttCa10ylZpZuHpAQtKuNx3uxpETex39LxcNnRQNmZAp
         anTw==
X-Gm-Message-State: APt69E3BGz6r/ZW8mD18+q80XF7AyNp/qoOAMEw/mvW8amg4p+Z1/9+3
        3KY60Mngv4rw6dE7MdreqmnFaw==
X-Google-Smtp-Source: ADUXVKJ3OD0r4L9jZacO5pCvFsQKH47yGHAio0L25NPpnMuaw7/qrmsVpRzYa543XYV0Hal3RpBYBg==
X-Received: by 2002:adf:f40a:: with SMTP id g10-v6mr11675950wro.256.1528697957846;
        Sun, 10 Jun 2018 23:19:17 -0700 (PDT)
Received: from localhost ([141.226.165.75])
        by smtp.gmail.com with ESMTPSA id g88-v6sm9958489wmc.27.2018.06.10.23.19.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Jun 2018 23:19:16 -0700 (PDT)
Date: Mon, 11 Jun 2018 09:19:14 +0300
From: jackm <jackm@dev.mellanox.co.il>
To: Jason Gunthorpe <jgg@mellanox.com>
Cc: Leon Romanovsky <leon@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        hans.westgaard.ry@oracle.com, Doug Ledford <dledford@redhat.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        linux-rdma@vger.kernel.org,
        =?ISO-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
        Parav Pandit <parav@mellanox.com>,
        Pravin Shedge <pravin.shedge4linux@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] IB/mad: Use IDR for agent IDs
Message-ID: <20180611091914.00007858@dev.mellanox.co.il>
In-Reply-To: <20180611044203.GA32562@mellanox.com>
References: <20180608174218.32455-1-willy@infradead.org>
        <20180608174218.32455-3-willy@infradead.org>
        <20180610063028.GH12407@mtr-leonro.mtl.com>
        <20180610104305.GA9284@bombadil.infradead.org>
        <20180610122505.GM12407@mtr-leonro.mtl.com>
        <20180610203027.GF5560@mellanox.com>
        <20180611043425.GA21382@mtr-leonro.mtl.com>
        <20180611044203.GA32562@mellanox.com>
Organization: Mellanox
X-Mailer: Claws Mail 3.15.0 (GTK+ 2.24.31; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Jun 2018 22:42:03 -0600
Jason Gunthorpe <jgg@mellanox.com> wrote:

> Er, the spec has nothing to do with this. In Linux the TID is made
> unique because the core code provides 32 bits that are unique and the
> user provides another 32 bits that are unique. The driver cannot
> change any of those bits without risking non-uniquenes, which is
> exactly the bug mlx4 created when it stepped outside its bounds and
> improperly overrode bits in the TID for its own internal use.

Actually, the opposite is true here.
When SRIOV is active, each VM generates its *own* TIDs -- with 32 bits
of agent number and 32 bits of counter.

There is a  chance that two different VMs can generate the same TID!
Encoding the slave (VM) number in the packet actually guarantees
uniqueness here.
There is nothing wrong with modifying the TID in a reversible way in
order to:
a. guarantee uniqueness
b. identify the VM which should receive the response packet

The problem was created when the agent-id numbers started to use the
most-significant byte (thus making the MSB slave-id addition
impossible).
