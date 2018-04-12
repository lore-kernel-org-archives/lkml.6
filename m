Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4/OITaxPUw037tuScRdW0Rd68kmi8IBN3Z1y2lfOUphNZjtSfqSLRbCXSKTKnKdGfcENX01
ARC-Seal: i=1; a=rsa-sha256; t=1523543381; cv=none;
        d=google.com; s=arc-20160816;
        b=0Ae6jyeO960TjKFB1ClvDPq6ZOZmkIkfa/9W9EsFvFOg2MSTxyHVrwwkkOhpU1MWfN
         RVcx1IxVibAzotzU7UPQDbbj8FuS4GK6tV4NpVDJ3NogNJp+mNpwz+Sr1ULHSpttDxWq
         WZaDeukFcklYZBn9bKZANRbYmYZnAjC+kLnGi31SqNYmc3n8iuakGNou9jzL5uFrY7Vo
         60TjMMVGY9ylIdHfghBZKeIyOtEdLUCqgre+BySX6UXV3b6v3f83vmQDdB6N5B/1OS/t
         l8JqvinNEosrDDJdq6CA/cjM/6kIbJbVKdmgLqr4lQpOcqAp9JhwN5h+Iq41tzl0uzaK
         OraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=+on+wqAD/9BRvkaUTczBMZQAJjp1y4davh34Rzl1QCU=;
        b=JsYoCG0q29n8DVEleGlrvb+xMyvX52DTVCBWuCv8n/eB6SQas6aw1BWy1z3sURMHAb
         eotgMwandvIA6vq8m1iKZLnlbgpfaEJh43z8Esi3gGrBnGH866Z+IuCJurw4UpZ+ksS1
         yfNMmCT7q+PtVKSyp24NVXRzfR1rqyv9zpgzc+s8Df7Vv7x1n/48+WrZ4vd+sx0S25jI
         e3Tn28kPSocLZzOt2H8EYOEGw4agQ9ucFhPifAyI+pfVl4UUishzFTPkQ1Ra7OjBCDrV
         Wzp9tlkO2WBrP9OxEEhhZnUlXXanSi2OxKN2K7beuJB1cCgT92sAmdE/18uUAMBMAwgm
         hOBw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=ORdZyq57;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.119 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=ORdZyq57;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.2.119 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: "Andrew F. Davis" <afd@ti.com>, Lars-Peter Clausen <lars@metafoo.de>,
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
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4aac6870-9159-18ba-0aa8-da227c426f38@axentia.se>
Date: Thu, 12 Apr 2018 16:29:33 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR0701CA0062.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::24) To DB6PR0202MB2773.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;3:mNRkqUwSooUQDS2ZZK2VXoQj85MTrDBgX+/cWdRRRqG6AvMXB2PSNigg2ztgesU2f0qQxCI5HTCLH7JYxJUE361fRoG4c/xOq4Aj/+QkbPlkDZu1llkMhipkTQ5tpEXk7zKQH81C5ibPs/22V3vD78pt9gBY31tqOB8bjeKYFCWznpT1niiBcbozj7bH02wXDJsVt7z6FH27jAuAla4Hptod1oLI5F8e/EByZ0P+7Vwo/TMJeoOLHIlLtSnQpEfK;25:pxRyekEDgHz1LoECGzor4k8BdQzV2Jh3dohY9MKoOyajIVmWyEJ/dJVLg79jSm376/U9qUDpnDBHhGAGv74iEn3IIeylHOHhP23QW5/RrUVjqUY+0IT7bmL8RemmVUcWBNnB+5ZXf/gRZLsVRe50MlXJub6MeeAxHzOt598gCQBrKXwGcb/3ns1TJFRpIMk2ChE3He2nhI5NzH7n4tJsedYfx8XTFZYr3CLXvub2hz3H2M2g+8ceAescrr3M7KwFwrHcLsHaMASUwoPAgzoN0Vg36zYG92S7LhQyJ9vPIkRvIc3PMs9D3OScDBpmxy/nGvUFIkYflHFqUcsU8NGdZQ==;31:13HUfblJdM2vc+NkvQLo8YmNA9bXScHuruxIkWZAsgnUECjmhXK4XuZco/tRbGh0eUXbGqeubfFunObcs/OmXj/LIPTtZ7t4cAwIGFths0SExOvgYv+u/1EdSn05fXsY8YvU+9r3kYPQEIlGugo1E902dMFoFa+xURkxV3E9ko5l3rQdwINtdKLUEI93Um334QkFMLF4z2POM1BJQDM5Br7Gsmtm4KUML2WyRPE2Ymo=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2773:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB2773796A0DAC18542082952EBCBC0@DB6PR0202MB2773.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231221)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123560045)(2016111802025)(20161123558120)(20161123562045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2773;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;4:TVHeaMEZRY1T5/XbdfG8likEl7a3O00CFM1yy7wwrgC5PeuSQP4kZcdOZsIC9Ow0PMlo9LuidSWboHai/2FQkBInVMLDGr8aODgaH7gFt9qWjt0tHiARKfsmJY05NzA/4AEnQREXf7JSnfWGR0sT1a4Am1y58AfC6XyFTJzAfyv4G4wlEY3zZXDxXkPfg6oVgfmQEI95Gb1kljUr0c6ZscQ1EmAA6jlUOELxHcjfZXsuekqdnzWUq61BKiqJM33vDSGsdVr1fgv7QC0Fr9JJNA==
X-Forefront-PRVS: 06400060E1
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39380400002)(376002)(39830400003)(366004)(346002)(396003)(189003)(199004)(85664002)(377424004)(51444003)(23676004)(36756003)(446003)(4326008)(478600001)(6116002)(230700001)(68736007)(81166006)(8936002)(3846002)(81156014)(2906002)(47776003)(65956001)(8676002)(66066001)(305945005)(77096007)(65806001)(7736002)(3260700006)(25786009)(229853002)(2486003)(97736004)(31696002)(53936002)(6666003)(50466002)(93886005)(2616005)(956004)(58126008)(64126003)(316002)(16576012)(386003)(65826007)(7416002)(486006)(26005)(54906003)(5660300001)(11346002)(6246003)(39060400002)(476003)(76176011)(86362001)(31686004)(6486002)(36916002)(16526019)(53546011)(8666007)(105586002)(52116002)(110136005)(106356001)(59450400001)(117156002)(52146003)(186003)(74482002)(142933001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2773;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzM7MjM6V21yNVl0dnRURnM3S0Q0YzQ0RlJkdTR4?=
 =?utf-8?B?ZUZ0eG9EWkVGbG44a1B5c1lCN1lvbXVqT1ZFQVVldThvRVMvQlIyOW0rU3ox?=
 =?utf-8?B?c3pYeHRJZ1F3NU44TjVqNERjczlvZ24xUGVzV1ZWRUNmSlIycUxBOTV5UTRm?=
 =?utf-8?B?dDFBNSt1Tk1JTHhPQVFWWkRBOGpFeURKeDN0K1IxVVNxek5VOVRSNThFbkZw?=
 =?utf-8?B?ZE1HRmZtcXNOaFBHdjVJY3ZWN1JlTWw5YUY4WmdWVlRZRHhLNFNoTG5TY2My?=
 =?utf-8?B?Y0grM21nWmo2L1lGamxmR1BOSHB2VkdDM2hNd2NBSnFuZURKMjA2MkpoSk9p?=
 =?utf-8?B?UVJaMzErbnFxTUdKM09wTnlRZWtTZXh6UjdSaDlmYkYvelBJQWQ0UHpOR01s?=
 =?utf-8?B?N25jUllHeVBKRVhWeUMxMlpSV2NHUUNSWDdSZjdwMTM4bGR3dzBOMUw5OVh3?=
 =?utf-8?B?Y21BODhSbThCc3hVaUtmWGJ0cmkrZWsvVG5sdjJaenVWK25wOTBKalJ4aFR0?=
 =?utf-8?B?RUorbnBCaWhTM1djWitLbVFMMVBtUndaWXZPL1BURlpwdjFUSUJXOHIwbjZ0?=
 =?utf-8?B?bDlZaC92MmtvK0x6RFZPYnVFL2xjWmhXcUtEOHdTUVNldlVYaDFsdmt0cHFU?=
 =?utf-8?B?UjNCeDluQ3VNVUU2dWpJS1ZVV3lVdWhpd1NjYmFFVnJiR1FtbGtHWUNRUVVS?=
 =?utf-8?B?ek5GOVFGUWwxUnNHU3B4YWRJcWF0b1RKTVJKVUwvRzVEZFpNNFRtYWd6aXh5?=
 =?utf-8?B?eVBoUHo5WEZYSFlsSXFZUkV0Z3ZTYi9rR3Vrd3EvQmduL1lvTDdVWEZIM3hq?=
 =?utf-8?B?ZjA4amY5OVRERy92UTg0QUNDa3pYemdqRTBSNE9VSXhFQzRHTTV0QTJYbWxD?=
 =?utf-8?B?Y1J3a2pIeS9YRXhTT0NPcUhjdXB3T3VJUlQwSGxBdDZ4L1hWcjgwY3Z3b2VR?=
 =?utf-8?B?a0x4cmphNjNia01mTHEwL0dHR21Rb3BQb0owT29pUWZUS0t2UEpsOHpzWHNk?=
 =?utf-8?B?c2s0QWRWeHVTREZLTS9SUVo5N0g0OG1mcCtNNDMwQTFJckVpK2F0V1hFaE1k?=
 =?utf-8?B?b2l0eFYwcWkwdTVJT3RNNlZjMFQ4WTZUMTRjaGx5WWN4WUU2ZGNCcnJwamFD?=
 =?utf-8?B?RWZEUG9wS0piWitWTXU4YjVQdXNRUDlEWmRXeER5aUh5cUhTMHBSYlNLQk9h?=
 =?utf-8?B?YkEvNTdBYnRpcEtQNXp3Qll1aVh6OU11UlFzNzBSTVA2a0M0R0dVa09aSGR6?=
 =?utf-8?B?b1BKY1F1VE1pcm5UL2hUYnMwbzhzTXZtM0hoRXZkVDBFeW8yU2FQQ3NQQzYz?=
 =?utf-8?B?TEVPRTltbnV6bGpidmt5aDJwSGM4dWh1MzRSYWlpS2JGNjdhdHE5WUlKeHEy?=
 =?utf-8?B?aEsvc05QT2dSMW11ZStxajByUmIxVzV0QWY0MHc1dDY4Y2VtbDdyMkxZR0h6?=
 =?utf-8?B?bThiU09ESENkRUpyYjRoYk4zQWtER1A2azN6ZmxlMk4xbmQ5SHBqSU0vYnZK?=
 =?utf-8?B?RTRoVnJOL2dxWWJ1dmJCRmNNYWxWVlV6LzJaZkRJUC9MNzJUQlhCNzk2RDJ5?=
 =?utf-8?B?L2pRbnJWRTZPc2x0b1ppcU5WNmFzaGpSelJ5NDN4OWRMc3FFOU9YWUZIb0gw?=
 =?utf-8?B?VTFIT0lubG5vVTlVYTg0ZkU5Y0VCdmJvWGFQMkIyTmNmYkROK2tyMkdnVkVV?=
 =?utf-8?B?cGZ0WFEvSTNsYzF4dVlDVlZFb3IwcVlSMnhQbCs3RlljME9vZURERHpua1Jr?=
 =?utf-8?B?NURHWlBnUnBKdXoxZE1LN0I1SEhPV0xmUDg4K0FNTkUxQkdvNnBhcDFyVzNN?=
 =?utf-8?B?Wk1lUExONkllRTgvMC92Zk93TEFaZjNvcG50RU1pK2QvV3pTUWNrSE8xMEhT?=
 =?utf-8?B?MkEvcWdTOWZoQnE1MDd3cnRtY0Q4RzNUTVQ0WjRqSTVOazlWQ0E2bTZnV2F0?=
 =?utf-8?B?STREYmN2T3ZUV3d1blRFelNiN3NxR0NFSlN0Vk1NeUxJaFpyVENmTlczVlcw?=
 =?utf-8?B?cm9Wd0RtQ2tFR0tzZG8zNmI3bFh3dmt5V3NZYUwyUkJieHVoVEpRV1BvQUtR?=
 =?utf-8?B?ZGdWMlR0TlBtUGdzSXpadXMvVlY5Qlk2SWljcThScXNQYlZoUExabVJPZFhM?=
 =?utf-8?B?T2tMWFhBdncwY1kyNWdaV2JXWVVRU2xuQlVzMFVSM0FXWjdHUFZYNnRYYVlI?=
 =?utf-8?B?WStpUzV0WnN6M21NbHVxdGlnUGo3bDJVeHRORGVTeXBCWXNMNnRDYkhodHU2?=
 =?utf-8?B?SG0xYTh2Ulp5VkduR21HMkJSbUMrN3FNa0FLdXBTTXczQ0dwanhyaDZtVVRD?=
 =?utf-8?B?YWwrdW1hVXlyUnZMaWZxZmVScEtkcFlENlNRaHVQajcwTDFZN3o0NGRMY2NQ?=
 =?utf-8?B?a2xyZXZrNVpaeGVIbE12Zz09?=
X-Microsoft-Antispam-Message-Info: uF2F+1H3NK8yqUOnrBj0e9Rjona6ZZ6kFx3ZXUk8gknGizS+7vQTz+ydl1Ee/ZcTmc+1rjsPhOr7vA3D9xsh27IQtN1hwgf0MLcf3qAkKSSAs250DsOoQo+GIDzsC58vI1EILF0icumALV7OXVJauS2js5W3Cs38r3K5SUKhKegbPWP/LLr5hKGnScLr41Vc
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;6:HVV3D4iIqeBoPRp+2fqAKhXSvGfZzncaGvgGyL+1hP7vTBm6VuJrn2cK5KpNfV7DSub+EOnUNcoo5SaI1AYnszc0OwySXkBaXjqAYijzPhd4RRR9odCQZMUEzWDSCqXVi9kR5s5LcEPrRLXDDRA7E709Fa6ZPHblm6VlbMFXD9NYRC7sZpXAZrOSOuOJSjsWnSOQStlbUwynAg2KYQw+TB4zJx/v6oXqQz8FEDO+Qrww/gak4znHAZXqg9Msndo+5cKMxbc8yASYYOmVJgh7QrVdVxTtKM9eUy8xEcRkZhLKKWTj8657zC0AkAIXorbGsx8gO9pqXk0OYaItJNaq65EJdD+yS6UAdz8dPI/3RM0KWhvZrvhRDQVzFi8/uUOeLKcjJG8w6rhNE++YXZg0kin2/a13yfroulNf92fAy1/ddVC2SXdmKN0zGzaQjOaB/0PANmjXParxQvqp66HdPA==;5:1TcyDLBMrdDj0o1fUHIrMP2KBvY2hubjqKhYwWaM4w9pNJ5qiQX1MRk6FtJkkSgtHDGXELOjee8CFgFumV37+crNofK7m2z2T8Rc1iwNzztxNLpL7SI5m9krmy5NoRh/In0tNehn/qxxC/pvQG7fI156a5ksBDyTon978TkS6os=;24:NSDDGZ+gMZhzi04O/EX+s0kCXkYvS2E8w7W9VOBGSZzFiMh44xTFE0Li2X4g/bLAax3/wp7eJRcmFDpvKnX9oTEQ73IrzsT+vG0DD+nJI5c=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;7:w+IcXlcVmOngKalg2dPTEOOnSxGl0QZt7ePNnETwzBezI9oqic2IBbJcI0HO67H/6owAGSlKOA7BXeOmyI5sdPZqxS+u/YSOZIDrT9iFjiA5TF4rhv3LKsSDjnTtB9XRF/nmKquE8v++zRCaM2F/cYKRIbKbOzQ8t5geDbPOeKSXIBQzeSQXkcdfQZehmvrkfG3imnTJSoore9fBLQAJ2xfOBECsxnGlOtB/I6AYQk+XG0uGHH205QwnXXGyxX6G
X-MS-Office365-Filtering-Correlation-Id: 90538b3d-6aef-421b-5cc3-08d5a081d260
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2018 14:29:36.7923 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90538b3d-6aef-421b-5cc3-08d5a081d260
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2773
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597551024530241746?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-11 18:13, Andrew F. Davis wrote:
> On 04/11/2018 10:51 AM, Lars-Peter Clausen wrote:
>> On 04/11/2018 05:43 PM, Andrew F. Davis wrote:
>>> On 04/11/2018 09:15 AM, Peter Rosin wrote:
>>>> This is a current sense amplifier from Analog Devices.
>>>>
>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>> ---
>>>>  drivers/iio/afe/Kconfig              |  3 +-
>>>>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>>>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
>>>> index 642ce4eb12a6..0e10fe8f459a 100644
>>>> --- a/drivers/iio/afe/Kconfig
>>>> +++ b/drivers/iio/afe/Kconfig
>>>> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>>>>  	depends on OF || COMPILE_TEST
>>>>  	help
>>>>  	  Say yes here to build support for the IIO unit converter
>>>> -	  that handles voltage dividers and current sense shunts.
>>>> +	  that handles voltage dividers, current sense shunts and
>>>> +	  the LT6106 Current Sense Amplifier from Analog Devices.
>>>
>>> Could work better to split these out into separate drivers. Maybe a
>>> iio-shunt-resistor.c that does just voltage->current with the
>>> appropriate scaling. Then make a a separate lt6106.c.
>>
>> I don't think we need a separate driver here. There are tons of circuits
>> that all work the same way and all require the same properties. If we'd add
>> a driver for each of them we'd get buried in boilerplate code.
>>
> 
> Fair enough, then it should at least be renamed to something generic
> like current-sense-amplifier, as you said lots of circuits do this, not
> just lt6106s. We will have then have support for:
> 
> current-sense-amplifier
> current-sense-shunt
> voltage-divider

For the compatible "current-sense-amplifier", I would advocate the
properties...

 sense-resistor-micro-ohms
 sense-gain

(or something close to that)

...and not input-resistor-ohms and output-resistor-ohms which are way
more particular to the LT6106.

But as I said in the cover letter, I didn't go with sense-gain since I
thought I would end up with requests for non-integer gains. There is
yet to be a comment on the non-integer gain problem, and before there
is a path forward for that case, I'm reluctant.

> compatibles in this driver called "unit-converter" which is still a
> misnomer IMHO.

I don't remember you having presented your preference, and I think
that goes against the established bike-shedding protocol?

Cheers,
Peter
