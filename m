Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70EADC28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 247642177F
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 17:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="mXk+Td1i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247642177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731986AbeHCTv4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 15:51:56 -0400
Received: from mail-bn3nam01on0068.outbound.protection.outlook.com ([104.47.33.68]:1854
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727466AbeHCTvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 15:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YJzB+KnyFKhLEmWrAsNYQ8EP3hzk/DxRcJ5zh/8+xcg=;
 b=mXk+Td1iuOAk1N7atBo6MpYVk0W+0zueHhy8hrpuFqra38bJ07s0AqfBfUIiz0ewCxWrwcS7fxXPLQ0kM9e2zOoG6lADpTRjFPvI1dJGw/kFMKyzfwqqFECFDHirr1wdOKJLICE9vcBkSBtz0gJ3N3mzus7wLUvGI2ro2jGBRYU=
Received: from BL0PR02CA0041.namprd02.prod.outlook.com (2603:10b6:207:3d::18)
 by DM6PR02MB4460.namprd02.prod.outlook.com (2603:10b6:5:29::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1017.14; Fri, 3 Aug
 2018 17:53:54 +0000
Received: from CY1NAM02FT063.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::200) by BL0PR02CA0041.outlook.office365.com
 (2603:10b6:207:3d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.14 via Frontend
 Transport; Fri, 3 Aug 2018 17:53:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT063.mail.protection.outlook.com (10.152.75.161) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Fri, 3 Aug 2018 17:53:52 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGu-0004fj-Fr; Fri, 03 Aug 2018 10:53:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <jolly.shah@xilinx.com>)
        id 1fleGp-0007cn-CX; Fri, 03 Aug 2018 10:53:47 -0700
Received: from [172.19.2.91] (helo=xsjjollys50.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <jollys@xilinx.com>)
        id 1fleGl-0007bh-63; Fri, 03 Aug 2018 10:53:43 -0700
From:   Jolly Shah <jolly.shah@xilinx.com>
To:     <ard.biesheuvel@linaro.org>, <mingo@kernel.org>,
        <gregkh@linuxfoundation.org>, <matt@codeblueprint.co.uk>,
        <sudeep.holla@arm.com>, <hkallweit1@gmail.com>,
        <keescook@chromium.org>, <dmitry.torokhov@gmail.com>,
        <mturquette@baylibre.com>, <sboyd@codeaurora.org>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-clk@vger.kernel.org>
CC:     <rajanv@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Jolly Shah <jollys@xilinx.com>
Subject: [PATCH v11 01/11] dt-bindings: firmware: Add bindings for ZynqMP firmware
Date:   Fri, 3 Aug 2018 10:53:18 -0700
Message-ID: <1533318808-10781-2-git-send-email-jollys@xilinx.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
References: <1533318808-10781-1-git-send-email-jollys@xilinx.com>
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(136003)(346002)(396003)(2980300002)(438002)(199004)(189003)(6666003)(7416002)(8936002)(9786002)(305945005)(50226002)(2906002)(5660300001)(478600001)(2201001)(8676002)(72206003)(47776003)(81166006)(106466001)(81156014)(63266004)(4326008)(39060400002)(446003)(476003)(36756003)(44832011)(186003)(11346002)(2616005)(16586007)(50466002)(316002)(126002)(76176011)(106002)(426003)(107886003)(51416003)(356003)(336012)(26005)(36386004)(7696005)(486006)(77096007)(54906003)(110136005)(48376002)(921003)(107986001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4460;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT063;1:Vdzjpv2tvWIIUyrLnkjwnYINNMP3uv4BE92NdjxR4au3XiR+6v9YOb2cNSmKwFOfDlp44j7JAnh5gr2TNWQ3QWtw5LpTaNkvNDohFa1RJOin7FxPjQeoTftlCIfc+xem
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55c5c80a-6d3d-40b7-469a-08d5f96a1405
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;3:QVpC+lNzN99yobD9G43Mn0AfdB7Z+sXIy7KWpdgAjCNrVLU59aRaJ27u0IL4u/ob1tXeZ8Q6YDljvYJzZr/QB//DbqNHLzTIgrNk1foBZpm/BED03r1hL/qVbwSWDZSucI0B2YzZFZn9m7+6q7AlVNPhr/y+icReaa99F2VRBz5pjPl+FH5Wk8BK7/aIHcxs8fd37rXLtvvulKMFOGL+VJoAuAfIcSoT+HtLtxdXXfLK6c3SLw0NmYApKnsROCOgmqYmIqQztAE6tiTr1w2WpeW3gl6O0Uqa2HhXHSw5mdG/BwQpU2dVQb9nD6LkFp1jWg52tmlOM1yU+btrEki4AVAhg3fdXKSUCYL2RWamu88=;25:rgYpWX0/dSzVHZvKg140liiW4U+Qa+D2+xa0Jkl+PYHY5H9pcnMNhBWeok2iDPD8im8MuUj3z5e3yAVU9VwtlpWRC7fRZQLdBT+qVNwwdDgSW9QpUrNeRFmM2sqKhYgKnA7WmIGQvj3TkvJ0w93Jni2B9yC1mldxzLTUcIAhjPnz8nQ+TZzmqC2BOUe8OTvhCU2y3Pc/h9njzkfyL6D7Qsu14NH+JedjYopigSKS/xG0PyJQd7ZAn/1Ms7DTouzdvzXqheFZ+UctUpZ04nKHXVXmmjsMznrfH7xi5To7HEj31eQKcB49AfFuG0G//m7wYpphnO4Pe1bnfw13juDKOg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4460:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;31:5QXyfZgC6dyPMbtX4xLjI5dg0arfqz7mDlfBTebhwECZdXkOoE9oz9ZFO8JNXPDtlWKP+E7zlrQ9QsO8Ix9OWawqeq1onbCOgxXFCGGEJ2jpuUNm3JYAcvQ8vRVCwvUOZ/w0KPNg/DQUyoqgFMj6OTqa2EtYAncZK4r2xM/Er3Kzwa4rubwAlTuFYgBFgLM+s/r4M8yvSFW02aCOrb5KrysxKRRJ9EF3k0hJ3kfjZwo=;20:MJre6KRcn3zdHeQc3u08Esx3Alc56RP2k+/eQaMhecAP0OPICJV1s73MfZS9uVFuohTbPoQ637Ut2ukGSi+m7FBl7PGZxp2XnIPVhWP+4kah5fzUNQ50NJkS6A6g/hIjRoPeTOW0TlT7K4qYykeqvU7TBJdE0X78R9xM3CFdI9kNs2ODCfeU+tA7XbHqZ2eoGLcloHkw8iRmAxBs8vxD3WjD+w3sO6gUCrj9IssoyTziQ4A90FvAjzCTKtDnmImSbUyMOBeM2GnGcdwnuHB7G1Etzk/P/OrHPnnDQYemRBtPUg8dzqLBkaakGjHnBxKYhgT2D2Uk3JuyS5Zh1fyMkJ+FlmnI9PRCcqX4TJytOevtE672HonWL2M6y0awpv6ly8Rg71adr1qYaaQlJYGxADxaE4d/9cksTLabmaL0Vo2whoudSEYOLKFRD653UtYflL6yk5qPWpRtjYc72oNMQN6E0efEQyCi08psk46fjV/RuVkJgV0Y62S5tFJ43vtQ
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB4460BA8A041C22C0F51BB5D5B8230@DM6PR02MB4460.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(10201501046)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(20161123560045)(20161123558120)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4460;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4460;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;4:r2OWd2cou5EkPqEuZDe4080TVw361TX3MEsXCN8iixg8OEdN0F/J5W8b6P54ahgUgyqB3TIN7is2VLxmAGA6rTHnU7FBnTdEMGv6WcU6/GXk3/qZNNmiT+4UcE4woeghLYdPfEPi07t9E58S+RM7D2kIsb4Cllc/iSpxIglyADFUywSE4jpnUEFSY54mS9yymuvfhJL83R7/uPNzP5M+HPbrWrJ6dOH3un6W6eNi1zAnwWQdFpBg0O7LXR/AWmU8+3J6YRUO60L/frBjBkkrFHgi4h4zkQGCI615NBbiDsd/YGHy8SbnvpA1golBRbiU
X-Forefront-PRVS: 0753EA505A
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM6PR02MB4460;23:RXKJvjhp8K5OZ1WAT+aHnT5SGHvqgBxUS9V94AdVC?=
 =?us-ascii?Q?Nfjq5XJ6hDGFX3kstbveK0Beej+qmVhFVdwF0oPete6MDRjKQ36JPIT/AJo5?=
 =?us-ascii?Q?XNw9EltFbg4GD0HELBNteV0/TOYKg9A3oGeJKh3pIQ/Q0caNb2lJ82oyILJ+?=
 =?us-ascii?Q?6KBRtmqKYApp5Uhb0SgNFn17IgsA+FYBDTcYhv6dfvAi6F6cAjp/wHqjcBBN?=
 =?us-ascii?Q?zkpWv/aMv6TmvQR4P11eFjiUXzN+IVB8aHcYOf6pLzEc+Qhxk8T0XecJ6uGU?=
 =?us-ascii?Q?7BEniOTkFAXRZcXGVVY8g4jBWahCqSxzOUrzgOLh/d4UddgdM5U5K7HEximn?=
 =?us-ascii?Q?WX0F6AS/x11iVC6HP4zmQBZWJBFzjougEnnaEJVXxZ/xUXPxM5prk6EJ6gc1?=
 =?us-ascii?Q?OoCBJhTjorDx6dBv1Y/WdFAiNDcx8KXG+rIJPEcGPZHW9B63pWhzrfoQ9cVy?=
 =?us-ascii?Q?FHlfj8OH7NKqmJiQUd1V7YAsIRdGwVSI2ou2mefBZ27nVd+ZQ8ezl5GQWf9B?=
 =?us-ascii?Q?Cwxo6INC4gZTtuVunVRup3pz/4hloa82gfmQ+IjlNgoNqR4JuOGvGpgIF5oc?=
 =?us-ascii?Q?ys3Mkj9XoWNf4afZJWlQq791/aC/tumlTBISQsnYR8lT9WlSxEAzWH5AoDa7?=
 =?us-ascii?Q?oT7g0vEpj2MbgOOzHJNFh5NSEQqczobMZu0MYEjG5qwlmCIfNvA5E0nmad2A?=
 =?us-ascii?Q?+axEfLJAkE50G+YjgaqfGKw40lPtlB20Ebkrv3F28sf/Kg/DH+rdqi7Gn9KZ?=
 =?us-ascii?Q?gnw5cSRhSK5RXE4iBYHz8LYooC5ts3hceC9hnQ/br3Qsp2HJBTPRKq+/gmEP?=
 =?us-ascii?Q?IQjS0/te4omY/16hI5UfAK2Fwwsu9wOTXsA8b+3e7eUQwdPGH5rBFR5ie2iL?=
 =?us-ascii?Q?P66lFv2kFe6cBa3BvAFA9tPztMUnPyGP1tYrkuG1vDe5dS2TLDC7TqqRN5Ej?=
 =?us-ascii?Q?GnxKHkHNWL1YCgRJPXBr++l94c/88N3i2Ebcllr6GC+FB+qtR6MeS67N54SS?=
 =?us-ascii?Q?Xt3OFxu8W76SmU/Fx3KWXrxuG//zYhepznTosMzFwsWrfKHXKXVKAZhNrrXm?=
 =?us-ascii?Q?Ks/MeOk2YT0S0wKhKTYmCjbF7tI9VK28y2b28VI9UgZHl2aoxJWA/gz4UByG?=
 =?us-ascii?Q?wCvAacd6DOze3QxHVEA/GCY3pT/5CA6jin9CADfJ3pY9KTvMXntCp4oc3046?=
 =?us-ascii?Q?LEFLJYGSl222SwkCEoVvnl8dmCmXgb+l1awpFfj4ty6s1M+7rmvbm2p+Wzdg?=
 =?us-ascii?Q?TycbTRS0XldYsKP560=3D?=
X-Microsoft-Antispam-Message-Info: PWc+I1ZimgKrwPFXiHJa/fj+Fkwcsd457dSYLaqSVJ5svsHJBjDvDz5UD9RxUm1EajkLP1WWKszqeKX2oJqhSnybQyGptPSb9U2htHcKGUYT9ePgYE4G1BRyfvOBDU5CsydyeBmIDTwG2RMM7TIzdQF4cLJ0qO3yPfu73/b4jB4GrgnolannhDM9Zm20B6uy3NEXjDp6d5n8XNFg0k40ES/HfCtqx0CkC78ltS+jczOZDt7720OGFpxL7dMbitk85v/FzE7940+NhmEt1juUKcKJl7us1aYOLZunW2XATRmATPfvD9w8ogmJVsFcbzxmxm8nuPosP5Ntv/+qhJOCH8ZB8aVWSXBikKjvFNZQitY=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4460;6:VHBxA6b+iPCQj7btQgmu88Ma0Rn/kRxYjXk8M6wv/oOJvVeOQynuZUZETv9i2KcHvc3wQA55q5BJNHNkkhcM1ro+RLKbmOsbvbL29MP4rk3AzaH3PjmGa/DzwT0v2lkiqjCo6S4p7ShvUsYfQQcWFAf1W7Xiy+gdKyTc5XINUR0b+plwabAV5FHB7Ff6nu8xOe7NPk/qyfcaoWlrY0De4HeyUrdJFqbQ0VisR7F9Ia7+APkA5vWL98yTa06Qb0jVBf6mYV0KVbOiYCH6XUFzOhbP+xmYW9aILzZkd9fuprFdNLOwp5A3Uq54GeNS1mSzGXzsctZXCTtBV+YybC5vfmSY7P6inExoalDN5mYqz/zuYq9ab2sfwSn9cJoPPOiLUsBI85+L28o2hCwWoGH9chclyA0fbJ651sICCODBSsNiAowo2dsO+m9qOk0x2KzSsq4Qn8iLP9OKekaFSfNvOg==;5:A4w4g/McXH1IK9/H+I+hFnPC7PqTWdIEYUKeeDqV8tdnS73RObxsTXsaQtb5sNbdq0+FymsmpMO+Dlj+KLuWk0hNWeccqH45coI+VCkimvrfoNr3tVNTW7YlNC68TKGVZv7icxewUd/RHIVVMxUtvTfzsMmGvUvo5I1leE1jIL4=;7:T1q2oGp7WDec0EgENmQP3yaoRg+mewYI2OUoWdFfY9DGXAGcK2+WjdxfKYcbAVKaJ2yVb1U5NACbS1jB5NOM9JxI78KDFR7UiDfow0UxxuCX9ku10OmuUHMWOUGOUxV1vYogQ5d592LSwcSgDwuTHVz8S+lri1MkxW0Zx4ZRzBgTOGKgBm4UQcddq4bqYI8zGNCOzXtcT82Ote3iVj0ARJbC1AMNgjLv6u6lInDb+2YYNREwCsOvQ8vTqHgaRpnS
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2018 17:53:52.9907
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55c5c80a-6d3d-40b7-469a-08d5f96a1405
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4460
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rajan Vaja <rajanv@xilinx.com>

Add documentation to describe Xilinx ZynqMP firmware driver
bindings. Firmware driver provides an interface to firmware
APIs. Interface APIs can be used by any driver to communicate
to PMUFW (Platform Management Unit).

Signed-off-by: Rajan Vaja <rajanv@xilinx.com>
Signed-off-by: Jolly Shah <jollys@xilinx.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../firmware/xilinx/xlnx,zynqmp-firmware.txt       | 29 ++++++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
new file mode 100644
index 0000000..1b431d9
--- /dev/null
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -0,0 +1,29 @@
+-----------------------------------------------------------------
+Device Tree Bindings for the Xilinx Zynq MPSoC Firmware Interface
+-----------------------------------------------------------------
+
+The zynqmp-firmware node describes the interface to platform firmware.
+ZynqMP has an interface to communicate with secure firmware. Firmware
+driver provides an interface to firmware APIs. Interface APIs can be
+used by any driver to communicate to PMUFW(Platform Management Unit).
+These requests include clock management, pin control, device control,
+power management service, FPGA service and other platform management
+services.
+
+Required properties:
+ - compatible:	Must contain:	"xlnx,zynqmp-firmware"
+ - method:	The method of calling the PM-API firmware layer.
+		Permitted values are:
+		  - "smc" : SMC #0, following the SMCCC
+		  - "hvc" : HVC #0, following the SMCCC
+
+-------
+Example
+-------
+
+firmware {
+	zynqmp_firmware: zynqmp-firmware {
+		compatible = "xlnx,zynqmp-firmware";
+		method = "smc";
+	};
+};
-- 
2.7.4

