Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CE53C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:11:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93C45214DD
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 09:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ysoft.com header.i=@ysoft.com header.b="Zr4aJ++r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93C45214DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ysoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbeIYPSM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 11:18:12 -0400
Received: from mail-he1eur01on0088.outbound.protection.outlook.com ([104.47.0.88]:20986
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727159AbeIYPSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 11:18:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ysoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jF+EjCqQxUIEpe3O+xISfDVAeOMIIRWV2XCxMMapxA0=;
 b=Zr4aJ++r0+HDMu2vycpeOS66vrNtOwZBja3ji0aPyJm9yJpLxhD/savPRnfKCq50UQy5kV7+OgzUaFfz/3d6hB24n6I4eYueK1XQ3xmJQF3/89Uhs/jvsQMWsoRe7rV4CKTeQnTvoGok4LW9MOwWlnZI5qbdvvD7Jop2DTz0Y/8=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Michal.Vokac@ysoft.com; 
Received: from [10.1.8.111] (89.24.100.190) by
 DB7PR04MB4667.eurprd04.prod.outlook.com (2603:10a6:5:37::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.20; Tue, 25 Sep 2018 09:11:35 +0000
From:   =?UTF-8?B?TWljaGFsIFZva8OhxI0=?= <michal.vokac@ysoft.com>
Subject: [BUG] pwm: sysfs: It is not possible to export more than one channel
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Gottfried Haider <gottfried.haider@gmail.com>,
        linux-pwm@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        H Hartley Sweeten <hsweeten@visionengravers.com>
Message-ID: <cd7b3cad-98bf-d976-2e30-0b018f51f90a@ysoft.com>
Date:   Tue, 25 Sep 2018 11:11:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [89.24.100.190]
X-ClientProxiedBy: AM5P189CA0014.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:206:15::27) To DB7PR04MB4667.eurprd04.prod.outlook.com
 (2603:10a6:5:37::13)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c249edb-1979-4abf-47fc-08d622c6e4b2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:DB7PR04MB4667;
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4667;3:TSsf+mHflB063+QwJk87P90XtQuKU0kwSGC1tMtrRnAcQ/vrT7+vxstYTu3cSOC+E80RMqL25EaNwjRB972D1ntq9bID1Snl3WESNjodTbWQ61BCf6bmRaIxSt2vd7ap+MfMxj8ULp1TxI+agqrbxMlU0Hnc7HCYgK7EBK6n3jh3OyibVWN6jdaxsoIS9feH8zeN54guVKgZ0Hy23up01vdPXuuAZSCUoJqSObVEb9kzVoCG7JRJSEuFOo7xY1Zy;25:0zjDCAuTIYxKgtCft7YrByyGkqKvaj7LL72R7b5gCYNKxQLSYKUiapgMQAEdcr5NQ57AQCgswRGNYluKlKlk8TJ9vqSxWTxM1GHu6LNcxW567tvRDrnaoyLy4n9cLqzOoiXsNNxdud4ero3tRExUpeeGDs5qgpj4emZm5miDzuLCPFdwnitdhOJoxeO5C6OmLz1FKKRNwoqBDVzseQ3Di2n7swvz8M7hXzOIWM9nu5niRpekZUhCVDcyNgumU6VTxj9dUUa9iace5jGogNthFlXBsen777nFUFHjUvntFFwWkjPOluXA70Ck03Vzby2MF3NrNaRijyeoSxxGtNBcnQ==;31:OzIkrsgAyOFu3VTrbI36lCevhZxtykJcX6eZa2l7SuGaw4dmn9eZvcqh0dUQuYRWsAy5mIYji6dfTZ+nsVP3+wCRR+kW0luTUn6QN4aWJnqYlwG3V3OKnlXzE/QEgx5TAEbuOBTVJ7l8lsUuSRe/8m63Z7xSHwUAFxP0sYurWwqG2MApg5RB514stc4EsvW6aiBO9XULAjqk9xMFDv9nwe4QkRACI250Ph7bL40U2QA=
X-MS-TrafficTypeDiagnostic: DB7PR04MB4667:
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4667;20:taqLvGcaCCEIYUTIO9SQFYX2fkPI8+5PZPXnWOcw7unBCVraf7QeVXf86Q1c8A0BHtJnVX/JXFQ3nzuRi7N83dn6MtNRnr5mhbC/3Qxjo6R6HSNfCGIVPT0T4VTLcOy8CDPuNm3ArW2NXoQiFkFhRyFcBS+i9aOY/QlMygBKvUD77OKoNUS5NW+Mpp2naN3iNyVfSFvdbTFtIrgQyh15oY20cx+GqhTkpiudLQSUnA6IAU3yNwlnIVyc30Vt75nb;4:CRjlTD5d9rKWl4Dp4LfqFdgOugt6kRBqiAVU5a3GYZxbfgQ6U/NHlOSlAQRv1Qrz69h3afslPVLaJKX3SY7RUxpT66hhVqfvkaeAib1L1d7m1RVefV5H1kucXK8gD+HOUyNY2bjKIk+NR+swqIexGFPgGv48cQsCYsidhgiKepyxHwC1JwRP7ptZt5iTyTl79BVfSQomOo/s+YJUo7ufa/GPpvFJgwo7k7SRQ6uYQzU0IQFFXOYARf8YpSprAReeTnb5nH5oeoxp0X+JNXjYXQ==
X-Microsoft-Antispam-PRVS: <DB7PR04MB46674CE7EBDB32CD12A8972C9E160@DB7PR04MB4667.eurprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231355)(944501410)(52105095)(10201501046)(93006095)(93001095)(149066)(150027)(6041310)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(201708071742011)(7699051);SRVR:DB7PR04MB4667;BCL:0;PCL:0;RULEID:;SRVR:DB7PR04MB4667;
X-Forefront-PRVS: 08062C429B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(376002)(346002)(366004)(39850400004)(136003)(396003)(199004)(189003)(68736007)(6486002)(65826007)(2486003)(36756003)(6116002)(3846002)(486006)(85182001)(67846002)(2906002)(53936002)(26005)(47776003)(52146003)(230700001)(23676004)(52116002)(81156014)(81166006)(476003)(8676002)(386003)(478600001)(86362001)(5660300001)(8936002)(956004)(31696002)(72206003)(2616005)(4326008)(31686004)(25786009)(7736002)(6666003)(305945005)(97736004)(6916009)(39060400002)(64126003)(105586002)(50466002)(186003)(54906003)(65806001)(65956001)(66066001)(58126008)(16576012)(77096007)(16526019)(316002)(106356001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB7PR04MB4667;H:[10.1.8.111];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: ysoft.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjdQUjA0TUI0NjY3OzIzOkVMRDBMTDZlT0hiV292NWVEa2JOVm9vT0xq?=
 =?utf-8?B?ODh3S2tNblRHd3dWdVZLWnkvaEJtWHdKNTVOZ0hUYi94cmJqUHZpenJOa2hh?=
 =?utf-8?B?SEJFVU9maVM4ZEJndnRlWmxvTis3Tnc1bzZ5QzNTOEt6SWpJT3VMRHgrbG5h?=
 =?utf-8?B?SU0wUVZHOFo3dUl1akpCVlJNRytaOW51Vk5DMGQ3SEYzakc0MzRIaDRONHpI?=
 =?utf-8?B?bE8wNWV0NE8xdzhUVGdRK3ErRHBDR0RaZTNjT2tLaDNObXY3MkdzZHNJaDdB?=
 =?utf-8?B?bkRsVU9ndVlWQzllWmJpQkZlbVhKUnNCcnJPb3ZlNXlHWVdXeE5wcjZZWWVU?=
 =?utf-8?B?VGJSclBVSVFGVVhHNThvRzMrSWttcElxZVZMcituZmYreHAxUVFGQUZJRUxR?=
 =?utf-8?B?aElqVXNTdThBZUplM1BDTlZiOU40K1VrL2I5Ry9CUStqM3pmeGR1L0VocFZ3?=
 =?utf-8?B?T3FjbER0TzRvZTgxd21ZU0x5RGdlRlhyU3k0TE5KUDV2K2tITDF2UkQxVGVG?=
 =?utf-8?B?UWZLMTFQaGUvWWt0d3FzcHZRYzVyN2gvZ0VQd2V0b0dFSjg0Q1h1dFZJUy9W?=
 =?utf-8?B?Mk1KTjFUMExRVDVGd21yWUNmRXdKS3Y3OUdTcWdrcXpkM3lxWWhuejhiYXha?=
 =?utf-8?B?M2RqMFVrVVFYOXlKL0RjU09icWlOTml6UnlLUmVzYk1WMU15aWt5Qm15SS9a?=
 =?utf-8?B?RCtuT29HMjJqWkxLaGh1d0pQdEVZRXZXNDJsU212MnloTkFoZldmUVZDc1Z4?=
 =?utf-8?B?YXFucE5yOTdCb0toWVFlTHRFUm40ZkxVbmxFbHUvLy9OTlZEd0dGbk1kNnlX?=
 =?utf-8?B?VVdiZE9idzArMmc5cUd2N1poTVpwSi9RL3NSUVd4T1lvaEFNbm5HYS9jSnVl?=
 =?utf-8?B?RFg2UCtLYkx4MU5zZHRrUm14bk02NUJ1MXpZN053K28wa05IMjN0N1grZysw?=
 =?utf-8?B?Rld6cENLV044UCtvSngrZkY3QmV1VndxMjAxQzVNU2dGcTJCbS9RRXhuTHB0?=
 =?utf-8?B?WTI5NVg4UmFHK01ScWVkR000bU91SHlia2JudXZWdHlyS1VveXpFcFdwZENH?=
 =?utf-8?B?bmE0OU5OL045MXlRU3VkQ3pRY0RLaHZqR2RqRGY5OCtaWnBmZXdJNkNRTlNv?=
 =?utf-8?B?RDk5Vlgwc2NJczRSU25NVE9PVVFka3F1TFpLbG5pM3RhSWN1UGJNSjdoTU1y?=
 =?utf-8?B?eC9acWpQcU4xckN1K0tuNHk4bENoYmtUSlFkZTZsUWpRWFNoL3BoV3N3RDB4?=
 =?utf-8?B?ZS84Wml0MzNUdUFKWnRHbGNtcnowdnJuYkYvRUVzdDVnY05VQlNHSEdKbC9O?=
 =?utf-8?B?ZXg5NEhGWjRjcEc2NS92TjBRMGVKODlDUWRhcW9FZ21KVklQNHljNE4zVlNC?=
 =?utf-8?B?Uk5wWVNZUTkySXVZNFV6SmNGMmJtWVhjN09zWWcwUG1GOU9mM0xtaWVUOUli?=
 =?utf-8?B?UnpPNkt3RXRUVEgxNDVtS2FuSndYQmxlMGo0a01aMWtYeGpmd3JvN21wM2h5?=
 =?utf-8?B?QmVZdlQvL21UOGUrNHR5N3NwdzFJNlpkTUFEaWc5citrWE9jc2hpT21MMVRv?=
 =?utf-8?B?MmVCaE1NSnhqQVNSTFRaVmVmdFFPeTEraGhMb0NtU1dFOFJQSjRJR3J6SnFm?=
 =?utf-8?B?bm1zRnJEYjNIYm9rV2hpVWpiZ3VaZ0xidE1yM3ErOUdnVnFFUmkxVDBTTTFH?=
 =?utf-8?B?K2NveENLZ0t2dThaZXNMdUhCMGEyOUxVMWFhWG1nbDRnNlV1U0FlZzdkTE9s?=
 =?utf-8?B?UFpFWVllYU1pZXExb2dHTzlTVjNxbmE5RVkzRnBuNFlRd1pYV2NLbjhYVkNC?=
 =?utf-8?B?cVlpMzllbmpqcEpKbHVUeWp6WXlKUkJicGNkZFhHWE1kTk4rMFN0M0lGNis1?=
 =?utf-8?Q?Kb6BmBTznEQfDAJvtLZJYA4gaaeG3LTt?=
X-Microsoft-Antispam-Message-Info: HO2jWQQxtOPyfIuV3otHWp8Uib3yVk/LpOFLPhLeuTQY1aync0fKsewysBCyxCia7a7xWh49yBHMxUDs+k3sIoWe0uK+f5Rrw8AXrMzSikpkEHYK+CIbRBByeNXIQtJqCzFVb9mkN4/gvQIxA1KmH8b2UADhCpaLLTQJRYBLpTXw+OdXj59BmDctj+vTcxzeUrlMVw5KBk9sISjhKWPZ8dlxsAFCTr8nK7JOaJZsat77Ht3DI0b6Hs2FGpHxiVDqPgK53mv6IhxBH9lYoFcEMG5x6+HlNgsWrJ5cqfqyO69j48rrqRGd2xzhBdSugksDM9DqxxU0w5fDyWu1GpqUkXqbn3VBUi1Wjia+se6JXf0=
X-Microsoft-Exchange-Diagnostics: 1;DB7PR04MB4667;6:2radFF7gWC/NeTJ7h8BhMJq6kVo+BSciRBjgFseYVfgxglyiSrRh8KumkK94+H9oI0BRZSfN/cPB6nyYayZx6cLSJBaqZ4HnCF7XgEAl+9msCDXhy7m8fGCsrufjwqpnjXROzoiB7x6zJu4ZcJQrUhIhEKXZIv21cDvjhNgrNRrUTwqoozwh1a0gKr+NtCneWFkTJbyXR+Kl1eY82NE26dvv9UTZ8refv5QL/alsR2UPgAXomfWoc9ovlVkMwkH+Rh/IwpabNl6dWBr4DhtStiv/KQguyOta1y6rIxXziUdAGh3Nq8xnKrKQ+O6Ce9rvuSKhM4EGf7zHwHfuPIDOOhZkJbnLs87654PTUILMkLN8TB69qTMag1Ste088y2NCDCpX/9SqD/zbnKhJmXJAzxU8FdAxDqNZemR6/pSVYTbOw+DhURtVvTrMqw9gMftPeDSL8t9zHC0+x1zwkiXE9A==;5:LWi6llfHagKkChKq+FgIRaoxm0ooYtKBxj6hIfjMdCTd35v/6exW9Uvrlti03pwbATYpYPeHrV6CAqF7Qz54S7o1bFH/8RZhsGvXdwArGWl79HCwkaCq79IxiXdLWumVc5753gUoTMYE/K7igeLKA6XywrNiQEFaOdElaPlbiHM=;7:TaNqHgRzlQfFX/9nU1asetKOCWXPF1LbyQyWFkXq8dn6NR7lUGB2rSpApcYsudM86YbIRlp2mLkXo5Tn+kYuFnVvHn5KbYw1EK6jidEtjDerTUHVbMgAMbnxDKbLk2arje6BEONwBQFmTduuJzs6QfABvwa9dv9EbInwVr8p4eAfJoUj2JYoGaSv+smx5kCaUe5Udvb2vZCzlJwenaMGqrkvJZ26q6dv0ucyw6alRMuVal0erWHG84Wcbec259lV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: ysoft.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2018 09:11:35.1859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c249edb-1979-4abf-47fc-08d622c6e4b2
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b5839965-430f-4be2-b282-d7a3149f2b37
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4667
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Since commit 7e5d1fd75c3d ("pwm: Set class for exported channels in
sysfs") it is not possible to export more than one PWM channel.

This is because for each exported channel a directory named pwmN is
created in /sys/class/pwm/. As channels for all PWM chips are numbered
from 0 it is not possible to export pwmN channel from one chip and
pwmN channel from another chip at the same time.

In theory if your SoC has N PWM chips and each chip has N channels you
should be able to export N channels. But only one channel from each chip.

I found the issue on i.MX6dl SoC with two PWM chips where each PWM chip
has just one channel.

This is how it can be reproduced:

root@hydraco:/sys/class/pwm# ls
pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0
pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmchip1

root@hydraco:/sys/class/pwm# cat pwmchip0/npwm
1
root@hydraco:/sys/class/pwm# cat pwmchip1/npwm
1

root@hydraco:/sys/class/pwm# echo 0 > pwmchip0/export
root@hydraco:/sys/class/pwm# ls -l
pwm0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0/pwm0
pwmchip0 -> ../../devices/soc0/soc/2000000.aips-bus/2080000.pwm/pwm/pwmchip0
pwmchip1 -> ../../devices/soc0/soc/2000000.aips-bus/208c000.pwm/pwm/pwmchip1

root@hydraco:/sys/class/pwm# echo 0 > pwmchip1/export
[  543.110824] sysfs: cannot create duplicate filename '/class/pwm/pwm0'
[  543.117314] CPU: 1 PID: 351 Comm: sh Not tainted 4.19.0-rc5-00025-g249f3ed-dirty #8
[  543.124990] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  543.131587] [<80112d20>] (unwind_backtrace) from [<8010ddb4>] (show_stack+0x20/0x24)
[  543.139383] [<8010ddb4>] (show_stack) from [<80ba1044>] (dump_stack+0x80/0x94)
[  543.146652] [<80ba1044>] (dump_stack) from [<8031e2b4>] (sysfs_warn_dup+0x6c/0x78)
[  543.154257] [<8031e2b4>] (sysfs_warn_dup) from [<8031e61c>] (sysfs_do_create_link_sd+0xd8/0xdc)
[  543.162988] [<8031e61c>] (sysfs_do_create_link_sd) from [<8031e678>] (sysfs_create_link+0x38/0x44)
[  543.171986] [<8031e678>] (sysfs_create_link) from [<806026b0>] (device_add+0x2c8/0x630)
[  543.180025] [<806026b0>] (device_add) from [<80602a3c>] (device_register+0x24/0x28)
[  543.187724] [<80602a3c>] (device_register) from [<80501acc>] (export_store+0x118/0x190)
[  543.195762] [<80501acc>] (export_store) from [<805ffc10>] (dev_attr_store+0x28/0x34)
[  543.203539] [<805ffc10>] (dev_attr_store) from [<8031d7dc>] (sysfs_kf_write+0x48/0x54)
[  543.211485] [<8031d7dc>] (sysfs_kf_write) from [<8031cde0>] (kernfs_fop_write+0xf8/0x1e0)
[  543.219696] [<8031cde0>] (kernfs_fop_write) from [<80294d78>] (__vfs_write+0x48/0x170)
[  543.227645] [<80294d78>] (__vfs_write) from [<80295064>] (vfs_write+0xb4/0x1c0)
[  543.234981] [<80295064>] (vfs_write) from [<802952e8>] (ksys_write+0x5c/0xbc)
[  543.242144] [<802952e8>] (ksys_write) from [<80295360>] (sys_write+0x18/0x1c)
[  543.249313] [<80295360>] (sys_write) from [<80101000>] (ret_fast_syscall+0x0/0x54)
[  543.256901] Exception stack(0xecfbffa8 to 0xecfbfff0)
[  543.261980] ffa0:                   00000002 76fc8000 00000001 76fc8000 00000002 00000000
[  543.270184] ffc0: 00000002 76fc8000 76f5cd60 00000004 00000002 000bd134 00000001 000ba730
[  543.278380] ffe0: 00000000 7ebff954 76e8b988 76ee3cd0
-sh: echo: write error: File exists

I am not sure what will be the right solution. The problem is that
numbering of the PWM channels does not work the same way as in the GPIO
subsystem where each GPIO has its unique number.

Should we just revert the change? It was not documented in the PWM sysfs
interface. What do you think?

Michal
