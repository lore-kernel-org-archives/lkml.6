Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18EF7C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FEA20684
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 18:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="m/+g+W8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FEA20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbeGSSnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 14:43:42 -0400
Received: from mail-by2nam03on0067.outbound.protection.outlook.com ([104.47.42.67]:62854
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731774AbeGSSnl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 14:43:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O4jqzTcmUF0c49hz2SUksp41czJCIiPqreZ+QLNPdoE=;
 b=m/+g+W8EyHHfbFGT7Dvbg7HtxZSZbtu2/vMNXwkW0p3Dg7oYL+NELbEz84DLr6uyZ/PfP9IfNRnLvV74ebgO7o8B6Wqj0ZzbIpT9iW4pmBVyOeJHiTejcFz6fcdPqD96YGMDR9qsraTvYO/SSuirGNDGw7htqzalV0Rii+zxeGQ=
Received: from CY1PR07CA0015.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::25) by DM6PR07MB4715.namprd07.prod.outlook.com
 (2603:10b6:5:a1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Thu, 19 Jul
 2018 17:59:21 +0000
Received: from DM3NAM05FT049.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::206) by CY1PR07CA0015.outlook.office365.com
 (2a01:111:e400:c60a::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Thu, 19 Jul 2018 17:59:21 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT049.mail.protection.outlook.com (10.152.98.163) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.995.0 via Frontend Transport; Thu, 19 Jul 2018 17:59:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxAS5019643
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 19 Jul 2018 10:59:19 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Jul 2018 19:59:28 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 19 Jul 2018 19:59:28 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6JHxD0c005840;
        Thu, 19 Jul 2018 18:59:13 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6JHxDDF005839;
        Thu, 19 Jul 2018 18:59:13 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 15/31] usb: usbssp: added device controller error, transfer and SETUP completion event.
