Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D9EC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:48:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E11D21719
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 07:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="URzdRGg9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E11D21719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727177AbeHHKGh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:06:37 -0400
Received: from mail-eopbgr10089.outbound.protection.outlook.com ([40.107.1.89]:41911
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbeHHKGg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mg8xzREecOSfy2ty26pu7ac+2u4eSNPilvXb0NK7xuk=;
 b=URzdRGg9p3vnrwJ69nHSMKWdoJ15K5J5gtyPgBYHStRoJnpB/1Dm4n1w2c33Tzu12duiH3VR6PODFXdKR7teIWO2bFp78TUVbqXmGuyirtnPuJ/ZVbTlw/nuXEfwnBuru4SqMOFbSJM5o2fphL6q3tvUvMsazqZyBidO/EfOy0Y=
Received: from [10.1.8.111] (89.24.100.190) by
 AM0PR04MB4659.eurprd04.prod.outlook.com (2603:10a6:208:75::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.15; Wed, 8 Aug 2018 07:48:03 +0000
Subject: Re: [PATCH] media: dt: adv7604: Fix slave map documentation
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>,
        mchehab@kernel.org, linux-media@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180807155452.797-1-kieran.bingham@ideasonboard.com>
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Message-ID: <505904fb-7bfc-c455-740e-b72a14731eb9@ysoft.com>
Date:   Wed, 8 Aug 2018 09:48:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180807155452.797-1-kieran.bingham@ideasonboard.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: VI1PR0101CA0049.eurprd01.prod.exchangelabs.com
 (2603:10a6:800:1f::17) To AM0PR04MB4659.eurprd04.prod.outlook.com
 (2603:10a6:208:75::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d3715dd3-32fa-4453-1de3-08d5fd0345b8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:AM0PR04MB4659;
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;3:P0hJLNejeJzMVhegbGWSO7NkVyITZ0HOTjdERbQX3iMmV3+oHhEEMnbj49M91Dmm0s9c55L5Mft/lUkWVod8O6Q5dy+IKsD/ykulQdkWI5Xy+zXWPJUgVImgVnCDxf9ATlbcdMCiIft5H7b8FCLjhhAKCEcwy0bvqROprunl8KudtzJKauU9l1lwtMow8l2IA8FoqhP7LOGLAkGZHOpY0OEZJXN0yCjgOAtfcdpbRZF8XZd97DtW2gabygakoU95;25:L6+IOYd5zIlPTgkWaqcU7sONY4vy0Yz6Z2JLHkxhruVFA157Jz7XbkMi7H8UvlJH+SCGSUc7DF59QipObaukyZYvB1tbpHuaJApRtn6agG3/+zC8W0Prwxm/TBd3BCae/Y+Mjh9a+eHkdm5GjpsrU8bX1KlFW1qafkEi0uE1BRYM7Tnaj5lrv/4dNBNEzXCzmDEqhSueGrNfJWJJQKXLUlL3fUjN3eAMtnIOGsxB6q2Cc8q9qWb5budKziBv1MUBALGTSS9JPbct8HL1zhmvi5AVTDDvtO2oihTSLrPhjTVE+SWcb4fsTKHAcvo/qNO8gicWBcICOCMNgl25iIaOhQ==;31:s70EzqCc4lKFkDJdAMwcpIyLIIVsRS23XCoXPMNXY3ca16+KLowy0lUQYMuYXlHTSxvzozzJjLSjYliu/lRtZNl/sq0NX7hdX/NVeRlkVfNoodUptHqa+BGwUrM/iaH1gLPoZ6XNVFZRcatrMG+x5dzvHqi2jay808O5dLFjDC7zP1X3DKX1LrUrOU5gxkmSUfDm5pKUIE9kw1C5oW+hqCWNTlTIqNXLuh52wXlR2Jg=
X-MS-TrafficTypeDiagnostic: AM0PR04MB4659:
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;20:00IsGB2tfojxwodbxSfbWYSXmbaXs+m5Gx2H17+SVBVmm6+cGo38tdsnawBGeLqZ178+JH13Ipvt3P08m+R8fIeUweyiq/gsO7NWt8KJlOs8xay/XzIgKomjlt7+NUod9kkT0H0Ixa4s2XddeAMOWyyjiWZSWie92exR1pWa9PuJKAxTDPUCYJu5x28S7ez76uIo/xtmUWhOGiTpJgIp0WIGN0Apecmaw9YzucHXQEL2/zbrnKVfTikNxW90MJMT;4:9ZxlQ7VU/XFC4u8Oce4aQk+yAwy63MITFf3d42AatEqvPpxgf3kmB0G2QaZmcEp5yIBybq8tsCKcruJgPoC5HHU08/uj3ISpiweHdJv1Cc4ejSAgzJJaFmFajuRRs2KCXLUhPXg1Okyya0G6pgqbYO2RJSvuAJZscFWeSvvR4NbRACD/a3MoqUaZgf2oHImzx/FTFluMNcb9alXu16RmOZIX22bX49+xbA9tAl/+tE9pPRQrM3ZjXUbpW/lJxoCp0uRwbcwEIAyNLIdv54rNTw==
X-Microsoft-Antispam-PRVS: <AM0PR04MB4659B5ECF3BA6775EFDEA29D9E260@AM0PR04MB4659.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(10201501046)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:AM0PR04MB4659;BCL:0;PCL:0;RULEID:;SRVR:AM0PR04MB4659;
X-Forefront-PRVS: 07584EDBCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(136003)(396003)(376002)(346002)(39850400004)(199004)(189003)(478600001)(81156014)(105586002)(106356001)(6486002)(77096007)(446003)(67846002)(11346002)(186003)(16526019)(8676002)(31696002)(86362001)(8936002)(81166006)(23676004)(53936002)(486006)(6116002)(65826007)(2906002)(3846002)(64126003)(26005)(6346003)(956004)(229853002)(2616005)(4326008)(5660300001)(25786009)(476003)(6246003)(305945005)(14444005)(31686004)(97736004)(72206003)(65956001)(47776003)(65806001)(85182001)(36756003)(66066001)(230700001)(52146003)(2486003)(16576012)(386003)(52116002)(53546011)(316002)(58126008)(68736007)(76176011)(50466002)(7736002);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB4659;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTBQUjA0TUI0NjU5OzIzOjR1NlBKSkxuS1RtY3RRQ0x4cVlrMGo0bk9v?=
 =?utf-8?B?ZDVHMjMyNCtadXJVcytBejZWY0xqeVYzRDA2MEFWTjFndUlmcXNCL2Y0UVBk?=
 =?utf-8?B?R3M3d0w4K1I5S1I0YjUxcjFBVjRFTmwxajZkNGcrbko1dm9nNTNmck9WQ2lB?=
 =?utf-8?B?amR5bFpZemxFNGIyeHN0RU42d3pCVWhtTU5LZVBBdTVVSGcwRWRaakZ5dTRw?=
 =?utf-8?B?NnBTSjYwQzd5VnlTTUY3bGZ3VU9rTEVOZm15aUVhUlFxYVpXSlZBcWl3UndB?=
 =?utf-8?B?Y3dUQms0aVJFdlppQ0lZcXJ3QlNQY055Y1F4ZERqaXphY0hQb3J2aDMzN3lV?=
 =?utf-8?B?YWFXVXd1Mldac2dKaXBESE11Rkd5b1J0dCtrMDhHcWw3OVVNS0phR0ZXcm1M?=
 =?utf-8?B?YmFqSmg1eGRZZEpuSTluWUNxSXd3K3ZjRXkxMnRGNEdzY2t5aHdkOTNkYlp2?=
 =?utf-8?B?bTZYQS96VUkxNDdxODBZY3JXak5kdkRsQUJjeWQ1b3J5QWxvaTR3NVVBUUtm?=
 =?utf-8?B?TldwclpGekJuVFFlN1o0MmN4L3NqNnVZMFdINWttMkt4N3R1ZWo4bzlBSFAy?=
 =?utf-8?B?YzAvTzkzRkN4aDEwRTVCRCs4S09mSEVUSDltcWx1VndPMjc2SWF1NXUvOTkw?=
 =?utf-8?B?bzE3K0hPb2RUUnRnc0FnYUc2TGsrY0FycFhWQ3luK1JnUW53SHRnOVZMdTky?=
 =?utf-8?B?aW85RzlsYVRBS2xZNHh3Tzd5MzVWeU5YbVpGNTVvbFhkVlhTOU1ha3ZMdjJv?=
 =?utf-8?B?UGM3TGxVazFYVnhQeHkrUTdlYVVwYmt6ZldiZXdKUjVpUkE1a3FCV2kzdU9i?=
 =?utf-8?B?WGtmUVA4YVpSWmNIOVUrLzcxYXJZZUlrVTVkWHRTU1RBd1VNTmN4R1Jmdm9i?=
 =?utf-8?B?ZHcrdzNiL0cyaHBBaVd5MnJiekdEczUxTUk1S29CMEdnYXBIQjhkZzBITTFq?=
 =?utf-8?B?QnBMSml3MjNwVDBYSjdGZjU0ZjA5Nm1LRDVmWVhpQTlPZHpWUnA3OUU1c3F3?=
 =?utf-8?B?TU5YcnU5M3dBOEF2WmE4b2ZnclR1UkFHblJWalU4dHYwOFEvdmkxWm00VWNW?=
 =?utf-8?B?ejNDMUxSOXR0ZXd6ZXpxRFZXYVRoeUNxZ0VDWXljai9YNCtEK0loTkZjb3hF?=
 =?utf-8?B?akR3ODMyb1d4YnpjR2lWVzAybFhsTng0d3M1UThyOTFadWZwa21la2VkWkZq?=
 =?utf-8?B?ZWJJY1FQbzhlYmlYNjIxR2ZJWnBsWG9PZjdLMFRWdXhCYlU3SFpIbVF6UmdP?=
 =?utf-8?B?cC9nK2VCLzdsRDNoME1KcXpHWm10Z241Sk4ySnZKMnl2ZDBOdHp3OE5xY3lS?=
 =?utf-8?B?NzhCZW9kY0xQbng5MkNOUkJ2cjJwbmpLY08vQWxvVlkvaVlRSU1SRFZkN2VL?=
 =?utf-8?B?Tis0NmpuRkxvbnBCNG9wWVFTYUxHTnVNcXBPWEdvc2JxdXkyZksvM21HZFc4?=
 =?utf-8?B?MWZ4WTk2enMxVTd3enJZS2YrU1dqUEtRNXVJNW15aE9PekYvc0xweFBTclRl?=
 =?utf-8?B?Y1Rxc2NtdEtTMXBxTXNtZWRCL21Yc01KdmtlWjAwcjNDVm5MM3MyVlV1aG1Z?=
 =?utf-8?B?Q0VCaVBlcUJ5MTA0VVJvNlh3eDQyTGIwWE9TcWZ1U3loN3l6WWkwVWxHTjB5?=
 =?utf-8?B?VktwdGJVNnI5ajh0QVQvNll3QWEzYkE0ZXNBWkdyMnB4UkQ2OXNjaXBlOWFn?=
 =?utf-8?B?SUtmajlqNHVhTlZ0QkZDSmxUOXphTzhoYlJkK3U1dTJ2aEd3RUpMSzJmUEVi?=
 =?utf-8?B?ZlZra08wMUsrQm5vajhWQnVzYnA0RHB2STJRaHgrWm5Xa2x4c0FoWTdQQWdt?=
 =?utf-8?B?S1lFQWVVNVdNT1dTUFpXRFRXbzMxaVNYTitiMkoxVUV0UVp4Y3FvZUVERmlM?=
 =?utf-8?B?T1N0OHJkanhZcGhVQ29WZFJwNmQ2RVRUNnJONWoyd09leWVsaUpscUtqTVk4?=
 =?utf-8?B?NkFzNzkrczlLM1NIbkQvcmlGZkxjcGZDYWxpSTJvWGtHeWZvVmZLQ2h1SnVJ?=
 =?utf-8?Q?5ExCZT?=
X-Microsoft-Antispam-Message-Info: ag01P+bnjAjzUF8cizTu25ymc2RZs8JS75msL4aqSERaZ7XH0pLju59Zq7zEDV1ZkD1K8RlmwsyXK/9d+s/eNaH33+QZ1xNf9GyTd4+npdVMM8X3lwQ2oS46t0luQbm/sRWgliDN8Bd1sW4eQ9piioqh2uTIHfzqRf7stBHIGu38vUgkT1QSi27GnzawQlhg4pgBlELoAj183KDhB/PPBevX2ExWZQxSg2Mglh/fIHtC/BvYbuv8FFGnvQPmJH3uvYNYfW71MmrA8P5+UCz7IZ9lwTmapNRN/g25Dtody7zp010A2t6pcfSBsxEJTLKHbBMSZ2gwW0t8kwekU1XJzo0qeGW/snxp0/4YFAnP2yw=
X-Microsoft-Exchange-Diagnostics: 1;AM0PR04MB4659;6:eVncEAEXjqmRuf2btzc/4dsixYo4Hh5dJST4j62HnQA+HIuyq2WI1VLeDqtq8P3W/pHwkIviLti7KWhKr7edRSB5yDwsae0vQo7cSbScX9jAgccC/LgR/HMRAe3MZojc7Nra5BewtGvZoKiYdoVjL+Jj1kaeTktDmdbguS5X9ThmuOuTeBGor+EWjTi/AtZH1uq/GZoLIBZgKi8btm58dn2sLcGux/nnTuQDNyjAwJFNwD5WpHkGP7NOnTB1/0V7BOhppAMEsYwkA7t+g0kYfoSBhAltfKk8zwq075lP4KeVXVOoRkFW7npm98Gdyam2/w4BnQFPMTGRWfnSa+OtfmW3UHtG0Z0Hcu4Iy11B1ebJDYAvcKfzP+S6xXPvglVUxzRNU3wlgzEK+UFNLxhrzT6jqqrmyPdfIA9ab8lEqWCshlrniX1qI+WpxCD8L5hbxjrjDKQlADWMP4zd9UEssw==;5:c0zJwvCZHlo1m3ac2WO21hCbtMTGpoAo2S9AWFYh2Dogo0hX7cva8gVIzD1zmvqjMjpItYjvvgs6Aw0sLKZdTqznMnCP4P87O3xquErBsqEw6Q+SfmYdi3pK4HjUvhWkFG9DtFL5WWbx1dsqbMejVVXkRjB4SzTKWNE/m75gy1o=;7:B0bkhFIFu6CKaoRZKR01w0oAZW4F9i9OM31VgfeiVaRqPJkSZvZLQSzCtKIBm+3FZl7gBAdSVCdIRP8R/s0BbdAaZw5fgCnATUQ/MUfMoik49hS0wZIAtp/ehvxRarcq/oLFGJOPDxoUVY+rG1wP/H6fzBY1hn4juMy3KmJZLN35HlNXCNQTlTNfEzuPlerV9rYxbxlgyCXSoLVkENcmGAEnkKnS4J/zw5oGh/MHIxbT0KNn4m1/r3uT7hOhJvWR
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2018 07:48:03.5684 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3715dd3-32fa-4453-1de3-08d5fd0345b8
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4659
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7.8.2018 17:54, Kieran Bingham wrote:
Hi Kieran,
> The reg-names property in the documentation is missing an '='. Add it.
> 
> Fixes: 9feb786876c7 ("media: dt-bindings: media: adv7604: Extend
> bindings to allow specifying slave map addresses")
> 

"dt-bindings: media: " is preferred for the subject.

I think you should also add device tree maintainers to the recipients.

Best regards,
Michal

> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>   Documentation/devicetree/bindings/media/i2c/adv7604.txt | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7604.txt b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> index dcf57e7c60eb..b3e688b77a38 100644
> --- a/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/adv7604.txt
> @@ -66,7 +66,7 @@ Example:
>   		 * other maps will retain their default addresses.
>   		 */
>   		reg = <0x4c>, <0x66>;
> -		reg-names "main", "edid";
> +		reg-names = "main", "edid";
>   
>   		reset-gpios = <&ioexp 0 GPIO_ACTIVE_LOW>;
>   		hpd-gpios = <&ioexp 2 GPIO_ACTIVE_HIGH>;
> 

