Return-Path: <SRS0=m5O9=ML=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77400C004D5
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C23C206B7
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Sep 2018 17:18:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="5Mr/nzOP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C23C206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeI2Xrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Sep 2018 19:47:42 -0400
Received: from mail-bn3nam01on0052.outbound.protection.outlook.com ([104.47.33.52]:7250
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728464AbeI2Xrm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Sep 2018 19:47:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGpkK3n6uiWiMPve2zeWK2/1IWMBqZaWbmj78HyDyAA=;
 b=5Mr/nzOPVwO+SRzkKsKDCFTxjyAJ+4RY7IST1Ues+gvpCN6+apJHCMAMUPcUhWcdCXwAbwA+lwP7d4R5SDXhvkhg4IlJRHQm1OBelisZKIJ0eVCgbER3nd3cvg7pGPJa305x6z+E5g0FkH7Faskn9SWtiArT+upFcU2WwnF8oF4=
Received: from SN4PR0201CA0003.namprd02.prod.outlook.com
 (2603:10b6:803:2b::13) by BYAPR02MB4470.namprd02.prod.outlook.com
 (2603:10b6:a03:10::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1164.22; Sat, 29 Sep
 2018 17:18:25 +0000
Received: from SN1NAM02FT037.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::205) by SN4PR0201CA0003.outlook.office365.com
 (2603:10b6:803:2b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1185.22 via Frontend
 Transport; Sat, 29 Sep 2018 17:18:24 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT037.mail.protection.outlook.com (10.152.72.89) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1185.13
 via Frontend Transport; Sat, 29 Sep 2018 17:18:24 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:40016 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1g6Isp-0001Ah-Th; Sat, 29 Sep 2018 10:18:23 -0700
Received: from [127.0.0.1] (helo=xsj-smtp-dlp1.xlnx.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radhey.shyam.pandey@xilinx.com>)
        id 1g6Isk-0001eI-MZ; Sat, 29 Sep 2018 10:18:18 -0700
Received: from xsj-pvapsmtp01 (smtp2.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8THIHIx021908;
        Sat, 29 Sep 2018 10:18:18 -0700
Received: from [172.23.37.150] (helo=ubuntu)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <radheys@ubuntu>)
        id 1g6Isj-0001e2-Fs; Sat, 29 Sep 2018 10:18:17 -0700
Received: by ubuntu (Postfix, from userid 13245)
        id A8B7C3C408A; Sat, 29 Sep 2018 11:18:16 -0600 (MDT)
From:   Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
To:     <vkoul@kernel.org>, <dan.j.williams@intel.com>,
        <michal.simek@xilinx.com>, <appana.durga.rao@xilinx.com>,
        <radhey.shyam.pandey@xilinx.com>
CC:     <dmaengine@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/4] dmaengine: xilinx_dma: Introduce helper macro for preparing dma address
Date:   Sat, 29 Sep 2018 11:17:59 -0600
Message-ID: <1538241480-13844-4-git-send-email-radhey.shyam.pandey@xilinx.com>
X-Mailer: git-send-email 2.4.4
In-Reply-To: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
References: <1538241480-13844-1-git-send-email-radhey.shyam.pandey@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-Result: No--6.298-7.0-31-1
X-imss-scan-details: No--6.298-7.0-31-1;No--6.298-5.0-31-1
X-TM-AS-User-Approved-Sender: No;No
X-TM-AS-Result-Xfilter: Match text exemption rules:No
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(376002)(346002)(39860400002)(396003)(2980300002)(438002)(199004)(189003)(51416003)(47776003)(4326008)(81166006)(81156014)(8676002)(8936002)(50226002)(48376002)(356003)(305945005)(5660300001)(478600001)(6266002)(34290500001)(186003)(63266004)(36756003)(90966002)(103686004)(2201001)(2906002)(42186006)(316002)(106466001)(52956003)(76176011)(336012)(426003)(54906003)(110136005)(50466002)(6666003)(126002)(7049001)(446003)(2616005)(11346002)(476003)(26005)(486006)(106002)(16586007)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR02MB4470;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT037;1:3dXZPBnvaPKUrUIMU+eg84keREh87o0FnPSEUVbDBpVpOVWiLUzpKEcqAM0aiQgPK+KjrevlsyqmueKkmN5kowuuZmYsN3sXVupU/QtBO8wfJsFf+BboGGnknTC2Ak/i
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 38fb583c-5c67-4b8d-16db-08d6262f9054
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534165)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;3:TX3ZFq9upenbtZj/pdgoyDrdXCWC/z5+OqJ2NBEd9toxZ9KVcHXk4YEVTneUhmnK28Hu8TdBlPVz5E6IsrqVeUpbAq4cvLLfFVG4vCe1l0WEvXH672hJrQ51SkVwduLEJUXoLobf7o7HgCZn9tiqV0u9TCF5gY+/RYbjaEpljicA9lPYTI1pstnt1xsZVOlZDAC1OuPbyKt5fjHTOcf8Y8HzVJUnC9CDy/Vx0aQ55z9wJ0NYnZznV1YQdT1CoAqkF3cVbHCCazqmHwgoqUIYQtXy4C1QcrcoVBSK+UWTifrKF+R+uYpHKNzDq1pcyDPjIdjpV08UwRP6IFaXZlI5f87wsBn1kVH7TBMIS1CVarQ=;25:1a6hC8xF1lY524phOZsBjaenJbTrQeZdnWxhPeH6xJspRIJCkuAyVP1ZhIrdHv/6Vs6IV5zWY1OAwmaay8TcG7lID/6E8elo9knwqmXjfGy+u4jJq+APg9IX9WmQVsBZeGcRyMkCZZ/n/wgY0bltHXPr3PbswV/KvEAEESVsOoEF9SIxTI/zJFas7DJC3pb7j7E2Oou3zEZwHYM9m5TzNBxLRdV0uWPXUNO/DmIi9pMFWnmkDE45MZIFdec9ck/s7eEgJ86zYbbcVG9ysqMZSZ0EKakLipZeWUNmsDUXI05LtXvUw/K23o79Py95qYjDpY/04yEaxvaLdpHc3AFVJA==
X-MS-TrafficTypeDiagnostic: BYAPR02MB4470:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;31:D5QYPKSDGKVU15RyZiWZfGR6helxQzs569yo6noW+xiqmac16YA+z1nhbxOj3lwjOCcpYKQTXCngPQkQUsHg/g1hG3H504DJo5DX3rH+rUqWeHFBGkXoXAjas2V7W/Mj494mX3PYCBoW15ZlXH44VgFmERM8CwzcORyTKUpByZimzolTllyUNZF1JkPr5BjbA+XfXhgFNmrwovxsc45AFmaa8/waQVA6Lp9EFvH1gyQ=;20:zxQ3Jp8fdNI44uCmYJIVFpjRYgKtUb1hLJiG+kNFJ21cXpZ+w69gYdc7uVCwNwec86ukWiJv9nP9gS6vF9QxcuI+3e6T15wgcyL77LfgujdydTFC0sTWRpuwLivqhxVGqoZB/qfBGCcLok2oRWIiVgf/3CzI/lHwB/qO+cLFQnohGpDpGkLzQcHjtZSI9Fkg5aNsDVlama7SzCKHTiCciAgydf5bhy475s2ekSQewU5OfpmnkJfGO7R8+u+D/SyXpJqbT7iimgQVIYp/EYcOFMw8AOTu/+d31w31JO0qOGwk3/N7NaTz7WsWl+RrG02LHcwnBt/yQD76R6axysphbXpxenvmnqW5xggp0N5QzoAvN0hu4xLcmS56Q2HR9ix/Gohnyvc54DT8cZSaOu5zrhD/7y0GGlLRady69kkUr27zGA60HF7XiHbLECYDsgyTCB9AG9nsrEGIgOVe4BVOwGBMISqtoSpms8WZIca16H7ApJ5xvd8eyOHNDivpSoP/
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BYAPR02MB4470F7C4739E13BE5501EA48C7ED0@BYAPR02MB4470.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231355)(944501410)(52105095)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(201708071742011)(7699051);SRVR:BYAPR02MB4470;BCL:0;PCL:0;RULEID:;SRVR:BYAPR02MB4470;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;4:W7wG0PqN9KA+GOsc4xYSZF1rX/a9y4slIwVWlK5DQSfkf05FZ/VATe0itOhiwd8VqariNJJ5KljJmolLaV3xpCAAT2IqdtMu3hA/+8nFX/CEVyvqoR5Blka//kyPaM9RAruSo+Z9fUZO6svwa9/wFwQP2Lu17Fz8BDksu44c0qd076DJO6mT3+MvXSbM7A9BuH1OZIAg81/LLXsckxF3qiL4FHTgWy7gUeet15hsOODUBP/L9Q8JKlmbtxYrClt9sAiJ8Bzozo2HDzW+oA9AorCyk6ajlR+IsdEJuyaqjRSeWameqRd3zT2mg46TG19O
X-Forefront-PRVS: 0810818DA0
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR02MB4470;23:vLDmSpU4sUdGSRBRCBs6rcvpaAOxChiaI4zTkA3kX?=
 =?us-ascii?Q?z39TZVwza1qFYDvu1xB6ne+YaeH3EO2bfmMSeIJFC5FlIZZ7S7NRjo5e8V5I?=
 =?us-ascii?Q?X1khkSsbCOkE2WkSedKsPeS47fXJXiYZpN5bi5PqqRIGd+0v9U3vNrNxFJlm?=
 =?us-ascii?Q?hInKzshktScqCZshBiirWOdKzgZXqbHu5IjjYFzQ/7QY7F6Tl6BEgp2vNNmz?=
 =?us-ascii?Q?4UYTycxam8ZdfdK0Mzp9S1hVxJG8om3Ns87H7VfowpdK4VkjSZ+wD/DRmqql?=
 =?us-ascii?Q?loRJNif+GYuaGUnqMgUaW9mJl59xPvYRBAVxFo8uAxZL0jOC+ZX30hXg8Msu?=
 =?us-ascii?Q?9tiNUW/icgLhEELLv6PEUTjhqE6Cm2+N/f/fVqaTiIvcb9jrADAIRR3qyS/i?=
 =?us-ascii?Q?y/DLEWMiJ8ed//enUHfZsggxxhafReSc+FWwMuH2DnAc6GgcyGZxNCVMax0S?=
 =?us-ascii?Q?fyGA1RNj/wb9LoGvTaE/HlTCGUJlYhd495PKr4dQuk4awWySh7r8j5pFHGg2?=
 =?us-ascii?Q?LWBTXfq7HjvwldmJnQQDMV8wDaVNR/CxXnWsVR6ypeKVl5flyD5r++iYU6BO?=
 =?us-ascii?Q?gCX8SsdRMkdbN69uu/Nv6Ll+jQjeEx9yr0fSABBVUGy+NwMjGVF66+7BWogA?=
 =?us-ascii?Q?81ZvF8nqhQndTgK49g8/eKCYP1PeK23Zi7/IGCoWjmbgjXhhlslWWgvWXBqu?=
 =?us-ascii?Q?5+Ue9tcAA0NagIJMOePrqT/1KOXnMoIlrpQ/80RtEnARAnaNRmw9xe0UtKoY?=
 =?us-ascii?Q?Imzgel+0/0KV+hnLqu208xHLXq1nNpPpOkGaG6EYU42gdfZOQ8R9Q+DDseGC?=
 =?us-ascii?Q?qAA7b2zBkm4cdZ7qIPPsmt6PwAqUVbeuQJbziYYxypKx+4kSV8izfJh2Pqnn?=
 =?us-ascii?Q?UXvKONwnSRy9NjGEZkE62/UO/w80MadwOQJS3O1reINW2ABYa8R4dmmzdY+G?=
 =?us-ascii?Q?oHxiBRzzGvXq7kfZfnXDhw6HdsyUVSl/AXQtjr2q8F85NqP6dCc1i7p6yCik?=
 =?us-ascii?Q?+NXxLIMi3L9BmwA3K+0Jj3y+E2afDbjBgGk42l1wQp/OzHcDMy4qiu0AhBzv?=
 =?us-ascii?Q?WNUq+PD6474V8IDCSG83nTxupDrzRZ8/OWZ8MLCEL1kLlPpW64C/wMRmVIoj?=
 =?us-ascii?Q?YXmr3rpwKH5CfFFnv09U+BtzXClX91XbwjryZpTKeg6G3NgpED9H/YZ0g5Xs?=
 =?us-ascii?Q?xzMM1JT/abOTRqjfiSwRJPZ5Cfkskjcgk5h?=
