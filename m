Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968169AbeEXONN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 10:13:13 -0400
Received: from mail-ve1eur01on0095.outbound.protection.outlook.com ([104.47.1.95]:16079
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S967575AbeEXONK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 10:13:10 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH 1/2] i2c: ibm_iic: don't check number of messages in the
 driver
To: Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
References: <20180520065035.7920-1-wsa@the-dreams.de>
 <20180520065035.7920-2-wsa@the-dreams.de>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3d7ad796-bede-23b1-3bf9-9c48fb063f9e@axentia.se>
Date: Thu, 24 May 2018 16:13:01 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180520065035.7920-2-wsa@the-dreams.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0502CA0003.eurprd05.prod.outlook.com
 (2603:10a6:3:e3::13) To DB6PR0202MB2773.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::19)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;3:myUp8OF+KxqpqjYbFltW0Vg50x4DNj4F3lzV+L409puPT6PVppiEdXzMeIWh9fmg5BCwot5BzBMph2Ipny+Ioi+4Seau7HVwPeylmcalOHl3tuYgPwsK/9rIYEQ0YbJC2X1Z7TMMDbEtzd5GYBgHaWjneBVske0dlmBvQfe8JDXBjYKmyE18wG5glHGrNgcYIanqksJO3gkHK0wyEuE+5sJCqZDLSGJP+TqF8srjnkicMtFi6IVq2+s3KDZWt1ig;25:eCH23Qa0bFqeWohJ8qL8u51+QnkR31FXZq4nTmh56vSBZ2Y49HL+Ntf213Ph6Y9MLNLonJHdHb4uaAxBMx9iZ2SXjYsbs0ryuQAazcRXWS+4dgMN+/MIj+g/qxgq2i7ogxIe0ZoM+Ocf+5wT1tLKP63fUxo2jZbpqJWckQDIIKscA8RRlG/KlbV4V0RNasrsThAxguXNM2y+fHZyqSDSkFB+nrJ2CPhhJTvKCSjRiopnii+QlTol0PfaHoeE6XtkknQ12j3f0Z93fR76qBr+xY09lVmAw1Hb7WgjXf2sb4p/agji3gx1XLilYYsaBk6FW9+TQLlGy6k4mfQj4oD3Hw==;31:WArPflKvWcqzoToU8JnjljFxDVKy49MXO+WHVJZ6R2StnhVq/J0lhqqFbmsC4JPZiS7K+suBSedG6E5nk9YL/1uQYsliNPOh5V/rsAcOuWGJVTbI66PdurisN74oKlauyU9CX716UblFMLAJLyjfQzAL9jxLb4VgYZ1nxig1Fmhc/8UBT2FhvrEVFFRSbXY4ZEda+zw3NJsNQ4QhpJg1gEAddLwhWoiQr7YZhl9HsOY=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2773:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27730A1693FA757EBA3622A0BC6A0@DB6PR0202MB2773.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123562045)(20161123560045)(20161123558120)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:DB6PR0202MB2773;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2773;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;4:yXM/Phsak8U8pqTi7Vv8bA9R5gPu/opiPH98y84rIA9jN8LNzUX08TzEkYfy8lzv3zkmBjWHOWhuYjV4wXE9GmC53pv3tRwcvAODRRSjHyO5n0dDl7VoNCo7E/tNmcl1efCGdgd4b2tPYenBHd/Mdu9TYPjo2kZhxofywMkaA8QTQWA5xvvm7XwcS9gvGrMi+7KvgtCvApmaPYYx6aYW4SJFJwqU7kfwrfw8/rbTOnhaM4r9F4miLtG6EJ8AEfWxxe9YAr2Med8HP5aoo14+7A==
