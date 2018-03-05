Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeCEQG6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 11:06:58 -0500
Received: from mail-eopbgr00128.outbound.protection.outlook.com ([40.107.0.128]:26256
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751395AbeCEQGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 11:06:53 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [RFC PATCH 1/2] i2c: add i2c_get_device_id() to get the standard
 i2c device id
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Adrian Fiergolski <adrian.fiergolski@cern.ch>,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180122113657.32094-1-peda@axentia.se>
 <20180122113657.32094-2-peda@axentia.se>
 <20180305155111.ihlt4hn4yz3igo3z@ninjato>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <b624a0c7-ffe2-245b-ff9e-ca9d10063715@axentia.se>
Date: Mon, 5 Mar 2018 17:06:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305155111.ihlt4hn4yz3igo3z@ninjato>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: AM4PR0202CA0010.eurprd02.prod.outlook.com
 (2603:10a6:200:89::20) To HE1PR0202MB2780.eurprd02.prod.outlook.com
 (2603:10a6:3:e8::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bd416732-d3bf-44fa-e7de-08d582b31afc
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4604075)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603307)(7153060)(7193020);SRVR:HE1PR0202MB2780;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;3:7iRvPpHXkBp/C49K0+6B15+iIPTl2dMDghUpn1GZmBks61thn/OO7LyYb2E4cfS0PH2S3sPC/PX2x3cMRkv2vTsDHHLJbqYKUCjFy4vLDWEHhMmPaqxtgtOySkv7rfWaSVS/pW6ulW5npSXlm9mymORb3N8Mns81mRV8xCAg5XR8VCwNM4c7n78h2PKSTBJqY1+bc+974wTzu4ZjTa8/pLuCNVQMRqzCe3BGN3XjulPpnpvuskTK0LI4G0Nb8vfN;25:Zie9BQfqpQ6onpaBfEcRTnT+6n9huEmKSthJFUf25J7W4bLWZnB0sbD+qUCrlJZRXkwym9H0N5GVM+yJUVgMTlJMkNOJlh/DFZ8UBBCXdzkA3vs4jWSQ5VwvHyjCTmL8COHr1rVX5TqqhTDSQ+26i+z4TgrE9+z1z2WCZ6nqsQNJrBuceJIA9j9duAB+TU46c3WgEe2erh5CEXt/Hgdded0I6x+u5eyMs62rS9PcVieZKVmjMXaQ3qtKUWsVTDM26lz1ZtiJU7qfny836z3YWtDB/xJ7oYXVfwCPC81IxiD6FUt3ZLxq4/btzWUIyJg+38jCWl66ln+GWRmemzqWyw==;31:lw8qyWgaOl6GpUc8mDkeMDaH+DbNJokah/0XJJzC4g6rYd8/otSrFUHv4WWc3UHJtKAFKjaviuCjMz6VX7ctGW2BBmFI4R8gbW3xtTcXeX+oPt4Kxrh2p6X41XSgmumTgY/eJZKQ2VQbmxV7flDkiw9LcgNgFyPIGnUX+KeIZGhN/yrT+uKxZvnxQjYzp0433kzY43Hngjm21dLLRlmsR2H0Rt43uiU4y3/P9Uad+Iw=
X-MS-TrafficTypeDiagnostic: HE1PR0202MB2780:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;20:w7GEdX7odS/6ZqlwjNyn9oYFYye6J8gY+G+D6kxImDhELh7dwYbDO3arejwK5FPTA6wOEmDqt9Oux1hHJ0t2yQtFxxNgh3qND8AI9vqxHSpKTr2myluaWV0jYIIrrPzRYXPHixWd5WAuqkNEsaJyj8AAiDpSj2o1Q9Xqbrv8nOo=;4:Xi02AOElcH6ac3yYN1XLUeJrbxxS98ivoG5ix5BCR7uop9PhBu8qR8p5LkQKD/cxuEv8X61xFG1p6R6V/cCzbn2mEZxSfz3f+4DsQgkbyHo2y7WhvjfDXEfpyFWkORQzTnFhzY+AZkRif4dSd0IHuNbwc7hnbln7LR8oI6xb76AdY/CKN5aVESLad/7VuMtZE8to3j3waAVNhv885tPznQezL2fta79kBgBTG8E2VR/Y3ySjlWdi70sgTBPkIlCrDltYHSZo5xuAm+Kr5TPWBQ==
X-Microsoft-Antispam-PRVS: <HE1PR0202MB2780C1A9E98740D78E1B36DFBCDA0@HE1PR0202MB2780.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231220)(944501244)(52105095)(3002001)(6041288)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(2016111802025)(6072148)(6043046)(201708071742011);SRVR:HE1PR0202MB2780;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0202MB2780;
X-Forefront-PRVS: 06022AA85F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(376002)(39380400002)(396003)(346002)(39830400003)(199004)(189003)(377424004)(97736004)(81166006)(4326008)(5660300001)(81156014)(8676002)(23746002)(53546011)(386003)(31696002)(65826007)(31686004)(229853002)(68736007)(59450400001)(8936002)(6666003)(6916009)(2950100002)(105586002)(6246003)(316002)(53936002)(64126003)(86362001)(7736002)(305945005)(50466002)(25786009)(3260700006)(58126008)(2906002)(77096007)(16526019)(186003)(26005)(74482002)(36756003)(36916002)(47776003)(76176011)(6486002)(478600001)(15760500003)(230700001)(3846002)(52116002)(66066001)(106356001)(65956001)(6116002)(65806001)(117156002)(16576012)(15583001)(217873001)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0202MB2780;H:[192.168.13.3];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;HE1PR0202MB2780;23:nfJLkPyLs78rmNiLfZiG3ZMKD1tO80fsxGq?=
 =?Windows-1252?Q?pfjJJ06mWiAgK7/pl1NDb2BBXtVmbbyYGoUdDjkw9j8NRffJUENtBG/Q?=
 =?Windows-1252?Q?7VJ6WMEt6xMOlqJx47wQC85U7pc1iWxU7pZwxZOoLZQUU+B35Nm7kwEV?=
 =?Windows-1252?Q?SYMPt8abaJevr4NyB8DcFRgxt1PmNXlUK+KpD6Zjn1OpQ33DvsXB44US?=
 =?Windows-1252?Q?IsL2yN4gqtHjsbNlPRVHolyn/Ely3qKp/vOZFnYK8awqqEf2SfVRAcD4?=
 =?Windows-1252?Q?HsLNkMdEN+unxK0dS7xorGvXNDAGiYB16AYOGxEtrkfPfHkUJHwOdDvq?=
 =?Windows-1252?Q?8NiO2PjMOLnksWEk6I3n1EXoXkDxjfwW5RqrqgaOW8Ah7oTi49T6kPFl?=
 =?Windows-1252?Q?LBdmgVv8KqjUgD4LlEd+c0b/kNJwZiTGErHPRSoJH1sYErXBE/G02CQx?=
 =?Windows-1252?Q?oeTyuoCFfmIsQ05fUUpIaqs/zttlVbVFxc61RT+2MDX+BD46EagJtmLe?=
 =?Windows-1252?Q?QVyFqAOnQDpantBNmf/uzbRS1GHuyut8SJKu8hxu2bkkaMmlWyo3/D5/?=
 =?Windows-1252?Q?vjE1gZfppfHFfupiP+90GCHMibpc0ExRBE6uliaZe1nmNXLC9XwsIosP?=
 =?Windows-1252?Q?AgValfJibVTmmsZhv7JaZTTEMcEwVtYb7U/fcVM6SkyA1840UIwOn+pY?=
 =?Windows-1252?Q?REmK+E6nTWLojErV4uzp0LvVuCND+1U/NIqmLdfvL2L/sCQZMJLW2tMi?=
 =?Windows-1252?Q?rTYz0Fw+NYFBaklHBoDTIIo71FTP5G9SzPdt1yKXHF86U0TQ0gX4RGVP?=
 =?Windows-1252?Q?P9ocu1Yfr/yehQkCXKW5vxfuAwP39P+h72obv4UiUu4k7HFTEJ/T1mTt?=
 =?Windows-1252?Q?Netjbu0jyT6PF0LFHJGEgV7XZiqTU+24ih1IaOi7kweSKUmKG/shR0Ml?=
 =?Windows-1252?Q?o5Nn0BcSPNQpNm6q4pSWcAqS1KeowP2g4DHD5kxniJN/ctoiGCESJEin?=
 =?Windows-1252?Q?BKDNKiGqAgzlxop3WVF0VaWOm0OSF0CqqVEKSuqpUHN5s5b7LOB0poh6?=
 =?Windows-1252?Q?YLVuLN3H1JxjslRjawh9kra0sKypmAEn0XJrnLhNFc/plywDsTnJG+cG?=
 =?Windows-1252?Q?pw2jUlqcNcmKfEgCh2Ke2Badls65dQY0bI/7Y1RwaokERStWogaTL4y8?=
 =?Windows-1252?Q?Zj7N08uHXUkOx2q9BznTezEr/Zo6/Hf2g/oXycmEodTiiiGpgSn14AK4?=
 =?Windows-1252?Q?R/VFUUgu8rYDZ+L2m+xFcZ+Knbo11R6OnpgV04kpXfGowmnObSmsP9SP?=
 =?Windows-1252?Q?gJFD4wlkcmxzoXNY+S0ujDG/cMABPKGf+OkAP2rEdJn5+++OvNfdsXtW?=
 =?Windows-1252?Q?LidEbAi7BUb1d8upE+OiCyK4vdPEuVCce2FikAxm79oE7Q2QgVDI6k3n?=
 =?Windows-1252?Q?Q0IYymBiCg89J4UFMW6INWTeiIwcnLpRQsufZa+bsvjKxUIT7qLdf1+e?=
 =?Windows-1252?Q?PWxUpHhFltb94oZd5XqJcMrt9sst1OzrJQgWgp/L5G+KbqBtbr+pwTLe?=
 =?Windows-1252?Q?Drf/jJmESnwhTc4fyiRWs1OiT0G2pGxEy+M/gfJnSLLEc6gdhTWUpg0I?=
 =?Windows-1252?Q?TwQU5WGwP0XT+u1mxDh5NZlnvGpQm3DfK6NBY/5nRJrFc?=
