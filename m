Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61F42FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B12D720861
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 07:19:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mfEgX9cA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B12D720861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbeINMcn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 08:32:43 -0400
Received: from mail-sn1nam01on0074.outbound.protection.outlook.com ([104.47.32.74]:45143
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726527AbeINMcm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 08:32:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L8Z7kP5mTFUWFChqirknmwzBZGy8jBVRgEWqX+GS8jo=;
 b=mfEgX9cAkG+zXcqSvmTyJhPltGpU8wrC56opex0sxmR2/0HuF9XzcpLKcsO+4i1JQCiShEKI6rYEQyI7i22nvMMR7455qYkd76k58Efg1O+Zr+D4SeZMaHELTzCbFLwXeYUXBYQH6ai+RlsD1YkVFz8u1aPSSi6n0jBk+xxsJGA=
Received: from SN4PR0201CA0041.namprd02.prod.outlook.com
 (2603:10b6:803:2e::27) by BYAPR02MB4470.namprd02.prod.outlook.com
 (2603:10b6:a03:10::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.15; Fri, 14 Sep
 2018 07:19:25 +0000
Received: from CY1NAM02FT011.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by SN4PR0201CA0041.outlook.office365.com
 (2603:10b6:803:2e::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1122.17 via Frontend
 Transport; Fri, 14 Sep 2018 07:19:25 +0000
Authentication-Results: spf=temperror (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; wunner.de; dkim=none (message not signed)
 header.d=none;wunner.de; dmarc=temperror action=none header.from=xilinx.com;
Received-SPF: TempError (protection.outlook.com: error in processing during
 lookup of xilinx.com: DNS Timeout)
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT011.mail.protection.outlook.com (10.152.75.156) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Fri, 14 Sep 2018 07:19:22 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iNt-0007WQ-MW; Fri, 14 Sep 2018 00:19:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <manish.narani@xilinx.com>)
        id 1g0iNo-0008KK-IZ; Fri, 14 Sep 2018 00:19:16 -0700
Received: from xsj-pvapsmtp01 (xsj-mail.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8E7J7tT031776;
        Fri, 14 Sep 2018 00:19:07 -0700
Received: from [172.23.64.106] (helo=xhdvnc125.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <mnarani@xilinx.com>)
        id 1g0iNf-0008J9-9C; Fri, 14 Sep 2018 00:19:07 -0700
Received: by xhdvnc125.xilinx.com (Postfix, from userid 16987)
        id 6A5B912159B; Fri, 14 Sep 2018 12:49:06 +0530 (IST)
From:   Manish Narani <manish.narani@xilinx.com>
To:     <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
        <pmeerw@pmeerw.net>, <michal.simek@xilinx.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <manish.narani@xilinx.com>, <sudeep.holla@arm.com>,
        <amit.kucheria@linaro.org>, <leoyang.li@nxp.com>,
        <broonie@kernel.org>, <arnaud.pouliquen@st.com>,
        <eugen.hristev@microchip.com>, <rdunlap@infradead.org>,
        <geert@linux-m68k.org>, <ak@it-klinger.de>,
        <freeman.liu@spreadtrum.com>, <lukas@wunner.de>,
        <vilhelm.gray@gmail.com>, <gregkh@linuxfoundation.org>,
        <kstewart@linuxfoundation.org>
CC:     <sgoud@xilinx.com>, <anirudh@xilinx.com>,
        <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 1/4] dt-bindings: iio: adc: Add Xilinx AMS binding documentation
Date:   Fri, 14 Sep 2018 12:48:27 +0530
Message-ID: <1536909510-7166-2-git-send-email-manish.narani@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
References: <1536909510-7166-1-git-send-email-manish.narani@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(1496009)(396003)(346002)(376002)(136003)(39860400002)(2980300002)(199004)(189003)(5660300001)(8676002)(103686004)(126002)(26005)(4326008)(63370400001)(39060400002)(336012)(476003)(63350400001)(16586007)(426003)(8936002)(486006)(110136005)(11346002)(2616005)(44832011)(90966002)(6266002)(50226002)(7416002)(51416003)(186003)(356003)(54906003)(446003)(48376002)(76176011)(81156014)(50466002)(316002)(42186006)(6666003)(81166006)(305945005)(36756003)(47776003)(478600001)(52956003)(2201001)(72206003)(63266004)(106466001)(2906002)(36386004)(921003)(107986001)(2101003)(1121003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4470;H:xsj-pvapsmtpgw01;FPR:;SPF:TempError;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT011;1:YRB2QXa7I7WmDqECSXtaEwghx6kGMLh6Azs4u1PQGec+h9Rch7yWCf3TPVKddXn3TEXrgcFLzvsJXMhuUNUWXLqK1UP0i2L/QdPWL9jQGG2HS/RoEGDP6O3Qvd3osaTL
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 70ca5991-072b-4de8-5704-08d61a1265a7
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(2017052603328)(7153060);SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;3:Xhn+bWz25KyiEKa1O4BsoHisIvgRVtBg/d9VSQHplY7I+grLHc+iBdB6/XtCLT2gv14vB1QXYSMKS8Qr9aJeXLU7MkjfMDsPW9unRbah+yDOf6D22sA7tuOtNvgVUFskQvQG9kaYbgVuK6SNa+GbQ4vn5irK+sCDYWPZGV+cg79znNovuRc7EH3Bpcqz+AGKyZ7xSNCtXwFICOU9A6i7ppcEdlcgKoTqr39hNxOz09z7v3zwualDAibfGbBefAwk5Cu3upYe9vJi7bSNJDUjr+Pa3jUlvaA1AMNvTHzzcDxJwAOU1ZdHX4bv/rDuYqIj8oEa/K7myAm/xvZ2ZEFgSc+MaDcj9PJIiquB+VbA8xA=;25:AWy6uA5in74/kafOIpQh3aLaX+5juOyMrZglsy7O5BoHysE599xsd53XV3UYXpd1wqXvujgxO94O0OmNV58HLA9YgoOwCHP2P4mVVWDX2ROHF5OnDWOGnNO8WMLkamVUjAH0U87eCHiUdQDIxViyLXOVUNy9Uk7JNHjW0ert500ZU8v5CtQruRsbORp7H07qfNhZecBaHX/ZdDsagLuEUd5uYCmAGduauoZ/TZIozUqlgr9Vi4UDtu+MxuGlL71oI182QQUOoSshhKDn8A3c8GT8+pFTguuS8OweqUN1fKyleTTjMdN1EGOVA+jFVg+vw/jo4hlwMi7NHIyZAi6H2w==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4470:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;31:zn4uiAxPP/BdySfOeAmGZKU/o8Gory7QXttI2zHd3Hep2Bl+SnPl26RNtcRtUlTlckdctXWHifr3JMa6D639NKIhW03Yb/WW7XNgXy6SBePtF1Fsw7vNUq9WxmMpmPABqAZhRPFnveD7elTQ5/5B8Rr7xj6wBDG5fqzimFHupFSkq2gPniO20zDkBBjJ59D0CF2iHuNyk+PKldDjNshpzpS/0L6Sq+7PQvvn6K+nsKs=;20:K/SReUlV7NODMyoi74LP0lTpgGclGDiT26mNnwS0Dd1lQInu81MNVZ8gGDt4Eey67BCITfKHEJglN4ke/zm8m7b1gUMQYS1RzkY/t0bGGMgZJxzDuAICCLqIQaUm8qykh1KFALMAPHvDCa2dZnbK5IY8isOnYfc0Wda10gmMxWKOc8e/oQ/Ab9lP5Hb0RiPjKOu/I9Q7UuccCs5Li3FPjqLg0OJ8lhg4KaV7AjvH/yJnYmfWOi4AuYqvIe9Dlf/7WWprmkvgNstIVeHnVc8ss7DDbCyZJQGpNr/KcxI7CzQB71yCCicCEs/qZITMRiEzYM5qqJtw60BOJDIL6aaltvTM5ZVn68cokZcaIehER/0ISaO3iAdl9AHVXzBnve3RZ/iRnrVVSnXfcdRI1XCuEeHgcWezaSu+/rg9bhZtgnguMbPl08ksI68xzkxt0YrJ/HW/qsSbmDiSPKeIsyfZ5tbmT9njhEoaMZncMuWynkC0veTqcD1k0Hx0iOKOb9Ze
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4470061050707021C642DBDFC1190@BYAPR02MB4470.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(72170088055959)(192813158149592)(105169848403564);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3231311)(944501410)(52105095)(10201501046)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201708071742011)(7699050);SRVR:BYAPR02MB4470;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;4:oa3xPJCnHUoyzG1yjb3TN9AiMfCsHe26uVPMBE9ih4kbcOjFz0FJy3DePeoN74V9JK4nHeRLL/3j0GiknA/ASCUw6fonMldeJ7EWamD0XkvctK43RGPYHqvMoueEqw3LeHHDL2isccBMvj2g08xnyKJOJkUJdfxE/c6riWVKpURJ4ys0tZ+7BZQuVVr84nKNA0Zd5qhQeXVcGZsx3Bmb2Xc0ijJ3l86LDFnv3ZY+EddVcVoz2ZCqRuHmZ4v4tNfcRf7lIM6AFeVbSGEYqj9dyg8YwuvzpouM97xmGBmsUlQ4mUbpBjlTEEu7gLCboZ//4MgcZh0fcU2KTlR8sVdAwgJNnbDGCFLdisYOshWEL5ZVqndbVR5FJcSgn85wxfrz
X-Forefront-PRVS: 07954CC105
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4470;23:JI2t61ftzOvnFRUNS5D3JapNmekTjXIjyXZHP+2lS?=
 =?us-ascii?Q?xTNP6839z1wh96oJMei2ROYrYTTT5z0lItofqj4gTe5N6T7wZ2pLqimd72+l?=
 =?us-ascii?Q?7QUL14/GwVDm+ePlqYgu0n4eoumVaBaiR40B4wOgmTcvKl0OTqQOIakmJX1O?=
 =?us-ascii?Q?SV6Hd4Vm6UBdmoyJNhTWoM4stlEaTorhUOJU4xHYJaoHaRftV54a7/x40U3I?=
 =?us-ascii?Q?n+jiD3aWwQcWvjoGtQsfw6EVwrdgzw47nMA0Q+LZXAu52gBNniT7vY8pFQmo?=
 =?us-ascii?Q?bhg4i7brR1nFHUmvwLWqrWMqoj4SA8VysjEFqmYdyfNGtrTtW3l59x2pm5js?=
 =?us-ascii?Q?2e8cHFj8sZSPM5O5rroF8VadfGRbhF6ziPpHyaZtmapNDIDrUJybWbkPOlYz?=
 =?us-ascii?Q?hTQ4phwQfInk5r4mj2FXCAzQhIMgbx8tBbDuYAepV9ugBZ60immGD7RhZ9lf?=
 =?us-ascii?Q?rccvIddMa0MB+vbiCichKPa8ot0gfnET4hayIk15Oe6lFVjH2VvzFfAXTGHk?=
 =?us-ascii?Q?6E6KMsxLfx/Ouro0I8z7VxvLj7YCXmR3qfELGOveeLHDsS02QKP8XuqOxyw/?=
 =?us-ascii?Q?yDRNdCHFJ3wgY+9zl+kiYC+i7eS159Vw8CTUQ8O3jidiAQz+XHSVUdyl9Cge?=
 =?us-ascii?Q?rB/EY19b7H/SvRaAizwOjyLXDnvL4rDWxCYgnhdidUbvY6JZ8NQNRgbx9bJi?=
 =?us-ascii?Q?Zr82t65iViKXIhelr8luFjHzgbvBgePVWaufdtr2Inxu5YaMih3YjAbDSnpd?=
 =?us-ascii?Q?390rlvY/fJx9ljDq02YU+i/ipCSc/ICOOMKW1dKjMS9lO0rhd0M8UNvgdq9E?=
 =?us-ascii?Q?7XzPrmCNKSrWZE5Zsa9LFGFugQH54RfE9JEv/LrvIv3d/GKHLltLaq/oshVd?=
 =?us-ascii?Q?Mzx+Vu9oHtjQAJyX/9OtmQWunhA7wqNvzDjafmkAeIL6MtB2EF/dvuHTzyBK?=
 =?us-ascii?Q?+caj07zd2yJLiHXp8g+wqJ4RgVmO2gT4rZgN1onK3OROrBorTz0+g2xmY04l?=
 =?us-ascii?Q?1j1q3tPD4Y0XHiemFHEi/qVGYz9d3GNIfIlPD4ze/bWMpM1ts6urABNlPKgP?=
 =?us-ascii?Q?zTiT88CMVJcS1akQM4xTrx1qLSiPNlprrSO06LAM/4LwPotEONAsmWSMYsNN?=
 =?us-ascii?Q?G3YV5pN3GvCHoIOvdqTTxSbzuBxRKuMnrbp0paT/DIQeIki2wXRPwYw/qQQi?=
 =?us-ascii?Q?xl5wtdkw2RE/o8sxs2zbVQ4RAkYDv7b7FlOAIVHviIGgVlR/hbIn0AF32iWb?=
 =?us-ascii?Q?WDLsJ8EUBj/zmtNTWV1IrH/XopDhsmfmDgdEFjsq7NvBL5XJRWyosth9Bg0z?=
 =?us-ascii?Q?B8tSXlTEQhEdMkU5AszX62dnt29Yl0h2aL+IlPPljcgXMonCS1ez8zt22eTJ?=
 =?us-ascii?Q?JLcGw=3D=3D?=
X-Microsoft-Antispam-Message-Info: Gz2lOA88MR24AaVi+BC25JkEl9W9vL23xPOjmeRONPoo/Z/tWuuP9PJzAdW93WCC5pwwzpSVLxNVs5gMnCVgNayGAPsy4t4W2IZkSgq7VTuRe8i+MNVSHJVRrx3pXq50q6/I5gRb+O1Nd5mKa6RRh55EgP2calW3i1M5VF8acxHBxKh5y3X6HjtQ/e0NwXZw7W8lHHc6DP8NTXyQoacMb9YiIYfz2X2+WWhKIsT17HHJ6HFYjNU8rDL8nqlo4gnPiH40bcwCyBGiGodG5oRTE/NN8JRWIUwpg7VsJ1MqqZWkHI4HKoIvckeCCcmN0Ydsc0vTRWA8Gvu0ItwAX3QxAuGmr3B6+jH9F8B8QV9XzWY=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;6:iAaeiUE5OmpbxNc1FR694oLU96i+ipdMLTgy0DpcoYG9sFim/06H5d9bRde48zEOJAWu1G6/pYBQSdB8yz94aGUInK6bldJD360fykTT+fDINVA3n+3anDhqGcI3UKtRhqYlXcjCyaWRyEVtoCRIy7hrVCtJHj9vV0u/b0WH+zLtuc+h2ncb97mbnC+C+JcdBX7YfEuXcpUosp+YXi3FRNrmILfHDIdo6EOB96zeRZ0BbFgLJk3KTJw922FW0Ytnw/r6hpzRO9x3xw8iXs3lxfVdvLKs3By4hLVwGZMqDBBCaykK2EyFPVGsv+d5Z1ry31OJO50eXy2CCzE3PIqMCZbdjReNeZwtvqgyB4gfX+QoBP3v9CYFt4l5rrMIzKOTQGaZKnucVGu5kYGKUte2kC8jv/dElYcSf3kyD1MCM+pdGa07SnKYZ4AkAikwY9ZrLK3ytXhw/HJQCuzrQ3FvcA==;5:p+dlBAvR2SsDVf8EfqB/mjMuob9tkcVS2ZMuVynvmG40Qkwn2FvQWc+AEAspplEUCE28mfAyKkbdwOgk0yrZq3vv9bOv3cnou7bO41DhVi4TaRyBOpkGW+AtiHgNm4+Iy21p0JbNxQhZJT8vq4HE3tm9c3Ip1tLE5tTx+0cDZpg=;7:/Xx3wukx9aJ0Lo7KaM4tOk1IEZrogeVNU7d+xX0u6haqQjKzd830GDujnnNMpA9ZFtPjMTih3gW64L9CKKOE8qf1cP1ZOjzqIjuH5DwRLVUv0most/74o2KWacgifTH2A+JVGOQkBYLJSwSi//Za9swCNiwpm2heVDEh6XT2oZwbhNiC6Y2/P2X+7j9oBXkywZHYyS+8gE0dSI1m5ckP6O1+eLLTHQ3iLZm+q1mRErjWsZoAKuvFsVh9QMhXRTVd
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2018 07:19:22.2640
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70ca5991-072b-4de8-5704-08d61a1265a7
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Xilinx AMS have several ADC channels that can be used for measurement of
different voltages and temperatures. Document the same in the bindings.

Signed-off-by: Manish Narani <manish.narani@xilinx.com>
---
 .../devicetree/bindings/iio/adc/xilinx-ams.txt     | 180 +++++++++++++++++++++
 1 file changed, 180 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt

diff --git a/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
new file mode 100644
index 0000000..d0958a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/xilinx-ams.txt
@@ -0,0 +1,180 @@
+Xilinx AMS controller
+`````````````````````
+The AMS includes an ADC as well as on-chip sensors that can be used to
+sample external voltages and monitor on-die operating conditions, such as
+temperature and supply voltage levels.
+The AMS has two SYSMON blocks which are PL (Programmable Logic) SYSMON and
+PS (Processing System) SYSMON.
+All designs should have AMS registers, but PS and PL are optional. The
+AMS controller can work with only PS, only PL and both PS and PL
+configurations. Please specify registers according to your design. Devicetree
+should always have AMS module property. Providing PS & PL module is optional.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams"
+	- reg: Should specify AMS register space
+	- interrupts: Interrupt number for the AMS control interface
+	- interrupt-names: Interrupt name, must be "ams-irq"
+	- clocks: Should contain a clock specifier for the device
+	- ranges: keep the property empty to map child address space
+	          (for PS and/or PL) nodes 1:1 onto the parent address
+	          space
+
+	AMS sub-nodes:
+		- ams_ps : Used as PS-SYSMON node
+		- ams_pl : Used as PL-SYSMON node
+
+
+
+AMS PS-SYSMON
+`````````````
+PS (Processing System) SYSMON is memory mapped to PS. This block has built-in
+alarm generation logic that is used to interrupt the processor based on
+condition set.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams-ps"
+	- reg: Register space for PS-SYSMON
+
+
+
+AMS PL-SYSMON
+`````````````
+PL-SYSMON is capable of monitoring off chip voltage and temperature. PL-SYSMON
+block has DRP, JTAG and I2C interface to enable monitoring from external master.
+Out of this interface currently only DRP is supported. This block has alarm
+generation logic that is used to interrupt the processor based on condition set.
+
+Required properties:
+	- compatible: Should be "xlnx,zynqmp-ams-pl"
+	- reg: Register space for PL-SYSMON
+
+PL-SYSMON optional sub-nodes:
+	- xlnx,ext-channels: List of external channels that are connected to the
+	                     AMS PL module.
+
+	  The child nodes of PL-SYSMON represent the external channels which are
+	  connected to this Module. If the property is not present
+	  no external channels will be assumed to be connected.
+
+	  Each child node represents one channel and has the following
+	  properties:
+
+	Required properties:
+		* reg: Pair of pins the channel is connected to.
+
+		    'reg' value		Channel Name		Channel Number
+		    -----------		------------		--------------
+			 0		VP/VN			      30
+			 1		VUSER0			      31
+			 2		VUSER1			      32
+			 3		VUSER3			      33
+			 4		VUSER4			      34
+			 5		VAUXP[0]/VAUXN[0]	      35
+			 6		VAUXP[1]/VAUXN[1]	      36
+			...
+			20		VAUXP[15]/VAUXN[15]	      50
+
+		Each channel number should only be used at most once. For
+		more details on channels, refer table given at the end.
+
+	Optional properties:
+		* xlnx,bipolar: If set the channel is used in bipolar
+		  mode.
+
+
+Example:
+	xilinx_ams: ams@ffa50000 {
+		compatible = "xlnx,zynqmp-ams";
+		interrupt-parent = <&gic>;
+		interrupts = <0 56 4>;
+		interrupt-names = "ams-irq";
+		clocks = <&clkc 70>;
+		reg = <0x0 0xffa50000 0x0 0x800>;
+		reg-names = "ams-base";
+		ranges;
+
+		ams_ps: ams_ps@ffa50800 {
+			compatible = "xlnx,zynqmp-ams-ps";
+			reg = <0x0 0xffa50800 0x0 0x400>;
+		};
+
+		ams_pl: ams_pl@ffa50c00 {
+			compatible = "xlnx,zynqmp-ams-pl";
+			reg = <0x0 0xffa50c00 0x0 0x400>;
+			xlnx,ext-channels {
+				channel@0 {
+					reg = <0>;
+					xlnx,bipolar;
+				};
+				channel@1 {
+					reg = <1>;
+				};
+				channel@8 {
+					reg = <8>;
+					xlnx,bipolar;
+				};
+			};
+		};
+	};
+
+
+AMS Channels Details
+````````````````````
+Sysmon Block	|Channel|			Details					|Measurement
+		 Number									 Type
+---------------------------------------------------------------------------------------------------------
+AMS CTRL	|0	|System PLLs voltage measurement, VCC_PSPLL.			|Voltage
+		|1	|Battery voltage measurement, VCC_PSBATT.			|Voltage
+		|2	|PL Internal voltage measurement, VCCINT.			|Voltage
+		|3	|Block RAM voltage measurement, VCCBRAM.			|Voltage
+		|4	|PL Aux voltage measurement, VCCAUX.				|Voltage
+		|5	|Voltage measurement for six DDR I/O PLLs, VCC_PSDDR_PLL.	|Voltage
+		|6	|VCC_PSINTFP_DDR voltage measurement.				|Voltage
+---------------------------------------------------------------------------------------------------------
+PS Sysmon	|7	|LPD temperature measurement.					|Temperature
+		|8	|FPD Temperature Measurment (REMOTE).				|Temperature
+		|9	|VCC PS LPD voltage measurement (supply1).			|Voltage
+		|10	|VCC PS FPD voltage measurement (supply2).			|Voltage
+		|11	|PS Aux voltage reference (supply3).				|Voltage
+		|12	|DDR I/O VCC voltage measurement.				|Voltage
+		|13	|PS IO Bank 503 voltage measurement (supply5).			|Voltage
+		|14	|PS IO Bank 500 voltage measurement (supply6).			|Voltage
+		|15	|VCCO_PSIO1 voltage measurement.				|Voltage
+		|16	|VCCO_PSIO2 voltage measurement.				|Voltage
+		|17	|VCC_PS_GTR voltage measurement (VPS_MGTRAVCC).			|Voltage
+		|18	|VTT_PS_GTR voltage measurement (VPS_MGTRAVTT).			|Voltage
+		|19	|VCC_PSADC voltage measurement.					|Voltage
+---------------------------------------------------------------------------------------------------------
+PL Sysmon	|20	|PL Temperature measurement.					|Temperature
+		|21	|PL Internal Voltage Voltage measurement, VCCINT.		|Voltage
+		|22	|PL Auxiliary Voltage measurement, VCCAUX.			|Voltage
+		|23	|ADC Reference P+ Voltage measurement.				|Voltage
+		|24	|ADC Reference N- Voltage measurement.				|Voltage
+		|25	|PL Block RAM Voltage measurement, VCCBRAM.			|Voltage
+		|26	|LPD Internal Voltage measurement, VCC_PSINTLP (supply4).	|Voltage
+		|27	|FPD Internal Voltage measurement, VCC_PSINTFP (supply5).	|Voltage
+		|28	|PS Auxiliary Voltage measurement (supply6).			|Voltage
+		|29	|PL VCCADC Voltage measurement (vccams).			|Voltage
+		|30	|Differencial analog input signal Voltage measurment.		|Voltage
+		|31	|VUser0 Voltage measurement (supply7).				|Voltage
+		|32	|VUser1 Voltage measurement (supply8).				|Voltage
+		|33	|VUser2 Voltage measurement (supply9).				|Voltage
+		|34	|VUser3 Voltage measurement (supply10).				|Voltage
+		|35	|Auxiliary ch 0 Voltage measurement (VAux0).			|Voltage
+		|36	|Auxiliary ch 1 Voltage measurement (VAux1).			|Voltage
+		|37	|Auxiliary ch 2 Voltage measurement (VAux2).			|Voltage
+		|38	|Auxiliary ch 3 Voltage measurement (VAux3).			|Voltage
+		|39	|Auxiliary ch 4 Voltage measurement (VAux4).			|Voltage
+		|40	|Auxiliary ch 5 Voltage measurement (VAux5).			|Voltage
+		|41	|Auxiliary ch 6 Voltage measurement (VAux6).			|Voltage
+		|42	|Auxiliary ch 7 Voltage measurement (VAux7).			|Voltage
+		|43	|Auxiliary ch 8 Voltage measurement (VAux8).			|Voltage
+		|44	|Auxiliary ch 9 Voltage measurement (VAux9).			|Voltage
+		|45	|Auxiliary ch 10 Voltage measurement (VAux10).			|Voltage
+		|46	|Auxiliary ch 11 Voltage measurement (VAux11).			|Voltage
+		|47	|Auxiliary ch 12 Voltage measurement (VAux12).			|Voltage
+		|48	|Auxiliary ch 13 Voltage measurement (VAux13).			|Voltage
+		|49	|Auxiliary ch 14 Voltage measurement (VAux14).			|Voltage
+		|50	|Auxiliary ch 15 Voltage measurement (VAux15).			|Voltage
+---------------------------------------------------------------------------------------------------------
-- 
2.1.1

