Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11897C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96BDE2152E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 06:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="YYVtneUa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96BDE2152E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbeH0Jwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 05:52:37 -0400
Received: from mail-dm3nam03on0079.outbound.protection.outlook.com ([104.47.41.79]:57439
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726776AbeH0Jwg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 05:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uOZMk7gUrNQ/OnOf1YevTz9mTkV83rK0xVsJyFex7UE=;
 b=YYVtneUax227JR5kbBF8hO8t20bexSz0kf7hGIlgqqfrRo7MSjCtwAxa475oS2wYgzRj8up3C7hr5uecBSn3b6FDdTxppH0yvnING2g6bQYRx0pG0R3CriEUlmRz1peUIV92vbfUJ5g2wgqBnhX2+EoplXuhcNVNY71LzJAz9VM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=George.Cherian@cavium.com; 
Received: from [10.167.103.249] (111.93.218.67) by
 DM6PR07MB4923.namprd07.prod.outlook.com (2603:10b6:5:2b::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1080.15; Mon, 27 Aug 2018 06:07:22 +0000
Subject: Re: [PATCH 1/2] ipmi_ssif: Unregister i2c device only if created by
 ssif
To:     minyard@acm.org, George Cherian <george.cherian@cavium.com>,
        linux-kernel@vger.kernel.org,
        openipmi-developer@lists.sourceforge.net
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org
References: <1535109010-5074-1-git-send-email-george.cherian@cavium.com>
 <c25ed354-5971-389a-0439-369171b5aabc@acm.org>
From:   George Cherian <gcherian@caviumnetworks.com>
Message-ID: <0661f015-754e-a419-bbe0-8d1c4de57ad6@caviumnetworks.com>
Date:   Mon, 27 Aug 2018 11:37:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <c25ed354-5971-389a-0439-369171b5aabc@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [111.93.218.67]
X-ClientProxiedBy: DM5PR16CA0044.namprd16.prod.outlook.com
 (2603:10b6:4:15::30) To DM6PR07MB4923.namprd07.prod.outlook.com
 (2603:10b6:5:2b::28)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ce30fe53-bb75-4500-0a89-08d60be35bac
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(5600074)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060)(7193020);SRVR:DM6PR07MB4923;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;3:1dRjXy4FsNcyxkCzqwjYGn54UR0nVXwHfETqcpqm6qjAWDoV5zO3yxwDJE0h0SewXTDY+8W08s5fg0tRlUJ+SsbmOly7eomNT+A42gZjJUOJZBAzcZ8TYzMrg3ZB123v/M0SrzQqfiD0kpq8uLW6cinO5UEjFeRuO4Cg8fIHbgaDCNyp/0C+Tc+jhYj5oRDNbVxbY1iq0zy79AWgrCha90bcYspL3+AsYonrKPVAlWJMv+2DDU9+amZoLmk2xDeD;25:XfHLRUXqyMCClBQ0Hnd+vSbiMrMe0QEEPvtHVVCrl45uygwyuR+B7J8z/RVOuQoZhKxHQZtVuT/EbEGffwma5Epns5zmP1+12uTzbmIMImFd6EU5sikTdpH0PYhbp0ASa5pEIl8e8aw/HmNqR/beEXk/JbpU775ooEMJ1pi0a6PIk+tg8RArtpL2IMREzXchEK8bRg8EdiGlJTn7A+BvWhNEIwVs5dOyO3odBhlY/A+euGOaYXG/QFcNCYj+JzpiUG0oe94kH0YK7jDGvusoLzGIhybFaIj9deGzoqvt5rcub03igyX0M+M0oz+OHgP74SCwNSqW0TqVVGxPwzGb/w==;31:hM6eivmqhCYM+GoKkNq/kZ4HjGVgOA2XM9oZ7KkBXtEKM+ta8ZV5lySWTy0r2i3Hp5pLorxri6ET+JrWmswbiIzplORJGr8n8RMpku1xr4dI4uNuceBE5005dFkYQQySe+fvhsilE2Y9SllJolBAUWUttKN91hSJJr56xuTA3yZtTcTZxH42mA9nIInw8z1Ne+0Jpnh/lhfWQpajUvru5ovqaHzkOsVaF4n0qjz1mno=
X-MS-TrafficTypeDiagnostic: DM6PR07MB4923:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;20:d4iadftVz5DxybH2EqydbcRd1yw8EJP6rhqVInHNnayLTqkDiohhNW+Wee6eQ542MGDXvwq/4hhMfPf/y9VsMoskqCJDk/jLjYjQOJRskdajku5Ic0Yp+5sw1yY8LCaebcxGnFu34Sj/qY3eiwwBxmxbMuSDAIG4IunAFQskc/P10byWVEkzIWLFSrYxItsd9ITuCKyLkITtS2Hso0BwVkBZYi4IeY+gQrbCtno55iZBGcyIuAvhL1UxRrEcMCdWJ483FHD2mmyzfGI9c8dJpgSNZAADdkEITjYoMDKn43dYLfNPgL4rGmqsDlXxiVXSUeyQC4dR9xvgDeR+bEeHn8jIYou2JCMyB8H0z8c3o/W5XEyb+9zTVH90lmbuUCs6vP8G96+k5Tbf4LSSGqyYNvQvZ5haCsihuxnBW4MIOXmrYoLjwxIsRko593mkYHDDxB+aOZaUiPLh7PIcItexNhrgG7SZbsyuQrov175CF5Y9iTYccqwqtkCckPDnlvjuH6xI4MhSXdd8zzQhzNCQYlUiCMa9bbCdr4i8D2bQhYq21JxQ3S42MObI6P9iJuvvMzyAdKTcWe0A3Qf9pGU+7BFxDxOGwL19EjGxnUoXhzQ=;4:lSVGmn/CNEJrQe+LBLBBODa/DR84kX60c/TVv1sh2TigErYwKKmthpC6z8+SpL3wJwUelj6A2gXwEcfpAJtKuZCxDqPUz8QwRDNMgKtPYnfDCA9rwleVUNroYNVqT4M5gNm7rWR3eMDkO7BYHzH/+iDwOfsxWetRMAv8EZM00mb5ECwbGJ8odpXUHT5zp6f0a8Bsgyu45tljXoGcmn6/OiH/FOWTrULk4ghvdts+Vwh7QmYtjFlT0ciuUAAsWljZuWjNiGuKsn/gBwC6X4gZ6Q==
X-Microsoft-Antispam-PRVS: <DM6PR07MB49239CEF90DD41FF13F60BDBF90B0@DM6PR07MB4923.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(3002001)(10201501046)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123558120)(20161123560045)(20161123564045)(201708071742011)(7699016);SRVR:DM6PR07MB4923;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4923;
X-Forefront-PRVS: 07778E4001
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(136003)(396003)(346002)(39860400002)(376002)(366004)(189003)(199004)(16576012)(478600001)(53546011)(386003)(8936002)(68736007)(58126008)(186003)(81166006)(81156014)(77096007)(50466002)(2906002)(64126003)(53936002)(72206003)(42882007)(52146003)(31696002)(2486003)(23676004)(575784001)(7736002)(36756003)(4326008)(2616005)(446003)(11346002)(956004)(67846002)(2870700001)(25786009)(52116002)(316002)(8676002)(26005)(14444005)(6246003)(3846002)(6116002)(105586002)(476003)(31686004)(5009440100003)(47776003)(305945005)(97736004)(76176011)(6666003)(486006)(66066001)(65956001)(65806001)(6486002)(16526019)(106356001)(65826007)(5660300001)(229853002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4923;H:[10.167.103.249];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjA3TUI0OTIzOzIzOlhzSnNtN3FRYnpFdFZqOFEwelFHd0tsdkZP?=
 =?utf-8?B?N1RReXRjemlsUlVWS0VXd1NucGVTbUpkQno5dW1LOG1JK045UDQ1ZWorMnl2?=
 =?utf-8?B?TEJPVFNXa2h2YWwrdndqZGFYaGE4VXVMWko5MkxPMnViNEI3Y3FWVnBYaHc3?=
 =?utf-8?B?dk01eTZ3d2xid0IrdWlUbEFPejdsWEQxeWVldkRSajJTYkh2RzJKdkU5Y2Jj?=
 =?utf-8?B?bFJPeGZGdTFCR1RyMFJ4UElrLytDNVI4R1FwZTNHRHFEVnR4QVJpNjFtNVUw?=
 =?utf-8?B?K3hYUXV4eFJEc3NtU2x2RTAzdzNXdTdNd2t4MURTeDVFS0RLQzJzOTltM3NK?=
 =?utf-8?B?aU9IeFNaNk45cHNsL2hoY3F5RUZVVmJYY2tFWG9JRTNxMGc4YjdXUWJrZjcr?=
 =?utf-8?B?Y2tTaXV4dGpTY2R3QXFkUCtWdGN4bHdZNFlaYzBiQ2Vsdi83OGdRTndMWjc3?=
 =?utf-8?B?WTBKOTNQS0FQVUxvVXF3bmRoN3NHS1ZRcFNMV0NMdDlSRSt1Wi9JQzEwNkN6?=
 =?utf-8?B?NWlUcCtCaEIrZ0FCbHp4T3cwV0ZlTGZuVTV2RXNyTE5uL3RFdFdWazRmd21L?=
 =?utf-8?B?VElrUmdlNTZWblUxY2RXREtrUHZQTnhlVUYxYnduL0RIRm1Wa2FHSmhheHFq?=
 =?utf-8?B?d04vcFFSdlg4a2ZCQXMvMmVOZFI4SHl6Y0pFNHRvaXZSTHR5M0NiKzhzU2RG?=
 =?utf-8?B?dndGbTk4OU5YeHZleTJvR2xndjRqZXUzZ1ZtRVNpM1Z0M1ZUVEYzRHE5V0xa?=
 =?utf-8?B?eHE0T2Y5SzZYU0h1RjZlMGFXb3B2L3FBSjBkMXJrbTZVZUxjWnVJY3phZWp1?=
 =?utf-8?B?QlFiQXZOWVlRWXVkaW12dmhtRzdJK1M1TE5tbEdvRmxjNHphUlFsT3RCNFpw?=
 =?utf-8?B?aitvc3NtR2R0V0VIRnV3SGVnZWhQcjg3R01ZQTFqVk4yUDdaRlZpK3F5Ry93?=
 =?utf-8?B?N2VUVlkrWnZseWRwTUZMZHFzcDgwZ0EvM0ExRlowVjErRlBoWGdORUZGWXlG?=
 =?utf-8?B?UmdQcUxJOFJXZVcxYVJzYTlyMktGSXZ0N1FLQUU2ZFluTEZJWFdUaTVTNHY4?=
 =?utf-8?B?M1hUMTVXemVSenkxTWx5OGRIc0lPeHkxTk12cm5ZaHVwa2NxNTBHSldLekZH?=
 =?utf-8?B?QmUrd3h6aTVWeTlSc0dJSExZUjZqb0RYNTVhaXhsNE1tZ0RVSHRIc1ZiTktW?=
 =?utf-8?B?dzJHd2xpanBWK09YcGdTYUNSVnU2RGdrRG9CVm5BNVAyRldnWU5mbU8zYmd3?=
 =?utf-8?B?Q3RnMW5NT2NvK3lvaGJpZXdONEhpRkFPTHR2NDY3NmM0ZENZQ0NrcjNXNGpC?=
 =?utf-8?B?Nzl4QUhnVElLSGRiWUErNldlTmtvTVFqSlVFTTB6UmZOdjRQOUo0YWt3RVF0?=
 =?utf-8?B?ZDArT29iNXhlbkxRSTFJU1REV3h2UENRR3l4endqUEtxRW52SERDTHFQU1JQ?=
 =?utf-8?B?TzdyZDRESi9EMjFqeXpydHFUTGJrb1FkckRIQ0JSOEdMb1VEYVQ1dlJOM1dC?=
 =?utf-8?B?cjkvK1NaN3QyU2V5RXh5clYveVpEUHBmWGd1T2wwditwZ1lpaXRqeHFNTGVL?=
 =?utf-8?B?TENRbE9jd0FVcE5SMHEyZUdBazh5RlN1N0hzUThEME9DZ0VsM1RrR2NCVDBo?=
 =?utf-8?B?RkYrN0k4TTdoT1V3T1dYMHNnNzRzcW1MakFxR3NNeVBsaS9yZlhROGh5bDFZ?=
 =?utf-8?B?UEY0MGdpMVBuU05SVUEwY1VCVW9CUUZOT0lrZ0IyMGMvYytRamd1d1VmZzIx?=
 =?utf-8?B?dk55VUNOKzhjVVlCYllmRG9adGFydFc1UnFqSU1UWEN2WExrTWZid0dLMVBU?=
 =?utf-8?B?bkU1Z0VPeVlndjMvTkRjeThOTW9HazduN0ZXUjFHM0xxdzNCQnFQeTA2N0h1?=
 =?utf-8?B?VTlCVDV5Y3kwTXZ3YkZZd1hjb2VOSTVhMGk3bTBKRlhGSEFPZjFUMWNMVFRU?=
 =?utf-8?B?VjVYYkZkZDROTldpUjFUQU9Qbm9RQUVkeFUzaytPeDVhZ0RJbVNNRlhhZm90?=
 =?utf-8?B?eHRDdXlzVzVpM29YSXlKN0tHZFRvc0s5c2dRRXBmZW5pZUhJVFMxTUZmYTdm?=
 =?utf-8?Q?xYEc=3D?=
X-Microsoft-Antispam-Message-Info: f+tWiFucOZiEbdo0mwT1V+ajKGZUaQ8UpHu04rxflzwrKXk8e0JAByCtcqGIfbzC5QI8XTkokApk2AEOaVF6FJQ6sEKC6zbXOcOUWpeRBEDCuOVGLmuSVwZIGVGjnmgShgRP7XqrWNPaqz3RlsEYbkEhlZI9RMCfQWEluhmrARI+n2GryGjHGf0PMEjvW5FBHxAQ5mOARI0p4BLT2hHkEYybpWu3hOUT0ZxZllX+zMtOzNzPfNfPAUCigBWGz+v4pjUytEnBs6exLxCy/iRIyWQSUra94YIa4AFpsjb16mbN00f/mUzA+91TSIYf2+NSdqaf5EYEqgU2/zmN5cUS6QNcY0Hj+ze1wp9ShEXqTTA=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4923;6:Ud4TajgjIsIcifTwp2TNNeyZid5qa0J90q+wxiLHXJR7bBVeEnAoVRVnV8eoyN2W8xiu1oGpyyff7S5sDDlJCOPb2QPbpnI8RdL7VxVy9ptQgYYlbOCALoDF11LvGhJqkA5tcKSv1etvcTeuQaDGbOAvRXd2RksJKlYt1ZKEHK8c4Hnie5jzDGPCJbAF3dpPu1n2j/NvXQpW+yVmJq90QQNN98fJpDVEqHLgChpAgg8EDSxhb+qiAtupXbbdE0PLPpz45vf20J2jW8AAS7gphXIaAinjw6janugxNtX2xox5vXiRETGUzhSyolj0bSkoRPtQ5vJubwZJ23KnnLJnqoI39OUBpBhOGyj7Ot4Uvg19Iyl8z8dFCVnU+g+CF5jhqKRnGPg8U9HlxWl44zP4OkQsg34pCIH6CcJKELJt4/g6MfDhNcnHgSgvAGvcI+nAmOuw8Fiwb4FoXzEH2fRH9Q==;5:oUMnrC/8tXWfUML213VDBcOEv/G+nJiD16vwSxGxmRwTroa4atE5N3gukM505oiyfvSYSDM96f7od9GAULN5ELziY888RzG80uCTuiBhdZNDxuMcheusuYg8qhWh2M/UzEp2bTryX6jVKmUDT58by0lh1SXRbf1sMZ5gyv+ZZx8=;7:RnIl3VFZJ5JYMj9dT/CCkpsdRQICOvjNj5WvvXsslEDhJRdsUhjfp6achVlaRj6fyNAkm3/kHGrZ3vUZkxLJCQOteCBt8EJxpPBNprSFSGOorKtc+lVKN1XlTtRsDjDVWSdEv7mm50tMHfqVpSSJS54f52uCIvnuVqqr3YmNHHMeqK/VqJvVi6oPZxEpi6zOHXaT/B7e+jAp+DCx8KQeCHi2Wn2rdZY700J/p5vz3ckI38E/UhFI0IQewWAHUSGQ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2018 06:07:22.2362 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ce30fe53-bb75-4500-0a89-08d60be35bac
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4923
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Corey,

On 08/24/2018 06:37 PM, Corey Minyard wrote:
> 
> On 08/24/2018 06:10 AM, George Cherian wrote:
>> In ssif_probe error path the i2c client is left hanging, so that
>> ssif_platform_remove will remove the client. But it is quite
>> possible that ssif would never call an i2c_new_device.
>> This condition would lead to kernel crash as below.
>> To fix this leave only the client ssif registered hanging in error
>> path. All other non-registered clients are set to NULL.
> 
> I'm having a hard time seeing how this could happen.
> 
> The i2c_new_device() call is only done in the case of dmi_ipmi_probe
> (called from
> ssif_platform_probe) or a hard-coded entry.  How does
> ssif_platform_remove get
> called on a device that was not registered with ssif_platform_probe?
> 

Initially I also had the same doubt but then,
ssif_adapter_hanlder is called for each i2c_dev only after initialized
is true. So we end up not calling i2c_new_device for devices probed
during the module_init time.

ssif_platform_remove() get called during removal of ipmi_ssif.
In case during ssif_probe() if there is a failure before
ipmi_smi_register then we leave the addr_info->client hanging.

In case of normal functioning without error, we set addr_info->client
to NULL after ipmi_unregiter_smi in ssif_remove.

> Small style comment inline...
I will make the changess and sent out a v2!!

Thanks,
-George
> 
>>   CPU: 107 PID: 30266 Comm: rmmod Not tainted 4.18.0+ #80
>>   Hardware name: Cavium Inc. Saber/Saber, BIOS Cavium reference 
>> firmware version 7.0 08/04/2018
>>   pstate: 60400009 (nZCv daif +PAN -UAO)
>>   pc : kernfs_find_ns+0x28/0x120
>>   lr : kernfs_find_and_get_ns+0x40/0x60
>>   sp : ffff00002310fb50
>>   x29: ffff00002310fb50 x28: ffff800a8240f800
>>   x27: 0000000000000000 x26: 0000000000000000
>>   x25: 0000000056000000 x24: ffff000009073000
>>   x23: ffff000008998b38 x22: 0000000000000000
>>   x21: ffff800ed86de820 x20: 0000000000000000
>>   x19: ffff00000913a1d8 x18: 0000000000000000
>>   x17: 0000000000000000 x16: 0000000000000000
>>   x15: 0000000000000000 x14: 5300737265766972
>>   x13: 643d4d4554535953 x12: 0000000000000030
>>   x11: 0000000000000030 x10: 0101010101010101
>>   x9 : ffff800ea06cc3f9 x8 : 0000000000000000
>>   x7 : 0000000000000141 x6 : ffff000009073000
>>   x5 : ffff800adb706b00 x4 : 0000000000000000
>>   x3 : 00000000ffffffff x2 : 0000000000000000
>>   x1 : ffff000008998b38 x0 : ffff000008356760
>>   Process rmmod (pid: 30266, stack limit = 0x00000000e218418d)
>>   Call trace:
>>    kernfs_find_ns+0x28/0x120
>>    kernfs_find_and_get_ns+0x40/0x60
>>    sysfs_unmerge_group+0x2c/0x6c
>>    dpm_sysfs_remove+0x34/0x70
>>    device_del+0x58/0x30c
>>    device_unregister+0x30/0x7c
>>    i2c_unregister_device+0x84/0x90 [i2c_core]
>>    ssif_platform_remove+0x38/0x98 [ipmi_ssif]
>>    platform_drv_remove+0x2c/0x6c
>>    device_release_driver_internal+0x168/0x1f8
>>    driver_detach+0x50/0xbc
>>    bus_remove_driver+0x74/0xe8
>>    driver_unregister+0x34/0x5c
>>    platform_driver_unregister+0x20/0x2c
>>    cleanup_ipmi_ssif+0x50/0xd82c [ipmi_ssif]
>>    __arm64_sys_delete_module+0x1b4/0x220
>>    el0_svc_handler+0x104/0x160
>>    el0_svc+0x8/0xc
>>   Code: aa1e03e0 aa0203f6 aa0103f7 d503201f (7940e280)
>>   ---[ end trace 09f0e34cce8e2d8c ]---
>>   Kernel panic - not syncing: Fatal exception
>>   SMP: stopping secondary CPUs
>>   Kernel Offset: disabled
>>   CPU features: 0x23800c38
>>
>> Signed-off-by: George Cherian <george.cherian@cavium.com>
>> ---
>>   drivers/char/ipmi/ipmi_ssif.c | 8 +++++++-
>>   1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/char/ipmi/ipmi_ssif.c 
>> b/drivers/char/ipmi/ipmi_ssif.c
>> index 18e4650..ccdf6b1 100644
>> --- a/drivers/char/ipmi/ipmi_ssif.c
>> +++ b/drivers/char/ipmi/ipmi_ssif.c
>> @@ -181,6 +181,7 @@ struct ssif_addr_info {
>>       struct device *dev;
>>       struct i2c_client *client;
>>
>> +     bool client_registered;
>>       struct mutex clients_mutex;
>>       struct list_head clients;
>>
>> @@ -1658,6 +1659,8 @@ static int ssif_probe(struct i2c_client *client, 
>> const struct i2c_device_id *id)
>>                * the client like it should.
>>                */
>>               dev_err(&client->dev, "Unable to start IPMI SSIF: %d\n", 
>> rv);
>> +             if (!addr_info->client_registered)
>> +                     addr_info->client = NULL;
>>               kfree(ssif_info);
>>       }
>>       kfree(resp);
>> @@ -1672,11 +1675,14 @@ static int ssif_probe(struct i2c_client 
>> *client, const struct i2c_device_id *id)
>>   static int ssif_adapter_handler(struct device *adev, void *opaque)
>>   {
>>       struct ssif_addr_info *addr_info = opaque;
>> +     struct i2c_client *client;
>>
>>       if (adev->type != &i2c_adapter_type)
>>               return 0;
>>
>> -     i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
>> +     client = i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo);
>> +     if (client)
>> +             addr_info->client_registered = true;
>>
> 
> How about..
>     if (i2c_new_device(to_i2c_adapter(adev), &addr_info->binfo))
>         addr_info->client_registered = true;
> 
> No need for the client variable.
> 
> -corey
> 
>>       if (!addr_info->adapter_name)
>>               return 1; /* Only try the first I2C adapter by default. */
> 
> 
