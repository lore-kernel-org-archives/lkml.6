Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF08C32789
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8AA204FD
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 11:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="hJfT/qyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC8AA204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbeKBUbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 16:31:02 -0400
Received: from mail-eopbgr60104.outbound.protection.outlook.com ([40.107.6.104]:17344
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725935AbeKBUbC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 16:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0n66ZZG8AsFlP2chYHsRo9KD0rpaWjZOm4XOMgTP48=;
 b=hJfT/qyuZ0IaUabGXP+KWMOwTgD7wO3X5bXEgFBtlxf5wT6q947Pg3ifKE/6KV9s3pCwLrbIGvA+CxVvJaA+MwClqKXPqfo6MPmrfBVrTRA7UzxhgALy2z8dRzc2iJBLtxH2QXj7bk8oKm4rbXBhEckBEz+aZYR9tVpJeFmlHHk=
Received: from HE1PR07MB1307.eurprd07.prod.outlook.com (10.164.51.157) by
 HE1PR07MB4379.eurprd07.prod.outlook.com (20.176.167.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1294.14; Fri, 2 Nov 2018 11:24:09 +0000
Received: from HE1PR07MB1307.eurprd07.prod.outlook.com
 ([fe80::b998:435b:155e:8c3b]) by HE1PR07MB1307.eurprd07.prod.outlook.com
 ([fe80::b998:435b:155e:8c3b%3]) with mapi id 15.20.1294.024; Fri, 2 Nov 2018
 11:24:08 +0000
From:   "Koskinen, Aaro (Nokia - FI/Espoo)" <aaro.koskinen@nokia.com>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH v2] arm64: dts: stratix10: fix multicast filtering
Thread-Topic: [PATCH v2] arm64: dts: stratix10: fix multicast filtering
Thread-Index: AQHUcp0MQUsx/YwAnUyT3CyI6LJndqU8VxNr
Date:   Fri, 2 Nov 2018 11:24:08 +0000
Message-ID: <HE1PR07MB13072CD7BFBA5F6B2A70B51CF4CF0@HE1PR07MB1307.eurprd07.prod.outlook.com>
References: <20181102111258.18748-1-aaro.koskinen@nokia.com>
In-Reply-To: <20181102111258.18748-1-aaro.koskinen@nokia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=aaro.koskinen@nokia.com; 
x-originating-ip: [131.228.2.5]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HE1PR07MB4379;6:gh1+SBPwI7KB2fKx7KywUytR4zOND6VDr/e2KYQqqRR2jmIQRs+Z6U5dzcFIkTmZ6qIMbSUyvj9A6QzxLD7HGNSI9SUhlf0XZW+68rlITNdkgVIQ32KHouTcHusjoLMRXKWuT0l5xuBnFMT/Dw7DjRbHMThMsDpSP/rZAmAQ6WvRWar7CD7wug1a5aI5ap+alfde8wFXnba2ajxTI8T3rV5LH49TyPtTOGlZg7RhiTMe9Pp/ez/NHjQBUJjEiQUAcKBOcLNfB1CgTxrTK8worayi1Qj31j7Dxt7EfrfRvsWgb5lfNI8AQSqNMgPnQFfErB/YvqT3t+HllTzjybeggPSqk6Dn5I6NoduC9bqzBjEZubTfK2NHARjrDEiLrXaJp4EM8xmWi7Qv+Dr1k/cR6E9z1Mvw6S1nfZylBVndGGJtATO/xFyBSr638zIMTlPAiFEQOw50j/fCYSsPETLkQw==;5:KE/S9pvYv9mfWCVI8844ZLU+QGCOmNUpZ7mOGK8/TikYb1O56Jk9rpI5O5F4eBzaeXgX+TxdTNc3Xon2URr0uCETIM/DJLeebJOK1CMRCQyfeIX8TkSl6nqzZhtAYc0tZoDOS0FtsnmmoZjCFCPMuwGbi6pIvGpwY1183jHDCzE=;7:YrNntcpIM5EWRthWnp/WAXmV0iKFrXspHGqgEx4kZ6UJwlzrlnRpHCm17xJFp3hU9x0P3eH9S+GH8Buo7StzPFNRiVf6VfqppZh0qWeUkzlAJx2s0HVQ2eBZh24GWu5JrrwZQu2HdLLcUdh5gv3pMw==
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: e7eeee77-8e5f-47b3-20fd-08d640b5b508
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:HE1PR07MB4379;
x-ms-traffictypediagnostic: HE1PR07MB4379:
x-microsoft-antispam-prvs: <HE1PR07MB43790C4193C7F6EBBE0734C4F4CF0@HE1PR07MB4379.eurprd07.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863)(82608151540597)(195916259791689)(109105607167333);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231382)(11241501184)(806099)(944501410)(52105095)(93006095)(93001095)(6055026)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(201708071742011)(7699051)(76991095);SRVR:HE1PR07MB4379;BCL:0;PCL:0;RULEID:;SRVR:HE1PR07MB4379;
x-forefront-prvs: 08444C7C87
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39860400002)(396003)(376002)(136003)(366004)(346002)(199004)(189003)(14454004)(6436002)(105586002)(66066001)(68736007)(54906003)(256004)(71190400001)(71200400001)(106356001)(5660300001)(6246003)(53936002)(486006)(446003)(9686003)(11346002)(55016002)(478600001)(97736004)(476003)(25786009)(86362001)(33656002)(7736002)(81166006)(8936002)(229853002)(74316002)(2906002)(7696005)(3846002)(6116002)(110136005)(186003)(6506007)(305945005)(99286004)(26005)(4326008)(558084003)(81156014)(102836004)(2900100001)(76176011)(316002)(8676002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR07MB4379;H:HE1PR07MB1307.eurprd07.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nokia.com does not designate
 permitted sender hosts)
x-microsoft-antispam-message-info: EYlfnbzML2h3TgFD7jCZh2F54kmBrXCX5ZVf0y0eLUe12WhbjCqf9tXUReBPdTagovptvYxGXHgAD2316ehsLtphZC5lKCE6J88TdAb+3PiQNhfjFSkII/+ef4wV62oDjFVmBufOGan9mgqTeGsCRTxrDS2wFbkTXHJx7LTsUKmJImcvQHwU9vSYp0odyqJRLpBJ+EtZw7NeQ6NGeyvikRU/+wWU26fn0jfyIdOVGAIkNe1kipC/dqsDGNe/wAJ8JothIhaqEmQfL8OKTAgXvwM5J/ZkJaI1ClKMGURQShCDsxGVrSV9dI26O9OHsgzTzgDwaKRcvq+99zMLddVUBN3QVbqDbxIEcgA37A7rknw=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e7eeee77-8e5f-47b3-20fd-08d640b5b508
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2018 11:24:08.9500
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR07MB4379
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> From: Aaro Koskinen <aaro.koskinen@nokia.com>

This is the correct one, but unfortunately both git-send-email and
my SMTP server are trying to be too clever and prevents me sending
the patch in correct format. :-(

A.
