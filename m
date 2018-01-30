Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeA3O2n (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 09:28:43 -0500
Received: from mail-sn1nam01on0068.outbound.protection.outlook.com ([104.47.32.68]:63288
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752165AbeA3O2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 09:28:41 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com;
Subject: Re: [PATCH 1/4] i2c: xlp9xx: return ENXIO on slave address NACK
To: George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: wsa@the-dreams.de, Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
References: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
From: George Cherian <gcherian@caviumnetworks.com>
Message-ID: <1043d995-1448-3c0c-8052-8c31d18343d1@caviumnetworks.com>
Date: Tue, 30 Jan 2018 19:58:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <1516253964-4615-1-git-send-email-george.cherian@cavium.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: PN1PR0101CA0043.INDPRD01.PROD.OUTLOOK.COM (10.174.150.29)
 To BY2PR07MB2326.namprd07.prod.outlook.com (10.166.114.140)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 726a201b-9599-4b7d-fb34-08d567edc0e9
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:BY2PR07MB2326;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2326;3:x2ZWzW27EHIfltgNJnxJzFes4FLKb2Qdd6ChDiDRh7eL9weJ/dX0Nsyvk6O1fy31+xX20lCjbZXXFid0734qosUnHlZ4ucJW434pDCp98Oz/5HpmQ6fQrhgR7EcnY2bMMahOIoWvirSCaR30/L2G4aLsRJiMSCJ9oxf8bbYsp4mcpDv7DMhfMvmcBZNknYEaHkdDnNy80BaLdytTHqbZSV3UR5Bf5vRKTwgaR0jF9USHxG5NcgDTCeEO1s2NxLdZ;25:sySAzluFMHJvAskGUP4qVDhX0lze7lXTa3DBlFJvL+ZUn41uU/l1N41sUYJ6cWhwK0q8g/IBHEierCW96tEmuwIy15NFgohoML7O8w80LHdmpfnyyas81S0TLQoPr+P8o1jWp39QZRb2YpOKij1Osmbv0CgQ6bwKfhZ5PZQzclvXdHeWzLtpz3HkmD1fW7qiPFO/neYdZjFMboUBy1RBUHyzoWMI71Txq0hDIdWcizYUoWtg3QX9lOS9VL/2GPKyR7RpJWxu/U4wmMgCR3O6KzyWqXNN/rYjE7XpGuU49Xga+FlAkC7GTdBY0LLkeCZThtEewCw7+wQW3kjv90a0cA==;31:RgMwd6FMDV1zCTCjL88YpXeySbomAihAu1MZ89OJTpm23jmb+NyHKGrPEyvy5QLO8rbtZt4LDg6Y/ntAQOEZky0+7Iq2YPgbcbRsvlpjCAegZKbqOyWKMsp+g5YEmVd3R3jHc/y7tPjT/EHjrUPwjh/61iq3ksbVpuRsztX1TmJaaVHTcpWsdjlUm5vb8aHZBoKRNA/QalWVXg1qlhtkTjzNvqzT+Rychi/rc2WKk4k=
X-MS-TrafficTypeDiagnostic: BY2PR07MB2326:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2326;20:7wV+s8VjYIgthGYaR43SxMQm78Rh5uXZSmuIthYn/85flBBwWKB0aJbpurOt65co4JTfvjzo/8YDdfvq+LjLBGpO/AMEZ2FEroxPWzr99ZfTKrUem7xzNZR+4egA/GCQxNzFEfT6BiQdaaPcm2GIUcTsXr0FGksGPwbRMKNt63/Wx8KK5vdQcFAcO6B/4ZgLkIOFh+zR2t/y40nxMy7QjlaZFnOZ01HOxF8GDBuwXnPd6Hpby7LZT9M06Z2wGmS3hG0jxcKQIrszrN1PB9RobmHjlwquGkvRIZ0x7ogMny8hGMlS0uBYWNGS8vwoolrFgv832fpEYTi4hunQle9t5nS7UbKU4zP8I1xzEBt/G/3cQYlrtVpmz5E6j26Nq+JaY22Aj61EYZcTO2/ZCbsxv9xvbErjKCvnvdSAGsOJNUCUQdtSFQ+CT6ydAG3uKe4k4fF/Mi6JNc0j6uapVNJ35BaXk3f4Aq2VJkis+KfCHszAPVKV8guP8VYH+QdTRBiiE70y9xdQElFzDONTv0YdlRxQAiRX8qOf63vr9o8DARMQQZ6c9IG7TPAzQvsX3NuUdvOi2lcX/uUyJzNzk1342BoRe5qs7cRd+yJ7zDZC/eI=;4:FOGWPf3Vd3AxChazhThggx21LQl7y+UzIPOLkl8yhGpsZFhK2QnHg5Kdbp8QC8o93nW5tDaNTdldRL1+Ywmcz0EFHp0Bm4DUmm4uWJ13sa+EkJfvpewGZ6n7t/2IGyiPP2H4eQG+Sc8gZrvaTsDA4Gfx4US4Ceg/0E/j6wvt2sNbpknGyPqwgXHgXlByfgOakm/aTZyvdQw3XneiEKtvRyjUoHDGLVHm1Z9DcxBNK2TyGcFV9H+HRUbacW4cBqraGOtotepcP+ENzIz+9LNJpA==
X-Microsoft-Antispam-PRVS: <BY2PR07MB2326B0D266C00E2492516705F9E40@BY2PR07MB2326.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(8121501046)(5005006)(93006095)(3231101)(944501161)(3002001)(10201501046)(6041288)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:BY2PR07MB2326;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2326;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39380400002)(346002)(366004)(396003)(376002)(39860400002)(199004)(189003)(6246003)(58126008)(3846002)(386003)(316002)(52116002)(25786009)(81156014)(97736004)(7736002)(81166006)(305945005)(50466002)(5009440100003)(47776003)(6666003)(6486002)(230700001)(229853002)(77096007)(105586002)(42882006)(6116002)(90366009)(65956001)(8676002)(53546011)(65806001)(186003)(2950100002)(65826007)(5660300001)(31696002)(64126003)(8936002)(66066001)(4326008)(16576012)(2906002)(31686004)(26005)(76176011)(106356001)(59450400001)(52146003)(23676004)(2486003)(68736007)(72206003)(36756003)(83506002)(16526019)(53936002)(67846002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2326;H:[10.167.103.249];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCWTJQUjA3TUIyMzI2OzIzOlpMZGFzc01oNGsyZnVhK3grZ2pJbTJIcTNn?=
 =?utf-8?B?ZXhqSlJuYlR6MEdRQUY1YUovaXVIcWhwQnprNXUwQ2ZoM005YkJmU0FTdjU3?=
 =?utf-8?B?M2tkMGtnTEszcWpSZDhHZFZMRkMrZ2tmNnRTUGFuOFc1L3dYNzRQZVdCS2U4?=
 =?utf-8?B?c2tkdkRIMW50T2JBS0k0YThxSExObTVqUklGQUNnV3k1YTl6clBZS0YxV0s2?=
 =?utf-8?B?L1NOVmhVUlFpNllCT1h6dEN1ckFaWVdma3JIMzN5Zi90OXFPc0FDL3lCRmNi?=
 =?utf-8?B?c0dYSGVPT1JYUitzNktnK0ZvRWtxTFFhUWgxMjZwL2hkVDRlVk54aHM5MEs1?=
 =?utf-8?B?cjJSMmVmU2xvK3RZY0FQVURrZ1NFRGYwNG1qNUhqdUFFdWl5QjQrLzY5RzlS?=
 =?utf-8?B?cUxXZnlaM3RNaEsrNWhtbVlCRFVhaW80NDU3UTRlb2x3eWN4eUxvclVyTW1u?=
 =?utf-8?B?K1FFVEgzWE9FaitDVG82UksvR1dDRGxPWXNucUt3cWlYN2hpczZoQWtnYWg3?=
 =?utf-8?B?S2hSOHZ5R1RNR3B2RnFqbllWOTM3c1RDb3ZXUnFvS3lWcGpNOUpMcGlsOXZS?=
 =?utf-8?B?dzhhL1FMbXdLM3ZuMnFuTEdLNXhXVzc5Z0tjMmJ2dFRxVDZpT0RPMUxjQlBF?=
 =?utf-8?B?OC90SWh6N214bFRHd2hCTFZsTHlEVTFueWJVQi9WdjF5RnI2UnBmdG5Idk9k?=
 =?utf-8?B?dGJ6Z1ZxQVZoYTVSVEVGWFVzUGIrSjJBS1dqZHM4c1M5QzUyck0yWEZxdzVT?=
 =?utf-8?B?ZUNobkxrL1VxSFF0SG12eFRLUXBNcnlleG1DcHRlZnh1Z0sreXQzQ0VudDYz?=
 =?utf-8?B?bnVlaVI3d05sT2hnZzhxTnE0Q0QrdmszSlpXWkRpVVNjMnppSTg3bnhXY0xC?=
 =?utf-8?B?bnRRMUxRaXB1LytCZS9lWTdTdm0rU1hxckRxUkZwcHplUDdUOEdJZFpIVlFw?=
 =?utf-8?B?Q0tIOG1sZUtyblB5bHRuZGxGdklDb05Ib0orU1RXVk9VbU1ZamFUblhydWM0?=
 =?utf-8?B?L2VqcHkxVzVIN2lvU3ZJR3QzYitrMUJhT01UWEJKaGNGS000RHozOXhiSlhL?=
 =?utf-8?B?bDdWV0x0V21zTzlZNmYvTmFETmc5bDREYnBBR2RuUEhZblpEL1dIZ2g1V0hy?=
 =?utf-8?B?V2Y1RURQU3h2a282eTdsdlVPdWhmTElPQ1REWHJCYmIwNFg4b2E1dDhTNXZ5?=
 =?utf-8?B?U0lhdEpXZ2lnK0dqS2lSZjliNnZkZWtHN21GRVBZZW0vUnlmaU0yWCtSZkpB?=
 =?utf-8?B?TklObjQweTI5L1lTRDlNUVRMcnRvZDZBdkxqUGttQ3ZlaHp3MC9MTEd2cVkw?=
 =?utf-8?B?SFVRUGpRUk5iQ0xyVkRVOHVHSzh4L1MzOEdDMW1scHk2d2gzV2NUSU5GNERT?=
 =?utf-8?B?RDBJSjVIM0xIdlZEMmFDY2N0TlVNTzhXemc2NFB1cUZOUzRaRVRGOXloL2NZ?=
 =?utf-8?B?QzFPN2h1QnFtdUh3ZWw2WlhoREEwaGpwSjhLR2ZoTVlCZHp6ZTF5WkQvenh6?=
 =?utf-8?B?LzBqSjNwQWFPTHNZZjN5YkJpbjNqQThEa3ZmRnlscnQ5dFRNSXV1L29NRWl2?=
 =?utf-8?B?MEVtNk1IYWVzTWdpZ3pvT2VJa3Fmc3lNOVdqb2x6ZStWTmJ0VHVDV1JuQjdX?=
 =?utf-8?B?UXJNMXVUV2pOMGdkS1MySFRQMUlvUzdhOVAyUFNrR3BXU3YzNFdOWXNZUi9Q?=
 =?utf-8?B?dXRpb1NTNWZaeEJuNWxhbmJpYjVVajZ6czhlYkt0U0xuemthZk1ibFUxQ0Iz?=
 =?utf-8?B?eTRubUZsWUo5MytRSE5kTnZzS2JBWTl6YW5pelhZZ3RJUmo4RlMrMHdKdUhM?=
 =?utf-8?B?MU5QZnZuTXZlbXZvVjhUbUNrMkhwdUpXdTNCdDdqTXpCWDF5dUFxaFRhK0NN?=
 =?utf-8?B?L0graHNudmZWVHBvZFhPYlhBaWZMejlKNGl6ZHJnRVhOaVlMdDFLaHRrZzRN?=
 =?utf-8?B?YWZ5WW5oWVcxZDkyS2hNYmVjZXRXZXVwU0ZNcjRNaUY2VVc2djY4MGMyU0lP?=
 =?utf-8?Q?bNqLL+?=
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2326;6:WIlhnI4y1IN6STpy8zcuN6bz/UQmLoWPW+fSV7xTw+xCGPGEVjpLPxpu1h1OD2CzO9eYw6M8n1ppj9xhM3rWup2ul0ta07jLFtlE95MHB6T0pEE7ScfJG0l+1+0Xg+cNieWdFUvxXP2iTezhFt0H8owDms6oUujCxyAAHairTIm5EJ9jfOAGtH31J2495aXbZoZ1YKaJwWYECezhRRVN6aSvZLruH4LjvY9veRM4+wlNl5EhDa+qNS3bwlUN0gqlzt/ugnW6mbLuT93iApQKQbeBPYdujoXDqFIGkDwQ6wj1mZLMMi7leNftF2P/W+oPdd6T0dTObPnmeeQzdteXe2Na8TMfolFVZKzBwUZKIbI=;5:5J6q26OSe8/MOfy6r9bPt8kBp/YhMnzPPjBhTtzRTyoe1y1sOoE8+utV9Pl5t/El0C3SgmsYCa8xuJLAcpDrVu/WivI+EicmYfVxKVXlkdliQadCfeWtgP/pJY7ZkXqYiLLYO2PLjDvtzdy7CvzjWMsDkPraRnrAkaQJqCIaNsQ=;24:a8px9Vd+f+naKfcCUuWUt+JHTxJ9ceKRXQvnW9GIRoPYvTuZQZkBWnkJL6e+LjT7sBA/MtAoZV4bG9vsc2/i6+fomd7CZCnq6aJhUl0iB5k=;7:qlmCehC37t6TJac17D8bas1c4fwmVdGnsghRPuApXy5nYP2LBf0iWCjUglp5cLLgCgLJwbb0k3VWRTuNOzSo8P/oKT0zNVQWbvhdqjz95FkGjptlan99uzNU/y5wp8Bxv81eqldIIXeRjaglAH4SqwVIkaW+Af26C5Vz8iyHLPJJGzduu5XKdQL87iQFyzopSC0tvKLaULChNBMCS3zKleaVDCT4nkfyHtuD+ORvJNLxvYvR8x6G6y4cWXx+wD2H
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 14:28:36.5981 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 726a201b-9599-4b7d-fb34-08d567edc0e9
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2326
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gentle Ping on this series.

On 01/18/2018 11:09 AM, George Cherian wrote:
> From: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
> 
> Fix the driver violation of the common practice to return
> ENXIO error on a slave address NACK.
> 
> Signed-off-by: Dmitry Bazhenov <dmitry.bazhenov@auriga.com>
> Signed-off-by: George Cherian <george.cherian@cavium.com>
> ---
>   drivers/i2c/busses/i2c-xlp9xx.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-xlp9xx.c b/drivers/i2c/busses/i2c-xlp9xx.c
> index b970bf8..6d78cdc 100644
> --- a/drivers/i2c/busses/i2c-xlp9xx.c
> +++ b/drivers/i2c/busses/i2c-xlp9xx.c
> @@ -324,7 +324,8 @@ static int xlp9xx_i2c_xfer_msg(struct xlp9xx_i2c_dev *priv, struct i2c_msg *msg,
>   		dev_dbg(priv->dev, "transfer error %x!\n", priv->msg_err);
>   		if (priv->msg_err & XLP9XX_I2C_INTEN_BUSERR)
>   			xlp9xx_i2c_init(priv);
> -		return -EIO;
> +		return (priv->msg_err & XLP9XX_I2C_INTEN_NACKADDR) ?
> +			-ENXIO : -EIO;
>   	}
>   
>   	if (timeleft == 0) {
> 

Regards
-George
