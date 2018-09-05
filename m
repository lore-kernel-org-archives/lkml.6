Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3548C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:49:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FF7120857
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 12:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="HAAh3p7R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FF7120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbeIERT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 13:19:27 -0400
Received: from mail-eopbgr30078.outbound.protection.outlook.com ([40.107.3.78]:20249
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726071AbeIERT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 13:19:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XgtNyzCkZPxGobac3/0HUgyyrKt91nuLOCgz2w9B560=;
 b=HAAh3p7RCerGYeAZPbvYIyl9lpnEeqV9m9OY4ILvvyJnxUULZ1I8VByEqel+/SPQTSLkk+kQgOp252f6M7jhDtlwE/pkY55j3IeWEFvyCsxO6KtWzytHqdYXSeC8REU5C6/NGeCBjoQYCGbbbVyNNl6ehBxb1f/VLnVph0FVDTY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=moshe@mellanox.com; 
Received: from [10.223.3.114] (193.47.165.251) by
 AM5PR0501MB2545.eurprd05.prod.outlook.com (2603:10a6:203:c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.14; Wed, 5 Sep
 2018 12:49:01 +0000
Subject: Re: [PATCH net] devlink: Fix devlink_param_driverinit_value_set()
 stub return code
To:     David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536066265-18641-1-git-send-email-moshe@mellanox.com>
 <2bf31ad0-c3f8-cdfd-8b96-1a8e3280064d@gmail.com>
From:   Moshe Shemesh <moshe@mellanox.com>
Message-ID: <7fd426d1-61a9-7f45-bf26-05bd9e180277@mellanox.com>
Date:   Wed, 5 Sep 2018 15:48:56 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <2bf31ad0-c3f8-cdfd-8b96-1a8e3280064d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: AM5PR0701CA0012.eurprd07.prod.outlook.com
 (2603:10a6:203:51::22) To AM5PR0501MB2545.eurprd05.prod.outlook.com
 (2603:10a6:203:c::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb8eba8d-b290-4203-942c-08d6132df4d2
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:AM5PR0501MB2545;
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2545;3:rSJYPSIhnrl8uebQgQqj3ALxl2gnsTIRxT1e63kxPHT8QgWIxvu/2xSFVkVo+LkVUSeh+2TFzcLrpKIJq3jRX3bN43hu1+uXbufrVBedauyaeAMujnWVgkbNkC5cwJBaUtN54pbo1skYNqORcVKgFMfw4TlzMXGNla4a6+SREklFRQcjlyBJG9o7TLaubuVWipAeLXop9ot3FeFKN/wrn8WbFVQdUvbOXNpo9OgYmV8giKdxjVJfUvhrv7E4Ldyk;25:3cWOLQnRk1UvE7F8f8670U4FYQrfJ6rppDxAoU6QWXe3/fyufGAtK9dNv6qNWAoPPV64dMyx7aikcLzjvLdDd3tWP8DR2oVBOJcRlKYT31j8mKd8EnrM89IAZb7AjSlT/KszmDsseOlvGj7KQhMKdiTo49/eiyUt4c813pG+/tP+0ZG63Vm7x7bt7zQWlEnV1rybTUYc06UwJIlOosNe2J3Ut/FJk6qeq9VPqHrMnw49g3TgYOa6r50Ncge1rG9gDHApU1ktQ+UtjHOxA3ZlvagiuoL9d0cM6fNOQIZk05f24Dsw/aOFn+jIl2OuM0bGHShYb8QT9btpR6KFNrSjoA==;31:wb5NbeFRdMFI/og5VJL6VqGYiZTs7HRJ90Jczg7a5L2AfXkVzY1yX+ex6UVlnZ7x/HlOfJal5PkYpww3Gu4Uu7TIKg5hLqFj4hX/Y11rs/QcnveXjeqAQGe94NYhEW4VO9F+yftCyFZfCOV1KjVO950dsGK08IMwoiPjn84uEnKwO4hlV1x0dYySzivrEYQHYhI/I+s5KY4snWT2CRXJNOqVd7ERcaVbR7bu5kGkjvM=
X-MS-TrafficTypeDiagnostic: AM5PR0501MB2545:
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2545;20:I/9a7u9hEkY7r5O2Y/5BKGzUHu5o6hUVVCVn3yxkQZPne9sYvaNu2jFXLLu5m0b780Hfa0cdaLz34vhrrZ9YNa/YdSvuBHQfG14At6kXNHNQqU5qWMFfynSTbEXJLVo4g+1gc1qOkEzqBCINMWpe81T9WCN1JjHhN1uCI0TMcj166Qb3TmTJ0x9oL5tBfZbzyluCG5s3IpZtj69d4S/S6JryJzyqqUnHoqXetCbPkhdLQxMSMCyUTlm71ZtDY4WP1BdoeyZZrX+tliUeIKG5op20gUqJZ/prfU2cOBfYetSUxxyRwyx3dW4VMCBOhSJBr4goxLjTMlLZZ3EgTiNJa1t7ZVcZKPq5axd0VA9eLbTyA1R/Wmy38wuVkLIe2SF+guwtm9pxeeH70Z72Vdyh/72YE/sz4D92UNqyFH+aFwRKJPb2AyVWhup0HzNVLx7Aws3gV+IcEOpYYHzeT0rXCwmgLhReAqnK+eQ4JvKvvp1BsFSZMRtBRD1EZTjbcmvy;4:TEG8S/2tTYiYEQkUV6PGxKVvWYNwdUY94ESyIw21lNcJCs7Pl0vzYIAFYf9JxxZNS7Lbi0fpwxvE8ij1R3xZBx54uN8nHlgreIHWKCWxj4QowGCIEjqKHcLCelGgCjpKHxS7ITKydHkuuDm4kXXWtDm05f+R9JLgSWE2GjZs9pIi1ZxSmxvo0FUwnQ9p0vUYQh7NowHZQcbsgoGWX2HpCRYl5im6H2cPg4euIfQcvPu9Ehg89tCXeA6X+HbjFApKf3fxg4Ow5upQtkKVXtHFtQ==
X-Microsoft-Antispam-PRVS: <AM5PR0501MB2545CE3AACB87375B75D8DACD9020@AM5PR0501MB2545.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(93006095)(93001095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699016);SRVR:AM5PR0501MB2545;BCL:0;PCL:0;RULEID:;SRVR:AM5PR0501MB2545;
X-Forefront-PRVS: 078693968A
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39860400002)(366004)(136003)(376002)(346002)(43544003)(189003)(199004)(81156014)(81166006)(305945005)(16576012)(52116002)(76176011)(23676004)(25786009)(2486003)(68736007)(52146003)(67846002)(6666003)(86362001)(97736004)(65806001)(53936002)(65956001)(7736002)(8936002)(110136005)(58126008)(31696002)(66066001)(47776003)(4326008)(316002)(14444005)(6116002)(64126003)(8676002)(186003)(2906002)(16526019)(31686004)(3846002)(26005)(106356001)(77096007)(229853002)(230700001)(6486002)(65826007)(476003)(486006)(6246003)(39060400002)(386003)(446003)(36756003)(478600001)(2616005)(11346002)(50466002)(105586002)(53546011)(956004)(5660300001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR0501MB2545;H:[10.223.3.114];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtBTTVQUjA1MDFNQjI1NDU7MjM6M2ZYUjBuOVdsazh2QXVPbUNsQXJ3NklF?=
 =?utf-8?B?cm01ckEyQ2ZNdUtDSGN6Q0VqSGZ3NDAycFdxdk5mQ3drREdoMm01eWhnZEx5?=
 =?utf-8?B?RDVheDlkQXpkT2UrMHFCU2pBWjV0UDlvR2UxdUdZbjlzSk4rYjdTSUoxR2hM?=
 =?utf-8?B?djBJWjl6cHcvWkJzNFZYUGxBWGcrNFBMVWVsK2grK2ZLSnlZV05oRG5BazlP?=
 =?utf-8?B?NVY0RUlYYVg3U3l5MzBueVIvQ0poZVR5YWw4ejh0dFA4MHVyMEIyOXB5YzVT?=
 =?utf-8?B?b1orYWt5Y3UzR2JBaXpqZ0tTWjN2VUNnWXNDUGlLbHhqL29OdEpYSkUzVGdW?=
 =?utf-8?B?bHJIcitJZlg3M2Q4ekN1aURMTVNSK3lQTUROMHN5T0M0b05NQTZzSlJwSzNh?=
 =?utf-8?B?ZW5CcFFOOW5aK2FiTUJWdTlIK2d6NTJ5RCtrcUwydzNYSzkwRkhTZnpTSEgx?=
 =?utf-8?B?Z01CMTF2OGF5Wlh3Sk53VlR6R0RjSW1oWHV1czJDZ1NhTUNyb0JWRnljSk1h?=
 =?utf-8?B?eXZHUzVjU3ZXVE1mTTZqaEZBMnVtVUNiK1dRVlhydkRTV04rZXlrTVdBeGtO?=
 =?utf-8?B?YWFuc3ZjMTdhWGdVTTMxakowOWxLcG1DWHBzSUIwUzR5K1NUSFhyTEVVWERv?=
 =?utf-8?B?VG93NHFCbzNlZG5nTGQwQlZ1eUlRZGlqZjJOUlZFQVpKS2ZzTEtwMnZPbkRK?=
 =?utf-8?B?aGhMMW8zQWl1cnR1Y2wyYldYUzRPOUVWSDhYcTZYdzF2bHVzVTBHZm9MNWsz?=
 =?utf-8?B?MEdGWWc2Uys4dEVKaTZrOUtHczF0WCtRb0NOMWVnVk9hTWNOdE9vOGVWOTJK?=
 =?utf-8?B?YjJ4Wi9aMDh1anpsQUlQMHRCMFVlUXBrdkhQNHRUMU1xWFcrbnRQQUwxWGJF?=
 =?utf-8?B?Vk1CRlordWZUZjdYTWpnd2hua3FKcWpQUUNrTTUzbkYwT3FKYS8ydHRYS0Jo?=
 =?utf-8?B?S1pvTFRXMlVwa21vNGRnVTRaaTJackhqTzFsTUJWL0FYdUFDeDlwK2FIbWZN?=
 =?utf-8?B?NS9ZZ1NoZ2JJZXdWUHpheUg2bzFiQ2l1dTdaWGpFL2VNTnJZZlNUWkVVTDRO?=
 =?utf-8?B?bWNDQmdXb0RXV0N0MlY3YTRlVENrZCtWYzlpYTV6ZzFrVUtWaG8wdzE4M20v?=
 =?utf-8?B?bHhEUVVtTWRURExZc1NXQkRVWmtDa3VPRkg3VWxRbjBsRGZ5TDFuRTFRL2ZX?=
 =?utf-8?B?dFU0YlNVMWZSdTB0aDVyOERGQXJCQzNVMFNDQTFOVVA2WGh1eUNHSFdqQ2Zs?=
 =?utf-8?B?VkVhQ1MzazVHbTNkOUhlUU1jUmtNUkM5NlFIU2VuU1VNM0c3OFQyeDhpdlph?=
 =?utf-8?B?ck5zWXUxZExvUTZJUUZXSW1pZU10clhacWdhNHNWR3VpTmxiU1k2RXA3WUw1?=
 =?utf-8?B?c1llOEgxbUdyUEMvaEVlUVBHOUF5NG9UZFRBK1RycWtCeGRvOWh5Y3dLVEYy?=
 =?utf-8?B?TFdiQjJrTDZXQnZ2U2Z6aXYxRjZwMm41RjlTUFBaQ3Y0YmozcDUrTFBrNGdj?=
 =?utf-8?B?RXVUWDJtOXVFb256OHhCWElXUWpBT0sydTNYZzZLZnRmUUpPTE5MTzlneW95?=
 =?utf-8?B?WDg5UVJ0YVNnT1haSEtBTjdaUFhydzJ1b1psSGM0ejlqcHNUUUNMQVFQSW9a?=
 =?utf-8?B?UzY1UHhWRzE1UWFZbG1JekF6NU8xUjAraTBTNmJHeHZNT2dhYW1wVHhvdTBR?=
 =?utf-8?B?dG9yTVEvRGFhTUZsWnlQZ3Z0eG0zSHE3Mm5xaVE3OGpqcXNPTE1lOFFySHJV?=
 =?utf-8?B?L3VZdzlRK1lHNFVLSFVZQVVIV0FoVG5DM0Nram84Umc4UkZKeFVPVDdtdDJS?=
 =?utf-8?B?amtmZlV3a3hKeGRYa1RoY25VblhXNTFHcXlBTkExQ3VhOEhicFZFRXZsV2hE?=
 =?utf-8?B?UnM1YnduWUVIZ1Yvc1lDbCttaGpQd0t2VTN1dURnZ2RxYlFsWG1nR2xVT2Yr?=
 =?utf-8?B?YmVpdVZBNlI3MFZyWnB4VlVtTVpCVjh4YUUvaHIrTTRiYlpocVBzU2VXVUdz?=
 =?utf-8?B?bFRiUzlvcWhwSzB3ZWg3UEF2czUxYnFpUk4rMG9nPT0=?=
X-Microsoft-Antispam-Message-Info: HPxL9iWgncgVdpRW1Pp3/6ojVeGtPsxQuyMTLeQxMW7zQ2EvP+Bnu3QOcecqyHmUyPbOP0NsrkeqqzNjfLb5SjubM7s3KjGxfrz4HEyAJ6hYUpcTwleo/YAs+pdbtr+bHzxPM4ECYDxfzo8pPuU4VywNm8i1RhSZZoi8nDSeyYGWrvDwNAG+nAZvSH8U7sxH+5kxwNK80Flec2MkZf2C20pZtXyTWZg8Riqzv+k0MGt+ezLvgUIIKNi6VdNM+d5BSwYxjsGRExOsdqq/dbKjbc2xkWFmkWWzPLG3yAvJaXJOvhDWYhN6p78L47N+ur30GlgdbH70rdoSYsgEaom87VLXg0TakuACqckT6axJpiE=
X-Microsoft-Exchange-Diagnostics: 1;AM5PR0501MB2545;6:Hg3tN5l1G/yLAxMUOSh1FRCTeqOZYBJgzHMJG0CKVIRuwhsqb64OAsNMMjxzL7NjtD5ZCh0/0foVdm2U2qWBs6U+qUT8oFR6sxkjTBElVg3qkO655Fz7TC7jAqSqIzjDk5dpD/MA2+LzOgrwor1y4odPuRj5MFziyXy6GYycS9lhzUzvROFq+5DOoLO80soNZ2CUQu5dM+M9e308vEz3OODM6e3kbjDmDQeQpMSIYoV94k6/x5DxwumyHr+fnFBSvLyvsK+Y+rnuqNy5qWbGkSVQegU7z0fpHcTTNIkcQ05Ia+sk4TNEz6ZLkvkhksXwR9gX6Y+ILlW7tELEzXTkwPVwEO6WktGAvn2U7Gz5H5SU/RZiKtkwFj5UFVJYuoFRBgc/jWyUFJarAbi5YORdVwwKg3kfGejI2MlJrKMzkUhQ7PLLnSX+I0/GjOlBxGyISLICbRY49tTpyBurp97a3g==;5:b+cMWANKle3+ZnW2McTrgHgippx4XERbNUUagYIeaUEsZSMI4ZOXvC7k2+3lM8YmYiB4mhfgTE7tkbpWh1qetCX/FsyuxF4vn/jcE6UMVfM+iVa1jjDyxi3AfMU7okYjTOHvjO8wfQ0MRrmVE+ZK+N0GRTzl1CzkHlSA5JmN5eI=;7:7DIMJgPE9F+1Suq6WGtIRiLQ2qMyQ3GbWOLRqj3EP5JL025GAgkgUPPY8nuJoYFSBdGtokWS6YgfZyXSqD30Sl/gts6nLDtApWTlRFk1eL1BGe6xdAyi4DL8OplxPEwNm/OYqRKCTNcxsACRfI7slx1F3QQTbv4ubzbHhOzpOF2GC2lUNHOYwCY3gKwRBb9eDNQSs38qr7HVNakSNu52ODpTO7dL7Sa+zsHzOB7Hq/oYCdNIPVn3GKHOYToT+lQq
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2018 12:49:01.6717
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb8eba8d-b290-4203-942c-08d6132df4d2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0501MB2545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/4/2018 7:13 PM, David Ahern wrote:
> On 9/4/18 7:04 AM, Moshe Shemesh wrote:
>> The stub function returned -EOPNOTSUPP while CONFIG_NET_DEVLINK is off.
>> It caused false warning during driver load. Driver needs to update
>> devlink on a parameter value if devlink module is there, if not it
>> doesn't need any error code.
>>
>> Fixes: ec01aeb1803e ("devlink: Add support for get/set driverinit value")
>> Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
>> Acked-by: Jiri Pirko <jiri@mellanox.com>
>> ---
>>   include/net/devlink.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>> index b9b89d6..b467357 100644
>> --- a/include/net/devlink.h
>> +++ b/include/net/devlink.h
>> @@ -781,7 +781,7 @@ static inline bool devlink_dpipe_table_counter_enabled(struct devlink *devlink,
>>   devlink_param_driverinit_value_set(struct devlink *devlink, u32 param_id,
>>   				   union devlink_param_value init_val)
>>   {
>> -	return -EOPNOTSUPP;
>> +	return 0;
>>   }
>>   
>>   static inline void
>>
> 
> This should be handled by the driver -- check for -EOPNOTSUPP and not
> log an error.

This is a stub inline function.
The return value would be ambiguous as the non-stub function can also 
return -EOPNOTSUPP, in case the driver-init mode is not supported for a 
parameter.
> 
> devlink is generic infrastructure. If a call is made and the operation
> is not supported, then devlink should return an error.

In general the stub functions should take care that the driver won't 
feel the missing code as much as possible. That's why 
devlink_params_register() returns success and so should this function.
> 
