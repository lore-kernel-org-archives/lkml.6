Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751866AbeCWX5y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 19:57:54 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58078 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751657AbeCWX5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 19:57:53 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 23 Mar 2018 16:57:52 -0700
From: Channa <ckadabi@codeaurora.org>
To: Channagoud Kadabi <ckadabi@codeaurora.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-arm@lists.infradead.org, linux-kernel@vger.kernel.org,
        tsoni@codeaurora.org, sboyd@codeaurora.org, kyan@codeaurora.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: soc: Add LLCC driver
In-Reply-To: <20180319145525.GD28808@jcrouse-lnx.qualcomm.com>
References: <1516924513-20183-1-git-send-email-ckadabi@codeaurora.org>
 <1516924513-20183-3-git-send-email-ckadabi@codeaurora.org>
 <20180319145525.GD28808@jcrouse-lnx.qualcomm.com>
Message-ID: <5f71be17214a8c54d59555be6f67517f@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-19 07:55, Jordan Crouse wrote:
> On Thu, Jan 25, 2018 at 03:55:13PM -0800, Channagoud Kadabi wrote:
>> LLCC (Last Level Cache Controller) provides additional cache memory
>> in the system. LLCC is partitioned into muliple slices and each
>> slice gets its own priority, size, ID and other config parameters.
>> LLCC driver programs these parameters for each slice. Clients that
>> are assigned to use LLCC need to get information such size & ID of the
>> slice for their usecase and activate or deactivate the slice as 
>> needed.
>> LLCC driver provides API interfaces for the clients to perform these
>> operations.
> 
> <snip>
> 
>> +/**
>> + * llcc_slice_deactivate - Deactivate the llcc slice
>> + * @desc: Pointer to llcc slice descriptor
>> + *
>> + * A value zero will be returned on success and a negative errno will
>> + * be returned in error cases
>> + */
>> +int llcc_slice_deactivate(struct llcc_slice_desc *desc)
>> +{
>> +	u32 act_ctrl_val;
>> +	int rc = -EINVAL;
>> +	struct llcc_drv_data *drv;
>> +
>> +	if (desc == NULL) {
>> +		pr_err("Input descriptor supplied is invalid\n");
> 
> Sorry that this is out of the blue, but I was reviewing a client driver 
> that
> uses this API. This should not print an error - we should be allowed to 
> safely
> pass a null pointer from an aborted sequence in the driver without the
> conditional checks and it shouldn't generate a bit of log spam as it 
> goes about
> it's business.

Thanks Jordan. I will incorporate this change in my next patchset.

> 
> Jordan

-- 
--
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum,
a Linux Foundation Collaborative Project
