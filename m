Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD7FC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9B20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 17:59:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="AYrwnlYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC9B20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387998AbeGSSoH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:44:07 -0400
Received: from mail-eopbgr730070.outbound.protection.outlook.com ([40.107.73.70]:35633
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732159AbeGSSoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gxAy70DoK/dmdZgoynut9MlY92jXnpgyWWl/u53hhXU=;
 b=AYrwnlYtFO4SKqIacC++vvDgc8t3YJJC5PQHR9WG4dW+dspA9fRfY2eFjQSASk1Tp402bcdhqFG4kE/uNsU5YHPgxPwqrJ7qKRwT/jC1OyeYNO6jJxfRyajWO9cjf6kuENgzMxXOWXwvgzKBeubHPeHq4I0ULTEkPV0F3vMDUA0=
Received: from BYAPR07CA0047.namprd07.prod.outlook.com (2603:10b6:a03:60::24)
 by BN3PR0701MB1330.namprd07.prod.outlook.com (2a01:111:e400:4019::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.20; Thu, 19 Jul
 2018 17:59:26 +0000
Received: from BY2NAM05FT012.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::202) by BYAPR07CA0047.outlook.office365.com
 (2603:10b6:a03:60::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:26 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 BY2NAM05FT012.mail.protection.outlook.com (10.152.100.149) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.995.0 via
 Frontend Transport; Thu, 19 Jul 2018 17:59:25 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxNgC025447
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:25 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:30 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:30 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxF8Y005974;
        Thu, 19 Jul 2018 18:59:15 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxFc6005972;
        Thu, 19 Jul 2018 18:59:15 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 22/31] usb: usbssp: added procedure removing request from transfer ring
Date:   Thu, 19 Jul 2018 18:57:55 +0100
Message-ID: <1532023084-28083-23-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(396003)(376002)(346002)(39860400002)(2980300002)(36092001)(199004)(189003)(36756003)(87636003)(50226002)(478600001)(486006)(50466002)(76176011)(4326008)(8936002)(42186006)(16586007)(316002)(26826003)(86362001)(5660300001)(575784001)(26005)(14444005)(426003)(48376002)(107886003)(1671002)(109986005)(186003)(246002)(8676002)(2616005)(51416003)(336012)(305945005)(476003)(7636002)(126002)(356003)(6666003)(11346002)(446003)(4720700003)(106466001)(105596002)(2906002)(54906003)(47776003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1330;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT012;1:4ES0x6PQhhFMkoC+VclkjcrssFeaeyP6GkuPLVhQFiLvisIVH/jg7uKIsyag/DE1U7ACNbfVxIWI4WMOiVe7t3CUxO16Qefe0dL+epnnhgRNswmnO/8Z/LXovnxxGraw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b76e34c2-089c-45eb-6147-08d5eda15db7
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN3PR0701MB1330;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;3:3YAJIAk+l9yEpsGo7Y5fpiFlLy7NaCkYToWSSf3gDUfYKO/VYqe1XoSkEmHUu9qhC7/38IPvTZPlOFYJSH9LFlQkauzycRvSX+ZcPjwfWHaG8Io1GzJACgcmF0IT//aXifS98ZOwQorktJ8wrRDFo+IvQ//GXeqMGtaxg+3yRY+hWWdC6365v0iXkNTaxoT5uQVtFPBqBq3BWCKaQHbFv5O+GlUv1LjsV/yqXKAY67wx7NL7OhGYDU9CaQcSekvuRDtbU27j7fP2Lw31S/9rGFzTJrS8r8MVMcjUnm8feT6hPvSrKqXuL2fGS3+Ij7DplRiBFIAEUw/kMZUb0oFyP9sDBeJ80/RvZwui/hnQMmY=;25:oYJ1BedQU+70altbdScwTIl++MpEZfwU20tdJs+Xmi2JAIjmiMLHlaSY8ybrrJ/ZfpvmGr2Uf8vk6N6v5QvY5rajvW/R38iT8ZZnnQdsEdgYnXOLbctF8cPsRB1dre2gfi8vbHzjEqXBXoCIynyxw/st8Y43d+sN4hNjl+lo0+XpPT4+PLq1qeRxqneS9P70Fpev4AB26Y2NpKly++FY7lfDEeTeid4peSLoAkSNUkwI0U4TefLRh+NxgXlHvUiswIfvilUGUC8SUQhw2CbR3xgmICV6nm8UP70RMgVLkmjXFPaJm/6kKOgeGjowKF1EVpZBkXVnW9NZBqnfS5N74g==
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1330:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;31:Aa/JzFI3nVrAlHLUGJnVRttMMJn/rkqpXw5rUyozf7QxzHOySw8e7k5QKF2er+W2U0ETgmAN03QPgG4/JnmxVLJXTz1p9+bR8NPCWef1fzwSFb9HdsozO6DTOQegPLfUpztcwvuHcoFIs54gfiR0g13f0bdvgWQQpWYNfKtwibQc6qZQMmFgmbX+eW7POI9tqYjYu/0RUyASNCUo39idYhhq8DGygG6UFHVAYvKJqyM=;20:x+Ebb6KtoJccVJGN6nniExzm5RVfGRTWZpJsIMw2gQ1kukohYYFFK1Ypg2SnyjTxnAZQddMslwtqQ5jshwCtxhYLWqbuIC5yPQr5lWsqZ+vOGR15h4C0UsVEA8PdvNLiktae+4AYqEcBBuScVtpjBDLnHDRhBBpoAuwvUMWYFHsIR1z8WTz3hHnKyEsZDnaf7yCDPUHcBENS/rJXLEbAvLquhHIpj3TXca00aZ7RVQOi+/23DwNWG/aCQag8qqODhgpzmxN4fVzn8WkTZYwrcUHNR2iLi/N3ZBT2o2CH3UGX+HL7BCh9zQw26O5mTN9CR+q8vxe+O6e+ndnlcKoRDJfnn/FxA6m703gEpzjl0pbhsJTB+M7P8iFz09uhAcaRCO6dflfNpq1PPj9A3BLwdg1QmZ3l0DFlJH0IDUTPPAtUqEsa9CIxnSqNjaINxL+JxWbeZP6wlRDbbxwkeDaxiJddctth0YAZXSIikpNUoNVjkw6xs83pCexcBTUxVkO4
X-Microsoft-Antispam-PRVS: <BN3PR0701MB13307D91BC49B20A7B120ABEDD520@BN3PR0701MB1330.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN3PR0701MB1330;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1330;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;4:TbtT29fUm4d3VF+ttUrEDi7nDZMXeyLSU5AD4FXeFMbgvZyEynx8SM7/xjR6AslNJ8aaktFma3LHFwsTyXr036wdkVVfiH3tgkZzgEOdJfIpspszudXHHQK4mxrvi4FpgqL3aWpAWqis/lYk3BkAMSfW6u5OWMeiN3Y6DsqM2oVb24t+ZjYj0EjEVIPWl6+QOJ4ZtsQ7BdrFfxx25kLzfoGJ3t9Tw6G+2wJsq9Rhxr6DabsJtK7WdF09SuPYXKlxZ+uFMKtjaKJ7XzHnJVkW1+Ao5H0Rde2OmkbSmnfGKfKzlIYI+tsz0CYSKz357qjR
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1330;23:FbTdDlyRimTFQ+QdKNtItY8667+l/LcbeKPGFWh?=
 =?us-ascii?Q?jnSqltRSaPeIMLg6kaK9MME8DeyQX3XGj/spXluLq3BV3agT0qzTwM4gS3cL?=
 =?us-ascii?Q?8ogqSlVc1SHgXQo+VfsKWTQsRwT6/yJKNUmS8RG09dBBXgm4aj6EIOTfq4lJ?=
 =?us-ascii?Q?+O4O44GFkgYwax2PyDUmcULt88mvtnL8Qaiptxis+1Pri0xo20ciViRZXoph?=
 =?us-ascii?Q?8Yy2Lo14TXb6l8YlVjEc2N6oCOpT5uh+uRZpRGXF7+eeYYu3bpKribAxB+t5?=
 =?us-ascii?Q?zMDuL/SJbCHdySwWmrnO2FJ+Ma5qZM/n3UoEryYgLT1J40cUkvcTGN7+dD5B?=
 =?us-ascii?Q?7bAgOju5GZwd/07g58XG93zvR5edDKTgYEvb1RgwWR7n2ETGHJOshpq16oDe?=
 =?us-ascii?Q?kUrY32KIxzgq+6OBoC6BVAN9yLa0FF8rt3N56A+Ilz9Hh5AkFI+o9v3Swk49?=
 =?us-ascii?Q?npNspVKpzv0H6X8MIAlDGgNsiDdSzYvnBlUSp5AvhSL1pVcskzOywihz7i9n?=
 =?us-ascii?Q?rPJc71iJCHnxdCVdMY5S3ANiLaQBEOnihjbYsheeTqNm34X8fuVJam+Om9Sr?=
 =?us-ascii?Q?RYEC7+Ji+frWqbx4cCRrUv6dqi3FvdIhAU0MJv4IvXKCLkQ2gd72MrIASe7F?=
 =?us-ascii?Q?pabTjkS/Sos4DaUmqbxeK2K2CHFhHSv4FL5jXXHI0EbPaJGJLFdjE3cCijjw?=
 =?us-ascii?Q?WkBO3JqLEcd0aW16acoZZNdmLg5NkrIFnKw7tKNuIqo6ENjBXjMFWiTnjYfv?=
 =?us-ascii?Q?24mrS1MJKPBR9ZnhG0R7eQ4NykKL597PihSKNSXihF5hEoIbe2sg/+c/2A8O?=
 =?us-ascii?Q?LADzXo5PNe+l34mN5VB1bq07lmwaJ4uLIdaJLQoxsXJxwWuIUPkq41LLEdxn?=
 =?us-ascii?Q?WxXG4r5N8+U5L+9GFUkmhYBCeBf2bgdWnRhYpqg6xDLUq+8H3lofxJPAQOk7?=
 =?us-ascii?Q?hre/Kz7avuF0eciw/4i8YYxMMnzVgnYL9QMxwDLK2rD7oJlGxcGJTG/Qv0I4?=
 =?us-ascii?Q?2h9scoTpxKvi5vzUfuqzXQToKrEXd3w3TH0p5CEjyFYCfbSa4T/JSdaoKrs6?=
 =?us-ascii?Q?72BAYli6JvrNEHvnHimGiYufADlwBz02UGLNEZU8F3IpW0q7sSU0ry6j5GsD?=
 =?us-ascii?Q?zORLSLJdn9Rap/ywwslJXKEW6pbPPCxA/XNQ1hfJAgHYIyaEx7IEkW0BF/hK?=
 =?us-ascii?Q?lcEx6cYEPTzavEgU=3D?=
X-Microsoft-Antispam-Message-Info: xudAfGchp+muwvwfEPDhDaW8sB2cUBfohmqz8Ofi8PTmzLv0hqGCurzagLZNZSWj8DJq7UKpQ4+U3zdXe8baNB9jEdH1wVOQocOF6eltpjExO2qjF0k5iEVCtmRjrBwtfLJsuUCRV7b3iMfMPdCTL4QEIk0DICPFUOsllKnEzJLPj2RiKKbrQS4o4iqhkD6xpRVS1m9hnbLi0TJliuKspug7kVNO4BHhNyM0ZlcW8PHRE0C5MJ7BU9t11G5j8uVoP//mbazv00ofbkLBWYT5O9eXfBJpvzUq+wD/R/eb3H0Hb+d20Fraj+3WEznqe7dGtafnn/hFIcwMfOS/HZ68s0QVnl5WeWtON6zASMAfbuLaKxdHP0z3G7INDG/ZE3kb06CeMKZRYfbw/vesm8eT2A==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;6:5hCxjRkTK4ubAX+Cqxbsc2MRCVuDVSkci2YrnFpUss2N+wYJ1QZkT9kDzn5COKaQ4NV1YUJ864y525+U5PrXz02dGTu/ztmgIPqt5merF26giLFZRAYLApHASwBTCdFHEPreRSxTeByrApaUONDN45t1WO7wmtbncNg0GT2FAW89AeYTJ9WaUYdJOQSRk4K9SY9L1Gdcrbrruwci752cSpGJVjFhws5BXhwitHi+mnmDkPRcXinZKNQowPOE2XW4c0gheqZ8LbnCPQbVuqezXPKceBoeiIo7TpQDRdgq/TvVNasjQ102aXQZj8uHZDg6mYqUrqLMSWyu/FKCdPz82vQIRcHIQfLgH1qyBtvZcgEJRHTj9A9Vjvdn8X3Xma6V+AnEKk2OoFN2tYRYHRtHsA91aenNPeGnD3hk29IrfzNSjpWpRK218v6P4pr7lOn95/qA+BBiJFDnhbOQQLX9dA==;5:Cmd/LvIJu4kx9fjlTZDb6ixQXflEvqgLOTrUFGtQs8jopOk4GAyZ9vZfC0t24LeiIglYxHAorO61azUcBGIp7PNJP6KYq2ecJGgnvdYwAHAP8T5QWPG24TAcLjEgce3iZaUq5xgVkQ4asCkNKoIqa+llzJ5W+2Pq30RUPACCqJE=;7:KYxH40eNLt7ddbVQo7CKzmX1XguYVLYDYYExV3gCyZx6KO9FHthYFTm9zJGjvim7ijlpgubBkJoQn783m9Hcrt3ckkAwif8c1rVf9X6Q0jGiL69Z37gztvBBBtCR0SY6hAnX2bHwHmo2jHhBEgLeh98aRrIDhSEACBNyn+S96QnUeDvzs3lfbaSjaYuxL9IBkO05qOVksoAigkPFwVRsp8aYDone9Reep+qsrUyu2XTh2fiYZcf7T5My6PDeuoTF
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1330;20:QbylnoHo2lTaYjMmk7rLYa4asWiUecFQxvPk8lF+K5F+1W4qvhGzoZSX2n1zWO9GnoBvf3VEbdgot0K4nhJSj3BAxn1ukxtcgAvNRd9/mC9iwYQx3+1aq/XCQuh12PVXSjdQq0M69uZR2oSgZfProFy1sKfYg09JxISezV1if09hexDPaz3kztZVj0AVc4WNPBb3huaXyf7b22ve32ZjtZmAPR+d5iXqvMMGrqDdF8swy/4AgfpR9gX1n19g1mgx
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:25.9984
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b76e34c2-089c-45eb-6147-08d5eda15db7
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1330
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds functionality that allows to remove the request from the
endpoint ring. This may cause the DC to stop USB transfers,
potentially stopping in the middle of a TRB buffer. The DC should
pick up where it left off in the TD, unless a Set Transfer Ring
Dequeue Pointer is issued.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 331 ++++++++++++++++++++++++++++++-
 drivers/usb/usbssp/gadget.c      |  49 ++++-
 drivers/usb/usbssp/gadget.h      |  11 +
 3 files changed, 387 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 4bb13f9e311a..cfb31120eef8 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -102,11 +102,51 @@ static bool link_trb_toggles_cycle(union usbssp_trb *trb)
 	return le32_to_cpu(trb->link.control) & LINK_TOGGLE;
 }
 
+static bool last_td_in_request(struct usbssp_td *td)
+{
+	struct usbssp_request *req_priv = td->priv_request;
+
+	return req_priv->num_tds_done == req_priv->num_tds;
+}
+
 static void inc_td_cnt(struct usbssp_request *priv_req)
 {
 	priv_req->num_tds_done++;
 }
 
+static void trb_to_noop(union usbssp_trb *trb, u32 noop_type)
+{
+	if (trb_is_link(trb)) {
+		/* unchain chained link TRBs */
+		trb->link.control &= cpu_to_le32(~TRB_CHAIN);
+	} else {
+		trb->generic.field[0] = 0;
+		trb->generic.field[1] = 0;
+		trb->generic.field[2] = 0;
+		/* Preserve only the cycle bit of this TRB */
+		trb->generic.field[3] &= cpu_to_le32(TRB_CYCLE);
+		trb->generic.field[3] |= cpu_to_le32(TRB_TYPE(noop_type));
+	}
+}
+
+/*
+ * Updates trb to point to the next TRB in the ring, and updates seg if the next
+ * TRB is in a new segment. This does not skip over link TRBs, and it does not
+ * effect the ring dequeue or enqueue pointers.
+ */
+static void next_trb(struct usbssp_udc *usbssp_data,
+		     struct usbssp_ring *ring,
+		     struct usbssp_segment **seg,
+		     union usbssp_trb **trb)
+{
+	if (trb_is_link(*trb)) {
+		*seg = (*seg)->next;
+		*trb = ((*seg)->trbs);
+	} else {
+		(*trb)++;
+	}
+}
+
 /*
  * See Cycle bit rules. SW is the consumer for the event ring only.
  * Don't make a ring full of link TRBs. That would be dumb and this would loop.
@@ -347,6 +387,157 @@ struct usbssp_ring *usbssp_triad_to_transfer_ring(struct usbssp_udc *usbssp_data
 	return NULL;
 }
 
+/*
+ * Get the hw dequeue pointer DC stopped on, either directly from the
+ * endpoint context, or if streams are in use from the stream context.
+ * The returned hw_dequeue contains the lowest four bits with cycle state
+ * and possbile stream context type.
+ */
+u64 usbssp_get_hw_deq(struct usbssp_udc *usbssp_data,
+		      struct usbssp_device *dev,
+		      unsigned int ep_index,
+		      unsigned int stream_id)
+{
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_stream_ctx *st_ctx;
+	struct usbssp_ep *ep;
+
+	ep = &dev->eps[ep_index];
+
+	if (ep->ep_state & EP_HAS_STREAMS) {
+		st_ctx = &ep->stream_info->stream_ctx_array[stream_id];
+		return le64_to_cpu(st_ctx->stream_ring);
+	}
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, dev->out_ctx, ep_index);
+	return le64_to_cpu(ep_ctx->deq);
+}
+
+/*
+ * Move the DC endpoint ring dequeue pointer past cur_td.
+ * Record the new state of the DC endpoint ring dequeue segment,
+ * dequeue pointer, and new consumer cycle state in state.
+ * Update our internal representation of the ring's dequeue pointer.
+ *
+ * We do this in three jumps:
+ *  - First we update our new ring state to be the same as when the DC stopped.
+ *  - Then we traverse the ring to find the segment that contains
+ *    the last TRB in the TD. We toggle the DC new cycle state when we pass
+ *    any link TRBs with the toggle cycle bit set.
+ *  - Finally we move the dequeue state one TRB further, toggling the cycle bit
+ *    if we've moved it past a link TRB with the toggle cycle bit set.
+ */
+void usbssp_find_new_dequeue_state(struct usbssp_udc *usbssp_data,
+				   unsigned int ep_index,
+				   unsigned int stream_id,
+				   struct usbssp_td *cur_td,
+				   struct usbssp_dequeue_state *state)
+{
+	struct usbssp_device *dev_priv = &usbssp_data->devs;
+	struct usbssp_ep *ep_priv = &dev_priv->eps[ep_index];
+	struct usbssp_ring *ep_ring;
+	struct usbssp_segment *new_seg;
+	union usbssp_trb *new_deq;
+	dma_addr_t addr;
+	u64 hw_dequeue;
+	bool cycle_found = false;
+	bool td_last_trb_found = false;
+
+	ep_ring = usbssp_triad_to_transfer_ring(usbssp_data,
+						ep_index, stream_id);
+	if (!ep_ring) {
+		dev_warn(usbssp_data->dev, "WARN can't find new dequeue state "
+			"for invalid stream ID %u.\n",
+			stream_id);
+		return;
+	}
+
+	/* Dig out the cycle state saved by the DC during the stop ep cmd */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"Finding endpoint context");
+
+	hw_dequeue = usbssp_get_hw_deq(usbssp_data, dev_priv,
+				ep_index, stream_id);
+	new_seg = ep_ring->deq_seg;
+	new_deq = ep_ring->dequeue;
+	state->new_cycle_state = hw_dequeue & 0x1;
+	state->stream_id = stream_id;
+
+	/*
+	 * We want to find the pointer, segment and cycle state of the new trb
+	 * (the one after current TD's last_trb). We know the cycle state at
+	 * hw_dequeue, so walk the ring until both hw_dequeue and last_trb are
+	 * found.
+	 */
+	do {
+		if (!cycle_found && usbssp_trb_virt_to_dma(new_seg, new_deq)
+		    == (dma_addr_t)(hw_dequeue & ~0xf)) {
+			cycle_found = true;
+			if (td_last_trb_found)
+				break;
+		}
+
+		if (new_deq == cur_td->last_trb)
+			td_last_trb_found = true;
+
+		if (cycle_found && trb_is_link(new_deq) &&
+			link_trb_toggles_cycle(new_deq))
+			state->new_cycle_state ^= 0x1;
+
+		next_trb(usbssp_data, ep_ring, &new_seg, &new_deq);
+
+		/* Search wrapped around, bail out */
+		if (new_deq == ep_priv->ring->dequeue) {
+			dev_err(usbssp_data->dev,
+				"Error: Failed finding new dequeue state\n");
+			state->new_deq_seg = NULL;
+			state->new_deq_ptr = NULL;
+			return;
+		}
+
+	} while (!cycle_found || !td_last_trb_found);
+
+	state->new_deq_seg = new_seg;
+	state->new_deq_ptr = new_deq;
+
+	/* Don't update the ring cycle state for the producer (us). */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"Cycle state = 0x%x", state->new_cycle_state);
+
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"New dequeue segment = %p (virtual)",
+			state->new_deq_seg);
+	addr = usbssp_trb_virt_to_dma(state->new_deq_seg, state->new_deq_ptr);
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"New dequeue pointer = 0x%llx (DMA)",
+			(unsigned long long) addr);
+}
+
+/*
+ * flip_cycle means flip the cycle bit of all but the first and last TRB.
+ * (The last TRB actually points to the ring enqueue pointer, which is not part
+ * of this TD.) This is used to remove partially enqueued isoc TDs from a ring.
+ */
+static void td_to_noop(struct usbssp_udc *usbssp_data,
+		       struct usbssp_ring *ep_ring,
+		       struct usbssp_td *td, bool flip_cycle)
+{
+	struct usbssp_segment *seg = td->start_seg;
+	union usbssp_trb *trb = td->first_trb;
+
+	while (1) {
+		trb_to_noop(trb, TRB_TR_NOOP);
+
+		/* flip cycle if asked to */
+		if (flip_cycle && trb != td->first_trb && trb != td->last_trb)
+			trb->generic.field[3] ^= cpu_to_le32(TRB_CYCLE);
+
+		if (trb == td->last_trb)
+			break;
+
+		next_trb(usbssp_data, ep_ring, &seg, &trb);
+	}
+}
+
 /* Must be called with usbssp_data->lock held in interrupt context
  * or usbssp_data->irq_thread_lock from thread conext (defered interrupt)
  */
