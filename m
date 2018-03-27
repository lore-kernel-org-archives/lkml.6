Return-Path: <peda@axentia.se>
X-Google-Smtp-Source: AG47ELvAPdhkL/xME+JD67yga+y5BSt/AWIkw0fgn+djXiTmAk4pDX10h9U5+IYFDOWsjOO1DU0M
ARC-Seal: i=1; a=rsa-sha256; t=1522136568; cv=none;
        d=google.com; s=arc-20160816;
        b=RtPncQQTOTVcMSiYkgHg3G90H98Jl/Yq+wmJ98JjJwb/8inzvuKqebTbXi+glMJ/7p
         yYAwURC0uygb98dQNDr9LXEk2sm825mY+GI764rye6nvnra1dRh3zBbc0THcd27gpRzo
         FhGh6/wFq+JyFCFAXH6rILreW8HKYNCnYUtOvZGYq8AyN5K/pRYgTjAE2A/WfjfSMGgu
         wn5RioIXYPglq/0i4iKf9JjZVDAcLB0eWjsN3XBvzB15d4X6NKebQj3MY1WiIm42Zg0D
         8QMC3BWgbnml/rzJZ0aSQ3+bzjWp0joxzk1ZwmjmfJrzn4FJJm6rZM/AtEycANjHN9ri
         9ZvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=oWwF6Nwy8U6hi2voJ9QSMg0/5tXjxW6X9G2e/s76sp8=;
        b=gwJ8ovex2+uDOZxZJoTR2oQnejB0fdwBxrAhLrjljYs9PG6HnTsYhyuFXsvGINmB0u
         0nT07zriRIU4G3xEqXPgWNNEFY7TLW5Qg16BIEM77/IXEseSPLLbO0FXOdetIopxGGnQ
         Auy9RlpP/1OuyYtBmRPR8c+L2hCZVGKGDSX3BWSKU/IP+Fc74EqLlnbnysTvjZyXOjxO
         /4AJpDQSJvCsJcndzJjdLaILJVGEG2jYC8du1yXxJ28g758gWDT2rEzV2Co0lUvGfert
         h+MkXnu7WUd4xM32U36pqpRQkN28UL/gbsK56SzV9hoedHUNQgZczuC8dK+M0AWBxsDF
         9RcA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=vXcW3Bxg;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.96 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: mx.google.com;
       dkim=pass header.i=@axentia.se header.s=selector1 header.b=vXcW3Bxg;
       spf=pass (google.com: domain of peda@axentia.se designates 104.47.0.96 as permitted sender) smtp.mailfrom=peda@axentia.se
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 3/3] iio: wrapper: unit-converter: new driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Rob Herring
 <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Linus Walleij <linus.walleij@linaro.org>,
 Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20180319170246.26830-1-peda@axentia.se>
 <20180319170246.26830-4-peda@axentia.se> <20180324140339.4ec66792@archlinux>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <1e950fde-d3d9-ca9c-1055-7ab8fc57fc4a@axentia.se>
