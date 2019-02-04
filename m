Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886F2C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 646B020823
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732767AbfBDK72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:59:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:61284 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730650AbfBDK7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:59:24 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2019 02:59:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,560,1539673200"; 
   d="scan'208";a="115106848"
Received: from cvg-ubt08.iil.intel.com (HELO [143.185.152.136]) ([143.185.152.136])
  by orsmga008.jf.intel.com with ESMTP; 04 Feb 2019 02:59:23 -0800
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Subject: RFC: striving for automotive grade certification
To:     linux-kernel@vger.kernel.org
Message-ID: <613bd2e4-4c06-10ef-772d-5cc057728ecb@linux.intel.com>
Date:   Mon, 4 Feb 2019 12:59:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am looking how can we get kernel certified for life critical 
applications, in particular for automotive industry. Mean drive train, 
not infotainment.

To begin with, all certification processes are talking about cleaning 
compilation warnings at level higher then usual.

Example would be unused parameter in function. This is what I want to 
start with. There are lots of warnings triggered in kernel compilation 
by -Wunused-parameter, it is perhaps most frequent warning at all. 
Technically it is not hard to fix all such warnings by adding 
__always_unused when needed. However this will produce huge patch 
touching lots of files for kind of nothing. So, before starting this 
effort, I want to consult:
  - is this (massive cleanup) right direction in general?
  - Any ideas better then marking __always_unused?
  - what to do in cases where parameter is unused depending on some 
pre-processor conditions?
  - is it better to do one huge patch or split into pieces?

Thanks, Vladimir
