Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B10EECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30A10206B5
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:30:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4cA8OOZ3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A10206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbeIOTt6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:49:58 -0400
Received: from mail-bl2nam02on0065.outbound.protection.outlook.com ([104.47.38.65]:40320
        "EHLO NAM02-BL2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728084AbeIOTt5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWV8MPJ6lpw7G2tyYwuu+XWCPTqaGoVljnfE6oMMvW4=;
 b=4cA8OOZ347PeTZ6RPwqJiTlYEwNna/wYl+5NHR9ID4JIzcDUOVmL8B4rVli7MGvQBjNFd6XYXdbeBQ5ZnGgK2NWD7kqlCYgkyN4GQ6LHqUOiwlcmzjccBMiWN7oJ4sjvyea1y5P2qjnma7o6uHCJkJ7Dg1AWD3croACS6zwH3qg=
Received: from BN6PR02CA0041.namprd02.prod.outlook.com (2603:10b6:404:5f::27)
 by BYAPR02MB4469.namprd02.prod.outlook.com (2603:10b6:a03:10::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1143.17; Sat, 15 Sep
 2018 14:30:42 +0000
Received: from BL2NAM02FT033.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::206) by BN6PR02CA0041.outlook.office365.com
 (2603:10b6:404:5f::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:41 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT033.mail.protection.outlook.com (10.152.77.163) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1164.13
 via Frontend Transport; Sat, 15 Sep 2018 14:30:41 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Baq-0003U5-My; Sat, 15 Sep 2018 07:30:40 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bal-0004sf-JI; Sat, 15 Sep 2018 07:30:35 -0700
Received: from xsj-pvapsmtp01 (xsj-pvapsmtp01.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEUOCQ024962;
        Sat, 15 Sep 2018 07:30:25 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1Baa-0004qO-Ln; Sat, 15 Sep 2018 07:30:24 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 53A57604B6; Sat, 15 Sep 2018 20:00:24 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 8/8] usb: dwc3: Check MISSED ISOC bit only for ISOC endpoints
Date:   Sat, 15 Sep 2018 20:00:01 +0530
Message-ID: <1537021801-23896-9-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(136003)(39850400004)(396003)(376002)(346002)(2980300002)(438002)(189003)(199004)(6266002)(47776003)(217873002)(107886003)(14444005)(126002)(2616005)(48376002)(90966002)(476003)(103686004)(486006)(16586007)(39060400002)(446003)(50466002)(11346002)(316002)(478600001)(36386004)(42186006)(4326008)(186003)(8936002)(81166006)(26005)(81156014)(305945005)(50226002)(2906002)(76176011)(63266004)(51416003)(356003)(106466001)(8676002)(5660300001)(36756003)(6666003)(110136005)(106002)(54906003)(426003)(52956003)(336012)(107986001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4469;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT033;1:2zEqVzWYA2UGaNgO/fKO1KqjofhuW6gINACB7rU/UIQokdb02YrTh10cl5SDGA1trsOGcMTqQJmLf5KRkk+guKEkD4DMxlp5bSZtWW2cmmNIHQ7+DbLx/gDF+J0pbsWi
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 67c7b455-cea8-4b1f-de6d-08d61b17d06e
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4469;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;3:TFJv5qgPJAZdwMQ7z+OosLsVfac3mV5PYsSg6cDkL6H851Tqy7Ol2eb+puauKJB84EZ24KNjofd5AV5+n6cDhYPg9iATD0V/+IIBwCa6mISnjvjz6aSa7/B/VNVHWmRMf6bcnMZgrrgKr59KHLwp/qv8HHipQpVb3KUlXwqXiCKdvYEmAX1D5S/p7Nomgzm61BqnTseihPeymWciPxch6OYhmru7/CWzf9q7ZYzCGq4x6mwjTFntYB6aTpkQGfHhUYkWtAf8Ow+ozWmADanmM+TaMWjJfJp++osZdO35ANcqcHL5aZTE2CMkaWF/ifzyEz0xxchhMVcpPOtQ4GsQ8m1QKfGSl29evl8MVSjy88c=;25:1eVKV6b0pLliigx/NDiVkF0aolmQiqC3V/Hmmz6j10oUaMcYcx1/8Tj71o+IGBDdxKs15brfhLOA/d6dJBPZDd2TxsdVSTvzqSXhtzo2rr9+EbON2Mscn2b5Q1fbSrqbKWEDs8cg/qNB65wdOUEAcEW1LJAxSib3gwuZDCiXRotTPfQeRE8AqL0oE2mMCrYFcTThU75gulpZJZoLH/+D8urond889njJVKC6QDHvKSP0Q9d0OtGsn08fkobS2fFRSmoBHWqh5TPwiEi7TA3AjAJ1STyJCYlzTt3NY4ACwmiWlxXJWSEJo7YayhDmwMEo9uZ8gN3UfOUCOgnuaH/mMA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4469:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;31:FEcxeWtTa+DMn0BmnhJJl146zk6JYGjmdEX35lebfHgrvIkfhoiKmQf3a6h4yagHuxbOu95j0J99ZqSUJi1oi2nFmfAC85rJmAMY0cP4mHBHqJPWHBgRpXujSdaFy6rMabqVDeC2JNvp0b8w5WNIOnv2yi0MrKUt2fNs/RwhLLnYUOZTUSr+Vyh8xXP1jlu0UXjYJyR9VT40K6E6fukI3Iihymz0jfw16IsZclFp258=;20:ha/ibPvMG+MNP9pdBY0Z84YDZj2ce/CQX5fzC2MRMFCGZhViGHP2TW1rQY20+dtvsmaoZE9UC0nphVKWOCL8ytstgs//zaeoxBlgdllDgqXqRg0l/sGQgymeEV1i38fTKDdXx2PyOvUv6lNu8rKO/PnMRbRlKsjdZ0mKQxt+zn3wMQtQRYYO7i8GcOUx4NneGb3S+pjRVbLFOkKV0ZVRBVq7zp+Koyk9avyKbSzMJ6Oyh/NR2/IFlfvZoHruSfGWldqm+K7kwA1kH5nez3XcpBzTEV+JV+CKt7KsDhlLF6yuhi00PDB8jbZA+lxpCDG8kNc9A2yvCGQY1npmuv8y5Kni8ni+d5GzidzLXdzliJiJp8jeYaiFlcFIMPTUZJblmlg/+NZ3PXN+OitnVcpmB/WHwKAHftJBaiJwgcw0aYodGBt2yXwt/M8dsq06TgqgXyBBj25+bmozx7Pp19NTsNyiDp0E7DyAHyubhkXXBZdFvYmCaUkcFqM3M/noGBF6
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB44695FC8970C2F4E01F00206A7180@BYAPR02MB4469.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93004095)(3231355)(944501410)(52105095)(6055026)(149027)(150027)(6041310)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123560045)(201708071742011)(7699050);SRVR:BYAPR02MB4469;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4469;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;4:JndJ/dpo5NwWXpzOhuxNKYYHa60ukurkas9I7503V6tP4aJ+LoopSSnfH6Z7AeLiGyTgT/2RQoL2IuaI6oI+nt6b1Qj9mTE2eSayVihZzWGOdgeK3d/xnDfOjIo98upZzhFG67O3/ZEo0QH3xYUijxr8ffxtWlT5mXvAbywXRhxu1gaEt8vycm1mvwNPacX/Nz9NrGmFsAggzbD6VIwAvlm1brH8xPLtQGPUYlidVDdOtpZlhmyR0n46E3aT7NTTknBqFTeroqzRnF4NG1OufW/nWGpyigxSCtX/FdgnD9krQcOV/grRbjmpueYyjjAG
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4469;23:3pRJZaklEt0uZtrofVrll0+/quEUgP838GXnXyWy8?=
 =?us-ascii?Q?wDCm5pdl+Y1P/JOTHj58l70Uw2McIXmhWUmIFKstsuNksezBhX9IfiecnqDr?=
 =?us-ascii?Q?KalNwHoZFe5Q8xp4SJcTpsSg49QUZlxuBVPrrREgC+FVJ9B793qAJ91AaHsZ?=
 =?us-ascii?Q?4I9MrY7VAjR9rFvcaxdL8Ou8qBjqHyQwjO0qDaFhiBg5EjN9CbjxPW8AuYNs?=
 =?us-ascii?Q?LT9sLiPNAxQ25nJvVPCo4WpPP75tkGEs6gzRTjuxOWeHOdzZ1zCrutfi8B3i?=
 =?us-ascii?Q?7/Tpd0TsTe4z4OchS+X0n4yrwCjNNlOaa2aeqCnGFX8LzNFb/wAkb9LToifc?=
 =?us-ascii?Q?N+XRV2mJ80qMCtNJ9d3qYZhAANFK61qvwQHrWYSM59NtghLkYyOpqCeio60A?=
 =?us-ascii?Q?KYe3kXDivy1jVq+fmkA7cO+E2GWACpm3LOJ0+t3W6fxAHOZgL+oc85wdGvpx?=
 =?us-ascii?Q?TahulOgvs/2qSCbicEWTEKgR31STjwfYi2N7NtC8lgfA4t5EM+ZLBhTOOqqs?=
 =?us-ascii?Q?xJS8nR8sZPSUgVsHKo8v8VG2K+8cDzNu99XJxrbb4EK6JEfDsKYcZcm/ey9I?=
 =?us-ascii?Q?nj8LR/oZoAgHQnvfIJhZ9QI4wf00Zm6atoIc/Q7ej93SFoY8oF+iTL5C5KlA?=
 =?us-ascii?Q?5TwL1K8AVXSId9I5jOPgRPeEgUKhQuhqiC+sgzWePFrBZ26Ycrl5o1hFjOhZ?=
 =?us-ascii?Q?wfcLm9SwACvoGoPNGSG9qNJiMT8+4y82diDZ3SgrPBmjjVjYnv4LJdYEU99X?=
 =?us-ascii?Q?9IvJY2MlDXzCq90AR833Mc59/hQkX3pj+6bd8jQZEF9pfd1x/f5DXxd1IM0C?=
 =?us-ascii?Q?TXIRJehykZ/nATvU+no564Qbiv2ukr2hsN3WuLxKWd8thguw/BjWtHA0PWLs?=
 =?us-ascii?Q?NtHIJ1/bN3o5723ULo6cfG+AN2UBQev42QkQujxmCj7+3V05UYpGBy3mVI7F?=
 =?us-ascii?Q?6nUjcxw1u7bPfMAsuyfMjJ3/vZDQKM3AyJTwuYS2qoknedr8Pbeey9czKdR+?=
 =?us-ascii?Q?FMfn+5GPqPY2ORqi/T0y0wdfMK9u78nmD9P/tO7PyCcp5mfote89+qe6p5FF?=
 =?us-ascii?Q?1PVJ7O6mTKjNFI5lTPFxiF4Lw8bA0qUd4Ns0ZltzhZBoOOq+6WTOKvTlE7ab?=
 =?us-ascii?Q?OTZXwB6qZaW4xysd0fq5ukwdcetJMMpuWlzsAy+Y6o51O6sX0QYxWiErXFiQ?=
 =?us-ascii?Q?L604eMDdSmJefmfPka8h6DY4Lz+NV4EYPbajddLlcfmxJQd44T7jXaFSN8cc?=
 =?us-ascii?Q?niWHtgnYujpl8R45YefxiroLdyRqlFO1EMcoEExGIwA0bOEiLcoGNOxuWerM?=
 =?us-ascii?Q?u53XDuEc3xOC46Mib2YhJ4=3D?=
X-Microsoft-Antispam-Message-Info: rTGeRr09XbiZcytHH5IEImNuB4RfRzfFsgcb+DDU40vOFX1AkczDM4n6m2aAAt0VQpSSZ4xv6mi5hagITCc1z2T5GF2smPc8AKzmsoHPAkqsvHP6bVDBrxIp86FTIJOgugbUGisOyhdIvsYAxAKg0f8D92jX2Y89s8+sfs2O4g6GaUPaLrOxM9x9YAZIoOod39I/A+oLbosKbhGq24leg7ZKTH/P7r8sGsdECnZj4AW7SFIATie9ZEhHiRAwPei5arMfhcNRVTVRywyyAh4v65C4a+R3dFriK2U7i2gdYtaB+FJX3CHeaTc94RE5tl9JtOhDRqiO4OVaO13NvqVev1Fdrwxtv73YVVLfhco1dWc=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4469;6:jVohrHmWxgqwyqGnj9Vo36V3mgT4B0dupuaqGhrOFjV1s9wyWRmeRUP7oV06IN/GkMepYmLfcOiQMm2zZ/1TfB8R0ISJci9jktV0t2jXvqo+kQd8CNZcRJkuDudvoSs1UhstTMLuxbQDAHbhYZni8NbkzUh/rT3BU91MPgR1DBxXKghUFwAp9rCW5GiQbhmFCYMxkHHhkgf3D/TaYNFXdBp2veDUlAEnl2a4VT9nK0lMmpa3fFDXoucC7I1BYx9ElZ/qXr9MSRD5GnkCvIE9ctdMWfZ1zoUU/w0C4XR6ID6Ab+MluAlyET6cvProIT6hx5DEd7oEQ625dcI5krtMCepunSaVm25eTCao6Edn2UByyeSOG0MlrazH3tMKx7y1KArxClZ8o1uPP+Vlvk1i3ybvGomy61Zqz4YlfLZx7Y/RYTiDOJYU5KyqNp2aKlrNIWV1NKAN48t+rhC5xJBNdw==;5:cvwg9utgHXCW5E8iNAl9y24mN5NeEZexF8kpaosV5AIzYHERJFrMNbSaQFqT+vMFeWqgsZs4l9wsRwHPMFr1OH/CVECG4kaSQdR0hRlBynoexR6tcwqfbZ4P+dhKgfDfzeP6QZpmAZ/kmdqsaxNGECKiBd8YSRiklH2/DrQq/aE=;7:8oljSxo5Os3GUr2e6DAN4kLK+SwI8shggoJUww8e/gvuH75wneFHgyglyU4d22pU+zYjwh1dYDmFwEhGC5y/qndxsg9VyQrSv0BH9zfW2bNpVvhcUVBxc59rIkWgqH2SGaoggyx2/lKCRzvW8DMDe/YKzluJ5fnQ5RaJfZBsyH3jwTcI0PMlS9003Wx1MpC4sqE6vaUo1qxToqooeg3M7s4VosVPPRvMlRYb/wW5ACj74Zpo83ORPA4jZYc+Qrq+
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:41.2909
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67c7b455-cea8-4b1f-de6d-08d61b17d06e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4469
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When streaming is enabled on BULK endpoints and LST bit is set
observed MISSED ISOC bit set in event->status for BULK ep. Since
this bit is only valid for isocronous endpoints, changed the code
to check for isocrnous endpoints when MISSED ISOC bit is set.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 Changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index 872c956..0b6d859 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -2422,7 +2422,8 @@ static void dwc3_gadget_endpoint_transfer_in_progress(struct dwc3_ep *dep,
 	if (event->status & DEPEVT_STATUS_BUSERR)
 		status = -ECONNRESET;
 
-	if (event->status & DEPEVT_STATUS_MISSED_ISOC) {
+	if ((event->status & DEPEVT_STATUS_MISSED_ISOC) &&
+	    usb_endpoint_xfer_isoc(dep->endpoint.desc)) {
 		status = -EXDEV;
 
 		if (list_empty(&dep->started_list))
-- 
2.1.1

