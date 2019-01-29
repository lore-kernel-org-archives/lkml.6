Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34BD8C282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1AC020989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="jIURMzvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfA2NL3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:11:29 -0500
Received: from mail-eopbgr800083.outbound.protection.outlook.com ([40.107.80.83]:30144
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725355AbfA2NL1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sDNuxpl12+7KxBtQIxoZ6OFuSW2fJTmc5CF4Gfiz8+U=;
 b=jIURMzvJX9rEZWGBr1+jBbfEZ7T+eIuD8CqFXVvmEJoiV5qIjczNUSva1xf9awdmJYfI9SGEpQqN/ViL8y+w4AgQq4t4h98KWzIDgIHnvmVTHRHcH07FMxCQQUDiSG79hB3lJ1y/HJYy4dNm52a6stSd2RSrPuglbHRhaQ2x3Bs=
Received: from CY4PR02CA0017.namprd02.prod.outlook.com (2603:10b6:903:18::27)
 by BN6PR02MB2644.namprd02.prod.outlook.com (2603:10b6:404:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.18; Tue, 29 Jan
 2019 13:11:23 +0000
Received: from SN1NAM02FT055.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e44::201) by CY4PR02CA0017.outlook.office365.com
 (2603:10b6:903:18::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.17 via Frontend
 Transport; Tue, 29 Jan 2019 13:11:22 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 SN1NAM02FT055.mail.protection.outlook.com (10.152.72.174) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 29 Jan 2019 13:11:21 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:47643 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1goTAf-0001pW-0b; Tue, 29 Jan 2019 05:11:21 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1goTAZ-0005Xw-Qq; Tue, 29 Jan 2019 05:11:15 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp1.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0TDBDAf026920;
        Tue, 29 Jan 2019 05:11:13 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1goTAX-0005XC-3g; Tue, 29 Jan 2019 05:11:13 -0800
Subject: Re: [PATCH v5 2/3] firmware: xilinx: Implement ZynqMP power
 management APIs
To:     Jolly Shah <jolly.shah@xilinx.com>, <matthias.bgg@gmail.com>,
        <andy.gross@linaro.org>, <shawnguo@kernel.org>,
        <geert+renesas@glider.be>, <bjorn.andersson@linaro.org>,
        <sean.wang@mediatek.com>, <m.szyprowski@samsung.com>,
        <michal.simek@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>
CC:     <rajanv@xilinx.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Rajan Vaja <rajan.vaja@xilinx.com>,
        Jolly Shah <jollys@xilinx.com>
References: <1547493778-22720-1-git-send-email-jollys@xilinx.com>
 <1547493778-22720-3-git-send-email-jollys@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <e4b34ee3-49ba-8b6e-76ad-69bf078a8256@xilinx.com>
Date:   Tue, 29 Jan 2019 14:11:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1547493778-22720-3-git-send-email-jollys@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(136003)(39850400004)(346002)(396003)(376002)(2980300002)(199004)(189003)(81156014)(8676002)(81166006)(106466001)(2906002)(356004)(6666004)(316002)(63266004)(65956001)(47776003)(65806001)(31686004)(31696002)(186003)(23676004)(8936002)(2201001)(110136005)(486006)(76176011)(2486003)(36756003)(7416002)(54906003)(305945005)(26005)(58126008)(126002)(229853002)(44832011)(11346002)(446003)(476003)(106002)(2616005)(77096007)(426003)(336012)(36386004)(4326008)(14444005)(230700001)(9786002)(39060400002)(50466002)(6306002)(107886003)(64126003)(6246003)(65826007)(478600001)(966005)(107986001)(921003)(83996005)(2101003)(1121003)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2644;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT055;1:+lWp5mSfC95wOFX35/fWeQmZNOiZLXHQQNeRz+nHP+zuNSx+zx/PyMTa/Ts6zWUtbqg38nDXjI/zDI0Q63hUNKVLdiV9qC1D5VQd7oK+ZlK/CRFfqELfZQ4kIz5WbWFaTdx2GDWCAXC2yvMcU+SDCw==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8665965b-e5c0-4507-794f-08d685eb43fd
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:BN6PR02MB2644;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;3:MwFJSws2bTiN7RORkAA/Z8UEET/BzN25TyKUPqRnPFE+4WAyaD7GqX7xCX2I9e9o0uKA3dgSuZwksi7MHQHPBO2wYxf934sglmx3uJPPEjrOwAYd/TPkdeF4ewHdGv9fcDJ6iCLTkBSCIzABU/Smh3TKt+kxPNOIBYDRKm4RsJGSRkiG5auHXWh1ekJWh8KXDc4ltg96LG5U6IQWSjiqOkEyOyAWFRmK/Cb1cJFfJhrust4CEQUA3+kFOe84LaWoO+Hi9U37P2s2KMT0W9zVSn3CghvtQfBTg1cmPEz8vJLwudwWons2kDXdCRj1KMR6elq8pkl7k9hC9NsIyIX7f6tottfSg7jr5k8ZsI1CoNx7dTr96vHNB5Qsy5XHzbDg;25:1qgFZgdGaIJJWo54uSZPQ4YjK0mBpvopHENXTy9kzFpTftNQgzn4TvVtD4hGHww5yi2Tdyzf7GEQk1zgPkZ4vDikkfx5mj6464K99veSfpPN/HkWplvL2mAbaWRGTi2v7EtMRRtWD7y/YSXY9DnJnwc4SXH8vGun6Pj88ox/dZg7vfJZDckh3BbDyfv7vUR2cECNKMReCmLQUbG0l5cVg/DFG08q/N4ii82j1nk+QM393KofjKSsMd183Vue6wbZwM6YvSpcnsJBYWcpGTVKuzb3IQ7n21IdzdahI9c0MpnnnWlZW7WTjTLUu3X+GAJMFachvoMMf/gcejX/78EfsQ==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2644:
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;31:oYrL4ldMLcoOVvYufWqLzcLeirAkDF90ghBu8HPNpUN0IhrC0viOCYIdS+uGfNSxWDyN4A+o3kWhel85PoCAhTYNn2WgOBRYHm6P0/N02kkkjgm5yT3027EQu8t5jGiq9AGXpV8rubM0w6UJEWh5wyreYdTA+bRz4e0FxbovEVjI2SBkpS6ykjwNbgZK21khvPRoU24hTI9if7BEFz31w4TOGUdHVypGMVtKC3E///o=;20:jEvg2vPWppZoA+vkxUQdjkLEM/l68kqJ1eay5FPnHZ6vmpnMNGc8cGZ6gyZXDkBBpPno2YMUVT8IPvAFx9RgBYVT4ApcH2XH0BVXd9+cmvPswOT5MGajbRhyE9RKX6coj9X7Yey4KCJw76d/K0wM4HtTbvN2o1JN/JyIES+lWADsymuXJhr4Dd3rW+MmbtSeL6dIeHaJ+HGmFdL7sggzQF90HpfJd+29KOHGEiNG47EUosdpUJqwH7UHK6bY1GHhA4AlM82JR5Ult618JT/DXOFeslSyFUPHn0SlKmNCh5YWOvf99Qf7gtIK7RcUWcDSo6L0uPK6aM+9dBPUAalJj0MFc3n/KHArz1c6czjOzAsbm5WNhU5MICvZnmpG6lmlrzijIshEd/8EeSxqFpI4hPcG+3+USpc2y8JymCpf1dGNlopWbpnIq7mErEKh8ckZMRJu76nuGrNKr0kWDQiED1KiBz3LklbMKe4E9LrCy70gmbl9q2iMaQUwSIUlyPPN
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <BN6PR02MB264407A4E8B477C7659BFF4DC6970@BN6PR02MB2644.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;4:J/KZ1zKA8EzA8Q48DK0iikcnUGkcYNNHvGKKSA1VDHhzYSnpQllv0orsM/uXz5mR7VvmBgXGW7kPDrbI7aHQbdV+tO4xS2BZpkOumiRcu8PlRcIJ+KjunMF+0rIpeOPSCvPTfbj76oTf/fowjiEGPyOWJHLMRngd80DxgVJ7JsHhI/RiKbRBrQ+qpO0LwQqGfEreQd6ZUAtb+1URmVt6yUoi/u9sM3Ex1kIdW1l8HCQsaSKBfFholpmslAVTowsi/Yj5ezdFFRNs49MeYiH/SE3VFty8K9abUE7Zfcelrq0=
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAyTUIyNjQ0OzIzOmV6ckt5R0ZzZmxwM2E4TmVpTHZTZ1NxN1E1?=
 =?utf-8?B?UVBrR2VDbktxVkNvZTF4akorZWUrc1JnVE5hajE5TFMwdDNYRjhzQlBFajZN?=
 =?utf-8?B?TDdMWmdpdnVLc0tReWRWS2N5NDY1SE1YajR2bWhrRWtRMnN3SVBiNnNXSVBv?=
 =?utf-8?B?QnVHQjF3NGtQSko4NXhZbjJHeWd5UHVvT2RJSDVRa2R4TlhCUkVMbGo3UUx3?=
 =?utf-8?B?eWdtMUljRXpIKzBkeWFMempPOFJhc1JiZlRPa0lnbTVzK0ZabitUQ2taNFU1?=
 =?utf-8?B?cXZuSld4Z0FwTCtIQzlncXBlaWR0eTQ0dFQ0clEySXFLZC9NczJQWE4vNWxm?=
 =?utf-8?B?RFdyOXg3T09yZTlwOTFNM1pjbGlpL3JDckZSK1VyUmxLd0hrTUpEdEkxWVhO?=
 =?utf-8?B?NEU3QVZVS1NySEYzS1VOR0ZSblFoM0t2SGRpY3ZUVlBLTzlIeGptRy93MHh1?=
 =?utf-8?B?NWI4VXVhdC9JYTRhQXZLaFF6TDBsNG02ODBhd1VENUlLZUYySVFmTVJxbkVC?=
 =?utf-8?B?UlYrTzNXQ2t1czdHNjlYSmN6bkw4YzF1NmNGeDlRRlFpTXl6THZNdkVrK1Rr?=
 =?utf-8?B?ZFhJY2k5NTRqUUZ2THhWTkhPVklpOXRXd1VEOXpHSmEvSmhvWEtOZEpZcEdk?=
 =?utf-8?B?cHRjU2hUeG5UWVh6K1dCN2JuUnZMVyt6QUlSRDdGcUhLUHg3N2VZdHZYVkdK?=
 =?utf-8?B?TUxxcnNOa05aYit5MVRxS2RFeXhtQkMyQ1pxaUM1eHNEZlZvWjQ2OHVuTjBM?=
 =?utf-8?B?YTliTE16YklRWnZvSzc3R3doVHRPYTZUdWEwVnZUYThYYS93cG9rRnQwbnVY?=
 =?utf-8?B?a3lNVWdnTU1sMnUzMmg5dDRhY1ljcTI0THhmS21vRFVlZmp5TlF5MEt1U1c5?=
 =?utf-8?B?NnhVUnVYK2NjblFRQ1hqVCt0eW95cEVQdlZSSEpOMnorRVovSnJLRkFMYkZn?=
 =?utf-8?B?RU53dXhSZDRHbVVGZENLVFNvMzFkNm1hK0cvdEt5VERCOUNMc2FWSmc2cFVM?=
 =?utf-8?B?aDJLTDhVTnl0S1BoR2E5ODNuQkdUMldmM3hrUFFhdUp4UHZqUnFMSW8yZVpW?=
 =?utf-8?B?SVp0M0gzejJpTjNZU3dWMm9QWEhqQ29Ib1FzbGRmcFU2VzNMU1BQLzRTNFFM?=
 =?utf-8?B?eGpMTUJqWG04RXFIZlZKa0ozTHQweFlHeWJLZnk4MmZ4ZndmeHN5SXRBSE5j?=
 =?utf-8?B?Qkhsb0dEMGtmY2dsUmd1QmZnalRGdkFoaTlRc2ZqUDRybmQySGszYWR0bWNX?=
 =?utf-8?B?NGhuTkF0N0lPTGw5OWFCNDRKak1icEN0WE10bmFNWHEvbEw0OG1MaUdhWVNN?=
 =?utf-8?B?L01MZW0zdWFNdGRXV1JCWGdNcThDRWVCTkFIRkRkazVMdXNORThCaFhNWWdP?=
 =?utf-8?B?cjkzcFRKQ2YrYmtqemJwTElhSzdUaXJNWGVuQzdvZTBDRVErUHcyZkVhMWN2?=
 =?utf-8?B?WklqU1JQUEZKa3J6V1M5eUI0WDcwY29TTGgvVE1tanRzcCtvd3BQRDhxRlZ6?=
 =?utf-8?B?aXYrNnFmaG93QllsVG9uT081Q0QyOFl3UjV4UGhPc01vazV3T2pqRHJCb0ww?=
 =?utf-8?B?a2Y3ZkJ0VmhtTVo4amgzN0d2OVFsT2Y0VDY5cVdaUTI1V0hDc2dyVytJWnRy?=
 =?utf-8?B?c0tyM2dBRitvazgzRGZjN1pMTFkvOVRpWllHbzlrWEZUMFNpdGtQZXBJTVNO?=
 =?utf-8?B?cnlibm84ZjdVV0NXMFFhQjVNVHRJdmVEWjliVE9Md3BPY0dlVEZVNmhOeWly?=
 =?utf-8?B?S0lyTGRlbHljVUpFZXpsdlhpd0s5Ui9kNjQ3aC9lSlFoTmhSNVJHb3ZQOFJo?=
 =?utf-8?B?SW9PUGVkUVF4SFo3VTRIWU8rNnAwWHVLMVFaMnI5MDhwempDU0hWMnVDK09T?=
 =?utf-8?B?Rll4dHE3QUNDUVA3dnBNdzFiUGtjRkxOMnJpTnYwME53bFBidjQwUzZSanIx?=
 =?utf-8?B?QVhrYmUzcmx5T1V2dkZPUWFNQ21nVURPTlRydzl5c1ZTcXhMSlRJWlA2dlpF?=
 =?utf-8?Q?aP6vOS?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: z0wB5zCbBdlf3FP648Hrih6iXFPAph1whBmEXpczoQO4H5p/j1vwBZKTQiNQPQiLn7v0Wv2/N5s3KqD7m3MIoeINlmJ4DRcZ0PoW53pHPf5uktoFErDApHgilLzej+MLZkjM1qMhLRRPysVirlJ2EFQpLF1Ibn2qFDfHs6J5z1YMgyc2Dp3GCxCJywRM8EJJwN2nG/UJYQxQpFhPfWWsiKFUfjhtGE5EiYSejWZxT4yynAoxk4iJZUfFC0F3fy9TNZmLXIblr5kJaoaP7qKuTNP0RHxyn771aVJ40gxjzpAIs/RffmdTmQCMq6YxUAxqyiu98Ba3S1Y7ZSmldXQCq7yLGpG/gZiOFblMT3rpWWjePCMvE1ECZAFJ2MyIKjb65XYSPa1KhVEaygAhQgZ15kvFut7lsLXxsYKfLHEAEko=
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2644;6:HTnoywXqmBxxoriOew4TQa1PjDBeaxqJf42F0aoVpAg31CQUNmK21Q9I1DhZVZ/dmdlTZOFxuExDfDU4nZkRk2qyoKs0R09QZylZDv5BmeauVTaN0VZj7u3dXWyW6wnY23nFKoqSSLSmeI7UK/SRmlWDFLP/Tj9VpCqgHoXggz1OXJycIB6cv7gpD+zJeFJJujwBEJrR6fQjXoFSEqSGWaD80ZInU0TBSsnEsyir7A4kTcA68Y0X03x86piWLeFjyEh33CtzqjKjMOS+xShbSaXTUnb9PfAf5/kyNoUeDO0hAcqnawYuPE1lBjvziEjLRSa0c99LjBM2vTHwCbhMKRYQMsErP80qMUl0tpez4quSgVRUUlV3ZxZ0v5BCHSassT3Dr5LHyXSenPalHywUtWb5yPaiRYdk6bLY5pUh4x7fX7cTFChFw4bLthI3dQAVOLcS3ewN9dil/DwIFpc9bg==;5:zm1xkttPeUOOCZB0SELzhJoyxjjzjNe5wqev2I46GyNR95DNqKmQTKOISZfA9/9Bn39N85Z12pljQCo+htwkGSoOh2zsbFM1KNID6FHDOII8m62jeDUGPCNv1N80EtI9KYljlaXWd/Z7Tt5Uhd1FBYkXuf/nqcfxIZH2qFsgzP4/YuGOfpMfTjF8k71DThK7ZSDmsLMY6w/aK8uiKYKeJA==;7:y7+oY0XT6FQRxPnG6T3ivBhu3n6IL1n6inEeRqBF7gZr8VhWJiO6m1/YAOlozT/ws1Akm7PhK05c2jQMWksjzX1xT4+3N2/UThDuGWgDJ5ZklGWmYDTutG2gGZOZJWpBHkSwsAVYUPjPYJ5/D1KtJA==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 13:11:21.8763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8665965b-e5c0-4507-794f-08d685eb43fd
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2644
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14. 01. 19 20:22, Jolly Shah wrote:
> From: Rajan Vaja <rajan.vaja@xilinx.com>
> 
> Add Xilinx ZynqMP firmware APIs to set suspend mode
> and inform firmware that master has initialized its
> own power management.
> 
> Signed-off-by: Rajan Vaja <rajan.vaja@xilinx.com>
> Signed-off-by: Jolly Shah <jollys@xilinx.com>
> ---
>  drivers/firmware/xilinx/zynqmp.c     | 29 +++++++++++++++++++++++++++++
>  include/linux/firmware/xlnx-zynqmp.h | 20 ++++++++++++++++++++
>  2 files changed, 49 insertions(+)
> 
> diff --git a/drivers/firmware/xilinx/zynqmp.c b/drivers/firmware/xilinx/zynqmp.c
> index 84b3fd2..c7a3b6c 100644
> --- a/drivers/firmware/xilinx/zynqmp.c
> +++ b/drivers/firmware/xilinx/zynqmp.c
> @@ -428,6 +428,33 @@ static int zynqmp_pm_clock_getparent(u32 clock_id, u32 *parent_id)
>  	return ret;
>  }
>  
> +/**
> + * zynqmp_pm_init_finalize() - PM call to inform firmware that the caller
> + *			       master has initialized its own power management
> + *
> + * This API function is to be used for notify the power management controller
> + * about the completed power management initialization.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_init_finalize(void)
> +{
> +	return zynqmp_pm_invoke_fn(PM_PM_INIT_FINALIZE, 0, 0, 0, 0, NULL);
> +}
> +
> +/**
> + * zynqmp_pm_set_suspend_mode()	- Set system suspend mode
> + * @mode:	Mode to set for system suspend
> + *
> + * This API function is used to set mode of system suspend.
> + *
> + * Return: Returns status, either success or error+reason
> + */
> +static int zynqmp_pm_set_suspend_mode(u32 mode)
> +{
> +	return zynqmp_pm_invoke_fn(PM_SET_SUSPEND_MODE, mode, 0, 0, 0, NULL);
> +}
> +
>  static const struct zynqmp_eemi_ops eemi_ops = {
>  	.get_api_version = zynqmp_pm_get_api_version,
>  	.query_data = zynqmp_pm_query_data,
> @@ -440,6 +467,8 @@ static const struct zynqmp_eemi_ops eemi_ops = {
>  	.clock_getrate = zynqmp_pm_clock_getrate,
>  	.clock_setparent = zynqmp_pm_clock_setparent,
>  	.clock_getparent = zynqmp_pm_clock_getparent,
> +	.init_finalize = zynqmp_pm_init_finalize,
> +	.set_suspend_mode = zynqmp_pm_set_suspend_mode,

This has been created long time ago and there was one more patch in the
middle of this.
I have applied reset driver just now which didn't have any issue that's
why please rebase your patches on the top of this branch
https://github.com/Xilinx/linux-xlnx/commits/zynqmp/soc and resend.

Thanks,
Michal
