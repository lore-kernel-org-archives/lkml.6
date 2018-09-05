Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DATE_IN_FUTURE_12_24,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D98FFC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 736D02086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 07:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="L/DMHEYt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 736D02086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbeIDLtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 07:49:22 -0400
Received: from mail-by2nam01on0056.outbound.protection.outlook.com ([104.47.34.56]:19168
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726041AbeIDLtU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 07:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ivnYS7S16FtgJPTeX2+Ariwm4xeVvrv81aaqs1HsAaw=;
 b=L/DMHEYtTFSuR3WU/vE/gwZzw9T5ePePBBTIEeXBP/Zn7ri+8vhafRRm/fFVnRWS/qB/RErJGALOiBUE/yd8EcuxddC7cEbdIs7q8F4AWJcY1zRY5DSVa7nRFZMmEgk1WTlI9jtq6NJ6b0RJJ9A2Iy2zSn3D5TrVzGak8joRrQ8=
Received: from BN6PR02CA0035.namprd02.prod.outlook.com (2603:10b6:404:5f::21)
 by BL2PR02MB499.namprd02.prod.outlook.com (2a01:111:e400:c2e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1101.18; Tue, 4 Sep
 2018 07:25:22 +0000
Received: from BL2NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::203) by BN6PR02CA0035.outlook.office365.com
 (2603:10b6:404:5f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1101.14 via Frontend
 Transport; Tue, 4 Sep 2018 07:25:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT055.mail.protection.outlook.com (10.152.77.126) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1101.10
 via Frontend Transport; Tue, 4 Sep 2018 07:25:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5iD-0007lw-0V; Tue, 04 Sep 2018 00:25:21 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5i7-0008GD-Sy; Tue, 04 Sep 2018 00:25:15 -0700
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w847PAB4015149;
        Tue, 4 Sep 2018 00:25:10 -0700
Received: from [172.23.37.118] (helo=xhdnavam40.xilinx.com)
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <nava.manne@xilinx.com>)
        id 1fx5i1-00086x-Ho; Tue, 04 Sep 2018 00:25:10 -0700
From:   Nava kishore Manne <nava.manne@xilinx.com>
To:     <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <michal.simek@xilinx.com>, <atull@kernel.org>, <mdf@kernel.org>,
        <jollys@xilinx.com>, <sboyd@kernel.org>, <rajanv@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <nava.manne@xilinx.com>
Subject: [RFC PATCH v2 2/3] dt-bindings: fpga: Add bindings for ZynqMP fpga driver
Date:   Wed, 5 Sep 2018 12:54:47 +0530
Message-ID: <20180905072448.12488-3-nava.manne@xilinx.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180905072448.12488-1-nava.manne@xilinx.com>
References: <20180905072448.12488-1-nava.manne@xilinx.com>
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(136003)(396003)(2980300002)(438002)(199004)(189003)(6666003)(76176011)(81166006)(8936002)(7696005)(51416003)(81156014)(336012)(11346002)(446003)(8676002)(305945005)(36756003)(50226002)(50466002)(5660300001)(48376002)(356003)(106002)(16586007)(217873002)(126002)(2616005)(476003)(2906002)(9786002)(110136005)(316002)(486006)(107886003)(4326008)(39060400002)(1076002)(478600001)(36386004)(2201001)(47776003)(186003)(575784001)(426003)(106466001)(77096007)(63266004)(7416002)(26005)(107986001)(921003)(1121003)(2101003)(83996005);DIR:OUT;SFP:1101;SCL:1;SRVR:BL2PR02MB499;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT055;1:aqW4RkNiWfFveceTuNDzIXPLFE8z86V3luS7myNRrz9YpdMBFqkZbS6XYkVrqpLkEwhg/gtlfLpxwpJK3GYpFT6jt4WgMV9RldDHf3XU6kviW19ayr67NXO8+Bg2XLX4
MIME-Version: 1.0
Content-Type: text/plain
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9be35548-d7aa-4eff-07dd-08d61237931a
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989137)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:BL2PR02MB499;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;3:We1br7jI6UWr/KWoZwORtXS2MI5R+9CBt3gV4JI3xU+gQd4Ek90Kv4+dThtZWo+p0GTOOWBoT0AoJn4TRjZo5J05xACn4xi9N/RRsCbdz739r4p+eM7lsf/dy+HdfATROhUN4DvtQzDIyGZ7MLkIa9xsg3iZ3W8lz5KOHrq5oRMXACTMXSxmK3sW9Cp+0qoDxefI4f2EH0dpuxIjDt7Yd0j1YAZCYQ522VJDog+j8rIuYWm+tYLr7Q1fqD5yDd2BsPBzRrETREV45XAndu+ead0gtMfURL6+X97XLU7yQ82xVw0nMs2c0b5NX170KcxurgorVlaHTk8DAoqwT2Yr2P0Yy5fGeSIsh1+QXyowEbQ=;25:DDxSvTR66rQkifS2J4dWgKZhKEsnqDCaXkxQ3WaeCxZ+7W5KGLaJ57SBFHxcFl/NU42o5NR0hJodBbPsuZmhn+ALjDQFqmkrQ6+SevUbnHo5KzId56WqVXSsR8JHY7S8Uy/+29Fa/5fqngh9zXqiSN3m95SI34YcXk6Ckszg0vTk4YkjHMnaA4nK9EgSLcDEuPChnHXnJKQk216gZ035ZeCSgWe8Dxa0duxhmp+xVE6SQKXkY1eVILLjsXQudXajIAaiCuHAuP6arDfXpMxkwAZs4AZWLzzwz2tsekc59pGOdEJd8vmjAvZf8YDDuV/IYmgypy2m+lYNkuR69Xv3eQ==
X-MS-TrafficTypeDiagnostic: BL2PR02MB499:
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;31:McfVpfMfibFe7SpaXCQILtoT5qNCgwyrTdvX/Jk//kTXSIv3PjER+h+qvk0BDmlgb/3KhTstQrjSmN5iS856L8a43A4r+mIaihJNVwIS6+ON4Y6Vs70t9VDJz5ObHFfiaNhJGtrpP6dbZRqdXrnTaeKnXExX78pucvnyHNI+uAFeBvPJyanyq1dxLUCMBzBdoog2ddyS0v5TS2PFxg+A+WIEqVD5eULyyka5TkHVtQg=;20:7N/uFmd4NcCSYkTBm1UBRDb0EbbhijhuiJyfSGGaI4NILd9q/+h+xPw03OibfcJxOBO6Wg/kXF98RvxgNRFz67LOrduHIhTjYGOFUs1eATOEJZzNSN0UMLV4fhmkESpdDE4lFNsXpfm2+I6DUVDPnJJQrtYvblcKhP6ovuhzc6g1p4f58iMEEuWl99SG1qovFo9Q0K/eQ/zbw0SR5e18KADVzVZhT62VAwUFV7DN4AGsd8boo1FRTf1N9Wlhxe8nG7ikgVsUC6mH2jD4G+q1+izlzztUg6Tny5DL74IBoX/o8gRW5jhWVcTTzp7G7KMUU0VuSe8OTV0+nluCQmUj4y+gThrQv7jZ9+0gVSzkg+NVBjio0nIhr9zFlypMDWXdt4LI/meXU5k3l2y7UTErtuhBmybql49E5aAqObLtlldB9eWlx5kgmScshQM23CmSpzzKZXM62x/IRjyKYyFK53jhjvWIflCNnWZmN4iNvyyu++/tWFYj2fzpnAeISOKh
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BL2PR02MB499D904ECA190FC65B3EF19C2030@BL2PR02MB499.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93004095)(3231311)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123564045)(20161123562045)(201708071742011)(7699016);SRVR:BL2PR02MB499;BCL:0;PCL:0;RULEID:;SRVR:BL2PR02MB499;
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;4:qFazQcHNgmQ2mTyO5Zlh4msQ0VJ9P/ekizyJ5Df8KRmQ3GhLg94a/7J9Ow3Zawkk5SF+yJCfSvmpnjwFclEtc9o/9HPExB3izYDgvt2bG9UEFZzK79lAMlMsSKkhtEfQ8OP+/UgepWJZDXWJw5DSyyrg7XQzLxiz4jiDniwOd7ny4qEqg3O5OzvZrLM6wtGrV2Q1BjZOtB4ue6x6xdSzGyZcXyawoCdIdYfJph6PndirwmnktLUU5zLtTAxsBUEXyhAs2ZH3SMhMC7IDhgNe9I+tRC7VSLueAeMkBQNKXeYZA1E1M8Jjgihtmy42uWiJ
X-Forefront-PRVS: 0785459C39
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BL2PR02MB499;23:56NG/+b11y1Pkm2TrKm3FmUg7c0/7xAyCmWmF+PuER?=
 =?us-ascii?Q?02mla2Mp40d6SV1pZW7UH0/jYCO4mNu/hQV5yL70DiwajdLlMqNlINZxQmpy?=
 =?us-ascii?Q?ZyjAyDtgg5Jqu9XNDueIk2De4aIC/t5adedzOqfGN2jO8L2hM2gWkRquoIhf?=
 =?us-ascii?Q?uKF6beo8z57S8aciKX1eLw0z7XaT/DL+KeCi2ms9xweer+WVg3xay8kqx3GX?=
 =?us-ascii?Q?O3ZW63Lp/3IGixpgmmy9d5OAYTBSlYVY0l8GRuHh3Y9khl/RbfveuZbhRDC2?=
 =?us-ascii?Q?TBLyDOPkdnm6Q/8BVokKnuL4nJBrSsjPbDrycbpB0Vgxc3pdccfg1FxG7bwQ?=
 =?us-ascii?Q?JnT6JpHZy6L7fgrq3qjsOI+0lZ/snuyCuuXeNM6wf8922F86Iq+5JogNo84g?=
 =?us-ascii?Q?M4n2xUbCx4wxXd+HvN5fKlvvWHIi8HS10V4G2Gw07FBzW07nO+VHavhbg017?=
 =?us-ascii?Q?Og/uHrmNimBHBea02yT/YE6lh+OGRGcjYLUt5fLTENzG7bvYoBLTH03iZlWu?=
 =?us-ascii?Q?/Gc6jyZF3S25OOHTPMgUxCG6imJRx60Q6Vf8qlRW+x14x6OFpjxyyqPUhryH?=
 =?us-ascii?Q?FdHF+4KRXYT3VEsH77lUDIi1LzN0qaXGGZ8s6iDgnsaadTLYgwY1z+J+d8Gj?=
 =?us-ascii?Q?CLh+MSwH4XAhl+/OJnuvOF6y5cPEzfHbFTbiLVI3fUHXzQrPdoLC4QXWyRiY?=
 =?us-ascii?Q?YZU7O/FTGXcMV4zEt3GRPKDSOHYdhx4PZcQ0qoNTsNMJB3FR7dRrM+CGMhwj?=
 =?us-ascii?Q?+r879GcyVhwgxEm9QmPLFcWuOlK7Z52nKOiMSMDo4CAl0PYZPVGMa7+b/Y36?=
 =?us-ascii?Q?YxPqdB7JUNhkbVntSvQZuNgXFMiTu3zQ3N8TO/foMLGaXa3ikDqTLpQklgH1?=
 =?us-ascii?Q?a/8vXgptNdjyt37NIE2ruiGBodpxE5shm/GScfPHCw6wmpwfdZTGPwgt1zJv?=
 =?us-ascii?Q?o1mQao9QcuRTyZ6egdSwCXEhjpaA3smwSgsXI68HL+Gmiacq7pkYenVO67sH?=
 =?us-ascii?Q?Dd57xBwtw0eBdVEo0zSnrXqw8REw0kYLSOwuoA6tjtckstIXXiyu8/f6ZxKx?=
 =?us-ascii?Q?QYGc7lZfUxGp4I7oTM1BiH7M+Ew5Lpl1rN7E+HTjdDB9ITe+ruVUNIxzzYWv?=
 =?us-ascii?Q?BSVYWjdNjjc9MtUfSL5N9nSLRUf/pGWUvEw4KDhhfgTC9OyYCOy9V1YH8tsk?=
 =?us-ascii?Q?wIe2jPU6LICnUifdcwgXDvAnSO8aQdBpyOmyIZ1PEhBbhl6sFalKAw0CB42n?=
 =?us-ascii?Q?dpcKi4i+jNwavHRO0WyfKkF3g33AQ3hYfX1dAtIXoT8kKorqKPTZEx2+JeBw?=
 =?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: W18kDwHLvGgs/JgiEoGeBg2jdYOvD61VnrxYE7RyGYQYRV1Dgxukugqv0np3OZTOlDjYA4GTuRnycLoM1oFHHq7tgWHbqkysy+uX1JqxA6S7HcgAyHhvyp/Rk0dxHO3teJsfL7KqZ6EFgbC3pQRGdUMMLZBp7LxI62RA5RKDTAM0jtdc7AzShBaoJwAyvNL563rMg+VFRzteNdIW0vEsDqBjiil+QmssDkY06Q6F7KJ2snjD3VTtkXgrQpIRFVABxGCSZ0+c+Nxu4iLrvoGVkUIOAGl9+WeIRy3rqxeSNytStxDmBw7dpHIPD2xYpuW7yd6l/uAuaybqkv6AasSdZWMzgR1jc+Fk/R6m7BnjSv8=
