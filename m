Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75D2C43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3004B21476
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 05:49:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="K+QrEQbg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3004B21476
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732603AbeGLF5f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 01:57:35 -0400
Received: from mail-dm3nam03on0041.outbound.protection.outlook.com ([104.47.41.41]:40246
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732191AbeGLF4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 01:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uA7jx8eTzJgYlX2fCCU9r/WocTIs+mTsH62njhUpGSg=;
 b=K+QrEQbgp50yIEu6Vth9w3uc7MMkJjOdpOQAhds9bhgjKuAxytAvXomnsyLcq7dMc2F7tuL9ous9wV6wsJ/zeAju2rURne1TAT4ceI2nRa42gJVWF9kNVzFgv9PU24cHDgjWYl3j3gbbyvDQl3gNhR4maf8z691KsqEchNejmMk=
Received: from BY2PR07CA0029.namprd07.prod.outlook.com
 (2a01:111:e400:7bff::24) by BN7PR07MB4708.namprd07.prod.outlook.com
 (2603:10b6:406:f0::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.952.18; Thu, 12 Jul
 2018 05:48:02 +0000
Received: from DM3NAM05FT043.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::207) by BY2PR07CA0029.outlook.office365.com
 (2a01:111:e400:7bff::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.952.18 via Frontend
 Transport; Thu, 12 Jul 2018 05:48:02 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT043.mail.protection.outlook.com (10.152.98.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.20.973.9 via Frontend Transport; Thu, 12 Jul 2018 05:48:01 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lkwC032054
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Wed, 11 Jul 2018 22:48:00 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 12 Jul 2018 07:48:07 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Jul 2018 07:48:07 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w6C5lpA1029816;
        Thu, 12 Jul 2018 06:47:51 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w6C5lpXK029803;
        Thu, 12 Jul 2018 06:47:51 +0100
From:   Pawel Laszczak <pawell@cadence.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>,
        <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <adouglas@cadence.com>, <pawell@cadence.com>
Subject: [PATCH 22/31] usb: usbssp: added procedure removing request from transfer ring
Date:   Thu, 12 Jul 2018 06:47:19 +0100
Message-ID: <1531374448-26532-23-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1531374448-26532-1-git-send-email-pawell@cadence.com>
References: <1531374448-26532-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(39860400002)(396003)(346002)(2980300002)(199004)(189003)(36092001)(446003)(2906002)(11346002)(106466001)(51416003)(105596002)(50466002)(1671002)(48376002)(126002)(2616005)(476003)(87636003)(486006)(50226002)(86362001)(5660300001)(54906003)(36756003)(8676002)(246002)(4720700003)(6666003)(305945005)(478600001)(356003)(26826003)(7636002)(14444005)(186003)(4326008)(26005)(16586007)(76176011)(316002)(426003)(8936002)(109986005)(47776003)(42186006)(336012)(107886003)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN7PR07MB4708;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;DM3NAM05FT043;1:HjvNHypQNA/S9N2PWfxIaZWiOKbsooQu2w9irB0G4Evk8tBcyCimJnJy9TqHW4QY/D3gDPFoUkh6u9j29TNBBU67FFiupBliIKbp+Uj2/mlWNCBmdWWJSwnYYkui5DnM
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 679a5818-ff38-47d5-fab7-08d5e7bb07d8
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:BN7PR07MB4708;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;3:v7I30rEFpLJzfWYVskW+IFmUnfcMSIwqx4Y13MhlbC+cXE0D2igqUnz58jNM6TPkU4Vd1MnrWtM3ZtnGidCuIJ9PxlhpumRSUmSreMMIzIhzvgMcLpjMXB/eX73lzcloG/CELU/Hjl3DCLlpD17Ya1HfSwmZGfh4RqfcGKyAcRFmn2cs9MLZoXXP+S/KYdXX06bw6GDk/ElM7d8nnZQFF6jrYJQXqXSQWWurEn2HDAO32YZvLxbdRllEOJGz0bkSKryCvgsgPrurXsvL1CvjkBb9EgXn5/zZWjWgTgXaXPWqIfsQEcwXIDiDhDCngbEE4g3FX1H3n8twZj6UMVkbKD8JpqxwhNpYu2L2nyPMRGA=;25:g+q3owEwiXOxf6X4zPnNMHq/OyuBUAhAi3XM3KPISnafCQX1mPxCnWOUuE0vbteR6sjz3wKc6P/pLuNA8EEoqdlmbLG5XsWYcrXiDab9V3BlTDhZOGevC4uPsICUwfRUwbdD8KI7Z9G9FpSZWIMPw1V8p4SFc6UTn1uD4bCAtaiRstqSYzwnpc3gw7fzbZFssqn/ozQRg0Tce1+JyAXQqAJ7dfQ126i/oVhk7rxSZWEF6CxdzZEEpX/2TTFfOFhffth6KRWiOS5Iu8MzCct6SlfkPJiVEsP3MOZ4JaycSV2zCPo4+llmrqEoZoHMqFAJI1DMZzzzeHFZbahYMuqCvQ==
X-MS-TrafficTypeDiagnostic: BN7PR07MB4708:
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;31:+DfBIrBlv7TeviOpolIQUVaQ7BuIcK88Xx/ibDh/rw/TI2DdEeAL6zPPKle+CAY+bz61qPUOscb0mIox7s+0ojUFuEkeeqiyZvhfYoIXCSpi18RW8H8tJmAZmec+YTZpAXX8O/DqX3UC6svTOUqIyRVNwNM1QZYYEv/xe75ZuYYnCRK+Er4wvzSN77++NuTsSNHJ8JXsSb0U8iAr/2MZHmzS6UhtM+uExa8rIZ6KN38=;20:JrunIclr8x8IfN4drOerStGqTKNL7omn/UKi8uoX0VttQg7KtMg8hBOPySGUVpoySoyJfAffJvspV6BO/vRjSjRLl+rO1GkAU+MBgzny7NCWdLzQrtgPu5i2iWwlpwr498nuHoEGSpmviEOGMopRR8XUgVoDs8qWlgsg0zG1l0e+dkcUgKiDl9RabxgdeiFOe0f3UHZKfI4VU7nKcjSouQUIcXbvJdqlgbO9szl5mQ0fg+YMFVLwzqxqgw359OVGSMyLhQSWuYc4r33dDJ/9lqJeRts1VDXSl2f+xXlWymxvwzgq3mzAaXGhdbRHsplUMKBoy6rCtqdrhaT0UHbfCfs06ZWibgJw0OW5npL/26Ajde4Ju0OqZRJ3sqeEgiVOP15Tdn+bKLGPbiPidoATY6m61gsmu+CdLCaj0G7jcXEWa5Q9mxN1lIsPPahX1SdD0fTxjN7GtrwGNqpJLRlwOIiUvh3NwF7EqQoF8iWHxOR6Pr6OXVtquzgeOSctnDy4
X-Microsoft-Antispam-PRVS: <BN7PR07MB470898DA1D972504B44FF353DD590@BN7PR07MB4708.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93003095)(3231311)(944501410)(52105095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BN7PR07MB4708;BCL:0;PCL:0;RULEID:;SRVR:BN7PR07MB4708;
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;4:CpN2+slEp9yZ/uOJN6jyzkH2vc+YoVd4xVMmRhSRM/KKb8+loGlvHl4Zi3FPI+snb8vByH02iMPcuAdnDQksWwqhmxvIhsIB9loPBNO3Jy4NQzt3KUw7/fgIsS+5fbCvug1FbE8wvCtCKb5h8cnjt/AyVa2PfKmdWQqGhCeY+Ho32ZpcPlDFDi8AraJyaAMkGe6PLVXTY3yVEQKk+mbBdjwmz+QVGzVMyWg5JW7dgZj5VGzPANbqs02rz11bXe1Jk6E1U/Dh6vlq1wqvtZPqIzBO75jM+UkEdfmpROQL6Kd7Kc/27tG9VEz9B6XCjLJG
X-Forefront-PRVS: 0731AA2DE6
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN7PR07MB4708;23:3h5nvAPPOgcA12aDW3V6u8hZ+fRo96TPKDey7rCOn?=
 =?us-ascii?Q?DpxXFCKcYMz9+yjTIm6JMMJci4UPyDtzZCzx+DKpa2PnebvweZB86nxR/+NC?=
 =?us-ascii?Q?BFm0SfQ5AwacjidjsTFkECJeHfR0i7dsKseWrwH7vb/3wdpIv1oC/9k0Fdle?=
 =?us-ascii?Q?0HecW/rXeBfxtszH8Rl1zCOeXFIFpC5QcfVKcV7XWNs6emkrvKTZNmSm1k0r?=
 =?us-ascii?Q?2TEgFHRCSQlzsdCF5KDXieXykLOwpMQdz09gC7wt6wZYfaT0vEZp7+5EjoT3?=
 =?us-ascii?Q?PjE1l4pcDV0CYSMBXuABBybiL9Ig+aZOthCZLEMt2lngJ4JuqeaEtUALOKgZ?=
 =?us-ascii?Q?Ru7UHJ43rpQuzkPbiZf8L72R4g7fIxZS8L5PqxFPYZHu/jGGRGk1RfNVoDF2?=
 =?us-ascii?Q?/1CmM0aWja1AKDktHyFofbZxGvmKHW0zqB9XpN9hKC4KbJBYA5P/3lmt+XW7?=
 =?us-ascii?Q?Q0C1tMFdHNEUa8FDjjxH9vvXYtILTBApROa/X3UXUmWCU0Xi76CQ8go+Wprj?=
 =?us-ascii?Q?/WmHObgKqxbFKrtdM+Q+/AsjypLh+9VM0WUxxNmBgK0EanDdCLldKc8By1UZ?=
 =?us-ascii?Q?tGoh41TRkmrsBoZiMSs8nP+CFcqLtscInlD4KZWUYtNpEb00UKt6taKGfbj/?=
 =?us-ascii?Q?yJZVdQy/T9gAW9PTUh4SFGMDqECCr08Wb1BTtR6t/vIa7iUBUebk8d9tfJhP?=
 =?us-ascii?Q?bAqPJi7N3slC0Izav7FlqGMdk6b1odgKdpMqsgK6WIK8g0qMt8uWydLbW/U+?=
 =?us-ascii?Q?ZWOda4A8te0e0WiEMIW+uchZFhwRj2jPasxQBvsPvZwP73XebV6ck/r0/Ay3?=
 =?us-ascii?Q?tGCbc9BDM6lHnmtXlWAE8V6gIGLV/aYp0UBeGTqctD7r36zIsRM8Sfak4W46?=
 =?us-ascii?Q?JjMutMM1k8fRr2fQavV8VWx296OWvGaDnsvxwF7v9j0Uv3LJ0SdreO0+B99h?=
 =?us-ascii?Q?RpDklYh9woYsvC8FoUh33YrqtNEn+lpiqfRYr788sD+7UnJi9N2h+6+wSqYD?=
 =?us-ascii?Q?cjPpk2NSCuIVZtKw//2lGY9zax9mYgXvyxjz8D+w1QttzsXFPK6dOBx71AGn?=
 =?us-ascii?Q?+x2JG28g8KBgERP1WBIrmycpP20hc9Xri5HT9baGYa0ENoROzgi9W/fP9lgx?=
 =?us-ascii?Q?6665+m57dBkH3aQ3mDB2fL1O7G3PizpIpdr+EfEHR57qiBOTdEZug=3D=3D?=
X-Microsoft-Antispam-Message-Info: KjeTllC2Fou9MxokCQ0RTstmw6zX3M/fIgjIjao5pc7R15UWH9X3Jy7BHCObKcIXUHGW+kT0dLemwqzhYeFht7gtAMwkGvDKu6hCfU1RcfWIGDNLJebtPSeu8UKc9rkOoB6e8b3AqKtVw7jgmVjpkbHX8c6tuC03eWdC+Wx+3ZCRoWCxuEH2inSulALZDQLjPliPJmDqAh6zYztZgr/Zt03e0dUacPB/JLCdENpH5Vxq/yvRefFRWHjfKPepkTWX9SPwqY6ZbNeHnpFHnkG85kuclFi6CD4UrKkGlvEfZfAJykAN9UWjptIYrBIIOHbOIpXEzqPp3F+aYsOPr2k2muevLp2Et02ahzGfarBWIZKJWYxjVeH2LiPOV5mTi0pB0ZU6F4fqt+WwCW8a4a62kg==
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;6:LwXvc33OwjBb4HF+AzNzbXLgX+NY+gIQeTmybFxpnZZnW+eG5RvOZpVUwwcH/3vUoyPY926TRcGNlqa2ipJqzwsgpB6gdpKXxzKl4evllZKu3Fae6PbEkWPO3lLTJRh7f/48wn+beZsg9cy/ukYv1mUWB++x0Tn7DvI1dNDhjIPAWAvXVENaS6x+YFYw3IrTNeRzGGs3gb1ObnrmJbiO/58i+X3txo+pEatyvs7VSZJxP4RR5Q412Msais0tdE3q6NrCk7aLB6zdlE28qKsr6hQCLtiYdmJxB+Pv78VvZL6DlAqbK3WkpXcZE66q8vpl3+laKg5OqOtm3+mLTB61zTT87/CC6gcscpyphEgrd+7rZEDB8YSovDlSQLfDcCWNAhklAT8SQv1Wxa4aBzkDy4fGe1Nc+dRoQmagjWSZJO3zK5iVBN6rzpaFt3BXrVTBfHgGDUff+pqIYQMA7cXdxw==;5:B/OKqV+Ik03UJmOlYMSk795fkH2RrGRYkn/25yV+Se9Hvo1YOoGNa8P9bnL0nRJgPQi6hYAq0ymNJNEVD0eQ0nuUd7qVBjbWCqhGKeA3yV7OyZCIr1rmJcykYQmZ29K17yjzAgz7YV9+GM6pfZGRHzvyfJR+Ajf2wqjA9R9EwEE=;24:vM73BnueVrTg/y/k6MGi9NEDPFvQmqDjZyRtIkZpBGQXcZ3nX5fkAlY66VIacpb7eJHaoNRD7dxfNSo++X/V3mtarySYnKnLytgYwgUoT1g=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN7PR07MB4708;7:mHwIi647920Rr5lv72nU9kPBkaQ5jDofImuLHbBQSultIlZNEbjGN0sxKS2mBZYgrAPBv3+m9cO6zPod+FRjbn3z+SzO5geCIEO/Bm5YVN/KLBQv3YtSxqaZwAg3yPFeJxg3d+gCd+EjgJ5nsr4z6Na6b2cZavT/i0qQcOVco/3naiSfOCIxA659TFHRlEAHFwYQx0D7CzGbup8dyj8IeMSwbqJtyJQtDvavrzHheywu6PeeaHZx0gWYqp7Xlors;20:ymiweqxlWCDkkGzPoTzscFrkHPesWNkKEZnV5aqHk2CbrobvkQpKDe60Ya/BnGYgEWyBQMt9WHkr32D9x/39uNLcviAy2WMjApDQvEFULLgyOB4pNp+CIWG590+xwB6euNr2SE9CLz77NFWbD83JMwXl9cWmTzNjxIJMe6ON/7CMp02deMWynHev2SMN555qlkhg0/HVAltcFjlhA11gfFdjd5M24w1y2ncRN55qGxqow7TlSJyJG6Z/KBJS8keb
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2018 05:48:01.6697
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679a5818-ff38-47d5-fab7-08d5e7bb07d8
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4708
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
 drivers/usb/usbssp/gadget-ring.c | 325 +++++++++++++++++++++++++++++++
 drivers/usb/usbssp/gadget.c      |  49 ++++-
 drivers/usb/usbssp/gadget.h      |  10 +
 3 files changed, 382 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/usbssp/gadget-ring.c b/drivers/usb/usbssp/gadget-ring.c
index 1ee6b056c87d..08597127d495 100644
--- a/drivers/usb/usbssp/gadget-ring.c
+++ b/drivers/usb/usbssp/gadget-ring.c
@@ -102,10 +102,50 @@ static bool link_trb_toggles_cycle(union usbssp_trb *trb)
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
+
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
+/* Updates trb to point to the next TRB in the ring, and updates seg if the next
+ * TRB is in a new segment.  This does not skip over link TRBs, and it does not
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
  * Don't make a ring full of link TRBs.  That would be dumb and this would loop.
@@ -344,6 +384,156 @@ struct usbssp_ring *usbssp_triad_to_transfer_ring(
 	return NULL;
 }
 
+/*
+ * Get the hw dequeue pointer DC stopped on, either directly from the
+ * endpoint context, or if streams are in use from the stream context.
+ * The returned hw_dequeue contains the lowest four bits with cycle state
+ * and possbile stream context type.
+ */
+u64 usbssp_get_hw_deq(struct usbssp_udc *usbssp_data,
+				 struct usbssp_device *dev,
+				 unsigned int ep_index,
+				 unsigned int stream_id)
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
+ *    the last TRB in the TD.  We toggle the DC new cycle state when we pass
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
+			ep_index, stream_id);
+	if (!ep_ring) {
+		usbssp_warn(usbssp_data, "WARN can't find new dequeue state "
+				"for invalid stream ID %u.\n",
+				stream_id);
+		return;
+	}
+
+	/* Dig out the cycle state saved by the DC during the stop ep cmd */
+	usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"Finding endpoint context");
+
+	hw_dequeue = usbssp_get_hw_deq(usbssp_data, dev_priv,
+			ep_index, stream_id);
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
+			usbssp_err(usbssp_data,
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
+/* flip_cycle means flip the cycle bit of all but the first and last TRB.
+ * (The last TRB actually points to the ring enqueue pointer, which is not part
+ * of this TD.)  This is used to remove partially enqueued isoc TDs from a ring.
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
@@ -362,6 +552,141 @@ void usbssp_giveback_request_in_irq(struct usbssp_udc *usbssp_data,
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
+	/*
+	 * We have the DC lock and disabled interrupt, so nothing can modify
+	 * this list until we drop it.
+	 */
+
+	i = req_priv->num_tds_done;
+
+	for (; i < req_priv->num_tds; i++) {
+		cur_td = &req_priv->td[i];
+		usbssp_dbg_trace(usbssp_data, trace_usbssp_dbg_cancel_request,
+			"Removing canceled TD starting at 0x%llx (dma).",
+			(unsigned long long)usbssp_trb_virt_to_dma(
+					cur_td->start_seg, cur_td->first_trb));
+
+		ep_ring = usbssp_request_to_transfer_ring(usbssp_data,
+				cur_td->priv_request);
+
+		if (!ep_ring) {
+			/* This shouldn't happen unless a driver is mucking
+			 * with the stream ID after submission.  This will
+			 * leave the TD on the hardware ring, and the hardware
+			 * will try to execute it, and may access a buffer
+			 * that has already been freed.  In the best case, the
+			 * hardware will execute it, and the event handler will
+			 * ignore the completion event for that TD, since it was
+			 * removed from the td_list for that endpoint.  In
+			 * short, don't muck with the stream ID after
+			 * submission.
+			 */
+			usbssp_warn(usbssp_data, "WARN Cancelled USB Request %p"
+					" has invalid stream ID %u.\n",
+					cur_td->priv_request,
+					cur_td->priv_request->request.stream_id);
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
+				cur_td->priv_request->request.stream_id);
+		hw_deq &= ~0xf;
+
+		if (usbssp_trb_in_td(usbssp_data, cur_td->start_seg,
+			cur_td->first_trb, cur_td->last_trb, hw_deq, false)) {
+			usbssp_find_new_dequeue_state(usbssp_data, ep_index,
+					cur_td->priv_request->request.stream_id,
+					cur_td, &deq_state);
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
+		/* If necessary, queue a Set Transfer Ring Dequeue Pointer
+		 * command
+		 */
+		if (deq_state.new_deq_ptr && deq_state.new_deq_seg) {
+			usbssp_queue_new_dequeue_state(usbssp_data, ep_index,
+					&deq_state);
+			usbssp_ring_cmd_db(usbssp_data);
+		} else {
+			/* Otherwise ring the doorbell(s) to restart queued
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
+		/* Clean up the cancelled USB Request */
+		/* Doesn't matter what we pass for status, since the core will
+		 * just overwrite it.
+		 */
+		ep_ring = usbssp_request_to_transfer_ring(usbssp_data,
+				cur_td->priv_request);
+
+		usbssp_unmap_td_bounce_buffer(usbssp_data, ep_ring, cur_td);
+
+		inc_td_cnt(cur_td->priv_request);
+		if (last_td_in_request(cur_td)) {
+			usbssp_giveback_request_in_irq(usbssp_data,
+					cur_td, -ECONNRESET);
+		}
+	}
+}
+
+
 /*
  * When we get a command completion for a Stop Endpoint Command, we need to
  * stop timer and clear EP_STOP_CMD_PENDING flag.
diff --git a/drivers/usb/usbssp/gadget.c b/drivers/usb/usbssp/gadget.c
index 2b16158c8bd8..b4e26aab1fb8 100644
--- a/drivers/usb/usbssp/gadget.c
+++ b/drivers/usb/usbssp/gadget.c
@@ -553,8 +553,53 @@ int usbssp_enqueue(struct usbssp_ep *dep, struct usbssp_request *req_priv)
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
+				req_priv->td[i].start_seg,
+				req_priv->td[i].first_trb));
+
+	/* Queue a stop endpoint command, but only if it is
+	 * in EP_STATE_RUNNING state.
+	 */
+	ep_ctx = usbssp_get_ep_ctx(usbssp_data, priv_dev->out_ctx, ep_index);
+	if (GET_EP_CTX_STATE(ep_ctx) == EP_STATE_RUNNING) {
+		ret = usbssp_cmd_stop_ep(usbssp_data, &usbssp_data->gadget,
+				ep_priv);
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
index 0870635ef728..f1cf120a2f54 100644
--- a/drivers/usb/usbssp/gadget.h
+++ b/drivers/usb/usbssp/gadget.h
@@ -1766,6 +1766,13 @@ int usbssp_queue_halt_endpoint(struct usbssp_udc *usbssp_data,
 		unsigned int ep_index);
 int usbssp_queue_reset_device(struct usbssp_udc *usbssp_data,
 		struct usbssp_command *cmd);
+void usbssp_find_new_dequeue_state(struct usbssp_udc *usbssp_data,
+		unsigned int ep_index,
+		unsigned int stream_id, struct usbssp_td *cur_td,
+		struct usbssp_dequeue_state *state);
+void usbssp_queue_new_dequeue_state(struct  usbssp_udc *usbssp_data,
+		unsigned int ep_index,
+		struct usbssp_dequeue_state *deq_state);
 void usbssp_handle_command_timeout(struct work_struct *work);
 
 void usbssp_cleanup_command_queue(struct usbssp_udc *usbssp_data);
@@ -2288,4 +2295,7 @@ __le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data);
 void usbssp_giveback_request_in_irq(struct usbssp_udc *usbssp_data,
 		struct usbssp_td *cur_td, int status);
 
+void usbssp_remove_request(struct usbssp_udc *usbssp_data,
+		struct usbssp_request *req_priv, int ep_index);
+
 #endif /* __LINUX_USBSSP_GADGET_H */
-- 
2.17.1