X-Forefront-PRVS: 0682FC00E8
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(979002)(6049001)(346002)(396003)(376002)(366004)(39830400003)(39380400002)(189003)(199004)(377424004)(117156002)(65826007)(2906002)(81156014)(81166006)(230700001)(31686004)(53936002)(52116002)(106356001)(8936002)(105586002)(76176011)(15650500001)(3846002)(77096007)(6116002)(186003)(16526019)(26005)(5660300001)(8676002)(478600001)(64126003)(68736007)(386003)(53546011)(74482002)(7736002)(11346002)(956004)(476003)(2616005)(4326008)(229853002)(446003)(58126008)(16576012)(316002)(305945005)(3260700006)(25786009)(97736004)(66066001)(36756003)(65956001)(65806001)(47776003)(6246003)(36916002)(50466002)(52146003)(23676004)(6666003)(86362001)(486006)(2486003)(6486002)(31696002)(42262002)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2773;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzM7MjM6cUsrbXlDaXIrUGM1Ky93MjlmeCt6REgw?=
 =?utf-8?B?QU9Fd252THdldjVSdHkxaHpjMnpiYW5pS3Uyekx3a0ZHUVFqS3lybHNUb0pG?=
 =?utf-8?B?TE50S1NDTnpjWDAwcDhpSndnN0Zmc3cyNGJwbFRsMmU5dnRzdzRSRFNOL3k1?=
 =?utf-8?B?UzZWdGRwYi92Y3JDdVJOYUZ0Unk5b0FRUVVyWVBoWUJWY3V5L0xZUWRlY2tl?=
 =?utf-8?B?eFIwQ3lEWHd6cUtESzdMbzZ0UkpyYVMyTXlJYUJ0VjhRcURlWEtqdldxTTJX?=
 =?utf-8?B?ZGJrYmt6MjlXeXlwR3ovWmtCVy9RVzNsSlBOT0krYUFZNUZZTjBtNFA3SEZN?=
 =?utf-8?B?VWFNRnVnS1hhQ04ybS82NkMwSEM0QmMwQVZGTzBsYmE2blpsQmdiTTVpSnFF?=
 =?utf-8?B?U2JIdG1VbW4weUVnM2wra21rM3IwYWlDbGY5TmtBTHk4ZFlHbFNycDRGT2tZ?=
 =?utf-8?B?Rnd2Rmw4OFBZUkRjN2hvMG1tTlVqWTBaay9Uak93VU1wY1U0eDhJcVdGT1dD?=
 =?utf-8?B?L0ZGYVI5L3RtcHQ3M0tjZ2g3V1l6KzJJNGJFYS9mMHNkRVk1aVBHTjZsM2Jp?=
 =?utf-8?B?enlQdnhwV0VaY3NOMWxjWkRZOFRkQXRNSUdid1ZTTURWcmppekF5cFRzNTQx?=
 =?utf-8?B?cXdRcEFiQUo3MDMyR2hnSW5IM05kc0JmUGg4ajhlbktQVnVSZGN4R3E1NVgw?=
 =?utf-8?B?ek1kTFN4REx6YWUzQU5mRUZZSGxnbk5tRm5zWTV3NjBCQWw3dC83NEUzdyti?=
 =?utf-8?B?OTA2NUE1ZEhlZWdvaW5sTVc2UkY2OVZzTWhNVDRJYXdwcytzRG8zTTVOamFl?=
 =?utf-8?B?Nk56QzBBaFNTbGlzVzhnRzdNZ0t2N2kyVjhWOGVKd1ZiejJoU21CQWsvZnAz?=
 =?utf-8?B?SU9nMzhmKzJhVnVlVSswOWNsejV3OFVGbG5ZQ0VVZEpEN3BXRHloTG9PLy9x?=
 =?utf-8?B?SzMxQW1sQkVnYk9mL2tsa0JjM25QNmJHdXZ2Y1h1MU1lVGtiYzQyazZnOXZ4?=
 =?utf-8?B?d1FqbjhIN3lHNDN2WHE1Yll5WGU2bW9aS2NKL2J4K2xrcVlTUU5nUkUxaEVM?=
 =?utf-8?B?Mm5iTkZKNWc0VGRNTFZoT0JtcTdGUGxZcGgvN0ZzVU8rUTJyKzVIV3k1ejZB?=
 =?utf-8?B?bHFCREdPaitpeGZsTERDYTJMZFI5VXpGbm8yZXh6UGhCYVlJa0VIMUpRK3VC?=
 =?utf-8?B?WC9jVzRlRzlTMGRXQ0UvT0FVcGJDYnVINS9kRHljcHNLeGxISDMvZzBoUm9E?=
 =?utf-8?B?UHplNWJ4YUJWcDVVZkF2TXk4amttRTJocUJ4Nm5iU1o5QzRXSytHbS94bjNR?=
 =?utf-8?B?WGV2d2ZPcWswS1RoR0dUZXpuZ2xabTBTdmhGWXVBMExWQncrdHloSUoyYlBm?=
 =?utf-8?B?LzllU3JYbzVscGNKdlROMkRDcVV0eWp2OE9GNm1SSGt5cHhxR1lGYXZYSUNp?=
 =?utf-8?B?V20yS3dQR01ZR0lXd2k4MUVlWkhYaW9IYk5Gc1VpVjNIUUFiRlA5R1ZGMmph?=
 =?utf-8?B?MDQrTGNBU1pVRmxmTU5MclRqK3Z0ZzluYnpYRUtXZ3dXSnE0T0ZhN21mWmlC?=
 =?utf-8?B?cHZZaTEzc1Q5SUNNcVFud1hEbU5Na09GeWVtaDhHRFhzSk5ydjBuMTlscDlq?=
 =?utf-8?B?WkhkeExrZ1ByZm1Kc0U1SW1iRmIrWGY3LzRCSGprN2I4Mm5VRE5KWHFKKy94?=
 =?utf-8?B?L1NLUUEwWGZGQmIrSlEyVXlBTlMzc0FhRThweUUvVDNWdHRQNTMxSmxsT25u?=
 =?utf-8?B?eFd0UERpNVFZSVNlSWVCMThBVzJqcWZROFhnNElvQmtxTGJ6NGxyYlZpazNw?=
 =?utf-8?B?cVNzOFZBRWNKTmkrSWFnVUkyVHVENzluV0NHOU05UzI4VXFYVXdIRzQrY2V3?=
 =?utf-8?B?NGc5TS9jRzFBWjFCVmxGcTR3SUZmTjdMNlozTHdteEtYUGJRUGxpZlh2Ynk4?=
 =?utf-8?B?R3QzTzEwWmpwSEFIZnhoKzBrNG1pUm80TXBLVDk4U0RXMHp0M0JmV2NJb0E1?=
 =?utf-8?B?Q2VDcDVCQUlzNThrV1JONUpoeEtweDVvWmlUOC9nVldsNXZpdWpOYzZicmsr?=
 =?utf-8?B?bTVBenZjL0FVa2g3ajlqTVAxVHdmbW1PWFpZeVN4bk4yYmkvTmpHM2VqYmZl?=
 =?utf-8?B?bGFIM3BIWW4xV2RjZ1BlUnBVclRKbVFYRGpFaG4wbXFnZFJkNVBYd2w1Z2Jq?=
 =?utf-8?B?cERWL3YwczZLcjFCdjVwUEQzUHpEYjM0WEdibmJDYkxlNGpIS2FkU3d4N01U?=
 =?utf-8?Q?homX0JbFyhzBL4dZi0Zn?=
