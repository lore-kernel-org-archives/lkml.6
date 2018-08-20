Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD80AC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 754012173A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 19:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754012173A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726641AbeHTXHc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 19:07:32 -0400
Received: from mga04.intel.com ([192.55.52.120]:29240 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbeHTXHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 19:07:32 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Aug 2018 12:50:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,266,1531810800"; 
   d="scan'208";a="82977995"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.93])
  by fmsmga001.fm.intel.com with ESMTP; 20 Aug 2018 12:50:31 -0700
Subject: Re: [PATCH V2 1/1] device-dax: check for vma range while dax_mmap.
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Zhang, Yu C" <yu.c.zhang@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yi.z.zhang@linux.intel.com" <yi.z.zhang@linux.intel.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "jack@suse.cz" <jack@suse.cz>
Cc:     "Zhang, Yi Z" <yi.z.zhang@intel.com>
References: <46441800c43f029757c70d8386e3112701081503.1534160958.git.yi.z.zhang@linux.intel.com>
 <1534787638.13739.52.camel@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=dave.jiang@intel.com; prefer-encrypt=mutual; keydata=
 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
 o6nmKbYpUAltQObU2w==
Message-ID: <89e7bd54-4afa-614d-ec54-49af7928d6c7@intel.com>
Date:   Mon, 20 Aug 2018 12:50:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1534787638.13739.52.camel@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 08/20/2018 10:53 AM, Verma, Vishal L wrote:
> 
> On Mon, 2018-08-13 at 20:02 +0800, Zhang Yi wrote:
>> This patch prevents a user mapping an illegal vma range that is larger
>> than a dax device physical resource.
>>
>> When qemu maps the dax device for virtual nvdimm's backend device, the
>> v-nvdimm label area is defined at the end of mapped range. By using an
>> illegal size that exceeds the range of the device dax, it will trigger a
>> fault with qemu.
>>
>> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
>> ---
>>  drivers/dax/device.c | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
> 
> Looks good to me:
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>

Applied.

> 
>> diff --git a/drivers/dax/device.c b/drivers/dax/device.c
>> index 108c37f..6fe8c30 100644
>> --- a/drivers/dax/device.c
>> +++ b/drivers/dax/device.c
>> @@ -177,6 +177,33 @@ static const struct attribute_group *dax_attribute_groups[] = {
>>  	NULL,
>>  };
>>  
>> +static int check_vma_range(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>> +		const char *func)
>> +{
>> +	struct device *dev = &dev_dax->dev;
>> +	struct resource *res;
>> +	unsigned long size;
>> +	int ret, i;
>> +
>> +	if (!dax_alive(dev_dax->dax_dev))
>> +		return -ENXIO;
>> +
>> +	size = vma->vm_end - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
>> +	ret = -EINVAL;
>> +	for (i = 0; i < dev_dax->num_resources; i++) {
>> +		res = &dev_dax->res[i];
>> +		if (size > resource_size(res)) {
>> +			dev_info_ratelimited(dev,
>> +				"%s: %s: fail, vma range overflow\n",
>> +				current->comm, func);
>> +			ret = -EINVAL;
>> +			continue;
>> +		} else
>> +			return 0;
>> +	}
>> +	return ret;
>> +}
>> +
>>  static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
>>  		const char *func)
>>  {
>> @@ -469,6 +496,8 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
>>  	 */
>>  	id = dax_read_lock();
>>  	rc = check_vma(dev_dax, vma, __func__);
>> +	if (!rc)
>> +		rc = check_vma_range(dev_dax, vma, __func__);
>>  	dax_read_unlock(id);
>>  	if (rc)
>>  		return rc;
