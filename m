Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D62C468C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2677E21479
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="Ekqnak4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2677E21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732539AbeGLF4K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:56:10 -0400
Received: from mail-by2nam01on0075.outbound.protection.outlook.com ([104.47.34.75]:24333
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726904AbeGLF4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV3gt5/MCDFyg4FL5QSAqE40dcIFnEVzuP8bqP7Aruc=;
 b=Ekqnak4l4W5lIC4b8Bo2hsU+BB9NLgZD6d5f2pV8up4JZYEpN+GvwZxPekz9kg2Vv39Xk1gWhYRFfX1aP9PjlAx3Mhl+dcKPXOJ3NmpJXeTFvmcdMJhEJZf9VyH1FtaHIPCN8v5LHgEBdHEsUDxcQGqjKggOoU9z0RCiYpWlauM=
Received: from BY2PR07CA0079.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::32) by BN3PR0701MB1332.namprd07.prod.outlook.com
 (2a01:111:e400:4018::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.17; Thu, 12 Jul
 2018 05:47:56 +0000
Received: from BY2NAM05FT049.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::201) by BY2PR07CA0079.outlook.office365.com
 (2a01:111:e400:7bff::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.17 via Frontend
 Transport; Thu, 12 Jul 2018 05:47:56 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT049.mail.protection.outlook.com (10.152.100.186) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.973.9 via
 Frontend Transport; Thu, 12 Jul 2018 05:47:55 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkw4032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:47:55 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:04 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:04 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lmmU029605;
        Thu, 12 Jul 2018 06:47:48 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lmWK029603;
        Thu, 12 Jul 2018 06:47:48 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 10/31] usb: usbssp: added usbssp_trb_in_td function.