@@ -365,6 +556,139 @@ void usbssp_giveback_request_in_irq(struct usbssp_udc *usbssp_data,
 	usbssp_gadget_giveback(req_priv->dep, req_priv, status);
 }
 
+void usbssp_unmap_td_bounce_buffer(struct usbssp_udc *usbssp_data,
+				   struct usbssp_ring *ring,
+				   struct usbssp_td *td)
+{
+	/*TODO: ??? */
+}
+
+void usbssp_remove_request(struct usbssp_udc *usbssp_data,
+			   struct usbssp_request *req_priv, int ep_index)
+{
+	int i = 0;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_ep *ep;
+	struct usbssp_td *cur_td = NULL;
+	struct usbssp_ep_ctx *ep_ctx;
+	struct usbssp_device *priv_dev;
+	u64 hw_deq;
+	struct usbssp_dequeue_state deq_state;
+
+	memset(&deq_state, 0, sizeof(deq_state));
+	ep = &usbssp_data->devs.eps[ep_index];
+
+	priv_dev = &usbssp_data->devs;
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->out_ctx, ep_index);
+	trace_usbssp_remove_request(ep_ctx);
+
+	i = req_priv->num_tds_done;
+
+	for (; i < req_priv->num_tds; i++) {
+		cur_td = &req_priv->td[i];
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"Removing canceled TD starting at 0x%llx (dma).",
+			(unsigned long long)usbssp_trb_virt_to_dma(
+							cur_td->start_seg,
+							cur_td->first_trb));
+
+		ep_ring = usbssp_request_to_transfer_ring(usbssp_data,
+							cur_td->priv_request);
+
+		if (!ep_ring) {
+			/*
+			 * This shouldn't happen unless a driver is mucking
+			 * with the stream ID after submission. This will
+			 * leave the TD on the hardware ring, and the hardware
+			 * will try to execute it, and may access a buffer
+			 * that has already been freed. In the best case, the
+			 * hardware will execute it, and the event handler will
+			 * ignore the completion event for that TD, since it was
+			 * removed from the td_list for that endpoint. In
+			 * short, don't muck with the stream ID after
+			 * submission.
+			 */
+			dev_warn(usbssp_data->dev, "WARN Cancelled USB Request %p"
+				" has invalid stream ID %u.\n",
+				cur_td->priv_request,
+				cur_td->priv_request->request.stream_id);
+			goto remove_finished_td;
+		}
+
+		if (!(ep->ep_state & USBSSP_EP_ENABLED) ||
+		   ep->ep_state & USBSSP_EP_DISABLE_PENDING) {
+			goto remove_finished_td;
+		}
+
+		/*
+		 * If we stopped on the TD we need to cancel, then we have to
+		 * move the DC endpoint ring dequeue pointer past this TD.
+		 */
+		hw_deq = usbssp_get_hw_deq(usbssp_data, priv_dev, ep_index,
+					cur_td->priv_request->request.stream_id);
+		hw_deq &= ~0xf;
+
+		if (usbssp_trb_in_td(usbssp_data, cur_td->start_seg,
+			cur_td->first_trb, cur_td->last_trb, hw_deq, false)) {
+			usbssp_find_new_dequeue_state(usbssp_data, ep_index,
+						cur_td->priv_request->request.stream_id,
+						cur_td, &deq_state);
+		} else {
+			td_to_noop(usbssp_data, ep_ring, cur_td, false);
+		}
+
+remove_finished_td:
+		/*
+		 * The event handler won't see a completion for this TD anymore,
+		 * so remove it from the endpoint ring's TD list.
+		 */
+		list_del_init(&cur_td->td_list);
+	}
+
+	ep->ep_state &= ~EP_STOP_CMD_PENDING;
+
+	if (!(ep->ep_state & USBSSP_EP_DISABLE_PENDING) &&
+		ep->ep_state & USBSSP_EP_ENABLED) {
+		/* If necessary, queue a Set Transfer Ring Dequeue Pointer command*/
+		if (deq_state.new_deq_ptr && deq_state.new_deq_seg) {
+			usbssp_queue_new_dequeue_state(usbssp_data, ep_index,
+						&deq_state);
+			usbssp_ring_cmd_db(usbssp_data);
+		} else {
+			/*
+			 * Otherwise ring the doorbell(s) to restart queued
+			 * transfers
+			 */
+			ring_doorbell_for_active_rings(usbssp_data, ep_index);
+		}
+	}
+
+	/*
+	 * Complete the cancellation of USB request.
+	 */
+	i = req_priv->num_tds_done;
+	for (; i < req_priv->num_tds; i++) {
+		cur_td = &req_priv->td[i];
+
+		/*
+		 * Clean up the cancelled USB Request
+		 * Doesn't matter what we pass for status, since the core will
+		 * just overwrite it.
+		 */
+		ep_ring = usbssp_request_to_transfer_ring(usbssp_data,
+							cur_td->priv_request);
+
+		usbssp_unmap_td_bounce_buffer(usbssp_data, ep_ring, cur_td);
+
+		inc_td_cnt(cur_td->priv_request);
+		if (last_td_in_request(cur_td)) {
+			usbssp_giveback_request_in_irq(usbssp_data,
+						cur_td, -ECONNRESET);
+		}
+	}
+}
+
+
 /*
  * When we get a command completion for a Stop Endpoint Command, we need to
  * stop timer and clear EP_STOP_CMD_PENDING flag.
@@ -385,7 +709,6 @@ static void usbssp_handle_cmd_stop_ep(struct usbssp_udc *usbssp_data,
 		"CMD stop endpoint completion for ep index: %d - %s\n",
 		ep_index, ep->name);
 
-
 	priv_dev = &usbssp_data->devs;
 	ep_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->out_ctx, ep_index);
 	trace_usbssp_handle_cmd_stop_ep(ep_ctx);
@@ -2273,7 +2596,8 @@ void usbssp_queue_new_dequeue_state(struct usbssp_udc *usbssp_data,
 		(unsigned long long)deq_state->new_deq_seg->dma,
 		deq_state->new_deq_ptr,
 		(unsigned long long)usbssp_trb_virt_to_dma(
-			deq_state->new_deq_seg, deq_state->new_deq_ptr),
+						deq_state->new_deq_seg,
+						deq_state->new_deq_ptr),
 		deq_state->new_cycle_state);
 
 	addr = usbssp_trb_virt_to_dma(deq_state->new_deq_seg,
@@ -2284,6 +2608,7 @@ void usbssp_queue_new_dequeue_state(struct usbssp_udc *usbssp_data,
 			deq_state->new_deq_seg, deq_state->new_deq_ptr);
 		return;
 	}
+
 	ep_priv = &usbssp_data->devs.eps[ep_index];
 	if ((ep_priv->ep_state & SET_DEQ_PENDING)) {
 		dev_warn(usbssp_data->dev, "WARN Cannot submit Set TR Deq Ptr\n");
@@ -2304,10 +2629,12 @@ void usbssp_queue_new_dequeue_state(struct usbssp_udc *usbssp_data,
 	ep_priv->queued_deq_ptr = deq_state->new_deq_ptr;
 	if (deq_state->stream_id)
 		trb_sct = SCT_FOR_TRB(SCT_PRI_TR);
+
 	ret = queue_command(usbssp_data, cmd,
 		lower_32_bits(addr) | trb_sct | deq_state->new_cycle_state,
 		upper_32_bits(addr), trb_stream_id,
 		trb_slot_id | trb_ep_index | type, false);
+
 	if (ret < 0) {
 		usbssp_free_command(usbssp_data, cmd);
 		return;
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index e2751693404d..fe373a7b7198 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -545,8 +545,53 @@ int usbssp_enqueue(struct usbssp_ep *dep, struct usbssp_request *req_priv)
  */
 int usbssp_dequeue(struct usbssp_ep *ep_priv, struct usbssp_request *req_priv)
 {
-	/*TODO: this function must be implemented*/
-	return 0;
+	int ret = 0, i;
+	struct usbssp_udc *usbssp_data;
+	unsigned int ep_index;
+	struct usbssp_ring *ep_ring;
+	struct usbssp_device *priv_dev;
+	struct usbssp_ep_ctx *ep_ctx;
+
+	usbssp_data = ep_priv->usbssp_data;
+	trace_usbssp_request_dequeue(&req_priv->request);
+
+	priv_dev = &usbssp_data->devs;
+	ep_index = usbssp_get_endpoint_index(req_priv->dep->endpoint.desc);
+	ep_priv = &usbssp_data->devs.eps[ep_index];
+	ep_ring = usbssp_request_to_transfer_ring(usbssp_data, req_priv);
+
+	if (!ep_ring)
+		goto err_giveback;
+
+	i = req_priv->num_tds_done;
+
+	if (i < req_priv->num_tds)
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"Cancel request %p, dev %s, ep 0x%x, "
+			"starting at offset 0x%llx",
+			&req_priv->request, usbssp_data->gadget.name,
+			req_priv->dep->endpoint.desc->bEndpointAddress,
+			(unsigned long long) usbssp_trb_virt_to_dma(
+						req_priv->td[i].start_seg,
+						req_priv->td[i].first_trb));
+
+	/* Queue a stop endpoint command, but only if it is
+	 * in EP_STATE_RUNNING state.
+	 */
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->out_ctx, ep_index);
+	if (GET_EP_CTX_STATE(ep_ctx) == EP_STATE_RUNNING) {
+		ret = usbssp_cmd_stop_ep(usbssp_data, &usbssp_data->gadget,
+					ep_priv);
+		if (ret)
+			return ret;
+	}
+
+	usbssp_remove_request(usbssp_data, req_priv, ep_index);
+	return ret;
+
+err_giveback:
+	usbssp_giveback_request_in_irq(usbssp_data, req_priv->td, -ESHUTDOWN);
+	return ret;
 }
 
 int usbssp_halt_endpoint(struct usbssp_udc *usbssp_data, struct usbssp_ep *dep,
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index 0477eb0f354c..000f2cb93723 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1780,6 +1780,14 @@ int usbssp_queue_halt_endpoint(struct usbssp_udc *usbssp_data,
 			unsigned int ep_index);
 int usbssp_queue_reset_device(struct usbssp_udc *usbssp_data,
 			struct usbssp_command *cmd);
+void usbssp_find_new_dequeue_state(struct usbssp_udc *usbssp_data,
+				unsigned int ep_index,
+				unsigned int stream_id,
+				struct usbssp_td *cur_td,
+				struct usbssp_dequeue_state *state);
+void usbssp_queue_new_dequeue_state(struct usbssp_udc *usbssp_data,
+				unsigned int ep_index,
+				struct usbssp_dequeue_state *deq_state);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
@@ -2313,4 +2321,7 @@ __le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data);
 void usbssp_giveback_request_in_irq(struct usbssp_udc *usbssp_data,
 				struct usbssp_td *cur_td, int status);
 
+void usbssp_remove_request(struct usbssp_udc *usbssp_data,
+			struct usbssp_request *req_priv, int ep_index);
+
 #endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

