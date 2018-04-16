Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx49YMSJy3WkwXvtVRS9eUkxk7iemnxT9jMOvGkrRqvnNprU3ihO9TlwLafCy2oie4ETyxMuf
ARC-Seal: i=1; a=rsa-sha256; t=1523863757; cv=none;
        d=google.com; s=arc-20160816;
        b=cuRZ0przi6ZmPtgTazcOVUWP1L0bEC9htun7gPQSwjEfMeDGZZbRNOKj7Nc2DB59j1
         x/IDyFGvtCoLlr9+Lh8usNpBi56IgkCbc9eEWSLDS9a4SnlRKd5wAxCv4tXm2X1WMrUQ
         j+HTeS7kS1qO0k8z1De2RdUG0S4OgHmC+cfs2lM7Qei2je/WZqo1Om2OScfJ8Ca2HgiB
         fLnT900UqumiRyBOKQKCRIcJ7XxPJERvIdDMEUyorcjoiMQeGqXC7ABqIAYxJ2lSx494
         7q0OqONT+YraojwmLvRbOs1b5RIsVdLsEbFu8+oqVMW4WHDZVXp3QqkdTL+LPwp4zUHH
         qIvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=nCZ1sKinBWWWksHs98MBVNc4Ml/wQdFC76pNe7BaIUI=;
        b=cJBKzFoCBiQT5f5JxFT/1IaVQLG6+G2CG+rVkwHtBsgZlMt5VLblFrntgAHjQWXdiq
         DRk0qFrW2da+56gPDac1pfdwKr9u1VyB2EMty/50K+WT6V98Q7nvGCrcL3WFwv8TQium
         Lcio2WlvmsjuZBpBwYCRWveCtSIDJ4SJOeW1jOJWauJc967kguXaMOpdKCH3rTcsW3M/
         y6xhS7jiOOcXfPtDpCnWG/jEmrSKNjolXfatqydTmKzOpIq4HE94irEptAIVh3cPuXAU
         ae7fFvOUdxigDz6xXrrz7B8Nog65DuA3O4djiUhsfTLIlFFoJRfNtwBYAWjnWJ8Ie8LF
         OfWA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=cqP2ALX0;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.137 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=cqP2ALX0;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.137 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: Lars-Peter Clausen <lars@metafoo.de>, "Andrew F. Davis" <afd@ti.com>,
 linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Fabio Estevam <festevam@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
 <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
 <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
 <4aac6870-9159-18ba-0aa8-da227c426f38@axentia.se>
 <c2923ac0-5e28-eef0-e32a-1e25ce550a82@ti.com>
 <36e0c96b-89ec-2372-825a-71ead1a43473@axentia.se>
 <6fff0256-c9f6-6302-45ac-afc7a3276b06@metafoo.de>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <181d76fd-e40c-abd2-7d22-d866c9ab3808@axentia.se>