Date:   Thu, 12 Jul 2018 06:47:07 +0100
Message-ID: <1531374448-26532-11-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(376002)(136003)(346002)(39860400002)(2980300002)(199004)(189003)(36092001)(446003)(476003)(2616005)(76176011)(105596002)(426003)(106466001)(47776003)(2906002)(26005)(36756003)(336012)(186003)(8676002)(11346002)(51416003)(8936002)(126002)(1671002)(48376002)(50466002)(16586007)(356003)(4720700003)(7636002)(305945005)(246002)(54906003)(42186006)(86362001)(575784001)(50226002)(5660300001)(6666003)(478600001)(87636003)(26826003)(4326008)(109986005)(107886003)(486006)(316002)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN3PR0701MB1332;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT049;1:LFKLyC9tF588dpXdgQBMR9nDqs4ihOQFE96aBWqPK1JI8bgx4JnbDdvzY9Q4CLX443sklJM2rNAn1LJNMggrRUHJG4/BBuGi49GkLtJIyd+nwQYwxTt03JkizBUKqvZA
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 68138c0a-273b-42c6-aa7e-08d5e7bb0447
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:BN3PR0701MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;3:nyScGC0w04/nd816CIb24j3twebvQtx6AZIhkIqysU8wZmK1aFeGI5iPDWR1ill4k2lzzKHjDcV3O+Sc9BK/uy1YWT7aB0+bDEuE/2cRxHBFOQ5qJsvpUm0l5PC8VWWfxCeD68R64SxyOXj6XZt+lJmzgoS60o69qJkAhsV++BiFyu8rUZhrLWv0h8EPKBwLEuYiGekpO0rvDPr1/J9aTlKFRzMzUTRFUMMMLPNjKHcRpp7FrtGonKHysP4z0fgk+LEcnRdZsDxJmf+C8dfhGSteSXcdWII2e73nHHDFG+YS/94jMD3MvI7ApMB9i/q6pKlNOL5M+mj3o3YUiu+BAe96fgjEONJZGsSamz+/FAc=;25:67NWwO6lIFkuL6uWy608cEYtGvZrDsAWAwG+MeD4mOqV0T5bpJ+XYfvhNA0Q8DT4sgGoojvkXuts3vH4ZVhMircFJTFLCMvz/QAjIBpv0JhMBLHeAmJSxgfhRmsAF61MBachQmH9DYxXyxMvTESXQ3+6P75N0YpzRreqzaOdnzQ6Q1yQtGxLu/i7HiYzujZc0obTqaxeafMZubhXJ5V3Nd6t/BYgv5TYMU5yXQT0CBweSWCGjwmgo88C/coY72nuhLnxUAKDAzTXMeutHgy5cztuOlbPJXvmv9NIP1rE5XmUKdbqj2Da7j3ZTciBvh0eMz+345oSRrdhzn8GVWg+Rw==
X-MS-TrafficTypeDiagnostic: BN3PR0701MB1332:
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;31:gRB+RJxC4qMOLFyf65sIH/Olx7PFKRFopPho3tnPoJj9Yjj0GJm+J79Y4BSP1k1Wui0NcZnKy0mFPgxi42qpcn8ugZ1h0yhnxvwMtunOzvhjUKnqieCJA3z6KoyANZoqBeKSGFF2X6hoiEO3bjxg6tvf7FYsMJLdLGf5JNOqnOQt73wNGhYuUTSxjG3YHevf3C3ENW1rPoG/7CBIGDDqT18bprYPEcXywxMyChwUnm8=;20:zOQx3naxPlmkR1p62dMos4rmzqDFHeiOxpLg9YO0xKcJPzBG5vareXbF6L4UUxt61XFhDaVvwPvOpbJqn3S3BXK+0bJ3o6px9MAsEv0155+gkbyhQMf4omtkUj3ho3uzaVR9m7nC+LEs9RqotTbQJduOMm8Ch16dVAsZeNwIFxa0HLVRreUErw6CYFrl0wI9X7HnYtaccTqWpj2YWqGMwvkv7ntToJjli35Y8U276MoHeLrr14jrvV5JdULUX9LOBWlPR/h4V4oYSLPgCEksCTM+iJQgwDM62wWzXfYZRLIyWW/JaBfhM/420wQh/+KaAFMnrI+0AM/NdaqOwk73FgEHJA9xHttGzyGZgd2bx6gX9NmipczDjsnqmyS0XJwSwcXrm5Bb70/KxBYaLkkDPLLZFvQAnRMYk2EQ9kDn+qNVEX6WwZ32wALcbSF7yK53gbtYkwCt9jZL0ErU/TI5qsZfrUoySowKo/hjdM9i3wiuVHIlNHlJxG1lu8wMCofA
X-Microsoft-Antispam-PRVS: <BN3PR0701MB1332EB2B4AD879ACBBED2561DD590@BN3PR0701MB1332.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(10201501046)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011)(7699016);SRVR:BN3PR0701MB1332;BCL:0;PCL:0;RULEID:;SRVR:BN3PR0701MB1332;
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;4:O4CdiLP8TfPoPLy1mN2jH1iimt0Kw/4claTMrsaBTKS9L3nRjG6rbtEreGg1a+hKCqf+E3ETwOcUZqb0BjHrd6iKq63EE9U7EAXmtRGpy/XdXHuJ1XLa/Mfb+uyAVRmoJN7YjMP0i0nRsyLDc4PZia56b3zpl9OHvFm2WVOXWL3PA6Ht0c+y4L9p+SDQU/FUI9vwPQCr+KbQwDx3cb5VL7wR+QzANfw1v8SYfdrxmxNJUCfWGqJ0j7RCBAyDrI1q+8O0ZehE55qvIDBmJhVBEiAHpLfg435lUt+r6L3FGVm0SmxhKxgj/NNlzILj/zU+
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN3PR0701MB1332;23:Ho+476lX9+/BYaPPeWzebi+hoWegfLOGDUf0WTn?=
 =?us-ascii?Q?t75uMopDMypBirSx2LUUmBaCgSqIPDIbmCj1gz/a1yZXQuB7GLqwIGt6PCR5?=
 =?us-ascii?Q?jFlB5xGO4Ky6Kq+y/2u9t8q7LwKIdurMa/d2ZsU6jirbtON8Pj9xV+m9HtN/?=
 =?us-ascii?Q?fQznsom+uHhIyKdhhMU8D7eatufdhu3AHPsiwSuz7u1f9KJtlKtE9svjNmaV?=
 =?us-ascii?Q?Ti0j9R7riHCNUFD0nQ1NdyChjcXH10punB5RvqTTP40hERLx9nw2pjDMIrc+?=
 =?us-ascii?Q?+g1p5//OwtMZGq7yggNanQ9cV8T6Qd/Db4jO/9DNvOFnFKbmpXXfNjiu7LZi?=
 =?us-ascii?Q?7vD+raoxjlsZDgIDAcayjMWXStWz57t5udDug2yoOVB/N8PquJNopTyV9TIf?=
 =?us-ascii?Q?RBR4vUt0nKvOI7ISexGKsLjk+JkQtcJInxS2RG4rLu9vqEK5fKBD5er3qd9K?=
 =?us-ascii?Q?JsHF037hN/dCsLHkV0msHmpO7HBWVtO5tLYbzOu16uYIHpr9pHY1SpHTRmOs?=
 =?us-ascii?Q?1S9dyitlvO2i+Fj+yTu6L60pDdWKx8I8j7/X5YSF/aazGTlA/k4b4uD3rybQ?=
 =?us-ascii?Q?yxecJ1QxKugFjv1EunNkqW9o+NyIQjo0rwB/xLknG93LAx7cgSUDE7FlOyql?=
 =?us-ascii?Q?XbRvk8MO5zFiMq0Jz7Pp24+vu319ESs0bjd1xv7czQrmwiMzUFvhnhv3gINl?=
 =?us-ascii?Q?fiipMtsSH2ApqNvc5aaSq61FHgodmX7f9YZLwYsRntgE+Os3y1+AMF2sTVnU?=
 =?us-ascii?Q?tndllWcGHXgmMa0qWdVPMlgmPZJEeaLXKAqDVDEXkIsvnZDO54KoDSp7VcHu?=
 =?us-ascii?Q?8hU9xVAJL7tifiLulkwg90caY5IXUzyiBiovBqV7KBS9B4TpKwdeqZzs5TRv?=
 =?us-ascii?Q?Rb15QsT/KdhwzR9QKzkGR9j9UkXF9bbBVNplbyTIeQrqL4aEgEDcf21i5E2J?=
 =?us-ascii?Q?bk5udRZz9m/gSW+lzbGTMf9LJfW1fHELvpRIIkO6mI90svgQXyNVEBiKIE3n?=
 =?us-ascii?Q?h9NV1/GMSeYsHX0uDs0D2eG7sDUcqNX2o546GinWvj4sP4nTyEu1ig6KF7ZC?=
 =?us-ascii?Q?+Jgf1kEyE0M1sWuFckNVussZkQ5perZxTI7Rspbn2K8ZmryYHSm4MAnkftg1?=
 =?us-ascii?Q?MAd50qbXCiegLPoqaDMWqtLDkTyOUC0DyK0oMuDdNdBr+ZXf7uEqocg=3D?=
 =?us-ascii?Q?=3D?=
