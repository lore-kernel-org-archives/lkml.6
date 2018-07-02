Return-Path: <SRS0=/0sc=JS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275BFC3279B
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:21:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03B025273
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Jul 2018 20:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="mIIK8NXo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B03B025273
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753101AbeGBUVi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 16:21:38 -0400
Received: from mail-sn1nam01on0066.outbound.protection.outlook.com ([104.47.32.66]:28687
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752606AbeGBUVf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 16:21:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G353Dwo/j/Khz+MlQojtuXRWZQx78MWQgFgTnFFLAZE=;
 b=mIIK8NXotyK6lJtYUuk5UR7/27Ubs3Mio0f+AYeZTzBfUw07LHPKi0GeDdsXabQuDIkTjl6P8FNtk4Wopw6Axrt3stvpA3JSDFCNQyusvt3dOIzggfJn4neTMr6IvDTzzJvY4DFhe61sfPV+b5POK3IHGAML0G6NWzvBlkA/LEs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Gary.Hook@amd.com; 
Received: from [10.236.109.62] (165.204.78.1) by
 MWHPR12MB1455.namprd12.prod.outlook.com (2603:10b6:301:f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.906.24; Mon, 2 Jul 2018 20:21:32 +0000
Subject: Re: [PATCH] iommu/amd: remove redundant variable tag
To:     Colin King <colin.king@canonical.com>,
        Joerg Roedel <joro@8bytes.org>,
        iommu@lists.linux-foundation.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180702163752.16418-1-colin.king@canonical.com>
From:   Gary R Hook <ghook@amd.com>
Message-ID: <57a38891-d811-17af-a544-cfeea9476160@amd.com>
Date:   Mon, 2 Jul 2018 15:21:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180702163752.16418-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: MWHPR19CA0011.namprd19.prod.outlook.com
 (2603:10b6:300:d4::21) To MWHPR12MB1455.namprd12.prod.outlook.com
 (2603:10b6:301:f::8)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5fc78f78-7406-4841-6e31-08d5e0596762
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(48565401081)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:MWHPR12MB1455;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;3:qET0/6KckejeJ94s7I+4Eiwr1sGCmqzq3h7FZKTHSopOQBXXcQ3KTpXORUDuyk8C/IXiPdHrD5KmmipX78eOH8cMRcgaOaa6IsTk7C6MTCZhpkeKDdoKGDiiO/gTaOIkfrU7Q0Iu6cKEwXMFUJ2ydf9VnsUL1uPPUGhVv4R8AOmTnXkkHeg+/qi+Wsol3D7vHZzrm+yGA7x/9ptrsYxGvt3u02xzdEx2aQULjDtzmfySwAS1KN5hwjahtx6Z8Ou2;25:qE/Ad9c4ds0+Vj3FwgFS7EUQOvOKL3FTiTjZnmCxK81ow7i/zYwysI2Zd/jwPyrmpDX56Ww+E4vD7UA39iVflS4NPXQkLRqOhkJm4kxVHlcTXMoDHqw2+oSiGzsMQkf/2/jnObLRjr2tNlg+8W8d/3ST3A+DaqNBEb/pPSph8saHMnIWiGM8Q8HCiAaadqp0ubrX4jLVejDXBLUuZiPbIdLtawAIBKlKcOkpg1+jc4lsE1Yjmd854Fp7FpZ6YrjYaI7AAGjnVZ0kX1+XVScYryaJEihu6VffpGbJ6pX/Ew615SI3R8B0TakthEHeN9P8jDX/HiQS6BJUZglbXDERMw==;31:zqGq4tF18VjBVj6sXdgdrXyvHTg6yrTnDILCXgJz1MCg66sfpcUQ9GD0WpuYiKoaxc9jYKUtzgOyQx3rslTTWpliZfJwShHFHtzh2Ofr9fKYFjqo47SwZv5HT3fZ6IFiUPJkp571GLyRO1zST/rjyMqnMf9l7SHXMT2IJYt2uxteDh1yZ9LvQv5U/msR4uCG7BZSkpnffEZNzpeRNzKhFQomfskRjjT+DVN23uWmuwk=
X-MS-TrafficTypeDiagnostic: MWHPR12MB1455:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;20:yKiuL1paFtb3X5Yyp3hVemaKz9n/BHRmt1WPTmopqxDgL1KIM2kl5yCfnOrEQcv7jp1Qwmd6E1ZGWdREUYBjld0ZoeEhcFnpx9FYALf4NrfYtgfZxhrpgHLyuOfLwX4g11RCKdGheXRiXQCaTghmUsuwnxkdEV1yXRBxNh2U4hl/olHu8Ob46bZ2OMYAgHugV+mdtPO0NBv+EQjnOdBQpfwUAQCLjXxW+gW5JTxUIRVO4lNApKEJtYGkSwWyPffJ9NJumCtNkHAKAd8Ud0pXJtLrccFVsDpV/t5M9tX2HvTfmcOh7KY82LPhdxcCeCLa4KVntIXmK6F9sE0vGdc+H0X3Se5HF8DKZ20VDIymF1Em+fZkB5rxyIXajW9+0PiotwEw9f4dBGF2QsAajn6Y9U+3bhjSfyaSgpm3ur6rMFd9ee9IUyRxp7W+MlWyzXn4KJB/ll2OHxDYPG19jqWdEB1DAwl2b1Wdoy91hcBs/eDFepkh3oP0FoeKH61ghPhT;4:0w5IrHulsIwdAlXbG4NjbffY+KSWPLJ9EyUu1mUMjxiQ+zD2bWTRD9pS7CTHKlIDd+pL+ABksDhd4UKRecVYmhJrDi3D0Ad1KNhrUk95ff/hKxZxF4fBdqeIZIUSBquaXRCVopBs5LPy7xck0aA1s3/ZEtUspGDjNCemFcdZjZ+xOXW/+MAyhGHuq4hP5gR3K7ZTPjk9ULDhBw9dx400/7gpIFH2KgundZLIhbbseLOTGpv7VO0jMV5fcNAyCs1u7AT5QlXRJG5kp9x1rD394oU6cCJVOZQACd6s+pd/Fcq6ABUObMFafWWQeXNsC8Vt
X-Microsoft-Antispam-PRVS: <MWHPR12MB14553DC30BA41DEC873C461DFD430@MWHPR12MB1455.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(198206253151910);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:MWHPR12MB1455;BCL:0;PCL:0;RULEID:;SRVR:MWHPR12MB1455;
X-Forefront-PRVS: 07215D0470
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(346002)(39860400002)(136003)(366004)(376002)(396003)(189003)(199004)(52116002)(58126008)(956004)(65956001)(6486002)(7736002)(65806001)(110136005)(64126003)(8676002)(16576012)(53936002)(8936002)(81156014)(81166006)(229853002)(6116002)(65826007)(2616005)(5660300001)(47776003)(6246003)(305945005)(316002)(3846002)(66066001)(6666003)(31696002)(68736007)(4326008)(76176011)(11346002)(77096007)(26005)(476003)(36756003)(230700001)(67846002)(52146003)(2486003)(97736004)(106356001)(105586002)(23676004)(50466002)(25786009)(478600001)(14444005)(31686004)(16526019)(72206003)(186003)(486006)(386003)(53546011)(2906002)(446003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR12MB1455;H:[10.236.109.62];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtNV0hQUjEyTUIxNDU1OzIzOlozQnFZbjRJNFYzbFd4MGJjMWI5UEhCRUdk?=
 =?utf-8?B?eHA5U25jZUNQUy9YQXE0UFhNSDhDaThBMVJqQ1Rzd21scmM0ei9mckFZVWxw?=
 =?utf-8?B?dHdGT2pETkZUMDhHeEFVYWZCcWVxcnN0emZoaDNaQkhEQVJGQjFxcnB6RnZs?=
 =?utf-8?B?ZjlZVWdmbk14ZzZWOFVIdmNSMzdreUdnMFkxQWtMdnkranZaT0V0bHJLalAx?=
 =?utf-8?B?c3NzSnRVV1NPNkpMNVkzQnFhTHp2RjVlWEltNGwxRVA2TWdqNjlYODJwMGJj?=
 =?utf-8?B?NlVCSGdCNFpjWXJVMnlTUEUwZUo0ZnRYcDFWYjlTSTRNcVNjaVJUNmpXQmdQ?=
 =?utf-8?B?dHRLZkE0NTBLSVJzNVMzQkg0bUxYcHZBdVgvL2E2QjlXelhSK1pkTmt1Slg2?=
 =?utf-8?B?OXgrRk41a2dHRXdqWU9JNlVWL2V3aEI4VE1PQ0g5VXcrcmRNNVZsbEVSWW5o?=
 =?utf-8?B?aHdIVUZ1bldXSlUyV01IMWhySjZ6dkZycjBJYXRnMTB4YWQrRFV1TjBmUW5y?=
 =?utf-8?B?cVRrVXppaFVVU20vRzdvWmkrU1d5d1I0R1RmQndmYVJhVHBpREQrcHJhdWEy?=
 =?utf-8?B?cE5tL2dpaEx5Ym1CYnJLQWwwZDluVUlsMEpxb1NTQU9yMjkrZFdHLzFIU0Za?=
 =?utf-8?B?bkVNUHFBamxwMWFsTVhMNE9oMFJiZ0t1U1kvb1E5eU4vZXRPVTBKTUFteXUv?=
 =?utf-8?B?Uk5kbi85eXhaMUt6dllKd2dUeHZpZkJHbk5NeS9OYmptK0FnR3U0RjN0WlZj?=
 =?utf-8?B?MytGVnAzelU2LzMxQlpWbEFBY3N3eWFmZ2tqZExsM2x1cnJrOEdENTFoYnls?=
 =?utf-8?B?L0VndWM0RE42VUNFcTJqM0NNWkhkYVVHUWJxaUVlRno2Vk94bXVwYUhvNjBG?=
 =?utf-8?B?MFBxZi9ZQ0Y5aE1hdFVQbkdWZnhmbDlTVkdXR0E1dU92dHdzeFFMNVVGTFha?=
 =?utf-8?B?M282Ris0d1g0SXBOZzNLMlk1UU9wdlM2c2wrbi82ZGIxR2c0QWJUM2IvSyt1?=
 =?utf-8?B?cEhHU3Q2MlZiUlJCZjkzKzhOTGlveDZuVUJPa1RWTko4RWNGN0lTM2x0VWw3?=
 =?utf-8?B?d21FbVNkS1pXUmYxendNKzc2amxObzE3c0hVZytrSFhZMm16T2NGQzVjMmt2?=
 =?utf-8?B?UzVDQkN2b0tCRjI5Rm4zZ2FsanppZk9RZTh1VlhqcWZDQTBSekx2RnpteXVC?=
 =?utf-8?B?cGNZaktDTnBNOW04UURCajJOcUt1WDJsZ3N5MlVydzUxdXBiM281am9rbVpq?=
 =?utf-8?B?WGx6YlM2b0hpT1VnVzYxWFFvcCthY1JxcnRKb2k1SmZqdGdyVC9lWTZyVjVY?=
 =?utf-8?B?QWR2K0ZYNEU3VDNlS2dBWXVwOWc4dWRabUkreHc5S2lPWmlaUzhNbnZRMElm?=
 =?utf-8?B?ZUZnVCtsVldjcEFqb0gwOSt6b1NWZWhFb0UxZzlNZFF0diszYTQ3aFBsemp5?=
 =?utf-8?B?TmRGQlgyQ0x5ZnliQmVwUUQvL1oyQUx0ZmpldDNyNXBWeUtLQUJJdFBWODQ0?=
 =?utf-8?B?UlYzVHZNdVBjZ1hCOHgvRWUzSjUzaG9qTmUxakF5aEZ4UmkxY2k2bHY3S3lK?=
 =?utf-8?B?amFaZ2k2NGxZZEtTdkd2LzQ2bEVLMnRUZm5Ka0FoTjdXQ2ZBc2FyU3VlYkJW?=
 =?utf-8?B?U1FGRjQyU2V0OGZBYWhLVVNRQWM1SXMrU01kNGdnMTc4UXNhSXUreTBMUFRS?=
 =?utf-8?B?STRiZnBlZnpZVXkvZXJISzRVTWZUbi9LeTJxOGhQRkh4NW5wT2UyKy8za2pD?=
 =?utf-8?B?SjVKZ1VQNXBRai9hTU9nK25CdVVUQSt5SnUvNU42b096VjcrRllNMlgzeTdC?=
 =?utf-8?B?SkM3VGhLd1g3cCtKMTZNQ3J2eGF3clFhYk1XY1J4VStiVitrZFJZZmY1dDND?=
 =?utf-8?B?S3p1VDJ3MXdxM0RuQWFUMW1GZHJlbFIrVVB5WlcrZHhUM3NienducEJadVN2?=
 =?utf-8?Q?ALYaLIqs2/DvL8y+RmPjeQeQPZQpJs=3D?=
X-Microsoft-Antispam-Message-Info: 6mpKbvaac86O7WKuJIyJVB0EYjRrNxcDNfjN+c7TUst0GhKpKdISx2k+R9+EY+5suo5GFFZiM/uIFEQQz+6lZJcrJ4R0pOpaSoS0xD7tHcqkD/Ayr3Yqa0dNOHRAVC4ViTFYjWOTEcm33vN/MvXzgrohY9zzCCIpYB6/Mp/cxFeZaucNJCYQu2dJNOf2FQlA15l0WefoEPF136iBGuXm+4jfq3Iu8RK0yqsqqCuO3PiugkzXR8SObs9EsQDcng8wax1HikzngMSN1+mLUm1E4DB/AFwlJbZGq9pNSwe15Of6lf0MQM1UxZTAFCv+8FfFDY/a8NS+z2pUrWPHGlYARR56rDXNqvrZqCT+3cPwQek=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;6:UwsYVcSS4FHcZiLNNOs1BhkrV7Am/Rzz4ozVE2BfjmMPAWKfLnY3IGxpkHiygqhTc0G+ITV+WSQ8WBDdTSvakFJ5+w/zdGnasogrSoU9wi5cYx9Mzju0em5xJbtduZN/E8oMVKvNK5fVlQ6DVAbnJYmAX5f+kOCvz9N8HOBVWXUX0RFefo1TY+uh61ci0R91lqCWv4d+aSlyMT/zGHFhFYMLua0Y64rU/j2qCZTxSk6SQVqhyglznOJTPmv8eCwXBHZfPDXhPParx+NEB/NMKen8k609J6CMEzi8rlViictAJcvAG8WVP8n2LPDA9+eLLpcemEZauctFE4wdIH8ubQzglGOkXJyGQFWZ9YNJNp5tSxSKpOENPmassjeIVjD2ULZWNEzo2ZmulLM09vebClmNgULphlU1KP++/cJrWqK0qvBw5+/OPTvmWbzhUS+Cp9o3nJkDNGG8TWpEcFS17g==;5:vJzH/VcPUMDNO6yr6ukJ8RXudwIHPxaJEmpU0qzJ+WfZaL4JhCahi1me1QN2HGq/oX95VKTezikvuWaQV6W03nAppcHo7esck6wp7NP0Te7Km3CJfmFwhRWxOGkWrxigusX+mTn1sKiXrzkDp0nX6ncEnrJh/xmDwNSq5ZhEfdk=;24:JAumkqqD5dUBtY3JSsgtEIAG64hHh/KheBPh+uw42Pi9b4Hk+mjpYG4JNFtTiuN21tTQ76GlasVSIKV8fvTSF+QMLgsgJ2sTOygbKuiE3a0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;MWHPR12MB1455;7:dc7OBumgoC98LAzOBPUvKRxF1Br9pPYt1luV6Gbqrmm4VfrYkFQfgVMaQ2XqIvfqZhO/2uir4iRT34Ne+T5Kl9HTCfOzL+R75m7uRaOTKgJw+E3jDrzoCiEtZiw0pWCWEKj02gBsvwgDvZQThFabUVUpPuacDxYGtDvZjc/PDgt7dhedhomCIjSnEkkKOJe51YgQaC5oX2+cfp818EnjuFGsA/n9ULWgvEPF/kzxjJka0PISq8uB7ZAk/aVsLDNU;20:FwJ4wf9aV+uNLPm7QAtmhFxx00H+Wws8o5O8sh6kOvZ6lAq7BHQYAvP/XN7KpBz0jTvlwLNXE1ehZy/MyqP7fz7GzxycvreT3k/9gazvq0PSkLjTNLnLGYk1XZ9TjgDO+gf4+UN6nfjwaRZn/RK71uGyoqu36O4/sLmwf0V6Oe7jk82lOH8K2jKQwXdLbcn+pK+MPtmo9kpL4C0h/pyqVjFpzAF60Mmq3n7CfvPHr2IMm3019kcsNTPM9Q2Wwai+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2018 20:21:32.9164 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fc78f78-7406-4841-6e31-08d5e0596762
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1455
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/02/2018 11:37 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable tag is being assigned but is never used hence it is
> redundant and can be removed.
> 
> Cleans up clang warning:
> warning: variable 'tag' set but not used [-Wunused-but-set-variable]
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/iommu/amd_iommu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 596b95c50051..c6aed1b088e9 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -547,7 +547,7 @@ static void amd_iommu_report_page_fault(u16 devid, u16 domain_id,
>   static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>   {
>   	struct device *dev = iommu->iommu.dev;
> -	int type, devid, pasid, flags, tag;
> +	int type, devid, pasid, flags;
>   	volatile u32 *event = __evt;
>   	int count = 0;
>   	u64 address;
> @@ -615,7 +615,6 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
>   	case EVENT_TYPE_INV_PPR_REQ:
>   		pasid = ((event[0] >> 16) & 0xFFFF)
>   			| ((event[1] << 6) & 0xF0000);
> -		tag = event[1] & 0x03FF;
>   		dev_err(dev, "INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%016llx flags=0x%04x]\n",
>   			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
>   			pasid, address, flags);
> 

If it's all the same to you, the intent was to print the tag as well. 
Could we add that to the message, rather than removing the variable, please?


