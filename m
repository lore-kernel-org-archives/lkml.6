Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuFfQLkOpU56OFqd2plUNUtkkTTAZtpocKazz2uglGvjV6WM3Ul6W1lGWm5RahJXKLkO24K
ARC-Seal: i=1; a=rsa-sha256; t=1521239019; cv=none;
        d=google.com; s=arc-20160816;
        b=D+NZIU2Fgm0HeeQ2tXIm17IBG3+1GPO5xuzvrNFswxtUs9HDLMFgzyrSK4MQs3Zuok
         3SMEtSPwilR366yII2FMbbWioJXbvypAak3SYaxjrvpz6T/ovESP99I5k++s+f1KOv+2
         SOAUD+ihCuGtaAGBhyC6ewwdDaxqyKMeF3LGnhwxHixH/hPZABU7c1ifAHSt/7ha0hyp
         h86FYHkEZizz1WyoXka4shi1xSUTTz87GdkBj0WQj2s5uuOYM/wq8wrqJpMMll7vawyS
         hI9wv628s2ZZeKXChqPXpar6CFqfZc/M8KN0YgLBN2W0fmVXX4AEfu65YPSYrw8svlXI
         rcIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=TDd4zi4OE2JT3vqVbjjwjsW8Iu0nGnOqPz7qgmDIG3c=;
        b=0FdtLxQZbUnsCCmfqrQs67sWfK1yHTA/hfPvLnGYWvTciWEldVk4QBiQmFzzwlUqN3
         A+8fH/EqFJMfBFBOCbTS4MXiu8+GQz+5hWeJVHIRyEni2hLvLBPLFO2HgGxJEZ1yY0Am
         sR9t9l9JzcmiTNqqrBgILWp9gzwDj1QPugG3eE3jCBCn0/uq4nsJP13SFYNNd39ijYMs
         6n7+kCX4fMEfPpCXccSWHKZNT2/ciKmhhHgfYKxsFVLzb9Kvvqwh5JVvaqyFyNprF5Iw
         au0pzZB4JCmIEf/+QEAA5xrcc1BmIb7vOadtRzWqkXgnsowkQuQBXauMB2fepXM5phje
         P/1w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeCPWXi (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:23:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:37918 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751372AbeCPWXh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:23:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25371971"
Subject: Re: [PATCH v12 13/22] selftests/vm: powerpc implementation for
 generic abstraction
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-14-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5e27e966-d1b9-e56d-45cd-43524fd4448c@intel.com>
Date: Fri, 16 Mar 2018 15:23:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-14-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064599281442992?=
X-GMAIL-MSGID: =?utf-8?q?1595134725868386565?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
>  static inline u32 pkey_to_shift(int pkey)
>  {
> +#if defined(__i386__) || defined(__x86_64__) /* arch */
>  	return pkey * PKEY_BITS_PER_PKEY;
> +#elif __powerpc64__ /* arch */
> +	return (NR_PKEYS - pkey - 1) * PKEY_BITS_PER_PKEY;
> +#endif /* arch */
>  }

I really detest the #if #else style.  Can't we just have a pkey_ppc.h
and a pkey_x86.h or something?
