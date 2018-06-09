Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J00PCI1nHFvXMQAAmS7hNA
	; Sat, 09 Jun 2018 23:49:33 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id ED7F3608B8; Sat,  9 Jun 2018 23:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
	s=default; t=1528588173;
	bh=GN+RRCIckXg7GR7Fm7LmVoQmY2BgpSRfPCOcPkzc54g=;
	h=Subject:To:Cc:References:From:Date:In-Reply-To:List-ID:From;
	b=I0y8uvaD/yXAUUE+wAYt9y/bvNnNojZmbYJg7gjjfZf7IVPZN6prUm0XY3Gu3WC0+
	 b80maAHmrOYZbVufYWukmD9rtrzeC3e7Oe1hCEMtibT/df4Hq/xEaUebDxeIHBdUDX
	 Y2agdX+JjLM7jMis+VzNLSQnhKGefTcEaRNgJ9jM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 68621607DC;
	Sat,  9 Jun 2018 23:49:32 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="DHyFrSb5";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=codeaurora.org header.i=@codeaurora.org header.b="dk1RepfD"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68621607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbeFIXta (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 19:49:30 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:54724 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753516AbeFIXt2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 19:49:28 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 439FA608BF; Sat,  9 Jun 2018 23:49:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528588168;
        bh=GN+RRCIckXg7GR7Fm7LmVoQmY2BgpSRfPCOcPkzc54g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=DHyFrSb5INHC1k3Ak96PYS9eBBdso6+lJ0yVS7OpdFWKfA1zsLU8oPYmm2OmxqZDQ
         Sa9Hc22OFpgIQtghzpYFNtMJXmZrw/xMV5f2uBk3Ay3C/w/ofnFaGSsg3MCN8VHmHL
         uRbDJenrVRh+YHq9dUyi1dRRLDlzGvf3DvLEOvJU=
Received: from [192.168.0.106] (cpe-174-109-247-98.nc.res.rr.com [174.109.247.98])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: okaya@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0412605A2;
        Sat,  9 Jun 2018 23:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1528588167;
        bh=GN+RRCIckXg7GR7Fm7LmVoQmY2BgpSRfPCOcPkzc54g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=dk1RepfD6QAmq0XBvp67UznhkWYnEA68n74Xe7Q6wNzZ5XRFd2/UcfN1eEghsQcbN
         VZB9Gfvo+VzUsWsSPWItJarPDu64zOxeqVDjIO1UHgiMLcocve0MdugKs5xIXGNSVV
         Zy+SkpE0l1v1JIYtu7oBzmCZBnKRDMB3RPsf4TFI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0412605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=okaya@codeaurora.org
Subject: Re: [PATCH v2] pci/aspm: Remove CONFIG_PCIEASPM_DEBUG
To: Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Busch, Keith" <keith.busch@intel.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Frederick Lawler <fred@fredlawl.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
Cc: Rajat Jain <rajatxjain@gmail.com>
References: <20180508230148.121852-1-rajatja@google.com>
 <20180510233912.96454-1-rajatja@google.com>
 <CACK8Z6H0PE-xBiNxhS+-P=-SyqAzKQi87xQoLGzgh6sgyt8zGA@mail.gmail.com>
From: Sinan Kaya <okaya@codeaurora.org>
Message-ID: <d856a2c3-2f75-8e79-f791-d5c0787a9018@codeaurora.org>
Date: Sat, 9 Jun 2018 19:49:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CACK8Z6H0PE-xBiNxhS+-P=-SyqAzKQi87xQoLGzgh6sgyt8zGA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, May 10, 2018 at 4:39 PM Rajat Jain <rajatja@google.com> wrote:
>>
>> Currently, the linux kernel disables ASPM when a device is
>> removed from the kernel. But it is not enabled again when
>> a new device is added on that slot even if it was originally
>> enabled (by the BIOS) when the system booted up (assuming
>> POLICY_DEFAULT).
>>
>> This was earlier discussed here:
>> https://www.spinics.net/lists/linux-pci/msg60212.html
>>
>> And some suggestions from Bjorn here:
>> https://www.spinics.net/lists/linux-pci/msg60541.html
>>
>> This patch picks up one of the suggestion, to remove the
>> CONFIG_PCIEASPM_DEBUG and thus make the code always
>> avilable. This provides control to userspace to control
>> ASPM on a per slot / device basis using sysfs interface.
>>
>> Signed-off-by: Rajat Jain <rajatja@google.com>
>> ---
>> v2: provide function definitions for !CONFIG_PCIEASPM case

Reviewed-by: Sinan Kaya <okaya@codeaurora.org>

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
