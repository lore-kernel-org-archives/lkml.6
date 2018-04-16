Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AIpwx49wnZVLB5yu1oXaPM37jzHRP+fwGz15jNUa14M1R+SFriWJIQbz/0hUxFdYds6y99RTsluK
ARC-Seal: i=1; a=rsa-sha256; t=1523887254; cv=none;
        d=google.com; s=arc-20160816;
        b=iVGzfL2S1RhJ+Q4bXO0JiFleIiW4GdlNcLV/GKS/k+zUVW2MPAi87M9krhH+KA2keQ
         pclSRTBErCiCMPE6YcBxE/7TFQEuDQhYGz9dh96JLcBZtE0norGzy31sR6trmlDR0QLQ
         V3Vzxppi8cVn/ae3wLpQuweJilGNpREiiOenlzq87GTHd76CnBiUDHf5/wXGNScWnlQ/
         y3BUxHVi5G034GCc1nwNYDjbT8AvbzhEi6Z/+fbEVeBfiBUlex/UdstVbudlaYk3T/ux
         +vPm2HYhUbQNWiip/gKWtbS5p7Cil5EBJ57SqEfXinqBPPCh5Wp78NtNjf+OdJH5d/pb
         rfzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=zQ/h8FLawq/8Xb6rRQoDfs7RFdC5IUOIb271zwFeO+s=;
        b=onxA+ztetbAjq/uLaPfreNYIBUYgGvPbdw7VX34zYIqimZgruz7RUjajlqhQM9il+C
         8Rt0J2abpommJSnEK6O3DOVqz1vQ7aPYu8RtoB8cPBZEGUhJp4HT2eMd8sJZRB99gxLG
         xdgJgDo002mYhOilI6f766ZQRj1e/Oaem5ARgV9LaZJPTbxTsiLmi+W2qQWLPy0AfAOh
         eIckHVuPefv/33gTsg7mm7518fD7K74k1cAlczaqXMkrAtbOhdRXTEjL3YQGQCG53aDK
         zQlOnBCkDWN7jvAKEmOGC69RwbEVSGkk8Ls7mZ0FfyhzQzXk2jcs2Nk7melozxHeDdm7
         eF1g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=la/zXHga;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.121 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=la/zXHga;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.121 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: afe: add current-sense-shunt and
 voltage-divider
To: linux-kernel@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
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
 <20180410152802.30958-2-peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <f4665f80-97a8-dedb-6d4b-b5e92b99ed78@axentia.se>
Date: Mon, 16 Apr 2018 16:00:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180410152802.30958-2-peda@axentia.se>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0007.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::17)
 To AM4PR0202MB2770.eurprd02.prod.outlook.com (2603:10a6:200:8c::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;3:YpucJEYIt6IJd0SrbQv84umj0rwusTsURa5u7Fl6qLaAvsi+sBTyDLs1fnDytCShaK/2ACaTaStbYsNpHz3zt9N1s1lfZfhVQag/7JJYYPnQymU90LmtL2Nbgg3tI9brk7PoeJjekkB/kJn3eqzXwiynaU+sYzQa4LG45yaSWolM0yEbpUm8FfGvDJs4HpIQz7dIuBIToB7oFV1VJO29XlUYtUyVLl22TRdD6bKe1Cs0xjeVv/eOPPKHIydzXVHy;25:pZUfLIk/XCchK0e6b1a1AHMqAlgAFmC5xti/V9fRn9Z0sGTtleFN3G4MO4QuwSfzBStCs73zhVSgQgVLt8fP8eym9i+Ntg24HjLONzqYVmK/xrbp+kWeJR4jJRZMkRjnQQIyY0h2N0pNqZgJtEh8uIZTBCz4uBJdp1KihbEuAQ99CetEfzioJdAtMDvfpSkLlmwMjQHsHg6sJ0vU7kp0KaIWAWdpjU7AxtAalOCNgUMlUZkbwyvuXtxvbaG+0vy1z/pzBEyeygD48eP6b8ozf+A1iYuXW7UtZuoFNdXwR1xBh8Uqp0MGu0AGpvQrcQuvKHaFdDfmwBqiinmGgU7XXw==;31:Mz6FsmAWN9G14bAJKvpa0Q98ZECyikCJxJTLQXhTq4HdK5Ey00rQENpaRXnSDPHvpPla9Lhe/1lf8K/Aq82OFz8DrTn962iIw/bJ9Tqw9rx56fIpbzIQTseZgj8dXOhYtqDTPU5hj34/4kkjRuO9HWvQwSEnI649Qp8RYkgxlnr5LBU1ioWZKwDDHvFet76mE01UL8YCZVxktBx9vaN397sKE6qQR9L9ueXfUeyUmoo=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2770:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2770D630D142DB10862DBB2DBCB00@AM4PR0202MB2770.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231232)(944501327)(52105095)(93006095)(93001095)(6041310)(20161123562045)(20161123558120)(2016111802025)(20161123560045)(20161123564045)(6043046)(6072148)(201708071742011);SRVR:AM4PR0202MB2770;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2770;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;4:Kd6SgFJmg5WBcWP1pZLtdEpUkmCDRqtlJiJNC+0TVIKhllLwQuRF+DakPW9kJAG8845QiOMKE20CFM7P6LzHBC4W1qDk+VmCMmA/9i7/3LjsS4k6/8uqozXqnRACjEgUg7XLzNF3I45Ny1b6H6JD9YoryevprZMI4/t+x1MTek1w7sMQDlGsgmTCeRhWx2GGHUr7kqlaPM+TUAvanLfCypwhElFxVCPqQ6ZoflYDpwcEstd837CMbZ4jTUbXDBj2/ZZShu4QlZpHb7yj75pyNg==
