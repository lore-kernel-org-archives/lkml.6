Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8A4ECDFBD
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F44620881
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="gjS98yeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F44620881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388630AbeGXMUl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:20:41 -0400
Received: from mail-eopbgr700064.outbound.protection.outlook.com ([40.107.70.64]:32096
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388241AbeGXMUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:20:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qw7pXrr6A3piW3WCt4SMA/+dbRrwdrLhTaDHqjngrSY=;
 b=gjS98yeq5z9Jldyy/ZSicCtkROiG0up+uTAQTEZVz3++UEwizoPmPjWA1VexWkDnxvqyhQL6rlRWNvFDX1WyIaS4GQMILGp1hIFU6bHfuH/R/Wploaehyu2U+Wzkh3Dr5NngBh2vf15s4FRWhUfMN4epAhHCLk1f5z/939LAOMw=
Received: from DM5PR07CA0098.namprd07.prod.outlook.com (2603:10b6:4:ae::27) by
 BY2PR07MB2294.namprd07.prod.outlook.com (2a01:111:e400:c50d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.16; Tue, 24 Jul
 2018 11:14:39 +0000
Received: from DM3NAM05FT060.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::204) by DM5PR07CA0098.outlook.office365.com
 (2603:10b6:4:ae::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 24 Jul 2018 11:14:39 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ideasonboard.com; dkim=none (message not signed)
 header.d=none;ideasonboard.com; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 DM3NAM05FT060.mail.protection.outlook.com (10.152.98.177) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1017.0 via Frontend Transport; Tue, 24 Jul 2018 11:14:37 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBEZti017828
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 24 Jul 2018 04:14:36 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 13:14:49 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 24 Jul 2018 13:14:49 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBEYhV025383;
        Tue, 24 Jul 2018 12:14:34 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w6OBEXEY025376;
        Tue, 24 Jul 2018 12:14:33 +0100
From:   Damian Kos <dkos@cadence.com>
To:     David Airlie <airlied@linux.ie>, Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Archit Taneja <architt@codeaurora.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sandy Huang <hjc@rock-chips.com>,
        =?UTF-8?q?Heiko=20St=C3=BCbner?= <heiko@sntech.de>,
        Damian Kos <dkos@cadence.com>,
        Quentin Schulz <quentin.schulz@bootlin.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>
CC:     <pgaj@cadence.com>, <ltyrala@cadence.com>, <stelford@cadence.com>
Subject: [PATCH v2 4/5] dt-bindings: drm/bridge Document Cadence MHDP DPI/DP bridge bindings
Date:   Tue, 24 Jul 2018 12:13:35 +0100
Message-ID: <1532430824-23477-5-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1532430824-23477-1-git-send-email-dkos@cadence.com>
References: <1532430824-23477-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(39860400002)(346002)(396003)(136003)(2980300002)(189003)(199004)(36092001)(8936002)(4326008)(7636002)(356003)(426003)(8676002)(54906003)(16586007)(42186006)(50466002)(316002)(48376002)(51416003)(76176011)(110136005)(47776003)(87636003)(478600001)(336012)(446003)(5660300001)(11346002)(7416002)(36756003)(246002)(50226002)(186003)(107886003)(2201001)(106466001)(2906002)(575784001)(86362001)(26826003)(105596002)(476003)(126002)(26005)(305945005)(486006)(2616005)(21314002)(921003)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2294;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT060;1:m2g/cz2D8pf86bhPQR93ZJcQ+TCwSNkyo4Jidp5iCHkcoArb/QQyHw1j1151kdiZTanOq3CgWCeqsb6YMTkMbawn7L/CC5lOOEOtoAK3XehtLN04zWq77632PvkqTBIM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6418cf26-f91a-46c9-43f6-08d5f156a56f
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060);SRVR:BY2PR07MB2294;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;3:tSpvUVxi8/tehVM261bV85oBypVDOgeiCKKdhKWN4TTW6agcGRbRn67Fl7nSq0GEvn6sc7movi2gYEyRGRmhzLgOIlmvwvVL+7peFgQR3MIyEGSAwaTc8S1TKnfgEbwJ4hx+MBxJv+ml+4MMMoPvO6GjJWP3r/ZMPAGza+a0D0qh5a8q+zOPWPCV0+IzxNjRDQa6BjpB4pgPHLu2rEnHIvcPUdozsZxQdLUot8QMzp7MhYtMUwpjyFaXX22s4EcTPjdKHdEiKDeVIGQ2LRrxWB8zNM260zMLjOB6NaEkxFpPEh98UyFQleeyEdTLyX/PD27r+hjQsj3FSOpDvGZaFzZhqsroNvxZS5haRv7kFlw=;25:nFaOiBe+Zlj5QxDBrWVvDIY5ygxgmT/nTKXt3liN3aLJgE1hrkNlQgZGmLW2f5sxa8X5UAacJM4hM/SNXoZ+BpFFJ2s72VMvvOZP/MKxcFjfTmaDWbm2IfGknWmPuVD3EKVYc8zuUpnNCpVslfGVAA57I9KWcF8/Dv1aH6brTv+UiPLqCPXiI6ZkPNPLjBK8awGTE5gHP65j10eeXPDtUAdGMpv3CPOYBgRNvC7dwl1Iy/+v2I06mv6oJXcoZd3ebd9yvucIC/6lXXExM3L1A5LRYK8rwKgi9p88JXf1JWpQELCx/tb3Mx1Qp71W8MvoVZWZj51taVgBqjnTS4ZPjQ==
X-MS-TrafficTypeDiagnostic: BY2PR07MB2294:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;31:1Zq5ffdg64zkR1ZYhvPLCcFoRqFgTGJzzXDWerhZsQZdjG14BwMPA8s4+iTsWo4wpC8D/GBv1QOQttM4OP/hn/c9lCdxtCSUa3nnZ5HgPyNy+xQ4pgJAfweZqP0PsAxTqPlm3QJO0F1GUds/M4XS/PiYNlI4AngbAfokn8dB1Lgrz8Y9RtiF45eEYRs58ZwKPAHLpl4ohzGpNGoe7iIWga0NiBDHi6aqHFSW6/TYHUk=;20:OJIyTLvWL0MMKjufbcqYL2W6ygvtzYDuLuASek5LgJJETQfVRmvkcCwuNiR0vhR4Vjdz5t8JaCOHojUPZAY27nz+k6eLDLEp69hAWJj/BQGM78cM4WQYO5BWFP0CkHtcIX5CIrY25YNOcOhCZ4uLS9y38uu4dNU061k6LHGayzeo8nAT4UuUb7zyDOwpUNSLLYoiGdnY+6W2nEHFDbD+uHvRVi1WPNdR7AlkY2GfCuxhHsD/XtqjPzmQZGltob0MOVkBq/QrjPElu7HiwMnzKK4e8594Zf7bIH/IMGWYm3PdQ/OfL3WiwzCbn+SSBW5uo3IMz5akBwUFXujsE7aNdkikXpjaFcarrE1t6EV/rbDqJ+OE+zeD4kAepF3Xc2n8BN6KR+RrZRuzS6jLznGZa65hv6Ojm3rgO5gyqGt/9jWRy/kM1mBJFS8eRk/eH1qaREki72wJjBzWC+t0nu5YBqY/9S6GO+Be4QaixbpMdiUXYqm6/RGE6R+YZWJABdvR
X-Microsoft-Antispam-PRVS: <BY2PR07MB2294DDA73D82D81B577CCD30CD550@BY2PR07MB2294.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(3231311)(944501410)(52105095)(10201501046)(93006095)(93003095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB2294;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2294;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;4:EYdFLpTFRCcAVJ8BmU22SRglqbOYhz0cEqhVsVO8b91L7yMZQn771QQ/sb3LkLu15T0V1VBRUdoi/OmJt1u7zFP4zrCYvTyDP5DmDlzeE2cppqMe/PVNFbzHnlwM/uJCJUUJDnZlvlCROOvFojXD3NqAX9OyeDeiVh1O+i2RXa3D9lGFjDUKV7/U80Ejl9QIqppH7bUexXHKhRQls2YDsNob3D9rSKXjthNj1YIcEzRBlarv+70kH9s7hVbeTH3dnU7bVfRGsXm/nPWZiYGXT62+uo2zNMkoxFKTKRfBLbCb54AhrbysiQ03bRJEIyW7
X-Forefront-PRVS: 0743E8D0A6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2294;23:HjFlN399oJwy1l5dKILi3kx0Q/u/nO2qMmFX84AYu?=
 =?us-ascii?Q?8XzNhqhGxQ6T6l47Crz8wAY2UOfRQ9Uab05qfa57xfdtsN1I/ndnQL/hknUM?=
 =?us-ascii?Q?Vu7BFVYr8PUTNIsL5vjNy8k76nHxaaw553m5w7zX7Uk6PBeRF4blYQBbkoXx?=
 =?us-ascii?Q?/ZV4r+8hxPfmsQ/Sx72CupFDR0iWWOkTL57q6umuxNg/lJzUxozFD0vNQ7zm?=
 =?us-ascii?Q?5Xyh0uvoswOHVCGU+VDmLDvDMrvWD0R8N2uLVftaZi85Bvf9XK+yYuNfqDbl?=
 =?us-ascii?Q?8ooUxVWYxYHhrOthgxTbOBUuCTS4UD0/DzJ+DiZywWQuSq/YW1PnfDUhkmSX?=
 =?us-ascii?Q?D4uL7q8JLGS1ulz8sA8jzzUX1GiqSELlJpZ9QgYvaygI3fSqS4u3uSh5bVVf?=
 =?us-ascii?Q?u7LgHMj6ibo/NDXqlmwkP+wY1IRDnGRN+SkkbqSHNqfV99g1PRmmqKJOCFeT?=
 =?us-ascii?Q?ex37aHQxEBf5jSAkrMrdMzIu53/3ofFBS5i5N54s5OCCOgfWyGa50+N0Vajc?=
 =?us-ascii?Q?qcqQ/nxcO7faCq2hxzYJ58tM4nyfqtNwntl/WAe6+ERlo1lnyWafFsLxd/Hx?=
 =?us-ascii?Q?rJCkmC4XQQJwg6tFujE+1RBLfEFFYuySaq+jFbD3LGQDuusAXQ1g9bW1q9uz?=
 =?us-ascii?Q?EpjzJhXQPsh2ZoRyLdq2rtEThvOQUdz029kp3ku6XbmuDzxBsPwXHgKp0fov?=
 =?us-ascii?Q?55JZE5cCa4NY49yn035ETG1ItikTzUCYwH/Q3j1fvXyVRkXOYMVyOi8lMter?=
 =?us-ascii?Q?gRZSiUhLvUWRA8lkC1vNmyTOHhmGDXuRx6shhwStji09zMW5+zo4fiCE/yoG?=
 =?us-ascii?Q?6NPcjb7xa1MXRZ1BiNDQWkjWJd7NX5JSur7RPUrnUOLxc5ElycJBqZVP1quo?=
 =?us-ascii?Q?tVGSAzu8/i7ywnoX9EwHvtpuPzZjVolpgKfoD20528F2sA1mBvr39mINllFD?=
 =?us-ascii?Q?cw7EZNsdQ3k5Zq+UulUkM9xFA39bz1l/6J6lPPW/ShdKVwUWAUw91fjT5PQh?=
 =?us-ascii?Q?V94pueHKPy8jvmkYxwRVn1wi6InXnn4kl2UOwHa41TFZQfH2iSK4vDtkhKi0?=
 =?us-ascii?Q?Oh760js0W/ZlFac1lQCX8UhMBO1sr9n3d81TRDEicjw8cEGmkT235hPq1a6R?=
 =?us-ascii?Q?UdKI+GtUO4/68PVPKLHMkHMqXERHqK+9dDtf6wN39k1qsgJTkK+mCJ/AEhqE?=
 =?us-ascii?Q?K45fIs8y6Rn6/jxb/bppDCRkEWFwr66xT/y?=
X-Microsoft-Antispam-Message-Info: 4v6jwY7CdAcQeigQZlkDOJwMSAg4NJC61lK8LonPejzwOvR3jp2heQW9vBNR+YUdp86M8nenYRLoGrvBqFTMslOUxth6wIQrXuPkEnT5SvXLzXxTnhXvFds09/7Nny47ltZvEv3LMniiVR3CMYAKx4x2i4KdDWL4gvVv+90BaVqFyY/8NoaNb2U2uzfqTSopiH65hQEfe+Q0L4MmQ1eAVtEajCfUc7dllwieyhfIMNPx18b44tyc7SvsmjPvIdALHmmPmgge4sWMlyDKLkfjUMQE+pfepLhleoCxxMdF7I2WFg/rET/2I71Xnurr3qVkApWdJbIrReSgptYBzoDTAXfzmBicgG9p1UKdMWWi9EYIxb7fDC/xsCMfk5PGelXb2fPPVaVyg3ZQMX7R7lMQNQ==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;6:bVDn/r3yL+1dUAllBTMZHmL3F+RrLrke8g9bhNimJzU68Dxrg8oUYEyuEbjPBEiSCY7YvnVaZreLxA/FpoznhAQyJGrmUyL+nX323Ln+B1ZvsogdTfsxHyBxTqj6D2WtsSrRttW4LvVBQP0q4tN55hzpcYVl8gFAZDhbgI7hUUHvEZpRR0CQ+t13KGiR9JW3TrO932woMFJwX91nclCoYKjVp2FQKtcoHlAOIi7g8xpBdQbTCsZsUwnKxeUbM2JkdwWB4YSmxCwrj/5EMl0Cq3fA0Wl8QkElixAM/F3vdJtWPHs3S97tGonrp8QeNNaUQ1yqQwbBFsKEufH5MhHgcOECWuEwZYnT3piunaMn3ZQpTy4Dg9bQAX5Elsy8gyqTVzpN8SBZ9VEgVSYUeO54KtveZG4986dX8/LoXWlP8M9woGUoIi7J6PauiNx7/kEZlcaf9mpU6OQmKf8A5MnvNw==;5:80TS8wtFn622CNXLlUyJEu/yyC745GTbsyNTgN026/zfnNUlYsKr3EC9/VTD3TXduYfKju6Pmxfgme8fqKBxi9h+SR8b9OpYcQcivyBq+Azb270BZ7EKKwUUqTUWTROllU5vseJyXCvWrxG6OhWemzFmUUp5zxQdbvgmfhGv6/U=;7:HF2zzYKeFhlgpTmHrr0MFzYvJVG1B6UyDV5jIeejWS1XjxgawGQjwKPjpP6EeQHVdyxnSEQlrIm42ohMdG1pTzUKpz598O4uYF26W+926RQEtN7zOhQDF12HlLKzr2FCyDE7PvoCsBDBFDavhOUrxnQknGoiJHJVI9n0Sv5vEz7Rw6jAx0+GzJyx+f0o67D8wcFLDwPh3pPLoYq4dpZNfUmxq3Mag9vWp6JAG1MUsUSezpkkIP6iHhP6HrqWU5ue
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2294;20:yLnMyqljVx2YJnYcvTHkn+0dTwaGDC7Rh+oL3hYtwdlszrntp90BVWvOr8vIffqWNz7zNLcFU4VHAz1LYvs8j6ZI1mueLx7yzLop+n3uLDy6WfAD9l9LaYK6iXvLdj/O9y73u2Ramec3FjNdT7l0yOi4vOoikvKb0XCIhBciuvOUCoQmATV81Mw9SEw81/5mopj5c3AfCg8VD7irdcoRW4YKOuK6xz+xl6ijFHu5mea9iUdKTQWYY4PAa9f82i35
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 11:14:37.8119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6418cf26-f91a-46c9-43f6-08d5f156a56f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2294
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 .../bindings/display/bridge/cdns,mhdp.txt     | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt

diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
new file mode 100644
index 000000000000..dc7be7590048
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.txt
@@ -0,0 +1,43 @@
+Cadence MHDP bridge
+==========================
+
+The Cadence MHDP bridge is a DPI to DP bridge.
+
+Required properties:
+- compatible: should be "cdns,mhdp8546",
+- reg: physical base address and length of the controller's registers,
+- clocks: DP bridge clock, it's used by the IP to know how to translate
+	a number of clock cycles into a time (which is used to comply
+	with DP standard timings and delays),
+
+Required subnodes:
+- ports: Ports as described in Documentation/devictree/bindings/graph.txt
+	Port 0 - input port representing the VGA bridge input
+	Port 1 - output port representing the VGA bridge output
+
+Example:
+
+	mhdp: dp-bridge@f0fb000000 {
+		compatible = "cdns,mhdp8546";
+		reg = <0xf0 0xfb000000 0x0 0x1000000>;
+		clocks = <&mhdp_clock>;
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				vga_bridge_input: endpoint {
+					remote-endpoint = <&xxx_dpi_output>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				vga_bridge_output: endpoint {
+					remote-endpoint = <&xxx_vga_connector_input>;
+				};
+			};
+		};
+	};
-- 
2.17.1

