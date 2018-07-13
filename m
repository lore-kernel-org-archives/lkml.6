Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC7BBECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9372B2087A
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 14:15:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fb.com header.i=@fb.com header.b="AxcuDhHd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fb.onmicrosoft.com header.i=@fb.onmicrosoft.com header.b="an2XPK84"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9372B2087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=fb.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731944AbeGMOaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 10:30:39 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:50100 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729778AbeGMOaj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 10:30:39 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6DEFZYX031445;
        Fri, 13 Jul 2018 07:15:42 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=JV3gp4+2yrQwaLOEXzrSqcq7e7eg0dT755hI6O07lK8=;
 b=AxcuDhHd+oeDNonrQF9T7PimbxXKU2TiPTR/Xn2mIthppb5uybVswbaucHgkxX2oJBE4
 RvZPMxqfzjMsNrZXQiI5vatI36hD6JXB+3cn1uvSWHDde7LKhN8rFIwRxP8TjDTZ+YFt
 e2gGNNb3HBuofZ7TKt6OsS/sk0AlfcRAbSE= 
Received: from maileast.thefacebook.com ([199.201.65.23])
        by mx0a-00082601.pphosted.com with ESMTP id 2k6vpq04vv-6
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Fri, 13 Jul 2018 07:15:40 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (192.168.183.28)
 by o365-in.thefacebook.com (192.168.177.23) with Microsoft SMTP Server (TLS)
 id 14.3.361.1; Fri, 13 Jul 2018 10:15:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector1-fb-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JV3gp4+2yrQwaLOEXzrSqcq7e7eg0dT755hI6O07lK8=;
 b=an2XPK84twuLU260eRBJ+RLx/IN25D8F1QwURQqirAaQbHd3rgze9mRKsufnScdNNEnF/aJ0gdxYy6XM/0YJVAXvVVsO1RD33mrLK48tB9bB3Tbv6VUz19zPCYzJFHGtiMk33uygzYQ+SlhasMOOPLoHFNSIkMMHklh684S9GOY=
