Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx4/zrx4cIm1bPiuG72j4C2MIGUavW0SYcEmOrxXc1J+qFQugGkXqOuiu2UOoZLEGSQLe1T/R
ARC-Seal: i=1; a=rsa-sha256; t=1523862773; cv=none;
        d=google.com; s=arc-20160816;
        b=FI2xSiRf2uZLwpg8hqeMnoCQmyd5ipPTQ2icTq3lLtHu1zbMbq1MDB2ns52pNKmXhh
         Jvo4bpOOvCW8C1MiziILvyz0QJ2C/n6KV+mWlLIyNxOBsMf5x1DeN8wB/mScl7+TwBdR
         fTzfSgucypKnaJ9hIan/D6uVaxUe82zL8sjRZxC/PexpvKPRfvMHVpEmAUs087dI2xZD
         v30Ug+5+kFYTm16GopdsU+7rb/XdEcdOIvFW4/9BGRuShDa533ru+1vaBhMKfx7KusSc
         6NkgiNpauhBJTj93QkpOiyL11aGVphJN8jhdTsiCvDCNGiFdgn+i7eZSq2H+/Xpdi3An
         j7mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=w4XP60oRBvUDQoRL3kpG+GlI/fw3vegPWzg950UTBcU=;
        b=kXaIJQG7I8rawd4BevB+m9qSaTJxzTPbGTyadPYwZe3nJJDFY0k5SfV+N1KoopD/kP
         pGaHKqrYef5Zmy4qfCmLVlJDmLMUYy/NVYBO6zvlCuZW1nUby3G2BRTVOVL+KNDgOdCp
         Hk8lrXc3sC1Wb6KFCO7zSxwKQMyumvX74pIN0sz71UWyoCj0Gi9QvQYTYrR5xbj71uRh
         0k9mtPHyn2iGvXvKKYxl09d17Mp0ufriofS+vrQp5FBibAKrE5DT31Arp8kH8i3w83JI
         oCNMP5nXicZbjVHyBmssOuXqZ+UQ7e0YAkovobMdqVrfn4mJUwkmyNdv0bil+uiUcfEM
         1lpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=qxfuMBTl;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.92 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=qxfuMBTl;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.92 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v3 2/2] iio: afe: unit-converter: new driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, "Andrew F . Davis" <afd@ti.com>,
 Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180410152802.30958-1-peda@axentia.se>
 <20180410152802.30958-3-peda@axentia.se> <20180415183140.04c39ebe@archlinux>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <81e69701-d49b-6675-010d-99d5d3eaf827@axentia.se>
