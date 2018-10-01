Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7334DC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2726D2145D
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 21:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="QGtFXz1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2726D2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbeJBDvQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 23:51:16 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:49766 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeJBDvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 23:51:15 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id w91LBUYO081738;
        Mon, 1 Oct 2018 16:11:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538428290;
        bh=Gf/w2yvcVi+0bLtDgRenGzOHpjy7oYV2QS8cv4flm7I=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=QGtFXz1fFKw3+qU9qC7OR+und+O48HVl7jQpKCpMlKvfffcV/TXj0UU2PzeuDTcHT
         RjggRM9nMBBZVSV3s37WyPF3xQfeZt7MUXzAcZ4HLijZxNm9aomc/uDOOe2un8dUVk
         XB9ln0mH1C44RAYvFtTF4eTEn9KJaXhtvyiYRqeA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w91LBUCj026406;
        Mon, 1 Oct 2018 16:11:30 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 1 Oct
 2018 16:11:30 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 1 Oct 2018 16:11:30 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w91LBTIF017842;
        Mon, 1 Oct 2018 16:11:30 -0500
Subject: Re: [PATCH 0/5] remoteproc sysfs fixes/improvements
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180915003725.17549-1-s-anna@ti.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <63b8b9a3-d938-cb7a-9a77-12159d4f38a7@ti.com>
Date:   Mon, 1 Oct 2018 16:11:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180915003725.17549-1-s-anna@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

On 09/14/2018 07:37 PM, Suman Anna wrote:
> Hi Bjorn,
> 
> The following series includes couple of fixes and improvements
> associated with the sysfs interfaces. Patches are based on top
> of 4.19-rc1. The first 3 patches are independent of each other.
> 
> Following is the patch summary:
>  - Patch 1 fixes an issue with unbalanced sysfs start/stop
>    and module removal
>  - Patch 2 adds a minor additional check on firmware name
>    being echoed into the sysfs file
>  - Patch 3 is a minor kerneldoc fix.
>  - Patches 4 and 5 introduce a new request denial to sysfs
>    interfaces to not allow userspace to meddle with a remoteproc
>    client driven boot flow, and usage of it by Wkup M3 remoteproc
>    driver

Can you pick up this series for 4.20 please if you don't have any comments?

regards
Suman

> 
> regards
> Suman
> 
> Suman Anna (5):
>   remoteproc: Fix unbalanced boot with sysfs for no auto-boot rprocs
>   remoteproc: Check for NULL firmwares in sysfs interface
>   remoteproc: Add missing kernel-doc comment for auto-boot
>   remoteproc: Introduce deny_sysfs_ops flag
>   remoteproc/wkup_m3: Set deny_sysfs_ops flag
> 
>  drivers/remoteproc/remoteproc_sysfs.c | 29 ++++++++++++++++++++++++++-
>  drivers/remoteproc/wkup_m3_rproc.c    |  1 +
>  include/linux/remoteproc.h            |  3 +++
>  3 files changed, 32 insertions(+), 1 deletion(-)
> 

