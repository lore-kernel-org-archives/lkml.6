Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 3sC4L0/1GlsNVQAAmS7hNA
	; Fri, 08 Jun 2018 21:30:28 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id B2940607E4; Fri,  8 Jun 2018 21:30:28 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eZHtl5Fh"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B8213602FC;
	Fri,  8 Jun 2018 21:30:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B8213602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753209AbeFHVaZ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 17:30:25 -0400
Received: from mail-eopbgr700075.outbound.protection.outlook.com ([40.107.70.75]:18704
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752863AbeFHVaX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 17:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector1-amd-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4koR7Ym6vV21GSnVBRI/k6Zj9aML9Bk0Xy6pl6tnl0Q=;
 b=eZHtl5Fh+pIenw/vIL1bgD7XW0e1mMH1oxpj9poTyO7s5sHcYvA/h9Am08jBW2j6q9y0anM17pu0s2Hil8BGmI39ioGSrpgyIWxMbJRyi/lLwOWsWq9iFMY4zB408J+QuapSYGLFfItUD6Yei9VlcdSIGz7FbeujzaLoWnnRF74=
Received: from [10.236.64.67] (165.204.78.1) by
 DM2PR12MB0170.namprd12.prod.outlook.com (2a01:111:e400:50ce::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.820.15; Fri, 8 Jun
 2018 21:30:19 +0000
Subject: Re: [PATCH v1 3/3] x86/bugs: Switch the selection of mitigation from
 CPU vendor to CPU features
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com
Cc: Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
 <20180601145921.9500-4-konrad.wilk@oracle.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thomas.lendacky@amd.com; prefer-encrypt=mutual; keydata=
 xsFNBFaNZYkBEADxg5OW/ajpUG7zgnUQPsMqWPjeAxtu4YH3lCUjWWcbUgc2qDGAijsLTFv1
 kEbaJdblwYs28z3chM7QkfCGMSM29JWR1fSwPH18WyAA84YtxfPD8bfb1Exwo0CRw1RLRScn
 6aJhsZJFLKyVeaPO1eequEsFQurRhLyAfgaH9iazmOVZZmxsGiNRJkQv4YnM2rZYi+4vWnxN
 1ebHf4S1puN0xzQsULhG3rUyV2uIsqBFtlxZ8/r9MwOJ2mvyTXHzHdJBViOalZAUo7VFt3Fb
 aNkR5OR65eTL0ViQiRgFfPDBgkFCSlaxZvc7qSOcrhol160bK87qn0SbYLfplwiXZY/b/+ez
 0zBtIt+uhZJ38HnOLWdda/8kuLX3qhGL5aNz1AeqcE5TW4D8v9ndYeAXFhQI7kbOhr0ruUpA
 udREH98EmVJsADuq0RBcIEkojnme4wVDoFt1EG93YOnqMuif76YGEl3iv9tYcESEeLNruDN6
 LDbE8blkR3151tdg8IkgREJ+dK+q0p9UsGfdd+H7pni6Jjcxz8mjKCx6wAuzvArA0Ciq+Scg
 hfIgoiYQegZjh2vF2lCUzWWatXJoy7IzeAB5LDl/E9vz72cVD8CwQZoEx4PCsHslVpW6A/6U
 NRAz6ShU77jkoYoI4hoGC7qZcwy84mmJqRygFnb8dOjHI1KxqQARAQABzSZUb20gTGVuZGFj
 a3kgPHRob21hcy5sZW5kYWNreUBhbWQuY29tPsLBfwQTAQIAKQUCVo1liQIbIwUJCWYBgAcL
 CQgHAwIBBhUIAgkKCwQWAgMBAh4BAheAAAoJEN7/muRPME1TTfQP/A8U028LCMsxhCmg8KnL
 oaXk5iRhiS8bhQILSWS0wTGjnpyYIsOdL4TwLLMfFkCtSjsdQSOnu8RVP3nu1waC/6U2pWWS
 W26B4GwpHfq/mi/PZOBW6+tt0srwxVvuFNVN/uE5r7Girlc8QHQfNyYxZu4eTbl7MuIIwuys
 rCueJGgaDOGps7aeknQhSYIBsdV2CazuEa2T7v4KTsjNbHCesayUbl87tZoBcs5Cf1yeUjK6
 ePSVZPszEQ9Z5iE7meU3+COIQZPvEhaYDx5qpHZjakWpb0AfOspIxgxRR3W+sutOKshbdNDy
 IhbYc9xDjOWooI+6lkNKIdAyqoqq387JndjUuXVYPM3lNY5MVprH8bO1CUzusuMFSB8SlMKq
 p2sUEiS3jBpSd5C3GKxYAOkhTZn1kyNB7CyBVU2R4II1R0aSJf2yxOmWrEboeFO/SZQAX5ji
 A7obQE44zVZlSIlFh/sm7ns2zxJYyafML5N9CA+5RWJ2QQUzzjgZkvTc2lBwvl+kAe5P23aS
 aWbJdEgjV6jwhzHfKtlIznqk/t0quVwEzhzfvzxK/8HL+di2aeg5YxPA7VrjDRLFRGiCUgV9
 gAPlLR92LnUM3XUgdtCAlQ0xPY1qaxbqZcK04zGQu6HtcO7czIwLf5K/pjwQRlMxPIUDFcTx
 gl81owVskfEp6Y76zsFNBFaNZYkBEAC+8m2NNYbxIOqTodhtUPv2VpsoovMYUNLD47xF1m+T
 FryIe0cQ/VeWb9eOBLWyAAbUdE8LO8Qzm3u226/Z5UsWT7q/iQ7BZrcsIJHe+/BtJw7d4u7M
 6s3EDznEdN1O1zw0wSVw6TcFVfi/Mb8eYLK9iG4YgUHfYl/JGqeZNyOsHwUmZtWYFhkG9pm4
 rqjgz838zXSq/zArcVhLFjgH/wpRXMq/nPxIdvoF4AuSnodmSG/8TvtQq0wt0oPZfR7OQxtw
 qZQm1Slpmi9cu5nQokrdm/3VxNCtZyUfWckRjpX8GcNWhTx0/gMuaeq2Rs2nb7u8qQaE8Ket
 kdaOOeo7OwsiIPNTutaI4g1y1BsWTfwRGDQwvZ/atT8nzKw+Ni7bzj+mUbQXkjxB+Rv+aSLe
 BVYrdGOME66Ru5owTNOpB3elfqX5QfBkcU6uTO5syxYyC1JffwSY82Ac3rLKW3qE/xu3uSam
 4i1lxWDnoOlyf4jgjC3XfUS+OiV2CbAWZ42Q/EZ+ilTu6arOSfSv5yQ1cgnX/CZ2A+Uaujjp
 oD/8w520lEjmVqx0FkPL9xH+uuY6aFzavmcqG6X23ooblnwYaa1lJND/5vnJ0dqnhOMl2JeK
 gnFgJEchkbts4CMFwDlwh06svU1tdCxqtftOPi5iR8KQAAUi7a+yYIeHq1l4vZhaEQARAQAB
 wsFlBBgBAgAPBQJWjWWJAhsMBQkJZgGAAAoJEN7/muRPME1ToGMQAN5eR7zVdNCRfNsY8bcw
 xqwTgBu5sugTBghHPRLfQGZOBBg/49iu/6qDu6Q/IBIXc1963GOtd0eOD1fjdtgNzP6WTvZY
 6zzkNvcwZQpWBTlXJa2KqKzdqGyTPZSj0YlY23L461PelTuxdIxNv45pOk32yg83NTqhxBZu
 mlAuPCfFpyH4IEEEB0j+9WEZnzl9cBLzw3rVv9bEIixe5ykSmG8UHJ6FJ6cI2myru6uwzbOu
 n8DkNLspmZppoTpwzPCY/6iljBLUBzDDRD8rzEavva2IhzINkrAvNSW6VpBMSpUBgsEIKxrp
 AFS1ax5uXmwYGyFzOWy034Zz5fWi260qiFplzKCij8t7sCgzOXwEbIt76L1basrRMY7urJm8
 4VM6MeG2mfa92FfrMeL0pnD5ONg1FIuleGlvvKdQdFnE4AlwGcKid5GUD+vNNj/pbZyUpe4r
 zBFsc21/8jXSlR6zJS4mgkNDIIBGiPny3tvKINMZ8VK00mR6INpd+NErd2LxwZ/DQ5ejVyVL
 080CbiD55mxxhqkbd5fHSfdhvvXIIYN+nM/RFLwaQGW9g62iFWlqeNRXezkERDV5ahFqZMP4
 YDdodn0nRVZYu2kaXfOclKPcH58HlrRb8pKTE3t/TNKGY3SmKoznH0QtM27TWeZ9R9RgTYiV
 zSNqP+QUNp6BotWI
Message-ID: <2a3e0323-7086-f764-1a3b-7ce4891e8784@amd.com>
Date: Fri, 8 Jun 2018 16:30:15 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180601145921.9500-4-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [165.204.78.1]
X-ClientProxiedBy: SN4PR0401CA0030.namprd04.prod.outlook.com
 (2603:10b6:803:2a::16) To DM2PR12MB0170.namprd12.prod.outlook.com
 (2a01:111:e400:50ce::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0170;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0170;3:VyXrjrTZkmDxA8DE0I5EBGHztZlO2nYt3531KUnAJdbhGbuyhTPTd6MgOJ6qJSESGfK6MNUB81K6Agdx0tL1OX1nr2d6hjAYFrDdE5KUANf6sQkG03jAsYcW7ybX67cBhH1OT+5Ff19Wvwoqb/+8bnOxtpoxTYZyn9mguJulRXp1HbFXawxZGW7yjGlAsdoymDQhdneiQAY5XCACfqZfTeE+rO+21+At+8258jhh4Yc0V58CqnWLi5ooBBuK5BAt;25:BFZ/TClFAy1v51QZf6HZa1fwclNlNW1B1wsNtPYpF8cfrM9Ov75SSKyBEnc+cHVkmDiqM/4UhKHWACzY+QPEw52JmzhIgnMDZBy1KzgVq6JAyHH93zJp4iypV/Buf2Cjzd/PhPgPpZXvSH1+OF66DvBpP0thbchhEK9b7GaNQnPl8a9jAk2jG8FAwq8cXYu11S/4N135fEEDY0/Xtqvo2pfsDzFy9SC5U4h8YQYlkC0cAc7G6hMrz6xBG1sCYPVohbcMJd5Gv01Jr1FGLMJFWsxB3A1hFlBlEXr90ZdjrXWjaAOLSRDglkBEU3lGG55rHZNdCuO9q/bxaIzvJZ7Keg==;31:vtxezm7b/TQNtaL3I0rIv2yRWXjpZVq3Tv0TXyshi3WYlZZR5s1C7C+04nHbZAy45C6pJ8NcLwP/iJ0Bvab7D78TLICG+lKGKvtP1K+smas4Int1fF9I7ErnMrHH0Mkh7OCvo/qTGdrxXfUKhcenN3QadsZQ97PgaVluQA7iHWplDlIej79eQjWd7XMq2IA41Os+KaSLzpodboiOBQnv8royGDg92uqGLp6D82nsf0g=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0170:
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Thomas.Lendacky@amd.com;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0170;20:hMtS82yWX/ix0frU8AOt0Ks7aqWs9w0F0orY9ppeB8KpuO+01DhdBZYlOpWGd3Virh1yPVjRZH6ZCav9bhTJIGZmZmcrf/tZdYk6Lgj6EOni9O2rNv6/8SbrCpH8DNAdBeNZRBuudX/z2mrzY3PFRGRTe8aXbryZugF65L6c9Tt4cogrD5dxs4OIpzGmRWawbxz32KYYtdzSKqzMfqZnJQvnlTJnQ2uHGbqWjwfT7LBzcrtus2eg+FdmJaQLK592k5BpjhvYF4vP6xjczCaD7/rrqN5hr6aY97Vlqh/0jfxSFQcA/245T7qRNCF6qPbTC3BFeCFAsjOleBdPSWE4YQFgpFXML89cFVPjvdmwlhhBp416W7fzxSp5BMz/E/3/gxt8CLbUJEMQpEe3kWMmpZdOqEuRN2YNoHL7UExY1g0GV0xELSasYbdwaD7v3htdvUivqlWzpbOAqjC8rYNFkHIXbwAfNMMlPUYH/bm1RiVrfJWjYW/5nmnyoPm9JKDN;4:fXk07yN+rUryQhlWM/FTx+zMg00jGJn0gREKcGFE4JGQ3nCweA3P7L9WpyGttrXkcBgab2e6iZzxnZKO+748hW2R5PelUrZfd5YW4apONljcAjh0UjpCufHRgC0shTelVIG+EmJvJsoubM4aaFUlD0gyKJVvxA/pNDlUcKbz5R4240LIwGGnS2/ygP4sPp99v+ah6pOX+Hvwr6m87GH7rWoH7WDd5PEWofpwn9SqX0iXuwW4JhxLkElJr+QAkAYVbRfj+U3xBnx5SQsh/Pi0opbU5XkKy7vZ4N8lJpdnpsz6fHac4QbZymEXadnrhGCJo9MwqJ4kZjoCuobTs137fjoKYiUGPftqpQyLthABJ7U=
X-Microsoft-Antispam-PRVS: <DM2PR12MB01700DE2E335382615C0FE31EC7B0@DM2PR12MB0170.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(146755900322472)(146099531331640);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(3002001)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123560045)(20161123562045)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:DM2PR12MB0170;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0170;
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(396003)(39380400002)(39860400002)(346002)(376002)(366004)(199004)(189003)(81156014)(50466002)(230700001)(81166006)(476003)(8676002)(76176011)(6486002)(31686004)(7736002)(386003)(23676004)(2486003)(31696002)(52146003)(53546011)(52116002)(486006)(54906003)(106356001)(66066001)(2906002)(305945005)(229853002)(4326008)(8936002)(575784001)(65806001)(65956001)(956004)(65826007)(8666007)(5660300001)(68736007)(3846002)(6666003)(72206003)(6116002)(64126003)(7416002)(47776003)(58126008)(97736004)(2616005)(186003)(446003)(16526019)(11346002)(36756003)(77096007)(316002)(6246003)(26005)(478600001)(53936002)(105586002)(3260700006)(25786009)(86362001)(16576012);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0170;H:[10.236.64.67];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMTcwOzIzOndJTGw0MjFFcEFMN3FPMU9TdXVnUUErQXI2?=
 =?utf-8?B?M0l2WlJaeEZGd0FiWHhlUHBkc3VBZittSkNBRGkvaGlPUUUxSXRYbW94TzE5?=
 =?utf-8?B?Zk10ZjVQYXhuTkVaL0Y2SW9HeUdyaVhOZmc1VlY2TWV5a25OUkxEcGk0THpF?=
 =?utf-8?B?aWMwS0V6bTBNVlFPNSsrb1B2NjVzdTQ4OGpweFZRUEFIdXV5T2lFR3VtWkV3?=
 =?utf-8?B?Q1l4am9ra1NWajhvS3dSQi81WHFjL3V1M0tHcFpsc1ZtR0ZndjI4bEJvVU9B?=
 =?utf-8?B?NTdGb2FaSlprYTJzTklpYW1adG5JVjd3ZFgxb3pQYXYzZmRqdWZPTlVtY0I5?=
 =?utf-8?B?UE1nR1c3OGNqOCtzYXFkYjlvckdJKzJ1RmdpMjAvTzZ2ZnkxUVFzNmloMUFH?=
 =?utf-8?B?ZUttdTR1MGtvZUg0Q1E1RXdGdHRyN3FaNXhIL0NmblNIL20zWHBUbXB3SHFI?=
 =?utf-8?B?b1VrUnhDWHVVcGxtM2JueEJUZENlVFZYeGpyNWlBcXZJbXVvVjZTMERkMDI0?=
 =?utf-8?B?bWdLL0YxdXpaMGtsWVlqVWFCekZ6WXhBeko3TW5JWWJ5dmRUeExIL05pc1Zh?=
 =?utf-8?B?Y0EvTlNaVFQ4Z2xXSmgrQjVXd1UwYzZsT1Y0MTROVE4wZ20wUkIyeVZaWUlX?=
 =?utf-8?B?Uk81OW1sQkhXeTFJMWhaM2wya25JYlBlY0FrVzdzNytJOU9FTkxFS3poSTlU?=
 =?utf-8?B?dkdCRW9kaWxObStPQWxTMnYrdGRHT0U5LzNSdHJ3aExKbzJ2end3RmVvZnZq?=
 =?utf-8?B?NS9yY1NwTkJmT01Wa3EwcGZwZk0wTEJ2RTZYYlRVSitMY0RTYUd6K1p6UGlm?=
 =?utf-8?B?T3NlTXlLa2xENzZjM2YvcGVxQzlkY25kRWFkUFhlcndkRGtzSWRZWGdWM1lL?=
 =?utf-8?B?K001eC9JMk9Md083aEFDN1NKNDBTNjg4NE1ub1NkOGxmQnBTUE5vZWU4VjZK?=
 =?utf-8?B?aTJacWNQM3RZRnF0NnorWUJTZng5MmtnaVE0M0FZWDlEMktvSlliN2xWSDM4?=
 =?utf-8?B?anR0TjA3K1BqLzBrMDZrZEc1T2Y2VmZQTHdGaEFFc0NINzE0L25MdEtUM2lY?=
 =?utf-8?B?MENpalJ1RFB0ZGNQak8rZWM2b24zTDJXc0F2R0IrSFpXVllBLzZYc1NqcUZJ?=
 =?utf-8?B?SVA1SFVMeGV0NWVLNmFFWjI3VzFLYjJnamlSc2VmWlhFaUpFUkxWK0I2YXFP?=
 =?utf-8?B?SjV5OXBhdExuTUd4NExQOHNlOE9KMkRWaHA5Z1psRE1kUWIvb08rdFlNWmJD?=
 =?utf-8?B?eWhrYzZIUlVTcm5IKzlyRk12L2pDeUw0SkF5OCs4TkdFWlpTWVl2REhXRHBV?=
 =?utf-8?B?MjVRVjNkR25jQnlic2VFelhRczdIZyt5SEV4a0NFSmt3SElxMjVJMmcxVkVz?=
 =?utf-8?B?eXBuazJWNWVxM3RtR1BPV1IyKzFsVXlLczVUSTRycmN3dUkray9GczFZVjlK?=
 =?utf-8?B?QmFCdWJvZzRLL041aU5Cc2VGUDcrQUdNeWtmV0RZcFA0T3RMMjcybU8xd0ti?=
 =?utf-8?B?Y0pnN0JWcG5pMW81QmEydS9ubUZWNnBGb0tWcFUyNlpSTklMRSt0R0R5VDB5?=
 =?utf-8?B?d053d1JqbldRVVdjSWU1Wk5ZbnNPYWRqMkFGaW1YUUllRUh6cHNCaytkb1dY?=
 =?utf-8?B?QURNWG1uNjI5Y2xUdWJ4VFNoaHNVRjZnM3hwUkk5bDY0M1JsUVV4UHlXYnBm?=
 =?utf-8?B?cW41QkZvNUQvT1hZVkFYYkpYKzhObnh4eGhGRkhxU3lzZHhDOURxaGZTendS?=
 =?utf-8?B?T3FWQVBHNUptcGRhditzM0I4VVdFZGg1dEVRMXFjZnhuM3RsWVR3NVV3SFNi?=
 =?utf-8?B?LytXVXhOR1N6Kzl0MWlhTHBqWUVXMHBEaGpzNDNIZDJOV1BGYlhsMzljZ1FX?=
 =?utf-8?B?c3dIQ0s0V3ZxV0hGbG1tWEpWaVU2RXh3a3RuekFoRW9ZbEhyMzI3NC9uNlRE?=
 =?utf-8?B?WU41Nm1YRngyVFl3c0tsdENVbGRxOXljY0Y4NEMwZmlYSTFyV0YrdWxKeUFr?=
 =?utf-8?B?QzI5UDVNaG4wQ3VWR3JNWTNuRlhUTHdERmRiUFBSQnFzYnE5VUhUc3lQTFVs?=
 =?utf-8?Q?XAW4ynaXUNX8y7FURuVrkJhQV?=
X-Microsoft-Antispam-Message-Info: YSSeAmbv5ynvvr21dmY8gnlgg0h4M52QvB1JsIP7BnKP9ZlgvbwqTKbvsEVQKZyVborubvifpZEFhQXWuL8Hj/F/jPODvbiLgMWGJNzRMNioMLyOpWgeutgmbEH84DmLBiw4UrpzywBW4VOW8/Fr7Cj6xcmiSvw7hPnTBC1icroLcEDx7dyCuVFNllXn3x+D
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0170;6:vN1NzKJb5wGoWmoAF+Vp2Tyhvmy5+pBqbAePD6gssDwon7tntuSgoBSWnu0NgKUXHNOvamntxnKw5k2WHWhJbrl46lbEPtWHrHccwNfArX1asE9jaEpnuNAezyGsPIITzDqxh+ZyU0g5ZYevBIBJJE+Rsv925+LBkZADfApg7YYc7JUY1Pu5mJieW4cLa/0O08gHlzMpAHIcg273cbCsJCGFdW72pwLx/uYQOKuwpMk44uymI0WEpM8BJSUYK8bYBx3Og+rG7vv54RodYVKB3gQLXef/dX2i19p9Nvrq6D6d8xet5t2KnnNUqG5ssD2aZ9PdPCMAfVvLYUG+uDy8bUbYVhsPxNZjBvb7SknJZBPdtM1IdgGkbTqYUKANfXZnUptj/IO3HMnhCcrYtAAxqDE4pEH9iqZzy29P+K1iJLihqzllIE7HMB02y80PAyz4OUrIWmZZMESgvclYSBDf7g==;5:tAZvQpxIR8OYs+3tdY/IsJEY+uTIVE8cwmg/oQkhWnEW/l06dU2EPoXE+lzoyFZcwob2ZAJHUbce1Jyd+dZwmQs6HKc2Ic2kZCyPOYwyFR2IM3q1knz9u6i/StEz7blYAbEZT/jGAzojGEjritCOyM2DaPY8Ds2Xcqwq+UIwP74=;24:hrbVNIO3z5NdX1EXEnH9dnomb7ykYEpPArvXXb/oWZVen1Leam2hbCXXhNz6Kdetu8WAlynCbFok3eexYT5XmrDxK0FlPZKxQVDri7kOlDg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0170;7:JMapHVlBK6N8nboq6unhi51lDaXPwdECpOxXGgxhv1PmGZHkgLj2MWb37NZCiTgOFDEX/hJ+bZeECybsACbYYau7lc5YvsuqjMsY5a5t8Qxf186/C9ZJh8xr5tI28k2D4GY7mGkSKWwmZYpQyZ/EHhBpCP7zNR+uT+hLdSmLVbbygMMjbIos+mxUtSIu5LaQSyuyM+uY/5KcX7gcKWIDu9sEBb+Z8RHhP/We9gUgnK8ScpnHQH3AXJoBIIE78Wfb;20:xDMPUxO71leuH6oYrtwqAVLpMNCtysZPIyDPZ3AifvIpI1LcZ+lCBHXVmPVp6Th8gPA/csujaRQPbmK6wUO7/5qLqeyGzo4RC/8YoKJTbizNv4dypvPGCyT2+cbaR+LyG/BQqnMrUzTw9VJf6Rw6/XZ0IrFqS0EFiC/EOGCV+WXdM7s+VOT/SJq/nvj2hmu8uvM/vBwrorQ29L/ySuB6zyHjsQv/h10+yjm4BtpfGjT6QtvZf6XGub6pJQhsmsFd
X-MS-Office365-Filtering-Correlation-Id: eb4b1832-079d-43b7-c48c-08d5cd87091c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 21:30:19.2296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eb4b1832-079d-43b7-c48c-08d5cd87091c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0170
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/1/2018 9:59 AM, Konrad Rzeszutek Wilk wrote:
> Both AMD and Intel can have SPEC CTRL MSR for SSBD.
> 
> However AMD also has two more other ways of doing it - which
> are !SPEC_CTRL MSR ways.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> ---
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: David Woodhouse <dwmw@amazon.co.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  arch/x86/kernel/cpu/bugs.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
> index 6bea81855cdd..cd0fda1fff6d 100644
> --- a/arch/x86/kernel/cpu/bugs.c
> +++ b/arch/x86/kernel/cpu/bugs.c
> @@ -532,17 +532,12 @@ static enum ssb_mitigation __init __ssb_select_mitigation(void)
>  		 * Intel uses the SPEC CTRL MSR Bit(2) for this, while AMD may
>  		 * use a completely different MSR and bit dependent on family.
>  		 */
> -		switch (boot_cpu_data.x86_vendor) {
> -		case X86_VENDOR_INTEL:
> -		case X86_VENDOR_AMD:
> -			if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL)) {
> -				x86_amd_ssb_disable();
> -				break;
> -			}
> +		if (!static_cpu_has(X86_FEATURE_MSR_SPEC_CTRL))
> +			x86_amd_ssb_disable();
> +		else {

As I think about this more, I don't think we can do this for AMD.  The
X86_FEATURE_SSBD could be true because of the LS_CFG support and not the
AMD_SSBD CPUID bit.  But if the IBRS CPUID bit was set, we would now try
to use the SPEC_CTRL register for SSBD, which is not valid.

I think you will have to keep the case statements and explicitly check for
X86_FEATURE_AMD_SSBD before using SPEC_CTRL.

Thanks,
Tom

>  			x86_spec_ctrl_base |= SPEC_CTRL_SSBD;
>  			x86_spec_ctrl_mask |= SPEC_CTRL_SSBD;
>  			wrmsrl(MSR_IA32_SPEC_CTRL, x86_spec_ctrl_base);
> -			break;
>  		}
>  	}
>  
> 
