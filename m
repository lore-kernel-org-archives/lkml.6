Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B8FC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 258F0208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:18:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="bhiTl94v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 258F0208A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbeGaN6J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 09:58:09 -0400
Received: from mail-eopbgr710040.outbound.protection.outlook.com ([40.107.71.40]:62627
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731812AbeGaN6J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 09:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11gx5+yH8lb67slXPMKqil73fJxpi6PKtLAu/t/Ku2o=;
 b=bhiTl94vlZm5hFgmpdEbZp5A47+qIcBY530xw8KFzQPAI8kOImOl2UUHW3f/Vs0weUauuDCXJVMC4rTpt5Z0XE8GZT2+LNElZgsV8egbkeUKRrI/kKyXboMoSIiWO+V03rmies6xTEye69IZZalsUBIgk8+4yXUo6omwveAQRIo=
Received: from MWHPR0201CA0095.namprd02.prod.outlook.com
 (2603:10b6:301:75::36) by SN6PR02MB4335.namprd02.prod.outlook.com
 (2603:10b6:805:a4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.995.17; Tue, 31 Jul
 2018 12:18:01 +0000
Received: from CY1NAM02FT006.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::205) by MWHPR0201CA0095.outlook.office365.com
 (2603:10b6:301:75::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.995.16 via Frontend
 Transport; Tue, 31 Jul 2018 12:18:01 +0000
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT006.mail.protection.outlook.com (10.152.74.104) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.1038.3
 via Frontend Transport; Tue, 31 Jul 2018 12:17:58 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:59433 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fkTbB-00070I-7C; Tue, 31 Jul 2018 05:17:57 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fkTb6-0004zJ-3X; Tue, 31 Jul 2018 05:17:52 -0700
Received: from xsj-pvapsmtp01 (smtp3.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w6VCHf52016962;
        Tue, 31 Jul 2018 05:17:41 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fkTav-0004yG-Hd; Tue, 31 Jul 2018 05:17:41 -0700
Subject: Re: [RFC PATCH 1/2] ARM: dt: fpga: Added binding docs for Xilinx
 zynqmp FPGA manager
To:     Nava kishore Manne <nava.manne@xilinx.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <michal.simek@xilinx.com>,
        <soren.brinkmann@xilinx.com>, <atull@opensource.altera.com>,
        <moritz.fischer@ettus.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <appanad@xilinx.com>,
        <chinnikishore369@gmail.com>
CC:     Nava kishore Manne <navam@xilinx.com>
References: <20180801100457.25614-1-nava.manne@xilinx.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <63c5cfb5-e36b-86b7-732e-c37fe47a7fec@xilinx.com>
Date:   Tue, 31 Jul 2018 14:17:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180801100457.25614-1-nava.manne@xilinx.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(39860400002)(346002)(376002)(136003)(2980300002)(438002)(189003)(199004)(81156014)(47776003)(58126008)(110136005)(65956001)(65806001)(8936002)(230700001)(106002)(316002)(229853002)(305945005)(31686004)(217873002)(39060400002)(4326008)(6246003)(9786002)(5660300001)(126002)(2616005)(81166006)(65826007)(107886003)(2906002)(186003)(6346003)(77096007)(50466002)(36756003)(2201001)(53546011)(106466001)(486006)(426003)(44832011)(6666003)(446003)(356003)(336012)(476003)(478600001)(8676002)(36386004)(11346002)(2486003)(76176011)(23676004)(26005)(64126003)(63266004)(31696002)(107986001)(921003)(2101003)(83996005)(5001870100001)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:SN6PR02MB4335;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:xapps1.xilinx.com,unknown-60-100.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT006;1:XfOF+f4S71WCgOwt1oXlFCl8uLmuzb/uwH/9HX5DMagqM5FjUVrXFp7fH3n4pc6W+hf44amsjmURdsZPX0stHX9D8oADjINEST42JQ6GDBzXDPNf1ZUSyK3vFZ/X0AOT
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 93a42dc2-273a-489d-a962-08d5f6dfa8a8
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(5600074)(711020)(4608076)(2017052603328)(7153060);SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;3:EXJOn1F/ijpYUy1pQOyUJeBQyaA0H+IJoQXZEBvzBul8tHQIYiRpvzjO8ljcyxbG48u7hSDi92PfKZl1JhMNEwvMO/o9DpQ6b9vBoVEq29WNFd7Gkz+gnjDn1OPYvlVVlbS8zA9NCUveyEIuEkQ4t85udPBiiDhPvtqzK5X0MEgHov57d8EHkqth9rHmPfIt0RazTetROWiSbXQFW7TE1GmPEKXEwG+QLoJ8ymlEs0XFMWBbXQRU1nGLk5IsiTimos3yAIgFm4X+hKO3yeNg12mI5Ja3Re890oawmPd2upkpEJA6CS2etd36FJNzrYt5Xr5H6xm2WeIWM/dQitjv6KMfmzCSWyw/ivkeWHrwbTw=;25:R/ehe9YwUT0oLCmA5nYZpISjFEHfrWys8O0A1GnTpevSP6mzIQw3sYkXoAM6TPvFPo6UMFXHNLsh9Zz4+ZLROajtpUwbdpyGXznwYQvztvSxIPiLKwEqUNMmKA3VE1x/0hTba/IV0RvFiOQUStuAsdLfm6omnFC0MO041UtLrzVU6IZfHWLClV3qTIPPxirDRJBMzxeZFst0nvddXHxT7UOAGUAW6E7AQ0J326fbh7nx3hJmuTw4HLYJ+xlHbrnkMhTyzpvcpii4GoHFrw8la/WckuSEJqqfGRmQZjhxCZV/9J6DUmvYoZWkuv+vP3ou3lo8Eo8FDp0MiXbHTc/UUQ==
X-MS-TrafficTypeDiagnostic: SN6PR02MB4335:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;31:P4PT2UwHd8/qrz0BUBmV0bBwbSBN7ng44I+ki8sZFdPA1qyuaSlNymc0hpQovwzVme5UhdDAgvVw2IYe0kOomb+rJsWGdFejAhaqi4WUuEU/ZDUQIUpdXUKe4GfY/FmILTYxIFeJk9HNqswYG040QpGDvyAe/bXyLWSmUikta+SatyOtFXQTJ4f2CSjMBTC02i0ZL21AT79RJyuD1H6QX1WeG5yyRpKjot1jKJ7FgfE=;20:Res/6qvbLo3Jg8fHqpdSpX28I8+3n3Iw9L0WKhAEuiqFEceevU0pHMQyxv/aFZyCNQ/9shauQ+pnNuJirmOJiTAFT1CaDoWT+ZzO9D5phieD1H4k0psTpb4dgEZxTKDisNw1wFcsLwOu4ajSHKql73Ou+VCbE+A1Y2RBPld2l33nOdAGNcWhbWBGDe1dPR1R1IEQUcWSHo37EtPQ1XTriNQSGR3dRTepcIu9x0B6cfwIVjod8wIulcKiFCWbwPHZZyLNuPEXpIxbQ0sUwz0BhakNylp+2kPbAhFYg4JEZcfr5lyeiE87U7wAJZ5nB/Hw1CifaE065OlF1l7HeiuwY75wSc1yRQmOIP35p2GXj6oii/b/kaSM6BX/H/znseu7nc5NJfM2pNsaakIjlZEa4hCUgWmNCz+RmHHtzpGAqf5mz9garqKhJTZNhH9UwH+KwVvwECmTMsY2q+ga5CtMnILj/b+wm320aTZEcSbW7Qs1WwxRhoqSFQlYumTUnZl1
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <SN6PR02MB4335935FCA78654FEDCC7FC5C62E0@SN6PR02MB4335.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192813158149592);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(3231311)(944501410)(52105095)(93006095)(93004095)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123560045)(20161123564045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR02MB4335;BCL:0;PCL:0;RULEID:;SRVR:SN6PR02MB4335;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;4:Z3v8qUcal4m4E0w9eO64FVzpnM/sy1JVaLlJmQlL5Ws3DpoNdpHFRUD6cUSKQLFe5xIGQL9hAOnGZbbdVQ6SDv2GS9GWX8tQfRCzjR4RWQ/eCiBxp/AytL19cvtqe2miFw1rx2NWXe0sBo/5IZt9nKt+C5C+ERIQWGQj1sHmhrnAbgtPNHIPGoGxCqeJhSl486trCBZ5Upv2Ey5kn970k/3+IJG59cPGASPOmX75MN1XPmZGJb+pJwqI2XML0gy3MNCUS6nswQof3wxVHOragkgI4qwxCwKU5mXmI6sEuADfDuz5EAokiLtZvcBcyggG
X-Forefront-PRVS: 0750463DC9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjAyTUI0MzM1OzIzOkcvSW9lMTI2eUIvTzQ5YXEvMmhvQnpUaG1M?=
 =?utf-8?B?cCs0azNub1NaRnU5Q0tJWXBlb2p3L01ZUUhLZlhpeFY1MEhYamNSRm91OFJI?=
 =?utf-8?B?bm9STXB4Y3duYlFkazVpWDlianRiUGJmeFRLd1pON1BtZ1VibGRLUDdITVI3?=
 =?utf-8?B?Y3RPY3FXbmhMM2IyZEpmb0JwRTFyelpPT3BsWGVJc1A5M0pMU080Tjlub1d4?=
 =?utf-8?B?UzltMXJMZnR0NTB0UHBtbVRLV09jZkxmSjBUbHFaZkc2bzNrYlJiOHJmNC8v?=
 =?utf-8?B?SkhLK1JCWXNuczV4d3RTdkxjL3dZNWtwN0NHYkFvKytONVlGV1pQRkJnY20r?=
 =?utf-8?B?eWROQUF4WjE2Yysvb29NYWR1Ym15N2tTU1U4OVhUbWN3dEg3NFpJTUdac3pR?=
 =?utf-8?B?SXp6LzVVbFdaQVFOaVgzdjBEZTNkZExnS1ZLVlpnUWJxb1o5b2hBWXlwVXk5?=
 =?utf-8?B?Rlp3TnhlOHBCdS9LWm56SlFNbkJSS09JeURsSWszVllKVXIwM0h4M0JESkxk?=
 =?utf-8?B?c0dOaW5sa2w2RzloZHF0NW44SDlnZXJBSm1wbnhBM1M0QnJQZERDalRoMFJn?=
 =?utf-8?B?Um8xd3ZqWklaanFLRW4vRXBhUWFDaUpaZnI3L2FZSjNELzV1eTI3cDFzbllM?=
 =?utf-8?B?NTk1OEJPMG41cmhDc1ZaR0Q0ZG1LYkNVbDZWSkEyUkpvaFlPZlNKTTZXd0cv?=
 =?utf-8?B?YzBDWU0wcjVjTThKWUxCR2dmV1ZIRkQ4STd3UGNkSERlQ0xhTkQzTm1LbTR3?=
 =?utf-8?B?TngvRUtOOFp0ZnpRY3pvZ3pQZytvMTE2YzdGNlNmdFV2V1poYWVhZDRLdzlB?=
 =?utf-8?B?TXhCRE1UczlwTGhCZ1cyM3h1dC9rNnBrODl5SXUzSE1QMStDeGcvSTZQdXhC?=
 =?utf-8?B?eGRicmcvVlJVeE94WUdBWk9Ld2hvVnpoTWRNUVM1eno3NFJ2WVZMVkNuL29P?=
 =?utf-8?B?Z1dERHY5emNaZVlOdjhFYUJsdEZKMTdybWl4Y2tLVnNaVVdKYmRjNkx1S3JP?=
 =?utf-8?B?T0NSUE1CaEo4elE5dVp5VmMzTWFWNUVZZ2lQdjcrNENBaDFvUkNhOXZBcXVD?=
 =?utf-8?B?NVlSb3pJUXBUZjhONy9NVnRENmIvYUNtNGV6ZEltcWJwLzh3eHUzMEVObFpv?=
 =?utf-8?B?N0xKMU15dTU4S3dnb0VrNDlFVmQyUG9yUkMxMmFNZEl1d2JrbGE3aVJIdFp5?=
 =?utf-8?B?SGF1ZTdibUdWZ0YyQmczbzBWR200SitNbXUrREdkS0NjVHJqZTU2WWk0eENt?=
 =?utf-8?B?MUVSZEVYa1JmeHBra0hnWVBTSnFJRkE2c0QyL29DOERrdlNBK1Q2aEJIUldW?=
 =?utf-8?B?K0FQUG5nNU9XQzJaay8vd3JzdHNKNWNRUElpenVrZmdaWHJvTVBFRmVmcUFr?=
 =?utf-8?B?NVYzd3hBL2RGZGUzZG1UOXl0VnN4K0JhWFp0TjNDa3dTcjBRS0pkbFliZStO?=
 =?utf-8?B?bTdSVnFLMTliMWxXNHErRVFsQXdOeE5mOUxwUFRzNk5NdlVyUjdZeDJZdFNU?=
 =?utf-8?B?bFpCazJ3dXdTalBka0h5WCt4ZUhBRVdzbHVsVTd2ck9xTWMrbFh1WGVvSXFj?=
 =?utf-8?B?M3pEUzFyVk9iNzRaVER5aG95VmV2R1cyME54ckVZOTZhczJUZDZLcDhoUGxh?=
 =?utf-8?B?UzYxRVZQeDMxOU1Qdmhma3NpWjNqRy9rekUrWnhWcmg1NnlrZ2RMZVZKRUdk?=
 =?utf-8?B?cXdqNWJDMElLSWJ2T3NMTmhMNXp2dlpyQ0k0Z3RPKy9TQ3J0V0ZobXN3cURJ?=
 =?utf-8?B?anMzSm9LdHNNUFZVc29HY3hnT2huV2lOdWJRemVzS3hSUlBvL1FNeEllWUNE?=
 =?utf-8?B?T09KL3FqcGRBY0kvV1dZbmZiNkp2SWNPMFFJVmxjRU0yYkM4bjFvWWQyc0Vv?=
 =?utf-8?B?em1HYTJhVThUMmNzbGpKcGdIb0FrU05Gc0pFc0VpVjI4ZXlpeGNjQnBmbzVJ?=
 =?utf-8?B?dTNrWmFXa1BTOWdXWVJsWGxYalJKSlROdkU1SzY3a3ZWd0VFb0hwZXAvVUxN?=
 =?utf-8?Q?WttFDd?=
X-Microsoft-Antispam-Message-Info: E96OEbzFNUobT/YqzY9i96+l2ytaPPqF0to6lq7tbg8hOOeVE84rQmYS24Fwi8NSjFrKZAfw089cdQSP20cLzlylEtb3dRSUmpbAeeVIegnn0IIBwHN/Kzz0I5ICUOFpeJU0B4qaoGJns5SHXW9gF9HWGyTh6i1MimWLus5Mq9J3lHj9kc5xVMfnWI/AHGaapstQgXE9bCYP28lPkf7jxtAH3zlzY+AnIT8Ruvk5SGImBQtl6bJMvNhyXLCPcD6bptVB1Mua1g8walhrVExw1T96Qkx0It03gWWET3b9tginjK9ELnaLB0TpxCEx4ER+Rlcvq1DOc0lvZF7T0FjjyYBPxAYAGvpLx+n1MpzakbA=
X-Microsoft-Exchange-Diagnostics: 1;SN6PR02MB4335;6:M9gSFjrDRwLOGnKLhu1UIO7L2Z9qyAB/3BgjXUCoWGah4aO1GYDXEEuYA22fM1PPoR0Pl3baog/wWu5BXAPu1//JSSAcHvnadPAUMgIBwFRes+SR5ssBjUVPTpvY63IbmlYfe0HMNTj6XKM8RiV34QFzeb3Sm4M5hHpGpY81hAkqAfcuVzEfslCr2s9bV6h1GGEY4tcSfChSs9wf+GDfVS+0uW4iA5kkW14lYblRL+/1W6f05sySGpVPBOidPNaRnfj4HxXY0FX20nm5fikxfH4zLIk3/sq7w0DBI3lLBkMe0rIaOong77o1ZRnFaFXDVjItxofkskcvFSTXcbokz4iXMBHMY4mDKDGjxvr9DbTRtlAocPMIkTj38KduQ/WU+A6iYTRmwiGRKEHahlzKC8aVlUeC/JdP6SMSfzVz8VhukMMhgRvonTMtZmOn3P6TwmvFBedJhE01Uc8A2SnhmQ==;5:gXP4NwjZxGYtzooOImOHsHrmLT1jzRegegkFjb4b9tOrNMi7535yOuEyKWkHf3+UjvhxE/RrzN2jczI7hhpNk3R/Fp8PvqJETKasNKKCTBJGKOwyhX5ifiQ0XyM3r09utMZaU/YWZCZKa2gDeoDr3zZwye2ykyYlEWjw8O26P6g=;7:IP74FMspzDDtGJZptaWue8MEoefii77D2VtBZuq/Daqw7oAoeJBQhIrAkYjV+4Um9fVdkfpXNarhEVUmB3HJqgh3mhIaKntHFh04tVoKHuyyKHk7Ocuk446GWqK105EfRVow+isHuKX3m1TO7yAGP7JsmbrYQ2fa9f5wHNZiLJYzyoeuyZ/A06NbI2U/4ekdZPZ4fvNc+sZvWEpGIiI4MAaqPZcm8aUrazf700oOsMxpyDfuWYyFUcOKun2M15FJ
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 12:17:58.0714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a42dc2-273a-489d-a962-08d5f6dfa8a8
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB4335
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1.8.2018 12:04, Nava kishore Manne wrote:
> New bindings document for zynqmp fpga manager.
> 
> Signed-off-by: Nava kishore Manne <navam@xilinx.com>
> ---
>  .../devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt   | 9 +++++++++
>  1 file changed, 9 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> 
> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> new file mode 100644
> index 000000000000..0eac747747f5
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/fpga/xlnx,zynqmp-pcap-fpga.txt
> @@ -0,0 +1,9 @@
> +Xilinx Zynqmp FPGA Manager

This should be ZynqMP.

> +
> +Required properties:
> +- compatible:		should contain "xlnx,zynqmp-pcap-fpga"
> +
> +Example:
> +	pcap: pcap@00 {

no reason for address if there is no any below.

> +		compatible = "xlnx,zynqmp-pcap-fpga";
> +	};
> 

Thanks,
Michal