X-Microsoft-Antispam-Message-Info: 0PlNRao1mG0XZDK9Kkm+VTxR5CBev/6GY1977GZ2J2yESGDaTQnGGMR2pUub3JLfzQEW4aIY0ROsGX5qSt+bw+CGz28mu5zfqsHl0kac02sb1yacNTKlI9Zy8v6mMf9e1bD3Ikur0ZkyaPqYaP6cV6gBRUWR5qsbdR/nJ19Y/uhYOuUse86TfmAs5XthWGSFwybgQRa7ZhVfZ3A+677pQd4luaGeWOPN+0mpbygM9jrQvebcSYksMITEWmolGqfvCaevVxLvkxXQul0fGXK2XZYCR4H1C+ZSmF2mELIXzyyP8NlkBVlbTboXYHXllr7lHet+Kjtj1kHYPhYFWbIfsg6+p0afMGf1Qc3ju/AW7g8=
X-Microsoft-Exchange-Diagnostics: 1;BYAPR02MB4470;6:ZQkBiS0YjkGQDzGWy6NzlH86SWCI8I4OP3PhAHuY36dQmwf+kHEjIK4dcy8SzOWFzLuc9Pj7feE4jJGE4LxxSJMxhwqPtHseHr1NGb10kiJsiiJJH1xSAmEtV3FPyTC4zWAPUQJdJPMrpgQ+48xMsNtufJFxslEl0rBepsIKfRQ0SIrQX6TZ3HJHleXBnBL68Aqky27VoLleQX+t8k7ayCVeb84rWd/hcMLXfg5SCpL+THIqovShOx7PxNNX/2/4RhM/v9eDkQS4Tvji42WDuFV+yu9VfC9YihA2KQdVzxxoptYWkNNbNkkdpg2yObHeJaP+QXos+1RrSjKAaU+Dygh7heJw6DrifzUptjO5ELcPO2U9QAj1b5D26CuhrV3YL8W43NHriJ2FAiPrrh1N5/i3LEqh2Vrcl6XudmxSYRdCq5i3x4azg4K/hWTM7TOqgxDptEEoKCFnWnEPMjuvdA==;5:FE2+R75z1Tj3AuXG0E9uy5y9nq0hditC4j/VRHxxhT02qUgL03jWGKLL3QqqPCezBLBEZRA/ESQIytPes8Q4dXZt9kBzD1XTMPXfY++YKl2o4GlyNiTVaoT5kZSlj2V/fvKIdd80psosgduKkJS65PlniF89aP/XZ9pLe7Z7QnA=;7:DtgcOjkUQ8PDeFM6sAQgBXKDRM26fsekKkU6N/aKFgHP50Tbedxz7XxtANy1crfaSAOpEgw9sZ50Sj36NlDGx80a9ao1OgOVAmwvRrxNOVcZu9OVeMBAiMBe3Yhx1uL6UYp4TxZAHw41wCCuCx+UWePBsD6ZGkbRveIohtnTT8/l7MdQ40eWmb9do2bTE40WygeEbMgZqmdVSfQzEQsBSQoLORLpWmIpwzWKoUvb3zC8BKK79uv8FJtHRIP2wNFD
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2018 17:18:24.3908
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38fb583c-5c67-4b8d-16db-08d6262f9054
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB4470
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the xilinx_prep_dma_addr_t macro which prepares
dma_addr_t from hardware buffer descriptor LSB and MSB fields. It will
be used in simple dma 64-bit programming sequence.

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
---
Changes for v2:
New patch- Preparatory change for 4/4 fix.
---
 drivers/dma/xilinx/xilinx_dma.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/xilinx/xilinx_dma.c b/drivers/dma/xilinx/xilinx_dma.c
index a37871e..c27ab64 100644
--- a/drivers/dma/xilinx/xilinx_dma.c
+++ b/drivers/dma/xilinx/xilinx_dma.c
@@ -190,6 +190,8 @@
 /* AXI CDMA Specific Masks */
 #define XILINX_CDMA_CR_SGMODE          BIT(3)
 
+#define xilinx_prep_dma_addr_t(addr)	\
+	((dma_addr_t)((u64)addr##_##msb << 32 | (addr)))
 /**
  * struct xilinx_vdma_desc_hw - Hardware Descriptor
  * @next_desc: Next Descriptor Pointer @0x00
-- 
1.7.1

