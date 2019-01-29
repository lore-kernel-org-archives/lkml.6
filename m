Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E160DC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9EAF020880
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="p4DkoXuU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbfA2NRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:17:52 -0500
Received: from mail-eopbgr720081.outbound.protection.outlook.com ([40.107.72.81]:59466
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726390AbfA2NRv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=88UXpWhEGIMWyQl6pEYbQ/9Zb6rIUpIbeTbv9VlxmSY=;
 b=p4DkoXuUPusevoC/iV2RWs6d6d019+mx9vwrsDap85+Wem9w5ZcJkENNgsROS3lJSRmpkrlq65qFlbtiNqL1dTRO4KP3lIrYRAeYyfbqhzaXTJclx1Wej4g8mYr62tUV9XKlQ720T+eM8rSA3T1E5KmOdySZuYtaa9Ry1KgC/vE=
Received: from SN4PR0201CA0015.namprd02.prod.outlook.com
 (2603:10b6:803:2b::25) by CY4PR02MB2645.namprd02.prod.outlook.com
 (2603:10b6:903:72::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1558.21; Tue, 29 Jan
 2019 13:17:48 +0000
Received: from BL2NAM02FT031.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e46::205) by SN4PR0201CA0015.outlook.office365.com
 (2603:10b6:803:2b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1537.26 via Frontend
 Transport; Tue, 29 Jan 2019 13:17:48 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 BL2NAM02FT031.mail.protection.outlook.com (10.152.77.173) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1580.10
 via Frontend Transport; Tue, 29 Jan 2019 13:17:47 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:54798 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1goTGt-0001wV-85; Tue, 29 Jan 2019 05:17:47 -0800
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1goTGo-0006zy-3r; Tue, 29 Jan 2019 05:17:42 -0800
Received: from xsj-pvapsmtp01 (smtp-fallback.xilinx.com [149.199.38.66] (may be forged))
        by xsj-smtp-dlp2.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id x0TDHZQU029145;
        Tue, 29 Jan 2019 05:17:35 -0800
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1goTGg-0006xJ-SG; Tue, 29 Jan 2019 05:17:35 -0800
Subject: Re: [PATCH v3 6/7] arm64: dts: xilinx: ultra96: Standardize LED
 labels and triggers
To:     Rob Herring <robh+dt@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>
CC:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <koen.kooi@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-7-manivannan.sadhasivam@linaro.org>
 <20181221023708.GC3233@Mani-XPS-13-9360>
 <9f4f05cb-f326-a4e3-e306-cfbf64b629b4@xilinx.com>
 <CAL_Jsq+zfV66EZHX7psh2=r-=wDrmLLcr5PWtSzuKRNOdMR-Dw@mail.gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <bf2c3b1e-7f89-4f68-589e-29f81c782c80@xilinx.com>
Date:   Tue, 29 Jan 2019 14:17:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+zfV66EZHX7psh2=r-=wDrmLLcr5PWtSzuKRNOdMR-Dw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(979002)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(189003)(199004)(58126008)(54906003)(44832011)(110136005)(50466002)(486006)(65826007)(47776003)(65806001)(106002)(76176011)(65956001)(336012)(7416002)(6246003)(476003)(316002)(53546011)(478600001)(2616005)(356004)(126002)(8936002)(11346002)(426003)(2906002)(81156014)(8676002)(81166006)(6666004)(446003)(230700001)(229853002)(31696002)(14444005)(63266004)(36386004)(77096007)(64126003)(31686004)(23676004)(2486003)(9786002)(305945005)(186003)(36756003)(4326008)(106466001)(93886005)(26005)(42866002)(107986001)(5001870100001)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2645;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;BL2NAM02FT031;1:mfqXn9LzeAHrBhXUXmkHydgbkvgCtfaed6X67POsmogrKaTzmEOtZw7mAQwqu2peNV7lz1xoxG2ni8BX/0Xi9PhXqobJB2ZiBwLuAPawYmZymk1jG69dUuq2o25Fve16hgT5Chkke6ADUGSAD6XPHQ==
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 228c1c61-4b9c-40c4-886e-08d685ec29dc
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600110)(711020)(4605077)(4608076)(4709027)(2017052603328)(7153060);SRVR:CY4PR02MB2645;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;3:buWvoYeJtDCVKH29mj++wubIazZ6K8UMJUuyAgIi1qLQjBKC6oxTGZkbxJS83AFCGo4s3+Ie9wA4MZfjCvUnWO7COS3va9ZPhgHiXnv3GcWapusgozp3ZOuOayNGEWj/JBqmTgU89BH03wAL/F1rV7198ff8OtZ7+CkzumNfVroGyo3ZUGnbfTKxhHDLvAZ/Rh9LuHAlF7KrLrqjPFF7fn5wxUizvG2rmpduS7nL2EbEVdfgvfkRVvtE+ZzdE5Ag4fJtJURKNQ3mb8ijrD5VArRdLe0Bx9ppVRcSeFE9iOhvrhIagNc5rc7ktZVXUEByuSwEapPHdJoIyg4rnAGo4tGAeHtn44yPkX3W3YWK3nXlHkBuWlTPnkkynXH52+u2;25:3gTwXKtap/meniiHQSrZjxtIvJkkfFDkH0w8pnDBwhVJhJ+aJdT8ff80tj+qcYmtBx6kekAw3EVNJG/9bZWI7yksi+2LMk0cpkslY5HNwtj2rzQq5TIQbnoGeoVWa3aFqUF0iI9hirhfDoX8vlQviMNAmXys8RYW6+O/9XUmCAhFbFDahO/SVlFEwfdYjHnmKCY3WqE5j2oP2/VMFGK/G4IRQizWVrxhYWZ0GtKadZEWcW4S5Tdaul/LDt21LCfwG3tNnkiyvuEw9b/9xuvBW0gau0yA43t2dMIPuqgrSbrX34UIySh7mnUIPsHjlXiBXNbnupdf8HrZgZIwGLXorQ==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2645:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;31:PLoK8M//pZWwT3whPLPJb1Kloe25O9LHD1rREIhK9N/CkO1+9dNIaL2DS48bTpavrpNoshbvYR2cuVxqXRCDnvF9vLHb0PA1PfHrfS86O2MEmZmy09oVeNKcz4q6z2+eFoX6o1uMwDAJgRV3RVIA2w3Tg3QhTsLAESepXKgUMvkEmQy/AQnxbS21mMqJqdWNLUViI8e+YnwzgDeOnYAW7fC8k+3HxEptSWE+VYjI6xE=;20:PWa6lyVbb3HA/12ZvkoKEMTUwu1PhieIXG6qXZtrzD+cQ11jtQhfmWFhmE8Mnv7SbdavlsiNv+8YmbFY04+CajnNm1+zF4OB1ucvWb+H+oc1maJiKToBuryISIAltJR57c/0Tt6bUpRXETQA7arh5SCQdBUxDWqVwGlLbz2majA+5c8zpJZDT80ecuvwQ3yLs6TGuEkajvuws6eMUhgDf3cctgh/o4iKLUjkr4JWKC3hbEaGYq1x5WPh0xhviTDX7HPYW2DqQkXXIvi3QrspNqiEM9ubp44voeQdSxcM0Td9TNghF2KNkp2Zy2alsFuDgg1um68hioOuEok+5ilKl2jikqJ8mtN5YO4TuGy1EpAw/g1NoXUPRyWOkYQNefu1eFfAG2bytIqt9ie3mdI/Xh0VQ6bgVCp9mwrLdhZqLnmPKNx9Qu9BczldwX8JbpNdViQeGqIaHbsu5g78RIoT4Pqpvv29wtVVZ82GdLPCOtW5q+t2DV7OyyiN3aAeV2UY
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <CY4PR02MB2645D376BAAFF1D4A063926AC6970@CY4PR02MB2645.namprd02.prod.outlook.com>
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;4:kUIfUDeB+1l5cg5hb8S+S6oqVjaWFlEQY+pMDJFjGe8pKsR+dF4+6UhKe7JpakQ+mYMlslFcrXK7klbi/fQM7DKDhkvZUzIzOeFWPIz8DIj40swkOZmwf5Ih2HDhqc1iZF6v7pnX+wOMHnydzsveb4gC3OdJCXA5fWpwFVPee4QVhafvIADJPRmoNwLTsQT7INzSB0ECHolK2a+m9dU1JVds+IJZArOx3il7rLcrDRMxT9x/o4yW3FPIiQ8N3RFKqeULtZOuoBsVArvzG+1XS1FDpoqm67aM4ue1xuN23b4=
X-Forefront-PRVS: 093290AD39
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyNjQ1OzIzOmR0eC9hb3c5NXZ0L1V1SHFUWkRKb01lL295?=
 =?utf-8?B?UlVnNTVpU3JPdWkrays1NDNCK1M2eGFtSFNzQjF1cU56SFhVczNpNGlXU0Zr?=
 =?utf-8?B?Uk9aL3FrUWhoNDc1MWJYVnlMSkFoZkFIa0FneXBFWnVYZEVFVGxYRFBSYWg2?=
 =?utf-8?B?MHIrT01Cb09EVDRvUk9BRGJvZkRIa3loNTVaNGtwTTVCN3NuVjBxZ3g2aW9W?=
 =?utf-8?B?aUZkREN3QkUzLzg2UlljeGlpVldadHovazREUWF1NGl0QzVhbUZmVDVJYUs2?=
 =?utf-8?B?RUVaaE82cDZQcktoZm41dVRPd2VSeUlDVUNSUEx4Z0lac1h1dUVhN2VYVTc2?=
 =?utf-8?B?NmtjdXJxTHpwaG5lblRoWUN4c3FGUTZjeGVwcExWeUdQMHlEMXFQQXRtVzhZ?=
 =?utf-8?B?SEs4Ry9qSnpURnpLRlpQcDJhcHhVWGEyWS9adDM4NS91M0lXYmRqd1QyVFIx?=
 =?utf-8?B?bEllUGVZSFBLZ1RuVGJNS3Bsa2NaNU5YRUpLRnA3UENTcmNGajlmam82aHFs?=
 =?utf-8?B?L2p0Wi9seG9CZ215MzNwMnNYYkY3bWRXK3AvRGNld0tjM0F6RzlkajE1c1pC?=
 =?utf-8?B?dy81ZzNMME5WK0dNTmtyaDlLQXk0NlVua0szSmN0elJCV1ZqWGQvd01kSUlp?=
 =?utf-8?B?cG1HdkJza05DOUdMLy9EQzZPc2dyckpCdG9mV3paZWgzWUwrZUVSOXhwR0dL?=
 =?utf-8?B?RHRuRDFMYTJLWlNNT1VaYnJVeFNhWnB1TEtERlNPZUUvUjk4d2VLSEViV3dB?=
 =?utf-8?B?TC9JZ1Y5S0NFQVJVczBzU3JwTTJPTFlBbk5xdW1BdXRzeGY0UzFIUmZWVlRi?=
 =?utf-8?B?MnI5bEdpR25vYVdCZ25tNnJIOVpWRWUwL0dxeGx1dnFLSDJDcjlzbWxpaFI3?=
 =?utf-8?B?eUV5K0dOV0pvd2I3YmN1MkNGUlJmZ0F0b2RuTDY5VjNZbWwwOFFVdHJRWXYr?=
 =?utf-8?B?TlMydlo3MUdZUE5HenlPTmZJeDlLZklWQi9UWEtBVm9kS0NjMTM3NHhqOUlv?=
 =?utf-8?B?WmhXRTkxNVdIamhXWHdJT3JQVm1ndnQybVNybEVhYkN6NzhKY3RYa05QNkNm?=
 =?utf-8?B?YkZYZGUvdFpMd1p1Z3hYMCt3WFBQUHFVK0RoNm5ES0FaUWh3Q0dORlJlQlUx?=
 =?utf-8?B?bFQ0Nzkxbk1Xb1Y1TW5vL1ovK0RweVl6blpQMm1tTmlCVlNvcU93QUMrMFRq?=
 =?utf-8?B?NWZXMitMZmI5L2k0Mm9KR3Q5a0V5T2hFRkZpQlI1YURvUTYvOVpOQmg4QzNy?=
 =?utf-8?B?cHdWVWNCaUdBV2tBakNPOWtvSWpsa2VYa09lUGpkZzdLT1NvOUpTcW8vcVY0?=
 =?utf-8?B?Z0JaZng1MnZGSjZjUnlOMThMbXZLQ0ZUWVcyMkJ3M1ExSjdLRVZBaHpPYU9q?=
 =?utf-8?B?RmNGTFhlOERPRHg4UlBJaWo4a2h2dkZ1ejBoblFMU3diY09WYlNydkpCZUI4?=
 =?utf-8?B?WmcvZ1lqL2J5NisySTExdmx6dTI0cWo1WFZlcDZHdWJWQloxQllsT3hMS3JR?=
 =?utf-8?B?UmM4T2wrTW1aSm5FVG1MM0VVUkovTndWNTMycTZ6RzVpRGlSb3JFbzdjS1dx?=
 =?utf-8?B?OTJmRXFFWldvaUpSMGtjSXdDeTdWTnUzdFJCRHNMRTJVY2tnNk50VTdlRkRu?=
 =?utf-8?B?eUZNcFhDYzlGV3dVMEE0NVN1dk9aS001L0Z4NGxBVGRsQzM4S3h6aUY1WWxN?=
 =?utf-8?B?TkRMd1o2VUMrUEFHcXlGc1YrWmtoeVhNdXRrYU9GKzF6MmhQOEY3dmxCQmFn?=
 =?utf-8?B?KzMyUExOOW5TVWlzeUt2ZE4zaUlKOUNVbUpFNzVCYm1tSXpMU09RVEoycHNy?=
 =?utf-8?B?SFJ3RmpoU2xaekpIekNzMlVNK3NFbW1YejNRRFRaSGdjMEJtdFFUaFU4S0ZF?=
 =?utf-8?B?dy9TSnduTzZKN01XWWt1ejdlWUJCN3ZVWEZueE9oN1R6SDFxd2phS3hrcCs5?=
 =?utf-8?Q?TJrZ/eXZY00WZ9rGXvpSpxPxmL/XXE=3D?=
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: vrPLD7xluiVpYOFnnSL7inGsjQh+e2IjNKf3WKqYvO+IbEFWqEGsSG6GocCYqHbDr22XYciWZPae6GCa4ykIwNjLS3pNY5d40UuQ4YB0tlfKvI+sMgVJsuY5FVv4OmbuZAm/7Y/syGS2gBJSNgCAYdFn1fvXBJswh1mWWAU5kWjTMo3yKqJNE6J8eCyGifTq/WoPiLTDcNyLSLNiQ4kUy8zeXfjkrwzAW7FJNORQFpQcA65dFlykiT3qJwlaMUtSmAO1OsJQDonkJtEClFhD/BkB3CXjOU1doqTMDU2yUTXwRzJdO8EkXHNl/vyBP9+sk8ozIREBKiE8l7cmZ6RQhb5fVZ5t0jIQ7CVhRTSrVcFgSaN3V0l4JvVsdUmRU+eUSx0d361HKH+ACAiC/P5wXzIgGHoH1Ptd+dhvLLZSqhA=
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2645;6:UxkQZE1oHhDhjO+5x4uQ3PN/WyXfdHcp4In1v0MXPjfo1qWsSBMDnxvB0qatwuHEsWoNQXpRF9m6UMYjNSR5ejsgtCKkU+AfotKoFFRIDDrexJMh/UCo7P5XIDSdrStmY/qVcZI+SBP9K5DdpvV93dCUDhL7Uc52ORqClRYvgSj8mZzjlmuSfqryYVcDLxE646V+t94TskkNga3XYL80ZFN4TjIthGYkPWD8X2dJhHmYgvIh+Y15saKGZBDHoBgwlOxHSIiKP/4TlbsoOFqw9EIqLoJbCqnk4tQUw3J3ipmr4easu5MlBcZ9hPMqYVSWpm6PgCS78/QGd7bkVYEo7eVA6nGaJ1CFHOsjjZVxYcOd5l5CrH6CGzSe1B6O+cB4YnicfvBwNSApVQvBCqx1ZA4Vp6uYpQYNDrhzZQhLnI3HeyM+hKnvAGa/5Rf5x9E8tEJdMMX75RHdOydWgMdClQ==;5:WXnOdTElo91ezVXnGNDDrMh4Vq4zjbGRHVIa2grar33UXg4Iq6GgL/7rus6UEWq9vsmf7aSHKeO+F8orcGusUV9HpkI5KjUc1CRxokky6ewuTAs/8QImFsWdtUBuQGykex7VHOZs0ZN6v+TpqyDdSHPCVFdddp5vF4F942dthvjrNvUffXjjZpoB3f3nP5IRExDQlzWfSymJCoFzgboMyA==;7:BxEpf74mmseVo2w4NLd2RH5cjo7e7RRmdJfqgdX0AGyt8dFLLpuUrkthZxtFHsT7M3YH20XRv4ngfWL/9RzkCjd7I6m3HkADCnuNg2NINAkRYancF8OjR63o/ElNCVag6t5JzqPgDqEb0CHHVyVg+w==
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2019 13:17:47.8181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 228c1c61-4b9c-40c4-886e-08d685ec29dc
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2645
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24. 01. 19 17:49, Rob Herring wrote:
> On Fri, Dec 21, 2018 at 12:51 AM Michal Simek <michal.simek@xilinx.com> wrote:
>>
>> On 21. 12. 18 3:37, Manivannan Sadhasivam wrote:
>>> On Mon, Oct 29, 2018 at 03:12:44PM +0530, Manivannan Sadhasivam wrote:
>>>> For all 96Boards, the following standard is used for onboard LEDs.
>>>>
>>>> green:user1  default-trigger: heartbeat
>>>> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
>>>> green:user3  default-trigger: mmc1 (SD-card)
>>>> green:user4  default-trigger: none, panic-indicator
>>>> yellow:wlan  default-trigger: phy0tx
>>>> blue:bt      default-trigger: hci0-power
>>>>
>>>> So lets adopt the same for Ultra96, which is one of the 96Boards
>>>> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
>>>> consolidate only User LEDs.
>>>>
>>>
>>> Hello,
>>>
>>> Any update on this patch?
>>
>> I am still waiting for reaction from Rob.
>> We are keep trying to keep backward compatibility and this patch is
>> breaking it that's why I want to know DT guys reaction on this change.
> 
> dts changes and backwards compatibility are ultimately up to the
> platform maintainers. Your users can yell at you if they care. I only
> ask that changes that break compatibility are documented as doing so.
> 
> Personally, I'm in favor of this change. I'd rather seem uniformity
> across boards and this is just a dev board and LED functions won't
> affect booting.

Ok.

Then please fix the patch and do it in a way

label = "green:user1"; /* ds2 */

ds2 reflects name on schematics.

in ds4 case default trigger is changes to mmc1. It suggests sd/emmc but
on ultra96 it is sd slot and wifi on second slot.

ds5 - linux,default-trigger = "none"; looks weird. None trigger should
be simply ensured by removing that line.

Thanks,
Michal
