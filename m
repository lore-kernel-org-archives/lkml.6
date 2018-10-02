Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A071C004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0580B206B2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 15:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="SItVTCsF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0580B206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbeJBV6Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 17:58:25 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:45364 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbeJBV6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 17:58:25 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w92FET9p129913;
        Tue, 2 Oct 2018 10:14:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1538493269;
        bh=SNVEFd0Pwxz8ZWnVjEEhcBZl5NKYPQnPZ3v/bi5QneY=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=SItVTCsFD5t+5tu2faeVwxoCDD7L2i2oix7QbZK7TYA75S/4gWQkFC5PJt468Pi7I
         4ItThJAoz+VAijx6hJ+QPpWqpE75torNzqhVElkBvSMQTzCmjvq0Wmmx0loGWU4WrC
         M+G8hYLNzqgZoipKDey8mdF4sJq/rfBA5628b68k=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w92FEToJ000361;
        Tue, 2 Oct 2018 10:14:29 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Tue, 2 Oct
 2018 10:14:28 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Tue, 2 Oct 2018 10:14:28 -0500
Received: from [128.247.58.153] (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w92FESYS023714;
        Tue, 2 Oct 2018 10:14:28 -0500
Subject: Re: [PATCH 4/5] remoteproc: Introduce deny_sysfs_ops flag
To:     Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180915003725.17549-1-s-anna@ti.com>
 <20180915003725.17549-5-s-anna@ti.com>
 <36e85566-69e5-0a3a-edf1-6e0cfd8b388b@st.com>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <63b9447a-0589-f9d8-bfc0-1f6350b7c185@ti.com>
Date:   Tue, 2 Oct 2018 10:14:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <36e85566-69e5-0a3a-edf1-6e0cfd8b388b@st.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud,

Thanks for the review and testing of the series.

On 10/02/2018 04:47 AM, Arnaud Pouliquen wrote:
> Hi Suman,
> 
> On 09/15/2018 02:37 AM, Suman Anna wrote:
>> The remoteproc framework provides sysfs interfaces for changing
>> the firmware name and for starting/stopping a remote processor
>> through the sysfs files 'state' and 'firmware'. These interfaces
>> are currently allowed irrespective of how the remoteprocs were
>> booted (like remoteproc self auto-boot, remoteproc client-driven
>> boot etc). These interfaces can adversely affect a remoteproc
>> and its clients especially when a remoteproc is being controlled
>> by a remoteproc client driver(s). Also, not all remoteproc
>> drivers may want to support the sysfs interfaces by default.
>>
>> Add support to deny the sysfs state/firmware change by introducing
>> a state flag 'deny_sysfs_ops' that the individual remoteproc drivers
>> can set based on their usage needs. The default behavior is to
>> allow the sysfs operations as before.
>>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
>> ---
>>  drivers/remoteproc/remoteproc_sysfs.c | 8 ++++++++
>>  include/linux/remoteproc.h            | 2 ++
>>  2 files changed, 10 insertions(+)
>>
>> diff --git a/drivers/remoteproc/remoteproc_sysfs.c b/drivers/remoteproc/remoteproc_sysfs.c
>> index ce93f4d710f3..b2d8c11b89d0 100644
>> --- a/drivers/remoteproc/remoteproc_sysfs.c
>> +++ b/drivers/remoteproc/remoteproc_sysfs.c
>> @@ -36,6 +36,10 @@ static ssize_t firmware_store(struct device *dev,
>>  	char *p;
>>  	int err, len = count;
>>  
>> +	/* restrict sysfs operations if not allowed by remoteproc drivers */
>> +	if (rproc->deny_sysfs_ops)
>> +		return -EPERM;
>> +
>>  	err = mutex_lock_interruptible(&rproc->lock);
>>  	if (err) {
>>  		dev_err(dev, "can't lock rproc %s: %d\n", rproc->name, err);
>> @@ -102,6 +106,10 @@ static ssize_t state_store(struct device *dev,
>>  	struct rproc *rproc = to_rproc(dev);
>>  	int ret = 0;
>>  
>> +	/* restrict sysfs operations if not allowed by remoteproc drivers */
>> +	if (rproc->deny_sysfs_ops)
>> +		return -EPERM;
>> +
>>  	if (sysfs_streq(buf, "start")) {
>>  		if (rproc->state == RPROC_RUNNING)
>>  			return -EBUSY;
>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>> index 75f9ca05b865..d21252b4f758 100644
>> --- a/include/linux/remoteproc.h
>> +++ b/include/linux/remoteproc.h
>> @@ -440,6 +440,7 @@ struct rproc_dump_segment {
>>   * @table_sz: size of @cached_table
>>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>>   * @auto_boot: flag to indicate if remote processor should be auto-started
>> + * @deny_sysfs_ops: flag to not permit sysfs operations on state and firmware
>>   * @dump_segments: list of segments in the firmware
>>   */
>>  struct rproc {
>> @@ -472,6 +473,7 @@ struct rproc {
>>  	size_t table_sz;
>>  	bool has_iommu;
>>  	bool auto_boot;
>> +	bool deny_sysfs_ops;
>>  	struct list_head dump_segments;
>>  };
> 
> I'm concerned about granularity. Are we denying all write access to the
> state and the firmware name?

Not by default. This is relevant only when a remoteproc platform driver
has configured these fields.

> Would it be interesting to have a bit-field to separately allow/deny
> write access:
> - to change the firmware name
> - to start the firmware
> - to stop the firmware
> ?

Do you have use-cases for the individual options?

> 
> For instance, if firmware is stored in the file system, the auto_boot
> mode is not functional (if remote proc in built-in).

This has to do with late FS init, the auto-boot would work if you have
your images in early FS like initramfs or initramdisk with built-in
driver (this is not a remoteproc specific problem and is the case with
all drivers using request_firmware()).

 We could have to
> allow user application to start the firmware, but deny to change the
> firmware name or stop it.

I am not sure if we want to differentiate as the above example almost
kinda depends on how you put together the system. It can be easily
expanded for what you are asking if there is a real need/use-case.

regards
Suman
