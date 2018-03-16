Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELu/djYmrpH5zuCPcLt8qX2r0fOYl/RYAOLThQ1MlsOCCus3Owq8pJRIBuwyEYBnHkcyPG+H
ARC-Seal: i=1; a=rsa-sha256; t=1521239179; cv=none;
        d=google.com; s=arc-20160816;
        b=rjfAMGW4pbYqucUBfOSpga04cAKxMMfXxAmAXVvwZ+H7oogLWTwwYguhxDnabKWf7/
         uCmtMZ0fw1SnxtXmIVQzVzKnxQl9x5iZmKsGJFizcXzMU9vlqxZC9+kI4xCyxyCS+re6
         jT5i0WonL3UMDiyOrVfARafMxds/1+moUbo8gn2fMVZbTPRKElEeb66Wzm+9NtzmGPk6
         +9WOX2nwlb7itljnapj2EmqAbwpCKHu4dzjZJzWdYOjZt/Bgt/zK+62ExLPQagPCzBcA
         e+kQKMFyJeKQjLIqLRU7zULtf4OKzRw+g/K/u7Pi2uJoH79FdM5E+CpEMzbK6bfr599N
         pwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=TIx5Rmdph1E5I72p1yHgie23XJq92oDlRDt5tqdy7qw=;
        b=dUScA0cgB3/pgcJw3YVpoQYU6xntC86uoLp/xV3YF/iHqCyoIACOxhRL3VNXiSp69Y
         j3dmxU41/FlfRdf9if1hZ0jBawUPz3sGrVyRP3rYs+Eedzsu3wJY3M6uF7TpEbFNzA2p
         4+HrSG1ZvdUbW+WUGZ0Ja4ivjhHXkz3kWjWzzxMhHzy1VzcifBCkEiZ76eeMH+khNRPg
         or6nAKFA9/qRwabEmQkvaZNcjNYRaMHErUk1DveUGPcIlcXxdopiatSYz0mht9fUFBhd
         kFwSvZxEAU4keBOmuWxplE4TSypQbFxtBh3YW+6IUrlVLtInVG0ofg0hxy1PtCyH0WlH
         sB1Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeCPW0T (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:26:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:37272 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751319AbeCPW0S (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:26:18 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25372433"
Subject: Re: [PATCH v12 15/22] selftests/vm: powerpc implementation to check
 support for pkey
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-16-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <dc588e0e-eda5-1267-5806-91b9b95e28bf@intel.com>
Date: Fri, 16 Mar 2018 15:26:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-16-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064575819973717?=
X-GMAIL-MSGID: =?utf-8?q?1595134894128082987?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
>  #define PAGE_SIZE (0x1UL << 16)
> -static inline int cpu_has_pku(void)
> +static inline bool is_pkey_supported(void)
>  {
> -	return 1;
> +	/*
> +	 * No simple way to determine this.
> +	 * lets try allocating a key and see if it succeeds.
> +	 */
> +	int ret = sys_pkey_alloc(0, 0);
> +
> +	if (ret > 0) {
> +		sys_pkey_free(ret);
> +		return true;
> +	}
> +	return false;
>  }

The point of doing this was to have a test for the CPU that way separate
from the syscalls.

Can you leave cpu_has_pkeys() in place?


