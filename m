Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1297BC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61A32086C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 09:01:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4xRllXV6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B61A32086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbeKGSah (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:30:37 -0500
Received: from mail-dm3nam03on0083.outbound.protection.outlook.com ([104.47.41.83]:24656
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726357AbeKGSag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpHqOwLAyt969tOtPiKTeVHGvBF6DtiZZBlGY9gWf74=;
 b=4xRllXV6qHHRMTZ86mrFxuTyuAnB6BQMuhLRrwskc1Xue0k+9oXjrWJIuK/xJBkpPzPyrJDw8hdpFRgBV8yJcs7f01CcA2NtSjO3bpVPjdjYSOqlH+vjq7JHFI4bsfm0h/XFrnUfS+5UBuOCYcXKbCv8mi50yrjmX6avd9/qFcA=
Received: from BN6PR02CA0028.namprd02.prod.outlook.com (2603:10b6:404:5f::14)
 by SN4PR0201MB3520.namprd02.prod.outlook.com (2603:10b6:803:44::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1294.28; Wed, 7 Nov
 2018 09:01:06 +0000
Received: from SN1NAM02FT038.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::208) by BN6PR02CA0028.outlook.office365.com
 (2603:10b6:404:5f::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1294.20 via Frontend
 Transport; Wed, 7 Nov 2018 09:01:06 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT038.mail.protection.outlook.com (10.152.72.69) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1294.14
 via Frontend Transport; Wed, 7 Nov 2018 09:01:05 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:44211 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gKJhx-00037Y-Bd; Wed, 07 Nov 2018 01:01:05 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gKJhs-0002Ls-7o; Wed, 07 Nov 2018 01:01:00 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wA790tpI032542;
        Wed, 7 Nov 2018 01:00:55 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gKJhn-0002JM-Aq; Wed, 07 Nov 2018 01:00:55 -0800
Subject: Re: [PATCH] pinctrl: zynq: Use define directive for
 PIN_CONFIG_IO_STANDARD
To:     Nathan Chancellor <natechancellor@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20181101005724.9622-1-natechancellor@gmail.com>
 <68ae935a-aec3-915c-bfe6-d69bfb93d702@xilinx.com>
 <20181107085503.GA31517@flashbox>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9d52cd84-440f-9a40-d0ec-1397abb24c98@xilinx.com>
Date:   Wed, 7 Nov 2018 10:00:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181107085503.GA31517@flashbox>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(346002)(396003)(136003)(376002)(2980300002)(438002)(199004)(189003)(11346002)(5660300001)(39060400002)(486006)(65826007)(229853002)(44832011)(305945005)(2616005)(230700001)(476003)(126002)(6246003)(8936002)(478600001)(106466001)(81156014)(106002)(8676002)(81166006)(54906003)(110136005)(316002)(58126008)(336012)(446003)(31686004)(426003)(4326008)(63266004)(2906002)(26005)(9786002)(36756003)(77096007)(14444005)(2486003)(23676004)(65956001)(65806001)(47776003)(31696002)(50466002)(186003)(36386004)(64126003)(76176011)(356004)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:SN4PR0201MB3520;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT038;1:T3lnr5Pz7fi5GdFgQpp5GtZw8PAtQNqHGdcF8G7vlt8V0bbNmw4a2qCfpW8Gr/JBxAS3KtxaaR/0NWSy5XsUwj903FdAJrv6b1S6cCEHH6FGadp2eVDfV19h7emrVlyo
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d8e0d12-1a08-4114-c789-08d6448f8d43
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;3:TYQDr+R34lq9dzipxQZ6F4yGZ1tL/kj+s0p8NvAXfM5ZKeqa94ql4WXBs6F3+bOmxT+ZBRumqWJmCJP2pZkZJfsj5SwQSEAMrY6zA1hz/9xkRH2DpnVaiuS/La33v2tzNiZjyUkc6+0guFpiG7f6Uz4IlLhOqVuK2PMetXwB6bCevTMKAWNF4NMH0K8oaM11Y91ZmRRNsaJ9S5S9k8hT4yoxzYOiATNy6c/BqNFsV8sau8gYj8T5zhdhs/bz7Z9IhRMhJZ7FyVGksxNUXDCZPkiagRsVHeDjAxHdJMN+Ac0sgSS5+jIlWuE5i+meNM8AO4LGcgMJFFu9Wccj0MeR/Ddy/xRSSsNRJYTocUGWEu4=;25:/oM6Vy7Wcs4QhBOcpYi8j9m+76gFOOe8PAmFLbPiC0pLW6BTOmjhX1og+o1SPrRgZjuOCyjM2L6WYbEnIXb29iKNP/7kC9QAl4loIYS5HzDin1+Y/+Ktlawf/ljJBoChDwhqjwiID0ungPHn2ng6D0cNzhKSTSTVy1KqsBMchtoaGChpc3GrTyg9NeeFVfx0ESYJAkxQUihQ35dIdeHcy7cVSO1hHa4VHs1JObfdUuZL8KSMl/463bqV3qHlPIff1T0jfNPedf38LikKFiV5ud8FWEy44AwesY8nvZgj0FLx6rx4gAOptRD0jAUP8q5Ypx+ogkoY2wLqWy7vjPvONw==
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3520:
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;31:DgmH0NANwpCpxzcWWbQzwITP0aNxcPC3sfUJ+m8uS+7/YyiGuLvgRM4DSSYOxw12Whi8pm2+7tZzx+FRhNcmKyh9M4fczsiz4kFqriMeiryNhvKgXLkOgFDOiJ7ICWvLox9nvqMaGcmXFGNGcGW7wM3P2LxYx+0W89c6WedyyHa8lFt//zTG0TOPkIxiIz8o8HlCj4E3yCPXTcWF1++tGbmTg+H4SLPO6UAK5KAx3ts=;20:yKn6/T5d46UiJA3bHP7Ry4hsZ1p7n/UMNf/oTEU2JdWUvvw2Zmcq1/hhhA14ll6qvDScTY6HzZFlIJFYMNrn99d3d+FylFQipeuHEmPKOdrLZPTuzxi7ROTQ1xq3fm/rK6HpuFLrb30nVynJZBinBdSslJSZEYvN4P/x/Nr2lRYVALHH5r3r41/EqoK/ayjbhhMqGUw9qY0KlF2kvigzY+YptZRSRCPgKS1UKQW8zdNCxotEPTGyQ06FGL0M932WfgR00q3zy9kaTtqaEZXEuphQAl59tdkQ+YJZ+5G5Re8XQSWxiLVQ12URW/c0ASuNph9lQ0LvFgguZVSWLPHqEqCC0pXkV5M+qAbHBHHUueJe5bdmXpGmmFxyO767gVMNnhMbDbIq5+FF/mqOy3G0z6Gms6vM3koFlwYIK5Hy0PpJZFhdZmvfFOVhJsf+09RMz7S7aTmMzz4PohOWQoje8JyoN7/FmL+3TtDZEd2P6OoHtyeUa3AJxDjoFXYDNrlP
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3520813BE5353DA2F2D72E7AC6C40@SN4PR0201MB3520.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231382)(944501410)(52105095)(10201501046)(3002001)(6055026)(148016)(149066)(150057)(6041310)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(20161123564045)(201708071742011)(7699051)(76991095);SRVR:SN4PR0201MB3520;BCL:0;PCL:0;RULEID:;SRVR:SN4PR0201MB3520;
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;4:QXMJMOcT5RwejCuzAUtTkKNLNo+sh4pMkEQSKqppn0e9J8qSGbS8Kn6ZBkbbICsMD4PzdwL/OvLRoHhF55f5tpZDEs+CWa3dEpb6eRegvZ/pJ0rnaG+xh/dRvCciXt94j8LrtYj1aPh8/PYy5N6KqFtdM98Q8qJrB0Ncf+965C68+v084oVbmynIoedfBu/Z3cIHan1+aGBrUTR7o5wQKh3JdIrHn//aHj7O4b4m7RmC4gX2oLxwkh/SPK8vrYMnL+kxJLWgbZ1iwNhxhDt5TQ==
X-Forefront-PRVS: 08497C3D99
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjRQUjAyMDFNQjM1MjA7MjM6NGJlK0xlR05IM09tRVhZUWk1UkJaRlRn?=
 =?utf-8?B?SE1OdUNKUjN4U1Zvdjd3RXFVWjJpZHNEZzRFWEpTcXRFVVhCU3NFN1NQbzZ5?=
 =?utf-8?B?U3ZHQUpMcXY1R0FXRklBcktRVjB5OFR0d0ZxR0l0S1FNaFp5YzdKZm10SGJF?=
 =?utf-8?B?YXBraHZVL3lpTFBib1NTRzh5bG5WOW5iYzBEQjkyMFdlQmF6eHRmek5iQk9k?=
 =?utf-8?B?eHdFa3FGRkJpT0QwNWZMQWJKWk03ZGhLNlR0WWVrOVN5MFFhYVNnRnBqTG4v?=
 =?utf-8?B?SlFLc3hGRExCSHprc0QwdWtnSFVkQVYwQ0xnTUU1bVdnZ3NkVkhSc0VYcGQ3?=
 =?utf-8?B?NnhNMWFYdi9MT09mZFYxT0xkSy9JQVI3TUVWbzEyclI1ZW1ncGZpR1hucUw1?=
 =?utf-8?B?Y2dBUk1vNjA5T25PSzZtbThjUmZQYnpNaUZraHFVd00wbERWQno3dGRZbWtO?=
 =?utf-8?B?VVVYSS9KWDBUcDNFL0RPbGVYOUtYVXh5TFB2QlVrY0FlemJkVHdTUmxLZlBY?=
 =?utf-8?B?aWM1NGxKRHRudUlvVjBocU1kU0tsNjlnYXJNeEpZNm0vSGFaRlVHQSs1VXdn?=
 =?utf-8?B?T29nMnEwZ0RzdUpSczhWaEhaM1IwZlZYWHZZWUFOQUFiTjNHMUdPakl2VGow?=
 =?utf-8?B?aSttS3R2MzdoMVBZTzFFZzlRUHNxeklMd2h6RVlrWFNtcitXWUY1UU45b1E5?=
 =?utf-8?B?Sm14YXFqV0N0clVwUTJ3cHhQZThJL0JuOXUzUTZ6L0Irb3JDcXlGaE9CTjVt?=
 =?utf-8?B?YlQ0Sk9ZSzdMeVNyMC9Hc2I5SlhCSzBwN3dQR1l6VEpEWkRGYWJCclJ4Q3Rz?=
 =?utf-8?B?L1lwV1E2VUtYK1U3SFdIQWN2MGUyOTdhWkgrUGhTdEN4YnhTeWFMbnJVVXM3?=
 =?utf-8?B?NkZhRTBIU3ZuYndDMTgwdkJncGI1TkdlNHhqQXZhdmVXaUZIbDY2ZEplSUQ4?=
 =?utf-8?B?YUoySWFsTVJ5dVRCS1BZYW1qd1cvS1BZK1NQZDdraDg4SEhjNS84M0RaSWhx?=
 =?utf-8?B?OUdhQXAzV3MwampQQmpuK0ZwQU9kUUczTWNnSUdybHJEdlFacGxURXBLVFFv?=
 =?utf-8?B?NXZ4bVVlQlFJZDRSVzNlOUt0V2NwL2Exc3orcVhlc1AyY2p4WFZkazd1YWVT?=
 =?utf-8?B?SmpHbWZlZXQ5aXp1U283dVFZOFFFdlBjdERrMExyR3NTMmhYYXNWZnFXMG9k?=
 =?utf-8?B?VGhkOWlPVWhVUEQ5NVRZc0RGaHJLS2paQ3dHd0lxZVgyTHBQWTZxMzdRdXdN?=
 =?utf-8?B?Y21xYW5UUjlOazFJVDNCeHJ1VXpIY2l3aDZCSWZDWW5kbnlEbUxYWENSWG83?=
 =?utf-8?B?ZUhqV1RvcjMxTVZtODdCOWJxWVFDNVMxYWpTL2xRU09FRzUrNFo1WFFPODl3?=
 =?utf-8?B?R2lTUWlNZ0dEVW82S2k2LzY2LzYyQ2VlUHZUZHhWQlFDRkNNcVh2QnUwNHN1?=
 =?utf-8?B?WVRGS0IweSs0ZG1KQVk2eXhsQXdsblY2QnRLU3RpK2I1SkhhemhBSm1FQWVS?=
 =?utf-8?B?NE1oVmExMlFjQU82Z2lmQUJqbmYxY1ZCZ05KbUtYelB0V3EzMmRpbE9JWU5r?=
 =?utf-8?B?a0l5ZUYzV1BYbXFVVXRjTm1BRC9QL0orR1NMZldQRWtYNllVM0ErRnI4dEJX?=
 =?utf-8?B?WWVOaVJ4ZFBORXdzanZWU0p4OUtrYy9hMGtubGFoV094ZjMzNGpKU1JpQlZM?=
 =?utf-8?B?TGZhRHZXcXoxMTU5ditJNjBwYTd3Zk5jblg1MzJYRzlncXBydTRjZzZIZlY2?=
 =?utf-8?Q?RjkGf0WGDUQn1n+h8DQJrb/gua7/7M7xMCToav4=3D?=
X-Microsoft-Antispam-Message-Info: M/isuT5RiWqRa/OXxCDuiAvK9TbPzot5gXXY9/u/wquF32Lhivsbwfav0EPfrYz8Kx9LFrwC6YpMY3XEI3Ow76COwEj4UcpQp52Dk41WEMdLfWFK+ohVCFNXxXsm+kRVXxcEqhwW+447r+jILz2UDhotmn7NY/osf3jbZ9aDIJJYFgo4fv0VFyyqXHSDg/1QOS+NomSR3WdZhY/eYMtsmTpMAXL+sBF1A/Fd2q0iPisdMQjmkX6mozaNLDq1jUWnLUFyoGiDK7UmjhJC5BwZk10G9MiElo+2owVDduG7NhYkExpDu/ku+vmYRqTK68X0wPo6sUN3HeWYvWD8Tk2A7rfrw2lqrTMANH/jsRMUVEw=
X-Microsoft-Exchange-Diagnostics: 1;SN4PR0201MB3520;6:cwcsTE7aoPwIhxluwVYztLu/gTdSdjIlDK5dWUPICURVevrXCLlrb+DKrdZdDTTmp1zqwukrlxBK47swZ6ObqvCN/UYBdR0+OjmvE3ag60JeR3C+Ktx1itwQtZXbYX6K+gk+k1eOHktODicXPcN1WJn+Qkgc0nr9UlbAxa8Wv+Pk5GmQyCDYIZdZsLNsjpIhDHnBY3jZqPwmynT6dpgf1Y2uGeSMBFoDvFTuuO0Rd/jH7jGXel08Bnsza/GyOE4lEcog9Bq08gK3OCUXWidjHV+c9wCQszDb0adnE5xNRFzUbySEhto7cJbmB70ICfMV3VIO3vBIdEjQAi2B/RJad38JchyNzRXfMGrBzT+JMybkQGqv2hS+FbD6Jd40ki8TTGhAySeiR0ufGOV1z2/t47nnKPt9fehXfkiEMgD1V4ZvTBHqw+1VL05UqDPWeFQJnr4OoXSz534MOpXLHqltRA==;5:ath/OzuABXt6OSVjXzqW0QlupDKb+tvDu3aq1juSD+qgsXera9t/80gzJ6139U09RueemI+WNYp/I5YB4kbbvuYlEjzdKxLHQNcE9d2vd26HQ2sV1IDpLp5gezHru8x/Bzfa2IytzilbKyJxb3itGsMz8h628n3w9eVuketEpH0=;7:1qeASMG2qk3Zji/cuqIXjrm30UmyPllkR1LTt/7j0lEIckV+A2wS4mpD6uhd8W2UQoqmns6Pu/VgbQHvhDTTbm6Equar0REIZyPTLU0fGR42PpSMnU+Y6E8OUTV7NFmzcqd73wdatuX0ozc364z/Lg==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2018 09:01:05.8045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d8e0d12-1a08-4114-c789-08d6448f8d43
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3520
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 11. 18 9:55, Nathan Chancellor wrote:
> On Wed, Nov 07, 2018 at 09:46:12AM +0100, Michal Simek wrote:
>> On 01. 11. 18 1:57, Nathan Chancellor wrote:
>>> Clang warns when one enumerated type is implicitly converted to another:
>>>
>>> drivers/pinctrl/pinctrl-zynq.c:985:18: warning: implicit conversion from
>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
>>> type 'enum pin_config_param' [-Wenum-conversion]
>>>         {"io-standard", PIN_CONFIG_IOSTANDARD, zynq_iostd_lvcmos18},
>>>         ~               ^~~~~~~~~~~~~~~~~~~~~
>>> drivers/pinctrl/pinctrl-zynq.c:990:16: warning: implicit conversion from
>>> enumeration type 'enum zynq_pin_config_param' to different enumeration
>>> type 'enum pin_config_param' [-Wenum-conversion]
>>>         = { PCONFDUMP(PIN_CONFIG_IOSTANDARD, "IO-standard", NULL, true),
>>>             ~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ./include/linux/pinctrl/pinconf-generic.h:163:11: note: expanded from
>>> macro 'PCONFDUMP'
>>>         .param = a, .display = b, .format = c, .has_arg = d     \
>>>                  ^
>>> 2 warnings generated.
>>
>> This is interesting. I have never tried to use llvm for building the
>> kernel. Do you have any description how this can be done?
>>
> 
> Depending on what version of Clang you have access to, it is usually just as
> simple as running 'make ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi-'.
> 
> Clang 7.0+ is recommended but 6.0 might work too.

TBH I would expect to download container and run this there to make sure
that I don't break anything else.

Thanks,
Michal
