Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 9E00FC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:04:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 542D7208B1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 00:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 542D7208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934864AbeFMAEN convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 20:04:13 -0400
Received: from mga12.intel.com ([192.55.52.136]:58062 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932490AbeFMAEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 20:04:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 17:04:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="236938041"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
  by fmsmga006.fm.intel.com with ESMTP; 12 Jun 2018 17:04:11 -0700
Received: from fmsmsx118.amr.corp.intel.com (10.18.116.18) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 12 Jun 2018 17:04:11 -0700
Received: from shsmsx104.ccr.corp.intel.com (10.239.4.70) by
 fmsmsx118.amr.corp.intel.com (10.18.116.18) with Microsoft SMTP Server (TLS)
 id 14.3.319.2; Tue, 12 Jun 2018 17:04:11 -0700
Received: from shsmsx101.ccr.corp.intel.com ([169.254.1.82]) by
 SHSMSX104.ccr.corp.intel.com ([169.254.5.87]) with mapi id 14.03.0319.002;
 Wed, 13 Jun 2018 08:04:09 +0800
From:   "Xu, Even" <even.xu@intel.com>
To:     Jiri Kosina <jikos@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC:     "benjamin.tissoires@redhat.com" <benjamin.tissoires@redhat.com>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Thread-Topic: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to
 support hibernation
Thread-Index: AQHUASd9wHD/F8upPEi0DX5gInteeKRcMcAAgAEenvA=
Date:   Wed, 13 Jun 2018 00:04:08 +0000
Message-ID: <9577C59DB499174B9340876B077C2E9569DF11D7@SHSMSX101.ccr.corp.intel.com>
References: <20180611015650.51385-1-srinivas.pandruvada@linux.intel.com>
 <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.1806121651460.6203@cbobk.fhfr.pm>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNGUzY2M3NzktZGNkZC00MjUxLWExYjQtMDE3MWQwNDM1MTljIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiOUJnZ00yODlzT3NVNXlGcTk0aVRNOWNiZXlJRUZyUFVuQ3RXV0NBamd2ajBwM2s3ZWU3OVhmK3R1dnlDWmM2TiJ9
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jiri Kosina,

If without this patch, the platform with ISH, its hibernation resume will take more than 10s because of ISH resume failure, it will also cause ISH not functional.
With this patch, everything will go will.

Best Regards,
Even Xu


-----Original Message-----
From: Jiri Kosina [mailto:jikos@kernel.org] 
Sent: Tuesday, June 12, 2018 10:53 PM
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: benjamin.tissoires@redhat.com; linux-input@vger.kernel.org; linux-kernel@vger.kernel.org; Xu, Even <even.xu@intel.com>
Subject: Re: [PATCH] hid: intel_ish-hid: ipc: register more pm callbacks to support hibernation

On Sun, 10 Jun 2018, Srinivas Pandruvada wrote:

> From: Even Xu <even.xu@intel.com>
> 
> Current ish driver only register resume/suspend PM callbacks which 
> don't support hibernation (suspend to disk). Now use the
> SIMPLE_DEV_PM_OPS() MACRO instead of struct dev_pm_ops directly.
> The suspend and resume functions will now be used for both suspend to 
> RAM and hibernation.
> 
> If power management is disable, SIMPLE_DEV_PM_OPS will do nothing, the 
> suspend and resume related functions won't be used, so mark them as 
> __maybe_unused to clarify that this is intended behavior, and remove 
> #ifdefs for power management.

This describes details the patch does on code level, but what are the user observable effects? Hibernation resume doesn't fail any more? Hibernation is possible (and wasn't before)? Did kernel crash while trying to hibernate and this is the fix? Or ... ?

Thanks,

--
Jiri Kosina
SUSE Labs

