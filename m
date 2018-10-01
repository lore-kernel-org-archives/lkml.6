Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B95BEC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7544F2089C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 11:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="qe4XGNnQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7544F2089C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729322AbeJASdG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 14:33:06 -0400
Received: from mail-eopbgr40134.outbound.protection.outlook.com ([40.107.4.134]:26432
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729180AbeJASdG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 14:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/3etFW1iA9aU0d8+8erZ/xwPtODFyW5jWmcExOMKZFI=;
 b=qe4XGNnQ41gBSPgpgUOgxBDcSO9exaE6A3QD2YxGtelOsybVkt+8tLtHJarj0CcQvRwPVUxp4BwzViK0QSargexh2MowYE+TpGwNzxYWw92o5sMeMIhxIaKi8TtKRY9vvAc2yIeNQ3B1MtK3AMJqpSkOxkMVuEMxeUwz5zvwCKA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.25; Mon, 1 Oct
 2018 11:55:30 +0000
Subject: Re: [PATCH v2] i2c: mux: remove duplicated i2c_algorithm
To:     Luca Ceresoli <lucaceresoli77@gmail.com>, linux-i2c@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Luca Ceresoli <luca@lucaceresoli.net>,
        Wolfram Sang <wsa@the-dreams.de>
References: <20180927133815.19089-1-lucaceresoli77@gmail.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <9fcca887-1ade-e3bf-67f7-aecd8a60dafb@axentia.se>
Date:   Mon, 1 Oct 2018 13:55:26 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180927133815.19089-1-lucaceresoli77@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P190CA0010.EURP190.PROD.OUTLOOK.COM (2603:10a6:3:bc::20)
 To VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d29078e1-3bfa-4d83-9e55-08d62794c96f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989299)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990200)(7048125)(7024125)(7027125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:5U5FrdlgH+1WqXIVphM+2scnNDdek6GDGTrceD24A9tJvm3X5iDt4yTu/rEWsZw76gMDlq8n5rfqtuwedOXIxxLxiZmK3IPOLhU0SFL1ifrvTAdNFaiCP4Sz3HnY1pp84c9Q5f1R6HsN66RdEMyG7C8xhm/pT+PEu66yRIzNvybIjGIct5jDw/DZ4brKxIgD2epVd6UDRT0n9ONa26/OBMaILQIhaqEGjU4d+wA6uFIORWqs4gvhkuMea0lHJZ+u;25:k8ROGOaiCYHHpeMRiCozMdvyYwn4dlS24mZ/NvbuO3iHI5waDG9pl2thFd6z0dJitiLfeMlOuDf4jyfKm5wxsLc9wRSIKvp58Zayc47K5NUvmtX4YZa6k+WJ5ctZ1lzT1fE7VtT1LXhE/s4jUzspVIduIDIgg/oBSxM/1pJFB46bVx2foQTnPzUuQ8lPORyS0g02N58qNs3DeFPyUFck0gJilBsK4T4bVoydpCQaU0NQAy2rcnFQqSWce11LNkK5+nNkKsq3KpOf1aFFHkf7orzn1ZDnoHB56khw2W67VRvE4L9OmFQWkhrFrOlukVPLSOgRMiUUy1UsIYVzImsu+A==;31:cNcfyCsmTaPxDpT0tdidtxCsNKpjphcgADJ19dbxkCnjD6+ifI298Y48RJjzFtGsVv7IP8k3Ep1/nTvgXtGSDQ6WsEI3L2PgI6EekzpjHWvIdHPtZG/3ih/yYlf361HNnCADnDiJIvbVHH9Zi6XOlhSOtLH1c3aduaORxJzyE/ZhROdsVSifUC+jahzi+0e9nDd7VwxkZhKyeWhrSeNjAkbbYdwNdywd2xEEXJxDR9E=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246153E04448CAC678C5D206BCEF0@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231355)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149066)(150057)(6041310)(2016111802025)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6043046)(201708071742011)(7699051);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:b0DN/JO+RBXZZQILugSsT/yfbSdEshI1vi9dsO5i8eh9DcjrPPDBNaudldsTjYB9Lc2eNUzU3h6oAZpLiFEejyFwxLlg06IR54nPHOIYHt1OjvpP+CT2c0YXHvy3Vuefe/to9mrkrdsTeUMveOfaKbB+CekK2VHOdQkgyHvT9v6x/FycPo+RLpNkyuZuTh1GRO6exGfAXRImuvZ0nH43EFpqsAQxASbWU0wCt/KPaIWmeurwAzF92knIqoxh4HRBJJKBWczGg1ZsqN289N4JHw==
