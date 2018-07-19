Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E511C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C52A20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="inqiLEFP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C52A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbeGSSq3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:46:29 -0400
Received: from mail-eopbgr730050.outbound.protection.outlook.com ([40.107.73.50]:8187
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1733174AbeGSSnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KxtDcUqgZOYt5We5ajz56AO8FeB+ysIuW6UcK91KoY=;
 b=inqiLEFP522fRpRaax53a8R9WYombVnZRYjm/0z1DD3KBytiOcft453Jst0wRHDf6IQVKCbqRHQNk8u7o680fc5/wjlrA8cCd7pC5XC1RmG3Uef5lCsMEW6HemPm3dyumIBX7fh+NQhPdWprnlfDGcUJfmm29W0IONjslMNp+xw=
Received: from SN4PR0701CA0015.namprd07.prod.outlook.com
 (2603:10b6:803:28::25) by BY2PR07MB2296.namprd07.prod.outlook.com
 (2a01:111:e400:c50d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Thu, 19 Jul
 2018 17:59:24 +0000
Received: from BY2NAM05FT059.eop-nam05.prod.protection.outlook.com
 (216.32.181.240) by SN4PR0701CA0015.outlook.office365.com (10.161.192.153)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:23 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT059.mail.protection.outlook.com (10.152.100.196) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Thu, 19 Jul 2018 17:59:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxASA019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:22 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:30 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:30 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxERu005925;
        Thu, 19 Jul 2018 18:59:14 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxEb9005924;
        Thu, 19 Jul 2018 18:59:14 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 20/31] usb: usbssp: added queuing procedure for control transfer.
Date:   Thu, 19 Jul 2018 18:57:53 +0100
Message-ID: <1532023084-28083-21-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(2980300002)(36092001)(189003)(199004)(50466002)(2616005)(48376002)(26826003)(478600001)(87636003)(486006)(126002)(4326008)(476003)(1671002)(8676002)(426003)(106466001)(2906002)(76176011)(105596002)(11346002)(47776003)(446003)(109986005)(8936002)(107886003)(51416003)(16586007)(42186006)(316002)(54906003)(5660300001)(186003)(14444005)(356003)(4720700003)(26005)(6666003)(50226002)(7636002)(305945005)(36756003)(246002)(575784001)(86362001)(336012)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2296;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT059;1:sIzwfkQpj6L9U0FgNv9yxEAUgqaSy+iVj5mCFYVKWPO1qNBkHGXyV7qtTOAtobT3JQhzf/yf+z3iB2xG0VZlrE9hUIEuEcamaOrzRUyshVVG7zLZ6q+35KC3Ql7jyT/R
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 144aaa20-f1d8-4a9b-7510-08d5eda15be2
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BY2PR07MB2296;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;3:YEvxRGCUxgkQCAsfO6WMSrqZa2GEXzE6ISqxfz6NidU+nq64PMTZ3JKKut+mlDuRVR/HdHPr/qdXWAWUyzguvkmfKJzINnEh6yagrL1FooDzsVNupgylU1rNVG+KcoPwJDiqqFP5lVIic6Tlivb/IIMDGuaKBDL+/s0ZYiZ+XMB6gnASBdN2zcGkNyCtG4Tr1RVFCpfJSvJNQc33r317zBKqZrVsLwhYcGdeJRTa84g9tsjao4icjyELBIhWpvaj2IW3DHkAOgk9csx8zlXFz6Pgbtr04UPsiOrdtit7jrNYTZLZ4eUEEg/+rXVdz8tFi7EBEksORP9IzrsIKVr7oknDcjb7O+/HQ9QaTewPZa8=;25:J+kKLM9bDoHga1/TLEynaJikKIPvr46k+wBqk6+48PbBls2VxVfEy2zfloJCZwPF0y/wzKvPXHuuvVxN4TBgPOG0/5TMtSHKeikE4tSEN9WMx2rgQwNgdF22gsKQQYW81dWu0Lwf1bMJO4y6SjWXhcQ57H5BeOJnC4OFvaaliNZS4R4GZxyfta8kR/3liZlslvkWVPxQobHJqoT6gDSQNeaIMeWERZ8M01DE2RtROGpI2bHDzPf5nddicppwOemQIXcTP5Y60FXyOG6qWIAEt5wHQnTADvQ/1RmS8toUJJiajlHMKeWAdc68UDuKIkA0hJeg6oIh9k9VMWiZT3dYBA==
X-MS-TrafficTypeDiagnostic: BY2PR07MB2296:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;31:evRZB/6TZeBGW3oIa1R70rpcUHDtrqZvhrjpxB+F+GxuMq/2WT40TVthaLJGbMiXWM2rX0X5QJ5e0R8Q6p8Ccr0gzA0Ux+QNW7gFg+bGkmfz5xwCiTDQbUyVUGJ0eabRbTq4tClAmxELPBWn2XXscfdrqU/5Y7rLoQBjKfr4w56epiC0ISR6ELDMKYJ4EE+yokuaAOG6PNCd9D9m6B9X15nu7ALvyOd/SG2glLv3nRs=;20:G+CuOOipt1VzxUmkNDuNLXEIk/zoA/KcsnBsvZiAX3tbPvA4QMgTRzg/z3MQ9nA6kgXceYQpVCh476mjSQuSNpTHmy0h//9Wq5HlYiOE9ZwqqgO8oYwV3JjO7Ap2Zf9uwnnLXUfVSNpq8hbXdt96k9HR9zQvNqpxNjwdrRdeVmi0mHA4BFORaG+CloHGyW+NhbQnvGv4B0IE00a7aKpoPhwssjxb+WI0kj8Za0mSj3rb5+L9TundzUpYrONpVeCr/BoNHgDkS+63WHMwWlyhT/rYh3aVKuYFTEAAMCSyXZ7mJZJ8ZcRhGEYZUwaJJrEF/YkD05A5JUx5axrcY1OZCujR+uE1RnAjuEKLzjBHNUfaYE2fG5CyJhINdw4Y+hds1I5B4kVr/BqxFLPXpxtA5peHrx8iqSVVvT2jQoakaksjii4CIRsHFyWjQD+8WteG09AdzLne+IWc+CFvhkbhKQWaVHxI+hJtxy6mfCwScxFbLkaj0mRg2eBy0K7UNF+z
X-Microsoft-Antispam-PRVS: <BY2PR07MB2296D9726B2EC3346F54E277DD520@BY2PR07MB2296.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB2296;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2296;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;4:5g8qAPGC+gIuKuWNUoYCpb9BN7nAadsEHOPFqQVxGI8CMBBzekmNsZ1VAuSOM8E9NW8KJJkVk7dv+aH+fRioDNqLf2UcY3pthBtKvc9XB2R0IfFBEJ0nLgbCutdwqUVK1M3VKi92OoncIyzAeQUDDw+dLFEOnvfYY7Z5zPrKM9n2ag/wUVe3/4B760PFL70bGrFMNhPukUaWtKqyY9/OC48Tg9iPtrupPEze57BomK85BTnbLLkYWfcOW0SEA4xov99LFyC+IXg0w3JiFuX/urj2xP65b+DCveMYgH3F9eNkWzkdPoLUyBDZ5df1NHuO
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2296;23:wfME6+ky1QZYq2MbYaOqBu3YsdBpoj03ZGG3rmSlM?=
 =?us-ascii?Q?SdMs/B/KRaCAwxEboYZUzs1JrguPTCQHKhbc1SaFaGXOHjQlsn2DCI4+UWOH?=
 =?us-ascii?Q?0L+L4r8lVUnbo4WuhleF3INlOS8ul0nEtxjZ9XbT8sblHDOudsHjo+2hG6XZ?=
 =?us-ascii?Q?FX14Wj9VFUjIp2HFWRcPLdrBvBEBIGqa/je9rPKJm0Q8k41vZxQN+tb6PS8N?=
 =?us-ascii?Q?RzzIa/7r9WhJ3MWb0z6H60YKy67WnovwUqpLhpoRAaG3D00kSQeGcjhwgDmB?=
 =?us-ascii?Q?hBxlzlZOKGC/KowqwoMX3s9MORbWnh67Yfbi3Ai+x2wULWBTU6+/90kO3aRh?=
 =?us-ascii?Q?TQHP1el9lvhOqU3xSw09+37rapw9CrqGOV7Gt5Vk5iyysJFsu0JhxI87oBqq?=
 =?us-ascii?Q?Sz2AJuGikqXUDa6wgwWmOgLnYbs8ikF4XyK+Fu5o9CKK+xM1oSAKo8oD0E4B?=
 =?us-ascii?Q?R+DszyulbFKHW/7kyn2N2wCTq7FSzHc9RkhAx4vzrusBVMaYJOCDoG0wZTm/?=
 =?us-ascii?Q?sE2ZXvUKhJ2M16cziEgdOt5fI1ljy8MyED1RY3/FVp8kOBy81rQOtj4JF+Qk?=
 =?us-ascii?Q?/hB2M1mSHjig10JAMT1kE3Efo9WQ38jz9s+Mgz79K5FNGCejt/bP6RxsmxHl?=
 =?us-ascii?Q?HZYGUKvJ5IqBYmS/SDoEY+cCgiH3TprowNbx2yM7vfrahN0VwXAv7Do5feqe?=
 =?us-ascii?Q?8OuMi1GzJcCPA2dCAjaWGrlyEwj+0hW0urFjAI6r5Z9sUxDOrTQiRbh7qRKB?=
 =?us-ascii?Q?eGWX2AqlnLEGevpRIiKvR++OD0dQMrgYka7NXlTaJ2J4pgXGM52IOH4AQNi8?=
 =?us-ascii?Q?YTuw6hFZGjZ0UWzVuyODdQBKAetvx4nNztCAa+B50+lzNwPiDsDM0MFKwNUK?=
 =?us-ascii?Q?Gwfi6pidtaR9XG5RzyZdYN8CoFhvr/G3ahq3JZIMUAaXaoPfJpcYXRELZdQ4?=
 =?us-ascii?Q?+kc+QOj8RLuKG0WnrHso+jWUTEhuvPrK551jfU5NWd9mPlzDgmTczpTZ11Ie?=
 =?us-ascii?Q?BQp/WEH7Y8MefwZmGyaqAUhDjA/VbefrHRHP6ouleHQ1tulr3+rsU0kP6nqn?=
 =?us-ascii?Q?zy39icWR2nTn9ry6TKw64y4altppv3VK4GtqG+oXIOBkFZxnkmIr5No1uY36?=
 =?us-ascii?Q?V7IMFWMRv1Dz3FNwKcp96lZ//9+GiG4PcVo+bRvB3No5F3+bexjW3vhVbcxO?=
 =?us-ascii?Q?a1pxPzFQzAmXX8=3D?=
X-Microsoft-Antispam-Message-Info: O5/BTAT5zfZWmezW/1ITheFQ4EY/H/Da6/a8jkHS7hTs3G+hmEINTKgp5l8PJMo6KaoHf1pt7FeVrXI0LXSOFMKKN2ay4hJUl8tEmKCreRGunEFMumERRVQI8xrUy3cruSZVxxXIBqvxbD1rplxeRnxqoTvmqq6WRmAAfKHl1D/T5VQnVCoVcl3ick6pSVghidfV6EdfoxvHVHipbaYSwWyXphK5ZWQ2GunrkSZ/qDYXTaSw3Uee//vVgl9mhah60zkrjjDsyr1p0Ed//Kj1KpDHdn5uNXC/+UqtuSEH8FJNgH8YBuExpMl9rGtQ+D9sVden5k9vYnRKgAFTGV7lPFtvOnS+Vk4PzFylaWLJJGpw0kzBdFguC0aewr8hiGWItlBIdnvGGVZmso3glQhviA==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;6:nMCyY17A+gi2y8nba80RKoCDQrRX0SyYBxtloNUG8desEHPQ2jLUJFQgEkT3E8212Rc6ndwFeyNZSGNgzs0xeUI8oP6TPAL7T1ZKOJYZ0aZXs89ehgZ/1IBBo/YW63YWSauCIT7bW/LwOoGh/hvPSJ3s0UYDzG2LOgIrIq3oZQKeaF+XyVI1R7QXtOoQWT2bT4M3eqKod7IwwUNvkS3IMvRPMAf+2q+2Ky6ookL0PPxmtBiBHAlh5qwhkDe56f8KelvcUptTU0KhhpudG7eTu0FhLdBS3FGQpmJWwThFYDsDSAFmzurTRV3Wp47ED8AmyLqQ8rfVo14F9ZENGhVUfjoKPeU+hkQHkXXCSwUvGFGVy2aeSmR1X5y9TEtJ6eezOouJ731gXIbbaiTHfYy8G8VyBdj6Ei+zm7dASAKko3tFp/KucujVw1bxPp6YSuI0kDaa7/h5rD2k/6yJkWa3bA==;5:N8di9s9R3FUNJ7iQ2I9emp3dIQmvInuuWW5zVJncqFVoR8XzIz1WyDoB6GLwAp7XqCWO+b+syi3gakDTfyy4YM3b0weVhGwLnUIhwDoiTZ5gQH/6AIMC57qcqCmTEC/b67Rw76KmS2zhMJctV5zfNgW85NNo6yC5aqCVfc4KI+I=;7:LVrHtyP6VqzsTehVEc3wQg/eXjAc6KIeXb56TO0qjD6C5rAe2711Sy0HBBQUUyo6/0afPAmYXuaEYcLJgBt6dVXivWhX6lCMy4Jsf6bJb+wQ1wMgzDGwAX0gQTb/Q9/rGRSEsTPc0hzhyzca0Jw68gCbSbKXAmOkegpcJMHG1gXjfEHOH+t79oJ3bs63nUAiNuSZQxPLhxzuuEFiywSLBfI5s0XDNbn+ed3AqkSaOMgKnlEdk4fykHUDSC83Zw8F
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2296;20:XOZpec2aBzfoLmQesp5xo8M/L3mnsXFp93KjNcbEMh/K/TmcN/c6Bue9qGQMlDiXON4K9oyWvBucZSjz/WHH7twljSJZbRpvH+SnZjxt6/lngzLvp3jbP06SD5Sj/SdMakb/0HLFtbpMWqIKUmYjBNzvbv0A+GRvvhTDOBrkjkzba6YW4W0880R6VF17GWc94tmQ2OmrzFkrUQgs7yf9plrcnktIkbhAJeXTn3fSCWXzF0R+oetCDf56gZ0TTKgH
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:22.9253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 144aaa20-f1d8-4a9b-7510-08d5eda15be2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2296
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch implements generic use in driver usbssp_enqueue function.
All requests queuing in driver must be send with it help.

It also adds specific for control transfer usbssp_queue_ctrl_tx function
that prepares TRB, adds them to EP0 transfer ring and set doorbell.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 272 +++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c      | 115 ++++++++++++-
 drivers/usb/usbssp/gadget.h      |  29 ++++
 3 files changed, 414 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 1b57f5180115..a0cfce0dc49d 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -310,6 +310,43 @@ static void ring_doorbell_for_active_rings(struct usbssp_udc *usbssp_data,
 	}
 }
 
