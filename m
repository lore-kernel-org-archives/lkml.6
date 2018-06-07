Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Ce3+GmsVGVsxSQAAmS7hNA
	; Thu, 07 Jun 2018 11:22:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4EDC0608B8; Thu,  7 Jun 2018 11:22:19 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zCjDl5T3"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 57556607DC;
	Thu,  7 Jun 2018 11:22:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 57556607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753603AbeFGLWQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 07:22:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:60082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753125AbeFGLWO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 07:22:14 -0400
Received: from mail-wr0-f177.google.com (mail-wr0-f177.google.com [209.85.128.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6EE020891;
        Thu,  7 Jun 2018 11:22:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528370534;
        bh=la3L0yuhItePzsdUaawyGF1ia5OX0Rglw8nCZkLes8w=;
        h=In-Reply-To:References:From:Date:Subject:To:From;
        b=zCjDl5T3cqGNb7jEhv78O/+4zKPFsGcb0rxzhnvAqtNbsyAvpLId4HnwB1rpm4Qy7
         1oE9FqqR80GBrBEWpQBd1CvyAnkS5O7v87QmyTzKQR7hYmUDvw76RvWKagyzA6XsKX
         7ht3SpTuU3oSzkPiZS5XZjsuEpFEdURk0fL2shxQ=
Received: by mail-wr0-f177.google.com with SMTP id v13-v6so9677687wrp.13;
        Thu, 07 Jun 2018 04:22:13 -0700 (PDT)
X-Gm-Message-State: APt69E0MfxqXI405p7k4dwZ2w2hl8cNRbDAf+jBvejPpopPSe5Vn4ALx
        or4j363/enGzLQbNxRQtF7qx8pWZUGWM8aqKHfc=
X-Google-Smtp-Source: ADUXVKJiJqzcS/UtaKwq8hopZ0a6xkxrglBDEc7/SNJi9Umjo0SLhwcNkolPvynzi5wflLx993VOXZYdEwLvYUK4ILw=
X-Received: by 2002:adf:ea0f:: with SMTP id q15-v6mr1462730wrm.9.1528370532247;
 Thu, 07 Jun 2018 04:22:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9166:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 04:22:11 -0700 (PDT)
In-Reply-To: <CAJKOXPd2rntNOpU1quR9Zm_J22+=pEaj4ZTC_tdZ0zcRYUciFg@mail.gmail.com>
References: <CAJKOXPd2rntNOpU1quR9Zm_J22+=pEaj4ZTC_tdZ0zcRYUciFg@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Thu, 7 Jun 2018 13:22:11 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcD3NecVq7yhpJb3whUZe28yq9OrwUpAyEt103KcSNtJA@mail.gmail.com>
Message-ID: <CAJKOXPcD3NecVq7yhpJb3whUZe28yq9OrwUpAyEt103KcSNtJA@mail.gmail.com>
Subject: Re: [BUG BISECT] NFSv4 client fails on Flush Journal to Persistent Storage
To: Trond Myklebust <trond.myklebust@primarydata.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 7, 2018 at 1:19 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote=
:
> Hi,
>
> When booting my boards under recent linux-next, I see failures of systemd=
:
>
> [FAILED] Failed to start Flush Journal to Persistent Storage.
> See 'systemctl status systemd-journal-flush.service' for details.
>          Starting Create Volatile Files and Directories...
> [**    ] A start job is running for Create V=E2=80=A6 [  223.209289] nfs:
> server 192.168.1.10 not responding, still trying
> [  223.209377] nfs: server 192.168.1.10 not responding, still trying
>
> Effectively the boards fails to boot. Example is here:
> https://krzk.eu/#/builders/1/builds/2157
>
> This was bisected to:
> commit 37ac86c3a76c113619b7d9afe0251bbfc04cb80a
> Author: Chuck Lever <chuck.lever@oracle.com>
> Date:   Fri May 4 15:34:53 2018 -0400
>
>     SUNRPC: Initialize rpc_rqst outside of xprt->reserve_lock
>
>     alloc_slot is a transport-specific op, but initializing an rpc_rqst
>     is common to all transports. In addition, the only part of initial-
>     izing an rpc_rqst that needs serialization is getting a fresh XID.
>
>     Move rpc_rqst initialization to common code in preparation for
>     adding a transport-specific alloc_slot to xprtrdma.
>
>     Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
>     Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
>
>
> Bisect log attached. Full configuration:
> 1. exynos_defconfig
> 2. ARMv7, octa-core, Exynos5422 and Exynos4412 (Odroid XU3, U3 and others=
)
> 3. NFSv4 client (from Raspberry Pi)
>
> Let me know if you need any more information.

Ah, I forgot maybe the most important information in reproducment -
client uses NFS root (NFSv4).

Best regards,
Krzysztof
