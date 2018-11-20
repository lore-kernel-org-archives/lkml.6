Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5353FC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72D4C20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:54:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="PMbBciyM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v9kYnMbn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D4C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbeKTTWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 14:22:51 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:35677 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725902AbeKTTWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 14:22:50 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.nyi.internal (Postfix) with ESMTP id A98ECF9F6;
        Tue, 20 Nov 2018 03:54:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 20 Nov 2018 03:54:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=oacQMMZwmaMU/dcl+A/XMGfESM5
        IeJYvn2lRjcxsDY0=; b=PMbBciyMefUWi3RY3UnLxJGhkvH4ZEtY88kAQKr2xSv
        w23PDtAZgiE4g3BOFhBylWzcIDZeVpcwgCb5sZBRMcrCECVMm2cuvxief83Bev+c
        7Wd2z1YCeyB3tMCdlf2j3jpHo1v0fPs2K83N9k6t36v/PiKJYW4yNrGIXuXbi3R9
        1UzUlhfJclbOgy0vmFMDXi5BwdsY9tMhd6Wc98/n7L/YuWNPFNH79Br8oSPB26Ve
        aWV8/wlXdOoxUTt0vAMRz6m1eUgzZSUDAvMNT1tdVwYOy7rX7Dhvju68NPKu8irM
        qNkmVKQynSdxGJvQECLdJEIUemCk6oiThJsDTxuxiTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=oacQMM
        ZwmaMU/dcl+A/XMGfESM5IeJYvn2lRjcxsDY0=; b=v9kYnMbn3iIKIWDPHO7VNK
        lkhi48KM6f/GDn/kKf1sVtxobWua0ICxujhshQ+ljSvQSO8EN8+nHkniYuA88ATT
        Vb7oRVbP+6yWWnLbxijlxkpXrZlgg5woHmdJGzJC1+zC0Pp5LRwXToQspupKBq84
        Fb/9004nX/MkoeCzAH+nj52Zo4Hxz1ac6PjBiQ8e31KG2sTD3+7Id39xg9epKkYh
        h2sqRDzWkYLfTX0yP9OWP0JMaOtt43Tbqvh1f+QS/mtbjN3GYFoBbM1HVKR3cKHm
        QIJ1twf5sd9G/R7mkbrGWzYkudcgkH8Fqdy6ThaHOltE73hj2f696hqFs+YESOTg
        ==
X-ME-Sender: <xms:2MvzW_irpHp4cNZGFuIkuOvYpMDjuWvGAcmfbV3ebpznqFfs6COnqA>
X-ME-Proxy: <xmx:2MvzW94Mb0s_9aqu_NX6S5amX6tMOA3sCOIiLQu-BUTcXDSEG5AeHw>
    <xmx:2MvzW_WSdYwh2uS8iELUVBiUjOESSw0OPlj51nsQCIbTbn8Q6erbMQ>
    <xmx:2MvzWxPo1SUiNh3rcNpnxL6NrjU0rOHiTOFjAivoJ_q2dCgvfHuwGw>
    <xmx:2MvzW4G13EVXnYNBlh2rl3CCTyx57ilmro8lIPobx5yAoXykm38SFg>
    <xmx:2MvzW73tJ37kGBfUJEmGYzqzOiNFcGvCq2iG0b8BQ3gQIK0Vgpw42Q>
    <xmx:2cvzW-1R0c7ntwnCMPGqHbFGQ4TFgKCT8h3SSuNQvO24Evsv1Qy3AQ>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4F487102E8;
        Tue, 20 Nov 2018 03:54:48 -0500 (EST)
Date:   Tue, 20 Nov 2018 09:54:47 +0100
From:   Greg KH <greg@kroah.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dave Airlie <airlied@linux.ie>,
        DRI <dri-devel@lists.freedesktop.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: linux-next: manual merge of the staging tree with the drm tree
Message-ID: <20181120085447.GB19171@kroah.com>
References: <20181120131616.139a4c8f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181120131616.139a4c8f@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 20, 2018 at 01:16:16PM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the staging tree got a conflict in:
> 
>   drivers/staging/vboxvideo/vbox_ttm.c
> 
> between commits:
> 
>   a64f784bb14a ("drm/ttm: initialize globals during device init (v2)")
> 
> from the drm tree and commit:
> 
>   cd76c287a52f ("staging: vboxvideo: Cleanup the comments")
> 
> from the staging tree.
> 
> I fixed it up (the former removed the comments updated by the latter) and
> can carry the fix as necessary. This is now fixed as far as linux-next
> is concerned, but any non trivial conflicts should be mentioned to your
> upstream maintainer when your tree is submitted for merging.  You may
> also want to consider cooperating with the maintainer of the conflicting
> tree to minimise any particularly complex conflicts.

Fix seems sane to me, thanks.

greg k-h
