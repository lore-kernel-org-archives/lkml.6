Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3358CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:36:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D408B208AD
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 07:36:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vSq23RR2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D408B208AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727438AbeH1L1J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 07:27:09 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:40093 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727130AbeH1L1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 07:27:09 -0400
Received: by mail-it0-f67.google.com with SMTP id h23-v6so1259087ita.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 00:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PVA+vqLMdABFy01XRPbmRoR0rVMY6hxh+YDsbDryhzU=;
        b=vSq23RR2SNaFs+e+IWJFX3ZrclzXKzDBYL+jzVGwlfrODCS2b9VvkoRTYm6fP5CIc9
         1Gqzp7LtsJRPEis3FkDn/wFc8ApfDO1Q0xRLRGfNaPkcXZbzvfFn8j7tUl0b5OYiqhfG
         qgwrScc3OX5ZKTVBXq8ZRLhfbpTKwiAwBLNS7QuWFo3gJUwPGbcI/8lV95fLrx06peBt
         Bgp6p4I0NyKfDyCGoY/mHIz0HlmatjmTkkwzdb/YgEixOGmPyWKFrckB+L72C90bjJAn
         0V9iP+QcnhAG5N5jjsXx3MYG6VAakCNAE3jqMC7N5y1vQw1MxyUIb65wXk995awi4W+7
         hSfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PVA+vqLMdABFy01XRPbmRoR0rVMY6hxh+YDsbDryhzU=;
        b=uAGx8yDoj+YEZ8y52iePsbM/BQL9S5ANQW0qWMZonQuepmn7dwCiiEp6+9fnIY0H/F
         YXncSsCWlQIEuNf1pBnAjjCJtNRZE2Gv9+KfVJsNwkQDftrrYY5WbQbtn16uWdd0H/YO
         ZOEnvlNQPFdjlEsgKaSVre/IQJKQdbcn6+40lDdCdxRWeh9tw/8ABd+wUebE2zIh/ZXv
         5LQQSadomFBaLkzFWKfgqXscLaO4dAXHPUeYXQe1OdTpzkhppRXMcoh07rTMCOJbjVon
         +/8SxD6Tx7I2+TsmTxz78XL1iC+R9u6brgn4pne6S3DXuV3mskKcB7KtSuawgGw1fJAa
         h60w==
X-Gm-Message-State: APzg51A2GtX9evZa4qZdrmxbTSDK0tXcpjjfWPGzpNfM1CPiF7YlVnDx
        mI4Ayqgh8fb5dwGIYaw5TEjjDe6dWVLbgkPx0whPwA==
X-Google-Smtp-Source: ANB0VdYC1rfvdxJgGnQ6thqdU6hPvyXsd12Swc6MX4ro5M5VZDTMEa5RTZnYt9t4TwuXciy7lR3CQ2Rdlg/skR93TF0=
X-Received: by 2002:a24:7f87:: with SMTP id r129-v6mr473680itc.107.1535441808405;
 Tue, 28 Aug 2018 00:36:48 -0700 (PDT)
MIME-Version: 1.0
References: <1535441465-65170-1-git-send-email-wen.yang99@zte.com.cn>
In-Reply-To: <1535441465-65170-1-git-send-email-wen.yang99@zte.com.cn>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 28 Aug 2018 00:36:37 -0700
Message-ID: <CANn89iJbC4=rBd3RNvS+i0m6ef66c6W9bv=TK2wmiEdVkJ6M6w@mail.gmail.com>
Subject: Re: [PATCH] tcp: another fix of uncloning packets before mangling them
To:     wen.yang99@zte.com.cn
Cc:     David Miller <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, jiang.biao2@zte.com.cn,
        zhong.weidong@zte.com.cn, liu.bo9@zte.com.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 12:32 AM Wen Yang <wen.yang99@zte.com.cn> wrote:
>
> The following warning was caught=EF=BC=9A
>
> [937151.638394] Call Trace:
> [937151.638401]  [<ffffffff8163f2f6>] dump_stack+0x19/0x1b
> [937151.638405]  [<ffffffff8107dd70>] warn_slowpath_common+0x70/0xb0
> [937151.638407]  [<ffffffff8107deba>] warn_slowpath_null+0x1a/0x20
> [937151.638410]  [<ffffffff8158bb7b>] tcp_set_skb_tso_segs+0xeb/0x100
> [937151.638412]  [<ffffffff8158bbc7>] tcp_init_tso_segs+0x37/0x50
> [937151.638414]  [<ffffffff8158d7b9>] tcp_write_xmit+0x1d9/0xce0
> [937151.638417]  [<ffffffff8158e53e>] __tcp_push_pending_frames+0x2e/0xc0
> [937151.638419]  [<ffffffff8157cf3c>] tcp_push+0xec/0x120
> [937151.638421]  [<ffffffff81580728>] tcp_sendmsg+0xc8/0xc20
> [937151.638424]  [<ffffffff815aae24>] inet_sendmsg+0x64/0xb0
> [937151.638428]  [<ffffffff810b9565>] ? check_preempt_curr+0x75/0xa0
> [937151.638434]  [<ffffffff81519917>] sock_aio_write+0x157/0x180
> [937151.638437]  [<ffffffff811e267d>] do_sync_write+0x8d/0xd0
> [937151.638440]  [<ffffffff811e2f95>] vfs_write+0x1b5/0x1e0
> [937151.638442]  [<ffffffff811e393f>] SyS_write+0x7f/0xe0
> [937151.638445]  [<ffffffff816513fd>] system_call_fastpath+0x16/0x1b
>
> According commit c52e2421f736 ("tcp: must unclone packets before
> mangling them"), TCP stack should make sure it owns skbs before
> mangling them.
> And there is another place where skb_unclone() is needed. This patch
> fix that.
>
> Signed-off-by: Wen Yang <wen.yang99@zte.com.cn>
> Tested-by: Liu Bo <liu.bo9@zte.com.cn>
> Reviewed-by: Jiang Biao <jiang.biao2@zte.com.cn>
> ---
>  net/ipv4/tcp_output.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
> index 597dbd7..fbe8140 100644
> --- a/net/ipv4/tcp_output.c
> +++ b/net/ipv4/tcp_output.c
> @@ -1793,6 +1793,9 @@ static int tcp_init_tso_segs(struct sk_buff *skb, u=
nsigned int mss_now)
>         int tso_segs =3D tcp_skb_pcount(skb);
>

Certainly not needed.

TCP stack owns its packets, as long they were never sent (not yet in
retransmit queue)

You probably are using an old kernel, missing some backport...
