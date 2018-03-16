Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsVi9rkGma79SdBz+P0TQ0RihK1BbUZKP0iQFpLldwy2GKBnNl8pL4Zwc++pLiU1jbX337s
ARC-Seal: i=1; a=rsa-sha256; t=1521238409; cv=none;
        d=google.com; s=arc-20160816;
        b=yQfpZ23MT3i/faQN7dwI2UxjByHcIMRXqwWNAILCPygoFYeRdkGcY9fsp8I5kXb9hM
         wHNKM8Abu8Krqoq3+fGdipWdjLo/ZDxU+lBtAyXTUhk7kmytG8miNDv+jFAy3jAOAy0d
         AZwktemiz3zVjq77gVSamY3lMEBAv9DDVvc+5ypv9lrrKwkbbhrLZ5JUba9Qxwge0MRF
         CiJwXfEL15r8FC1P9PXXex30FmNF5JaeLiT5D/nJUmS9VPx2L1C695Et41CBx25K1wF7
         vulPzk2L9oDNHAUBrAyhY9eGLydg9BUS/Zrc7FNcQ/djwkMS32OL7Up/6h5khtOCGIQA
         VaCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=3xJDPzeHpWNo+74KGzilMrj9SnCXJVbsuj39UHmoJ1I=;
        b=TVHxsojTDc5L8V2cdjGrKh/QjtCYrmLvyQ74/FxCV2Ms5wliR2gPdofB/movntRzdF
         o9nPLucGI09UYNWsM2/N+DwGS0NV3ufxxfoQuCwCFkXQ+ngGsmpcrUSGXMVErMyqC4xk
         Mld+7vyC2IvUoHwgZb3XONuYqT6wg0aW7XvX9mXNRha2cAXjj2MfC0r/4gjqKiL57i5V
         8NvatZBGiVErHJuZlNgMNuT/RyrZcvSM6QbGVRLy94M1/T4QMUhRVtBBHH5wj3CubTaa
         n8u/QaqKiUmoQW11ER3EzHO6uFuMtsDvjaCuojrXJ0zt9RWLeAZdZTfyWV558bBv65rW
         JgRg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752216AbeCPWNQ (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:13:16 -0400
Received: from mga14.intel.com ([192.55.52.115]:50632 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750915AbeCPWNP (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:13:15 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25370198"
Subject: Re: [PATCH v12 09/22] selftests/vm: fix alloc_random_pkey() to make
 it really random
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-10-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <9e410d84-3cd3-edf5-4699-26fcc2bbb393@intel.com>
Date: Fri, 16 Mar 2018 15:13:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-10-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064660294767595?=
X-GMAIL-MSGID: =?utf-8?q?1595134086651231579?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> alloc_random_pkey() was allocating the same pkey every time.
> Not all pkeys were geting tested. fixed it.
...
> @@ -602,13 +603,15 @@ int alloc_random_pkey(void)
>  	int alloced_pkeys[NR_PKEYS];
>  	int nr_alloced = 0;
>  	int random_index;
> +
>  	memset(alloced_pkeys, 0, sizeof(alloced_pkeys));
> +	srand((unsigned int)time(NULL));
>  
>  	/* allocate every possible key and make a note of which ones we got */
>  	max_nr_pkey_allocs = NR_PKEYS;
> -	max_nr_pkey_allocs = 1;
>  	for (i = 0; i < max_nr_pkey_allocs; i++) {
>  		int new_pkey = alloc_pkey();

The srand() is probably useful, but won't this always just do a single
alloc_pkey() now?  That seems like it will mean we always use the first
one the kernel gives us, which isn't random.

> -	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%x\n", __func__,
> -			__LINE__, ret, __rdpkey_reg(), shadow_pkey_reg);
> +	dprintf1("%s()::%d, ret: %d pkey_reg: 0x%x shadow: 0x%016lx\n",
> +		__func__, __LINE__, ret, __rdpkey_reg(), shadow_pkey_reg);
>  	return ret;
>  }

This belonged in the pkey_reg_t patch, I think.

