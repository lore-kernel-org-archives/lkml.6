Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9EBCECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:53:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA3DE20652
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:53:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="fNHfprTm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA3DE20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730913AbeGRNbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:31:24 -0400
Received: from mail-db5eur01on0136.outbound.protection.outlook.com ([104.47.2.136]:42656
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729374AbeGRNbX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:31:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy9NuEp2a3Lb/eg2t3tQk40c8awhYgEVJX8wBqPeFuc=;
 b=fNHfprTma9tDrZOoqdfwTN85cDdLCU+IJ13tRy6Gcj/fy76ofXTjtQNugYwRGzDYNWickmDnzdlbFObmzbAHsXnGacwuPhVlizgnu2Dc52ZAKA5aA3giq21KXaPpxmxgL69yzx6V1ZzdNUR2GFgsJFrOR+GWG2VM6EuW38KmuVA=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 VI1PR0201MB2461.eurprd02.prod.outlook.com (2603:10a6:800:54::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.19; Wed, 18 Jul
 2018 12:49:45 +0000
Subject: =?UTF-8?Q?Re:_[PATCH_V2_1/2]_mux:_adgs1408:_new_driver_for_Analog_D?=
 =?UTF-8?Q?evices_ADGS1408/1409_mux_=e2=80=a6?=
To:     Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20180717134218.5642-1-mircea.caprioru@analog.com>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <e2682f87-f1c9-de44-d543-6437f29ac638@axentia.se>
Date:   Wed, 18 Jul 2018 14:49:41 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180717134218.5642-1-mircea.caprioru@analog.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR05CA0253.eurprd05.prod.outlook.com
 (2603:10a6:3:fb::29) To VI1PR0201MB2461.eurprd02.prod.outlook.com
 (2603:10a6:800:54::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd379c97-84ff-4379-77d5-08d5ecacf0ea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:0g5fglPakcKPt4xMugtImsmTH75K161KSOZdNiaVJsdva8l3Irrgc/r96gZS7nkjCp0M4rlyaCPhPna6oVCreKmQmSCf58alAPAbB63PFgnpKMWuTACwUXFjufd0XRzblcfoZKtYyiaLgjoJtCZs/nonomvGdH4ZwvwNHXSM0RX76tCFvuTIuYlHoNlztdoBEFHDDkKbzg1NhbqbsYOSQdBk2WSBdXjRcABlIqUR2rerXrT+Gr8n91llPZJccDnl;25:4YWNZbvv61yN8G2tsUZ2pJHyu/0Q8RcA7hu+Fbk4NUq+DVt+EacK5AogiwX2s2esnlPdptVoCsT+xQB46pT80Ocy9pyeinlKxzb6343Blwd+BfvsJLeK2e3NgPcKHTK1aLEdlXxcqOb5uO8dgURUnTRxZoGzHZzvRrEonAKhIiNhMpG5IFFHoEnutb9z2bTjBGiSiebYZf+r8V/k7py8KZJHGUNp9LeFsQlks9/KAeKe54ofspP5S5FvQaQGSfAZ8UyxJszumHJtOgGa67qz4R1sGwN31TbHB26951doY5ZknUMUizyqpXmbk87728TccMlXhB1VUixkymUvHALdow==;31:RaYVRsh4rbU561nFChOaQD7oA9kqVULma7brx15AiAYKSlGYNLlH9w4pZZZuQkvUr2wwbHDmFh/xP4EHkvJW1Tf5XcZHQImv4jyazpkhfv5k5AyMapcmHq1O8FjsBWOtcszJrq+HzJOQFkguBtAQedgNRYdaRQsYo1Pg3BqZz5bHU7VjvaOGROmPVGFMpaf9w/8mraf9WXcXQJ5qXnnM+M9Iq1TJwnngX1sA/VSnwDM=
X-MS-TrafficTypeDiagnostic: VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB246140C7C0CF78ADE458A9C6BC530@VI1PR0201MB2461.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123564045)(20161123558120)(2016111802025)(20161123560045)(20161123562045)(6043046)(6072148)(201708071742011)(7699016);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;4:YLCzYaj8Q0S0eaUF1yCqeH0URCTPz5zxHJ1smXWNqKEmJi5ewrdHVqpQFQ27h550Vp0nKfVDVIOl/JR2TdWsvPqSfNJoeZ2g3aJYmICVx04e8F7vq3yWey5Xt0ojfYcAs5WsRpUOjr2bxKRArRZDHwT0PCuAYDnJpXQRp5A4nzpELILHv+XfDd+mClT4YUV2tNW7r+L8Et5NdZZXrd5W/3N9HuiPcFeIeR3VJP+VF6uBgeUO7sohT8wF71slHikm3YyH9YTjSgtAeVeBDQxVpdfsA0MLfOsmh/5l+GaxNFJXCAuLVvPiC6mvOONzj7KdS/onXBWZq3tTODz6OlcF1zlON2aHtoeAaP0iphaLERE=
X-Forefront-PRVS: 0737B96801
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(376002)(366004)(136003)(396003)(39830400003)(189003)(199004)(54534003)(6916009)(305945005)(36916002)(2616005)(956004)(486006)(53936002)(476003)(64126003)(58126008)(52116002)(81156014)(16576012)(52146003)(8936002)(74482002)(7736002)(23676004)(316002)(81166006)(76176011)(65806001)(2906002)(26005)(386003)(3846002)(230700001)(31696002)(6116002)(186003)(3260700006)(16526019)(25786009)(446003)(2486003)(66066001)(77096007)(6666003)(65956001)(478600001)(53546011)(97736004)(86362001)(6246003)(36756003)(68736007)(14444005)(105586002)(50466002)(31686004)(6486002)(47776003)(5660300001)(4326008)(11346002)(229853002)(65826007)(106356001)(117156002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR0201MB2461;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjE7MjM6S1RKVlQvRzRIcEdWdUliZ2NXSmgrVXgx?=
 =?utf-8?B?TWNUMGdtOFhVN1ZzZE5EM2FYL2g0L1hLTFlSY09BZXREek96MktjSU11Zmhy?=
 =?utf-8?B?citUekZ5ZHJUaVBEYU8xU0JCazNFZkQ5SDNjbGxRb1Jzd0ZtZ0xQOHVmVWN3?=
 =?utf-8?B?eVloTjBZejZnayt4ckc0bVkxY042dUxwNUR4Y3NJMlhEczlNTmFRbE92aytk?=
 =?utf-8?B?WjhHYlFsYWRDV3l3eXh5em13SjN5enJ5ZTY4V2lvZVlXRmkzVTVqM0VwdEtL?=
 =?utf-8?B?dE40alRoMWtoWWdGL1ZtTzBDZ0NqRlZMbGNqekhWN2JpcHdKeDAyZjBOSmNC?=
 =?utf-8?B?UUN6eFNsaXNxZ0pYREhOS2dvb1dSR2JZd2QxYTkybXJyRWJPcCtGZk0wVDVy?=
 =?utf-8?B?WHVuK2VoN1J2K1NkZFBvTDR6aVpxQTRkeGVxamhCQmNudlpFVlR0MmtUZ29L?=
 =?utf-8?B?WG5QbkpianBUdEgrVDRrSTg0RmpaeWk1OG1QYmpQeHF4WGxUMlBYYUUxTHFy?=
 =?utf-8?B?allYNjRBbit0MU9NLzFIZXZwMFRSVlcydDVob3pPekhwczQ4YlFEcnJoNkc1?=
 =?utf-8?B?d0g4emtyNUYwdmxTUzVnZ1E4OXlxSFpqMExmOGpyN2ZuNXN2U1B6Y1N2Y0pZ?=
 =?utf-8?B?cVBYdHNWTmkrZnJ0K1hmakt5cWZ5OFV0d1BWUDdIY09maGNhYUIxZ1hDSUJS?=
 =?utf-8?B?ZUJWTE94eExVRlNseDJZNTJGemlRRytjSmFFUEVFQlNhc21ZaDYrUTVkTWlp?=
 =?utf-8?B?bHpPemtDYnpmcnd5bmtLZzVOTzZKWEdkS1FvM09HUk1SeUpaWENnNlVmMHB5?=
 =?utf-8?B?RStTandqclk3S3F5ODlCOVBwbC9pQmdGVGJUZW82ZUNkYTVVdTVET2pPQ29x?=
 =?utf-8?B?N1FRQ3ZySTBFMnVwdVhYWllleGdWb0VHUjZRWkxIRjZJV2luZFRWWUpleXFr?=
 =?utf-8?B?dXl0Ly92NTBHOFRpNWtJZk1QeTZLRDhSMDg0dk9TRXFsK0FDTDJIL05wTEZE?=
 =?utf-8?B?UTVSamNIK2NmODFkeTlqTzU3SE5MRHBUQWpCWTBsZllBOG11R1FNbDJpU29q?=
 =?utf-8?B?T1dOV1VzUlNIdTYyT3p4Q0NURm5veXNtQWJodDl6VkFKc09hRlJzcklma3lE?=
 =?utf-8?B?MTVMSUw4TGFkR2g0VGRkUytoODlyejJMbFZhSkxvUmIwMGN2ZWliek5PZTNE?=
 =?utf-8?B?OWtXRlFUamFIYWttaHdDeGovdFhiTjBTOHBDckxCUkU5Q3NpY2dEeUVuN1BV?=
 =?utf-8?B?cjlZc2ZLbGNvSFV1UXA2ZDdGR1NKMEtQem9oUTYyUXlzd29ZaCtUdU5yUURI?=
 =?utf-8?B?WjluZkhzWWh6QzhWOUxueWRiaWFOdWpScU94UDFJSmowOUEyNGtpM3VWUUti?=
 =?utf-8?B?aHRMUzNEUEdUY0dXMmJjTzRZbXEvZ0JFbjlnOXZKTTRZUytJRDAvZ1hqaXZN?=
 =?utf-8?B?T1BiY3FWVDZ2RHhPZzlIQ0tBSFBMcUVHWjYzRDYxWkN0S2taV0d1ZXJ4ZXpD?=
 =?utf-8?B?SHh6eURGQStUMStlamZDSTJEN2N6VHRWWEx2QWtJSW01Z0dvU2ZNL0tVb08w?=
 =?utf-8?B?YzkzQzRaOUNzUWphZVV5eWJkamhSWklWWDBybmRJZ3JlMWhZV3FBOWd1SDl5?=
 =?utf-8?B?dWJVUWh5QllYQXFobTFhQTVmNjFDTDB3QU5CUmc0N3BLSjhGbFNxTW5QcUU5?=
 =?utf-8?B?NHBjc1pkQkZibm45RUpiRmx3REhBbnpnUmM5TUhYKzZxOGRtM054WjVPSGg0?=
 =?utf-8?B?OEowRVhMZWRGanU2UVA3NS9kbDJkODB1M3haNEw4MFZUQkdHWlZNK0tkUDYr?=
 =?utf-8?B?RGVRaFB6aCtGdDF1dFpLWjR3ak9JM0Z0d0tmTnZWOVpNcytMRHNySTg1Uk5F?=
 =?utf-8?B?MUNOU1N3QU5mMG9pRmhHWUZUMlJhaHlBYUR3c1Fkem55blNkc3I2TnZvUlNh?=
 =?utf-8?B?Qm1mMmE3SE5OcXh4dDJXUzZKc1JzR3hDNDVtVzBEcVY4OVIrYmZFdWdEalov?=
 =?utf-8?B?WGxhNjlESjhCc1ArUmc4WGh2TmxDeUlzeXdCRTlkcHlGZ0lBUHAvTkVXbjUv?=
 =?utf-8?Q?cTfptD4Rm+tEGKXEnZwe7qJRVtM?=
X-Microsoft-Antispam-Message-Info: ho98/TE9SFEq78TY1oWYUvgRvv+dGU60sG4lp8CaKeyDJhIJW4BjaGuyExXYYFELoTciHgbY13mODvaI77k/Gx5Wh9kus5x1bsz3kl62KNKmZzJDWwZHsiUoCjP3jvbHkgAvRBI6DCPtMLNmgmigz1UvA/MmfneEB0rbchWg3GJn6JbZZ4/4LxPsEE0tVh03fJSXtbEROSLMb3kxiZM8FyiiaCicHKDNIGzLhjQqe7lwLH0dSE9oA5+pHPoXMrFkmerKhwUUQDL3DOptJMRqiKqj0xIK2iDOxT54DzNLHJqhVYEFgCqY8iwuq8ydlZ5qZEdet869RJUgqhvsuQJ2xfNk4A6wvgWw6yXbasvlGXo=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:/sENiuu99JgYcmoRxzXExLL27Atam4kLJZMCoRNdGZDgscpFGGmrHnZRFN4mUj/791DKq2SImjBAV5XPmJfSIgKLiP40E9MN2xDhEAxNPheoNRVven3g25b3QPf5cgG/NqAGqVaX1O9WuoHBoK6Y1RMSXnx5Hfp6dm1uGCT9INl+UtNh6FBtesf6BzLqypDvdZusIBH6Ku55DxvPGiUUltNdur1JlWevUNE8+IbhfFo+WihY2RrT6y++aziNW841G576L7CozK3PcHSnM93Capwx5R3sl9VAbYHyP0E26mtMnurAWNd1IxkXvviROo4p019LU8sialFspE2Uxen+UhfjrwcQa1HRo/HK5BBPZvbA6qvdlU5z9bEdtA3a3BLKKoC3Bas4h9XAtNxUassxOnV/KL3ql8KTzg3GjslpbfZ8iGcMIxpLIhOc6K8qJc4826Vuofpd6PPq4d9cAviZvw==;5:VTAyt7m/RjDcqfo16oFUqcZVioxW7vReac68jwZIxMzaXaMXYB2rfbBu1dvVhH7LAbpAwn2JZmZeMcshiNv9QgOPJ2HvvUmZU9/wnkFXZSK5LaHCc9JpPCZeGm4yuz+lx9wxoImCS3mYKV4M1CpblaykTEe8CADgJsyYY27w8js=;24:X+6Zlzkdh/U4oxK0hK4nEOPND1gCMwptvgqlH55k5n2EFoF8A0EHnNZ5mZQpoCslKEcvV/+C/wgR4UlGS+kz3J7yiGCVYhUE2W3amYI/14k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;7:MWkl6ZA6hfS9cmoK3DOk8tIxxQiUD8uu4Rn/NZvC5M+0A1QIlfBnduVyJyXiTtuEoqUqgIAx9082QWgjx0ypm2ZUQU5cQeHXfnLPJXdPbov0AhbRGYur1cV50lcC0e9AxFSJnmYIJ+g4OXl4riAfmA9ip7mTpwYlb2QNztlY8h9df4MpZGp9/HbYIJgru0U4J4M9ixJBqIhWDUJnDCDku/HdTHKCuydnQGVsonJtbgHY/AZV8I4gyj8E3/sDeGxV
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2018 12:49:45.7908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd379c97-84ff-4379-77d5-08d5ecacf0ea
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-17 15:42, Mircea Caprioru wrote:
> This patch adds basic support for Analog Device ADGS1408/09 SPI mux
> controller.
> 
> The device is probed and set to a disabled state. It uses the new mux
> controller framework.
> 
> Signed-off-by: Mircea Caprioru <mircea.caprioru@analog.com>
> ---
> Changelog V1 -> V2
> - removed adgs140x wildcard
> - removed cells verification since only 0 configuration supported

Ahhh, the two muxes in 1409 cannot be operated independently, as this is a
"differential" mux. That simplifies things quite a bit, and good thing you
caught this early!

> - added id enum for ADGS1408 and ADGS1409
> - sorted includes
> 
>  MAINTAINERS            |   5 ++
>  drivers/mux/Kconfig    |  12 +++++
>  drivers/mux/Makefile   |   2 +
>  drivers/mux/adgs1408.c | 120 +++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 139 insertions(+)
>  create mode 100644 drivers/mux/adgs1408.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 192d7f73fd01..458d42d6f4f3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -810,6 +810,11 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/i2c/ad9389b*
>  
> +ANALOG DEVICES INC ADGS1408 DRIVER
> +M:	Mircea Caprioru <mircea.caprioru@analog.com>
> +S:	Supported
> +F:	drivers/mux/adgs1408.c
> +
>  ANALOG DEVICES INC ADV7180 DRIVER
>  M:	Lars-Peter Clausen <lars@metafoo.de>
>  L:	linux-media@vger.kernel.org
> diff --git a/drivers/mux/Kconfig b/drivers/mux/Kconfig
> index 6241678e99af..cf825e9f47ef 100644
> --- a/drivers/mux/Kconfig
> +++ b/drivers/mux/Kconfig
> @@ -21,6 +21,18 @@ config MUX_ADG792A
>  	  To compile the driver as a module, choose M here: the module will
>  	  be called mux-adg792a.
>  
> +config MUX_ADGS1408
> +	tristate "Analog Devices ADGS1408/ADGS1409 Multiplexers"
> +	depends on SPI
> +	help
> +	  ADGS1408 8:1 multiplexer and ADGS1409 double 4:1 multiplexer
> +	  switches.
> +
> +	  The driver supports driving each switch independently.

Remove this line. It is confusing since 1408 only have one mux and
the two muxes in the dual 1409 cannot be operated independently.

> +
> +	  To compile the driver as a module, choose M here: the module will
> +	  be called mux-adgs1408.
> +
>  config MUX_GPIO
>  	tristate "GPIO-controlled Multiplexer"
>  	depends on GPIOLIB || COMPILE_TEST
> diff --git a/drivers/mux/Makefile b/drivers/mux/Makefile
> index c3d883955fd5..6e9fa47daf56 100644
> --- a/drivers/mux/Makefile
> +++ b/drivers/mux/Makefile
> @@ -5,10 +5,12 @@
>  
>  mux-core-objs			:= core.o
>  mux-adg792a-objs		:= adg792a.o
> +mux-adgs1408-objs		:= adgs1408.o
>  mux-gpio-objs			:= gpio.o
>  mux-mmio-objs			:= mmio.o
>  
>  obj-$(CONFIG_MULTIPLEXER)	+= mux-core.o
>  obj-$(CONFIG_MUX_ADG792A)	+= mux-adg792a.o
> +obj-$(CONFIG_MUX_ADGS1408)	+= mux-adgs1408.o
>  obj-$(CONFIG_MUX_GPIO)		+= mux-gpio.o
>  obj-$(CONFIG_MUX_MMIO)		+= mux-mmio.o
> diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c
> new file mode 100644
> index 000000000000..a5192c5e484b
> --- /dev/null
> +++ b/drivers/mux/adgs1408.c
> @@ -0,0 +1,120 @@
> +// SPDX-License-Identifier: GPL-2.0+

The preferred spelling is GPL-2.0-or-later

> +/*
> + * ADG1408 SPI MUX driver

ADGS1408; you are missing the S.

And I think you could/should mention ADGS1409 here.

> + *
> + * Copyright 2018 Analog Devices Inc.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/spi/spi.h>

This #include sorts after linux/property.h.

> +#include <linux/module.h>
> +#include <linux/mux/driver.h>
> +#include <linux/of_platform.h>
> +#include <linux/property.h>
> +
> +#define ADGS1408_SW_DATA       (0x01)
> +#define ADGS1408_REG_READ(reg) ((reg) | 0x80)
> +#define ADGS1408_DISABLE       (0x00)
> +#define ADGS1408_MUX(state)    (((state) << 1) | 1)
> +
> +enum {
> +	ADGS1408,
> +	ADGS1409

Add a trailing comma here, to make future changes less intrusive.

> +};
> +
> +static int adgs1408_spi_reg_write(struct spi_device *spi,
> +				  u8 reg_addr, u8 reg_data)
> +{
> +	u8 tx_buf[2];
> +
> +	tx_buf[0] = reg_addr;
> +	tx_buf[1] = reg_data;
> +
> +	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
> +}
> +
> +static int adgs1408_set(struct mux_control *mux, int state)
> +{
> +	struct spi_device *spi = to_spi_device(mux->chip->dev.parent);
> +	u8 reg;
> +
> +	if (state == MUX_IDLE_DISCONNECT)
> +		reg = ADGS1408_DISABLE;
> +	else
> +		reg = ADGS1408_MUX(state);
> +
> +	return adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, reg);
> +}
> +
> +static const struct mux_control_ops adgs1408_ops = {
> +	.set = adgs1408_set,
> +};
> +
> +static int adgs1408_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct device *dev = &spi->dev;
> +	struct mux_chip *mux_chip;
> +	struct mux_control *mux;
> +	int ret, idle_state;
> +
> +	mux_chip = devm_mux_chip_alloc(dev, 1, 0);
> +	if (IS_ERR(mux_chip))
> +		return PTR_ERR(mux_chip);
> +
> +	mux_chip->ops = &adgs1408_ops;
> +
> +	ret = adgs1408_spi_reg_write(spi, ADGS1408_SW_DATA, ADGS1408_DISABLE);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = device_property_read_u32_array(dev, "idle-state",
> +					     &idle_state,
> +					     mux_chip->controllers);
> +	if (ret < 0) {
> +		idle_state = MUX_IDLE_AS_IS;
> +	}

Drop the {} here.

> +
> +	mux = mux_chip->mux;
> +
> +	if (id->driver_data == ADGS1408)
> +		mux->states = 8;
> +	else
> +		mux->states = 4;
> +
> +	switch (idle_state) {
> +	case MUX_IDLE_DISCONNECT:
> +	case MUX_IDLE_AS_IS:
> +	case 0 ... 7:
> +		/* adgs1409 supports only 4 states */
> +		if (id->driver_data == ADGS1409 && idle_state > 3)
> +			return -EINVAL;
> +		mux->idle_state = idle_state;
> +		break;

If you reverse the test above, or if you rewrite it like below, you can fall
through and get the error message (w/o duplication), like this (since the
MUX_IDLE_... defines are both negative, but you already depend on that):

		/* adgs1409 supports only 4 states */
		if (idle_state < mux->states) {
			mux->idle_state = idle_state;
			break;
		}
		/* fall through */

> +	default:
> +		dev_err(dev, "invalid idle-state %d\n", idle_state);
> +		return -EINVAL;
> +	}
> +
> +	return devm_mux_chip_register(dev, mux_chip);
> +}
> +
> +static const struct spi_device_id adgs1408_id[] = {
> +	{ "adi,adgs1408", ADGS1408 },
> +	{ "adi,adgs1409", ADGS1409 },

This looks weird. Other spi_device_id lookup-tables do not have dt-style
ids like this; they have the equivalent of "adgs1408" and "adgs1409".

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, adgs1408_id);
> +
> +static struct spi_driver adgs1408_driver = {
> +	.driver = {
> +		.name = "adgs1408",

You have (silently) dropped .of_match_table since v1. Why is it not needed?
I felt much more comfortable with what was in v1 for this area of the patch.

Cheers,
Peter

> +	},
> +	.probe = adgs1408_probe,
> +	.id_table = adgs1408_id,
> +};
> +module_spi_driver(adgs1408_driver);
> +
> +MODULE_AUTHOR("Mircea Caprioru <mircea.caprioru@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices ADGS1408 MUX driver");> +MODULE_LICENSE("GPL v2");
> 

