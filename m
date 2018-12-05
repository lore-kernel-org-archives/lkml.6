Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED778C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C00D20879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 15:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544025562;
	bh=rmDmFM1Bg4XU33mltuunMZWS0Dse78bB8tFhI28Txzg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sKo/4aKl8h5u3xdus9R5RGH7axYq7l3WlL12cbDG6l73XNf4O4W0MPVWIHyl9GmQ0
	 elRa/vrWbunfieNKR2TuZXNzXNd8QcbS2ngo4Ul9Pg1mKM1fwO7F6vcuBWivMnDXw2
	 vTs8M7lHjdjVfGCy6fEBcJE+ky6/5UmEjvZm4Od0=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C00D20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbeLEP7W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 10:59:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727339AbeLEP7V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 10:59:21 -0500
Received: from localhost (unknown [106.201.124.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 51DE920850;
        Wed,  5 Dec 2018 15:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544025560;
        bh=rmDmFM1Bg4XU33mltuunMZWS0Dse78bB8tFhI28Txzg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WrqqOaTxcFIwaxxVzkAkRa337HDalXuSec7bxE3I5x1pOHLYOptKjT8Xu6+YhI1DN
         Fm0p+lhFdUrMGWkPVPCEjYmK7QEC1G8A47UCZYL820l7TDgpnCpMPvZMpSJDYZkLBF
         JkJdaZIAHLa1lsKgr3NR8PY9VX9TBmj04FKv+Z9I=
Date:   Wed, 5 Dec 2018 21:29:12 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Frank Lee <tiny.windzz@gmail.com>
Cc:     dan.j.williams@intel.com, sudeep.dutt@intel.com,
        ashutosh.dixit@intel.com, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        robert.jarzmik@free.fr, okaya@kernel.org,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] dmaengine: remove DBGFS_FUNC_DECL()
Message-ID: <20181205155912.GP2847@vkoul-mobl>
References: <20181130154249.3222-1-tiny.windzz@gmail.com>
 <20181205082719.GF2847@vkoul-mobl>
 <CAEExFWu1ahDPqKbYWKPY_bQuw=1Kp1gUki+CpQ7Mq5sNNiy_tg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEExFWu1ahDPqKbYWKPY_bQuw=1Kp1gUki+CpQ7Mq5sNNiy_tg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-12-18, 23:49, Frank Lee wrote:
> On Wed, Dec 5, 2018 at 4:27 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > On 30-11-18, 10:42, Yangtao Li wrote:
> > > We already have the DEFINE_SHOW_ATTRIBUTE,There is no need to define
> > > such a macro,so remove DBGFS_FUNC_DECL.Also use macro to simplify some
> > > code.
> >
> > Spaces after full stop and comma please
> >
> > >
> > > Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> > > ---
> > >  drivers/dma/amba-pl08x.c     | 14 ++------------
> > >  drivers/dma/mic_x100_dma.c   | 22 +++-------------------
> > >  drivers/dma/pxa_dma.c        | 24 ++++++++++++------------
> > >  drivers/dma/qcom/hidma_dbg.c | 33 ++++++---------------------------
> >
> > Do you mind splitting it per file.
> Hi Vinod:
> 
> Why not apply it once ？The change is not too big.

It is not about big or small. A patch should do one thing and touch a
single module.

It also helps people when they look at changes and backports.

-- 
~Vinod
