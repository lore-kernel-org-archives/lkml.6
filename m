Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 874FEC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A1AC20665
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 10:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="wgmhEs9X";
	dkim=pass (1024-bit key) header.d=topicbv.onmicrosoft.com header.i=@topicbv.onmicrosoft.com header.b="wgmhEs9X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A1AC20665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=topic.nl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbeJWTRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 15:17:01 -0400
Received: from mail-eopbgr50084.outbound.protection.outlook.com ([40.107.5.84]:42112
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726970AbeJWTRB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 15:17:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JehTtYtVe3CKzt0sZ+P91LfY8vrxBM8hFcgGTxeKLe4=;
 b=wgmhEs9Xnv65bRuxSSPS3tac2Y0Xr1oFkNBntE1liHao6bg7l9eBNhtmx/evHlDoahIPQN19BOG8nya/qaLVKDMIEufq4xhcXiibezD8zkTxmPDLrSsFJWbTJ3e2tdztgBSSb/KaU0J3QZXI6cSpdoiLWdxzaQc25VpoJkuBBN4=
Received: from VI1PR0202CA0031.eurprd02.prod.outlook.com
 (2603:10a6:803:14::44) by VI1PR0201MB2461.eurprd02.prod.outlook.com
 (2603:10a6:800:54::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1250.21; Tue, 23 Oct
 2018 10:54:01 +0000
Received: from VE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
 (2a01:111:f400:7e01::203) by VI1PR0202CA0031.outlook.office365.com
 (2603:10a6:803:14::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1273.18 via Frontend
 Transport; Tue, 23 Oct 2018 10:54:01 +0000
Authentication-Results: spf=pass (sender IP is 52.236.92.113)
 smtp.mailfrom=topicproducts.com; kernel.org; dkim=pass (signature was
 verified) header.d=topicbv.onmicrosoft.com;kernel.org; dmarc=none action=none
 header.from=topic.nl;
Received-SPF: Pass (protection.outlook.com: domain of topicproducts.com
 designates 52.236.92.113 as permitted sender)
 receiver=protection.outlook.com; client-ip=52.236.92.113;
 helo=eu2-emailsignatures-cloud.codetwo.com;
Received: from eu2-emailsignatures-cloud.codetwo.com (52.236.92.113) by
 VE1EUR01FT052.mail.protection.outlook.com (10.152.3.19) with Microsoft SMTP
 Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id
 15.20.1273.13 via Frontend Transport; Tue, 23 Oct 2018 10:53:57 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (213.199.154.178) by eu2-emailsignatures-cloud.codetwo.com with CodeTwo SMTP Server (TLS) via SMTP; Tue, 23 Oct 2018 10:53:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=topicbv.onmicrosoft.com; s=selector1-TopicProducts-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JehTtYtVe3CKzt0sZ+P91LfY8vrxBM8hFcgGTxeKLe4=;
 b=wgmhEs9Xnv65bRuxSSPS3tac2Y0Xr1oFkNBntE1liHao6bg7l9eBNhtmx/evHlDoahIPQN19BOG8nya/qaLVKDMIEufq4xhcXiibezD8zkTxmPDLrSsFJWbTJ3e2tdztgBSSb/KaU0J3QZXI6cSpdoiLWdxzaQc25VpoJkuBBN4=
Received: from VI1PR02MB4094.eurprd02.prod.outlook.com (20.177.58.204) by
 VI1PR02MB3887.eurprd02.prod.outlook.com (52.134.25.153) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1250.29; Tue, 23 Oct 2018 10:53:50 +0000
Received: from VI1PR02MB4094.eurprd02.prod.outlook.com
 ([fe80::c1f9:5583:365f:eeca]) by VI1PR02MB4094.eurprd02.prod.outlook.com
 ([fe80::c1f9:5583:365f:eeca%3]) with mapi id 15.20.1250.028; Tue, 23 Oct 2018
 10:53:50 +0000
From:   Mike Looijmans <mike.looijmans@topic.nl>
To:     Moritz Fischer <mdf@kernel.org>
CC:     "linux-fpga@vger.kernel.org" <linux-fpga@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "atull@kernel.org" <atull@kernel.org>
Subject: Re: [PATCH] zynq-fpga: Only route PR via PCAP when required
Thread-Topic: [PATCH] zynq-fpga: Only route PR via PCAP when required
Thread-Index: AQHUapoLmRCclnn8wkmk7zyT0pifY6UsiLiAgAAfbQA=
Date:   Tue, 23 Oct 2018 10:53:50 +0000
Message-ID: <1781ed23-e03c-f70a-ea8c-3e9fa6eec9d4@topic.nl>
References: <1540276279-2903-1-git-send-email-mike.looijmans@topic.nl>
 <20181023090119.GA2205@archbook>
In-Reply-To: <20181023090119.GA2205@archbook>
Accept-Language: nl-NL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
x-clientproxiedby: AM6P192CA0097.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:209:8d::38) To VI1PR02MB4094.eurprd02.prod.outlook.com
 (2603:10a6:803:7b::12)
Authentication-Results-Original: spf=none (sender IP is )
 smtp.mailfrom=mike.looijmans@topicproducts.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [81.173.50.109]
x-ms-publictraffictype: Email
X-Microsoft-Exchange-Diagnostics-untrusted: 1;VI1PR02MB3887;6:Lw62inu8ke1WFnUhAAWF+tFFrJtLT3ljLlRN9l2FkdJ6u0rbF70DJo6i7SvLg3aAcUL6yCowpfhqrJCWL7iv/iPanTAbUIL87ZnYDOMdkejPTiFOiMFFbaaLAgnhHJcmlTDAGXUZVBeSb6HN4v9dWIDL9q0STVJbOF8MXMWb1DmI/6+/pMPtbMhB1/YehrJfDmweiu//3SOO6xRGpra5g+uR+doxf+7Es5p7g7JjjzXVYblnnMoYdiKiM0/N57QE9EX5DXy7hCmfJBS7TNpk0Ho2qbUHBXDTiFrJFBx9yqXrY9Z0jpB814zFb/YRFEgf2Jv4lCQCnhceBETVwH5V2cJT1QTjF2tWoLGRyuB+H5ak1uDQaUdphxB6QuzATZ8mvohdqe/qv/ISEC6z/ccyqBuhz4qq0vzisIfWTmOfGnSkzWfAmUzOIzfu7ai0mEw+0KnGvxAk1i8SgBiu4pnAcw==;5:7OJhAZr8QOMpDYbAUXLpPwgLDw7PEQjhLkqV1C01WzZpWKa/SLqqy8V67raWwGpreCP4bvTrap8KOeHKBZa5MGaQ59OneJKoOSJegUmNauUoTBtdruYs0mGJrkLPfIzk8XoMIJ4ZrJQzgd/JY4bROtByi+vfg5CuV4e0EpL6ycg=;7:5TtGA9yhJc7UCji193nbkPy0p0SPqmC9z0QAsS13JV0fFUFPVNJGphu5oOTTEnF+leJrhCB5mLPdXW836Zgm827VL1lSSdFLvp2sMoRmu1J0B4Z2hDJ4lXtpSkIsO9hIrOcamFzfIEenieUYNjaORUiaZZJZfzN2RMPspIjPwdMGAf8tSYo473JQNZPJ+H+bOUmDgwoRLzHDrQzjgsNsjC0DO4w7jBWywd/V/Pq5N+1Gan22ORZEDW/qWIT6mVuW
X-MS-Office365-Filtering-Correlation-Id: 01f0ac86-fe76-4b00-467f-08d638d5d73c
X-Microsoft-Antispam-Untrusted: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600074)(711020)(2017052603328)(7153060)(7193020);SRVR:VI1PR02MB3887;
X-MS-TrafficTypeDiagnostic: VI1PR02MB3887:|VI1PR0201MB2461:
X-Microsoft-Antispam-PRVS: <VI1PR0201MB24612694AC293D3172EE2DED96F50@VI1PR0201MB2461.eurprd02.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(60795455431006);UriScan:(60795455431006);
X-MS-Exchange-SenderADCheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(93006095)(3002001)(3231355)(944501410)(52105095)(148016)(149066)(150057)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(20161123560045)(20161123562045)(201708071742011)(7699051)(76991095);SRVR:VI1PR02MB3887;BCL:0;PCL:0;RULEID:;SRVR:VI1PR02MB3887;BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(93006095)(93004095)(3231355)(944501410)(52105095)(10201501046)(3002001)(148016)(149066)(150057)(6041310)(20161123560045)(20161123564045)(20161123562045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(201708071742011)(7699051)(76991095);SRVR:VI1PR0201MB2461;BCL:0;PCL:0;RULEID:;SRVR:VI1PR0201MB2461;
x-forefront-prvs: 0834BAF534
X-Forefront-Antispam-Report-Untrusted: SFV:NSPM;SFS:(10009020)(136003)(39840400004)(396003)(366004)(346002)(376002)(199004)(189003)(6246003)(81156014)(68736007)(316002)(106356001)(14454004)(54906003)(478600001)(64126003)(31686004)(65956001)(66066001)(81166006)(58126008)(229853002)(53936002)(6486002)(6436002)(6512007)(2900100001)(74482002)(65826007)(2906002)(3846002)(6116002)(8676002)(71200400001)(97736004)(305945005)(105586002)(25786009)(65806001)(7736002)(4326008)(5660300001)(8936002)(5250100002)(186003)(476003)(31696002)(2616005)(26005)(52116002)(102836004)(486006)(14444005)(446003)(71190400001)(44832011)(76176011)(36756003)(256004)(99286004)(6916009)(53546011)(42882007)(11346002)(6506007)(386003);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR02MB3887;H:VI1PR02MB4094.eurprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: topicproducts.com does not
 designate permitted sender hosts)
X-Microsoft-Antispam-Message-Info-Original: 7GtpJobTe9F0E0IpQvflInP/zB++/CVpB/6mSe15qe3Le2JIZ+8GCicFisF3lQLr6G+T4B9+2FVjOWwy/aie4sg3XWHV6VtZupZdHrkapgILE5TZOLvoKVDoYUVbxd+9M/ht0DO1/goVq95SMqIczuKFfrhPKRzK2qEh+0CPx5Lbl39o+1WMYlpJ2dSEZgb3QdU3OSv4l1sfj9DJ/EBtyb0gdg7SMi6MvyZF0ZoWRsUlaw+uBbciGBSy9BL/4Qa4UPqmvbnYOvDNf9Arz1k472Sezz3c5T5X0ZepsHX4WGjncxjX7ApReJfrvwyPwCuZ571Fmu/+iNLRA7gwZZtmVVGhCesWRtQ65snYPKnlYe8=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
Content-Type: text/plain; charset="utf-8"
Content-ID: <450E8440B1618648986F985171A6A78C@eurprd02.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB3887
X-CodeTwo-MessageID: 20181023105353.de015863-7e28-45d7-9391-f8a704371552@eu2-emailsignatures-cloud.codetwo.com
X-CodeTwoProcessed: true
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR01FT052.eop-EUR01.prod.protection.outlook.com
X-Forefront-Antispam-Report: CIP:52.236.92.113;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(376002)(136003)(396003)(39840400004)(2980300002)(438002)(199004)(189003)(6486002)(5250100002)(4326008)(74482002)(31686004)(99286004)(31696002)(2900100001)(2616005)(58126008)(316002)(54906003)(106002)(8676002)(106466001)(356004)(36756003)(6116002)(65826007)(3846002)(5660300001)(6916009)(65956001)(246002)(305945005)(65806001)(64126003)(7636002)(7736002)(7596002)(14454004)(2906002)(66066001)(446003)(47776003)(11346002)(229853002)(44832011)(476003)(436003)(6246003)(53546011)(186003)(25786009)(6506007)(76176011)(26005)(336012)(42882007)(102836004)(8936002)(14444005)(486006)(386003)(2486003)(50466002)(478600001)(23676004)(6512007)(126002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR0201MB2461;H:eu2-emailsignatures-cloud.codetwo.com;FPR:;SPF:Pass;LANG:en;PTR:eu2-emailsignatures-cloud.codetwo.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;VE1EUR01FT052;1:CD29LOiZh5Wz40MTFH6m49aUMEVnWBGYNXs7x143ybu2SHwN9ExiMHFrXOGATVqW/XQ8AMnV5wp5gjqmjPDYaVYfwW4ODEyTXhTx9yIBR9ylIK0CbbkePNMkvMdy5VvW
X-MS-Office365-Filtering-Correlation-Id-Prvs: 8ee7e021-dc55-42ef-52b9-08d638d5d096
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989299)(5600074)(710020)(711020)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7153060)(7193020);SRVR:VI1PR0201MB2461;
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;3:xsAH1XTbDviOiYz0r6jIq4mHq+hghFnLR+GntWYl15jtj+z2xSJmR7nuhn0ijFHaeXaEPg9SvitBolPV4DevIXHUvvu++0/26SbifAqmCCU6TtpVTTLq0xcCbE2sdThDwMN34CdKinZ9jjxC3CxCjUpKKfQb/1eQdRFvuToQ7Ss7u3Sh7+VKjy++jkJGWDjYj9w1KZqWuR52cdCfA/gyZwQB5eD/FD6+L/afVMKqBcJBVfa0wS1pXpEVpGsPiRDRUMkwOEwVCt9BOPVlMmOeQ8VzyFggdNJuUToUcG8zHQKr2yK9wFAqvdk6yLQDciLNeK/HDilKYtLa0hQanlWOsQryO4O1fAOgb4oMJOf9bZI=;25:nCEX0nN0UMgBaNIWzotNFqTL8gyQnQwGIxuTXduqIQQAVtdqZmKmLcjjlK6Zocw2nH6Z1WXh4RyaEhhU8kH/c2OyBdV2BwuxnZthwXFcZ6hVyOY26A5W4BBW0OtKKeoWz+cYKp6RWq8XcZYg82a0m7KaR2/sPQO17ERBmx36eGawdfAzcfHtnTGw0142wO5WLuww2+gr35QePRUpcYJoYAisS1SgzecGnqAMjMWBacU2+Zl/V7WZRHGmN6qm0qsa9tB0/eSyx6xL70wW6sjbLglTGdV3fXw+wwzXZ84SR4d/b5Bk38g0ICbNsriiz5qbTL4yCCQFBPyeDOpU45cMhw==
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;31:fOQuykoC13/WPunrM1uv9IdDMTA5PKxQTeQmpLt9oa1sEwCsen0DBac/OxJlwfXW0ZIPfqpayRm4ejfjG14zTxSibWT/SiMGBTTiMit1jniunKXd+n62F9/QJC7mBol6m7PPCxenqgNfu4ZC6K2b8WA107xJ7OXX2/ghRveBM0wsddSDLf1Jw0pzoyq9oVcQnNlyCmgqdjd/ZtTdUsJIzXdCzxCzubDRbihDANca+4g=;20:JHQ8lkwiMLLiwSKHn13gabJAcHK2UyVycA/c8maAIxQrHCB4LXV5S2oIEioNxvrfQpQs/jYQwEkJeXviqyyR3YDXNwrlGbHlPOAV8KVmBh4YGRONactjhtmlpv3vKAbB+C32wEMtUUiTzlLYjVhSJTvj9mMo4GK/JqTww46Pwn8=;4:JIGEVCFj4YS/PWnFYzbeTmp7aW1vetMJrW0IEs96kzhySTa+bZWhHDc1Mklv2ZlwQArSDc6/DS3+vlTUzvsa8MHQYLxCvG0dgcwCEeBC5mfTf1VxvLr1Z45PTNrPRKdc3vzt7oESQPCLldCqLmA1MoOO9G6m/8EfopIz83bz78CCk22+hdsyY6jjluvMpxJULcEKwojfEKibYOhQe/z/cKNhYe64S8bfqEI5cNBgK69cHiCk9PMI9VBK9RD+Y+vhE8iv7ylxk0CJuWfR95yJSOGUmpn7CeuvJGBOqEQyp//5zzjHT/tiZCNEjt0YMr/J
X-Forefront-PRVS: 0834BAF534
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtWSTFQUjAyMDFNQjI0NjE7MjM6OTJoT1ZMT0VxeGxFdDZ0bndpVysyZ0g5?=
 =?utf-8?B?NGw3bUVidWRaVCszL3RNU2I2NS9xSUw2RXFISHBnL0JvRmxYZnFxTUdHOUZE?=
 =?utf-8?B?VC96ak1WUkd1YmdNWEErYUE2anY2RDBqK0RHTkJtRGMwbW9mMkkyNmpSNTdW?=
 =?utf-8?B?bzc1RVd3RWRlQy9hcDBMVlhkQkNXU1NBSk42Y0xLY0o5VHpEdTUrREYvdFli?=
 =?utf-8?B?enJicy9tbW96TWZ2V05UMFhUbnZOMXd1bkN1VDhXNDAwRXhmOUJJUHhOdWNE?=
 =?utf-8?B?UWgxdjMyaWJMK0hGaTk4eVJmd3B0VzA4YmtuMUI4VE1IK1NGTWlNejdGTENJ?=
 =?utf-8?B?bFVRMkxNREhFd01Gc21talRYdGFsdWNOSlhnV1BZRmV1SWtscmQ4eTZ5Smxp?=
 =?utf-8?B?dnZ1R1krNHVwZTBqc0NQRkRxQnBZNkVLM085aFJ2VmNMdXZWOThzT0pMckJz?=
 =?utf-8?B?R0pHMG8ySHp6QllrMkZVMjZiRHdkOFcrazNia2JwS1ZsQ3RPM2QyZjRXcjls?=
 =?utf-8?B?U0d6QVRFSW5QVDlXbURLeE53enBySU1GNENQUHFCYjhBQ080cDBqRko2VzV3?=
 =?utf-8?B?M0UrK2liak5JQW03N0FObjM1VmhOY2p0MktkNW5iNEhTTXBjWDR4bW80N09t?=
 =?utf-8?B?OUZlZ29SK21PaTl6Y3pWSllxOU1UZ0N4SkcvVm51UzhxYTZZVHJJMThBbjhI?=
 =?utf-8?B?QjFyN1FsZUhrMWc1dklHOWlwUWg1aVZkNkg3NngrT3E2L21YWVRTa1VTbi9Z?=
 =?utf-8?B?bFVnT0FpL1JJRFBqTm9Mc2tQanFYRkI3MUVJTi8rSXlZeC9GU3dNQkdEL0l0?=
 =?utf-8?B?R21aNGtJY1hiSFo0cExIY05xM2cxc0taeVBLclprSnQ3bmd1ZTVLQ3kzZThU?=
 =?utf-8?B?UWloY0dDYjJ4aExNN2NjSjZkNjNqRllNRjlRenUxOHRQd1RPT2w1MXllUlY4?=
 =?utf-8?B?M090TGgyTjE5UTZWcEZheXJ3WnZTd3BHazZ0NUxWbkVzbWFneFByTmxHamk5?=
 =?utf-8?B?MUwxK2FDejYwb0J6RmpJRUlmbUFWUmlDaUUvT010MVZOaVlxSnowQVBGRXdH?=
 =?utf-8?B?UkRaZnFEOTlBbkVzT2ttUCtpNzdFMjZmcHpYQVBRM001QkVzdFgvNlFBeWhP?=
 =?utf-8?B?OFFpYkN4UFVOcHVOeS9hSHRkc3BRVi81d1pFY1Z3YlBWY1ZBM0xkYnBjR3JB?=
 =?utf-8?B?VXd4dU5kVlhzN1pOekZGczlOOW1qQmhha09XZ3FxRllpWVdiWXAzWjhvWEVt?=
 =?utf-8?B?ZVNYNFZ0TGx5bkR4Y0JqK0pyTGtjMHRtTFVPUEl6REpFWDhuNVpsa0tzbHhP?=
 =?utf-8?B?RzhpcWRLYXczTzhWVWJWazNiMktUa25MV2hrOGE2UWtGQitwdUtINXFVdDhD?=
 =?utf-8?B?RUQrWUJSOXhrR1NrZWdUYUZJWHVhMHdVaTFwWHdNNmZoQlhUVXp6ZVdOK2tz?=
 =?utf-8?B?eFZNZ2hjK2dSOWQvYTRwK3dhUnVDSmp0UnhzYnM4OFR5VURwMzlCQlVrR2k4?=
 =?utf-8?B?djZVc0hDTTJGaG5HbXVDYjdDa2dHTnI4d1FQUi8rbm5BdTBVOFl3a1cvaG1y?=
 =?utf-8?B?S0twelJRTHhvcktmZE0raG56S0h4aHduR1BEekpwU2JkUFBJcHJTWHdzLzF1?=
 =?utf-8?B?Tml1UWhNTTYwUXI1N3FHQm9yaVlXNi9uVVpnRnM2S2JNcTFlbEhFdGlPUTMz?=
 =?utf-8?B?MkRjSldqZnZjVlpYZzJnMVNlVE1PNmUzYjh1UWhhMTZSZ2x3MHlsRUdObS90?=
 =?utf-8?B?NmFxRFRPYmUrVEdnSTZsU1F6R0ZycitkQUlpZ2ttYkFmVVVOdi9XKzU4bmRY?=
 =?utf-8?B?bUVyWDZ5b1cyMVlNVDNmbEZaRUtyaTBLR0Jaemp3dHoxK2ErZ2tiRDQxUUFE?=
 =?utf-8?B?UHdOajhENGM4VHpMeU02WU5vMllzMTVHeGNoNHJobFhIVTdSUmhrTzljK2VG?=
 =?utf-8?B?d1JXS3RxdWtJeHNwRFk1ZEp4cllNa3NyVW9VZTNHQkVjTEtrU2RMNWt0WTBm?=
 =?utf-8?B?cmw0NG5HODBMTFpEa3JZdElxaVp6U1M2T05MMVRRPT0=?=
