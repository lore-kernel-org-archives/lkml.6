Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE92C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:46:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012F720989
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 09:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012F720989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeIXPsG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 11:48:06 -0400
Received: from mx2.suse.de ([195.135.220.15]:39028 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727497AbeIXPsF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 11:48:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id C15B7AE5E;
        Mon, 24 Sep 2018 09:46:51 +0000 (UTC)
Date:   Mon, 24 Sep 2018 11:46:51 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] HID: intel-ish-hid: Enable Ice Lake mobile
In-Reply-To: <20180911234543.10847-1-srinivas.pandruvada@linux.intel.com>
Message-ID: <nycvar.YFH.7.76.1809241146210.15880@cbobk.fhfr.pm>
References: <20180911234543.10847-1-srinivas.pandruvada@linux.intel.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Sep 2018, Srinivas Pandruvada wrote:

> Added PCI ID for Ice Lake mobile platform.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/hid/intel-ish-hid/ipc/hw-ish.h  | 1 +
>  drivers/hid/intel-ish-hid/ipc/pci-ish.c | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/drivers/hid/intel-ish-hid/ipc/hw-ish.h b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> index 97869b7410eb..1b4e93e19e6b 100644
> --- a/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> +++ b/drivers/hid/intel-ish-hid/ipc/hw-ish.h
> @@ -29,6 +29,7 @@
>  #define CNL_Ax_DEVICE_ID	0x9DFC
>  #define GLK_Ax_DEVICE_ID	0x31A2
>  #define CNL_H_DEVICE_ID		0xA37C
> +#define ICL_MOBILE_DEVICE_ID	0x34FC
>  
>  #define	REVISION_ID_CHT_A0	0x6
>  #define	REVISION_ID_CHT_Ax_SI	0x0
> diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> index 09d085946db3..4d78f85021a5 100644
> --- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> +++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
> @@ -38,6 +38,7 @@ static const struct pci_device_id ish_pci_tbl[] = {
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_Ax_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, GLK_Ax_DEVICE_ID)},
>  	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, CNL_H_DEVICE_ID)},
> +	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, ICL_MOBILE_DEVICE_ID)},
>  	{0, }

Applied to for-4.19/fixes.

-- 
Jiri Kosina
SUSE Labs

