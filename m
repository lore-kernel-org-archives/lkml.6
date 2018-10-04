Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A614CC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:40:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 580E121470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 10:40:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="SB/qM+Y/";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="oz4f64yG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580E121470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727336AbeJDRdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 13:33:15 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:47416 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbeJDRdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 13:33:15 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 6D04960C85; Thu,  4 Oct 2018 10:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538649634;
        bh=EN+D2QcrJH+kaLNiDM01jmxIH/34Lrq2no9ByEC31Vg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SB/qM+Y/o//afCZcLMhVhj/XI/vljiIcfpIDaJljn/Z84YuljpvBO4o/Z5wXggINp
         ALaRl3vHi5bVuy6FbOluq8N8NlFBhTUEKeX7eRMlCyxK5sNYnsN3nE2+odjIREquMv
         qOOvTIgBpPTo2mpXGB/cDGz6U1yt4SYlI/JMCZF0=
Received: from [10.206.24.39] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0B1D1607F4;
        Thu,  4 Oct 2018 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1538649633;
        bh=EN+D2QcrJH+kaLNiDM01jmxIH/34Lrq2no9ByEC31Vg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=oz4f64yGqf5Po+70tHBx5OLZ0gvoK6+fUokvf5a75s9klZxFklmJZFk06N3g977gT
         byVtmWoRizUl0PJfc9tgBpk9oHwAEA1l3Bj+vYqR1DF2O0tajOwuwgEj50tYLsurUF
         P8GYvqY481ZwY4elYdIpo8UisLF3drnCBgY7YXio=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0B1D1607F4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V14 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
To:     Avri Altman <Avri.Altman@wdc.com>,
        "subhashj@codeaurora.org" <subhashj@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "vivek.gautam@codeaurora.org" <vivek.gautam@codeaurora.org>,
        "rnayak@codeaurora.org" <rnayak@codeaurora.org>,
        "vinholikatti@gmail.com" <vinholikatti@gmail.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "evgreen@chromium.org" <evgreen@chromium.org>,
        "riteshh@codeaurora.org" <riteshh@codeaurora.org>
Cc:     "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "jlbec@evilplan.org" <jlbec@evilplan.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1537770516-28410-1-git-send-email-sayalil@codeaurora.org>
 <1537770516-28410-3-git-send-email-sayalil@codeaurora.org>
 <SN6PR04MB4925D198F7AE8961254F43C9FC170@SN6PR04MB4925.namprd04.prod.outlook.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <4aca5fe6-43db-c7b0-b255-622ccec4d1fc@codeaurora.org>
Date:   Thu, 4 Oct 2018 16:10:27 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB4925D198F7AE8961254F43C9FC170@SN6PR04MB4925.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/24/2018 3:33 PM, Avri Altman wrote:
>> obj-$(CONFIG_SCSI_UFS_QCOM) += ufs-qcom.o
>> obj-$(CONFIG_SCSI_UFSHCD) += ufshcd-core.o
>> ufshcd-core-objs := ufshcd.o ufs-sysfs.o
>> +obj-$(CONFIG_SCSI_UFS_PROVISION) += ufs-configfs.o
> Isn't ufs-configfs should be part of ufshcd-core? like ufs-sysfs ?
Agree. Will update.
>
>
>> +static ssize_t ufs_config_desc_show(struct config_item *item, char *buf,
>> +                                   u8 index)
>> +{
> The read part already exist in ufs-sysfs.
User can just read the existing desc here and update the required fields 
as per need and write updated buffer to same configfs path.
I think its better to have both r/w functionality here.
>
>> +ssize_t ufshcd_desc_configfs_store(struct config_item *item, const char *buf,
>> +                                  size_t count, u8 index)
>> +{
>
>> +
>> +       /*
>> +        * First read the current configuration descriptor
>> +        * and then update with user provided parameters
>> +        */
> if originally only lun0 was configured, and you want to configure a new set of luns -
> luns 8 to 15 (config index 0x1) - won't the read fail in that case?
Let me try it out on my setup internally and update once I test this 
scenario
>
> Thanks,
> Avri

