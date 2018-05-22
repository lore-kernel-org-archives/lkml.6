Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751551AbeEVSDz (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 14:03:55 -0400
Received: from mail-db5eur01on0091.outbound.protection.outlook.com ([104.47.2.91]:27960
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751291AbeEVSDx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 14:03:53 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] mtd: nand: raw: atmel: add module param to avoid using
 dma
To: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Josh Wu <rainyfeeling@outlook.com>, linux-kernel@vger.kernel.org,
        Marek Vasut <marek.vasut@gmail.com>, linux-mtd@lists.infradead.org,
        Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-arm-kernel@lists.infradead.org
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <498f4a40-0f4b-fb32-2d6c-032b5341f2b0@axentia.se>
Date: Tue, 22 May 2018 20:03:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <959d826d-1a98-ca22-acee-a4548427fcd3@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0142.eurprd05.prod.outlook.com
 (2603:10a6:7:28::29) To VI1PR0202MB2781.eurprd02.prod.outlook.com
 (2603:10a6:800:da::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;3:XRTkTxqyxOTh+8EpvAKgEtvL/WYiY4cAYtOeNbCi00NlatrM9H3butAHrPs0avIKXZiDUb7qS38Eq9z/ZHdEJ943a6wI8AZpWFnTxbhHsZQgskcppCt2MQqCYB12MAxmDYekiAxoXr43aAY7CsqjnFgRITJk1gAiq3O9oXuxFlo7at29PX6u+iYrv0qie0ZBMf+mEjQIhtl4ufkuQ+9+2nD4X0urKa6NERTpVsdExoLTtDimhWW9FsgV/atM1iST;25:O4Vm/RLuEyxpSfFQptNJjH1s44KyTYMH1vQ4/4zm1I61mqGiC8k23YWs8WLo8gH94V9LibA+Iv7hgwRozkyyIZ5mc/W9raFt1xhBjXC775tP+Zl67dVDqkR2rfgyaj9fwPrmK1pRnkIII1KDq2kjQLYu/m2Uk9JBd8FQWJlnipTdZQblYZTbzjuwwaOfh9INDXJ3GFjv8/RlEMKGpZYz8+C7X2SPedEKoqwC2Uz9QZ4lAymoI0HUQbm4vziPrRGYuq1F/yqzeJkPIepQwfasq/tQhZnL4Xmey2k9qlmsnTSAPM1OeKFa+wXoHtWLJE2bzFtuUQG87HzjH83J39BDXg==;31:lT00dhn2zytihdubBnx+fzTN6ELhIg5jdUXcWmC0z7WCzcHNHS2lLKGOoM4/3rjifT3sw5gaMOjj+bkwqIZs5jqfxP0/Eo+6nWyTAYZfXLoGuRW91s7EvYC00/A4NtImHbYkD48rTgrSrvrEbMbInhUa1j42xWqslYj3cjnF9j4ZeueHI8btRnsZVQhGca2IVlxEU9DI8vhZKyv63QvFBC5DACslPMBMINHMlrqkzDI=
X-MS-TrafficTypeDiagnostic: VI1PR0202MB2781:
X-Microsoft-Antispam-PRVS: <VI1PR0202MB278153ABBF5733D2961C7ECABC940@VI1PR0202MB2781.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0202MB2781;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0202MB2781;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;4:WjBtlPNxdgSDP4SB7YMe6rhsT4Ozu9d6r7tIG4rdKFoRmg8L5YIBIz4SvoJZuC8YPVYCVxmc47QUzP2ALbKbo2OpH+R2UuzS8o6M9o9x1tHGsF1KxppnOQt3iUh1k8aQTt4mC43NwhsY9laENd1ZKx4AhKNNCxjYKSxx3UdT37mW7xvdnI99At7XnIgFnZ7joZaoF5A0lGjHAuRJ/Da0ven1G9tZ4mhwGTTfmyrnpVUvtYFUJk4lxC8qg2zxNb311SuaJK/EF5rdaLf0tWLCuw==
X-Forefront-PRVS: 0680FADD48
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(366004)(39380400002)(39830400003)(396003)(377424004)(61684003)(189003)(199004)(74482002)(478600001)(106356001)(386003)(68736007)(76176011)(486006)(86362001)(31696002)(77096007)(446003)(476003)(956004)(2616005)(11346002)(26005)(53546011)(186003)(230700001)(50466002)(16526019)(16576012)(64126003)(2906002)(105586002)(110136005)(25786009)(3260700006)(47776003)(54906003)(66066001)(65806001)(58126008)(6666003)(117156002)(229853002)(8676002)(316002)(36756003)(93886005)(65956001)(31686004)(81156014)(3846002)(6116002)(36916002)(65826007)(6246003)(5660300001)(8936002)(23676004)(81166006)(52146003)(2486003)(7416002)(6486002)(53936002)(7736002)(97736004)(39060400002)(305945005)(52116002)(4326008)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0202MB2781;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDJNQjI3ODE7MjM6RzY2N2pBSmJER0YvOXBHSGtPZmp3V2pk?=
 =?utf-8?B?dmV2eTU4ekl5YkVhN2lGQWFFWHBDUDBOZ0ljL0RjK0d3bUFkL2hnRUw5dG85?=
 =?utf-8?B?NmtvVXFJamdNZjg0UVErcnkxK3M3VGFoZWFzbTVONTd4NVREbjY1YkphQVVm?=
 =?utf-8?B?QUpEeU1uaG5RK2xoZXJDMEY0eVZyZjg0M3hNRjZPZEhFVjdTRm12Zlg5WnBR?=
 =?utf-8?B?dGRKRHRFSWRyWThockl4WHgwcTFndDF1eUtPeHJwTVA1OGNsR1hVZDBZa2V4?=
 =?utf-8?B?L3dRQmRwcDBncEJuc01GZ2ZvdFA3a1A3N3dKM2s5aDdMMm16Ri9GYisxVzl3?=
 =?utf-8?B?UW1YNnVoUEZJeDhJbTlScHNQMjlwUlFmd0dPbWFUdEtvQStrYU10U0R2NGd2?=
 =?utf-8?B?cGUxM2dITkcrc1FrSHNTYmpsNHFPZDcyRTkyT3NxQ0NUUWErV1ExWFZpUFNE?=
 =?utf-8?B?aW81V2RvRWlkTThWN21aVFVVZ25ZeWtYc3FqcHdaUmloT0NES3VNZ0tLRXNn?=
 =?utf-8?B?RWRadHZvK2dCRTZIbDM1UWZ3ZnEvdG9ZclRJcENRQTZiTjhDaC9LQ2ZNNmM0?=
 =?utf-8?B?Wmx6WHI1aVpiSk9XSE03R3RpTXRjS1psbzNVRWlQQXF2STRnQSt4S0FnRmkw?=
 =?utf-8?B?dThLSUZDekJTcHR3Si9RcGhrQU5uRHBrektuS1EwYXhvSG1sR20rNWY0SXhy?=
 =?utf-8?B?akI1R0dZblBEazVwNWoyZUhrb3g4R1NFWUtWSEpKN3FmVDRBYk5jcjczdyti?=
 =?utf-8?B?VVk4M3l5UnVmeXdaVHQySWhQczNkSDVnbVpZZ1JYQmJCZHhZdlZiM0Q5bEVN?=
 =?utf-8?B?TjRybHVGK3lOSldLeHFLUUdiSTkyMmNWLzJaS1hVekdvVWo3cUU4U2UwcUsz?=
 =?utf-8?B?QnBER2ZYblowQktTMTh0TFZoNGliSnJNYVliWk5QZ0RXQkczS0NIRmdFdUc4?=
 =?utf-8?B?eDRMTjl2ODJ2dEhxM3hrREdKUmRtcnBJNElxOUUrT05JaUgwMytpS0w5dzV0?=
 =?utf-8?B?ZTZKdTFzMm1TK010MldyRkFWNGpNWUJza0FrWXQxdERQbi9LM0RCZUprL3lN?=
 =?utf-8?B?ODZqTXkvT2hwZkVyc1B5SnRUNjBnMmZDS283VW9JWFgyMHlpbW1Bbm5PNWdk?=
 =?utf-8?B?S0JwS1hvaERiMXNlcEVKRkxMQklhaWtucXUwODhxWFMrakxwblNSZjhLV1hX?=
 =?utf-8?B?NDNLc05qeGc5TzBxTXFmMDAvRWtPdEc1TDk5U24rVlBnN2JuaW5ZR3doWng5?=
 =?utf-8?B?Rm1YcXBKay9sMkFZNDcwOE8vMHB2d2tuWFkwSEd1U0gzMTlwVnFtQTUwSGJx?=
 =?utf-8?B?V1ZsaVM1eXNjNTFyQjg2bnhYcW5oTHQySWQ1SGF6bXkwMWd1YjhXdk5LT2ZU?=
 =?utf-8?B?dGhlN2dmOStLQ3I5WTBYRndsQ3BSQnFHVURWTXprYks3VzFZVmVwY0MxamVX?=
 =?utf-8?B?R1h5N0VSVVBiU25hblFLZjJsUEdiQmlYc0QrS2dYRTBuK3lNVURGU3VtR1NB?=
 =?utf-8?B?NGJsb1U1QW90UVhmRnZWTHFOcnBDckl3UnU4alFLWnZxZ3BoUUQweFczNkt0?=
 =?utf-8?B?Q3NxWDZqUWIwelFHdE5oemZtR2diQUwrRzBSVWMyQkxXN1lPcU9uNXAwejJK?=
 =?utf-8?B?TVVTVW10aDhSZVhrMlpORkhTamZRc09ocXZuMjdYODRiQlorYzdtb1k3S090?=
 =?utf-8?B?VkNaWnpmN2s3MytGMnNKNVc3a0ZNTjVBbU5pTk9iM1ZWZkEvWTQ0OXJ3ejdj?=
 =?utf-8?B?ZUtLL3lxYjFIOEZNSXBxTnk1Tnk2akhQRTJMUmc3bkZaZXVKdU1JVWkyWVky?=
 =?utf-8?B?Zk1DZkQ2clVxK1NGaXlPWTFkVkFiUTljOWxIRmQwRHdkekpTMG9YeHZpbzBG?=
 =?utf-8?B?VWdQM0FOOW9LclF2enZXbzR6bFJKMGp2K1B5Q202eCtFN0gwLy84c1lsV3ZV?=
 =?utf-8?B?ZkdHVnBKRzJ1d1k5Ulo5OE9yZHZJWkUvMVRoMFEvd1h5S0E3SnQ4aUdWcmdy?=
 =?utf-8?B?NUk5Tys2aHExVGNuNDE5dFFKcHp3dmJPMVY4MnBrUVJnN0VwYUN4dm1wY0ZB?=
 =?utf-8?B?MTEyL05xMjZyKzhpWHpWdGlmYlV4Tkp6MExtZ1c5TGdFQUFwMVZmWTlxQVJs?=
 =?utf-8?B?eGEyVzlFMmlmS1k2OUpoNXRnSUdYSlBmemtKS25aSkFDK08rMytuaStDbWxy?=
 =?utf-8?B?ZXNjOW1xaUJFRXZhbGFDT1VYelVza2tNS0lEZDVWckdXc05YWDdvSTFQQTdT?=
 =?utf-8?Q?n3Sjn0Wijej4ygjP3mbz?=
X-Microsoft-Antispam-Message-Info: CSS3W/ers6FPvRQ2jPy4tdbsX1mN2atxNL96u/cBJMYcPhaCesli34NwC+bHZ2ZZHdjaRPpaqFFCfxUP/3bIWw/rhxEBMYGepQCH5n4VQs6NVqzf2LIyKOQ5OrpQq4yB1VGDvkNyr4bPuW448PRt6c+PqF9OQiGieueUVZS3fSlO2m2FBJtb3VPs8PQcbB+n
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;6:t3KbFTvj7qiPWbsy5NH8uXVZWPmzVyvhSkHxwXojHks1BW8fmM4QUbu3XyTogzLWMGgK+AeMomsQKpjw4fgW3xQe2bHdOvz1MzWoUR6Vmy6DydeBcv+fWnv6mjqct/Uw+/ZUXRh2BZxyX+J/ykm37kgMsYh5/v9b4fTFoeUcmPCLfUzWk/FFncIWO9wUduXpZNo/HSK63S0VsdGn4K1zWU+Jxy4TeUZRH4HoyT0S+7Hke9RQlmRy8PBYjahqZx7DirnvOkhwocEUGrFRt9Gu5NldWKUNqYidiEIpIykdQGFSpTXZz6Rw+XBpLLCyL7uhHop9EBQApoId4y+xnq5CS1czKpV/XQZpHBz0yh39EaVacFmrP4yFC4LhQquGFLV7uMWcBoIHEjOVgZO1fHBHaAIrwhZAHyCBBQoJiTdhbsDgM8Sx8v+tHAjR5EHdDW2DmbDnGwAdl250uVLSqtUYBg==;5:5+r+T7/xrN/sKPxcC23AAAWFj9evGnyVRBHEUPM/7yNPyodvdKeoTqVESsyIDOvkAAYhp0pwyHqvDCgMvWekmpN/FYmX/mejzsAb9MJP34PKZ9fDewZlTDtXEvYV4TAI42dcFy1zgdaemRWZHL+JkxlUzFIKsQgiZCJG4q5qQug=;24:JhKROsq5Q0FUXF8gNobGsXBM8xEDfRufEW2QUqOH9kg4bWUIuYiFCDZkvZH0laRgn6huzCfqZ/uXXqY9r/PJmSFsNZQ0zZ7Q5TzF3PLuRJs=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0202MB2781;7:i/vNSbC+fmEa18nsjPsQwrK6trQI84OlTaAq6ysEGqd9uY+6E5SECpzIj7clFHsTr1Uq+NkstD10Vc3Kx1PsvNY/FIvEc3SSCU/EyMwocGlIHnFuy2fFN3SjqRqw+40joh/ZtRALWfWAa/bKjoBnSrP8PvCHrxp1JzKPE0f3lSME1k17sim198DZgxDbi6j/Oa7COUh+G+7xbu9TUiHqIahnnwiCrEKhOAf4HoPY3i+5F4/yxg7TSPB09Ijn+cHU
X-MS-Office365-Filtering-Correlation-Id: c9e1a57d-c4d9-47bb-ac75-08d5c00e5d97
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2018 18:03:46.5401 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9e1a57d-c4d9-47bb-ac75-08d5c00e5d97
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0202MB2781
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-11 17:34, Nicolas Ferre wrote:
> On 11/04/2018 at 16:44, Peter Rosin wrote:
>> Hi Nicolas,
>>
>> Boris asked for your input on this (the datasheet difference appears to
>> have no bearing on the issue) elsewhere in the tree of messages. It's
>> now been a week or so and I'm starting to wonder if you missed this
>> altogether or if you are simply out of office or something?
> 
> Hi Peter,
> 
> I didn't dig into this issue with matrix datasheet reset values and your 
> findings below. I'll try to move forward with your detailed explanation 
> and with my contacts within the "product" team internally.

Hi again, just checking in to see if there is any progress? If not, maybe
it's time to just take the patch as-is, warts and imperfections included,
and even if we all hate it. But what to do...

Cheers,
Peter
