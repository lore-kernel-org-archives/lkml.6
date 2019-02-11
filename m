Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71BA9C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:27:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FAB921B25
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549913278;
	bh=Lz7tJbgIT8LNC7DBEv3tyMK2p3xMYrTBIDvho7Jryvw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=DZLdKZNJyHpjC1ZDiLjIzJfD7Ry3lzTeWQvDtbl6SYGk2DHCKCGyhLEqQ21zKw7TU
	 lhCYCHtEub66GgREGCMkioEgnr7K74IS7niKaH92AJ+/mVHWIJEfIdXJX2YGWB41Vd
	 le7jXOlPcQhms6QgDYPdQSoTyNwnIb4wot/Ulp+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbfBKT14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:27:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:51730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730233AbfBKT14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:27:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A488218A1;
        Mon, 11 Feb 2019 19:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549913274;
        bh=Lz7tJbgIT8LNC7DBEv3tyMK2p3xMYrTBIDvho7Jryvw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nj+ukbPpvXaTr7WXTOY/SmFLEWZS1mMswjBlD+JH1ItOT+3R6eBzB7w+JlGVdBY8Z
         BJOORJCpBQzyrLPs55Y32ND8eLWgVDNjfmGUCR+SuYfHzebgy/sxNlMlQHBbe9dICf
         oJhThuKp/PD/sMokWMHzd8g7iDYjLXdG7csEC59g=
Date:   Mon, 11 Feb 2019 20:27:52 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Babu Moger <babu.moger@amd.com>, Borislav Petkov <bp@suse.de>,
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
Subject: Re: [PATCH 4.19 054/313] x86/resctrl: Fixup the user-visible strings
Message-ID: <20190211192752.GC13134@kroah.com>
References: <20190211141852.749630980@linuxfoundation.org>
 <20190211141857.375396128@linuxfoundation.org>
 <046b7dbd-3480-d8a0-e454-bc1576d5834e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <046b7dbd-3480-d8a0-e454-bc1576d5834e@intel.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2019 at 10:12:46AM -0800, Reinette Chatre wrote:
> Hi Greg,
> 
> On 2/11/2019 6:15 AM, Greg Kroah-Hartman wrote:
> > 4.19-stable review patch.  If anyone has any objections, please let me know.
> > 
> > ------------------
> > 
> > [ Upstream commit 723f1a0dd8e26a7523ba068204bee11c95ded38d ]
> > 
> > Fix the messages in rdt_last_cmd_printf() and rdt_last_cmd_puts() to
> > make them more meaningful and consistent.
> > 
> >  [ bp: s/cpu/CPU/; s/mem\W/memory ]
> > 
> > Signed-off-by: Babu Moger <babu.moger@amd.com>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Arnd Bergmann <arnd@arndb.de>
> > Cc: Brijesh Singh <brijesh.singh@amd.com>
> > Cc: "Chang S. Bae" <chang.seok.bae@intel.com>
> > Cc: David Miller <davem@davemloft.net>
> > Cc: David Woodhouse <dwmw2@infradead.org>
> > Cc: Dmitry Safonov <dima@arista.com>
> > Cc: Fenghua Yu <fenghua.yu@intel.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Jann Horn <jannh@google.com>
> > Cc: Joerg Roedel <jroedel@suse.de>
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> > Cc: Kate Stewart <kstewart@linuxfoundation.org>
> > Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
> > Cc: <linux-doc@vger.kernel.org>
> > Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Philippe Ombredanne <pombredanne@nexb.com>
> > Cc: Pu Wen <puwen@hygon.cn>
> > Cc: <qianyue.zj@alibaba-inc.com>
> > Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> > Cc: Reinette Chatre <reinette.chatre@intel.com>
> > Cc: Rian Hunter <rian@alum.mit.edu>
> > Cc: Sherry Hurwitz <sherry.hurwitz@amd.com>
> > Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Thomas Lendacky <Thomas.Lendacky@amd.com>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> > Cc: <xiaochen.shen@intel.com>
> > Link: https://lkml.kernel.org/r/20181121202811.4492-11-babu.moger@amd.com
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> Could you please drop this patch from consideration for stable?
> 
> Sasha already confirmed that it should not have been included:
> http://lkml.kernel.org/r/20190202193050.GA3973@sasha-vm

Now dropped, thanks.

greg k-h
