Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B3AEECE567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA36621567
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 16:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="fOVYg7/W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA36621567
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390788AbeIUWmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 18:42:39 -0400
Received: from mail-bn3nam01on0090.outbound.protection.outlook.com ([104.47.33.90]:6560
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390076AbeIUWmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 18:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EZ5LEimMPAUq+0jbOH60t75CwC5+y6+GgQiXt+cJ8KQ=;
 b=fOVYg7/WgDCOedt+SmRV5+1+55vGlFVz6lcfoqbHNfNBdz7wUtrI6wdHuKHZz6ksn7HsC9YWRiSLt8uCfwr+ddEjKn+SHnt0wkCxVOOWO6OJYXwoVFg02dPe0pYbPqQSOjm1UB7fvgFruI4Q17erN2seCWxVvvygmGgs7puDj34=
Received: from CY4PR21MB0773.namprd21.prod.outlook.com (10.173.192.19) by
 CY4PR21MB0775.namprd21.prod.outlook.com (10.173.192.21) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1185.5; Fri, 21 Sep 2018 16:52:52 +0000
Received: from CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c]) by CY4PR21MB0773.namprd21.prod.outlook.com
 ([fe80::d1f6:46cd:d8b4:880c%5]) with mapi id 15.20.1185.010; Fri, 21 Sep 2018
 16:52:52 +0000
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
Subject: RE: [PATCH v2 1/2] X86/Hyper-V: Add Guest IDLE MSR support
Thread-Topic: [PATCH v2 1/2] X86/Hyper-V: Add Guest IDLE MSR support
Thread-Index: AQHUUX+peHjbdhKEmkSbur3LtThgRqT685YQ
Date:   Fri, 21 Sep 2018 16:52:52 +0000
Message-ID: <CY4PR21MB0773B209A6BE8DC3463F7A32DC120@CY4PR21MB0773.namprd21.prod.outlook.com>
References: <1537514712-62434-1-git-send-email-yi.y.sun@linux.intel.com>
 <1537514712-62434-2-git-send-email-yi.y.sun@linux.intel.com>
In-Reply-To: <1537514712-62434-2-git-send-email-yi.y.sun@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=True;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Owner=mikelley@ntdev.microsoft.com;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2018-09-21T16:52:50.8236864Z;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=General;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Application=Microsoft Azure
 Information Protection;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Extended_MSFT_Method=Automatic;
 Sensitivity=General
x-originating-ip: [2001:4898:80e8:1:990c:85a5:5aae:c0fc]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0775;6:rCP0WYRG9VR91dJS52oIBesCWj/vwcAIXAaIndERmCTToCJ2xrbsu7WS+VgU1SkosgsnCRY3/KNyPz+VpuX7yCok8rq3QQPRUnSpXVzSdo/vfQV8InLpYFXrGQ4+7+eIkGhmmQALUeFNFDhkkXBtCt9MzP478rYfIF3FRAyxApHsfKs2x59uk7RX0bPZ4qC944MfljVAL7QYEiXAxyUDNO/QcxLp9Z7W0mglMfJag2cuYSvtko6EIQn/tPv3KYpwkXlriUNQa56V4UQPr4ZmGq6/nTkWDD43athnfj1SUfBl1EsEVC/O53eXAe2GiZ382Ry70TgraofpJGpCvnRtXKqkXTFpQt2mkEJ2lMDwT/GFDVJ3i0PxrX8BJMsYQ5KggfvmLoApVT8MydAiFH3WtCkfJ4k9QjDWnI19Vd7NLMKr252Veg9Jx2nZbNMxvi6rmxNvSIgtdGmGbgcJxDnlYg==;5:MrUVjuiDcKxI4sqOgE1QyFjY9+XeA+soq0pbuSDAshN29vAjU9ULkmAXJNzP2eBMTwS8vbw26QkA+0FGuCKZJRhViWrQnfnTGYYXK7ujppXPZYjy1khE0myxjv8LyruNGWW7Vf/200l/j7f9BFQ0cAkUz25ac1L/zUJKM17JZts=;7:irC6TjsdPCeO4YjTszHLSZHa3NuxXMuY5vl0gtZfzwiQoaEerSnLoRU7hcLI/rxvrYOXYCmUsQzN8fXVR3jZZ2dAyPAQyMw6YLCjs+dFX2V5hTykY46Ic2ssp+orbmJCG/mx1RhvsTqE/CQzebNjIuk6kXTMKp7VhPidB5RGXLULQN0B7z4+vkGp4MSReawbnA2rgD+66n+sTSlrHQsVBYmp4mzjnsqj3q5d9G5JlgcJHxA5A+ephckEu5cHNKKx
x-ms-office365-filtering-correlation-id: bfb246bf-c53c-4808-2793-08d61fe2abc5
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0775;
x-ms-traffictypediagnostic: CY4PR21MB0775:
x-microsoft-antispam-prvs: <CY4PR21MB077523F8F89DE9B1CAE95F69DC120@CY4PR21MB0775.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(228905959029699)(28532068793085)(89211679590171);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(2018427008)(93006095)(93001095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991041);SRVR:CY4PR21MB0775;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0775;
x-forefront-prvs: 0802ADD973
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(136003)(366004)(39860400002)(199004)(189003)(8676002)(8936002)(305945005)(10290500003)(81166006)(81156014)(229853002)(186003)(446003)(11346002)(2501003)(14454004)(54906003)(110136005)(316002)(14444005)(256004)(46003)(5660300001)(10090500001)(6116002)(6346003)(5250100002)(6436002)(476003)(99286004)(76176011)(7736002)(74316002)(7696005)(102836004)(6506007)(9686003)(86612001)(86362001)(486006)(8990500004)(107886003)(478600001)(2900100001)(55016002)(68736007)(4326008)(71190400001)(6246003)(71200400001)(25786009)(22452003)(53936002)(105586002)(72206003)(97736004)(2906002)(106356001)(33656002)(217873002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0775;H:CY4PR21MB0773.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Michael.H.Kelley@microsoft.com; 
x-microsoft-antispam-message-info: GafmBXtF1bYPRL3FCPi1JMKiU9mOEqZw/FoBStqAJnOwmhyc8VidjFaJDaaiGcejW88pUyC58Nxnm1wWKPiyppaqXg3+z7aOloK6O37uhaCC44KVD7RMt9A3o0O3vJQC8BzgE1Eydt6i/hAaUMjOAZ66/WP5rm/OiMiFSIqVcvE1AAy9cJ8z1gabOy6lrnVs0SVLcVo3bVlFFXNAuyFL1xiFsx1fz0zN3ajjCyj1EWf31dDpvXKdF3rjGJfX872jvQ4aOaJddZgBv9iTou8fgZpEpaW4OZA7oWx7zCBGT4I5BNQxL4A4zPXye4i5iXaDxwuntQl5yV3sS0MP6euEslNBWsD9+U70zlhq9yKATyU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bfb246bf-c53c-4808-2793-08d61fe2abc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2018 16:52:52.3687
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0775
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yi Sun <yi.y.sun@linux.intel.com>  Sent: Friday, September 21, 2018 1=
2:25 AM
>=20
> Hyper-V may expose a HV_X64_MSR_GUEST_IDLE MSR. We can read
> HYPERV_CPUID_FEATURES eax to check it. Read this MSR can
> trigger the guest's transition to the idle power state which
> can be exited by an IPI even if IF flag is disabled.
>=20
> Cc: "K. Y. Srinivasan" <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Stephen Hemminger <sthemmin@microsoft.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
