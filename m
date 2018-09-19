Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45085C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD98E2150F
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 12:17:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="n+PY/XVx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD98E2150F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731495AbeISRym (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 13:54:42 -0400
Received: from mail-eopbgr80123.outbound.protection.outlook.com ([40.107.8.123]:19642
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731206AbeISRyl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 13:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=189g/uZnQfSTpEerowyPWlc5mfWeuFBlo7cQbcmWHNM=;
 b=n+PY/XVx8d5J6zeBhKOF9nja/3s4qBGl4Lpw4gUeh4pRquPu8A5k6nO9C5F2Ac9O3H0PmnS3vtaVGO3tMJbG5xDN2Ez6GddexCNSmIay+PcOhGsD6qPoW764zN7oEQddKMLzrmKP3VNtHDUrrl74DEEoPB2KpPqk5dmF3IMsVCw=
Received: from DB6PR07CA0164.eurprd07.prod.outlook.com (2603:10a6:6:43::18) by
 DB6PR07MB3512.eurprd07.prod.outlook.com (2603:10a6:6:24::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1164.18; Wed, 19 Sep 2018 12:16:53 +0000
Received: from AM5EUR03FT040.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e08::202) by DB6PR07CA0164.outlook.office365.com
 (2603:10a6:6:43::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1164.10 via Frontend
 Transport; Wed, 19 Sep 2018 12:16:53 +0000
Authentication-Results: spf=pass (sender IP is 131.228.2.241)
 smtp.mailfrom=nokia.com; infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=pass action=none header.from=nokia.com;
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.241 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.241; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.241) by
 AM5EUR03FT040.mail.protection.outlook.com (10.152.17.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1164.13 via Frontend Transport; Wed, 19 Sep 2018 12:16:52 +0000
Received: from fihe3nok0735.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w8JCG4cD019473
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 19 Sep 2018 15:16:04 +0300
Received: from [10.151.72.173] ([10.151.72.173])
        by fihe3nok0735.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w8JCG3jr019355;
        Wed, 19 Sep 2018 15:16:03 +0300
X-HPESVCS-Source-Ip: 10.151.72.173
Subject: Re: [PATCH] tools: Remove conflicting BITS_PER_LONG define
To:     Arnaldo Carvalho de Melo <acme@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180912170232.25258-1-alexander.sverdlin@nokia.com>
 <20180912190107.GA5502@redhat.com>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <822a52db-93f1-3681-29ba-595cd000b5cd@nokia.com>
Date:   Wed, 19 Sep 2018 14:16:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180912190107.GA5502@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.241;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(39860400002)(136003)(396003)(376002)(346002)(2980300002)(438002)(199004)(189003)(230700001)(81166006)(81156014)(6916009)(47776003)(8936002)(65956001)(65806001)(106466001)(97736004)(22756006)(64126003)(305945005)(2906002)(36756003)(356003)(31686004)(65826007)(5660300001)(478600001)(229853002)(6246003)(336012)(53936002)(11346002)(106002)(2616005)(446003)(50466002)(476003)(126002)(76176011)(68736007)(26005)(86362001)(77096007)(53546011)(31696002)(26826003)(186003)(2486003)(23676004)(316002)(8676002)(58126008)(4326008)(54906003)(486006)(44832011);DIR:OUT;SFP:1102;SCL:1;SRVR:DB6PR07MB3512;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;AM5EUR03FT040;1:C0YLkNYSFh34npj1oKvIvUijtqHbDb+CPL04GtO74ZKGkIFR3T/hiGyz0Jxx6/2iJWbr7F3MIKSSLNwX9X5m+mi5nidVTrVBxo0K5iY9ilZe4iwYM2jQ1A9X/fnSccK9
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 66feb54d-070a-4211-0e32-08d61e29c8ca
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328);SRVR:DB6PR07MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3512;3:2OmxlyqVDNU2Z9Ko16lhKF/gPYSk0xQcylNGs8yoozBcJQOseUNL5QQuCNCLc0VtfA/fRAHk5PDsnqyZVXgi9RkZsQeWoBNDBoskCsnnsHmlzeq+HoM3AUPTQZra+Bhb/9XioVOaK38s81cGCKec5VWYjL5w1JSFAMUMO0WxJZ1VwA7mrs3BDasqhKsOGcuBNLUZxlfbinLZhJ161dbur1nzg3QTEkWZuVs4atZuiT4tNaZtzoZLqt0FPrdkEHPIkPDbjmM/Fa///BvmcZCCNmvrxNYVshTjVCX3ZPMfpu/gtmdWUCMEKWrM+PKK3fJYCAlEsHI1C4TYlLrRcFmk63xYrDJP+om+HY1+FQWZjxI=;25:6O8XjpO4LgF603jJn3u6BdDPSM9IoZ8SnXdEIfgz7r24Z0K5TvKkAxisCJALA6PcvC2vhaLyScgwQEzr3dTZTPAxJlAtyiseLheZjwncO2oyxJEbr4fSKU3ycl6WFBusM/nuQXC4JNcVmexcuralMVBZk2+W/3MlQ5AN+nlqoe7gHyIjNRk1PfUBlQrqc7QXLsOwb7ua5Di8/slLsMgqbwvN3q6hzXJ9fnBP2r1oFCjuwj3LdFkVxPkV9AzECnVx7YZ/3qHtNRush3Z/ctKmSza9sw6Wh/i1VjuDrK800oo5k+pvvpIztCPRzoeVJ8iGQflshnhg01fV+p6UmljNWg==
X-MS-TrafficTypeDiagnostic: DB6PR07MB3512:
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3512;31:6as7jIbfdQYQKXlpwZhlnK166Ar690PHBJraxB1lWKeFi9xINOztO2f5x96ZxQf8IlwvbSsQqXHNnhgjUpJ01TMYCBli1RJlKBaOnFx/2h6Mur83VVllGJ3u9LjiKpmxrmgnSxltI9mczpyYoX9zt73ns9jqoWUvecQMEXCLyt1GBX5NxufMhg87bq9etOpPygcwv1Mdvdx49GAjClEcMaVMgDwVZ91fE+P+i+/DB8M=;20:TRWvjAPY9cgDigxlY+AK2I/IcAnUWa5yG21xWYtxDV+rawbmlbNurR0d2FDWcqzy7Nbrh9/OCF/kBrxM5OAXEig2qBYdi1j2mxcIb9Szo8xHOofZpDl7mFzHo7Mn2lYE5m5HGCDzEMMT8urHSGYrCVLxEsugBz9ioV4YszKHzvXu4uY0K0Ch0XC99EZUhAemgigQTwwx5KfP3oOEsZy870y+i69c/jitHc7k5OOM1+BXjz1B3h3Xzu9og9tuZaimd+CWwN7L8HLFkNxUJcGrxyhOQ4g/7qX0qLpjjqGjDRkytbyCPPokHv79uj1NdzJ5Waa5aEa+ptkKgX0nNCmIKfIuxPW5BAm9/NWpcOcHX6zpc/4j48TET0aNfpPVrxPgbFDBajOr7pbun2GMAuCs87L4Dm8fegRA2rCygzR7blN2BerFZxc5vAigiWvjRCHEIBVEVoRUvtryrp1uuV/Wr/Q6VKcmrVgypteyT3YMUJts6RUVoPvTtfFtmpq/7ODsJNXE5HdKxeF7j/rldIFiZvsaWB7JpHFseqKiGUJs7FvVJEuWoVaaVuqF6zLLNGl7MQuJvQusckJzUBbAj9/KeGDEO6c4QjFTpsn7KXMNHSo=
X-Microsoft-Antispam-PRVS: <DB6PR07MB35129F20069D2D8F4B073442881C0@DB6PR07MB3512.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231355)(11241501184)(806099)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(201708071742011)(7699050);SRVR:DB6PR07MB3512;BCL:0;PCL:0;RULEID:;SRVR:DB6PR07MB3512;
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3512;4:GWmaToz75F6lRhTZfq7jyLzMr+OUXNpkxBR8yOIckwqkxavlLJ+Mgfm6ueUu8YmpBPKpNnptYkL+t1Wi3Cf5WKYPP3yFhd385FxZtK/tAkyHTUen495/NVkcHGJ91jMWrSFLxiEq+wGFsqlT+clFFj9kqB92QfC0blgqRKcd/NgxLrBFvvh/NlGAAasXJZ56HdU6H4Q5bBLg+YQWss03B5A7cvWoEqLBB2sgVCLSoTS4trmmE2E8YJkLNo5Eu04X4PESGW5L0B3v9FEe2tO7Gw==
X-Forefront-PRVS: 0800C0C167
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtEQjZQUjA3TUIzNTEyOzIzOlJsN0lJanl5SC83bndJdk1VbVo4WWhFbFlL?=
 =?utf-8?B?bmRESjdENXdsV3RPNlYvM0tydlg2Y0x3YzNZT0E5eTlPNm1uZExJNmZkZFFo?=
 =?utf-8?B?VjNRYThNaFgwRCtwQWhOWWVwZW5sQTdKclk1bCsxbXhHdWNIZ3ptQXFLcjg5?=
 =?utf-8?B?VWFyWnQyUUpmNXdzaDY5SWd6eFQwOFFmVVZ1b25qalZjN0RhMS9DdURYZ3VR?=
 =?utf-8?B?NWlCaFNQQ3MwL0hUWFB2L1RHdmVvUTRBd2duZXQya29hRlBRK2hJRmhKRkZr?=
 =?utf-8?B?Q2xZOVVOcVNDZTkyWXhhcWdiUkcyZXcyM1lsU0E1bVhnNVk3MzJzcStpZ01q?=
 =?utf-8?B?cWRQTGJoTTdYWTNUTGhObE53NVJEUjIweUdVMnlIcVZNeGN5N0xNRVlWakQx?=
 =?utf-8?B?S0xOcGx6a3loQXNPaE9OaHNzeXd4enlDMlh3azNJSDU0bFl5R2ZxV0R1bkps?=
 =?utf-8?B?bUZZdzZ3V1FmelYvcnpXOEtxNWJCZGMxUDRYcGpjQnFkaUk2bGt2T1hJUkdK?=
 =?utf-8?B?alhTTkthMS9qODRZcVJLZGtSK2JzNldES1NtQUtyQkF6TVpwYk95TEMreFVw?=
 =?utf-8?B?V3kxNTlQNE5sRkd2c3dSbmczS05rMVFJZ3NRbVFKejA3dXd1ZVJtL1ZveHIx?=
 =?utf-8?B?RUtaVEg1U3hoQWhvZHdLUlZCVis0ZWlqeFBIV2Y1cEVoSEJoQmFQdVRoVTAx?=
 =?utf-8?B?OHRLQU5TZExpL2JaOVgzbWMvUXJ5bXdtZlNsRVk1bjhJbWloeXhXYXAzT3cz?=
 =?utf-8?B?UEl4a0h2V1BhcDhsMHhEN2VobVNWRUZFWU1McG04ZTVhNU4zeC9pYlcwYjR0?=
 =?utf-8?B?c0pXN1hOYy9MQTNCa3d3QzBDbzN4ZVVxTStGWmdoZ3dOS0VsWUp4YUk0VUtG?=
 =?utf-8?B?eStqT2JrZ1R6ckx5SEpIYzlMMHU4bitxQ3pPK3NIRmNzMnJJNjZvK1A2b1Q0?=
 =?utf-8?B?aHNkOWFRZjdvTEoycVVDL0tCR0hVdDh2NGdiTlVZblFaTnJtcEFkZkdNWFVw?=
 =?utf-8?B?aUpMb0ZVZENMdFA0RWo3Y3VnRHBwRzlaQ1l5YzR5RVVXQmxRajQ4YmtYSVR2?=
 =?utf-8?B?bHpZZ0VYYVdYbGRCcVdDcXkzNU8vYmp1RnlIUGhjemppYmxuY1ZENnpTZVpj?=
 =?utf-8?B?QmxjalpUa1R3MUp1dk5YODlsdTJWanhYWW1rR2dzcVlIVGpGekpRR2RCVUZn?=
 =?utf-8?B?QmNIa0V1R0d1NENXZTczbnIzRmJvbWJNL2pyajIvUC83RHpkOUVWRU9tbkd6?=
 =?utf-8?B?UU8rS3h6TFN3Vm5LeHJWZEhFcytCVXI5UW5YUHp2QmlCMUJSdnRlU0o5b3ZO?=
 =?utf-8?B?YitaVk9kOUpjOE5wQm5tM3V6NW1sQ1ZXdzE1YUJLQ2g2a2Y0eit2UUhoTG1C?=
 =?utf-8?B?NFJxOGpoaDU4YXliOEZFeTRmVUJ5NXFNYjJacldtNXovdW5aMHM3UmZaQWxv?=
 =?utf-8?B?RW4zQkVWeDFNRU42SHNiU3d6VU1LWWdIUVlvQmFlOXRSQ0NlbzlHbnFya3NJ?=
 =?utf-8?B?NDFEUFpjYWR4eXZSUm8zZi95eFBoYjZ5S0FTbzIxSWJza3gxVkdIbVZybjFR?=
 =?utf-8?B?ck11TzQvVUp5aGdQZE9IYWxVbUd1c2MzQk1vdjZXOW1NNVFZWDVxN2lDb3hG?=
 =?utf-8?B?cWoyWXFldmxsL0lDVWp1N0VYcEVISTZmL2h5MHN6QlZFUjdoTmt0L3pibXYv?=
 =?utf-8?B?bWhVdTlhcmdlbXdOaGdaS1VzbGxCUXlMMUswT09zeGd0V3pBMDZ3Q2JrOE9N?=
 =?utf-8?B?ZlVwamptMEJvaVFCV1hmZz09?=
