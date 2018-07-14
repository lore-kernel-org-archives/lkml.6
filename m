Return-Path: <SRS0=T5ek=J6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB3FECDFAA
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:52:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E91C92087C
	for <linux-kernel@archiver.kernel.org>; Sat, 14 Jul 2018 19:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="UvP3P+na"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E91C92087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731225AbeGNUMH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 16:12:07 -0400
Received: from mail-db5eur01on0103.outbound.protection.outlook.com ([104.47.2.103]:10080
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727511AbeGNUMH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 16:12:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q+FG8WsNE7DWlxypt8eBgcvx9JSvOsGxfmVSt+4dq7A=;
 b=UvP3P+nadvNHC8IUydNcEQ+6v6rjMO5GyXDPJ+mmVTQVT4Ph+1Gr8EPFPduQ2hIBrC+ceM8cXkHkdchGx+K0f1Ks13NXJACDfYp87n2zYdW07ngbHYkT3RuCHGqZCcduPy0Hx6xHCiLQ/IIMqDvlcAkPtW/KBSezSMJZ9HwCRBc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=peda@axentia.se; 
Received: from [192.168.13.3] (85.226.244.23) by
 DB6PR0201MB2453.eurprd02.prod.outlook.com (2603:10a6:4:34::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.952.17; Sat, 14 Jul 2018 19:51:54 +0000
Subject: =?UTF-8?Q?Re:_[PATCH_1/2]_mux:adgs1408/1409:_New_driver_for_Analog_?=
 =?UTF-8?Q?Devices_ADGS1408/1409_mux_=e2=80=a6?=
To:     Lars-Peter Clausen <lars@metafoo.de>,
        Mircea Caprioru <mircea.caprioru@analog.com>
Cc:     davem@davemloft.net, mchehab+samsung@kernel.org,
        akpm@linux-foundation.org, rdunlap@infradead.org,
        linux-kernel@vger.kernel.org
References: <20180713122738.5888-1-mircea.caprioru@analog.com>
 <b3540119-73e1-38d5-1dc9-ce9f8bdad9e8@axentia.se>
 <059d9750-8715-bc4e-185f-d52b48ad9b59@metafoo.de>
From:   Peter Rosin <peda@axentia.se>
Organization: Axentia Technologies AB
Message-ID: <3e01389e-a18b-a9d9-677a-dd1258417c94@axentia.se>
Date:   Sat, 14 Jul 2018 21:51:49 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <059d9750-8715-bc4e-185f-d52b48ad9b59@metafoo.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [85.226.244.23]
X-ClientProxiedBy: HE1PR0501CA0005.eurprd05.prod.outlook.com
 (2603:10a6:3:1a::15) To DB6PR0201MB2453.eurprd02.prod.outlook.com
 (2603:10a6:4:34::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0cad09a-b9cf-4341-4ae3-08d5e9c3404e
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(7021125)(8989117)(5600053)(711020)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:DB6PR0201MB2453;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;3:q5VlSOFUpwc+aMXgBjztlIFakZVfLgUHr5+dXUpQYzcCRQC+veUaDHLOliN1jm/KPR71PfiqVEkn6om8xqDGTRf3qks3Z8qnSYITCWcTc7RpdCbs2kYP8el1tsQ2Nk6bQ87qwu/UEPusV+Mw8q4VupAgRRkg825N3WezeaWgw8teEJ/q5SqxGvWAqtm/CU7jQb55cMrJaTbrJ7tIUKc4G7BU5atHUyzdWR1DaGAnuf5gkbdfXbfSHAToJVdPQIfJ;25:qWONeQUxUUTS7T1RUI7fxWbtHBZb5J+H/zdyBcDnDV50g9ClWb/J08BP3TH0A0SErRbi1yNP6pjY18jMOSKDzh6Ge2kXE9S3Mh0VI12ZBmEmjayfOseC2jv+K5AYuomLwXls27Zwzr49zMn6jTpn2dL56qn/nyPLsD/9XMpld+GXaP1oDvblUQ9NSD+W9RZux5eosTw8aUo+hrdgR2uuv64VeHpL2V+N2pweu6qVEm7UECxb/m/zdl+Vcl8k41xc3rfacOxKDngpxx/tomPtqxFV/aXsCC/Q8tLWe3GWngmxIIYFpN6ism2/yCd37k41st33U0pkiLN4Yv4+GZ0VqQ==;31:pSKjflF0BoZYxX0C18Wx2G1A0x27Kk67JIA5LDGdBoz38EvXM24ANR01O03+XXe0nogPXPReXbvtCy6HvT9C94i0cOyk9XwTqziO9utoSn91eH5517af9GmYXi8O6U+LezrGfPaVb30HSRJgxvMyiRVM9las9sJw+dCIAS6d/K1W4wmcEf2XSRuBxhc8YYI/JPZIRUD0yUCYp3s2wx7cb95+PR1p9M55O07yEce4Y6o=
X-MS-TrafficTypeDiagnostic: DB6PR0201MB2453:
X-Microsoft-Antispam-PRVS: <DB6PR0201MB24531D8A6AD11BE3E68CF55FBC5F0@DB6PR0201MB2453.eurprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(3002001)(10201501046)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(2016111802025)(20161123562045)(20161123564045)(20161123560045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DB6PR0201MB2453;BCL:0;PCL:0;RULEID:;SRVR:DB6PR0201MB2453;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;4:PGCTeMiJeSh++uP36VgNBaY8o2qxzPEY9QlO7chTGP1R3x2ld7U3nsAoDMsLKPVR9Cbe1LDc/3uC6NWOQtGWxQse0DMUKudDXHHy861d5X2w92Hj6r4G6HMWCQy3HSbYswL8fjHuUC5jVfsSjNKwLLFahISt8gZW0plFhkD1D2nSQHa3CEktXilIai7bgryNgP8E/EfRsFKrcMech8qYbJquXLe0iuXgWMIC937K0SlJn5le/ie9LWV3k6Mn1u1WbMzO62dGPWvhAuPJ8LFHNg==
X-Forefront-PRVS: 07334CBCCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(366004)(39830400003)(346002)(376002)(396003)(136003)(199004)(189003)(5660300001)(81166006)(81156014)(86362001)(65826007)(64126003)(305945005)(74482002)(66066001)(65806001)(50466002)(7736002)(6116002)(31696002)(6666003)(47776003)(3846002)(31686004)(65956001)(97736004)(230700001)(36916002)(478600001)(117156002)(23676004)(36756003)(52146003)(2486003)(3260700006)(52116002)(4326008)(25786009)(68736007)(58126008)(53936002)(6246003)(476003)(386003)(16576012)(316002)(76176011)(2906002)(77096007)(486006)(446003)(53546011)(956004)(2616005)(11346002)(16526019)(105586002)(26005)(186003)(110136005)(106356001)(6486002)(8936002)(229853002)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR0201MB2453;H:[192.168.13.3];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: axentia.se does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjAyMDFNQjI0NTM7MjM6ZHBTc0w1M2M1aEZENjV5NjFQSTZOWnpj?=
 =?utf-8?B?SDdUL2trdzZjZ0RmdEFzZFdxN1Q5cXJ3dFVZd2JocktGR2hTMnpMWUFjNG5l?=
 =?utf-8?B?ejhWRVhCZzh3Wi9QRkQ0aVI4WWdnY3FQVzdQS3pLcFlLY3gzZHlpbmtKSGFG?=
 =?utf-8?B?b2Nad1FYQlUybm5VWWZMcWxHYlg2eGQyVm5JQ3FyZWYxaUNUbTJEQXl1R3FT?=
 =?utf-8?B?V21mWEI1N0NHcFFRanZwV3FIbjU0VFJWcXlpdDl1RXVWMGNqb1dYLzJnVXZL?=
 =?utf-8?B?azdaRUhkaVNJUW04Wmx0MnI2cDZwRjUvcTZLZnFiMHBudFBUUWE3SWY4QlhB?=
 =?utf-8?B?YmNaZWVVUi9RWXdEWlFmMlBkeTBTeXdCS3FPcGEyYjYwVHRtZlVtN3FXdFBJ?=
 =?utf-8?B?Qms2VXJYazVPZWZvL1dEaXNBRVBsVmlTcUtTL2ZvY2Q4dU1TWDZ5YTRudzhX?=
 =?utf-8?B?WmJDVUpyaDV1Q2NtK0U5NG45SWluZERGZzNocWdCeElEdmRwTlFURUw3VEg5?=
 =?utf-8?B?eWoxSm1CdlVHeEVwRndtdXZscXNPdm1UMXdDTGwzQmpvZFBmMTJOejBwZ2Vv?=
 =?utf-8?B?aVdCU0t6b2lZTVpPR2J1OUJiV3d3anI4U1lHWmJGSURBQnBqUWZaZnk2Zkw5?=
 =?utf-8?B?WnY2MWxqZEh1NlZPVjNDbXE2T2JlYUxJdktkWk1TWXpvVUlNS1JQVzN1UkJG?=
 =?utf-8?B?aENzWXNTd203VEVvdStjRDhKZUlQcGV3OWRpTWtWZWRaQ0hBSkphdGpFS2k0?=
 =?utf-8?B?SVVIZ0M4NmpqTUJ2M0VOeFNRUlBYUXVKWXlkVkIwcHJFYyt6eUxLdlJiclRF?=
 =?utf-8?B?d3Nxc21NMll6ZDRIa3JYMGk5OEMwY1pZUWZ2bHR2enFORjRGSi9DOEE3NTc0?=
 =?utf-8?B?UTF3V3NLb0lWbHNDYjFxdDhFdUYrVFhnUDU3b1psd0xOc1d1QmpvWDlJZkIx?=
 =?utf-8?B?TDRnOU1HL3o3UDBPUE9OdlM4QlZLYmNVWmFvUHVCMFNybDFvdTdHa3JUOWNQ?=
 =?utf-8?B?bTdJNjlxYnNOVVNodlFuVlJlZFR6T0hnS2swUjZtMzFSaVhjWktyOURGZUhS?=
 =?utf-8?B?UHZOc044Zkp3VGc1bmlwTzVmVloycVFIVXQzMXJ2eWtsTXFyZWJ5TzVkVmxj?=
 =?utf-8?B?dXIrR1NOWUwvNnVldjdvclpNQ0xFWUVxVWhiMi82MWJ1K3RNVUVWV2FCeUhE?=
 =?utf-8?B?WTJDUjRVMmZDS21PbitacENoYnljY0d1c2I0R24ybDhEZy9vQTl2WWh2K1l0?=
 =?utf-8?B?YVBsVnZSdlpnYk0yY0E4WWxnVzl5Rjlrc3ZIYXJrWWlUOUFtaGJqNDVFeUwr?=
 =?utf-8?B?N3hnQlhiKzd2VjJwbDV6dDVzbE5qUFVWYm9SY09NcC9DOUoxY29rak9pVXZS?=
 =?utf-8?B?ak1RNEJyNm56YjR5VUkxcU1SZng4RUFzOHV0RGJJdXp4WG4rdGEzQXZvTGlD?=
 =?utf-8?B?SFlxYzY3U0J3bk1Ya1ZLTlpDelNqUmpEYVVnYVhpOFJsMFBBREY4bllRSzl3?=
 =?utf-8?B?d2M0dTlzZWQweVJuNFdoRUVyN2lTNDEvWFNUV2txM08zWTBsWkN2TmlOb2RQ?=
 =?utf-8?B?bE5hOU5nR3NuZW9vczBRREVrK0ZVWkp6Mk9NQ29ZcFhRL2JsQSsxR0lHejBx?=
 =?utf-8?B?RlpzMHdqM2dVN1QxaW1VaGxFWm5TZjMrbzVHNUhvcnJ4Z0JnQUFVRmorelFP?=
 =?utf-8?B?eXp4cG1Gdmh0Z09BbXkxTFgxMnZRYnk1VDh0R0ZKendTRFUrVWxqSmVFK011?=
 =?utf-8?B?S2JZNVh6Yzc5dzkrNjIzdzlUNDhFRFhIdjhtdnBZd2VPUlBNMzR6Sys4QXhV?=
 =?utf-8?B?ak51YmJBZTBpZm9Zejc4Zk81UWJDbCtGQ2k0elIrUXVuZTkvRVhKRE9FTmNw?=
 =?utf-8?B?NDVoU3lzU3Zac2syR2FwSXFqUCs2RU5hN2xGOThDUlJrcmorMmJzRFNsRFE2?=
 =?utf-8?B?NTYvbGlic2lzQThPRFlZdElOZ3h2Vk9IRVE2MnlTOVB0ZFd3ZE1TL0RzVlMz?=
 =?utf-8?B?VjMxMm01V2RTTTJDNFdqVms3ckxRNnJFRkRiTWhnPT0=?=
X-Microsoft-Antispam-Message-Info: V0b2jFVVF1ONenuDuCiCmmm98BKRP43ZT3usem3nWnUBY//9RoxGWamio+/qlWWxC+hBpmP2uXTZhr5JwHS7T5bL1La/oe2kCVX8J27vh0TsmDntW+O7GfdLla+7fGMpR4U/6xxCSVUVHYypzRvAC6JBUHLJKPz8zwb1PbbCV7Tgr9CMjdsJ+Wn5es44lIdTCYESHjYhyfy8SjUuWAoCHvZ8bmPIyU0Aro19AO5uMz8UUNrE0JoPbJgKV5ijbuFdX2sK7P2jjlBLsKwzJhx4Z8l/iOZVWdb1ZY2u/ZKJ03wEcI4WpNIHSwJI9xPHeJ1I1YK4b9xxufXb0aY22CPU351QOf6Cs5lhMkXGS7gHYME=
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;6:G28/KofrlQiZzstDkCGjy3ONNxBcDjvr1bC/B5UJ9/C++6UXR9NQ/FUxWX1hyj6WB+P1lGbtQAap/dDlyzRJ3qSnXi61QnD/xaP/9BkjTEPr/pM4BpGzPTDxddvyUlsXyLQW2FZ1UV/TKyjhdG49PW4Ze47Nhv520xsNiAPO5ImGgA19hNXcd4sRtyj7j1DbDebjOiuvcjfdHbs4TpgzfbeKtdU3v86Bfe40skCjtAI0Q/H70qhct1s76HZTS7kDRjV8BEEpGDFWTM46AUQxTHpMczPz/BO7NMHCz2LeeI/yyRmaIX5hvaWUNEkrZYbOABa9uZqOc4AXsWPuZw3KJokDcEqpIiKGb40FO+Qh6xCohZPBQV2cjC4wMl9VK3MFUBca+idmRBeS6W0fhSWv86elu96vieamxAq9Jlo/yF/Aeuo1G6Rl+8VrHRRQ3jfgPrOdhzfLSHFzpWm789LK3w==;5:y0PORHPakwCBur6IchrI0OG684ivrtj2ZtRZLOTPmoR5bf0wasF8/GNNEr4+CMRHxdRlI1IyoQs7/o2tkezw5/dLGpJSkwvoQByc/q+LZRf0pU9DaqMaZ9+XwDS2vK0E3Oihpa95rX8lGeQaPjk2WRQZccg1iToYTWwr4M2ftOU=;24:7BpNqNeYgwJhvRVDajoo95MqRl68f/n+BhZdp/0PIfAn4vX4lrGGHbPMD7JiW1NqvZiy66C1x1QT3gs9sPlzUcb2Fge8ZgNB/EFShKQH/gU=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DB6PR0201MB2453;7:gkbnac69MgBDTRk1gSruDNS1efAg1fmmXhvd0lmrbDnq4YrpiMoJqwfFItU8G58s6JKvgIhrEPTbX39Xovq0rIcdtAHfDZZSNIHYC/JWKelFUCeroCovIV3MLbvkd7HnBiUtB/cN7vqgXshDMyKZ5fivSJ3I7JBZz0Fk5HGvuuJcDDeN131kV5MN6RnYTlBZMIK7UqVktUe3RAqwIsqKarrvu4QljY2OaMVjo5pfoM+po63mMVL2BLlCc5ijt9ko
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2018 19:51:54.3555 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cad09a-b9cf-4341-4ae3-08d5e9c3404e
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0201MB2453
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-07-14 16:02, Lars-Peter Clausen wrote:
> On 07/14/2018 02:04 PM, Peter Rosin wrote:
> [...]
>>> +static int adgs140x_spi_reg_write(struct spi_device *spi,
>>> +				u8 reg_addr, u8 reg_data)
>>> +{
>>> +	u8 tx_buf[2];
>>> +
>>> +	tx_buf[0] = reg_addr;
>>> +	tx_buf[1] = reg_data;
>>> +
>>> +	return spi_write_then_read(spi, tx_buf, sizeof(tx_buf), NULL, 0);
>>
>> 	return spi_write(spi, tx_buf, sizeof(tx_buf));
> 
> Be aware spi_write_then_read() can handle on stack buffers, spi_write() can't.
> 

How obvious...

But ok, I guess the ugliness is warranted.

Cheers,
Peter
