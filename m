Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753491AbeDTRmz (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 13:42:55 -0400
Received: from esa2.dell-outbound.iphmx.com ([68.232.149.220]:52997 "EHLO
        esa2.dell-outbound.iphmx.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753336AbeDTRmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 13:42:54 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2ECAQABJtpah2Oa6ERbhEYOejKDYJR6g?=
 =?us-ascii?q?XSBD5J4gXgLIwiEPgIagiwhNBgBAgEBAQEBAQIBAQIQAQEBCgsJCCgjDII1IhF?=
 =?us-ascii?q?LXAEBAQEBASMCDV0BAQEDASMRRRACAQgaAiYCAgJFEAIEAQ0NhH0ID6ZighyIQ?=
 =?us-ascii?q?YIkBYEJhn2CE4QagUGGMoJUApdxCIVbiFyBLosoiTSGdYElHIILcIMUgi2IYoU?=
 =?us-ascii?q?+jz2BGAEB?=
X-IPAS-Result: =?us-ascii?q?A2ECAQABJtpah2Oa6ERbhEYOejKDYJR6gXSBD5J4gXgLIwi?=
 =?us-ascii?q?EPgIagiwhNBgBAgEBAQEBAQIBAQIQAQEBCgsJCCgjDII1IhFLXAEBAQEBASMCD?=
 =?us-ascii?q?V0BAQEDASMRRRACAQgaAiYCAgJFEAIEAQ0NhH0ID6ZighyIQYIkBYEJhn2CE4Q?=
 =?us-ascii?q?agUGGMoJUApdxCIVbiFyBLosoiTSGdYElHIILcIMUgi2IYoU+jz2BGAEB?=
From: <Mario.Limonciello@dell.com>
X-LoopCount0: from 10.166.132.189
X-IronPort-AV: E=Sophos;i="5.49,302,1520917200";
   d="scan'208";a="242414311"
X-DLP: DLP_GlobalPCIDSS
To: <rdunlap@infradead.org>, <sfr@canb.auug.org.au>,
        <linux-next@vger.kernel.org>, <dvhart@infradead.org>
CC: <linux-kernel@vger.kernel.org>, <platform-driver-x86@vger.kernel.org>
Subject: RE: linux-next: Tree for Apr 19 (dell smbios SMM)
Thread-Topic: linux-next: Tree for Apr 19 (dell smbios SMM)
Thread-Index: AQHT2AgwKJy6Z28GlkKE9Su24yAKO6QJt6TQgABkPwD//82qsA==
Date: Fri, 20 Apr 2018 17:42:52 +0000
Message-ID: <ef8c8d74b23848c19ee7adaca189a99f@ausx13mpc120.AMER.DELL.COM>
References: <20180419143545.63c0c639@canb.auug.org.au>
 <6aec5528-d6f1-3e05-1ac2-6eddbd0ac64f@infradead.org>
 <43bec7e798f5491284d2c049f835d339@ausx13mpc120.AMER.DELL.COM>
 <de6910be-497c-c3b2-39df-bec37bd79f81@infradead.org>
In-Reply-To: <de6910be-497c-c3b2-39df-bec37bd79f81@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.143.18.86]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3KHh2Mh008156

> 
> Hi,
> I've attached it here.
> 
> thanks,
> --
> ~Randy

Thanks.  Darren's patch.  It was supposed to be prevented by 
32d7b19bad9695c4c9026b0ceb3a384561ddee70
(see comment in Kconfig).

#                                                                   
# The DELL_SMBIOS driver depends on ACPI_WMI and/or DCDBAS if those 
# backends are selected. The "depends" line prevents a configuration
# where DELL_SMBIOS=y while either of those dependencies =m.        
#                                                                   

As I can tell it's getting caused by CONFIG_DELL_LAPTOP which is
        select DELL_SMBIOS

OK, this should help:
https://patchwork.kernel.org/patch/10353385/
