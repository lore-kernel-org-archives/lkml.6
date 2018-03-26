Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752704AbeCZR7D (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:59:03 -0400
Received: from osg.samsung.com ([64.30.133.232]:39850 "EHLO osg.samsung.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751908AbeCZR7C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:59:02 -0400
Subject: Re: [PATCH 1/9] x86, pkeys: do not special case protection key 0
To: Dave Hansen <dave.hansen@intel.com>, Shuah Khan <shuah@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org, stable@kernel.org, linuxram@us.ibm.com,
        tglx@linutronix.de, mpe@ellerman.id.au, mingo@kernel.org,
        akpm@linux-foundation.org, Shuah Khan <shuahkh@osg.samsung.com>,
        Shuah Khan <shuahkh@osg.samsung.com>
References: <20180326172721.D5B2CBB4@viggo.jf.intel.com>
 <20180326172722.8CC08307@viggo.jf.intel.com>
 <9c2de5f6-d9e2-3647-7aa8-86102e9fa6c3@kernel.org>
 <b54257c2-138c-7ac9-8176-0dc4868093ef@intel.com>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <19a54db9-b0bd-5661-de2a-c5ee76e733d9@osg.samsung.com>
Date: Mon, 26 Mar 2018 11:58:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b54257c2-138c-7ac9-8176-0dc4868093ef@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/26/2018 11:53 AM, Dave Hansen wrote:
> On 03/26/2018 10:47 AM, Shuah Khan wrote:
>>
>> Also what happens "pkey_free() pkey-0" - can you elaborate more on that
>> "silliness consequences"
> 
> It's just what happens if you free any other pkey that is in use: it
> might get reallocated later.  The most likely scenario is that you will
> get pkey-0 back from pkey_alloc(), you will set an access-disable or
> write-disable bit in PKRU for it, and your next stack access will SIGSEGV.
> 

Thanks. This will good information to include in the commit log.

-- Shuah
