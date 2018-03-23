Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752284AbeCWThB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 15:37:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:13852 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751997AbeCWThA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 15:37:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,351,1517904000";
   d="scan'208";a="185457026"
Subject: Re: [PATCH 09/11] x86/pti: enable global pages for shared areas
To: Nadav Amit <namit@vmware.com>
References: <20180323174447.55F35636@viggo.jf.intel.com>
 <20180323174500.64BD3D36@viggo.jf.intel.com>
 <7B08037D-1682-406D-90F1-C2B5B1899F7F@vmware.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "aarcange@redhat.com" <aarcange@redhat.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "keescook@google.com" <keescook@google.com>,
        "hughd@google.com" <hughd@google.com>,
        "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <4f97f448-307f-1095-84cc-1b7444eb78a8@linux.intel.com>
Date: Fri, 23 Mar 2018 12:36:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7B08037D-1682-406D-90F1-C2B5B1899F7F@vmware.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/2018 12:12 PM, Nadav Amit wrote:
>> 		/*
>> +		 * Setting 'target_pmd' below creates a mapping in both
>> +		 * the user and kernel page tables.  It is effectively
>> +		 * global, so set it as global in both copies.
>> +		 */
>> +		*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
> if (boot_cpu_has(X86_FEATURE_PGE)) ?

Good catch.  I'll update that.
