Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56037C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5EE20869
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 13:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5Y0Nd+JD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5EE20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729446AbeIGRz0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 13:55:26 -0400
Received: from mail-eopbgr720063.outbound.protection.outlook.com ([40.107.72.63]:27072
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728322AbeIGRzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 13:55:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yunVzcyw+srTsSotZNAFuedem7YsFjztCVDhgC/jEFg=;
 b=5Y0Nd+JDf41yXxHMNk6gGObWDk1wnGFPvq1yfWRHOOrZ7n6mQwmev59QN8VKqgCNQTbjA9Theglw1MZm4qCKgHVSwTmudFE4Vg7Y6OBazvyLxWiXq+l96u5PPVH7rPM52tm8bWJvyq17G5w/vNOL33I4WS4LmsvhTNxifi37nkk=
Received: from BYAPR02CA0057.namprd02.prod.outlook.com (2603:10b6:a03:54::34)
 by SN6PR02MB4943.namprd02.prod.outlook.com (2603:10b6:805:99::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1080.17; Fri, 7 Sep
 2018 13:14:22 +0000
Received: from BL2NAM02FT062.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::208) by BYAPR02CA0057.outlook.office365.com
 (2603:10b6:a03:54::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.16 via Frontend
 Transport; Fri, 7 Sep 2018 13:14:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT062.mail.protection.outlook.com (10.152.77.57) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1122.15
 via Frontend Transport; Fri, 7 Sep 2018 13:14:20 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:46050 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaZ-0000Wh-Ql; Fri, 07 Sep 2018 06:14:19 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1fyGaU-0005mb-MU; Fri, 07 Sep 2018 06:14:14 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w87DE7ux019599;
        Fri, 7 Sep 2018 06:14:07 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1fyGaM-0005le-JK; Fri, 07 Sep 2018 06:14:07 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id C3A0F604DB; Fri,  7 Sep 2018 18:44:05 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <Thinh.Nguyen@synopsys.com>, <v.anuragkumar@gmail.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v3 4/8] usb: dwc3: implement stream transfer timeout
Date:   Fri, 7 Sep 2018 18:43:45 +0530
Message-ID: <1536326029-16327-5-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1536326029-16327-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(346002)(376002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(107886003)(90966002)(39060400002)(426003)(6266002)(106466001)(47776003)(50466002)(316002)(36386004)(486006)(48376002)(5660300001)(446003)(76176011)(2616005)(51416003)(476003)(478600001)(11346002)(54906003)(42186006)(110136005)(2906002)(16586007)(103686004)(8936002)(50226002)(106002)(97736004)(81166006)(356003)(26005)(186003)(81156014)(8676002)(126002)(63266004)(53936002)(6666003)(336012)(52956003)(14444005)(305945005)(36756003)(4326008)(107986001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4943;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:ErrorRetry;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT062;1:GUj5A/NvYwSunMZXgPXrLVAUCKCbUbHacpFvwyu8pSxbKSIIm/nfEQHC0B/idvjHCyQ5c6+XXkMGWW8RhLawYTC7EWba1daBJOqvnKsTSlXNzuPUr3/a5qkcPGLvwOmp
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff7fedbe-3dea-4de7-b862-08d614c3d2c6
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4943;3:WLgM98oYauNtGvjRcdBp5CfSpOM/+8O8lrrb3lghDTc2AEjr4WGAAtbpGS4mEhkES3cflsYsJBLukKceQfO6zFhohtY+BbtEBaBXsYPunqsYFdYDpbW/8+BG5j238eyTgJ4RWPT0IWBtKUJaKIUCuvRCxhzMRc/iBx+FFUgPsp68/XRXsrRs/7T5FgRUk1/p4YF7+BUew5IR7Vp6ZFnc0KbCapHdvWkGjqmYKC8esM3lmSSDCM6TzRKb9VG+3WVBJo2oYTLQmytHQDSfdw2kn6KH91lfEx6eZthr0nII5Y8+lc0Cqb4O3YjO+ifB4389gGyLDGuOsrk9s+jHfhyaTpLeky8BMvdTTV4FPkNlGXw=;25:oSOI4MeiXD66nvIFWIzqYBT7QqjxlPvCMUUAjcE2sSIXT2zpeUSI5tHWApZROEYLHA2ZeHYgjB7upmSny2HmzTfaifIKXNXLxZKN9bmVelSgztLHHs+vs2idLfrNWyX1CF0AWLK07uM7Z3TjdC+thGjN+QT1pUVhFYHYjBO77kHJVt0b8yGWuasi/MIUicDWCqaCgmcfNuVv0Z59/vSA8Bvxf6d6rOpVx12Ti6uAuDQ9nIbRBzh+OZmQ836dasY4cyJtwpBh0qH2geN8yixZApcPB0VIMaGRPYQNTVnihd22DA6hgbc8L+xG+BPZI/+Q6q4tO/kHNok8oCeoXNaHvw==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4943:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4943;31:2LJa4iOWcRt2HLD8iuhYb0oLtCOtYzzfoaJnGEBwo8OE5iCVi9KpIfa+z/7tOz64a6jxqmkBumgUFn+F7boOuJcoT62KaId/nDUyo1hONeNQkifXudFwFLgrlO4annhdgaRzN8zEzChhd+0kEaCbcEvgCqE/qQrVftejg491kDRObjLCyXZgLuSWDAUg/GqFePZW6SauMI+JVQQti/5+O21xCr+cWq00CFp60wiR/Ps=;20:wJx11feS90kJZ5EvDYCwK6pqKeVQEyyYjI+oUUSTv1wH7tnhS7p7v/nJYWeHnDxcn8GvaE7VCnCjJOjhMxaH9ZV1skRl/Rqe1PyTH98IcjZ01wPj53DSjMF6dcX9ekxm5qayuVl7WzGScV/scjETziOFTSHZrmisV7PUFQ410Nsnd+oaRfysCda+XUtj0VvBF9Nwznu/Owx3zsjdFFV5V5zWTZeERP3okG3pfWs/bbIHZofrtvgJ7hBArBQ0EGJY4zkKs/MDCxA1sH/xc1u5Rq8HJYi1oOO02y85tk6YC+6F4MruNNvgMPUyGQk7ZMoZl+EF8Z+r0QA+MokMLV1D7so3tdxMDz6EnDMlc4kTHEG7F8P4ANzzhmZmNStFWTeiC56P/7WJFvASj0pE6xslq3KJe1JeO7rXVbeIZe5TrEgT9CpJfQl1har1RCdD2xQ343pXiFuZ4NqpIheCnUoMxQ+sDdWc0jrattjSMWvub2Y+6tnfMaXejZVDAkkS0HKs
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4943E6DD4323A7A2305476B4A7000@SN6PR02MB4943.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:SN6PR02MB4943;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4943;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4943;4:Ww0vtOsz6mG7euHmb3HRc7Lr84kwKu4vMfviVMepwIT/gjIWtkn87zpXPPo2aUv9Y74EPUQaLWxm4S0S9Z5tIcwqJ8eq9QbWSBhcnFQUJMJFOPLAjwPOi1XuHVNeZcgu06ixo79ypgfk6X2psjv6hegPurQj/m/R2x9XfoyIPxox2gkLaGTs3ZB1S5gajjTjNfJ/Fh3kZdZW6JUc72qDwap94tVqeC4c6rMRj1B5v+lj23bEebbkY2r3L5kid9b8XyYfJ2OwjAHCdaOPB9i/mapB3Z/SLfPkzixjBnIPjqfvTi8CxNHcwwASeiV/NvY5
X-Forefront-PRVS: 07880C4932
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;SN6PR02MB4943;23:4FKDSMXXBGAYMGv3Rc5zhzK2UOQwbw5AlqG5vpvgE?=
 =?us-ascii?Q?imYnEpOtNFl2+2YqZ/B98wmriHyS1HRRF0eFmkPqhK8StPOst4p5z1bAttcQ?=
 =?us-ascii?Q?2CVcSxgx17VVnTa9aA3OFBhPzk3yo/qGAHajWjuywr1W+jxHMDSL7N10f6Ob?=
 =?us-ascii?Q?4VIOfbwjSi8jT4EF+vsSvf8uWkJ5iW107A9PgwPVAOW6vK/X4ebnmONI1r0R?=
 =?us-ascii?Q?/UbZsZxXRjui+bWn488I7vPyzL7rshTQFRYNG7Fx2oKe6QmsXK8haPollF4i?=
 =?us-ascii?Q?kJzhTEhuNBwz4KX8hq7jx8Y7SMSItZi1Mt1qjIVR4p+O6n5wBIWaJjmCMC9L?=
 =?us-ascii?Q?pyZCO1sXWComjGNfpIG+tms+h0LQv000S0ayrLBRjog+ZlodNJH0+D41rXqh?=
 =?us-ascii?Q?ocq9ycOkHA4iU7jgU30FZnG2MwloflPx4D8RdPGi0/sYiepwaMGBCdqGd2KP?=
 =?us-ascii?Q?LHybEgWwsOTqxS9nuNn3chnfzLhabFEP0MLo3W277hJNh1MuLfdUwl+hUDB/?=
 =?us-ascii?Q?lcnOR3TnazwPZXUpFQ5zdS+Pey7vBnceTXI5HsOyZO1+SOtz8rYhAtgOufDj?=
 =?us-ascii?Q?GEER/FipNy7rKL061F4XVpBSTI0y7/92gpWONLZnBjARQSRS6UemUrBkZ9Gq?=
 =?us-ascii?Q?jezhhogLZRKGo326tc4O9IZkBrNnm1PRzt9+rxLQ1G84kprsTO/rW87mia6R?=
 =?us-ascii?Q?efFEx5WITBMO5L/ZU7PN4x56InGmi+8DXHqsCOLS1xvKBjYOw2U+VMIyfZrk?=
 =?us-ascii?Q?/xTsDq1yMFKSebOeFuG8B3VcpX2kNEU9HiXqZgASiuSUJ1S1jOlqGNQm8Lp9?=
 =?us-ascii?Q?JrihKj9uYzTYck9Xpgh+x1Qnq+Qrkk5FhXI12e/Pm0mcmW1XEiXVlNbNw3Nm?=
 =?us-ascii?Q?3q3MDo5MRzAk1XuAtkb+Bm+tzti+qoE2XXRO7bYCGarKXoSkOD5ClQkpra6s?=
 =?us-ascii?Q?MLgPQE1dZ7TSWW8gz2B/rI3yV3PdLrBVILsxT9WgQchPab9UmzfLRyMTjsI7?=
 =?us-ascii?Q?fTKT9wGuxGkhaljdxGvMwRDmQO/Qxwiiur0hIK4PlwDq4ftTagBsSKRsw+u4?=
 =?us-ascii?Q?KCNggcS8XQrqylJi5V9TU4wqyf3BD0yZLQgILJWESZSKSXd/O4qgQocLF7ae?=
 =?us-ascii?Q?m+LSRWjh43WdHLg0wDPgaJY0IDzWv6ddOEdXP9HN10dGTzQZk62ayQGOXDj1?=
 =?us-ascii?Q?OGGYSXeblwLK7lkZU70GKQkPIoYDUoX/KEFkA60C3YdsjyVoT4HF99pdRfWv?=
 =?us-ascii?Q?pIQS7e7wDErhuxA26A=3D?=
X-Microsoft-Antispam-Message-Info: G29AD91Q3MTNtXsgRPzyitPm+iTV7+ExK+JIif8HOYSgCRxQynI+qc+8kmDaH0ebTnQiqabuJWGHDPn8ItvlhiyEd0NWybGAuoW0PCk/Ua2nyfO3NUOo+glKQXzIENLwveuwdIH1zCqTIKWtvt9kxCyZRQlzGu+K0RtiI3c2ZVaoFRROCWISqr+7WnyoN1c4K/hlqBvHRV45BUQBsejEPilegyaP3IB03lMvVdYdWUY+eBqcdkmN5dTg+QGsDHzZo5SmPfuE7kSggN4M5bzdDGvZsE1oiJz9H98ldD6cgDNOBDxMFUFBa0kKbz4ihP56BW9XzG18gzzUmLdSrRBezOBtdtlnOX2Mm7gmXyIckPM=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4943;6:YYBxVBusDYWwoCLdXQ/bPRCHh/lV1Y9SnpUMUfk0bfSs+tsHjSFt7vYM7NJ2oUCeUGQDcX2Nn6N+3fRX7bw0odJCv6IiXlDHjzE2Oyv7kbItWhqWFLeKYRKTdWgNHh2iGgIlhBrK2gnfuAXYet53EIFgScseImCZLCLzwJBmwUNZp6vWud1C8rAMzdiUpeZr7lpRWsIIb9LZaS9JnEvLqJGoxzyekcXjXbUwgnUPVhF1/QQJkIzAoR+A72sIoppms71SygA/nakphDD9tRUxbOrGtRdsNG/4ZLr8MEQpogEBG88eSyytgenO6rKjEMR/2Qj9m6ENYwXcVnds5PvbDiN7bWOtSC+Zce94IgKaW/OoLDkzYBTeiBsIOq3ag/EoS2ilYsDpiStjkTglFrC3bpNM5nyRAdULqYKd447iHwcSFqoBsNRR1PqtNKs7PeNmqpCI/PYwEeFgxOrX/NLeeQ==;5:h0HK80NGXRqCWXe3jliQRpAJJec8orHjcHCaLe67hI4/IhMz5txEgESCd3kVJPOB/WcL0AwL4PsTZ5uS0Ru9ZAME3xwIsio8Q/X7AnMaZll5Mnw/DT2a+0Uk4Bn0B+BvNm+ZTsGuaBGnvSYBKZv0RFRVe/E4Mjk2QfrpzC1gcNA=;7:+AmxzE4JA+DyGwXSVbb+QrmFDYxsulrbLpRLz4mAYZfz+6uwLMMp+FyTLgyBpkr99HGSTwchhNUcKwAuYgI/XYEai/qVLJvLKKQ6wdSuH759H+tWcuEyGX9AdickOCioDsos5RnKyFGJVcijC4Dx88uxnbqJMP1aQVfKmlFvUZEwp9Cw5gugG7D0UUVYHfw/CDy/XcQRXq28YbjZWY+pQzbHoJUJgN1nKAUaKOS8KvDQNfI6iH7pKJX4Fkkkd7Xs
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2018 13:14:20.4420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff7fedbe-3dea-4de7-b862-08d614c3d2c6
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4943
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to dwc3 databook when streams are used, it may be possible
for the host and device become out of sync, where device may wait for
host to issue prime transcation and host may wait for device to issue
erdy. To avoid such deadlock, timeout needs to be implemented. After
timeout occurs, device will first stop transfer and restart the transfer
again. This patch does the same.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v3:
	1. Added the changes suggested by "Thinh Nguyen"

 Changes in v2:
	1. Changed STREAM_TIMEOUT to STREAM_TIMEOUT_MS as suggested by
	   "Andy Shevchenko"
---
 drivers/usb/dwc3/core.h   |  7 +++++++
 drivers/usb/dwc3/gadget.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 5bfb625..0b255e97 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -633,6 +633,11 @@ struct dwc3_event_buffer {
 
 #define DWC3_TRB_NUM		256
 
+/*
+ * Timeout value in msecs used by stream_timeout_timer when streams are enabled
+ */
+#define STREAM_TIMEOUT_MS	50
+
 /**
  * struct dwc3_ep - device side endpoint representation
  * @endpoint: usb endpoint
@@ -656,6 +661,7 @@ struct dwc3_event_buffer {
  * @name: a human readable name e.g. ep1out-bulk
  * @direction: true for TX, false for RX
  * @stream_capable: true when streams are enabled
+ * @stream_timeout_timer: timer used to aviod deadlock when streams are used
  */
 struct dwc3_ep {
 	struct usb_ep		endpoint;
@@ -705,6 +711,7 @@ struct dwc3_ep {
 
 	unsigned		direction:1;
 	unsigned		stream_capable:1;
+	struct timer_list	stream_timeout_timer;
 };
 
 enum dwc3_phy {
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 13ea282..98e5f39 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -254,6 +254,7 @@ int dwc3_send_gadget_generic_command(struct dwc3 *dwc, unsigned cmd, u32 param)
 }
 
 static int __dwc3_gadget_wakeup(struct dwc3 *dwc);
+static void stream_timeout_function(struct timer_list *arg);
 
 /**
  * dwc3_send_gadget_ep_cmd - issue an endpoint command
@@ -574,6 +575,8 @@ static int dwc3_gadget_set_ep_config(struct dwc3_ep *dep, unsigned int action)
 			| DWC3_DEPCFG_STREAM_EVENT_EN
 			| DWC3_DEPCFG_XFER_COMPLETE_EN;
 		dep->stream_capable = true;
+		timer_setup(&dep->stream_timeout_timer,
+			    stream_timeout_function, 0);
 	}
 
 	if (!usb_endpoint_xfer_control(desc))
@@ -730,6 +733,9 @@ static int __dwc3_gadget_ep_disable(struct dwc3_ep *dep)
 
 	trace_dwc3_gadget_ep_disable(dep);
 
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_remove_requests(dwc, dep);
 
 	/* make sure HW endpoint isn't stalled */
@@ -1257,6 +1263,12 @@ static int __dwc3_gadget_kick_transfer(struct dwc3_ep *dep)
 		return ret;
 	}
 
+	if (starting && dep->stream_capable) {
+		dep->stream_timeout_timer.expires = jiffies +
+					msecs_to_jiffies(STREAM_TIMEOUT_MS);
+		add_timer(&dep->stream_timeout_timer);
+	}
+
 	return 0;
 }
 
@@ -2403,6 +2415,13 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 			stop = true;
 	}
 
+	/*
+	 * Delete the timer that was started in __dwc3_gadget_kick_transfer()
+	 * for stream capable endpoints.
+	 */
+	if (dep->stream_capable)
+		del_timer(&dep->stream_timeout_timer);
+
 	dwc3_gadget_ep_cleanup_completed_requests(dep, event, status);
 
 	if (stop) {
@@ -2487,6 +2506,11 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 		}
 		break;
 	case DWC3_DEPEVT_STREAMEVT:
+		if (event->status == DEPEVT_STREAMEVT_FOUND)
+			del_timer(&dep->stream_timeout_timer);
+		else
+			dev_dbg(dwc->dev, "unable to find suitable stream");
+		break;
 	case DWC3_DEPEVT_RXTXFIFOEVT:
 		break;
 	}
@@ -2588,6 +2612,18 @@ static void dwc3_stop_active_transfer(struct dwc3_ep *dep, bool force)
 	}
 }
 
+static void stream_timeout_function(struct timer_list *arg)
+{
+	struct dwc3_ep *dep = from_timer(dep, arg, stream_timeout_timer);
+	struct dwc3		*dwc = dep->dwc;
+	unsigned long		flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	dwc3_stop_active_transfer(dep, true);
+	__dwc3_gadget_kick_transfer(dep);
+	spin_unlock_irqrestore(&dwc->lock, flags);
+}
+
 static void dwc3_clear_stall_all_ep(struct dwc3 *dwc)
 {
 	u32 epnum;
-- 
2.1.1

