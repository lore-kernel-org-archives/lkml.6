Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuszp5ntbwnk0wnB4kHF+xgJYNClhy5Lq71CchBJtV+eM8fmqJYY66rbnD96ZwIj4eGVWeO
ARC-Seal: i=1; a=rsa-sha256; t=1521237944; cv=none;
        d=google.com; s=arc-20160816;
        b=peyVLwzM0eTqHEB/sj1/jPxvmQamSnnR2M2+zFXQe+EcS6FFNzodfAMPEGkUNfsBSp
         S5MIP0by/F1RcHiUSlNfY8DIAdz28XM3GO98MsyeHFRP7qtCoa7oizo3w68CRzopB8uP
         TTc63b6Qrs38q9CykzyNwY3rkRsfgUeS8aQFGLdUQbQs42h4/o7yFfR/vwB9YIZkZmL+
         2P6Uz7Edk3o48PmcMd1IiKqWebeSkmTB9gSBeUjVK1bJcbsh0hN7b8Y/71/UXx5St9Of
         M1loPH/RqCPmg3Z8nktVLeyiR6Z2IY3nNnpcjj0D8v6HKqJzAtNuHhTok/TAkheWOpBS
         cEvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=Z1NIGfbaTdcdiwjkfgQhjObIRoap1s4YSuCqzzNxrPE=;
        b=RqhhRcpEqtgUIqsFaur1v46cL9MxgMjeIcf/3yx6MJyI4ciPZ+UVGh2jibxRKPK3lP
         QazKWQ/1T1Zdb8R9N393FWrIXxLm6bK0bfofwMWcrsWy1WnyL9AtpqKjZiNzhMprq9Ri
         CwirUWnmtM+Gqq3plOymMmCYtVBZL7Cs7IieNM2IygMShN7zcuAjoKjVyKx6iFNKVyky
         f0PmR9enn6itGNaqSOiUxGv4lapzKmBhQ4R9NtVJNX6uT02DnvcSXym8zgfAe9lfc0xu
         sYATjseEB3X1kRRlw06MtYC2zA18Ueo60KN3GaO1uLqwz58wuvG0Z0DE5ka6YTptbYoJ
         DaaA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752327AbeCPWFc (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:05:32 -0400
Received: from mga07.intel.com ([134.134.136.100]:52588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751753AbeCPWF2 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:05:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25368952"
Subject: Re: [PATCH v12 05/22] selftests/vm: generic function to handle shadow
 key register
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-6-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <92951c0a-0468-6d3c-efef-2d9da53fd10f@intel.com>
Date: Fri, 16 Mar 2018 15:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-6-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064730361349989?=
X-GMAIL-MSGID: =?utf-8?q?1595133599741100110?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> +static inline u32 pkey_to_shift(int pkey)
> +{
> +	return pkey * PKEY_BITS_PER_PKEY;
> +}

pkey_bit_position(), perhaps?

> +static inline pkey_reg_t reset_bits(int pkey, pkey_reg_t bits)
> +{
> +	u32 shift = pkey_to_shift(pkey);
> +
> +	return ~(bits << shift);
> +}

I'd prefer clear_pkey_flags() or maybe clear_pkey_bits().  "reset" can
mean "reset to 0" or "reset to 1".

Also, why the u32 here?  Isn't an int more appropriate?

> +static inline pkey_reg_t left_shift_bits(int pkey, pkey_reg_t bits)
> +{
> +	u32 shift = pkey_to_shift(pkey);
> +
> +	return (bits << shift);
> +}
> +
> +static inline pkey_reg_t right_shift_bits(int pkey, pkey_reg_t bits)
> +{
> +	u32 shift = pkey_to_shift(pkey);
> +
> +	return (bits >> shift);
> +}

Some comments on these would be handy.  Basically that this takes a
per-key flags value and puts it at the right position so it can be
shoved in the register.
