Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75C7C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E70421903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 06:51:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="TKyVaadz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731597AbeLUGvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 01:51:04 -0500
Received: from mail-eopbgr700084.outbound.protection.outlook.com ([40.107.70.84]:43138
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725785AbeLUGvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 01:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eF/V1AOrdnGmi4Bw/w+Xl//h7VqNR61dsyccBj58atY=;
 b=TKyVaadzPKNs4oM2ad370HHoUoctm5ycC4iSvkt94riuecQOWobDpUcZtNTDTC6B4Eoz4EVBFjlaqCFIK+9fL9zz1TBgrQm70IzbD4btoLybevm45biijSi3oCb3aVVNGNGEUVRtifZTHNvsGAZoQaZPY88xFbl6gGRUxBkGTfQ=
Received: from SN6PR02CA0027.namprd02.prod.outlook.com (2603:10b6:805:a2::40)
 by DM6PR02MB5226.namprd02.prod.outlook.com (2603:10b6:5:48::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1425.22; Fri, 21 Dec
 2018 06:51:00 +0000
Received: from BL2NAM02FT009.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN6PR02CA0027.outlook.office365.com
 (2603:10b6:805:a2::40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1446.19 via Frontend
 Transport; Fri, 21 Dec 2018 06:50:59 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.83)
 smtp.mailfrom=xilinx.com; linaro.org; dkim=none (message not signed)
 header.d=none;linaro.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.83 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.83; helo=xsj-pvapsmtpgw01;
Received: from xsj-pvapsmtpgw01 (149.199.60.83) by
 BL2NAM02FT009.mail.protection.outlook.com (10.152.77.68) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1446.11
 via Frontend Transport; Fri, 21 Dec 2018 06:50:54 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66] helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw01 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gaEe5-0002vt-7Z; Thu, 20 Dec 2018 22:50:53 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1gaEdz-0006ub-T4; Thu, 20 Dec 2018 22:50:47 -0800
Received: from xsj-pvapsmtp01 (xsj-smtp.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id wBL6obpt001382;
        Thu, 20 Dec 2018 22:50:37 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1gaEdo-0006tZ-Ol; Thu, 20 Dec 2018 22:50:36 -0800
Subject: Re: [PATCH v3 6/7] arm64: dts: xilinx: ultra96: Standardize LED
 labels and triggers
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        <michal.simek@xilinx.com>, Rob Herring <robh+dt@kernel.org>
CC:     <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-soc@vger.kernel.org>,
        <daniel.thompson@linaro.org>, <amit.kucheria@linaro.org>,
        <linus.walleij@linaro.org>, <koen.kooi@linaro.org>,
        <nicolas.dechesne@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-7-manivannan.sadhasivam@linaro.org>
 <20181221023708.GC3233@Mani-XPS-13-9360>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <9f4f05cb-f326-a4e3-e306-cfbf64b629b4@xilinx.com>
Date:   Fri, 21 Dec 2018 07:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181221023708.GC3233@Mani-XPS-13-9360>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.83;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(376002)(346002)(39860400002)(2980300002)(199004)(189003)(64126003)(9786002)(6666004)(356004)(2906002)(76176011)(36386004)(6246003)(31686004)(8676002)(110136005)(54906003)(58126008)(230700001)(81166006)(316002)(81156014)(14444005)(186003)(26005)(50466002)(44832011)(36756003)(77096007)(446003)(65956001)(63266004)(106002)(11346002)(7416002)(426003)(486006)(8936002)(2616005)(126002)(476003)(65826007)(305945005)(478600001)(5660300001)(229853002)(23676004)(106466001)(65806001)(47776003)(31696002)(336012)(575784001)(4326008)(2486003)(107986001)(2101003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB5226;H:xsj-pvapsmtpgw01;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-83.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT009;1:MKqMotHaStxZEXVilAwgKXrjorS4nGa4Z3kfV9UpKSAsHdGUubLECDh0odN52vh7wooMUZrMjJ69U6c6gSRqoXHWdf9xoYojW8HN8M5UTORoQEQIt1hKCiKC4RcpPCgw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e1dc704-9937-4000-925a-08d66710aa42
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:DM6PR02MB5226;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5226;3:JcuAm2+kewdvPxm4Zh3wfI94NQoo7U5ZOpPsM69yNJiGmF79NegTxyjDT3uGY7Bn/bt1J9mApiVbYhk6fZp2AOjtrsV4mFmcSlJQ9RJuC5WIhCc3KPq7GfY+ngZ4vGlzYdrqgHj50EY9pe5QddPF9u7rMrvk8elITb5ElMiSRdLcOb7YUgDV21q5oZmOTas5bpfi1YEW/JH+omDAxi44uXWwl0wDmol+YKgs1LwfiB5+ucG2QxnECICKK41jNYQrOPc1QQk1E6HtPYdATdyb+IQuvVSyjwcnHYOKgDG9TUAAdClat38yCaXuXCI3hV0u1DfxFgTm2e2WbSGN9+2UxkwoAMPwHbdMDKfHYRLnysk=;25:u56GF3F+3fkXoHGgKon8H/0CNyCL/20eeSVNkfYHG+a4ahJblMhg8b2aKdp5u0IoeOqprWuzquY6XfOKmpGLazbGVeZQ21uNXq6vaMELvpRDseLnnU3iLWw9C8ofdXBPu+vDgenCPEXoo07wO6iBaYmEtFTfFxBrZaspUVewxjaedJ81ujY3G3bQawBwAcqj7WLEpuZQ7cehXnVllEzQCWwEq1KOEHcekiNjbFMs1RnxtbmwwCwYn093ehow98QPJ5rUpsUZcPok/OS1DJG9vZQbsFsx81cJkPBIdcgytThuCpQ9goxciKi0+0jWyG/O/W+sSTjjle2TcrKO5bPsMA==
X-MS-TrafficTypeDiagnostic: DM6PR02MB5226:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5226;31:UF94JNUpaBxt78zKIK8StMcUZ1HF8cqZuDcmB0CQJdh8IODmyYJfr1wcLwjMm4XfR8apDCMvygT5VAvAQNllfTqj+UArDrjVj365VtcSgqE9epiDDDcYVxSb7XLtV6d89wa24EPAJL+OgdnOQVoXnmhbUjoR86X0oeQbErkBAnFwPIAHlWGNwpL1nfjFITYVa8XCk2+tQeo2pv10/0L3NvjIBxtLV0gLTBNsg0KvoL8=;20:rtbTD6whqlP+jbUJR0FnHs+RgYLHo14C3iVdbFzh177xTZomWBD3H3LcI/EWMAqX4CkOEpNWLWR8wjeh70ur9i8LaJ2pfmPjnLNKxu/NMuwhOsj17lPlft6CikxdToaHPRAMHirLVG9XwYQYsArzkgLJfxOmKY/qxQkQGlh0vmcKgHO726BzGBcIOE2/bo0Nk9BastN7VKemTBoUjw+brwLEtYaJklvTPJM630jOpHUm1BXUE5C4P3Ou4kDrb64TCAA5+vxd3BNT0n+rtkIpwgnyNR1ZEOTinqI7N618XQ2EGVcdIlMFmu3KUgdxKV6LbDAZKvzVuPIRG9TBpYz4nqGZEcp2fdcGlvTGpyOX+GBNA+Nic3kmt3KyXNTKO0dPZhEUC2u/cRgO1RWYerqT1+NcKFYGyvdbhxweXnw8ocjs6jjDEQeToJHHyy5rOQh3NbdoY++W4wvKP8WKBjwUXdXLN9BF5+GnXeOn7z9JybVEEuZiv44OgF/wMA1kF076
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB5226FB53CB0804460F49D733C6B80@DM6PR02MB5226.namprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(3230021)(999002)(5005026)(6040522)(2401047)(8121501046)(10201501046)(3231475)(944501520)(52105112)(3002001)(93006095)(93004095)(6055026)(149066)(150057)(6041310)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:DM6PR02MB5226;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB5226;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5226;4:DGN48ogADd/JtRkwLaSj81iiVZxaqH4e7atQpiszWGoZpjG79mHogDFoF8yaAHMTI3XW45KGYg0CcUxOg7O4BjvSmpti5RaYys7WmZf9aVVVjT2+b05qWe0uHIf2epDHAHSVV4S/whl6S8QrKdDKQxYL71CdAC2RlrKUcTiHHZp1nvqsxo7VvArbhaxpFgECATZ4j4zPpINPATdV8kcWMlWJJ1f4oMvxsJrItsLP0GB7U3znSohJHOP+EDXX8s97sRjfrPtEbOpBEXwCJ14luw==
X-Forefront-PRVS: 0893636978
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI1MjI2OzIzOjlXN1JhMmcrclpsYzFWUFg5bHE3K1VSMHVi?=
 =?utf-8?B?THAxbXd2NWs2dmZaWERlVEo5Ky9GT3dPYnJWRldIbmpYWUZ0a2prekFiazZD?=
 =?utf-8?B?ZzcySlpZVm5odGVweVNQM0pzZzI5TWRSWEhYWG5iek5XUStqbGp4TXVGWEFQ?=
 =?utf-8?B?YWRjbTNXM21ON280MWduejJmV1dKTEtHeEgxa1AxT2lPdU8zS2dEMFZ1KzZU?=
 =?utf-8?B?MzVaTDBZS3pDSGY0VkdUd1drMk5FWmVacG1EVHZ5dVlPaEl4N1p2SmVwb2hv?=
 =?utf-8?B?UUV5ckUyejMwbzFBVjl5ZisvUHRnVnJySnN4K2hQRWxBdWVrQmJGcUI4SDV3?=
 =?utf-8?B?RHF5N3Rzc21FSmwrVHhQYmxacktXOTlSdzloSnNOVHhWaWkyQ3VMN2RxeDlQ?=
 =?utf-8?B?cGs5YUgzS0dFSmRBYVlMTUllWmIxdEFwZHlJRjFFVG9yMzVxckVYN0xUZDlP?=
 =?utf-8?B?akxEUXdjSEVYSXpsZGdPVkFmdTBhS2MwTlVjeXhQbWFFakpsZ2RLcUpLc1o3?=
 =?utf-8?B?bEhXZG5xTWJ0QmswdUE4N0NuZ0x1UjAzOUhGWmJTR0dUMUFmVVBPVGFOamxQ?=
 =?utf-8?B?Z0g4allRZWJoQmFJeTNtaGxhaDJtMzNlR25tRStzdEN0angzMHFiaVZLWGV0?=
 =?utf-8?B?VDlGSW9STGFJNnVxaG1jd1FxVkRQSEgvVkpsSE1kSzdFazNKV2lCbUh3YlpC?=
 =?utf-8?B?NUV2WFpEb1VIZ0ExUTZVVUNvYUU3RVlxV0ZVTkZ2Z1BvQTNsY0pHS1dGSUov?=
 =?utf-8?B?N1M1WnFXc1NMT1NvdWRYbSs4RmJkMnJVYzI0SnJXWjVXNmlLZVAvTDJaT3dP?=
 =?utf-8?B?cVlBNUZTSnFiN2E1cGZGbzFtS1JRb3o2dHQ4WlZEVkVpd3E0Sk1oZFVRSGRw?=
 =?utf-8?B?NFVKbXFGVmFLclVna25TQng4ZFFqbEFnWFROMFhhVnN5S2orSnFSSUZ0dVd5?=
 =?utf-8?B?Qlg5VFpHQmlQUDFqR3YxRlFRbUFaYnhielVaa3daVGdsL3FqWTdFeVBCNWFw?=
 =?utf-8?B?R1Vaa2Z5RU1qVm5KWlBzMGFXY21LTDRYU2QzSWpNa0U5eTRXb1RjbXVFMGFi?=
 =?utf-8?B?RkMrSFZKaHp1dXpRdU13SkJsd1RONEU1TE8rY2l0L1RJUTRnQmxrc0VTem5O?=
 =?utf-8?B?b0ZJdEZSdkRsWFY2WERKcUpoWjd2TnE5dy9mU1VtTmZrczNmeFBVckZTUVJH?=
 =?utf-8?B?M2lmQjZlK0hLMDBucTB3K2wzWW14eHZqRHlGdWY3TmlrNjZ2SlcxeVhjQUpC?=
 =?utf-8?B?R0ticy85dzUrYmcwbEM2M2VmaVBpYUIrVStPaXQvb0lXRFN2eXJDRDQxODlI?=
 =?utf-8?B?OVFuNnpDa1g5ajZHdUFhMThzRG9qTlJndE1aVS9BUGxCMmVyL241WkM0Y2Yw?=
 =?utf-8?B?UjZMTXhsODNmbis0SDQ3T0dhQkt3RnptMm8zZGt3dis2MS94QWk1UndZdzls?=
 =?utf-8?B?QzZRVVFXS3VSenVvcE5SeGV2OUJ0TlluWkZSNmNLNkczbDdaNGl4T2NFbENG?=
 =?utf-8?B?UlMwc2hnTXNmUmE0aWgwNUphVlBwTVNGRDZENm5sTDlWMStVSXRYaWJmWXV1?=
 =?utf-8?B?RHVtMHNSMDlwYVhGK2tZYXRvOXNNQURJNHdsbS9GdjNmSGVLMnovUlc1ZlBC?=
 =?utf-8?B?MG0vRWs0amZZWS9WdWwwMFBnZzZTdDlPYXM3Vnh0RzZlVFNOZzE0d0UzRUVF?=
 =?utf-8?B?TFEvTWJ1NjFPWUx1Vmd5N1NtUUlSVmcwbXZqc05kMWliT21qQlU0Z1ZDMFFE?=
 =?utf-8?Q?LeZ2Xw9B7/7WZ+9zvivCCrFwCU9iLYtsoG5rA=3D?=
X-Microsoft-Antispam-Message-Info: rxSYo2/x6OcwfQNPRlrmAR19pptV1wezBjHuTVBRkGQUFPseW8hhq+ngDis1mm2vBBpUxwkEpY4kfKurfUW7N+kygdnSXwMDy/vODfjQAQPcGnSWhp2ef3QA5MMrzTTM5oDgjfTCrYqAZo1CsAn4264WzIQwgaG17bTSnwFfcZ9G6jJI1YdG7ZnY4PHkfeDiogXx3Jpdiwhn3HamhYFFxYKVzY/qbvuLCqrxa10aCK6DxhdwKENbuaPEfCSHIle8rzXMpfPHBVHFKF6wEumP83SKso2EjC8GITmDhb0vIAZatv9LYnsICcOrlnwPHhEm
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB5226;6:vbaEjGb3XLbDLNnDHchz+xBwbRXWn2OTRdBwR9ufs4SK3kWYsPoPb7/lyW6vRHJscF5/ogpD903Mjlg/LaVwWHfplPaP8gGALO1GvxNwApxMr/VKlPpF51Jom/LctnUrnt2BsjoF1RV/PSuEqRmSK4DICSCEUtQ8Ro9CkacJX1ZuoUTvMvqQry1XOj4b7a2x8RizFL971tlbBLkCUBasY49bvA8R6e4dHnFVvCZ+VkqtV+T2AX+h8Dy5yhvI/jmLnVDlxKi82BuGQNHIwtxXzgung3H/biug7JYFy/3p9F2mD3BIa5Exm8/oFX/IqcYeurQZsKYbknIalGs7lkHMHnTkLUN2kx/H8oZyGujbO0n2gWJuH3R0IG5w0wmrQX91bTQU9/jmXV0ZE84aK/aFgSigz7yCLWViykT8LA7sd0Zt0qKZXNmqkZVIchfdidSus7q/IA6ANSs5vJLhHEaCZA==;5:sOUUt6X4sC/V5x1rVugUuC/QpxSOqHrxvWwMVUvQJNMjFAN4vDzbY26hbpjoXuMh5uVRQzaJc9Uiy9IeZtG01m0blSSqKcqeoH312k7VS/3Oz8ol6CXeieUkaTGd7hSE2hM4ynVkawluCCtgEKzVeBlt7LZK/SHqiqiBQMpe/cw=;7:Buk96ktpCw1cc7L7ulNhq4thSnD0lP/iVPTj70PMvrxofHWpJv0MUG0HVI7TM7e8RXqedluBsRUopkddJdMyjKgFwAn+wtLQhufZbYbsE/gDETgRbUa0G6XLPLjKtQrepFpINor8VU2zYiQpedoHNw==
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2018 06:50:54.1567
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1dc704-9937-4000-925a-08d66710aa42
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.83];Helo=[xsj-pvapsmtpgw01]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB5226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21. 12. 18 3:37, Manivannan Sadhasivam wrote:
> On Mon, Oct 29, 2018 at 03:12:44PM +0530, Manivannan Sadhasivam wrote:
>> For all 96Boards, the following standard is used for onboard LEDs.
>>
>> green:user1  default-trigger: heartbeat
>> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
>> green:user3  default-trigger: mmc1 (SD-card)
>> green:user4  default-trigger: none, panic-indicator
>> yellow:wlan  default-trigger: phy0tx
>> blue:bt      default-trigger: hci0-power
>>
>> So lets adopt the same for Ultra96, which is one of the 96Boards
>> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
>> consolidate only User LEDs.
>>
> 
> Hello,
> 
> Any update on this patch?

I am still waiting for reaction from Rob.
We are keep trying to keep backward compatibility and this patch is
breaking it that's why I want to know DT guys reaction on this change.

Thanks,
Michal
