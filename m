Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0488CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 81DEE20875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 11:14:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="L79HLqpZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81DEE20875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388536AbeGXMUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 08:20:35 -0400
Received: from mail-eopbgr700084.outbound.protection.outlook.com ([40.107.70.84]:29867
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388400AbeGXMUe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 08:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BjrDoEdnEig8q0LumSOZDu4XqS+2Xyia9pUaFoB+hoE=;
 b=L79HLqpZIgtbwZ6DoY6ZC06YVeQ9N4QCPUor4e9fZGaC3+S6BTsJjxD/JbH7Y8eVtJrIFO3N9oNY7Ez71VxnXdbGg9iw4yEjFQMT7I7naMSvl/RpIcdBhnmjlG3u9Q79+v1qL+7jUHM1sCJycMXelwJZkZ19ENAGRs+oSsZtTAo=
Received: from SN1PR0701CA0024.namprd07.prod.outlook.com
 (2a01:111:e400:5173::34) by CY1PR0701MB1338.namprd07.prod.outlook.com
 (2a01:111:e400:4c1b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.973.21; Tue, 24 Jul
 2018 11:14:29 +0000
Received: from DM3NAM05FT053.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::208) by SN1PR0701CA0024.outlook.office365.com
 (2a01:111:e400:5173::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.973.16 via Frontend
 Transport; Tue, 24 Jul 2018 11:14:29 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 199.43.4.28 as permitted sender)
Received: from rmmaillnx1.cadence.com (199.43.4.28) by
 DM3NAM05FT053.mail.protection.outlook.com (10.152.98.167) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1017.0 via Frontend Transport; Tue, 24 Jul 2018 11:14:27 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBELVY027537
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 24 Jul 2018 07:14:23 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 24 Jul 2018 13:14:36 +0200
Received: from lvloginb.cadence.com (10.165.177.11) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 24 Jul 2018 13:14:35 +0200
Received: from lvloginb.cadence.com (localhost [127.0.0.1])
        by lvloginb.cadence.com (8.14.4/8.14.4) with ESMTP id w6OBEKsq024982;
        Tue, 24 Jul 2018 12:14:20 +0100
Received: (from dkos@localhost)
        by lvloginb.cadence.com (8.14.4/8.14.4/Submit) id w6OBEI3V024937;
        Tue, 24 Jul 2018 12:14:18 +0100
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
Subject: [PATCH v2 2/5] drm/dp: fix link probing for devices supporting DP 1.4+
Date:   Tue, 24 Jul 2018 12:13:33 +0100
Message-ID: <1532430824-23477-3-git-send-email-dkos@cadence.com>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1532430824-23477-1-git-send-email-dkos@cadence.com>
References: <1532430824-23477-1-git-send-email-dkos@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:199.43.4.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(136003)(396003)(346002)(376002)(2980300002)(189003)(199004)(36092001)(53936002)(4326008)(8676002)(8936002)(26826003)(107886003)(110136005)(478600001)(316002)(87636003)(54906003)(356003)(14444005)(7416002)(47776003)(126002)(476003)(2616005)(6666003)(81166006)(16586007)(42186006)(336012)(2201001)(446003)(11346002)(426003)(6346003)(5660300001)(26005)(186003)(86362001)(105596002)(97736004)(2906002)(50226002)(486006)(50466002)(106466001)(68736007)(51416003)(48376002)(76176011)(69596002)(81156014)(305945005)(36756003)(921003)(21314002)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1338;H:rmmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT053;1:bvqIi0apoRS8frbuWee1tSqJRTyzj3EkD2rEHfUxNrM/5QV9nDG5HxCBJ3HrWSkx8xr/mbBYNqgzaAWc1r9pC/duq3SvC9w2zr0t01P/rHl8ZrFPaCpzpsdfeSCiXjKp
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e16ab85a-ee9a-425d-f361-08d5f1569f7b
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600073)(711020)(2017052603328)(7153060);SRVR:CY1PR0701MB1338;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;3:vMfwseh5W20fdNneQ/+qqP0g9e+rBu7xWD0Yy3axTkD7Awo1SsrfcdNZiuEQ3G2oLsnwl2rv6M2NX/u+wQCkkvVeziFStLT8eXq7bYsbAFYYogU2zROxY0zT2JUbUJ91inRiuvomqn91l3q/GHvMA8UVHkI4R1YMY0zNbFV5nOgrhkvp5Qesd5t3BzRc5SmdSK2Gw+AYJ5mOHJ4itexpTWGMCqHMxo6T0rXOrj41J+4th6AqAN12fXbi8IkxIg5brZ1mRSNJ9kLUMr0bZwjeEJMWAxptQtPIPLPqGklu7gZi5+62ILGYGJom4IBI+txfvIxMhH/Lwh/kuQGTa9MrEg==;25:YQtwsfjXqakOn8g2gGXU3kZ/MnTAYbVEB0HI5qBXqlqZsz9yHBy40pl2PtAheL098DAB9Q1FUcWzh23H3A1lipaYotrP++/nmutl4YPGdoGBYkMtB+9ZUKDARrImQ5z4IPPwoqMiEE+amjW7bFU2lDU0mCz3zuTG5RxY4IkQvM3SsgluuiO+rgaobgiWWGiTQKO4Iq93AAvCdYWpGNNJH+k2e0RN3To5RtsSxgLaWW/hu40zhfNCfMYHtkNzjP0s/aLYWsFlxVkYDoQXrmepXL2YEAt1cosKuEFm7mTP5n2nk1NBVL1WUnciwPJ65A2/Pnze58F0UsM6UX6iueHrMQ==;31:auWXFqQOk0cVXHewjp1TXMidQwJD5Kw7I0JNBVTgn3d2D3R8KWDdm+BkBL9SI8f7MtR/TzM+9/u2YZWzANIO/GTYFstAVq/8RevCFPtY+ZaGbio/fzohbzXHy0KlQyu08TzuZwrP04BZQKoZrDwn3Jmhble7LTm53qTNqmf5q+mcNrX6aJHTtMAEI4E1kH41JevzK8mC+GsAgQjJhaOdKSDAP8SoGl5NNKDXvgAYbRQ=
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1338:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;20:N2/K20MrVaJVmPyuO7vygmbAyTXT/uwVVsjaiv/QwKKBi5aVFBpTLaDpvZ4LWtSFq8Z9AkVv8N4U0r97PlKDW+67OIbLnEf8v0Bwurt3aVyyFvFo267ydEHVICYhIuHB44XVTmU82wr8tmAOEboPR9jijslUwRDk8dwUNjpk0W/1BtTiKu4dKqdlBejftFfQpZBrlxBJS1YTh49AbNackBMB4hqUfIILb13OUSb12QRFI5raZQz3VJEMJXaA/A88GUCHDI/Gf53bKzxu6Y24GAA1ggFSqIRHwtCVzEEJiKuDQljDcL05c79Yp5IIWpKsq86ACscMtD37xtslvbyAyjyUmhujU+GW7xIFvSGUgPIBTHmT57Q9xeswNvjLJChYM7dDKF/Mvg1eyaCJzRTP7ixKLsXbUoLHA497FePL8u7TN96aQIfnA24Am1S9Rhx/RfuW9euxz1oVl1g4IKfLy7ziSzb+pk+ezV3/ofZn15OjroDHLBOGqvcRLL8TW3Hy;4:r6c3voTbEKLun2qUBWWaZ+ntfWdPuASsgUKxn0E5EvEez2sVgrVX60Utm0GyMmh/sgkyVe+NDERP1ek3uAO33NMG6aG1Tyf0VKE6qSMcaGDKvsZyVB2xQwqz0p4aNQQneQJsi3zrY8jaG/A26D3YsFnhPSBoVACH8dIoMwIz2w2heygZLgb8Hv4G9wCTH3mM/vkjf0lo+Guf0qugmN4J2aeVBvBT4N8qU+uewS3ZGywUMgyA9UvLGYxtr0blo9YdLDkMiK2Ezds3qY2No5F9soaEUqsUfTZVZ+DK9aCR2qLx+ePiPb3xkia70QXhXVsj
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1338C228D9455ABDD67ECFE2CD550@CY1PR0701MB1338.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93003095)(149027)(150027)(6041310)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1338;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1338;
X-Forefront-PRVS: 0743E8D0A6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1338;23:5g5vR82+DdgNhdW/U9EhXS02fxORyWFNBLjPrBI?=
 =?us-ascii?Q?cXnUnWm3Nht4k4cjsQYsN3f7mvB0r2LRoDtEbAhVeLKKqb5PmmT/kJFHFXVP?=
 =?us-ascii?Q?gCUHrdRd14VU+SgzQbMN2meNuyjeTnVQWyA2HH8VUx8whH9Dl1CJClHEyMyR?=
 =?us-ascii?Q?ordG/n+oErcdJdIMG8A6r5jkjNvBbmXpd2LyWIunvNnfe1Rq1LZzxpbLSp9l?=
 =?us-ascii?Q?jHHJYApaPOpPDYC5MuqyyrPLUHqJEv8yjiZfms8bl5AwfI8zs0Bh72ke97Qs?=
 =?us-ascii?Q?zrSTPHNPXxgeQNqpJFEaLXQ3+Ejjo0yweFiXDWX0LhWYKyjhC/lGGAHGF0YI?=
 =?us-ascii?Q?66IapcpUq877XPmwnBs2Og7FFLEpTZBIGcB0ue2Ciu3I4yhVEf9wbCTicIh/?=
 =?us-ascii?Q?FsHPBh4yTCG0Ioz+Qp0GXUIHXp6zhkxmFWPTRyF+Fy3PQdjvFhEU215PNMVl?=
 =?us-ascii?Q?TEMU7jaK/frXzSfaSFCcu2nlcjSIJHMyjZyj55Knqk78aWKxqLEXkX4nzZVj?=
 =?us-ascii?Q?J9meVgMpbF/f0gf5dNT43JZ4/HJzVGPzPZM339hK31R+A5sgwTRxSY2iAQrG?=
 =?us-ascii?Q?Y4q6i2iGtIzVSGbm0HGQuSSe/tJmeRKSbyF4mnFSG3iEKWIE6yYIECzmD89R?=
 =?us-ascii?Q?C4wH7zhru57RROTQ2HyJXpXfzOFvZEMfl2mjtsHT5smffy0aVdZdVev2VXYX?=
 =?us-ascii?Q?k685YNqFYIo3D0HQChcBjKQF7Wk9iVmFMZ583t3pRp8G+F0qLUj5/Hurh7x+?=
 =?us-ascii?Q?h8rb15hZCrPvUBXoKmQfPmUTsWgXCNmijNGWOssYBvugklvAEu2YIgdXfIlj?=
 =?us-ascii?Q?bN+1yB4Mu+nrUY5M8sfY2v2WDKZ22MoMdChLyWo8aZ2++g1Ltj6i80Rcn/6Y?=
 =?us-ascii?Q?KHEmHz/RdrQ2jXPNUdyt9liGT3vcePnrWGdLbbY05DHtRx+NbY95eqUas5qf?=
 =?us-ascii?Q?ibjVbkCU/9qKqrqlTZuALCKO7Ke0xMJuhDfC+QHnzy8FHYgl0i2ebrH4uBGp?=
 =?us-ascii?Q?BBBjeckQTcciCPhT7O8Zv6vdJlRwEVsQtlqUtIi8BtmtHV+gT2I7wllgP4Dh?=
 =?us-ascii?Q?Qdo3ZpZXkSv+BzbavgB6755dBHdNXcGIP8wEa+1YIi6yD+ADgubJNzOo4+mZ?=
 =?us-ascii?Q?c2UZmZdEu5qvsa5x1147T9STGFgSUags74TMBQBxj3TJ61WJP19EfQJYCvb4?=
 =?us-ascii?Q?s0UdCCkZNR2F44cC2v6UTvfgVlCJfmKgtqN6cbVYzthbK1f9WVttm+JgO/cn?=
 =?us-ascii?Q?PLmt+ZvQi1fsrhsUvUXQUqFwSKz9Lrcaa+7krwEvQr9UR718NXo1QP7yNJOV?=
 =?us-ascii?Q?KEufGtXI+yftpmJ6CJcbyJTqY6Shb80y556Ars9N9oBQw?=
