Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425180AbeE1PxO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 11:53:14 -0400
Received: from mail-db5eur01on0113.outbound.protection.outlook.com ([104.47.2.113]:22932
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936943AbeE1PxB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 11:53:01 -0400
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Tudor Ambarus <tudor.ambarus@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Josh Wu <rainyfeeling@outlook.com>,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        Richard Weinberger <richard@nod.at>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        Eugen Hristev <eugen.hristev@microchip.com>
References: <20180329131054.22506-1-peda@axentia.se>
 <20180329153322.5e2fc1e7@bbrezillon>
 <ed87cf13-a69a-6115-f0a8-5f51c4957d1d@axentia.se>
 <20180329154416.5c1a0013@bbrezillon>
 <b740406a-e91c-67ad-24a3-cbdbe259d00d@axentia.se>
 <20180402142249.7e076a64@bbrezillon>
 <e0d9bd59-8031-e387-676e-dc5811170a0c@axentia.se>
 <20180402212843.164d5d21@bbrezillon> <20180402222020.1d344c14@bbrezillon>
 <d7e6f78d-b57b-4d0f-c07c-ca6c1930cd51@axentia.se>
 <20180403091813.5fb5c18c@bbrezillon>
 <d0afd431-6e51-a9b7-c103-ecf1f6e07c2e@axentia.se>
 <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
 <a25ca617-d3da-d401-1ba9-8e5887f8a8e5@microchip.com>
 <024079cb-77ad-9c48-e370-e6e8f2de171b@axentia.se>
 <9c496531-f7b6-4b9d-dd51-0bfb68ead303@axentia.se>
 <c3cc1894-2d7d-93b6-a9de-ed9ca4564ae9@axentia.se>
 <20180528162718.6be7191f@bbrezillon>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <db31aac0-6b59-8835-2181-635670e7f176@axentia.se>
Date: Mon, 28 May 2018 17:52:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180528162718.6be7191f@bbrezillon>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR06CA0142.eurprd06.prod.outlook.com
 (2603:10a6:7:16::29) To HE1PR0201MB2458.eurprd02.prod.outlook.com
 (2603:10a6:3:81::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;3:ax+BN9D05gdg26jHuE54M6+c9gTHYYgSvOoRc4F31yupGu/DJMIBK3CHAqCUrtSPsUwLvp9nZ66j5heV3f3V6SQ2o18xFmDE28F5cNtkOP75AzwC83fQOoIB56bYCItJ+KlSeis9hFlfcVzFECHCgohQU94GP74Fa8966yAA+s8jrvQuiryw9y86B20gA8QzSLRf6AMRtHMCx8/yf/FzNVZOFDYIFO8beahT7BbqhLkubTQEIAMpCLX7fAxKeSac;25:xSf9mLNF1vLMAL+INeZiBG5xtPhT2rYsJYqLj/Rt76BOWpJFKMCcixZnPtf7GBWvyhefrTULL4GHQrQzp3p2qf9AK1cx36j/I+w0WXnkavt7xYcHwLtJd0aGEQk3rpN/kfWnKvSHWE8JZJjLtH7Ty9OhHkUV5IZHQU7XxJK+z4G2ZCkkZ39XyEO+m4aLu9nQMMN89oOsgGjEQluTAwr4Uktu+sU7xPABaeXsNjiwMflkLoYAdzJTPKdSZmg4e6gDCdA1FuM9hzlugwAq5BA+ri1Wlsf3tuZgeKz2F/IxjPJHTKeysa5e66KH2P3bCK5HAa9deYPC/fO4F3pgZ+pslg==;31:fxeBqOUmmCsSZxqlirofRJPm4yFhHTkhiwQaI0yJVUZ6eUDG15j+s1d07BHeUggg/Fs7d0j1NLpsdybF57jBwmqoEXt1W8Pjcg0+ApjpNfP0bSiIW5+CRGMely7plVvsH2L1lZ+QxyUs9JE4WX/Keb/DWWjlWWzelVNd01at8SgVo5DCM4Te/M7E9I76mBSoPhno2ga2EqMbbm6y9ay+eCsQHk9USbLNKyXl+favhfQ=
X-MS-TrafficTypeDiagnostic: HE1PR0201MB2458:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
X-Microsoft-Antispam-PRVS: <HE1PR0201MB2458C475157076037E324B4EBC6E0@HE1PR0201MB2458.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(10201501046)(149027)(150027)(6041310)(2016111802025)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(6043046)(201708071742011)(7699016);SRVR:HE1PR0201MB2458;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0201MB2458;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;4:/6JHQeXdDAv3q9Z+pluEOMADjmN9i56KZKeP0zxswLiWcSTDwchJ5IkYelKyLLsZXFnObBFoSjfpO+OQTqYYGLq9AUlEkvaze7zZ6cL00AGXteLrvlVEX/r54kSH+4gGan2oMQd2EYWAp3+aQDmP/suITPiNYvz/gpLtNXQqnm/ONbOlpggjLn+6edXHSHE7sVGPcBZ8LNtYSyQDIT2+utFVU39Rq6FYdVahUgojfcQHlq5Th5lTN2fdoPgpKsWrhEFxUzMsJ4J13vk0ogRn1g==
X-Forefront-PRVS: 06860EDC7B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(376002)(39380400002)(39830400003)(396003)(377424004)(199004)(189003)(64126003)(53936002)(68736007)(5890100001)(186003)(36756003)(16526019)(6486002)(229853002)(93886005)(478600001)(8676002)(59450400001)(386003)(52116002)(76176011)(53546011)(2906002)(26005)(77096007)(54906003)(117156002)(16576012)(316002)(446003)(97736004)(66066001)(31686004)(39060400002)(6666003)(476003)(105586002)(106356001)(74482002)(23676004)(36916002)(2616005)(47776003)(65956001)(3260700006)(65806001)(6916009)(86362001)(31696002)(11346002)(575784001)(58126008)(956004)(25786009)(6246003)(305945005)(230700001)(81156014)(50466002)(8936002)(52146003)(7736002)(5660300001)(486006)(3846002)(6116002)(7416002)(2486003)(81166006)(65826007)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0201MB2458;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjAyMDFNQjI0NTg7MjM6aHhWZDZ0UVRFbk1sOU9nOG5CSlNSQzlF?=
 =?utf-8?B?dUM0ZXZISDRscXNENjlZdExBV0dRanpLei9TZXBZcmJnVXpZU0J5eFR4UllN?=
 =?utf-8?B?UXRnYWNZcE9rclArNU9EU01qcHR3RU5ESXVpRGJsYS9lRFlUUHZSSTZMOU13?=
 =?utf-8?B?QTJ5YXIyanByWEM4RXpUcnVKN3hMdy9McjEvWlg3YUM3OCt4RUFyL25JbEdJ?=
 =?utf-8?B?TkNGNWI5TUszTk9QQm9KR0lRZlp1SnZVajZPNU01d0dObmxya2QyMW9QSG1x?=
 =?utf-8?B?QUIxS000ZVZpYUIxUVZ2RWxsbm1hWmt4aWh4cllMZ0IyQ1U4T2VVOW9jL2xt?=
 =?utf-8?B?Z1BqOVpLUUl2cHFYVm9DZit6SUJsdFpJMzBuZENFZjM1cjREMmswdFNwKzhZ?=
 =?utf-8?B?WDJ4Q0huV3E3ZDNvZm1ERHRTclNPdS9qODBoWFIzL1p6cVNXbERzaXJJbS9E?=
 =?utf-8?B?UUMrVHBRYXFURDZmL1ljYUtVbW9ISXhtMHJ0Z3I2RXBKR0RrTDE5NXNqUUlZ?=
 =?utf-8?B?ZnRHUFZmVmhtdTB2Z0dOWFdWM05ndnBGVVIxUGRzUkJSQjRvaHExYUlKRGJm?=
 =?utf-8?B?WUZlK3p5dDlHcnVUQ0VKQTR0MVppaTk2VXdrcDhCakdjNHB5RjZFclVkSDYr?=
 =?utf-8?B?VEU2bWNIMFpDU1FXRmRzSFQyYnk3aldxNklLVzUxdXNrT3RnZHhvRU1aL2dV?=
 =?utf-8?B?OGIyclR6d1V1K3FXb1p4NjY5allsbS9iZDY4YkxGRkgrSzR0dWNna2pzcS83?=
 =?utf-8?B?SnJJbUJMTkNSWTVOMEJvVnlWTFNQaG9qbmdOYXJteEFnN1J0WTJQalU4S3dk?=
 =?utf-8?B?MFdEdnhDMzZ4RUI4OUtWbTNJUUpmRlBpZVhrbE5HZWZvUlFRZzA5UmZ0U3lZ?=
 =?utf-8?B?VEhZNTNoNk85QXBzUGROUjBtNG1JRHpqeXY2RE9rQXN5bE4zL2dxazJIQ2xG?=
 =?utf-8?B?Y1JULzhCV0VRcG5JR2lDM2ZTZHZkMk5FTC95dzhscjRwWFlxVDZCYVkzUDU2?=
 =?utf-8?B?T1BMN3NNMDRhM2hRWitvV25PQ0E1STV1bmFoU0l0dllFUUdPK2VaTnR1N21H?=
 =?utf-8?B?bEFzMWQveDI5SW9CQWFZajMwZTc0ZHZPSm44WkI1WlB2aFMveFp3NUFqaUdJ?=
 =?utf-8?B?YXk3bTdwbUk4QVVWc3paSTJ0OStLM2QybU5GZDNxb2JvY0hXR3hia0FWNUx1?=
 =?utf-8?B?TUN1RWRwMVlmOWY5RXFRUHJJMXFYdjdxZWlOWWNCNWw2QTNvaFFLTzJWU0xD?=
 =?utf-8?B?cXdUYklUbCtJbWJHQjJQODVhWFEwL1ZMRmR6KzljNk96RURrUWdERVB5R2E1?=
 =?utf-8?B?QVhTOXNTL2lPRDdiR2ZDRjA2cGhVMHkwMnFRdUpudjlQRUJQMWN5K3VMUzUw?=
 =?utf-8?B?UVFaL0xQVmw1aXFSbW80VnMrSzhWcWpERm1HR1FWb2syZEM3eGtPVmJyRlNt?=
 =?utf-8?B?Ym1zR2lFdjZFUlVWdFVZWXJQTFdvQmlvQjdsb1NNaDRib2NCU1hnNHgvR1Fm?=
 =?utf-8?B?VjRlbFNlV0hNbG9uR3ZyUW5Rc2tDTVV6dUQ4eFVMUHR4WENsQkViRW9xS1po?=
 =?utf-8?B?clA4VXdMZCtGK0NyWGFoMGIyVklSWllOT1dFdFdEVWVTUnp0enlwOU5WUnRw?=
 =?utf-8?B?cWlLU2MzRjVyZFRYTDVhdkxjaENBSWV1cTI4Nldoa2NtR1hkSXFFN2FQZVpl?=
 =?utf-8?B?WmdnUHVOU1VKcmw1VGpJSGJaRzAxb2sremRPOGpNazJDR2xjaWt3L2plOWFL?=
 =?utf-8?B?OVdFN3ZLY3d3OXFRS2FlU08yZnRhdU5vc0N6eDJKVHlqK09oVjhlajhtVEJt?=
 =?utf-8?B?T090aTE4bnVWMWR3QXNMZkE5RmRKTDdydGdMNFZrZll3eXc4SnpjcXJQS0Fq?=
 =?utf-8?B?bjA2UmRBT1h5U1F6cmRaWEVXWGVhUXR1WW5DMElrL1ZuUzdjenJ2UTNYZ3Fi?=
 =?utf-8?B?V2ZBakhIUzNLUmRmekVremNYaGVaMHB5dWxDQWR0dm9KZXV5Q1BEL1R3bXlS?=
 =?utf-8?B?dVJwcDVISUpqaDd0TDVSRHNOb3BWa0ZNWU1NWGhmSnpJVktJdy85ZmhlN012?=
 =?utf-8?B?cDMweDlhamR0eDYyemR4ZVFTN2pwWk5iV3BjRVJYUGdibHpjdTJjRndGb2Vi?=
 =?utf-8?B?U2lwK3JZNTBzMk0yUXNQTjFPRjVKMFNkRmE5Z0JKWGJWWE9lU2d4MTdaZlJn?=
 =?utf-8?B?aGVuTWE4R09JY0NreWYzWXNCM1pCSncramJJbm5KWnNWWVkrWUMwOVlaVThv?=
 =?utf-8?B?emt3OWVaZDMzdHFLNVFZenJhL3NaOW95RlBkRnpQbFhHVHRJRlBwbjlmU0V2?=
 =?utf-8?Q?gXim1CqP8CLwi2yF2z512Cy9nX3ACTIrkU7uKYN?=
X-Microsoft-Antispam-Message-Info: OCVqWlRVDqlNkRVpiP5SuWHh8fvMFfXDF95bkxndT9QbbEj84SCsPhyRrzyuplymgW3efbxRe70hI1Y6EX2CLryi4cx/V/nC9NhSgYa6R63nEaDObXg+TuWMMXw/jPRCcfCDhRzTeHbXcdvYhl3AAuFLkyvr3ERF7CQ2Sjr9gW5TSQFnZwfdzUdR2Ka0pMI2
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;6:IZpj8Xh4f2OmEcnU9uNtJgdxFcdFbSVb5foOudCP8wF/K1hr90QMOM/QqdXuflBMH+OYpq/veIPIXpsmzEdzV7tMqifxyHaQ3nNx7tPVN9qnxHW/VUfdt7sVJ0zHLLlGN/nCFSW+fn1zU7g/n6dcF9bA3KNyrD9ZFcODhUgX06g7blAtqeevrsfCHIFpDUxTizd+DLX3XukLr9Z9CiLFfpYYEAocE96vCbHfKa3GMKs/RZ0ZtVU56H8EUpboBysaWY/xBRd78GS745PwfHbipZV+T4EeSS5mJ20WVtLbeBV9D2qQ3+MVcBrcrYaIBv18hocHzbeGr5KzfXWggev22dAUCa1HKmd/TneYy8uqXoW/NiR7xRG572cMFg6ON+g6GYShmSeKGSWKXavj5k+PvXfnqUrUDGoGZAvXvMW79g4L8+f6bXkg5ir6350y6Nezy+Xve8w+h+ffHWagLMLT4g==;5:Z614fAHRXS8M8PsONF23c/KktnVgZ4LEJwHBxIvnINgVBJ9Gm2s4QTgP0AkbSULM1EtwXgWHX1ocgivO+DI16gZG48e/d7VuX9AOgHuDjY4tSU5LifgpjA7xGCZmYMJlBNFgo/TT31EGqmz31W5sqIpf0wcB0nWZSVW3ay4O2JM=;24:LBLubVw2Uo79cud8HGit0aaEu/FOLPl8RAD57cdvQf5Cc7IYzR8KEb8cCYyVefcKR24RqIbcUcxz3CflXYsQ77wDqAX2qbCYLx56pqD+V8w=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0201MB2458;7:BnI0PMQ2bimsE+hagCTDFbLA/VZ8410ud/OsAAr9Lfo3N1TmkeGSM4Kr8hewYAOR5/v4K/ot12v7df6vrUXzSufe29heTbzUTp/zexwiqsul1rGXEoBK3BSarGey9wrP6Tn9vtKBH+l+gcAE2qlb2AHgxMHsGkSaB7kyTG9iBlyz+2lGMvhdipUrlpypEj9J1LycU4oPQg8ZX0ZsQYjCUb4uTsQLdm/pTnh13taFjMQIZ86vYsphHwfwtNNreVJr
X-MS-Office365-Filtering-Correlation-Id: 8b3d32ad-6286-4314-93cc-08d5c4b31507
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2018 15:52:56.8645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b3d32ad-6286-4314-93cc-08d5c4b31507
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0201MB2458
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-28 16:27, Boris Brezillon wrote:
> Hi Peter,
> 
> On Mon, 28 May 2018 12:10:02 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> On 2018-05-28 00:11, Peter Rosin wrote:
>>> On 2018-05-27 11:18, Peter Rosin wrote:  
>>>> On 2018-05-25 16:51, Tudor Ambarus wrote:  
>>>>> We think the best way is to keep LCD on DDR Ports 2 and 3 (8th and 9th
>>>>> slaves), to have maximum bandwidth and to use DMA on DDR port 1 for NAND
>>>>> (7th slave).  
>>>>
>>>> Exactly how do I accomplish that?
>>>>
>>>> I can see how I can move the LCD between slave DDR port 2 and 3 by
>>>> selecting LCDC DMA master 8 or 9 (but according to the above it should
>>>> not matter). The big question is how I control what slave the NAND flash
>>>> is going to use? I find nothing in the datasheet, and the code is also
>>>> non-transparent enough for me to figure it out by myself without
>>>> throwing out this question first...  
>>>
>>> I added this:
>>>
>>> diff --git a/drivers/mtd/nand/raw/atmel/nand-controller.c b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> index e686fe73159e..3b33c63d2ed4 100644
>>> --- a/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> +++ b/drivers/mtd/nand/raw/atmel/nand-controller.c
>>> @@ -1991,6 +1991,9 @@ static int atmel_nand_controller_init(struct atmel_nand_controller *nc,
>>>  		nc->dmac = dma_request_channel(mask, NULL, NULL);
>>>  		if (!nc->dmac)
>>>  			dev_err(nc->dev, "Failed to request DMA channel\n");
>>> +
>>> +		dev_info(nc->dev, "using %s for DMA transfers\n",
>>> +			 dma_chan_name(nc->dmac));
>>>  	}
>>>  
>>>  	/* We do not retrieve the SMC syscon when parsing old DTs. */
>>>
>>>
>>>
>>> and the output is
>>>
>>> atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
>>>
>>> So, DMA controller 0 is in use. I still don't know if IF0, IF1 or IF2 is used
>>> or how to find out. I guess IF2 is not in use since that does not allow any
>>> DDR2 port as slave...
>>>
>>> From the datasheet, DMAC0/IF0 uses DDR2 Port 2, and DMAC0/IF1 uses DDR2 Port 1.
>>> But, by the looks of the register content in my other mail, it seems as if
>>> DMA0/IF1 can also use DDR2 Port 3.
>>>
>>> So, I think I want either
>>>
>>> A) the NAND controller to use DMAC0/IF0 (i.e. DDR2 port 1, and possibly 3) and
>>>    the LCDC to use master 9 (i.e. DDR2 Port 2)
>>>
>>> or
>>>
>>> B) the NAND controller to use DMAC1/IF1 (i.e. DDR2 port 2) and the LCDC to use
>>>    master 8 (i.e. DDR2 Port 3)  
>>
>> Crap, that was not what I meant to express. Sorry for the confusion. This is
>> better.
>>
>> So, I think I want either
>>
>> A) the NAND controller to use master 1 DMAC0/IF0 (i.e. slave 8 DDR2 port 2) and
>>    the LCDC to use master 9 (i.e. slave 9 DDR2 Port 3)
>>
>> or
>>
>> B) the NAND controller to use master 2 DMAC0/IF1 (i.e. slave 7 DDR2 port 1, and
>>    possibly slave 9 DDR2 port 3 (if my previous findings are relevant) and the
>>    LCDC to use master 8 (i.e. slave 8 DDR2 Port 2)
>>
>>> But, again, how do I limit DMAC0 to either of IF0 or IF1 for NAND accesses?  
>>
>> So, I added a horrid patch (attached), which mainly adds printk lines, but
>> additionally does one more thing in atc_prep_dma_memcpy. It changes the DSCR_IF
>> field (from 0) to 1 for DMA-memcpy for dma0chan5 (i.e. the NAND). At least I
>> think it does that?
>>
>> Running with that patch gets me this:
>>
>> # dmesg | grep -i dma
>> at_hdmac ffffe600.dma-controller: Atmel AHB DMA Controller ( cpy set slave ), 8 channels
>> at_hdmac ffffe800.dma-controller: Atmel AHB DMA Controller ( cpy set slave ), 8 channels
>> dma dma0chan0: xlate 0 2
>> dma dma0chan1: xlate 0 2
>> at91_i2c f0014000.i2c: using dma0chan0 (tx) and dma0chan1 (rx) for DMA transfers
>> dma dma1chan0: xlate 0 2
>> dma dma1chan1: xlate 0 2
>> at91_i2c f801c000.i2c: using dma1chan0 (tx) and dma1chan1 (rx) for DMA transfers
>> dma dma0chan2: xlate 0 2
>> dma dma0chan3: xlate 0 2
>> dma dma0chan4: xlate 0 2
>> atmel_mci f0000000.mmc: using dma0chan4 for DMA transfers
>> dma dma1chan2: xlate 0 2
>> dma dma1chan3: xlate 0 2
>> atmel_aes f8038000.aes: Atmel AES - Using dma1chan2, dma1chan3 for DMA transfers
>> dma dma1chan4: xlate 0 2
>> atmel_sha f8034000.sha: using dma1chan4 for DMA transfers
>> dma dma1chan5: xlate 0 2
>> dma dma1chan6: xlate 0 2
>> atmel_tdes f803c000.tdes: using dma1chan5, dma1chan6 for DMA transfers
>> atmel-nand-controller 10000000.ebi:nand-controller: using dma0chan5 for DMA transfers
>> dma dma0chan5: memcpy: 0
>> dma dma0chan5: DSCR_IF: 1
>> dma dma0chan5: memcpy: 1
>>
>> So, output is as expected and I believe that the patch makes the NAND DMA
>> accesses use master 2 DMAC0/IF1 and are thus forced to use slave 7 DDR2 Port 1
>> (and possibly 9). The LCDC is using slave 8 DDR2 Port 2. So there should be no
>> slave conflict?
>>
>> But the on-screen crap remains during NAND accesses.
>>
>> But pressing on.
>>
>> I then changed the priorities for all accesses to 0 in the PRxSy registers, except
>> the ones for masters 8/9 LCDC (slaves 8/9) which I left at priority 3.
>>
>> But the on-screen crap remains during NAND accesses.
>>
>> My guess is that the NAND DMA is doing too long bursts and that the LCDC therefore
>> has to wait too long and simply fails to keep the pipeline from running short?
>>
>> So I tried to reduce the maximum SLOT_CYCLE for slaves 7 and 9 in the SCFGx
>> registers. No noticeable effect either.
>>
>> I then tried to split bursts from master 2 (DMAC0/IF1) with small values in the
>> MCFG2 register. No effect.
>>
>> I'm getting nowhere.
> 
> Could it just be that you're reaching the DDR bus limit. As I said
> previously, when you go through the CPU, and assuming you're consuming
> the data directly, you have:
> 
> 1/ NFC SRAM -> CPU
> 2/ CPU -> L1 data cache --write-back--> DRAM
> 3/ L1-cache -> CPU
> 
> While, if you use DMA you get:
> 
> 1/ NFC SRAM -> DRAM
> 2/ SDRAM -> L1 data cache -> CPU
> 
> So, if you're approaching the limit of (LP)DDR bandwidth, using the CPU
> might make things a bit better. Still, if the limitation really comes
> from the DDR bus, my opinion is that you should maybe use a smaller
> resolution or use a more compact pixel format (RGB565?).

The issue is still there if I use a CLUT mode instead of rgb565, which is
what I normally use (and what I would like to use, CLUT is just alien and
a pain these days).

The panels we are using only supports one resolution (each), but the issue
is there with both 1920x1080@16bpp and 1024x768@8bpp (~60Hz).

> Did you calculate how much of the bandwidth is taken by the HLCDC
> block and compared it to the max (LP)DDR bandwidth?

I did, but don't remember the exact details. There is some room even for
1920x1080@16bpp, but not oceans of it. We were a bit uncertain if 16bpp
would be possible, and in fact that was the reason I worked on CLUT
support for atmel-hlcdc last year. But since the problem persists with
much less memory pressure as well, I don't think that's it either.

Admittedly I have not tested these AHB matrix tricks with a smaller
panel (it would take a bit of work to arrange for those tests), but the
issue was there when I last tried (using defaults).

Cheers,
Peter
