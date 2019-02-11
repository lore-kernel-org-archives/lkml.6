Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CEE4C282D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54B8F21B24
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731322AbfBKSMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:12:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:4178 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbfBKSMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:12:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Feb 2019 10:12:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,359,1544515200"; 
   d="scan'208";a="143346536"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.131]) ([10.24.14.131])
  by fmsmga004.fm.intel.com with ESMTP; 11 Feb 2019 10:12:50 -0800
Subject: Re: [PATCH 4.19 054/313] x86/resctrl: Fixup the user-visible strings
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org, Babu Moger <babu.moger@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Brijesh Singh <brijesh.singh@amd.com>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        David Miller <davem@davemloft.net>,
        David Woodhouse <dwmw2@infradead.org>,
        Dmitry Safonov <dima@arista.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jann Horn <jannh@google.com>, Joerg Roedel <jroedel@suse.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Pu Wen <puwen@hygon.cn>, qianyue.zj@alibaba-inc.com,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rian Hunter <rian@alum.mit.edu>,
        Sherry Hurwitz <sherry.hurwitz@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        xiaochen.shen@intel.com, Sasha Levin <sashal@kernel.org>
References: <20190211141852.749630980@linuxfoundation.org>
 <20190211141857.375396128@linuxfoundation.org>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <046b7dbd-3480-d8a0-e454-bc1576d5834e@intel.com>
Date:   Mon, 11 Feb 2019 10:12:46 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190211141857.375396128@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 2/11/2019 6:15 AM, Greg Kroah-Hartman wrote:
> 4.19-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> [ Upstream commit 723f1a0dd8e26a7523ba068204bee11c95ded38d ]
> 
> Fix the messages in rdt_last_cmd_printf() and rdt_last_cmd_puts() to
> make them more meaningful and consistent.
> 
>  [ bp: s/cpu/CPU/; s/mem\W/memory ]
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Brijesh Singh <brijesh.singh@amd.com>
> Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
> Cc: David Miller <davem@davemloft.net>
> Cc: David Woodhouse <dwmw2@infradead.org>
> Cc: Dmitry Safonov <dima@arista.com>
> Cc: Fenghua Yu <fenghua.yu@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Jann Horn <jannh@google.com>
> Cc: Joerg Roedel <jroedel@suse.de>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Kate Stewart <kstewart@linuxfoundation.org>
> Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> Cc: <linux-doc@vger.kernel.org>
> Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Philippe Ombredanne <pombredanne@nexb.com>
> Cc: Pu Wen <puwen@hygon.cn>
> Cc: <qianyue.zj@alibaba-inc.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: Reinette Chatre <reinette.chatre@intel.com>
> Cc: Rian Hunter <rian@alum.mit.edu>
> Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
> Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> Cc: Tony Luck <tony.luck@intel.com>
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Cc: <xiaochen.shen@intel.com>
> Link: https://lkml.kernel.org/r/20181121202811.4492-11-babu.moger@amd.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Could you please drop this patch from consideration for stable?

Sasha already confirmed that it should not have been included:
http://lkml.kernel.org/r/20190202193050.GA3973@sasha-vm

Thank you

Reinette

