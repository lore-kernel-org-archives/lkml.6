Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58DB3C28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2600C20851
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 15:43:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="jc+4GBiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2600C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727488AbeKUCNm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:13:42 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:59197 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbeKUCNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 21:13:42 -0500
X-IronPort-AV: E=Sophos;i="5.56,257,1539673200"; 
   d="scan'208";a="21357967"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Nov 2018 08:43:56 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.49) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Tue, 20 Nov 2018 08:43:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYQepiv6/5Kqlw8v1fRBGmZHUXu+JHiFYa+HTyvkOCs=;
 b=jc+4GBiq99rddJj1eXVq/nY1/llc9LpffkXhtqI8qqkXSO5yI4kmEN61NCSPVyTxBFMepsEZasbYaUobCAra92LfFrPAb/dPHnjcVCmrVbihTVAuZpiJbHocLQmfzz4IrQbgR+kbm81xjM0LQO5QckFZfj6G036ZMNFiWehfz4Q=
Received: from BN6PR11MB1842.namprd11.prod.outlook.com (10.175.99.146) by
 BN6PR11MB1698.namprd11.prod.outlook.com (10.173.29.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.31; Tue, 20 Nov 2018 15:43:50 +0000
Received: from BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae]) by BN6PR11MB1842.namprd11.prod.outlook.com
 ([fe80::d88c:1d67:5fb0:12ae%2]) with mapi id 15.20.1339.026; Tue, 20 Nov 2018
 15:43:50 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <lkp@intel.com>
CC:     <kbuild-all@01.org>, <marek.vasut@gmail.com>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <boris.brezillon@bootlin.com>, <richard@nod.at>,
        <Cyrille.Pitchen@microchip.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: parse SFDP 4-byte Address Instruction Table
Thread-Topic: [PATCH] mtd: spi-nor: parse SFDP 4-byte Address Instruction
 Table
Thread-Index: AQHUgMfp7padVqHddU2ujFJxxustT6VYy+AAgAACMYA=
Date:   Tue, 20 Nov 2018 15:43:49 +0000
Message-ID: <d2b4845b-8066-18a1-1b88-1f0e8fe634b9@microchip.com>
References: <20181120115512.15958-1-tudor.ambarus@microchip.com>
 <201811202348.n7lHxFem%fengguang.wu@intel.com>
In-Reply-To: <201811202348.n7lHxFem%fengguang.wu@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1P18901CA0008.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::18) To BN6PR11MB1842.namprd11.prod.outlook.com
 (2603:10b6:404:103::18)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Tudor.Ambarus@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR11MB1698;6:v84PKpUv9otp5dNoiF5Rer7Qlq4+yC5a9bdCSWcjzQ113GkKZjGwDBAtl71PxfpUcN8JrU1lz+doGCh7kGjlZWlUNVJWNeOzEf+ZSFlD+nDOHD1a1Q7WVcO9gqkVv++1zX/ZEfmeRNi5IRJKprHo7aNg2w2N+TVoWHc1FM2AKfpUU+wI7Sy07SZUNhMkHRtf7Yl/7oD01y0hMyD6aa5SjOAxF1OtqOX143YFFajlU9XG5e4KaBXSTAJWr56ACOyEfNJVNsxNYLbw5aN64czkLTWQIPp6curD+63lubdW+zFETYgqbHy3CxISWbybaLUVYIDyiWae89p/hMFO9MvvVZAXWU++8CvKeDhuQCFBfhwldbbAnDQl3iWQqlIc/nUE0YrI/LK9mL0i9XWiKJLhq8/rswPE2iZOHzdI+sBmD7+5Y69uTI5NEX5ch0k/ER+Q6u6vFeBt3HXxtLnqKrb53g==;5:UXX2YEAq+sqo7UMIWahkNPIfF+gzQjUmttssPh9vllJjs/QUTEH9HYAWbMF/ma11FZ1CEsRHKtIor6WBjjoogQ2m16oPL02t/XHkOYH806Tv77AzKEvU+As/ZqxsdTSxjRJlClXQ50WCV9KEkwDKhzhUiqBYb/rFhwhfV9avab4=;7:CHCZGWKvnW5dQb8LYE6mTjJaq98bVYRz5/WkBxXMsvcRpr/oCWp0dbQoeYXQ6emhA6tIas0dkcXEQkJS33L7YNzdHcR8oeuOdCsqiMUGV0dyzkx2DAD65G5rs9HIwDiCoL0y2+WCd3z9tUc8voqi2Q==
