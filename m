Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17AEEECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:31:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2C9921477
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 14:31:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="RAUCULYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C9921477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728201AbeIOTuy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 15:50:54 -0400
Received: from mail-by2nam01on0062.outbound.protection.outlook.com ([104.47.34.62]:2379
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727162AbeIOTuy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 15:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YHKTFBCrGpeeBxkWvOvxpl4OX01ojhxm6czd0z3qOaI=;
 b=RAUCULYtNwr94fhZXYfgR1V8Lx+g2D1VM7KRwn6r4ZAGIaR5HErmMdgFdMJAKqJPGTDPJJCdIhtJGajbHmynnCDD89GkRU5X9gSLW01la9B6IQZlRx2pUvKuU0PG/6NaQ7hcBZhemo5yyDsOh8ZdMmZKORxRQUXB6heLX/bPF2s=
Received: from MWHPR02CA0027.namprd02.prod.outlook.com (2603:10b6:301:60::16)
 by BL0PR02MB4466.namprd02.prod.outlook.com (2603:10b6:208:4a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1122.18; Sat, 15 Sep
 2018 14:30:31 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by MWHPR02CA0027.outlook.office365.com
 (2603:10b6:301:60::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1143.15 via Frontend
 Transport; Sat, 15 Sep 2018 14:30:30 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1143.14
 via Frontend Transport; Sat, 15 Sep 2018 14:30:30 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:34650 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Bag-0008C5-20; Sat, 15 Sep 2018 07:30:30 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <anurag.kumar.vulisha@xilinx.com>)
        id 1g1Baa-0004qu-VF; Sat, 15 Sep 2018 07:30:25 -0700
Received: from xsj-pvapsmtp01 (mailhub.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w8FEUNGL024950;
        Sat, 15 Sep 2018 07:30:23 -0700
Received: from [172.23.64.8] (helo=xhdvnc108.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <anuragku@xilinx.com>)
        id 1g1BaZ-0004qJ-3g; Sat, 15 Sep 2018 07:30:23 -0700
Received: by xhdvnc108.xilinx.com (Postfix, from userid 15427)
        id 49388604AD; Sat, 15 Sep 2018 20:00:22 +0530 (IST)
From:   Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>
CC:     <v.anuragkumar@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <Thinh.Nguyen@synopsys.com>,
        <apandey@xilinx.com>,
        Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Subject: [PATCH v5 5/8] usb: dwc3: don't issue no-op trb for stream capable endpoints
Date:   Sat, 15 Sep 2018 19:59:58 +0530
Message-ID: <1537021801-23896-6-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
References: <1537021801-23896-1-git-send-email-anurag.kumar.vulisha@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(346002)(136003)(39860400002)(376002)(2980300002)(438002)(3923003)(199004)(189003)(486006)(336012)(2616005)(36756003)(476003)(36386004)(6666003)(54906003)(356003)(42186006)(52956003)(106466001)(126002)(11346002)(103686004)(446003)(50226002)(305945005)(90966002)(63266004)(81166006)(478600001)(48376002)(81156014)(8936002)(4326008)(2906002)(50466002)(106002)(107886003)(16586007)(316002)(6266002)(8676002)(76176011)(26005)(426003)(110136005)(51416003)(47776003)(14444005)(5660300001)(186003)(39060400002)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BL0PR02MB4466;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT038;1:hiSy7ipEDN8svjgDyU95jzOrWORaTSil0fExjl1B9pclK3udwdhvd1Q2XFVz1OqpPAvTh5GXZvCgQGaQ0gELGeGMw+AahwTakOsy/ndkgGs/gV0HBuQpEuwPWQWGYpax
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f069c12-286a-43c0-e3d2-08d61b17ca09
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL0PR02MB4466;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;3:rr0jBb4jDnMjjEL1PA0I+x+9IVZ6LahGmn5Yd7kLVgd1LVSpOEQUhO5xOrNJw4jSwu43GAHD5yg1A9dmcDqIYILAk8mNOykscnzQRY5V7dH+I0FoHmbz4Kxtd4Dk9JFuVHd0VXprTd3EtIzXdckV0gTnVRoMkx1Hx5vKS/Gtms2wnNaCDNVJRlqPfQxTbhKTIXRm9k5Tu5i8efGWMi4OViTFAnjEnZV3v+qSuHW1lNoD3NR3mSzqjsYNBv1X0U+5cW0jHUR0PKllsaTnE9jq+PiJyDVEJyrVfx5bvg7KKW4IkU9UkORS1HpgWPRqDj9XBAilZOTG229BCq4kjHeRGA+qnyIFq8XPENGLu4z93/I=;25:HqnGl7r3C1iVScISlovq47NPrMZykOHJr34Vgm0EFaepaf/wg7F5r8G6INHnVU1Z6/En8snJdOwhcgQrVEFz9RU6Mbd9G2qvsYpR7ncNVph1nG5Dz871KAZmjygIPeQkuCoXoTKszTTmNKZO0YATgDknrzfrYCvDqxpcm31/bxKIIIyVJtwDR42u64zZFoq4DZJgQ7L9ScS/SPEZXdxHQwpojrBJ/Y8EuqQTIZ987B6Roam4iLixU0Jykr9WXmwcAuavh5KjUTkXCqQgcl1tHvFly5SuQOm5OrLI45ppQoKizQMW//RhGPhDEBvZCtpG7EUodcn2yZoO80/N+/BvCg==
X-MS-TrafficTypeDiagnostic: BL0PR02MB4466:
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;31:D1w1cxjtR41K4oJ1NWg5Z4LTdK84L0Yrl0jpHqCFgSnLhD+cJYc1WrPR3wg/hEONmByPz+hphFL457mVyFFXRSwQfb+QGznUhS/fwVQsiaDYqH80lYACLU7pdUMmsY+EGYTgXNnliLGHsY1fAIOKaDATK5XrmNtOSkhrWHnfDmx995u/W4nd4f6/9qwg3eE6EuvnRRfT2cNEH3OkwGUaBZBwegg2WsMFZGzG++f48HU=;20:rYXSRQ3Hl/OsfPyv6cJNCaSWlC4IO6GDg7EohwIuglVb/QuCdEFCw1oDpDcwQe7MVn6+dTNLwTSnQizFpc80lnDQs6ArIwkt/eyxiNuCI7pUEmAWPu5kQ1CRJAz+23j/KdOtrtfTv/pwFwpcxn7BFw+JKXYaOEWN0B2cq4BaJwiq96TTe3F6wuwI6n4LrQ+U3hpX0RWZ1YI3H5ptj9MM0BU7U2f1UbYkuKS5HOp0aAtbHu5TZ0rESmU8yHOGwKFaw5Z0QvTOdPelXEIp3G09KXLlmvcOWxxqMzVSs3rjSf2osige25CdGDBjlDQMG4T3PGDKqUMjftbFbhAaql79zGkadvlwl8P4q2iocD7dVCFgKluAosFkwqy8qIzqZM5XgqLMz/ZOTZZuDlqDiGbjTO8WVYJ+xE5fKh6HS6yhWnCcBoYCB1YwaC2q734MWk7QNpKsz767b6lbDkFQ4qnDzP7BKs03xdfVUxJTrCZOInrSwVb7Nd9UAGbxrldX/aYi
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL0PR02MB4466C8A06A69B9CFD1B1BF1FA7180@BL0PR02MB4466.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3002001)(93006095)(93004095)(3231355)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123564045)(20161123558120)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699050);SRVR:BL0PR02MB4466;BCL:0;PCL:0;RULEID:;SRVR:BL0PR02MB4466;
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;4:sjtwrWoeQsZzE/mEMgRDwg27jOSkR63T3uYTtUldx1wpiX3ekySGnJAklosuPTvmbaWtTlfUbii4V++k+z2aI6BK/erWKwgka6YGka8av8KEE4KJAboOaCrhRShXTR7MaF6KCqe8DDDUa0nk3hY3yd5gUqtRCqDx3AsC8Hd+JKHunwEm4wfCPyrT6eV6Br6Zw41HQcg64D1QVySdg0CaWM/opvqG86kySAJx0N3ZCpAnCbRR4zhSH1rLxPb8R4eHe7wT4UKzQHvnqLWL+FyDgz+FCgUMq1zU/D84Vr6oXU+NKurL4VbOddgQJALrQoKM
X-Forefront-PRVS: 0796EBEDE1
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL0PR02MB4466;23:ZOa8iVmwK7lds7ZfqbG9I4WVXGdajPwhPeNZ1EcFi?=
 =?us-ascii?Q?idQGUzRZaLW0Wdk5ypl9Stoow0HyrxDEBgDkXJlrc3leL592x/UeHEG5A8UO?=
 =?us-ascii?Q?uwGGGnBWwoO++kwVBy3ckjNtDE8Qg9iHW4d+dWGjaV4ysDOKVzOzJ6VeS8yB?=
 =?us-ascii?Q?vo7ouj/+htZ8iv54iDjxNn+xeM+wyh+d7x84QcNFguZGaeXZ6DeHzERZezv2?=
 =?us-ascii?Q?OOsh9H2sS+QvLUzCJ0kD2vlQBPYXit14faQT9SqCQftP2eHUVB162/2/hRI4?=
 =?us-ascii?Q?AC/vx1EgZa3RCvFmwnDWLnFr6ar6cjBq65oBQtCNuDFSbn/tfyGolMrlpMK9?=
 =?us-ascii?Q?4qkF/BCubdMwliTQDHAgdUML66AvZRvOUiXF4RYr6DR2iKam1CIS4Ya3Wt+9?=
 =?us-ascii?Q?m26snV6NgF25fSqZ0uYNsKLZj/qqAQd7Ox+IRguxSCUGISR01n0I3WWXWUXY?=
 =?us-ascii?Q?o0R01jo0wFE6vTo6pvDg4hxHoKC1LqAq+HF14liU/ClDMHl1TJ03eiEseNUl?=
 =?us-ascii?Q?nV//ZCq5uJu+M+2lFD1SBy513u8MvxsFU63dScD65fGNJLxkFQCLM6KTFOiM?=
 =?us-ascii?Q?UQz5I+Qmg+ygZzNzp3Wq1BtRGcjhp6fD1Hfb3FEBVaR5QifTcQIVCnWC3cpw?=
 =?us-ascii?Q?QnOlI9bIgoIDfxqrCb9R4MGiZUwM6O7uih9rQTZsPqGcsGm6SUpMg86z2zl5?=
 =?us-ascii?Q?kKD3/pMCWm4pJOueA5emVz+p3OigNmvyJoF9eRi2fojpXt5gd0PaiJMop+9a?=
 =?us-ascii?Q?92Cel/KbO5XW1wVKJBs0mSzLMvZ0Ht3rGw2h5/cNiJNs2h38TkKeW2v/UuG2?=
 =?us-ascii?Q?GIaoKAwMhkh+YasVh+ePJXBY/2FJAwUkCMWeY24wGw7pssz7/SnUaMfN+b9s?=
 =?us-ascii?Q?cgTMYJ5vHdI+CJuvF9neeWEtvfSPtbM87ewRYW/3LkKy4cUEedWA76kR4dYW?=
 =?us-ascii?Q?l3QGKj3105/xG/ZOfb+8upJpq1RGrqDYCn45gQIbYVx/aTUI5+f2DJ3YbGqw?=
 =?us-ascii?Q?eW+Qls7oZChzQmrBASJJpk+NNJ8m/pbHXzK8x38ctPisBSG3IM/LqbzjfEx1?=
 =?us-ascii?Q?8+JlYmNldsAtjZFALQTvXLbW6YCMwgQv158qRUrAD8mbjaUiIGl4tllcJw92?=
 =?us-ascii?Q?3QyrVBgfzwU23W843+stKIvN+XHhv9Suem77OkTnAt7+8LM28bYRFNNxQ0yd?=
 =?us-ascii?Q?iIUcMNPt2QTHr/5zmFEof6tsSZDfJLZnXB/a+gFyEWYgfpgLFPPYv1OP6I6g?=
 =?us-ascii?Q?Qp9DJ2+9WBjHzNLeKQ=3D?=