X-Microsoft-Antispam-Message-Info: TJzIaPUALkFVk9tgBvdEBCn+FU/4uJvUr9L4EdJn+wZHsCQCyBhiksNvWrfMyNSbjgaeAcOUtQPQpNfw/exJMfAljlbKNu18uOVGdjTj7+irLv1UiG0kVjZxk3l/sZfEZ4VEDh+e+E4NE8gYi+ai6KhuTblQAY4hrYvD+8AONBdlThaB0OjaK1zq5Bqafxp39KhOPZNyWiXsc0wc7XT/MPrlNpnGDY8EduwFixUrn3Wkj+f76/MOmjwVL2PYwIR87krxeLgmZ3feuKPymj3bV3B09QDu3LG32Ylhc2XXVxI3u0JyUpTOLQukG3G5oNYm46IyuhCYF7Ms2e9ltcB6EtgUgGBSdeSd8BhNOdBFzhnWJOfnIpGli9I5gduZBMVlp68Az9g4M64/n7xOW1/e3QwgexnVnO08t4UElEGsa154lUbJDgQ4JvR+joxDCC9k
X-Microsoft-Exchange-Diagnostics: 1;DB6PR07MB3512;6:OjL2EII7JXkL4afaw7oIAOOozorKa9HzzUnbel9zudjJT756JGyGKe+sN9uJZRozuu8i42c2vxO0pBvP7Qf5SjBwmJPrsoHnZSM+ZeQkuypD1zjnTmNbXyzeNW1Ks7FxmhoFGnFvqnKycb+fG+XdZdxQSGpNz590Bw9pPlsUDYyFUQRBsmEeMcvEp4o2rNEHgGkLUtLleKcu7AkyLKTeVBqotNgLG+8lEFwGfAoMLFeIaV/P66/eDOcyJmaSWAtgyJ40/ou1rsRVC5T3I4W3jlyC3roKYFjYwN74x+IAcOIQkgOfk1rn4CFOXBejkF6+8xy58BeyokQpgbaWUK32otcqCbBO9eLFAwaUJybHcDNWnKv9vFEZ+V26gFvI2rZTQeZeJMQLnHQxmpC7zwWF63YNQa5KDbcCGvTDPwKIpq/xor2aKG4XAwRZHEiaNpoLcuJTCRrYfDOn8C9be7Rdjg==;5:CtWF8qoEXqDvp8L0hByf2I6EjW9ObUSZUjIoyv1l0sbbkTEtOjP3u0QqteNWKM1XBXEm10QY0mqPLVTFfQbXieHfzOoU7rVvp8ztstu6/3eVo5U+9ka9W9Qv1QiFOXOTk265K23Chtv/VtFrwGYEAUaCh4PcnSMQhprL5pNIQbM=;7:kwfzh0Vc7GAY+/DpwjmQIHXRVqy6GYQ+yY2wS+F8RNECX9chcGlRqrwopFe5vXhYf8pYAjThAQs1iwIrAQJyvFHI0hSN9idnssfIQBzKbhobDDjAZFyw+3JDH5DMsE8XgsbE69TPL1wBZRFUZhxiV9AsrxLjyROPzcK0NyC7gkphK6R7BN8zjzupVHVxEdZGPiH3/+iZWMw9D7O56I4k1liZWYlncneDDpObSdxjkdjyjh/tUStEgpt+ciggtlv8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2018 12:16:52.8806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66feb54d-070a-4211-0e32-08d61e29c8ca
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.241];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR07MB3512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/09/2018 21:01, Arnaldo Carvalho de Melo wrote:
>>   CC       .../tools/objtool/builtin-check.o
>>   ...
>> In file included from .../tools/arch/x86/include/uapi/asm/bitsperlong.h:11:0,
>>                  from .../tools/include/asm-generic/bitops/__ffs.h:6,
>>                  from .../tools/include/asm-generic/bitops.h:16,
>>                  from .../tools/include/linux/bitops.h:35,
>>                  from .../tools/include/linux/hashtable.h:13,
>>                  from elf.h:24,
>>                  from check.h:22,
>>                  from builtin-check.c:30:
>> .../tools/include/asm-generic/bitsperlong.h:8:0: error: "BITS_PER_LONG" redefined [-Werror]
>>  #define BITS_PER_LONG (__CHAR_BIT__ * __SIZEOF_LONG__)
>>
>> Include <asm/bitsperlong.h> instead as other headers do.
> Please try test building all tools in tools/
> 
> This broke make -C tools/perf/

I agree, this brakes perf, so we need to work further on that...

-- 
Best regards,
Alexander Sverdlin.
