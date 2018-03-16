Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELtuAGC0iHTzbYMI3LI3xWbOKQpSEfM7izELUjMXBYiV2VNtgnlkYZBiZH+8F4bXz1cKHbER
ARC-Seal: i=1; a=rsa-sha256; t=1521239717; cv=none;
        d=google.com; s=arc-20160816;
        b=cdOeZl4r6aTe9c6fZ9Qc6hcluxU1eyZJH+WYMygIjhLZjHaK7VpM6+G33Rc7cq/JvE
         ecAcOfW4+EeZMv8h7DtHLlWlVFm3pFg/ckRSui46XbXsdlFTTqwYRPX06Avv6i2/cJ1h
         F2xTOIFl7hV4f6/XYIW4I7jh99iTgcWhiUFwplJGQCA8vL4jDdoBlCo75ctWWZWUEkez
         /mEcCphl6M1D0EmUZBDNO05j9Xbhs8ghsgldIiDkHmk7qYdOpAAXQcNUAQ0RLmfqGMHp
         i5drR8nZrm/r9Q/rDHDrawYBYeHPsHrEjawVEQnTu/Rhj0gRnAG9j8rJGmMNwEOGjSEg
         5m6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=KYhJ4ka6hBkvj/cFNgRl1TES2HKIi3cF8nLDGC2UhIE=;
        b=XkOHQ6yyuasAxBuEStIe3dhrWrATXjXhB2FNYzOf2rLxDuKG2PDwppGjITkxfi1d4A
         dSkgoJ9DnwTrgHxaySJw+Z0fv5h2ZwCjChCMnULtH8tc0lp3KsU+GAmuP0H19Z6S9Gk1
         XozkvZIyrL8ha6l+bCCHVqksbjPn0Y2g6Iiy38ZSzkHcslYEXdh4Bh+kY1HZfL8L7qdl
         icZEaoBzFxu0g7pcP/96pxGBYiylleCqSMpOZobLMufyzmK1hAeBpotm5boJYklMqi16
         A/YF/3Uj2arqvqW6fBtgo7uLLSoP0RNRPIOTKFxb8LYXchIRtB/MDfWhgJ3+K3mtVwtj
         hy7w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752374AbeCPWfC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:35:02 -0400
Received: from mga12.intel.com ([192.55.52.136]:54867 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751969AbeCPWfB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:35:01 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25373747"
Subject: Re: [PATCH v12 22/22] selftests/vm: Fix deadlock in protection_keys.c
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0c82a148-3f10-66f4-a7d7-cace557ff038@intel.com>
Date: Fri, 16 Mar 2018 15:34:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-23-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064461610258751?=
X-GMAIL-MSGID: =?utf-8?q?1595135457653036474?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> 
> The sig_chld() handler calls dprintf2() taking care of setting
> dprint_in_signal so that sigsafe_printf() won't call printf().
> Unfortunately, this precaution is is negated by dprintf_level(), which
> has a call to fflush().
> 
> This function acquires a lock, which means that if the signal interrupts an
> ongoing fflush() the process will deadlock. At least on powerpc this is
> easy to trigger, resulting in the following backtrace when attaching to the
> frozen process:

Ugh, yeah, I've run into this too.

Acked-by: Dave Hansen <dave.hansen@intel.com>
