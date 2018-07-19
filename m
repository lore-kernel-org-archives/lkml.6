Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13A1C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 701C02084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701C02084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731962AbeGSQji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:39:38 -0400
Received: from mga14.intel.com ([192.55.52.115]:8555 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731524AbeGSQji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:39:38 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jul 2018 08:55:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,375,1526367600"; 
   d="scan'208";a="246609688"
Received: from mldahl-mobl2.amr.corp.intel.com (HELO tstruk-mobl1.jf.intel.com) ([10.254.107.75])
  by fmsmga005.fm.intel.com with ESMTP; 19 Jul 2018 08:55:39 -0700
Subject: Re: [PATCH] tpm: add support for partial reads
To:     jarkko.sakkinen@linux.intel.com
Cc:     jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
From:   Tadeusz Struk <tadeusz.struk@intel.com>
Openpgp: preference=signencrypt
Autocrypt: addr=tadeusz.struk@intel.com; prefer-encrypt=mutual; keydata=
 xsDiBEiLICMRBADteQacQxypsuFvAw6IwYzbD8pgQi+kLYBcqfGgVAUN/cO+sLl6u1lVdaDB
 fhAArdbV9lpoqcWnmhQFTb4A+W569EpydBr6nuatWkEB+fmmx8YoUtuZfXt7v+1l1rc09kaW
 LY+TkwQkvFCeuvdasgmBLnmRWymEGWi1E12hUgTw/wCgtK24geC7XkiuANMv0gpr+raOgQMD
 /2yJZ0SeXQApWyTRaeIYN8GgYHZTWuBp/ofN+viEkhrDxahcaGPP5B/Nv6VS1+M0e5m8OzHj
 qPUbgfyOeJcslC5aoZdqqqzVWVLaA/+Jy+O+6T3k3R/IryVVATldBlwnGFDhET0mKQsd15zt
 cIdQBBbfSFR5VlugZuWV5q442IpPA/4g7nen9FFPxh45Te8D54hAsOCywjm6xUE0UJGYHeJ/
 MXCPtuXfVCbYcOxZVH7kUS2Vtk5d3bF40IE2WnVq1ZScNANF4ZjikxYhYGfNWX3HXak1gSoj
 UrY87rMSjPIAry4L0BoIx2qgL/k4iV/3QcXL4t5wosU0iw++suf1zGGcKM0gVGFkZXVzeiBT
 dHJ1ayA8dHN0cnVrQGdtYWlsLmNvbT7CYwQTEQIAIwIbAwYLCQgHAwIEFQIIAwQWAgMBAh4B
 AheABQJQTjJTAhkBAAoJEDFswfskq9xyqvcAoI2nsaUCX8ZGbu+Jhq+++qlBFJ2rAJ983RoO
 R2ofHhn3g3Qi4K34tw0l087BTQRauzUlARAAqkWRL/InEPnoGMg/gw/CRaDBaIBgMsvIcghI
 7xevIzpleXt6jKHghSBooH+zaT7qi4u2gkgPn4odsER3Rm94XgrZJgoqls6EpKMWpJNGP4HT
 eYgykhfsZOLX8ijUbjTM/Sm/dZVo6aYoBL2+ciJwyl+Zt3Mp6un3/GWu6cA9005V50pRqO7j
 PTlVCHi2bedcEEf5DDsYJv/3Oz8/4LpSf6BL6BltjeZVa2y03dTMmD031JTH+OuyJm1yh72Z
 HWxhlYNXOv6uFJJVr+paQjrAsBVIYKhK24bD+uGJxLm8AN9i7/Si+2YeSsXvKUhk9mIoFBnU
 VFo63cziRTcpRu/kXgDAbujwN88qytEcvhEZHS6B9vdws+lhTpolEjkLCkz0Y59z4Fs9srKy
 QkRN+wtdiLgrwyDW3ryAKxcDmOumGWebDxpaOI/pBhrlS93HmDlvj7JmgTUU4a/NhwI3dXh5
 pn8FZzZyVXe3Kc3bu5T3UAC7uztinsAvCJQS6jGZWrXmXkqYkaLXQOw61eInWjr01zE/zDbE
 mdJPM0+va/gtZx9TtGxr4PpjbqswqCiubLDZXZHh5uqArPv/i+E8aXIsNSTN6Rrqs1j9YgDN
 ALksibv6+tXH3sOlCUgjuZgJH3+s/mnaAtiV2rZ/WlH15d6nd0uiDSZrKhlR+g4NHMh1ztEA
 EQEAAcJPBBgRAgAPBQJauzUlAhsMBQkJZgGAAAoJEDFswfskq9xyfv8AoI8aPrJCoM0h5WOP
 kKxMmPEPHzUNAJ9jBBYXhX1CWg+IhI7i/fLlI0vwCA==
Message-ID: <5984eedf-792f-2d8c-be7a-143ca570592a@intel.com>
Date:   Thu, 19 Jul 2018 08:55:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/19/2018 08:52 AM, Tadeusz Struk wrote:
> Currently to read a response from the TPM device an application needs
> provide "big enough" buffer for the whole response and read it in one go.
> The application doesn't know how big the response it beforehand so it
> always needs to maintain a 4K buffer and read the max (4K).
> In case if the user of the TSS library doesn't provide big enough buffer
> the TCTI spec says that the library should set the required size and return
> TSS2_TCTI_RC_INSUFFICIENT_BUFFER error code so that the application could
> allocate a bigger buffer and call receive again.
> To make it possible in the TSS library this requires being able to do
> partial reads from the driver.
> The library would read the header first to get the actual size of the
> response from the header and then read the rest of the response.
> This patch adds support for partial reads.
> 
> The usecase is implemented in this TSS commit:
> https://github.com/tpm2-software/tpm2-tss/commit/ce982f67a67dc08e24683d30b05800648d8a264c
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>

This needs to go on top of this:
https://patchwork.kernel.org/patch/10460863/

Thanks,
-- 
Tadeusz