Date: Mon, 16 Apr 2018 09:29:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <6fff0256-c9f6-6302-45ac-afc7a3276b06@metafoo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0701CA0065.eurprd07.prod.outlook.com
 (2603:10a6:3:9e::33) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:Ln7aK6gs80uj+aPjP42+3LAzLgSlgOptINTzmMQW3/gbnCR/hmS5B9Py4qtl1BfHn9P2BZbHe938eyF+Zf7UlgfRIlwgEyyWw+fameY1ZKXGXYN5XXy7umix/yd8zzQf1HDTTtmu0nRmebHAgLHWqf1TR+YMstKdlGTgQS4aiMpWuxH7F75vhaaKIj8x9+QZ1ockYq5VohQa98NKVr2PcDjSjyhr9Mr52YQD4Nmke/NJW7iOeoH+KQx+IYoUWYfu;25:5ldkCKHrR/5QAhqmgJat4/qzCfOJ+JsSHWt0f8loMQuoG+Q+GTSHZOq4NKZinKnvGKFzt6HwRYrD33870s9iEjsMT0DuoE6NxXAp+zcopXOVTSmBBHFk3uRnkBf9QQWWd6z92HVzO/GcqxauqD5nV0GQl/JtasqHfhrUvyDdWRO7iy1zYulJL8XoVSn3MNbl81OSu2iodbustIRnlC6Al+R//Ao/Un7Wzw3JG67r3mYnB7+x4ckgNKGbKAeEkLiz65C3jbm66eFaPy1s4C2O1pxfy/IF5d8+2YiHX7BjS7sB+yMa7D9JM1noX7rOJwP4lUfyXnzSVxtBS1WzEdKpVA==;31:Dtsf7o3bGc3WkCMAWmu+0S4kok31tgmAWRx2MvsGPw1M7hFzdB+sGWJV2GEA+XTn68AqgZdXIHlxpNI+B5IOS1UnwV5MzC3zAE1SF//NdSv5YOvUj44kVhG7Qko1ysvQmxGmtIGKvttbzA6oppgbNzu75MrjmrnQdkTazOQ1qIO4NqkoFAWdvGskU/Fcz5boA98rrZ5iBsSYR0+iVKdIEdbKrG5aowVNHPWzJD3vqvA=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB277580162E0123FCD34FC40CBCB00@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231232)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6041310)(20161123560045)(20161123558120)(2016111802025)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:PRssNzCFMzekpwWrcxWNqP0cuYV83FeoLaEKMfeIirZU9KIQT0l1Ie7BxbTLMHDiBBwJ3rNdqQY5CFmEFYtExJR5VibYy0Yz9msF0vGUpkypqVRcg9uQsb+JBYty/qWwfmMM1MNPyEJLTiBQwv+7Xt8AyWJVtW+MAeG46FFGW7ZxvOUDfmV/3ndw+YUm3BZMKONlnyv7j5e6IUGaY5BwJwwp0TQRrzF0yTqdWjPR3BjILjYulfVbNzAy14OW9HuOz75K+xtRTRLKWjkygsA+gA==
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(396003)(39380400002)(366004)(39830400003)(377424004)(189003)(199004)(53936002)(117156002)(81156014)(93886005)(86362001)(478600001)(31686004)(97736004)(2906002)(106356001)(16526019)(81166006)(76176011)(68736007)(50466002)(23676004)(36916002)(8676002)(186003)(105586002)(316002)(16576012)(3846002)(4326008)(956004)(39060400002)(2616005)(476003)(58126008)(65806001)(65956001)(446003)(54906003)(110136005)(47776003)(11346002)(66066001)(6246003)(53546011)(7736002)(52116002)(74482002)(2486003)(52146003)(31696002)(6116002)(64126003)(77096007)(6486002)(26005)(8936002)(36756003)(5660300001)(229853002)(6666003)(8666007)(25786009)(230700001)(3260700006)(7416002)(305945005)(65826007)(386003)(486006)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6WitmNFZYbUlacXVJQmpNU05lT2hkTEoy?=
 =?utf-8?B?YTFwMTZ6WnczSVdmZmtVKzJUMEhOWjRseVhlcW44ODd1YjRPdTFTNlcyd01I?=
 =?utf-8?B?QklBYUgyT3JDaldjRWRHcHhaVXhIVGVRZGZJYnQvak1RVWRSKzFxUWt4OXha?=
 =?utf-8?B?OUJibVp5Zmc3RHJ4ZU9mWW9EcnFicC93cERocXdHbUVRRzNaSmVTR2RteVZW?=
 =?utf-8?B?ZmVTS2JST1dCMDFqUFRnQXNzWWEvNXU2TUxpclpYM3BFK1pKWUVPb2ZrUkRO?=
 =?utf-8?B?S0F0ZERwZWxKTTBpNmttUVBSMWQzc2p1TlorUW1sWm5PazRIUkxWVFc5eUZF?=
 =?utf-8?B?WGt1TVBuV3p6eWt3aFJETm1XUU55SUludzgwOEJkS1FObEZ6ZlF5eWFFd2xr?=
 =?utf-8?B?V0lMdlhmNFpkVUZQTk1VdjhibjR4WFNDSHRMVmVyNEgvQkJzWTVsS0lZMURz?=
 =?utf-8?B?SUw5WUJTbXhOamU1L3JIVmNQZ29vM2t6bGwzM3Rub1hlY3pvRmFiQ3N6UjUv?=
 =?utf-8?B?cTNKRU1laVdRcHhiL2lhSzMzaVZoa2dHNDMySndUSkM2OExkVklOQ1lQQXRj?=
 =?utf-8?B?T3RjNGRsUVpCU2dWUDRRN2NDQk5nVzIyV0F6SWh4TURCdzVTMXRwQUU4Siti?=
 =?utf-8?B?alVmOVpMbE0rekZ0dXFMNlVQVVJzSytYUUo0b1ZDVDJlTm1rWkRXc0hya3lk?=
 =?utf-8?B?K01IVGxtb3pMSUFMNm5mQ0V5Ums3TVQ2UzM5VjNtTGJ4NjJETHo5SSs4Uk5i?=
 =?utf-8?B?bjMyM0p5K204Q2Z0RXpPN3ZCK0NGZXFkdWhyVDJ3U3RNZVF6WlphakpteVhP?=
 =?utf-8?B?TU4xSGdwOWtTZDZqL2d6TE4vNnpHaVdNb1Z4enFlRUJuRzRuU0JwbWszUHJ2?=
 =?utf-8?B?U0UzaWR6R3FOSGhhblBCekhWRUNQNDlnSTRpRlYzb0JYQVBjUmlLbkhlU2ow?=
 =?utf-8?B?eXlhWXBPeENTeTlQckt6WDBGRXRnYnVzelZ2SzhmbWxpeERiT3FwQmI1cEdv?=
 =?utf-8?B?d3d3VC9RSkdYWHRpV3JBMDRhbnYwWThxQXJ0UTQyOEI3bFNJK1JkaWpMUGk4?=
 =?utf-8?B?UEpqN3NSK1M1VmY1MHVaaDBZVnFnSGh1aG0vWm52M3BvNkdhVWZtR2Z3UUFK?=
 =?utf-8?B?eE9iWVJhWUlDVDh5enNGTW83SDFpby9nVThuNHEreXpET1Iyb3NOQTdrM3Nn?=
 =?utf-8?B?YThSWlM4T1h4Z1VDT2Jhd3Q2UkswUmoxcm1UVFVxczBobGdtYjBXRWozbTJR?=
 =?utf-8?B?azVTMUVIRjZTZ3J0QlJoZXJsNHFZZkNzbU1MV2Mvc0NSTFMyK1RYNVozM0Ju?=
 =?utf-8?B?SnRPanArdk5IZzBzZzNiVkRraWU4V1gxN3FCMUhRR2NqdC9abWVJYnEzamVt?=
 =?utf-8?B?d1VKVEttdFA3eGpMdHpJVXFqWkdZYU9sZStPK1A0SHFFOXRzSGRobVZ2dXJ3?=
 =?utf-8?B?SnRMSUJzdG0zWllicmp6ald3OEFFd2ZaSzFXS2NhT2hPTVg5VWhsWFlJK3Ur?=
 =?utf-8?B?UGdUNUVkTlcvVkpRNjhlUGE4WXdwR0N2TGlndmxheFNYbjNCMXBCZ3p4UVl3?=
 =?utf-8?B?UzgwaGtrMjZYd0V2cVlkeXBOR1R5Y1Qwck0zMkdNT3pUS0IvQ21QdzVDblJv?=
 =?utf-8?B?NEdqZkhZYTZFdFhQei9zRWJpaXlibjlCVUpOMkhYUzdNMVZ4N3BsZ0phQTFY?=
 =?utf-8?B?MW9oYUxPWjRRcDRNWGx6V3NROTIvV2pFdUcyYjVvQTRIbEUrcDBVVC9CMUVK?=
 =?utf-8?B?U0Z6aFJFTFV3eFVBV1FCZjczMWN4TkcwQlhzZnRja2c0NHZ3WEgyY2NnVTRX?=
 =?utf-8?B?RXlSQTZYbkhuY29nZ0Z2WU5JcnBTMVpWMWJYZHdYdGkzMExHMDFWZGhVcFJa?=
 =?utf-8?B?RUdOVGp1OXpoeU9XTnRzWGtqQ2oydTdWVFA2NDBIL1hHZkdJb3RnaXhuM3Ro?=
 =?utf-8?B?bzNZeUpCVXE4YzN6ck9vTVlSMklJRnQ5YnZFQlN1OXhZbnpzVmVmOUNjUlp6?=
 =?utf-8?B?VTlwNFNabnZ5bUNPZ2Vxd1pNOWQwZ2JabG15SUwwdkYyR0NUaHdOTy9mVStQ?=
 =?utf-8?B?VityRnVLQTB6T1pDcHVFL1NrbHM2WmhqRElweDFOdnJ2RUI4Zmt5dmtNbXNo?=
 =?utf-8?B?eTVkamNhMTNpYTd2M1Z3eDRUYXFmUDdxVFdNTGV1eEF4TFdJMGJBa1I1RzRa?=
 =?utf-8?B?UUhCWGxUUWF1TFN4TytTM1d2eGd6MG95QWg3UWtPWkF4Qy84bElXUnhOQkFG?=
 =?utf-8?B?VC9Ba0ZUUk1UOU9VWjBMdEcyaHE5ZStpYTZEdmpiZ244Ujd1bTNnWUFRPT0=?=