X-Microsoft-Exchange-Diagnostics: 1;BL2PR02MB499;6:w3dBopnBglg1orIFTJiZrkNBtAUNOt0AlAlzeByt5HyN6Ko8FHBI1iQ/0viOtOjk5uXhr/PDkcURUHvQnC97LLNg8JL7mVyaybuP3Aw5FNNnTKyMr7i2H12gC5LeH+aT0jr4YmW8ShDwADiAHdHLiQbzvCL3u4DZcEuiPPGB/2BxdwtNRxSf9VJN8EFApp2zWKeYmzLUwzNYZHrBGYgKwmgew40FlBo7opZWXRqN6p9R3yWGPQEbIl0+V94gmSQ20BiVE3xJGOLAFxRYHfkevcUx0/1Nme9py0mPl8oHpZFe3vi48JtFETZpP+jUyQxBdakhwEiZZKZLXo3HNyS5QTEGMceR6sV8XsOiiE2kY8Kl3ZCjyneOO00dfUu4Xa9pjXdGyCIoGi8PF4tauOlIBaYroR0vSLWgmwuVzHR2qxgA1FdaHUXTzwlS/xHi+SXwdgkUPHkUKED50nVOZrALMQ==;5:raw0H5m4DSdJ/2ITRuoxIT7twb24acfuPNMGwglIQpmzHgPzQZEdOdYS4nm6hOZr4FyhAe+WVn4MaNwRGRY9XuwwoZ8jEIzC+vDyjhuztLyojVFWH6KBKykkZoU5IoYCOHizsS5o4e1AAOTv3Eda93AUDE6u/BPwr/NAa8Ckm04=;7:2jE4i6RrK68HtHIvyb0E5RFIbehhQLtAHOYlroY6OGa0T6c7TF/iZMLg027kLi55pL+5VR56eVJNpd+/TCnd3KQZJMKrUiBDSLFyIxg6rpf475u684fKmfhKNe2ZqJqLQTaYEvYRVseZgOnk4vamRQbDj5M40L6aU/ROS2vjqXV47gEPOLJqOI6rTmrkCOj/m6RmbkmaxwXHuOj4Go5u6eXPkdMEe4MSBsQzGaeE5g5Dfd/+ifWzEToQ3FkyNqmb
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2018 07:25:21.8086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be35548-d7aa-4eff-07dd-08d61237931a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL2PR02MB499
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation to describe Xilinx ZynqMP fpga driver
bindings.

