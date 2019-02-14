Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0C0C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:52:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92D6821904
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 04:52:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395537AbfBNEwk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 23:52:40 -0500
Received: from smtprelay0076.hostedemail.com ([216.40.44.76]:46743 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731212AbfBNEwk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 23:52:40 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1484318224D89;
        Thu, 14 Feb 2019 04:52:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: night26_8b05019bd7540
X-Filterd-Recvd-Size: 1660
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Thu, 14 Feb 2019 04:52:35 +0000 (UTC)
Message-ID: <7da4c05d211ed71795bcbad0ded3614979a664c6.camel@perches.com>
Subject: Re: [PATCH 3/5] soc: qcom: socinfo: Expose custom attributes
From:   Joe Perches <joe@perches.com>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>,
        andy.gross@linaro.org
Cc:     david.brown@linaro.org, gregkh@linuxfoundation.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Date:   Wed, 13 Feb 2019 20:52:28 -0800
In-Reply-To: <297ee5e7840077f0330d4ae02dcd13c2ad97f910.1550114271.git.vaishali.thakkar@linaro.org>
References: <cover.1550114271.git.vaishali.thakkar@linaro.org>
         <297ee5e7840077f0330d4ae02dcd13c2ad97f910.1550114271.git.vaishali.thakkar@linaro.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2019-02-14 at 09:11 +0530, Vaishali Thakkar wrote:
> The Qualcomm socinfo provides a number of additional attributes,
> add these to the socinfo driver and expose them via debugfs
> functionality.

trivia:

> diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
[]
> @@ -70,6 +93,10 @@ struct socinfo {
>  struct qcom_socinfo {
>  	struct soc_device *soc_dev;
>  	struct soc_device_attribute attr;
> +	#ifdef CONFIG_DEBUG_FS
> +	struct dentry *dbg_root;
> +	#endif /* CONFIG_DEBUG_FS */

It's generally better to move the #ifdef/#endif to column 1


