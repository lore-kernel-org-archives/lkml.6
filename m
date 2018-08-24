Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3022C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:59:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3DED22157F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 07:59:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="W0AHN6Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DED22157F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbeHXLcv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 07:32:51 -0400
Received: from mail-ve1eur01on0109.outbound.protection.outlook.com ([104.47.1.109]:45036
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727490AbeHXLcv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 07:32:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xO9FYLZ9m3bljSlrdrT0Zi8YbRL+wj9zQcKGkMVtf84=;
 b=W0AHN6BpBwyg3AChxftuBIbndRaI4Srm7JVK2/oy/wrjL/+pR6/jZjNqYdGcX6PfiU23UdIaBvMT9hj0EaQ4as6ZDlProel3TQQ/30yuBXB1DLo2Pet9/eDsHb/NPt76fcYCPPElh9F1FYS1qrWQE1EGJxw7pFrmxznWwJ19oc4=
Received: from [192.168.13.3] (85.226.244.23) by
 AM5PR0201MB2452.eurprd02.prod.outlook.com (2603:10a6:203:35::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.14; Fri, 24 Aug
 2018 07:59:15 +0000
Subject: Re: [PATCH v8 0/4] drm/atmel-hlcdc: bus-width override support
To:     Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Sakari Ailus <sakari.ailus@iki.fi>
References: <20180810130359.9882-1-peda@axentia.se>
 <20180824095131.5d9cb33f@bbrezillon>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <da750a67-8739-9153-72a7-7c7efd0ed7ec@axentia.se>
Date:   Fri, 24 Aug 2018 09:59:11 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180824095131.5d9cb33f@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0314.eurprd05.prod.outlook.com
 (2603:10a6:7:93::45) To AM5PR0201MB2452.eurprd02.prod.outlook.com
 (2603:10a6:203:35::9)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 751ea06f-3b39-41f7-8ba3-08d609977d62
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;3:QmbGbZKiDKCnKujeCcxP0ImWOZg5Auepye3mgF7JWjmVhrtOSbvt7MqWovTv5gRbfPxYL992DU4cqBKWljr9iP3l4Djf8YsX+So+lPZeY+34Vsm2kftvLkcAH6TJ0enZN6k2uSIT9qEJzw7G0RzneXiONfNWlKYr32TIlH78yVSeIxJPi/qG4mrT+kwbqnJxHO2VwrhOuwnCGe3c/7cBARJgdQZAnM8QGka7f0YCPjj950DoicqUBQ2ZyDynE3be;25:T7pOr9M1JKwkp8rbyH7kbu26xnF5EOaVgzPq4q68AAxCaKD0xtBpuGW7aveYxwtfdqeJSJ0sCLVU+KyE7azqIyl3ZhWjoKJWKpJ2kK3nV+3rwAO82WZ9qhG6KimbSpHJMQRWvYgzwLw+7t01Im2EsKUalDHLW74CyDKl3aXbKPwvbciXw5sSLq4iL4mIaW6WQT1FmJVGTW9I3iSadnfZ09p4wXV3B0MvELO43twnvnEPHvY1u3nKhKmpOw/fmWhoZqJhOVhx2KUpRMStz/8Tiv70ustrKwzBPh56dnvU+v2H4UfHX4OuT+agE43cHezQdJHMS/FGbAJVNO7I0op3ww==;31:x8N1becSQx+H1cOZV/A4Jbz/aWsIWXBajHzVge5Dprd/8CAY4gih5sJwmgrymWsAPWjRlMSDUVjkn1vh4NxQt2Ty5bpYOGO5Ez6lHTkbf3F9t4A/gAdo+KANhrIebhL+2tVCLO/nXZlMttfkNpM8hhzETTs+2d+uLqd9W6iWAeUEuAjATKtHQ8lxRfqV8ZoR/hRfzVaCSs5wB67h2YP+QSxyJwtn30f+hsKnRPeS8+E=
X-MS-TrafficTypeDiagnostic: AM5PR0201MB2452:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
X-Microsoft-Antispam-PRVS: <AM5PR0201MB245296829692A5C3531E68AEBC360@AM5PR0201MB2452.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(2016111802025)(6043046)(201708071742011)(7699016);SRVR:AM5PR0201MB2452;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0201MB2452;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;4:G0HIju+9gR0pX4oxFyhBIjJRdIqWM5rf1LzADzOPRbX7ZhxHMXSdwU//Y40Kd95M1HGqCvdeLd7ZsycVwpE98gIV0YJimk2iQ+1/JvHojMfsECH6d2nCiT1ceXgciopMdQQQ1ywvPsws0oYw8Z5wdWtDB6XcD2BtEKpkV/JxrF1uRNE7qvDTRDmNVaKa11u/ZbAvzIftFF69TSY81b03wHdO6qNMZ4nmDHiSaLjIRsKsKRfIzBdXfSEiFjUmbKBp1C6i6xPetkfuTRhuQj89qg==
X-Forefront-PRVS: 07749F8C42
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(136003)(376002)(366004)(39830400003)(396003)(189003)(199004)(36756003)(53936002)(6486002)(81156014)(31686004)(7736002)(105586002)(81166006)(65826007)(6306002)(106356001)(305945005)(7416002)(8936002)(76176011)(53546011)(386003)(8676002)(36916002)(74482002)(64126003)(2486003)(23676004)(52146003)(52116002)(68736007)(6666003)(6916009)(86362001)(446003)(3260700006)(25786009)(4326008)(476003)(956004)(65956001)(65806001)(97736004)(117156002)(486006)(66066001)(2616005)(6246003)(26005)(11346002)(31696002)(47776003)(316002)(478600001)(16576012)(229853002)(77096007)(2906002)(16526019)(186003)(5660300001)(54906003)(14444005)(6116002)(966005)(3846002)(50466002)(230700001)(58126008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM5PR0201MB2452;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjAyMDFNQjI0NTI7MjM6ZXMwUkFYWC91REJYa1pRRTFrNkxKcWxx?=
 =?utf-8?B?cmhzOFJYdmxNeFRaNkdRUjhKUnJDbm52c0JDaGNhV040RUd4dnhZZ0xxOHg3?=
 =?utf-8?B?UFk1OFFranVaSDJhek5HOVpZSzYzOTh5eHJwckhqMU1BcmFTUU9velRWejdC?=
 =?utf-8?B?dlMzU3U4dXFpSG00NXo1Z2lSRUFFdlpzNW1NUDhyM212djhmSWpRNEpjRmlp?=
 =?utf-8?B?R2diVSsvVEV3SGpoVksyU2Vab0xoc08rV004UWd4Z2pKOEkrRjlWNklYYnlR?=
 =?utf-8?B?QzZSV1B6NUxaejNzc0kxR1Q3TStRNFBTWERLN2gyNG0veU9IZ1FrWG9HOXpj?=
 =?utf-8?B?M2tnbDNsK05velNwYi9SNjBkbGxlRytpSkVCU3ZkbGQ2ZnMvU2I0RGQ2K0F0?=
 =?utf-8?B?MTFhSlpvYW9KTERnRElmY2dXbERvck9IWi9RUFlXejd3VmJGYVBCTTJncElN?=
 =?utf-8?B?c0hXa0F2TWVQY0UzRjdkTUlZSC9EaERtT05xcUdGQktNUFdGczJQZ0cyMEs1?=
 =?utf-8?B?OVFydXQvWXl6VVFlSmxsbTkwSVZscnpJTER2czZBdzl0T1gyZmpBM2E2U2Rl?=
 =?utf-8?B?Y3ZucHhWSWtMZGhUSXdkeU1pS01lNjdvdlN2bVNXRUVCNnNjM3lZNDlGbDVB?=
 =?utf-8?B?Z3NCMmtpN2NyUFZxVkhsRmJMVWgwWUU3alJWbzFyMWEvWjd0UXY1bWVYdE9Q?=
 =?utf-8?B?a3ZwZmIvRUYzM1F3Y1hpZVhlc0dsRnUrWUZpSUxVejhNY0l3VGJuTmdGYUpj?=
 =?utf-8?B?cTdLQUZrWjZlZStGd3dFNFgydUdoZUtWcGVGN2tEM3AySEp5RUs3eW9Lc3Br?=
 =?utf-8?B?QXFMUForRVZtdkJJeEUxc0UySWVFNGNFVGVsenJDeFEzUmMxbTNIMElHK3Az?=
 =?utf-8?B?a3JsYlRaZW1YSys5YlM5ZHhpRGFpRC9mMDduaWs2dnIzbXVLMXpaNW5lUUE1?=
 =?utf-8?B?QXlVdjNnTlptbGVEbklSWFpWbHNMTDVTZGdJWVkzRll4WTlSbHpON2I4U1Js?=
 =?utf-8?B?eDh4UzM1RTFGRUY5YzFJVVdiSlpWK1dBMWZERGlEWEF4OWNlaUFKWVgvUXhn?=
 =?utf-8?B?MHlmKzhhTkY1VXl4OEdBTzQ4SnFVeE42S3BJS0pDUUdLa1QxZkFhb0x0Mmg3?=
 =?utf-8?B?TlZVNXdpWnNjU3ZySTUvcWJwbjhDNS9XQTNSVE1heFZCKzdwOEFOWEdLTkpZ?=
 =?utf-8?B?bG1vMHlZUTdoNWQ2aVR0ZlFmSWp4UnJxVGpaWUIxRTVCQ1VTTWdBTkNoa1cr?=
 =?utf-8?B?U1RvY21LVzhueEVDajY3d01rbGJ4QjVGNlkrRW9BRnlVeUhjbzQ1WGMyZkRK?=
 =?utf-8?B?YnZ6a1g4U2VxZjBrUFhlamgza1A4VEV0S0p4R0lPSXdpZ1RObjREZXIxd2VS?=
 =?utf-8?B?cVk4L1lZZVJZTGFzUXJoYldhMVlHeHBGU0UwYVpYOTdEV3pqRWYrbk8yOUpM?=
 =?utf-8?B?ZFFlMXF0L1dmekFVNUFsUWtXRmd2a1NKYld6clVFK0FpcnVaQ2RBNXBVbVpi?=
 =?utf-8?B?VmdSTGxtUi9tYnFhdEl0RjRXbUdYUUFiSXdGcG9zdVh1djVsYml1eFVFcVox?=
 =?utf-8?B?bkUwb1BTYXpTNTdQSFlvNSs0SVdzWW5xMURHZ1N3RHFRVDg2bU5adTFhTk9J?=
 =?utf-8?B?OStqK2VKbEFMSFp1ck9KeUJuRHhEWjN0NGdObkQrbVRYRkptb0QvOE5HTE1x?=
 =?utf-8?B?RmQ2ZWQ3MXY2M0NKMG4wYWt0bmROc3dKY2dRbnJLOFF0YXRZUFRUNW5JUDhK?=
 =?utf-8?B?NHV2c2tJYkpoNktIUXdWdEltTWYxaGRIMGhWQU1BZ0tvWlEvR092L1lwdXNt?=
 =?utf-8?B?RVU4V292QjcyMUtmRXU1SHVjVzArc3dNMFA0V3pMNWZCTzRKRlphRjJIN2JT?=
 =?utf-8?B?RDlPdWdYcWhoR0RSeERteFlvOUtXY3NoYWhqWXMrb2xIR0tzV1dtaG94aU13?=
 =?utf-8?B?WlRMaDVNSlJ3cmZZT3F1dEptU2ZMdlh0R0pwVVp5V0FscHdtYjMxLzdsS2hY?=
 =?utf-8?B?OElDQVFCbFBmU3RXYjlrMi9oSWc4djdUTmh2WEFVZnZUb0lHNWQ4V2ZtcDJx?=
 =?utf-8?B?ZXh6UGpxYmNsU2hhelpwVk5vSzNaa1Q3c0s3WHZLMDhQTXB5N21NQ1ZJM0ly?=
 =?utf-8?B?a3hHSzlhNlc4eUVZRnhWOUlkTnZjVWJsWFl5NkwveFBUY25wUE9la1lHUmV5?=
 =?utf-8?B?enZvR2EzTUdMQ2NJRjZBeThjclBXWXc9PQ==?=
X-Microsoft-Antispam-Message-Info: YCv6mNqhqEUkoWVXQfXjrz8bf9D68vhiNh/GhSepNmpw4KiHATazH5rAtt9eeAokx4j7qjsTmb0zjFpbb4JcdK4f5FGlXjK0brMwRVEiXNaA1BtH4MP3MscQDseRmmw+rMmcSgLI6NOPCKC/+NLHKvr7To2AuZZv4oPtOPMvNb8NxcAqr8qep47rgKISP7mf7Ewc6Aesbuxli5fFaRrldwZkZZUia+yr3qRZhMYfL7hTndOLePyb1HRmLscxV8mjEWXcJZjH+rExzvF5e0ICaQMBOi0urldq7LVTJ3daNBlBBkPgjb/sbWF8Ze9EG+/KRIspWNW+QDNkwIxKRDZqM50wvLaxyDhUK2STVlVKBEo=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0201MB2452;6:iogE641wuKyyxl/yN9FEk4Q5T3kLHWD1ZRzQ0UfAEH9tt7Dbda51vzbRhN3R2qoNwvlj2fwTjKtMB/QSK7BHJemZFd1slgyY9hSKLhvONslsQZy1scIRk8qHlaCFw8jDsayXPDBv5j3NUO+ceAC21NMaUTzIGO3DKLnWHcRl/S4uFBeuNqzIVe8titZwVZOcs0GyNIAvSpt6ubLUmEYthTEznBoPUDhhSm1DmQDI3Zw+jF5/pVAYdIyNRf1qtTqao7uam7QETai/1vJpfohA8uQ6jVCoy+OILoHsaWfHQrEmzj3oWe6LpgLvq//0/9IpkyO/bdOyIcE9NNLZr9G6DCEVg3fmw94S5hQJWINHWyVJneabM+iLb4iczxXhUYNNHCm/SplQcdsTm10s5zrsZc9rKEA4zOkjJw5+OZHT1bGUzoBpcJ5N9WgymwJmtVEKV6P65oOi00oYTmLuqgsvTg==;5:o//tmYvsXO3qyWsiensWVLbrl7h1v5QoLNINbKCcM2Ixn1ehGYCAMxXVonoddH7m3M0arHYPVH1+UVHq5w3cCMaZYAtGEMzbRDO63l+UpfdYoB6PuhhtXmDHfl3ivza7HZ4RzcDdx7wlOy0Obvvaeyux0PUAhiwsnW6e1TIkJgU=;7:KpQ14OYDegds5N99IeLDO6S8nIVWtLCMVvQvHJ4jgqKWafuRKlpfV6nZFJxBxiU2DrELtSU9Ym4lq0h1+DRyHmyEnpPXOby+Pa2AJRqppAKh7++I71aGhkvTUGptq356KaHxexVm2klVZt87ds+8q7+n8AgOz97MhAQd0GU+VWEOKU3ewcgRreEUc85Pk46TN0Z22aZJ/ihycKPJaolp2QPWI+vs7iwEKMHlvcKEv+i5ma3zrE4ale+FokiED1ct
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2018 07:59:15.8138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 751ea06f-3b39-41f7-8ba3-08d609977d62
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0201MB2452
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-24 09:51, Boris Brezillon wrote:
> Hi Peter,
> 
> On Fri, 10 Aug 2018 15:03:55 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> Hi!
>>
>> The background for these patches is that our PCB interface between
>> the SAMA5D3 and the ds90c185 lvds encoder is only using 16 bits, and
>> this has to be described somewhere, or the atmel-hlcdc driver have no
>> chance of selecting the correct output mode. Since we have similar
>> problems with a tda19988 HDMI encoder I added patches to override
>> the atmel-hlcdc output format via DT properties compatible with the
>> media video-interface binding and things start to play together.
>>
>> Cheers,
>> Peter
>>
>> Changes since v7  https://lkml.org/lkml/2018/8/4/288
>> - The ep device_node was leaked in v7 patch 3/3, so add patch 3/4
>>   which simplifies fixing this in patch 4/4 (and adds flexibility)
>>   and adjust patch 4/4 to the changes done in the new 3/4.
>> - return -ENOMEM on allocation failure in patch 4/4
> 
> I stopped following the discussion at some point. Are there any open
> issues or Ack you're waiting for?

The only worry is the silence from Rob on that multiple-endpoint
discussion. Since I don't really care deeply, my plan was fix up
the of_node leak in v7 without using of_graph_parse_endpoint. I.e.
drop 3/4.

But I would have prefer Rob to add some final opinion instead of the
discussion petering out like it did.

Cheers,
Peter