Date: Tue, 27 Mar 2018 09:42:40 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180324140339.4ec66792@archlinux>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0102CA0004.eurprd01.prod.exchangelabs.com
 (2603:10a6:7:14::17) To AM4PR0202MB2769.eurprd02.prod.outlook.com
 (2603:10a6:200:8c::19)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e5b7850-701c-4315-53e8-08d593b6544d
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;3:PtDlWVzPh1tQsmG5GzFM4LXOwgJARm9769SuiWw6MaSoJGdp940V7cLQ9vq6V07fZ/vi0YZ4KRURwKj4wpaLprCFnn9zBJFwQbWpmmtT/Yas7+FuVutgJ+Sm7J418mVCxSVzBkBFdXBoBrslJK7xjvWtmvpV+JyhGJXhesEq5IRads8KE1HAOD9sz2R68obCTojO2ZaoIwS5YxYqjYTHkMtx5vzgIwDu6o3j4atENvmckD7JJwHyZhNcLhmFAxFc;25:ScErDoWM8FdnhSUpTxCzZwKDQA4alfdS84ZzHk6MRtz1Mtscic0MmL+1JfLmi8EHq7tZuikIlMpwJjR7Hjy1Kd+aZYUbCUHMRcQOn2lgXx8rsgW8/wsiHkT6ZWgNDt/SGXXIGKkx1x2FxRsFTratIU0PiWp7LE5NLsleKoPJzxqKTgn2148z8QMi7KZFeGDLoTYpc2UM8cPwdKwx8Zlj61Pp3UwnKa+69+SgnBM/Ec39UghRSECk7TD3g3TPsN66HTiS/LsNqqPL+Ez3isCmLo3PtRXBSipODgwXcmIAzpcAarj3qVNyr5tcWgesaaGTi68Ufu37YISZNJwpuTx5jQ==;31:Mv/n7JWKj2WYDXfUla9qc74Ch+EasV/bVEdGvNmTEEjNPC05UBSQzND2OOzFswnHtCRuzBdyshaUVq75Wyar47N8ATF5OWyZIgKcwdrXsMMnCmi8XI7754TB4rnBYMOkKH4j07j2PYdhFjD4rCmWYtpmJer6hzVc0PfLmlrV/abzPj2KhePy9AtMs+I4ZCmvdpQLr/9K1AKE34SqT//pqiTRFjLuYoJQ/HR2sHjE5fQ=
X-MS-TrafficTypeDiagnostic: AM4PR0202MB2769:
X-Microsoft-Antispam-PRVS: <AM4PR0202MB2769B4647F6DA8504014CA35BCAC0@AM4PR0202MB2769.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93001095)(10201501046)(3231221)(944501327)(52105095)(6041310)(20161123558120)(20161123562045)(20161123564045)(2016111802025)(20161123560045)(6072148)(6043046)(201708071742011);SRVR:AM4PR0202MB2769;BCL:0;PCL:0;RULEID:;SRVR:AM4PR0202MB2769;
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;4:D4dXPe8guSXyD5LtBsRGNT60S+4m5ifSJtkem0yM4FppNU/Qh6AThaxzcjzJt7lncme+Bz2meO3atJgny16pmA+lD++OuMuY9IeRXmfxifS0aUcSFdqYHP/k4cjeiN0XEsHs5lVuEAZDcerahEp8OtGkB/n79ttFZSBwgdS7t3BrwllZJkE0f35GpQb9BjzBRRicJ2mf/wv5QHqvJt6Pib7pDQ82KpvVKzG7OpGTtS3/fSkoqPqCPVD2FC1t94D/EO581Hyk3D87KH8+e3sdXg==
X-Forefront-PRVS: 0624A2429E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(376002)(39380400002)(366004)(396003)(39830400003)(346002)(199004)(377424004)(189003)(117156002)(7736002)(230700001)(305945005)(3260700006)(486005)(476003)(25786009)(486005)(2906002)(5660300001)(68736007)(6486002)(105586002)(446003)(4326008)(86362001)(97736004)(6916009)(53546011)(386003)(478600001)(229853002)(2616005)(956004)(76176011)(52116002)(52146003)(36916002)(23676004)(2486003)(11346002)(6666003)(7416002)(50466002)(65806001)(65956001)(66066001)(47776003)(74482002)(31686004)(106356001)(3846002)(81156014)(81166006)(8936002)(8676002)(77096007)(31696002)(58126008)(53936002)(8666007)(54906003)(26005)(6116002)(65826007)(16576012)(186003)(6246003)(64126003)(316002)(36756003)(16526019)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:AM4PR0202MB2769;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTRQUjAyMDJNQjI3Njk7MjM6K2YyQ1p6eUl5R2MxUkFwMmtiREo2TjRp?=
 =?utf-8?B?WWJhSEFnemNiam5jTTI0WXVwcGJnUTR5YVplS25uLzZyQnQwenY0bW1RdGRB?=
 =?utf-8?B?SnVkb29VZC9HTjVLcytOc2VwUWpXUzcyK3cvbEdVVzdmZ2c1QS8rRm5hbVY1?=
 =?utf-8?B?KzFKS1dxSFc5dHhQV0h0c1gwbW5Zc1VYRzhDdDVZR2g5T3dqempxM1hqVEZN?=
 =?utf-8?B?djd1ZnBvTlR2dTRyVWJ6a1lnaW1OSEoxdlVWblpPVWU4Um5oZkJlYmJ6VW1Q?=
 =?utf-8?B?M0lJa0JDZW5DVXlXcC9wV0g4YTFDWTRScGs3ZXRscWpQeGQ4QXBMeUxjaEZZ?=
 =?utf-8?B?UmZNTmJOSEtuYnJlRkNEdWRuSkhzS1JLMDdqUVJwQmpTM0NydkJ5dVExMVZt?=
 =?utf-8?B?a2FJbzZvWnBPNkFTWDZUSGk2OUhrekhhN3Q5cllVWDBDSXRhQzB0eDVCUkVw?=
 =?utf-8?B?QzlseUtkRTRiaWRnWm5BZ09na0I1L2J0MHVJVm5JTXV5RkhEZkJGS1EyZ1dL?=
 =?utf-8?B?b3lFcUtSMkxDMjFGSnBrVGtOOE96ZEhaU2piZUdKMnZZck9UNHo4R1hFUTIx?=
 =?utf-8?B?ZEd2amp0QnVxMHVENTlUdFlQK3hMWkp1MC9ZRjV3VzNOaGlmOWpLbHlVcEhk?=
 =?utf-8?B?RTlnSlN0UnRWSEl4Z0d0OWVZdTYwNjlwWndjdkl2M3BoVis3SGtlVVBTdnNO?=
 =?utf-8?B?VC9IajVpMHRNMGpTdTJZU1Z5dDhSbTZTd0ptTm0zQUlieDhTUHlCMGViSGw3?=
 =?utf-8?B?REZwYUtDcHNmMFdkcjVJMjdOMzlqNzAwK2ZhK1pRNDdWM0t0R0lHbjd3UDFq?=
 =?utf-8?B?VmhiU1Zka2dwNjBkK0NiTUFXdnJ3bzBEUWJTbXVRZ1d6N1FjbVZMU3FzbGVo?=
 =?utf-8?B?T3dOUzRQUkpUUlZ1RldSV3ZJMXZHazBXOU1rbk1RdC9MaC96QkhBR0RxU2Ny?=
 =?utf-8?B?K0QxRFM2MXJjclZMVHZHNVNvT3BiN0t2RytRMGdscDZUM0ZTRGpqa3FrL2NL?=
 =?utf-8?B?Mm1odFRUcWVWOXROdVloeXFWRTQrSEtrZ0JHdkpMQzJoc2VaN09KU1FTSkFm?=
 =?utf-8?B?RGloZDZKRFNFSlNkei9tRzZCT040ZUk5c2FZbmkySlNLaWpZc0Urb2dzOTZv?=
 =?utf-8?B?UFcvdzBKbHFKWlNwYVJSazQyY0lKblp6d2dWQ2ZPOW1zM0dsNGV5d29XV2Z0?=
 =?utf-8?B?QU1YWjhhVURONGhGRytaeXNKSjZYSGo4bUxzYUppcTFWdVpIN2ZtOU51WjU0?=
 =?utf-8?B?UGV1RVRsQVk2eXhaQ0RsOFRyRExsOHVOOTFOZXlmZWpjWHVRTCtEb3phUEw0?=
 =?utf-8?B?SlNFbUt1VXI0bVRNK2QwTDNCRDdXZmxyOXZ5UVQzalRhMUZMT3ZrVDVFQVA1?=
 =?utf-8?B?NGFUeWhnRmlBdDJVei92RFdJdlFGYWVqeStNYlR4ZUhnMlljTFZRUFZGUy8z?=
 =?utf-8?B?Qjk3eE55OTBTd0hPQkZhYW1xaFZBQU9aRXEwVTRJNnFpUTVlR1g0ZHduUEJU?=
 =?utf-8?B?Tnk2WkJlZDdKL0xLaDQrZFhSYzloNFd4WDdXYTRNdXljNmRmRWRLSDdsY3pP?=
 =?utf-8?B?YkVqTnVQK01rbjZuUldGb2l6WEM4SzVlZXVXQlN4R280ekNvblJaRHdEcCt3?=
 =?utf-8?B?RHc3Y2krK1hlelhNWXQ4VzVDdllab2RwYkMvUFpuVmFrd2gwaXRqZmR2ZjlF?=
 =?utf-8?B?QmlrL3ZlWWt5MHAxeFBWNDExVC9JekhiUnlqTmRPbkljeDVVNnRhQW82WHlV?=
 =?utf-8?B?Yi9JNWhTbm8vYXphYUoyTnJiS3NaTE5IeWNPVXhXTkVBYW1uRUFZbUpYczdr?=
 =?utf-8?B?SlVDbnQ5N2ZYZGJPZGhCMlYzVVNuQy9kQ0d0QlBDUnEwVVlNeVp3anVWc1FZ?=
 =?utf-8?B?TklRc1Z6aFF5QXhpczJPTDhzZURYNHdwV2h6Y2NBTGUwNGRNN1BIWENlekxN?=
 =?utf-8?B?dDFZTlBvZi9JYXlGVlg0TnR3RzJJOVJaNGlrZmgrZGZ5ejRmQ0oxc0xDWFp2?=
 =?utf-8?B?dEE4SldsdDA4WGdWWktlSmNveU1jUXF0RnBjOEcyRllSRHRGWk5SUzM0aDAv?=
 =?utf-8?B?K0pqcmFLdlB3UjVrZ3ExR1dJOGcxQ0E0SUJPV25BVEFZK2orWW80MmhyTWVJ?=
 =?utf-8?B?MDI4eFJPZkYrekZKdXdYMFoweWdsbkhJTkJ2YnV1OTdHa3Zkd1NEZmd0TzE0?=
 =?utf-8?B?em44Zlk2L2lrcU1pcUZacUlEU05meVE9PQ==?=
