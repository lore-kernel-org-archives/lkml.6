Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C0C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:47:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 447C920880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 08:47:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cern.onmicrosoft.com header.i=@cern.onmicrosoft.com header.b="D2kbpFK/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfA1Ir4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 03:47:56 -0500
Received: from mail-eopbgr60062.outbound.protection.outlook.com ([40.107.6.62]:11808
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726415AbfA1Ir4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 03:47:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cern.onmicrosoft.com;
 s=selector1-cern-ch;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq0zvXEJIlFKGTZaqpfHDnDphUIkFh7Ye6QXX4/eq5U=;
 b=D2kbpFK/aDNZd8DYLs6eftWvCpYWoNKGhgDtEHS5wZGT+Ehw7KWSuuBGMyRA49xtvqhtj7vo/flx47I9I1rOrudcwAcCpUcc1M9vUEirpKMSq1wRzuLbQohDctu9eO0FHxCPsqe68aqOd6JG6I5Z6CmbaDCS/V9QOWNjmWZpBe4=
Received: from AM5PR0601CA0033.eurprd06.prod.outlook.com
 (2603:10a6:203:68::19) by VI1PR0601MB2271.eurprd06.prod.outlook.com
 (2603:10a6:801:b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Mon, 28 Jan
 2019 08:47:51 +0000
Received: from AM5EUR02FT031.eop-EUR02.prod.protection.outlook.com
 (2a01:111:f400:7e1e::207) by AM5PR0601CA0033.outlook.office365.com
 (2603:10a6:203:68::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.16 via Frontend
 Transport; Mon, 28 Jan 2019 08:47:51 +0000
Authentication-Results: spf=pass (sender IP is 188.184.36.46)
 smtp.mailfrom=cern.ch; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=cern.ch;
Received-SPF: Pass (protection.outlook.com: domain of cern.ch designates
 188.184.36.46 as permitted sender) receiver=protection.outlook.com;
 client-ip=188.184.36.46; helo=cernmxgwlb4.cern.ch;
Received: from cernmxgwlb4.cern.ch (188.184.36.46) by
 AM5EUR02FT031.mail.protection.outlook.com (10.152.8.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1580.10 via Frontend Transport; Mon, 28 Jan 2019 08:47:51 +0000
Received: from cernfe03.cern.ch (188.184.36.39) by cernmxgwlb4.cern.ch
 (188.184.36.46) with Microsoft SMTP Server (TLS) id 14.3.408.0; Mon, 28 Jan
 2019 09:47:49 +0100
Received: from pcbe13614.localnet (2001:1458:202:121::100:40) by smtp.cern.ch
 (2001:1458:201:66::100:14) with Microsoft SMTP Server (TLS) id 14.3.408.0;
 Mon, 28 Jan 2019 09:47:50 +0100
From:   Federico Vaga <federico.vaga@cern.ch>
To:     Vinod Koul <vkoul@kernel.org>
Reply-To: <federico.vaga@cern.ch>
CC:     <dmaengine@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
Subject: DMA Engine Documentation: TX Descriptor and Submission
Date:   Mon, 28 Jan 2019 09:47:50 +0100
Message-ID: <1655406.8MLMLfCWyH@pcbe13614>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [2001:1458:202:121::100:40]
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:188.184.36.46;IPV:NLI;CTRY:CH;EFV:NLI;SFV:NSPM;SFS:(10001)(10009020)(459900002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0601MB2271;H:cernmxgwlb4.cern.ch;FPR:;SPF:None;LANG:en;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 574a7355-db8f-441a-7bc6-08d684fd49a9
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(5565046)(2017052603328)(7153060)(7193020);SRVR:VI1PR0601MB2271;
X-MS-TrafficTypeDiagnostic: VI1PR0601MB2271:
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0601MB2271;20:4P5pLgsvW9f5EnHt8L0C7y3s2VUcqAKkez18U3n7Aieym5KrFz01VaumYGM0qNcZjG25jtq9K3rrCRtuVCiW20VjUD5LsR/MnJJqRZOcbKnhHfpfJD/JR7u12+3h9brrTjbBP20yPmfXahzP105zxGvnezl0JDm1X/x1/n/rVgcVZJn/xKHkxuUzpkKbggNEmHwkaYURfqN5Puv4NTODICGwSK0we0k1bgnUv2/CIA2O2GN7jV26F2DX/5iBpgyTA4p4fOp5F9rpwdAdyZNuOKOUCoWt3UFYDAlkaiqlhq/98iUTQu32GBhIni+Ne4ovO5Alz0l+e7Kr4xyL//nwg28U0+IAqQzLsCQRzYZYfjuA06huw6QddbVnPEr/asyn2c9XOAznDOSoSWL+MicJfKVlDfyOk9UpbqOPq9s68LiwcILTSEyeZv268CFakqhjyjr9uiJylqWJxcjZp4vc1Jv4noCD/AEUGSkLGIjtD2dG4qloylFvtudpmvkIQL5L;4:Mn3RdSp9MYMEgXDkdXDmgV50SVhrs27Vnq31v1i+yzyoG8HlLk2BxNFcC/qaNraImitXLBfZHazFxL/mf/YCrgz5y/cIhsE1gxBYK1ftJST9QJD7S6MPtaPOpbdLaxitCr+LdKpWQBUDGoBEKrbHl77Paf6sZQF9LOYnGR5qmtgW/wLjLGlqLq6iqgApipQOw1m2o/9WWk0xlVr3tsHCRgi9xPQ5dwLCb07NIiz3dx9laSEZwYKxRnYX03g5koGp5miNKRj4MRclLnftsCN+gv7YhBi94J3BKcqld8eY6ef49e1lasJCpM05LnrD2BZA
X-Microsoft-Antispam-PRVS: <VI1PR0601MB22715DF5A500532A15147BF7EF960@VI1PR0601MB2271.eurprd06.prod.outlook.com>
X-Forefront-PRVS: 0931CB1479
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0601MB2271;23:9uQBGjRRar1RctjJH6LQClppmK7jwkQ8wi5QjXqM20zTqeOW/D4I8qJa6CMfQucP7h0Ae704Zwh+M153VGLi5lF048Qf/CjI1hMswbDQf9Oq3UtlmWV/XewhGEwS/YYCbiK+8OrM0xneXb3O1P+h74d0y826ElFJqiv2If2tS+7sl9iVuc084d99PHnvw9Vj;6:2JiwceOyZRy7hfh3iyMlwiIO0sRbEsllxC9VSOjUnQcKNuz+v7e5FEIvXlPOk0o1eubkalCxgjL7dEntNbDIxAdyMMuuDFCZmTOlcWOytVZYDIQOnGbmzAKjt8QdA4cTYoD0hEt+vBS1b3FZkxURr5hRcFRlEoJnYR0bUTqQuItxWbr32MEtfAq7g5kLdgqQXbk2t4n2QCm8MfS63Qp0Py8gGqJ4+p0kNwHBMeHj6v7l/LScsjTqJSYnfbbbIlPUAoUTgvWWjauWNsjEXq8qBWyutjlLPqNJehGoVG0mEhgeSd2YK2EF0s6k5X8e2TLa5PbbmGgRplyLSdsQE+2IA2bNoVv1mzP4kjuP5NejmB/bH9JlzzFM4poQueVMEYkKzCQV3Y93eAuu7PoxZp7Ihlgor6ZzJPMQoNhx6HFjoTsYGjTjnle1kdvka9/vUGABpujFfLKhBm4uO9J0Sdk0qw==;5:liR/A+SLN77wrUUCyZc+Lt0d2DUGbTeE/popl4wbk0p+pZjunfr2Z8j550DXu7j5imS/DABvxf9RlT1pS9Vz1Qr3KZnND3pDxJRLab9Kx4dxzOg2C11Dpf0g/lugglufXrCNvcJJAexnn44wtVoH41u9H+t2rkRj64bh1KUWTo9NiO23OvIfC3UwnS4Qh3mpzGZYmjgF109weSmEqHfkNg==
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: xK/Th0aT76rfP6uRnVjMXxbHOAIt6L+pdJ2h11rmu+7V+cOOsHCAc1e6paT9ScChr3lUvtWE3CXydALLjxQCDmwqMqJZ6ehsSVPF+P4BcyalosYvQkDuTSVzmVCN5q5ISlxc6ocMYxDCsLdTpQwUDGuDqnQls86s+stFASwap7OJHguwuyrdF1PL3G3UJB6X/yhY0gRYnFuqxN1KqEgdoKnbgrSGaxOFrqmrWBNDnVuEgW9KO3e+CcX41RDGbFqdG68o5ikQoVL+fqmQXncorAjWl7eJJV+RpVJuI4D7FHq31Dsy2jSphoe0+LK2/wgS1s57v66vriqa6mrXjhAl0ZSZpjg/E9hgO5F+cXHesXXnqfNMpZ1YcQo68WojXKqT9DwkT58xml19bAmyJ1e59uSOMXx1y3e1WJ2L4Xpga1mflUkVX+ifIKa/bXjv5stDr9oHhCq+paX23BGA5iscnEU7BolGXLryMFSgEfmKFHGgylFXMMruF/rYac9OFPaB9Aqiakv5a6ETKehBDHRIUd9dihiy4OtdeNubo3iAuz0=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0601MB2271;7:osWSFSS+ahnAVYhyEjqObQKbmpAyomGcLrYDRCY8bqBXvkbdkT2BeAXYavDbzyBZZx3pcqolco+k4lV8jZVAcLXWq44Wvk3Rq7evCUcsi4f0Nak16XQdOmJz4xfcvl/ITvL2E0lHdpnui/KW68ZBYA==
X-OriginatorOrg: cern.ch
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2019 08:47:51.4518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 574a7355-db8f-441a-7bc6-08d684fd49a9
X-MS-Exchange-CrossTenant-Id: c80d3499-4a40-4a8c-986e-abce017d6b19
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c80d3499-4a40-4a8c-986e-abce017d6b19;Ip=[188.184.36.46];Helo=[cernmxgwlb4.cern.ch]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0601MB2271
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a new question concerning documentation.

https://www.kernel.org/doc/html/latest/driver-api/dmaengine/client.html

From this document it is not really clear, at least to me, if clients can 
consider valid the `struct dma_async_tx_descriptor` after submission to the 
DMA engine.

Clients get a TX descriptor from a DMA engine using things like 
`dmaengine_prep_*`. These calls - may - allocate new descriptors and return 
them to the caller; this may include other structures which are not visible to 
clients. So, if my understanding is correct, this means that it's the DMA 
engine that, on TX completion, releases any TX descriptor allocated by 
`dmaengine_prep_*`. This implies that the pointer that the client is using 
must be considered invalid right after `dmaengine_submit()`.

If what I understood by reading the documentation and the code is correct, 
then I think that this should be mentioned in the Documentation.
If I'm wrong, please tell me where :)

Thanks




