Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEB45C65BAF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:34:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 811ED20851
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 19:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544643271;
	bh=VtI2iPL2J5H9Lrs0uykyq9RWMX0C79HMAOURHRDBLug=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=ROqPLmY/6kW6GogWhMm2+lCHZDOhH0PgGR2kOYCwEtIyTAY/j5nIxRVdVD6L6UpS2
	 anCTOBBIRcTZS7MysziK5WHuXs3O1btk+cLlAqkswTPYccJ95dIxiocHPbMUQC5yFK
	 EJbuh0vF6LctLNw9TZ2H5u9QNhZmb5jFADU1LfBo=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 811ED20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeLLTea (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 14:34:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:39580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726235AbeLLTea (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 14:34:30 -0500
Received: from [10.80.45.159] (unknown [71.69.156.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98AB120851;
        Wed, 12 Dec 2018 19:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544643269;
        bh=VtI2iPL2J5H9Lrs0uykyq9RWMX0C79HMAOURHRDBLug=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SDnqO2FIEgV8gt025LTrofsiEclifvrbCRoXlD8vJRkh3O9XWS6IRP6ML4ILmQVA4
         3eGvpEdPIEPCPf41cpmJ/Dz6r8dN8Z/XSJygzTW5KM8fq60iSTmX3UU3Dr6UaFs9FU
         svnUcgUya/oTaUKPjIInnolXl1z9gTYPy9EnBSno=
Subject: Re: [PATCH v6 5/5] ACPICA: Remove PCI bits from ACPICA when
 CONFIG_PCI is unset
To:     "Schmauss, Erik" <erik.schmauss@intel.com>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Cc:     "Moore, Robert" <robert.moore@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20181212171941.7437-1-okaya@kernel.org>
 <20181212171941.7437-6-okaya@kernel.org>
 <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <39dc076f-1b3d-ad0c-c4bb-056ac589f361@kernel.org>
Date:   Wed, 12 Dec 2018 14:34:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
In-Reply-To: <CF6A88132359CE47947DB4C6E1709ED53C556B2C@ORSMSX122.amr.corp.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/2018 2:02 PM, Schmauss, Erik wrote:
>> ++ b/drivers/acpi/acpica/achware.h
>> @@ -109,8 +109,17 @@ acpi_hw_enable_runtime_gpe_block(struct
>> acpi_gpe_xrupt_info *gpe_xrupt_info,
> CONFIG_PCI is a Linux-ism. We should stay with the OS-independent nature of
> ACPICA. Please use ACPI_PCI_CONFIGURED and put it above the comment like so:
> 
> #ifdef ACPI_PCI_CONFIGURED

Thanks for the feedback. My search for ACPI_PCI_CONFIGURED returned nothing.

git grep ACPI_PCI_CONFIGURED

@Rafael,

How do you want to handle this?
