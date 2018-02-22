Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932662AbeBVN52 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:57:28 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:42422 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753855AbeBVN5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:57:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0226F602B7
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: FLR on AER
To: Jon Masters <jcm@redhat.com>, helgaas@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <75DE2522-5DDC-4852-BE38-F7EB53691196@redhat.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <372f63b2-2739-51fe-8959-3c5a0fecc29e@codeaurora.org>
Date: Thu, 22 Feb 2018 08:57:21 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <75DE2522-5DDC-4852-BE38-F7EB53691196@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/2018 8:21 AM, Jon Masters wrote:
> Hi Bjorn,
> 
> It looks like the AER driver won’t do a device FLR but instead will default to progressively bigger hammers. Am I missing something?
> 

AFAIK, AER driver does a secondary bus reset only if it observes a FATAL error. In order to
issue an FLR, driver needs to access the endpoint config space. Since there is a FATAL error,
this is not possible as PCI link is unreliable or probably gone.

> Jon.
> 


-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
