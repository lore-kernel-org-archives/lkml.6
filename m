Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAE9CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:58:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 120872064D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 09:58:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="s5J5nd2D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 120872064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730524AbeGTKpl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 06:45:41 -0400
Received: from mail-eopbgr60098.outbound.protection.outlook.com ([40.107.6.98]:45246
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727243AbeGTKpk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 06:45:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNg6I6FFoJQRdAuONFTdu9V1kpNuglYGohg3lRSw8ug=;
 b=s5J5nd2D+yn7T+8htN7tsacKG+XIVpcSyzMnyqFt4NNU8QdMwq7feGewZwopU28DpRGNZVugKQOb7nmFjkbsNhIs5o7rVX6ByjApv80TgMyA59wdnZg16EzSNMrxLvRqkV5UslMMrCK6ugKw+ATmpqlUvs+HtDaUJIBQlHPvNRI=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.973.16; Fri, 20 Jul 2018 09:58:05 +0000
Subject: Re: [PATCH v6 00/10] Add the I3C subsystem
To:     Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@bootlin.com>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vitor Soares <Vitor.Soares@synopsys.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        linux-gpio@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>
References: <20180719152930.3715-1-boris.brezillon@bootlin.com>
 <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <2ab0ab75-2df0-2714-f007-c33b25481016@axentia.se>
Date:   Fri, 20 Jul 2018 11:57:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2MP5+oFz--e+BM24D8Ahw7H_RKgN1S6wY1nQE6JL0dmw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P191CA0002.EURP191.PROD.OUTLOOK.COM (2603:10a6:3:cf::12)
 To HE1PR0201MB2459.eurprd02.prod.outlook.com (2603:10a6:3:82::7)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f0d6b70f-8821-4246-90a7-08d5ee274ac2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;3:1XgbzvCip1XKrReek71dZ3uTpcpFz6EYD7tKpPViQDLoveQGgT3DnFTpDoDClSddYexeh0VTT8KQlJobY5wwj63LWHFvCF7mJgLCvGRgVsvZzarkEM1CCKYXeetIDn6wAtmXrfpKXIoxb6sGL7bMmB430yCIatDXYZrIvvrRcvdPhb6W8gUe9uZQG+D6UGGckvLxVrUeJK+uxictXZpQDkOuBrh6mo2FuGQwv1VtzSsQGB+Cid9sHTkttrhdAyDh;25:aoaFN/Cd7Hi7UFFeY3kV+4dw8Mbz+uZnHDA2Hter7MA4WrfI5uICbwqiw6zc0CWxMjuF8JMSX5GHaRyuzwjlxxzBmH94e6Ju4Lswg5/VsgmIUlo5Rj1TZDUrQsdU1TDS6970CMMutUMdmtZL5Q4RUd0xsMGLd+iqSFmaZi3X+aPd8f5pWDnPLITUwcFpStdSFNKrnKTEbRs9YKsKvquKkdnfWOb6kElLJXBubWOpZm4vHtWqnD9AtYZoZrEPFVTdzZQkJDrYstA4/2AnHBJjfTvxy8+C/XwjBEBqMMzPH1nMW6JwSVCbgjWdAShNCZdGozlxlMGAj+5Pv0ptNJUfEQ==;31:lnvzQzf8gSDpQqY12goE7pTFMDT2VB6SsDErspr7eYZAaH5LMkwX0Ax4bqacdkZBoCSyTiN9Kssgax7xK+dSyhyZ60qI1bOzmvvy5Fbdxff1Z9ZhqcYfE5fasl+VKqsG3hjrEFUHz6i7zdqDx1PaIc1lOmP/CmhCfS0sCJjF6pkQbDHm0OSUs71WZGwKullzyYn0AKE37ob9oox88KrqI2U8wey2se/GotvPy6Fx+SY=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2459:
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2459FD774FB97BF683286698BC510@HE1PR0201MB2459.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(60795455431006);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:HE1PR0201MB2459;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2459;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;4:rseTJoSoniSLgUmSmg6C0oMieCfJYS4EoxCqwBq+jvrtzOofgTvs0fNqUtKknrZPpnkkZu4gYxIzqwVhbJOuwsOIQICYoNxdaFa2nEKLEGK8wkugtWIAW4i8pw2so1lI30j7efSiIRshV/ia8QqLGHv/x2tTIuyk5ylVur5NWMYWVNMueBk6K9HSj/GRsGLi5gXrtbXw/wATuAlUyF5K3IFq+xMA4TKMRVr2OrG/RNOC1LsUMwuwssYyWq4Rb5tA+1FMIYnFxo1DbyrPI7l8JhVf//aOlfSh5Aee3PznPv1qOiassmrtM+iqzpr1zQhj
X-Forefront-PRVS: 073966E86B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(136003)(396003)(376002)(366004)(346002)(199004)(189003)(229853002)(36756003)(6486002)(230700001)(47776003)(66066001)(7736002)(4326008)(65806001)(65956001)(478600001)(14444005)(26005)(305945005)(3260700006)(117156002)(486006)(77096007)(476003)(446003)(11346002)(2616005)(25786009)(53546011)(23676004)(31686004)(52146003)(36916002)(2486003)(956004)(16576012)(316002)(52116002)(76176011)(74482002)(86362001)(31696002)(2906002)(54906003)(58126008)(110136005)(106356001)(6666003)(105586002)(97736004)(386003)(68736007)(7406005)(7416002)(65826007)(5660300001)(16526019)(81166006)(8936002)(81156014)(64126003)(186003)(53936002)(6246003)(3846002)(50466002)(6116002)(8676002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2459;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTk7MjM6cUN6Wm85dHFPMnV0cCtVSS8vM2MvWith?=
 =?utf-8?B?NzlQdUJjc3c0ajRZRVhaK2cva1Mwa3pWbStYQ0svV2FPSTJuMkx6c3V4TTh0?=
 =?utf-8?B?b2VzejUxZTF3UGQyQitnTjlMWmZhcUxkY3NkQWVWc1duZTNObjVXQjE5MlVL?=
 =?utf-8?B?Wi84bDdzU2J3eVoza3NXenZWa1ozb0ZTUHpzTzRQM1BsM2d1UHIxTVVldWJO?=
 =?utf-8?B?U1dCdUlHcFdYR3VuM3B1aGtqd29abC90VEVkWlZNMTNseGQ4c3lQRWdOWk9F?=
 =?utf-8?B?K3ltbW02WUY4TEZZNENDdzB1UndDbW1ZckU0TkRvWXV1UlpBcit0MkZNVmJN?=
 =?utf-8?B?bDhpRmtEWUU0cXlubVRneTIzZG01a25GQ0dKVWJuRXAvaTdmUUxHdTFDTi8x?=
 =?utf-8?B?cjZaWUZhbld6SGwyYk1qakFTa1VNbDZ6QnlybVI1a1hadytJRzE4clN2cThM?=
 =?utf-8?B?VmdSWFNIUFpDbXVVV3g2dUtLaDRJckttYWVSQzc2c3RyOE1xV3lJeUpsdzlD?=
 =?utf-8?B?bG1ocFlOV29xcFFNczdrRHgrWGdoUTdRa1RRS2NhMmMwMTJDRTZVeUI1dnZ0?=
 =?utf-8?B?dzB2TWRTdkhvcEl6Vnd2MlZsNmxiNlVET0huZDhZMm9ldEduUGZEd1Zuckpp?=
 =?utf-8?B?YWVNZjU5Y1pCemY2M1ErdVdwWnhtclc4LzNsNHZ0WEY5bWFTK2NkR3ovYTRR?=
 =?utf-8?B?cnVkWXZjblFrVm1rWG0vajdKWFAxREpLUmNTRE44TUVaMG1MNmltQndUQ3Zu?=
 =?utf-8?B?SnptVDhucjB2dXFUYTJPeXFpTXkwem9VbURhRG54d2dudU5aa0FTZElhcHc3?=
 =?utf-8?B?SDRlM3NhU3Era0cwNHFDM1A1bDNkTzg3YkVEVERmUC8yc0dmSzAva3NxUFRX?=
 =?utf-8?B?TnNnLzhqbXJuM2pCYnBTclV5MjRhUWpwVDlxbHhvekFuM1duQ3BJeTYrQ0NR?=
 =?utf-8?B?bzdrMDlkS1N5dkhvb1doUXczR1VjYXZSSkppL3VkanorSytGVnFGRnNaM2cv?=
 =?utf-8?B?bjI3TTdXeUtHT2pvR1hIRW9oNHp5V3FDeDBhRSt3Zmg1SElqME5MSUdKU2VZ?=
 =?utf-8?B?c3p2U2JUL0dINTVBTTdTb1g2WnlHR3NqaU44Mjh1R1FwZUJGZ2FMRnc0dFJq?=
 =?utf-8?B?NUt5Y0NYOG5CZHkxMVNvV1hKaE0rMlQ2aG9PYVB4OEN1UzgvNGFMUW9xQVpF?=
 =?utf-8?B?U0NhemlVVjdic1l2WXpBK3lreGJWbzFxaXdXakdJaUh1RlhjenpudDlNeXpn?=
 =?utf-8?B?NzE0YWVyWE1wWGlOdlFYaHErMFRjZW1UZVhWYmYxVk0zQ3B6U004MEZ2QmNa?=
 =?utf-8?B?OW9XQ3pPT0lPTHlUdHFYSytHQ1lUemMveXptWWFzUFJNdXFhNHVGa3FsM0pv?=
 =?utf-8?B?RUZnNm9SR1JUNkE4WDN5ZnVvRTdHc2NiYytURjFISFZaYkhBK0RwY1ExSS91?=
 =?utf-8?B?MHpsZGNNUWwrQ0NaTnBPY1ljRlJVbm00Mjc2MmRTK05yazZpZVJsS0t1UDN2?=
 =?utf-8?B?L09yMjJhMGd2UHlnK3ZBWlRXY1lhZSswM1VGTm81TGlSamd5M0tkajlXM0tQ?=
 =?utf-8?B?TXRNZlBxWHIyNG9qWFhONzVFdFY3ZXk1MzNxMWdQdkZuQWJLbFE4Q1BSajR4?=
 =?utf-8?B?WjUxV0dvaVFPM081Q0NtdXVGa2ZIWTlLdzlnUy9HQnI5S0lGRGh0cUFjaFYw?=
 =?utf-8?B?YmYwM0JJS0ZweE5ITVluK0hlckhWZzJSMnpuV3NXd1k5T2hwdTc2T1hsQkd6?=
 =?utf-8?B?UW85M2VEZ09Ncm9nZ05xb243YTBxVEtFeW16dzJOTUZFWGpWTDhNMHd6TzR4?=
 =?utf-8?B?NWhDN3BZL2lFKzdLS3RaSWlMbmd5Mk9hNzYzOFBYNzc4WUxtTFdTdmtySG4v?=
 =?utf-8?B?enVidkxSblBiT0tJVmFaU3dVNEtSVml6TTZySy9USTJSVGVBZ1Fjd1JmMiti?=
 =?utf-8?B?SFhKZmJqY1dOcTZoZyswbW9ldVRSSkg0NUZTdFhnK1VScVdyTFFmNzVhSnln?=
 =?utf-8?B?R2M1cThlQi9iTkw0RkZnUHVvUko5NGU4VFBSQVZiWjFlOHBJNU5mRS9IOHMx?=
 =?utf-8?B?dm1RT0FQdUNJYlBNMFBHTGk1M0VBY2U2WGFsTlVjTUk5V2ZER1F1OVZENlJm?=
 =?utf-8?Q?lMEp5Nc2FKNqQ+mBSD1LLOeU4n05eSQtI0dqsz8cp2JcWr?=
X-Microsoft-Antispam-Message-Info: 4+ZF5Mp5ET2ThcrcR29Q8dqjvLtop6cBLEjSPs9McHxVFRaxdfxZN9Bq4VKWqejOsPA5CbGoY5pLYMF04qz8ZPBou8dEHyt7MiFMzrIsG8t+5bngi28MsO5okvtnO2N/yeEAv8+XZglveBr2TkTRF3B5iGz1BKHMN3ldf709M5GIfTWLAE6S2SO1XJV1z4SL2HvkWUzsZ6jQbRuQza+DPOmN0i43Wi8sH9sABWVIF+HNibxvv8cTJKoRJ2Cu6ieLD1x/XqeaFzzN3iSQCHYy6aDErqrvRdlBY66Q5DlZMkgb5Qgd6q8+lcYhAZom7PynaqVioIXeew0jvKMM9YYpheIn43nSP2NCzZV01aFaqyI=
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2459;6:cma2eJUYvjDGBpThaTs4aTCN/1yt+DHpyKAsJ+gHIbx4fhut0sZnS1hnLv/u1neuxRoU/wAE54SQGEa3OQCvbZ4RPbPl5pkieJHOKsRVa7+yD/kRBsoie2Am7gP49rM84tKRF8xXxNrb6TeYwfBo78qFVQzY8tif2HEyLwyvCIubl7Cv4MgWIvozA6h9tGVVdS8F3/7rFLQFKjDXM1D3NL1Gx+n6BlCsBcS4jgy1EP6x3UuSmDLLOOveVzycsRpah1Nl8tHc+KpZL9qrZ/LMvdwvACmNcICZPXEj7F5pZg5XmcM5pt+6m3kiapHa1XEyvyYK9Zd+2FskxlrZry6WTkKyEQmXtwkHUMQ3UNbXiqEbT05qVqCywG7QxJepQHAnsOgd0Czzre8VUzeV+7ViJvMrjP8QtfoiX8rPUWyTh1CSKuGh8A4Hg1MGRDd9umhLk+l2ZxVxflxgJcqtgbt7ug==;5:6RU5tpBqQpytvRL7qcxOje7ekKAYsJZNYsrOltcRol5YaiGAMV7xVUoaZCfFUqHTXlU6pLjFlAESsz+ybaP3nR0JTp3zMNiJWpzHGL8+M7faPOdOYVt0j2F5h94ILEVyYjOK5n2E2dD6vD8oTuz53vi5vu4lLkRUlcTR7bc2os8=;7:j5UPk3Uy+89d4PQKoR3h+vRV5VnJOYdmIW14em11F3lWWUYDXzTnaiW04g3twuQLBhacPUcWGiFtYkvHLkq3NMYLR9EBbkxtM8G9Ep2ZPCp7jdWRTOraXoZHuzfpbCLzEvbxfTFynJpSRxM0Axwyc+kwkUyVCFdFVH8T1QAos+8ZLjXM3wdnYVgRASDwaulTaglnfZtkFEgHSZwslHLSTdSN32oqy9yjDuFhZD/MuNBAKrZplszeZBnH/7vhxnci
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2018 09:58:05.9496 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0d6b70f-8821-4246-90a7-08d5ee274ac2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-20 10:52, Arnd Bergmann wrote:
> On Thu, Jul 19, 2018 at 5:29 PM, Boris Brezillon
> <boris.brezillon@bootlin.com> wrote:
> 
>> - the bus element is a separate object and is not implicitly described
>>   by the master (as done in I2C). The reason is that I want to be able
>>   to handle multiple master connected to the same bus and visible to
>>   Linux.
>>   In this situation, we should only have one instance of the device and
>>   not one per master, and sharing the bus object would be part of the
>>   solution to gracefully handle this case.
>>   I'm not sure if we will ever need to deal with multiple masters
>>   controlling the same bus and exposed under Linux, but separating the
>>   bus and master concept is pretty easy, hence the decision to do it
>>   now, just in case we need it some day.
>>   The other benefit of separating the bus and master concepts is that
>>   master devices appear under the bus directory in sysfs.
>>
>>   Discussion around the bus/master/dev representation is still ongoing,
>>   with Arnd opting for a simple approach where
>>   * the bus is implicitly represented by the master device
>>   * the master is not represented as a device under the I3C bus
>>   * only remote I3C devices are exposed and possibly duplicated if
>>     several masters controlling the same bus are exposed to the same
>>     Linux instance
>>   and Peter preferring the representation where the bus is a separate
>>   object. IIRC, Wolfram was in favor of the "bus is a separate object"
>>   too.
>>
>>   If possible, I'd like to close this discussion soon, no matter which
>>   solution is chosen.
> ...
>> Missing features in this preliminary version:
> ...
>> - no support for multi-master and the associated concepts (mastership
>>   handover, support for secondary masters, ...)
> 
> Let's try to come to a conclusion to this discussion, this is the main
> show-stopper for inclusion that I see, as changing the fundamental
> design would be hard to do once we do it one way or the other,
> and the structure is exposed to user space.
> 
> Peter and Wolfram, could you explain what scenario you can see that
> would require handing over ownership of a device from one i3c master
> to another i3c master when both are controlled by the same Linux
> instance?
> 
> To me this seems like a rather odd scenario, and supporting it
> properly requires significant complexity once we try to support the
> dynamic handover of the bus between two of our own masters.
> 
> It seems more likely to me that we could deal with this case by
> requiring either that each bus is controlled by at most one master
> device in Linux, or at least that when we have two masters on
> the same bus that they each control a non-overlapping set of
> slave devices. Either way we'd be able to represent the structure
> as a normal tree in the firmware (DT or ACPI) as well as in
> sysfs.

I have not read much of the I3C spec. I'm just coming from the
current situation with I2C and the i2c-demux-pinctrl driver which
tries to retrofit this into the I2C world and is not doing a grand
job. And how could it?

If you can acknowledge that i2c-demux-pinctrl is needed for I2C
but for some reason is not needed for I3C because of something
that differs between I2C and I3C, then fine, by all means ditch
the explicit bus object.

But in my mind splitting up the devices on the same bus between
several of our own masters and then not have a single object for
the bus is going to cause headaches down the line. Be it address
clashes or trouble with master ping-pong or whatever.

I think the reason for i2c-demux-pinctrl is that some (most?) I2C
hardware suffers from quirks and one way to work around it is to
make selected accesses from a different master. I expect I3C HW
to also suffer from quirks...

Maybe a bit-bang I3C master isn't feasible for some fundamental
reason? But if it is, then I'd say that it's just a matter of time
until someone finds a situation where such a thing could be used to
work around some I3C quirk. And then it might be too expensive to
always use the bit-bang master for the affected device.

But what do I know? Don't let me hold this series back...

Cheers,
Peter
