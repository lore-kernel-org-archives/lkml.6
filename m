Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BE6C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE14521731
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 15:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bY4SpG5C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE14521731
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732789AbeHNSnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 14:43:01 -0400
Received: from mail-eopbgr720084.outbound.protection.outlook.com ([40.107.72.84]:23712
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732374AbeHNSnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 14:43:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgO+2Ri6jl3ghQWUIQ6LKwH6IVRweSgB6rK38jP1Qmo=;
 b=bY4SpG5CVCUd+Nbc3mdKh3y60XwG/pwiUN78zoLrqwWvakTRKPpeV26ZPSeK9H0ujYBh7zA4CqS0KrVFjnQSeE8h6/KebeXlL409gwIjU3F+K4l95m3GbQFlN4FX15yJmCBt0J5PnQcl4bM7QlB0gKb0vRJlEvlAGHW3AnunSyg=
Received: from BL0PR02MB4849.namprd02.prod.outlook.com (52.132.14.30) by
 BL0PR02MB3731.namprd02.prod.outlook.com (52.132.8.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1038.24; Tue, 14 Aug 2018 15:55:13 +0000
Received: from BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::e42c:5d04:1f44:ad9d]) by BL0PR02MB4849.namprd02.prod.outlook.com
 ([fe80::e42c:5d04:1f44:ad9d%3]) with mapi id 15.20.1038.025; Tue, 14 Aug 2018
 15:55:12 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     kbuild test robot <lkp@intel.com>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Ravikiran Gummaluri <rgummal@xilinx.com>
Subject: RE: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Thread-Topic: [PATCH 4/4] PCI: xilinx-nwl: Add method to
 setup_platform_service_irq hook
Thread-Index: AQHUMMEvYQXdyRdHrUqZcZ0+kpU/maS9aSuAgAIDjGA=
Date:   Tue, 14 Aug 2018 15:55:12 +0000
Message-ID: <BL0PR02MB484920A86EB6267FA35FC2CCA5380@BL0PR02MB4849.namprd02.prod.outlook.com>
References: <1533915580-31805-5-git-send-email-bharat.kumar.gogada@xilinx.com>
 <201808131647.wzxWvkIy%fengguang.wu@intel.com>
