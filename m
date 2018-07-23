Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C38FCECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBE420856
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 22:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EBE420856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeGWXDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 19:03:37 -0400
Received: from mga01.intel.com ([192.55.52.88]:5927 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388137AbeGWXDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 19:03:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Jul 2018 15:00:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,394,1526367600"; 
   d="scan'208";a="242674460"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.153])
  by orsmga005.jf.intel.com with ESMTP; 23 Jul 2018 15:00:20 -0700
Subject: Re: [PATCH] tpm: add support for partial reads
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153201555276.20155.1352499992826895966.stgit@tstruk-mobl1.jf.intel.com>
 <20180723201956.GB26824@linux.intel.com>
 <fb053916-f6e8-3266-14d7-128e062b6a92@intel.com>
 <1532380412.4112.22.camel@HansenPartnership.com>
 <7441b5ef-18d8-13aa-ef4d-40fe684c9218@intel.com>
 <20180723215620.GH532@ziepe.ca>
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
Message-ID: <dabf6cf5-e62c-721f-9f19-18da34d52ec1@intel.com>
Date:   Mon, 23 Jul 2018 15:00:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723215620.GH532@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/23/2018 02:56 PM, Jason Gunthorpe wrote:
> The proposed patch doesn't clear the data_pending if the entire buffer
> is not consumed, so of course it is ABI breaking, that really isn't OK.

The data_pending will be cleared by the timeout handler if the user doesn't
read the response fully before the timeout expires. The is the same situation
if the user would not read the response at all.
Thanks,
-- 
Tadeusz
