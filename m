Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvY3+7P/aSlzDzlsybZ4PPvzroy1xw8Dd50+vgkCT+UlTjrDew/KKSZ/jSy3MxmNDW4X4W0
ARC-Seal: i=1; a=rsa-sha256; t=1521238014; cv=none;
        d=google.com; s=arc-20160816;
        b=wrqX7jv47/b8TosvOi39fzE9lQ3TNdKC/gAbenzb5MLjaGyZAxvWKWD3+FvDYp47EV
         Xs/ozenlAOxtY9TwHlZ4axlQlrv9hZk5tM8/5uwxBwAV0XFt8iOgsDmZ+SU860JtPu9I
         baOQmaWnngSZ/6CVuHnXfZuMXAZg42bBF4tzFvkUp9SJZd7dRa/IxgXsKEMTxD0MOf/w
         WfeegUan6H4g4Wr4Xr4CqPx7FsTzfsqBxVWth32QirpABP9N0JdI5NQmdn3MPxOnY01U
         5wqzrMPLPTdmcHDy7prEx/zAxgXfEYYTsNKkU5B+W5PTS/+nmUztdkNwdVj5y/4InH2w
         zwjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=WgTbGji2RSMZ+2GnZTEAEQpPZNN+RyP3IIi8GbgxWlM=;
        b=vQuGWJfHQllEIoV8ShcQRNk/k7aHG39H9Mhuh/MbKQHGPy7uTYvrvWZBobXtyzd1SO
         6do2jLWpwIo6KAqvcjYcDRGE4Bv1kqjEo3Dd/XJmt4hhq91wRMNCnD9VwHFHW4a2qDAx
         7/RVZLmZoePL4oTyjZFL6KVgk3lnwSfPuqy6wbcQI6IrymOWtK/hrxRB6LbYYQCbUOUw
         bGsBByWwbx17KWVZgH477oFp3oaecJJAWThAiOlTlOPmAA64K6Z/MSwYiWrGtZhAuYNj
         OGFMjLeXhgm7JsRdGDaB2omyEQVsFulpKnsOT9roAQj0IqK3qpATO8vmCNK+wPmZTquf
         0jmg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751468AbeCPWGy (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:06:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:26225 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751233AbeCPWGx (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:06:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25369307"
Subject: Re: [PATCH v12 06/22] selftests/vm: fix the wrong assert in
 pkey_disable_set()
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-7-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <efe141d5-b609-c21e-8860-c0184e167770@intel.com>
Date: Fri, 16 Mar 2018 15:06:44 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-7-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064682238197500?=
X-GMAIL-MSGID: =?utf-8?q?1595133672699966929?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> If the flag is 0, no bits will be set. Hence we cant expect
> the resulting bitmap to have a higher value than what it
> was earlier.
> 
> cc: Dave Hansen <dave.hansen@intel.com>
> cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  tools/testing/selftests/vm/protection_keys.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index 83216c5..0109388 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -443,7 +443,7 @@ void pkey_disable_set(int pkey, int flags)
>  	dprintf1("%s(%d) pkey_reg: 0x%lx\n",
>  		__func__, pkey, rdpkey_reg());
>  	if (flags)
> -		pkey_assert(rdpkey_reg() > orig_pkey_reg);
> +		pkey_assert(rdpkey_reg() >= orig_pkey_reg);
>  	dprintf1("END<---%s(%d, 0x%x)\n", __func__,
>  		pkey, flags);
>  }

I'm not sure about this one.  Did this cause a problem for you?

Why would you call this and ask no bits to be set?

