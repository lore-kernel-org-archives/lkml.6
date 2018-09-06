Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60740C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:30:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D042D20659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 07:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="QACwESki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D042D20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727865AbeIFME2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 08:04:28 -0400
Received: from mail-eopbgr40047.outbound.protection.outlook.com ([40.107.4.47]:12512
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbeIFME2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 08:04:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LK+H4n5MasHifsxJZloLwEZNraZVKuhp4BOHZAuQj5o=;
 b=QACwESki0OuvzPM3FuOMjUFWFdYY7rP67zBQ677EdvpLul1UnExJFdBg/ley1nJ43bvnCs7F3jbDhACFG6kl9kHJaXFGsXeK8PYH3CBnoi/n7HeX9N5Eep6UjduANAqbSl/F2Zc8Uhaad02/0xQbQNOPC/0qT2tGirfykhBr1wE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=moshe@mellanox.com; 
Received: from [10.223.3.114] (193.47.165.251) by
 DB6PR0501MB2551.eurprd05.prod.outlook.com (2603:10a6:4:5e::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1101.18; Thu, 6 Sep 2018 07:30:14 +0000
Subject: Re: [PATCH net] devlink: Fix devlink_param_driverinit_value_set()
 stub return code
To:     David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Jiri Pirko <jiri@mellanox.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1536066265-18641-1-git-send-email-moshe@mellanox.com>
 <2bf31ad0-c3f8-cdfd-8b96-1a8e3280064d@gmail.com>
 <7fd426d1-61a9-7f45-bf26-05bd9e180277@mellanox.com>
 <b660e196-9277-f66a-5be8-4288f73b9305@gmail.com>
From:   Moshe Shemesh <moshe@mellanox.com>
Message-ID: <515d8c65-9225-c184-5649-9d65547c4385@mellanox.com>
Date:   Thu, 6 Sep 2018 10:30:08 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <b660e196-9277-f66a-5be8-4288f73b9305@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [193.47.165.251]
X-ClientProxiedBy: VI1P18901CA0007.EURP189.PROD.OUTLOOK.COM
 (2603:10a6:801::17) To DB6PR0501MB2551.eurprd05.prod.outlook.com
 (2603:10a6:4:5e::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c33dc4f1-5e7b-491b-82e9-08d613ca96e5
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7153060)(7193020);SRVR:DB6PR0501MB2551;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2551;3:ThMOq39ASGlnludV5VBLqEsSgo+sBaatiuBI+mefwiHgh2uMVBUNLzSUhONWRAOYwH6SIQAuLc6ce4f500iQE6zS8fkR2fOy9b24cQIEohTdwRIQHJu3ZNjejdAJqkeadlrkiqbU18KSfAK+s6crhA2y+C67ik1OIms6W0J85bh30i4Vqzmaw5s2yUbFcOPoEQtXuFDXf3PL9sD6FXXJaeAsGCUN3/HEqwRLfl8LejULFPS9QHTy6nviDlznyUY1;25:0AwOKBpRDsQwyWqgSMOc7X7mdA/KmGjsF5V0akvJG77RLHdpNsEgIaa+qxmRRe8XCBBuqWnq0L7kAFODleBx8hiDlqH+40ovwxoV91LA2PPYx2w3Ak2xctCy+/zkgV0pFr5NW63DZHvM9KsgPwNV5u1xNLHFmUEqLLxlnFlCbH3ELHcqvQpU2+HnUNK8uCfPBZC+PmpeT4g2vhpHU+Pb9hjLkS289guvO5DbuvXOCTY5dDcATeNr6M09/Y1xqLNyjWISwsIuB0qzjdM6Ll9GQPoU0RABWf9gsADJk8Iw/nvj8VhlLXfjYeaaiOoHKhiXiZTVyP9OaY7PsgtNe8q29g==;31:AsWpkUn/Ky/SJv5XLdOtz0atvxnKY4fZcrJ2xIBTilBHuRT/rw5NgOUFcEdp3rapfLPOSkSbZr+tyb5PoPlJN7ZPhK1XmtBKIkthBi48GPztX8M5TekMwDfNRTvZyFZDZrLO5Zigy90V/gwdR7pbAYP8Q7GEha+4MBcFklqVQJV/SQ9Lm+pS/RxjtjaNzMCUGYkivAit41fd55cVbW0ucNaYSnKV6+G4O+QWkPbe0+0=
X-MS-TrafficTypeDiagnostic: DB6PR0501MB2551:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2551;20:zzu6rVX3JOm7DS+mHeDIXyZZNQuIdTC1pG86jNt1Lt5HnQem4wrUDjqeT63qtQnxokcy6qCXARfkyN0wK6o5rYlosvD6nuAqUdIoshqnYQteZdmrNHKs6hpKlJgdjPiJwH7qmY6Jm1jt5H3fvgeEpt9wpUCHl/CLIym0bq6JAEC3yfYgAtZv8Ymi2reL0GWUIU4miyq5lDEvca0GsijKQVdvz9E8u35otwKDG/onHalL+iH41fOWoeu7ypT4JrdkY9UTf2gzA5IbKXdECTCydSWaMItTk1jxP22nh56Xap942Fo/WvodGLdYBuriV49umkYPdElYu28UIw9W8z31KN1IC6BKUlETEDlKe9v3JVHW8kfZubju/x5eogMYj8472QOS1Lsduf1J+PDUpYn4kW0ecP0IPUxC38A+CSXeZg/OUtdrTXFLpIuLd4QTg521cx0zV8KiOeUm1M0wJtvmNOETa1AQJmIqq1uCGUez3i8KAKKLRBz6/xE/7n42xczW;4:heFn9mL8IOFS4bpSPQoTwasgoA7lBrG+nDbPlsYhHRNJtqSjNzDGl6POsfixaB8zyYSK1aeHVCp6zZ9MefgIt14iBrA2Wm0An/jN+U1IhCRn4wVDjFGcegT1EWygb726/rxdk0ccjPnduOH/cz/1/ElAFs8CpqforLHMWL4WKCq3LH7rdOFlS4i8L90QnPod3RFqkzTO3e3hrdkjFzxorGM8dr6VpbdSTXOSh6hIN1L3XROEkTzjCAHgp0uUJG2Y5hLJzlHuBhXHxE81g9xg2w==
X-Microsoft-Antispam-PRVS: <DB6PR0501MB2551D192B95DA7C90624F632D9010@DB6PR0501MB2551.eurprd05.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(823301075)(3231311)(944501410)(52105095)(3002001)(93006095)(93001095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(201708071742011)(7699016);SRVR:DB6PR0501MB2551;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0501MB2551;
X-Forefront-PRVS: 0787459938
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(366004)(376002)(396003)(346002)(136003)(43544003)(199004)(189003)(23676004)(956004)(64126003)(67846002)(52116002)(39060400002)(316002)(25786009)(2486003)(52146003)(16576012)(58126008)(53546011)(110136005)(97736004)(76176011)(478600001)(26005)(77096007)(50466002)(2616005)(8936002)(386003)(31696002)(4326008)(186003)(106356001)(81156014)(86362001)(476003)(105586002)(81166006)(6116002)(68736007)(5660300001)(7736002)(14444005)(65826007)(2906002)(2870700001)(31686004)(3846002)(305945005)(93886005)(16526019)(229853002)(8676002)(6486002)(6246003)(6666003)(36756003)(53936002)(65806001)(11346002)(446003)(47776003)(486006)(66066001)(65956001);DIR:OUT;SFP:1101;SCL:1;SRVR:DB6PR0501MB2551;H:[10.223.3.114];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: mellanox.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA1MDFNQjI1NTE7MjM6VENQUVUxc2UzNVdjUlNyeVJFWjdMUmlC?=
 =?utf-8?B?czBzKzQvMzhYbzM0WnpPSWlHNnRweHhwR3pxZjNRc0VicXZ5U3lqYzBYczhp?=
 =?utf-8?B?SEVzeVBxQlZoSy9JaWVTQU0rb09MbldrL1hhcy82SDcreDJNMVVHNTFmRmFI?=
 =?utf-8?B?Tm52QUE4U2dSazF0WktkamRRWkZxT0lvTWtaVjg2eHIrTEFFNHVMM053M1Q2?=
 =?utf-8?B?ZGlkMk9ZVmZVcTBSR2NMcXlCVWg5ZmtjRkVnbVltdEYrM1BoUW93dkdKeVJ3?=
 =?utf-8?B?VXhqZlVRd05NTWdiNlZhRjM1N0NGVmZCOUR2OWRDMno3UlB2bU5Yc3R6bkpL?=
 =?utf-8?B?NFNNRnplSlkzTXBjVlpReVAzanhycUZ4Wi9Gcm1BVHVSbW8wSkVpR3hNejQ0?=
 =?utf-8?B?STBubVN3ak1USjErZXVTZ2VhditwVnFUZlBqQ2huZ3RsTjZHa3BacUJka3FQ?=
 =?utf-8?B?ZU9kQlVuQjQ3dTB5Q2t5aHVQaFRteDN5WkpOb2UyZTR1SjBBaHphNUh2eW94?=
 =?utf-8?B?ODQ1dExYbWJpTExPOS9DeVVjTHN2OUE1RE8rOVZ6aHUwUkJsZWpKeEZvd0l1?=
 =?utf-8?B?UEJRekZhazllRXA5QjE4QzViTUFLWEJXMjBpOUpXQXAyMUxyNzhpLysxeEds?=
 =?utf-8?B?eUF6ZDI5MHhMVlpQTHRvc3crek9WV3k1aWVDYVNIMUlXbTRnZE1qRjF0RHpt?=
 =?utf-8?B?WlJiL29GLzRkcjU0WHZPK01VVDFCZU1QUTMvZWJxRGJQNXEzaWtiVzhHOG1Y?=
 =?utf-8?B?YklhWk9MY0owYUh1TjN1Z1NKRUN4WW90M21XM3JRWXF5THdXcENSb1R4SDAv?=
 =?utf-8?B?MkVkdmxkTHJUeC9mS0xZR1l4eVM2dTV5NFgrYSsxTDhoeTh0VWJoZG5jNUR6?=
 =?utf-8?B?UlY4WVdlRENPM0JTWFpPU1N2clRLTzQzU0pRZUpkby9oYzRZeUNhTlIyNkZo?=
 =?utf-8?B?Lzl0TmlOVWtnenVqMmpxRTNzK3h0aEZteW1DQTkrTjJEY3BPU1RTOExhL0JL?=
 =?utf-8?B?UWNWMXVTMk1JN2wxa0xlYVRLcThTS0p1YnovdFF6a1EyUG0wL1pzVC9rM1lB?=
 =?utf-8?B?ZFNmMDh3a2hMcThOVlBtcEM0TkRrNkdsdzArZTBzYXQzaUh5SlBObmE1RVBq?=
 =?utf-8?B?blZRWU5Jb1FnRWNqanRhUGhiZzZhSWkxb1ZYaExCSnU2ZC9IbHZnSHg3Zy8x?=
 =?utf-8?B?eWdLeDVsL2syaEg4OGEwOGp1TVJ4d3R6dDFXZ281b1hRSzI3MzZFUSt4R1V1?=
 =?utf-8?B?LzMzQ2Y0YjRDU1pRNnRJMnE4ZFpmanhnUkdDeU5Sdk9jYm9VaWt6WGNZb0Jm?=
 =?utf-8?B?Qmt4OFQrbFJKZ29KLzVRLzlKSGN4OFhHd0kvaE5UR29DbUdtaGJmOHBsRDFs?=
 =?utf-8?B?TStiZ05oZldJelRWblpxNUc0NThMY0tPSUdoVTdCMUlJS0F1SVhYMzdGTmxQ?=
 =?utf-8?B?VkhYcGVYYzVZalEvOEtOZ3VtYk5Yc2hOYjlKZlExQ01KNW80MUdaUVJhMmlv?=
 =?utf-8?B?b0hyL1kzVXFERlc5eVF5SUZROVlreVloYk5FMjRta012UkY5eTNtL1ZDb0NG?=
 =?utf-8?B?cU0rQkZLYUFUc2gxZ2lXbWRzd2xUNTMzenk5aHlUcGdLd3lBMHdBVmJFMTRk?=
 =?utf-8?B?SzdndHhUdDNNb0tGV2k5d0pBYTNzZnhVSENPZDlwMFV2UFVhZlAyOTZCTGxa?=
 =?utf-8?B?aEJxY2pHSTFxYUxqUXlYZXI5TjJsK1FiVjRhRmhWb0lWRDlQOFJ6SCtVTU5G?=
 =?utf-8?B?MGVCVDlPdTRFdDlWK1NrZERUZGEwVlpzMnMzMkFUTlM0UzNxOVVkOWxwcG4x?=
 =?utf-8?B?SEc0aGdUNHZIWmsrcTZlS3ljK0l1NUFYd2VBNmtSUW1MWnF6K3ptMEppcURM?=
 =?utf-8?B?QU0yZnRudVBYdXpUMXVpWHQyc0xVVHRwWjhkdSs3YjhtbXU1eUF5RVpvYWIw?=
 =?utf-8?B?K3pCc2kvZ21iN2ZBdVg3Q0RJaEpxeDZqSHZVQVMzQWtjazBPb0FZSzRMdGRw?=
 =?utf-8?B?VlhmNnVhZDBlM0lpaVFVZGlSMElSWDhGNUpINzdEMWJ0bDJEdG1IRnA2ZllH?=
 =?utf-8?Q?ay2RlC5fEEKvZ10uSEuwbEziViS?=
X-Microsoft-Antispam-Message-Info: oId2X4BczJd5SHrb4UikhCOUMxN486qIqH4LdoOyt/EOTiuanWPFKMC55gOKkNBr1bD3YJsTnXOkaVDe3i5md0LL3CopkKy6LcEwPvRBecNFNOl9eMW+lh+cWtc1iYMJH/Q56mUmx3Tysj+QcFj2odB+Mcc+i2ztaEjfkYl+e3PPcwkJ7qncBYq7y5pbJjnIaBL9OoK7PBudcLBO6B5DziEImMq4msdKBZxxjib1I21y4L7t8gcRFSRwO8XUh+0C7/s5YKz/ffjcVCnZjeV1zx+3cYideCPthoU42IeZB8BUHm4pJnOM6fOxuKeWsvKK49aPbcH4HYJrYC4kDwYmLrVFEyCfOUyLBFMYhc0yyfw=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0501MB2551;6:WXgP30qbM1MFQBONaVRwfOkEDw9fP96jv6FW3Vg8RXXLo/W7fKe+iVdg/JxmzEGUlNZNhN4xhRQa9zHFTpj00uBuBc4FyBseJmNRhuq8T2xD8dHxR5rcNsaLuOtVaNtHKaJwsehDYC8PTVs7hq5L3a2tUl+fcMOKASJ7CyJeMc3uOZM2tjb7wU5kK5LIfOcc/cm/V+jIChRmQvTnkHNl+M3TWfLfVvNm3V7XzHPcMVgRAEdh90uw2CrFBn//UcBMVpdFfvyG4Zk0jFL9qEDHAgyFIqe1cvhlBb1VcKkPDTFT5V5gQl1CMMgDqFz32hQT5HDUjx5vLsjMS+wWekKKXMLkHLKusNmqGeufPfBOPE9lWSUlPsprST3j++UJjuk/H9QQOmF+SjLL59Msr1VDMoe4AkKzIkf2eYcXd+aCDnxA16V/D5Ke7HYMlUN5pubf/GqUqUimuJceeo6kbQJ7cw==;5:JyrEtKMrZGCIu4NkAh9bocE2KaF9l+M+DD0pegs8WIeLinKV8gSGvqmjfy1qpYb120XmOX0LxqHVg/b7TvDQ0T63Ox5xt58i9HBLn29VRiTaXD2ZhuG7ZiySNOhR6gBREjacFbfx7ZgDDJxh5R0H6TBhMN+2n8rWuOkzLdJggxY=;7:hlm2BZ8GyVJ0/Ce9WtZ3IUpprgoCK31k/bOeK8iL9BlV5o6fHI5Dx0+8Mc5W/FCT/Ne98laXDH2/VZoZ07sC65Cy/UAk/1qicfDzmR4Y9OOJMnkNN/DUmW05VHL9M1p5095YouuOZ/P1kLMDkpuwijare9XJSjbNMyoDMW3Ct8MtyEC5KUTvSdPualQJq9myrddv9GuQlCl4/8rdNxMDPdY1qrr4/3f2NGnyrQhpMJ4Ss5u76/GSyVmQs889YbYi
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2018 07:30:14.7167
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c33dc4f1-5e7b-491b-82e9-08d613ca96e5
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0501MB2551
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2018 5:26 PM, David Ahern wrote:
> On 9/5/18 6:48 AM, Moshe Shemesh wrote:
>>
>>
>> On 9/4/2018 7:13 PM, David Ahern wrote:
>>> On 9/4/18 7:04 AM, Moshe Shemesh wrote:
>>>> The stub function returned -EOPNOTSUPP while CONFIG_NET_DEVLINK is off.
>>>> It caused false warning during driver load. Driver needs to update
>>>> devlink on a parameter value if devlink module is there, if not it
>>>> doesn't need any error code.
>>>>
>>>> Fixes: ec01aeb1803e ("devlink: Add support for get/set driverinit
>>>> value")
>>>> Signed-off-by: Moshe Shemesh <moshe@mellanox.com>
>>>> Acked-by: Jiri Pirko <jiri@mellanox.com>
>>>> ---
>>>>    include/net/devlink.h | 2 +-
>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>>>> index b9b89d6..b467357 100644
>>>> --- a/include/net/devlink.h
>>>> +++ b/include/net/devlink.h
>>>> @@ -781,7 +781,7 @@ static inline bool
>>>> devlink_dpipe_table_counter_enabled(struct devlink *devlink,
>>>>    devlink_param_driverinit_value_set(struct devlink *devlink, u32
>>>> param_id,
>>>>                       union devlink_param_value init_val)
>>>>    {
>>>> -    return -EOPNOTSUPP;
>>>> +    return 0;
>>>>    }
>>>>      static inline void
>>>>
>>>
>>> This should be handled by the driver -- check for -EOPNOTSUPP and not
>>> log an error.
>>
>> This is a stub inline function.
>> The return value would be ambiguous as the non-stub function can also
>> return -EOPNOTSUPP, in case the driver-init mode is not supported for a
>> parameter.
>>>
>>> devlink is generic infrastructure. If a call is made and the operation
>>> is not supported, then devlink should return an error.
>>
>> In general the stub functions should take care that the driver won't
>> feel the missing code as much as possible. That's why
>> devlink_params_register() returns success and so should this function.
>>>
> 
> A driver is accessing core infrastructure to set a value; core infra can
> not because the code is not compiled in. The driver should be told that
> the option is not enabled, and it is at the moment with the -EOPNOTSUPP
> return code.
> 
> That is similar to devlink_dpipe_table_resource_set which returns
> -EOPNOTSUPP when devlink is compiled out.

Yes, that was my original thought when I wrote this stub, but actually 
in this case the driver has the value and it wants to update devlink, so 
devlink will have it too. If devlink module is not there why should it 
really care ?

> 