x-ms-office365-filtering-correlation-id: 421b5065-4829-49b6-c853-08d64efef71e
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BN6PR11MB1698;
x-ms-traffictypediagnostic: BN6PR11MB1698:
x-microsoft-antispam-prvs: <BN6PR11MB16982EC423D3CEDD00AFDC5BF0D90@BN6PR11MB1698.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(166708455590820);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231442)(944501410)(52105112)(148016)(149066)(150057)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BN6PR11MB1698;BCL:0;PCL:0;RULEID:;SRVR:BN6PR11MB1698;
x-forefront-prvs: 08626BE3A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(136003)(366004)(39860400002)(346002)(376002)(189003)(199004)(105586002)(31686004)(14454004)(54906003)(316002)(106356001)(52116002)(26005)(3846002)(68736007)(186003)(6116002)(97736004)(36756003)(2906002)(102836004)(478600001)(345774005)(53546011)(386003)(6506007)(76176011)(11346002)(6916009)(66066001)(2616005)(476003)(72206003)(25786009)(8936002)(966005)(99286004)(8676002)(5660300001)(305945005)(446003)(7736002)(81156014)(2900100001)(81166006)(6436002)(71200400001)(6486002)(6246003)(256004)(71190400001)(31696002)(86362001)(229853002)(5024004)(39060400002)(486006)(6306002)(53936002)(6512007)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1698;H:BN6PR11MB1842.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: TYIgy4eyLKyot4WvtI0Xqaw12tMRijN/0MSQwLw1BhdzrWTje/Wzq7X9zTxIn3KegOM8Rz4LV4R/M4G1+9WjjdKDcbxr++rTS+wmjje5yokmW/lXJxQoyvqNZDZS1KOTdnMtQ5xAq3+RI7DL6M1XwpdSrK5BdaCPf9JLMFImRxxWcXDDXt6VmeX/pwxziSF+DtM2eOiH2ksXoCdbxIIrMO3iT+Mvsw1EKN12z8W3kv9pV9tTiSt+0ORU6a9DFE6KbTm2MedawvNm2Z/Er0A7CvGjbRS8h4s/+IyvZNGkvoBz5Nymv7YbCDDNsdV/eLLBYx/D7Q9YG5RWbdxH22z+K7cU707d5OSh5/0AtpmfZlw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <58A6CE53FE02864A9C8378930281A1CF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 421b5065-4829-49b6-c853-08d64efef71e
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2018 15:43:50.0090
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1698
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/2018 05:35 PM, kbuild test robot wrote:
> Hi Cyrille,
>=20
> Thank you for the patch! Yet something to improve:
>=20
> [auto build test ERROR on mtd/spi-nor/next]
> [also build test ERROR on v4.20-rc3 next-20181120]
> [if your patch is applied to the wrong git tree, please drop us a note to=
 help improve the system]
>=20
> url:    https://github.com/0day-ci/linux/commits/Tudor-Ambarus-microchip-=
com/mtd-spi-nor-parse-SFDP-4-byte-Address-Instruction-Table/20181120-223821
> base:   git://git.infradead.org/linux-mtd.git spi-nor/next
> config: i386-randconfig-x005-201846 (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
> reproduce:
>         # save the attached .config to linux build tree
>         make ARCH=3Di386=20
>=20
> All errors (new ones prefixed by >>):
>=20
>    drivers/mtd//spi-nor/spi-nor.c: In function 'spi_nor_parse_4bait':
>>> drivers/mtd//spi-nor/spi-nor.c:3165:15: error: implicit declaration of =
function 'spi_nor_sort_erase_mask'; did you mean 'spi_nor_set_erase_type'? =
[-Werror=3Dimplicit-function-declaration]
>      erase_mask =3D spi_nor_sort_erase_mask(map, erase_mask);
>                   ^~~~~~~~~~~~~~~~~~~~~~~

That's fine. I already specified that this patch depends on the
spi_nor_sort_erase_mask() function introduced in
https://patchwork.ozlabs.org/patch/999105/

Thanks!
ta
