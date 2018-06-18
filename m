Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C3AC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:33:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C93C2208A6
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=epam.com header.i=@epam.com header.b="kSSqfOKa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C93C2208A6
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=epam.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeFRMdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:33:00 -0400
Received: from mail-he1eur01on0063.outbound.protection.outlook.com ([104.47.0.63]:50267
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750910AbeFRMc6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:32:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=adUMI9ld2yNj3vYYxIpkmruMdgdD7NvnpImn3OjoFfo=;
 b=kSSqfOKa0IwTZg1LBdf3qWbV9PaXidRztYo5Fpohoxa0ziGD4au4s8QcbM0Hekub4vkEGoYQPYtgqQjB+bW8874yZJ/ylBhBBZ16xnvq5b6jUVjVAayE6DhUzoDyHlz7HWTSawwkDCVmb1X1qccAYYWT7Rh3OF0tOM5+7m2pXa4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Oleksandr_Andrushchenko@epam.com; 
Received: from [10.17.182.9] (85.223.209.53) by
 DB3PR0302MB3211.eurprd03.prod.outlook.com (2603:10a6:8:9::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.863.19; Mon, 18 Jun 2018 12:32:53 +0000
Subject: Re: [PATCH v2] drm: Replace NULL with error value in
 drm_prime_pages_to_sg
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Oleksandr Andrushchenko <andr2000@gmail.com>
Cc:     xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, airlied@linux.ie,
        daniel.vetter@intel.com, seanpaul@chromium.org,
        gustavo@padovan.org, jgross@suse.com, boris.ostrovsky@oracle.com
References: <20180618060709.14290-1-andr2000@gmail.com>
 <20180618122951.v55dxtjg4azezjvg@mwanda>
From:   Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Message-ID: <a0b8ffa2-cf75-5a8c-7341-29855780fc00@epam.com>
Date:   Mon, 18 Jun 2018 15:32:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180618122951.v55dxtjg4azezjvg@mwanda>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [85.223.209.53]
X-ClientProxiedBy: AM5P190CA0033.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:206:14::46) To DB3PR0302MB3211.eurprd03.prod.outlook.com
 (2603:10a6:8:9::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b0bcc130-7690-480c-7d9c-08d5d5179d55
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(7168020)(4627221)(201703031133081)(201702281549075)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DB3PR0302MB3211;
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;3:aSZuA8RQ3J2qtMj3FCOer3fWqhh2glFMrzWtlJbf/bEI0x2QXSTv2Frvshdawu9eyuiGnze7UluioxcDgcOkl8VYqfZGhSbwVSIZPGo5l/v7gOwt0O51Tk7l89Kgv1QL4mbIsRpvT9WdqnR20v1CfMQLF4UTiyWK2J8AOsRS0e6ooygaAAt3fGa6cbCLIWQ0gdJdj1GXEu18B0bFuzuL+eh5tGXHEURzh8G+f3FZzlX9WcpXx8PWGTQeOaiMf5ZT;25:f8clmCQ0eFW3Rlk4s9HJj0J6QAf6OVHvxlPJhRUMYuavishNHRv1hXuAyCn4Lwwl8haHl6CoT8W35BwsirC6qLf8JxOztpO59EKoesjWoLsMpiQA6yPZ5b0VPINEcrMhQgi8AWIkdRUBsg2vHw5A5kHtHBpKJCjBQvY2hhvK26wgtIgpiBp2Cf+9qlEmXUp48tseHg61Cr+PIL84bjXzJx6J2W4D/IX82ALRteElsZuZ0hzz+eNe7xthJx5c1RAdII4Vjkoucr6tyVaAcXnYN0MvNVDurF9ZF8b3tSqu2F+pbWNQb3dqUAv6AhnoP6y+fMAy2LKstZEkQINQcnbUlA==;31:xOwDekXMOLEGwwCSJcoZlshvDjkhUyA6u2mQjWzLdSRTkQdb9ISJuDlSfAYml2BNOx2zxfoWfl1fk+dBuOp0YktjmnAzj8cPOnGV48MriW+NBufPd8f6d/MnhCx/xTAFmvtULM9x5hezped2ZNP7ABfCi6JLl5sClCGsn+cGKXM/TXKFuolzwyNxc820ClotrLyeCN2XRKjRD5ZSVq2pJ2Ja4S8n/Ezz4zHOgKpXYvg=
X-MS-TrafficTypeDiagnostic: DB3PR0302MB3211:
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;20:mnKx+l9GceKjLsCdtTZxULZUDpa23LVXRIFsw1N9KXMLA9sNIEdfuKSwXvygJewBcI4KCpGb/FniPSMB4NTzKWD+RIYrpB5ss7W782If4DJgEUY9moPCB0cSSf0cRyR5r5kwqgVleeMp+FGgmLHTvK/QLne///cDyTGiYtyaCWnJyVykvGBp7HtlH/49rvAsRSus8OoGH0xfB6q9zWy3tjaljR7M44eeK8antGMG0VXXdxV6iQU2trMQcuuLL3lAFpqeosgGbG45ooPIaKQZZ8pX32lGj0CHX+sC25nEoxsiAEAeUCL7CNHXmDXMpD/GuJRlRqSrD3FlDO7fnIPXeQLUzt487NYy2rfJ9+jMi2oj0m9m6IYmbbVzAgq0zY91EkBqvsnKamBUArozVTXSF1K/FaPQGGAOdexnsz3tOe9jLp3rx5vfpyxJH/eBj37Y/4O6OyfLt+B1BR+O3Fe0gowDA93YJ8z5HVa8RNQUdMGy793lmFw4rhpH5PXZzSRh;4:yFnLsuVIF/5QhbRvJGeudGbO5ZMdJkRYZFnOnHvP60AS8ZHLvEsxlhv4KDczZAkOL36BcCySe2zT+JV2YuJo7ghYBz5Bo9oX91zGq9I2ZASIHFUgH2v8zHmDOwqeib6psYes7G7L73XEfRe6tBbwwhhvbNQEPYAH4NWD9k+tMtqoQea9lrOLEpdxZD31BAuVSbUs7akQ7Cj4P/47Ltmi05pZKGkvvlJwXMvQZqsx/8nmWvaUGTIYqGIQjhx1MtCiYfVQkwzQImOy8ghC/L3tL3WeNGu/vNzxuIsiwGFTYrz9vm5cHl55k+UX8vwToWDY
X-Microsoft-Antispam-PRVS: <DB3PR0302MB32118E8CA58C9D70BCC80ED5E7710@DB3PR0302MB3211.eurprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DB3PR0302MB3211;BCL:0;PCL:0;RULEID:;SRVR:DB3PR0302MB3211;
X-Forefront-PRVS: 0707248B64
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(366004)(346002)(376002)(39380400002)(396003)(39860400002)(199004)(189003)(5660300001)(186003)(65826007)(6666003)(50466002)(72206003)(25786009)(4326008)(64126003)(53936002)(26005)(7736002)(2616005)(6246003)(956004)(77096007)(16526019)(11346002)(105586002)(476003)(478600001)(31686004)(80792005)(106356001)(39060400002)(446003)(67846002)(7416002)(36756003)(305945005)(55236004)(23676004)(2486003)(52146003)(486006)(52116002)(76176011)(97736004)(386003)(86362001)(2906002)(81166006)(81156014)(31696002)(53546011)(8676002)(6486002)(8936002)(68736007)(58126008)(316002)(16576012)(65806001)(229853002)(65956001)(66066001)(3846002)(47776003)(230700001)(6116002)(110136005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB3PR0302MB3211;H:[10.17.182.9];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: epam.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjNQUjAzMDJNQjMyMTE7MjM6TUtaODFMclFTbENkMXk1YWliKzgyVzBQ?=
 =?utf-8?B?eWVHdDlubFcxZHd1N3FXUlhUbnlnLzRoTGVLTXdJc2JDZ0U3cGs2Vi9zK28x?=
 =?utf-8?B?cXJlRUV5aWtIZXVrblRqRnh0MFdqSGJmVWQ2c3hKVWUrVG4xOHUrNWp2cURI?=
 =?utf-8?B?Zmh0akpJbXI4TkM1MlpHNmJSSE96bmtKOXlZREZWZ2tEYXdnOUljMGZ2VU03?=
 =?utf-8?B?SkN5YTNYeTlab2pCTXV3VmFPbStFdXFNMy9WVTFHWHc1dGRHVFUxWmRORElE?=
 =?utf-8?B?d2U3UXB3cnYyNGhuT0lOejh1ODJqa0V3YlBtcW9JM2ZJSE15R1VCUGtjNjFX?=
 =?utf-8?B?RDFSbE11UzFxUENPYzdzWEhyU3hZd2IwejZ0MUxzK1F1Wk44TlJhMHUrYmVs?=
 =?utf-8?B?ZTRGNWJET1ltZFUwVjlUamZuUUlzN2lGT0RmcDZZUGVLeEdwMmtXdVBZS2Jv?=
 =?utf-8?B?aXVqQmV1c0M1YjdWRUxydUxMa1puMTN4U05qVm9mOVFJOWR2QStOK1ROdGNQ?=
 =?utf-8?B?NThHemRnSW5CZElhdmYvazN5V280aERDMmZjNmtDQ3NzREVDekZFNTdrRWtT?=
 =?utf-8?B?MkI0WC9JMnJ6WTdWU2dUa0piSGdwRHZtL3N0YWp5R0NKU29oVjZldDFLMFlQ?=
 =?utf-8?B?a0EwT2FDVFZIdi9aZ2d3SjFlbUVVSkdkTkFOcmhjeHpycDhCZHo3UDl4aE5n?=
 =?utf-8?B?LzF3VzZCc2s3YnRDS3NtRmtVbFdIRDh1YlluUzJ4OWhoZUZQVVVncmh1YW85?=
 =?utf-8?B?d0Y0Z05NSHVOZFVSRG5pbDBkMCtDZzdZa3YrWnpIaWNzRjJhRnJPUWRWM0FW?=
 =?utf-8?B?SG55WHhsOUEwRFpKNDlKUWNVZ21TdVJodndKU2UwYVQwMjZNUFpuRkUyK2Y3?=
 =?utf-8?B?MHFRaXVZUG5LWkhXVmFyYjhlaGQ1SWNSNGhlT29BMkhoRVNUMWV2TGh2S0lN?=
 =?utf-8?B?WEF6VzZmRFBoR0ZQT2hhdmgyVkY5R0FXbFZBMzNPaHBBdFhCVkFUUUU4c29V?=
 =?utf-8?B?UjgzM0VweU9xTGFnY0FjQUZIdUxMQUxQWFJFRks5N2FxWUljQkdkUEx4TU9C?=
 =?utf-8?B?Z0RPSjZHajFSekhHeGRZb2tOTE5JWHM0YWtFaWI1R2xGVm1STDF3RTd6aDZO?=
 =?utf-8?B?N0I2a1g3MndUdXNGbllUS1AvaUtzeStZZVVySnV4MDU0enJIU3pZbVhJdy81?=
 =?utf-8?B?YTlvT0s0UW9KdTZSblByUUVQWTVrdTVDTkRtK2xWeHNGdUxmMFFhdCtPc2s5?=
 =?utf-8?B?TzMvaHhsMlBLai9qdW4yV3h3QURpMThLWk5weE5VeVR2SnI3NzRqTjBRS2FQ?=
 =?utf-8?B?Qm9jQ3Z2QVZCYlZzWjViTDk1UDFLQ1F3eDFxOEdEdGhIczV3Q3AwS1hQMzJa?=
 =?utf-8?B?dzhhNGFXdVdkUEo4c2I5Y3R3ZDc2UlJMelBQNXVPYmU4RDVtSlhOYkhqVDAw?=
 =?utf-8?B?eW5HZ1hucEpvejc0VURMNHIzeWdYK1dOUDJvWjVJYUxDMVVBYWM4VTUzTTZE?=
 =?utf-8?B?cUNubTVxMW5NZlBNSCthem5EckVhbU1ydm9zZDBodW40aW15OEhIVERIMll4?=
 =?utf-8?B?bG8wdHpTcEU0dGEzTURLTWIwT2pnNHUzZEZsc0gzd1VXMDB6RU1yZzBLaFJl?=
 =?utf-8?B?VXI1VUV0SkhLVW55VmxZcGZOVWxmcG1jdS83NnNLbWZyYzNhallVeTYvbWFY?=
 =?utf-8?B?bUt1MnJMbkhEbzFGYlhrT0twTVkwcTJwZFBVNjJ5Z1BBcVJXbVF4bUx5TVMz?=
 =?utf-8?B?Y1JuVjY4ZFhtRFA0NElUMDVzZVdmOFFMRDRBZVY4djNjSTZVY2FsQzJpSlNW?=
 =?utf-8?B?WmQrK2l6elB6UW1lTUdYNjh6SmxXdEZqVVNnU08xbjFzclFvMXE3YXpoNk5x?=
 =?utf-8?B?TDR3SWpNZG5yYVh5QmNBdG9IaWRGZVhKbThLZEpabW5MK0Q4U0F3NUI1MVJZ?=
 =?utf-8?B?bVFwaGFIMGVjTWhDRnJiSjNuVHZGQ3RkbEpwblpYUlhvTVlLZFBmeUlhdGM3?=
 =?utf-8?B?TXJ5bUFST0NvSnk4OWNCTHptZjFBWDlVRzNCdWsyS0hoR2l4MmxmejVwL2w2?=
 =?utf-8?B?UkdDSmVva2xpclJEQktBQW9uR2I2U2laRGxCZ2tVNVNvZEpodno1UmRlTUw1?=
 =?utf-8?B?c1hydz09?=
X-Microsoft-Antispam-Message-Info: oRpYGhGekSbdX01FCRQY+viTJkSlLEJ8Sa//1+uVUqCCfh6K/EOo8iU38y0hooC4fZmsZyBC1H/RpN+4BcT68ddD2TdRvS5eo4gRq7wr1YdHegBkogZ0LwWDwZzRV9pThRuPKK/HzO20BFxeLufdZZuN7PF3iFP6bk/gkwsxxA7nf0CojGasveE3x0JKbSkmyVuLPDypY0TIqFdcwNNoYn+GjPG8EBy2Q9Vu5x7rqHNczwGHPyvcF+FFYrVsfEaw2lvm5hIP4j0QhFiOhuOLinhkM9QPpsvNTInTz82qVops3ew+VtYY58J+b9G9I+PheoKRnSP/5aTrwg8zJgcyuQ==
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;6:mVWQ8hMEKdS8tpSSNOUECIxEwjTv6ixF+URusAMop7S9Q8w50D7AD/LfIkpSWZvYmiknXwWWwPesHoxI9v0ZumbzDEyNWnkqlJq+lPkZ3UqGqDqpQYBrTRfqVkfIocIePJoNGNE+el3ZstyHRlRH5VRNnN+ZqekB3og9xM1URQt16kkMSxS+eEW4h4szs114gEbqvcroc1fl5VcnuwskHKGB5DphpUPYZxHg2hs0MyA1XxasNlrb6KV6S7v1IDnKs3xl1To8yAU2KtNw7BpbAahnD1fY1biJPAo340NR7bZJefXwQ3K8MlRjcdjZIXBXuPzLUrnZ84GRHWPVpF1aTytwW3rfxPxCTA3hD8a29T9RANekHyDwiiRLg/gg180W6snJvAenfJ3k6+LoMYGCGRQzMDpz7loO+wooaKvzMaylXTQqVgoBgDXyRcvG4HofjMZ5QO1tTHdBMRcnbT58qA==;5:mjW20XZnMGd07hYkFmpq6TZzj5LhBkJY6UNBAKKfStCm1mhJuFo0zcGmajxAavOnDZEuhrAp8cpMOfwB3O3NNs2XOn7GqHf07l7DxrOu1Zd2WT8Zo2bVPyBQHg77hPgis0AsezZyXCndtFojMW+nlSGjWxZjBypgJ3eFVCfvqCo=;24:TslNwh7EEIZHVVQ7QAPmQbJJSbJRtfuKCGXsl8Dgb+wKQjM+q1a0DAcrrUrD1RGMKtFif2sqYEBCu+539l50FRRwNgthDrLgO79w5JpMs1k=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB3PR0302MB3211;7:HeLjt7ONnQCkjoUb7FSw5RjW1ty/BSDfZCv7YaTOH14RtgTs6vKntK18zm29pj6H/LWftvEcXNig6bihvNfy6ufgqH0IioXxUjOaDyQN9g39F387h3bGNaVZa2GnDH5CMS/HPZQ1tqLkUanfou8PlZYSzvYepdye6gI9PlSKQknlqZ7RS5inP6AAlrbqpNMwVQ8e9PVMtYPkH59DpEHqPMhqVo8XjgKh+rBnKyapGOlZVJK6KGC6AjVdha/Zf4kK
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2018 12:32:53.4164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bcc130-7690-480c-7d9c-08d5d5179d55
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB3211
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/18/2018 03:29 PM, Dan Carpenter wrote:
> On Mon, Jun 18, 2018 at 09:07:09AM +0300, Oleksandr Andrushchenko wrote:
>>   drivers/gpu/drm/drm_gem_cma_helper.c    | 2 +-
>>   drivers/gpu/drm/xen/xen_drm_front_gem.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_gem_cma_helper.c b/drivers/gpu/drm/drm_gem_cma_helper.c
>> index 80a5115c3846..ce868ce288fb 100644
>> --- a/drivers/gpu/drm/drm_gem_cma_helper.c
>> +++ b/drivers/gpu/drm/drm_gem_cma_helper.c
>> @@ -436,7 +436,7 @@ struct sg_table *drm_gem_cma_prime_get_sg_table(struct drm_gem_object *obj)
>>   
>>   	sgt = kzalloc(sizeof(*sgt), GFP_KERNEL);
>>   	if (!sgt)
>> -		return NULL;
>> +		return ERR_PTR(-ENOMEM);
>>   
>>   	ret = dma_get_sgtable(obj->dev->dev, sgt, cma_obj->vaddr,
>>   			      cma_obj->paddr, obj->size);
>
> If dma_get_sgtable() fails then we return NULL.
>
> Fix that and it should be good.
You mean I can put your r-b with that fixed?
> regards,
> dan carpenter
>

