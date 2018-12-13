Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B67C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 541792087F
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 12:19:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="nUJGeCbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 541792087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbeLMMTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 07:19:21 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:61869 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728766AbeLMMTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 07:19:21 -0500
X-IronPort-AV: E=Sophos;i="5.56,349,1539673200"; 
   d="scan'208";a="24165636"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 13 Dec 2018 05:19:20 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 13 Dec 2018 05:19:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0E6MZe7AVMAIbZF5s51ZD3myJppDkLkWYQGV6ZJJdE=;
 b=nUJGeCbghQCMvq64VNULcoupbMUE0//FmqcqPY9iF1+GeUnH1tIFXLhLDZRlxX0EnYR9szfyqXsgEXYZDuaZu4fzXi9SUfRFC8O6qurAaAaC6bdKO2MNbP513sgxWiicCNIJKU5E2fFa8bs9Wn0IecPyVxYalYkOlzX6zoRlcxY=
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com (10.174.113.19) by
 BN6PR1101MB2225.namprd11.prod.outlook.com (10.174.113.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1425.19; Thu, 13 Dec 2018 12:19:16 +0000
Received: from BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838]) by BN6PR1101MB2243.namprd11.prod.outlook.com
 ([fe80::1dae:74d9:ffd2:7838%3]) with mapi id 15.20.1425.016; Thu, 13 Dec 2018
 12:19:16 +0000
From:   <Andrei.Stefanescu@microchip.com>
To:     <broonie@kernel.org>
CC:     <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <mark.rutland@arm.com>, <gregkh@linuxfoundation.org>,
        <Cristian.Birsan@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <andr3i.stefanescu@gmail.com>
Subject: Re: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Thread-Topic: [RESEND PATCH v3 3/3] regulator: mcp16502: add regulator driver
 for MCP16502
Thread-Index: AQHUkTmSRQO8vdR2CEWafmmGWx4+QaV5v9kAgAEgxYCAAGMEAIABVgIA
Date:   Thu, 13 Dec 2018 12:19:16 +0000
Message-ID: <2f24d81a-5271-6ea7-32a2-bc2e708521fa@microchip.com>
References: <1544522876-15967-1-git-send-email-andrei.stefanescu@microchip.com>
 <1544522876-15967-4-git-send-email-andrei.stefanescu@microchip.com>
 <20181211164706.GL6686@sirena.org.uk>
 <6a35df06-1309-f069-9b22-8c2cc5cca56e@microchip.com>
 <20181212155502.GD6920@sirena.org.uk>
