Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B635BC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7C821872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 15:45:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=armh.onmicrosoft.com header.i=@armh.onmicrosoft.com header.b="SuENbLwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfBGPpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 10:45:09 -0500
Received: from mail-eopbgr30045.outbound.protection.outlook.com ([40.107.3.45]:57472
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726037AbfBGPpJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 10:45:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector1-arm-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTloccA7TFcyy8Nbgeahr8+nIXkacik22JJ0R0DNCpA=;
 b=SuENbLwos0pJM9P8QzkEFH41pCbG+tNLc30/D57GyOwwDq6ybpLNa+Lm5gn8njtyfNqR4S0o1akJBhlrEaWEZEKaIXl/eDnfg+mnz0lzyxCmGbS54Q2x/cZCTaBulz6d7yj9XHhbPxUbvZFQW7yuLforiqduwg2x8qc4ueTUlJs=
Received: from AM6PR08MB3175.eurprd08.prod.outlook.com (52.135.164.24) by
 AM6PR08MB4296.eurprd08.prod.outlook.com (20.179.5.86) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1601.17; Thu, 7 Feb 2019 15:45:06 +0000
Received: from AM6PR08MB3175.eurprd08.prod.outlook.com
 ([fe80::41ac:8166:9e93:9721]) by AM6PR08MB3175.eurprd08.prod.outlook.com
 ([fe80::41ac:8166:9e93:9721%3]) with mapi id 15.20.1601.016; Thu, 7 Feb 2019
 15:45:06 +0000
From:   =?iso-8859-1?Q?=D8rjan_Eide?= <Orjan.Eide@arm.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Brian Starkey <Brian.Starkey@arm.com>,
        Liam Mark <lmark@codeaurora.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "tkjos@android.com" <tkjos@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        "arve@android.com" <arve@android.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>, nd <nd@arm.com>,
        "maco@android.com" <maco@android.com>,
        "christian@brauner.io" <christian@brauner.io>
Subject: Re: [Linaro-mm-sig] [PATCH 2/4] staging: android: ion: Restrict cache
 maintenance to dma mapped memory
Thread-Topic: [Linaro-mm-sig] [PATCH 2/4] staging: android: ion: Restrict
 cache maintenance to dma mapped memory
Thread-Index: AQHUuI9lns/3+YiToUC0S+cImvhCrKXS82qAgAEJoQCAAIoDAA==
Date:   Thu, 7 Feb 2019 15:45:05 +0000
Message-ID: <20190207154502.GD3768@e106893-lin.trondheim.arm.com>
References: <1547836667-13695-1-git-send-email-lmark@codeaurora.org>
 <1547836667-13695-3-git-send-email-lmark@codeaurora.org>
 <69b18f39-8ce0-3c4d-3528-dfab8399f24f@ti.com>
 <alpine.DEB.2.10.1901181316380.9328@lmark-linux.qualcomm.com>
 <alpine.DEB.2.10.1901291544001.19412@lmark-linux.qualcomm.com>
 <20190130113122.fipxgcmgrqggozcm@DESKTOP-E1NTVVP.localdomain>
 <20190206154021.GC3768@e106893-lin.trondheim.arm.com>
 <20190207073104.GA16222@infradead.org>
In-Reply-To: <20190207073104.GA16222@infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [217.140.106.39]
user-agent: Mutt/1.5.21 (2010-09-15)
x-clientproxiedby: CWXP265CA0095.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:39::35) To AM6PR08MB3175.eurprd08.prod.outlook.com
 (2603:10a6:209:46::24)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Orjan.Eide@arm.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;AM6PR08MB4296;6:dhte3nDh+vCAxTKoG5xwAtOZzSxr5QRuxPewMq5p5Gn0UeQD18Qin95AetTVJvD6pJzuVwHsWqqT8ZgBHfF7bCY5bIy08/Vl7heHNgEukI0864U/mhB3JIHg9dh/F4SPaOhw2V/U36iR1kFVEzIbOY0ubXPwtEiyAzPy6e0CvhYqcrVYmCIG4HPo3wF0SwY6ou2KI+WlPcWp0u+B97dcWa1yJqrzlARXioCRxuFZWV+/oGQlsZjbhM4Jk9lMUb2PjgzjgYJ86RhUYGrkMEcJNbYa8ekG/MkfkVLSoFwQdYnNyC7KLKqJTEfrUwluxObiJeOvQKk4xIZH7z6ywvH5WMgsN+zY4X/8SL81FdDkNfp32AN2K3Que0skOsb4FFFUlRhmvR5Qk1/N8FUjJtE8RO+TSye9hI9KeFovyaOEavQo77HfD/3VbdPwt8PgC0oQvcaYmHOGWKSk2vNWhGLgeQ==;5:Rxohra7cxaQzK1NRwNEKaw7sA/d6ZyJTQSxmjilQvHntDVw5HhIftdkkRirbQ9gvWbyJYm9a8vT4xfnH8Z4BNKY3rJJpa5L4oiXbZBcddYacq/RDlkz9CoFnx1Mg0xGwhU34lausPWFAeoojh39imqcJaq8eiKOo3MWPWnCEUXDPoRiLi1X2MqCAEFG55Z40l/Z0M170Z9rghXNs4d/t0g==;7:bPDDwv8uBC+TqdCe+qNWxLQJHMXfv2KOhLae6YxiGBTknOSTsTt7+/gk2zyKDiyGRd8RdggEBWHKAAliIL2EH4FpKJqITvK/L9JtdpNjAHEv2Oa/Gar1NlLDmIWMBg8kv1KDR0U/FFA+k0LGV6mg1g==