Date: Mon, 16 Apr 2018 09:12:45 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180415183140.04c39ebe@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0299.eurprd05.prod.outlook.com
 (2603:10a6:7:93::30) To AM4PR0202MB2770.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:47f3fd6bX321Up96GfwZgT1k/HzlJBiVVu+ZkSmwL4S3BtxGHBwfuxdN7aDsTL4b4uAI3tINUKZzggj5K7b83Fk/K4JkRMt7LslJLgCJy8pgcyL/ls1zkZm0eKKPb0KazpH366jReKISIc1737rxhj1ho10gOHywaHs+Q71wlrZNX4vUxFCmkuONO3hOiMpb6tUPL0Vf8fEblzS/jFAO3nPnjNW2LjQkNuwqrdkzqs8aYbbnkxSzoKK/9jU2c5cG;25:kc94iEwCtHpBO+8INIg7XDeutq/HK/dbfzLX9wk9ZHCHubnsgWKcA6gC64XAr970vwieCrPc3uFj5nH2slHRY3DRg7mblXEsmml8ChqvL/Adw/n5j/ZtnZfJkwx2jHA3dgWCEbtSnjtcwCvpzUWW2BAikqgJKwoEDE77/7sUX35H15lEo6eTyIKnoXnFMaammdblxqesTUeFR/c/kj8xCDeRgIluKRGIwsH0CvZGTpikRliu8rqSMPgQduNyN9xhUoriKQ5F+Iy+i+Jdlt7cgI3cNMrY0JU+AbiAjjl+rkEE85Pe1ThcbtDehB3RoXck/N/UyCrYrTDuO9DNtGSJRw==;31:nZmttqcmWzjPNY4vZWvoHrV96INST2VGY34m/lMAmhYR5AMKvrHVuSQQMtOuwYUewatBDeE3aHYg8pqGfe29VD/IkRNmKVs+lbHKU2emCE+5dHf+VUfTGDsvuKBFjXMs8YvC3fL3pBvFYhzsNqQVuLvg1ttg4wPCaFPOoqlLHsqerlr1Y6U3EV/gEPWsj6PWiR1SfpTtO8C/c8RRUng7aEh+yxDOky2iKghz2V+S34g=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB27703528521CCCAECAEAE139BCB00@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:1qxKFtmjxipJOcovE2VJ4SbN6umW9RhsgBppyMrbioEqwpgW1yDCIgedN+yPSbG29BpWUW4blux6at6e/7EQhr77A6uMss7VZvps05QJtT2nGTzjn+EgU1L+GgSa0dladQ6Xjo+HYinPSibO2J+Xmvje0nQ8Xt3Brs92GO7sgA3+RCMhUlPVpg7aNz11CZHMix8M7LSLojIuKKFivj4VAcLcBH+hvh3torE2GG3OYKTps9HPk7soNfNZjmOX/r3wE4qJWu92ykKtaJZIfGP2rQ==
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39380400002)(39830400003)(396003)(346002)(376002)(52314003)(189003)(199004)(377424004)(47776003)(76176011)(6246003)(16526019)(8936002)(68736007)(186003)(53936002)(77096007)(66066001)(65956001)(65806001)(2486003)(36756003)(23676004)(36916002)(58126008)(52146003)(52116002)(53546011)(117156002)(386003)(478600001)(31686004)(16576012)(3260700006)(316002)(8676002)(39060400002)(105586002)(446003)(81166006)(81156014)(2906002)(97736004)(106356001)(86362001)(11346002)(956004)(3846002)(6116002)(64126003)(31696002)(5660300001)(486006)(305945005)(8666007)(50466002)(4326008)(25786009)(6666003)(6916009)(229853002)(476003)(65826007)(2616005)(7416002)(7736002)(26005)(230700001)(74482002)(54906003)(6486002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6b1pxS0swRzBhbTVKOW45NlVSanA5TGhi?=
 =?utf-8?B?akNpVU1tcmM0bnhjN2pyUEN2THB2dkpwQVN5NTRKSEpmTXdlMzhheGJQUjg1?=
 =?utf-8?B?OWNpdGtzUEFVeHZoazV4a2pJbU14NTF4SG9FbXU4bkRQYjRxOCt3YUhxb2ds?=
 =?utf-8?B?WTgrZXc5SEpDelFWd0RabXkxVzJzM1RNSExVTERIenhsNHkxU3IxUnl6L1Va?=
 =?utf-8?B?SDl4cjJTR1hxMFI5N25GaGZlM051OGR3bXpIWFlHSHlKeiszUU5OUzdpb1ND?=
 =?utf-8?B?MG5KOEwxY2tLZzZlK0xmZEx2aGoyTHNLTTliVVQrT283bEFqM2x0eG16ZmxX?=
 =?utf-8?B?QXJmUEhZMnNUNG1HUCtvaS8vMm1hamY5N2s1cmpuMVdRM082YXVXQXEyWDJW?=
 =?utf-8?B?TnlUZm5YVHFGaW1sKzBCTndzQUNkbzZzOFo0U3gwU043bDZTRjdUUE9rUnFp?=
 =?utf-8?B?N3lHVWdPT0tIZ3BLL01BQ3pyWWdlYUVFTEFyaUo5RDFqS2tJRWI5eS9oSlA1?=
 =?utf-8?B?UHY4K1JTMjNTVU4yYWhDTUtFMUVXRFY3bUhQdW16WjNYVE1PeDZLNWUxcTRT?=
 =?utf-8?B?RDRxVGVOUDh0UExMTU1FWkJpaTdHR290Rno3TDJWRUlPcWZ2KzlEd0Vjdk45?=
 =?utf-8?B?MWVNbEo3REYzNlNKMGJqQW5GV2pSSWpyamE4c2lXa0VzcFpWVnVGdHZ5dGE3?=
 =?utf-8?B?Wjh5Y1pNNHkxSVprN1FtZVg4ZG9TWFBuUFFTOXVyTi8xenVTQ0trUCtQdWZE?=
 =?utf-8?B?ZWppem41VmVxNEFUVFdBcWtpRXZpY21uMnhSSFhiNS9OYU00MjNQaHFsNVc5?=
 =?utf-8?B?STF6dW1BMkRDVmovd08ydHU3WHVIRlNxZ0pGYlI4S3JmbWV5WEpueGZNQ0NC?=
 =?utf-8?B?WjRyZENkNzJIM2hCWjV5WS8vNWlRaWlIMjduRlVUVTlnQkQ1UGxHQ1piUnFt?=
 =?utf-8?B?U2g5c1plekVDeFNCMGVVVnFpdEE3YVBEdWtoNUpkcUtlS2NoQzVJNjcxR29r?=
 =?utf-8?B?QUFZSzVUMVM1SEZjZlU4MW5DaDB0RGJmVEwwa3kzMmNvMndZQXhKS1RvVE92?=
 =?utf-8?B?Z3VWOWtNMjhmaElCOTUvNDhXaGFmNjdjQWpHWnRjckR3ZVpYNU5PbDBMdnFs?=
 =?utf-8?B?bEJmbVZvSmJERFRNc1E5M09WbEhOVy9pY1dBd1JxYjE2ZkVuQWljUDFOV1hS?=
 =?utf-8?B?YUJRTjVGU25oT3pENW9HeTFMZkFlUEhTdzRST1hoaDFLdVN6cm5QSXo5M3BJ?=
 =?utf-8?B?QWVod1gweDZuWVBXa3lHdW5LZUhrNXg3RWovNG5na3hpR3VLMGluV3ZkVTVT?=
 =?utf-8?B?REVnMDFBSEltdmhYVjhCTUY0R1hxdll4Ynp4a0JSS21jek9DN0ZzVnRwMHdP?=
 =?utf-8?B?OFBxUThHRUZVQ3ROeHFIOGd6VTkyS3R6NWwyT3RQMXFQRWdTMXE2aWNRbENF?=
 =?utf-8?B?Y3M1MDRDN21EeVF3Z201Sm9JbVVtUm9NeGs1c3llZ3BRZ25uUFk5L3VZR0pC?=
 =?utf-8?B?ZTVrQ2NtdmF0TTNvdjdwM2V4TTBPWnl6WVhxTWNRMmhLcGUxQms1R1QxUHdz?=
 =?utf-8?B?VHk1RHVERkpwTXhIdEZ5N0U3VTVWSXNKTHlDeXJzdjcxZzl4RzZvRk1ONkVs?=
 =?utf-8?B?cGJpRmd0VVJoWEw0QkNNZTRYaTNpS25PVGhDdWtabUJINStUQ2FLK25vRkRN?=
 =?utf-8?B?bUp5U0VDTGV0REFYbVBtYXJUaWpBM0x2Mjc5MGpyMFh3R0lMcUxaWDVvMmFJ?=
 =?utf-8?B?aTFwSFUrV3BFNmc0TWxtd1ROQ0dBdGthMnc4NUtLd1ZpYi93RzdpYXlIUVRM?=
 =?utf-8?B?cFlKQzZWQjFwM0VLSkMvZXlQd0g3VkdiUkJQV0NXbDlpYkw2a0dxcWJLYjYw?=
 =?utf-8?B?QzVhWTd4aW9tZThGV054K1h0amsxZC8xblNVaHdxbC81TlB1U2ZrTU0ySms4?=
 =?utf-8?B?RktMd0hxZ3RudVQrcG9WcXlIQTVhTDlsNStDKzFKMjVuZjRnODBlbm41Wk5O?=
 =?utf-8?B?MTZPMkJhdys1QitFckQvUkpVMU94SlRTL0xqQXl0NVl2a2xnREloSVNOcEJU?=
 =?utf-8?B?dEhMVmJ6eG45YkZwNWxIYkgwejRxamF5MGJWZ2xCbURDaWs0d0ViMEpXck1z?=
 =?utf-8?B?Qk5KdEdld09jTWNtdjV4ejRZZE8wb0p4RU9lQ3U3V01tY2UrZWMwZlYrNWds?=
 =?utf-8?B?RWVVaVlEODF3cDJ1TE8vL2VWaytWY1NGRGN4MWdpd0ZKV0xOeDFwZnV5eXJn?=
 =?utf-8?Q?QhfNz1RqfzRzmxRv3PyI?=
X-Microsoft-Antispam-Message-Info: KZCWz34nngBTEL1KwJGnUp8jfFJ7AntxvQ9o6IMaZ9ruHfjunz6mw8u5v1odALbwIKsDY56sfZY5XntDZpnxZqjwMI8IQA/rRC6DMGnxdQOS8V+/Qdv1fUbHQZdwAKcAQ3IggAzBrtc/roEvpmZKkCc5KGm+zATkQSaZEXtEF0CU07YYDztTnlkLyI3fvuOi
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:o9ZMU2RDGGTuxgT6bzyaEE4bdOAyCejGct9wqGAFcAaVK4VaJzCqyMyrMdA+0w2BlmmfsF0UV6i7r+ckhCbbnO1Xr232Df3avQ6XP3XK7I1My/518k3tUDGKnYiLB5lc+VGV7YhM6WKOJcdxrFofk3QJb7JVTxkamfuFcfavTLMZoI1zaXpmUPayuvN0YfB4LH9JqQOLlYf8dN7f+zSm6dkpW/E9HfzxIH088NSY0xVEESWenevXYj5ICcPDFHHGfHHtwAI0UgkxBS2y7Bog2SqzGR20Cy3lVBkoufTlnUNX8hy5HQinuzCwQhxv2SmX6V4Xy3oAYjSWAhzrRpZJxukkzUZoYVIuhJysZ0bgDGLmmV7rQWTcfTvlIe8wl7/+WU/hE+YxsPNqBf8LOmwkC8Hp6wngJpOa1QAh7JVg04NPJWifdc8uq8IBvD9C34m4IwtM2WAQq4tDibpzUvYiGw==;5:NcIkspIf5Y1jNXq8aJ5g7SwM0euS5E+VZ3ViCxE5wQTBOYqSuo5/HOSvAs+lfrZAwPF78QosanL1VW/wrL1ohGI/WWAe6ZsOGGFnCQ3+Ymk7aWuyPwO0nFc3Pf0lBzBOxzQGPLzFfzfJ2KpSncg1sC/KYyXjVKNgL9oF6yLX7qs=;24:lNY4OnzHcwtb1Gz2RdFcrTpCDTD+L0swEJnoJPadNe+zrT3XWaxRgS0GcE/upex2ShcmZrSCxz2PMiMSzy1nvtktxUCJpEFUz81SHC8uUZI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:Wy055mT2Av7HVAGkArrlsqiM7YUpGg26qvGB0XADb2bgahnC6FWPnjpk9+9vdwkcjDHnntrLxsBBfJCn/aAAgaunohTp3ZSg+4S4Il9xQQtc2DqeUKROpdE0XQWH9jvJSvIs5i9favBKFVE9BUaN9LdCPjB5fWyiWuNAHFAUbJw0SVL7DKduHw5xHSaggzD+z0qPW/DDajcSRyz0Xp+sFDBkX2K4uNyPTOBfKqWCbjUnXpyvaJdfZoBgpv0T8ZZi
X-MS-Office365-Filtering-Correlation-Id: 44700b33-bae7-4eeb-03c4-08d5a369766f
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 07:12:48.6361 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44700b33-bae7-4eeb-03c4-08d5a369766f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373534966690766?=
X-GMAIL-MSGID: =?utf-8?q?1597885931211796165?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-15 19:31, Jonathan Cameron wrote:
> On Tue, 10 Apr 2018 17:28:02 +0200
> Peter Rosin <peda@axentia.se> wrote:
> 
>> If an ADC channel measures the midpoint of a voltage divider, the
>> interesting voltage is often the voltage over the full resistance.
>> E.g. if the full voltage is too big for the ADC to handle.
>> Likewise, if an ADC channel measures the voltage across a shunt
>> resistor, the interesting value is often the current through the
>> resistor.
>>
>> This driver solves both problems by allowing to linearly scale a channel
>> and by allowing changes to the type of the channel. Or both.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> So I 'think' the only outstanding question is Andrew's one about the driver
> name.  We aren't in a hurry at this point in the kernel cycle, so lets
> wait until that discussion has ended.  Assuming that we do possibly end
> up with a change, then please roll all the patches up into a single series
> to avoid me getting confusion.

Yeah, sure, sorry for the split series, but the lt6106 that's present in
one of our newer designs didn't occur to me until just seconds after
firing the first half of the series. Which is kind of typical...

Anyway, about the driver naming. The suggestion I like best so far is
linear-scaler from Linus W, but thinking about it some more I think I
like iio-rescale even better.

Any objections to iio-rescale?

Cheers,
Peter
