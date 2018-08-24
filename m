Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFE5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038AB21568
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 01:03:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=maximintegrated.onmicrosoft.com header.i=@maximintegrated.onmicrosoft.com header.b="y9aINEoW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038AB21568
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=maximintegrated.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbeHXEdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 00:33:00 -0400
Received: from mail-sn1nam02on0090.outbound.protection.outlook.com ([104.47.36.90]:19232
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725951AbeHXEdA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 00:33:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=maximintegrated.onmicrosoft.com; s=selector1-maximintegrated-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hahp1p7Vbl//PXPHVQ05Qtxh3ydpMXNVVPCGdgZ3A2g=;
 b=y9aINEoWbsLElqs5sgCEqa5f/j0GEC+52vIrWseN4BqXUBUqdeP6r+1dcDp/MZkHQency/eg5C+2O22hWml1wzuj8lnsGPkaWNOSmMmao4tyqm0Y4bJOGIBV9ys7BCM0c6y96BI692aQCDE9S2FgX9YrpaqekzHZuFlIHX4zGYk=
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com (10.164.166.136) by
 BY2PR1101MB1208.namprd11.prod.outlook.com (10.164.167.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1059.23; Fri, 24 Aug 2018 01:00:43 +0000
Received: from BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::590f:de4c:57aa:e969]) by BY2PR1101MB1126.namprd11.prod.outlook.com
 ([fe80::590f:de4c:57aa:e969%5]) with mapi id 15.20.1080.015; Fri, 24 Aug 2018
 01:00:43 +0000
From:   Ryan Lee <RyanS.Lee@maximintegrated.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "ryan.lee.maxim@gmail.com" <ryan.lee.maxim@gmail.com>
Subject: RE: [PATCH] ASoC: max98373: Added 10ms delay after amp software reset
Thread-Topic: [PATCH] ASoC: max98373: Added 10ms delay after amp software
 reset
Thread-Index: AQHUOnabmEeGGJCKvUqoA4kk2HWnO6TMfDkAgACceoCAAO9xgIAADhLw
Date:   Fri, 24 Aug 2018 01:00:42 +0000
Message-ID: <BY2PR1101MB1126A78A4E53E96E892AEBAEE7360@BY2PR1101MB1126.namprd11.prod.outlook.com>
References: <20180823001519.20056-1-ryans.lee@maximintegrated.com>
 <CAKdAkRT-71tL7U1t_WMenh5kquppsZpiL=0bEyL4RLjj622zqw@mail.gmail.com>
 <20180823095107.GA5207@sirena.org.uk> <20180824000807.GF53155@dtor-ws>
In-Reply-To: <20180824000807.GF53155@dtor-ws>
Accept-Language: en-US, ko-KR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=RyanS.Lee@maximintegrated.com; 
x-originating-ip: [204.17.143.20]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;BY2PR1101MB1208;6:xST/PJ7r5OA9VqnM5Neo13JQKLMLAWubk9dv9OW7VboYAo8XEqpuyqT71CSnpo+pniHP6bE0W0VxJxTY8bRyJ010dQCkNB0E7S1JxhY4dzacl1o+Eb8PyvVdWOm8I9LEJ8L32mkEqf+obV/hNj715h0fhcETBxCO/5ChEWews5Uo9KG3hnAlUQXBYxCpq1zZykSTHoUgeciPinGo8Dp6iRqNK2eKGrju//+i1XJt3YvLwj/7WevDeQUiQKqYxgscy1+LFpd7kkTnD/J7kjX+vfH8y8TuKJuQO86BUB6BtmaXTA2YFv1DNFt8+eQF2qKMJOxKJDEyrSDEGn+2Ug3FPlLKl9MNoAv63KE80pdZuC864GdoAD4417mXZge7S/UvCRtgpss0pOWQ0HT4UnCquD1/kOeIFMG9gmxFQVDcG8rtG+YibwSO7J8FnfAVczuF0y3vzx7KYNQX/dI+CENXmQ==;5:Kes77RjIkvGxRQm8VwiElV6isfVacJ9ORaQmcJhaLTynfVK8zpDvPaW0pkQd3IJgZjXZIEASguo9d0kbriN3V6Sl9Lc1qG1UQ5ChUDoFeVCndg76U/jpbAW/JkL0cLErpKVLG1Y8JwHLBvKsQ1NSGdJ9IbO+nAIHBc33mwMoG+0=;7:wI/FGbG0kZ3DtSlNAHQkRSzExlr0DeCow8T/AsWScjA4ACt52JAVXo5UUxrrPzZEVMqw4u+cOKbnuYIho2vdlZORSfIxuqxoNjqeDRFg0nWRPw3jE6TFaUMSiqLzQwmk0WwZgOSuJJjUJvw01hReJoQPz9F02DQc0t/f0c201w2do1lQgki4LvHUH2y/pu2Vr7NYb9Q2FYr7NH7mTaostqeLCjSVtDEVUV8dKoOcT9y3G/8+5Ikt4On6sZIw+ot7
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 35d0d0d9-1f9a-4f48-eb20-08d6095d0490
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:BY2PR1101MB1208;
x-ms-traffictypediagnostic: BY2PR1101MB1208:
x-microsoft-antispam-prvs: <BY2PR1101MB1208F808AA6D73F1250F59ABE7360@BY2PR1101MB1208.namprd11.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(9452136761055)(85827821059158)(108721460000369);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(201708071742011)(7699016);SRVR:BY2PR1101MB1208;BCL:0;PCL:0;RULEID:;SRVR:BY2PR1101MB1208;
x-forefront-prvs: 07749F8C42
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(136003)(376002)(346002)(69224002)(199004)(189003)(13464003)(5660300001)(14454004)(105586002)(9686003)(106356001)(53936002)(3846002)(6116002)(86362001)(33656002)(68736007)(8936002)(5250100002)(66066001)(2900100001)(8676002)(229853002)(81156014)(93886005)(81166006)(25786009)(55016002)(478600001)(305945005)(74316002)(6436002)(72206003)(7736002)(316002)(6246003)(4326008)(110136005)(54906003)(7696005)(76176011)(6506007)(53546011)(26005)(99286004)(2906002)(486006)(11346002)(446003)(102836004)(476003)(39060400002)(256004)(97736004)(186003);DIR:OUT;SFP:1102;SCL:1;SRVR:BY2PR1101MB1208;H:BY2PR1101MB1126.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: maximintegrated.com does not
 designate permitted sender hosts)