X-Microsoft-Antispam-Message-Info: XFHMAEgnuCrjzIWX45Aks3rm36aUsnKAmR+h6MbdA+Od3m4R5Pe3z+PtATbK5e7+ex8BLM6WoAt9rpBhRdD+YTVJg0Yo86uIbQVaVPvjbq3m8a9a9HrvGXRUSB7brB4rWjUqvPsh4LGL+UAwzBPZyFXbHlulPk58+Nrp6YbAfcuV2zy0rWdOhaonZHkQFXQG
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;6:cKee6W88yLLEMSAc5gscIoCnZWrBz8SqrPxPIjsFgagixd56l0kqX5AXSKuZ4/jbFJXO4hOeM780TBbGwxma4LocdHk0jGt7SVUsDEgjGVGSSqExhFmc3/toZZwSb85eTn4Brf4ILfzLTKF2SR+eetaKiRoI4MT5BBNeOv6O06bLmvqb7RUhfy9z5TjWeQ6Zls55qqVlHhLOyqDUlcrjP5XCrJ3YDXnOH9YWUVBD4/AwWkqAhAgNrGkvY2PjAAYM/FlBEulLKxGSJBC3Fzk/EGkgST6L3JesHhHVfuLAep23ro3NlKspLXSP2K9c/Pfzs/eg2+y6quDRpmw5zIHfBVlBVuaE1GymK4n8X77kZzaOYcCKZvnxUVuCJmIEwjXfMELYxm9n16Wd3kukBthY5DzkmEPIP2JtlXBkzbUSuWraqm8408FHCf1Ez37BDuLIbpcVr/W3PH63FBMZdpaIlQ==;5:q1draVzUiOBJTkkXWkPGeBXKFjLt99Ma2F9gV9pypcOrzdUZrWImS8a0wsFEwnwAHEBsCNDSrdXeuuuhZzhsGIRB5M0W7uh3ZzJSSBPELzdjtG4J1r8vPGg96xYbVE09AAkNXqlACFE3U937HTgmx/BvBh45eS3ccSU+4FpEoGE=;24:SnNsu/KVXPzF9NbOlJlvJwS6hY25qvqJDMqUAR9US/HUvPLX2mKqpW6V9nDkIx4a9jkZ6y59M+/ur/HZ6V0jdEt6NjCi6ml/0bXhsBwC5TY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2773;7:Sx+oTEP9xaRRJ6gxYzkojcEnOhKe+UCfhTjmsHsOReuOeNHTn88hAKGpNGhr5+ao+muYDATnb9gxGEhqr23j1X4X1B+FwoKo0QNogEzuKqf1l2ZxWxlshiMdf3n/XyHsNKFE+wURQZUhYiPAzHkTF9Wdr5leLpQp+2cjhD28k8RFSgoX1etPreoK5jHpThuO2OO2mrXqmx6hdNpP8AJbmd1BhOO9HemBAsgg/N61C3B0TBnJkZu0F0MpBnbBYMRF
X-MS-Office365-Filtering-Correlation-Id: 29a2f788-b0fb-48b4-4a70-08d5c18078ae
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2018 14:13:06.4018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29a2f788-b0fb-48b4-4a70-08d5c18078ae
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2773
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-20 08:50, Wolfram Sang wrote:
> Since commit 1eace8344c02 ("i2c: add param sanity check to
> i2c_transfer()"), the I2C core does this check now. We can remove it
> from drivers.

Reviewed-by: Peter Rosin <peda@axentia.se>

> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
> 
> Only build tested.
> 
>  drivers/i2c/busses/i2c-ibm_iic.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/i2c/busses/i2c-ibm_iic.c b/drivers/i2c/busses/i2c-ibm_iic.c
> index 961c5f42d956..6f6e1dfe7cce 100644
> --- a/drivers/i2c/busses/i2c-ibm_iic.c
> +++ b/drivers/i2c/busses/i2c-ibm_iic.c
> @@ -561,9 +561,6 @@ static int iic_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs, int num)
>  
>  	DBG2("%d: iic_xfer, %d msg(s)\n", dev->idx, num);
>  
> -	if (!num)
> -		return 0;
> -
>  	/* Check the sanity of the passed messages.
>  	 * Uhh, generic i2c layer is more suitable place for such code...
>  	 */
> 
