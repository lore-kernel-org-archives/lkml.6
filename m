Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBF7C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7256720823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:58:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729237AbfAUH6z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:58:55 -0500
Received: from mga11.intel.com ([192.55.52.93]:49237 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728830AbfAUH6w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:58:52 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Jan 2019 16:36:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,501,1539673200"; 
   d="scan'208";a="109735021"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.37])
  by orsmga006.jf.intel.com with ESMTP; 20 Jan 2019 16:36:19 -0800
Date:   Mon, 21 Jan 2019 08:35:56 +0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Wei Yang <richardw.yang@linux.intel.com>,
        linux-kernel@vger.kernel.org, rafael@kernel.org
Subject: Re: [PATCH v2] driver core: move device->knode_class to
 device_private
Message-ID: <20190121003556.GA4544@richard>
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
References: <20190117055719.6161-1-richardw.yang@linux.intel.com>
 <20190118023459.9972-1-richardw.yang@linux.intel.com>
 <20190118155541.GA5544@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118155541.GA5544@kroah.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 18, 2019 at 04:55:41PM +0100, Greg KH wrote:
>On Fri, Jan 18, 2019 at 10:34:59AM +0800, Wei Yang wrote:
>> As the description of struct device_private says, it stores data which
>> is private to driver core. And it already has similar fields like:
>> knode_parent, knode_driver, knode_driver and knode_bus. This look it is
>> more proper to put knode_class together with those fields to make it
>> private to driver core.
>> 
>> This patch move device->knode_class to device_private to make it comply
>> with code convention.
>> 
>> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
>Thanks for this.  There are a number of other variables that should move
>into this structure, if you want to take a look into doing that.

Really? I may not notice that yet.

I may try to take a look into this, but not sure I would have enough time :-)

>
>greg k-h

-- 
Wei Yang
Help you, Help me
