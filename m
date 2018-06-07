Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id o6BzDykhGVuAOQAAmS7hNA
	; Thu, 07 Jun 2018 12:12:35 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 640E6607DC; Thu,  7 Jun 2018 12:12:35 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="c1q+ouzT"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 76A13608C1;
	Thu,  7 Jun 2018 12:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76A13608C1
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753544AbeFGMMS (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 08:12:18 -0400
Received: from mail-cys01nam02on0086.outbound.protection.outlook.com ([104.47.37.86]:27525
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753076AbeFGMMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 08:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gHQXSDMWKmX4MWt/c4hHSktaqbYx0ySqKW9VAldFNdM=;
 b=c1q+ouzTlq5r5i0aPyvQhhmBX2EGhvmw8+FMNiTTBLk182q14vDtaUgw7vAxv7HSzIkA96Fc0htxyYa4DGZe67gqYYltOa/g1icaih1N3yYsl8K/WkiIYfOEcvs5mZrvGbciFntQ7fFcLdnUWc+gSzmZjvQWrO+iB1H315DlETE=
Received: from BYAPR02CA0025.namprd02.prod.outlook.com (2603:10b6:a02:ee::38)
 by BN6PR02MB2353.namprd02.prod.outlook.com (2603:10b6:404:2a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.841.14; Thu, 7 Jun
 2018 12:12:08 +0000
Received: from SN1NAM02FT064.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::206) by BYAPR02CA0025.outlook.office365.com
 (2603:10b6:a02:ee::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.841.15 via Frontend
 Transport; Thu, 7 Jun 2018 12:12:08 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 SN1NAM02FT064.mail.protection.outlook.com (10.152.72.143) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.841.10
 via Frontend Transport; Thu, 7 Jun 2018 12:12:07 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fQtlv-0006Lh-Fk; Thu, 07 Jun 2018 05:12:07 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1fQtlq-0001FQ-Bx; Thu, 07 Jun 2018 05:12:02 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w57CC0DD006549;
        Thu, 7 Jun 2018 05:12:00 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1fQtlo-0001F8-1K; Thu, 07 Jun 2018 05:12:00 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 39A8812157A; Thu,  7 Jun 2018 17:41:59 +0530 (IST)
From: Manish Narani <manish.narani@xilinx.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>, <mdf@kernel.org>,
        <stefan.krsmanovic@aggios.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <adrian.hunter@intel.com>,
        <michal.simek@xilinx.com>, <ulf.hansson@linaro.org>
CC: Manish Narani <manish.narani@xilinx.com>
Subject: [RFC PATCH 3/3] sdhci: arasan: Add support to read Tap Delay values from DT
Date: Thu, 7 Jun 2018 17:41:40 +0530
Message-ID: <1528373500-24663-3-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
References: <1528373500-24663-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(396003)(39380400002)(39860400002)(2980300002)(438002)(189003)(199004)(47776003)(486006)(59450400001)(186003)(26005)(51416003)(76176011)(305945005)(8676002)(44832011)(446003)(11346002)(2616005)(8746002)(103686004)(52956003)(2201001)(575784001)(476003)(478600001)(81156014)(126002)(81166006)(6666003)(72206003)(356003)(2906002)(50226002)(107886003)(7416002)(63266004)(106466001)(6266002)(106002)(110136005)(336012)(426003)(42186006)(5890100001)(8936002)(316002)(36756003)(48376002)(4326008)(5660300001)(36386004)(90966002)(50466002)(921003)(107986001)(2101003)(83996005)(1121003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2353;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT064;1:2yw3W+Yj89AxvwCMgt/IQX2fLolDp3stTOVJA1g0HmsPEJ1QJR366gOrW3OfuaYBkJ5iMaT+uJwEMQuPQu7Ve4XObq6e8PhSpXpN67Nl0EV0NPXi4cgh1/hwnfscQTcR
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2353;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2353;3:f+p+93OKgoDE2wjjzUqOc4+AD6qoFT4as9GuqOIeMQ+k760CZPctYx+h2RZZRMb0a2Z58/2QSbycSf4mubk7gR8CizVXqxSCN2ZcHCrCBimdPo5hXm5SQ69e4GuVQSGXnSO9YqMeleJ08zbIArRXjEWzJiO1s5RtOxPkavYpJJX7NyjAPlEWL9R9uxL4XNlfECND8/kxktdArUjPqvjEA6mes7NsBVINhjCsxEx299xE+pE53iiDQcjk66VupGIlA1u49c4U6vDfS0VazsGrbieU2jUeyJRmcbcehFVl5cUXX+nvIiwq/Sas+uEBTDkVx1vq8Q0RHgYtSDgTpEsmQLNlaw6R7u+wZsluaO/oEmk=;25:61BBduKJPKQjGVY5rdwUiY3Vy0CNjh1lpnHPop1+5yyGbG+n8TW2VhRhaDGQof3xRG2hufCKPScKmtbT4ERtGyZ1dAwcKMx4w8WSncvRU1MNDUwtzfsGIt2J8/r+aWn0sieMjo+7g8dx+w1W+sQf6d/V6GfACzNhUbShInv7KeFXhjSHtQMSXuCihLzZ6l9S5RMUxceQ1IwhZRFBDHDu2KCTPq4giEH505wC2cHW3gEazB8sxpBGVT7vwx6XrCIxpKZLyVsqFtDKQ26WHTnOX1PDQCA4P8tDUIOqPLciXJJblC1ISY5/P4GYcpaEOYlyiPgCKgBF8uKS2NpgJ9n34g==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2353:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2353;31:3GWDjfXJv77ADp4HePNa35d7cVhb4wd4+UbZn+DmbD3I3JBktrJPsPdROjtnsPSMnS7Uh6FWWIDU1k2OCBzay+uOelVZLUw/9Y76IVdUaR19pqyf5ahTktne8iX+OiJM2wsVIbvlBACnuMozU55Of/ve/GgNWilK44Za7EmWj1z/uoLt+iSRpbv6AjNBhYXYkGiyCfaX9x5vE3H91OFBdqPooC5AwPSU9ZE4vZ9gpCE=;20:qhChi1qDiM+xf5caUb1SxXgV2kxvIMzOv7iR4w0uMe4g3x3LwEwWd0+jFCofVsK7hR6GCXO+E05A9kPdRA4eJ7HnZTmEk+nNBepWKT6oXKMLugSThJjK4tAGM+IQ6tkIzHSpJTfw+90k1qX87A3Y3pie0Ktfd+zqp4c3906AkTKsIltyOaREIkx09SwdWdYffYdFOsNJXhKPmWfn1R9e5tsdql0x4UYQ4GlikyEcUl4dZkuHXABDSQ3jo1Ed91JOdRGGcw9tOEYOLIHSTbC8BSu4JTXySs5UV70cZl5us5rng3JJcBsfAxNk4uDkGN4WBxbdxU8xr8nvnso7csP3Aa7Cfz6AO0yoRWYuw1ULaLqE/RSzSQItcyUv30wXqB4Gp3uryYYDBQx/KcwSHA0qrRgTaVv2pTh9okEcA8DiMk00oCmctO9gjlX7uLk4Ntbc9TJmJnd8FXpoHHVwgpGsTcJ0HGRMSn/sPK6mY/oDdGD1e3Ap5El/J3tYG35cREW6
Content-Transfer-Encoding: quoted-printable
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB23530C394A5654F4818BB32EC1640@BN6PR02MB2353.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93004095)(3231254)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:BN6PR02MB2353;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2353;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2353;4:o6kYQHKqhWR1KDc1J08VsRrJLhswooLtXclS+t9SRh4g3w4N2lsI/mvcZsW/VAhFjn1G09usgAMcPLwDrWlnW3RLdoNXskmS4X9OEA1UtT72ZB+Wkl8COF1wCbLglGaVK6baJJKlt5EFXVobQiVJKeqlg9W8nJzXAWzQCW4okav6zXlw/0pCVNVrTEU73wX4rEj3K5oFENb/tlx7Tb+se2dKxhEFLUCQ54yhjiK/wXkZcqFPHsq2xz0ZGnUFK3LG6MsGDfQUOehKlSRJQF7MGjP0gGzObzZTEJO2Jhl6veho/yDR8PJUsgPUNOsi7Gt4
X-Forefront-PRVS: 06968FD8C4
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BN6PR02MB2353;23:bDEc5jq9/gQyK7+PsXcm3AWEMSBWA4t26Ij/D2Zaf?=
 =?us-ascii?Q?6CFJhg90hqQFWBetwk/Is7taZWnGA/6hZzlMneokOFR0UbBSMetW00YwSLlN?=
 =?us-ascii?Q?U3q7y7TnIY9lopBrKfQjWFZQ0p+4k5D/JT4VXZt4/Vc9pTyZG8A44FiGhm3W?=
 =?us-ascii?Q?jp0wGnYhXrDg4KpNCVT+Zu/muAXRQGzg0JBP//64sWT+29bTQZTNdqRzkGmq?=
 =?us-ascii?Q?eqfLjR6ZiDmUpaVNX245TTbHEU/pW0ePfUmPn6BKMWCsAaN/FjeJZsLjK+G0?=
 =?us-ascii?Q?9IgxalDTMdlTZxDsvRc2j640wC0eZvZM7jySbpdwf+a+npYITg+UzZBZdkKo?=
 =?us-ascii?Q?+8U21y82qk2UQtBapEFVG8rl8+7H8Y41awCm7x9s9VHrHHfHTGTFVmouEqe7?=
 =?us-ascii?Q?c+/rmW/I5H3zegGSPn1T4fhxbJIGYi4bXKUoDbmB/Y7TzSvjaucGaNOKFcoq?=
 =?us-ascii?Q?kjdvkWuymCwPKN1jBkFggJTUGniusBvoLNmPoTiqqr9Rt1iofu5Fbe8C9LWQ?=
 =?us-ascii?Q?OX0TwBC9A/fvfPMEMRav2KbY75Md/PJDEw2qeDjkrYvH6cmUEawIs+UzPJQV?=
 =?us-ascii?Q?Af/YWbJ4YZn6a446QXZlyOoHb7rWYB7TT13t34Alvy+1fj+anEpockZOJcrz?=
 =?us-ascii?Q?Q9dJ+b5lQtRAzWNxQdL81ZQWkU1FkPbZlynt7lxmhblXheDjUbAXB172ayAn?=
 =?us-ascii?Q?fiY13r1Yc3EGZq4+HkxKX8ef/5yNJMSYkZcZL8YadxcMtb8aLLk6zcmbUP3F?=
 =?us-ascii?Q?XOWFGOFPXfsHuRrBnTiudaAoXRtJgyz6Tfz8XIVX7RzdSKxeAqb3NYPQWOhH?=
 =?us-ascii?Q?bhXtX9DazFhQ4O+EsA2U+EIE+MlE/2ccQKtvf4IzrY3OHLDSPSVQeZdcMxFr?=
 =?us-ascii?Q?552WTZVhwf/pNGE0csf6CrFgnGnQn2tE3cSUxzAF46GMRlSJ4GRvP6olEQ3L?=
 =?us-ascii?Q?fwedUP0I4qnYRtnVnXh7DLnzOuoCwX1OHBs5PS/zymUOqRqh/kj9WA+mW6CB?=
 =?us-ascii?Q?TapNyOTC/cOgaYifUQ+JvVYSmiinMeo92hK3PgCC5k72HhEuvrFw5FPTrdzy?=
 =?us-ascii?Q?19iC97Atz+QMsu4EMtdsIw/ucGT1dz2hosYGQgp+pUdF1mHvYHyEiGE7lFaE?=
 =?us-ascii?Q?i2RhTgR2TqmQCYinu/ire/Gf6u7EWyOzDbQ3w6G5fjgLcCEz5VlYkOWFkFiQ?=
 =?us-ascii?Q?k+ybWfV6RLuSoNV6/EScy6y9H6RhTc8LaGqknzDGr/Gyj+F67+GQbFnm3BUM?=
 =?us-ascii?Q?h/9VTm0GTnMD1g3Cn/FL2rP9VIc+UdwcPPB9PFMbM4bmF5WyofxstFBQ/kGv?=
 =?us-ascii?Q?2sa2Fr1cf7iM3uhtL8QbejiJ72W5L2StUs+HpDyYmtiqITA1WT4CE5HLG2Ql?=
 =?us-ascii?Q?e/01bPwJ2po2tvS0YriJTiOFuK/YOxep3AdNA3xen2syJL9?=
X-Microsoft-Antispam-Message-Info: L+buKDscGqvdxbG95Fe4PwnBs/mcRm6GS5j3BsIArHcimLu/CwXOqTFlzqJiwbs/aptaXAnCnKQvfQHN5r+SYO5NWFCJ2F2twNP0G8b2/U3MPhiMjpjXf12a4DAl375dAG9xPcQMAybcFf/orUGcKPvl+yLoR8TaiBvPO+dQrYB1b5kV5FIa24raHztRxDTh
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2353;6:eLGznyDBcSM2Yte1RXQmzGkFCOjEMAdA6pVEUntt7mhjE4IX2H2PaH05XKMiT8/j00QpqcbteiLNydmi+QKsbm7saSpebsPpZJjdAdZGJea+jfoPIfi2FFNyqMcW9kH1tFkNZ+kJ637GIdwbUmt3GjtfcB2eHjEKUsrm75wIu2vz3AjhJ2LD51qHB/tdJIoXU59ZZDdR8I5kRQ0bbD0w+fmzSWK8FyrW64ONUJmea1ZA2+x+sBqB2mZJWK/OOlfVoyjUDBtW+4gkLLe3Ysee2a2NypEAvSUYzd9mRx2qNSEryW2KK3PyuYEcUNWQ7tR3GeFDchtjR2pbkVc+KsxemoAwlOkJDxhnN4oh4wnery/gbcOUaBo5oXL3gwUB/tktrAPuQBfe+c6yW5yZn0eOsUmiYecQWWqI02c3Y9M30pRYIGP2TUP0XMybEUiMtIS6edhKSZRgSOfepeS5C/mulA==;5:c1PxEl7T91Ej/OCwDtpomn4MAsuzsUAtH0P/m4uNM3wKtqIicxQybY9ohPw8IH2em1R0Xd1Dxt7jbgLTKUw6OJUx78so/zxn9J+kEVj3tw2CAUoBEFLiRqCC8yucP0g8rTsdR2QC+ZHa5+i1SAxcULPrS+bcI4uzEndqTRn+1b8=;24:hcj56634y8AV8k5Kdylcr8Zjrc7WfHD/bhN1T5bRgJbYDB1v6uCxJv7polC3aKl+2UhWvpH0qK0OAmis7ZxxktX+EdgXvwBNU/oTC8Yf048=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2353;7:pRfK5g1S8rQXSZYnmXur9CLrC6GoDfIqV2AJciKKV+ryygywYm6XcF+jBw4cJ1sAy2rLQ72pJSakvrxR8VxOXO1EAq+dc878jvwaI8kGJhfUAu2UZ6Q/rzVrAqo1CreLQB3mVu7Ml+tCseytXMW2iIaH9KAHLrOZcMy4TaBp7MdZnlaQH7Ab/Mxi2ifymBdhJN3tWDtWCGk5BTuENqz6u+mNQSNDEpu2lfjqWqHLxxQO/+CM0L0OTz/83vb4uA/X
X-MS-Office365-Filtering-Correlation-Id: a42eb9e1-fce7-41ef-ac6c-08d5cc6fe424
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2018 12:12:07.8681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a42eb9e1-fce7-41ef-ac6c-08d5cc6fe424
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2353
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for reading Tap Delay values from Device Tree
and write them via eemi calls. The macros containing these tap delay
values are removed from the driver.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 drivers/mmc/host/sdhci-of-arasan.c | 131 +++++++++++++++++++++++++++++++++=
++++
 1 file changed, 131 insertions(+)

diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of=
-arasan.c
index e3332a5..fc0fd01 100644
--- a/drivers/mmc/host/sdhci-of-arasan.c
+++ b/drivers/mmc/host/sdhci-of-arasan.c
@@ -36,6 +36,8 @@

 #define PHY_CLK_TOO_SLOW_HZ            400000

+#define MMC_BANK2              0x2
+
 /*
  * On some SoCs the syscon area has a feature where the upper 16-bits of
  * each 32-bit register act as a write mask for the lower 16-bits.  This a=
llows
@@ -90,6 +92,10 @@ struct sdhci_arasan_data {
        struct sdhci_host *host;
        struct clk      *clk_ahb;
        struct phy      *phy;
+       u32 mio_bank;
+       u32 device_id;
+       u32 itapdly[MMC_TIMING_MMC_HS400 + 1];
+       u32 otapdly[MMC_TIMING_MMC_HS400 + 1];
        bool            is_phy_on;

        bool            has_cqe;
@@ -160,11 +166,36 @@ static int sdhci_arasan_syscon_write(struct sdhci_hos=
t *host,
        return ret;
 }

+/**
+ * arasan_zynqmp_set_tap_delay - Program the tap delays.
+ * @deviceid:          Unique Id of device
+ * @itap_delay:                Input Tap Delay
+ * @oitap_delay:       Output Tap Delay
+ */
+static void arasan_zynqmp_set_tap_delay(u8 deviceid, u8 itap_delay, u8 ota=
p_delay)
+{
+       const struct zynqmp_eemi_ops *eemi_ops =3D zynqmp_pm_get_eemi_ops()=
;
+       u32 node_id =3D (deviceid =3D=3D 0) ? NODE_SD_0 : NODE_SD_1;
+
+       if (!eemi_ops || !eemi_ops->ioctl)
+               return;
+
+       if (itap_delay)
+               eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+                               PM_TAPDELAY_INPUT, itap_delay, NULL);
+
+       if (otap_delay)
+               eemi_ops->ioctl(node_id, IOCTL_SET_SD_TAPDELAY,
+                               PM_TAPDELAY_OUTPUT, otap_delay, NULL);
+}
+
 static void sdhci_arasan_set_clock(struct sdhci_host *host, unsigned int c=
lock)
 {
        struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
        struct sdhci_arasan_data *sdhci_arasan =3D sdhci_pltfm_priv(pltfm_h=
ost);
        bool ctrl_phy =3D false;
+       u8 itap_delay;
+       u8 otap_delay;

        if (!IS_ERR(sdhci_arasan->phy)) {
                if (!sdhci_arasan->is_phy_on && clock <=3D PHY_CLK_TOO_SLOW=
_HZ) {
@@ -200,6 +231,16 @@ static void sdhci_arasan_set_clock(struct sdhci_host *=
host, unsigned int clock)
                }
        }

+       if (host->version >=3D SDHCI_SPEC_300) {
+               if ((host->timing !=3D MMC_TIMING_LEGACY) &&
+                       (host->timing !=3D MMC_TIMING_UHS_SDR12)) {
+                       itap_delay =3D sdhci_arasan->itapdly[host->timing];
+                       otap_delay =3D sdhci_arasan->otapdly[host->timing];
+                       arasan_zynqmp_set_tap_delay(sdhci_arasan->device_id=
,
+                                                   itap_delay, otap_delay)=
;
+               }
+       }
+
        if (ctrl_phy && sdhci_arasan->is_phy_on) {
                phy_power_off(sdhci_arasan->phy);
                sdhci_arasan->is_phy_on =3D false;
@@ -456,6 +497,7 @@ static const struct of_device_id sdhci_arasan_of_match[=
] =3D {
        { .compatible =3D "arasan,sdhci-8.9a" },
        { .compatible =3D "arasan,sdhci-5.1" },
        { .compatible =3D "arasan,sdhci-4.9a" },
+       { .compatible =3D "xlnx,zynqmp-8.9a" },

        { /* sentinel */ }
 };
@@ -641,6 +683,74 @@ static void sdhci_arasan_unregister_sdclk(struct devic=
e *dev)
        of_clk_del_provider(dev->of_node);
 }

+/**
+ * arasan_zynqmp_dt_parse_tap_delays - Read Tap Delay values from DT
+ *
+ * Called at initialization to parse the values of Tap Delays.
+ *
+ * @dev:               Pointer to our struct device.
+ */
+static void arasan_zynqmp_dt_parse_tap_delays(struct device *dev)
+{
+       struct platform_device *pdev =3D to_platform_device(dev);
+       struct sdhci_host *host =3D platform_get_drvdata(pdev);
+       struct sdhci_pltfm_host *pltfm_host =3D sdhci_priv(host);
+       struct sdhci_arasan_data *sdhci_arasan =3D sdhci_pltfm_priv(pltfm_h=
ost);
+       struct device_node *np =3D dev->of_node;
+
+       of_property_read_u32(np, "xlnx,itap_delay_sd_hsd",
+                            &sdhci_arasan->itapdly[MMC_TIMING_SD_HS]);
+       of_property_read_u32(np, "xlnx,otap_delay_sd_hsd",
+                            &sdhci_arasan->otapdly[MMC_TIMING_SD_HS]);
+       of_property_read_u32(np, "xlnx,itap_delay_sdr25",
+                            &sdhci_arasan->itapdly[MMC_TIMING_UHS_SDR25]);
+       of_property_read_u32(np, "xlnx,otap_delay_sdr25",
+                            &sdhci_arasan->otapdly[MMC_TIMING_UHS_SDR25]);
+       of_property_read_u32(np, "xlnx,itap_delay_sdr50",
+                            &sdhci_arasan->itapdly[MMC_TIMING_UHS_SDR50]);
+       of_property_read_u32(np, "xlnx,otap_delay_sdr50",
+                            &sdhci_arasan->otapdly[MMC_TIMING_UHS_SDR50]);
+       of_property_read_u32(np, "xlnx,itap_delay_sd_ddr50",
+                            &sdhci_arasan->itapdly[MMC_TIMING_UHS_DDR50]);
+       of_property_read_u32(np, "xlnx,otap_delay_sd_ddr50",
+                            &sdhci_arasan->otapdly[MMC_TIMING_UHS_DDR50]);
+       of_property_read_u32(np, "xlnx,itap_delay_mmc_hsd",
+                            &sdhci_arasan->itapdly[MMC_TIMING_MMC_HS]);
+       of_property_read_u32(np, "xlnx,otap_delay_mmc_hsd",
+                            &sdhci_arasan->otapdly[MMC_TIMING_MMC_HS]);
+       of_property_read_u32(np, "xlnx,itap_delay_mmc_ddr50",
+                            &sdhci_arasan->itapdly[MMC_TIMING_MMC_DDR52]);
+       of_property_read_u32(np, "xlnx,otap_delay_mmc_ddr50",
+                            &sdhci_arasan->otapdly[MMC_TIMING_MMC_DDR52]);
+       if (sdhci_arasan->mio_bank =3D=3D MMC_BANK2) {
+               of_property_read_u32(np,
+                                    "xlnx,itap_delay_sdr104_b2",
+                               &sdhci_arasan->itapdly[MMC_TIMING_UHS_SDR10=
4]);
+               of_property_read_u32(np,
+                                    "xlnx,otap_delay_sdr104_b2",
+                               &sdhci_arasan->otapdly[MMC_TIMING_UHS_SDR10=
4]);
+               of_property_read_u32(np,
+                                    "xlnx,itap_delay_mmc_hs200_b2",
+                               &sdhci_arasan->itapdly[MMC_TIMING_MMC_HS200=
]);
+               of_property_read_u32(np,
+                                    "xlnx,otap_delay_mmc_hs200_b2",
+                               &sdhci_arasan->otapdly[MMC_TIMING_MMC_HS200=
]);
+       } else {
+               of_property_read_u32(np,
+                                    "xlnx,itap_delay_sdr104_b0",
+                               &sdhci_arasan->itapdly[MMC_TIMING_UHS_SDR10=
4]);
+               of_property_read_u32(np,
+                                    "xlnx,otap_delay_sdr104_b0",
+                               &sdhci_arasan->otapdly[MMC_TIMING_UHS_SDR10=
4]);
+               of_property_read_u32(np,
+                                    "xlnx,itap_delay_mmc_hs200_b0",
+                               &sdhci_arasan->itapdly[MMC_TIMING_MMC_HS200=
]);
+               of_property_read_u32(np,
+                                    "xlnx,otap_delay_mmc_hs200_b0",
+                               &sdhci_arasan->otapdly[MMC_TIMING_MMC_HS200=
]);
+       }
+}
+
 static int sdhci_arasan_add_host(struct sdhci_arasan_data *sdhci_arasan)
 {
        struct sdhci_host *host =3D sdhci_arasan->host;
@@ -776,6 +886,27 @@ static int sdhci_arasan_probe(struct platform_device *=
pdev)
                goto unreg_clk;
        }

+       if (of_device_is_compatible(pdev->dev.of_node,
+                                   "xlnx,zynqmp-8.9a")) {
+               ret =3D of_property_read_u32(pdev->dev.of_node,
+                                          "xlnx,mio_bank",
+                                          &sdhci_arasan->mio_bank);
+               if (ret < 0) {
+                       dev_err(&pdev->dev,
+                               "\"xlnx,mio_bank \" property is missing.\n"=
);
+                       goto clk_disable_all;
+               }
+               ret =3D of_property_read_u32(pdev->dev.of_node,
+                                          "xlnx,device_id",
+                                          &sdhci_arasan->device_id);
+               if (ret < 0) {
+                       dev_err(&pdev->dev,
+                               "\"xlnx,device_id \" property is missing.\n=
");
+                       goto clk_disable_all;
+               }
+               arasan_zynqmp_dt_parse_tap_delays(&pdev->dev);
+       }
+
        sdhci_arasan->phy =3D ERR_PTR(-ENODEV);
        if (of_device_is_compatible(pdev->dev.of_node,
                                    "arasan,sdhci-5.1")) {
--
2.7.4

This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
