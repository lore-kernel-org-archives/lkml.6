Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751327AbeEEK3I (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 06:29:08 -0400
Received: from mail-he1eur01on0098.outbound.protection.outlook.com ([104.47.0.98]:4934
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750821AbeEEK3F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 06:29:05 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525484596-5585-1-git-send-email-wang6495@umn.edu>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <63ff0aae-9a34-9c6a-625d-7b07b7da9ed3@axentia.se>
Date: Sat, 5 May 2018 12:28:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525484596-5585-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: CWLP265CA0179.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:4d::23) To DB6PR0202MB2774.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;3:lxbJmjBKLcmi2lfY0UxUTPgP3MNlH0a0mXSLZvSckNwxHeJjzUtgEGFln/GQPdn2gv3XWQaiqSsCT4U1jViGUVjaOx5rU2DGMGjYObtg68leyPIGc80RRhoo63obTzKSaCxxTkRC22HyjQvz66ku36ff7TinrUNVUzfRFI4Nhgz8+30sx7Ui3WmsDbjU+jCA0N70HVtdnjxSU6UzQh361FeTuo2ngEWZqMQpIf2tvC99pKCjBghDxAw/7cpiYKdF;25:g8cBqRXz4LQnu/tgls1zVZko42zb8XuWoVkEnTkbwwaeUCwTvloC68BQhnjxlV1Rdh7NRph8ikOKa/Rvm+UngVjwalE/9jq31TwCljhl5aibeEpO5f+BkFI9rfjCZUR/0waIsOztNeG0LENDKaLMRg3mGb5rQnW/20kw3DRfrg58XgnKOw0u1nwChDL3dr1iYzlZ9KKlsAxOqAYnlPc+KQxR3PSZnrziOxQ7dkAXzJjhi9qazy5H5mt0sOor3RX9WvR6pu2FoV04brY+5uENPHe8C+4uPjwyTuBmEofkhti+gKVHfB9/xQOMymCJEdC3dkOZEmWCjqs1a+IIPP/dTg==;31:6iHFVo+vclZ4weK9CEHZQqIUJVd6nuSnd+ihTJ9qupL0NziD5kIt6J1UEgEskR4PKXhfuzFf8Gh2P0H0UzXrU+LpewDEDiO1pJ1pRrZqfM0SD9bNxyeATucwNgJa/LkEtUijqwqsFGthupMb1uD7Ha7/LyyUjZ7bcpHTHcq1TeQGfKvi6JZUamksYotddfKboRtYfWy/IH2Hjnpgk96nCyRTJ4jyhChtlrqNsPQiHGM=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2774:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB277414176693D4D6C3501BBFBC850@DB6PR0202MB2774.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(8104003914727);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(6041310)(20161123562045)(20161123560045)(2016111802025)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2774;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2774;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;4:oSlo1bQ56CqGqzjzo1qN4CSIHeMevSxLUTR4qQZptorq4mskWs7g3CCWoINhB4c8aqcGFfPAzecscvRu6hm9GCRXEDWD4m1R9fSJiVcCGPGX7cN2aTLIzHZO2jIOGN945XKf90ln9MesFc9KN4Fiud/Sm0zDLY2gTMYzeIXYKeG9xVxEMDnUKxgtJRuuivEj85I7f77/yY5n+r1LPSw4nAutVK5jaYl55mKO+qxhOeWEVkv1ciKNaICnYXYjodxodd+hRvOpi0Fqv0gbNr/M3omfFgl6QIWsBPcwiJII6jpe4Cxgk4NyVqCxWMvRLcrNrC3tVeCDLw+WT4LBsM7E8g==
X-Forefront-PRVS: 0663390E1B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(39380400002)(396003)(376002)(39830400003)(199004)(189003)(377424004)(59450400001)(53546011)(16526019)(77096007)(5660300001)(6916009)(386003)(66066001)(6666003)(65956001)(65806001)(26005)(76176011)(65826007)(68736007)(86362001)(229853002)(64126003)(117156002)(3260700006)(7736002)(25786009)(8676002)(305945005)(36756003)(23676004)(36916002)(52116002)(2486003)(3846002)(6116002)(52146003)(2906002)(230700001)(476003)(11346002)(74482002)(2171002)(6246003)(31686004)(53936002)(81166006)(8936002)(956004)(2616005)(486006)(16576012)(4326008)(186003)(97736004)(58126008)(31696002)(446003)(50466002)(54906003)(478600001)(105586002)(316002)(6486002)(106356001)(47776003)(81156014)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2774;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzQ7MjM6UWNVVmFBbW82WXljVnp1SFNzOCtuQkpS?=
 =?utf-8?B?TnpmcFFUejl4MEpiUVF0UEYwL2JhZG5PcUsvOTBwNWwyWXhoV3M4eGNKbm84?=
 =?utf-8?B?SlNjNjJweG90WWxMMTFucm1LQWVEc2JwSklWQXg0eFNsUkxudHlIeVNSWWhk?=
 =?utf-8?B?NUxId2t4NnorNnZZdlhaSzY4U1ozcDRkdTFMcUpWemFjVWRqRG5DZXhETkRz?=
 =?utf-8?B?SG1ScWRoOGFCRFR6bk00Y09vWk42WWhQMGxXT1hMcit4ZmFvRnhkWmtWWnlE?=
 =?utf-8?B?em05NnBPdVFtRFlETzIzZ2RJRWdSRVd1MWMwdU5QVm10RUxwM2liOWJ0YndX?=
 =?utf-8?B?SVk0cThoTDNXV3FDek1SVzJEVFhIM2pJQ0tHNkJPMlEvQWZ2eHBtSHdjYitx?=
 =?utf-8?B?WVFpUFdwdVRoSWZOOVdwVi8yRk1tY2VwQjZvWmlIV0lnTlNkSTdyaW9mc0k1?=
 =?utf-8?B?eFpwZGtxTWdIQUFjcHc1bE5ZU1huSVQ2UkZQUUM3N2h6clp2SmJWVDJydTgz?=
 =?utf-8?B?a1JPdGh5UDF2RFdIeTBjWW9GRDhiMHo2VFY5bHJkeEM3KzRNTEhqY1RYTzFj?=
 =?utf-8?B?MVVFNUhiYjg1R3lNbXprdlBaN3BpT2NzVGpHNVJHQ3NOUjVaUWFBOVloNEFo?=
 =?utf-8?B?Nm95dmtKM3FvTXVJcGJuWmNpSVlGbTF6Vm5aeVg1bmh5Z1J4ZTE1ZmZZMFdR?=
 =?utf-8?B?NVZUeFlqNURQWk83YlpSZVdNcFBBVlBKQmxNb0tsQmVlY0lGcU83VXNVWlh1?=
 =?utf-8?B?cS9Ia0swS1ZmR0FEdnBPa0k4cVNwVEovL0VRblB1SWFmOHZKdlFBYlY0ODYz?=
 =?utf-8?B?NDJybkNQMEY5akVJUytBZDJYWGhvNXN5d2lBUE5EWHhoU1VzSHhNNG5ON3E3?=
 =?utf-8?B?dk9Xa1pLVlZEa2tRSHNXK3NPK0drLzM3Z0pSWlh2SFRzWmttc3A4L1BKUWVD?=
 =?utf-8?B?SXp0YzRPZlBXM3JIdzc4cHJFRGFTY2Z0UUxiVkZDK3p3ZFBwY0psZjNrcGZj?=
 =?utf-8?B?V2s0elhCV2cxWk5JeUpvL0lEOHNNcnBSZ0tQdnVLT0VWeEsvNUxkb0R3RnhC?=
 =?utf-8?B?YjVqZSs1aUV0VUF0dnZ2U2tqQVBoQk94MzViSm55alFOdU1ZV3NhQzJLNlp3?=
 =?utf-8?B?SEtoQnJmdk1QT3YrRG5GbDZpcGtGNHJzZExyWnlqV2lXWmhXQURDNHNNaERa?=
 =?utf-8?B?THNIWkd5Y3RsazdXVnNITnQ4QXR1aWlmWUl1U3FKdUFVeTlNRmhlSm9mQXNP?=
 =?utf-8?B?R1dBSkYvL2VrN0x4eWtEM1FzdzhWSWhTdi9yVlJ6d0wraVphUmNabXZuRlJr?=
 =?utf-8?B?VmlTRXlwT0VNZGtHQ3o1UkIzTzhhSXpoS0daZWE1THdWNVRZaW4vcUc0WERt?=
 =?utf-8?B?UWo1aEU2aG9tWXA2Wjc3V2VjNW5PRzgrTFhySmNsOEJYNVRPYW1MRDlkQ3BX?=
 =?utf-8?B?NlZXZDkrZUtMZDFBSURVMExXYUJpL3c3eHFMMjFsbEdGNmFKc3dYV0NYbzkx?=
 =?utf-8?B?WTlpWlRPU0ZlM29aYTdiSlJyMFdlOVhvT0FsUEhScVJKWkRvRk1pbXFnSDU2?=
 =?utf-8?B?aVZaVnhRL1dSaG9mejR6Q24vbGpGMUNRdkU4SVJyZSt6bUI2Z1UxcCtTdnBH?=
 =?utf-8?B?NnNQb3pPMm9XcGpaTUhJU1JVclRaQUhtRC9aNVMweDJZRy9QMTlWbWs2RGpS?=
 =?utf-8?B?OUtnc2o3cVdVTUxzSkc0dVhsQzRiRVJEQW1lcWZCY2ZjaTcxeDVESGpHalYw?=
 =?utf-8?B?ajFBQWtCdXJRaW1mV3JKR1BhUEV2ckg2cjJyQlp5L0lhWFBKS3hOcEl6bTA3?=
 =?utf-8?B?NmxlNDhLaWpzUEVYcUdoVUNXS0Z6Z3Y5YWRFT1BGVjQ4cTRNRWFmbGFJYTJn?=
 =?utf-8?B?d0M1ZnFBOEU1bSsvQWMraHRwWm9GQXdpcnhhYTNQSm1XbkVHWnQ5Vm5xOHNE?=
 =?utf-8?B?dXYrWTh4bjZON1BCT1dnN3VJenZoeDhTWFlLY1dPSnY5TkhKb1RyZkVBUGhE?=
 =?utf-8?B?NGs1dWZBUUVEeXZ6YkVudXNXTWVlV3FqbkxzWi9xZHJOYTEzU0VjZUtrSFhn?=
 =?utf-8?B?bVRBejVCZnRId3dtU1BZTEVNak5ibVlrR0NHRmVXUVpCd1U4MENKT0IrRXBZ?=
 =?utf-8?B?bjdyYktSZ2NXYkV4aDY4cVVuUHdXQnd1emxONTNqMFZzdUZwdzZGWVhEblFK?=
 =?utf-8?B?MVRKQVFGdzgvcHpwVU9Qc1lFUjhTVEE9PQ==?=
X-Microsoft-Antispam-Message-Info: /bh6mFeYHhaPSEF80RSbLmmGotT/QewQA1HCl/kbvKeYxXN2KmPo6Rx3TF+XLbeDN/5er4T1ZEwnuKWH34vXLv0ko43421rhr8t8ruCWM6Zdk1u/uKCi+JEO32ZdqXSKGTpCVtqeWI/ZG18zis4aSA8slCTNs8guHYI6asf+7cd53QNPYveZU9zTE6dwsREY
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;6:6b+RggsAz5aSQqx8xz6FuNf2RHjzThATOKm4HdLQumaFtfn3x2UmoYUhoC8GuUeZIKeGps+q5JtSO7Qy5fsEUwf2w4fVsUsh0s1Hj72VKea7Gv8ssrGOsG/MWTUbJsAL/cOSVj07r58BAeBDKt6cWS2wMI/FiPkMlLhsHKF0qEfJzlggg/5QjnnhdZNxne3zqCDz94XRDH/PikaSN9lWU57RFcaGKqaeCfVKU84y5mgjMX0Pif1v0VWBik3GzxrVSy62bQgjebzSHeL4AZza+IwsEsT4FVz5DzxKt6XFkGpHT00tdfPTqzLOYpVntOIviP1xdZn8vwwqtCDeSmDNQ2y7+cKyMCyOBc3hPHRTps5Udw3DFYVVZFJ/mPlmWK7TKA0FBbiGkdv2ZCObyL7BOut+NMUohAAMPNAMZGFN8GDKOTBEMvPAZYU905NC1BrrijnRYEkrOuYG1P/YeJXuWQ==;5:Dw/zUZtNYTx4HwjwP5SgEeA0U/VsuxAKmJfaUw90TYN4z/adqYr2g5t11HBMTVz+USvnaumBlW1t26qjX2BR8DOezHzC8fKdcRTRbFJ3Zr48FsDa5hPdhLiZH+yGWah2RQDhoKBnOHx0JMrh3zLlgYglzsMDBbyKNPaGuqHOZTw=;24:L4hDq05jpzwcahw9r6qG/x+3YqxApD7spn2kdImIS25zw4zU/Evv5zNPqc6/ISYCiRK5LlRY23yS2ofuSxrRoUXoeU2IwQjowBh3nFgyfHY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2774;7:OmOIyiobui2G9gozy0a1Od0lYLvuzNl27W+lGOVtNBEBdwWMKBDPWfXIAqyRKpjq08T9vBcqq7PkczSCOr1jLLPHFnT3L26tgL6mu5UV4tfJdVueZaZ4pnrjy7Ty14uZ53qEMifm8YuYx0m9UvwSyNIldxDO6qvK4FlAQug3zYhF7LCcLEXdD/khv3Vwbb/myqUxQFZ6p8UptDedoW9wN8xYPU5cRPLSw+ZvgbXyW1GtCE+51+sRbLZVk7H7A286
X-MS-Office365-Filtering-Correlation-Id: f0f0276c-8564-4597-4712-08d5b273056b
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2018 10:29:02.0474 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0f0276c-8564-4597-4712-08d5b273056b
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2774
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-05 03:43, Wenwen Wang wrote:
> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
> which are used to save a series of messages, as mentioned in the comment.
> According to the value of the variable "size", msgbuf0 is initialized to
> various values. In contrast, msgbuf1 is left uninitialized until the
> function i2c_transfer() is invoked. However, mgsbuf1 is not always
> initialized on all possible execution paths (implementation) of
> i2c_transfer(). Thus, it is possible that mgsbuf1 may still be
> uninitialized even after the invocation of the function i2c_transfer(),
> especially when the return value of ic2_transfer() is not checked properly.
> In the following execution, the uninitialized msgbuf1 will be used, such as
> for security checks. Since uninitialized values can be random and
> arbitrary, this will cause undefined behaviors or even check bypass. For
> example, it is expected that if the value of "size" is
> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
> value read from msgbuf1 is assigned to data->block[0], which can
> potentially lead to invalid block write size, as demonstrated in the error
> message.
> 
> This patch checks the return value of i2c_transfer() and also initializes
> the first byte of msgbuf1 with 0 to avoid undefined behaviors or security
> issues.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/i2c/i2c-core-smbus.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index b5aec33..e8470d5 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -344,6 +344,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>  	};
>  
>  	msgbuf0[0] = command;
> +	msgbug1[0] = 0;
>  	switch (size) {
>  	case I2C_SMBUS_QUICK:
>  		msg[0].len = 0;
> @@ -466,6 +467,8 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>  	status = i2c_transfer(adapter, msg, num);
>  	if (status < 0)
>  		return status;
> +	if (status != num)
> +		return -EIO;
>  
>  	/* Check PEC if last message is a read */
>  	if (i && (msg[num-1].flags & I2C_M_RD)) {
> 

I think these two hunks should be two separate patches. They address
orthogonal issues...

Cheers,
Peter
