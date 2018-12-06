Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C09C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:55:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C26020878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544100925;
	bh=bYZXzN3gp9hoXl6n29fOJyv31yUGQovWzyrVKzXruJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=zQcf5wdvlLY5zxKXo4tvElYmkleZW/TsYja8ctxemkYJvcbOSfiI5KPk52AyeZI6N
	 TzSpcB/fcdkTnTuu7VO0/K3XeZyP5gRinD/C1tXe6Hse/IrQXYHd/xPzsMck2J8Y1b
	 wNrrPGCyX8uN4W+dZlGe7EgI4Gr91T15k4N8DtLk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C26020878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbeLFMzX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:55:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728648AbeLFMzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:55:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 43AEA20878;
        Thu,  6 Dec 2018 12:55:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544100922;
        bh=bYZXzN3gp9hoXl6n29fOJyv31yUGQovWzyrVKzXruJE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wH+sCoDGyyuhcMgiIF7K6zuXWSWnlqINb83dQziw9WzKCFjM2iqLtlWCtYUhzxuRP
         TWqpqlgGKTdDRJzpOwD55qdc6Qjewd0CONlZcZsV2ogQRVW7SpJ+d7bOT7215rGi37
         X+edNswJy8juB1aPTt/FmfcM5lImnbmHIeMFrD00=
Date:   Thu, 6 Dec 2018 13:55:20 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH 1/5] driver core: Introduce device_iommu_mapped() function
Message-ID: <20181206125520.GA28736@kroah.com>
References: <20181204172504.19708-1-joro@8bytes.org>
 <20181204172504.19708-2-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181204172504.19708-2-joro@8bytes.org>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 06:25:00PM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Some places in the kernel check the iommu_group pointer in
> 'struct device' in order to find ot whether a device is
> mapped by an IOMMU.
> 
> This is not good way to make this check, as the pointer will
> be moved to 'struct dev_iommu_data'. This way to make the
> check is also not very readable.
> 
> Introduce an explicit function to perform this check.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  include/linux/device.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
