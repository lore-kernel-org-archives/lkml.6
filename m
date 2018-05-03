Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751339AbeECUeR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:34:17 -0400
Received: from mail-eopbgr20113.outbound.protection.outlook.com ([40.107.2.113]:3328
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750909AbeECUeP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:34:15 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se;
Subject: Re: [PATCH] i2c: core-smbus: fix a potential uninitialization bug
To: Wenwen Wang <wang6495@umn.edu>
Cc: Kangjie Lu <kjlu@umn.edu>, Wolfram Sang <wsa@the-dreams.de>,
        "open list:I2C SUBSYSTEM" <linux-i2c@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1525300581-27217-1-git-send-email-wang6495@umn.edu>
From: Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <4390a69e-a297-313d-044d-abf846eff1d1@axentia.se>
Date: Thu, 3 May 2018 22:34:06 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1525300581-27217-1-git-send-email-wang6495@umn.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: VI1PR07CA0201.eurprd07.prod.outlook.com
 (2603:10a6:802:3f::25) To DB6PR0202MB2775.eurprd02.prod.outlook.com
 (2603:10a6:4:a8::21)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;3:jqjCiefGfhLMZuPNOjTTvNvLHDEKNk5ATboVYvrKQu8FrKu3vN1Dt9z2movoYSk/sH+lvNtQNkszM+htjkzLMdDp7X549TNIQIdtgMxy1OyVwlB5DswbRkTym7gK8mqKdj9TzN8vQcmCuMG4IpvMHaw52em9FUXnqlcouwwrwWnT4wVFVIbwLCMZqON3+c1zVsPlboh6MYSMbOuyX01G2YPUgfgNKvniyHjTUlGBTe//Rzy/3S+Wtj1SEcqvrtPw;25:UcUEghpVBlSx+YlXhFpcT1+Zm633YEVzxryAjCZD85uj1Dfu3uhqbmSJ31wk5/7y2wt4CC3gKUiGAvq/Tt0AsZ19QXXOe6jqDQgLG5r7fj4/3N5frk1kfISkxm2wHPrL1beruQVpeDINbrqUBNsixp+hYlNeI0+c/uyOX/k/AcS3V63uaboJuRi24XX6aWyP0/8ZiS5DsWi+EMEL5re2HGJBIjHwSTIlAjFla8UH+qVA5wzGf9wVVv6kffnBqXt59HtCHfCN3Rn5f2CLOa3QPsde+rYNhpfqgFrFBvDAT14lQRTOzhpz4wVa+z1lSyYaTq6Gl7aAgyhsPOgQz4kqTw==;31:nvP6K74O1+IyE/jdvqM2lmI2wNOJaEDR4xxY49qKK3Tdtea6kOO/LtiG8yJPpVAv3wU4VOe5xtEZDOAOXiJ6L8suX5cbAd1PhxAi0SosU54AbUjppKQ2T1ohQQKmHiaxoBJnedXi/QWt2MHxjoBiHIgJhA1RVH0aqD/B9TYIdvQaP96eyPzKn/qPJ6C68MvUuMKkmL3loylXYSUtNjBG533SfsAl9kpkp1HagvXBlV0=
X-MS-TrafficTypeDiagnostic: DB6PR0202MB2775:
X-Microsoft-Antispam-PRVS: <DB6PR0202MB27754DB56E15EDDFD2039B53BC870@DB6PR0202MB2775.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705)(8104003914727);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6041310)(20161123558120)(2016111802025)(20161123564045)(20161123562045)(20161123560045)(6043046)(6072148)(201708071742011);SRVR:DB6PR0202MB2775;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0202MB2775;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;4:/aNRdQ6P61N2z05TlOcxHoFUOJ3ZcxBvzSTsrUhs2RlTanVnTdVtPeCyFueRdHW8HtQRvMawaD5EEQhV1bNmOrrnX9n12Lo/FoyeEOkDL5q8LRL93VsRK1gq0okRA60KckKcIWLoIa7/5/92YS0N/yTo5t0RBvQQXWLMrOXEO+lK3IKNTGqUNb79ZHZek21eSR9aABFRMFTurmWM6JOjyUDUy262T1H8M8BNF2ucuMdPh8mJZt/E+kWVC0ag6ev9tLAJkhjwtfSYdw0nzwgf23AKY0G9a2kKcjRAvAAOoh49e/+tPKgqTxbIVDXQr3Ce0w5NV1r4kYwSs7moE8/Jy0UA06VzNr3TEmmhuFTob3o=
X-Forefront-PRVS: 066153096A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(366004)(396003)(39830400003)(39380400002)(377424004)(189003)(199004)(81156014)(68736007)(31696002)(86362001)(52146003)(6916009)(77096007)(26005)(50466002)(478600001)(47776003)(54906003)(25786009)(81166006)(97736004)(36916002)(3260700006)(316002)(66066001)(486006)(5660300001)(11346002)(6666003)(58126008)(2616005)(956004)(59450400001)(476003)(23676004)(117156002)(53546011)(65826007)(52116002)(2906002)(446003)(65806001)(186003)(16526019)(2486003)(386003)(16576012)(65956001)(105586002)(8936002)(6116002)(3846002)(305945005)(230700001)(8676002)(7736002)(76176011)(36756003)(74482002)(106356001)(4326008)(6486002)(2171002)(64126003)(31686004)(229853002)(53936002)(6246003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0202MB2775;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDJNQjI3NzU7MjM6YlNnaXVmZzRRcm1vWk1ud2dqcUFIMFo4?=
 =?utf-8?B?VFBUNHdpR29lc2Q3bm1ENXdvVkZRMDRjNGh3V1MvNk4wemxTMDVZQmFKb2lU?=
 =?utf-8?B?YUUySlpmcitZYkZWUUdMR2gvUDY3KytyaU5iYVR3ZC9VcmdXc2VtT3Eyd1Jh?=
 =?utf-8?B?ZHJqR1U1V0ZNdzNLODZBVXZlT0t0OExGS1FQWmFkU1psaTMwOWFid1R5Si9V?=
 =?utf-8?B?eFdwczBtWDIyc0FpbUpFbHE0enhReW5zMHdaY1BPbmg1UnQvWTQwRUd1bDdN?=
 =?utf-8?B?Rk9GbWxkSlRNamFsV2JHSjVOb0pGR05Md2ZUQlhPc0FiZ0Y5TDd0c0k1YTVI?=
 =?utf-8?B?cHdDTjEvcVVENmxicEM4a2pwMEtGT1dTcmI0cnp4blh5NldmRDJ4dVp5cWkz?=
 =?utf-8?B?aVdCZm0zZkNXZXYwM1F1WitTWFc5WFNpTjUwajdBaG1lYnROMlBIVjE3b0xN?=
 =?utf-8?B?TEFnSHNuU1dvTU5jS1RmOWo3aUg2Slc1YzJsazlXbExWNTVZZCsyYXdiYThE?=
 =?utf-8?B?UFVHWWw5aTZTN0s0czNodXA5dHRhQk0zZG1jN1RSRWRxRGI2czZHUjhCQ0xa?=
 =?utf-8?B?MDZZUjRPdzB4aTZZU0hjQkx0R08wVExYT3lWazJYanJHSHNidmVxb3l2L3Br?=
 =?utf-8?B?dVZ4cDhzdXc1Q2pSc01MTlFnemZEOEQ0UFM5c0o0eUhjaFRqVlJMdUk3Nmpp?=
 =?utf-8?B?ZVk5Y1V6VWhyNUhZOUNobXNqQUk4bTZwSGpqZFQ3dmJ6S3dXSFFBWkdMNDdj?=
 =?utf-8?B?eU5HcFFCZkJEd2NZaCtVMS9wWThTelp6ejkzRkVKaGZaZzdZMklYSVo1T0Vr?=
 =?utf-8?B?emJURzdMclJqOGtRUGp4NFAwTEJMd1IvdnhBd1EzVHRQRVYxSEUwNitGM0ZT?=
 =?utf-8?B?OU1jaWpZbVdsT3d4K0Erc0hRQk0zYjh6Z1V0bkU0bEZ2WDU4cGROcU9jVGtp?=
 =?utf-8?B?V2U0MzEwbEdLeGUvci8vM3ZEUUNvTGRpNnRBVkkxSCtMTHJGaTRvZDUxTzVi?=
 =?utf-8?B?aHdsWWdraTVIMlM2UzNZNS8zbCs1YXl2WDNjRmVZeTRXcnVVVnVUeVBsdVpn?=
 =?utf-8?B?NHNFZ2hQTk9RMWJuTXNuOHlWNFhPUGdtN05Tb1ljZTBRd3U3dHEwa3VtNFM3?=
 =?utf-8?B?NS9zYVhUSElISVc4VEIvaTBOK2ZWOVZOQjRGU3U1ZVlqVzVsaVdud3lpT3Zq?=
 =?utf-8?B?K3BwWkFpMG54S05NRUgwZXZyWU5Vbms2WmJiem9OQ0ZVdVYvUVZqY2E3eVNL?=
 =?utf-8?B?cDRxZGFPVnc0a1U4dmNMd2ZHZWxDSyt4U01Mem9GZHNVZWZma2lMbThEM3Ay?=
 =?utf-8?B?TVhkcVhZOXFUV2kvcmNza2dYNVA4bGlIa2F1Qk1uKzFmbmpsNGtQekNyRDhr?=
 =?utf-8?B?SDZPWWpySm1tRGphNXIxOFBnQXBoMTFMTEZqUFJTQkh2RWp1ZGt3RkdSdW1w?=
 =?utf-8?B?NlVwOFp1ZTVYcEJLdHB6dWdmMGd0akVwOW94MUVHT3dSV0VPa0JCN2Jwb1Yy?=
 =?utf-8?B?UWp6RndsNE0zVjNOKzNrancrdkJvT0dTZ3AzSldmZnBiTnZaY3RPa1FmSDVq?=
 =?utf-8?B?NGJpYmZDTGtJaHdQaEtaeWNLbEdEdEY2dHZxSXpEZHZPb2N1TjFYaTJUN2M0?=
 =?utf-8?B?MDlLaWF4RzBNZFZyTmEvTC91OEhHemMrUXozbkhUZy9BcjFhMnI1bUkrRnpl?=
 =?utf-8?B?VEtFNWZ2THZmQlM3SXd2UndJRjhqNll1U0ozZjdxeGNweEZIdjNVbzJXNSt2?=
 =?utf-8?B?SXY1Nmx4cDg4T2dSMHVma3FYd1ZLcCthZEZVOXJDbHA1RXdRN1FvR2lsNjNp?=
 =?utf-8?B?b1hHbVk0ZTR1TW9qdndaLzd1RnRuMDhxMWZTWlZ3VmVqZ3BRejBVdWlpbVFZ?=
 =?utf-8?B?cTJ5SUpTOWhXSHBob0JLSFFrMVdhYjlVaFN6Vm9IQ2FhMmswbkxLOUd6SjFs?=
 =?utf-8?B?L3VnWlVLTmxjbkpqeHU2TU83QkFLVEQ2Qk5qRm02eUl4WUQ5ZWNhTFVwR0o3?=
 =?utf-8?B?UDZIMHRiT1lFcUpUOFNRUEFoKy9JSnJHL1pOVWJaanlKMjdjaDZWY3dJK1dG?=
 =?utf-8?B?SUZhWkIxRE5VUVk0NmhoSVUrZWd5Sit1ZXFZcFJ1NXN3TWY1WmVyWDlYYk5z?=
 =?utf-8?B?Y1huelF5L2lTWnBqdzM5K0wyS1NhWXFjQ0FaUGhCbXhBb1ZoOXZYTXRBYTFK?=
 =?utf-8?B?M0JXazVkbEtOR2VZVWUrYUZUamZiSXc9PQ==?=
X-Microsoft-Antispam-Message-Info: bgXl+2sD8Dr1Z6UP27q2Jd5lP2RrPxi5lfs7ioc04aMm/3TPkUPS97KhrQ+1IWTZwYd9nD8VfM34nE673OVWAM8A4ukbLVIeGNCKmx5aApN8dmJhb8vVsjexriHmVKAV7LZCbhm/H+zuqSOgEWKl47HofGvHOxtnrEYIjAayRuc10knZ+VLLWY6LcGnBGCw6
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;6:+zhxkAaQcqznpigpZEUO4Dd4XKw523RfbbQ1Qz2AmGxQMhLK2UbzRX054raWi7nTrlohRVwZH+33nEAi+JZ1Y1DYm/PpNOc6BwcZdNkQu6bTJoTYjKJ6kgCp3vDYaLIFCGN/752rPHxbtIKmzOQYHCS55FGHsJx/9WtkxBphHjNVBMFqqS8xSZpT8rkQQAMF6rFEpLGMJZtr9JHMt8h+NyNiZJSfrIgV0Tw/QMoctJKUfRWZVud7fYYtb8nLC/5yVAdM+HqCZ+DkuUrZzp6zMGFMZeelN50zRCzK+TUvF5i3H/3CpIpLSHM61cVPoyj73vxaH6hONpMl9KDJqvF/YRLMFfzXm3yekHinhdYLb+XQg7fijlLY/ytNj1SIy5tlrbG/LmHr+HcGmPSSUdYF0yf1/T2NLodWZhm7yJg4yk4+4+4f1cr3JP9LA1FSnI9oLzZasWmmVRjpTUfACJgdEg==;5:/uVAJRhnGBdoIuG8jkxkX5qXUUgto0xwqnqJOLcb5XCOC38y7DHjOuD91tftVi8F1prBa7Pmqdl6JwU7xGPVPuT+kwJKAXCRmmX0sz2Rfxg/TjFNwrSVzVAKPdI7SImi86lxVn/q76BUMdDXfnwolA4+ArpGxVzncOutBP/zcGE=;24:mpC60l3RJqZMHs214FOL6sPZU2Q0nU3Be5KZVl9vaFzs/eaVMRKrJWyeigq5axZ9SwTiHtRZ1x2kAI0CAhmAaz9AO41ADfz+Kdlx0rSJcj4=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0202MB2775;7:DRt9j7LJmHTzAPIglet5YNyZBuajqgc7W8qMYZwVAUGBK3NrwjT+W5zY+FPjRi/fAsXqS1I+j70EKvnwaA2CGTgjzCP8atYFAkdbGgHbS1mSQfUtrQyraLfamLcoqIjjcgWA8uA1mdFJ++x4xtfSGT3ltlvdCWM3xZGfiGhiJLIre4CDB9yt3wW1YDBkUwUGxw4rb8d4xqwPs6oiFr/zHVeSb2FbSYBSO65+2hWkeIeagDpwBhQ0lDYeFbJSM4lL
X-MS-Office365-Filtering-Correlation-Id: 2cc567cd-9b24-4084-4b5e-08d5b13539ec
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2018 20:34:10.0026 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2cc567cd-9b24-4084-4b5e-08d5b13539ec
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0202MB2775
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-03 00:36, Wenwen Wang wrote:
> In i2c_smbus_xfer_emulated(), there are two buffers: msgbuf0 and msgbuf1,
> which are used to save a series of messages, as mentioned in the comment.
> According to the value of the variable "size", msgbuf0 is initialized to
> various values. In contrast, msgbuf1 is left uninitialized until the
> function i2c_transfer() is invoked. However, mgsbuf1 is not always
> initialized on all possible execution paths (implementation) of
> i2c_transfer(). Thus, it is possible that mgsbuf1 may still not be

double negation here

> uninitialized even after the invocation of the function i2c_transfer(). In
> the following execution, the uninitialized msgbuf1 will be used, such as
> for security checks. Since uninitialized values can be random and
> arbitrary, this will cause undefined behaviors or even check bypass. For
> example, it is expected that if the value of "size" is
> I2C_SMBUS_BLOCK_PROC_CALL, the value of data->block[0] should not be larger
> than I2C_SMBUS_BLOCK_MAX. But, at the end of i2c_smbus_xfer_emulated(), the
> value read from msgbuf1 is assigned to data->block[0], which can
> potentially lead to invalid block write size, as demonstrated in the error
> message.
> 
> This patch simply initializes the buffer msgbuf1 with 0 to avoid undefined
> behaviors or security issues.
> 
> Signed-off-by: Wenwen Wang <wang6495@umn.edu>
> ---
>  drivers/i2c/i2c-core-smbus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/i2c-core-smbus.c b/drivers/i2c/i2c-core-smbus.c
> index b5aec33..0fcca75 100644
> --- a/drivers/i2c/i2c-core-smbus.c
> +++ b/drivers/i2c/i2c-core-smbus.c
> @@ -324,7 +324,7 @@ static s32 i2c_smbus_xfer_emulated(struct i2c_adapter *adapter, u16 addr,
>  	 * somewhat simpler.
>  	 */
>  	unsigned char msgbuf0[I2C_SMBUS_BLOCK_MAX+3];
> -	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2];
> +	unsigned char msgbuf1[I2C_SMBUS_BLOCK_MAX+2] = {0};

I think this will result in the whole of msgbuf1 being filled with zeroes.
It might be cheaper to do this with code proper rather than with an
initializer?

Cheers,
Peter

>  	int num = read_write == I2C_SMBUS_READ ? 2 : 1;
>  	int i;
>  	u8 partial_pec = 0;
> 
