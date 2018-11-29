Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A25D9C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F71520863
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 23:37:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="WMMWp9uu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F71520863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbeK3Koi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:44:38 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:45452 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726728AbeK3Koi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 05:44:38 -0500
Received: by mail-pg1-f194.google.com with SMTP id y4so1623377pgc.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 15:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/c8sH5pyuhihdHDLQsZMsMIC+y0JmxVHxRPxHjbjAE=;
        b=WMMWp9uudfhdOcyHXs39eAkqGzGSBj66aMkVE+gvSGBd/Xjd9AswrKXBSnTktwpa8L
         oAz1PfeblPsHd4SUJIBtBEE4o2icBbpSBcBlE0WLYemD4apFrzERTQUPd4UVHJaQIB8D
         WKfiqBUxNircNL3tRks8w+jtoQRxjVA9Nb8/HWvY2ISljqSSQ1gPM2woX40BHt5LHN/X
         hO1gb7P8ifuPwAL5UKvmR8Gwxa9R9vhjefst4jQNwLEiZHKoNIoBRtQceu4/evLdIYsS
         SaMaHk68AGIQM1zVVY8JrueQuk+LCpdUggmjz5kb02u/CfDEzdKLuESDpbGu4LId17lO
         TCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/c8sH5pyuhihdHDLQsZMsMIC+y0JmxVHxRPxHjbjAE=;
        b=SyhtdYZKX16U9+AKPmoZAPy+JqkkBkqnFMQqW1ePjSU0DrNyPriT6J88QuQB5JM8gw
         aYSGv1YhVijxuuJIF0C/kGBeNbjJw79n3W+RoVuSacXOdFlRcdm9kVRur+DqPS/QlFHK
         tPGRs9S+TjkFyrvy+I5m2vqxhznG9JLaLuAIvElx+C6CADjMyHd0iZGuNGa4GZ713ZaP
         UGF53H7c2f3YxUKtJuCVs/atFF1rStrF6WurpR8/H1W79JiDcxSkoyHWIu6GEP0yTNEO
         Dy2a+QktTFnehrxu7ZRlp/4C66NKRk/YQ3W3nBJInL4n/+yZXvVETFOfrpJKzJIKuV4y
         4NeQ==
X-Gm-Message-State: AA+aEWY5GJWUM0N1b2205Hjuv6M3lqbEBJzZ+NffLXaF8Ou8an6OgOu9
        qbwGrZwSh4vjshn8U96UJ5pi8g==
X-Google-Smtp-Source: AFSGD/XL650jwoSBIRL8Ub0lSq8kUk+k36J9YGmtnaGBMq/ac6T3ijv+T6uels6pj1oxSYfus7U8Gw==
X-Received: by 2002:a62:5003:: with SMTP id e3mr3492776pfb.23.1543534643883;
        Thu, 29 Nov 2018 15:37:23 -0800 (PST)
Received: from ziepe.ca (S010614cc2056d97f.ed.shawcable.net. [174.3.196.123])
        by smtp.gmail.com with ESMTPSA id k63sm8953092pfc.76.2018.11.29.15.37.22
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 29 Nov 2018 15:37:22 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1gSVs1-0002vY-R2; Thu, 29 Nov 2018 16:37:21 -0700
Date:   Thu, 29 Nov 2018 16:37:21 -0700
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     kbuild test robot <fengguang.wu@intel.com>
Cc:     kbuild-all@01.org, Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        Mark Bloch <markb@mellanox.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/uverbs: fix ptr_ret.cocci warnings
Message-ID: <20181129233721.GA11172@ziepe.ca>
References: <201811280723.DnTk8AXL%fengguang.wu@intel.com>
 <20181127232130.GA28456@sof-kbuild01>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181127232130.GA28456@sof-kbuild01>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 28, 2018 at 07:21:30AM +0800, kbuild test robot wrote:
> From: kbuild test robot <fengguang.wu@intel.com>
> 
> drivers/infiniband/core/uverbs_cmd.c:1095:1-3: WARNING: PTR_ERR_OR_ZERO can be used
> 
> 
>  Use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR
> 
> Generated by: scripts/coccinelle/api/ptr_ret.cocci
> 
> Fixes: 7106a9769715 ("RDMA/uverbs: Make write() handlers return 0 on success")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
> ---

applied to for-next, thanks

Jason