X-Forefront-PRVS: 0812095267
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(136003)(376002)(346002)(39830400003)(366004)(189003)(199004)(74482002)(65806001)(2486003)(52146003)(52116002)(8676002)(25786009)(47776003)(65956001)(66066001)(64126003)(486006)(65826007)(305945005)(81156014)(7736002)(39060400002)(81166006)(76176011)(229853002)(3260700006)(86362001)(575784001)(97736004)(6246003)(476003)(6116002)(6486002)(34290500001)(36756003)(23676004)(11346002)(105586002)(36916002)(8936002)(31696002)(106356001)(2616005)(956004)(117156002)(58126008)(230700001)(508600001)(16526019)(186003)(68736007)(53546011)(386003)(14444005)(3846002)(446003)(53936002)(54906003)(5660300001)(26005)(6666003)(2906002)(50466002)(4326008)(31686004)(77096007)(16576012)(316002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjE7MjM6c0pidkpOQTZnY1BuRjI1RDI5aThhYmxy?=
 =?utf-8?B?V3pvS3plOXhYaHZkTlF3OFU2Q2lVZTVleXovRkxjTmFGOFVVcnowcmhLUWZN?=
 =?utf-8?B?SGlQK2RHUjZOdkwyOHZrN1pLampibW9MSmwzWDU4b3h5VUlwYnBlMzRSZnB4?=
 =?utf-8?B?RnZydk5CNTR2TlR3L2tTZlpxTHJKZnB4TmorTFlUbkVNUEgyL1luRGszbGsx?=
 =?utf-8?B?NHUxUGloNXBZTFkva1psWW5yNzkwbzhScTBIRkI2YnI4QksvNEU5cW83WGVK?=
 =?utf-8?B?K2RYeklJWFFvQXR3ZjR6L1l2R3A3RFc2Z0xBOEl5RmZjZFJLRHZld1ZpNUpp?=
 =?utf-8?B?dG1Jc0lIZnJXcUpESFp1ZVNPa2RZaG1CUW93S2xTUkM1Z3EvaExibk9DZDc5?=
 =?utf-8?B?NWR4ZFpFcGpqQ2k5aTRWTVRqS251ZjNuQ1FmMThPRCtXNVl4SXV3RTNHWkpE?=
 =?utf-8?B?cXdzQmFxaGcvTUJoRk1MMGtOaFF5ODFzQmk3Q0FjcHAwWXArbVhXSHBYRnRa?=
 =?utf-8?B?RUx3QkJIbVEvb05Mc0QxN3FUT1NwSGVPeDJsYzJPdklGOWVkU1JNWEcvZ0Rk?=
 =?utf-8?B?d2Q4cG50ajBNUzV3OTcrUkl4bXdUSXZqVWttdFdvWDlvSHh6citPdzYza0x3?=
 =?utf-8?B?UU9IR3hpZzJ2V1kyUG9udHB5NnNVdFA0WGNSVzZncEUyNEpjWURMUXhrSm51?=
 =?utf-8?B?MGVDdmhOVGlBelg2V2lFa2ZPM0pXQmtzanIrZkd3YksrTFNDSWxKOEpmNFFK?=
 =?utf-8?B?NFAxSVRDWFdnM1l2VkRYRkFVRmdYY3pvd05SZ0xuQ3VEQ0RQYi9Jc3ZOaG16?=
 =?utf-8?B?OUNvcnJzTjVWaUtaSzg1T1ZLV2EwMGJDZzFzWjJMbUt4SnhwcStCLzYzTnkz?=
 =?utf-8?B?VTRTMjI3VFZrZVNicE52VUdUZEFhZlVMWXBtbitrYmdEZ0pjWVUwb3BkS0k4?=
 =?utf-8?B?N2IvMXFqeWNKdWV3ZXVIcEUvV1dWblVlTlhzMVNGMVJzcTRFRFhjL0N6b3hv?=
 =?utf-8?B?K0svbnNrUFN2UjlWaWtXQmxLMTQ2UGpkcGl6WStvN0lCbmdoM1Rxeld3K1Fw?=
 =?utf-8?B?SWM3b25pYXliSUNPd0Z1YUhDQS9PTnpFNWFDMExzM3NaaEhLSGg2RFdoREFl?=
 =?utf-8?B?YXRnN3NtUm5ZejNLNkZPaFRTOXVsZU9JRktUYnlhSG1Wdm9CR0VOTlFiMFB1?=
 =?utf-8?B?QXpYR3hzaG9jNWNEcWpmTDJiZk5ySldWTklvUDdDRHFGaE9xclFrb3IyS08y?=
 =?utf-8?B?ZEpzQTJyRnJwc0liWlIvVlhWQmRSZjZsVlhvRXEraVZhejRyVlkzWFI3SDgy?=
 =?utf-8?B?eUUzNHo3NEQrM2t4b1VqVk1UZXFKZlpmaVgzWnk5MXUvTTRMMUhZUEVDMUoy?=
 =?utf-8?B?MGhsQmVwWk5WZHpGS2Fjdm9Hb2ordUw3N3VWRDg0aUVpOG1NbDR2aXJpZitq?=
 =?utf-8?B?a1RrbVBhSHh1ZW1MQXdjNHBsQmlhWEJHWGRpUTJIcEgxNm9vaU5IbEZvR2lH?=
 =?utf-8?B?ejF3NVJ3akYvMFRTQjJna2F1VzlQSGxFME9kdEE0cFVOUVZyM2hhUThKK3I5?=
 =?utf-8?B?QWpJV2RMWmVVb2FPRWIwNTVxeWw5aVVoNTlJMU91dUFTWjRjeGdwWGZWSzRT?=
 =?utf-8?B?SEo1WWo3eFlFR0lJZzZWUnFEWmpENUNaMnhQQjI3a2oyWVNyc2t0SXk1N05L?=
 =?utf-8?B?L3pMckoyVGZhRXNPY2pZNklPRFVCclg2Q0lZWTVwWjVoNXNONDl1TDQ1WXYv?=
 =?utf-8?B?c3hSbW5FMDhKZmMxdTkzZDhWWE1wSVhqTmE2Y01GUnQ1ZHdKTWlHVTl6MUUy?=
 =?utf-8?B?Uk8ycUl0VHRxVGdsaGZUUVRCNmRLOGM0Y2t2RnVaOUFOZUlHNHJjWEtvbFJB?=
 =?utf-8?B?dXV4MzM4bUQ1cHNJTW4yWlB1b2p6K0ZCMVZJaFV4WjdOMnNUeGF2SVluSi9o?=
 =?utf-8?B?NkxUWDFzdUhuODRYNjk0dnI2QUhSZVkwYjdPWUpQVWpncWVhRCtHNmNrdVpm?=
 =?utf-8?B?SkJxMEV0UnFXOTEvbDJTamNQYjBzNWVRNG4waWdhUWRKS3cyK3A3Z1BKbmE1?=
 =?utf-8?B?alNrc2wvc0JiYUVlRlorZzc0c3F1OGxvc2xhU1ZvRnlOeXVxQ01rU0dpdWJX?=
 =?utf-8?B?ak56Q29kbm9SeUZ1RzJzKzIwTWZqaURROVRJSCtIZlZLT1krLzU4T2NmRnBh?=
 =?utf-8?B?RHBvaklkTUdEWGc1VzR2K3dMRTNXTWc9PQ==?=
X-Microsoft-Antispam-Message-Info: EpAgoT93Dr+dDCvutc8E3ahdeAkbgIivlvRsTLyDd3wazP7Vfj8muIFulXE8NpZcBxPe7XY5EhayJ5Swgn73noLwgj001Dea4c1vr9fc3fEDl/XxQrImJakM8r4JCQ0k79MPf8J4toIBcLPv2zoKxI/nM7XgbDKN9vUo6sIjSEIz0puKkvAd7xrmqFQ0IlckWaYotQBDdrJPomO/1txgvyQKtdQAfog1gy338d/juWsuGEfj10zqMjWhqbtkdou1+TsGWLnp8VtpkqXf0rNjvzsFg6EsUnvg9uZ++NVkKgAEalHfOkqyFkaxIZvR+TSmdY4dS/9hIMDsIwpvkefeSHJu3ELaG0CbBWetRquUzBo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:nU213i8UG3I/+XFkTOVYtZfiIOVlmhaQhcqaVAKJ8dl6PrpT0AL5PhOrUBJV+DIgV30SgD/Pbt0laBy6VTTf4fCMWrRP5k9ym4P8u0tbfGYmKsHD2ArZuvU7K84P0asF5nxbnC3Ar1QQ4aDrfSobhuWMW+k0x54nUdGWy9GvsEKPxqrsj+Li4Xm4aNunAIvHzwSA4sa13njJeceVSGPw02vLvMvRlH15e6CJvmoljQ3yRoIrPb5GnKStxtntugopsssbIbkZTIhX+qxtI13/4qF/iPmGe8kr3G3yOOYQNkl+O/KnPlCsomKwASh6R/IjcSK+MWeSAc++0SkgE9zIoxrak3NVKOPqGuuRnQiHBrXAgNmFwpA0dBLjP8LFYfr6J3krkISW26t+ZtjZgWGKkoppRyPlme/CuA+x52p7E3TFbZO2X9xYDI+Z8zcPOmEJWR48Cj/08D2ukftEBGuXMQ==;5:tsWOlEoF1eEcl8HED3pUPb+J15KMCwVRibkOW15lBubujRqYhBh01/Q14DNVmjR8YYss4ULER7UW/bpQAXOAkiLkLw9Bf6tJps+FIMk9h0TofHWjG0i8ghCwMZSciO6sNq3V7G77I4puyMSa1Lk2gm7LX2antQ718Eb2fidym5E=;7:4prVzZj/lxe/GfZoTQLoh65t5Kw2mm4BzOMMOr1fQ7zRQIAzYE6lPE9HUr+2AJgIvfBJAnHzDvstGQ/XPoKEzEckxrxlkT6xaGxsfmzeIXyxJ2h/fJijbyIMlnoTGFPf9LYBsDu6kIM6DEOB7NpPYN36m/wWEvwzuYPbPZ2+ee5RB5CF6PkWHkaG2vlUQe0gLowzeDuZ2qViWn8QgMwy1G0D6mAaDOKEaRVYd47/XDdC0MQ860VOD5w0nxrNMeGg
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2018 11:55:30.2838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d29078e1-3bfa-4d83-9e55-08d62794c96f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-09-27 15:38, Luca Ceresoli wrote:
> From: Luca Ceresoli <luca@lucaceresoli.net>
> 
> i2c-mux instantiates one i2c_algorithm for each downstream adapter.
> However these algorithms are all identical, depending only on the
> parent adapter.
> 
> Avoid duplication by hoisting the i2c_algorithm from the adapters to
> the i2c_mux_core object, and reuse it in all the adapters.

Looks about right to me, just a couple of nit-picks. See below.

> 
> Signed-off-by: Luca Ceresoli <luca@lucaceresoli.net>
> 
> ---
> 
> Changes v1 -> v2:
>  - include i2c.h (fixes build failure on i2c-mux-ltc4306)
> ---
>  drivers/i2c/i2c-mux.c   | 37 ++++++++++++++++++-------------------
>  include/linux/i2c-mux.h |  2 ++
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/i2c/i2c-mux.c b/drivers/i2c/i2c-mux.c
> index f330690b4125..2b0cc2ad0a17 100644
> --- a/drivers/i2c/i2c-mux.c
> +++ b/drivers/i2c/i2c-mux.c
> @@ -30,7 +30,6 @@
>  /* multiplexer per channel data */
>  struct i2c_mux_priv {
>  	struct i2c_adapter adap;
> -	struct i2c_algorithm algo;
>  	struct i2c_mux_core *muxc;
>  	u32 chan_id;
>  };
> @@ -263,6 +262,23 @@ struct i2c_mux_core *i2c_mux_alloc(struct i2c_adapter *parent,
>  	muxc->deselect = deselect;
>  	muxc->max_adapters = max_adapters;
>  
> +	/* Need to do algo dynamically because we don't know ahead
> +	 * of time what sort of physical adapter we'll be dealing with.
> +	 */

Multiline comments should start with a /* on a line of its own. Yes,
I know you just moved it, but please fix it up as you do so.

> +	if (parent->algo->master_xfer) {
> +		if (muxc->mux_locked)
> +			muxc->algo.master_xfer = i2c_mux_master_xfer;
> +		else
> +			muxc->algo.master_xfer = __i2c_mux_master_xfer;
> +	}
> +	if (parent->algo->smbus_xfer) {
> +		if (muxc->mux_locked)
> +			muxc->algo.smbus_xfer = i2c_mux_smbus_xfer;
> +		else
> +			muxc->algo.smbus_xfer = __i2c_mux_smbus_xfer;
> +	}
> +	muxc->algo.functionality = i2c_mux_functionality;
> +
>  	return muxc;
>  }
>  EXPORT_SYMBOL_GPL(i2c_mux_alloc);
> @@ -301,28 +317,11 @@ int i2c_mux_add_adapter(struct i2c_mux_core *muxc,
>  	priv->muxc = muxc;
>  	priv->chan_id = chan_id;
>  
> -	/* Need to do algo dynamically because we don't know ahead
> -	 * of time what sort of physical adapter we'll be dealing with.
> -	 */
> -	if (parent->algo->master_xfer) {
> -		if (muxc->mux_locked)
> -			priv->algo.master_xfer = i2c_mux_master_xfer;
> -		else
> -			priv->algo.master_xfer = __i2c_mux_master_xfer;
> -	}
> -	if (parent->algo->smbus_xfer) {
> -		if (muxc->mux_locked)
> -			priv->algo.smbus_xfer = i2c_mux_smbus_xfer;
> -		else
> -			priv->algo.smbus_xfer = __i2c_mux_smbus_xfer;
> -	}
> -	priv->algo.functionality = i2c_mux_functionality;
> -
>  	/* Now fill out new adapter structure */
>  	snprintf(priv->adap.name, sizeof(priv->adap.name),
>  		 "i2c-%d-mux (chan_id %d)", i2c_adapter_id(parent), chan_id);
>  	priv->adap.owner = THIS_MODULE;
> -	priv->adap.algo = &priv->algo;
> +	priv->adap.algo = &muxc->algo;
>  	priv->adap.algo_data = priv;
>  	priv->adap.dev.parent = &parent->dev;
>  	priv->adap.retries = parent->retries;
> diff --git a/include/linux/i2c-mux.h b/include/linux/i2c-mux.h
> index bd74d5706f3b..5a4ffca99f5d 100644
> --- a/include/linux/i2c-mux.h
> +++ b/include/linux/i2c-mux.h
> @@ -28,6 +28,7 @@
>  #ifdef __KERNEL__
>  
>  #include <linux/bitops.h>
> +#include <linux/i2c.h>
>  
>  struct i2c_mux_core {
>  	struct i2c_adapter *parent;
> @@ -36,6 +37,7 @@ struct i2c_mux_core {
>  	unsigned int arbitrator:1;
>  	unsigned int gate:1;
>  
> +	struct i2c_algorithm algo;
>  	void *priv;

I want the algo member further up, and certainly not "grouped" with
priv. Between parent and dev seems fine to me.

Cheers,
Peter

>  
>  	int (*select)(struct i2c_mux_core *, u32 chan_id);
> 