X-Microsoft-Antispam-Message-Info: DvZckpCpoM/26JYKbAnQTHkuAE0QkEDAvVYsJoAExdP383LbymodweKYF8O+vyG4xVhyXBGHpn2Kb9lMKADDyOiMmYeWAeUi7oyXJwvGXwWYRvxF1hZKkXVNnrxrR3nIRBhJZ0E6FKEUigPq27dteVyWfEpFohXXC2H9edrnq1KqcXk4QaShXSuwFnhdIrMA
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;6:s1Hz1Ap2FBhGXpnOTdpmJGP901WXAfu3g1zWkEZHDFLBN/itL2kZJIc+q/VWa3s9FOW+iz6yjxYJ1ClSTIVNyT/vTQdtaaE87hWxpPyYHTexG3jmlDgVaPAUclP65MQefv8lvQm0kH9kj7V74a80OlzakYU4l2qxr2YsKnWhoze6xT01W4wgw4Hj6P4TC5GQMeUr/U4rZkGMnlTShbmoqGhrvQzOGn6T0cEMcX8P4Ur+PR15Bfs1Q+iUeplYHIOiq15uqNNk6/aU/xLuM1/LKH3syyG5uy74QhJxiiop7r86PG5igUyh8Zi35MS++BTyEYD2ZFtgRBsbdvsMKvDpM9KLLYU4nqMtDqGutNe9hpMaHCIC5TJumkNyDrsEkAUpFAswc0KAao0ztiIBarcFjeNvHGtkHXG5xF2MCysIFD7tqi53+EyR3xBI0hePWZr4p88qNNtBuEmMngQZoEh89w==;5:0zzAlEp4aerqS7rCggNex5S/fD18AkZegNXCDQz056JMZgwvSm46bNmrLpxY75w0n7tCRAOtgYG+/+1+PGV2CRSt+lQstv3B5fqj8KzeCLefc1bwJVZX3QRlZjbJeZecyIOtQEBoGu29S+z1/gTiruHqzMKgHeZseBE3vh+UImQ=;24:SL3mttgXlI24GdfVcCqN9Mm4zkHcQquE8yMOsi3Z6Z5Gp6njlUbj4kCFo0nV//3EZC+yO1g58BQC3W3E6xPIvBNZU5qx1mbnlRPf4Txhdw8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;AM4PR0202MB2769;7:8LQEXeBLCcXYmlGEI8hWMwkK0+Mjlw4TW/tOIJfI3b78OH3mhmzBO7RaXGdIuO+Fp/tcv4zBypUcHIdHkxRgV46kBpX94KzgJFahozuC8livmUXrVcZh5ZIVINDDS2qYgKD9zFu75kFolDMziLD38Bs7BVEhV3BUBtd6FHnhVODQqMrOCTHCJg9GmL6OUB9jk3bcF91LROdWzsi2QoABCEG/1BWh6tuRzUupGENKuLtfKz8x2gBkXGpQINV5ro5e
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2018 07:42:44.1415 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5b7850-701c-4315-53e8-08d593b6544d
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0202MB2769
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386357743794195?=
X-GMAIL-MSGID: =?utf-8?q?1596075875151978420?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2018-03-24 15:03, Jonathan Cameron wrote:
> On Mon, 19 Mar 2018 18:02:46 +0100
> Peter Rosin <peda@axentia.se> wrote:
> 
>> If an ADC channel measures the midpoint of a voltage divider, the
>> interesting voltage is often the voltage over the full resistance.
>> E.g. if the full voltage it too big for the ADC to handle.
>> Likewise, if an ADC channel measures the voltage across a resistor,
>> the interesting value is often the current through the resistor.
>>
>> This driver solves both problems by allowing to linearly scale a channel
>> and by allowing changes to the type of the channel. Or both.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> A few comments inline, but basically the code looks fine, just questions
> around naming and bindings to answer.
> 
> Thanks,
> 
> Jonathan
> 

