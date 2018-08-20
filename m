Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC3CBC4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:14:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F2AD208D4
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 11:14:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=analog.onmicrosoft.com header.i=@analog.onmicrosoft.com header.b="IlYBhgtW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F2AD208D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=analog.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeHTOaB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 10:30:01 -0400
Received: from mail-co1nam03on0068.outbound.protection.outlook.com ([104.47.40.68]:61792
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725948AbeHTOaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 10:30:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector1-analog-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFsIlcQl9h02uRFjWbKw5o70DpokjMfw4c+go5ucvzg=;
 b=IlYBhgtWmI7LVZ5aMvqSoJqeYKi8ejWA1Yp7K8N3PipBGamcumUgQBZOwIGZ2Gw/sNEHt/MuwV6sog6dGJdvwvJdHl3BxwkttzrhjU8ZMMNY9vXvc/r3DcX4KlE2NmJ6WVlE4xmPJbKrwase9GgIpQR8+NQoKC9yZWTx/NJeyD8=
Received: from BN6PR03CA0082.namprd03.prod.outlook.com (2603:10b6:405:6f::20)
 by BLUPR03MB552.namprd03.prod.outlook.com (2a01:111:e400:883::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20; Mon, 20 Aug
 2018 11:14:46 +0000
Received: from BY2FFO11FD018.protection.gbl (2a01:111:f400:7c0c::191) by
 BN6PR03CA0082.outlook.office365.com (2603:10b6:405:6f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1059.19 via Frontend Transport; Mon, 20 Aug 2018 11:14:46 +0000
Authentication-Results: spf=pass (sender IP is 137.71.25.55)
 smtp.mailfrom=analog.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=analog.com;
Received-SPF: Pass (protection.outlook.com: domain of analog.com designates
 137.71.25.55 as permitted sender) receiver=protection.outlook.com;
 client-ip=137.71.25.55; helo=nwd2mta1.analog.com;
Received: from nwd2mta1.analog.com (137.71.25.55) by
 BY2FFO11FD018.mail.protection.outlook.com (10.1.14.106) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1059.14
 via Frontend Transport; Mon, 20 Aug 2018 11:14:45 +0000
Received: from NWD2HUBCAS7.ad.analog.com (nwd2hubcas7.ad.analog.com [10.64.69.107])
        by nwd2mta1.analog.com (8.13.8/8.13.8) with ESMTP id w7KBEjTO011492
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 20 Aug 2018 04:14:45 -0700
Received: from NWD2MBX7.ad.analog.com ([fe80::190e:f9c1:9a22:9663]) by
 NWD2HUBCAS7.ad.analog.com ([fe80::595b:ced1:cc03:539d%12]) with mapi id
 14.03.0301.000; Mon, 20 Aug 2018 07:14:45 -0400
From:   "Caprioru, Mircea" <Mircea.Caprioru@analog.com>
To:     Peter Rosin <peda@axentia.se>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] mux: adgs1408: use the correct SPDX license identifier
Thread-Topic: [PATCH] mux: adgs1408: use the correct SPDX license identifier
Thread-Index: AQHUOHH9YqD8n8fT5UGByPoy0/1tYKTIeqyA
Date:   Mon, 20 Aug 2018 11:14:27 +0000
Message-ID: <209EE0F380CD554C95B3E2532952872D29ABC21F@NWD2MBX7.ad.analog.com>
References: <209EE0F380CD554C95B3E2532952872D29ABC204@NWD2MBX7.ad.analog.com>
 <20180820103827.24639-1-peda@axentia.se>
In-Reply-To: <20180820103827.24639-1-peda@axentia.se>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.50.1.100]
x-adiroutedonprem: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:137.71.25.55;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(396003)(376002)(346002)(136003)(2980300002)(438002)(189003)(199004)(13464003)(246002)(6246003)(6666003)(97756001)(5660300001)(23726003)(6116002)(3846002)(106466001)(7736002)(7636002)(8676002)(50466002)(55846006)(356003)(55016002)(2900100001)(2920100001)(229853002)(305945005)(33656002)(46406003)(106002)(47776003)(5250100002)(2501003)(110136005)(316002)(72206003)(14454004)(486006)(86362001)(478600001)(2906002)(26005)(7696005)(186003)(8936002)(446003)(8746002)(102836004)(53546011)(11346002)(336012)(426003)(126002)(476003)(14444005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:BLUPR03MB552;H:nwd2mta1.analog.com;FPR:;SPF:Pass;LANG:en;PTR:nwd2mail10.analog.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2FFO11FD018;1:8ZUWQkvW/DhyL/7PRBmH2s6VJtbQgjxqLXo26SVuRYKWtM9UvTkMpnwBYmOdR8lWxDnpZdLwXa3QMzZR9o7IHodBje1+9+U5Xe46BlFLlZCAM/jxlSi6MukD59qSyULj
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 970b5800-5da7-4e64-79da-08d6068e22fc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060)(7193020);SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;3:4foD3xtZQY1qPN4R3V498y6CLKHvnby/2y1KjPRYojxzg43gEwPn1cKKZJL99UjUoLsM7lRL2FaXR4pjiuknOWL+9MxYWUaVJluny5u0QQFh96t0n9Vp5soq2z8ve3PfzT/iFyiyBHB1cSGt9q+uZmjYb8N+AeSZ8WWGiQj4+mTlbVdFEXIP/gJH3+kv6qG8O6ASNUiKDriLAj0qmrI5JfTCBOojsthawI8TMgJOQyc0uoaGpRzo8JsvyD5pz8EK8vQnDq7B8szq+Ki1eUmK0S0cuV/Zp6aK61cPm+yYbuRFVpbW3sGtR2awk2xuFGz1AVGkO1Z7j2vXpDgwRMFcBYeDay1uQfOtRP7odcfQFQI=;25:PkvD+L3PxFbbPiTFPMFK+X3iA+VTm01s0tQ3wt+k99e9c3IefGiiHNZSiCUd26nhc9VuiO90QiWi5A1mCrJrRHoNZkpijuvOw4RbJv5z689VoYioyo9mWnREjNOI9yoRhZwlogsSR6fKEBdi53KBC6xTejBTS9ehkyQx9QJt/lkl6uzjQZpikxM2sPJz/00kaIBeCpvURZBiusBvKKp6HUl1njDPJWp9WPeZ9jGRI/UD0vFKsHyn39frU8ve+QecfE133Yv68FVKXmB/PRbK/0mghq9f82AsjN3jj5K+Nbr+7eBgl+TnqYqpG7xXJj7sCV0yi5fWO4C5As9Xes4c8BERFpVSRUo181WCel1EbbU=
X-MS-TrafficTypeDiagnostic: BLUPR03MB552:
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;31:1EHjjBt17mBNstHbkip9OEyVDAv1Ok1Truz+Xx1VVUggM/jbK7K8Cc183IWw82nq/HUK5mi/fmKaQz3Aq/z5j+iBVW2XIZUHgPuHzyUEvUi2ot2iO0buAwpASlByh6NrYsMlsko2McEJVR6ygmV1LfjdyXtvUEkAHnSJVCv4p12BEJ3fIW3rh62qjTpRVNa6X7t+B6AbbWKBh2/fB3EJJMoC5vRrUZyh4l/mfIjYv98=;20:S5R2UIa0mjPNtLoBCAYykiAJ/80A4QwNIejgK6XGH4yiaC+x6t6dtxAv0S5nJwwXaFLqd8K/npYwhuYMDmSSsWxCclSPtzpZtugQr74WdL5sKuLaN+ifTqb0/f/L8tdRiJaj2GZvvjtLrb9x6Pal+Vm1+8+bGOQK0xLum/WA2ni5VyXUJGIfoa+xw4jRn5hgZZ82b4mzKgGRpPWPUCetzd1uPeHIgwe/BEHsKdrY7dExwSJDGjLIYjAoYjr5N+LZXXBEnUC6/Yta4AXk1C6dnSmecHXGMOe+ASkHJ4UdO+D//Yk/y3YB/542XaKC3mknAA+NnPM25nVycryT+K1FURQtIuiKnAdQJuJrBE+AcBW/5vICbFImrrlYq2XxywsWlXElFvyLnET9eICI/vIeDSFh7tke4j0UzH84RiengaCbk9nJyUdfXdijGbvYY/0Bra72t5VfbdsEb1dNIRMZxaefafCbGYRLmPSDvGtuYDcsv+RkLmS8lylXDlnXUVEf
X-Microsoft-Antispam-PRVS: <BLUPR03MB5529F96C1983201B1B208A981320@BLUPR03MB552.namprd03.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(9452136761055)(232431446821674);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699016);SRVR:BLUPR03MB552;BCL:0;PCL:0;RULEID:;SRVR:BLUPR03MB552;
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;4:eusip7NVQpngMso2cJjrzJj6wRmEOcGp6RRlfSMbMBlAdhYaPji3AMFjEJDiVkD4k9k8iDoMTsWzMj3BqrdfzLRJqRNFUwtgGDXO3B/mwIbuj/ZcZocCSdS8GtXrpEPAgltFnp6vFDDiBACMCWijn2vfmj1Va6jxxUWxeRCQgO1UN2/eeL3gjuho+oqfNACOCVNDhldO0l92ijD8+x6kjRBKlnPxbDmbmxM9jkEdP2mwyDmvqY5iAP0ezpUtvnkFJH/ZHr4kZ3k+xMvVlWnqMqxo/WIyxyOVCtyCTrx/GWnkAwK3EiaRk+3MexP7tL2Sc+L9PrCS1L04PA+qW6m5UpHvmBfdJT83NTfqA+0UYqc=
X-Forefront-PRVS: 0770F75EA9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BLUPR03MB552;23:kHTmw6qvbF7nUkdFMg+2JDySazKsyQ4oOAytW8WkWv?=
 =?us-ascii?Q?XGTSHUHB4j5CLg25+Qd59j3k5FUMhif+H6a9gRM9F8zbb0mYJNy1h+mfdSug?=
 =?us-ascii?Q?ZR5okPGpzRq3dgAoCtRIZNjNvv8bYvfewnor5B49rupKFCDZ0JPnUnuUahlU?=
 =?us-ascii?Q?U9aWO0jo0W03G9uCY0rfioPov1+0SdrUGTBhKG+kQ8UYlm1kC4ac7SdoaesS?=
 =?us-ascii?Q?rt81AS/CJIiRODX5ewUnxXY8eV2YwMFpT1GQ0OvE4S8AJQ/KdVmhmpjNIIiU?=
 =?us-ascii?Q?e6SGjn7zr4lRJYaQVQ4EIoTm67vZClqXwJCHDRft1dKJoMBDLyasKZvkHelg?=
 =?us-ascii?Q?WGXEDyPIiMyPSdBKLuaXaGpJya4HrCtRa6TddpTL9BzSSmSy4HkQjVqYibOD?=
 =?us-ascii?Q?6UBqWhIcZ1Z7+8yG3hBFODYgCtXWPnktz1ObSTgHIqMiZ5wY0glzGoijtmqX?=
 =?us-ascii?Q?0A1Z79HSxuClYjhnVERfMdrRidstZQwR5z7toMXysfGtf6T/hczgJJotjbVp?=
 =?us-ascii?Q?logZW7t2C4wSEvo3oUmczso2mHrYc8UuSCB6yyT5sl6ZS8+y/ghTpqJOZqyA?=
 =?us-ascii?Q?u/lSqvfIKVPX0OVXZ0FSFGmzWfKcXTiy4FNiN3gySomv6hB7D7WIX5bHinyX?=
 =?us-ascii?Q?yY3IsfUohNTXjJhthJ6t/wEL26JJap8pa03etf9LneEZXi0gLYs4shkP338f?=
 =?us-ascii?Q?v2Nr+a6UkPhYkjExOaNJQYDCVlgKTmI73G/r2s5efGCuzgWoQZrSYcBQvAO+?=
 =?us-ascii?Q?vPopRWY+xAGE/a+ERLElc8EOGZdxLct3yVCU3Mdm43JgMmi9a1k3hu6kxDhn?=
 =?us-ascii?Q?rZlrrv6HG2JYIHXHyQcWthKNRa+j+eovXltEO3PnCBVfdJhdNcc0dRE6mq0K?=
 =?us-ascii?Q?9GdDX6IPoZHgY8TeMi9hVdk1ashLSumqShF3UItA0usBfpTXpeUgZ1qMVN1J?=
 =?us-ascii?Q?vhGzOMUT/YzJL5h90OynVzjcBJaP7UWmyAw7OH2dWLlr5HED0K520e4oF/QH?=
 =?us-ascii?Q?sFV05+FBA4J0dy0f3qSwgyd36pm5muNcPrTgRGUR2/gzOOReVRsg2rPs2++S?=
 =?us-ascii?Q?xqf5UAVa+pZW1uUBY1salTlRuKnF6nO9fyjnn68oyPubdKXLBWVai7N9yhrZ?=
 =?us-ascii?Q?3p95sJwht45PBHMqB3gL3Ux4S+0Q3gQ5ymRur7i4PDSCw9di5eO5yHeDMktT?=
 =?us-ascii?Q?SMFhj02H8VWKg0x4LAbQPYcJJUKEWdz60GM3PIPKGzfZwoofQmoylBVesiN+?=
 =?us-ascii?Q?W4RoL9SglHFKhiZnY6MTxEWFbSFpOYClztSYnbu02gQhrFHDUuQL2LInhZWg?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: AFXi0gIxNZ+jmANOhoNWZ9kHbs5QovoYUQGh5YfLHUgnAHlLBsfPgzgQKXONvLnZrdz48jKQ7eaBIdRJ2shzhydjdMeW0eXB1GwiLjtC9NG9T4ceYWNaCgBbBT2xcmws5M7Fhh+MPcQh918PlqkJFgHfQBaWvlmCJ79glOFUREYGO+BMPHH8+G68XB/WIFgPPAzYMU9/YGsRwkTRrBtpLWURr6q9il6T5BMo/CmsJXzkivEioWmzW3XhggFOmd7YBNIWyQza57UdwWTxIvsyCIoJbDYwOC4JEfCpF6+pNwmvhGios4/D6ATj77UseAqPnCH7o+8nOgy4Qx9W+smJifhD3NPP6AeHsPznMN5V8cQ=
