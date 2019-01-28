Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11ED5C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:25:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA7C2087F
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548667554;
	bh=qgFqZIzh69tsA5afbyuoGBOGY3xgwcOr43nns6jP7eM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=yapXOVzjubL/cgS4FqaYeyysnkvJmgekGQTCylaU3DHTJF8iohTKqwAdJLDcXwCAN
	 sHdyEvuuItdBXaGyqpaFuogsLjLqtikF7FWPq1Nxq47hchdvwwAEsF+XMho05MWDwj
	 03uPZ+034DIFsRyTlZ2gCIcifGU5pd/9Hy1EngN4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfA1JZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 04:25:53 -0500
Received: from mx2.suse.de ([195.135.220.15]:59910 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726369AbfA1JZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 04:25:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5DBDDAC5E;
        Mon, 28 Jan 2019 09:25:51 +0000 (UTC)
Date:   Mon, 28 Jan 2019 10:25:49 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "Du, Fan" <fan.du@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@suse.de" <bp@suse.de>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "tiwai@suse.de" <tiwai@suse.de>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "jglisse@redhat.com" <jglisse@redhat.com>,
        "zwisler@kernel.org" <zwisler@kernel.org>,
        "baiyaowei@cmss.chinamobile.com" <baiyaowei@cmss.chinamobile.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "Wu, Fengguang" <fengguang.wu@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: [PATCH 5/5] dax: "Hotplug" persistent memory for use like normal
 RAM
Message-ID: <20190128092549.GF18811@dhcp22.suse.cz>
References: <20190124231441.37A4A305@viggo.jf.intel.com>
 <20190124231448.E102D18E@viggo.jf.intel.com>
 <0852310e-41dc-dc96-2da5-11350f5adce6@oracle.com>
 <CAPcyv4hjJhUQpMy1CVJZur0Ssr7Cr2fkcD50L5gzx6v_KY14vg@mail.gmail.com>
 <5A90DA2E42F8AE43BC4A093BF067884825733A5B@SHSMSX104.ccr.corp.intel.com>
 <CAPcyv4ikXD8rJAmV6tGNiq56m_ZXPZNrYkTwOSUJ7D1O_M5s=w@mail.gmail.com>
 <b7d45d83a314955e7dff25401dfc0d4f4247cfcd.camel@intel.com>
 <dc7d8190-2c94-9bdb-fb5b-a80a3fb55822@oracle.com>
 <CAPcyv4hEyG-1hC=20M7YGFG-BF7yvNcG7EkLurAfysHHB2yXBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPcyv4hEyG-1hC=20M7YGFG-BF7yvNcG7EkLurAfysHHB2yXBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-01-19 11:15:08, Dan Williams wrote:
[...]
> However, we should consider this along with the userspace enabling to
> control which device-dax instances are set aside for hotplug. It would
> make sense to have a "clear errors before hotplug" configuration
> option.

I am not sure I understand. Do you mean to clear HWPoison when the
memory is hotadded (add_pages) or onlined (resp. move_pfn_range_to_zone)?
-- 
Michal Hocko
SUSE Labs
