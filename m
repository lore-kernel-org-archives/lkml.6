Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DDCC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:10:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E5A220989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:10:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="4Np92Grt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfA2NK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:10:57 -0500
Received: from mail-eopbgr690073.outbound.protection.outlook.com ([40.107.69.73]:51297
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725601AbfA2NK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:10:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GFYR839ScpqsI0P283D+51nS+/7B5uGwNOTDTDIEj0=;
 b=4Np92GrtiZL3yl9JH5+Bho8Hujkqmcb4kLy62vdkluH/Bbt//8YgmdQJpQrbFYGtFwLQQKocROlHVAHzpnnuk50EYfsTXOkncfN1JMLy7LVn1EKtTIBG7kjeSWVrpwW8QC1gidQt7bAnMd/6/BhJyaPLrlyES1/YARRtzTwCoXM=
Received: from BYAPR02CA0006.namprd02.prod.outlook.com (2603:10b6:a02:ee::19)
 by DM6PR02MB5020.namprd02.prod.outlook.com (2603:10b6:5:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.23; Tue, 29 Jan
 2019 13:10:22 +0000
Received: from CY1NAM02FT050.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::209) by BYAPR02CA0006.outlook.office365.com
 (2603:10b6:a02:ee::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1558.16 via Frontend
 Transport; Tue, 29 Jan 2019 13:10:21 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 CY1NAM02FT050.mail.protection.outlook.com (10.152.75.65) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 29 Jan 2019 13:10:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1goT9g-00047X-Ju; Tue, 29 Jan 2019 05:10:20 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1goT9b-0005Or-FX; Tue, 29 Jan 2019 05:10:15 -0800
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0TDA5Rp005959;
        Tue, 29 Jan 2019 05:10:05 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1goT9R-000588-BD; Tue, 29 Jan 2019 05:10:05 -0800
Subject: Re: [PATCH v3 0/3] Add reset driver support for ZynqMP
To:     Nava kishore Manne <nava.manne@xilinx.com>,
        <p.zabel@pengutronix.de>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <rajanv@xilinx.com>, <jollys@xilinx.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chinnikishore369@gmail.com>
References: <20190125074654.10950-1-nava.manne@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <a33b5188-e926-7c02-8a91-b4c6ab81ad7c@xilinx.com>
Date:   Tue, 29 Jan 2019 14:10:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190125074654.10950-1-nava.manne@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(39860400002)(376002)(396003)(136003)(346002)(2980300002)(199004)(189003)(76176011)(50466002)(65956001)(65806001)(230700001)(6666004)(356004)(26005)(47776003)(63266004)(110136005)(77096007)(39060400002)(2486003)(44832011)(6306002)(23676004)(6246003)(106002)(31686004)(65826007)(316002)(58126008)(106466001)(8676002)(81166006)(486006)(9786002)(966005)(81156014)(426003)(8936002)(446003)(2616005)(476003)(36756003)(336012)(2906002)(186003)(305945005)(31696002)(126002)(229853002)(64126003)(36386004)(4744005)(2201001)(11346002)(478600001)(921003)(107986001)(83996005)(2101003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5020;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT050;1:O9pzeh+o7aCQQuJKnWNgZXPfBgFxheIgs1buZIjq6w5nyfXDktcgPO9wILanysEEi9b7OOfJ9tUVvXEDc+Rdr0ShTvmrPOpPKDE99etAO566xu+fYQC7ipUEADFNEiZ0/6VXyakp9Ang76GvKsQgrw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a1b1a2b7-f7f4-4a41-234c-08d685eb1faf
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:DM6PR02MB5020;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5020;3:gNQ+ncaxM4EKS6YUY6+1/oWqFw9HtebfO+SkNCW3TrFKGS7SspssaiYAuiQRXdMyRSD6Jpps8ViyRqcJuiwe1G0W7+DayeHfRdrdU43wzEb9lc46zXyNaUPeaGEj/xbOdyyXpHlpeYymjR/fmJHlRWCizSAhor6bDwRCSXe1XhcGxtEZ9IZmvGrYrwYHLMWrT+LAdH5CjBH89yJD4n6RldleHaG8pb2rJ58zsdw3X0850JqtiH2iXMx76NxhJmBp2TdDt00Vx92CWoxjHrMGdJqtC7vlFYf/4zyb6tYMxoW7Obtpw3e6wAXdkGWQ/aEs9v0AG0T8sn8r+BHQuNPENCauMhfIV/45/dC/rZc050TBT+BxnaPQJYcICBBAHHKv;25:+NJpIsNnC0lX7Wb7KkSeHeDwFrU6DUu4vuP6ev2TM7wE4NIV0W8i4hAcUD/J1btBz1OqUfwZKoS1NFxXpb4nySi+EEZgUQkjjfKERWRF49gvAe6v/2MyrEdnXQMe1PKW8NSkmy8ogfscTfI610n+rxa8xNhPw+KyH/kgaMFKf2THXC02ZNShbIYoIp7G90rkvPSG8qDU5MORBwKFqS3wR21dOQKc9zmwt02U9nqmmetdIjoSSFkzKV2On/mJ3N6mcyM9fOZyWb6zOLFevd9+5dL+khysWbo545jg98H0eApbyuMZFZNR0dHtS5uJph31Y6i4caAdwaUk/KpihgaQeg==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5020:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5020;31:zUaRPs0uJ0XcNKPXqzR2gJ+zj2rWX+uH6KU4fc7T4uEBr/qXQ4GajvddeWnMKrDqy5tGJ1sykkyu/zTYTUn3gBCLCArxDp5vrVoXQ52+6DlGTxwIWl4wj7PHYtpVC/k0aKmxg4zjl8/L6+j99llD0FMIfivk3Z9SfUE5N2r+MkWr2CoWXsUPsdAaYg1XXUGU6+8bHsp03U5UIXXiuYdERISDpmlYp+Tm9II5Dxj4H+o=;20:u+AkqPaj9I8gdExx+w1lKu9ZwQBO4QjRAAy1iD3BOLWRZfW+62dr2ngAegzuO+ItT8BtRLrwp3xqK/SSDE4FV2W3yEs2KBLjn57j5mCVIsuVPWybpDkZz8XhfV5uGS5D/suExEr+iLGLR6wWkc/1d8VUh7LFFu43zuOy+RJ0EH3o2kyEN89KMI6xuxBgOK3thZQ8YvuPyb9eStQTDmBU4o+xI2YE7iR0L/h5gSbFBI666dZ0/Z7o5Gj5KZegXNuVJ2vn6UL2VsHI3bloJDd1TIwhTJRq5i/8v9Waj6xClV6TNypHyI30r71/VVSZMwQ7vpvCRMYfNCFbxluSEf9A0o9qeJH9vZN4GcrnHHDDkyW6oFSl8as47tn20Ce6M7RxZD+hY6R93QiyRZkOSdio6GwMvM8oGOAZ6c1P1CgsPgfJJkNPAxZgPHt5MwB5523wnofjgtTRsCkzbR8QFRP9bwdhQjPDWFzU4oHuVm+FSvf5UeUiy6XI6SDfkaJHTZVV
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB50205C30C4D8C37D14350BC7C6970@DM6PR02MB5020.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5020;4:FXNKAXuRirOgKeiwyPeL9IKVts4cQE2RXlJS6Amm5kZgsME3OzZJ/MmybppR7BzJm8aozGkUz2NU7MgbJBDuQC/iDno6/Vfb9bKpiNYwikfXRTIRlI+cAZYYFexKelKgxO669fOLTMgfBdsnhRGSxJ7GyJox7t2iLPxVuJNWEqdZwlaALDAX7akRL/6u+w2O0nUMvP6uFJLUbAVv1nAhDPo044s5IgC5ZjNVXrAgy+ZwGxO6/2Nu2tfHSpae/iQFF2yskQy0WidvMSQg4t2cJr4rHVInUNbGe1Y8JGIsIF4=
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MDIwOzIzOk1TS2dsWGVVWk9uVlhib2M1OXN4TTdXNi9i?=
 =?utf-8?B?Z2dzeEFkU0Z0REVaYVM4Z09ObDNLTnQxUHUzaFkvdHNxRnI1UjJjM3NZRm41?=
 =?utf-8?B?aHhpMlNteVUzQmdoSG5CUUhoSi9iLzJwQjhCbTBQS1FvVG5WWFJ0dTJ3Z2l1?=
 =?utf-8?B?S2dUSjhLZ2gvMnNTMFd0M3c3ZStsbmRiUUdxUE9yL1Rab2RIckIwRGx4OU43?=
 =?utf-8?B?cG82dVJWaEg5MWltNmlWYWVtcHBoK3d4cStnQm9BcFU4TVhqTDUxZjJUK2FN?=
 =?utf-8?B?eW9KYnNPTzV3aHNaL3lic3hxSEk4Mm14TjNuTFlhQlRmZnpYWit1R0hnQlYz?=
 =?utf-8?B?dndQZEpqWTJBelBqMHZzSHpqd1FhcTk2cEkxb2s2bERKa3dqRmFRbkFXTGcz?=
 =?utf-8?B?dFVXU2RKODdYU3hWZ2g2R3M0Zm91d01Zb2dWMFkvOEExK3hsVWhWU0lpZ2Jj?=
 =?utf-8?B?MFh5SS8yK2ZhN1grdy9uTzRPY3FHUTN4dzhKY0FWcHM1Zm1ueEh0ci9BakNh?=
 =?utf-8?B?NXQvQXdGbEJ6Q09wOFl4VkpRenBnMzFIaDlBdldBQ0pSMGVEeWE1ampJU254?=
 =?utf-8?B?dENLRWRZZysxNVJoNEpxNkVTbGMxcHBvMzV0VzRmTmRKRUI0TTJ0YzRsNHZO?=
 =?utf-8?B?WW14TU5ib1huZEVJcVlHck0yU3hFd2Z4U1Z3T0NjbHR2UTBLbGlFVXNwQ0pW?=
 =?utf-8?B?U081Q01jUUh6NjVjUEdPdDZFeTRaWDhiUW1HNTdEdVUvRlFrOUVLTmU3WWps?=
 =?utf-8?B?QWpHUGEvMlh5Z1UrSDhISW9YQW90Rko0Z3ZMcG5JSVFEWmVUNkRtMndlRTd5?=
 =?utf-8?B?Z0lvdWFVbjdyWVZEUXBMR3dSL1RscmxOUVorN0hwcFZnSk9rUzFlNjNrVyt2?=
 =?utf-8?B?cjlmNzErekFMUXJjS24zN0lNc1huRVlkRFVHNFpROVlOb2dRZ3NNaVVEcFls?=
 =?utf-8?B?Y0NHRVQ1ZE1RMFZONDlOK0U3UmpFaHhnQ1ZKY2ZkcnN5b3VzWG1xZmxFSlc5?=
 =?utf-8?B?SHBnUGhiMG1SRFM1ZTR2enpPVmd2VzlpU2dWSkh4RXcvT0NZaUJjcGluWlJp?=
 =?utf-8?B?U01GMnpvbzNRTGNzMWJVUnZxQ1QzbFJBQ3pLSzFtVGU3VERzSGliUjBLeTVw?=
 =?utf-8?B?S05tZzdKemhOQVlqVXJ6SW1RdkJSR2VZRFppT3cvNkR0SVhOR1ZHZml4OFlv?=
 =?utf-8?B?ejYrMXNSZlNhRUozV0ZGc29PdTlIUXRwU1EwT2Nackw1KzNVQnMvQ0hYTG1o?=
 =?utf-8?B?ZzJIdjNUYmdYSlJBYktpNHUyYyt3U1VtN08yMzkxem94d01Rd0UvelZoL29N?=
 =?utf-8?B?MHlUemxSbmJjbEhReFExWVJPK3ArVU5vTWdmQUxqbi9OanlhSzk4emFUVW95?=
 =?utf-8?B?ZXFSc2htQk9TVGtMOFdQdXZNNmUrYjFTbmFGclA3d1VZN05QM3N5Ni9uODd1?=
 =?utf-8?B?QU5pMW9uMGJmNU4yL1BQeWMvd1lzS1pJc25ELzhMOEJoQlFPYnBXbk96eGNP?=
 =?utf-8?B?NmhBNXVDKzdhVlBXQS9VbWx0bDBXZmgydkp0WVJTMmljSDZMR3RNbXVPTDdx?=
 =?utf-8?B?TW5KKzVkazk1SlVQT2JUVEdRcHpTWHRpOXVheWVaandGM3V6RHNJUGRIcEZX?=
 =?utf-8?B?d1dwMnEydWhWVGdkR2Q0ZUVwMmlCc2dJYm9KOXFlL0UwZTJTOXh3VXZueWtU?=
 =?utf-8?B?NXdjWmU2dThSeFh0cVdVTVMxQkN6c2t3SDE1b1ZGSkNiT0hkdkh1TmFMK2ZY?=
 =?utf-8?B?MmJiTHpObTZMMlFNcFhoeWY4T3RibjZQNG9UcWlhYnFnVTI0aC9HV293S0F3?=
 =?utf-8?B?SWQ3UGM4Wm5XRFlQSmIzRFh2Y2FGY21hYmFpV281R3NtRnc9PQ==?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: XqItZJ/Z6007nrBKS/elZV28LNlAQ/HXJy/A0TM4xljYE2HeU+Ql8yN6hOo8h1X8mN6CXQA+FNMwUxfaMfQOisgjo09o0Wy4dn6LCk94nTTHTHB4JkQIMRISiGwLlm9fFgra2XX5Q+dkh5+7O4t4TOv4QRHixHJce3+IYGY/SaGtM7STwzZnb9ejKlXDizoB1cWypyNAS1s6PfN+CcqGEKeKr1t7xeNnV9L/fD8nAq8qFPkjMG+9fUmnOLNgRgBqo4QIhYTTYhQzEHVCI4cfn3pPPKJxbR6MaXyTVweCQibgNfLlYlHdH4MEhrnIQKfYud9miXBPyqnsNPr44ImSSFlN9ATjyrNdEJlvjdas59OZKkOWY+ucxFLZoJXDiArS6/IpkA82b7sAWxG1fHRtyCrEMmhcAREQgTb3XBghy8w=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5020;6:TPSDK2tUwYZvMst/kQkqzoGjNXXhOh8SoQXEwyKy14l0pBXofGKK+eFOJvZfbofxr8aVBlViEJiBugzHyqniC8JXMSBoL/15gcvbi3yxrGQtvBa8vYJtMdxCQhwozlbPL3trW/8M7NIr7u6kE+6Dm+1MBTNLu8Qh1xwKPNL2JqRdu18xawa8BiMc2tUaGC3oqfqXixa1R1JL1ByWx9amHJWCy1kNY8nswWYX4tGOnlwBC336vMWKA/8wloF+ittHZh996wbVNFBdiis9cTLoq4LsTzg1ATz4Rg0e8JW9hm1xF7DVSxmzDxPFEYEt1RhMbU09digzgmu3J5kGydNN8eQWgCFhWK8DW9S6Q0rtPXveEs9N+4/dXTL6kbiJsxOrD0bkYwBF5pDzA2zqF1qUndtiJQ2WKzZAZnqLnVa+qMoGr1T1VaF6ZFyHHyCP3kjjYNRcR3O9+5U8G5GuhkAW+A==;5:30EQZW4sdQGG4hcihwoL0fwfvb6tJXbhZYD2sTl4xhIIx9qOfzYXxuFFnRx6F4FKzpGyjPT6u4hMeyq7pR902b/HaG3MLFyl3ceyR4hgiWbyHQn2i2p78FeeDf2fn8Dhy1tAGjSwTdU7/QV60FhBy14xMphDPqnFvjmRwa/St298jeVYBOa8RZjSKkUPQUXq5iSR77Gx+pwXRNNHTVQVYw==;7:3Ei4bcD8amJ54rnE9ZoRb0DGYvtRjlxJ4nQ5toDPkga+zjIz+2wPUdFGdDwo27WyUkLu3dz+U1k32z/BkH/n9PoAKrQInDv/gVGo5wlJ8PfzWnZ85B/nLs67gQ7MLrpOiJsqzXKQ2jDF/rJKxNCFkA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 13:10:21.0610
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a1b1a2b7-f7f4-4a41-234c-08d685eb1faf
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5020
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 01. 19 8:46, Nava kishore Manne wrote:
> Nava kishore Manne (3):
>   firmware: xilinx: Add reset API's
>   dt-bindings: reset: Add bindings for ZynqMP reset driver
>   reset: reset-zynqmp: Adding support for Xilinx zynqmp reset
>     controller.
> 
>  .../bindings/reset/xlnx,zynqmp-reset.txt      |  52 +++++++
>  drivers/firmware/xilinx/zynqmp.c              |  40 ++++++
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-zynqmp.c                  | 114 +++++++++++++++
>  .../dt-bindings/reset/xlnx-zynqmp-resets.h    | 130 +++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h          | 136 ++++++++++++++++++
>  6 files changed, 473 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reset/xlnx,zynqmp-reset.txt
>  create mode 100644 drivers/reset/reset-zynqmp.c
>  create mode 100644 include/dt-bindings/reset/xlnx-zynqmp-resets.h
> 

Applied all to
https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc

Thanks,
Michal
