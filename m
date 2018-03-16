Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELvFgPLeo1bsNCPudA3paYapkgZh6FjJRqL4tDLAaG3H3WSizOSI843tQr6fWp/ilfxb+GyE
ARC-Seal: i=1; a=rsa-sha256; t=1521239523; cv=none;
        d=google.com; s=arc-20160816;
        b=KW9pUIhKWayHk+dz7F6JXEBZhu3UUhyAPqpkqs54BLgmFR0HFexKYfgP9RJ8tHsZGN
         9rpUt77HSdIyytx1HfpC6TzKaf1Pu3B6bN4Qj0r3l61+Du2mmiatEunxCoAozNneeIWH
         XKx0cE3CoUFxsQai60x83VbHDGHuJw5Vk6oNM/+uLhjn6PmKYkwksYugoGGoljHuAj26
         ofw9Kg96F+orqyOvRhh5G+bYfGGJTiCJa3UTliEGs3YJGIhZ4t+IhxFO5t57GhUOXveg
         qn41pznB8idgnCsP7+cRDr8Wui3pj5npLLGHas05w14H1hf7Yp7U0aPkrHZ+T/95E5e6
         bFpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=sp/8EiS+HAK/tE0aPmHn3B6BbAnzp9Kvkm/UdF9uuEM=;
        b=nxgKtbA04qtQa8yqhx8zw8gK4j14lLWCPnvvkIuSPuA9ZJ+AmPJkUzOJ5sfPorpoGd
         BvHdeMBalZfGif8KVKoM9eMb4tR3xsRcVu7qshqdi6nCgmoozC7vl5LCjROUEgCDUA2g
         Lr78dcSf0HaIqewC6PjMksv9kguWuCLvniVCeAH+qfHET+O0Z1iOcajhXCkOKEPwL95O
         6jP2UNd6yLB7gnXkdaTNni/x2ImP22iXjjBdtrFBx0ueFjhy9PRgZHwECoYSCZG3lYiy
         iqjYXxC3rIS38vu5/DvUkFD3UNMZDAdcNgPnozrHz0SZwoN8xTy9LdxM/fKQalqLAmg8
         xPtQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752541AbeCPWbi (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:31:38 -0400
Received: from mga03.intel.com ([134.134.136.65]:27443 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751586AbeCPWbg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:31:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25373343"
Subject: Re: [PATCH v12 19/22] selftests/vm: detect write violation on a
 mapped access-denied-key page
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-20-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <f0468b51-6c2a-0317-2c5e-d48d8a12c374@intel.com>
Date: Fri, 16 Mar 2018 15:31:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-20-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064488113796574?=
X-GMAIL-MSGID: =?utf-8?q?1595135254455332432?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> detect write-violation on a page to which access-disabled
> key is associated much after the page is mapped.

Acked-by: Dave Hansen <dave.hansen@intel.com>