+/* Get the right ring for the given ep_index and stream_id.
+ * If the endpoint supports streams, boundary check the USB request's stream ID.
+ * If the endpoint doesn't support streams, return the singular endpoint ring.
+ */
+struct usbssp_ring *usbssp_triad_to_transfer_ring(struct usbssp_udc *usbssp_data,
+						  unsigned int ep_index,
+						  unsigned int stream_id)
+{
+	struct usbssp_ep *ep;
+
+	ep = &usbssp_data->devs.eps[ep_index];
+
+	/* Common case: no streams */
+	if (!(ep->ep_state & EP_HAS_STREAMS))
+		return ep->ring;
+
+	if (stream_id == 0) {
+		dev_warn(usbssp_data->dev,
+			"WARN: ep index %u has streams, "
+			"but USB Request has no stream ID.\n",
+			 ep_index);
+		return NULL;
+	}
+
+	if (stream_id < ep->stream_info->num_streams)
+		return ep->stream_info->stream_rings[stream_id];
+
+	dev_warn(usbssp_data->dev,
+		"WARN: ep index %u has "
+		"stream IDs 1 to %u allocated, "
+		"but stream ID %u is requested.\n",
+		ep_index,
+		ep->stream_info->num_streams - 1,
+		stream_id);
+	return NULL;
+}
+
 /* Must be called with usbssp_data->lock held in interrupt context
  * or usbssp_data->irq_thread_lock from thread conext (defered interrupt)
  */
