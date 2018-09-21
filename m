Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC0B8ECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:46:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 582A121479
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 11:46:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="cA6dbUyC";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mJXKkBWV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 582A121479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389986AbeIURe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 13:34:57 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44112 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbeIURe4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 13:34:56 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 377076125F; Fri, 21 Sep 2018 11:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537530386;
        bh=nc+UKqztwt319MVF18m0A6wQS49uc1GThSkV77Jr/pI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=cA6dbUyCbH1fRKo/KUic96gs7Rq30Slwqow3CgCj7Ly35V7U3BdVBQ3VrYjX/Jx6j
         e0F+DXrRPVOWQqAvJnOA2dRQ/IznJQ3vq6MKcgfjcTYvIeKnI6i4Ra3+OZNOAcOqJf
         7NFmg0FnbR8peLwdEbuvHee+A6tqaSWjX0av0l/E=
Received: from [10.206.24.162] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B5C0B61284;
        Fri, 21 Sep 2018 11:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1537530385;
        bh=nc+UKqztwt319MVF18m0A6wQS49uc1GThSkV77Jr/pI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mJXKkBWVl3MtFoqWRQHBzlM0R6pjxbxGXpH3ePKzP/Gq6Or9XOIXba04jAUe/HSsl
         TW4WZ1meDW4LF9AMWj7aoZh8UDi1yWuX2CPonKf50Mv+jEkSYHUnVEgIHOnPLkLoTo
         1YNrPjmt7bxqlgD1B9Qp0TVQE3PxuSfZAzPBkC/U=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B5C0B61284
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V13 2/2] scsi: ufs: Add configfs support for UFS
 provisioning
To:     Evan Green <evgreen@chromium.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        asutoshd@codeaurora.org, riteshh@codeaurora.org,
        stummala@codeaurora.org, adrian.hunter@intel.com,
        Joel Becker <jlbec@evilplan.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536918159-311-1-git-send-email-sayalil@codeaurora.org>
 <1536918159-311-3-git-send-email-sayalil@codeaurora.org>
 <CAE=gft5Hfstqe38daPAGncjZjdnfL-+Fv7QGSvLtBWc7BFzwPg@mail.gmail.com>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <dad90758-04d8-f30e-a456-15217c90ff7c@codeaurora.org>