X-Microsoft-Antispam-Message-Info: VcnrqVUeAN6u1DJV06axkEzhr3OFDO+C4scP7ZG1kRwGjXgz+VKkCEhyTBE6cSZ/HHKqC4pTLWjuCoN2+G/o45lQYLcn6fDEjJUXVcVRPxW95jZXu8z99SBTIZI4LYCLaJXc8cC5QKB7UjEhsJO44vTJzECGA4RxyTsN6IevLuUbPKxoyy0znkJ8CNG3c2RzDJe5cyA4GYwwQ+VNVBy1LzPsIrxx2ZTgN4Jr0DYUaVnAbXeYhTb1Ks4m8AodQ2decxfXZpr6HQ6AWDbL4NStq3wg0hY/uB3bFJdM45EddEsfkMaroNMLsEPqYkO8Kbn3rzWtK36m6lS6aWpn26c72QWeZawPl6ejY+WdEy0Sfkk=
X-Microsoft-Exchange-Diagnostics: 1;VI1PR0201MB2461;6:oNyCCgwjlSnJEpkPKLPNZIL6HTvJ25jg/5UzjvW5v1ZF9+I3A0HANRrJcRKm9qrkR22wtvKy+fNmxKXr1Rd/3QhSQ1pR63O3b5wAMwrfBpWCdtFO3VIOdeVm+MuzZwXdynC2pU8wt8P2dzhGOvPp8Uf3QtOjEqxwqbGUCMD7nGlGEpXZASbRF3rtltX+o8k/fYmFQSCuBDgKP+atIr+gaufrOEjU/rDC81sPUwPhI72bH5pzDLsEXK2+yNJQ5JBM7CLywE/qGhyy30qJImnf1pTSIJbgApm8DbDuvHnEYIi3BBUoHMNHbCEfTNmELEW4HEH/lAWfIUW2bR4wfwSMFp3y7dsTmEnGg3SbChE+onx192afbGHEzGxKbl5uMKMMJE6nZDYZscxl6zG9WWLvtO7ODygs4ndYTjYtPJ1dSCIDP6ls//7taFTUwvZzZgBde4glANY9YbzN48tYCR8lmg==;5:jvukZn5P8Pr3RQuuNk2F6r+oXgmqv+h23Q8AnXWGvrGDC/OVqvpAyYa0/olQjymaq5WP3e2HuGp8W/RhOxu4zN6TGK70mN3iPPHykONW+CwRl2SuEmEElj3vrEn3gqprYIrEut7fKsFT/z+PYhrdhdOJhhSuUEGcMf82IsmM1wQ=;7:oATcz9W+mzwWpTQbbqk1Ui1/0uW6F7qWolRgOY6XdwRCXyDByDsmCk3A9CJuKCYrhepuxUR0/sIOtnM5JrbaQJBtPG47g7Qz0aF5jK3n0jN0cVOVmZ99h2t+/m041hyWcUTTgCOR+PR5kh8ve7wKPv54W/sH5vguU/pVPWmH0+Ev9FUtpz46jEoG84d+F3vVI7b9ZMgO4HHnLOWphiDjWMk3zvAkN7wjfPyGijZXSBCS4HhsBUkcGJddA3Z9LN+L
X-OriginatorOrg: topic.nl
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2018 10:53:57.9275
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01f0ac86-fe76-4b00-467f-08d638d5d73c
X-MS-Exchange-CrossTenant-Id: 449607a5-3517-482d-8d16-41dd868cbda3
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=449607a5-3517-482d-8d16-41dd868cbda3;Ip=[52.236.92.113];Helo=[eu2-emailsignatures-cloud.codetwo.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0201MB2461
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMtMTAtMTggMTE6MDEsIE1vcml0eiBGaXNjaGVyIHdyb3RlOg0KPiBIaSBNaWtlLA0KPiAN
Cj4gc2VlbXMgbGlrZSBhIGdvb2QgdXNlY2FzZSAodGhvdWdoIHVuY29tbW9uKSwgcXVlc3Rpb24g
YmVsb3cNCg0KVXNlY2FzZXMgZm9yIElDQVA6DQotIEl0J3MgY29uc2lkZXJhYmx5IGZhc3RlciB0
aGFuIFBDQVANCi0gU2VsZi1yZXBhaXJpbmcgbG9naWMgKGUuZy4gc2luZ2xlLWV2ZW50IHVwc2V0
cykNCi0gQmVpbmcgcHJvZ3JhbW1lZCBmcm9tIGEgcmVtb3RlIEZQR0ENCi0gUHJvZ3JhbW1pbmcg
dGhyb3VnaCBhbm90aGVyIGJ1cyAoZS5nLiBQQ0llKQ0KDQoNCj4gDQo+IE9uIFR1ZSwgT2N0IDIz
LCAyMDE4IGF0IDA4OjMxOjE5QU0gKzAyMDAsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPj4gVGhl
IFhpbGlueCBaeW5xIEZQR0EgZHJpdmVyIHRha2VzIG93bmVyc2hpcCBvZiB0aGUgUFIgaW50ZXJm
YWNlLCBtYWtpbmcNCj4+IGl0IGltcG9zc2libGUgdG8gdXNlIHRoZSBJQ0FQIGludGVyZmFjZSBm
b3IgcGFydGlhbCByZWNvbmZpZ3VyYXRpb24uDQo+Pg0KPj4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRo
ZSBkcml2ZXIgdG8gb25seSBhY3RpdmF0ZSBQUiBvdmVyIFBDQVAgd2hpbGUgdGhlDQo+PiBkZXZp
Y2UgaXMgYWN0aXZlbHkgYmVpbmcgYWNjZXNzZWQgYnkgdGhlIGRyaXZlciBmb3IgcHJvZ3JhbW1p
bmcuDQo+Pg0KPj4gVGhpcyBhbGxvd3MgYm90aCBQQ0FQIGFuZCBJQ0FQIGludGVyZmFjZXMgdG8g
YmUgdXNlZCBmb3IgUFIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogTWlrZSBMb29pam1hbnMgPG1p
a2UubG9vaWptYW5zQHRvcGljLm5sPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvZnBnYS96eW5xLWZw
Z2EuYyB8IDQgKysrKw0KPj4gICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZnBnYS96eW5xLWZwZ2EuYyBiL2RyaXZlcnMvZnBnYS96
eW5xLWZwZ2EuYw0KPj4gaW5kZXggMzExMGUwMC4uZjZjMjA1YSAxMDA2NDQNCj4+IC0tLSBhL2Ry
aXZlcnMvZnBnYS96eW5xLWZwZ2EuYw0KPj4gKysrIGIvZHJpdmVycy9mcGdhL3p5bnEtZnBnYS5j
DQo+PiBAQCAtNDk3LDYgKzQ5NywxMCBAQCBzdGF0aWMgaW50IHp5bnFfZnBnYV9vcHNfd3JpdGVf
Y29tcGxldGUoc3RydWN0IGZwZ2FfbWFuYWdlciAqbWdyLA0KPj4gICAJaW50IGVycjsNCj4+ICAg
CXUzMiBpbnRyX3N0YXR1czsNCj4+ICAgDQo+PiArCS8qIFJlbGVhc2UgJ1BSJyBjb250cm9sIGJh
Y2sgdG8gdGhlIElDQVAgKi8NCj4+ICsJenlucV9mcGdhX3dyaXRlKHByaXYsIENUUkxfT0ZGU0VU
LA0KPj4gKwkJenlucV9mcGdhX3JlYWQocHJpdiwgQ1RSTF9PRkZTRVQpICYgfkNUUkxfUENBUF9Q
Ul9NQVNLKTsNCj4+ICsNCj4gDQo+IFNob3VsZG4ndCB0aGF0IGJlIGFmdGVyIHRoZSBiZWxvdyBz
dGFuemEgdGhhdCBlbmFibGVzIHRoZSBjbG9jaz8NCg0KSSdtIGFjdHVhbGx5IG5vdCBzdXJlLCBh
bmQgSSBkaWQgbm90IGVuY291bnRlciBhbnkgcHJvYmxlbXMgd2hpbGUgdGVzdGluZyANCnRoaXMs
IGJ1dCBpdCdzIGVhc2llciB0byBqdXN0IG1vdmUgaXQgdGhhbiB0byBmaW5kIG91dCwgc28gSSds
bCBnbyBmb3IgInllcywgDQpsZXQncyBlbmFibGUgdGhlIGNsb2NrIGZpcnN0Ii4NCkknbGwgYXdh
aXQgYSBiaXQgbW9yZSBmZWVkYmFjayBhbmQgcG9zdCBhIHYyIGZvciB0aGF0Lg0KDQo+IA0KPj4g
ICAJZXJyID0gY2xrX2VuYWJsZShwcml2LT5jbGspOw0KPj4gICAJaWYgKGVycikNCj4+ICAgCQly
ZXR1cm4gZXJyOw0KPj4gLS0gDQo+PiAxLjkuMQ0KPj4NCj4gDQo+IENoZWVycywNCj4gDQo+IE1v
cml0eg0KPiANCg0K