Received: from [192.168.1.212] (107.191.0.158) by
 CY4PR15MB1463.namprd15.prod.outlook.com (2603:10b6:903:fe::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.930.21; Fri, 13 Jul 2018 14:15:16 +0000
Subject: Re: [GIT PULL 00/10] lightnvm updates for 4.19
To:     =?UTF-8?Q?Matias_Bj=c3=b8rling?= <mb@lightnvm.io>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <bart.vanassche@wdc.com>, <hans.holmberg@cnexlabs.com>,
        <javier@cnexlabs.com>, <hlitz@ucsc.edu>,
        <igor.j.konopko@intel.com>, <marcin.dziegielewski@intel.com>
References: <20180713084845.19511-1-mb@lightnvm.io>
From:   Jens Axboe <axboe@fb.com>
Message-ID: <04ed78d5-1911-be77-a671-3696b12c8656@fb.com>
Date:   Fri, 13 Jul 2018 08:15:12 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180713084845.19511-1-mb@lightnvm.io>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [107.191.0.158]
X-ClientProxiedBy: BN6PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:404:23::19) To CY4PR15MB1463.namprd15.prod.outlook.com
 (2603:10b6:903:fe::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e4d5e769-27c7-40ff-ea77-08d5e8cb0fd8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:CY4PR15MB1463;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1463;3:+LNzfrCf4vhNH4jLbJkrvIdawE17TGwdGXJeMyW67/IfncJkVud40h9JRUz3ECpeTjhGoaxx2R4O92G4DQDCwd7tR4uG+sZgjZ5KKGjyTNfqEOdVA0U1WVCvMWw02+2l6wvkHcqbshus+N3DMx3e7xTcEbNxUa3mJQzzd4h2VWxQJ4U3K81bSuy3Xq3mYgpFqWgOsjwtjPfWfqiXdKse1GcXBCwUM4HgMkiiLTQ1qBynOzjyjsMN94J4WunplzvD;25:BWHMnwOsFErZvSUja1Z7qC+85PKWROdo6ifXOsu7HKX4fUrusJUpkJPMPITqAYI2VGzpwZTiIipgMNMGiTYfqj4/MGjSPPrPkbG8NHa3n7LjbN5ILMiJgzYOcA6FZF0sIR5He9Y5HDjKRPyHPEZGOC9DDhDdNWVfMghoSUg9JBMi00c0MrNvUVc9U6RTqnwkBh5tDtKVRzHXRt4rWZ0ktN/TYoVs+dRGY/8wQRq8hWKPnS8fr8Fq3vICe+SXZzoWWSCD/ea4PxBu7cV+p+jRYMubjmMHD1S6ngB/vFKwei9BISeG5Joe1rxNXhA24e1szyLXb3dQubsuIMhfqtYdCQ==;31:KQrj803cQuP6RJzlSZHx0XLakDUO5GQsSkKgWs3FTIx2YCdfYRMso0SW+ewJJQgbqVVEWCfJVHVwiEGxSEWZBT1oTLcfvVXc6ltub3y/J2ZdDMC5yEjufBI1hz8mTkMDdBonSq2OE9XHhFfrJsmX6B3/1NzW2n/XYI6UYG0R9RtXamHWEsdsQ19ta/G/kH9J3SC1Sq8czp6T8+Ld/5oRo9UpC6Mlk4AurRPTxm1YsI8=
X-MS-TrafficTypeDiagnostic: CY4PR15MB1463:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1463;20:ydH+FSGID+WPX6of8HFfjnALfmXuRByoTESlrwWxXidbrPrKxyIt9jEgaJCgasczZuf2fo/K9yWYyacy2wOc6q83ay41OTv6FW4GCokVVSnU7YPMRtHLSLgOOka0zBJtRFw+a94BoOdwDelk7MUfValsgwJQEHWFW1mO3rFeUuE4leQ3jaJRh5uNLrRosUp5I334I4oT0SWxz4yD7UPIV6OgJVmXtlbZWViCAaAxBiT09JT4Ig0ZeLPrrPVSB/525QuUi8dlmcouTj6x5Jgn7BdM/1Vea8kIMPiL/nw0bnUmu2tHWvWs2Uf1KTwICJQW/qtmHTYDmQOE2HK2M+i1nvRng+wIBzspz6Vkl6fFb1YGv2fmsh5FbFyY+svYYyAPbRg3I4iyZI7ZGQ1BImJKjUOSI8MNeSw+n1Ak2Neoz7ja+jm5HUNY1sj4usa3PLYWmfr9ucjtAH9z0Sq/wx5hW6Z6F7lZShLaF6PKNJ9Fzngbzb5kvBMX2aYa/qTNhoic;4:WS2F2wPi7nVLdmqCmfZqTKKk0YlPs//r41/t+v900yiY6gOmA749Vmp7OtKsFB/KG7y0e4rFRCebZSZEGn0mEsRl/bwXDXDKkDkpPqtjgNqrkF+wr6N4K3V+cCnNWhdU/mzT0bHA55tDj5X5s4RL2D+c4Slamk/3DkjHQMmK5CV6hwc0CYN9bq2UKzrEBsssV662JsYdjrYtA+WNnj43v0yWlabX6j397i9jHc6v4ssOxj+ZIwqppuQ8fhyM6bmxN4QPlNS65QUdKUJlOhwfyg==
X-Microsoft-Antispam-PRVS: <CY4PR15MB1463925E3675BB40114EADFFC0580@CY4PR15MB1463.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(3231311)(11241501184)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:CY4PR15MB1463;BCL:0;PCL:0;RULEID:;SRVR:CY4PR15MB1463;
X-Forefront-PRVS: 07326CFBC4
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(346002)(396003)(136003)(376002)(39860400002)(199004)(189003)(956004)(36756003)(6246003)(2616005)(229853002)(476003)(25786009)(305945005)(47776003)(7736002)(68736007)(117156002)(66066001)(58126008)(81156014)(50466002)(81166006)(65806001)(4326008)(478600001)(53936002)(6486002)(65956001)(8676002)(386003)(16576012)(6666003)(5660300001)(6916009)(2870700001)(97736004)(8936002)(23676004)(86362001)(65826007)(31686004)(3846002)(52146003)(316002)(2486003)(77096007)(106356001)(186003)(64126003)(31696002)(26005)(6116002)(2906002)(15650500001)(105586002)(52116002)(53546011)(76176011)(16526019)(486006)(11346002)(446003)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR15MB1463;H:[192.168.1.212];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fb.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjE1TUIxNDYzOzIzOk5WMmtjdEQyeS9ZQkNDbDVpNWpGT0pzcnRn?=
 =?utf-8?B?TWlzWTIreXJ4NExHRU85ZHhQNlZabHc0MmQyTEdQRDhpWW5Db1ExeTg2Znla?=
 =?utf-8?B?V0pnUXpqT3NZam10aTRQMC9SS1VrcENmNnlLdURtdkVZdUtKSGpqTys5U2Y1?=
 =?utf-8?B?S0tLblN1cmFHYWU4aXpYT3BmOG5YQStFOGRHY2hYVWlBMSt5bzZSNFIyUmtU?=
 =?utf-8?B?SGhUcUdXdmtRM0I1TS9mV01FUm1YbzlPRTZ5OUlEVXQyZHk5N2RpSjlWb3Zl?=
 =?utf-8?B?eTB3aU1kNit6YjhZWnpzeng5WXJTSnhtWlh0Qm84TjRTajhEZjlKYWhzNVVZ?=
 =?utf-8?B?QmY0Z2hvdG1DWnk3V1lIYm50RHFpR3FldXFMeEF2VjYweXFiTG1KK2doVW1D?=
 =?utf-8?B?ZjEzREoxaSsyV1lzRDZ2c3UvZkhqbTVwOGRqUmJUQkwrZ1BoMWdZRndxVGRj?=
 =?utf-8?B?T3diM2ZQblpHYzRyaktWY3ZnZUZBRVdmYzRLd0hSYjIxWHpsQWYwOEJubU8w?=
 =?utf-8?B?TGp5ajhUZVM5cUhwMHhDdnZ1YkZlMDJKZjJPTXJNY0ZON3ZHUnA1K0RFamQx?=
 =?utf-8?B?N3NSb014YXBub1dkYVg3K291NFlhek53djhrNVpMQXRsdDIwdlYrbmV6ZXdq?=
 =?utf-8?B?L3dQYk5sSmtncUV2NWxJZ1BBODE1clh2dkduY0U3ajJ6eDRMYU5xZ0ltZGQv?=
 =?utf-8?B?WkVaK1hBTDBveEtHQUJPQmd5MG5XeG9Oc0FCeC80VUtQRml1dzh1Y1M4VnpQ?=
 =?utf-8?B?eUJNUTBwV0VJKzJPYndmMWxpSlJkYzlRejFiR29mUkttSElkckh2dGVkUEl2?=
 =?utf-8?B?WHcxeTZBSHNVRXRjdFFHRjM3NWNrcDBReEF3cFh2VVpuUGViQ2lkV2R5ZHBx?=
 =?utf-8?B?YmtEUEtZMWZpRWhXRmk3ZEFJS3hpazg5b3VlcjdwaXhtaTd6Y0NIM1NZUm1L?=
 =?utf-8?B?bDYxVzJLRVZmcUsxbm1pSlFIeHhwRFEzVDhkSHh3UVVZS2NmL3dTdEhCS2h1?=
 =?utf-8?B?SGJBMkZaSGFSdWtKaHRuR0F2RFhTZ20wZFZsbGlhaFBxUHR2OWJCbTFObHh1?=
 =?utf-8?B?TjFhRFcrVTVxcmgwUm5ESWpQb0gxQmhpeHpHWXI3eFlqWVdzVy8weFZuYzh0?=
 =?utf-8?B?VHA4OXMzTDFWeVk0bFFXS3FTMkFRaVRXbHZ6SkpIOEJ2YlI1OGVTNjB3MTJM?=
 =?utf-8?B?aS9NUGlwWm9hSzFSdExjRXU4U21wMkE3M0NVNmFRa2d2NHZZbnZuV0hGMWdt?=
 =?utf-8?B?SUsxUFF0K3ZDTlhNUytRdGphbzJrZ0NtSXJlOHJzbGVubS9vUjFiRVlYWXJ1?=
 =?utf-8?B?OUZ2UExNOUhvdUFSS0k3VFpPTHM2S1pHYWdzdjhkTGJ5RlVyTWd1UnRMRUJJ?=
 =?utf-8?B?cDZVN2dFcWdQNGJQZHcwTy9FTHRFWHZRQ3VDTzlUQkx3YVkzRjlVY2ZySExW?=
 =?utf-8?B?UjFldkk5MXFCYnkwNXk4REd4UTdDSHdEaldreW56YUE2c3hIRGl6Z0U2TERn?=
 =?utf-8?B?a2doaXlraEhzdUt1dlM5bGo2MlFRTFJsUk0xeWN2VUdRRHdUTi9xWDJRN0RH?=
 =?utf-8?B?NHYvaUVIT3I3V3pSaUpIVnpVanNWR0dNSHVzdXJOQmRpdGZtZjdKU1ZVYWp4?=
 =?utf-8?B?VThQWmtFZFVSbkhvWmpjbzdVZlFCRjJqVTRPT28rZGNBTTUyR1pUY3AzNDdi?=
 =?utf-8?B?R3dZTEFEczNqd2lLV3YyaUZKU1dscWJ6akV0b1JQbkRqTWcrMUhxUzdoZW9D?=
 =?utf-8?B?ZWV6Wit4TDJ1ZVRCNEFLa3pVZUhRMlFPRGxydEM3VUNMWFlqWStGWXJsL2ZX?=
 =?utf-8?B?V3pHbzIrTm5Yd2ZIeCthRUYrTmk0c3krMVJQYm1ueTRpd04reXlxbWpsYkFa?=
 =?utf-8?B?ZDJYUW9JdWxVb1BsOXl6a1U4eDhzY1F1cnluU2ZKK3BtUFFQNUJkZUROK0xx?=
 =?utf-8?B?eXljMXB2LzZ4emNSaFJUQVQzdDlKNHNlcGdISnJqbTFBRXhBVW1DaTlNeTF4?=
 =?utf-8?Q?eJJ3v0?=
X-Microsoft-Antispam-Message-Info: 8Gvt334eUNeUFuSjORtRsUsg5YUn6N6He/V7HH4OfjcXLu9h6cFrbnXmFzxijSu6Y567N56cED9b6qBY6gNq973jBxM/wni7nLev0Mw64BQYJJVabS1Ay7VIvZVN+rpNHBEGX4bkx628e/hvKShszyW8HKiUVW84fZNofMmWiVeb+1joU9O+cdemtVLFb3BwEfbOXbZ5FRUEkCLKo21pxCpeyTXMQnSHzJ+spKwlWO+Y7zwnNPbznBk14rw9dTwOi3OX7jL85TI5tlK+cjGHm/C2/7euCrzdZkWIHHRugdhvWMNOiiSfvidJtEXuZq7ewPfa51n5U7GHRKt3N9GWXwSS9odJg2z84mqfe9vRvIw=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1463;6:vhq4kSNW0BkeNfA+nUNGmYaVqOcE80dZLetOKAKSEWZ5Q8SDRspY3c/R303glItyhQ9ypVtMs6k3upwAoCpDVYq+cs3u7n3b4W6iXYqtMV35zxL4gUPO7Z+zDEQ28V+SgjnIBAz/1FUUzN1fdnIAxP4PxsT4iuwqeyVw8NZhkyOEaui5Axij7Wfg58sOCgXutM6CpOGcbuvAyBndxeczsHOJZ2R2UdgL9bnnqLIFXGS5DghW3Y64PeVfKdynlWPyp7nviEII/ttwthadxvqOAKefos46zfH/YMH+KItzJ7yg1fK83WIdzOx+4mxgwWrjXqmRTZDI1KDgLfZs29vdZZpda9CuFQNAMLrkh42qnaLVKVtqgsvK2MBKm01MQFIZhOWOaN8Dq5oEFSNH8BxjRuFJQ+mlHkG9QMqKXpUKAzwdia1kVByBEy3pe5O1RakWle4VBVK1a35SOpinX7cr9g==;5:9xeYMcJr4hi9TSn/N9/5AUfjiY9G2GK84u4UBBgX/VT9/6KcnNHFjCspB1G+T7btlDRJO3zM2uGDHqTBlPmoVqgu1wDFxpwI0Q2bxIH9Kxhq0uwUssLEWOWM+awijITcgawNx4ZNje/M1lcWJA2e8mH06aU6jDsMF9ggrtA8IT0=;24:YQgymysMS8geS2SQlbVZYdfCZdaJnObdcSadzWziQEbI7T2eJ2AzfS34eE7N8UtXJXp/CdWA7kHipUsD1qMDCkcCBYKsYDtUkhCfHIDewF0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR15MB1463;7:19nrkPe/1c0WvoStHtUvRWI1nkSPQe2vFVVpGbjNY1W8t4joDKBcMCRzgnSIeK2im0fFXdosTTnHrttbsU/Jv30SzSTvmrjNpFoWmVO+ThcWdeJS8xfD9R+STqJBYKML6+EQpiPdH5iGJcNrOe4e/1/XNhxiCJJgnj84lqZnW3snia8iFWtAXNthRoGBeoLvfzwPAbQrFi7EmBair0IgAUX1A6ujCf4GEKNalb/zazvjGkC0xMUDlDvBPMUtDv3y;20:5H5Wjl5orEM3gjhZvVPwxIPb2vEaJO6SJpFnvRc2x1bYvj8WKNOGTFGCa75xaDrUCYaCG0XbTwZ0zmpm0mkkWD1wZXzauuoxZGNIDAfJNhlk5amYq71f69fhaP8/uOFquk6CnQe3Sxn0fNJi1qij06xyIm1pCrwmFPoCUA3wNd0=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2018 14:15:16.4345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d5e769-27c7-40ff-ea77-08d5e8cb0fd8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR15MB1463
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-07-13_05:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/13/18 2:48 AM, Matias Bjørling wrote:
> Hi Jens,
> 
> Please pick up the following patches for 4.19.
> 
>  - A couple of small fixes from Bart, Gustavo, Hans and me.
>  - Heiner has reworked the read path to issue reads in parallel on
>    partial reads.
>  - Marcin fixed up the case where a device does need a host-side
>    cache to provide reliability.
>  - I added device description to error messages in pblk,
>    moved the compile DEBUG option to be pblk only, and limited the
>    report chunk command size.

Applied, thanks Matias.

-- 
Jens Axboe

