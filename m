Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id lzt3OtR1GlvbYAAAmS7hNA
	; Fri, 08 Jun 2018 12:32:19 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 2DF6B6089E; Fri,  8 Jun 2018 12:32:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CF73B601C3;
	Fri,  8 Jun 2018 12:32:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CF73B601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752459AbeFHMcP (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:32:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:10821 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751251AbeFHMcO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:32:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jun 2018 05:32:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,490,1520924400";
   d="scan'208";a="46253996"
Received: from ahunter-desktop.fi.intel.com (HELO [10.237.72.168]) ([10.237.72.168])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2018 05:32:10 -0700
Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
To: Evan Green <evgreen@chromium.org>, Stanislav.Nijnikov@wdc.com
Cc: Vinayak Holikatti <vinholikatti@gmail.com>,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        Gwendal Grignou <gwendal@chromium.org>, Alex.Lemberg@wdc.com,
        Avri.Altman@wdc.com
References: <20180529181740.195362-1-evgreen@chromium.org>
 <MWHPR04MB11372C75BFC9416BAF5E81A19A630@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft4LoNiRtxgTA_ZPghZGEVOzu_GAwMgqhs-8NCYVgj_AVw@mail.gmail.com>
 <MWHPR04MB11370AED823FB608218CB9AD9A600@MWHPR04MB1137.namprd04.prod.outlook.com>
 <CAE=gft5Vk3neDkyvmVf4CkBQQPVK=wXp=5jJ8n0uaosEwWUOAg@mail.gmail.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <b844b80f-9f6f-10f7-6dfd-f92d905738e3@intel.com>
Date: Fri, 8 Jun 2018 15:30:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAE=gft5Vk3neDkyvmVf4CkBQQPVK=wXp=5jJ8n0uaosEwWUOAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/18 17:59, Evan Green wrote:
> On Sun, Jun 3, 2018 at 3:21 AM Stanislav Nijnikov
> <Stanislav.Nijnikov@wdc.com> wrote:
>>
>>
>>
>>> -----Original Message-----
>>> From: linux-scsi-owner@vger.kernel.org <linux-scsi-owner@vger.kernel.org> On Behalf Of Evan Green
>>> Sent: Friday, June 1, 2018 5:44 PM
>>> To: Stanislav Nijnikov <Stanislav.Nijnikov@wdc.com>
>>> Cc: Vinayak Holikatti <vinholikatti@gmail.com>; jejb@linux.vnet.ibm.com; martin.petersen@oracle.com; linux-
>>> kernel@vger.kernel.org; linux-scsi@vger.kernel.org; Gwendal Grignou <gwendal@chromium.org>; Alex Lemberg
>>> <Alex.Lemberg@wdc.com>; Avri Altman <Avri.Altman@wdc.com>
>>> Subject: Re: [PATCH 0/7] Enable UFS provisioning via Linux
>>>
>>> Hi Stanislav. Thanks for taking a look. Responses below.
>>>
>>> On Thu, May 31, 2018 at 3:04 AM Stanislav Nijnikov
>>> <Stanislav.Nijnikov@wdc.com> wrote:
>>>>
>>>> Hi Evan,
>>>> I have some generic notes:
>>>> - Why to create new sysfs entries for the configuration descriptor fields if they are just duplication of fields in the device and unit
>>> descriptors? And the sysfs representation of the device and unit descriptors is existing already.
>>>
>>> Well, UFS describes them as different descriptors. I worry that if I
>>> add a bunch of clever logic to hide the config descriptor behind other
>>> descriptors, there might be trouble later if 1) there is a quirky
>>> device that doesn't reflect the values between descriptors quite the
>>> same way or at the same time, or 2) if a later UFS spec adds more
>>> configuration descriptor fields that don't exactly reflect into other
>>> non-config descriptors, the cleverness will look awkward.
>>
>> No additional logic will be required to attach write functionality to the
>> existing entries instead of new defined ones. It will reduce the patch
>> size significantly. And there will be no need for the unit selector
>> mechanism which I'm not sure will be accepted by the SCSI community.
>>
> 
> So this would be modifying the existing sysfs entries so that reads
> still come from the device and unit descriptors, but writes go to
> equivalent fields in the config descriptor? I can explore that
> approach. Alternatively, if the unit selector mechanism is not
> desired, I could dynamically create sysfs directories for each unit in
> the config descriptor, but still bring out the config descriptor
> values as separate entries. (I still worry a bit about smashing the
> descriptors together as the UFS spec called them out as different).

If you use the unit attributes, how do you configure units that do not yet
exist?

Perhaps it is better to represent the configuration descriptors exactly as
they are defined in the specification.  Probably not worth exposing them at
all if the configuration is locked (attribute bConfigDescrLock == 1).

Note also that the 2.1 spec. defines  bConfDescContinue which allows updates
to be grouped and committed together.
