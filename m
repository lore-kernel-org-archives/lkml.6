Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 1C62FC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6627208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:39:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6627208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933835AbeFLRjG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:39:06 -0400
Received: from mga11.intel.com ([192.55.52.93]:30078 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933295AbeFLRjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 13:39:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 10:39:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,215,1526367600"; 
   d="scan'208";a="48431427"
Received: from tstruk-mobl1.jf.intel.com ([10.7.196.162])
  by orsmga007.jf.intel.com with ESMTP; 12 Jun 2018 10:39:00 -0700
Subject: Re: [PATCH v2 2/2] tpm: add support for nonblocking operation
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <152876282414.19591.7972634639749417028.stgit@tstruk-mobl1.jf.intel.com>
 <201806120803.W0vjfLEH%fengguang.wu@intel.com>
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
Message-ID: <23f79ed3-be69-2a80-b4d8-b9af8491bcd1@intel.com>
Date:   Tue, 12 Jun 2018 10:39:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <201806120803.W0vjfLEH%fengguang.wu@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 07:53 PM, kbuild test robot wrote:
> Hi Tadeusz,
>         # save the attached .config to linux build tree
>         make ARCH=i386 
> 
> All error/warnings (new ones prefixed by >>):
> 
>>> drivers/char//tpm/tpm-dev-common.c:223:1: warning: data definition has no type or storage class
>     __exitcall(tpm_dev_common_exit);
>     ^~~~~~~~~~
>>> drivers/char//tpm/tpm-dev-common.c:223:1: error: type defaults to 'int' in declaration of '__exitcall' [-Werror=implicit-int]
>>> drivers/char//tpm/tpm-dev-common.c:223:1: warning: parameter names (without types) in function declaration
>    drivers/char//tpm/tpm-dev-common.c:215:20: warning: 'tpm_dev_common_exit' defined but not used [-Wunused-function]
>     static void __exit tpm_dev_common_exit(void)
>                        ^~~~~~~~~~~~~~~~~~~
>    cc1: some warnings being treated as errors
> 
> vim +223 drivers/char//tpm/tpm-dev-common.c
> 
>    222	
>  > 223	__exitcall(tpm_dev_common_exit);

It is complaining about __exitcall here, because there is a module_exit() call
in drivers/char/tpm/tpm-interface.c already and the two files are build into the same object.
It is strange that the problem only manifests itself when cross compiling with ARCH=i386. Native 64bit build works fine.
I will simply call the tpm_dev_common_exit() from the tpm_exit() and re-spin a v3.
Thanks again for the report.
-- 
Tadeusz
