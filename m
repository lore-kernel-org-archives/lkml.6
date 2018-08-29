Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2966FC433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:19:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B51662087F
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 00:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=microsoft.com header.i=@microsoft.com header.b="L0TvpWc6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B51662087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=microsoft.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeH2ENV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 00:13:21 -0400
Received: from mail-eopbgr700125.outbound.protection.outlook.com ([40.107.70.125]:63168
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726188AbeH2ENU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 00:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XGYVAld0d0ycqImv5m9tH+srSDMkj5283I32mO+lg74=;
 b=L0TvpWc6pguoQLLuE+P0pfwK/S4Fa1DKnZP7BPPTRv91LDl0k6lmYs+kHHENK5bvLMNcd8U7/CH5QgdjpEqIlb0W1/8rQCq760CHf7eEf5Gbh1lJRr7PfuWpRlPmmGheIBM8wncBODR9eVcp/fFs2y+fhXxZJDVZtegmssjBKHg=
Received: from CY4PR21MB0776.namprd21.prod.outlook.com (10.173.192.22) by
 CY4PR21MB0503.namprd21.prod.outlook.com (10.172.122.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1122.2; Wed, 29 Aug 2018 00:19:12 +0000
Received: from CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611]) by CY4PR21MB0776.namprd21.prod.outlook.com
 ([fe80::7c3a:eea8:1391:1611%7]) with mapi id 15.20.1122.000; Wed, 29 Aug 2018
 00:19:12 +0000
From:   Sasha Levin <Alexander.Levin@microsoft.com>
To:     Ben Hutchings <ben@decadent.org.uk>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/2] Build fixes for liblockdep
Thread-Topic: [PATCH 0/2] Build fixes for liblockdep
Thread-Index: AQHUPyrPOAEl1ifvEECDyTlTYqVbKqTV3XmA
Date:   Wed, 29 Aug 2018 00:19:11 +0000
Message-ID: <20180829001909.GB161312@sasha-vm>
References: <20180828235656.GH18030@decadent.org.uk>
In-Reply-To: <20180828235656.GH18030@decadent.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [52.168.54.252]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;CY4PR21MB0503;6:mBoMUznLVLPBeHkYI453JFVe17SbVs+IKdfdqQJiKPjUFmp60RU2uEIEQ9nv+aoOfcO+IxZ4BcabQpZKCZNFnIDkO3DpTeopoOk1r3cEgsbDh/y3SeVG6Oa3od1eVsCSesPPsrcNBU699J9Zx/ysstRmX4J17XbvWpjBrpNuo2B2+XLDOacB2ngNoJ8SxIDJXJSOl8qCqjHpOryjwSt7uMI7zpCjD1hxHRWekDc4qyrY4DyY8iYNxArI2JVM/w0mXp0Tp3dk/W3CUJEsHQ18MLBKB4XCc/larZkGgJljFlL6Pk6BVAr5U5U76oPyid88DBrLRzLT/S6cX7RF1py+WG64G7vP7L09VkO3qNsLm5RrSGonPMDlzNX2iNzNms/vu8OGXD6NOYkv+/AfoX9v0d5Bj20ckUzJm/sGyMznm/lNcNvbAJ5MPMFgQMQf5CO0SuXSGDozdloX/3QfUSMefA==;5:nxeU+mgtQQp9wl4BGBl2SQGskiNuBHG0YNP+/2I4wQIJWYoeH8cb4ZR+U/kvfd7/i059q98ZWulTOiw88ChyFfcl7n8J9/zmSutMVwfsTxhqy/1oKZLYYA+P4Z4D+7uCmFoOxAGIFgvCVpzTWb3kftPrIu5+RP4mAwQWk57f6bY=;7:o6ORN+uVITdaWavGkv+HHDQ49QTb9tnz3zu5pcszKZF+gwlYUZEHwN9bQ+ehi7/kCh+/q1EnlHPduzfewIsRnEXQ4EiP6Ft5S2OCuV4h6G1X4H9fd5UU2cet1Rg5U5G3/QfqteftY2xhfU52rEEOgsgrO8tKmoYMeoZnp4BbmEu4tRdDcEZrRTV+nyuwAJCWNPzcOWksiTmKkQGpgxaOwmNULdWIrsPTwOzjFZ94gbB0Q5s5hD+3Q1pYvRcZbKDC
x-ms-exchange-antispam-srfa-diagnostics: SOS;
x-ms-office365-filtering-correlation-id: 06fad5de-d360-4448-3657-08d60d450bb8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4618075)(2017052603328)(7193020);SRVR:CY4PR21MB0503;
x-ms-traffictypediagnostic: CY4PR21MB0503:
x-microsoft-antispam-prvs: <CY4PR21MB0503669CD82E43D5F75B337FFB090@CY4PR21MB0503.namprd21.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(8211001083)(2017102700009)(2017102701064)(6040522)(2401047)(5005006)(8121501046)(2017102702064)(20171027021009)(20171027022009)(20171027023009)(20171027024009)(20171027025009)(20171027026009)(2017102703076)(3231336)(944501410)(52105095)(2018427008)(10201501046)(3002001)(93006095)(93001095)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201708071742011)(7699049)(76991033);SRVR:CY4PR21MB0503;BCL:0;PCL:0;RULEID:;SRVR:CY4PR21MB0503;
x-forefront-prvs: 077929D941
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(7916004)(39860400002)(136003)(366004)(396003)(376002)(346002)(189003)(199004)(14444005)(316002)(11346002)(256004)(22452003)(105586002)(3846002)(14454004)(6116002)(1076002)(6436002)(4326008)(486006)(186003)(476003)(26005)(446003)(33896004)(6346003)(99286004)(102836004)(68736007)(86362001)(6506007)(8936002)(86612001)(76176011)(106356001)(87496004)(5660300001)(2900100001)(7736002)(81166006)(81156014)(66066001)(8676002)(33656002)(10290500003)(72206003)(478600001)(305945005)(2906002)(6246003)(6306002)(25786009)(9686003)(6512007)(5250100002)(33716001)(6486002)(229853002)(97736004)(53936002)(10090500001)(6916009);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR21MB0503;H:CY4PR21MB0776.namprd21.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microsoft.com does not designate
 permitted sender hosts)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Alexander.Levin@microsoft.com; 
