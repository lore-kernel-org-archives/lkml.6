Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A180C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:05:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2143C2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:05:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mWk4Q3Ps";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="W9BYrc8U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2143C2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeIEOfQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 10:35:16 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:39848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbeIEOfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 10:35:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9127060807; Wed,  5 Sep 2018 10:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536141945;
        bh=8lWHOeodTxTllCNcFug5p5ZcbPwauU7M62BPvcvpDeg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mWk4Q3Ps8oEzD5E6kxm7O3H5M11cAaA4wjF/YHgO1G+r8fNr6kUeZWzztAtIlLx49
         rRYr76hwelYcLPf97xtaz9PnwFvATYwowhgOimkegiybQbOy2iPE69XlZr07PlUOCY
         vy3L6kMa1A39CoWyIeOiE+injj9gYzKOb0iUSBzg=
Received: from [10.206.24.162] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8D85D607F4;
        Wed,  5 Sep 2018 10:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1536141944;
        bh=8lWHOeodTxTllCNcFug5p5ZcbPwauU7M62BPvcvpDeg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=W9BYrc8UApwZIds1OJp4E9KiCK/4JN6KPrM1HfZPmsMWI9O1SgXPFXMZ0B8f6+GNQ
         8K6QBEF9kbadyS5OPk/ZJLoF/3D8K06zpfeFhV5ctv1IjFV8L9W/h37DJIDnIXopky
         Lz7DRY4p5tp8icQ/cGIRrvioY3OiCnBimdOp+Z/Y=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8D85D607F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V12 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
To:     Adrian Hunter <adrian.hunter@intel.com>, subhashj@codeaurora.org,
        cang@codeaurora.org, vivek.gautam@codeaurora.org,
        rnayak@codeaurora.org, vinholikatti@gmail.com,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, evgreen@chromium.org,
        riteshh@codeaurora.org
Cc:     stummala@codeaurora.org, jlbec@evilplan.org,
        linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <1535626003-4966-1-git-send-email-sayalil@codeaurora.org>
 <1535626003-4966-3-git-send-email-sayalil@codeaurora.org>
 <317ec142-2238-ce9f-adba-d6335b1fab8e@intel.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <76f3caa9-5fda-2feb-33d7-d2f56ba457d1@codeaurora.org>
Date:   Wed, 5 Sep 2018 15:35:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <317ec142-2238-ce9f-adba-d6335b1fab8e@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/31/2018 12:42 PM, Adrian Hunter wrote:
> On 30/08/18 13:46, Sayali Lokhande wrote:
>> This patch adds configfs support to provision UFS device at
>> runtime. This feature can be primarily useful in factory or
>> assembly line as some devices may be required to be configured
>> multiple times during initial system development phase.
>> Configuration Descriptors can be written multiple times until
>> bConfigDescrLock attribute is zero.
>>
>> Configuration descriptor buffer consists of Device and Unit
>> descriptor configurable parameters which are parsed from vendor
>> specific provisioning file and then passed via configfs node at
>> runtime to provision ufs device.
>> CONFIG_CONFIGFS_FS and CONFIG_UFS_PROVISION needs to be enabled
>> for using this feature.
>>
>> Usage:
>> 1) To read current configuration descriptor with index X
>>     (where index X can be 0/1/2/3) :
>>     cat /config/XXXX.ufshc/ufs_config_desc_X
>>
>> 2) To write configuration descriptor with index X :
>>     echo <config_desc_buf> > /config/XXXX.ufshc/ufs_config_desc_X
>>
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
> <SNIP>
>
>> +static struct configfs_attribute ufshcd_attr_provision_0 = {
> Actually, wasn't the original suggestion to use a binary attribute? i.e.
> configfs_bin_attribute
Yes. we did discuss about having binary attribute in between , but then 
it was thought if anyone who wants to use this interface from a shell 
script, it will be much easier to write multiple ASCII attributes than a 
single binary attribute.  It seemed more readable for users and 
easier/comfortable to compare any value to default spec value(if required).