In-Reply-To: <20181212155502.GD6920@sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0173.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::21) To BN6PR1101MB2243.namprd11.prod.outlook.com
 (2603:10b6:405:52::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Andrei.Stefanescu@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BN6PR1101MB2225;6:yOyI0EyjdMQf38ZMMH+aXE2AOxFAF4F8LmoHmuAhSnvL4rtzTfEE8yYSdxbzxkbaImopso6wXnSoWzNferhtiNen36SBN+ngTiwNYK+E/6XTLOjEissuGRAW10WjBjX18rjAn8nic9OePjp9THEzhDQCWxb9GPM5r2laoL31enmRc2ErpxExBpufCIRikDz8g0b/RI2rKOquU1QrMyYSiR+f1PqKOPWYdrZysFjuCu1j+tH9E+ML9XJkV6z3xGeg5AeSaN84/pHxfqR8MKiqBxcnjhTk2f3VtJ0hTb0mUiLy6CP5Zc5yZCKgP2F8J3lLE7CKoKPOMIJF48UCJysqcjs5z/mP7M72pMoGkpKP51dL4QkYG1tObyAQl8N3PXK2AVJUS1VO4wrEdgpN47HU3CYO3vW0rrbCkv6vCz5LoO+Xu2DYD3LpnXMtSdbQC+ZsfBfX47jBVg1WmTweN8jzFg==;5:VSBLfRwblcaKyDLzwt+EgDQ9zXjDzvVvDJIr1oIgPW1yu63C9cQTW50dHI80AV39KH6sa3ELwrOR+SFUJUBhhVCCFMjQPt80tQ3gKbx3NRM0N8sHgOW8/ilnEu+NdqrFOYQBV4AKuUwSCGrRfqlnk/T4Ia04tMen7N0xfvClXUw=;7:WY8/OdG53aDl6dT1PF2zK0v+zv9BPyinIaDz7fusfQ+TJbQGleqPEPK23c1hm2aFtOvSIwZY1yh+Jp4fn/Oe77sZ8z1v/mC1X7b2frhrsE1qQ4VXrnX38DVz1476cPfwnnDIDJW+skUDwMTYh6SaAQ==
x-ms-office365-filtering-correlation-id: 70e63405-43cd-47df-ca07-08d660f5331c
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:BN6PR1101MB2225;
x-ms-traffictypediagnostic: BN6PR1101MB2225:
x-microsoft-antispam-prvs: <BN6PR1101MB222539B0DAB83B491492C219EDA00@BN6PR1101MB2225.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(3230021)(999002)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231475)(944501520)(52105112)(93006095)(93001095)(10201501046)(148016)(149066)(150057)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:BN6PR1101MB2225;BCL:0;PCL:0;RULEID:;SRVR:BN6PR1101MB2225;
x-forefront-prvs: 088552DE73
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(366004)(396003)(39860400002)(199004)(189003)(102836004)(7736002)(93886005)(54906003)(97736004)(14454004)(229853002)(305945005)(5660300001)(6436002)(31696002)(71200400001)(86362001)(386003)(71190400001)(26005)(53936002)(53546011)(76176011)(52116002)(25786009)(99286004)(186003)(105586002)(66066001)(6512007)(8936002)(72206003)(486006)(68736007)(4326008)(6246003)(316002)(2616005)(476003)(446003)(3846002)(217873002)(11346002)(6116002)(6486002)(256004)(31686004)(6506007)(106356001)(39060400002)(81166006)(8676002)(6916009)(478600001)(2906002)(14444005)(81156014)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR1101MB2225;H:BN6PR1101MB2243.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: PPoc+AD2OasBhAM3nT+H/M/z0irPnDM/Eh9QdMd5NiUAaEcgds9tjMzm54HmQQbUL7z29v4zhEXEzB7mgRPYYk/RsLDn/bsHlRrI55QzkHy9Ttaccyyx606dRlY/LgWpm7DHjJ4e3JidS0Ze2sgv+hBJiVozRlJ0SW+EVhUygaIeXhvUwFJ3UmAy/DvYkFqQ5i1bmgsSndagRRCevtR/0WCdPVPHQO3orh6AwU/R4MPR3+Q3/uRtAB4B82VA49szn4BWkIMdDeNrpePS/WNwAz9i/iaLJe161bF1fThykihPZJLiQj4U9MCRkG+trbI7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <FC19A310035B2F4FBA7E4FC6E3B9DA7D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 70e63405-43cd-47df-ca07-08d660f5331c
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2018 12:19:16.3154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2225
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On 12.12.2018 17:55, Mark Brown wrote:
> On Wed, Dec 12, 2018 at 08:01:07AM +0000, Andrei.Stefanescu@microchip.com=
 wrote:
>
>>> This puts the device into low power mode when the suspend function gets
>>> called but this might not be safe - devices using the regulator may not
>>> be suspended yet so could still need full regulation.  Normally a GPIO
>>> triggered transition like this would be being done by hardware as part
>>> of the process of suspending the SoC.  Is there some reason to do this
>>> manually?
>> There is a line from the MPU (SHDN) which goes low only when the MPU
>> turns off. That line is already connected to the PMIC and it differentia=
tes
>> between suspend-to-mem and standby. To switch to low-power, the PMIC mus=
t
>> be controlled by the GPIO pin LPM.
>> The suspend sequence is:
>> - LPM pin goes high (PMIC enters Low-Power <-> Linux standby)
>> - SHDN goes low (if target suspend state is mem) and then PMIC enters
>> HIBERNATE
> This feels like it should be being controlled somewhere else, if it's
> actually causing a change in the PMIC state it seems like it wants to be
> done as late as possible in suspend to minimize the risks.  At the very
> least suspend_late() for the driver seems appropriate.
I tried with both suspend_late/resume_early and suspend_noirq/resume_noirq.
Everything seems to work ok.

Which one do you think is more appropriate? I am guessing that during
suspend_late some devices may still need to be turned on and that it would
be the safest during suspend_noirq.

Note: the GPIO pin used for LPM is a special one (it maintains its=20
voltage during
suspend-to-mem). It is part of the SoC and its methods for setting the=20
values
do not sleep.

>
> Could you submit a version with this feature at least split out into a
> separate patch please so we can apply the rest of the code while this is
> discussed?
Sent one patch series and another patch with the current suspend/resume
implementation.

Best regards,
Andrei