Date:   Fri, 21 Sep 2018 17:16:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAE=gft5Hfstqe38daPAGncjZjdnfL-+Fv7QGSvLtBWc7BFzwPg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 9/19/2018 2:26 AM, Evan Green wrote:
> On Fri, Sep 14, 2018 at 2:43 AM Sayali Lokhande <sayalil@codeaurora.org> wrote:
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
>>     cat /config/<device_name>/ufs_config_desc_X
>>
>> 2) To write configuration descriptor with index X :
>>     echo <config_desc_buf> > /config/<device_name>/ufs_config_desc_X
>>
>> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
>> ---
> ...
>> diff --git a/drivers/scsi/ufs/ufs-configfs.c b/drivers/scsi/ufs/ufs-configfs.c
>> new file mode 100644
>> index 0000000..84ccb1a
>> --- /dev/null
>> +++ b/drivers/scsi/ufs/ufs-configfs.c
>> @@ -0,0 +1,237 @@
> ...
>> +static ssize_t ufs_config_desc_0_show(struct config_item *item, char *buf)
>> +{
>> +       return ufs_config_desc_show(item, buf, 0);
>> +}
>> +
>> +static ssize_t ufs_config_desc_0_store(struct config_item *item,
>> +                                      const char *buf, size_t count)
>> +{
>> +       return ufshcd_desc_configfs_store(item, buf, count, 0);
>> +}
>> +
>> +static ssize_t ufs_config_desc_1_show(struct config_item *item, char *buf)
>> +{
>> +       return ufs_config_desc_show(item, buf, 1);
>> +}
>> +
>> +static ssize_t ufs_config_desc_1_store(struct config_item *item,
>> +                                      const char *buf, size_t count)
>> +{
>> +       return ufshcd_desc_configfs_store(item, buf, count, 1);
>> +}
>> +
>> +static ssize_t ufs_config_desc_2_show(struct config_item *item, char *buf)
>> +{
>> +       return ufs_config_desc_show(item, buf, 2);
>> +}
>> +
>> +static ssize_t ufs_config_desc_2_store(struct config_item *item,
>> +                                      const char *buf, size_t count)
>> +{
>> +       return ufshcd_desc_configfs_store(item, buf, count, 2);
>> +}
>> +
>> +static ssize_t ufs_config_desc_3_show(struct config_item *item, char *buf)
>> +{
>> +       return ufs_config_desc_show(item, buf, 3);
>> +}
>> +
>> +static ssize_t ufs_config_desc_3_store(struct config_item *item,
>> +                                      const char *buf, size_t count)
>> +{
>> +       return ufshcd_desc_configfs_store(item, buf, count, 3);
>> +}
>> +
> The copypasta above and below is not my favorite, but I suppose it's
> either this or wrap it all up in a macro that you stamp down 4 times.
> I'm not sure if that's really any cleaner, so I guess this is fine.
>
>> +static struct configfs_attribute ufshcd_attr_provision_0 = {
>> +       .ca_name        = "ufs_config_desc_0",
>> +       .ca_mode        = 0644,
>> +       .ca_owner       = THIS_MODULE,
>> +       .show           = ufs_config_desc_0_show,
>> +       .store          = ufs_config_desc_0_store,
>> +};
>> +
>> +static struct configfs_attribute ufshcd_attr_provision_1 = {
>> +       .ca_name        = "ufs_config_desc_1",
>> +       .ca_mode        = 0644,
>> +       .ca_owner       = THIS_MODULE,
>> +       .show           = ufs_config_desc_1_show,
>> +       .store          = ufs_config_desc_1_store,
>> +};
>> +
>> +static struct configfs_attribute ufshcd_attr_provision_2 = {
>> +       .ca_name        = "ufs_config_desc_2",
>> +       .ca_mode        = 0644,
>> +       .ca_owner       = THIS_MODULE,
>> +       .show           = ufs_config_desc_2_show,
>> +       .store          = ufs_config_desc_2_store,
>> +};
>> +
>> +static struct configfs_attribute ufshcd_attr_provision_3 = {
>> +       .ca_name        = "ufs_config_desc_3",
>> +       .ca_mode        = 0644,
>> +       .ca_owner       = THIS_MODULE,
>> +       .show           = ufs_config_desc_3_show,
>> +       .store          = ufs_config_desc_3_store,
>> +};
>> +
>> +static struct configfs_attribute *ufshcd_attrs[] = {
>> +       &ufshcd_attr_provision_0,
>> +       &ufshcd_attr_provision_1,
>> +       &ufshcd_attr_provision_2,
>> +       &ufshcd_attr_provision_3,
>> +       NULL,
>> +};
>> +
>> +static struct config_item_type ufscfg_type = {
>> +       .ct_attrs       = ufshcd_attrs,
>> +       .ct_owner       = THIS_MODULE,
>> +};
>> +
>> +void ufshcd_configfs_init(struct ufs_hba *hba, const char *name)
>> +{
>> +       int ret;
>> +       struct config_item *cg_item;
>> +       struct configfs_subsystem *subsys;
>> +
>> +       cg_item = &hba->subsys.su_group.cg_item;
>> +       sprintf(cg_item->ci_namebuf, "%s", name);
> CONFIGFS_ITEM_NAME_LEN is only 20. Is there anything preventing the
> device name passed in here from being longer than that? You'd have a
> nasty overrun on your hands if not. Maybe snprintf here?
Agree. I need to use snprintf here. Will update.
>> +       cg_item->ci_type = &ufscfg_type;
>> +
>> +       subsys = &hba->subsys;
>> +       config_group_init(&subsys->su_group);
>> +       mutex_init(&subsys->su_mutex);
>> +       ret = configfs_register_subsystem(subsys);
>> +       if (ret)
>> +               pr_err("Error %d while registering subsystem %s\n",
>> +                      ret,
>> +                      subsys->su_group.cg_item.ci_namebuf);
>> +}
>> +
>> +void ufshcd_configfs_exit(struct ufs_hba *hba)
>> +{
>> +       configfs_unregister_subsystem(&hba->subsys);
>> +}

