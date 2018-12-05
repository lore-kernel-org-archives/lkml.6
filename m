Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7433C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A30C920879
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 17:19:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A30C920879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbeLERTS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 12:19:18 -0500
Received: from mga12.intel.com ([192.55.52.136]:35530 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbeLERTS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 12:19:18 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Dec 2018 09:19:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,318,1539673200"; 
   d="scan'208";a="116290345"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by FMSMGA003.fm.intel.com with ESMTP; 05 Dec 2018 09:19:17 -0800
Received: from orsmsx114.amr.corp.intel.com ([169.254.8.128]) by
 ORSMSX103.amr.corp.intel.com ([169.254.5.166]) with mapi id 14.03.0415.000;
 Wed, 5 Dec 2018 09:19:17 -0800
From:   "Ghorai, Sukumar" <sukumar.ghorai@intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>
CC:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Dmitry Torokhov" <dtor@chromium.org>,
        Alex Hung <alex.hung@canonical.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "rajatxjain@gmail.com" <rajatxjain@gmail.com>,
        "dtor@google.com" <dtor@google.com>,
        "Hegde, Raghuram" <raghuram.hegde@intel.com>,
        "Tumkur Narayan, Chethan" <chethan.tumkur.narayan@intel.com>
Subject: RE: [PATCH v3 2/5] usb: assign ACPI companions for embedded USB
 devices
Thread-Topic: [PATCH v3 2/5] usb: assign ACPI companions for embedded USB
 devices
Thread-Index: AQHUgfT9bpVoLUXBzUeHmeL1LtVGbaVwfSmA///7x/A=
Date:   Wed, 5 Dec 2018 17:19:16 +0000
Message-ID: <D73ECEF0C711E34A8F972E4B87F540058FBCF1CB@ORSMSX114.amr.corp.intel.com>
References: <20181117010748.24347-1-rajatja@google.com>
 <20181121235020.29461-1-rajatja@google.com>
 <20181121235020.29461-2-rajatja@google.com> <20181205093247.GB1817@kroah.com>
In-Reply-To: <20181205093247.GB1817@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiNTAwY2E3ZjYtNzY4Ny00YmY3LTkwYWEtZTMyMDE5ODRiMzBjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiMXRNbkxIS0ExUElYNmRPZEQrRVdJQk1pN1NXN3Y2ZlEwZWl3MzREY0U2QloyV0ZtS0ZpZGFKZ2EzWmpWcUl4RyJ9
x-ctpclassification: CTP_NT
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>On Wed, Nov 21, 2018 at 03:50:17PM -0800, Rajat Jain wrote:
>> From: Dmitry Torokhov <dtor@chromium.org>
>>
>> USB devices permanently connected to USB ports may be described in
>> ACPI tables and share ACPI devices with ports they are connected to.
>> See [1] for details.
>>
>> This will allow us to describe sideband resources for devices, such
>> as, for example, hard reset line for BT USB controllers.
>>
>> [1]
>> https://docs.microsoft.com/en-us/windows-hardware/drivers/bringup/othe
>> r-acpi-namespace-objects#acpi-namespace-hierarchy-and-adr-for-
>embedded
>> -usb-devices
>>
>> Signed-off-by: Dmitry Torokhov <dtor@chromium.org>
>> Signed-off-by: Rajat Jain <rajatja@google.com> (changed how we get the
>> usb_port)
>
>Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Tested-by: Sukumar Ghorai <sukumar.ghorai@intel.com>