Date:   Thu, 19 Jul 2018 18:57:48 +0100
Message-ID: <1532023084-28083-16-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1532023084-28083-1-git-send-email-pawell@cadence.com>
References: <1532023084-28083-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(136003)(376002)(346002)(2980300002)(36092001)(199004)(189003)(186003)(14444005)(6666003)(50226002)(4720700003)(26005)(51416003)(16586007)(5660300001)(54906003)(316002)(42186006)(336012)(575784001)(86362001)(305945005)(36756003)(7636002)(246002)(26826003)(87636003)(486006)(478600001)(48376002)(4326008)(476003)(126002)(50466002)(2616005)(446003)(47776003)(107886003)(8936002)(76176011)(356003)(109986005)(106466001)(426003)(1671002)(8676002)(11346002)(105596002)(2906002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4715;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT049;1:uLBQE36rDdjaCPL5NmKtH++E56YvhPUtsPehVwXckzvCPLdq1ZKV1i6ZkctvtKXTb1R99FeEZxY7Eq89cCpUlWPTG8bd7LB9iN7CpgZYyLM/inh6E6hz7K/4pI+atxVt
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88f4eca4-12c9-4552-69ae-08d5eda15aba
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600067)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR07MB4715;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;3:yx5yAmCzoRuJLwe6er2m2h/GFPX2P2J+udReqHswUS4+zRcdHqlX/XupLh5/ddcSrXPAWYwGGBxXZ1764KzGNlxZUC55//7OXJ4fq8vhlHaBl/6pRYhqDxMstfoVSOGoA8K66iQggy0JdUK9sMhUqZg0egdTCAFYfG3fjc3flQ2c9jkRyfILmjKL9MSZqHJgDVj+2JevoVhf4I/zWWTI2iEhLcuMMAOptycMtA0+cJEApU3BfPMS7QYS0mBxKMSyuiIjEkncvZ6X2iwBFWA+kz78t6syTD1TSn/JFLW23ifE/DQaebqZbzPYNdEwpAKXwkhQh637lDY/pR8oknHikjYXbzbGDj9oBQSupD0JHww=;25:rnyuDxfj0u37bxZLBelM+ooNIMMDs7hVcv9SEYryUDnf+9ngl86C5b5igrw0OSnFfgeJ3R2wrovz2btVYqjr6pDgqBKNdgSYXLNLp4n4EWJ/TJkNUdJII00ibhD6uE94HiDDa/BhuU7kZhZYEySU1p8eeV2ROpSWVC70Nezjk0xz1ccpdlgEJDGi6ugdTGvFHMFfl01NIQL1BcUxk8vkz470erdLOR5FFVQcO36wU5Zggb5ID+GQAJKLcMgYR1TQ6lLPVmRYw6H8ZFH2pxMQnPTJSHDwRuTWWH4KlMgVk8lVQXwFg/44Txad5U1MLvBaEE/8ykuyRkzSuHjGFY5V4g==
X-MS-TrafficTypeDiagnostic: DM6PR07MB4715:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;31:r1OdXM91KJ+PJoSmZ8j8psO1iH0xi1IgcAbGoPT32RP0GeS/ks2UmxgUVEzR5axk4WLmcpojXdVzevPYsFWmq82B5GY3eEIGHH613i/i464DG306o9Np+PxRJnrUIqeMUkuw0xI15iO8TKNm15o7TM9PbReLOpVJjcrr+QKPY4S+3oGfCYJPI3RqLM81YvULUKi1zW11RyBDKoZ1NL2Z4RCnieINcqGVaByCEjbc5Bo=;20:ZCnHgHJpHRj+TkRyosMCMNHUT3TLDFM4DTzB/vN+rTwTAXmEQihOolx9MXtxIbwEi8M4MZ2ruMb08j4SxWZTLYbePLkUtQKyg2+ZwMeiedohQDV3EqdQJtGQqSQkpcy0RGYYLxIUUUAuM//naO4hNMp4QjZPqxXdTmqNO+w8RGl9Cm7itW7JdCq5gC37JNi13aUPD/5v2hKYQ18yl+x/cbUE+ZP7tYL4RukIF0rQwcOkKJfKNxPC+lOZD3U4LdEBiuk6t8XknvRLE49+75y5qW+tl4MvoVzSBqYiiKOle/TkDFIxKoeYfhVx3QMnOdvbSXj0cVgxoUGijEzJiSCmjbO/mOAkmjIeN5qH6IntnJePaII0K6Y8Qxb71OPkb6tfKqI7CMc18aH63y4FS5QgkRAQkhKuRHNUlCUo7owhxPkZOwf5RITTI5b3p7Ea6rOKUTVXPMMVfZS9w9No525bD++r2luVgObAE+WESnev7LLV2hvLE8+bLKdkgTtHwJ3s
X-Microsoft-Antispam-PRVS: <DM6PR07MB4715F5A749208EE837EA8B4DDD520@DM6PR07MB4715.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93003095)(3002001)(3231311)(944501410)(52105095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:DM6PR07MB4715;BCL:0;PCL:0;RULEID:;SRVR:DM6PR07MB4715;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;4:oQRfuZ/Xv+gNPe4OYrUnhM7vKnO/exhghYeSFSHXEEHUFIhlpu8BpqtdupJNEX06GR/55KSFT3kZjPmsPz/ybUH+8eHgXf8AABB3WpC04YL0GDGAifLQ7+P82P0+KxgCyccNwKNIJcJRUBru2trFSP+7FL7u9yd/jtfjA4rFyTLzgcHuUb+TpnhHVYMiUTNVzlKIYQp4RRZNwxpaeje9cXn3udxy6IFY+w4dv48QVTXkpDdalqB1jyQ+wpz+xQDzoH2quotf93b1suuCoXfYYKPP2xYlzhPeTE5OJ0bsCcKwxOkP1rI32kpxWywT/IK2
X-Forefront-PRVS: 0738AF4208
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR07MB4715;23:xy3XsiWa3/kXU8PnmBPslDMZ+BNX6nTV/IMYuQCyp?=
 =?us-ascii?Q?SEc6tCjTKSiHgBUmzLF+N2rkzvyhjfco0iUUWadnA3JdQalfe+aZL3dyADat?=
 =?us-ascii?Q?sbJi8pNFsUKcdY7O4m+Jek/SHoy84OTge1w0YFpLRTJfxzRE6fHrixpuR9+y?=
 =?us-ascii?Q?4S8j6fZ9dVnEcVRrPbj7pk/AJqAESaWWWodlg/weBJez2YwUG05H1m4E/pGK?=
 =?us-ascii?Q?WhuArkjFe7kqdmiQAlVHchFWmzOZdw19dFPgSdgY5efAe1yDw2mSq032s/Ya?=
 =?us-ascii?Q?Hl0K3XtoX+N6LADmA+aptaDG109ldUMrGrBnxHHj3ryAJqiQ5jc5ebvU+SQR?=
 =?us-ascii?Q?/PWxQtcpaG+rGHTIHL//iU3luIwVWcgRvMYRC3/a8+9FLgcpIkA0+VazmgiQ?=
 =?us-ascii?Q?9lG9erYrShqxrshM40TTk4FlwtmbEJYfHobdLJLXsEaqWEea/L0d5qzWiYff?=
 =?us-ascii?Q?M5tPnsFs6F3kY2wwsHjo0BzJx2/RGpyG2iON82dQXDFWEGsK9E1lAgUWJ0yS?=
 =?us-ascii?Q?95xekSFgQLKM91xLB8ymggPJ7rDZcmJ8E2V5Y4OhX4cxOAYTqfbHUvKmUSJF?=
 =?us-ascii?Q?bKfyHZ6DDwP5a55Lf9dZXh2JYWIh9jhqD3A5qV6Ncjhw4JthhjzqTWHMFio3?=
 =?us-ascii?Q?+8Z5NI79YSM3VGWd5xFpezquJ75KljBscXZHzGGM8GM/eTmhuWGOEtKZi1b8?=
 =?us-ascii?Q?dB+K7iQQhQPjH0eYQ6SqX9defMeOywF8Yb1/tdrdGoSoTmX6VCv8Hbqg/04d?=
 =?us-ascii?Q?6EwTGIY39xRVVBcdkvkOiGgsWe6aXkigmmrXzAH26jB6dvrop8pswY+DvjhX?=
 =?us-ascii?Q?z5NovEFfucBBmLo2sAqMmv3irrsulwVosIN2YOE44XpbwTEe8C8BFZvoLhjc?=
 =?us-ascii?Q?LIo+FEnwPXJBtrl9fUa/WybUVNli2JKPVwTijEwRKFvhhQ1YMfP13/HrOTz/?=
 =?us-ascii?Q?2j04tZYH/OPCIPCuqC7hbTb7iuFopr1nfiEgHPvC4C1N1ChLmXtbcHeGMppr?=
 =?us-ascii?Q?7Cr3P1PLTEzNUa/sB0pe6CjUeJ6lvusXyIpquDMhRONEdHVt10TqaLsSFZih?=
 =?us-ascii?Q?v3L0+QBLn8xQEoCGx8WS6cwg84fewglRFD32P0+G5BG5w9KCThF606Kpu85/?=
 =?us-ascii?Q?WLnMajJOdauDZDor6+Yf2Aa7MKfG67TvO1NxYYp/PL7DrRRE/3h1pRjujwRl?=
 =?us-ascii?Q?Nfeg3fTmxcP0oY=3D?=
X-Microsoft-Antispam-Message-Info: yn4Ary06yA59kU2I5iy6evCxvHPS/NSC2bZk9NaXRVPmJVjV4TGZMKOQ0+uXK+tSASBqyge0+QK+eT+Wg7UE9OefyuFhLXBK0r36d+vyGvchrDn3W1LOq+PumcYzqFPPCs3nviEDx1OBZ7+n3hmPZIS73lrNYVlI5HK23hajtovabUjxFqfTcn1o39eho+sSiHXXd93KjNnjd5BwKS14b6oe7HjDxAAUBO9QJ2ZMcMuduJ5AvBYlLom9KmchttpFs2PgmoZBkwFmj8+L3wkrmgze74Hgobw6nHupxMGqlkagGtpplk91pTkYbZhw8X7uAfNL3s2BMdj6SmoM62BauIJS9xkY8x0kyOpd96rni9/Pa0jcoFjQzLzw4fQrIOsWvwrdaGQQLkCpRi5pw/JsbQ==
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;6:fFg/V1jdb3UDVU95GNz22mxBU+Q24c7rDjAuh2iZPEc+GG2kRwr+g7gHsXQbSrImbpPR12lScob+jNJ2eLXol/se5ys+3DospmFxoalnnOD4JiEa0R1AfgjuwJiw/aJmtToLrgWjGR908lqrYkZKKj8CbbtUx32DjK4XRFtO36eZMTNFqmRI0zEBkVx9yJhsPNY6gDmPSeJWYo6Xu7jPOP9sx5Kk+KkHFh3AuSnCediAs8OX048xKPL9C/6yFEZMN5VwNdgCFZOYt7s3FIN9L0uztBxooYyEyZtHYWeRplHsEG1As7IxSBSLSb/SDQJvlcJVSo2wY//RVXgfcJQ8QdMUc0xNEubNXNMbbuEjKxkZP4sJ+fSkiTVWadNuc7bdm8m3fcRO/aVAyJW5TmD4k+9wnwdTwF8rydSyqIivzslxOFRbH+XPRe3iWHlTTH20b6HVwkbiaabRUMMgdwwrGQ==;5:ijDx408rX1UxqHUNF+DsXh72UvoDIy/P8f6Kzc41uml38QO4iMzN3c392TO/96LNePfUYKrVN2f+y16pVwa5wB332lgUDucSNdemsSQLzv1TAcbzgnntTKDAEnz55qAh/j6D+VRMf4R6XhWzJtMu3T/mKRT+TpCSJGEndtJKfoA=;7:Ab/vdWiWrKip73bjuLKwJ5HWzICtiCF21QnYKNzqYlGs1cnJEhtL8gXBsV7HGCVn7TmEQxuuOP5aR/qHXvLeiy7SUBqjPkIdNbyTdX+Cg63LrsQV7IItJMtZklmTS207jUhxCGljcsh0MZm5jfi3lVOOXc8Olahkp/4omhxd64C2FeR9eRHIIgbyDiQducoKuuGUeyvB/PcGjhIYcXcOQbUYN3Yt2TNAz/MQWxBByepIuhdkHoMnAwFp3gYUdRRB
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR07MB4715;20:l3kn4hi+jCavLvF+lKxPnBBXvos87vavsKSJEsuz/PDwvETeoGHU4G9OXiVF0x0QMNMUVce7kcqnu+tRy8ozNgE/6KWkc5eHb3ss6wpszmEzx7zlqOlasK6d3Yx3TC6V4mbqlTg//MPvn0bdWrt65ymuzczGCsK4bTDTpDyrz1XX9wAJyQs+igWW1Uk7zGfJBSVJd3rhtk1GjpyfLIz7zM3HcNfsYCk0xeYjwVnVw55paGWkOOMAMdIutC69dMMn
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2018 17:59:20.7351
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f4eca4-12c9-4552-69ae-08d5eda15aba
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4715
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds some other completion events used in driver.

The Device Controller Error event is used for detecting
Event Ring Full error.

Transfer event will be implemented in later patches.

SETUP event handles SETUP packet received from host. In interrupt context
driver only preserve the SETUP packet, then postpone handling
it for later. We can't handle all Setup packet in interrupt
context because some of them needs to call command that take some time.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-ring.c | 57 ++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index c704b939b48a..eab7676fa744 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -1070,6 +1070,18 @@ struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
 	return NULL;
 }
 
