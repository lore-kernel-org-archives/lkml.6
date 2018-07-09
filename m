Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47DC0C6778F
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB66320875
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 08:19:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="Iww6fhCk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB66320875
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=xilinx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754426AbeGIITA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 04:19:00 -0400
Received: from mail-eopbgr720086.outbound.protection.outlook.com ([40.107.72.86]:35084
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753933AbeGIIS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 04:18:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector1-xilinx-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h1RTv4bujshNhP9C8CH72L+rqD+OEbaSSfY3ZgpRyZU=;
 b=Iww6fhCkKHUI+JhY2szZO/wPUvi9VkKb7bJUU1+vmWHE1+ZPYulcNPB9wlD8QFbaMz5bpSim559n1Bn+86tQyT6urCOaVUXJQfDL7eyhmlKupB90of77b9+MFQ94s6qhQ3gCCzvljmnRGMzPWVfrpkxPNHNJxAeiicfTaSP/na4=
Received: from BLUPR0201CA0041.namprd02.prod.outlook.com
 (2a01:111:e400:52e7::51) by DM6PR02MB4459.namprd02.prod.outlook.com
 (2603:10b6:5:29::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.930.19; Mon, 9 Jul
 2018 08:18:54 +0000
Received: from CY1NAM02FT060.eop-nam02.prod.protection.outlook.com
 (2a01:111:f400:7e45::203) by BLUPR0201CA0041.outlook.office365.com
 (2a01:111:e400:52e7::51) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.930.19 via Frontend
 Transport; Mon, 9 Jul 2018 08:18:54 +0000
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.60.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.60.100; helo=xsj-pvapsmtpgw02;
Received: from xsj-pvapsmtpgw02 (149.199.60.100) by
 CY1NAM02FT060.mail.protection.outlook.com (10.152.74.252) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.20.906.15
 via Frontend Transport; Mon, 9 Jul 2018 08:18:53 +0000
Received: from unknown-38-66.xilinx.com ([149.199.38.66]:49136 helo=xsj-pvapsmtp01)
        by xsj-pvapsmtpgw02 with esmtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fcRNk-0007iw-Sn; Mon, 09 Jul 2018 01:18:52 -0700
Received: from [127.0.0.1] (helo=localhost)
        by xsj-pvapsmtp01 with smtp (Exim 4.63)
        (envelope-from <michal.simek@xilinx.com>)
        id 1fcRNf-00066y-Pe; Mon, 09 Jul 2018 01:18:47 -0700
Received: from xsj-pvapsmtp01 (mailhost.xilinx.com [149.199.38.66])
        by xsj-smtp-dlp1.xlnx.xilinx.com (8.13.8/8.13.1) with ESMTP id w698Idd2020147;
        Mon, 9 Jul 2018 01:18:39 -0700
Received: from [172.30.17.111]
        by xsj-pvapsmtp01 with esmtp (Exim 4.63)
        (envelope-from <michals@xilinx.com>)
        id 1fcRNX-00066r-CC; Mon, 09 Jul 2018 01:18:39 -0700
Subject: Re: [PATCH v2 2/3] dt-bindings: xilinx: Add missing zynq boards and
 sort entries
To:     Luis Araneda <luaraneda@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Simek <michal.simek@xilinx.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180706060158.24155-1-luaraneda@gmail.com>
 <20180706060158.24155-3-luaraneda@gmail.com>
From:   Michal Simek <michal.simek@xilinx.com>
Message-ID: <1088d908-eaa1-78a8-f1a5-1a7d82eb5afb@xilinx.com>
Date:   Mon, 9 Jul 2018 10:18:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180706060158.24155-3-luaraneda@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(396003)(136003)(39850400004)(376002)(346002)(2980300002)(438002)(199004)(189003)(110136005)(54906003)(2906002)(58126008)(4326008)(6246003)(50466002)(39060400002)(5660300001)(36756003)(316002)(36386004)(356003)(9786002)(106002)(186003)(426003)(77096007)(26005)(336012)(478600001)(64126003)(47776003)(2616005)(446003)(44832011)(2486003)(476003)(23676004)(65826007)(126002)(8936002)(8676002)(81166006)(81156014)(486006)(53546011)(14444005)(65806001)(11346002)(65956001)(6666003)(230700001)(106466001)(305945005)(229853002)(63266004)(31696002)(31686004)(76176011)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR02MB4459;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT060;1:56xHXjHTZLwJkWrd8W1Wn3tCywvYdJmXH448rziITLUGBaM86n7UrKvqLUJyIVBmNIAnvLa/QQmOP7KdMdVkVBDSlfonnt+aOGkJYio70Sz3coJK6UN3BeikEyqRd5Tw
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 51146fd1-61f9-4461-869f-08d5e5749bea
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600053)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328)(7153060);SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;3:/x/oZAkEp+btbVxELYtD4o7GHWSjyvXqlaALCyxHWksPeVbvwFK8q3u4oeCI2gtj2Njh9wjZV4OSsjPHfjOvj8zjIVnyQesugoza7tXwu/DnOYw7eRzPhkDiD6L38BGWS30SnZxgSZRaVWUyegT2++B9XoJ/cIsxebrRvtK5poMj8/UFgznHClXEDvWhu4gp7cDyxrUXvOH7M2Bm1gfhj7nnacJBkp0G4Fl2jVtMxvMFMOmEGns8oUTs4byGQoOjY5h2m0ONVh2gs3e46zxKkjkj97rEhfm0rBqRMjAxUwxotRX89I/fIJec+qftuk4rtfPNigVjNxvud2ANCpmeve6HcETXCBCjfxAo+K9vEEM=;25:g1oHTVPDJVf/tCM8SRivq40GZiJ5sk2HDyg5B5tATuu4BQm/ufpiZw+qPUY942aetH2+HI3S24zU7Ami56o3qRsw93U3jkL3ARTzHSUh2BocULuhwK0QiJsErz4C0UpskNIFFpyY98spGMRks0yZX5ALAEcyWZ00zfDmy+BgRzT14RcchM/4QmoTdZKu60R+N/A5W3YH+dVJpO6Go92DY9UKePXYlI1R29ZBFeSxz0hc5Pr25N4w1k9lRIlZlwtWr6zDJGWiMZlZIi/vAsb34PYc+ekEtzQJZX8nbVvBxZ5n9Hln0NdlozuH4irOj0yQ9n5RFLSgOtH6LlRGvqtN/g==
X-MS-TrafficTypeDiagnostic: DM6PR02MB4459:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;31:CT3hSJouL4VPxo5medkUCka8Xnup9dfikX2qlCUa64wYq6Oj73Tp1xcSyyM/vGJqilI631qJWDsZdBLlc4WNAj39A9IICCW8lK+HmWfJcsYxXdzqIELcGa5Nf6O9LiGxCRy039J7vqDBxYqRFE+Yz/zp2NMV6z+9H1ZkomaSSQQtbnTVOy6a0O+oTICROfv7yJeQ3LF6uiDUkKHxelQAyHG1xlrjf2hp8GdOgYxG4bQ=;20:uzP091nsPefon5fPzn5ITf1fIGeyKgKRJYQ6RQU5s+AAuvw7NSeKjbYUlACseENpWwDba5J2xhpvTHWU5aDT204R8vThI0kG/1QxPP4tpkhN9G8QJlk5xhf2GqKZ8yGJZRS7uudZPn7YcPyCJtST2fXG9+rIpXuGu4EUJdj6A7q1GXD+Wq+WmuZU30CCfHfpj10g+InGPgsL2m9ytfS9DCdNb8Rwu6kBzgOxknbqA8JmltgjY8ab5QXJfsgvG3Hg/NZ2Ouuau/hHZEGLh3W3R/doSR+XgEBSBobXGwNuAag8YwmiwUto912XcugFICdd7n9++VInDIOeiKEYXp9SsgPrX8aslRm90JkIxP/qVbwePOstiO8ArqrAbiHxBa6naJ3a20cUaMeU0vCSSU7wy2nugz4I7rLy/DSm22TlceNFgpSPxiFTANjcAUxG6+S9ez4om+QVqsBNaDGH7BwSFQqTn++zlPFuAt6CayUtxLs6UnmYRExm/0zMn6Dc3SBU
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-Microsoft-Antispam-PRVS: <DM6PR02MB44591096E948F55E21C06442C6440@DM6PR02MB4459.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(85827821059158);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3002001)(3231311)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:DM6PR02MB4459;BCL:0;PCL:0;RULEID:;SRVR:DM6PR02MB4459;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;4:wgXfK/T1wEh98X62t5j/Y3iqKTMoknc2pnC2VinakVCXY8yjumOrUgl0i1bItzUaazWUTFt5Z3lbBukG1GEGXPh4EyhJXMumJbpH493zQZ4nGMM/pvxOQsjNW5XqtiAIH93cJbJWu7DbME+QkiME08mLqPTyLVMHYGItfdLnvLvwzqPYMSpen7CRHLR98zUMwLYkjweyVbXF8zI83CYy7qTCa9t4UsWp0Nu3ta2xr/oBJDRxr4cqHwt2wgSx4FfaG+EHkSVvyohTra5OdeFby9E0R97hI1sUfC/oV0VwvGFadFAVQN/3hTofL4C7aE03
X-Forefront-PRVS: 07283408BE
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjAyTUI0NDU5OzIzOnhEVnZmcWFucEdZalZJMUMranNvdHhBTUpm?=
 =?utf-8?B?bjNzNTFmQ2NIY2lmV1YreGdPWmR4Uzk2Vkh4TEhvWDlWVGxsd2MyZ2l6eVIy?=
 =?utf-8?B?SWNVOEVYc3FLQnNqQ3U5bFljb1ptNnE0TUw5SUFCL1ozNzgwbmdhejQxbDlj?=
 =?utf-8?B?R2hENVVNQm9BVEI4UFN5VnNJYmNlb3NTcU1QLzhIVWpSaVo5bmx0OEUwamQr?=
 =?utf-8?B?VEEySGZzN1N3ZFNXbWsvRXN4eUZmVXVvZzhoc3JYTi9rZ3kzN1ZTYjFob1dj?=
 =?utf-8?B?d0NEWWt0cXNDeW9GaDVQQm8vMlplTXJNUVhpankyalFVZW9SRk5ObU85WnYz?=
 =?utf-8?B?bWFrU2VlUXV6ZEpyOEtVQ0poRjF4Y1IxYkhrQUdSTDZJeFM1MThHWnFJUkZy?=
 =?utf-8?B?bVR0QU1XaUgxNWtVNlU4MUdJT0lwbjlld3RTeHRYaFEwcVBtNmY4dmxxNU15?=
 =?utf-8?B?ZXdEKzBVdjZGZ2V2TmJUVVhWZmJVTUVZYitzNDB3VjUxQUVveTdvYzVsUzZj?=
 =?utf-8?B?WFBrQXRIY2Y2NThnbGl2Z1VTVk5JTnl6L2IxVjVsUFFiWVRJZy84ZmdBSGdo?=
 =?utf-8?B?RWx4Qm95UlJ2NXVHR010cnRHeW9qZXlyUFp3STQ1NjZ5RzROalJWWllzRWU3?=
 =?utf-8?B?TUlRYVhOcnBOaEpBWnZ5MitUenlMdUxmaWJDckpnS09rTWlNVTd1ZXBYYTdH?=
 =?utf-8?B?WXFrV0xUaWduZGplTWlFNlVkb0hlTDJ6TzZiRG9URlVQNnR5R1BITUtYeXpG?=
 =?utf-8?B?SElzekZSanRDdmU0NzBhTnJYQWJBSWRyWnRpZWZkaGlSb2NsM0drdzBHMkt0?=
 =?utf-8?B?b3pid3puSCs5UDVqeG1KTXR6SEZIRFNmaWJPV1RIWTc2YnhWYnkwMkgxNmFR?=
 =?utf-8?B?WHpqaEwxNW40UHp4MWdwNjhkV2MrTXppc0xaYWR3VWg0ZlhDR3dlM1pJY2xM?=
 =?utf-8?B?RE10U0FLQUNyMks0d0RoVS8ya1NNdlFkeDBIWjJQWkI1Vk0yZzNhYThFbk9R?=
 =?utf-8?B?M0tlM0FIb2htMDlPc3FMbTNQL3NIOUZOVFErT2hJV2tld3FYWmFrVFo5MFNS?=
 =?utf-8?B?VjVhRWd5dGpIckxWbzk5cm92a0ZuZ09aRVE4aHlVZWk0K1liQStJdE02ZmZT?=
 =?utf-8?B?NnhiejZHYTBKdDdVdVBGVXVIaEtKall5WDkrVXNQOUdaM2JuSkpxZXdCclB3?=
 =?utf-8?B?QlJrdUlydndXYm9xMUV6Y0VYNVFmOWJ2RjRBb1UwYnhMTTlFeldYVzVsekpB?=
 =?utf-8?B?aTdMdDdUckhBZloyc1hDNU1wYU93cGtoRGN4Q2l5WU0rVE1NZHI2MVhicnNw?=
 =?utf-8?B?dzFnQnNHa2lXZGpJZloycXZzcjVsUU5wWHN1cjRPRU56NGpIcFhLTzExRERy?=
 =?utf-8?B?Qzd5S2RXWkNwU3VMdFYwTEQ0V3IreG0yZFpLcFlFZUpaM1lsVWc1eFRVaDA2?=
 =?utf-8?B?TWhGZkZBcFZjaWYyOUFrSlBTczlrUHFqakV6aXNvRitkMENFZDFuR2p6SVVF?=
 =?utf-8?B?OWxsVXdaMkEvMjJIbm03V0RLK01CWkFxcnI4aENQSnFZOStDNm4wNWxoYU16?=
 =?utf-8?B?NzRaN2Z1SUJJRUxzV0xRSWZhaTRWY2RwTHRCSng4ZXcyL1Nub00zUFlkTXZk?=
 =?utf-8?B?L1JWSVRTWDhTMjhZeWUyYVBuZkVyeFBmNzdYVGdQOVNhL1krMmdCMWdCS3NQ?=
 =?utf-8?B?dHNFQzFSSVVSQk9tY3BubjRINlVSbVA5NUxvTTNOMEJuK2czclhuNVZvY0pl?=
 =?utf-8?B?bG11WkwrMWJtbnpxeWxHYkR2V2s1RnZtQWNwTDVmTmlaR3BRVkNGS1gwS0th?=
 =?utf-8?B?NUxHTDF2TFBzTFNHbnFzVnliR3JhdnUwMWpHb3pTTXdLU0E9PQ==?=
