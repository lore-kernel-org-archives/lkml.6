Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cIlLHhdjGFteRgAAmS7hNA
	; Wed, 06 Jun 2018 22:41:27 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 5CE9E60861; Wed,  6 Jun 2018 22:41:27 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="Kq4PIpWA"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 824916063F;
	Wed,  6 Jun 2018 22:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 824916063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752956AbeFFWlY (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 18:41:24 -0400
Received: from mail-sn1nam02on0120.outbound.protection.outlook.com ([104.47.36.120]:36992
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752403AbeFFWlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 18:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BGC1o6B48QQ7cmKNwk6KqdoHE/xJiMeKpzMSXh5ZMP8=;
 b=Kq4PIpWAbkypS0vi2ipCEc4J+i5e52Bkt180V7IKmYW9sKD5qeX+C5xOVyvFIw9FJr2MAu1+nEkI4cUCRumS7fkgBd9/vkQWkq7dLtxST2EV1WRWN3rjZxZb8ERrgYrc99NxBccgQZ1QBM5jIFyrHM4eE291jFjL5QYFHHvjxmA=
Received: from BL0PR2101MB1107.namprd21.prod.outlook.com (52.132.24.30) by
 BL0PR2101MB1010.namprd21.prod.outlook.com (52.132.23.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.2; Wed, 6 Jun 2018 22:41:20 +0000
Received: from BL0PR2101MB1107.namprd21.prod.outlook.com
 ([fe80::78fd:ff13:65d6:31d3]) by BL0PR2101MB1107.namprd21.prod.outlook.com
 ([fe80::78fd:ff13:65d6:31d3%4]) with mapi id 15.20.0841.011; Wed, 6 Jun 2018
 22:41:20 +0000
From: KY Srinivasan <kys@microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Allen Marshall <Allen.Marshall@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "hpa@zytor.com" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        Alexander Grest <Alexander.Grest@microsoft.com>,
        "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] HV: Fix definition of struct hv_vp_assist_page.
Thread-Topic: [PATCH] HV: Fix definition of struct hv_vp_assist_page.
Thread-Index: AQHT8OW0xvko0r+GHEaIrg880bNua6RTHXwAgADPYkA=
Date: Wed, 6 Jun 2018 22:41:20 +0000
Message-ID: <BL0PR2101MB1107DFDFAFC3292E690C067CA0650@BL0PR2101MB1107.namprd21.prod.outlook.com>
References: <20180521092506.90121-1-Tianyu.Lan@microsoft.com>
 <alpine.DEB.2.21.1806061217220.1579@nanos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.21.1806061217220.1579@nanos.tec.linutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [2001:4898:80e8:2:d9b3:cdea:3634:b0ba]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR2101MB1010;7:cjTqT+mShkBEeO1OoVrrXtah2ABTQrVMfSCHYSw/eqyqU5IutUyuaCopyYdIlrw6B2QA6V/iWd6JX09P6NtQtO2eoDgRrX7gSgP7zzCrcsZPzpmnxvdj0Tri/zzIJPG85PcsOEV4ACMp7shtDKgHwAjltZDKQlMernaVHkqVPIKYura7FEpVqF1crWBwSd76c7VKMLxc2QlGC+2t4IsSM2p/AuTb+CS8JruXB0rOV9dSUm30dxfLlocbqAt86BZS
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:BL0PR2101MB1010;
x-ms-traffictypediagnostic: BL0PR2101MB1010:
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=kys@microsoft.com;
x-microsoft-antispam-prvs: <BL0PR2101MB101010AF106E159EAC995D9BA0650@BL0PR2101MB1010.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(28532068793085)(89211679590171)(9452136761055);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(2018427008)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BL0PR2101MB1010;BCL:0;PCL:0;RULEID:;SRVR:BL0PR2101MB1010;
x-forefront-prvs: 06952FC175
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(39380400002)(366004)(376002)(396003)(346002)(13464003)(189003)(199004)(8676002)(7696005)(97736004)(10290500003)(33656002)(6436002)(11346002)(446003)(5250100002)(186003)(6636002)(46003)(229853002)(5660300001)(486006)(105586002)(1511001)(476003)(54906003)(110136005)(99286004)(106356001)(22452003)(316002)(25786009)(14454004)(3660700001)(8936002)(2900100001)(575784001)(6116002)(86362001)(4326008)(2906002)(6246003)(86612001)(8990500004)(3280700002)(9686003)(68736007)(53546011)(7736002)(102836004)(305945005)(81156014)(81166006)(74316002)(478600001)(55016002)(10090500001)(6506007)(76176011)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BL0PR2101MB1010;H:BL0PR2101MB1107.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: tXiZT1g7dnqJgtsEFRXBxGLDmq//5Zhh5WXcJw+cfIyQmc33pIn4MZ9lbW8nZeS6qz6XDtaiw1o7dYA8u19fDkqivBEKsQsTNyN0WJN6goTOpQUduQrkyyloBXwxfOjprlWGBFVM3Lk7QarWnLGSXVC88+IweU6oVAy0JsOXj3mVML4dEMg1Lwojg2s5BrBQ
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3447a917-1e32-4cab-d614-08d5cbfe9fb5
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3447a917-1e32-4cab-d614-08d5cbfe9fb5
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2018 22:41:20.3348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB1010
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Allen

> -----Original Message-----
> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Wednesday, June 6, 2018 3:18 AM
> To: Tianyu Lan <Tianyu.Lan@microsoft.com>
> Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> <haiyangz@microsoft.com>; Stephen Hemminger
> <sthemmin@microsoft.com>; mingo@redhat.com; hpa@zytor.com;
> x86@kernel.org; vkuznets@redhat.com; Alexander Grest
> <Alexander.Grest@microsoft.com>; devel@linuxdriverproject.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH] HV: Fix definition of struct hv_vp_assist_page.
>=20
> On Mon, 21 May 2018, Tianyu Lan wrote:
>=20
> KY ????

I am looking at the published Hyper-V Top Level Functional Spec now; will g=
et back shortly.
>=20
> > The struct hv_vp_assist_page was defined incorrectly.
> > The "vtl_control" should be u64[3], "nested_enlightenments_control"
> > should be a u64 and there is 7 reserved bytes following
> "enlighten_vmentry".
> > This patch is to fix it.
> >
> > Signed-off-by: Lan Tianyu <Tianyu.Lan@microsoft.com>
> > ---
> >  arch/x86/include/asm/hyperv-tlfs.h | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/include/asm/hyperv-tlfs.h
> b/arch/x86/include/asm/hyperv-tlfs.h
> > index f7be6d03a310..fae0a5431cdd 100644
> > --- a/arch/x86/include/asm/hyperv-tlfs.h
> > +++ b/arch/x86/include/asm/hyperv-tlfs.h
> > @@ -496,10 +496,11 @@ struct hv_timer_message_payload {
> >  /* Define virtual processor assist page structure. */
> >  struct hv_vp_assist_page {
> >  	__u32 apic_assist;
> > -	__u32 reserved;
> > -	__u64 vtl_control[2];
> > -	__u64 nested_enlightenments_control[2];
> > -	__u32 enlighten_vmentry;
> > +	__u32 reserved1;
> > +	__u64 vtl_control[3];
> > +	__u64 nested_enlightenments_control;
> > +	__u8 enlighten_vmentry;
> > +	__u8 reserved2[7];
> >  	__u64 current_nested_vmcs;
> >  };
> >
> > --
> > 2.14.3
> >
