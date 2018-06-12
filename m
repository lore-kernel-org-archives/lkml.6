Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 19E45C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:48:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B080A2086D
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 13:48:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="KOpUbe5q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B080A2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933743AbeFLNsU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 09:48:20 -0400
Received: from mail-db5eur01on0054.outbound.protection.outlook.com ([104.47.2.54]:52154
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S933295AbeFLNsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 09:48:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BkV0chDw7b3WztRRaEHN7HwbXfBEdQA9ebge8RwKQ+s=;
 b=KOpUbe5qXTz8+Q06sEf+4s+sVuCMVOAK00fnnlhYFNSTVt6ma10ex/Qqrm3O3cjRAEnS7AjtGxPuaBMWJIyrLTjolRpaOPdukgkbmH5eOO64tQMmeBzzc0yt/O8xDmml8GLu+A2Il2IFOtd6sNQEY7yVYIQRkLcW6AV4vGViPag=
Received: from [10.17.182.9] (85.223.209.51) by
 AM0PR0302MB3204.eurprd03.prod.outlook.com (2603:10a6:208:9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.18; Tue, 12 Jun
 2018 13:48:15 +0000
Subject: Re: [PATCH v5 1/3] xen: Sync up with the canonical protocol
 definitions in Xen
To:     Juergen Gross <jgross@suse.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>,
        xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com,
        lyan@suse.com, boris.ostrovsky@oracle.com
Cc:     konrad.wilk@oracle.com, andrii_chepurnyi@epam.com
References: <20180612074856.28451-1-andr2000@gmail.com>
 <20180612074856.28451-2-andr2000@gmail.com>
 <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <fbc66cfa-f750-7810-1a0e-537c5c98d9e5@epam.com>
Date:   Tue, 12 Jun 2018 16:47:40 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <9c579567-ebe2-f465-5443-b3a3e71d34a5@suse.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.51]
X-ClientProxiedBy: AM5PR0601CA0042.eurprd06.prod.outlook.com
 (2603:10a6:203:68::28) To AM0PR0302MB3204.eurprd03.prod.outlook.com
 (2603:10a6:208:9::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(2017052603328)(7153060)(7193020);SRVR:AM0PR0302MB3204;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;3:CI2MRM0CxhzOxv0y/lUOxvX5wda0pjSut9T5iNXx5lzXD7PFlH/zsa6fR/zTrEdcrjU3H0YKbV0vvIgnXUHsmUTRdzFAkl/voKbEkwBP4tdZmclhDnpPtBzx3xSWKX+9Fq1xVLjbJBA2+7GfGduuTdaBRsYIwh2H/Q3OseCIUHt83xadZXhfNXSscqTIY5vKUiR7AQ0eeIkEKRFP4shC+l0KlfNIZEqwo7ZH5bOPxkR/W+PkJPAcidBdsAEGygx9;25:WycIDBAvRsVcCgW4ue0DkXD3LzrIH4YAO/JNycL+Gckzxn4DubcitaXpvf5U2VTvCsWXyIMoI4E3OydLCaPRrBpXPiO1Sy7bBwPXP8iMuW0z7RfdciX5gIWTzHnwuGCVIaVC4x9nAkqdVEXwFhQIo1kNEYwZKogMIA3dgm3M6vtA8ke8GDWtULaerr5Q4REi8NYplSi7jHuFDSFBrQeB4ypM6V7LypOB0jsjL4HcAvZTbiPCxi2hBytrOTE+gCul7NNF1gxK2L3MVKHTXFIcIYGCNA3oCc1Nn0wNXY/ej7pR5HRwxoFSvpYpnsIWmDYi73h9bvw6x/2nXlsPGY/Q5g==;31:mZgfCc3r5BHNKIxcGIabzRjuupo0UTHpFdwqh+nliXhBSvJoTRCvWYkV6vEIL++X5zpk27A1ve/BW12jWyDPVox781oUECV8i7Wn0uIwgsXxuqw6GxD1/iJh+CMVOU5pJVOdU4G8fudTCUTw/2JkAjo7TPH5XT/FoSRpZt+32RqpCzrcFy2NIPUcTLZIkfV17oPSoJ2obNc4p3ZJvX9HZcA7RKVjgRDt5YYitEYXFrc=
X-MS-TrafficTypeDiagnostic: AM0PR0302MB3204:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;20:q4gd6/Gd5KPB8kDyk+j+GhNqcgKw9gVFJVA/EvMlD1464+yE6LFJywKV/GHvdUEdc1zvrf/QXedDMitTKgR6Wi6CvJ7x09buQWh8o8uvHVt9gttbvcMKF5Ur4hqJfNbaxSy4MWeSQ62KVhwJOONPmksk0kqwMWJQ/TgKXQLwrmh+7dNzS31CVk9vcXU74ny3acX4YUtX1raoIifDbkMpjlE6bYe17wgDBWFrv0UXIcYQON8GCw5zdlTsA6lWe5R8V6OPR+58mMxM+2uxMYzG0HoQNoCqFQQ4enRdzaGEjZu0vjz7Xxiu62PR4E6gBoWGEB9yL78JYEGX3kGVsBKg16RJIvSh96wEF9Iw+9mhkO8oBY41db7RzzxJyqib2vFOVETe1GmhQ/ql/iEeyUQVSW1j0B71gklAlBf1gF4ASJLPHFy0D1gTKeUXan+3+0WZmV/zRR5Yaxwdwwy1GK3NTresPlC6Ylh5CfklOIRZIiIWYtfC5eS0LkJhQA6MpVDk;4:Rj/jNLqejid0Ej1PXKo+6m2oN6u8pCohcROB9sxE/R2WyufOwPEzWvihrk+/5D9YKV4QOufNQI2YJi3MxGXqhI43jJb53cVVHRXqFsUkQNXWO+u7mmrJ5ozWNI2C0TnajzOxKnf/AKJpTEzTiepnj3cHAk94W8pUE3L/C4/B5rgTnV3UaVNTmKN+cZEL+3sZIFEJHvu+01uBBTW94W0DS0pAZfKBd/ICj7MEjRzJpOXVr9/6I+gBI0YAEVUhnaZrqLJGsPjs5wpaSxFZ7AaNvp95xXXozUbXRLXb57/7WZ11NSLR8Kl9BfiiN8CiPcYqsdZcl2DC55nQyDcHO8SPyg2cXPpEUBZdEAyOZd6aotg=
X-Microsoft-Antispam-PRVS: <AM0PR0302MB320491F63C79F8F3E9C5D516E77F0@AM0PR0302MB3204.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(4114951738403)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:AM0PR0302MB3204;BCL:0;PCL:0;RULEID:;SRVR:AM0PR0302MB3204;
X-Forefront-PRVS: 07013D7479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(376002)(39860400002)(346002)(366004)(189003)(199004)(50466002)(26005)(59450400001)(2616005)(230700001)(76176011)(58126008)(106356001)(72206003)(81156014)(81166006)(39060400002)(8936002)(107886003)(4326008)(7736002)(25786009)(305945005)(31686004)(6246003)(8676002)(110136005)(486006)(478600001)(53546011)(386003)(105586002)(53936002)(2906002)(476003)(16576012)(316002)(5660300001)(47776003)(65826007)(64126003)(97736004)(16526019)(6486002)(52146003)(86362001)(80792005)(65956001)(11346002)(52116002)(229853002)(2486003)(31696002)(6666003)(36756003)(68736007)(446003)(77096007)(6116002)(65806001)(23676004)(67846002)(66066001)(956004)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR0302MB3204;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjAzMDJNQjMyMDQ7MjM6cTV3TTVVM3VlMTZoMVNnUjgrcnRhNEp3?=
 =?utf-8?B?ZW9QenNlR3JXV0gySjRRNU5PZUM2eTcvc0h3alRzOGhhbE9zRHhzWkY0RnRi?=
 =?utf-8?B?L0s1NzBPN0NqZlFLSlk4dWxjOFF6QVFyUzZWS3lRTmlGaDFwbVpGZ0RZY3Ev?=
 =?utf-8?B?QVo4Tm9USGw0MHpGcEljcjVvSTJxemlFSGhSd3cvZ05OS1RjVm5Ta0JpVVBF?=
 =?utf-8?B?OUlSZFdHZzduQzNYcUhGd1FPT3ZFY3lTT0ZRN1NMQ2lyU2NFOTJheHQ1K05l?=
 =?utf-8?B?WlducWVkcGwrTHh2T1ZzNzc1MU1tV0pqT01kc0pqazYyanVkZDB2RnUwVlMw?=
 =?utf-8?B?QkNzeC9BQ2lZRnFMbU9LcWN0SDdWV0pnaWZNRUlTYlM1T3lYUkIwMkNrK0ZU?=
 =?utf-8?B?N0tyK1ZDL2F0MGJ3bUhTd0s3NGRSWExLVXJmSmFnN216cnNtenhZYUpaM3Rt?=
 =?utf-8?B?Sk9ndUJ1TkFRMDNhQkFFUUNVRnVTZUhzK1hBKytjTE9HeTJ3K0d2Z1J4K2xm?=
 =?utf-8?B?NFI1dU5xaklrR2lxOCttWStxWTZxVkxJZTI2OU5XMDVlN3ovQWZvd3oxMVNZ?=
 =?utf-8?B?RkQyK2dCQ2lyVkxReUdzSE9MeUpqVWt5c0c5Q3Iva2VsNUs2akFwci9CZnhJ?=
 =?utf-8?B?YituSXcvbmtONnBoM3Bwa1pORm9DcjhoTzhrMWFjRitOK2oxVHE5TFhDaWkr?=
 =?utf-8?B?bEg1RTFKV0V6TjBEYkdId2NzUi9BdWhobDhLa1Y0WVBKRi9scUhveGUzb3lX?=
 =?utf-8?B?M01xYWRvTE9naDVnS3FEWEo5RjYxZXJGblgwbmxWUmNIRlBqcU5PREw5WjZt?=
 =?utf-8?B?b1hpdWVrWUJIdkxYSlcyd3E4dGV3eFdUeUhHQnFpZWVnc1VmdUpoeUtaNm5q?=
 =?utf-8?B?ODhncURLK2tOSUxOL1hsRlVVYmVjYnhDd1g2VmIyTFlXTHBDUGZlcTZQMUxY?=
 =?utf-8?B?b292anpTZnNTTzAwQytRM1ZtN05pdWhqVFJnNUFqWkpDMEc0UDYwSmRPTUIy?=
 =?utf-8?B?Y2I5M0Q4eUcxRHpwU3ppcUdxOVFtcVBLWE9pQ3lrMWo2QTNQa2MrN3ovTmoz?=
 =?utf-8?B?bVJRYzNyaGRxaFBLNzdpajg0bGIva09UbC9iUEx0TndlcWMvdkMyWDdnaWIw?=
 =?utf-8?B?ZStaREFvb3pTdHNHcEptbXNWQkthN0lYMFoyaWdVZ2ZjaVJjdFBFeUVKOURX?=
 =?utf-8?B?NlQ3UVVZdFFXN2lDOFB4MEhhMUNjRm9saTVTNU9OT3N3WjNicitNR3BZUCtp?=
 =?utf-8?B?VGFkUnFhTzA1aTl4M3VTMzFGUjZEMlBLZjE3UjU4Tk1CNDRDcXhhR0VCZUdB?=
 =?utf-8?B?SHBTOUhxSmo2Qk5ZeWNWNGVSUmwyMHZXUTNESGhRVXVCMDc3c1ZMQkg4SDFo?=
 =?utf-8?B?Nkk5RC9INFRKQ3RJeCtwZU5CemlKUnBIc0JlLzIwakxZTWZ5VzdEUzJpTEJy?=
 =?utf-8?B?aDJGM1o1K1Y0VzFzdnBsYy9Oa0FtK1ZCMVNkVENpc2RxR1FkVE5EUU00Yy9x?=
 =?utf-8?B?SUtMSmpnUEJ1UGlkWlI2K0F4TEZHOU5tNGFGcEdvcWlvb1lPMkVSMCtucE5l?=
 =?utf-8?B?b0NMQmpwNEJwN1c2NWY4aGlHc3VuV1VmQkl4WnRJMHZXNWY3SWQ1RjBXeHhJ?=
 =?utf-8?B?L3JIWHRPMStaSXdTYlNObHNUS2JWQnNuOEhYdzNlNlZTWUJBa2gxK0xXcit5?=
 =?utf-8?B?MzRESmhIc1c3Umd2RkIvL1RTQ3NkTzRHckxtR2JkSVVmcHNuTExROU12UTU3?=
 =?utf-8?B?VE92OWpicWwydXMzWkJsOFM0TE1rdVlIOUNvNENQTW4rYlZhTHJscWVaeXFl?=
 =?utf-8?B?K2RXZEhkYmg3bCs2MURadTZET2hlQjZxQUlYdlFPR1dLN016eGFybTJPVHpD?=
 =?utf-8?B?RjB6dytJbjRlSHBvTlJubCtkclhTWG9WRXI2K1VFN0JKWHZmbDVhWnkvV2ZM?=
 =?utf-8?B?QXBvUzZrNnVNeVA3ZGxVbS9LcGhvYnplSE1QejlYM244dkMyWFlVWkRoS0ky?=
 =?utf-8?B?U20wajZaMGZUN21tbnlORTFUcE5TMXVnblE4eEg4a1JsY3VLK05EN01hU0dR?=
 =?utf-8?Q?hXz/oEIlZ7l9DtXfnN7WhHLuc+t?=
X-Microsoft-Antispam-Message-Info: E+mJB7O4luLeCobHM8mWFKphuycw259a2D8z/WSkO75HlXdm5KXSLw5BpjpRnWu/8usAhvoEKGhdWdzQT24zDDfoDWdfZZ1y0yggYaErglDfv7fqOu4JYL+vqJqWD8Z2wP/s/OkbAiaJh+vCkfqkB6iM/DsjPlsGSeynVRsDdq5IsKdn4zg1SUx5XNhSEWhc
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;6:F+ANJKzCWeVxaWhqrf7/VSpXSsxk3y5Md4lCH5DMPr5utoqwmdc9/b5wsazrppO/GPLRC/WYKFg/mqdAJGG5zopCl13+geYE1es4rrjK0uBld6WL+T9V3joXg771L1T1JAvQKQym4+aXCRRRfKTHgFj9Y8RQzOJP2pOhwMAe7Ey/zqHSOIjvUSC1OlkM6qAANWJdldAjbMvmh8xRS0F6XaiYb3jhBoOIvFJah6YPV6Z1oNUZ7O1Hy08RexAEgucQf2vvUgX9MumTP+hn4yoXtW1bYcL6AOysgWeewjnjzddHjVvf8yNNuto3xVbaE7ov0XBtrFvaQjb8m1IhyvhZMWKMEj1wtHnyBiWc0a1JlnyskhcpX9RM0FHylSGbA+HHe8iCPCJq07PN7PGslsVMLw7UDHXib5pvH7PAUkbCzVVgSBgpTQ4Oee/2Ht08tOGiRHjtOxkPwcVidYzoTTzjLg==;5:SioH9C2D5b1SLkDL004YA/7RbCHLHsd1lTdJiwCtToPoq3CP1pBeeNt6gEFsNnmHWKw0Rz9nwPVsEwdMjCJ6hhy4CzsRlow35JdQAgG0uuEBldqQE0ZuwmoSd8+3MmPFmLmhBkNxjIYhPOLFntCG5QvO3WMn5Ss5ZYZ+iremGxc=;24:sBA8TvTzdNKoo28mHMlN0HmcCcAfjLn6Th+A/GpfZnt9KAaMUa+l1iOFHRpiqtyemvkZY342RbSDRGl7ST+Mh3cWSwFzyJHjKhT7HVYVgtM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM0PR0302MB3204;7:3Ys3LBTMBB8ShgBxa+1gfpu5mScMS24MxDKetkqV2JqZ/irvcIw5WIbsn1uGgcJ/IsAyRJtK1pJX4urdmwvRpxkkk7+DEu4Qe2RNyxogYkIxeM/6Kdh1WExOtgWvftgtBS84XXS3cWYNoi+Q6IlRZl3p1kEmluSyvdIRMrl4zVs7eC0vjHSVIacAprurvm1PwHFvf0HPDGwIogUgRZBsZr8XoDRUkt+kawDsH6Z6h5ATvxSfk1Op1uWK2Z9AqInQ
X-MS-Office365-Filtering-Correlation-Id: 8fe7200b-46f7-42f5-62e8-08d5d06b25de
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jun 2018 13:48:15.3178
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fe7200b-46f7-42f5-62e8-08d5d06b25de
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0302MB3204
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/12/2018 04:46 PM, Juergen Gross wrote:
> On 12/06/18 09:48, Oleksandr Andrushchenko wrote:
>> From: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>>
>> This is the sync up with the canonical definitions of the input,
>> sound and display protocols in Xen.
>>
>> Changes to kbdif:
>> 1. Add missing string constants for {feature|request}-raw-pointer
>>     to align with the rest of the interface file.
>>
>> 2. Add new XenStore feature fields, so it is possible to individually
>>     control set of exposed virtual devices for each guest OS:
>>       - set feature-disable-keyboard to 1 if no keyboard device needs
>>         to be created
>>       - set feature-disable-pointer to 1 if no pointer device needs
>>         to be created
>>
>> 3. Move multi-touch device parameters to backend nodes: these are
>>      described as a part of frontend's XenBus configuration nodes
>>      while they belong to backend's configuration. Fix this by moving
>>      the parameters to the proper section.
>>
>> Unique-id field:
>> 1. Add unique-id XenBus entry for virtual input and display.
>>
>> 2. Change type of unique-id field to string for sndif to align with
>> display and input protocols.
>>
>> Signed-off-by: Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Reviewed-by: Juergen Gross <jgross@suse.com>
>
> I'm fine with this patch being added via the input tree with the other
> patches. In case I should take it via the Xen tree, please send me a
> note.
Thank you
>
> Juergen

