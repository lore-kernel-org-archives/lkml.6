Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DFBC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E72921763
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 15:09:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="WIZdxITq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E72921763
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732410AbeHCRFq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 13:05:46 -0400
Received: from mail-bl2nam02on0041.outbound.protection.outlook.com ([104.47.38.41]:51014
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726115AbeHCRFq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 13:05:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e6Kof0AmMsATiUlnf0I4i4JE+6Pb7P55tR6SYCnURF8=;
 b=WIZdxITqZijHgSrPCvyP5MW0Su9vgRaK/PYWlWhBEUOI0cO08Jkl1q88JaMGeVITTu069DrnVgJgGRP9Ri4i77PIFdZNDjcgu/qIhiFKsRGHU7M9TzEg7gEtZUmLTQRV1kPHj0VPr8SC5x0Tku9R4Ogd5dpFe3YpUNVTUFjthCk=
Received: from DM6PR07CA0014.namprd07.prod.outlook.com (2603:10b6:5:94::27) by
 CY1PR0701MB1340.namprd07.prod.outlook.com (2a01:111:e400:4c1b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.21; Fri, 3 Aug
 2018 15:08:57 +0000
Received: from BY2NAM05FT048.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e52::203) by DM6PR07CA0014.outlook.office365.com
 (2603:10b6:5:94::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.15 via Frontend
 Transport; Fri, 3 Aug 2018 15:08:57 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=fail action=none header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 BY2NAM05FT048.mail.protection.outlook.com (10.152.100.185) with Microsoft
 SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.20.1038.3 via
 Frontend Transport; Fri, 3 Aug 2018 15:08:56 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w73F8sTk018490
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Fri, 3 Aug 2018 08:08:56 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 3 Aug 2018 17:09:08 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Fri, 3 Aug 2018 17:09:07 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w73F8ri2003441;
        Fri, 3 Aug 2018 16:08:53 +0100
Received: (from stelford@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w73F8qme003318;
        Fri, 3 Aug 2018 16:08:52 +0100
From:   Scott Telford <stelford@cadence.com>
To:     <dkos@cadence.com>, <adouglas@cadence.com>, <kishon@ti.com>,
        <jbergsagel@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Scott Telford <stelford@cadence.com>
Subject: [PATCH v3 0/2] phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY
Date:   Fri, 3 Aug 2018 16:08:29 +0100
Message-ID: <1533308911-17286-1-git-send-email-stelford@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
References: <f4b7167e-a210-2196-07ba-0c22fd88fa64@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(199004)(189003)(36092001)(105596002)(476003)(478600001)(305945005)(126002)(446003)(106466001)(8936002)(16586007)(26005)(7636002)(42186006)(11346002)(2616005)(51416003)(76176011)(110136005)(426003)(47776003)(356003)(246002)(8676002)(50466002)(107886003)(86362001)(316002)(2201001)(486006)(186003)(5660300001)(6666003)(48376002)(87636003)(26826003)(36756003)(50226002)(2906002)(4326008)(336012)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY1PR0701MB1340;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BY2NAM05FT048;1:ZQ3PxRMvmFtL9OF3KEBucWskzVTSnWtKGhGha1XvAlB9bc8HZU9F9GusepWO7POoKTWXNhkWBBPPhuEDko8Ks3DmA7s2duoqtZ8FyZmb+u3fBj7Qa5nEsiKfyEe9YqOv
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f70d1993-0e07-4324-8b6b-08d5f95308e2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:CY1PR0701MB1340;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;3:grO2t9F1SbkTKBWR4HKdINfIkWLTmK8Wt2sdCLMyRYr7JqqmJFbLxWUc6fUrScxjCLDzMroPZnX7LtR0IM7WM0EnwvWZ6izqRp8qWh1ThFmwvDHBgL0orskEqXsVoZEdSZe2uw5Ylt9gw4NkbWUfFnu9KRNHaMLMZf0OmcquiQT1+EGvmuGzREbLQSZkmZEPk6VOxfxujtBImxi3bfu3kbR3yoN6zpzQUTTpdVVs7PdZhIZFatJIIqxdgOwKPxPCuM3zUEwYdnO/2fJ+dmSskLOpZTkUQ7Lced/F9YDZyWMRrAPZVBgcfm4hjVzuBAYHzq+iq5SnXkRNiqcbLLdIidXfLRUSwFdFDZO5I9RzeZw=;25:c31fwB+xzgDKmx9bhZ5Du6+TA3DA5w1JiWG2KMyPtOlVh+unGeVOvQFIauBl8D+s3qFmHj0Lo2xF4MOA9cdr0KFV0Y6d6H394uhpVlZZFqAS25dNkMqb/ki/7TgkGhFpWzRbo6Pd6W1y0jk2t4dg11N9Dd1Tm4WYnY8ymvGSBKNNikZcxHFA/zStEdDyGgcxP4JahTi7nMFvlWuTHjBwdoUirkr7Wml7RWjSB+sWQ9LQiND5u2EJzBZie9DkKTuODuOBsg7LeBJF3B7nruOSnc08tU0D9oru+FvOjOZCCDZ2CLPQGGxREzFMcT2JvvmQNV3pVaKuN8p+/bpDqs74WQ==
X-MS-TrafficTypeDiagnostic: CY1PR0701MB1340:
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;31:+fVUhch42VBOaRgXpVIt0KJDesb8LbzO/PmAsta6l0frbps5EES+U1HfMnAl4skpGEXNDRr3fB34AHnl28MTHPia6U/RnM48kWZR8yIUWS0+X4EeUGA9PqYDhPN81iooWdSjgG/lzCcGC7sLijcFyTkaAEK4fdzZxJc+Ylj1idN8F2wP3pOFrSqvEx9mB3YjsUBZhwiQeeiPB0bz8bjFYKAMBJ4OJOpawqWfeCFap+g=;20:vzk1GB80otx5pQGTn2RM5e2fkuVtJijTnsGf1h7Mea9qngXI7v7btUwGRR+2DGh4RBB802TJKca1BR4DHmdU7g75I8rzvX/q+x0aCEly8J23Xme8WtHEwspL8S7cp56gvaow0FPWnJ03Kl+/Wmb7pn5SYyDfBv8ckJcMnqUEYnGGyFxQOZJzg8MIuqMPIot1qf0sBKVi9GNOm9UvHx6KKT194goTzj6B7WrnyORzQPRqESttJ3BKfIkoqX87zxR6k5gfSkCsgcb6+xfFrPW5Q2QQj8j+bN/Oz6vW49/Rq+t3PnjmVxqTlEWWZduayeMj7i/4vON9coN6RFMPAJlP3tdncNdrDAyJtipgU5WNx9o13WGb1J/wR5srXdQw76TbdJChoTSOWRjJBwb8pA6kb+PXT4udN2wIl14TEdGKPvdOj/brPOtL3tyqXM14KzZtQhGQENc0Wcfc9YL8a96AV5pFiJi/z/sJTbu9vJ9hrW1XINVyBmnCVpqeuGS7rt/Z
X-Microsoft-Antispam-PRVS: <CY1PR0701MB1340758F7AC60C8FEE67D52ECF230@CY1PR0701MB1340.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231311)(944501410)(52105095)(3002001)(93006095)(93003095)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:CY1PR0701MB1340;BCL:0;PCL:0;RULEID:;SRVR:CY1PR0701MB1340;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;4:ADEd2cTOCu1RCRKdkH630J7owJa99UFKBAcOHUAfPpiV1iQ/MO4npwdiURosxzS92NKKfGZNoQTNI4YfO2SJpEnh5GcBA/I/uOgM4XH1u+N4fcIC6JN1sWTWSfIfxu5f7Pmgv4lSqlH961VkP0RQU2g5axYHNulCRLk9nQQ0+k8KJbmI5A110EKd4MV+hTr0w8qLsZlhlvEZqDoDWeYillr8IFkoXayWpojwfl5kaITO+8spr2PSMDg/N91nV8yI0v/nGguG67/9Dqe0T8CzMQ==
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR0701MB1340;23:++It6IrPKlpqXArkSyXzl4eycxIy2L3SfNK/KzV?=
 =?us-ascii?Q?2GwZjiqW3FqMKNLBIAUol3Dk6fW5sghdFrYvP9XGECIdJgpJ4uykG7PeZlIM?=
 =?us-ascii?Q?XbrlqOCvlbXb7nQpeRXSbFcgdAnbfjATY7ag1QPpkihIXs+8xL1az1K7aX6a?=
 =?us-ascii?Q?+XmiUJdgbCLtdnzfkGNv/tnsSFYBRd3qNpXWtliGmJKY50bDEwjSFVb7Cb+M?=
 =?us-ascii?Q?zielLWZWgorzhXXmofiZoc7V7ebr17tNLHuNaFyqa7A+oE4exJy6BLnbKOzN?=
 =?us-ascii?Q?5YykUW0vcFprwpwkPz0G8BZeTbJNaH1d0BUmytvkmWVkkBd3xtarLce38vh5?=
 =?us-ascii?Q?spVdKx+nDVJG/Mi0Ntw14XBVxRKIekBzN2GOkCNe934nJwYeg+CUAEP/UwyC?=
 =?us-ascii?Q?xQh0awifl2YWX0xtFUKJ0dE/FZQON/2egPdaS+VvY29uEVH28AJTCMCcjewi?=
 =?us-ascii?Q?P4+g1uemjYdQ19tep809MQlgHwBOR3o9bx3kvwI4QIYX72FUGIIu38jtx1RJ?=
 =?us-ascii?Q?m3bRq2xFfV86HTpck0RtLLkbcAHQG1SpbEXherb9ZxT+fTEPO/Yob7S8bfLw?=
 =?us-ascii?Q?VBhjuX4WbPZR4BBHX7gN0AE7Y+QSRudNjbUfcqwL0uLND/WKyq4biu9QLkc0?=
 =?us-ascii?Q?F4gsQqVlgf7K/HRgOMyuYNVC2OIjzjeMYxWQEZnrTGN3P4uJIPZ9TQlf2lhX?=
 =?us-ascii?Q?JgSDhkK7yptE1LqIDLqJ1cWYUp+zjkmuqcUXQKUeQefDyEfNj9BFUBewBnm3?=
 =?us-ascii?Q?WVtslZAz1CVANtunaro6tgde8cpiaD07dvUCnGqgjQCw/hVX4ZZ/RwjHnd0O?=
 =?us-ascii?Q?q0ixumfDqi7x1bMrXlaR5WE2+LkxK+xFw9EqH7l0Q87XZZFIOS58wTH41Fvf?=
 =?us-ascii?Q?ZM43c1T6Z8WktnA23uDbPK/jZ0b7SsJX7y2CDhWMofggsVExPCWv6O3dU0L0?=
 =?us-ascii?Q?m2ABctMZ0Z1QMFwhXVEBBcXL+4tj2V7AJa01vXlAaGKWH8y4PwQsYrm5l4mi?=
 =?us-ascii?Q?HFWvCzPB/EEkR1kYyHtMZ4+XCiXNvJc0yjaIV/Cps8gAR3Ois5vWPGNjYC/r?=
 =?us-ascii?Q?OtFZjx41/M9HUBvTsCxZoc6Qmyt3Ps+kBw5ucNzWN1rTwLE6NRQ=3D=3D?=
X-Microsoft-Antispam-Message-Info: mn3E8SFVxKv6um5Do4aF0yUnRruZnZQE/d17luZOExZUN62hU7iiXCgRDqSgqXGaBP3LVitWvYvJaa/F9/Go9bxMsjEhDsTiu1oHW3iVMqkjPsonXrPQvIvPpnKuRTavBWLJYoSwcDy4/KpmMcl+/HWaMzU3YPxdkqo/3JJrnnHHjQIsINMSgWuqIJF/rAfKoyh2qianQNlB/4DhHtKoa3PCWMjXIXWxqupPOPfppsP8sbO9TJXUQZzX0hl1q7e1IODdHCcaJp/wAveQWw8AffBw476wR2PQuXh65apMJ/tCq5DZ4qaArrs4EthBCCztcBbYSwrxWAHL0srgbw5bUj+R9nibfv0P3emTJoOZpGDv1X7jnY8M9Vrk+8xSqBdPaKFKkDgoigrtVbWlXjMxgA==
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;6:4JGSYCIQEa0HZfqoOpmbz+YJ3ckh4DylOH+tCC0E3pHgaUhCILvvqHLYNlAGpcmNMfj7mq2OK4wRlJFfNOkCTLHSwPgLXyHH/yI4cKZ0PdWnSATm1TZFTrgo+35XZP5hcfVM4oRpCTMIDMzXc284VzZyQKEOJXxBJkvNwDDLJSVY25bQ4Z7Pbt+AcZ8jAl0vRsYBuG6bsCP5OCFlhHe9nu8GdV9h0k7CMBnAbCMuy0uK+pXhtt4TR7cIHsea9wfBISAJ1QVsGGCOPA1T1/zLv7TeYjX7c18qQuxm3VVt4qlo5EWAFNg1kjRQ/I4uUbOuuyKTkGH+foRv1BADXmTsviiW0DNF4jar+F3Z1jcUnMXQLK31YfBPUI73QPUJvsHkez5FR0GYLBjC0Im9yo57CgZhImk4UtkhbEqf8MjyKxw9R4zZlCNsoAkIfg4+Dk/6/GCTfTXNCcihpczXCG81vA==;5:Kh3jMU0fIcwrWABzY4QgUnITtteCb+6A9tYUjj8ZZPkcL4lx+aLoKpm120359Xy++zvJUtBDCV+raV9IsTX/H0kLIxbwMeGZtKs/QxeyPwH79TtFci605ECDVItToIolsxCCDpE4mp/647bTFCqyqhmCghb72mkh9B40eHKKnVE=;7:3tshwuT4kh+//aeq1AvsiHN9CuJs+qeAvsd5I0ltKn9tnvj1j/yYv32J8iImcP03pMZxsNExJK8xF828/4wUm2SeXTgSxr2uzDYH7CJp4eKQ37+6y3S1BBCbyUFeFTsWM6JwQe66WeKRE8k9+m89KKYqKFBoOZAmTL/Vqlicz5okNezqIUzNj/0hxjifwvAZDhMoMC662ynv5eoLA8Zqu4ezoS6OQE8YoKNsKRM7l/m8df+gDVPRLlkel3JPpElV
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR0701MB1340;20:VhIALgBz2WGabMr7C5+Wavq8TlX5BvtpTOot2zXybGSUGAVdqGTmckmA467lktGaZq8ryuelm0yn9sa8CuXxDhCJAjeQ5DOi3nfGkWbUOh5y2FUK4J54H/tk85j3b+SK36han0FSIUfvdWTteKH0E61g/b4JINxrfbHNW7dYVZ1ZMMTERKwjcq3K+09jKMvbTu2lptHbKgG+THb+3ZWhOhSJLxTmDZnuJtnHEp4gcLyIC7vkYrWreW/yiwFAz3cP
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 15:08:56.8834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f70d1993-0e07-4324-8b6b-08d5f95308e2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR0701MB1340
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches add preliminary support for the Cadence "Torrent" SD0801
PHY used with the Cadence MHDP DisplayPort Tx controller.

Integration with the MHDP driver will be the subject of another commit.

v3:
* Split devicetree bindings documentation into separate commit
* Merged phy-cadence-dp.h into phy-cadence-dp.c
* Moved probe function to end of file
* Minor refactoring of cdns_dp_phy_pma_lane_cfg()
* Fixed SPDX comment format

v2:
* Fixed Linux/um build 

Scott Telford (2):
  dt-bindings: phy: Document Cadence MHDP DisplayPort PHY bindings
  phy: Add driver for Cadence MHDP DisplayPort SD0801 PHY

 .../devicetree/bindings/phy/phy-cadence-dp.txt     |  28 ++
 drivers/phy/Kconfig                                |   1 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/cadence/Kconfig                        |  10 +
 drivers/phy/cadence/Makefile                       |   1 +
 drivers/phy/cadence/phy-cadence-dp.c               | 538 +++++++++++++++++++++
 6 files changed, 579 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
 create mode 100644 drivers/phy/cadence/Kconfig
 create mode 100644 drivers/phy/cadence/Makefile
 create mode 100644 drivers/phy/cadence/phy-cadence-dp.c

-- 
2.2.2

