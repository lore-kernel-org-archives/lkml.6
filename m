Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsy1XvLePZaShZ1kV3Ljn3mQIuRCTEYYNdWM5H4opZ3rMkdeVVthrUHHccQEvAO50GneDw7
ARC-Seal: i=1; a=rsa-sha256; t=1521239078; cv=none;
        d=google.com; s=arc-20160816;
        b=R50itxqpI94OzYHCYCHmlnGhAHKKhtxuBNZgT3fa2E3SSl+mLMJNfvMHGQBmOqH39i
         r5ER3HFnFbvT+Zbea3Xtu5wzMtfW3/cqoJbabNXDugzu3zmSanDSwjAIC+o/VqPLDPM1
         6AHA776R3nMgUwvXw5oEm+PQtA9trkKsLMxmxwAET/t7XqvQEYLoOQRXsJlK9HmiLnbn
         SnnH//Wh29ifGE1BIQ36wcQCbPSr4h0n8hilVCKmaX713Pd2Gzq0PMvrm3e+uHhydWgV
         yy4w/4k+w82ovRehKdwp9ErQE716SuMPsc66yUlLE9oAQqhMWwnoJrnvJX5/Ojfe6tl3
         N5yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=ZSE2ZxyymCPUKR9zVvgZFq7Zpw27qsbQ5Ia2GciHqQU=;
        b=C9UwgbtRYcZzwsSF8lrUAD9ihB47FGD7rkGT/pYNV52WbfA2h2rjrgPLyRfx0LG1aR
         vX8TvaG6bRensga+e+cRyiJIMVZDG0IEuTHKBUOnPu0HBsY9aaC0R25FzNr4plJNTzSy
         JlnlJb6mE74lhOALhss2wdoTy8q95H7lp3ErXF8XLtDNcZYoC01iDGlK2m4Cade92IJS
         CZakzocYrh0xci4KhnDVaPlLPolYzt1Cd2yIam2y3vVxm7UpITmE7JQzeWtAKkxi2S6T
         8UyTffCS1pPuaeV0H/U59cxrG/3rwYW+idYfwoTlwVKxBMGnkahxFKEEa4j1qBeGWWWM
         AeIg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeCPWYi (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:24:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:37971 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751448AbeCPWYh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:24:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25372140"
Subject: Re: [PATCH v12 14/22] selftests/vm: clear the bits in shadow reg when
 a pkey is freed.
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-15-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5622aacf-adc6-e547-8f36-9a43f830c29b@intel.com>
Date: Fri, 16 Mar 2018 15:24:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-15-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064595048468921?=
X-GMAIL-MSGID: =?utf-8?q?1595134788115750336?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> diff --git a/tools/testing/selftests/vm/protection_keys.c b/tools/testing/selftests/vm/protection_keys.c
> index c4c73e6..e82bd88 100644
> --- a/tools/testing/selftests/vm/protection_keys.c
> +++ b/tools/testing/selftests/vm/protection_keys.c
> @@ -586,7 +586,8 @@ int sys_pkey_free(unsigned long pkey)
>  	int ret = syscall(SYS_pkey_free, pkey);
>  
>  	if (!ret)
> -		shadow_pkey_reg &= reset_bits(pkey, PKEY_DISABLE_ACCESS);
> +		shadow_pkey_reg &= reset_bits(pkey,
> +				PKEY_DISABLE_ACCESS | PKEY_DISABLE_WRITE);
>  	dprintf1("%s(pkey=%ld) syscall ret: %d\n", __func__, pkey, ret);
>  	return ret;
>  }

What about your EXEC bit?
