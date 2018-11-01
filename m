Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 190AFC0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917F3205F4
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 22:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=osandov-com.20150623.gappssmtp.com header.i=@osandov-com.20150623.gappssmtp.com header.b="A8HD3Js9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 917F3205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osandov.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbeKBHEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 03:04:50 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:38782 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbeKBHEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 03:04:49 -0400
Received: by mail-it1-f194.google.com with SMTP id j9so651185itl.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 15:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=osandov-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2RjijWIyvdkxniL5nShlmEBWEtVg4KZOTV+yGCPF/k0=;
        b=A8HD3Js9cC/n3l411t4thec/v2VUBp3kl6zCUmNOajRJx7Oz9FTh/PZYcK9pCOOzk7
         qdLwoQyueqA2IzEsr9NzMYJHPsQSvCgxU9LvMwHXkpsNYISZuN8smbQ4lQtia1fZC5f4
         2M+4L8N12rCyCPvJh59xLrUFd2yBjTlgLGx1z1r5q9vgCK1cO0HCsMQRDt5mu8+pwzk5
         wAgeqZBd0NoK++FpZ2aKM/ozUMkqbegf9WuZyJDvfAvj3oTuUW0HYStTuKBxadgvY+NP
         1SPUe0YbMbwO+i+E47YxEc7Tr2EYcK39lil3e+xe+drvkHmzUEhHE+NFhYDySgXS4SOT
         Frmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2RjijWIyvdkxniL5nShlmEBWEtVg4KZOTV+yGCPF/k0=;
        b=JLtdwkpPkhugJa7tn9rgYKZ1j2PLeS4L861j5aylf38mUx+DinSdomiHw+VKFtfFk+
         adECG6f9k4+ILInRObBew1cJeiuFaEF9qVgXmt7jzQ2DY2ezDs6+TRw6+tAKoz6oReOc
         5/dpZBhZvV06wy+pmbZ+EjIjgw4tHWGUdurSjAZQU4RafQJ1WMjAlfHNXBPCN1hjXsHU
         wMCTjxqylN+vO39REPGDGEur8/FWM4s0JJZ8THzeeG3KOSbb8CGR7Bt8x4K75ZDal9lR
         V6kC2Jm8TPF6yCQmU8V0Sng5IH+Fh6ssfVAWh7K3Sfd4LhZDvcLsjx2bDtIMQ0xcOnBF
         ixJw==
X-Gm-Message-State: AGRZ1gLrXNptlGW0bhpJwfjigQPNPNK7t6rZqui/tVCPu+14yJA8qvca
        qB7NFTv8I/EZquZEkIUjpUlWwg==
X-Google-Smtp-Source: AJdET5clvBTPOlp1mXrZYtZaKRIBsRnIGk1KMgtruKWAD/Khgj5q/COG2RIOXpJqzQopObSdi12XnA==
X-Received: by 2002:a24:3306:: with SMTP id k6-v6mr7395823itk.79.1541109599884;
        Thu, 01 Nov 2018 14:59:59 -0700 (PDT)
Received: from vader ([2620:10d:c090:200::6:5dba])
        by smtp.gmail.com with ESMTPSA id x67-v6sm9671080ita.3.2018.11.01.14.59.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 14:59:59 -0700 (PDT)
Date:   Thu, 1 Nov 2018 14:59:57 -0700
From:   Omar Sandoval <osandov@osandov.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/16] blk-mq: add 'type' attribute to the sysfs hctx
 directory
Message-ID: <20181101215957.GH18005@vader>
References: <20181030183252.17857-1-axboe@kernel.dk>
 <20181030183252.17857-7-axboe@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030183252.17857-7-axboe@kernel.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 12:32:42PM -0600, Jens Axboe wrote:
> It can be useful for a user to verify what type a given hardware
> queue is, expose this information in sysfs.
> 
> Reviewed-by: Hannes Reinecke <hare@suse.com>
> Reviewed-by: Bart Van Assche <bvanassche@acm.org>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>
> ---
>  block/blk-mq-sysfs.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Out of curiousity, why sysfs instead of debugfs?
