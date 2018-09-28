Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96736C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:27:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34FAC206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 23:27:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="HNU2Buyb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FAC206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727425AbeI2Fx6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 01:53:58 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:57703 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbeI2Fx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 01:53:58 -0400
X-IronPort-AV: E=Sophos;i="5.54,317,1534834800"; 
   d="scan'208";a="17986793"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES128-SHA; 28 Sep 2018 16:27:55 -0700
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.37) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Fri, 28 Sep 2018 16:27:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4RJGX7oBkdw/pbCcoeMyT/8/aeOevLRhOHSRU6rans=;
 b=HNU2BuybueDQ2OFJP4vX76C63iTcaHOYlDf2/hyDiKkISGqliAmBE5hed1zdFckSdKWiPy1opG93vPTazy3QbSrvvOb4AzdKcE7Cai72QdbxA+FQ5EI/FNA2/BaNcZgNJy4/7Jp+OJHPGI7DWJAQxH+WK26bWJlx6L10AYbE/t4=
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com (10.174.112.135) by
 BN6PR1101MB2339.namprd11.prod.outlook.com (10.173.200.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Fri, 28 Sep 2018 23:27:53 +0000
Received: from BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::389e:3b37:851c:1235]) by BN6PR1101MB2130.namprd11.prod.outlook.com
 ([fe80::389e:3b37:851c:1235%11]) with mapi id 15.20.1143.022; Fri, 28 Sep
 2018 23:27:53 +0000
From:   <Woojung.Huh@microchip.com>
To:     <f.fainelli@gmail.com>, <netdev@vger.kernel.org>
CC:     <davem@davemloft.net>, <UNGLinuxDriver@microchip.com>,
        <steve.glendinning@shawell.net>, <keescook@chromium.org>,
        <akurz@blala.de>, <hayeswang@realtek.com>,
        <kai.heng.feng@canonical.com>, <grundler@chromium.org>,
        <zhongjiang@huawei.com>, <bigeasy@linutronix.de>,
        <ran.wang_1@nxp.com>, <edumazet@google.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net v2 3/7] lan78xx: Check for supported Wake-on-LAN modes
Thread-Topic: [PATCH net v2 3/7] lan78xx: Check for supported Wake-on-LAN
 modes
Thread-Index: AQHUV4HBhjWv+EmU3UuT63bPraRoJaUGVj1w
Date:   Fri, 28 Sep 2018 23:27:53 +0000
Message-ID: <BN6PR1101MB213090E4982A687CC5F750CBE7EC0@BN6PR1101MB2130.namprd11.prod.outlook.com>
References: <20180928231856.3587-1-f.fainelli@gmail.com>
 <20180928231856.3587-4-f.fainelli@gmail.com>
In-Reply-To: <20180928231856.3587-4-f.fainelli@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Woojung.Huh@microchip.com; 
x-originating-ip: [47.19.18.123]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2339;6:r4O8lOhoUbYnKQfQrklHOQH3tHaM/Fp9gta/2kh7XClrTP1jnV4Fp3adrZUi6RPSrICCvAxiAYwY9e4ig+TWCbLdrjqqg+wDmSfx81/HFQLN8g8w2OfYNABTr1LJP6SIRCeM+ajYQ/Cuo9bNoyp2U+hr6T74Q0PW+TqKqvepobDwua1pl9TUWWljkp21Ss2NIPJ/FFqVA3nmtsXcGui+ckZXBAYQGvP11mIP3VZMzeYmdfUCcNCJbS6/000Z3TPlTriU6s60Ntk7W2fqyEFteJ/SW6QbbdpDLl3eWZ9L6Bd27gllKP3u24iSChA0sXPtb04+j48KelUl5nK+kP+VUOcmsYQUq6XZT/9alaBJuN9ceA8l93IYbNLIusQv6y0jnTpwQbPo8Iahj/RqblEb85vmpuFlZdJDyT50oiP+OSvrZmL2sphVW1WiYKWurO2LS9kRskYYhItdDxzj9lJ13w==;5:GzwqkZyv2P4pwO8zSME0QTmt4tcvD6nR64xbQvisLqBZOnDabLaXeBtM/k2SKu9IL5dag4f4HQ1NIRBRcKoQz0kBUrUdxblujrg3i91JVQ+JLI4fWJqB2QTyyn6BOVAWlgo/KhWIelOWS2zn5TE8pM5kMuMm6PTlTjGe0a0d1Oc=;7:IH+Ug+RFp5h0lZO6Y29m7XFaHpWNw1jQt146J8McsG+e1xGGRYHVi9aXd32j31ewP+4PPU7kKqav6TmNK92b7MSJ6yFjmcj4+VK5HY76hif3ubnuxEirGvHwoxV5QK7vUIBgIkRKoyWXnLiy1Uo1jLpdse6jibLa8AwBMQeWE/C7u/XiZEVN6mHwDeSFBnjwOnKxHRTgu2lOzCUPDMKpvDDCguV73I3BwokZSZ0CArj3WdreNuVVxvmJsJ/+5W8Q
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: ee7f03b0-863e-40ec-0719-08d6259a037b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2339;
x-ms-traffictypediagnostic: BN6PR1101MB2339:
x-ld-processed: 3f4057f3-b418-4d4e-ba84-d55b4e897d88,ExtAddr
x-microsoft-antispam-prvs: <BN6PR1101MB2339848344D72A1E28D415A1E7EC0@BN6PR1101MB2339.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(85827821059158);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(823301075)(3002001)(10201501046)(93006095)(93001095)(3231355)(944501410)(52105095)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051);SRVR:BN6PR1101MB2339;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2339;
x-forefront-prvs: 0809C12563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(396003)(39860400002)(346002)(376002)(189003)(199004)(99286004)(34290500001)(256004)(26005)(446003)(66066001)(476003)(74316002)(9686003)(106356001)(7736002)(105586002)(305945005)(5660300001)(97736004)(110136005)(486006)(2900100001)(5250100002)(316002)(86362001)(71200400001)(54906003)(71190400001)(186003)(11346002)(2501003)(7696005)(14454004)(478600001)(6246003)(39060400002)(102836004)(76176011)(81166006)(33656002)(25786009)(53936002)(8936002)(72206003)(68736007)(229853002)(6506007)(2906002)(55016002)(8676002)(6436002)(7416002)(81156014)(4326008)(3846002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2339;H:BN6PR1101MB2130.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: /4d/ehgp74pe1/K4J3nDo3mCsr8qJ3eq8CrRUqn9W33t2j65/xJoh+sjZ/W7Gp8XaR6Imbneg+ec/IWLG2SleYlSbzZgaRhXQVQa4y/QtWSnbpt4XtzeF7dqAH++dKiFD0PPWMCI24sF8gKiRFDzQrWWTTIlU+Kg6sY7apqWEv6FCGqF02/VJqF8LPVOeGTvJqbiHZRf+jhERcgXm9rSGVs9c3lmNy3ecuiMWRV+vhraSWg736185b4p2pwSa9ogRGkuCe/tObDh/NLT6HRMYPQKgf7xkowY0gtjaQ4ZOu72CkZ7WBdNOopLFYdipmJflCLzqaxCDfD8YrQx3hBp4bS/G/llkCMXRNtYU8SYNvA=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ee7f03b0-863e-40ec-0719-08d6259a037b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Sep 2018 23:27:53.1448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2339
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The driver supports a fair amount of Wake-on-LAN modes, but is not
> checking that the user specified one that is supported.
>=20
> Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 E=
thernet device driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Reviewed-by: Woojung Huh <Woojung.Huh@Microchip.com>

Thanks.
Woojung
