Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E245EC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0D052229F
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 09:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550137271;
	bh=FPx3PBkPN3ty3Ia6Iq7gPktSnoMRP+VuMlw+4HT+a2M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pYcvHDobYEQ1jJPGHKrS0kXbT3RkmQhA0s8bbWHmNqxeW6FOiki5e/aFz7I/NkJrT
	 2FdgEcMyM8WsG6ZiqoHwzteJKA1W1Neu70UnBEk6buZhfuref4SH1SFdLcE030dRsn
	 TcRsPCChssu+npu3mJ2Aix4BvkwqTErFerTh58mA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391770AbfBNJlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 04:41:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:60466 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730685AbfBNJlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 04:41:09 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7670C2229F;
        Thu, 14 Feb 2019 09:41:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550137268;
        bh=FPx3PBkPN3ty3Ia6Iq7gPktSnoMRP+VuMlw+4HT+a2M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=05Ox1cPe31QcBsKPnljDfvfZrWoGPEx4C9r1S08Y2HWAhr8isAL2QI47VnmDUtaMp
         exi6RzXiPzN+z1x7y6ogthXeZzXDr+1a/MtNUB5wCLVhSM3Ck5KEA+qA8orb2TQLvs
         yHt8cxJYIkdriFpT8QIsmkCYMhV1XjxhSZLv5jQ0=
Date:   Thu, 14 Feb 2019 10:41:06 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Vaishali Thakkar <vaishali.thakkar@linaro.org>
Cc:     andy.gross@linaro.org, david.brown@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rafael@kernel.org, bjorn.andersson@linaro.org, vkoul@kernel.org
Subject: Re: [PATCH 3/5] soc: qcom: socinfo: Expose custom attributes
Message-ID: <20190214094106.GA10895@kroah.com>
References: <cover.1550114271.git.vaishali.thakkar@linaro.org>
 <297ee5e7840077f0330d4ae02dcd13c2ad97f910.1550114271.git.vaishali.thakkar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <297ee5e7840077f0330d4ae02dcd13c2ad97f910.1550114271.git.vaishali.thakkar@linaro.org>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 14, 2019 at 09:11:49AM +0530, Vaishali Thakkar wrote:
> +static void socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo)
> +{
> +	qcom_socinfo->dbg_root = debugfs_create_dir("qcom_socinfo", NULL);
> +
> +	if (!qcom_socinfo->dbg_root) {
> +		pr_err("Cannot create debugfs directory\n");
> +		return;
> +	}

No need to check this at all, just call debugfs_create_dir() and be done
with it.



> +
> +	DEBUGFS_UINT_ADD(raw_version);
> +	DEBUGFS_UINT_ADD(hardware_platform);
> +	DEBUGFS_UINT_ADD(platform_version);
> +	DEBUGFS_UINT_ADD(foundry_id);
> +	DEBUGFS_HEX_ADD(chip_family);
> +	DEBUGFS_HEX_ADD(raw_device_family);
> +	DEBUGFS_HEX_ADD(raw_device_number);
> +	DEBUGFS_ADD(build_id);
> +	DEBUGFS_ADD(accessory_chip);
> +	DEBUGFS_ADD(pmic_model);
> +	DEBUGFS_ADD(platform_subtype);
> +	DEBUGFS_ADD(pmic_die_revision);
> +}
> +
> +static void socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo)
> +{
> +	debugfs_remove_recursive(qcom_socinfo->dbg_root);
> +}
> +#else
> +socinfo_debugfs_init(struct qcom_socinfo *qcom_socinfo) { return 0; }
> +socinfo_debugfs_exit(struct qcom_socinfo *qcom_socinfo) { return 0; }

These function signatures do not match the ones above :(


thanks,

greg k-h
