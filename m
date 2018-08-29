Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C558C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C23F2204FD
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 10:57:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="bPMhJTFh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fl2EQq5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C23F2204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728187AbeH2OyB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 10:54:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50847 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726858AbeH2OyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 10:54:01 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 9361B21165;
        Wed, 29 Aug 2018 06:57:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 29 Aug 2018 06:57:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
        :content-type:date:from:in-reply-to:message-id:mime-version
        :references:subject:to:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Oh0Y1zo4tqpBXUoNbpS/nPDQChj/IMgFHUqEBPOXREg=; b=bPMhJTFh
        oVaCFFP2o2uWf6n3GlIhYRaoUvwZ92qKe5GBWkXxKcO/667WE1NH0hP3WhzzG44a
        rO8GHFIgVIhxdW/PjXAC5+57pPlPKdae8QdQu5vhX3kR/0f5uC4IFFRfux+1uJos
        sIAFF8o6kmedyKxrlwRWPFJbonZuI1F7gb3gRc/oo3bw8wPIArRulkVZeKL5hK/m
        Gh29FIiH/0n4F+Hcw6i8/B3274PGun2il+LcZ/JrPZ+CvlIRqTQMh9NeAC4gtVQ8
        coHZh2chAMiZLgSeBcpM2AktxiU+xhYDOd3UiyttHBEZNXCV8dlIZWiZn3L1kvK0
        RSFM00nU4+AzYg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=Oh0Y1zo4tqpBXUoNbpS/nPDQChj/I
        MgFHUqEBPOXREg=; b=Fl2EQq5h84j9evoqCUp2frdoRHo9ZrYQrnVTcl3JoQuyO
        2XbTIiiCh4bR986hlpkmCGF8QQ9MYkOylEsZwLvp+lvWPYRkqn3vYvLryTKdb8+m
        GuNVZGLdrDXOs3I2n2LXq0kysfjHxF+gDqZE6JEdx5HibEipKzRL2Er1vl9AUJLs
        YOPGAbw3IzLWGwCzlyiolV1mo8d1rGxBy9eZOJ8hQCEZalBFFYYFvLurnS5FWTJb
        ZT5QJr62iEdkLnfJ+sE5+NH1dc/xit8kkHwN40M0aVzVATKj+/Vdg/e0JL3VPn8S
        JKCgAB4lSggUUC2oF9qR0xHclA8eYPBj+VGUCv0pA==
X-ME-Proxy: <xmx:JHyGW0wzr1wXvRJDqFsuTfNjP-sZbaETNZCIXWzu-LyEqe_VhmP78w>
    <xmx:JHyGWyo09JdpBThVx-R-07EgbK0PzW-TDB-6-1M8VmaDkPEHE6OODg>
    <xmx:JHyGW8eRVkmQUuYfIllo96BFi95NwAiGn3ycHdybtWQ2rTLOWd9kYg>
    <xmx:JHyGW9r_rxG8o5eD-by1-FiNru-WbpyvwvKe1ZX9TTTEIzi2Sy2TtA>
    <xmx:JHyGW-nQ8CSfccCYE9gQlKyRUK917u0t6MN3SXDmD9GExzIMt43d0Q>
    <xmx:JHyGW9kpz_n1k3Ti_dZ_h7dRdIXa4Jsd2CGGp5VZmbAr2H56QY2Evw>
X-ME-Sender: <xms:JHyGWz4m9uirMad__nhWa1Cgmo0h6Eclj4DuiCUBT8c4Ol43KUyO4w>
Received: from localhost (unknown [208.181.116.45])
        by mail.messagingengine.com (Postfix) with ESMTPA id AC0A5E47C1;
        Wed, 29 Aug 2018 06:57:39 -0400 (EDT)
Date:   Wed, 29 Aug 2018 03:57:38 -0700
From:   Greg KH <greg@kroah.com>
To:     Chanwoo Choi <cw00.choi@samsung.com>
Cc:     myungjoo.ham@samsung.com, kyungmin.park@samsung.com,
        rafael.j.wysocki@intel.com, chanwoo@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] PM / devfreq: Add new name attribute for sysfs
Message-ID: <20180829105738.GA26948@kroah.com>
References: <CGME20180829073410epcas1p2f314e6c4c29eacfe3ebd5fb4f7f2f122@epcas1p2.samsung.com>
 <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535528046-18835-1-git-send-email-cw00.choi@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 04:34:06PM +0900, Chanwoo Choi wrote:
> commit 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for
> sysfs") changed the node name to devfreq(x). After this commit, it is not
> possible to get the device name through /sys/class/devfreq/devfreq(X)/*.
> 
> Add new name attribute in order to get device name.
> 
> Cc: stable@vger.kernel.org
> Fixes: 4585fbcb5331 ("PM / devfreq: Modify the device name as devfreq(X) for sysfs")
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>
> ---
>  drivers/devfreq/devfreq.c | 11 +++++++++++
>  include/linux/devfreq.h   |  3 +++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/drivers/devfreq/devfreq.c b/drivers/devfreq/devfreq.c
> index 4c49bb1330b5..2145563d5ee5 100644
> --- a/drivers/devfreq/devfreq.c
> +++ b/drivers/devfreq/devfreq.c
> @@ -620,6 +620,9 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  	}
>  	devfreq->max_freq = devfreq->scaling_max_freq;
> 
> +	devfreq->name = dev_name(devfreq->dev.parent);
> +	if (IS_ERR_OR_NULL(devfreq->name))
> +		return -EINVAL;
>  	dev_set_name(&devfreq->dev, "devfreq%d",
>  				atomic_inc_return(&devfreq_no));
>  	err = device_register(&devfreq->dev);
> @@ -1261,6 +1264,13 @@ static ssize_t trans_stat_show(struct device *dev,
>  }
>  static DEVICE_ATTR_RO(trans_stat);
> 
> +static ssize_t name_show(struct device *dev,
> +			struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%s\n", to_devfreq(dev)->name);
> +}
> +static DEVICE_ATTR_RO(name);

You need a new Documentation/ABI/ entry for this.

thanks,

greg k-h
