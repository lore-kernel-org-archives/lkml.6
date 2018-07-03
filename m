Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08F51C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:14:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9C0821A59
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 19:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lightnvm-io.20150623.gappssmtp.com header.i=@lightnvm-io.20150623.gappssmtp.com header.b="likIWXwf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9C0821A59
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lightnvm.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934399AbeGCTOz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 15:14:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35267 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753086AbeGCTOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:14:53 -0400
Received: by mail-lj1-f193.google.com with SMTP id i125-v6so2412480lji.2
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jul 2018 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lightnvm-io.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OcEN2iIQC3x1J6F/bvh/SzkV0jFjtxl8e5E4j4a7X5Q=;
        b=likIWXwfRBtjt50rFvhT5KI7vwuFw74iqrPGVGpjP7H9sIWn55xfdUWrqZD/XqQWVp
         jXx5+nEm9pufJ/nHkhKSJEGgDjS4jgVbgIxdPy0fC7JUby7htadqvSn9Az2UAk9d+DmB
         rv4ObhqmAWpvBguRe/242oaaGcgKSf72Iv51uUN91dyl5a7VR2MQ56yH0RvlKstAc3aT
         e6ZcfsAuI6UaJ1mkxgp6Bz0Xa7DLxH0bYoOy2QIWLTaJeKqq1JqW9L8KB6cQtwCAKVVW
         LyHMmEmnkrqLQzN/9HPnrAUE4bXH2kbnQ4WesxMRo+y0FwKjBIANJa+KrYEcURYFm9Nv
         6NjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OcEN2iIQC3x1J6F/bvh/SzkV0jFjtxl8e5E4j4a7X5Q=;
        b=kCtNWdr9vxDd76tGVHCm68Lvad9CKlw8iK8s2nty/9nCVP7FVvo/my0CmwnugeuCAg
         vsjZZsMJ+CF+wGfY/BWpwhdiHkqHyRJTMCJKqqTVHbx9CT5DfaWh6d7h2wJY7cSuenL0
         /pBtDwWhxeNaLaYnP/OddTVHd8K3RfCrhzUdZU5tSaIefw1ARrIFFfiJX8m7XZiPRKeX
         o5W+dn8bsxjEi84UaqU/1Cnv72KTiH+kI0doB3ksovFy/nTEk+DGcyK2w3YxYrIdulqv
         q/emSCjVEdZPBgn+ss2++Zj5YGSKVFDHZS6uJDePZm8+nN0ylI76amylhxhuKC7XhJBr
         8lbw==
X-Gm-Message-State: APt69E2WL7/Ce8vIZJ3TWuFGNo92K3TShiCc72icyzRXkyMs3e7/8qw3
        9WEQEPWVuPkqfLuEu4emFOV3yt9b
X-Google-Smtp-Source: ADUXVKK+WlwNUwPYAhjwwfn+6/bzddfyOvIvKTJERqo0HYA2CFv+NA0NFJqg4BiHtW6HEUNREW1L+w==
X-Received: by 2002:a2e:2f02:: with SMTP id v2-v6mr21650051ljv.113.1530645292230;
        Tue, 03 Jul 2018 12:14:52 -0700 (PDT)
Received: from [192.168.0.10] (95-166-82-66-cable.dk.customer.tdc.net. [95.166.82.66])
        by smtp.googlemail.com with ESMTPSA id l90-v6sm390700lfk.38.2018.07.03.12.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 12:14:51 -0700 (PDT)
Subject: Re: [PATCH] lightnvm: limit get chunk meta request size
To:     javier@cnexlabs.com
Cc:     igor.j.konopko@intel.com, marcin.dziegielewski@intel.com,
        hans.holmberg@cnexlabs.com, hlitz@ucsc.edu,
        youngtack.jin@circuitblvd.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180702080223.13214-1-mb@lightnvm.io>
 <C0B26672-CFD1-4058-A979-48341CD40F8D@cnexlabs.com>
From:   =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
Message-ID: <dd3b8963-1f11-59a6-dc60-e0171687a727@lightnvm.io>
Date:   Tue, 3 Jul 2018 21:14:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <C0B26672-CFD1-4058-A979-48341CD40F8D@cnexlabs.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2018 09:10 PM, Javier Gonzalez wrote:
>> On 2 Jul 2018, at 10.02, Matias Bjørling <mb@lightnvm.io> wrote:
>>
>> For devices that does not specify a limit on its transfer size, the
>> get_chk_meta command may send down a single I/O retrieving the full
>> chunk metadata table. Resulting in large 2-4MB I/O requests. Instead,
>> split up the I/Os to a maximum of 256KB and issue them separately to
>> reduce memory requirements.
>>
>> Signed-off-by: Matias Bjørling <mb@lightnvm.io>
>> ---
>> drivers/nvme/host/lightnvm.c | 10 ++++++++--
>> 1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
>> index b9989717418d..3b644b0e9713 100644
>> --- a/drivers/nvme/host/lightnvm.c
>> +++ b/drivers/nvme/host/lightnvm.c
>> @@ -583,7 +583,13 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>> 	struct ppa_addr ppa;
>> 	size_t left = nchks * sizeof(struct nvme_nvm_chk_meta);
>> 	size_t log_pos, offset, len;
>> -	int ret, i;
>> +	int ret, i, max_len;
>> +
>> +	/*
>> +	 * limit requests to maximum 256K to avoid issuing arbitrary large
>> +	 * requests when the device does not specific a maximum transfer size.
>> +	 */
>> +	max_len = min_t(unsigned int, ctrl->max_hw_sectors << 9, 256 * 1024);
>>
>> 	/* Normalize lba address space to obtain log offset */
>> 	ppa.ppa = slba;
>> @@ -596,7 +602,7 @@ static int nvme_nvm_get_chk_meta(struct nvm_dev *ndev,
>> 	offset = log_pos * sizeof(struct nvme_nvm_chk_meta);
>>
>> 	while (left) {
>> -		len = min_t(unsigned int, left, ctrl->max_hw_sectors << 9);
>> +		len = min_t(unsigned int, left, max_len);
>>
>> 		ret = nvme_get_log_ext(ctrl, ns, NVME_NVM_LOG_REPORT_CHUNK,
>> 				dev_meta, len, offset);
>> --
>> 2.11.0
> 
> Is this a v2? I remember seeing this patch being posted before [1]. It
> still looks good to me :)
> 
> 
> [1] https://lkml.org/lkml/2018/6/12/466
> 
> 
> Reviewed-by: Javier González <javier@cnexlabs.com>
> 

I changed the title. Since it didn't touch pblk. Thanks.
