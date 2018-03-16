Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvVA928Do1xeokyOzUoNfAWCisE7stoLMUdpNZEAyPXZgWt44WeC8bu0YlDYh0rwOxaMztl
ARC-Seal: i=1; a=rsa-sha256; t=1521239309; cv=none;
        d=google.com; s=arc-20160816;
        b=smtXgRyA6MNcZuv/Ofvbwh3LamRoq3HVyZYC0IaL5RLIpZ8AVWUvWS/3cg7w5NFxiB
         xxcBm1k8sNzeuxmWOr77sHRtIq/XOj59J24J6/4NUPLUYvstvrojF9OtbNGnbSDAOk4m
         /cVAiHQobhLj2ThVMxI2kGZB35TA9Vz9gmcS73m0+/myD10D6QHaGnzEC/prZ0kESzDz
         6NQQzAWmJEpRyoAZIYNowkE+LcicU3kD62f/vbXXw2TpeNAurduixqTxMsIVzAXuEXBL
         ww9YSPjkEyE+YsyVZ5MNOzWAsBo7tHbqOYh+xdI/BlntanhGNoWIai1jfin+cYUordnb
         ckMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=scYGEetoYdjg4RxdVrRWTZYS5SCmdVAxQYQNw0Icf70=;
        b=KTJc+64eOw2TKdgR/Y5i6wlDCFj77pRk2UZMO0ucji2FQu7z2h4tJaEoGfcwnqdyk5
         hkv51fNo/me5ZuyG8giM6GEhcVS5zuXq6vIgGba02ChO4mxPxiC6mNLiZJ+bDqtToW2S
         Uf60aNGC56BePaMwR5PCzIfBiK5iFTFk9WCrRr8qpx98IlAzLf7l9lo4oIrxlztTE4R5
         d4slkbvYWYhbVqprPe+A9cn62rBOb8tlJqlKsz6x+Gv2emyIJx3ZqSJnUU8S0uKKcRad
         +QmmVDhWlyHSMx84bxq3GBkVTWaZVC8J1HXhGxJmHyBFW3w7HPavQhiReAxrqAthAcs6
         et7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751562AbeCPW22 (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:28:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:51360 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeCPW21 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:28:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25372790"
Subject: Re: [PATCH v12 16/22] selftests/vm: fix an assertion in
 test_pkey_alloc_exhaust()
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <98204562-7c91-23f0-101b-508954020353@intel.com>
Date: Fri, 16 Mar 2018 15:28:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-17-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064512550172050?=
X-GMAIL-MSGID: =?utf-8?q?1595135029900884582?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> +static inline int arch_reserved_keys(void)
> +{
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
> +	return NR_RESERVED_PKEYS;
> +#elif __powerpc64__ /* arch */
> +	if (sysconf(_SC_PAGESIZE) == 4096)
> +		return NR_RESERVED_PKEYS_4K;
> +	else
> +		return NR_RESERVED_PKEYS_64K;
> +#else /* arch */
> +	NOT SUPPORTED
> +#endif /* arch */
> +}

Yeah, this is hideous.

Please either do it in one header:

#ifdef x86..
static inline int arch_reserved_keys(void)
{
}
...
#elif ppc
static inline int arch_reserved_keys(void)
{
}
...
#else
#error
#endif

Or in multiple:

#ifdef x86..
#include <pkey_x86.h>
#elif ppc
#include <pkey_ppc.h>
#else
#error
#endif
