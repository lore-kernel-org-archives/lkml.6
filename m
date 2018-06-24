Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ACE3C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:20:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA26E24E64
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 09:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA26E24E64
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeFXJU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 05:20:28 -0400
Received: from mga17.intel.com ([192.55.52.151]:42215 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751582AbeFXJU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 05:20:27 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2018 02:20:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,265,1526367600"; 
   d="scan'208";a="51444228"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.255.231.150]) ([10.255.231.150])
  by orsmga007.jf.intel.com with ESMTP; 24 Jun 2018 02:20:26 -0700
Subject: Re: [PATCH V7 00/41] Intel(R) Resource Director Technology Cache
 Pseudo-Locking enabling
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     fenghua.yu@intel.com, Tony Luck <tony.luck@intel.com>,
        vikas.shivappa@linux.intel.com, gavin.hindman@intel.com,
        jithu.joseph@intel.com, dave.hansen@intel.com, mingo@redhat.com,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <cover.1529706536.git.reinette.chatre@intel.com>
 <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <55327577-c7cd-3ab2-ed8e-385149565ce3@intel.com>
Date:   Sun, 24 Jun 2018 02:20:25 -0700
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1806231402500.8650@nanos.tec.linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/23/2018 5:16 AM, Thomas Gleixner wrote:
> On Fri, 22 Jun 2018, Reinette Chatre wrote:
>> The Cache Pseudo-Locking enabling series that was recently merged to the
>> x86/cache branch of tip was found to conflict with the new kernfs support
>> for mounting with fs_context.
>>
>> In preparation for a conflict-free merge between the two repos some no-op
>> hooks are created within the RDT mount function being changed by
>> the two features. The goal is for this commit to be placed on a minimal
>> no-rebase branch to be consumed by both features.
> 
> Thanks for doing this so quick! I've picked up the lot and slightly
> modified the first patch by moving the stubs to the header file to get them
> completely out of the conflicting area.
> 
> The immutable branch for David to pull is:
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs
> 
> I've also created a branch based on Davids mount-context branch, applied
> the cleanup patch below to it and merged the for-vfs branch on top.
> 
> David feel free to pull the result from
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git for-vfs-merged
> 
> or pick up the patch below and do the merge and conflict resolution yourself.
> 
> The x86/cache branch is rebased and merges cleanly with for-vfs-merged. The
> last two patches are dropped; I folded them back to the patches they fix.
> 
>     git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/cache

Thank you very much for setting up all the branches to support a smooth
merge.

> 
> Reinette, can you please verify that x86/cache + for-vfs-merged are doing
> the right thing?

Will do. While tracking down the bisect issue related to
copy_from_user() I managed to lose connectivity to my test system. I
will continue the testing when I am back in the office on Monday.

Reinette