+/*
+ * If this function returns an error condition, it means it got a Transfer
+ * event with a corrupted Slot ID, Endpoint ID, or TRB DMA address.
+ * At this point, the USBSSP controller is probably hosed and should be reset.
+ */
+static int handle_tx_event(struct usbssp_udc *usbssp_data,
+			   struct usbssp_transfer_event *event)
+{
+	/*TODO: implement function handling transfer event*/
+	return 0;
+}
+
 /*
  * This function handles all events on the event ring.
  * Function can defers handling of some events to kernel thread.
@@ -1080,7 +1092,9 @@ int usbssp_handle_event(struct usbssp_udc *usbssp_data)
 {
 	union usbssp_trb *event;
 	int update_ptrs = 1;
+	int ret = 0;
 	__le32 cycle_bit;
+	unsigned int trb_comp_code;
 
 	if (!usbssp_data->event_ring || !usbssp_data->event_ring->dequeue) {
 		dev_err(usbssp_data->dev, "ERROR event ring not ready\n");
@@ -1110,6 +1124,45 @@ int usbssp_handle_event(struct usbssp_udc *usbssp_data)
 		handle_port_status(usbssp_data, event);
 		update_ptrs = 0;
 		break;
+	case TRB_TYPE(TRB_TRANSFER):
+		ret = handle_tx_event(usbssp_data, &event->trans_event);
+
+		if (ret >= 0)
+			update_ptrs = 0;
+		break;
+	case TRB_TYPE(TRB_SETUP): {
+		usbssp_data->ep0state = USBSSP_EP0_SETUP_PHASE;
+		usbssp_data->setupId = TRB_SETUPID_TO_TYPE(event->trans_event.flags);
+		usbssp_data->setup_speed = TRB_SETUP_SPEEDID(event->trans_event.flags);
+
+		usbssp_data->setup = *((struct usb_ctrlrequest *)&event->trans_event.buffer);
+
+		dev_dbg(usbssp_data->dev,
+			"Setup packet (id: %d) defered to thread\n",
+			usbssp_data->setupId);
+
+		usbssp_data->defered_event |= EVENT_SETUP_PACKET;
+		queue_work(usbssp_data->bottom_irq_wq,
+				&usbssp_data->bottom_irq);
+		break;
+	}
+
+	case TRB_TYPE(TRB_HC_EVENT):
+		trb_comp_code = GET_COMP_CODE(le32_to_cpu(event->generic.field[2]));
+		dev_warn(usbssp_data->dev,
+			"Device Controller Error detected with error code 0x%02x\n",
+			trb_comp_code);
+		/* Look for common error cases */
+		switch (trb_comp_code) {
+		case COMP_EVENT_RING_FULL_ERROR:
+			dev_dbg(usbssp_data->dev,
+				"Error: Event Ring Full\n");
+			break;
+		default:
+			dev_dbg(usbssp_data->dev,
+				"Not supported completion code\n");
+		}
+		break;
 	default:
 		dev_warn(usbssp_data->dev, "ERROR unknown event type %ld\n",
 			TRB_FIELD_TO_TYPE(
@@ -1123,8 +1176,8 @@ int usbssp_handle_event(struct usbssp_udc *usbssp_data)
 	 * non-responsive.
 	 */
 	if (usbssp_data->usbssp_state & USBSSP_STATE_DYING) {
-		dev_dbg(usbssp_data->dev, "USBSSP device dying, returning from "
-			"event handle.\n");
+		dev_dbg(usbssp_data->dev,
+			"USBSSP device dying, returning from event handle.\n");
 		return 0;
 	}
 
-- 
2.17.1

