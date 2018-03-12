Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeCLWmF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:42:05 -0400
Received: from esa5.dell-outbound.iphmx.com ([68.232.153.95]:38409 "EHLO
        esa5.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751282AbeCLWmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:42:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2FFAABYAadah8mZ6ERdGQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQcBAQEBAYQmfygKjWWNcoIEgRZtk0WCFQqFJQKDGyE0GAECAQEBAQEBAgE?=
 =?us-ascii?q?CEAEBAQoLCQgoLoI4IoJKAQEBBDo/DAQCAQgRBAEBHwkHRgkIAgQBDQUIhRCuL?=
 =?us-ascii?q?ohjghWFNYIuhmqFKIVjBJpWCZBZgW2ENYhJjmuCXYEsHoILcIMSgkKCBXeMeIE?=
 =?us-ascii?q?YAQEB?=
X-IPAS-Result: =?us-ascii?q?A2FFAABYAadah8mZ6ERdGQEBAQEBAQEBAQEBAQcBAQEBAYQ?=
 =?us-ascii?q?mfygKjWWNcoIEgRZtk0WCFQqFJQKDGyE0GAECAQEBAQEBAgECEAEBAQoLCQgoL?=
 =?us-ascii?q?oI4IoJKAQEBBDo/DAQCAQgRBAEBHwkHRgkIAgQBDQUIhRCuLohjghWFNYIuhmq?=
 =?us-ascii?q?FKIVjBJpWCZBZgW2ENYhJjmuCXYEsHoILcIMSgkKCBXeMeIEYAQEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.195
X-IronPort-AV: E=Sophos;i="5.47,463,1515477600";
   d="scan'208";a="148290409"
X-DLP: DLP_GlobalPCIDSS
To: <linux@dominikbrodowski.net>, <dvhart@infradead.org>
CC: <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Thread-Topic: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
Thread-Index: AQHTujOfjdkuaHq0Pk2UI1enckQ/AqPNMdfg
Date: Mon, 12 Mar 2018 22:42:01 +0000
Message-ID: <4cce64d16cab4d499dca9347c1a1f30c@ausx13mpc120.AMER.DELL.COM>
References: <20180312185357.GA1672@light.dominikbrodowski.net>
In-Reply-To: <20180312185357.GA1672@light.dominikbrodowski.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2CMgBd5009109



> -----Original Message-----
> From: Dominik Brodowski [mailto:linux@dominikbrodowski.net]
> Sent: Tuesday, March 13, 2018 2:54 AM
> To: dvhart@infradead.org; Limonciello, Mario <Mario_Limonciello@Dell.com>
> Cc: platform-driver-x86@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Dell Inc. XPS 13 9343/0TM99H fails to boot v4.16-rc5
> 
> Mario,
> 
> unfortunately, my Dell Inc. XPS 13 9343/0TM99H, BIOS A11 12/08/2016 fails to
> boot v4.16-rc5. More exactly, I could bisect it down to commit 25d47027e10
> ("platform/x86: dell-smbios: Link all dell-smbios-* modules together").
> Usually, I have enabled
> 
> CONFIG_SENSORS_DELL_SMM=y
> CONFIG_DELL_SMBIOS=y
> CONFIG_DELL_SMBIOS_WMI=y
> CONFIG_DELL_SMBIOS_SMM=y
> CONFIG_DELL_LAPTOP=y
> CONFIG_DELL_WMI=y
> CONFIG_DELL_WMI_DESCRIPTOR=y
> # CONFIG_DELL_WMI_AIO is not set
> # CONFIG_DELL_WMI_LED is not set
> # CONFIG_DELL_SMO8800 is not set
> # CONFIG_DELL_RBTN is not set
> # CONFIG_DELL_RBU is not set
> 
> For v4.16-rc5 to work, I need to manually disable DELL_SMBIOS_WMI:
> 
> -CONFIG_DELL_SMBIOS_WMI=y
> +# CONFIG_DELL_SMBIOS_WMI is not set
> 
> Any ideas?
> 
Dominick,

Interesting.  Can you please change CONFIG_DELL_SMBIOS to a module
and see if that behavior persists?  If it does, can you please blacklist it on
the kernel command line and try to load it manually and share any
backtrace?

Thanks,
