Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C95CEECDE43
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8ABF421486
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 23:34:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABF421486
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbeJTHmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Oct 2018 03:42:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:10160 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726349AbeJTHmg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Oct 2018 03:42:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Oct 2018 16:34:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,401,1534834800"; 
   d="scan'208";a="98990071"
Received: from kskibin-mobl.ger.corp.intel.com ([10.249.254.29])
  by fmsmga004.fm.intel.com with ESMTP; 19 Oct 2018 16:34:22 -0700
Date:   Sat, 20 Oct 2018 02:34:22 +0300 (EEST)
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
X-X-Sender: jsakkine@jsakkine-mobl1
To:     "Winkler, Tomas" <tomas.winkler@intel.com>
cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Nayna Jain <nayna@linux.vnet.ibm.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "Struk, Tadeusz" <tadeusz.struk@intel.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] tpm: tpm_try_transmit() refactor error flow.
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9D9F5512@hasmsx109.ger.corp.intel.com>
Message-ID: <alpine.DEB.2.21.1810200230200.9963@jsakkine-mobl1>
References: <20181016133716.17842-1-tomas.winkler@intel.com> <alpine.DEB.2.21.1810180309430.5022@jsakkine-mobl1> <5B8DA87D05A7694D9FA63FD143655C1B9D9F5512@hasmsx109.ger.corp.intel.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Oct 2018, Winkler, Tomas wrote:
>> -----Original Message-----
>> From: Jarkko Sakkinen [mailto:jarkko.sakkinen@linux.intel.com]
>> Sent: Thursday, October 18, 2018 03:15
>> To: Winkler, Tomas <tomas.winkler@intel.com>
>> Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>; Jason Gunthorpe
>> <jgg@ziepe.ca>; Nayna Jain <nayna@linux.vnet.ibm.com>; Usyskin,
>> Alexander <alexander.usyskin@intel.com>; Struk, Tadeusz
>> <tadeusz.struk@intel.com>; linux-integrity@vger.kernel.org; linux-security-
>> module@vger.kernel.org; linux-kernel@vger.kernel.org;
>> stable@vger.kernel.org
>> Subject: Re: [PATCH] tpm: tpm_try_transmit() refactor error flow.
>>
>> On Tue, 16 Oct 2018, Tomas Winkler wrote:
>>> First, rename out_no_locality to out_locality for bailing out on both
>>> tpm_cmd_ready() and tpm_request_locality() failure.
>>
>> This is unnecessary change and technically it is not a rename: the commit
>> message text and the code change do not match. Rename is just a rename
>> (i.e. change a variable name foo to bar).
>
> I'm renaming the label because it doesn't match the code flow anymore,
> I can change the commit message, but you please review the code.
> Tomas

The flow change is unnecessary and does not really have anything to do
with the bug fix. Earlier version was better than this and would have
been fine when taking account the remark from Jason.

/Jarkko