X-Forefront-PRVS: 0644578634
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(346002)(366004)(396003)(39830400003)(199004)(377424004)(189003)(5660300001)(64126003)(31696002)(105586002)(486006)(50466002)(4326008)(305945005)(8666007)(25786009)(39060400002)(3260700006)(8676002)(316002)(956004)(11346002)(6116002)(3846002)(86362001)(446003)(81166006)(81156014)(106356001)(2906002)(97736004)(74482002)(54906003)(6486002)(476003)(65826007)(2616005)(229853002)(7736002)(7416002)(6666003)(6916009)(230700001)(26005)(2351001)(52116002)(2486003)(36756003)(66066001)(58126008)(52146003)(36916002)(65806001)(23676004)(77096007)(76176011)(47776003)(8936002)(16526019)(186003)(53936002)(68736007)(65956001)(2361001)(53546011)(16576012)(478600001)(6246003)(117156002)(31686004)(386003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2770;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3NzA7MjM6WURSdVBhWS96YzRQZWdMbkFNWUgwSlp6?=
 =?utf-8?B?Z2VueVJDaThyYXI2MjRaVHpSaS9aa3VUUzFIRS9VcnF6OWQySVdIK1hpNXR0?=
 =?utf-8?B?ekhJNHBtOHJRTWFINEg5eWdtYVZWazB6RERwMzhscmN0WlB3eldEUlFJblFa?=
 =?utf-8?B?Tll4WkNNcnVMMmRSbkhVdUxqck1TMHdXUkpKTDFrTjRKTlRjMHR5TVdka21m?=
 =?utf-8?B?MUxkVlNZZUVWeEhyKzJXa3pJaVk5emhwL3d3dHJxRzRhQUNjUm5wWmE5RW5R?=
 =?utf-8?B?Y2MyWTdkWk90TnVITlMvaGVubFpPZEJLSHpSMGJVNGMvUnFGYjJtdkN0ekFL?=
 =?utf-8?B?ZWE4bzJSSzJFT0lEZ2NNOGdGQ3M2VVpvbUZwMjRrU08zdDJWRW92TXYvbWlZ?=
 =?utf-8?B?ZnAxRlFTWFZCcFNhdnpnNTdTWFlTbUxPMnRmN21qcWdJZnJIais0MmpBZ0Vx?=
 =?utf-8?B?YTlTVUVVc1krNkhVWTJJOTFJcm9zWkZrd3BFNnFLQU8xLzY2UzlLcFpXZ2V1?=
 =?utf-8?B?K08yOVFzSkxMNGZYakkzU3I5SXJUZkZkeG1LVkdDR0lZT0MxU3R5UWgzYUFk?=
 =?utf-8?B?OTdhWFhTQkRkOUxpU0p3Z2pTcW1kUXJtV0dKRWNqditaay83UGJJNHBVUlBr?=
 =?utf-8?B?ckwrZEZLUm1EOGVEMFNncGw5QzQrdThlem5MUHhWcVFLa1pKdmNMSnpsMDdM?=
 =?utf-8?B?YnlGUmJlYzZYdktTZHpYWjY3RVJ6MklweFI1QTVtQ0RXajZGZllUWDhFOW5J?=
 =?utf-8?B?WUNOcU92Q3F5SlpXSzJiNHFzU0NUY1BlY2xPSWZUVy9BRVVIME9yL0ZBaDQ3?=
 =?utf-8?B?T2ZsWVA3TUVPYnJUcnRlU2NGQzN1NVhkV2xVSWlMNmtVWFUxalJudFR1SFBV?=
 =?utf-8?B?cTBqOTEvdnc1MTFoVWdRb0dwanFOUWNQdUpNc3ErSkplR1hzSXVpWHB6ZXNY?=
 =?utf-8?B?YWJ2R29KZVBaaHh2WTY0a2ZHelVOWitvTDlPYW9UUm1XNFphckx1cDI1dlhp?=
 =?utf-8?B?UzlZdnRUaUJVM2RySzhUclhTZzJvUDhFQnMvTkt3Z0kzU0tvZGc3Tkxwa0di?=
 =?utf-8?B?eW5PSVRBNVJOZ0syTG1qSjF3TDNHbnlaQmVZNW43Wk0zaUFla3RWY0w3ZHpv?=
 =?utf-8?B?cGgzN2tQRTNBNkxNbCtzNHJvenExUTEvSEwyU3hMR0tscDJUVWNDUGZ0ejBE?=
 =?utf-8?B?a0dneTRmUVlCd2s0UWlULzNpYnVuWGt1RnBsQklLL2xsNGtIMzQyYm51MUx1?=
 =?utf-8?B?Tkk5c1Zsc3JTSUlHa043S3c1L3VXeUszSFVwcGg2QWcySVkzMFMzTkZDS0pX?=
 =?utf-8?B?cndCRklWNlBqRXpNbytUSkIzMjgvRjVSTDhQYjNHcEYxa2hiUDZLeVJNTm9S?=
 =?utf-8?B?SDlDNHB5OHpvTGROaU9JVUNNeTVTdk85VjhiYStGQkRFbDlESmxzanRBN09S?=
 =?utf-8?B?R3gxMUdRb3ZpVXJybnkveUwvNTV0OUszR3J1ckJqRHBHY2E2bjQyM3VkRTh5?=
 =?utf-8?B?c3NYZUNTU3lFV2dFUHNLbkJmRkw4UjR1Z1RFTitucStQQUpKVjFqdjk0TlRs?=
 =?utf-8?B?eEhVYzJpRUd0VVNxbCt0aFMraDNqSFZQUFN4K3RkekhORnkyOUF6STBHc3lZ?=
 =?utf-8?B?YmNNN0laSTdWK29xbWxDN2JBUmZQTFFhRWZWVDVxcXRkd2RpbWZTK0lPemZ2?=
 =?utf-8?B?NkR2S1R1UjlOYWJySStucFZCQWxLaUd3WllUVzRzMnd3cWU4dFBXcjhybkho?=
 =?utf-8?B?a0QwRWM1S1dTZFlDRUM2dUxRbDFxa0haU0RpdWJXczhYSi9QUFZaT2R3M1Jj?=
 =?utf-8?B?eDBQS28wU0J0T09BT0lFcXRlaXRoMVJDa1VqdmlsNEVCZ1l4M1FkdGlzWEps?=
 =?utf-8?B?YW9sK05TNkl4c2JJVkRUd1FyZWcycm5XRFJYb2ZFN0dSL0Zac2JqK3dOMCtF?=
 =?utf-8?B?Mkx5bm1DbEFWakhEbkxia0cxWS9PamRUZEtGTWZieEZNSytSYm9hWXVGcHpK?=
 =?utf-8?B?aURoWjI4UnFIejFHKzJDQmFHTFY1cVMrQmpaYmNGdXBTWUFMcTFkVkR6ZjdS?=
 =?utf-8?B?a0VNbjBvUHlZZENQU1dEUEhOMi9JUUYzekMrMkFRNGszQ2g5c1VDUmtyQURq?=
 =?utf-8?B?ZEwzcGV0SmNLSk90MTJyOFZ3bTVhSkwySm8zQ0ZWUjZLTUlic3NlRG9sRDFq?=
 =?utf-8?B?WGM3WjhLNkg0MUNJR1lJVUlaSXg2b2VNMG02R1RtbmEyVm9zTUlvUU0yVkFO?=
 =?utf-8?B?Nmt3L3NGTmFWVnBYQUJacG5qLy94ZGNUblFTcUJZK2NaOWpBMTQrMUhRPT0=?=
X-Microsoft-Antispam-Message-Info: To3rrp4n/vKeRodY0vdA7rNvzwOTogEPAPXbYOnnrontC93DWvvP4iCqYjopy5pkuSc71wV4Ce0gP0gxnPWWd9AkQjL/e05oLUmlqcLIgOXnaLzKWIslQZdOqLIoHS0fBJ343td/PV2h9XbYFxvz2hECYYZ/nwLiGqOrWMmLWa5PHMAc3M6FWySVXR+S0El4
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;6:TnQZXHmU/Ie9+gU3TQ5wY3EFLaf+0Rulzr1/wbUZ6q/GOPBpx7oH/umpJKVVfR7AZ4cdgsDuBheHJGc0QHmZqzbwFYwBJKD9XHsUljr/LG73gTNwTXlDcBM2XTY3dOekaNSnLqJ2lTZnLOtFAx2cWKWe2X12Hpd2FydCFqkZbHh5Cj0NQkU2vl3hcMrTYq9LiZC6Lvx1Nw5YaT1K+Y1/1YUrJoCy4Gd3h+ITgu2Ga95xDff0NENrVrsKTfnjQJB8Gs85xODDvmmYyrwtwOXBybreZmGgUF9knQXw4pdXADLVMDjVOugpTlHJcg1/Vd/7HLUVoqWGB1R9wTvC4vNtgQH6T8AzFPS3liE0XpBXbmcGci6ZzgTnUfkXQ7vKT2rzWPWB3ibljAEFGekaMZ3eaLZY1IIOYzNrPy0SdqL3zqgsGqjSgTEopDaF6yiXIMhnXATQxKqT6ra4Y9Ts0BUbqg==;5:A5q2eJNGowEdp/8hqae0ivew3yeJvtwoVI/RLhYBu/BnAInWaPBkql3nPbDizW2goGIOASMbb1ZtHvedPrvuoqvzxMB+nFtsgjXFpfQLd3ipfO8XaFgysga/2RiU8UJndOqPQRxB2TTnF9heprczhlaSOtjQKIcR7/+wCZw0MHc=;24:DgVgFc4wu11vVv+aGc5pMTSYNv91gZanxaY/qmcaa3s/MbmK6AuAl6XokKmgDr5pR35RffScfzjPI+3fbBEMOSkD8Cd64n0EGF+uHPBmuG4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2770;7:pkMQs3VUt3BR8VPx2jPpOHhyJbb3hlD7psd7zO8UqZ2XpEWepaEk6O3FUmHKCTXxr0aatPIoX1BvUWQckPyURvPgestbvyyCxrD7RChX2Ktd9UQaWvJBTSHblMeXYUnJJECiGIASDPGNFM0GpmLyDMfMIQdlJCnzJ0LrZw9morueAVCDnhd1S1yhY3yFYegva4kPu4pk6yf7wrOktsqnOf2kqvSEtUrt3WhBvIzASRs5Rn/Lgz3CyJ5fzPgFsfOG
X-MS-Office365-Filtering-Correlation-Id: 801363de-062f-441f-07f3-08d5a3a27531
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2018 14:00:47.9126 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 801363de-062f-441f-07f3-08d5a3a27531
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2770
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597373529205381513?=
X-GMAIL-MSGID: =?utf-8?q?1597911600944970408?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-04-10 17:28, Peter Rosin wrote:
> +Example:
> +The system voltage is circa 12V, but divided down with a 22/200
> +voltage divider to adjust it to the ADC range.
> +
> +SYSV        ADC       GND
> +  +          +         +
> +  |  .-----. | .----.  |
> +  '--| 200 |-+-| 22 |--'
> +     '-----'   '----'
> +
> +sysv {
> +	compatible = "voltage-divider";
> +	io-channels = <&maxadc 1>;
> +
> +	/* Multiply the ADC voltage by 222/22 to get the system voltage. */
> +	numerator = <222>; /* 200 + 22 */
> +	denominator = <22>;
> +};

While I already got a reviewed-by from Rob, and maybe I shouldn't be
stirring the pot, but I had an umpteenth look and I now think this
one looks a bit odd. It shows a bit that it originates from when the
compatible was the very generic "io-channel-unit-converter" in v1
of the series. What I mean is that a voltage divider presumable always
gets you a lower voltage. Therefore, one would assume that the
denominator should be larger than the numerator. The fact that this
translates into the inverted fraction when calculating backwards
through the voltage divider should probably not affect the binding.

So, in the above example, I think it would make more sense to have

	numerator = <22>;
	denominator = <222>; /* 200 + 22 */

(and then, naturally, adjust the driver to invert the fraction)

Comments?

Cheers,
Peter
