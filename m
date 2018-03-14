Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751555AbeCNS6m (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 14:58:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:23019 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751279AbeCNS6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 14:58:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,306,1517904000";
   d="scan'208";a="182780764"
Subject: Re: [PATCH 1/1 v2] x86: pkey-mprotect must allow pkey-0
To: Ram Pai <linuxram@us.ibm.com>
References: <1521013574-27041-1-git-send-email-linuxram@us.ibm.com>
 <18b155e3-07e9-5a4b-1f95-e1667078438c@intel.com>
 <20180314171448.GA1060@ram.oc3035372033.ibm.com>
 <5027ca9e-63c8-47ab-960d-a9c4466d7075@intel.com>
 <20180314185452.GB1060@ram.oc3035372033.ibm.com>
Cc: mingo@redhat.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <3f7c9ee7-46db-723f-177d-7505d0ac1e41@intel.com>
Date: Wed, 14 Mar 2018 11:58:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314185452.GB1060@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 11:54 AM, Ram Pai wrote:
>>> (e) it bypasses key-permission checks when assigned.
>> I don't think this is necessary.  I think the only rule we *need* is:
>>
>> 	pkey-0 is allocated implicitly at execve() time.  You do not
>> 	need to call pkey_alloc() to allocate it.
> And can be explicitly associated with any address range ?

Yes, it should ideally be available for use just like any other key when
allocated.
