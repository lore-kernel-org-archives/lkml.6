Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AFFC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:06:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A77542086E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 11:06:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="YsrJfBG4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A77542086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbeJRTGo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 15:06:44 -0400
Received: from mail-eopbgr710045.outbound.protection.outlook.com ([40.107.71.45]:56224
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726173AbeJRTGn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 15:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2wDdGCAkDVcKR2nrZ/3viqZis3SurgnkSy1ZBpWKlbg=;
 b=YsrJfBG4fwtGb0GLpuxoYVYSUek/Sp0Uqwv7sNEk9MJOGTmIBKXNmVGYSgbRLFsRoiEHXwPXbSgDdQ44noIsHlGk2fRAPlWP+jW6/aRryBSvrrQaewQmI7FVr93cj71XXyYCoAN+Sk/OmB0r8p0KbbozGLtOPA2hSzjfJzEes3g=
Received: from BN6PR03CA0053.namprd03.prod.outlook.com (2603:10b6:404:4c::15)
 by BL2PR03MB545.namprd03.prod.outlook.com (2a01:111:e400:c23::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1228.25; Thu, 18 Oct
 2018 11:06:05 +0000
Received: from BL2FFO11FD008.protection.gbl (2a01:111:f400:7c09::114) by
 BN6PR03CA0053.outlook.office365.com (2603:10b6:404:4c::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1228.24 via Frontend Transport; Thu, 18 Oct 2018 11:06:05 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.57)
 smtp.mailfrom=analog.com; gmx.de; dkim=none (message not signed)
 header.d=none;gmx.de; dmarc=bestguesspass action=none header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.57 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.57; helo=nwd2mta4.analog.com;
Received: from nwd2mta4.analog.com (137.71.25.57) by
 BL2FFO11FD008.mail.protection.outlook.com (10.173.161.4) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1250.12
 via Frontend Transport; Thu, 18 Oct 2018 11:06:05 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta4.analog.com (8.13.8/8.13.8) with ESMTP id w9IB64du028668
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 18 Oct 2018 04:06:04 -0700
Received: from linux.analog.com (10.50.1.118) by NWD2HUBCAS7.ad.analog.com
 (10.64.69.107) with Microsoft SMTP Server id 14.3.301.0; Thu, 18 Oct 2018
 07:06:04 -0400
From:   Stefan Popa <stefan.popa@analog.com>
To:     <jic23@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>
CC:     <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <Michael.Hennerich@analog.com>, <gregkh@linuxfoundation.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stefan.popa@analog.com>
Subject: [PATCH 2/2] dt-bindings: iio: adc: Add docs for ad7124
Date:   Thu, 18 Oct 2018 14:05:39 +0300
Message-ID: <1539860739-3416-1-git-send-email-stefan.popa@analog.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRoutedOnPrem: True
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.57;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(346002)(376002)(39860400002)(2980300002)(438002)(199004)(189003)(5660300001)(23676004)(110136005)(106002)(54906003)(2870700001)(7696005)(126002)(356004)(476003)(336012)(26005)(47776003)(426003)(77096007)(2616005)(186003)(478600001)(6666004)(966005)(305945005)(7636002)(246002)(4326008)(44832011)(486006)(107886003)(36756003)(2906002)(50226002)(7416002)(5820100001)(316002)(72206003)(8936002)(8676002)(50466002)(106466001)(53416004)(1720100001)(6306002);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR03MB545;H:nwd2mta4.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail11.analog.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2FFO11FD008;1:j57ptdkGid8OH7jivEHyi+dP2qZ+9gIT/J02CFWE3x/s1ssAbOwTVpumpzJnjZnL2YgTL4FCHGNzhg6z9PTTWgBrwsHLYnFeJCqM268cUGqDK9QofddLW+UES7k+Mf1j
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 94aae2ce-ff35-433a-4eb9-08d634e9b2e4
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(711020)(4608076)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060);SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;3:legwIiWFlCEKnswPYMZVb4UI+tAunJNoSGVkCU88ZRGyWFNiGexJQ+/6ld/lasmijWxLdkVYQ1TavjY3Jpf/SgJfGSx2lwWglsjJt0EgfCXwAUYHlYMQdbltVnhQYU/2lwKuUbOW+iyuNtIPsuyFhg14a04GkM7lF1ohvaM/RnBFvD7vBgHKZloiSYKk774TfdmgO8xHPleCIIgeNRtq8zO+QUtV+6/8hNwBDR4fNCWaKiHYnGhdbbLD+sfzHWhRbAX4Tfd4nK3jFpawEifMAqyTfFQtyC78l0CKjJ3abK57R6UVjebr417TnJIviAHlT/e+4jeruO/0tTryNov/i+d74pRKjcFDUbxvZztgXL8=;25:9YRSKauc6kuenGg2NLBcHCtlEE3AyjehkmQ1Hpf1HX7Iryiv7HcVpyXGXSV9yFGAf62btdjoawVyjIwkuT+plBienJ8V/ToVY3qcO02tV0Nfl+t021nU842FA6ZwbzF7JjaRfq1BQk9we73E4IaE13NWTm//Bphv/f1LvISK0DxqtX6kceBMCNJza7YF/Qi97xIeAVivR3WPyhdNxMDuWJ7D3XV/a5vQOvrrpo+k1dxfUyoxUKfOTt12tr8rUW8UAm9geJ6V5hJPIY6UGNmm93wKEWLD1AGLs64xwHzFCInklZ2Uz8TI7ajxxN3ATipi361OcvA069wD8zl9IFSFU8IfX/ynloLIHK0Iv6PYvnI=
X-MS-TrafficTypeDiagnostic: BL2PR03MB545:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;31:irKjvv5/Ttjq+v5h+Kc4BxC55IWA4G324SdCtBAA6VE+8CnwXJOnbeOfIdLXz3MHtl8aPF0LkGcxoG9mwPyUeiJfhfxqaQzAyc806gRy0Xo5Jb26NB21S4Qq87juumZrRvHMnREIilq8gCxrjyicCATOmu938N+Qq9yySzaxx1Y91JUkMA7IHJifVUq2YJj8p8sqvXGFfFXP1RbZ4QIhIovOjLZEdlRsTACiZ4dq/xo=;20:qfDrvZBP0gfKhvpycYmg1PioXmiDtfq/+OFbEH0fv6UocsUsALRBGd+1V7HXk1V+h1wKmFVcEZn3Ft67ridocy8U3PsHRQPYiTnNsvnumfAAv9mIYRfdHrrpihSAEaWtQVrRqOuyOhyJzx7QA5p9TjieFNBO0+ZqeOFih/PfV8Gvo+guVSamj/oULxsAcl++0MW7UKG9/SAOfALuxawGn/xHvdcICa+BNBF2WB4Ix9MfQqcvlzNsz6AIRcX3om06GtrZxvzwicklJn+foHCW2FX/fH91L9XjrCY8IEM+riQfOBBdg7namJSrGiac2SjbNA9UKIR2/ZrFQiZ+ku5mdQ7cefIZOeOMptX8YlvCxlsTmeCe0debTFiTzyOxKuWwjdaREDAu0pIt1/5y+luo5bBaYSGPUlzCXIdLGsaXLcAHnzv2WIaUQuillTx184ZNBvPjumHWiB5FFzrxXLVtd5vMaMn1Xuze6ERmw+u2jmyblVzjGWX920lrXu+3n07L
X-Microsoft-Antispam-PRVS: <BL2PR03MB54585FBEDDC526F078C4B4E9DF80@BL2PR03MB545.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(232431446821674)(9452136761055)(170811661138872)(95692535739014);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231355)(944501410)(4982022)(52105095)(3002001)(10201501046)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:BL2PR03MB545;BCL:0;PCL:0;RULEID:;SRVR:BL2PR03MB545;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;4:qgnaSejq4eLOQvWLX7n+TFErhlBspkvKki4i8/PR02uYRrcqvEpYO+HbNXrjkyzm6hXs32GKQ3q3lwrOkEF70ujfl6H94yBfqBL3nVGT9xcWbrZzQQrrR4D2tWnjMZuM0wPA6zLdTo5VjS0neQwvelzi18QtfYVNZ0DL4iI4edNyKHEc/DBkGgQxN0orJf3YsuI19mGsDNrQV58eCD4NQ7DM4vh13tGRRaS2LsmiTINNauBikKi6kOGBAaKhIV0lR2tTM8J9CFhHlu6VVYv4VXYc2yfF+2cj6Oe1QOJKk+PD6koTvxzrWGqwm9twmlkBvgLqI9WDoMAwzLZmC1FihrbKAekVxJJK1xVhbeAxC6B4QPXAzqQ5rB9Gx5riMKmaYc8kq6E7X7Du95NFj8dfN1RActyyfTGY/9AD5izErsk=
X-Forefront-PRVS: 08296C9B35
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTDJQUjAzTUI1NDU7MjM6ajdXU0VaQ0d4WVkvMjFQKzhHUXdhZTJvbkZN?=
 =?utf-8?B?eG0wdTBTcW5NSVdNd3kxU0E0bzB1MFFOZ2EveXF3M2VNL3BKMHk5WmJmZXdO?=
 =?utf-8?B?K2dYUFhnRHM1SjdibVF4N1FUNW9LNXZiZWozNW55WERqYU5UMnFseUtCV0pn?=
 =?utf-8?B?N2hwTGUvK0NRaytRb29vZS9hRFNmTWVIV3ltT3JrY2Y2b1c3VnplaTdzSWFX?=
 =?utf-8?B?Z0Yyb09icm1PT3B6dldnekNwWmVZZVF0ai9EWllqUXBXb1ZpanRDRUpaZHpT?=
 =?utf-8?B?QW5BbWVMYnA5UXBrR1VOS1lSUWtOaHJPMHM4SjZiNElzQWZOZWhpT0hQRC9q?=
 =?utf-8?B?S3Mwd3Fidllka1l2MWdqN3B1MVBScUh5ck9WZmdlNWNDcW9OZ0dnV1FmTVZ4?=
 =?utf-8?B?djMvQVRPM3VzdXFZU0hOUnhEbTFzY1M5Y1hucitKN0pwbTFRREcvOGRYa3py?=
 =?utf-8?B?R1MzOTNTVkhQd2g2UzFnc2t6QUUzblJOS3RJcWJubmVhSGRGMDJiNHV1S0FN?=
 =?utf-8?B?ZEg4ZWY5eVlMSit6ZHpGR3QvVlkzMldYbUpGek5MWjlSTUZHd3pOS2ZFT3BN?=
 =?utf-8?B?T0RZUE9JUGhQTnZNUVhOeEZUeVAyQkxTVWFJbnhhaXg0RDZESy9iZnRuWUpH?=
 =?utf-8?B?RHJFMVgrSEdYZnd5R25SVkhXL0lpWkFxdE5WZlVtb2U3NTlkamhUZGVXV1ZC?=
 =?utf-8?B?UjAyRXJYYmhmK2pxMXNLdzlIT2RDODI3OTBHUFJXQmp4YlpHZkF2eHlFMmwv?=
 =?utf-8?B?OURod2dIZnEwV21hZisycVZZNW5pZnZ6SmVZUkxRL25sYllMbVpMWFNaaFJL?=
 =?utf-8?B?Y1BuSUNjOTU0YzZCRGxFbE9YZEtqZmREUHJLZkZZUlEwZmZPRXVwMzBUNGo2?=
 =?utf-8?B?ZXpyVDZhd0JWbFJGRnROdDZpamhvTFhjSkp2Y1FZMVRES2Zyemg2Mlk0WXRO?=
 =?utf-8?B?VFErb1pRdjZmRXNONVJiVXdnUG5FR1ZNWDAyTnNBOW95NWYremJuaWtaVHY1?=
 =?utf-8?B?aGFhYWoyT1pJSU5wUllUWUZma21oczdQQy9nZ0UveHkzeU00cWlYOEh6M25p?=
 =?utf-8?B?M1F1OHZVVFlYejRFN1dsTHhKeXp4YjhTSUxVa0FnWEYvM1gzYXpBRVpJbk5i?=
 =?utf-8?B?NS9OYnBpZE0xYkFzMlViM0NxVkFMTXlPWWVyUHlIaE9Eajhid0RyaEFaU2pC?=
 =?utf-8?B?RjVmZWhQR21FZnlZL1NKZWZtd0NxTXUrOWt3enBrR2VNUExmL01HaEpYMVFK?=
 =?utf-8?B?eEI5bHNTeUMzd0xIZDlYTmRnZ1BXd0VkNi9GMFU5QXVHcWVPckpMU0tEYUxv?=
 =?utf-8?B?MXRXdWszL0Q5eFNSOGJBZkJwZkU4c240WVVjV20vZXd4NklxaWk0cjJwZ0dV?=
 =?utf-8?B?cmRMZG9CaUh4bEZ1SFJzNG5oZ3plRVZSRE5qRWZad2JiVjd1bXFpR096RVVT?=
 =?utf-8?B?YnZrUU1KdU1WbUlVZ3FXQTc1NTdSM3BNTDUxWjJZNHNqbk5wQU1kVjRkMUxS?=
 =?utf-8?Q?dKvNQIy51a8sxtno8Mu2nQzA=3D?=
