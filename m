Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 671BEC282C2
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F71821916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 01:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549591126;
	bh=b+S0EFJwpzXXcIXWxFeOomz6lpqOHYC0b0kUYWYGRA8=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=YPw7y25piP+VsY22Hoz7GW7dLKYvmw4MQO8sEJ3SuMtLGt9URXaq3o4JCWf+72sq0
	 YAZ77cEAPvPPqLU6A1Hq1jRkR8ZIqVbRGME9CN27CVTbc+UxzEEBVkk/qmkw+8GkZr
	 vyU5Q4ZVp7f/QCdyZ6tWO0rW6jaxqPRCAVdKzQbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfBHB6o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 20:58:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:33358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726775AbfBHB6n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 20:58:43 -0500
Received: from [192.168.0.111] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34D392146E;
        Fri,  8 Feb 2019 01:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549591123;
        bh=b+S0EFJwpzXXcIXWxFeOomz6lpqOHYC0b0kUYWYGRA8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=usPhDr1O+l4a3klZTbUJ0A9BEKhuoIZFHh9uiWLwFA3P3AIcYFF5MwksHmTYiDNm6
         TfeXStxaysaSU7ijbogjWVVNBbRKmXoWmp72i5vgJ6RyFELSrkBmhYaQpglf7EuubZ
         8WIuYi2xt5ZamT2+izszlEl9ZPp/BVWlYiQ9PiNw=
Subject: Re: [PATCH v1 1/2] PCI: ATS: Add function to check ATS page aligned
 request status.
To:     sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
        joro@8bytes.org, dwmw2@infradead.org
Cc:     linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>
References: <cover.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <91bfae8b1d4b424219e3ce3c1fc03559c73f1ae7.1549478584.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <5d55e369-355f-b710-0594-03465aa985da@kernel.org>
 <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
From:   Sinan Kaya <okaya@kernel.org>
Message-ID: <32ec3293-28ea-8f0f-f801-0370b4cf0453@kernel.org>
Date:   Thu, 7 Feb 2019 20:58:39 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <a5a29eee-2e33-ba0c-67a6-69983fd0796d@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/7/2019 5:16 PM, sathyanarayanan kuppuswamy wrote:
>> If I remember this right, aligned request is only supported on ATS v1.1
>> but not supported on v1.0.
> Its added in v1.1.

This means that you should probably have some kind of version check
here.