x-microsoft-antispam-message-info: fs4d/Dqt5j81PuoKlNNxuyr/H+F2vUUz7a7gFoDMeHvD6uAlQowNQy9GIxW9uCTnahT+eJWrC9FUfV+kZgYb/371HwB3PAZumMmqvRl5HrBVBVvL7I7oNT8bUrqOk9YsyFTgYmZ9U21sn/Ckb8wHI6dmY7WCb+uUtXmY+OMAisE045Yrc8E1wXkLIN4MN+KvumzrzqI63b1bUYMtKOZsxv61xWoXN+ZAWiTV/2/lq5ApIBBcVni4tpZKycpAIIqMlrODOrHSnB3q7kGHDrpeeRGYW4tfKh6w4XGpSpZnndEXVD6/vlYP099xuHvpJNXx3M9UVuFaYLbmXE05fn63+Nlb4N93BAB5jr/JfwNaDbg=
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1AF71A2D8C5A724BB1438F68B2A36857@namprd21.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06fad5de-d360-4448-3657-08d60d450bb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2018 00:19:11.8679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR21MB0503
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 29, 2018 at 12:56:57AM +0100, Ben Hutchings wrote:
>In addition to the patch I recently sent for lockdep itself, the
>following fixes are also needed to make liblockdep build.

Thanks Ben. I've already sent patches similar to this as well as a
MAINTAINERS update a few weeks ago to Ingo, but he didn't merge it in
yet (https://lkml.org/lkml/2018/8/13/480). Let me follow up with him.