X-Microsoft-Antispam-Message-Info: e1Pa3eejABoTnugVOtp++2QDiTRx4a98jPXuqtCKa5qvY40Oljhh5HTwtbvS3fZ1Mt5hfiQCLXvykOwtF2fafa6fmpcw9Ry2MJuoiRmYd1XAQSABFZ3d6UJs/3I9zAduEwInCAlI5HjZU7uaHnwKWA9lEr919J4rPdzq8PnaedUoMIyWcsWoyTMbedchxn/iofbpRwjoSCITZ/wPYlhXfymqz+okua2h+Vx1K/lUy78sj2JsgUs3o4Uiuy2FcA7i1x2kT/EKuOY7p9eP6FIOCX+4Frr5GSDmv8bzugMbtxUvfyKOIOuuoH4XWok1RuY9VgY2sRErnzCxRrlF4AsexY/KUuYbqYVLOI1cuJFR/Ew=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR03MB545;6:VuTvIP7PrU5AXkkhm9M9GJBzic9soa7VlibUPY9i96+ZPOrhpzW/IlFHN9dEjbALLybfqWDYZpv6MGPF9AR7yGJSecvTlU6RcB3E+63hXhxv2Y+/ddj0ixjVUPZRiyfnqUyKVln8YLHZyhkfDTirJ6jfsTlPBVfzzb4S8U0R9Bpwoo7l2ke46Cn9JR4R3aL0DFO2f9RdVhobdTZlKtgq8myTU7b5xGU440fTXA6eCWY5lpteckCrDtsgKf1GDVgWfBtD5PSdqUHpko3jrND9V6QN3iDtrIw2wXjNBt/JGdIJ0a8mhqMdtLgis9VlKwgUuUr6vcNV+/7gN2u7dQrqojcOv7b3gvwCdunZ6uyLydtfOb3jW8ukU6N5zq0TWs3fgjNIc2qkvhZTWJVEVeRvToRxx/ctuYMXpN8APPyqFcza18zl4c08ADqyfVGoRTy+XbpeJECPfCZbrk4I0GcoB0yWquIPXIa789cjKfQJ6lM=;5:QhlBHpHBGG7efo3rLZLAc6Zg2I4iZ/bYcGb6sAa484eDZ6TwshZR/WkGTMSjXVgNaCS28j6ve2cKCmO52dsqB7lMfMVV+PmrWzj1uW2UujOsNiURcgFyzlKuBvVSU2Z7zuhqJMt4Y3REgAYkgI25BZKBScSbRNbAvwblCGB01Os=;7:/6mkOERnm6eHsjtxZOf9tAwfhFatZzikD7uKdKYk6G3itsJNr7geDh6xTvuRaMIAw6pyy5tEdQf9hZSnUXtiP00rexKRzpdOC+52qO9DFBdNzUI8TidJUDilQbxrpdoydLJr325izM5hcZcoBA0rXkFIBAUjfNCxSQ2xHuiKttnl7VAf3GVYjPzzDgZYPvXSWIssH5UYC1ASXhuCvNf85ZBl9r1fVwPj1KypxDZvghisyMMOW8SO2r4Lj5cpqR7R
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2018 11:06:05.1741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aae2ce-ff35-433a-4eb9-08d634e9b2e4
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.57];Helo=[nwd2mta4.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR03MB545
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for Analog Devices AD7124 4-channels and 8-channels ADC.

Signed-off-by: Stefan Popa <stefan.popa@analog.com>
---
 .../devicetree/bindings/iio/adc/adi,ad7124.txt     | 96 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
new file mode 100644
index 0000000..77a7b92
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
@@ -0,0 +1,96 @@
+Analog Devices AD7124 ADC device driver
+
+Required properties for the AD7124:
+	- compatible: Must be one of "adi,ad7124-4" or "adi,ad7124-8"
+	- reg: SPI chip select number for the device
+	- spi-max-frequency: Max SPI frequency to use
+		see: Documentation/devicetree/bindings/spi/spi-bus.txt
+	- clocks: phandle to the master clock (mclk)
+		see: Documentation/devicetree/bindings/clock/clock-bindings.txt
+	- clock-names: Must be "mclk".
+	- interrupts: IRQ line for the ADC
+		see: Documentation/devicetree/bindings/interrupt-controller/interrupts.txt
+
+	- adi,channels: List of external channels connected to the ADC:
+	  Required properties:
+		* #address-cells: Must be 2.
+		* #size-cells: Must be 0.
+
+	  The child nodes of this node represent the external channels which are
+	  connected to the ADC.
+
+	  Each child node represents one channel and has the following
+	  properties:
+		Required properties:
+			* reg: Pins the channel is connected to. The first value specifies
+			  the positive input pin, the second value the negative input pin.
+			* adi,channel-number: It can have up to 4 channels on ad7124-4 and
+			  8 channels on ad7124-8, numbered from 0 to 15.
+
+		Optional properties:
+			* adi,bipolar: If set the channel is used in bipolar mode.
+			* adi,reference-select: Select the reference source to use when
+			  converting on the the specific channel. Valid values are:
+			  0: REFIN1(+)/REFIN1(−).
+			  1: REFIN2(+)/REFIN2(−).
+			  3: AVDD
+			  If this field is left empty, internal reference is selected.
+			* adi,gain: Select the gain when converting on the specific channel.
+			  Valid values are: 1, 2, 4, 8, 16, 32, 64, 128.
+			  If this field is left empty, gain of 1 is selected.
+			* adi,odr-hz: The output data rate can be programmed from:
+			  9 to 19200 for full power mode (when the master clock is 614.4 kHz)
+			  2 to 4800 for mid power mode (when the master clock is 153.6 kHz)
+			  1 to 2400 for low power mode (when the master clock is 76.8 kHz)
+			  If this field is left empty, odr of 9 is selected.
+
+Optional properties:
+	- refin1-supply: refin1 supply can be used as reference for conversion.
+	- refin2-supply: refin2 supply can be used as reference for conversion.
+	- avdd-supply: avdd supply can be used as reference for conversion.
+
+Example:
+	adc@0 {
+		compatible = "adi,ad7124-4";
+		reg = <0>;
+		spi-max-frequency = <5000000>;
+		interrupts = <25 2>;
+		interrupt-parent = <&gpio>;
+		refin1-supply = <&adc_vref>;
+		clocks = <&ad7124_mclk>;
+		clock-names = "mclk";
+
+		adi,channels {
+			#address-cells = <2>;
+			#size-cells = <0>;
+
+			channel@0 {
+				reg = <0 1>;
+				adi,channel-number = <0>;
+				adi,reference-select = <0>;
+				adi,gain = <2>;
+				adi,odr-hz = <10>;
+			};
+
+			channel@1 {
+				reg = <2 3>;
+				adi,bipolar;
+				adi,channel-number = <1>;
+				adi,reference-select = <0>;
+				adi,gain = <4>;
+				adi,odr-hz = <50>;
+			};
+
+			channel@2 {
+				reg = <4 5>;
+				adi,channel-number = <2>;
+				adi,gain = <128>;
+				adi,odr-hz = <19200>;
+			};
+
+			channel@3 {
+				reg = <6 7>;
+				adi,channel-number = <3>;
+			};
+		};
+	};
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a1bfcb..f2fa508 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -845,6 +845,7 @@ L:	linux-iio@vger.kernel.org
 W:	http://ez.analog.com/community/linux-device-drivers
 S:	Supported
 F:	drivers/iio/adc/ad7124.c
+F:	Documentation/devicetree/bindings/iio/adc/adi,ad7124.txt
 
 ANALOG DEVICES INC AD9389B DRIVER
 M:	Hans Verkuil <hans.verkuil@cisco.com>
-- 
2.7.4

