Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8404EC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4928420850
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 02:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2jqG7yW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4928420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937137AbeFSCy6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 22:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755376AbeFSCy5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 22:54:57 -0400
Received: from dragon (unknown [45.56.152.47])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3AA0204EC;
        Tue, 19 Jun 2018 02:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529376896;
        bh=Ze5gpS0BeSvIX+9uWerHsundAXq1sI2/Jt2B3j4VfRw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=i2jqG7yW5UIOsyL66oyoLJEQwYh7A1FRZBaYdXGtVL5sCTKV08j6FSVSWe0A5Qtqe
         0c4ti7lWPNVTaP+FiYTFMEcFX1KYRrD40Nf+fo/kb5G47KV/26CmGu+yMP9lBzqVQg
         88kYE+1p9O2T8yg/EKjP3B0PRcZWRopVhY9XsXTY=
Date:   Tue, 19 Jun 2018 10:54:00 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Leonard Crestez <leonard.crestez@nxp.com>
Cc:     Fabio Estevam <fabio.estevam@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fugang Duan <fugang.duan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 1/2] ARM: dts: imx6qdl-sabreauto: Add sensors
Message-ID: <20180619025359.GB16091@dragon>
References: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1be8dc197f842d3be31a15315594a25c8ad8f298.1529309235.git.leonard.crestez@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 18, 2018 at 11:15:44AM +0300, Leonard Crestez wrote:
> The following sensors are on I2C3 on the baseboard:
> * isil,isl29023 light sensor
> * fsl,mag3110 magnetometer
> * fsl,mma8451 accelerometer
> 
> Added under i2cmux/i2c@1 because they're not otherwise accessible.
> 
> These are all supported by iio with following configs:
> * CONFIG_SENSORS_ISL29018
> * CONFIG_MAG3110
> * CONFIG_MMA8452
> 
> Tested with raw reads from iio sysfs.
> 
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Applied both, thanks.
