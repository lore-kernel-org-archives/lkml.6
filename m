Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9DBC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D2002184A
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbfAKP7z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:59:55 -0500
Received: from mga18.intel.com ([134.134.136.126]:1938 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729359AbfAKP7z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 10:59:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Jan 2019 07:59:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,466,1539673200"; 
   d="scan'208";a="309613771"
Received: from unknown (HELO localhost.localdomain) ([10.232.112.69])
  by fmsmga006.fm.intel.com with ESMTP; 11 Jan 2019 07:59:53 -0800
Date:   Fri, 11 Jan 2019 08:58:28 -0700
From:   Keith Busch <keith.busch@intel.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>
Cc:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-mm@kvack.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rafael Wysocki <rafael@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCHv3 07/13] node: Add heterogenous memory access attributes
Message-ID: <20190111155828.GD21095@localhost.localdomain>
References: <20190109174341.19818-1-keith.busch@intel.com>
 <20190109174341.19818-8-keith.busch@intel.com>
 <87y37sit8x.fsf@linux.ibm.com>
 <20190110173016.GC21095@localhost.localdomain>
 <20190111113238.000068b0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111113238.000068b0@huawei.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 11, 2019 at 11:32:38AM +0000, Jonathan Cameron wrote:
> On Thu, 10 Jan 2019 10:30:17 -0700
> Keith Busch <keith.busch@intel.com> wrote:
> > I am not aware of a real platform that has an initiator-target pair with
> > better latency but worse bandwidth than any different initiator paired to
> > the same target. If such a thing exists and a subsystem wants to report
> > that, you can register any arbitrary number of groups or classes and
> > rank them according to how you want them presented.
> > 
> 
> It's certainly possible if you are trading off against pin count by going
> out of the soc on a serial bus for some large SCM pool and also have a local
> SCM pool on a ddr 'like' bus or just ddr on fairly small number of channels
> (because some one didn't put memory on all of them).
> We will see this fairly soon in production parts.
> 
> So need an 'ordering' choice for this circumstance that is predictable.

As long as the reported memory target access attributes are accurate for
the initiator nodes listed under an access class, I'm not sure that it
matters what order you use. All the information needed to make a choice
on which pair to use is available, and the order is just an implementation
specific decision.
