Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0D1DC32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:26:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADA1C2081B
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:26:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKbzqxQ7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADA1C2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728263AbeKCDeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:34:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:36048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeKCDeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:34:07 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3480F2081B;
        Fri,  2 Nov 2018 18:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183160;
        bh=3ngNwzdsDuq7vdh0ZrRK49NjWWQphhL3IY7lhjhVTUs=;
        h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
        b=jKbzqxQ7sP0ZNknGLeO3aU952fGv8REo9dmu0tNR0MzilwKPdpaic50xtqTS8kgdI
         0GOTOHXQSOhhiwx/DDEWQJZUD05RtDtmCjzrfe0l0kMd7RQWYrhgz3PmICU6jSOZC7
         oFx0V+YMhH/6rA24CvdMBt86WhBM6ov3iUYu9p84=
Date:   Fri, 02 Nov 2018 13:25:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Suganath Prabu <suganath-prabu.subramani@broadcom.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sathya.Prakash@broadcom.com, sreekanth.reddy@broadcom.com,
        Suganath Prabu <suganath-prabu.subramani@broadcom.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Message-ID: <5bdc96b6a91b2_2e7982af9fe8650b0ba@bhelgaas-glaptop.notmuch>
In-Reply-To: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
References: <1540992219-20291-1-git-send-email-suganath-prabu.subramani@broadcom.com>
Subject: RE: [PATCH v7 0/8] mpt3sas: some bug fixes patches
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suganath Prabu wrote:
> V7 Change Set:
> Split some patches into multiple small patches
> as suggested by Bjorn Helgaas
> 
> v6 Change Set:
> Incorporated changes as suggested by Andy.
> In Patch 1 converted while loop to do while in
> function mpt3sas_wait_for_ioc_to_operational().
> And in patch 3 removed parentheses.
> 
> V5 Change Set:
> V5 post has only defect fixes.
> We are reworking and incorporating the suggestions from Bjorn.
> And after covering tests, we ll be post Hot-Plug Surprise
>  removal patches.
> 
> V4 Change Set:
> Reframe split strings in print statement, to avoid
> 
> V3 Change Set:
> Simplified function "mpt3sas_base_pci_device_is_available" and
> made inline
> 
> V2 Change Set:
> Replaced mpt3sas_base_pci_device_is_unplugged with
> pci_device_is_present.
> 
> V1 Chnage Set:
> In Patch 0001 - unlock mutex, if active reset is in progress.
> 
> Suganath Prabu (8):
>   mpt3sas: Added new #define variable IOC_OPERATIONAL_WAIT_COUNT
>   mpt3sas: Separate out mpt3sas_wait_for_ioc
>   mpt3sas: Refactor mpt3sas_wait_for_ioc function
>   mpt3sas: Call sas_remove_host before removing the target devices
>   mpt3sas: Fix Sync cache command failure during driver unload
>   mpt3sas: Don't modify EEDPTagMode field setting on SAS3.5 HBA devices
>   mpt3sas: Fix driver modifying persistent data in Manufacturing page11
>   mpt3sas: Bump driver version to 27.100.00.00.
> 
>  drivers/scsi/mpt3sas/mpt3sas_base.c      | 73 +++++++++++++------------
>  drivers/scsi/mpt3sas/mpt3sas_base.h      |  8 ++-
>  drivers/scsi/mpt3sas/mpt3sas_config.c    | 27 ++--------
>  drivers/scsi/mpt3sas/mpt3sas_ctl.c       | 21 ++------
>  drivers/scsi/mpt3sas/mpt3sas_scsih.c     | 38 ++++++++++++-
>  drivers/scsi/mpt3sas/mpt3sas_transport.c | 91 ++++++--------------------------
>  6 files changed, 106 insertions(+), 152 deletions(-)
> 
> -- 
> 1.8.3.1

These all look fine to me.  I'm only looking at the code structure; I
have no idea how the mpt3sas hardware or the SCSI mid-layer work, so
you're on your own there :)

Reviewed-by: Bjorn Helgaas <bhelgaas@google.com>

Andy also gave his reviewed-by on the v6 series, so I cc'd him here.
I think it's good practice to specifically cc anybody who has
commented on previous versions of your patch set.
