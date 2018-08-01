Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58C7BC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:04:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1C41208A3
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="UVwXB+IJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C41208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbeGaLo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 07:44:29 -0400
Received: from mail-dm3nam03on0064.outbound.protection.outlook.com ([104.47.41.64]:41792
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727409AbeGaLo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 07:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7J805yM4+ls8rFeGV2r30cMBaadRAI7NqEOvqT46MM=;
 b=UVwXB+IJNMcXtZXjHnGjgMF7yh99L4ZODn+X9q0BXvPXGIKKje9RTBPPs+YsPyw+hNN5YT+T4PvFWkSsWYOecBKOIMnrp7Oc/YuJBsW5ffCCiJ9LB3L4X/hpQbZdbOt5M3spPNYjLV2HDE0yiV6Q3uT2G+uOIU+WTRtqTGfJL4M=
Received: from MWHPR02CA0026.namprd02.prod.outlook.com (2603:10b6:301:60::15)
 by MWHPR0201MB3515.namprd02.prod.outlook.com (2603:10b6:301:77::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.18; Tue, 31 Jul
 2018 10:04:50 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by MWHPR02CA0026.outlook.office365.com
 (2603:10b6:301:60::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Tue, 31 Jul 2018 10:04:50 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Tue, 31 Jul 2018 10:04:46 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40370 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fkRWH-0005eM-EV; Tue, 31 Jul 2018 03:04:45 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fkRWC-0005Vb-Ac; Tue, 31 Jul 2018 03:04:40 -0700
Received: from xsj-pvapsmtp01 (maildrop.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6VA4UkC020250;
        Tue, 31 Jul 2018 03:04:31 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fkRW2-0005Sf-GF; Tue, 31 Jul 2018 03:04:30 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <soren.brinkmann@xilinx.com>,
        <atull@opensource.altera.com>, <moritz.fischer@ettus.com>,
        <nava.manne@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <appanad@xilinx.com>,
        <chinnikishore369@gmail.com>
Subject: [RFC PATCH 2/2] fpga manager: Adding FPGA Manager support for Xilinx zynqmp
Date:   Wed, 1 Aug 2018 15:34:57 +0530
Message-ID: <20180801100457.25614-2-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801100457.25614-1-nava.manne@xilinx.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(396003)(376002)(136003)(39860400002)(2980300002)(438002)(199004)(189003)(110136005)(186003)(11346002)(26005)(9786002)(77096007)(336012)(356003)(106002)(446003)(50226002)(478600001)(2906002)(8936002)(426003)(486006)(39060400002)(36386004)(6666003)(217873002)(81166006)(48376002)(81156014)(2201001)(106466001)(36756003)(52396003)(50466002)(8676002)(63266004)(305945005)(5660300001)(47776003)(316002)(2616005)(476003)(7696005)(51416003)(126002)(16586007)(1076002)(76176011)(107986001)(921003)(5001870100001)(1121003)(83996005)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR0201MB3515;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT009;1:75kZnhS+DdA2I4OSk5/snzGVFJLhEfYog0TCoCwSYW78kX2z5t+IAf5GdGUTUmQiYvPGx8f/nPbOGGzxzLxvV09a8/2SSPaBWaIe95Smv7DZC+XvLoBceivqhIJ5sVAv
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18aecc3e-cd24-4772-5efa-08d5f6cd0d5c
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:MWHPR0201MB3515;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;3:uzkCa6VPYeBzV73wQE39VkNYDryQIxHZKGWLV0vbEUtC+fo17/rXZ5LuN+eqEfxtxQjlD4vB5vLWeGTeKWVPUBubKMAOz/frZ7tam8ux6blyqOxycutEEvLfowbdb6ZB17D4IMiYr0ssqwTkioxjwkRMT7O0sp6uaymeaSfUtqHHe0u+kgq9YUtd+Vic6BauzC21ObD+2JJgWgrWgasHaKfH+1ZiO9DHIYhoc5Sk79EXU2x1Kb9V0xtGPVWOazaOlQJei6Wo9+4osMowVNhkigKoCySLXSTbsj0P4xN6tJQGp/jcl6dw5HyC0jxAlaGgKf0ElMdn7RhHrh5Yu9T4cls18XECjEycpqeq2a0RkMg=;25:1i8+P8mpHrNK3XX4qnWLOo6+VNuF/dVpJkvKmRPNN0WZEpODcZ2p0EIVhJ1zi6t7Zy85EccDg1kH0cpSV8z+TceHSIZFz0fuXQVeMELTGj+kMY0b82+/U4kMsruTe3v5VN2BX5oGyQscBSf58JNMOLvTPeDO16/INK/IZwsiyTQ5b0HvyCslQbw10aIwIxfn3c6XjZM2hJGEB29sG1h7uIXYlLtGWXnI1JV7yWmaowNwi01C4uHbi3F0zwhSwLD9cpEz7xwuoVsCjuOC3hyDpGdR2K3mAN2SyfUTASpzkBHcCajPKCAEWLEHy7Ji58CSUxhiOP8dtrfbHWWHN0b4Rg==
X-MS-TrafficTypeDiagnostic: MWHPR0201MB3515:
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;31:sLcqKndr3wAlPoqHUW9RfngGmxDRDUvPHGupAMcI+Q8LBeayw8hoOeOpNC2cngfJgFUWO2q6MfsFgbUyg3yxYGiUyUuNDL6oq8S/LliKPAwgWlaYG6UuAUn87AiQUjArQk0CbwG1KslXMNU/qK9sUJ8zmAHTcbXL0IwZnOYsCVA+llF+xrx44OVhPKTCt71j67gVoXog39jkM3JnBSEqCCacipeSKLyrDwXY1mUTVHU=;20:I8kMzKd9K/SSiULxY1AgpE+BNWPY4Jqx/TTBWc7BEaa000pIxBuJXUne6Z1GgQEFVf704K9uftKgc46eG3w8SI3ZRwBKML93fsBTRDUWxU73jMbg0iRGex28+BKhJV23P+DzaRewvwHRWUDfhkjxEV0VlDPdNbZqE08yi6fFETfc9Vd62g5pnng6Pbq/cDLT51fg79KdxbuwvFs0CNYo3pKc1jmV/HX+WLemcVC0uf7jvnLaIv1HAFHmNUHSnMb4cHHYgYrhyTWV47EbEe68oqP2zAah2N+SHHL2t9FhQ43dPaRu7fate+Exiv0VrNM18wo7oPH+KWykB6j/dwvQ5wqP4GJPkfYTge8DpbAz3nmieF90Iiy9XrzH2wDue2otH+nhVBp7OsqRxDyyw6gmXY2X8CulC9hZWuhb3oLxGwvYx+XYwu0KZlLlcJR318sZFIYQDpwOnmVIJrBqCa3G3MOzvlHsyd3Qrcg8+yF1XQabHp23o3H9uPHyhEGV7s/U
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <MWHPR0201MB3515E726AA7906E19F458EC4C22E0@MWHPR0201MB3515.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231311)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:MWHPR0201MB3515;BCL:0;PCL:0;RULEID:;SRVR:MWHPR0201MB3515;
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;4:LM/olCKxj5QjZCscE/2VPgb0Jo9JwVKnvipABnMeUzm2hpDkNc19ozrt+8nK+Kk+T5bsTNDXPrzEzFnCEkRtwje8Iov61fKpfkjXID67NF0muKt/vyPoOXG0sw1U6iKsRL3nBdd3rSSXr0ms2hu4X1W3vDfWJSBIIUYzvi+3FPGdz+Gv1KISZmEr0mZEgf/qbFZPNOvPcyGWD+QZ6Z62E1iYnPD/uT9pFVjuzBBvBZQWysWBbj3iZaMCbYipZkk/BJJzHUp16rCpsaGdOGKPxGcmqjso8Ca69ekprDHYvar9xP0OL0diO15H5l7lMqjb
X-Forefront-PRVS: 0750463DC9
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;MWHPR0201MB3515;23:kmKSVFSVryuqSKG8As1pLNh035lEDUQlA6sTlyz?=
 =?us-ascii?Q?uVhkC5Bm0dMLvfF9DHufWz433O0dgVycxRWR/JaSbJEmhV/qgdfmtEq076LH?=
 =?us-ascii?Q?YB9jjmadwZRWuL2KVebQ2cmqbyhGgy4UPIxRsMO2XxNpVRXAQzbaH55J5/sN?=
 =?us-ascii?Q?6HuFcNyr531C0n7VSoXqHgLBws1blyC70wvOGLmmJz37nB00Cv6Vk1XRXsCG?=
 =?us-ascii?Q?9U7bGyK8bG3emv2Zky9sQ7U9djCwfqoZIxIG15g6FrvK9hnC9ElvfcHqEm5R?=
 =?us-ascii?Q?OJ803KYxI6LZFiOiHz/C7JNoXpZFqY36Jf6H/mTt4fgpgYTAKpcXVxPjds6j?=
 =?us-ascii?Q?QxlTdl+qyOuqKo+/I0+VI2JpCQaq1KQc4RIFMfykNgy0fdd+Lc5kPqL9Hn4/?=
 =?us-ascii?Q?b/9W1JEHmY1G3is7S7wTgQVGsl6evjwrmRHccf5/szBjOuqjhxvEOy8jWSr1?=
 =?us-ascii?Q?iJS4SNgMLr2NK/uIpIZakIpFMuuTsEd85PJSfwJjz/YCNgZwpdspLCNd4yqi?=
 =?us-ascii?Q?fCQ5R1PFcPWNqxK5jhF0ZDm1BAwLznfFsQd3teYHnB8UOKLPHSsFU0n3f35l?=
 =?us-ascii?Q?FP4Tgtr87qy+3dK7wQyQ0BQXyzOY8tk7tqFH2KOWC3FHDp1P7JykFV67Unk1?=
 =?us-ascii?Q?sFpcOmyttjqL9tXDxVFyi571xa+YBn64dMFoD3zgeBGyRGgbld5xkuxL7KUZ?=
 =?us-ascii?Q?UliJmRK5KXIcwcetEA3A538iP8M31xoTzUoAJ37WEmYGD9QdXbnVwYv3XTFg?=
 =?us-ascii?Q?t8tXPez1NruKEUgHzsNSBK3xpfzSyBwm690rKB03HszkJNhy/ocGqgA1Ws7p?=
 =?us-ascii?Q?e2HFfGsDpvtnLBbR9G1JDSX/wSDlFa+BkNEXNx11TGlNqsEdUJkHQ7Ti8AGo?=
 =?us-ascii?Q?KDKntqrSpUpOqsFqotlu/n+M+3M23ML2Ig8mVcZJT9rt9bUx2CNKt45Yl48h?=
 =?us-ascii?Q?7tov0jt6YmnUhCzLWYwAmlEtxlP6sDclk3s3KsRFQUwRVtYJ4yAtPj0qsBYo?=
 =?us-ascii?Q?Yocm4dtQjxyoAY2nTJmLgwp+yUEE2hIl/vspXdmMZOKl5PIE288ZAZ+bkDH3?=
 =?us-ascii?Q?CMbpEnYtxmaQ5beTsy/QN1DNgXSZAro9dW9Nx2fHW4fFMSbArraS4oF1eQQ9?=
 =?us-ascii?Q?sJWSqMA6KOkEtGXHR7fhHdsh+ATUQgm9Pb1COpPnoJxIo7NnHtKDV5gbEuvT?=
 =?us-ascii?Q?oYousrNets3hmlmN2Dst8+dgv20t8mMxPuRkMtS6RUyTnn3vOQBuEnZfnUQ8?=
 =?us-ascii?Q?yZQ7CdApnLglHCJ+RIRLRjjpvLVTvMHIjdo6BkqgB?=
X-Microsoft-Antispam-Message-Info: 9/zB08BHp033PUEw/Uj4z+4Cu47gLuiqkuH2OzwsG8swrDjVpCzJ2lURwF9yPm+r1FOqp9u9S8bNv0F5ggil7oeZ8BvCX2okK0W2QY9zOvY+lpuja/qw5LCxUY+KPp0dAF1WwVCCCcgSrIb8738Q6fMAFbuARPTf5fDZko5Jl3iSzv+JT3XpuZYC9hk0JVpNbWyrkS2bIhwCj+0LUXXJe5eAX6l6+njuNYgIrQZgC1r81KJIXfTA9dvo4ckWNHn5UnvjBpiHr6+S3O18ALq/phEB6t2o8J7cyzPLB7QtQG8biUCV8psVasJdFeREmJocw6x4mHfhWbzYxy3sQAkO4KzBgBK3/V2bM080fmROtZA=
X-Microsoft-Exchange-Diagnostics: 1;MWHPR0201MB3515;6:rBVTgADGuwaIWMKAYwLAJx9/HnKJL5w0TDpg+WTp9ufyUcsem5k2Ff8qHGr2Uv2fSelCN96LtoiDuPVmxEqJi6bKYwUgLteiELk2Wvn46JmTibArLUMj0i9hhDFovkmqG9CZ4KBtYWL+7fjci9fXkDjsFv5JU7AI2jK6LOoVaz4su7dVIQMrKQ6RpOdyNB/Gbzmo+vByhTEzlPj5b651rEHW6JpuWLas2OXt5WO7IFP6SsHkFPsUe4GjXT99XR3N51b3S/ifdv5p0XOj29CWqlOXcut/txPTrVFJrYhgaAO8h91aUkCUEYV2MBhotSJdWk/xkNmxzyiopWiYm1Ti+f6HhCQP7Y8CFBpzlZdv7PVEU8A5LYPomHu9vAXR2/0uL12EkZLCLbqCSm8ShyUlOSVVUz/zgyRo61AP3L0k8HIgUu5IGm9FA+hLhfaLleA68sxds/9rwEfVe9DIumGTDg==;5:FTmWy+kUJPlc/Wih3nF/oryRqhS7JP65yscscay81JC9rju40unRS79L9jtCc7eX3QhbNIgKIRoSqQYiJQW1PbL1D/EjtH/egjM6ec5k7pMwXjpUpdXt9mrbftu0aO+Kjhd6dP3+M+tGVoxiRm1ONcCyq0URqBo3Ab50TuZMl8w=;7:j4T1UEVIeYH1H8kmoqFXCWCPX6ZiG+/f/DUxJd8XooyGXEgTll3pfhcvt6fkP/63QrRgynwszPjDVYUJWoRVhm3axb87mmgInZvdqEzhqW0WAzBiKv8ViDgkXT6U1Y9+iT6hgMqBlEGdshCPeN0VaWAXO+kSFQjOBTdeu3YcaU+8PuyPkiOtHSH9XYHCdKDvt8ALVtYUq6Ad/7ygxqGUhjz5A7cH/rOjhWRnK1tFjSYfQ6yhh7sjcSZ5rTB3nWq8
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 10:04:46.4115
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18aecc3e-cd24-4772-5efa-08d5f6cd0d5c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR0201MB3515
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds FPGA Manager support for the Xilinx
ZynqMp chip.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
 drivers/fpga/Kconfig       |   6 ++
 drivers/fpga/Makefile      |   1 +
 drivers/fpga/zynqmp-fpga.c | 164 +++++++++++++++++++++++++++++++++++++
 3 files changed, 171 insertions(+)
 create mode 100644 drivers/fpga/zynqmp-fpga.c

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index cd84934774cc..b84e3555b3e3 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -26,6 +26,12 @@ config FPGA_MGR_ZYNQ_FPGA
 	help
 	  FPGA manager driver support for Xilinx Zynq FPGAs.
 
+config FPGA_MGR_ZYNQMP_FPGA
+	tristate "Xilinx Zynqmp FPGA"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	help
+	  FPGA manager driver support for Xilinx ZynqMp FPGAs.
+
 endif # FPGA
 
 endmenu
diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
index 8d83fc6b1613..ef444512cb01 100644
--- a/drivers/fpga/Makefile
+++ b/drivers/fpga/Makefile
@@ -8,3 +8,4 @@ obj-$(CONFIG_FPGA)			+= fpga-mgr.o
 # FPGA Manager Drivers
 obj-$(CONFIG_FPGA_MGR_SOCFPGA)		+= socfpga.o
 obj-$(CONFIG_FPGA_MGR_ZYNQ_FPGA)	+= zynq-fpga.o
+obj-$(CONFIG_FPGA_MGR_ZYNQMP_FPGA)	+= zynqmp-fpga.o
diff --git a/drivers/fpga/zynqmp-fpga.c b/drivers/fpga/zynqmp-fpga.c
new file mode 100644
index 000000000000..e4172c3a6868
--- /dev/null
+++ b/drivers/fpga/zynqmp-fpga.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright (C) 2018 Xilinx, Inc.
+ *
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/fpga/fpga-mgr.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/string.h>
+#include <linux/firmware/xilinx/zynqmp/firmware.h>
+
+/* Constant Definitions */
+#define IXR_FPGA_DONE_MASK	0X00000008U
+#define IXR_FPGA_ENCRYPTION_EN	0x00000008U
+
+/**
+ * struct zynqmp_fpga_priv - Private data structure
+ * @dev:	Device data structure
+ * @flags:	flags which is used to identify the bitfile type
+ */
+struct zynqmp_fpga_priv {
+	struct device *dev;
+	u32 flags;
+};
+
+static int zynqmp_fpga_ops_write_init(struct fpga_manager *mgr,
+				      struct fpga_image_info *info,
+				      const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+
+	priv = mgr->priv;
+	priv->flags = info->flags;
+
+	return 0;
+}
+
+static int zynqmp_fpga_ops_write(struct fpga_manager *mgr,
+				 const char *buf, size_t size)
+{
+	struct zynqmp_fpga_priv *priv;
+	char *kbuf;
+	size_t dma_size;
+	dma_addr_t dma_addr;
+	int ret;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->fpga_load)
+		return -ENXIO;
+
+	priv = mgr->priv;
+
+	if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
+		dma_size = size + ENCRYPTED_KEY_LEN;
+	else
+		dma_size = size;
+
+	kbuf = dma_alloc_coherent(priv->dev, dma_size, &dma_addr, GFP_KERNEL);
+	if (!kbuf)
+		return -ENOMEM;
+
+	memcpy(kbuf, buf, size);
+
+	if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
+		memcpy(kbuf + size, mgr->key, ENCRYPTED_KEY_LEN);
+
+	wmb(); /* ensure all writes are done before initiate FW call */
+
+	if (mgr->flags & IXR_FPGA_ENCRYPTION_EN)
+		ret = eemi_ops->fpga_load(dma_addr, dma_addr + size,
+					  mgr->flags);
+	else
+		ret = eemi_ops->fpga_load(dma_addr, size, mgr->flags);
+
+	dma_free_coherent(priv->dev, dma_size, kbuf, dma_addr);
+
+	return ret;
+}
+
+static int zynqmp_fpga_ops_write_complete(struct fpga_manager *mgr,
+					  struct fpga_image_info *info)
+{
+	return 0;
+}
+
+static enum fpga_mgr_states zynqmp_fpga_ops_state(struct fpga_manager *mgr)
+{
+	u32 status;
+	const struct zynqmp_eemi_ops *eemi_ops = zynqmp_pm_get_eemi_ops();
+
+	if (!eemi_ops || !eemi_ops->fpga_get_status)
+		return FPGA_MGR_STATE_UNKNOWN;
+
+	eemi_ops->fpga_get_status(&status);
+	if (status & IXR_FPGA_DONE_MASK)
+		return FPGA_MGR_STATE_OPERATING;
+
+	return FPGA_MGR_STATE_UNKNOWN;
+}
+
+static const struct fpga_manager_ops zynqmp_fpga_ops = {
+	.state = zynqmp_fpga_ops_state,
+	.write_init = zynqmp_fpga_ops_write_init,
+	.write = zynqmp_fpga_ops_write,
+	.write_complete = zynqmp_fpga_ops_write_complete,
+};
+
+static int zynqmp_fpga_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct zynqmp_fpga_priv *priv;
+	int err, ret;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = dev;
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(44));
+	if (ret < 0)
+		dev_err(dev, "no usable DMA configuration");
+
+	err = fpga_mgr_register(dev, "Xilinx ZynqMP FPGA Manager",
+				&zynqmp_fpga_ops, priv);
+	if (err) {
+		dev_err(dev, "unable to register FPGA manager");
+		return err;
+	}
+
+	return 0;
+}
+
+static int zynqmp_fpga_remove(struct platform_device *pdev)
+{
+	fpga_mgr_unregister(&pdev->dev);
+
+	return 0;
+}
+
+static const struct of_device_id zynqmp_fpga_of_match[] = {
+	{ .compatible = "xlnx,zynqmp-pcap-fpga", },
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, zynqmp_fpga_of_match);
+
+static struct platform_driver zynqmp_fpga_driver = {
+	.probe = zynqmp_fpga_probe,
+	.remove = zynqmp_fpga_remove,
+	.driver = {
+		.name = "zynqmp_fpga_manager",
+		.of_match_table = of_match_ptr(zynqmp_fpga_of_match),
+	},
+};
+
+module_platform_driver(zynqmp_fpga_driver);
+
+MODULE_AUTHOR("Nava kishore Manne <navam@xilinx.com>");
+MODULE_DESCRIPTION("Xilinx ZynqMp FPGA Manager");
+MODULE_LICENSE("GPL");
-- 
2.18.0