X-Microsoft-Antispam-Message-Info: JkfWw0Lg32VTXy33gqOkoBJIXkaoJBR4iZijhXvYlzyk+ME02CQmZ5PJ0oUmbjt42UT8UvstQlR1GeHtdBpncKaR5sHN4HUl2LECnR8Tih46UVszKT71E2G8T58mECbVFrTGMdvUQhyyY4sX0HwIB/GpG0wvzxd8pRn0xDwcJr+tlPeP7/9PLx8Y1Q/Z9NNS
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0202MB2780;6:IM8xTD+sYbLJZJuPJCJV7kIjlbEMvuH+u2NfSJln3vd4nHNJty74jX5r6yotnF7UM5nllC1NG9TXpdrQpMmOeN+4nrXIH1XQVjnyJVxhF5X+157LwNLweMP7Q1RI3zIGLepzoYHp98KKmbvH4lj6Uaicf2CaOLiEoj4nDJ7ah20YrS0qAGlhXkNU+gmLJzt1F4nkvdjKoOO8kNWxcNbipL2Nn349eJ3li3WtEm2408dmzjKQCn2P19m9zBJsRNd8jS2K7krSlK0kTLNjB2+H5w4fwVLLcapHo1TwL8z3XIDu4EHmqQRVftozFngjvA6Q/eRPzcijYvVttAvRO7NVl7HTOB2Ze87bUinuQZyaz7o=;5:AkZ9lNDjvGg/0rcM9siLeQfK53psWMlsPfqitwKEGnID6lvuiiqvykRVbUHid0VkQQI2ukJ4lORt/T0XkzFKFvMZfdf1uDSFzEzTkU4pQP1RMzUpG+4bR1CYx/+jjWeRnUrjuFE+v/lFMo1faaw9wQaHPyoO0TlTEBXFcoi+uuo=;24:3k9grz1+iub/3+V/8UJiY0jM7Fz0vKqXHWIV5XgcEn40ZBg47FCY408tyqx2RU2oZgOAaPn3crR6x4z178TxTxGaWb6j7j2H9qn+ujQnz+k=;7:J80vHT9fZqraSRZvrAMjIx4t2cQt+BZWiXzWUHvXS/kP/0vHkAnMR+uOM7oQrdvH6PxBTXA8FzQ6jT+ROo/w7SUZwxkKUxpMCiYsq+rXbFVfZBD3KHqiWIozu54KpBZQcr1pvcSZTJjolbl8pMkRVy8q72AUfR6HzBF1KAoetX3vpBVkif9eqN1GiH/U9toObdBy55kSi+tdqpHTnMqI+XrnKATyHxm8sDeupYQUsPOKuFA1NruZ7WJOmARKA/HA
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2018 16:06:50.2425 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd416732-d3bf-44fa-e7de-08d582b31afc
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0202MB2780
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-03-05 16:51, Wolfram Sang wrote:
> On Mon, Jan 22, 2018 at 12:36:56PM +0100, Peter Rosin wrote:
>> Can be used during probe to double check that the probed device is
>> what is expected.
>>
>> Loosely based on code from Adrian Fiergolski <adrian.fiergolski@cern.ch>.
>>
>> Signed-off-by: Peter Rosin <peda@axentia.se>
> 
> In general, nice! I wanted to have such a function in the core but never
> had a device to test it with. So, much appreciated.
> 
> Looks mostly good, except...
> 
>> +	ret = i2c_smbus_xfer(adap, I2C_ADDR_DEVICE_ID, client->flags,
> 
> We shouldn't pass the flag of the clients (like PEC) here. I'd think it
> could be plain 0 but please double-check.

Right,
..._TEN should definitely be cleared.
..._SLAVE will probably be cleared anyway.
..._HOST_NOTIFY, ..._WAKE and ..._SCCB I don't know about?

Are there others? The bits aren't that densely populated which makes
me worry that I'm missing something...

Cheers,
Peter

>> +/**
>> + * struct i2c_device_identity - i2c client device identification
>> + * @manufacturer_id: 0 - 4095, database maintained by NXP
>> + * @part_id: 0 - 511, according to manufacturer
>> + * @die_revision: 0 - 7, according to manufacturer
>> + */
> 
> All is nicely documented, very good!
> 
> About the upstreaming procedure: Could you just make a seperate
> pull-request out of this feature? I'll pull that in to have it in my
> tree and you can still collect patches in your usual for-next branch.
> 
> When the above is fixed you can add my:
> 
> Reviewed-by: Wolfram Sang <wsa@the-dreams.de>
> 