X-Microsoft-Antispam-Message-Info: 3idfDIuaWGs7Cr8HkyBZQs6c82Ai5KlYoJMQH55LCJmmi+eSzw06QkYYgVDfHMIS6bPFQ/ymL/xVEisqd0OkPVONO9YPhoEZJRxRh942GrORUWzq+xZTzmgF1FGAIUICfZEg/ShntGU19hZWf301P/mpIQD+nkw+8fJiY7E2vQ7xM31keFHCjSUFkqnrU9lL1eyVFoe62o49S6r+DVlq6ye809QN9B3zm30R5dYTf1t4whZ2Zt5zjHvVu7HUMVN4OI8Xt9sjGMuWq4kCoTeNnd1gsFDBSAOfGjed6eCd2Cn3QsrwXoW3V7x9/kQ4UJudzZOhgZjCM/f6lI9y0Gz1Fg3koYuQrhL38l4KjJgFLlw=
X-Microsoft-Exchange-Diagnostics: 1;BL0PR02MB4466;6:gYC8NjC8yuv5J37GuGJiSTgtr9Y/kNtXen6pxbGSYbYkOLlFPdyVji5xUFbKVGA+YqIQgACVAgDONlnQuFnQ30IyWmB2GVPc/hSuhTw1O7KjwVT5Y1KS+jFsfJTQzAjraorOPaZgEwFVhaEnVXpVX/qclR8E3S51k4/N8qMji5Kuv9DVYBrOhKM2q3qhpje4DwtQSUPanLvXJRZs5ncSh3Qum4XiJSSWxXLRfzJzi2Q1pc6od2lJsQFXPTJznxELzKVi5sBAAqiQT0DIHmeWQ5mbc8v02r69eeF6WbM/l2hCfbgP3WG2J4E5Jul4LqFJVduOtCkow+E/OFkqXAxW3iWZ+W+Cy1BDahWBm953qLbl7vC5YGfksXe5+wf1spGoA5RhM2Vpyte93G/On7YLeE2nr02VxwSTj5rnDCQn06R2HJa6ClKm6h/RZxK1+WWixkFd4EOJ4sqWhi0ZS5yoRw==;5:tpVQ9Cun7HmG5UHgyhQCn+m0Dovj+wAN0eqd55rJlJMfxKm3HcBkYHNl+RFzJ9/PYo+tULcorVDQDCi/v8dEEuvx+GjyglQR6VGGvO1E5cvKkIj/w0bUi3qDXFoqbhE3+odTkWx/7CyVBXAsqrQXlj/iBbHHyhyun8A7oJMs89M=;7:cdegy8eWK3ewG2GP4bA4cXnErWstRJI8OWovnKjQYfMhBgCykjNB7UyMjCOwBx7IL2bgboUaqKX27fLZ72jZ4ixVdrHBQgrF2k1Ysj6ZwZoblIjHf7NlkONzzUGOVyZzFX+SdcftHfhYnt3amlB4mHkEyhThzyb4kYj1OuHG+hUxlbBWMVm32NlKZGat4jKDORIHO1/EJZgCDx6rLkyGAgw+Clw0tErMSeQpLoTqZk66HvI6jF/2h1P49u5WhdAt
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2018 14:30:30.4534
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f069c12-286a-43c0-e3d2-08d61b17ca09
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB4466
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stream capable endpoints require stream id to be given
when issuing START TRANSFER. While issuing no-op trb the
stream id is not yet known, so don't issue no-op trb's on
stream capable endpoints.

Signed-off-by: Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>
Reviewed-by: Thinh Nguyen <thinhn@synopsys.com>
---
 changes in v5:
	1. None

 Changes in v4:
	1. None

 Changes in v3:
	1. None

 Changes in v2:
	1. None
---
 drivers/usb/dwc3/gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index e18f9b9..b2d68f1 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -677,7 +677,7 @@ static int __dwc3_gadget_ep_enable(struct dwc3_ep *dep, unsigned int action)
 	 * Issue StartTransfer here with no-op TRB so we can always rely on No
 	 * Response Update Transfer command.
 	 */
-	if (usb_endpoint_xfer_bulk(desc) ||
+	if ((usb_endpoint_xfer_bulk(desc) && !dep->stream_capable) ||
 			usb_endpoint_xfer_int(desc)) {
 		struct dwc3_gadget_ep_cmd_params params;
 		struct dwc3_trb	*trb;
-- 
2.1.1

