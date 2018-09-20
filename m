Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6031CECE561
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E665A208A3
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 06:59:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E665A208A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbeITMlm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 08:41:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35072 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726014AbeITMlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 08:41:42 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AEE1E72088;
        Thu, 20 Sep 2018 06:59:45 +0000 (UTC)
Received: from dhcp-128-65.nay.redhat.com (ovpn-12-72.pek2.redhat.com [10.72.12.72])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 79BB460851;
        Thu, 20 Sep 2018 06:59:39 +0000 (UTC)
Date:   Thu, 20 Sep 2018 14:59:35 +0800
From:   Dave Young <dyoung@redhat.com>
To:     lijiang <lijiang@redhat.com>
Cc:     Borislav Petkov <bp@suse.de>, linux-kernel@vger.kernel.org,
        kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        hpa@zytor.com, x86@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, thomas.lendacky@amd.com,
        bhelgaas@google.com, baiyaowei@cmss.chinamobile.com, tiwai@suse.de,
        brijesh.singh@amd.com, Baoquan He <bhe@redhat.com>
Subject: Re: [PATCH 1/3 v2] resource: fix an error which walks through iomem
 resources
Message-ID: <20180920065935.GA11980@dhcp-128-65.nay.redhat.com>
References: <20180919125251.8181-1-lijiang@redhat.com>
 <20180919125251.8181-2-lijiang@redhat.com>
 <20180919132949.GB9122@nazgul.tnic>
 <32409e2a-533b-c317-5519-26e0993cd30e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <32409e2a-533b-c317-5519-26e0993cd30e@redhat.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Thu, 20 Sep 2018 06:59:45 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/20/18 at 02:39pm, lijiang wrote:
> 在 2018年09月19日 21:29, Borislav Petkov 写道:
> > On Wed, Sep 19, 2018 at 08:52:49PM +0800, Lianbo Jiang wrote:
> > 
> > ...
> > 
> >> In fact, we should get the resource A and B when we walk through the
> >> whole tree, but it only gets the resource A, the resource B is missed.
> >>
> >> Signed-off-by: Dave Young <dyoung@redhat.com>
> >> Signed-off-by: Lianbo Jiang <lijiang@redhat.com>
> > 
> > Before looking at this: the SOB chain of all three patches is wrong.
> > Hint: see section 12) in Documentation/process/submitting-patches.rst
> > 
> Thanks for your advice, Borislav.
> 
> I have discussed with Dave Young, and he suggested that i might add a Suggested-by

patch 2 and patch 3 are based on my draft patch, but since you did debugging
and changes you can move my SOB to Suggested-by for patch 2 and patch 3,
for patch 1 please just drop my SOB and leave yours only. 


> tag instead of Signed-off-by tag for him. What do you think about?
> 
> I will modify the invalid SOB chain and post it again.
> 

Thanks
Dave
