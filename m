Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELsbO9WYF6fdok6RqOFUFMrjFro/iONFzuyeLF+JMvwPmR+zxTwQAPYMqZAhVrsesK8jQVb6
ARC-Seal: i=1; a=rsa-sha256; t=1521239476; cv=none;
        d=google.com; s=arc-20160816;
        b=mJhhUOLzKzhHGPYCDjzh9rDUx9FoEK0wtA9ljJvFo4B8fhHtjHTy072Uz4yWudAwGB
         UlVf0CEjcv8TiZwlitYVIdoqS7xThzPFkWOj0+GtpY+FzwiXl4Hc9X/d2clk6gY68y8g
         WRHVT6B4YLmeQ4D3u+NZd/M6X7wnQiPnLGIOjaUmqgeud5Cwz8mkJicAjb5y0Ngq09L2
         UO9Sca6vz1kRRoedOCm1HDcWYWw9Vk5q5g9VH5X7ZwuD1xiCFA/OVZGNFEdgrFn6l/es
         OO+J3QtNA8WAT2TAtHMBuqRTothveYsT8xlF9vWRwo14D3tVFF7/TXEdm48LApq/JVoB
         yz8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=q+Uk5vdE/lTZXwU+ST92oekpZqJWcV9quMZLzFkXuBk=;
        b=HF+LfspIg2UwhTRH8b3lzZJvfc66svyl94yNqdI6/qO8pZcu7Uwc5WAEMwAj1CaGlK
         7B7t042+Wl9lW8k3JkEjK3tTEDkoUalMcVaNL5gWtogXU3vVChs0UilJEWmHewb332T9
         aMw9cuavP87Wq/JferLywvJHTbz0/wnx/Pk5WuUAVhAmbIUlxM4swuLiSGsESqah2+aT
         Y6Fre3V94ZDi4Jfjt79vPK+vrCymBxHoSKNwCst5REvVKHJq3u0rG5np1VeDkoOs4Aw1
         hF4Aq4LQZonTMvFE0NDcEZe3aPNCEw5kOAwEwRlcYkCkzi8jD7olw8HTNtDCZx4MPREq
         O8jw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752731AbeCPWbC (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 18:31:02 -0400
Received: from mga05.intel.com ([192.55.52.43]:37439 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752618AbeCPWa7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 18:30:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25373233"
Subject: Re: [PATCH v12 18/22] selftests/vm: associate key on a mapped page
 and detect write violation
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-19-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <cf9ccf32-724c-e25c-4226-3c9c670bc4aa@intel.com>
Date: Fri, 16 Mar 2018 15:30:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-19-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064566016800488?=
X-GMAIL-MSGID: =?utf-8?q?1595135205386151603?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
> detect write-violation on a page to which write-disabled
> key is associated much after the page is mapped.

The more tests the merrier.

Acked-by: Dave Hansen <dave.hansen@intel.com>

