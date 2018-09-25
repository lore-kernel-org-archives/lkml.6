Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63909C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:53:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95EDB2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 11:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="JCVA+ldA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EDB2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbeIYSAF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:00:05 -0400
Received: from mail-db5eur01on0047.outbound.protection.outlook.com ([104.47.2.47]:48657
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727165AbeIYSAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9rU7L/yfeHBWRgLrtKRJsAwrt+1962jp3Hm0WG5s4/s=;
 b=JCVA+ldAKbJafVVg5V7dZb5WKKBeujDF6FtL0vaT7eKm0D1ULZrw5uhDuDJvJ7K5VnSYnRxRafqE2zvu7UJUxVqwVTU311YKPDBCZokaXMf1j/CUyYGj1JLrShG5Mj/ZF//2ZGCCyPrAk880j9ZOYBjNvdS91X+l3VNlGzXQ/w4=
Received: from [10.1.8.111] (89.24.100.190) by
 AM0PR04MB4659.eurprd04.prod.outlook.com (2603:10a6:208:75::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1143.18; Tue, 25 Sep 2018 11:52:49 +0000
Subject: Re: [BUG] pwm: sysfs: It is not possible to export more than one
 channel
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Fabrice Gasnier <fabrice.gasnier@st.com>,
        Gottfried Haider <gottfried.haider@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
References: <cd7b3cad-98bf-d976-2e30-0b018f51f90a@ysoft.com>
 <20180925102153.GI7097@ulmo>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <06ae5eac-6474-2eaa-94fe-68c750ef5479@ysoft.com>
Date:   Tue, 25 Sep 2018 13:52:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180925102153.GI7097@ulmo>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM6PR0202CA0049.eurprd02.prod.outlook.com
 (2603:10a6:20b:3a::26) To AM0PR04MB4659.eurprd04.prod.outlook.com
 (2603:10a6:208:75::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04573ebd-f3ad-44f7-e2ba-08d622dd6acf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4659;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;3:qH6750dL72Zd0bXzZcbR56gzZkHO2NF7MbIu5UG/TYU+XNaD7SBoN7sNNtUAYFlasE/YmPhNVj7BfQg3qbXFNwUJ3L2b8/uzj41IcP44dNnn6ALtfAR40QmJ7OZi0I5c2uaRRpCu7+NMUbD1eARV2AYiWxGTh7gQ//8ozzea4axVPHAVlDceE5AbqD5jiJjoAcXPGrMSYEW2HPD0pCATuhT9yBK3OvYtrEnLCyay3X6qt1HeGrZ2xJOXiyRdg6Sm;25:BLxf+s/rGTD4PLHyv8IT4FYye2m2GOmsnY0rSnJfrs8+XtZBckq7mGTNh2DRMNGZY6eZwr8dvokXUfUvqDzANZdZuaGDz2JGjv+oMs42q0CRifYUlu6Fjn4n7bdgEdwLpJCuEG/C2j8Dqm4nJu+9vVl9Qb+2pKPwzkOABx4H0mgkmlT8fa1A8h+VRt2nED1aC99axs2XBGmBqwqhQoPL6Iazfabed2fmfyUgtZjGOO3jntDWpO+YhcPwChMOxY5crDAr/BUQQFq6NhAMbfQI6iQky/hGSfHLtiWTdDuC6WcHDOPJ8uw0AHHxpaYUrH4pshFU3dgxkcfNUQfEPf6UMg==;31:GQwgrMnsHKZSI3LGX/DkzXSStMsfPMvCXMvxtgREKAH1MdYBw6/OCCja8zgQqOJeg3mojnTQjnPC1A3oUaFBCgIT1SXFBuV1YvCrHIYux3fZoXE1+sYRgNLAYNvdGBfkQ5PXPK3aE5u3WWhOcZIYdeJGB94DJpsEMYwY8aVR41W6IR5TxyPNhpDc3L9uQZbAn+Jp/3XSgK4yAjoennPD5UpU/xCzVHrP3mkL/kOgN8k=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4659:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;20:8z0MBCuLf35t8GlU0AVRnithWravwP3ZGfeu9wVLajv9rkXsHjpwHIxrzSboNvL7ZhlQago8bty/GwVJfq9xiirBUGZwEwP2/fpVDmM3iS9IX7GTwaMF4/nCz3MoF/9kOaCkhTlZodIdsUW0VHDS7ZbG6klVSXUylaaEpwyVHCqEGQ9FHRvT3CfePx4cJ7VxPmGRhDJO+Lvt27uh3fnypsWH0fkWHrTZ4qCoM2TV4wroyVnqlp8U3ZScrJ4/4Wtg;4:ZNuIccbn2EWtdtPDtLoaFVHa5fN2XKYu7Rz2RkAOfukS+bwtNlSIPLeRpQNtxIpKKfNUCwAUIyXo0j3HLkd0tE9yO+7f8GekJeXEgi6TQBo9uV4t2vIMCfkANoH3+raF5nCwUygw87QMVDkRuN546iLCxDmpaumfD3OcF3o1zdNvto//QXZ5EKlxbLnuzR8ZY9fjPVp5uNi9GoLXC/XwK82QJete+NJqTEVx86m1tXuz/CLyUGHWO2naNT5V07v2jH8MCvSPXHtpocry7rl63w==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4659EEDF67618530BDFD05849E160@AM0PR04MB4659.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150027)(6041310)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991041);SRVR:AM0PR04MB4659;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4659;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39850400004)(366004)(396003)(376002)(346002)(136003)(199004)(189003)(64126003)(97736004)(6306002)(81166006)(305945005)(7736002)(8936002)(68736007)(52116002)(2486003)(52146003)(23676004)(67846002)(26005)(186003)(36756003)(86362001)(31696002)(16526019)(53546011)(6346003)(31686004)(386003)(476003)(76176011)(106356001)(486006)(81156014)(2616005)(77096007)(956004)(6486002)(3846002)(11346002)(229853002)(446003)(54906003)(2870700001)(345774005)(316002)(105586002)(16576012)(58126008)(85182001)(53936002)(65826007)(39060400002)(2906002)(5660300001)(25786009)(6666003)(6916009)(966005)(8676002)(72206003)(47776003)(50466002)(14444005)(6246003)(478600001)(65806001)(65956001)(66066001)(6116002)(4326008);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4659;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU5OzIzOkMvZGlqcXd1ekQyZmE0MnlsTHQzZHVGdDM3?=
 =?utf-8?B?bXgwa01pUmZyQVE0U1Y4Ti9lNnRzeWY3Rmcwak44aERDRnkwWFpwVnUrUytB?=
 =?utf-8?B?L3RKczJuaCtsUFJ6WmtqY2lkUTdFeW1QbGg1YTk4eUd3NWlNMXU0c3JPOVRo?=
 =?utf-8?B?YjlJUnlMLzhhd2Z5aTRZMGpQcFpKUjRtU3lRZThiTlRWQ2puWmhWL3BjZmUz?=
 =?utf-8?B?d1B2K2t6QnJmeGhCdnd1QWVDU29seUFhYlNoZmhKY2x5OXA2NmdVQzZFaE5o?=
 =?utf-8?B?VXZoc0RTS3c0QlJIM1pwd2pXSmRvVWZ6QVpHNUJEMFE4YTcyVlBrWHg5a2JC?=
 =?utf-8?B?Zlc3bW5MSzRldEEyT2dzeWxyMFBsZERyemhpWDZhck1qbEpuVmE1ejZROHRC?=
 =?utf-8?B?RjhZMlhRWWxycGJKdHhtSVNybndYc243aFNEWWdRemtybVJ3cjVOcFVVTkJy?=
 =?utf-8?B?VmVPdU1vdFo4SnB3WVd2NjJmalBzS0pTRmJwNVJYMklpWDNocFJuZS9xUkFJ?=
 =?utf-8?B?aUVxaWRrVC9DQ2E0ZnJldEFjZmNNd1pFN2VJNlJlUHZaekhpZUN1SGtSSGxK?=
 =?utf-8?B?c0g1TjdxUmFZRGM1YWl2L1Voek8rV01JazVRdDNJTGIyYUp4cnRnLzJ0cWM3?=
 =?utf-8?B?MWdWam93aDRremRWbzAvY3AxdHBFOWtWazBFSVVyVmNrdEpsd202UFBDSXZI?=
 =?utf-8?B?WnMzY1hQMktuem9jSGljdG42TVFGRDhlMVJBRmVGSGk1Z1pEUVNiUTZZMXZy?=
 =?utf-8?B?WFZxbWFQd28zbTNDMkw2M2N6TEs5NkhESUp5dXZqVUQveHhZNm0wQ2hYL1Fw?=
 =?utf-8?B?VUhGQXZkTjExVE54VHRZOU1lNkQ2NjZKN0U5RDhNcGhrM0RNWnJIbnhlZCs1?=
 =?utf-8?B?MjMrcGhoY1hOQ2JHVk5Ma3NnTVZCWitDeXBrYVZTWklDRXNZNHo3d0lWdHdq?=
 =?utf-8?B?dk16TEF3Ty8vazNsOHRkdE8zQitqU1BSdmk3dXA1cUtOVUJ6MHJjajdTMDdw?=
 =?utf-8?B?N2hpL0VjbFRubnUzbkVVcVJMRW5wdGpDcjFlNUd0NllsK0puMzdnK2dRbG5M?=
 =?utf-8?B?cnU0bUM5SSt3YmtFRWNKUFU1NlFQbHc5VW9yY1E1WHo4NTArYjVhQ3Z0TVhu?=
 =?utf-8?B?dE9SZ1RzRXQxajliWklCOStEV2xPQjE4T3AzdHdDeVhWRjFDeE5tL1dya0gx?=
 =?utf-8?B?WGszajNSR0FjbFB3b2dEQ3MxMUJjdWp2SVE5MlMvUDJUdWJmMUJPUGN5cEV4?=
 =?utf-8?B?OVZ6RXVCanF3UTZrbEpIVmZXTHZJeWNyTFU3UnhmZFViR0FvL0wwSk1PcW85?=
 =?utf-8?B?QmFEMituSHk3M1NQWUI1ZHJIU0VFOHdVNDAwSmtzYmhaRHkzNGI5eFBSWWZl?=
 =?utf-8?B?MEdRb1h6OFNxN2hWK0pGNkQ2Lzc3TVdVc05UUnM2SGF4dkZtZjVoUHhja0hX?=
 =?utf-8?B?dnZPekFEb3hOaVRONmtNem01c1dKZGhnRzNYeHpOWWpWTTlTd3ovN0Z6ZTdB?=
 =?utf-8?B?Y3EyR016L25rbjZBbGNLK1U3RE9iZXlCQU41bzg0YjlVQm1WR282UllkUEN2?=
 =?utf-8?B?U2tmVCtPOHA4R1RWaGwyb1hzOU1wTHBIbmVCOW5sTzBscDZxZkpXOUhpV2or?=
 =?utf-8?B?YzFUWmFtR2I2WmNIK2dGREQzVUwySGNUeWZvL0l4aVFocFJXaHhUSXJLMHVQ?=
 =?utf-8?B?VW5WZTkrVERXNndibjIyU2pkdXZnRE94dWRKSGxVakxrb0I4YkJLK0I4VUhz?=
 =?utf-8?B?Mm03akg5V0l4SGszQXVRdG5Pei84L0VsNTBVSGdlaVRoMmxLSXNQcFZ1TkxT?=
 =?utf-8?B?RTBlczFZOFdBNldhM3d5dWN6Wk0xTkV6ZG1mdUl1eWY4azlTRW80U1lPaDR6?=
 =?utf-8?B?dWRnejlhVFo0MTQ4RHBpWlFlb04zU2Y5RWdRamJLMHV3L2drYXBucCtJbitQ?=
 =?utf-8?B?RXBDRVdVQi9vdFBhaGx5UjNtYzRxYUtBRnJpc0tzL0ludU9JZHZBa29RbkF6?=
 =?utf-8?B?SHJBL3Joa3ovQkVUY085alVSQnVDVFNPZHZOdGJzZEhFNlJ2aDlKdFF5Ylpo?=
 =?utf-8?B?NGlEUzVRYWdQWVVHdHEyN1BxMmJlZUVPNER2R3c3c0xyQ3h1MHV4YjNSSWtF?=
 =?utf-8?B?UG9BOW52Sjk0Ri81UHBVeFhLNUFDNTEvRzBWSFhOc3k1TWNMTVFXRmxYcU5z?=
 =?utf-8?B?QldsQVBKNklVczh3eCtIQUViV01nPT0=?=
X-Microsoft-Antispam-Message-Info: SsXWXdlLGRVMRP2QM1zRfBP7n/1Fs7PCS0BQUtPRs2dXIw1lgZsB4WxO6viLRTXhWMlP2zr/mkwmB9sOCInLSBTtw8ZEkmP1xeeYUnN3mEyVsjhj3AzlhtIA9KkSmuOVM9HjWR+xTiBoKPSZVnzdd70ffn4HsyIMmhJz7oq9cDQwoukghqmXjEroImXxMwM7kuKy8HW737BNCyHMLy5lVtT6KWdU/dDqcxe5J6GuYHS00D695DcR1F2Z543T6mNcenffimW2av962X1BJvGycT9MHzjaXuoUnOEwL7vo1ggfOfJH5keums7H635I8dFH7gHfWGrw9RRYM/43wtQXtbBS4b+A/6RLPd4Msmbpw10=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;6:fOluRKmr25iHoj7C/Y/yoqPJEPwfA16LyqOqajEr+d1DMsC68u0t6p4ZP0kPYqrH8g6LZXVEN5dHr6cOIaNFn8g+fcxkJLdPNxtYscr8FR/Ju48G3PC3S9Z++vwJo/7NQG4KZ8ZKa3oGsC08RuNOFhA/7GBBEABKPgm/RaDRrhlLjeJVnnDcDqgKBESoJAItbBI6dfvXUvQKqlmv+tJqJVlOUmxmyOcy7KXCAlWbDyguPt7lrGaShUKGtndKFSckDhMIfk/sJy7mbznaeQMCOQ2Asp2mO57HoQB8CroIokOqwYIC9CubA1bIUho+EcIHsl6hBv7aX/o9fL35R2/fR4DHfr5llWelo7U0uM9+U+ftl+0jdzvPYkaf1qUZ9B5YD8tLeM8Vl4bXXAyg8V1MT+WzTOso4wsb75AtfGutI0Prfn0uxn1SONu9ML04+Jr/FC3JfokXzPbSFYC015O7Qg==;5:jOI2T9AVErYE9S2snMgF5KekCU2oMRxq5TrjVAuTsWY56GkgQWm7/mCgW3nEQnv7ooCHcose0Fd1STnfkKRhx2/tKoXbBXzzquqkgLb8TNBZq/l5uXDtBTVJ8t4beLbbd86zM+BXuEHb3vYDTFU9YO+td755HRDhM1e6ZH4dPUI=;7:pm7+yKOO01p7V+e7+61oX7khXo+ZDRg9WDtu+ONnM04+tXgfY15bs6KNCyj1Vj203/sRLhjtYR3/EktJmTUYmv6Z0WPJ1pkL8ASnUpRdobjghswvRElD1pWxfMVMT2eMPcPkLZPZ53IMZ+dZExXtPZXF5AqKO1bxLhn7G+ypSE3JLpqNmv+1oXAjOqhkZsxxgcdhSzIwtusfQEszz984UdfyTVNV0elFFrlNjDr5sUzLXkIf1Nw1EsydICaK63z3
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 11:52:49.1967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04573ebd-f3ad-44f7-e2ba-08d622dd6acf
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25.9.2018 12:21, Thierry Reding wrote:
> On Tue, Sep 25, 2018 at 11:11:32AM +0200, Michal Vokáč wrote:
>> Hi,
>>
>> Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in
>> sysfs") it is not possible to export more than one PWM channel.
>>
>> This is because for each exported channel a directory named pwmN is
>> created in /sys/class/pwm/. As channels for all PWM chips are numbered
>> from 0 it is not possible to export pwmN channel from one chip and
>> pwmN channel from another chip at the same time.
>>
>> In theory if your SoC has N PWM chips and each chip has N channels you
>> should be able to export N channels. But only one channel from each chip.
>>
>> I found the issue on i.MX6dl SoC with two PWM chips where each PWM chip
>> has just one channel.
>>
>> This is how it can be reproduced:
>>
>> root@hydraco:/sys/class/pwm# ls
>> pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0
>> pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmchip1
>>
>> root@hydraco:/sys/class/pwm# cat pwmchip0/npwm
>> 1
>> root@hydraco:/sys/class/pwm# cat pwmchip1/npwm
>> 1
>>
>> root@hydraco:/sys/class/pwm# echo 0 > pwmchip0/export
>> root@hydraco:/sys/class/pwm# ls -l
>> pwm0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0/pwm0
>> pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0
>> pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmchip1
>>
>> root@hydraco:/sys/class/pwm# echo 0 > pwmchip1/export
>> [  543.110824] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
>> [  543.117314] CPU: 1 PID: 351 Comm: sh Not tainted 4.19.0-rc5-00025-g249f3ed-dirty #8
>> [  543.124990] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>> [  543.131587] [<80112d20>] (unwind_backtrace) from [<8010ddb4>] (show_stack+0x20/0x24)
>> [  543.139383] [<8010ddb4>] (show_stack) from [<80ba1044>] (dump_stack+0x80/0x94)
>> [  543.146652] [<80ba1044>] (dump_stack) from [<8031e2b4>] (sysfs_warn_dup+0x6c/0x78)
>> [  543.154257] [<8031e2b4>] (sysfs_warn_dup) from [<8031e61c>] (sysfs_do_create_link_sd+0xd8/0xdc)
>> [  543.162988] [<8031e61c>] (sysfs_do_create_link_sd) from [<8031e678>] (sysfs_create_link+0x38/0x44)
>> [  543.171986] [<8031e678>] (sysfs_create_link) from [<806026b0>] (device_add+0x2c8/0x630)
>> [  543.180025] [<806026b0>] (device_add) from [<80602a3c>] (device_register+0x24/0x28)
>> [  543.187724] [<80602a3c>] (device_register) from [<80501acc>] (export_store+0x118/0x190)
>> [  543.195762] [<80501acc>] (export_store) from [<805ffc10>] (dev_attr_store+0x28/0x34)
>> [  543.203539] [<805ffc10>] (dev_attr_store) from [<8031d7dc>] (sysfs_kf_write+0x48/0x54)
>> [  543.211485] [<8031d7dc>] (sysfs_kf_write) from [<8031cde0>] (kernfs_fop_write+0xf8/0x1e0)
>> [  543.219696] [<8031cde0>] (kernfs_fop_write) from [<80294d78>] (__vfs_write+0x48/0x170)
>> [  543.227645] [<80294d78>] (__vfs_write) from [<80295064>] (vfs_write+0xb4/0x1c0)
>> [  543.234981] [<80295064>] (vfs_write) from [<802952e8>] (ksys_write+0x5c/0xbc)
>> [  543.242144] [<802952e8>] (ksys_write) from [<80295360>] (sys_write+0x18/0x1c)
>> [  543.249313] [<80295360>] (sys_write) from [<80101000>] (ret_fast_syscall+0x0/0x54)
>> [  543.256901] Exception stack(0xecfbffa8 to 0xecfbfff0)
>> [  543.261980] ffa0:                   00000002 76fc8000 00000001 76fc8000 00000002 00000000
>> [  543.270184] ffc0: 00000002 76fc8000 76f5cd60 00000004 00000002 000bd134 00000001 000ba730
>> [  543.278380] ffe0: 00000000 7ebff954 76e8b988 76ee3cd0
>> -sh: echo: write error: File exists
>>
>> I am not sure what will be the right solution. The problem is that
>> numbering of the PWM channels does not work the same way as in the GPIO
>> subsystem where each GPIO has its unique number.
>>
>> Should we just revert the change? It was not documented in the PWM sysfs
>> interface. What do you think?
> 
> Fabrice has reported the same thing. We've been discussing possible
> solutions here:
> 
> 	http://patchwork.ozlabs.org/patch/973224/

Thank you for the reference Thierry. I was convinced there must be someone
else who encountered the same problem. My search did not produce anything
useful though.

> It looks to me like we'd need to at least revert the patch to restore
> the sysfs ABI. At the same time I think we'll want to fix the issue that
> the offending commit was trying to address.

Agree, ideally we want to solve both problems. My knowledge of the overall
architecture is still fairly limited though. I have no idea if/how we can
deal with the issue the offending commit was addressing if we revert it.

Would be great if we could somehow choose a different name just for the
symlink but leave the device name as is to not break the ABI as Fabrice
suggested.

Michal