Signed-off-by: Nava kishore Manne <nava.manne@xilinx.com>
---
Changes for v2:
                -Moved pcap node as a child to firwmare
                 node as suggested by Rob.

 .../firmware/xilinx/xlnx,zynqmp-firmware.txt        | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
index 1b431d9bbe44..ef0c3978e6e7 100644
--- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
+++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.txt
@@ -16,6 +16,16 @@ Required properties:
 		Permitted values are:
 		  - "smc" : SMC #0, following the SMCCC
 		  - "hvc" : HVC #0, following the SMCCC
+--------------------------------------------------------------------------
+Device Tree zynqmp-fpga bindings for the Zynq Ultrascale+ MPSoC controlled
+using ZynqMP SoC firmware interface
+--------------------------------------------------------------------------
+For Bitstream configuration on ZynqMp Soc uses processor configuration
+port(PCAP) to configure the programmable logic(PL) through PS by using
+FW interface.
+
+Required properties:
+- compatible: should contain "xlnx,zynqmp-pcap-fpga"
 
 -------
 Example
@@ -25,5 +35,8 @@ firmware {
 	zynqmp_firmware: zynqmp-firmware {
 		compatible = "xlnx,zynqmp-firmware";
 		method = "smc";
+		zynqmp_pcap: pcap {
+			compatible = "xlnx,zynqmp-pcap-fpga";
+		};
 	};
 };
-- 
2.18.0