@@ -1494,6 +1531,232 @@ static int prepare_ring(struct usbssp_udc *usbssp_data,
 	return 0;
 }
 
+static int prepare_transfer(struct usbssp_udc *usbssp_data,
+			    struct usbssp_device *dev_priv,
+			    unsigned int ep_index,
+			    unsigned int stream_id,
+			    unsigned int num_trbs,
+			    struct usbssp_request *req_priv,
+			    unsigned int td_index,
+			    gfp_t mem_flags)
+{
+	int ret;
+	struct usbssp_td *td;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_ep_ctx *ep_ctx = usbssp_get_ep_ctx(usbssp_data,
+					dev_priv->out_ctx, ep_index);
+
+	ep_ring = usbssp_stream_id_to_ring(dev_priv, ep_index, stream_id);
+
+	if (!ep_ring) {
+		dev_dbg(usbssp_data->dev,
+			"Can't prepare ring for bad stream ID %u\n",
+			stream_id);
+		return -EINVAL;
+	}
+
+	ret = prepare_ring(usbssp_data, ep_ring, GET_EP_CTX_STATE(ep_ctx),
+			num_trbs, mem_flags);
+
+	if (ret)
+		return ret;
+
+	td = &req_priv->td[td_index];
+	INIT_LIST_HEAD(&td->td_list);
+
+	td->priv_request = req_priv;
+	/* Add this TD to the tail of the endpoint ring's TD list */
+	list_add_tail(&td->td_list, &ep_ring->td_list);
+	td->start_seg = ep_ring->enq_seg;
+	td->first_trb = ep_ring->enqueue;
+
+	return 0;
+}
+
+/*
+ * USBSSP uses normal TRBs for both bulk and interrupt. When the interrupt
+ * endpoint is to be serviced, the DC will consume (at most) one TD. A TD
+ * (comprised of sg list entries) can take several service intervals to
+ * transmit.
+ */
+int usbssp_queue_intr_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+			 struct usbssp_request *req_priv, unsigned int ep_index)
+{
+	struct usbssp_ep_ctx *ep_ctx;
+
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, usbssp_data->devs.out_ctx,
+				ep_index);
+
+	return usbssp_queue_bulk_tx(usbssp_data, mem_flags, req_priv, ep_index);
+}
+
+/*
+ * For USBSSP controllers, TD size is the number of max packet sized
+ * packets remaining in the TD (*not* including this TRB).
+ *
+ * Total TD packet count = total_packet_count =
+ *     DIV_ROUND_UP(TD size in bytes / wMaxPacketSize)
+ *
+ * Packets transferred up to and including this TRB = packets_transferred =
+ *     rounddown(total bytes transferred including this TRB / wMaxPacketSize)
+ *
+ * TD size = total_packet_count - packets_transferred
+ *
+ * For USBSSP it must fit in bits 21:17, so it can't be bigger than 31.
+ * This is taken care of in the TRB_TD_SIZE() macro
+ *
+ * The last TRB in a TD must have the TD size set to zero.
+ */
+static u32 usbssp_td_remainder(struct usbssp_udc *usbssp_data,
+			       int transferred,
+			       int trb_buff_len,
+			       unsigned int td_total_len,
+			       struct usbssp_request *req_priv,
+			       bool more_trbs_coming)
+{
+	u32 maxp, total_packet_count;
+
+	/* One TRB with a zero-length data packet. */
+	if (!more_trbs_coming || (transferred == 0 && trb_buff_len == 0) ||
+	    trb_buff_len == td_total_len)
+		return 0;
+
+	maxp = usb_endpoint_maxp(req_priv->dep->endpoint.desc);
+	total_packet_count = DIV_ROUND_UP(td_total_len, maxp);
+
+	/* Queuing functions don't count the current TRB into transferred */
+	return (total_packet_count - ((transferred + trb_buff_len) / maxp));
+}
+
+int usbssp_queue_bulk_tx(struct usbssp_udc *usbssp_data,
+			 gfp_t mem_flags,
+			 struct usbssp_request *req_priv,
+			 unsigned int ep_index)
+{
+	/*TODO: function musb be implemented*/
+	return 0;
+}
+
+int usbssp_queue_ctrl_tx(struct usbssp_udc *usbssp_data,
+			 gfp_t mem_flags,
+			 struct usbssp_request *req_priv,
+			 unsigned int ep_index)
+{
+	struct usbssp_ring *ep_ring;
+	int num_trbs;
+	int ret;
+	struct usbssp_generic_trb *start_trb;
+	int start_cycle;
+	u32 field, length_field, remainder;
+	struct usbssp_td *td;
+	struct usbssp_ep *dep = req_priv->dep;
+
+	ep_ring = usbssp_request_to_transfer_ring(usbssp_data, req_priv);
+	if (!ep_ring)
+		return -EINVAL;
+
+	if (usbssp_data->delayed_status) {
+		dev_dbg(usbssp_data->dev, "Queue CTRL: delayed finished\n");
+		usbssp_data->delayed_status = false;
+		usb_gadget_set_state(&usbssp_data->gadget,
+				USB_STATE_CONFIGURED);
+	}
+
+	/* 1 TRB for data, 1 for status */
+	if (usbssp_data->three_stage_setup)
+		num_trbs = 2;
+	else
+		num_trbs = 1;
+
+	ret = prepare_transfer(usbssp_data, &usbssp_data->devs,
+			req_priv->epnum, req_priv->request.stream_id,
+			num_trbs, req_priv, 0, mem_flags);
+
+	if (ret < 0)
+		return ret;
+
+	td = &req_priv->td[0];
+
+	/*
+	 * Don't give the first TRB to the hardware (by toggling the cycle bit)
+	 * until we've finished creating all the other TRBs. The ring's cycle
+	 * state may change as we enqueue the other TRBs, so save it too.
+	 */
+	start_trb = &ep_ring->enqueue->generic;
+	start_cycle = ep_ring->cycle_state;
+
+	/* If there's data, queue data TRBs */
+	/* Only set interrupt on short packet for OUT endpoints */
+
+	if (usbssp_data->ep0_expect_in)
+		field = TRB_TYPE(TRB_DATA) | TRB_IOC;
+	else
+		field = TRB_ISP | TRB_TYPE(TRB_DATA) | TRB_IOC;
+
+	if (req_priv->request.length > 0) {
+		remainder = usbssp_td_remainder(usbssp_data, 0,
+						req_priv->request.length,
+						req_priv->request.length,
+						req_priv, 1);
+
+		length_field = TRB_LEN(req_priv->request.length) |
+			TRB_TD_SIZE(remainder) |
+			TRB_INTR_TARGET(0);
+
+		if (usbssp_data->ep0_expect_in)
+			field |= TRB_DIR_IN;
+
+		queue_trb(usbssp_data, ep_ring, true,
+			lower_32_bits(req_priv->request.dma),
+			upper_32_bits(req_priv->request.dma),
+			length_field,
+			field | ep_ring->cycle_state |
+			TRB_SETUPID(usbssp_data->setupId) |
+			usbssp_data->setup_speed);
+		usbssp_data->ep0state = USBSSP_EP0_DATA_PHASE;
+	}
+
+	/* Save the DMA address of the last TRB in the TD */
+	td->last_trb = ep_ring->enqueue;
+
+	/* Queue status TRB*/
+
+	if (req_priv->request.length > 0 && usbssp_data->ep0_expect_in)
+		field = TRB_DIR_IN;
+	else
+		field = 0;
+
+	if (req_priv->request.length == 0)
+		field |= ep_ring->cycle_state;
+	else
+		field |= (ep_ring->cycle_state ^ 1);
+
+	if (dep->ep_state & EP0_HALTED_STATUS) {
+		/*
+		 * If endpoint should be halted in Status Stage then
+		 * driver shall set TRB_SETUPSTAT_STALL bit
+		 */
+		dev_dbg(usbssp_data->dev,
+			"Status Stage phase prepared with STALL bit\n");
+		dep->ep_state &= ~EP0_HALTED_STATUS;
+		field |= TRB_SETUPSTAT(TRB_SETUPSTAT_STALL);
+	} else {
+		field |= TRB_SETUPSTAT(TRB_SETUPSTAT_ACK);
+	}
+
+	queue_trb(usbssp_data, ep_ring, false,
+		0,
+		0,
+		TRB_INTR_TARGET(0),
+		/* Event on completion */
+		field | TRB_IOC | TRB_SETUPID(usbssp_data->setupId) |
+		TRB_TYPE(TRB_STATUS) | usbssp_data->setup_speed);
+
+	usbssp_ring_ep_doorbell(usbssp_data, ep_index,
+				req_priv->request.stream_id);
+	return 0;
+}
+
 /* Stop endpoint after disconnecting device.*/
 int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 		       struct usbssp_ep *ep_priv)
