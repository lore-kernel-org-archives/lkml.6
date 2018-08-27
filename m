Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D95C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85E9C208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 20:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="V6pl3HNA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85E9C208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeH1ATu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 20:19:50 -0400
Received: from mail-eopbgr50124.outbound.protection.outlook.com ([40.107.5.124]:13262
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727029AbeH1ATt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 20:19:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uH7/vFqZ/CQkbfIWPa1QC1Uc++vUcGJKQPiDlX4viQU=;
 b=V6pl3HNALkk2NGeMr3/WY62IPBKPZ8H+FQCZ/DFtPfSLQ5n6HC8AufYys69fAJeDoUEVpo2BknbccN8J8n+iUfBDl6CM7CZxLFgOBI+wNBsO6b9nspVINb9y+jRJcArIcRUr3WUL2OY1Gkfj+jiYZdhPb31bidgLOYMGEf44d4w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2457.eurprd02.prod.outlook.com (2603:10a6:3:81::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.14; Mon, 27 Aug 2018 20:31:27 +0000
Subject: Re: [PATCH v9 0/4] drm/atmel-hlcdc: bus-width override support
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
References: <20180825085620.10566-1-peda@axentia.se>
 <20180827212449.723bdc99@bbrezillon>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <ca38bd82-09d2-8e55-a3a2-e0e559abdf7f@axentia.se>
Date:   Mon, 27 Aug 2018 22:31:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180827212449.723bdc99@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0402CA0051.eurprd04.prod.outlook.com
 (2603:10a6:7:7c::40) To HE1PR0201MB2457.eurprd02.prod.outlook.com
 (2603:10a6:3:81::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c1240dc9-f562-4557-c4d4-08d60c5c1119
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;3:6eq1/Q/NqH3Y/4aKTr42Nw17HNZU5BmzjWgq3D80+KJezGxZ5b+DQi/Mr6wtin9mgPIcHIm9B5Ezn84HcccxhYbWBQkWvE0CKDSUjl7D3NE8gNy6hLMl5V/jvR7tTMECSxskBef71xBSkV8tnJ2in9V76l4jp/04vTh9mhwWUxAQd+VrtXa4yQYzZJ2QnFN2V4j3sQPPiPrVyyb/PthJwcUJS3p/geJGSMgN8KsobJXwi2cCNQkhkMmWePhHCm3q;25:KwdIvYMuViyTPfH4T50waYIVrjwLqwtXqFi5F1Ty2/Fxp32tmgsAE9xlRSx/LCTpIqLQ21FOKNh6JtvOLGiw4jqnadxGJQtt3QBOCaatBQJs3/JsZKwidR4mwfhgDaA6I3OdTRNxN0ULUKvi/i01/djLiVN6E3YN74h6C2Tx4wcxJQ0GldaAXVtOXflkD+lDZVccVKMfRl7HSReUXBPHnNNfpfSE+JvuHnM77iFo3XPBPHv9hBy+ssj2ZG2lS/H5V5jxWxM6AqNhXpmHjX6N+zcRZuDZBvl8CkM0fQTL33L6tUNIIa9aLhf1g1ciXyuOJDfEP7bx7WWtB+WM/Z7e6A==;31:XRour9B7lLAbekFM58HCriz4Eqk/oXy0czHeJ1V/sSSKmyzGtstkqRm+DEqbqLHcrXDkL+k8tVvqbGEsLhJbbto6kpZd5vUe3uC56GYo3zndKhXT3sOlnmocAShTFX8gfhKGI+7/bmcK8xqv7jOO0J7uSglrOgB7/NqCZk6xY+QHR1M1LNQb6H+h3KmHHgaWJswFS/0Yq1wfqUnK6QhFpdej+HD+LuqqA8dFeZXOArE=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2457:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB24578BB30802140829946ED1BC0B0@HE1PR0201MB2457.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2457;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2457;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;4:t7ej9aiBVUD8pd90FFcI+4IITiQ/ceMmSTUR8Hfnqf3oKxMO4rkkBKnZU/pLaQiH4XG7Loi9nVYmpRWJg6gCOfm6JTaTbE0pYLcbaodQaOHoTL1sQl2ZUKq9q0yDV+rqnHIOT6uEtxl5lxm3r7vfHwzS6gLs53G4Rg2pGmnxsVgKuPa6HfwZGKYNkFpRN5R2MGjoPKlQvcoL5KAr2D7CZXYM64DBJu9T9Zi7u/k8ybsDtTno272o8X51fSfFRz054EdV3zrZ+1L9Zcyp+ZbeOg==
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(396003)(346002)(39830400003)(136003)(376002)(199004)(189003)(23676004)(52146003)(74482002)(2906002)(8936002)(2486003)(54906003)(16576012)(58126008)(52116002)(66066001)(65956001)(65806001)(64126003)(76176011)(36916002)(25786009)(53546011)(2616005)(11346002)(316002)(26005)(386003)(476003)(956004)(446003)(77096007)(3260700006)(486006)(86362001)(14444005)(117156002)(478600001)(186003)(966005)(106356001)(16526019)(5660300001)(6246003)(31696002)(105586002)(4326008)(65826007)(6306002)(7736002)(47776003)(31686004)(53936002)(229853002)(7416002)(305945005)(97736004)(6486002)(230700001)(50466002)(8676002)(6116002)(81156014)(6666003)(6916009)(68736007)(3846002)(36756003)(81166006)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2457;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTc7MjM6bVhwM21TS2xXUGk1Z1hPRWtwdlB3OU5R?=
 =?utf-8?B?NHBaTmFKSkl5SlM3aldDT0hmcVcrMWhEVGtKdklUVVhGN1A2eHg1RTI2bTN0?=
 =?utf-8?B?L1N2Z0hQYWZRRUhnMy9XUlRjanFWZk8yVmxqa2NTMzdKYWRtemU0eEZSWEtq?=
 =?utf-8?B?eElEUG9kT1ZlSndzbVhsdTBaanNwSzVwNWc1cytKNlpMZ0ZUUzhXdE5MQVlW?=
 =?utf-8?B?YkNlYzYzb3ZrNmVLYkFYUW13NzQzRXNYS2svQ1QvNThiU1RaMEIyMG05NHVH?=
 =?utf-8?B?eFpVbXdVNzVNaUgzTldyQUdTeHExYWFEUmllUXhVUGR3ZDBTT3J0L0d4VHNS?=
 =?utf-8?B?emdQcU5SYXVJTVNZQ0FTc2dKWXQ1V0EzQ1NIVVJvZjZmL1lQbjg0SWtFUVBT?=
 =?utf-8?B?Nkt0QXpyaHVqVmRZTzdGdWZyYXN6NmR6eFZlNUxKOFZBcDVoVnMyNVBrTWJI?=
 =?utf-8?B?dDB6UVJLOFlBaDdGckI5YjZ2TUZmUFZhRVJhSDBXUGJBZTlUVUFVQVNiTUdn?=
 =?utf-8?B?NTAxNy9Gd2QwVmhIT0hhTGE0OWdNczhkRElKVFdvNloyd1dUYVVHZ0xiaHNK?=
 =?utf-8?B?NnpIdVVnTlN4NzlORlA0bE8zcVc4UzY2SDBQVFc0cEZUMFdaQzBraW1UTVBq?=
 =?utf-8?B?K0hodFI5Ylp2SUJKMVY5SXIzcmNFY1loVzVmOEYvcnhtWHI3SnFUQzFNUTEy?=
 =?utf-8?B?eUpRbmlOQzQ5Tk1jckR0ZkthVjBJc3lPRHpUekdvNE9OVVhQenVkeVkwRzdN?=
 =?utf-8?B?QWpzbXpveFA2dE1hQXZqcDdLRm5tbFNDRGNReSsxR3FJcHBjQk1PNnNMRUdS?=
 =?utf-8?B?QkNHWVRUSHVwZHlGaVhDR1FFbWZOOEZKdVNQZ3ZhMXo3V0w5aEdDbElmZ2pi?=
 =?utf-8?B?TVVpV2tGYnZRb05HbXRqT0FsSWZvb0htbFhrbU9abHVEZFEzVkdiTjc3TlJ0?=
 =?utf-8?B?WCtpTmRJeS9VTjhJWlB3MUN1VC9McFZSUnlrVG0rbzlBaExBUE1mR0poMTVG?=
 =?utf-8?B?SWpOUXZ4M1F6SE44K3d3YVpmOVNjOUFwQko5UzBGTTdOcG8wcUlHYmdxeTNm?=
 =?utf-8?B?Zy8zWWNhNDBKZEN2dkl6ZDFEVm9LNGN4dDBXQ1FnejVXa09mRjU5RjdZNmMr?=
 =?utf-8?B?R3l2aE5KaFdzelduTERjZGpWV25sSUZnVHhHckRaUHY5NysxeDcyV212N3JJ?=
 =?utf-8?B?UTJhMFY3ZWdOREhzd2IvaVZVRVZxVkZjU1pOWDRiTnFpZE4xZ1hCeGtHbmJv?=
 =?utf-8?B?K0p1bWtOZ3NWNytsK2wwalUzOS8zcE4yNGJVS0l3VzZhS29nNGEyYVVXNGZH?=
 =?utf-8?B?N3djbFJ3YnY1MmNEb2NWdjVza3FRSS9Ta0ZydlM2S2FNaXhtR1dMeHZFSTQx?=
 =?utf-8?B?RzRzVmNYNmRzYStkS0tUVk90VmF6T1lNQVJGL2JvZUVld0MwUlRNRGRJZlBu?=
 =?utf-8?B?VE01bCtMNFVkL005eUJpZ3VFYThqR1hpdkJackFLWVl0NWFLazh0SitJbFQx?=
 =?utf-8?B?M1l4R1psMmpjV2ZJd09lMDhCcUFsWDZNRXA5TS9maFNqZzBoZ25nOXBDakJZ?=
 =?utf-8?B?UFpVWkVqQXNGU2M2anNvQUl1RU8yRmg5eTJwcGlScjdlNEtTYVhjbW03c3g0?=
 =?utf-8?B?N2drV1FLM0srS3h0a0ZNbi85RzgzTXZmckJCd2UyN1JvZGxEL01yVGEzbVVE?=
 =?utf-8?B?RHNZeFlSZ2dFN1k4cW1jVGN4TW4zTFIwNDFrZmM4ZXJiR1VXa1R1c1U0aGsr?=
 =?utf-8?B?WlpNeWFlUVhkWjRaNVIveFJ4NHlJOHd1bkplZzRpbG1WMDFMQmxpSzdiUG1M?=
 =?utf-8?B?WlA3QWZydVFQVFpXK1VoVW9peTJ5NzdOM3ZYUlRNbXY4RHZRNUZrQTArYjQz?=
 =?utf-8?B?Q3ZNbjQwcTRNMnkxdTNLYld4L01XeWhPV2h4QnlkVEN2UHM0VEhzSXUyQmx3?=
 =?utf-8?B?TVBLeUI0eVBGa0JBbzdSSWtrYldYUDYySFRFbkdFYXVpaHZ6R3E1RnNKNCtt?=
 =?utf-8?B?UWd2R0tRZWZrY1RmU2k0Q2NXa1BzZW5TaW9xaGlaU3Jqd3NER3hCekthNVhK?=
 =?utf-8?B?am1CQ090dWRYelFyT3RMWEtJeEtyNndjek5MLzdHb0E2OVFMK0VUNVduOWpp?=
 =?utf-8?B?SnpRNzBjdUlnV0xKQmtwSXppdVlvaldUWTRqZG5YcG9oY3AvVW1QbHZ6MWxP?=
 =?utf-8?B?MzdxcDhjQ1N0ZHlaVldNb2hpZ1U5SWc9PQ==?=
X-Microsoft-Antispam-Message-Info: pZ8hxruNu3LO//qJDSe4wkA8fS/G4a0ANpmli0RtemFfoS+P1hYTx8lLp/F87CRfDpnpzC2nKFw1m0tJYjmZ3WqdKhPi/956+vcxq3a6a5GAbhGrwvt0DsHyUyhM98AeiXo3bz/j2qI1LKaX8/ySXnGDvHeBpVc8gI3m19bolqnnXMcMYXogJ2gumjh7DLoWtGcrXGUQfYZKcWhJuJ/nU499/3wCtJTOAExKt2eYtyjjPEoLZ13G9Q81fCbb2MFSn4uJA/H38LSx6Pxi/Q0LnivTWyMcHcsGcDJ+p/2iZtMFrx3SyrHR3+qoQGtu+r4bwcAwm0eC4S6JAI1a+xFv9Q==
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2457;6:xonDV3k+BenjAyjTSC2pl7y/9ui8p/wZkh425W0YS3h6/aJ1Z2BUj22jgYqpvFVmQTbnBwff1rqGA0P3TLcfi1ECFMA/xFoHpTz5An0k1fdOgRcd3wXRf3NTfVqt9CWgFW4VR7ev9fI/q/WqHiWLbo6pivTrhfr+slTJjOfOP5ENAqI2dAClM83t0ZX7fdZYZojg5r1QaRxfkylLCF9wMkO8zDN4Ndm2/A/sYmhjCF/SS8DaTsoYPr+1CnGe0j1w41sGy8KI6Tsecbkvnx8tky67upHzc9DDt3Zdcb8o4a/2KcTCvDhrIxxv5McKay/lWv5pFqLO9KlYbJ5oShIlV076RIHknlsOv9nRVy/6K+AZRPNNua15B9b1Px3C6VQUkNqukyhmcsBjMxRJ/btDDitFkQbgrKVjsTFxAtjDOVwvVm71txeMrj93nSA8ZOU6wrSpSZvWDtwYwT8Q8X8Xwg==;5:oF0HH/wdmkh/GjYOty8WytMfvyE35P4XpVd9VZmD9ulxzouPje+8UToGVCngv26M2TIrx5J8jJcJ3jggOJk4+JizSo60YoJA3yaUXrvmKIUHWkLfkEzuvnghJrvzn1oCecjWYVFpNFNBQxchU1dPB2a1EhShhtO1EKzjAD5xYYE=;7:gzwi+D+86HL9FbE7RkyvLgRBa3AduErlx2qcUjPmfUV69HWybJ8nGOsEoerA4GnOg+z9ttgES/WoMmqsEJ+S4o0kVhMDShr9JFtwhHL2/2C8nVL+Owxb12LXEEb4qR2KYY7HlSRQmlR+7vt0wmfHB9JGx3R2y27V9YZo52ITbJxCCoNKlMFJaSHFR4R2XkfH22ACmYZnwjZWEftXDxQIiovcFLZIoSP8rjxG7PdVPu9FLiiM83fXMUcTOvNulmiT
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 20:31:27.1760 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1240dc9-f562-4557-c4d4-08d60c5c1119
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2457
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-27 21:24, Boris Brezillon wrote:
> On Sat, 25 Aug 2018 10:56:16 +0200
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
> 
> Queued to drm-misc-next.

Thanks!

Minute issue, you seem to have some spell-check going on or something,
because the subject of patch 1/4 has been "corrected" from
"...add ti,ds90c185" to "...add ti, ds90c185"

You might want to evaluate if that auto-correction "feature" should be
disabled/tweaked/whatever...

Cheers,
Peter

> Thanks,
> 
> Boris
> 
>>
>> Cheers,
>> Peter
>>
>> Changes since v8  https://lkml.org/lkml/2018/8/10/309
>> - go back to the solution in v7 (but the ep device_node leak fixed)
>>   for patch 4/4
>> - redo (part of) 3/4 w/o using the disliked of_graph_parse_endpoint
>>
>> Changes since v7  https://lkml.org/lkml/2018/8/4/288
>> - The ep device_node was leaked in v7 patch 3/3, so add patch 3/4
>>   which simplifies fixing this in patch 4/4 (and adds flexibility)
>>   and adjust patch 4/4 to the changes done in the new 3/4.
>> - return -ENOMEM on allocation failure in patch 4/4
>>
>> Changes since v6  https://lkml.org/lkml/2018/8/3/333
>> - zap bus-type from the binding in patch 2/3
>>
>> Changes since (the shortened) v5  https://lkml.org/lkml/2018/8/3/182
>> - add reg properties (and #*-cells) to the example in patch 2/3
>> - prohibit bus-width 0 in the device-tree in patch 3/3
>> - added reviewed-by from Jacopo to patch 2/3 and 3/3
>>
>> Peter Rosin (4):
>>   dt-bindings: display: bridge: lvds-transmitter: add ti,ds90c185
>>   dt-bindings: display: atmel: optional video-interface of endpoints
>>   drm/atmel-hlcdc: always iterate over the first 4 output endpoints
>>   drm/atmel-hlcdc: support bus-width (12/16/18/24) in endpoint nodes
>>
>>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 23 ++++++
>>  .../bindings/display/bridge/lvds-transmitter.txt   |  8 +-
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c     | 70 +++++++++++-----
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_dc.h       |  1 +
>>  drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_output.c   | 92 +++++++++++++++++++---
>>  5 files changed, 163 insertions(+), 31 deletions(-)
>>
> 

