Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,URIBL_RHS_DOB autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650A1C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2110D20645
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microchiptechnology.onmicrosoft.com header.i=@microchiptechnology.onmicrosoft.com header.b="e1lm7Gjj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2110D20645
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729350AbeLFJsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:48:13 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:58176 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727783AbeLFJsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:48:13 -0500
X-IronPort-AV: E=Sophos;i="5.56,321,1539673200"; 
   d="scan'208";a="23908969"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Dec 2018 02:48:12 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.76.106) with Microsoft SMTP Server (TLS) id
 14.3.352.0; Thu, 6 Dec 2018 02:48:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfLrTLNAalKo2dkSNPqpJtlEhRjpA84wqep4W8kat3Q=;
 b=e1lm7GjjI4XO/TMHIlczujQXQ28WV0FEOyIEK5PbqTvdPjU4Wd5zdqD1Uyiy1baj6vq4mei/2Hnjz9/xT6YcrUJhU02I0Cra+NPcVCXCbCFDu4EO5rPvur2va4hwRICfJmrLh8lXbBntm4+h44SH9hov++lRqkegnf3M1Q68bEs=
Received: from BY2PR11MB0744.namprd11.prod.outlook.com (10.163.112.142) by
 BY2PR11MB0661.namprd11.prod.outlook.com (10.163.159.27) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1382.22; Thu, 6 Dec 2018 09:48:10 +0000
Received: from BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681]) by BY2PR11MB0744.namprd11.prod.outlook.com
 ([fe80::6c42:c3b0:5734:1681%5]) with mapi id 15.20.1404.020; Thu, 6 Dec 2018
 09:48:10 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <sebastian.reichel@collabora.com>, <alexandre.belloni@bootlin.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Thread-Topic: [PATCH 2/4] power: reset: at91-poweroff: move shdwc related data
 to one structure
Thread-Index: AQHUdPi2R8S5SO7XUE65Fo0kFeM8lqVw7UehgAC6UwA=
Date:   Thu, 6 Dec 2018 09:48:10 +0000
Message-ID: <a0db3b8a-3c2b-02fd-64cc-b490a75b8b7c@microchip.com>
References: <1541416443-4321-1-git-send-email-claudiu.beznea@microchip.com>
 <1541416443-4321-3-git-send-email-claudiu.beznea@microchip.com>
 <20181106210933.GU24212@piout.net>
 <6719a808-e704-3c63-f592-3b90d44ccbfe@microchip.com>
 <20181107172340.GF21694@piout.net>
 <20181205224052.34o3cmh3y3htchcj@earth.universe>
In-Reply-To: <20181205224052.34o3cmh3y3htchcj@earth.universe>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR07CA0166.eurprd07.prod.outlook.com
 (2603:10a6:802:3e::14) To BY2PR11MB0744.namprd11.prod.outlook.com
 (2a01:111:e400:52de::14)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Claudiu.Beznea@microchip.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR11MB0661;6:xOs+TGLc+vmtvayqAUSqp0VSLuM9H/zeWsd3zRpKAILQSefcYdGkQ4725SS6vmDmzUD4L9JyuCDK1KuJeVr7cbGi4Httg5mLF/sVwTZBQwxeOLcuI9RtcmvVnT0MtXOH4tD5eKdZk5veIAgqbBgTQbMemJ2bK9aHnjQFSC6zgc8FLybQrdwfY+FcYHlPePwkToiIfQDWVQQut8HYO1hSB67uPshf0OhT79BiepZLsc4IlF6gEFgRnlAn71RhoJc/Tav4/QsmmirsLIyztncRYkRRdDlRHcx57rh8axIZF9Txh426Jzi3LQHXOikbjGNKkG+LIzIzXfk1EEVWuBJKM72pNMIuP1Ujj89SmkMGYaDhlEyS5BRdVSL7fqhW2O6QMTxTCRCTa8tXShBUYMGFvZTLy68h1iTdbSh9gW+13uhqFyNayT13jBnycwbtkMGhKanKdWmLAfwYSoqd8uu9Fw==;5:cGzsmH7Hxs8z7jPXMeJWIKFL3v8kUzseUZhDz+KK52FZ+kBjX9SYi10AkDmgfCNgFDaMLI2QScHwVb1Gb+wO1vINbcjSi5CU+dhLEbhTET+Or0gvwQz3ejK5DcInQZ0NKPUBMl+Dl/gYKdpytceo6tzMuhbVMn44g+lT4ycLbM0=;7:F0FyB5I3XBIVCgoS74tcMQoJr8ErRXRlWzOqpeOHQB5scpzbelIIx9nCMFzoH4UiYfhp9wb6mQgqnIJ6eGcPePHMNZDQzacrV/dGpZyw4GIiQckz1MK7ifSiMXOCB8gyGeEz2GAzSwrMUo3AmugmMg==
