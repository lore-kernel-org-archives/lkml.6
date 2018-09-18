Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3024ECE561
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A81E42086B
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 05:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A81E42086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbeIRLYb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 07:24:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:26126 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726399AbeIRLYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 07:24:30 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2018 22:53:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,388,1531810800"; 
   d="scan'208";a="89700460"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga004.fm.intel.com with ESMTP; 17 Sep 2018 22:52:39 -0700
Received: from tiger-server (unknown [10.239.48.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by linux.intel.com (Postfix) with ESMTPS id F3E3958014B;
        Mon, 17 Sep 2018 22:52:36 -0700 (PDT)
Date:   Tue, 18 Sep 2018 22:31:49 +0800
From:   Yi Zhang <yi.z.zhang@linux.intel.com>
To:     "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi.z.zhang@intel.com
Subject: Re: [PATCH V5 0/4] Fix kvm misconceives NVDIMM pages as reserved mmio
Message-ID: <20180918143148.GB70800@tiger-server>
Mail-Followup-To: "Ahmed S. Darwish" <darwish.07@gmail.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, pbonzini@redhat.com,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        yu.c.zhang@intel.com, pagupta@redhat.com, david@redhat.com,
        jack@suse.cz, hch@lst.de, linux-mm@kvack.org, rkrcmar@redhat.com,
        jglisse@redhat.com, yi.z.zhang@intel.com
References: <cover.1536342881.git.yi.z.zhang@linux.intel.com>
 <20180907170451.GA5771@darwi-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180907170451.GA5771@darwi-kernel>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Darwi's remind, Will follow that next time.

Thanks.
Yi

On 2018-09-07 at 17:04:51 +0000, Ahmed S. Darwish wrote:
> Hi!
> 
> On Sat, Sep 08, 2018 at 02:03:02AM +0800, Zhang Yi wrote:
> [...]
> >
> > V1:
> > https://lkml.org/lkml/2018/7/4/91
> >
> > V2:
> > https://lkml.org/lkml/2018/7/10/135
> >
> > V3:
> > https://lkml.org/lkml/2018/8/9/17
> >
> > V4:
> > https://lkml.org/lkml/2018/8/22/17
> >
> 
> Can we please avoid referencing "lkml.org"?
> 
> It's just an unreliable broken website. [1][2] Much more important
> though is that its URLs _hide_ the Message-Id field; running the
> threat of losing the e-mail reference forever at some point in the
> future.
> 
> From Documentation/process/submitting-patches.rst:
> 
>     If the patch follows from a mailing list discussion, give a
>     URL to the mailing list archive; use the https://lkml.kernel.org/
>     redirector with a ``Message-Id``, to ensure that the links
>     cannot become stale.
> 
> So the V1 link above should've been either:
> 
>     https://lore.kernel.org/lkml/cover.1530716899.git.yi.z.zhang@linux.intel.com
> 
> or:
> 
>     https://lkml.kernel.org/r/cover.1530716899.git.yi.z.zhang@linux.intel.com
> 
> and so on..
> 
> Thanks,
> 
> [1] https://www.theregister.co.uk/2018/01/14/linux_kernel_mailing_list_archives_will_return_soon
> [2] The threading interface is also broken and in a lot of cases
>     does not show all messages in a thread
> 
> --
> Darwi
> http://darwish.chasingpointers.com