In-Reply-To: <201808131647.wzxWvkIy%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BL0PR02MB3731;6:E860XNuzEtW5JFoTGHBkWItkivAwjV7IkcicqyBi56SmdxYrMxfGbDBfw+cy41VP1RVTjiRpjh9fp92Yvr2lxMRJCfqzoI+ToRSv+wM9M3tMf81k8EW9lzSBGcXCcBuet/VlA04dEjpXOafma0SKayyE8uNoQN5b5Fw8zUyUVxg3R/pi3b8kxzqcZtDY7PEZss+/XXpZWu6/RHJe+YvZWSY2e5J5wFr5NmcuXZ5JcZI5EmqOZZ+L4j2ssA9OooyVnuGvcWxWCqbAJ6OZRYMZ32yvPYUbN51sUgoG5uIFpxtJL0Y+v31o9S4I0OFp4IdU+wc4Tjv3PVzwtH+gUOFToN8Q82Lf9u765yHrTvRE46rClxghCnPkfQR3VzSns7Gsj/se84f/8HstvI+fgqJqdCvog1iB5Jkb3XI6pAtCdWQMNXlmyYsntgQ7tFFnanOU80pgCkZcXKzAULEPteJfqQ==;5:PsYYutMHHUaXKvI0pCW/VH0unUIppDWZRDd7dXnn4N5BY4lxuMDo17xS+ku3OcaQLuVVMg9vhUdn+VvzGF1UYgCkXIvKwmlLDjSV457CkM+SB08VwZI+IlMVAX0tg2H6s80fR+DJd2h1E4wDLdzbz4Mx9AobBKG1S0yM/JYkoKs=;7:O3ukzTKcD8OKaf5jqhlRBcrNhMV3DSEtEoZWcITWUb4twYmVbezV1OdBffNQeZHlQVC00g0WV1Ou7wOGL+VI2bKFxpYOsPaoixa0tZzzMt1+v9dpgNRr5LAg4i3lNHq9Fgp1eEFTvbOQko/bH7m18eWcEeRTLRoHveHzI5uOSR53NwlX9OihbzwF0hZSCFnPOIV0KSI+jexGd6a3XirHZvXuUOzIzEHOC25ci/xkJxNQ9dgQZrgwpdIghrD5LCmk
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10009020)(346002)(396003)(39860400002)(136003)(366004)(376002)(13464003)(199004)(189003)(446003)(345774005)(6306002)(6506007)(8676002)(53936002)(9686003)(68736007)(316002)(5660300001)(66066001)(476003)(33656002)(97736004)(106356001)(6116002)(102836004)(486006)(55016002)(74316002)(11346002)(53546011)(229853002)(3846002)(2906002)(6436002)(5250100002)(26005)(2900100001)(105586002)(4326008)(6916009)(86362001)(14454004)(107886003)(7696005)(186003)(54906003)(14444005)(256004)(7736002)(478600001)(76176011)(8936002)(99286004)(81156014)(81166006)(305945005)(25786009)(966005)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB3731;H:BL0PR02MB4849.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-office365-filtering-correlation-id: 40d3bb5c-cdc5-4b8e-0611-08d601fe5216
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BL0PR02MB3731;
x-ms-traffictypediagnostic: BL0PR02MB3731:
x-microsoft-antispam-prvs: <BL0PR02MB373153070A855748D1793B13A5380@BL0PR02MB3731.namprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820)(211936372134217)(228905959029699)(9452136761055)(192813158149592)(162533806227266)(84791874153150);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231311)(944501410)(52105095)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BL0PR02MB3731;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB3731;
x-forefront-prvs: 0764C4A8CD
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: c6Dbwr15ZtaFxtMgcF4ViDlY1EJqB77H+o4tZK3nPJ+JamaIRuwH9DIdYOOGi/oLz4YcoiAspWozlOD5FWrfwmKvXozN2xsAi7W81NRX/5+0HYQ/yXgBRBZH5X/pXEelnk0MD/pEP0fBJ5vyWWtC9/FSbvps0Kz3N54XNz6tLdL6fCeevp1cvX8ZltTmDVwMDtPvZSX8lfUw8Rd/4rTf5Mw9rS3Qbnw0TCIHx41UDs8dPnYDx+LW+4EKo/sBVlRisfxBMWzvTurrD1IEO0csZE/mf4hU2O5SAWzz+8FxYxs0Vp4v3vG1aSfw4zfqpZdgEMkHo0+PbPMsjOkL16MNfA/jPWCHJEpVfiWn6ukoBgk=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40d3bb5c-cdc5-4b8e-0611-08d601fe5216
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2018 15:55:12.7812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB3731
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Agreed, will Fix it in next version.

Regards,
Bharat
> -----Original Message-----
> From: kbuild test robot [mailto:lkp@intel.com]
> Sent: Monday, August 13, 2018 2:39 PM
> To: Bharat Kumar Gogada <bharatku@xilinx.com>
> Cc: kbuild-all@01.org; linux-pci@vger.kernel.org; linux-
> kernel@vger.kernel.org; bhelgaas@google.com; Ravikiran Gummaluri
> <rgummal@xilinx.com>; Bharat Kumar Gogada <bharatku@xilinx.com>
> Subject: Re: [PATCH 4/4] PCI: xilinx-nwl: Add method to
> setup_platform_service_irq hook
>=20
> Hi Bharat,
>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on pci/next]
> [also build test WARNING on v4.18 next-20180810] [if your patch is applie=
d to
> the wrong git tree, please drop us a note to help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Bharat-Kumar-
> Gogada/Add-support-to-register-platform-service-IRQ/20180813-144216
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git n=
ext
> reproduce:
>         # apt-get install sparse
>         make ARCH=3Dx86_64 allmodconfig
>         make C=3D1 CF=3D-D__CHECK_ENDIAN__
>=20
>=20
> sparse warnings: (new ones prefixed by >>)
>=20
> >> drivers/pci/controller/pcie-xilinx-nwl.c:823:5: sparse: symbol
> 'nwl_setup_service_irqs' was not declared. Should it be static?
>=20
> Please review and possibly fold the followup patch.
>=20
> ---
> 0-DAY kernel test infrastructure                Open Source Technology Ce=
nter
> https://lists.01.org/pipermail/kbuild-all                   Intel Corpora=
tion
