Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B042ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 23:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D050F20866
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 23:27:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D050F20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbeIOEnh convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 00:43:37 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:36945 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725724AbeIOEnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 00:43:37 -0400
Received: by mail-ot1-f68.google.com with SMTP id o13-v6so6154977otl.4;
        Fri, 14 Sep 2018 16:27:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=be6sJRAw/raldX1ntUCubT6RXwut+96tO3F1H38UATU=;
        b=WpHSs6xgmELYApfvbMqFPPffS4u9nnGFFG/jI4R+CM8zuBGkV1LhQYzb1maGqC1lqY
         /8q/Df781dKO7eNnC6lpWXm4GNekDbQMypkPR8YzZm1P8BNgTh/j0kRNicNxxSmDanSw
         29bKx6n3OSwJzxmAPMgamcg2MjSIB8o7C6yZkTW4Plc5Fyh/NjezU6J4WajAMVLNvIT2
         jZnByD18tyTcFmsKcLW8cqnWyg+rf3WtSJCghy17vhr/GnB3MpgYv3sCXKfZ0YwdAUv7
         k22/boD49xaKnl8mvtPY1FDrdrk2dC1EryVjRZR0bfsmG1RDdxFGZN+5IKeeNAC9fGVb
         DbWw==
X-Gm-Message-State: APzg51BPL234X8RDjGoy3Onar21akZK6mGAv1ayuXUv8wGCzptSwCHqf
        4ajdzKOfT5HVFxGo/6AStmjIP5lzePz39w==
X-Google-Smtp-Source: ANB0VdamoeyjrtPeQzhPBR5aA+ovb/aunimlnocnExhDEhRBoB+kSZzqx8CtYj39qtPerr/GMS1rKQ==
X-Received: by 2002:a9d:422b:: with SMTP id q43-v6mr6180842ote.289.1536967620179;
        Fri, 14 Sep 2018 16:27:00 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id j49-v6sm1998412otc.60.2018.09.14.16.26.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Sep 2018 16:26:59 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id v10-v6so6151728otk.7;
        Fri, 14 Sep 2018 16:26:59 -0700 (PDT)
X-Received: by 2002:a9d:615e:: with SMTP id c30-v6mr6003123otk.178.1536967619270;
 Fri, 14 Sep 2018 16:26:59 -0700 (PDT)
MIME-Version: 1.0
References: <20180912085937.22489-1-horia.geanta@nxp.com> <20180912085937.22489-4-horia.geanta@nxp.com>
In-Reply-To: <20180912085937.22489-4-horia.geanta@nxp.com>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Fri, 14 Sep 2018 18:26:48 -0500
X-Gmail-Original-Message-ID: <CADRPPNQYPZGPo0y7pv3CFFJH6Kn4rL42w8YgH-d3pMrU=Q0FFQ@mail.gmail.com>
Message-ID: <CADRPPNQYPZGPo0y7pv3CFFJH6Kn4rL42w8YgH-d3pMrU=Q0FFQ@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] soc: fsl: dpio: add frame list format support
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Roy Pledge <roy.pledge@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        David Miller <davem@davemloft.net>, aymen.sghaier@nxp.com,
        linux-crypto@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2018 at 4:02 AM Horia Geantă <horia.geanta@nxp.com> wrote:
>
> Add support for dpaa2_fd_list format, i.e. dpaa2_fl_entry structure
> and accessors.
>
> Frame list entries (FLEs) are similar, but not identical to FDs:
> + "F" (final) bit
> - FMT[b'01] is reserved
> - DD, SC, DROPP bits (covered by "FD compatibility" field in FLE case)
> - FLC[5:0] not used for stashing
>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>

Acked-by: Li Yang <leoyang.li@nxp.com>

> ---
>  include/soc/fsl/dpaa2-fd.h | 242 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 242 insertions(+)
>
