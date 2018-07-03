Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F70C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C6BE21F41
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cadence.com header.i=@cadence.com header.b="RGkBvw/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6BE21F41
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cadence.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932580AbeGCUBK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:01:10 -0400
Received: from mail-cys01nam02on0047.outbound.protection.outlook.com ([104.47.37.47]:12064
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753056AbeGCT61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 15:58:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=279lHT22WLJsJpP/Pq1nFblSDcptW5YWd78AhYEAZ70=;
 b=RGkBvw/YNhJcKNAIJx9xREZutm5O10L/PLS3fRPU2AKYS7PJOBpZAhN9IS89VZDFl5JTndfDt5OqN6GHn3y9At1PCX5E6kmX9xyxjKSSsHiZ4nk6P5yX5CNmHAdfHriWSvp60OQrAsuiT+OAKZxIVld+1zS5mDyQGUvz2REa9pA=
Received: from CY1PR07CA0011.namprd07.prod.outlook.com
 (2a01:111:e400:c60a::21) by BY2PR07MB2293.namprd07.prod.outlook.com
 (2a01:111:e400:c50d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.906.25; Tue, 3 Jul
 2018 19:58:21 +0000
Received: from CO1NAM05FT028.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by CY1PR07CA0011.outlook.office365.com
 (2a01:111:e400:c60a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.906.24 via Frontend
 Transport; Tue, 3 Jul 2018 19:58:21 +0000
Authentication-Results: spf=softfail (sender IP is 158.140.1.28)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=fail action=none
 header.from=cadence.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT028.mail.protection.outlook.com (10.152.96.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.930.2 via Frontend Transport; Tue, 3 Jul 2018 19:58:20 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwFYq005316
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 3 Jul 2018 12:58:20 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 3 Jul 2018 21:58:33 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 3 Jul 2018 21:58:33 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id w63JwGQK011971;
        Tue, 3 Jul 2018 20:58:16 +0100
Received: (from pawell@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id w63JwG49011967;
        Tue, 3 Jul 2018 20:58:16 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-usb@vger.kernel.org>, Felipe Balbi <balbi@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <ltyrala@cadence.com>,
        <pawell@cadence.com>
Subject: [PATCH 05/15] Introduce Cadence USBSSP DRD Driver - added gadget-port.c file.
Date:   Tue, 3 Jul 2018 20:57:49 +0100
Message-ID: <1530647879-10007-6-git-send-email-pawell@cadence.com>
X-Mailer: git-send-email 1.7.11.2
In-Reply-To: <1530647879-10007-1-git-send-email-pawell@cadence.com>
References: <1530647879-10007-1-git-send-email-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(136003)(39860400002)(376002)(396003)(2980300002)(36092001)(45074003)(189003)(199004)(42186006)(316002)(486006)(16586007)(76176011)(51416003)(14444005)(336012)(36756003)(2616005)(86362001)(126002)(476003)(11346002)(26005)(186003)(446003)(110136005)(54906003)(426003)(7636002)(50226002)(4326008)(107886003)(246002)(50466002)(4720700003)(6666003)(356003)(106466001)(2906002)(8676002)(305945005)(105596002)(478600001)(8936002)(87636003)(47776003)(48376002)(5660300001)(26826003)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BY2PR07MB2293;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CO1NAM05FT028;1:9etT/Nxzm3IvFmTgbWLjFiSalKdEiskyKfSTcmodTMMOb/obyN/ZZ29lCllBOghRSmfPvPnUk0cq1Jqnct/qJ0fLutgdJXxisGCwLBp9GnSorcF28OKDJOWP9vUZF5Jt
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b2d8e8fd-e3aa-4fc4-7c0b-08d5e11f53e4
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600053)(711020)(2017052603328)(7153060);SRVR:BY2PR07MB2293;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;3:i0dfppaKmQgLXCT3WdiKOs4zC1GY0Piw3HnruRypU8wMuQUM+WNEq1dW7a4N9MQdHMDV7n55DKoFZW4p9BH3eDF95fFfV8ICcQr2SquTl4LPwsmtG/sAaimtIWal4EUeTUnoBnRQSWO8mtM5pr/ptsCrNtCh57e05XOsJOn9dA9+aay60kssVDtlgjV1jSWIHRNlSOrchS5nqiFLItfkCKma2XAJK7oeBdLfwEHRrfBBllg59E+4UomchpeDh/J+UDyB4p4GMVEptkq4YVnw654ZkE1KNM2XJbijklHKIOcoAAEMMGaiLpfOx0hc52QC1SZe67g6T32My+U8TMODI/Gyan6QiFa7msDVVnnfN4A=;25:Ot+c5tNugine5pS9mQMgkI587ThxgsdAymiGjJFlpqJr+uEteDLzrMToYjPvfU0dxj89CuGIOPnZt+bbmFhwYOaFQRz3/cdM1pDEVzYwuRKWS2QqfrYe5VRW2veJ1VX4JfXSx9iVj7YLQwlqkMdIeg9B803nodVjX/6vuW6aEWei9p8/ce4Pg0BBsBh6wBPoz+ZDZUygjTbflghN4jYDkXHaPLaTr/saMra2mveVJojGTsIQZGNYtQlqSgvaYmXy5nkmglf+R9XbjL+r+EJJfGNnxJoZy1rH2wpEmkH47AsJkCtTW/iZuDngdr3QTkuUQTHYeQ1LJIAbc6JvKIDMmw==
X-MS-TrafficTypeDiagnostic: BY2PR07MB2293:
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;31:vYdE90uv1cqE2jI1R+kHXKuU74nBC8F9iVM6Mrj0LGUtWLckqMBw3etyB8J1H55YgukyJzBlc8k89ucdJxaPlQpWaJ3S/sAbG2Kdy3PzipzYBleLbKw7/5tefrJ2ENu4hVCBSmD00lKL91Tyfhw5bnfreyu4NnaCp6JbbflDFigdQTur1qHWx3Fsbd+R/BjL/ZKQjS72ch38LYDL5vtxZsEbD71oDJiAS8KpcGgPsaM=;20:HolBH73Bz4+yRunQZQlxKaBBeFfDWdh09d4kJAYMI9fjYtkb/5duyfKrr97yDGjX+8fpOB0pWzdQPsiX9ZUEVDP5UIpMOcmCMtGZAkZ/xZi63QIaxJjOEUD03orS3KPqo/qvNPGXS7ll8yp61+GqcmyR0sUpZV5kzb4JI57tTk0X4kDysk5RLA1srD9f9NyNm72RoQ6ouuKCqpiDSjAia6e3djNDCqHyvxRGPTF+CrC/qdQnSqDliwKSvkqrWjDtyrDo+9vPp5BgzTGrZJb4rzPTcuQxoPcYY7ImbBTdIVu/HHks5ToPFyZF3GHzOeOOZAY1HABf5V31mnpHG2vqLpVHRKx+8SjMOkX9sNohHJ7NJeQSHwyVQJyk4XMaJHWRiYhIarI6E4pC4KGtyPl06so9xhWs4iaQVL7S801frOJMT1H+mOqYzIF6YrPgpyRIF1a7ASuNjKo6y3Dd1xh85vjutPcE+lFnGDTwb2TsXY3BSxMEE7cpO3vSel2tqnAZ
X-Microsoft-Antispam-PRVS: <BY2PR07MB2293DD1CCDB63B70C89E688EDD420@BY2PR07MB2293.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(21532816269658)(72806322054110);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93003095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:BY2PR07MB2293;BCL:0;PCL:0;RULEID:;SRVR:BY2PR07MB2293;
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;4:xFuz1R5AlbL5bAxH1cuAlC4NhYP7SeY5HsF/0U1WuuqcuiC+SB0lD+YiWEkl6jxj62xVHsXLJIsLBkVRlhuhRdhGN6DR8kjqdcht0vkXOo8Cv7V7LcdalSch3f49R1c/KvdJll6A9tykwMoL+Lo51LEluiU8tITvEFxDOwOFhhSisKXywqNTnA351ljitOfV+/xUd8ac2tbEjz/GbHpftKV31X6SdR3q/I7TBHknxT5hEvS/mxClFOhMsxDiXvXUPXNlWROXfJ0AZ7K3pqLV5yPklf8xdfPkw6KOq55FPt7dVg5G7+WnUa1DRHEADgH2U6gc/00nj4NDagBWZFPMxN1Gx8FAQv94hBNMrifZnz0=
X-Forefront-PRVS: 0722981D2A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY2PR07MB2293;23:J/eOoCSBo+AytehND5mpWLQaYuI8r0/HTp0NriT+U?=
 =?us-ascii?Q?ibmBqBijgmucUT5Otf1OQKy4CvUOY172fU0cFd9W6cmfB0Z7HI/BLz883arU?=
 =?us-ascii?Q?ekBbCIL2ucXQ+woWK+Py5bjpoL5egwGXQ1zmkuhs9i7kFyVPoK7h+WbMDe7n?=
 =?us-ascii?Q?L4NZj7kJ529K2OsAY5khKXQibsEFs5t//R0Y3BeHUeU1+j4EccwoWFpBnBl7?=
 =?us-ascii?Q?l/322onbbED1rhPGJLo1mxJtuMRXFaMgyvuh01B+t5psbtne0niipu/qiqW+?=
 =?us-ascii?Q?Wylt371VAOaOwrB9sOPaKsgWOjB20OdiTOcg8puSESvRnkePDHTt24sM2FHp?=
 =?us-ascii?Q?V0hLUez+O18KSYz73WPVAT4nJvDERqGJgvR9Ct+qzIX9YYRUVNWoY+NebxWf?=
 =?us-ascii?Q?75LlOLcPXC5Llx2Il6TxSRSTktePvLCPxnVhbmTN51iK+A+xJIA1TfmQiuP9?=
 =?us-ascii?Q?c98jJqTfMRhHUsLzOGR4cCgRYAJ4fQDumU0Q/XO3GmCJbJTT9CmfrJ1nQCrw?=
 =?us-ascii?Q?ReJb5kO6kgd/gwWY3vduGComdxDPxR5RSTkISwMEiB4/ie064vMFNueox6gP?=
 =?us-ascii?Q?BxJjM/E9G/F7SQHpxWwjBdmW2wpuCH5Cpqgvx661g+mA3W17bjzgXCqXB3Na?=
 =?us-ascii?Q?BWJ4TFKY1F2eb39nzqp7smqj9SWb6A1mNlt2Jpu+GNV3mdUJjBkeeXyIklgx?=
 =?us-ascii?Q?LusQGI7TVfuXJVvYechyyr+z4Y4tWGRPRK8UUto3XxJA7lwWyHs4LgZlsVWg?=
 =?us-ascii?Q?Fdg09M6+iAejdxGVrW4M4mmrrw1kmrPS4TSs5FJx9/AOKyLiHeEIt+AnC4H1?=
 =?us-ascii?Q?o1irtKu0EDIjZHrwjc6aO7Q4bBOH6EEY6I1QVn1+7XN5FbMh/NuTkNXC/RvV?=
 =?us-ascii?Q?2rvBW3OVlWWPK5uaO0kQiitnRU1XFy5O4EiMpnKB+07M2XErg09ffOp+g2ql?=
 =?us-ascii?Q?Lah6YCp0hhrmwV5v/Fld8fKfF4Z5PV0vVEj75WksRnKYHLJ7TkcuKCWP3d10?=
 =?us-ascii?Q?uDi0+OM4SnYlRIzeEC3mOQkDpG4c0EfFrUbSSf+kI/oC11lo+oIndF3fRkn7?=
 =?us-ascii?Q?899TLS+L8PnZ20FsYFjwT+UsKcgMwS5P7+Br57HpqUlK3/62vsbWVVCzl8gW?=
 =?us-ascii?Q?IIMX4rf65roT88U6HNoLzZ6GzoEbR+Or5U3zXGaDZFHIHwSW8IYvg=3D=3D?=
X-Microsoft-Antispam-Message-Info: BJfDny49EKhnkXkTIEfavXEUn180SC65BtytATzcJPE6O3hS/aMMb6gzII9itohR8twxXGSmfaWlJaaCnNw3LjYfhXGgeXcJ1fa6uy669xp1LG2O2Ap1IdZgzBZLK8zbnYcpT3Q7blEkB6EPnOy8JcoEyMWisoLgxj5O1Sod+E4/LI91lNK/SVRbkzYTnjRyeJDTSQ1j5LXANDMfhIoNsBZxxIWC268d60UWAIHA6Q7Mb533/JzBDXFsofKNPg12ycmxYXHQ3auCXflScnNF0iriPfA3FMrPesj8fBDe2pIjbLoPnLhnWrdznG4ECoaFEgvrg6iyZlp+89vZJpUY/E7/1pYrjcWOVjacAi4l0Faw6xsLCEWrhs2uoTHO3254MSegWNM+2LGxGuiaAKJZbg==
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;6:naCqEamY/4pACTxw+ZEra99EiS7NmGCOUheAKX/yJFjgt/BT1JfMGy5BldUqaV1NLt+ffiYqRu+mkRde8LkevE695LN6N8fP0VWZCNjSLO05hOQChxUEC2Tz3syJFB/W6usJDmpTfPwHBZPVGzyIN/2IdUocisz4ig2/xtTP3D6kbd6pGapq3Ve7JBD5CjjAcZ9uyYlq+8jYdu1QUwuczbxxrlf33jPITtJfmwnHUPmmRPpy0pHEy8uUvrVVNxQXu4RseRiBKpMDHOupKxZZZA0i+3MOLKdTJFnm0lER/lEVVYPZw19TLFcJ7g2BLZ9EncK9+vSZNyxw4RXZjhXWP3x6BFAqYjSY/vyWVQJLW/6QmlS2l1xJXUfSQfP1DfGFexIyIcJnYK1NsdzV7E9QWf3H7f6McsY9/PWPLt7JhTg/Wlgx0rJvEueBhr+VoLyDAN7+WpQvrvkuJxNKOp2tpA==;5:3tOq01d+cFZyOg6oAQDpG6owTo+4uuZStv5XeGARwEChmgpLu+RqVSRpRio0ny16hnXF1FoZferw6nkY4az0EUnqkIVZYR2oMer8tOFw40jBhSNEKm4NNOxICYGb0hWwaSARBsLQWxxz+Hmzt+5y6SDThjOXHBM3eYDcocsfp7Y=;24:8Mz1JmrRniFm6eDSKgiSJ4gu+9t4wPicwWQjMxjKmzuazVSIc1Z7IZj8bmuUpGJcKfTEcoKHdvLeAxjFgJSbsOAkuc8NphRvIdd+KR9cUm0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY2PR07MB2293;7:RcLItmDJzdfRllrYz4KVjj3YLGLi2VLAubKa9iKgHBBId2N1zf9TglWNO9D9Gmrg4M/EWYPhau1FgD10ynfP1tuVKrY+2wxi4MkZSzfxId73D5qAkAOSlVtSIaCSye4A35p74ciuyxW5Lmf3VnabQrusx/L5vscjtUEh79NtL9fo80Eg8Go2CZAkEkhUFiZVhClamb0ZSvCnCZ3CT9KuuIh4eUKRvfSxA+H8q3F7HYgkYK5Ra8aT8cWxYwV5KBh/;20:ByqX3bMFFuvvcXvftF1fz6sMAcfgvam8yZzWr+4X29mqKDAvrAyoGacute5ZU8eNk1QNSchj6CnjnBqUFVVrwKiFcBCdENHCjYMZOdGQjetWwtXnrkaiUxr6IYGG3mPgt3np1SNGFZyTe2F8N95lGuaDzCKKNDvZi2ytMPFEF6jtf0wgD01Zjd4SCPoc5UD/89WpHua2W+WcvNbBK4rlc73qSGgeiwvq/e+ryYojwdL0H+ayWma50TlNq7fpC2ZI
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2018 19:58:20.8793
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2d8e8fd-e3aa-4fc4-7c0b-08d5e11f53e4
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY2PR07MB2293
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Laszczak Pawel <pawell@cadence.com>
---
 drivers/usb/usbssp/gadget-port.c | 284 +++++++++++++++++++++++++++++++
 1 file changed, 284 insertions(+)
 create mode 100644 drivers/usb/usbssp/gadget-port.c

diff --git a/drivers/usb/usbssp/gadget-port.c b/drivers/usb/usbssp/gadget-port.c
new file mode 100644
index 000000000000..8335bc31ad09
--- /dev/null
+++ b/drivers/usb/usbssp/gadget-port.c
@@ -0,0 +1,284 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * USBSSP device controller driver
+ *
+ * Copyright (C) 2018 Cadence.
+ *
+ * Author: Pawel Laszczak
+ * Some code borrowed from the Linux XHCI driver.
+ */
+
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#include "gadget-trace.h"
+#include "gadget.h"
+
+unsigned int usbssp_port_speed(unsigned int port_status)
+{
+	/*Detect gadget speed*/
+	if (DEV_SUPERSPEEDPLUS(port_status))
+		return USB_SPEED_SUPER_PLUS;
+	else if (DEV_SUPERSPEED(port_status))
+		return USB_SPEED_SUPER;
+	else if (DEV_HIGHSPEED(port_status))
+		return USB_SPEED_HIGH;
+	else if (DEV_FULLSPEED(port_status))
+		return USB_SPEED_FULL;
+	else if (DEV_LOWSPEED(port_status))
+		return USB_SPEED_LOW;
+
+	/*if device is detached  then speed will be USB_SPEED_UNKNOWN*/
+	return USB_SPEED_UNKNOWN;
+}
+
+/*
+ * These bits are Read Only (RO) and should be saved and written to the
+ * registers: 0, 3, 10:13, 30
+ * connect status, over-current status and port speed.
+ * connect status and port speed are also sticky - meaning they're in
+ * the AUX well and they aren't changed by a hot and warm.
+ */
+#define	USBSSP_PORT_RO	(PORT_CONNECT | PORT_OC | DEV_SPEED_MASK)
+
+/*
+ * These bits are RW; writing a 0 clears the bit, writing a 1 sets the bit:
+ * bits 5:8, 9, 14:15, 25:27
+ * link state, port power, port indicator state, "wake on" enable state
+ */
+#define USBSSP_PORT_RWS	(PORT_PLS_MASK | PORT_POWER | PORT_WKCONN_E | \
+			PORT_WKDISC_E | PORT_WKOC_E)
+
+/*
+ * Given a port state, this function returns a value that would result in the
+ * port being in the same state, if the value was written to the port status
+ * control register.
+ * Save Read Only (RO) bits and save read/write bits where
+ * writing a 0 clears the bit and writing a 1 sets the bit (RWS).
+ * For all other types (RW1S, RW1CS, RW, and RZ), writing a '0' has no effect.
+ */
+u32 usbssp_port_state_to_neutral(u32 state)
+{
+	/* Save read-only status and port state */
+	return (state & USBSSP_PORT_RO) | (state & USBSSP_PORT_RWS);
+}
+
+/*
+ * Stop device
+ * It issues stop endpoint command for EP 0 to 30. And wait the last command
+ * to complete.
+ */
+int usbssp_stop_device(struct usbssp_udc *usbssp_data, int suspend)
+{
+	struct usbssp_device *priv_dev;
+	struct usbssp_ep_ctx *ep_ctx;
+	int ret = 0;
+	int i;
+
+	ret = 0;
+	priv_dev = &usbssp_data->devs;
+
+	trace_usbssp_stop_device(priv_dev);
+
+	if (usbssp_data->gadget.state < USB_STATE_ADDRESS) {
+		usbssp_dbg(usbssp_data,
+			"Device is not yet in  USB_STATE_ADDRESS state\n");
+		goto stop_ep0;
+	}
+
+	for (i = LAST_EP_INDEX; i > 0; i--) {
+		if (priv_dev->eps[i].ring && priv_dev->eps[i].ring->dequeue) {
+			struct usbssp_command *command;
+
+			if (priv_dev->eps[i].ep_state & EP_HALTED) {
+				usbssp_dbg(usbssp_data,
+					"ep_index %d is in halted state "
+					"- ep state: %x\n",
+					i, priv_dev->eps[i].ep_state);
+				usbssp_halt_endpoint(usbssp_data,
+						&priv_dev->eps[i], 0);
+			}
+
+			ep_ctx = usbssp_get_ep_ctx(usbssp_data,
+					priv_dev->out_ctx, i);
+
+			/* Check ep is running, required by AMD SNPS 3.1 xHC */
+			if (GET_EP_CTX_STATE(ep_ctx) != EP_STATE_RUNNING) {
+				usbssp_dbg(usbssp_data,
+					"ep_index %d is already stopped.\n", i);
+				continue;
+			}
+
+			if (priv_dev->eps[i].ep_state & EP_STOP_CMD_PENDING) {
+				usbssp_dbg(usbssp_data,
+					"Stop endpoint command is pending "
+					"for ep_index %d.\n", i);
+				continue;
+			}
+
+			/*device was disconnected so endpoint should be disabled
+			 * and transfer ring stopped.
+			 */
+			priv_dev->eps[i].ep_state |= EP_STOP_CMD_PENDING |
+					USBSSP_EP_DISABLE_PENDING;
+
+			command = usbssp_alloc_command(usbssp_data, false,
+					GFP_ATOMIC);
+			if (!command)
+				return -ENOMEM;
+
+			ret = usbssp_queue_stop_endpoint(usbssp_data,
+					command, i, suspend);
+			if (ret) {
+				usbssp_free_command(usbssp_data, command);
+				return ret;
+			}
+		}
+	}
+
+stop_ep0:
+	if (priv_dev->eps[0].ep_state & EP_HALTED) {
+		usbssp_dbg(usbssp_data,
+			"ep_index 0 is in halted state - ep state: %x\n",
+			priv_dev->eps[i].ep_state);
+		ret = usbssp_halt_endpoint(usbssp_data, &priv_dev->eps[0], 0);
+	} else {
+		/*device was disconnected so endpoint should be disabled
+		 * and transfer ring stopped.
+		 */
+		priv_dev->eps[0].ep_state &= ~USBSSP_EP_ENABLED;
+		ret = usbssp_cmd_stop_ep(usbssp_data, &usbssp_data->gadget,
+				&priv_dev->eps[0]);
+	}
+
+	return ret;
+}
+
+__le32 __iomem *usbssp_get_port_io_addr(struct usbssp_udc *usbssp_data)
+{
+	if (usbssp_data->port_major_revision == 0x03)
+		return usbssp_data->usb3_ports;
+	else
+		return usbssp_data->usb2_ports;
+}
+
+
+void usbssp_set_link_state(struct usbssp_udc *usbssp_data,
+			   __le32 __iomem *port_regs,
+			   u32 link_state)
+{
+	u32 temp;
+
+	temp = readl(port_regs);
+	temp = usbssp_port_state_to_neutral(temp);
+	temp &= ~PORT_PLS_MASK;
+	temp |= PORT_LINK_STROBE | link_state;
+	writel(temp, port_regs);
+}
+
+/* Test and clear port RWC bit */
+void usbssp_test_and_clear_bit(struct usbssp_udc *usbssp_data,
+			       __le32 __iomem *port_regs,
+			       u32 port_bit)
+{
+	u32 temp;
+
+	temp = readl(port_regs);
+	if (temp & port_bit) {
+		temp = usbssp_port_state_to_neutral(temp);
+		temp |= port_bit;
+		writel(temp, port_regs);
+	}
+}
+
+static void usbssp_set_port_power(struct usbssp_udc *usbssp_data,
+				  bool on, unsigned long *flags)
+{
+	__le32 __iomem *addr;
+	u32 temp;
+
+	addr = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(addr);
+	temp = usbssp_port_state_to_neutral(temp);
+	if (on) {
+		/* Power on */
+		writel(temp | PORT_POWER, addr);
+		temp = readl(addr);
+		usbssp_dbg(usbssp_data,
+			"set port power, actual port status  = 0x%x\n",
+			temp);
+	} else {
+		/* Power off */
+		writel(temp & ~PORT_POWER, addr);
+		usbssp_dbg(usbssp_data,
+			"clear port power, actual port status  = 0x%x\n",
+			 temp);
+	}
+}
+
+static void usbssp_port_set_test_mode(struct usbssp_udc *usbssp_data,
+	u16 test_mode)
+{
+	u32 temp;
+	__le32 __iomem *addr;
+
+	/* USBSSP only supports test mode for usb2 ports, */
+	addr = usbssp_get_port_io_addr(usbssp_data);
+	temp = readl(addr + PORTPMSC);
+	temp |= test_mode << PORT_TEST_MODE_SHIFT;
+	writel(temp, addr + PORTPMSC);
+	usbssp_data->test_mode = test_mode;
+	if (test_mode == TEST_FORCE_EN)
+		usbssp_start(usbssp_data);
+}
+
+int usbssp_enter_test_mode(struct usbssp_udc *usbssp_data,
+			   u16 test_mode, unsigned long *flags)
+{
+	int retval;
+
+	retval = usbssp_disable_slot(usbssp_data);
+	if (retval) {
+		usbssp_err(usbssp_data,
+			"Failed to disable slot %d, %d. Enter test mode anyway\n",
+			usbssp_data->slot_id, retval);
+		return retval;
+	}
+	/* Put port to the Disable state by clear PP */
+	usbssp_set_port_power(usbssp_data, false, flags);
+
+	/* Stop the controller */
+	retval = usbssp_halt(usbssp_data);
+	if (retval)
+		return retval;
+
+	/* Disable runtime PM for test mode */
+	pm_runtime_forbid(usbssp_data->dev);
+	/* Set PORTPMSC.PTC field to enter selected test mode */
+	/* Port is selected by wIndex. port_id = wIndex + 1 */
+	usbssp_dbg(usbssp_data, "Enter Test Mode: _id=%d\n",
+			test_mode);
+	usbssp_port_set_test_mode(usbssp_data, test_mode);
+
+	return retval;
+}
+
+int usbssp_exit_test_mode(struct usbssp_udc *usbssp_data)
+{
+	int retval;
+
+	if (!usbssp_data->test_mode) {
+		usbssp_err(usbssp_data, "Not in test mode, do nothing.\n");
+		return 0;
+	}
+	if (usbssp_data->test_mode == TEST_FORCE_EN &&
+		!(usbssp_data->usbssp_state & USBSSP_STATE_HALTED)) {
+		retval = usbssp_halt(usbssp_data);
+		if (retval)
+			return retval;
+	}
+	pm_runtime_allow(usbssp_data->dev);
+	usbssp_data->test_mode = 0;
+	return usbssp_reset(usbssp_data);
+}
+
-- 
2.17.1

