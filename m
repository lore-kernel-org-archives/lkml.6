Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AA60C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505B120645
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 17:23:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505B120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728798AbeIJWSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 18:18:44 -0400
Received: from mga04.intel.com ([192.55.52.120]:50166 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727764AbeIJWSo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 18:18:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 10:23:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,356,1531810800"; 
   d="scan'208";a="68929856"
Received: from tstruk-mobl1.jf.intel.com ([10.24.8.238])
  by fmsmga007.fm.intel.com with ESMTP; 10 Sep 2018 10:23:14 -0700
Subject: Re: [PATCH v5 0/2] tpm: add support for nonblocking operation
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     flihp@twobit.us, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <153419236870.8189.15489652816512817246.stgit@tstruk-mobl1.jf.intel.com>
 <20180831085711.GC12908@linux.intel.com>
 <20180831085825.GD12908@linux.intel.com>
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
Message-ID: <67bab063-e24d-461c-dacb-5c9458ef9784@intel.com>
Date:   Mon, 10 Sep 2018 10:23:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180831085825.GD12908@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/31/2018 01:58 AM, Jarkko Sakkinen wrote:
> Just the change to the commit message. Mislooked patchwork, the typo was
> in my response :-) I'll do recheck for 2/2. Check those comments before
> v6 if there is anything else.

Hi,
I have done the changes you requested and ran the "checkpatch.pl --strict"
on it and it says that "no obvious style problems and is ready for submission".
Thanks,
-- 
Tadeusz
