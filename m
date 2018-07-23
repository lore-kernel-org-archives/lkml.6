Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF0EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 621C820846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 06:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="mMoDxVjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 621C820846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387940AbeGWHMD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 03:12:03 -0400
Received: from mail-eopbgr70111.outbound.protection.outlook.com ([40.107.7.111]:17824
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726943AbeGWHMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 03:12:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/RCL0MaV8bukP9phsTQUI0HVGL0514hQQP+Mj5CZkA=;
 b=mMoDxVjcnCtWh+2AQUZmycR0iv7ewFLoxRT62aTqI9Ypa4AwYpH3+dvEX7lumCuOhdpV/xVINby4CExZfuHTaUGyKjYOYaRyfUHYElf+zm+PQJa2mZfsTRoy6XrY52EQe4AXuaACjD7VFeATrdqirQ0bv9+3hhQG4qvl2CWvw0w=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Mon, 23 Jul
 2018 06:12:23 +0000
Subject: Re: [PATCH v6 5/6] i2c: Add Actions Semiconductor Owl family S900 I2C
 driver
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        wsa@the-dreams.de, robh+dt@kernel.org, afaerber@suse.de
Cc:     linus.walleij@linaro.org, linux-i2c@vger.kernel.org,
        liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        andy.shevchenko@gmail.com, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com
References: <20180723034025.5763-1-manivannan.sadhasivam@linaro.org>
 <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <911dc259-7b30-9c6e-2c82-2f4c032b9d73@axentia.se>
Date:   Mon, 23 Jul 2018 08:12:17 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180723034025.5763-6-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1P195CA0011.EURP195.PROD.OUTLOOK.COM (2603:10a6:3:fd::21)
 To VI1PR0201MB2463.eurprd02.prod.outlook.com (2603:10a6:800:54::23)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e97aba7-3fa6-47d2-4001-08d5f06342a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600073)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;3:igFne6eGd9yLPPdPf3fovTTZcWpmXBSs0rtjKdAiyklp6l7R50NFELLJAOzUwLoaZbp3fb1NDSs6FpQe4KXXx4wklvvkJGt0qLu02yvpfHFWAFvjRhSV6kygJGXu/z4PaeqtbjjadCmbTEK/qelHag1qql8yHBkLdiFCqtG8XRMzVYtMUQr+b0v8IPNxwGaI5CsWBZeWpsKjOn70wXdTtztIEzHlGHkonYkEl+ROTOfNWaW+PMg/ItGiQvuU038U;25:12MaDTnBypXnUZCkphk2w9+1/5uK9ZUO8ddmLW5WfLinGAdg4txRuIEAEuhd1KRayBRcWQnkp2oaZZ33hed+GXEzp1AGto5iu6WixrpSBrHv3PWaKAou+7Nmtl3PR6U+ww0nQ8ERLQ9eCnwq8W5yJ1FiJzfsFU22ELFd8k0vyyeY5c4TItx8y8kg8EcH0R+wHnIBMUFO48zESkVOavlRFdoGV3uiZtsU9hc/IqAuzOMHl7ErDG8BTiHf7rgeAlnFSCaSOW1QoUdfNirSlA1R35vahDy3Lhb7W6jjT3rr3pzlP2qkyBRz3FQEcMGJ/ZO/KVlyNK7LOVc8QWdkyBy8pg==;31:gpPxsnHQ/kB6Wt152KMiv5YXnXfhhUvsxWFzqXsVs7P8WZyN4Eq8ipkaHtoG/RtCaXXAofZrjd2pG7EgTA1KkhKHdkSnDdbHKyssbaxVX5BCI3X5zFC8lLOcW+T0ptSOAkIyP4uq6Q2JbrZLkUCOAGnv4YwnzN2x9xwT6WlhGXcKkA8paHGt9HFDTfG28Nuu6PzypUPXUcyfPG+GicFGC8PJL4uOOBiqr+tasYTYSzA=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2463:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB2463FB753B337900ECE0CCFDBC560@VI1PR0201MB2463.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2463;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2463;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;4:bCvaCGn1nbyz654U1E/XI5uMpGSmTUlTkQ3nL8w6/mRVj9PiAVc6Bg51ck7/mZ7bPj0fKfLwW/O5CFzyW2K+ajKAHFq6cGceCi5RmO4luFJgemAzCdB/V/J+Ef6P99grw/xdL/O8hVDv7OqfQg7hxG8X8q6kUDBF07DJLTVOV+neOhEAgPwPRfMajRr7rBut/hax0TwEqFfZoGuQdX7iXf3KQa35+Fg7nq8jArT6lXVlQxW/Ba0dgC2MxgF4gPCa1yr2KtQm2FFA/oxStETV3A==
