Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D7CC04ABB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:49:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FBB820854
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 05:49:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FBB820854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbeIKKqx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 06:46:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:57939 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726301AbeIKKqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 06:46:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Sep 2018 22:49:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,359,1531810800"; 
   d="scan'208";a="88930395"
Received: from pipin.fi.intel.com (HELO localhost) ([10.237.72.128])
  by fmsmga001.fm.intel.com with ESMTP; 10 Sep 2018 22:48:44 -0700
From:   Felipe Balbi <balbi@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawel Laszczak <pawell@cadence.com>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        ltyrala@cadence.com, adouglas@cadence.com
Subject: Re: [PATCH 02/31] usb: usbssp: Added some decoding functions.
In-Reply-To: <20180910181856.GB6019@kroah.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com> <1532023084-28083-3-git-send-email-pawell@cadence.com> <20180910181856.GB6019@kroah.com>
Date:   Tue, 11 Sep 2018 08:48:43 +0300
Message-ID: <87in3c1t50.fsf@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> On Thu, Jul 19, 2018 at 06:57:35PM +0100, Pawel Laszczak wrote:
>> This patch add additional functions that converts some fields to string.
>> 
>> For example function usbssp_trb_comp_code_string take completion
>> code value and return string describing completion code.
>> 
>> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
>> ---
>>  drivers/usb/usbssp/gadget.h | 580 ++++++++++++++++++++++++++++++++++++
>>  1 file changed, 580 insertions(+)
>> 
>> diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
>> index 49e7271187cc..b5c17603af78 100644
>> --- a/drivers/usb/usbssp/gadget.h
>> +++ b/drivers/usb/usbssp/gadget.h
>> @@ -930,6 +930,73 @@ struct usbssp_transfer_event {
>>  #define COMP_UNDEFINED_ERROR			33
>>  #define COMP_INVALID_STREAM_ID_ERROR		34
>>  
>> +static inline const char *usbssp_trb_comp_code_string(u8 status)
>
> <snip>
>
>
> You have _giant_ inline functions here, why?
>
> Please just put this all in a .c file and let the linker properly handle
> things.  You do not want to duplicate all of these crazy strings all
> over the place where ever you call these functions.
>
> And I am guessing this is only for some sort of "debugging" mode?  If
> so, shouldn't there be a way to not even build this in?  Some systems
> are very space constrained...

many of them seem to be a straight copy from xhci.

-- 
balbi
