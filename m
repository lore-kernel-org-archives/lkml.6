Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A6AECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:03:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFA321550
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 17:03:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="NsthUV2c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BFA321550
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390742AbeIUWw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:52:56 -0400
Received: from mail-bn3nam01on0104.outbound.protection.outlook.com ([104.47.33.104]:48486
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390615AbeIUWw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KXpAmZ7S9hN0UFaOifx36jSnUjOV0+zQayvClqWDIP4=;
 b=NsthUV2ciy5cM1dD2kDyvUK19pV4dFR0fOLAy8Z5s4gQce9o2ZNEMCJJp8Yn4zhyl2gvEpWSy3+fQZpiZXxfXvmSSqFDTU6VwTK8HdCcJMifpiOeKViMjBaQr8kdqD1vwv9rBb/gHrM+q53dIjCHXI4Tda3JJMFIcynvJWtp050=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0117.namprd21.prod.outlook.com (10.173.189.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.4; Fri, 21 Sep 2018 17:02:54 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 17:02:54 +0000
From:   "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>
To:     Yi Sun <yi.y.sun@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "chao.p.peng@intel.com" <chao.p.peng@intel.com>,
        "chao.gao@intel.com" <chao.gao@intel.com>,
        "isaku.yamahata@intel.com" <isaku.yamahata@intel.com>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: RE: [PATCH v2 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Thread-Topic: [PATCH v2 2/2] locking/pvqspinlock, hv: Enable PV qspinlock for
 Hyper-V
Thread-Index: AQHUUX+pyi/oxQXiE0uwSTGHRUFOXaT69BVg
Date:   Fri, 21 Sep 2018 17:02:54 +0000
Message-ID: <CY4PR21MB0773F63A6367C5C1CE26F5ADDC120@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1537514712-62434-1-git-send-email-yi.y.sun@linux.intel.com>
 <1537514712-62434-3-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1537514712-62434-3-git-send-email-yi.y.sun@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-21T17:02:52.7266697Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:990c:85a5:5aae:c0fc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0117;6:KLj0pvCuFp/6pskABxKUyjSjhh9JGb4AGNBuomhEiXOMi5j4NbG2pULUTnxqgr44olIuPBICvB3mYGOO+Iis64uEQ15Xbjxb4rOsAvA8/ErVjq+sM0weIvgVxf5h3r6x8W09hODgCVZab4IRWJIoJfCt00T7NPydgtK3OcT1SeWdSFhz4WIfxhItJpXB6pArGZwsU6IYuFshIPHEvv65VsDS3eBQbuUiFR2V1FicuidYTexOv5gcMFjKbzYdRcLPpK1+Ytb0BeDts7MOBFAvW29X0Ve7zT1u8eZ0yn/yhL1DJ/WEBLIh5Kzrut/0LR4bVLFYWj/328ES0kGrxv84wieiXjuIqSk2TKGeQzfyivXWz1Zm1/XQFHJpT/T6AXa+JGt7WTl7Wb6PYfjBA/Bl0zCnxuW++JnTyIP2JsFSNam7z68BHUrKzBoUzvqsisUQ671g/7MWPD9Uz5JCvNGTmw==;5:780c2TjzDWrDJZrJwNwcBJw1F0HE/nZjUeEv+kzDzWKkZ5V1z1glmVoonUOhYrO2rCAPQlt96Y0EGP2X0Zl6wSpOPoCnzBKFFtU+UkZsLRZ/ch7mHNYlDyULwBs01fjZ0JQuITDTfIyxt40GZ5QbyNgdoXQ42cMAuKicmtxGVaE=;7:eNAqImBPvh+PMZYkaucX0DNkyakrijQwGWfbfcxl8dxAkeop+6s3r7e24obn8/pOWGWsLvckqIlydVixup4hX8Ls6sS4OnqN5q+GRIOnQO7jHWJIabq6WdjcXJTHZJu3tlvIDWo85DQBnxnzE8w7CwR3cRqY9kx+dJSEp9Ej9L79fUqrgbMZg6iXstycnyJZsDPfAoCgFJQHaWqP4wTUqcicOl63zTbvQIVLA04XLMOSmnTUrUE8AU8uUtTQfMUa
x-ms-office365-filtering-correlation-id: 56c0bbdb-b4f9-44c5-1457-08d61fe4127a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0117;
x-ms-traffictypediagnostic: CY4PR21MB0117:
x-microsoft-antispam-prvs: <CY4PR21MB0117822FF92485EC8245A75ADC120@CY4PR21MB0117.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(2018427008)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0117;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0117;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(366004)(136003)(346002)(396003)(376002)(199004)(189003)(81166006)(110136005)(6506007)(54906003)(81156014)(305945005)(8676002)(14444005)(256004)(2501003)(6436002)(68736007)(5250100002)(102836004)(74316002)(105586002)(476003)(53936002)(8936002)(5660300001)(10090500001)(8990500004)(22452003)(106356001)(33656002)(9686003)(46003)(55016002)(316002)(6116002)(6246003)(107886003)(97736004)(486006)(229853002)(71190400001)(71200400001)(186003)(10290500003)(86362001)(446003)(478600001)(7736002)(6346003)(76176011)(25786009)(4326008)(2906002)(7696005)(99286004)(14454004)(72206003)(2900100001)(86612001)(11346002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0117;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: u8A0CYGyX8Yehs7bJ+rfoVu3zV43aOQuCkvS0qGq1ne8Aem+1Ro78eQezWQkRPNnEJ6/TVPLB7njwv6ioueM4DxKHp0BLBa0utqg8nXUul3XVO0Jop7F+LMzW35K6382A3zhtDV2t+yeY4caNYZYPA3EnvscdeLSzzUGbof86skrhSzhVRdSNFo1gg1NGdn4HmqJ0J4xcsnMNnN3/2VDP5vSwq3ZHcGUzY4GLzZgOaYxSotptJ2HE/+XhXk+vlU5VoFl5gTNPsGfG9/IrK3s8TuPccrWXgdYj49fNWOCdKHOOZiutivcMt4Z2Ve8kB1c2SNyK1lrYQdjX7YfFcOaFmxIN052vYbpOvk/4ny6u8U=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c0bbdb-b4f9-44c5-1457-08d61fe4127a
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 17:02:54.2038
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0117
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Sun <yi.y.sun@linux.intel.com> Sent: Friday, September 21, 2018 12=
:25 AM
> +
> +#define pr_fmt(fmt) "hv: " fmt

Other Hyper-V messages use "Hyper-V: " as the prefix, not "hv: ".  Take
a quick look at 'dmesg' output for reference.

> +
> +#include <linux/kernel_stat.h>
> +#include <linux/spinlock.h>
> +#include <linux/debugfs.h>
> +#include <linux/log2.h>
> +#include <linux/gfp.h>

Some of these #includes look like they might be leftovers from
some other code.  Please check and see whether kernel_stat.h,
debugsfs.h, log2.h, and gfp.h are actually needed.

> +static void hv_qlock_wait(u8 *byte, u8 val)
> +{
> +	unsigned long msr_val;
> +
> +	if (READ_ONCE(*byte) !=3D val)
> +		return;
> +
> +	/*
> +	 * Read HV_X64_MSR_GUEST_IDLE MSR can trigger the guest's
> +	 * transition to the idle power state which can be exited
> +	 * by an IPI even if IF flag is disabled.
> +	 */
> +	if (ms_hyperv.features & HV_X64_MSR_GUEST_IDLE_AVAILABLE)

I can't see a case where this test is actually needed.  hv_qlock_wait()
can only get called if the flag is set when hv_init_spinlocks() is run, and
the flag value doesn't change after it is set.

> +		rdmsrl(HV_X64_MSR_GUEST_IDLE, msr_val);
> +}

Michael
