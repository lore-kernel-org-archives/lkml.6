Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3354FFD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC2E120881
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="I03h0rxN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC2E120881
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=arista.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732019AbeG3Ono (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 10:43:44 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45389 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726649AbeG3Ono (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 10:43:44 -0400
Received: by mail-ed1-f65.google.com with SMTP id s16-v6so4163758edq.12
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 06:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=irCMglaYCgTyZsJDaXGcM2Q0kfEPp/Cwn4ayDBIvsWU=;
        b=I03h0rxNjQr9zd5k/e7HUUWEWVUSgYasIsbZ5kfJPNsVO4bNw6Liws5eghlfUewGyu
         WNoXu4/nEgDKs5vS7GFAyH9DOkmNU11M1iqm0iFACtpqaqoq9eoifDhaAxdM7UGDjJ4t
         b2FXZOhlxloP/CW1N48Sq8ufgU6l0DXXvMBIOW7415MLFx5kpF8RfC1f35vmQhQmnIqY
         i9IeymoOFwKjPXAea8d8b5eX92HTDjtTlEaZV6MwYS3fXzopNdTI5bd+wmJPdoydBV7I
         0Ow+0vgRnLXmb9hZ2h5v1dMn/Jq+YalrcxJ9WVryNp2TdeUgKz889JiaiJ9eEkk5h6Jx
         KgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=irCMglaYCgTyZsJDaXGcM2Q0kfEPp/Cwn4ayDBIvsWU=;
        b=UQ/S08yG8zQNIF6KkbAg3NVctCaX5H4lFSLuIo9TnQq3crDSkIya4dusU34CkuO2x0
         K+zzezHcIiULcdxlaUhatWmU1sCduxdJ7fHO7lk30DXW9Ns4l9jz8jK8oFPJBoGcr+5c
         hkSx8u6b5qaSsEO7Y2dwE4oeHcLJjZQ2tGDg5+x8159W4u4xvPZEXtf0NHeg6zreGu+9
         21D7nmvqBtz7NJdirUKP+0wbKCiBDZq727/X616PqnH7EomrnsxIeXhPsyxvVMqGjlwD
         Y6EPF/sK9nPqgZLkioiNh4o3GJkImkAcV/sS1VksXVpC6GXosbna518ucRz6uqxe2QTu
         1K+Q==
X-Gm-Message-State: AOUpUlGsY43/wB/TGK8pApeSBfexWy9j6XF2bZ8ocqjzY/jgSC/KSfjf
        V30FXm4UHlQ1PZ3zHv8vKyJ8Wg==
X-Google-Smtp-Source: AAOMgpfe6iziaIdF7+CFFWRlmCoYc4F3QYwM6wM72U+ZrB8IqsscRj561GLLzPBfIDgC0BABJLdm6A==
X-Received: by 2002:a50:a186:: with SMTP id 6-v6mr8347409edk.12.1532956126891;
        Mon, 30 Jul 2018 06:08:46 -0700 (PDT)
Received: from dhcp.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id i15-v6sm2414787edq.56.2018.07.30.06.08.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 06:08:46 -0700 (PDT)
Message-ID: <1532956125.2679.28.camel@arista.com>
Subject: Re: [LKP] 7acf9d4237 BUG: kernel hang in test stage
From:   Dmitry Safonov <dima@arista.com>
To:     kernel test robot <lkp@intel.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        LKP <lkp@01.org>, David Miller <davem@davemloft.net>
Date:   Mon, 30 Jul 2018 14:08:45 +0100
In-Reply-To: <20180730081219.GC30690@shao2-debian>
References: <20180730081219.GC30690@shao2-debian>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the report, looking into this..

On Mon, 2018-07-30 at 16:12 +0800, kernel test robot wrote:
> Greetings,
> 
> 0day kernel testing robot got the below dmesg and the first bad
> commit is
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git master
> 
> commit 7acf9d4237c46894e0fa0492dd96314a41742e84
> Author:     Dmitry Safonov <dima@arista.com>
> AuthorDate: Fri Jul 27 16:54:44 2018 +0100
> Commit:     David S. Miller <davem@davemloft.net>
> CommitDate: Sun Jul 29 12:50:19 2018 -0700
> 
>     netlink: Do not subscribe to non-existent groups
>     
>     Make ABI more strict about subscribing to group > ngroups.
>     Code doesn't check for that and it looks bogus.
>     (one can subscribe to non-existing group)
>     Still, it's possible to bind() to all possible groups with (-1)
>     
>     Cc: "David S. Miller" <davem@davemloft.net>
>     Cc: Herbert Xu <herbert@gondor.apana.org.au>
>     Cc: Steffen Klassert <steffen.klassert@secunet.com>
>     Cc: netdev@vger.kernel.org
>     Signed-off-by: Dmitry Safonov <dima@arista.com>
>     Signed-off-by: David S. Miller <davem@davemloft.net>
> 
> 9939a46d90  NET: stmmac: align DMA stuff to largest cache line length
> 7acf9d4237  netlink: Do not subscribe to non-existent groups
> 25432eba9c  openvswitch: meter: Fix setting meter id for new entries
> +--------------------------------------------------+------------+--
> ----------+------------+
> >                                                  | 9939a46d90 |
> > 7acf9d4237 | 25432eba9c |
> 
> +--------------------------------------------------+------------+--
> ----------+------------+
> > boot_successes                                   | 20         |
> > 4          | 4          |
> > boot_failures                                    | 22         |
> > 11         | 11         |
> > INFO:task_blocked_for_more_than#seconds          |
> > 22         |            |            |
> > Kernel_panic-not_syncing:hung_task:blocked_tasks |
> > 22         |            |            |
> > BUG:kernel_hang_in_test_stage                    | 0          |
> > 11         | 11         |
> 
> +--------------------------------------------------+------------+--
> ----------+------------+
> 
> [ 1414.113020] Writes:  Total: 373492244  Max/Min: 0/0   Fail: 0 
> [ 1472.149785] CE: Reprogramming failure. Giving up
> [ 1475.552294] Writes:  Total: 387526813  Max/Min: 0/0   Fail: 0 
> [ 1509.501097] CE: Reprogramming failure. Giving up
> [ 1536.992336] Writes:  Total: 403788741  Max/Min: 0/0   Fail: 0 
> BUG: kernel hang in test stage
> 
> 
>                                                           # HH:MM
> RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> git bisect start 0a930dcfc77cb12bbf9bffd69fbadcb0c237f577
> d72e90f33aa4709ebecc5005562f52335e106a60 --
> git bisect  bad f605359102be537b6217dc49600f4369d1f04932  #
> 07:19  B      0    11   27   0  Merge 'm68k/master' into devel-
> catchup-201807300507
> git bisect  bad 375347c493a490f493fafa02f30fa23179acbdb9  #
> 07:53  B      0    11   27   0  Merge 'linux-review/Todd-
> Poynor/staging-gasket-fixes-and-cleanups/20180730-034316' into devel-
> catchup-201807300507
> git bisect good 86b34080126c3f4254a3f9e8d5dcb447d9233bc8  #
> 08:05  G     11     0    6   6  0day base guard for 'devel-catchup-
> 201807300507'
> git bisect  bad ed28433e6f289d33dd6b4bbf627a60396234db58  #
> 08:40  B      0     1   17   0  Merge 'net/master' into devel-
> catchup-201807300507
> git bisect good 5b891af7fca14526b2a87c6f38b004e2df655ef4  #
> 08:54  G     11     0   11  11  bpf: Replace [u]int32_t and
> [u]int64_t in libbpf
> git bisect good c259b4fb33ee6e7667bf1d34bf0803b7c5fdbdce  #
> 09:03  G     10     0    3   3  netdevsim: don't leak devlink
> resources
> git bisect good b0753408aadf32c7ece9e6b765017881e54af833  #
> 09:17  G     11     0    3   3  net: mdio-mux: bcm-iproc: fix wrong
> getter and setter pair
> git bisect good 71eb5255f55bdb484d35ff7c9a1803f453dfbf82  #
> 09:25  G     11     0   11  11  bpf: use GFP_ATOMIC instead of
> GFP_KERNEL in bpf_parse_prog()
> git bisect good 6d27c6dd1012e7be748ec05da78556319718fbe7  #
> 09:39  G     11     0    4   4  Merge branch 'net-socket-Fix-
> potential-spectre-v1-gadgets'
> git bisect good 9939a46d90c6c76f4533d534dbadfa7b39dc6acc  #
> 09:55  G     11     0    7   7  NET: stmmac: align DMA stuff to
> largest cache line length
> git bisect  bad 25432eba9cd8f2ef5afef55be811b010a004b5fa  #
> 10:28  B      0    11   27   0  openvswitch: meter: Fix setting meter
> id for new entries
> git bisect  bad 7acf9d4237c46894e0fa0492dd96314a41742e84  #
> 11:03  B      0     6   22   0  netlink: Do not subscribe to non-
> existent groups
> # first bad commit: [7acf9d4237c46894e0fa0492dd96314a41742e84]
> netlink: Do not subscribe to non-existent groups
> git bisect good 9939a46d90c6c76f4533d534dbadfa7b39dc6acc  #
> 11:14  G     31     0   15  22  NET: stmmac: align DMA stuff to
> largest cache line length
> # extra tests with debug options
> git bisect  bad 7acf9d4237c46894e0fa0492dd96314a41742e84  #
> 11:48  B      0    11   27   0  netlink: Do not subscribe to non-
> existent groups
> # extra tests on HEAD of linux-devel/devel-catchup-201807300507
> git bisect  bad 0a930dcfc77cb12bbf9bffd69fbadcb0c237f577  #
> 11:49  B      0    13   31   0  0day head guard for 'devel-catchup-
> 201807300507'
> # extra tests on tree/branch net/master
> git bisect  bad 25432eba9cd8f2ef5afef55be811b010a004b5fa  #
> 11:50  B      0    11   27   0  openvswitch: meter: Fix setting meter
> id for new entries
> # extra tests with first bad commit reverted
> git bisect good e61543e57747e8fd80390af39504365a392cef2b  #
> 12:04  G     11     0    4   4  Revert "netlink: Do not subscribe to
> non-existent groups"
> 
> ---
> 0-DAY kernel test infrastructure                Open Source
> Technology Center
> https://lists.01.org/pipermail/lkp                          Intel
> Corporation