x-microsoft-antispam-message-info: HWjnb9t417nnhf0thVLabnnJ4SNr6RSw5BfFc6aZDt/CLHtgfj+uflsrqndkeJK9s3FfKkhiqqsq/9ixhHwteq/Vj4Yj6bdoqLxvT8VAZ+wfAxGX69UN0ZdnJXWieGYv0I8Q5o43ZYfyc2vk3yyBrzfkCqJNnaISkpa4ztrXY8IAOPlHEqGs5I/zOi0p+U/srqkyZjK9HJ321LTp2yKdXc+RlloJK+CjrxERCFNiD0qAdp6PKKb1Kx9cY5hnRmnHZWfTacHXLAOztait7kLpeHiq5n7DuhqLobGr99HjJXUK5QyQzYJ2LoUSa3Gi3Yt4t878vWxR+JDc7HFwDpyYkS8uaqKLnBOP9HfQ7ZrY6zY=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: maximintegrated.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35d0d0d9-1f9a-4f48-eb20-08d6095d0490
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2018 01:00:43.0531
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fbd909df-ea69-4788-a554-f24b7854ad03
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR1101MB1208
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>-----Original Message-----
>From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>Sent: Thursday, August 23, 2018 5:08 PM
>To: Mark Brown <broonie@kernel.org>
>Cc: Ryan Lee <RyanS.Lee@maximintegrated.com>; Liam Girdwood
><lgirdwood@gmail.com>; Jaroslav Kysela <perex@perex.cz>; Takashi Iwai
><tiwai@suse.com>; Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>;
>alsa-devel@alsa-project.org; lkml <linux-kernel@vger.kernel.org>;
>ryan.lee.maxim@gmail.com
>Subject: Re: [PATCH] ASoC: max98373: Added 10ms delay after amp software
>reset
>
>EXTERNAL EMAIL
>
>
>
>On Thu, Aug 23, 2018 at 10:51:07AM +0100, Mark Brown wrote:
>> On Wed, Aug 22, 2018 at 05:31:04PM -0700, Dmitry Torokhov wrote:
>> > On Wed, Aug 22, 2018 at 5:21 PM Ryan Lee
><ryans.lee@maximintegrated.com> wrote:
>> > > +       mdelay(10);
>>
>> > Is it really necessary for the CPU to spin for 10msec here?
>> > usleep_range() would be better solution.
>>
>> Or msleep() for that matter, it's not going ot be the end of the world
>> if we delay a bit too long.
>
>Frankly, I'd rather we did not introduce extra delays. I do not know if we=
 use
>this part, but on ChromeOS we are interested in shaving as much from the b=
oot
>time as possible and 10 msecs here and 10 msecs there do add up.

Thanks for all your feedback.
Let me apply usleep_range() or msleep() instead of using mdelay().

>
>Thanks.
>
>--
>Dmitry
