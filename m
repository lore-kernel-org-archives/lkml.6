Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CEF2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3232082F
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 00:54:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF3232082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726972AbeK1Lxv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 06:53:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:30551 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbeK1Lxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 06:53:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 16:54:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,288,1539673200"; 
   d="scan'208";a="113005221"
Received: from haiyuewa-mobl.ccr.corp.intel.com (HELO [10.67.64.126]) ([10.67.64.126])
  by fmsmga002.fm.intel.com with ESMTP; 27 Nov 2018 16:54:06 -0800
Subject: Re: [PATCH] ipmi: kcs_bmc: handle devm_kasprintf() failure case
To:     minyard@acm.org, Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <1542812905-27337-1-git-send-email-hofrat@osadl.org>
 <9320680f-679e-fc89-4349-17dbbd30bbfc@acm.org>
From:   "Wang, Haiyue" <haiyue.wang@linux.intel.com>
Message-ID: <67962bdd-f7db-5a7d-e5d8-baaefd748ab5@linux.intel.com>
Date:   Wed, 28 Nov 2018 08:54:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <9320680f-679e-fc89-4349-17dbbd30bbfc@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend for wrong reply HTML format mail]

Great check for making kcs_bmc module be more stable and handle things gracefully.

My tag if needed.
      Reviewed-by: Haiyue Wang<haiyue.wang@linux.intel.com>

在 2018-11-27 21:36, Corey Minyard 写道:
> On 11/21/18 9:08 AM, Nicholas Mc Guire wrote:
>> devm_kasprintf() may return NULL if internal allocation failed so this
>> assignment is not safe. Moved the error exit path and added the !NULL
>> which then allows the devres manager to take care of cleanup.
>
>
> Added the original author.  This looks correct to me, I've included 
> it, but I would
> like Haiyue to comment, if possible.
>
> Thanks,
>
> -corey
>
>
>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>> Fixes: cd2315d471f4 ("ipmi: kcs_bmc: don't change device name") 
