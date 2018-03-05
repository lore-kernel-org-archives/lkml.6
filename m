Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932314AbeCETXg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 14:23:36 -0500
Received: from mga07.intel.com ([134.134.136.100]:19216 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932147AbeCETX2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 14:23:28 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,428,1515484800";
   d="scan'208";a="32578971"
Subject: Re: [PATCH v12 08/11] mm: Clear arch specific VM flags on protection
 change
To: Khalid Aziz <khalid.aziz@oracle.com>, akpm@linux-foundation.org,
        davem@davemloft.net
References: <cover.1519227112.git.khalid.aziz@oracle.com>
 <f0bfc4b7ce6c8563bf0d5ef74af20b5d1edea66f.1519227112.git.khalid.aziz@oracle.com>
Cc: mhocko@suse.com, jack@suse.cz, kirill.shutemov@linux.intel.com,
        ross.zwisler@linux.intel.com, willy@infradead.org, hughd@google.com,
        n-horiguchi@ah.jp.nec.com, mgorman@suse.de, jglisse@redhat.com,
        dave.jiang@intel.com, dan.j.williams@intel.com,
        anthony.yznaga@oracle.com, nadav.amit@gmail.com, zi.yan@cs.rutgers.edu,
        aarcange@redhat.com, khandual@linux.vnet.ibm.com,
        aneesh.kumar@linux.vnet.ibm.com, henry.willard@oracle.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org, Khalid Aziz <khalid@gonehiking.org>
From: Dave Hansen <dave.hansen@linux.intel.com>
Message-ID: <df5344a2-f28d-7828-b76b-107dc24be2dd@linux.intel.com>
Date: Mon, 5 Mar 2018 11:23:27 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <f0bfc4b7ce6c8563bf0d5ef74af20b5d1edea66f.1519227112.git.khalid.aziz@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/21/2018 09:15 AM, Khalid Aziz wrote:
> +/* Arch-specific flags to clear when updating VM flags on protection change */
> +#ifndef VM_ARCH_CLEAR
> +# define VM_ARCH_CLEAR	VM_NONE
> +#endif
> +#define VM_FLAGS_CLEAR	(ARCH_VM_PKEY_FLAGS | VM_ARCH_CLEAR)

Shouldn't this be defining

# define VM_ARCH_CLEAR	ARCH_VM_PKEY_FLAGS

on x86?