@@ -1555,6 +1818,15 @@ int usbssp_cmd_stop_ep(struct usbssp_udc *usbssp_data, struct usb_gadget *g,
 	return ret;
 }
 
+int usbssp_queue_isoc_tx_prepare(struct usbssp_udc *usbssp_data,
+				 gfp_t mem_flags,
+				 struct usbssp_request *req_priv,
+				 unsigned int ep_index)
+{
+	/*TODO: function must be implemented*/
+	return 0;
+}
+
 /****		Command Ring Operations		****/
 /*
  * Generic function for queueing a command TRB on the command ring.
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 2fd6d27ef0bd..e2751693404d 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -401,8 +401,119 @@ static int usbssp_check_args(struct usbssp_udc *usbssp_data,
 
 int usbssp_enqueue(struct usbssp_ep *dep, struct usbssp_request *req_priv)
 {
-	/*TODO: this function must be implemented*/
-	return 0;
+	int ret = 0;
+	unsigned int ep_index;
+	unsigned int ep_state;
+	const struct usb_endpoint_descriptor *desc;
+	struct usbssp_udc *usbssp_data = dep->usbssp_data;
+	int num_tds;
+
+	if (usbssp_check_args(usbssp_data, dep, true, true, __func__) <= 0)
+		return -EINVAL;
+
+	if (!dep->endpoint.desc) {
+		dev_err(usbssp_data->dev, "%s: can't queue to disabled endpoint\n",
+			dep->name);
+		return -ESHUTDOWN;
+	}
+
+	if (WARN(req_priv->dep != dep, "request %p belongs to '%s'\n",
+	    &req_priv->request, req_priv->dep->name)) {
+		dev_err(usbssp_data->dev, "%s: reequest %p belongs to '%s'\n",
+			dep->name, &req_priv->request, req_priv->dep->name);
+		return -EINVAL;
+	}
+
+	if (!list_empty(&dep->pending_list) && req_priv->epnum == 0) {
+		dev_warn(usbssp_data->dev,
+			"Ep0 has incomplete previous transfer'\n");
+		return -EBUSY;
+	}
+
+	//pm_runtime_get(usbssp_data->dev);
+	req_priv->request.actual = 0;
+	req_priv->request.status = -EINPROGRESS;
+	req_priv->direction = dep->direction;
+	req_priv->epnum = dep->number;
+
+	desc = req_priv->dep->endpoint.desc;
+	ep_index = usbssp_get_endpoint_index(desc);
+	ep_state = usbssp_data->devs.eps[ep_index].ep_state;
+	req_priv->sg = req_priv->request.sg;
+
+	req_priv->num_pending_sgs = req_priv->request.num_mapped_sgs;
+	dev_info(usbssp_data->dev, "SG list addr: %p with %d elements.\n",
+		req_priv->sg, req_priv->num_pending_sgs);
+
+	list_add_tail(&req_priv->list, &dep->pending_list);
+
+	if (req_priv->num_pending_sgs > 0)
+		num_tds = req_priv->num_pending_sgs;
+	else
+		num_tds = 1;
+
+	if (req_priv->request.zero && req_priv->request.length &&
+	   (req_priv->request.length & (dep->endpoint.maxpacket == 0))) {
+		num_tds++;
+	}
+
+	ret = usb_gadget_map_request_by_dev(usbssp_data->dev,
+					&req_priv->request,
+					dep->direction);
+
+	if (ret) {
+		dev_err(usbssp_data->dev, "Can't map request to DMA\n");
+		goto req_del;
+	}
+
+	/*allocating memory for transfer descriptors*/
+	req_priv->td = kzalloc(num_tds * sizeof(struct usbssp_td), GFP_ATOMIC);
+
+	if (!req_priv->td) {
+		ret = -ENOMEM;
+		goto free_priv;
+	}
+
+	if (ep_state & (EP_GETTING_STREAMS | EP_GETTING_NO_STREAMS)) {
+		dev_warn(usbssp_data->dev, "WARN: Can't enqueue USB Request, "
+			"ep in streams transition state %x\n",
+			ep_state);
+		ret = -EINVAL;
+		goto free_priv;
+	}
+
+	req_priv->num_tds = num_tds;
+	req_priv->num_tds_done = 0;
+	trace_usbssp_request_enqueue(&req_priv->request);
+
+	switch (usb_endpoint_type(desc)) {
+	case USB_ENDPOINT_XFER_CONTROL:
+		ret = usbssp_queue_ctrl_tx(usbssp_data, GFP_ATOMIC, req_priv,
+					ep_index);
+		break;
+	case USB_ENDPOINT_XFER_BULK:
+		ret = usbssp_queue_bulk_tx(usbssp_data, GFP_ATOMIC, req_priv,
+					ep_index);
+		break;
+	case USB_ENDPOINT_XFER_INT:
+		ret = usbssp_queue_intr_tx(usbssp_data, GFP_ATOMIC, req_priv,
+					ep_index);
+		break;
+	case USB_ENDPOINT_XFER_ISOC:
+		ret = usbssp_queue_isoc_tx_prepare(usbssp_data, GFP_ATOMIC,
+						req_priv, ep_index);
+	}
+
+	if (ret < 0) {
+free_priv:
+		usb_gadget_unmap_request_by_dev(usbssp_data->dev,
+					&req_priv->request, dep->direction);
+		usbssp_request_free_priv(req_priv);
+
+req_del:
+		list_del(&req_priv->list);
+	}
+	return ret;
 }
 
 /*
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index d582c9dbe6b4..0477eb0f354c 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1752,6 +1752,20 @@ int usbssp_queue_address_device(struct usbssp_udc *usbssp_data,
 int usbssp_queue_stop_endpoint(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd,
 			unsigned int ep_index, int suspend);
+int usbssp_queue_ctrl_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+			 struct usbssp_request *req_priv,
+			 unsigned int ep_index);
+
+int usbssp_queue_bulk_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+			struct usbssp_request *req_priv,
+			unsigned int ep_index);
+int usbssp_queue_intr_tx(struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+			struct usbssp_request *req_priv,
+			unsigned int ep_index);
+int usbssp_queue_isoc_tx_prepare(
+			struct usbssp_udc *usbssp_data, gfp_t mem_flags,
+			struct usbssp_request *req_priv,
+			unsigned int ep_index);
 int usbssp_queue_reset_ep(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd,
 			unsigned int ep_index,
@@ -1784,6 +1798,10 @@ struct usbssp_slot_ctx *usbssp_get_slot_ctx(struct usbssp_udc *usbssp_data,
 struct usbssp_ep_ctx *usbssp_get_ep_ctx(struct usbssp_udc *usbssp_data,
 					struct usbssp_container_ctx *ctx,
 					unsigned int ep_index);
+struct usbssp_ring *usbssp_triad_to_transfer_ring(
+						struct usbssp_udc *usbssp_data,
+						unsigned int ep_index,
+						unsigned int stream_id);
 /* USBSSP gadget interface*/
 void usbssp_suspend_gadget(struct usbssp_udc *usbssp_data);
 void usbssp_resume_gadget(struct usbssp_udc *usbssp_data);
@@ -1807,6 +1825,17 @@ int usbssp_setup_analyze(struct usbssp_udc *usbssp_data);
 int usbssp_status_stage(struct usbssp_udc *usbssp_data);
 
 int usbssp_reset_device(struct usbssp_udc *usbssp_data);
+
+static inline struct usbssp_ring *usbssp_request_to_transfer_ring(
+					struct usbssp_udc *usbssp_data,
+					struct usbssp_request *req_priv)
+{
+	return usbssp_triad_to_transfer_ring(usbssp_data,
+			usbssp_get_endpoint_index(req_priv->dep->endpoint.desc),
+			req_priv->request.stream_id);
+}
+
+
 static inline char *usbssp_slot_state_string(u32 state)
 {
 	switch (state) {
-- 
2.17.1

