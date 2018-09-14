Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4066ECE561
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 23:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4CF20882
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 23:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4CF20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbeIOFDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 01:03:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:15789 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725724AbeIOFDi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 01:03:38 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Sep 2018 16:46:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,375,1531810800"; 
   d="scan'208";a="90614863"
Received: from ssaleem-mobl4.amr.corp.intel.com (HELO ssaleem-mobl1) ([10.255.32.214])
  by orsmga001.jf.intel.com with SMTP; 14 Sep 2018 16:46:31 -0700
Received: by ssaleem-mobl1 (sSMTP sendmail emulation); Fri, 14 Sep 2018 18:46:31 -0500
Date:   Fri, 14 Sep 2018 18:46:31 -0500
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     =?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>
Cc:     "Latif, Faisal" <faisal.latif@intel.com>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        "Hefty, Sean" <sean.hefty@intel.com>,
        Hal Rosenstock <hal.rosenstock@gmail.com>,
        "Singhai, Anjali" <anjali.singhai@intel.com>,
        Shannon Nelson <shannon.nelson@oracle.com>
Subject: Re: mutex and rcu list traversal idiosyncrasy
Message-ID: <20180914234631.GA20084@ssaleem-MOBL4.amr.corp.intel.com>
References: <E4626316-0683-45DF-9F09-D602FC982E21@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E4626316-0683-45DF-9F09-D602FC982E21@oracle.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 13, 2018 at 05:55:44AM -0600, Håkon Bugge wrote:
> Hi Faisal,
> 
> 
> In commit f27b4746f378 ("i40iw: add connection management code") you have in i40iw_add_mqh_6():
> 
> rtnl_lock();
> for_each_netdev_rcu(...) {
> 	[]
> }
> rtnl_unlock();
> 
> Shouldn't this read:
> rtnl_lock();
> for_each_netdev(...) {
> 	[]
> }
> rtnl_unlock();
>

Yes.
