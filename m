Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6062CC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D332A2089E
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 12:53:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="g5zrK8WW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D332A2089E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391453AbeHPPvd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 11:51:33 -0400
Received: from mail-eopbgr30091.outbound.protection.outlook.com ([40.107.3.91]:45083
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388870AbeHPPvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 11:51:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4oCLETSQQQvEunFUi0Sq3WJ2ZAoVrJ58tiQeUNfJqR0=;
 b=g5zrK8WWVIxZfshyzDrrYF1Fthaa/dp0KJQcWmBDB7J6cngFymm3S1LUPgVMZtJgyAcWtiV2ZNdQ8tOrOiVB//+Pzw2aopCLxEMkDL6Z+1lXSQIqKZ7LgwKUnjB21E5EThRRXeC4E3lQbu/vhhdHPTOmmeOwQi92/O+j+FtNfJk=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2464.eurprd02.prod.outlook.com (2603:10a6:800:55::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1038.21; Thu, 16 Aug
 2018 12:52:45 +0000
Subject: Re: [RESEND PATCH v5 2/3] dt-bindings: display: atmel: optional
 video-interface of endpoints
To:     jacopo mondi <jacopo@jmondi.org>
Cc:     linux-kernel@vger.kernel.org,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        David Airlie <airlied@linux.ie>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Jyri Sarha <jsarha@ti.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>
References: <20180803072308.14962-1-peda@axentia.se>
 <20180803072308.14962-3-peda@axentia.se> <20180803081128.GA4528@w540>
 <6fe3e84e-bd9d-0894-df8b-1b40c0f9477d@axentia.se>
 <20180803085143.GC4528@w540>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <061a99d5-4fe6-795c-7e91-cf7127fb8472@axentia.se>
Date:   Thu, 16 Aug 2018 14:52:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180803085143.GC4528@w540>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0135.eurprd05.prod.outlook.com
 (2603:10a6:7:28::22) To VI1PR0201MB2464.eurprd02.prod.outlook.com
 (2603:10a6:800:55::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 10010252-faaf-4eb4-ef03-08d603772a44
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;3:WsM3p3H7W02E9Nbiqe20gTHHxgI3th9FOeVTZbKR4nYHGXUZjeV+U/CHZCpFsOw+dBPm0teUsLoEvL8jElsznYjsWBdT8IZdobrCxgkpEbKVhHd4tFyZjCY994Wi+B9ubPjfsL8tWGjj49qURLRdvnHPeBaSptrU9uE2sgu/iSPAQxiyziJa1bLMxQ/Wtto/DspZP9rJTtkWK3TLvLZNOU4rv2AGqnlBCOV7G9VvWNWqaTWFbt7E0WmbCLfJ+iwW;25:I0HI4AywqhnHOft6NC+dyetGANFoXtXp2hO7Dkm8/kH/8bDMvIyEDZTtCUABDHtMCa80q2z3FXvsjxk+Us8439Pj+zLUurwBqORGwCAjFCf9yTrAmZHxBNMq3jZZRnZ3euy7ei5h4miTxnk6i5mZrLlLFvHe6TgbamEOfq7j4UPzy0H7YqwcnojrWqnLU2PRwom7EZ8jRACW3w7eTcobQW4moPmfk7dDaeKSt6QlOVmR1T4IzL3dqeus7MfI8xZ483h83J71SCOn6KVbIE4XNsDEBiphIlW+Bs0xB2FTN8VKVxajup0UronhBpHRIVprHqaHYIQwyH01h4Tu0xXE5Q==;31:2PzCfQAg8bsOUoYgeO99USdqWBQpaIHbteJawkVbBZm7mxRAXUVy0IJvksfKgHOt5bxDKOjK/ksX6VMS/iSMyU3vbXsBzvD4+evNN8xSss1OH0u2d1EcM/wWKEe6MzSp2qRBZvQl4VVaayASXgDElWvUJjhXqwWUjk84wO3mXybkQPMV0QxjHPXlx7eTygXz/+Bu3+np/qgT+H6ApCyBp3tq5W/ufeX68wcxASeMeF8=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2464:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2464D8ADB558C3B5A4E90EA9BC3E0@VI1PR0201MB2464.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(17755550239193);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(2016111802025)(20161123558120)(20161123564045)(6043046)(201708071742011)(7699016);SRVR:VI1PR0201MB2464;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2464;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;4:8jlcUqhIEKG1bma24mAVKsP40K9u+sQiQCnj92PDYLOrTh0Jz3aj7rzJ+5WmNHN/YFXt4OXacynFxoed3oZ3lAjMcJjsQOpbSAm/w2uJVopB4qvBFzVhmEKnDpc+ogTgU1oysa0To5nglrGzR2kXBFlcR658Y37ngv1WO17NT0of6sfxXMl4o80VwgZR3p3efb/+o6a5ugVcXcNM0Tg1k303y2/1hheW7LEXhFFtXnd5fT7eJ6kDgaCDauj7SWdD946QFPt58Ay0Pq53Avc5suJ+Kwz768IJO09BZuVf/+pg4UntoZgYNNqDp1+YxkAz
X-Forefront-PRVS: 07665BE9D1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(136003)(346002)(396003)(376002)(366004)(39830400003)(189003)(199004)(16526019)(7416002)(117156002)(230700001)(31696002)(26005)(23676004)(52146003)(2486003)(54906003)(77096007)(74482002)(65826007)(8936002)(66066001)(76176011)(36916002)(58126008)(16576012)(25786009)(5660300001)(6246003)(217873002)(6916009)(316002)(68736007)(186003)(86362001)(65956001)(6666003)(65806001)(229853002)(3260700006)(4326008)(47776003)(105586002)(7736002)(2906002)(36756003)(53936002)(6486002)(31686004)(478600001)(52116002)(93886005)(6116002)(50466002)(386003)(446003)(956004)(11346002)(2616005)(305945005)(64126003)(3846002)(8676002)(97736004)(81166006)(486006)(53546011)(81156014)(476003)(106356001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2464;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjQ7MjM6TDFBdXp1ZVJDbEEzZDNJVUMzeVRuOUdE?=
 =?utf-8?B?MjhNK0xTVVF6WTNaVUNaMXpvZGRseE9RR0JXUytVUDNoVStNR0Y1cFh0NTZ6?=
 =?utf-8?B?aFRzVFNKbmRhQ0g5VzNNdVZ4ZUV6S2UrV20wbzk2NGVDWWh6a21rcHlDSFVx?=
 =?utf-8?B?UjJCMllzL2xQd0JKTDErSUNGOGxtMmJRMUF2cTdGdFg2cHE5VjloeUNkUldm?=
 =?utf-8?B?WG5tQmdQTnNuVVdpVjdsM01BeHlrSXZac2N5ZG85RnNUcEpSeHlnRnQ2NHRX?=
 =?utf-8?B?OTREbVF4UGxQOTNDVlBLMGtmaE94cEorUkNoZWk1dDZEdEtGWTRJQU5NZTdh?=
 =?utf-8?B?Y1p1OEt3ZjFYUmlJc0dheER3NmMwMWZaSjJCNWF1Z01HazlFVFNnaFl0RWxJ?=
 =?utf-8?B?enUzTVUvWDJmSWsza21ENUVuTHNJdkdHRm5Mc2dsSUdNdDBqNnR2YWNCTFdm?=
 =?utf-8?B?bVBUaXF2dm15dTgxdStXbElBcndFb2hmNkNmcUdodHRKcjQwUE53ZDkvNEJE?=
 =?utf-8?B?SVdQZmNYYzgyMDBZdStIY2VmT0RsYUpaR1luajhJWHdhN0ZoMGJ3TDNqTStK?=
 =?utf-8?B?L3B0ZHEwZElzcmRsa0l3WWZjOU9Sbnpub24zSkhLSmZPemdpeFUxUVhMU09L?=
 =?utf-8?B?bTVHOWthSGVXQmpydUJJY2h4TWo2UFpBV0NWVXZrZm04YVIxWHpiOEdUU2ZY?=
 =?utf-8?B?RFBiQjkrTXNvSWlaQlZzM2UyREpuRU1wRnlEU0Yxd29mbUdrM3BwVWtod0xJ?=
 =?utf-8?B?ZHlkWmZIU3pQWllLZVpYQWNvQVIzV1BZMnNvVHN5eDAyelVvaEtMaW5RRCtw?=
 =?utf-8?B?ek5wWE5XcEFEQXprN2g3aW5SbnBVYkNObi8wVUd4NEN6dy94eWJmWUFTUkxR?=
 =?utf-8?B?ZFdnNlpUcW41ZnhBWWxYSWRLOTRER01YeXg4ZVllMXNqZkFlRno2SFpLdzZE?=
 =?utf-8?B?Vm4wd3pCUEhPM3Q2QktRL09iaHNMRnljTXN2SFhPOElHNk1ORUdySGZWSEQ0?=
 =?utf-8?B?QkxuY0U1OWFISTIvV0tqeE1wb0g3clNZaGNoaFdzSUNhb2Z6S3lMUjVvK1J4?=
 =?utf-8?B?WDRXbXhCcUZ6R0ZPQ1JqYzBYZHRsMTVsUDdvc2laaDcxbWEwai95OG9BbWY4?=
 =?utf-8?B?OXlTdktXQTcydGJuMkR2R2dmZ1FTZFRVeS92Z3c1MjFCMG5Ebng3a05MYm9Z?=
 =?utf-8?B?alcxR3pTZU9KcjBXNW9ONzRKdy9wZG5ScGtnRHlOWmdaYStCYjNIR1hsS3hx?=
 =?utf-8?B?SXg4bzkyQWdPU05VdXM0UEkrUFovVStlSVk0aHVYQnVWWENTclBFa1VObm01?=
 =?utf-8?B?VWNRZmhyOGt6S0w3Mjl3TnJsSW5QQ2dzckVBcnZSTlQ3bTd2K1pSaVBuL21G?=
 =?utf-8?B?QzdSeXFMMW1VdENjQ29wZHFDUFZDaXpUUDZ2WVVFMVhKakhJWk5VdWNkdXlY?=
 =?utf-8?B?WEs4dEtuVFZHeGU2OGFuVktOQzZRN05YNy9WVlNRTE5mdi9Ibk5PNnZPd3lH?=
 =?utf-8?B?RXBPbTZvSGQvMDJPZzBMd1NkTUpNZ2F4UnFJNk9LK1VrcnJMcXBKUmJicm8v?=
 =?utf-8?B?Vzd1eXc4dWZEaTZOdFAxNXg3ZFE5N3hGakJwZDZLZ1VMazgwNmFDREZ3M28z?=
 =?utf-8?B?L2NLLzNwZys3R1h6d0grMzBsYVI1cVlHUEgzVDdGRXF5bUlNSGlZcDVtbDg3?=
 =?utf-8?B?R3R2MllOa3EydDhQWkdCYzNEZjFqT292WmlqNjkxVHRza0U0K0pkR0VrVUUr?=
 =?utf-8?B?NTV4NXdRSTNqaHhqQXZ0TzFPc0lSYzdLQmtoT1kwWHAvR2dtYUVPWkgwL3ZH?=
 =?utf-8?B?OFVEYUE3M2tFc1pCSzlPU210bFcrblphSjIyLzhzNHY4RDlvRis0UGpBVGgz?=
 =?utf-8?B?Qk1CU2VQTjR6b0srV2Q2YWlkR1FveFUzeVduRHRUV3E1aE5lcFMzbEJHMGgw?=
 =?utf-8?B?SkVKM3ljOWp5MXIvdDhaSjB0N0RwU3VQTFMzQmZ3a0VoZ1ZaZFpURExkc1pQ?=
 =?utf-8?B?NjlZWHRER2l0MHhtdTBMZ29GMjg2K1NlemIwZXM1LytDUEI4a01NOGR2NTVu?=
 =?utf-8?B?dHNXUTg5TytpblgxNjBjK2NGTkFtS3NtVEhCUnlXRDNzTzEyT05WYUN5eFB0?=
 =?utf-8?Q?MT/2NoszDJDDopReB/4RyhFqR5qL3CVC94bBOSYeBSA60/?=
X-Microsoft-Antispam-Message-Info: CjR71RZrxAz5CNrSjFRgEOZuiZMGR/eOFMwaQNNAJuNwAWTiwKezLEZYYeeMjjNaOdYR8gWMwPK05F5hRKZw/Lrt/eGcTuAJoccdjWnrs2l3b4mvrWF4Y14GN2jVi4IkeSJAMRhlQqeYzWvo+DE1swZRhPrbPajxLI/C5N24077QaNZa+L3wm1S78PH43mZc55EZmGvtikZRDagfrrT1CA2/dvCCKPVihqso0fh/uIUeBth32V8/j8xqnni+rW9hGciucdYoRi9IpiKKvEAAmIMHSUTVzdd7Ah0NRSZ3FJFK+9DYl1jCQFkVkV4OBodZ2VQaxcTZllhZoVOHYgbPHJkYkJe3b8T46XGIN4QeCeI=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2464;6:t0t4tj2iZkXjuXdQjvYBIDhUr0fPPsmKPdSFHIMOftHjZ6vBqAUgxSurFzcxIgp8UQaA7nN/1lr1n7FtHyttmUkx3Weguh1aXxgYoQc1HlfFZg3mTBFAZS1e3gM4IH0DKJ5XctPHa/1wYOQ7hT6IQDTZUfMPWHoMgi4HH3psi6qKhzonAD557ihagI970Xug1BFSC5P8KuNU0W95D7nPb4SHyBR3NKXVhze5U5DNpWP3lgNkbAjlMz1GWuMLOTrHTgKFy/EZx85SqqDSd3glKd8NscIdCqO1LyV0JgjVEa03AWIbUUbGctAHRzwLoFpezLGud0wB9cCJ+/db0e80pX1o+3XqmVKHVR7AISqFg94ev/jNR+3VBNPPEEIvhuwG1B2jBxiCoXZ7kNGDa/dFs6cdeKx9+YShiphg/GeoU47cRwOGoms9aC7gcW4nMdh7QiasZkBldHzPj69jGpDZbA==;5:HkLcM4mk811aYzFdV0fFm5Oq8slicM380LLNpOMCXzZGdBzQ4Ql885k8QsCp7jaSWFkRJTibBMeyoYVpUtP1FonVrMZtLbG7fk4ziKZNnpxQImArq/5Sk2adT28VZ3u+eovgQo9nb1F0nmISFGp1U69wHblCRQetLJRlzvUgwls=;7:7/opAl3wGlhNXD0fTTOBKgsrIG54Cjv5esbO++M7qEKRzCLw969SdPyshsVwaFRpoH7Atqs/qO6fnZbEE5ok+GQj5ltTJyQOxF5bsmHVAtdWCQb9asQdzwxD5vmU/fJpL6xCqfQ/nQtvhRSi0BdEA0+i/CTw90jWJE7OVJFGzxFYoy+TszW0PQAAH38M5GIc57B+p7jLJX1nJofGyGebaXBJu2GTqP/5aVXvXIPpVKxlMjdjOhhKu7h3T5zm0h/J
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2018 12:52:45.2156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10010252-faaf-4eb4-ef03-08d603772a44
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2464
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-08-03 10:51, jacopo mondi wrote:
> On Fri, Aug 03, 2018 at 10:40:02AM +0200, Peter Rosin wrote:
>> On 2018-08-03 10:11, jacopo mondi wrote:
>>> Hi Peter!
>>>
>>> On Fri, Aug 03, 2018 at 09:23:07AM +0200, Peter Rosin wrote:
>>>> With bus-type/bus-width properties in the endpoint nodes, the video-
>>>> interface of the connection can be specified for cases where the
>>>> heuristic fails to select the correct output mode. This can happen
>>>> e.g. if not all RGB pins are routed on the PCB; the driver has no
>>>> way of knowing this, and needs to be told explicitly.
>>>>
>>>> This is critical for the devices that have the "conflicting output
>>>> formats" issue (SAM9N12, SAM9X5, SAMA5D3), since the most significant
>>>> RGB bits move around depending on the selected output mode. For
>>>> devices that do not have the "conflicting output formats" issue
>>>> (SAMA5D2, SAMA5D4), this is completely irrelevant.
>>>>
>>>> Acked-by: Boris Brezillon <boris.brezillon@bootlin.com>
>>>> Reviewed-by: Rob Herring <robh@kernel.org>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  .../devicetree/bindings/display/atmel/hlcdc-dc.txt | 26 ++++++++++++++++++++++
>>>>  1 file changed, 26 insertions(+)
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>>>> index 82f2acb3d374..9de434a8f523 100644
>>>> --- a/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>>>> +++ b/Documentation/devicetree/bindings/display/atmel/hlcdc-dc.txt
>>>> @@ -15,6 +15,14 @@ Required children nodes:
>>>>   to external devices using the OF graph reprensentation (see ../graph.txt).
>>>>   At least one port node is required.
>>>>
>>>> +Optional properties in grandchild nodes:
>>>> + Any endpoint grandchild node may specify a desired video interface
>>>> + according to ../../media/video-interfaces.txt, specifically
>>>> + - bus-type: must be <0>.
>>>
>>> Is there any value in specifying this, if it has a fixed value to
>>> "autodetect"? I understand it's optional, so if nobody else objects,
>>> feels free to keep it there.
>>
>> That's just how media/video-interfaces.txt works.
>>
>> bus-type 0 means that other properties describe the bus type. In this
>> case bus-width is specified, so that means a parallel bus. But bus-width
>> has no meaning (or may not have) if bus-type is non-zero. But checking
>> that bus-type for zero in the code seemed like overkill to me since the
>> driver already knows that it is a parallel bus...
>>
> 
> Yeah, I felt like pointing that out since you're not cheking for its value,
> and that property is only used by v4l2-fwnode to handle some
> not-that-used-anymore bus as CCP2 is.
> 
>> TL;DR I'd like to keep it.
>>
> 
> Fine with me then.
> 
>>>
>>>> + - bus-width: recognized values are <12>, <16>, <18> and <24>, and
>>>> +   override any output mode selection heuristic, forcing "rgb444",
>>>> +   "rgb565", "rgb666" and "rgb888" respectively.
>>>> +
>>>>  Example:
>>>>
>>>>  	hlcdc: hlcdc@f0030000 {
>>>> @@ -50,3 +58,21 @@ Example:
>>>>  			#pwm-cells = <3>;
>>>>  		};
>>>>  	};
>>>> +
>>>
>>> Two blank lines here.
>>>
>>>> +
>>>> +Example 2: With a video interface override to force rgb565; as above
>>>> +but with these changes/additions:
>>>> +
>>>> +	&hlcdc {
>>>> +		hlcdc-display-controller {
>>>> +			pinctrl-names = "default";
>>>> +			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;
>>>> +
>>>> +			port@0 {
>>>
>>> The node has a unit address specified, you're missing a reg = <0>
>>> property (no big deal, it's an example, but the other one has it)
>>>
>>>> +				hlcdc_panel_output: endpoint@0 {
>>>
>>> Missing reg here too.
>>
>> I'll fix those (I think they appeared for the original example after I
>> wrote the patch).
>>
> 
> Ok, then please consider also describing the port@0 node cell sizes too
> since it has a child endpoint node.

Ok, I have now figured out why this was as it were, and I no longer agree
with adding the extra properties. The whole of example 2 is inside a
reference (using the &hlcdc notation) to the hlcdc node in example 1, and
therefore these "missing" properties are not missing. I think they are
just clutter that hides what is really needed/different between example 1
and 2, and apparently Boris and Rob agreed when they acked/reviewed. The
description of example 2 also clearly states that example 2 is changes
and additions on top of example 1. So, I plan to have this in the next
iteration:

	&hlcdc {
		hlcdc-display-controller {
			pinctrl-names = "default";
			pinctrl-0 = <&pinctrl_lcd_base &pinctrl_lcd_rgb565>;

			port@0 {
				hlcdc_panel_output: endpoint@0 {
					bus-width = <16>;
				};
			};
		};
	};

Jacopo, please let me know if you want me to keep your review tag anyway...


>> Cheers,
>> Peter
>>
>>> Minors apart:

...because I interpret this to mean that I could add your tag if I made the
changes you suggested. Or did it mean that I could add your tag regardless
because the issues were minor?

Cheers,
Peter

>>>
>>> Reviewed-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>>
>>> Thanks
>>>    j
>>>
>>>> +					bus-type = <0>;
>>>> +					bus-width = <16>;
>>>> +				};
>>>> +			};
>>>> +		};
>>>> +	};
>>>> --
>>>> 2.11.0
>>>>
>>

