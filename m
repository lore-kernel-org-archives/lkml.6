Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756079AbeEHSba (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 14:31:30 -0400
Received: from mail-he1eur01on0097.outbound.protection.outlook.com ([104.47.0.97]:52088
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1755759AbeEHSbW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 14:31:22 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: I2C PM overhaul needed? (Re: [PATCH 1/2] i2c: sprd: Prevent i2c
 accesses after suspend is called)
To: Wolfram Sang <wsa@the-dreams.de>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Cc: Baolin Wang <baolin.wang@linaro.org>, Mark Brown <broonie@kernel.org>,
        linux-i2c@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
References: <99031524fa147e72451d26f54b24f36093c0d3fa.1523255712.git.baolin.wang@linaro.org>
 <20180427121417.auv4ppryegkprv32@ninjato>
 <CAMz4kuK3fyBhdrUcLvY0s0N-0yY9_0MrAAi9cWdX1ZfdNW+R0w@mail.gmail.com>
 <20180502052336.i5f4yv2ho3za7qa7@tetsubishi>
 <CAMz4kuJAzr-ybCCmjx_Tcdw6qNYN0wLGQgWsb1H0WEkR4ZpyYg@mail.gmail.com>
 <3485f73f-e356-6db0-89fc-d51bf8bdab71@ti.com>
 <20180504122447.u3xgrkperxz5dpcz@ninjato>
 <bef80500-4727-d324-f0c8-4fc6016f43ed@ti.com>
 <20180508163221.2slrtg3cidvpj7g2@ninjato>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <82fa7efb-5145-ff3b-0e7f-4f83b9fcc1dc@axentia.se>
Date: Tue, 8 May 2018 20:31:15 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508163221.2slrtg3cidvpj7g2@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0158.eurprd05.prod.outlook.com
 (2603:10a6:7:28::45) To HE1PR0202MB2778.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;3:joy2VaUUkPFgZPB4sogNx8xahWxWzAc7iEg8U+vp/Gs4cYBnNuQUGOmInFNdKp/f7KzyTjW6XXpldLlQckR/Qtgr8W8vV6eg0KT79sqSzAIYr1ukWj9gpBCjhvOFenK6bfdhhJXRC4LrYWDbJJLLYPYAiTcs/XNSSc5IoKRJOSSptKVqi7LARaSKOuD3uVrOpJCdhDkYJMpQJEDP4R0BlZVEY/6V3NgKCHYTRvti5ErV9w+we26RGE6eBtZvuMhz;25:tuv0L0C56RVukoYA0lfGbWYKERqmKwMYAjAD55ApTTQDEeSbXDmzRI2ICY2zUCavIPjlfEgCVTUJe0cIKW8JB7WbqEbAmHywMDqhRsTXC6g6EfMdS0MEr1LU/vj480Uc5i2hGirCgzCK0WDChqvviD1hP5GNctzbSjzkAW+aD5nmY01rou6j/wP3Afoj9OU0Mx9cruJfqvDay9MtZcm4M31W/xyWE5rk5kCz6nPYuIxPLqKH135uCPCzs8kzSiyo9Aws6ThgwrTYCZdosvsSjDo5Dy0v2vjGlPBIibmJsgE+eMppzefuxy9t3zOtXwOJl+JjPLN4mo8ZomSTU8dhbQ==;31:mQEvNkXkocWnvcBH7QybOvNngw9vhyw93JiYaytg2QgdxH4uZKdDuZ1xvvPgGg2Gzfkw2/lfSP5bpl4160wS3urxWJvtYYPpUkYLOBaG6cmZ0ud+44/OJ0xuABOSX6ZsHMgBhQJQu10DAQRsrsBe7EbJCVJRWitfda8Vl1QGMXmS/gVTQU/LKWjcKTwGUnsLBdI15OK0++UWRMUPWUSFxrjA4WjCFbsrN/Tdxo7Nglc=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2778:
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2778CDFDC5A03BC2E706A9EABC9A0@HE1PR0202MB2778.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123558120)(20161123560045)(20161123562045)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2778;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2778;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;4:NPOiBy+1KHhpOymZAtgCaJf65s2av10JW6Jso5pu7CMPllpJh8DBtupHu7fnLHTqLB2nbefuoiOXuFbyvD7DFNpYDHJgzr/BP+htyVANkTChDuLDI//2ODQxFT31UGb2T37FxdylYVG1JXyvGsEQAW6XZQ7adRxq0Dx88ggCnHJz/duUim2qFPYPyNFHbD+Zkh5zB1ssNXaJTmimnMQNT008JaG5Gxx7VT2T1WiIyT0MB/1VI3x4AwQVj94g575JtqSc9TMJPzu/WdKS054jRg==
X-Forefront-PRVS: 0666E15D35
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39830400003)(396003)(376002)(39380400002)(366004)(189003)(199004)(377424004)(3846002)(7736002)(68736007)(81156014)(305945005)(6116002)(229853002)(16526019)(386003)(6666003)(230700001)(53936002)(8936002)(31696002)(86362001)(6486002)(186003)(81166006)(97736004)(53546011)(93886005)(15650500001)(31686004)(6246003)(5890100001)(2906002)(106356001)(105586002)(316002)(11346002)(486006)(446003)(4326008)(478600001)(36916002)(117156002)(65826007)(956004)(2616005)(59450400001)(5660300001)(476003)(50466002)(16576012)(23746002)(3260700006)(76176011)(64126003)(36756003)(25786009)(26005)(8676002)(58126008)(65806001)(47776003)(77096007)(54906003)(65956001)(74482002)(52116002)(110136005)(66066001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2778;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;HE1PR0202MB2778;23:wxcyZka8T1lerJ/0RLu1L4tgnBHNMTkqiN0?=
 =?Windows-1252?Q?Kq/Y9XSwNHCyHms+4yvYwyOMAISnDkS3NYp8Gb4gHT0JiZmxNpalfvBR?=
 =?Windows-1252?Q?9qSJtz6GKcfhyMgHFV2/1hgfH3kPJgUTmfZ4MuDcXRomqFcTKnH/UJwE?=
 =?Windows-1252?Q?1/DZPD8XpXqlwDv3eXc97GEIlfxsyRcZeZo2IMJ1NHcvrIWmjL4iVRTJ?=
 =?Windows-1252?Q?6z3931XznhctxyYBq6/Bi3l0vKccHXI0ubbmQmUumK8+qhitmQIIim/l?=
 =?Windows-1252?Q?pPDVcgA/rsVL916mFTDxMz0ZynfxKS6MetJazvHj8JgUQ/CSukcfWsRP?=
 =?Windows-1252?Q?pSuQo2SyEUAdQssLWQcJJtuuO4ZZfqprdcFsHA7ylckVBJwudP3VMxPu?=
 =?Windows-1252?Q?ZJ8mgyQJV6Gd1J7NU0eOrDA7dwAwlYfckwj1+PAarILh+3PwDx+Kcaxl?=
 =?Windows-1252?Q?xcrOLx+b1vzTllNXi4gHadYO+Q5gTnZ+q8+tW8kNNh04Mk1DMgyVRHOW?=
 =?Windows-1252?Q?+NVg1kfldT04/RbyoScxJtmGUklRcg+i153PFzq8f6mA4YMaH8TeJBRC?=
 =?Windows-1252?Q?2/B95J5JnVqc19E8Wj5LL/xIhO98jYQmQUP8EBUU7Zm60XDSVqC/r3VG?=
 =?Windows-1252?Q?FNppsVSoggGAkZiN1lqDS2rzGrpe+pfN5zemCDP8BxlSKHFRDHEROs3l?=
 =?Windows-1252?Q?osj64hj3DY46r6CCaeZNP1oqvrIKO7YFjH9KJo+1/n8TQoZX6i7LOCSO?=
 =?Windows-1252?Q?dzHpZHoeedbKI6vrftgh1nUHsB8VCtLuRUtBVNDPYFRwRbi9/p8Q+J+P?=
 =?Windows-1252?Q?chTtGO+eLpjwAX9+iYmOw2rLIhBo5awXRmw3JbU/voQENqqo9H027Ccy?=
 =?Windows-1252?Q?+VMb5gf0dnI9U0jRpamejqwJ0vT3zp4hAqHjvHhFkTh0Bmdfx0z/lYi5?=
 =?Windows-1252?Q?JEq8fMKF0gdPYy6oc5lKy8WHgR3wikO7Bqp6yLK+P0FIWZv4ttvAkTAz?=
 =?Windows-1252?Q?btr/OWupLRGyCZDtzLgPVPv47OA2v1g3gNNuXBzmaxcTRLiVD03D3XQF?=
 =?Windows-1252?Q?sCtJexJM9b5pSr7b75Vy9wXFkZl2dt+oOSQIgQoBL3fxDLyfX7gDr+di?=
 =?Windows-1252?Q?769t5I+/GSGL2Ce5nep1s6ooAQy+HSEkSJOzvbJgLAOjml4dUfX3YT26?=
 =?Windows-1252?Q?zuAh6QZrkCbehLES6wBMyvCMkxGaIXoyCJ3Yborzzg9MPd4EAeWs9FjI?=
 =?Windows-1252?Q?2tcIDp3RLSpYR33A06dt3xVGU7HmIwut6Vo8oet7cYi6WqFcrt+9QO0S?=
 =?Windows-1252?Q?VtaYPf6vxmlsdTGrYlgzq7zrY5btyX4qM4/YgGLB+MDP+GrTGaEXAHxm?=
 =?Windows-1252?Q?9Vmhh2p+RDkmwNUHdUZ5q5QLEkKwfZjQaUC+3GgVZSF52PwFV1d3lNJu?=
 =?Windows-1252?Q?UDnrs23ulLZRLBODBqyOGXjgMg9F77MQTu8et1MZO7XFXUwUB1pMJAHx?=
 =?Windows-1252?Q?3uPix5fQLcKOlMDSoTReP33IWthMgpjNpMO5TuVavv6vrtd2a6PQefEt?=
 =?Windows-1252?Q?i6cFlrXSGQ2azWhP48DYQomSF6sv0Bv8lSnV1Q8nYiivE24vRAkGfQ2b?=
 =?Windows-1252?Q?xp1JopNd9+/2M0EVwTZ/i20cUW75uAt9XczMf2z9nZDyKqzwUxrLgN+F?=
 =?Windows-1252?Q?i8Np7NIRLgOsSCLCChiIL/cGi1nOMgXNkxI8zRpL0HjtB1aebQNwA248?=
 =?Windows-1252?Q?kTW8gQ/X7U5QLX3HuWxu8HavPmp69OMWA4a2RvNI=3D?=
X-Microsoft-Antispam-Message-Info: 7E63O96kRVs/brEDjrAOzYJf4sqz627qKgRpuQQIaImaBFcamMogar8qxCu2U3WyHG9qhl1XLfRiUo76XBjhUlH8V9incDN24vV2f7y+qHAJeukXWe0BaZz+ZNW7J2naLsYkBDFQqa5fkBSJ1XnuIx7L3vaMlxXTJC+YV9QKc4BK7wRoISjg6fJqkxgG+1sn
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;6:PGoNw3e8d29Vz9LEJGl1iIl8BDYNxjaoL6GS8QYpHlWiz6PrJjWlaqabdFTHWFkT82C4O2wpHuVAtlmvo4/TUC+IMvXJ5SyPQdNfPecupVyhILoncFVFi4+s7omesVa3vGSUdIyr/XXiuovoRxpASygn1/Fenj/Hq1peJaBbm6L3kydkCKkY4vQRy9Ax+uUWUMZ87igPZGG9FJGnjBOIRBteS20bvgMJJxHPIUdxMXkd+ae0tPWWzYYUV6g9LOXlSYsZITadHkd3EpMEyZeZ/k1F8tGGQYIrwcteiOmA7Z7Xa2hbkfJZmlc6nxNQdlrD5O3HMW+xZjFd389u58j25LiHUORy5YIqzF5yE5niIncE1MwCNzx1olLCMIuDY/lYXWkd3C2Z9boy/1/3AhzobXX7sk9ePtxPHOn3uTjBcaWzhOdmb4QFPwg3ofQzY1vVmYY0dOTLPOttxJ6w8cu5/w==;5:UqqSylBbI9aiKZPqfl5rot2z8k6uGUFCU8xDvk0VnJvjDIHCQEkxohdKvWXqc5V20UrR+CxegcM2D60ufoFoYuFz6TRUdspufrZwdD4iUousej5SrEfgZk5cfc1EDAJ88m4WN5c/HS7Q1E60okDBpVtI7eJNAxSPQ50AdGn/GTY=;24:uhUmjCydGjyEZgjmSPDUQORMuyrKMflRXg+NxPMv2mcXp3tGUzCRsJ+UNiznx571gEHVJkKKZJyqaoLhsT4aGKs//mxSh4FyPAYVhbHQMoM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2778;7:nmvBUU734/gFCeKCwMWmTo84ueb1js/ODvXRAgRQZQLrgBf47Nq6YYCIBodewNDknfohdrrm5cbXeSgh55rDk1B2gZbJz5bveP2gZ+aBocRQSXn5mdyq9AIrKxSMKWTfejvghbipWho9rqOWbsgXQW5MUFi0AOGsSRlxhA6r0F17dV3AU/wBJ5hXa9OZctRMl30idVDQxHZpnZMWFlVktKLZRLIiHmCIxkQuIEhUy3h8F9Jhlu5jMkmc3JXL64gz
X-MS-Office365-Filtering-Correlation-Id: c699081b-d98b-4228-5c67-08d5b511e47a
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2018 18:31:19.2901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c699081b-d98b-4228-5c67-08d5b511e47a
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2778
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-08 18:32, Wolfram Sang wrote:
> Grygorii,
> 
> thanks a lot for your input. Much appreciated!
> 
>> That would be great, but note:
>> 1) only i2c_transfer() operations are locked, so if driver is doing 
>> i2c_transfer(1)
>> i2c_transfer(2) <- suspend in the middle
>> <- suspend in between
>> i2c_transfer(3)
>> It will not help.
> 
> Will it not improve the situation by ensuring that at least the transfer
> with its (potenitally) multiple messages got completed? That we are at
> least in a bus-free state (assuming single-master here) before
> suspending?
> 
>> Everything depends on timings :( - in my practice 10000 suspend iteration tests
>> where required to run many times to catch 3 buggy I2C client drivers.
> 
> Matches my experiences that creating a reliable test case for that is
> not that easy as I thought. Or I am missing something obvious.
> 
>> 2) It's normal to abort suspend if system is busy, so if I2C core will be able
>> to catch active I2C operation - it should abort, but again I do not see how it
>>  can be detected 100% with current I2C core design or without reworking huge number of drivers.
> 
> I agree. After second thought, waiting for i2c_transfer to finish maybe
> won't be enough, I am afraid. We don't know if STOP has been put on the
> wires yet. My best bet now is that we implement such a
> 'is-transfer-ongoing'-check in the suspend function of the master
> driver? That check should be optional, but recommended.
> 
>> 3) So, only one thing I2C core potentially can do - catch invalid access and
>> report it. "wait for transfer to finish" wouldn't work as for me.
> 
> And we do this in suspend_noirq function of the i2c core.
> 
>>> I at least know of some Renesas boards which needed the I2C connected
>>> PMIC to do a system reset (not sure about suspend, need to recheck
>>> that). That still today causes problems because interrupts are disabled
>>> then.
>>
>> this was triggered few times already (sry, don't have links), as of now,
>>  and as I know, the only ways to W/A this is:
>> - to create barametal platform driver (some time in ASM)
>> - or delegate final suspend operation to another system controller (co-processor),
>>   as example TI am335x SoCs,
>> - or implement I2C driver in hw - TI AVS/SmartReflex. 
> 
> Yes. Please note that this is only needed for reset, not suspend. So, it
> is a bit easier. Still, it might make more sense to use a platform based
> solution. I'll think about that.
> 
>> Sry, but 99% percent of I2C client drivers *should not* access I2C bus after
>> .suspend_noirq() stage it's BUG-BUG!! Any W/A will just hide real problems.
> 
> I do believe you, still is there documentation about such things? I like
> to understand more but didn't dig up something up to now. E.g. I grepped
> for "noirq" in Documentation/power.
> 
>> "master_xfer_irqless" might be a not bad idea, but, in my opinion, it 
>> should be used explicitly by platform code only, and each usage should
>> be proved to exist. 
> 
> Yes, we can think about it once it is really needed.
> 
>> Some additional info:
> 
> Thanks a lot for that!
> 
>> I'm attaching some very old patch (don't ask me why it was not sent :()
>> I did for Android system - which likes suspend very much. Some
>> part of below diff are obsolete now (like omap_i2c_suspend()),
>> but .noirq() callback are still valid and can show over all idea.
>> Really helped to catch min 3 buggy client drivers with timers, delayed
>> or periodic works.
> 
> Ok, so what do you think about my plan to:
> 
> 1) encourage drivers to check if there is still an ongoing transfer in
> their .suspend function (or the core can do that, too, if we agree that
> checking for a taken adapter lock is sufficient)
> 
> -> to ensure transfers don't get interrupted in the middle

A note from the peanut gallery: the adapter lock is not sufficient when
there are mux-locked muxes on the bus.

Cheers,
Peter

> 2) use a .suspend_noirq callback in i2c_bus_type.pm to reject and WARN
> about transfers still going on in that phase
> 
> -> this ensures that buggy drivers are caught
> 
> 3) write some documentation about our findings / assumptions /
> recommendations to a file in Documentation/i2c/
> 
> -> this ensures we won't forget why we did things like they are ;)
> 
> ?
> 
> Kind regards,
> 
>    Wolfram
> 
