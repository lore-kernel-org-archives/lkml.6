Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751183AbeCILFB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 06:05:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50192 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751077AbeCILE6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 06:04:58 -0500
Subject: Re: [PATCH] x86, powerpc : pkey-mprotect must allow pkey-0
To: Ram Pai <linuxram@us.ibm.com>, mpe@ellerman.id.au, mingo@redhat.com,
        akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de, msuchanek@suse.com, Ulrich.Weigand@de.ibm.com
References: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
From: Florian Weimer <fweimer@redhat.com>
Message-ID: <ec90ed75-2810-bcc3-8439-8dc85a6b46ac@redhat.com>
Date: Fri, 9 Mar 2018 12:04:49 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1520583161-11741-1-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/2018 09:12 AM, Ram Pai wrote:
> Once an address range is associated with an allocated pkey, it cannot be
> reverted back to key-0. There is no valid reason for the above behavior.

mprotect without a key does not necessarily use key 0, e.g. if 
protection keys are used to emulate page protection flag combination 
which is not directly supported by the hardware.

Therefore, it seems to me that filtering out non-allocated keys is the 
right thing to do.

Thanks,
Florian
