Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AIpwx489/645vwdcCWDDA3tvffqxgsfZ+Zr5VLHoe6xDJx+hAsvpY8HZA7+RoV2ibHqB8Ivq5Hf3
ARC-Seal: i=1; a=rsa-sha256; t=1522270549; cv=none;
        d=google.com; s=arc-20160816;
        b=Br1IocsXNiREprEMbTd0lpPox6nDrtBxySleE09kWBYf343XrkNYsc1pijzrYeGvQZ
         2EI5IqOUB+913D/IXnlNbGZygpo4zcDGM7FeuykYhy7t0N9zg/dQuHcwqqMn+Py94KIn
         qS4KATxWsG7wxxLW73TG+I/DukVQYEyKs13qaUTZp03qazXYur7YB8QHsMNxARx9++13
         Wo8DDccvmZt8ax/7Z739g4bjhAMMDxt6yt+Rm5Btrfa4TsSCfpfwBce4BbcGTiEmjs0N
         Hsm1bz3goSuu9M3/CWrqTNnA67jfhH5aEH/IkbdunSf66WViUi2Klsxerh2oqtjuP7xc
         9FEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=DHHpKg5nmUBys2PKEGZBlZETKgiwhAMFjz+r96ltMJw=;
        b=WRAawvgbF3K6X7PSqLwU2yYDM9egKERY61fgCUOlGJ7cUk7W4YY2adc82QslAehlS4
         bHn8tYursv91PKCcxSsfPAUACidDLojonT4iGEyPo2ATVBACRPSTsn0YMr84cCYXGXW5
         xzswOz8sCTWyftw9Hfe5MyvlGXTfFsE6LX6aZfzK9f0ggxLF8qk++HC97rx+0Ouzae8Q
         lIwNG1rSQTdPOvxqvIp/i2OO48ajG668eEcaLvOZhz/Pg+s8NVDv0DQH93bLtoCcomDf
         SN4VEiPfJwzTV2kLYy92VQZw1ULBtLDTF/OX8pHg4sDnPBPwiIqrVCkcNupW7nhZJOOc
         GzEg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752828AbeC1Uzi (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Wed, 28 Mar 2018 16:55:38 -0400
Received: from mga02.intel.com ([134.134.136.20]:11086 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752090AbeC1Uzh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 28 Mar 2018 16:55:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,373,1517904000";
   d="scan'208";a="37661512"
Subject: Re: [PATCH v12 07/22] selftests/vm: fixed bugs in
 pkey_disable_clear()
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-8-git-send-email-linuxram@us.ibm.com>
 <dc5ee0c8-afe3-78aa-001d-7b49b398337b@intel.com>
 <87muys3p2v.fsf@morokweng.localdomain>
Cc: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org, mpe@ellerman.id.au,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        akpm@linux-foundation.org, benh@kernel.crashing.org,
        paulus@samba.org, khandual@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
        hbabu@us.ibm.com, mhocko@kernel.org, ebiederm@xmission.com,
        arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <34fd1ae9-9697-ac6c-d6bc-7c25b4515a25@intel.com>
Date: Wed, 28 Mar 2018 13:55:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <87muys3p2v.fsf@morokweng.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064680200522222?=
X-GMAIL-MSGID: =?utf-8?q?1596216363759401557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/28/2018 01:47 PM, Thiago Jung Bauermann wrote:
>>>  	if (flags)
>>> -		assert(rdpkey_reg() > orig_pkey_reg);
>>> +		assert(rdpkey_reg() < orig_pkey_reg);
>>>  }
>>>
>>>  void pkey_write_allow(int pkey)
>> This seems so horribly wrong that I wonder how it worked in the first
>> place.  Any idea?
> The code simply wasn't used. pkey_disable_clear() is called by
> pkey_write_allow() and pkey_access_allow(), but before this patch series
> nothing called either of these functions.
> 

Ahh, that explains it.  Can that get stuck in the changelog, please?