X-Microsoft-Antispam-Message-Info: WAm5fP5f3b1hlGBlwkUhbo6jpeCdufP7XZJrBMjEeuSXVRHpowpKuQuFfoY6Ze9D5A13SskWirucPxksHWkFo+Z4Q9ca7sxykSuRLLZk+DKJjibe9465MCFGVL/IT4fbCimzU778Rc4lYAD5PiUDhsZZ/7aghny8hagJnja9d5LJGxgW+KnGh5Q9pjdegj7SbqAYN3loJvP/mImtX4tj7giGV2SvtPDjKPTJx8iZV26gUTrJcvkzs2KW6n2w+yzmkudZR9yaLObrYq/FCbYCk+EcU7YH5iDc2vF9G+AKAzg2JrMQgTlLyVPrlfgFxCHVa54Zee9slOm8mRfAoNNCYskRLIpfCgPvQrVL5KAJdpcITH5tSL+8HkHnM4QthlocfdOreZtgLmmkjmA0OlrASQ==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;6:cvehMfP/lgrNccfSDTE5+dnQZ2OgdR9ElxvyBN/3KiIXnh/jKE5sSlbAVDzdVSlDppb+vF1KKbvhlgdxogQcQe3TJpGqLmDqjgTS71ARufTuJCsOmoSRYFZYa4HTIx9fWNRxl4Bq9dNtIdl6yyEQFBw3Dj+npkfK5MGJDgK+gyN+KsbPjUpfRZ4UbgpR40XcTbUpokdRBLPPBHANAlwKVoMJAwEhaSvm67GJ79O/+ubAmhlUHnoL1Zd1nEvJ74SIVbI/sCMJ6G6h8dq8UCg77o1GZUNg/KiS0DMnB/6IkvxyGmdgP7h1QszRShAMh66xaOLnOyAEg+ln/DVwOZHilGUHcTHttNqkM4mdk0OhtviUjPTGZqc24DQYhQqwUo01eVF/mtcuWSk76fudrR+rcFQ+eR1mhPBD+BvmENYioSfkLqncE1WXJV2eims2L5NHBTy9tQpQI0LXI7bdvXUS6g==;5:SgxoiRwisf3cMdkZY6WdrZTqF4dU/S+fGtP8+bZhXacRt1LAju/VDN3P6sWS5gpJc7nacp+UPSe8Imcr8hQVASoOIrbpnS8P63a/oaZkQOIqmHApqmYogJgAxG+qo4CoME/UodGdn6mIyOAuHZKR36v5AdP9Ft0ob0zMcpPrasE=;7:46x2Hzz+0sRhgy96F0AOGHjEUR1EC9wAyz9X9XdWq2MLE1+NOOCFtD4pn18cRyZSy6s7a1rCd4VrfCIm/GMhOtX4n+JOhcNdQd1fNJ55W2vcwx27ZOF312FXu/8Hfdd92gOYp50SXUh3/yxK8x/i111pKs0aMuZeiaTfNe+XdA9q/5XPUS+qlrQCdFGozxNqcFZ/q8HmZAMIdXHEhjqqhESNvpu9NVQHFCtSRX/8hTiyfsuuQwmx3+yygkiLdj1U
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1338;20:xa8uK4udM+j2uAJft8uyiaCFbWdZQ0b9BMlV1ayiAyDVKT3pTHCwTu3uisqif1vTtu16QilEEAGfJhcIQIJMgdVBhjjY7UAfhDjB2wHd+fP6UoM0Zk7kLtOaA0uMPMzQI+rDBx92Vo0/xwOGvYqRpV6rI8aPm052DW9U2+9xdraHvNSUBr6uYbZER1v9L73W7zDVanEojYjUh52mgvcwRZFzLOIhnEw/8zWR7A7PeeQfyY99IrjF3+OlFpTkaad+
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2018 11:14:27.9850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e16ab85a-ee9a-425d-f361-08d5f1569f7b
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.28];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1338
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@bootlin.com>

DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from DP_DPCD_REV
to DP_ADAPTER_CAP should be retrieved starting from DP_DPCD_REV_EXTENDED.
All registers are copied except DP_DPCD_REV, DP_MAX_LINK_RATE and
DP_DOWNSTREAMPORT_PRESENT which represent the "true capabilities" of DPRX
device.

Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT might
falsely return lower capabilities to "avoid interoperability issues with some
of the existing DP Source devices that malfunction when they discover the
higher capabilities within those three registers.".

Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved and read 0
so it's safe to check against it even if DP revision is <1.4

Signed-off-by: Damian Kos <dkos@cadence.com>
---
 drivers/gpu/drm/drm_dp_helper.c | 30 +++++++++++++++++++++++++++++-
 include/drm/drm_dp_helper.h     |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_helper.c b/drivers/gpu/drm/drm_dp_helper.c
index 0cccbcb2d03e..86a070269c87 100644
--- a/drivers/gpu/drm/drm_dp_helper.c
+++ b/drivers/gpu/drm/drm_dp_helper.c
@@ -370,10 +370,38 @@ int drm_dp_link_probe(struct drm_dp_aux *aux, struct drm_dp_link *link)
 {
 	u8 values[3];
 	int err;
+	unsigned int addr;
 
 	memset(link, 0, sizeof(*link));
 
-	err = drm_dp_dpcd_read(aux, DP_DPCD_REV, values, sizeof(values));
+	/*
+	 * DP 1.4 introduced a DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit in
+	 * DP_TRAINING_AUX_RD_INTERVAL register. If set, DPCD registers from
+	 * DP_DPCD_REV to DP_ADAPTER_CAP should be retrieved starting from
+	 * DP_DPCD_REV_EXTENDED. All registers are copied except DP_DPCD_REV,
+	 * DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT which represent the
+	 * "true capabilities" of DPRX device.
+	 *
+	 * Original DP_DPCD_REV, DP_MAX_LINK_RATE and DP_DOWNSTREAMPORT_PRESENT
+	 * might falsely return lower capabilities to "avoid interoperability
+	 * issues with some of the existing DP Source devices that malfunction
+	 * when they discover the higher capabilities within those three
+	 * registers.".
+	 *
+	 * Before DP 1.4, DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT bit was reserved
+	 * and read 0 so it's safe to check against it even if DP revision is
+	 * <1.4
+	 */
+	err = drm_dp_dpcd_readb(aux, DP_TRAINING_AUX_RD_INTERVAL, values);
+	if (err < 0)
+		return err;
+
+	if (values[0] & DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT)
+		addr = DP_DP13_DPCD_REV;
+	else
+		addr = DP_DPCD_REV;
+
+	err = drm_dp_dpcd_read(aux, addr, values, sizeof(values));
 	if (err < 0)
 		return err;
 
diff --git a/include/drm/drm_dp_helper.h b/include/drm/drm_dp_helper.h
index 05cc31b5db16..92800f2241b1 100644
--- a/include/drm/drm_dp_helper.h
+++ b/include/drm/drm_dp_helper.h
@@ -125,6 +125,7 @@
 
 #define DP_TRAINING_AUX_RD_INTERVAL         0x00e   /* XXX 1.2? */
 # define DP_TRAINING_AUX_RD_MASK            0x7F    /* XXX 1.2? */
+# define DP_EXTENDED_RCVR_CAPA_FIELD_PRESENT BIT(7) /* 1.3 */
 
 #define DP_ADAPTER_CAP			    0x00f   /* 1.2 */
 # define DP_FORCE_LOAD_SENSE_CAP	    (1 << 0)
-- 
2.17.1