x-ms-office365-filtering-correlation-id: 6a1907e0-c012-4cfc-d918-08d65b5fee6f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390098)(7020095)(4652040)(8989299)(5600074)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:BY2PR11MB0661;
x-ms-traffictypediagnostic: BY2PR11MB0661:
x-microsoft-antispam-prvs: <BY2PR11MB0661A8EC3AC45A697A18243E87A90@BY2PR11MB0661.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231455)(999002)(944501520)(52105112)(93006095)(93001095)(3002001)(10201501046)(148016)(149066)(150057)(6041310)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:BY2PR11MB0661;BCL:0;PCL:0;RULEID:;SRVR:BY2PR11MB0661;
x-forefront-prvs: 087894CD3C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(136003)(396003)(39860400002)(366004)(376002)(189003)(52314003)(199004)(86362001)(229853002)(305945005)(102836004)(2906002)(54906003)(6512007)(7736002)(53936002)(478600001)(72206003)(110136005)(99286004)(8936002)(6486002)(11346002)(6436002)(81156014)(81166006)(446003)(14454004)(31686004)(966005)(316002)(6306002)(5660300001)(3846002)(6116002)(2616005)(25786009)(6506007)(386003)(66066001)(486006)(4326008)(186003)(76176011)(71190400001)(26005)(71200400001)(106356001)(476003)(36756003)(105586002)(68736007)(8676002)(93886005)(256004)(53546011)(31696002)(6246003)(97736004)(52116002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR11MB0661;H:BY2PR11MB0744.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EgJ1fAdEuq8MLVUud0ryjg2c3ZLowCy8XZnpRp0yFlf+3R94Gu9WTLbZXe49eDQsarpQeadA2RGGHLWgVI40aIATDa24sTtVx30OX9YNGGDPW7qpBK+wJkur8Jq5IuwUx4YFrvrJ669Lafe5ZNnUjY0LM0aVOtQ+QoT5M6WZIYWVjEpnYbWCd0vYqi5Fkt5NSJcA14k0eijo2l9iycn/WPU/B6n5m5uO36yUxA/0U6oT3Q+cV6dNUxmPvAZJ5o3zkfDB9wR5mJb7hWR5yig165Khjpo7lyibW9tTGtIFeX6XVq3v3RznLdz2EDHql5xHMCrVkwh6KwsiAQ2KpXbidrAPyLZ1tieuaPZs2C+U9gU=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="Windows-1252"
Content-ID: <D84CF29545773F4AB1BEAA5C00B72BA2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1907e0-c012-4cfc-d918-08d65b5fee6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2018 09:48:10.3985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR11MB0661
X-OriginatorOrg: microchip.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 06.12.2018 00:40, Sebastian Reichel wrote:
> Hi,
>=20
> On Wed, Nov 07, 2018 at 06:23:40PM +0100, Alexandre Belloni wrote:
>> On 07/11/2018 14:54:17+0000, Claudiu.Beznea@microchip.com wrote:
>>> Hi Alexandre,
>>>
>>> On 06.11.2018 23:09, Alexandre Belloni wrote:
>>>> Hi Claudiu,
>>>>
>>>> On 05/11/2018 11:14:26+0000, Claudiu.Beznea@microchip.com wrote:
>>>>>  static int __init at91_poweroff_probe(struct platform_device *pdev)
>>>>> @@ -154,16 +160,22 @@ static int __init at91_poweroff_probe(struct pl=
atform_device *pdev)
>>>>>  	u32 ddr_type;
>>>>>  	int ret;
>>>>> =20
>>>>> +	at91_shdwc =3D devm_kzalloc(&pdev->dev, sizeof(*at91_shdwc), GFP_KE=
RNEL);
>>>>> +	if (!at91_shdwc)
>>>>> +		return -ENOMEM;
>>>>> +
>>>>
>>>> Is there any real benefit that will offset the time lost for that
>>>> allocation at boot time?
>>>
>>> No, I haven't run benchmarks on this. I only wanted to have them groupe=
d in
>>> one structure. Please let me know if you have some tests in mind.
>>>
>>
>> Well, it is probably not much but small things adds up. Having it as a
>> global structure is probably good enough.
>=20
> I suppose I will get a new patch with this change?

Yes, I will send a new version for this one.

Thank you,
Claudiu Beznea

>=20
> -- Sebastian
>=20
>>
>>>>
>>>> I understand you are then testing at91_shdwc to know whether the drive=
r
>>>> already probed once. But, the driver will never probe twice as there i=
s
>>>> only one shutdown controller on the SoC and anyway, If it was to probe
>>>> twice, it will still work as expected.
>>>
>>> I had in mind the scenario where the driver would be compiled as module=
. I
>>> know insmod already does this checking. I'm ok to remove this checking.=
 I
>>> will do it in next version. With this I will also remove devm_kzalloc()=
 of
>>> at91_shdwc.
>>>
>>
>> Thanks,
>>
>> --=20
>> Alexandre Belloni, Bootlin
>> Embedded Linux and Kernel engineering
>> https://bootlin.com