X-Microsoft-Antispam-Message-Info: 3R+zVjMx+J9Mirip+HjDqFY6CO1TAtzg0V5QrpiFG+w2D5Nibp/xvP9grRpcExqGyDIe0a/eGtAYzoIgSx3FfrEghmR9sPs948uzW02gerXeA15hQOeMoqNDdoc7Ai8WsOYGNPlJmSIh5xy4HtMEW7KR8mE1JfyaDwrhAMsQF5w8JkzoFpnQ/iziUIhO6kLbQ1+B3FW4JV2EXU6oau90enHAYByq48gRm1Zjm/us9AABzTPqpyhULzrPQyKkqMzgps11BYRCd4AhkzupODHKvSAzaHemO4nsYxX+Yh/gdX7e0nmJ310TGENFq9/e76xxpud7UkbHVSyfJ11HLV7Coup8mDTImBe9siZx2lVR20iotcObJ+p7bs8j5CfOSvirBMmlTKaFUJH+pFRF1SQzFA==
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;6:TvIgyHCL2yWX70Dr1OpYlzwpCYrWLvV3qM1OubdsgoQYvDpkn+vo5as29xEYvg9pF1W28pgyzdYCJB05TtorTZ8aC0UmpYJwheFgIa3qNCxb7tyoyc73f4uvTEY3lBmm/Ulbbmz8o4uXmGz9R7EJOaiJyJGGEB1o+0XpM9YzqrJ7AphFI+/rgh4sf47kv2uRnWhUrodMxbR9tu1g1rfSWZ9tjbvqpgZwKBeBOzcekSLHMXOF8iAi2TyG6m5FQeHvVggy0pC685ltXlZQEnvHhjW/RhURWAf3WXlNgpRwddJ4dOR//k0eHiuzfgpEroGdLyA3acPXfqQXy82J0RklZbVRfw0kIwoYS3yhOeW1aXAxbJBe5jzixWp0ceaucbjbj/tWrod/csWZABL6CO+dsChobvcEBPLalOJck5KDJfvIC+QT8VAO18+I9NHrpGRnaBY4hZ4ZKTXKn+OnvQGqfw==;5:0WzGr2hSjcsiJH/oO0XP7XRqnsn8Cx6n7Ap+Cy67mfDE5+RejT9Qb8kIKmTohXxS4/2o8UFKSywBOKMFHqqBjv2cO8xW6kcsb7+NWX1xSLe3e3FIikYfgS8nhB1WfyBhc2WlU6f7Nk60dkI7glXgl3M5un8sdBuKUfYAyrcmmGc=;24:phj0+LZ2BPDpnSNNJoYFDtOyYe7SpW15XpibWW0N4zwh+bvwccSQ/MjaRfQqUG9seY6BRT4ydU6OGhV9vbaTP1PrbCQOzx97uIKL9nBkHcM=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN3PR0701MB1332;7:7pQItHq/qxS/0SX7F6BLCuNgdvwi9DvUk8lxScCKZZZnaEguKB/wrpQNK5lUfc/Ytd22YPqM/wWdak5TBPw2trpBFh2xRVLyNEMqa2v0dzGcnusSmhnnT2YS22dZGKC7DBulr2JHotdhzQoq4k7kLGPYUjeXG26lmyey4Wdv/pC0VA4hwvqiOtAXebWzb5dqD9ApckJW12eGSnp/Dix61WvEA+a/yVeceQAtiXw+5BTBZlE8CUHS3be509GGEAZi;20:G728x4fRhi8jMF+8hhN26JDu0GIoIGdtsQLAzWFKbFBlCsW42h2EPDU2l+TS0XlhZWbafj6DLIAOGstnTElqwLCQDMTO+U6N/ZhQCCJ0Qm4xw3RobyB7vIfw1SgvQfGjk39rMYbMsXi9VChOB5wZghzl0MrSSEG0F/HiqzQcMlxzRcxJpuskS0Dm+g+zSkiXL4hD9uCZkgEzVv93Qjyi3XW8ncfpYTyrHwD/3C40VwBh8nDkG1SaJUOUk/9ZNn7K
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:47:55.8874
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68138c0a-273b-42c6-aa7e-08d5e7bb0447
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR0701MB1332
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds usbssp_trb_in_td function. This function checks if given
TRB object belongs to TD.