X-Forefront-PRVS: 0742443479
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(39830400003)(136003)(396003)(376002)(189003)(199004)(956004)(74482002)(53936002)(229853002)(446003)(6486002)(97736004)(11346002)(2616005)(6246003)(68736007)(7416002)(476003)(8676002)(81166006)(230700001)(316002)(16576012)(53546011)(26005)(478600001)(386003)(3846002)(65806001)(66066001)(64126003)(2906002)(5660300001)(31696002)(23676004)(36916002)(86362001)(65826007)(6666003)(76176011)(36756003)(106356001)(105586002)(31686004)(65956001)(2486003)(52146003)(52116002)(117156002)(8936002)(25786009)(3260700006)(81156014)(7736002)(4326008)(16526019)(77096007)(486006)(58126008)(47776003)(50466002)(186003)(6116002)(305945005)(39060400002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2463;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjM7MjM6ZjdxaEMzeUdiMllDelA2WFpialRUN0hW?=
 =?utf-8?B?SXVLWk1EQk1KR2NyT01VWWNSWEU1ZXpHaWJ2ckwvVG15bGxMaUFaS3RTTkdl?=
 =?utf-8?B?cDVUUnFVTThnME9MbGpqTHE3NUdqaEhmekN3ZXlYUk5CWUlOYVZvMFRWR1JQ?=
 =?utf-8?B?T3hNbDVuRWJpY2NpeFVJVitMd3ZMOXFmeDdLczdRR1pzOGJEYlJkenhVOTJ3?=
 =?utf-8?B?MjMzeXQzaGticFNrQlNZWkJWbXFPNDV4bWl1RUFEeHBxOW5HOUNEN3hYa3dN?=
 =?utf-8?B?UTBzWnZRMkNDa3cvaWJTdFBwYmd6dkc1MXcvdVdYMy9jL2tOeXlFYnlUbmIv?=
 =?utf-8?B?VzJ5RDFGcVhjM2pZVjVXeDZRWUdjR1ZvcnNuQWhpMXB5TlhyMTVEWk9DYmp0?=
 =?utf-8?B?aFc5aVBLdVVCMmtDL1lUNWFRUlErTndVbUtnWDFHQmQxeVh3YXFPOGhEUkpL?=
 =?utf-8?B?NkVVWUxSYjVDemZVZDJ1Rkdibk5kN1NiejM1RkllR01UakxTMjFhdm9JdzdR?=
 =?utf-8?B?cWVTeVJpYXVJRVJ3eVgyQi9iTmdtNlpnbmdFaXhFZ3BBK29UVmFQMnM2YS9i?=
 =?utf-8?B?RFZHMUpRZjBhNHArYUI3ZEdsSElLa2d0UG02REFXVGJvK0pBVjl0dDVrYmZE?=
 =?utf-8?B?UW5xendzcmxPb2htbm1TWm1oOGhFQ3ZiRzNhWWUwZE1SL3V2bGxyZld6dy80?=
 =?utf-8?B?cmw0aEloMEVzMnI4dmJ2QlpsaStMbGd1UUwvWUtJeVJoTkRXZnV5NVJqOFBk?=
 =?utf-8?B?MmZsYy9LRk90ME1kTjhIYlZkMjFhOFo0R3dINXFzTDdMdzAxaVBraFdEWnBl?=
 =?utf-8?B?MzJCbDdHV1U4bXByUWlJVDF5Nk9vL1Ntd0FiRFpyR0lqeUs0WlpjQzBLc0Qr?=
 =?utf-8?B?Q1ZhejhFUjBNa3dSZCswVExGYWhjL1NQSG1wZ3BueUV0RDU0WW1wU21NUEdj?=
 =?utf-8?B?TmYvbGRxc3RCajRZV0ZXbzJ2K2RKVVFNUmdUVjlXQ1BWTTlIVUZoTWsyOS9C?=
 =?utf-8?B?cU9lcjlXOURQNXQ2UjRLRlhrTVNLV0txSDN0TmVRWklhV3dJdFgxTEJzTkNU?=
 =?utf-8?B?V3A0RWQ0ZVZrT25zT09rd0Jpc3FRODBEVXlHOFFLdDhhaDBwL3FiK1E1WmxJ?=
 =?utf-8?B?bUJ3dEsxczB6S05pTmFKL0tNS2I3U1hiVWFMY3l3a0p6aDc4NjF1bTNnUDlX?=
 =?utf-8?B?UzA0TU53ZE9aaG1mUFJQUjhDUHhsdkRhNHpZdnd3UnB0aUxHQy9ZNlNDWkZO?=
 =?utf-8?B?WFdjaVJxQXYyck42UUl6bW8zV3YyckU4VFRibmVMQVV4VTdHL1FTdlZITWc2?=
 =?utf-8?B?eWM4ZkxhRzhLc05nbDh4QkJ6UGxDUmFsdk9iQmhmdTdOV1BWQTZGK3A1cytM?=
 =?utf-8?B?UzdjN0o5RG41RHg1ZnhjYjFVUy9wNlR1VW5xeVFUZzltVUpQTjFkVU0xQUlO?=
 =?utf-8?B?YmJPSy9EeGpRakgxNStFKy9LbU9lLy9pRmJCVmVjK0pBd0p2VlVEOUkzNHF5?=
 =?utf-8?B?anJiT1BFYnhqUHhwa04raWRybVlGcWRnQ00xSnpWQXJnZmtEM0JmYmR0Sito?=
 =?utf-8?B?cWJ3a3JkVDJUMWlZU1RGd3lpNmUvaU50V3Z3bHJkcytEdk5HVlYxRFdITysx?=
 =?utf-8?B?aDdDUkJQemRrR1dYUUJrZDBYKzJkRmQxSGZsellWME83MWw3czRha3dycS94?=
 =?utf-8?B?aVN1Mkx1ODZrQUYwSUxGK093MEt2YjZhSFRCbWlRSVdTMVU0a2FndVJISFE0?=
 =?utf-8?B?c1F2WDFFNmpIOFYxekFqQi9QQXRQaVQ5SnlMNmtXUlNHT1BEY0hTVVJWWFd1?=
 =?utf-8?B?bVBFcTFzNkloaFpNVkVEcHRJSGZ0TDJaRlBhOFJSMkFGN3dpT0p6QUNhekFG?=
 =?utf-8?B?MENoNjkrT3pkdlI2bE9mZzRQNEQ4dEgxWkZ4TXc0NUM0K0RNbVdKUlZSK3lx?=
 =?utf-8?B?RHNud0MrMzFTdWk3NFBCQXQxckU1YkgwZEpIVHcwZ0s0dExTL1gxSmhIZVZa?=
 =?utf-8?B?b2lDYWx4Z1l6Wm5VS2pmMXdVTG0vZkxxVXFYZHRaVjdnVGdma3dteUhvWnAx?=
 =?utf-8?Q?Tn/oMlSNnUKb4/dbpZRJ+QvQJH9?=
X-Microsoft-Antispam-Message-Info: vwi3RH1h2XqRRhbjyCekV7DV9aWBIOAr804sumXQUgORrSnOecL25O72U2ay7bUkw1Cy5RA9FQs3iGSbnIfwGf76nKSbdnyx+rn1Xjgps+aeRMb2WMGJUlhoVwZgqgXCDKQQJ/+BS+i0oibOeFFAU98qFoKGZ5BF+NjRIja4t+D0mrFVLE4ulZhERNILwdQS2KJ5t7nPhRqeKiZdiX8QoUvmSM4jFulZyoG7b6xDRkGwjtm8PuMX5ySxx7lgJgqE2OnsjRhEypOMOLDjiGvQWDKxXUzK7jgCf1in01cz/h92Lu4t+ixuYvnx1pro1oPGzXrf+kvfRzt6mm2rl0tFJqIBHLlqE5b3kcc6OuOheLQ=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2463;6:1sn3FDGe7UoQ8AsKJTxg0pmp93TnGAbh1crqMTkPVRUO8zlvGpNBGK5EUeqtoeRF5JmYVwqnHQtRIuYaH+ksPz8GwwNLS3/h55bZLlFxGw7fJGEJ6qAST/tB4LOlYnmu+CtlNDsF4JhQv22WLR4ZL/tMAPjB0VpgmF6wU/TFoK73o4bjIRDNK4nxC4Sx0Rtkb4DCGWm5y01iUf6jVWQMBxCkdSOhhZWTZ8nd5AAX/g11USQi0oUKA0YlxUr7AzDQiA22RclXistpf0K0gd4Fd2HzmgYu+guONS55r0zBL0IWIp+Hnm0jFQvFjiPzLRlKlz6HrJUZY/mRdpjyXLdQlfKBS2vcFqJoZZ0cTgPKJ5PgRThCGJQm2diNp9LDGOM5XAmmQkZSpFodDaplGpZNzMG7mEd4u8vHvYAVgzinRC4+H3TgFfNxJpBEyCQLmhNBup88+Vb6Qi6AgnQqeS0p2w==;5:ITFtU4esws2feajQE67kv3ZBTZjK0rnwCyv+IbKqufeGfisLTvsAftVA81uT9o6k0C27Nzmk/8VtlRgEnbGhgMsEQpUhX9EXmMMNyw2uLxMvunCea1Yb2OaHi49kHikEdVUjbXVGpnNdtsk2RN4rKck7HvCyc4AjtwKOFJWItQY=;7:DsyJTkVfZyqbY1D0PgbL/4KhnxrzfAslg4tSES+Sj031jrwndioL96hprCxRcnS+cEWjUyfXKJyStHitz0c4g0wfKlrQ8HTBHUs5vRfYuKWGxvBHtPZy/ciCxspLh+QKr8OY86hhU08PH5BIWy5rZiPNoecm/TojdUYd0rzzul1ZpW0TEs7bOtt4EfOFzJJ8U/MpwJm2E91v8t92m5Q5IWlugnc2Lov7aMrbDrhKcA8qZepiIBNAe7yLLsBGGMqD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2018 06:12:23.9537 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e97aba7-3fa6-47d2-4001-08d5f06342a7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2463
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-23 05:40, Manivannan Sadhasivam wrote:
> +		/* Handle the remaining bytes which were not sent */
> +		while (!(readl(i2c_dev->base + OWL_I2C_REG_FIFOSTAT) &
> +		       OWL_I2C_FIFOSTAT_TFF) && i2c_dev->msg_ptr < msg->len) {

You moved the OWL_ line to the left instead of right, so this is still
misaligned and thus not helping the reader.

Cheers,
Peter

> +			writel(msg->buf[i2c_dev->msg_ptr++],
> +			       i2c_dev->base + OWL_I2C_REG_TXDAT);
> +		}

