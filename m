Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F255DC5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BCCE20B6F
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 09:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="mTiKccQ7";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="QVdRK9M5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BCCE20B6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbeGKJxm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 05:53:42 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53848 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbeGKJxl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 05:53:41 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 4A84760646; Wed, 11 Jul 2018 09:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531302612;
        bh=xYzMEfG0L1Ma6G3aNz1odg+YFmjXsdXB/tMFht1pSdg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mTiKccQ7eq54S75FJcqozdn1Fk9x8kDeaTZIBmDby3LGsmr4bnP25hFIjaFD30gGc
         qTRnJzp9iUsljXBPbSL/TycS3Uhrkk5w2cC7Y5c/YkxBStmqjJ7N9mQKsLzKO75so6
         pGK4REFWioaDy6VX9MAKO5E5wbRtEhrFUjXxi8ZQ=
Received: from [10.206.24.162] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sayalil@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7BA586063F;
        Wed, 11 Jul 2018 09:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1531302611;
        bh=xYzMEfG0L1Ma6G3aNz1odg+YFmjXsdXB/tMFht1pSdg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=QVdRK9M58LMS3cviqXFXG8KF9C4rfOFOMjhH9QLn4IPOk3N3ptVL9HBfOdPgKIccP
         W+lxKye7kWAPCLB5urBNo2nZUchd23BVXzSLucACxGAVuboIGPiTDjp0SKUh5IyMz8
         qsZeLYnXjgwKxDic2Awzei5LijC97kIx4bYPtFa4=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7BA586063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sayalil@codeaurora.org
Subject: Re: [PATCH V5 2/2] scsi: ufs: Add configfs support for ufs
 provisioning
To:     Christoph Hellwig <hch@infradead.org>
Cc:     subhashj@codeaurora.org, cang@codeaurora.org,
        vivek.gautam@codeaurora.org, rnayak@codeaurora.org,
        vinholikatti@gmail.com, jejb@linux.vnet.ibm.com,
        martin.petersen@oracle.com, asutoshd@codeaurora.org,
        evgreen@chromium.org, riteshh@codeaurora.org,
        linux-scsi@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>
References: <1530858040-13971-1-git-send-email-sayalil@codeaurora.org>
 <1530858040-13971-3-git-send-email-sayalil@codeaurora.org>
 <20180708202136.GA1546@infradead.org>
From:   Sayali Lokhande <sayalil@codeaurora.org>
Message-ID: <4964583a-d13f-7b92-9838-e4398ec8c682@codeaurora.org>
Date:   Wed, 11 Jul 2018 15:20:06 +0530
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180708202136.GA1546@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/9/2018 1:51 AM, Christoph Hellwig wrote:
> On Fri, Jul 06, 2018 at 11:50:40AM +0530, Sayali Lokhande wrote:
>> This patch adds configfs support to provision ufs device at
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
>> CONFIG_CONFIGFS_FS needs to be enabled for using this feature.
> As mentioned before:  this absolutely needs to be a separate
> config option so that the code can be compiled out entirely.
Agree. Will add separate config for UFS Provision and set it dependent 
on CONFIGFS_FS