Patch also add procedure for testing this function and some testing
cases.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-mem.c  | 166 +++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget-ring.c |  73 ++++++++++++++
 drivers/usb/usbssp/gadget.h      |   4 +
 3 files changed, 243 insertions(+)

diff --git a/drivers/usb/usbssp/gadget-mem.c b/drivers/usb/usbssp/gadget-mem.c
index 6ee068592ba4..e1ecb688eb0f 100644
--- a/drivers/usb/usbssp/gadget-mem.c
+++ b/drivers/usb/usbssp/gadget-mem.c
@@ -766,6 +766,168 @@ void usbssp_mem_cleanup(struct usbssp_udc *usbssp_data)
 	usbssp_data->page_shift = 0;
 }
 
+static int usbssp_test_trb_in_td(struct usbssp_udc *usbssp_data,
+				 struct usbssp_segment *input_seg,
+				 union usbssp_trb *start_trb,
+				 union usbssp_trb *end_trb,
+				 dma_addr_t input_dma,
+				 struct usbssp_segment *result_seg,
+				 char *test_name, int test_number)
+{
+	unsigned long long start_dma;
+	unsigned long long end_dma;
+	struct usbssp_segment *seg;
+
+	start_dma = usbssp_trb_virt_to_dma(input_seg, start_trb);
+	end_dma = usbssp_trb_virt_to_dma(input_seg, end_trb);
+
+	seg = usbssp_trb_in_td(usbssp_data, input_seg, start_trb,
+			end_trb, input_dma, false);
+	if (seg != result_seg) {
+		usbssp_warn(usbssp_data, "WARN: %s TRB math test %d failed!\n",
+				test_name, test_number);
+		usbssp_warn(usbssp_data, "Tested TRB math w/ seg %p and "
+				"input DMA 0x%llx\n",
+				input_seg,
+				(unsigned long long) input_dma);
+		usbssp_warn(usbssp_data, "starting TRB %p (0x%llx DMA), "
+				"ending TRB %p (0x%llx DMA)\n",
+				start_trb, start_dma,
+				end_trb, end_dma);
+		usbssp_warn(usbssp_data, "Expected seg %p, got seg %p\n",
+				result_seg, seg);
+		usbssp_trb_in_td(usbssp_data, input_seg, start_trb,
+			end_trb, input_dma, true);
+		return -1;
+	}
+	return 0;
+}
+
+/* TRB math checks for usbssp_trb_in_td(), using the command and event rings. */
+static int usbssp_check_trb_in_td_math(struct usbssp_udc *usbssp_data)
+{
+	struct {
+		dma_addr_t input_dma;
+		struct usbssp_segment *result_seg;
+	} simple_test_vector[] = {
+		/* A zeroed DMA field should fail */
+		{ 0, NULL },
+		/* One TRB before the ring start should fail */
+		{ usbssp_data->event_ring->first_seg->dma - 16, NULL },
+		/* One byte before the ring start should fail */
+		{ usbssp_data->event_ring->first_seg->dma - 1, NULL },
+		/* Starting TRB should succeed */
+		{ usbssp_data->event_ring->first_seg->dma,
+				usbssp_data->event_ring->first_seg },
+		/* Ending TRB should succeed */
+		{ usbssp_data->event_ring->first_seg->dma +
+				(TRBS_PER_SEGMENT - 1)*16,
+			usbssp_data->event_ring->first_seg },
+		/* One byte after the ring end should fail */
+		{ usbssp_data->event_ring->first_seg->dma +
+				(TRBS_PER_SEGMENT - 1)*16 + 1, NULL },
+		/* One TRB after the ring end should fail */
+		{ usbssp_data->event_ring->first_seg->dma +
+				(TRBS_PER_SEGMENT)*16, NULL },
+		/* An address of all ones should fail */
+		{ (dma_addr_t) (~0), NULL },
+	};
+	struct {
+		struct usbssp_segment *input_seg;
+		union usbssp_trb *start_trb;
+		union usbssp_trb *end_trb;
+		dma_addr_t input_dma;
+		struct usbssp_segment *result_seg;
+	} complex_test_vector[] = {
+		/* Test feeding a valid DMA address from a different ring */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = usbssp_data->event_ring->first_seg->trbs,
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
+			.input_dma = usbssp_data->cmd_ring->first_seg->dma,
+			.result_seg = NULL,
+		},
+		/* Test feeding a valid end TRB from a different ring */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = usbssp_data->event_ring->first_seg->trbs,
+			.end_trb = &usbssp_data->cmd_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
+			.input_dma = usbssp_data->cmd_ring->first_seg->dma,
+			.result_seg = NULL,
+		},
+		/* Test feeding a valid start and end TRB from a different ring */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = usbssp_data->cmd_ring->first_seg->trbs,
+			.end_trb = &usbssp_data->cmd_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
+			.input_dma = usbssp_data->cmd_ring->first_seg->dma,
+			.result_seg = NULL,
+		},
+		/* TRB in this ring, but after this TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[0],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[3],
+			.input_dma = usbssp_data->event_ring->first_seg->dma + 4*16,
+			.result_seg = NULL,
+		},
+		/* TRB in this ring, but before this TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[3],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[6],
+			.input_dma = usbssp_data->event_ring->first_seg->dma + 2*16,
+			.result_seg = NULL,
+		},
+		/* TRB in this ring, but after this wrapped TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[1],
+			.input_dma = usbssp_data->event_ring->first_seg->dma + 2*16,
+			.result_seg = NULL,
+		},
+		/* TRB in this ring, but before this wrapped TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[1],
+			.input_dma = usbssp_data->event_ring->first_seg->dma + (TRBS_PER_SEGMENT - 4)*16,
+			.result_seg = NULL,
+		},
+		/* TRB not in this ring, and we have a wrapped TD */
+		{	.input_seg = usbssp_data->event_ring->first_seg,
+			.start_trb = &usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 3],
+			.end_trb = &usbssp_data->event_ring->first_seg->trbs[1],
+			.input_dma = usbssp_data->cmd_ring->first_seg->dma + 2*16,
+			.result_seg = NULL,
+		},
+	};
+
+	unsigned int num_tests;
+	int i, ret;
+
+	num_tests = ARRAY_SIZE(simple_test_vector);
+	for (i = 0; i < num_tests; i++) {
+		ret = usbssp_test_trb_in_td(usbssp_data,
+				usbssp_data->event_ring->first_seg,
+				usbssp_data->event_ring->first_seg->trbs,
+				&usbssp_data->event_ring->first_seg->trbs[TRBS_PER_SEGMENT - 1],
+				simple_test_vector[i].input_dma,
+				simple_test_vector[i].result_seg,
+				"Simple", i);
+		if (ret < 0)
+			return ret;
+	}
+
+	num_tests = ARRAY_SIZE(complex_test_vector);
+	for (i = 0; i < num_tests; i++) {
+		ret = usbssp_test_trb_in_td(usbssp_data,
+				complex_test_vector[i].input_seg,
+				complex_test_vector[i].start_trb,
+				complex_test_vector[i].end_trb,
+				complex_test_vector[i].input_dma,
+				complex_test_vector[i].result_seg,
+				"Complex", i);
+		if (ret < 0)
+			return ret;
+	}
+	usbssp_dbg(usbssp_data, "TRB math tests passed.\n");
+	return 0;
+}
 
 static void usbssp_set_event_deq(struct usbssp_udc *usbssp_data)
 {
@@ -1180,6 +1342,10 @@ int usbssp_mem_init(struct usbssp_udc *usbssp_data, gfp_t flags)
 	if (!usbssp_data->event_ring)
 		goto fail;
 
+	/*invoke  check procedure for usbssp_trb_in_td function*/
+	if (usbssp_check_trb_in_td_math(usbssp_data) < 0)
+		goto fail;
+
 	ret = usbssp_alloc_erst(usbssp_data, usbssp_data->event_ring,
 			&usbssp_data->erst, flags);
 	if (ret)
diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 7c4b6b7b7b0a..c3612f4bc2a9 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -73,3 +73,76 @@ void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data)
 	list_for_each_entry_safe(cur_cmd, tmp_cmd, &usbssp_data->cmd_list, cmd_list)
 		usbssp_complete_del_and_free_cmd(cur_cmd, COMP_COMMAND_ABORTED);
 }