X-Microsoft-Exchange-Diagnostics: 1;BLUPR03MB552;6:5q/tY03D3iPoIbnvmw83mAKCtrdlO6+CgB/W/DyrQ8gAUPcnUFHb+eNWPTpObka8KfLLzbZ+EaGBsU9PiISiS9xoFrxCYA2jasWnsW5WQjAkCm0xV6WlwYSG53Sh3zL4cJzLcEMDFMm3vpsDwQanpHQvpua0QT0WDEKXP+EQAnblT9h3qcOSn5HW3dj0dHEaasZLnL0IDHcr+pNC6vzmUQ72WcJzN3sKmh9SgL9CycUtsiaboYCJkpjF+DroOOf8uf/N0saW94URSul18PeNGfGaorM5SyHKW3HYErDn9up3fy+J4nmGbDpxjzqTPyNSUkWhYF2fCqi7Kp6/QsJzqsRpEl5R9G0Wbtg7y5PYZZfrkT3y9SCSJ8lg80HT8PJb7iTeayE4pZwb+OeqGv98GGNJsYnTLu2kxdpoO02UQ7kWuKGWYfr4lDTqr4Gu8dmelfPlIug6dcJDgssf4Jzy5w==;5:PROAepx1gh1iSRYKBDXnWDK+A65Ty3P2OvVN5ErpA2P6m4PVzbO+/DgUCQG6Hlngk9ZeuTUdmibdjyfZL7antg/fZmZ/+EhNc+dTEVP9sraeOCtQ1flNN5r7U9sIKYZw0OOWha5+qFG1G2JuLAT2IVbo2nVwh7hPikEftnBSewk=;7:iiEinbrtCp8TzRiSlX3NVxDVrodPIFc/IxS4w3AmRW2hqIi+Q6mZnr0Y5IrpL7FwwjRBSEoswbk42J1tUeIHq0uK3t+gjKdyVoOq/qig5yj8ezqTv/yzx1uKxj45NkHhV9In6HKfJlg28TK5be3P0+M+xh9OWg5ZMtpM3tBJOaygHwuRJpjNbZ0idvMiHrICY6tgp2SS+Q5w7qcs73HVnSupCXK1XObtanB4MNQrFEQKTtBu74OLsNLoCBxFk9El
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 11:14:45.8785
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 970b5800-5da7-4e64-79da-08d6068e22fc
X-MS-Exchange-CrossTenant-Id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=eaa689b4-8f87-40e0-9c6f-7228de4d754a;Ip=[137.71.25.55];Helo=[nwd2mta1.analog.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLUPR03MB552
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ok now I understand.  We can go with GPL-2.0-or-later and MODULE_LICENSE("G=
PL").=20
We are pretty flexible regarding what license we should use upstream wise. =
If you feel we should change it in some other way we can do that too.=20

Regards,
Mircea

-----Original Message-----
From: Peter Rosin [mailto:peda@axentia.se]=20
Sent: Monday, August 20, 2018 1:38 PM
To: linux-kernel@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>; Caprioru, Mircea <Mircea.Caprioru@analog=
.com>
Subject: [PATCH] mux: adgs1408: use the correct SPDX license identifier

The file is GPL v2 only.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/mux/adgs1408.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

On 2018-08-20 12:16, Caprioru, Mircea wrote:
> Peter Rosin wrote:
>> I just noticed a discrepancy in the license annotations in your=20
>> driver. The SPDX license identifier says GPL-2.0-or-later, and I=20
>> assume that is correct and that MODULE_LICENSE("GPL") without the v2=20
>> specifier, as in this patch, is the correct thing to do?
>
> The file should be v2. It might of slipped from the final version.

Ok, so I read that as if it should be v2 *only* and not v2-or-later.
I.e. the reverse of the original patch. But since these things can be sensi=
tive, I'd like confirmation that this new patch is what is correct...

Note that MODULE_LICENSE("GPL") means GPL v2 *or later* (GPL v1 is not on t=
he table), while MODULE_LICENSE("GPL v2") means GPL v2 *only*.
See include/linux/module.h for details.

Cheers,
Peter

diff --git a/drivers/mux/adgs1408.c b/drivers/mux/adgs1408.c index 0f7cf54e=
3234..fe0377bb83eb 100644
--- a/drivers/mux/adgs1408.c
+++ b/drivers/mux/adgs1408.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
+// SPDX-License-Identifier: GPL-2.0
 /*
  * ADGS1408/ADGS1409 SPI MUX driver
  *
--
2.11.0