*snip*

>> +static int unit_converter_write_raw(struct iio_dev *indio_dev,
>> +				    struct iio_chan_spec const *chan,
>> +				    int val, int val2, long mask)
>> +{
>> +	struct unit_converter *uc = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		return iio_write_channel_raw(uc->parent, val);
> Talk me through the logic of having this...  Supporting a DAC?
> Bindings don't talk about that possibility...

There's no logic at all, and I don't need it. It's just leftovers,
should I remove it?

>> +	}
>> +
>> +	return -EINVAL;
>> +}
>> +

*snip*

>> +static int unit_converter_configure_channel(struct device *dev,
>> +					    struct unit_converter *uc,
>> +					    enum iio_chan_type type)
>> +{
>> +	struct iio_chan_spec *chan = &uc->chan;
>> +	struct iio_chan_spec const *pchan = uc->parent->channel;
>> +	int ret;
>> +
>> +	chan->indexed = 1;
>> +	chan->output = pchan->output;
>> +	chan->ext_info = uc->ext_info;
>> +
>> +	if (type == -1) {
>> +		ret = iio_get_channel_type(uc->parent, &type);
>> +		if (ret < 0) {
>> +			dev_err(dev, "failed to get parent channel type\n");
>> +			return ret;
>> +		}
>> +	}
>> +	chan->type = type;
>> +
>> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_RAW))
>> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_RAW);
> if the parent doesn't support RAW, is there a lot of point in carrying on?

Nope, better to error out I suppose. But I'm not familiar with channels
without RAW, what alternatives are there anyway?

>> +	if (iio_channel_has_info(pchan, IIO_CHAN_INFO_SCALE))
>> +		chan->info_mask_separate |= BIT(IIO_CHAN_INFO_SCALE);
>> +
>> +	if (iio_channel_has_available(pchan, IIO_CHAN_INFO_RAW))
>> +		chan->info_mask_separate_available |= BIT(IIO_CHAN_INFO_RAW);
>> +
>> +	chan->channel = 0;
>> +
>> +	return 0;
>> +}