+
+/*
+ * This TD is defined by the TRBs starting at start_trb in start_seg and ending
+ * at end_trb, which may be in another segment.  If the suspect DMA address is a
+ * TRB in this TD, this function returns that TRB's segment.  Otherwise it
+ * returns 0.
+ */
+struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
+					struct usbssp_segment *start_seg,
+					union usbssp_trb *start_trb,
+					union usbssp_trb *end_trb,
+					dma_addr_t suspect_dma,
+		bool		debug)
+{
+	dma_addr_t start_dma;
+	dma_addr_t end_seg_dma;
+	dma_addr_t end_trb_dma;
+	struct usbssp_segment *cur_seg;
+
+	start_dma = usbssp_trb_virt_to_dma(start_seg, start_trb);
+	cur_seg = start_seg;
+
+	do {
+		if (start_dma == 0)
+			return NULL;
+		/* We may get an event for a Link TRB in the middle of a TD */
+		end_seg_dma = usbssp_trb_virt_to_dma(cur_seg,
+				&cur_seg->trbs[TRBS_PER_SEGMENT - 1]);
+		/* If the end TRB isn't in this segment, this is set to 0 */
+		end_trb_dma = usbssp_trb_virt_to_dma(cur_seg, end_trb);
+
+		if (debug)
+			usbssp_warn(usbssp_data,
+				"Looking for event-dma %016llx trb-start"
+				"%016llx trb-end %016llx seg-start %016llx"
+				" seg-end %016llx\n",
+				(unsigned long long)suspect_dma,
+				(unsigned long long)start_dma,
+				(unsigned long long)end_trb_dma,
+				(unsigned long long)cur_seg->dma,
+				(unsigned long long)end_seg_dma);
+
+		if (end_trb_dma > 0) {
+			/* The end TRB is in this segment, so suspect should
+			 *  be here
+			 */
+			if (start_dma <= end_trb_dma) {
+				if (suspect_dma >= start_dma &&
+				    suspect_dma <= end_trb_dma)
+					return cur_seg;
+			} else {
+				/* Case for one segment with
+				 * a TD wrapped around to the top
+				 */
+				if ((suspect_dma >= start_dma &&
+						suspect_dma <= end_seg_dma) ||
+						(suspect_dma >= cur_seg->dma &&
+						 suspect_dma <= end_trb_dma))
+					return cur_seg;
+			}
+			return NULL;
+		} else {
+			/* Might still be somewhere in this segment */
+			if (suspect_dma >= start_dma &&
+			    suspect_dma <= end_seg_dma)
+				return cur_seg;
+		}
+		cur_seg = cur_seg->next;
+		start_dma = usbssp_trb_virt_to_dma(cur_seg, &cur_seg->trbs[0]);
+	} while (cur_seg != start_seg);
+
+	return NULL;
+}
diff --git a/drivers/usb/usbssp/gadget.h b/drivers/usb/usbssp/gadget.h
index b19826c1798a..374c85995dd7 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1705,6 +1705,10 @@ irqreturn_t usbssp_irq(int irq, void *priv);
 /* USBSSP ring, segment, TRB, and TD functions */
 dma_addr_t usbssp_trb_virt_to_dma(struct usbssp_segment *seg,
 		union usbssp_trb *trb);
+struct usbssp_segment *usbssp_trb_in_td(struct usbssp_udc *usbssp_data,
+		struct usbssp_segment *start_seg,
+		union usbssp_trb *start_trb, union usbssp_trb *end_trb,
+		dma_addr_t suspect_dma, bool debug);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
-- 
2.17.1

