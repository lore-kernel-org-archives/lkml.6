Return-Path: <linux-security-module-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-467088-1527098236-2-5744283114007593800
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-security-module-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1527098235; b=M19UPT47qESiFyVV4TpF2yW6qFVlkSvtUhEkkS9KF4X04zG85J
    rIWXFW9z9vKeicUrZB9yQyyUMPP5vdpdVgGPVYKPLxqsgzSfBGdPRN0X89NmaL7v
    ulMtUy8UMpCs8IAFE7nsU21ouAJDroR5d/wMWKg2RRczJ7ByZS5MA5yZnd8Sj9Yp
    1BwXylO8tdiu/u8fi8PdYUsKzDgUdW6Acg0QaaqBEPAS9B4+Q/zfUK2a9LnjeGd9
    sJye0ksd2c32Uy5/pKLfcJIMEcf5N+Fg7/zg8yBUFCs/C2Cq1sDjJ+SI/Od7Hgdb
    BhwIdLjqYFhJjzDr8xTm6CDxj8HE82tKLrGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1527098235;
    bh=LKo4x1ui2oG7Vqv5M1bSrISHX6/QdTZZBuXElD/j7uA=; b=ndclOkKfZIy+
    x4BGZwJuSjWu+xikkMQFomydEJA8ysXYYYZz3wawZtoGgXwT8Orkw2AAPfWMbYdr
    9UqXhCAqzKPOe36c4kCkcQ2tenl+UYAzNrrIZeTJ1W+bHXuF0/iqr8blkQ7IWolI
    75tR3+UYO5D4PO+mQOe7CA3KyI0SgPiCNMTMODXRxXCC+/aOZQiAC6aVYjcRVVCj
    qb4ann0FI85hoZA0m72fRKEZai/LeaWublWxemMra3Fq8ppM1QNvOhxPk56Zppoo
    fEiqJ/AVthf9aQViMoVWik3wLVEd0u0jSbeBCN1MIW7ujw3R+OZef8e0rynKP+Cv
    iVxNp2bhag==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=intel.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-security-module-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=intel.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCRgDz+Ntm04+qbgm1vJunEFKSJXpre9Qei1wzNUf9ZbmpnhkZ8/6tOZjEtG8F4DRvTNRPjoPggWvlmR4iQ7WQhLNxtmbEXQEsQpsYiVPKD4HCsqD819
    xE/3+88jXZEoR38R3MZnm3/tGEndgOc+Z8f4Ft1JD+KVtmZSA2nZnDep7KU4vD9S5WXLesjKoWegg/fCQuuhJ3KYiWgK+kFKw1X1fk0h817K5WXtuCVYVtqR
    Ft+HmDFdGwZuzdpuAZLI8A==
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=YG_GpJ4tajcoB6vf054A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933343AbeEWR5N (ORCPT <rfc822;linux@kroah.com>);
        Wed, 23 May 2018 13:57:13 -0400
Received: from mga14.intel.com ([192.55.52.115]:49589 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933287AbeEWR5M (ORCPT
        <rfc822;linux-security-module@vger.kernel.org>);
        Wed, 23 May 2018 13:57:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="58435901"
Subject: Re: [PATCH] tpm: fix race condition in tpm_common_write()
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc: jgg@ziepe.ca, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
References: <152701036671.19968.17347263774570787595.stgit@tstruk-mobl1.jf.intel.com>
 <20180523132318.GE363@linux.intel.com>
From: Tadeusz Struk <tadeusz.struk@intel.com>
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
Message-ID: <fb9c3d0c-d6fe-25ee-6452-92ade053c75a@intel.com>
Date: Wed, 23 May 2018 10:57:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180523132318.GE363@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: owner-linux-security-module@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/23/2018 06:23 AM, Jarkko Sakkinen wrote:
> Ouch o_O Do you have a fixes tag for this one?
> 

This one is quite tricky.
The original bug was introduced by abce9ac292e13 (tpm: Propagate error from tpm_transmit to fix a timeout hang)
and the code back then was in drivers/char/tpm/tpm-interface.c file

Then there were two other commits that moved the code around:
afdba32e2a9ea (tpm: Pull everything related to /dev/tpmX into tpm-dev.c)
which moved it from drivers/char/tpm/tpm-interface.c into drivers/char/tpm/tpm-dev.c

and last one, ecb38e2f521b0 (tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c)
which moved it from drivers/char/tpm/tpm-dev.c into tpm-common-dev.c

I have no idea how to tag it. Maybe we can use:
Fixes: ecb38e2f521b0 ("tpm: split out tpm-dev.c into tpm-dev.c and tpm-common-dev.c")

And then it probably needs to be back ported manually all the way back to abce9ac292e13.

Thanks,
-- 
Tadeusz