X-Microsoft-Antispam-Message-Info: r9xKs8UEY4CG6m6IpU6P7iByrhvyBLHCv4Ptp1ECfqhfY6a7Bb4X6L+LtZ48CKUB/D2sq2+Ew/HV1twY3R62x1056UDk0Yzs1/EneYUICgJosZyZPx4HIe9LpksHOKgrZIyKUbqVDzvzt6TFkePwP1sYKt6NrsB1jvJBSb0S5mZVqll5r0jPOU8J3GeNgtr9ZIOYPUT31Su9Kch19GUXwiy/VwR3V0Ji9OPxQKci7cSuAw6xGPWehLD1V001US17GQ03ISTBAslqrkPS8O4cJTs/WHNtGwUpI+A//SRKNa5YaxtMP0uPaKR2CEDlf8vfamCnIKWtKALrSp6B9mPLEY99uL+dUmNmFe3vFX/sveQ=
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;6:r43bC6XGehPmR4rhxq4pOB1wRiijwMzDgbFLr+j5b3t7kxSPgDf6IFZ0Dthy0Gj29MpwE+L5ssqev4NzwzVhNMjwU6WzPoN4Mr2LSW4K+V1g7LN0Q/GJyEz7QWK/QuM3LllZvs+6jol+J5dco3OV+7LtGlcejszMu+sRZo7/nUnY5sq5PZkXRct5SvHczcHUGVPnO5gyuVBS4DgQvxRP8+dYgJP0rU8V/soTEQK26H5oGSyMLxtysHEDDz5R9xpuRpmMoTKlAccNMmXE+0BBonWBM7wglDA9iajsYBVFruTIVna82xkiN4q2zHbva/HjwfjqO4ZLeLYUyrBlwU44eH32Vv+8kGDYBYGUvY+/tzBOmyYPd4bVZcpxNLnIbCZAovGmV2fwgIrhQI7CS8Mg5v1pz/N/Mp48Q7X1YoZdwf3Gwb/jkfmOB72As7GBRTPto+a1NJ1sTH3TPnsukXUuqA==;5:lsoiqWlhM5v8SDSH6glSCwF2ev0vXgd27S1dP2blGgTQdNd3b8QqBxZ8H4ypCBdPP5431Iv0LoafNmrubVs5Zvb47pd1ZzgEy/NTiekPZwIvwWQnBRXvPu08n6fiBM+DhQ6d3a2QiwzcWj2Ffektm2On/KuUzHaZWN+YWVfW9nM=;24:TMzpflcyhwMH0rUXFr6/59f/OGE1yXFRTJ/LnXFcj/qOM6Mhx49PqwgLCto5NU/7wiXoblASZW/ac7bKoHQ/cyuN398CYh+43LvEeilbTW0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR02MB4459;7:kk5XGji6sADddfliwfdaYMcpVefSHZKUT1Ut3V5HrnnhE0aGNBKmR0Fp3sQnd0+RUtUVWQ0B0UwCtZztLr448j63IXR43CgegwqdTVeZftxJoDuGCzps6OOyF3gkGaCrplZcn6SbkBdhoXFVMJUO3Zpu3SaEQ1kt31oviPv8EFGHS6CPRF6VsqbUNIaE6Cdc3miALycw8PTjhi+FPheqV7mE54K9gc+uILKcJLqICueeeRBCVvg3ZDvXUvhw8+Mr
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2018 08:18:53.3536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51146fd1-61f9-4461-869f-08d5e5749bea
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB4459
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.7.2018 08:01, Luis Araneda wrote:
> The bindings were missing when adding the device-tree files
> 
> Also, improve description of existing boards, sort them
> alphabetically by manufacturer, and migrate the contents
> of adapteva dt dindigns into Xilinx's
> 
> Signed-off-by: Luis Araneda <luaraneda@gmail.com>
> ---
> 
> Changes since v1 (RFC):
> - Don't remove "internal" word from Xilinx boards on dt-bindings
> - Migrate content of adapteva dt-binding file into Xilinx's
> - Sort additional compatible strings alphabetically
>   by manufacturer
> 
>  .../devicetree/bindings/arm/adapteva.txt      |  7 -----
>  .../devicetree/bindings/arm/xilinx.txt        | 30 +++++++++++++++----
>  2 files changed, 25 insertions(+), 12 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/adapteva.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/adapteva.txt b/Documentation/devicetree/bindings/arm/adapteva.txt
> deleted file mode 100644
> index 1d8af9e36065..000000000000
> --- a/Documentation/devicetree/bindings/arm/adapteva.txt
> +++ /dev/null
> @@ -1,7 +0,0 @@
> -Adapteva Platforms Device Tree Bindings
> ----------------------------------------
> -
> -Parallella board
> -
> -Required root node properties:
> -    - compatible = "adapteva,parallella";
> diff --git a/Documentation/devicetree/bindings/arm/xilinx.txt b/Documentation/devicetree/bindings/arm/xilinx.txt
> index b9043bc35c14..26fe5ecc4332 100644
> --- a/Documentation/devicetree/bindings/arm/xilinx.txt
> +++ b/Documentation/devicetree/bindings/arm/xilinx.txt
> @@ -8,18 +8,38 @@ Required root node properties:
>  
>  Additional compatible strings:
>  
> -- Xilinx internal board cc108
> +- Adapteva Parallella board
> +  "adapteva,parallella"
> +
> +- Avnet MicroZed board
> +  "avnet,zynq-microzed"
> +  "xlnx,zynq-microzed"
> +
> +- Avnet ZedBoard board
> +  "avnet,zynq-zed"
> +  "xlnx,zynq-zed"
> +
> +- Digilent Zybo board
> +  "digilent,zynq-zybo"
> +
> +- Digilent Zybo Z7 board
> +  "digilent,zynq-zybo-z7"
> +
> +- Xilinx CC108 internal board
>    "xlnx,zynq-cc108"
>  
> -- Xilinx internal board zc770 with different FMC cards
> +- Xilinx ZC702 internal board
> +  "xlnx,zynq-zc702"
> +
> +- Xilinx ZC706 internal board
> +  "xlnx,zynq-zc706"
> +
> +- Xilinx ZC770 internal board, with different FMC cards
>    "xlnx,zynq-zc770-xm010"
>    "xlnx,zynq-zc770-xm011"
>    "xlnx,zynq-zc770-xm012"
>    "xlnx,zynq-zc770-xm013"
>  
> -- Digilent Zybo Z7 board
> -  "digilent,zynq-zybo-z7"
> -
>  ---------------------------------------------------------------
>  
>  Xilinx Zynq UltraScale+ MPSoC Platforms Device Tree Bindings
> 

Please do it with more patches. There are 3 changes in one patch.

Thanks,
Michal