x-ms-office365-filtering-correlation-id: a767c6fc-3113-4465-70fe-08d68d133b25
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM6PR08MB4296;
x-ms-traffictypediagnostic: AM6PR08MB4296:
nodisclaimer: True
x-microsoft-antispam-prvs: <AM6PR08MB42963EF80B057D7DE617ACA190680@AM6PR08MB4296.eurprd08.prod.outlook.com>
x-forefront-prvs: 0941B96580
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(346002)(366004)(136003)(39860400002)(376002)(189003)(199004)(81156014)(25786009)(105586002)(68736007)(106356001)(6486002)(6246003)(6436002)(14454004)(72206003)(4326008)(99286004)(33656002)(76176011)(52116002)(6116002)(3846002)(386003)(478600001)(6506007)(81166006)(8936002)(8676002)(93886005)(14444005)(5024004)(2906002)(256004)(486006)(446003)(1076003)(6916009)(71200400001)(71190400001)(476003)(11346002)(66066001)(305945005)(316002)(86362001)(58126008)(229853002)(53936002)(6512007)(97736004)(7416002)(7736002)(54906003)(186003)(26005)(102836004)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR08MB4296;H:AM6PR08MB3175.eurprd08.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: arm.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: nZWbiUWCLqcsozA0CcHZwvmLQMjeVjwTn9JgOjAL9ALT0eUYPgtOLezuj+/TxrSaRaLa9w1m75xMJvZSO1FM04jfmmXv3tIUYZSxwTBu5m8wM4oCAL4D37Brjy4oFw2MwDigYv+S0ckczWygLPO80mRW7LIpFoQSYJEGhTuGFFuOGfbx4sfm+XdDGSw20MMk1Uw3pV6yR/PBG9DvZTi7lP/C0D4gjL2mZoDpmBb/VS61PDS60zN2p11A0S3DMRTB1OResmeEBpNkPeKr5BwRx9xWP7fS07tBNTVySdnZ/zBRigT4UOFJD70+mhH4vRKfxsm11Ywt+3WDWuWc3EGedVfTkruLXZ1kvV62tXZOEk1pq4we2Lxa4kHt6KikM6/eA3yqrOpljQQKOx9EKXQ0touMIb/XfFv8pgLCjl7gPnI=
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <C6EE633CDBF53240AA19547B5E6776CC@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a767c6fc-3113-4465-70fe-08d68d133b25
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2019 15:45:04.6561
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4296
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 06, 2019 at 11:31:04PM -0800, Christoph Hellwig wrote:
> The CPU may only access DMA mapped memory if ownership has been
> transferred back to the CPU using dma_sync_{single,sg}_to_cpu, and then
> before the device can access it again ownership needs to be transferred
> back to the device using dma_sync_{single,sg}_to_device.
>=20
> > I've run some testing, and this patch does indeed fix the crash in
> > dma_sync_sg_for_cpu when it tried to use the 0 dma_address from the sg
> > list.
> >=20
> > Tested-by: =D8rjan Eide <orjan.eide@arm.com>
> >=20
> > I tested this on an older kernel, v4.14, since the dma-mapping code
> > moved, in v4.19, to ignore the dma_address and instead use sg_phys() to
> > get a valid address from the page, which is always valid in the ion sg
> > lists. While this wouldn't crash on newer kernels, it's still good to
> > avoid the unnecessary work when no CMO is needed.
>=20
> Can you also test is with CONFIG_DMA_API_DEBUG enabled, as that should
> catch all the usual mistakes in DMA API usage, including the one found?

I checked again with CONFIG_DMA_API_DEBUG=3Dy, both with and without this
patch, and I didn't get any dma-mapping errors.=20

The issue I hit, without this patch, is when a CPU access starts after a
device have attached, which caused ion to create a copy of the buffer's
sg list with dma_address zeroed, but before the device have mapped the
buffer.

--=20
=D8rjan