X-Microsoft-Antispam-Message-Info: /UBDb/andLCCtBB3ipOt1CZ5sBQd3tZUC9J9D68k7RDQMrffY4utYBTJqYbkQv1fVrUQJOSyr/VskIPtzyH9j63jL0kdoLfgimM+Rkb3aPlBC1njf0NY4QggF8KpL+C6TiEXKNA4Z6QczPDk09zczxJRyuQUEJ5k3L1owdiKj1H5tD6VFLTGtGaVycboGgeL
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:FTzS157jQ60UCZ4VlWQPQUwu9xhsY9FNuhe+WclSOD0ejkZadxypXZE288vUiZrgscerdVkCyjIYLFrHhynBjTqYENpce5yFvm5CHKLdRlXFpgkyYIiZpBIKNw4DPKmFOqEC6qDAXBeA8yAraU8+CX8G3D1IL8+DClzbl+DBfswBRzS2xhn8GiZlOxfcQ2yihEUU/9TkpHM0g7dR6IVPurgzUMjvLMlSOnO5J4U1qLASYBedQ6LtMG9IsltUl6o4B+TQ3UDNt5k0FpukiWVs4ZqrrgWClNF5BGtMtO+gme6aDmV0WFUxzH0TismvnjDT2KjKh+HXkI/7NZrHRrsgtYGho0nEaVn4TcvyoDEzU+h20Dp9P1KOiYz5OyKf0HlM2aIsI8OHCf3lDGnZlC51BlqYbDHJxKXO4lL3m3EykInZnLTLAM4cFStzcdd0VOoGlb1p8nA2yaEy3MB8aLhmHQ==;5:WkMKPeV9uaEj6vhgkFSjTcfQegv+FXWujOZiJCH3grPtdMoSivL0IXytSliiyUm+3Lp5VwdW8aDL/2vVrnFx4/LSDAUVDXhdE2u2dMhK82Je8wIQheWwJWdLS3ctxOBfkNHr3reIXocJ9x1r3L/EokjEcp3Hgx74ChzRoXbfAOs=;24:JajHYPGBODSitEl2cv5EsdJmyw3R4GWxtq91vDTN6rFYul7PIH+czDAi8k3I2up011KmUs5BGMm8UIXCfXmDYNiBRKqQkojQ8audg3O+QuA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:/7hbJpjjTBJxSFDiz1gt4Yn66jpQRcw1io1iXyGiTTlrDYSJOCRo18VOfUObcVtXQpSGVWxDAmCvlQarcaZ2K1VJbwvwbLGAoz/rs4aNIpYS+WLsqWTVwwqBO8MN5AeaHf3E88UtC7D2X1PVUjsg4hEMWqGmse4yiFkkUcMcuS63FF4xFe8RKXKjbcq0AyFoLF85CYrNAH2jf9Vk+ryJ5KeCCes3m86WucpXQtjnf0tKAbplRpMR4sQQaBe5ACu+
X-MS-Office365-Filtering-Correlation-Id: 788b034c-f491-40a1-0676-08d5a36bc026
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 07:29:10.9588 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 788b034c-f491-40a1-0676-08d5a36bc026
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597886963641752531?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-13 10:11, Lars-Peter Clausen wrote:
> On 04/13/2018 12:31 AM, Peter Rosin wrote:
>> On 2018-04-12 17:35, Andrew F. Davis wrote:
>>> On 04/12/2018 09:29 AM, Peter Rosin wrote:
>>>> But as I said in the cover letter, I didn't go with sense-gain since I
>>>> thought I would end up with requests for non-integer gains. There is
>>>> yet to be a comment on the non-integer gain problem, and before there
>>>> is a path forward for that case, I'm reluctant.
>>>
>>> Why not similar to what you had before with the resistor:
>>>
>>> sense-gain-multiplier
>>> sense-gain-divider
>>>
>>> if either are missing assume they are 1.
>>
>> Hmm, how about sense-gain for the normal integer case, and then divide
>> by sense-attenuation if needed? I.e. exactly the same functionality as
>> you describe, just different names.
> 
> There is some precedence in the clock bindings for using -mult and -div as
> the suffix for fractional scales. See fixed-factor-clock.txt.

Ok, I'm going with sense-gain-mult and sense-gain-div, but I'm going to
diverge a little bit from the clock binding and make them optional with
a default of 1 if missing.

I'm also going to use the compatible "current-sense-amplifier", and not
mention the LT6106, because I suspect that part can conceivable be used
in other ways...

But I'll wait for a bit with this and give everybody a last chance to
pitch suggestions and opinions.

Cheers,
Peter
