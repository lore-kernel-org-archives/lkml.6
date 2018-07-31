Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FD8C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:10:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9052620870
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 15:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nokia.onmicrosoft.com header.i=@nokia.onmicrosoft.com header.b="li3w3M40"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9052620870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nokia.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732403AbeGaQvJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 12:51:09 -0400
Received: from mail-eopbgr30126.outbound.protection.outlook.com ([40.107.3.126]:60384
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732330AbeGaQvJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 12:51:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.onmicrosoft.com;
 s=selector1-nokia-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E1v/+L00G2PmidD5dSS2GQMcL+nlF7sTSVEFKviVvJc=;
 b=li3w3M405vgvBHJRDLfGZYictJCDUK7tQdZvX/gn3tf5UqU84O2m8TR6OwOIvh91FzX9HsBW1rvA00Lc7yKNPAecCzVeGI7nBsW3Hy+Vash6X8D34H2uM5zIS4tU6zq/+36uDtnMF7bMjYhgfzYoncX/Wxmq+TlBdJDz2EHPzgE=
Received: from DB6PR07CA0071.eurprd07.prod.outlook.com (2603:10a6:6:2a::33) by
 HE1PR0701MB2265.eurprd07.prod.outlook.com (2603:10a6:3:2c::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1017.12; Tue, 31 Jul 2018 15:10:18 +0000
Received: from DB5EUR03FT053.eop-EUR03.prod.protection.outlook.com
 (2a01:111:f400:7e0a::208) by DB6PR07CA0071.outlook.office365.com
 (2603:10a6:6:2a::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1017.8 via Frontend
 Transport; Tue, 31 Jul 2018 15:10:17 +0000
Received-SPF: Pass (protection.outlook.com: domain of nokia.com designates
 131.228.2.240 as permitted sender) receiver=protection.outlook.com;
 client-ip=131.228.2.240; helo=mailrelay.int.nokia.com;
Received: from mailrelay.int.nokia.com (131.228.2.240) by
 DB5EUR03FT053.mail.protection.outlook.com (10.152.21.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.20.1038.3 via Frontend Transport; Tue, 31 Jul 2018 15:10:17 +0000
Received: from fihe3nok0734.emea.nsn-net.net (localhost [127.0.0.1])
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w6VF9DII008137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Jul 2018 18:09:13 +0300
Received: from [10.144.213.23] (CND135GF6C.nsn-intra.net [10.144.213.23] (may be forged))
        by fihe3nok0734.emea.nsn-net.net (8.14.9/8.14.5) with ESMTP id w6VF9BRl007983;
        Tue, 31 Jul 2018 18:09:11 +0300
X-HPESVCS-Source-Ip: 10.144.213.23
Subject: Re: [RESEND PATCH 1/6] rapidio: define top Kconfig menu in driver
 subtree
To:     Alexei Colin <acolin@isi.edu>,
        Alexandre Bounine <alex.bou9@gmail.com>,
        Matt Porter <mporter@kernel.crashing.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        John Paul Walters <jwalters@isi.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Anvin <hpa@zytor.com>, <x86@kernel.org>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-mips@linux-mips.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-2-acolin@isi.edu>
From:   Alexander Sverdlin <alexander.sverdlin@nokia.com>
Message-ID: <053432eb-1f24-a763-0bfe-e67373e7ea82@nokia.com>
Date:   Tue, 31 Jul 2018 17:09:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180731142954.30345-2-acolin@isi.edu>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:131.228.2.240;IPV:CAL;SCL:-1;CTRY:FI;EFV:NLI;SFV:NSPM;SFS:(10019020)(346002)(376002)(396003)(39860400002)(136003)(2980300002)(438002)(189003)(199004)(6246003)(316002)(110136005)(2171002)(68736007)(58126008)(54906003)(5660300001)(106466001)(106002)(65826007)(7416002)(50466002)(229853002)(217873002)(230700001)(36756003)(305945005)(8936002)(53936002)(356003)(39060400002)(65956001)(65806001)(4326008)(44832011)(53546011)(77096007)(2486003)(22756006)(476003)(31686004)(97736004)(486006)(186003)(64126003)(126002)(86362001)(2616005)(11346002)(81156014)(81166006)(26826003)(6346003)(47776003)(336012)(446003)(8676002)(478600001)(31696002)(76176011)(23676004)(26005)(2906002)(42866002);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR0701MB2265;H:mailrelay.int.nokia.com;FPR:;SPF:Pass;LANG:en;PTR:InfoDomainNonexistent;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;DB5EUR03FT053;1:2UDFOy/VSb1pMHa9t+HlmQbM3WJVjRHuWoXQpH7WbHk5nPLAg14e6YIbYcZtgAQic5J+265U3eBkTVs4QpoYk5Y3IWUaUX6hZSeY33vKqZinJa0ud0gFiMIsEKHDo8Sh
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b3dca11-42f2-49f6-f6f8-08d5f6f7b9d2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(7020095)(4652040)(8989117)(5600074)(711020)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(8990107)(2017052603328);SRVR:HE1PR0701MB2265;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2265;3:dVFUo6XC7v27XUGb3muQvV7lH2UCwRw9yK0rSZG9COg+xJvtTn9NT2SNxlqw7JFuJSC+mukgdtKpDvuiTynLj1Au4Avrv8ActmpJZUHLwo015SsEzoguiX5Kp44HKtE2WV4b5PTgOEE331pLURDFQQ5OCaqGN4j7cUC8nGGSoVrCoPRezqWC4J9Kyqphp8zpCZyRKk3NOKwIOJCKUvByjQNdpzYcPTzc4cTsIzn6JQJERkNnFs6aSvmGCv3dGdsttU5FkHTMRPPKvJVO4E6RFhw/faf8Nf+Bo3z9a8XGCCTrbGoN1VocFEhiKX7SSviXY6SMh2Qi7dvf5MLZl4/dgX+YcdaAucALP/rCdgF8GRg=;25:UPhrBJ/fAnPemNXV2qggNlyW0Y5twe5YTGpbRIHQvvmASAC2+LezwJa7xtfDFKahdoBqs46jQbVAzq17/7oSNLMJfsix9HxG9Ta9esYAFoLsY2LRDyoV9GHvPzzBMLke4xB1KkWHn8cfiGG9i3QEpiHW/guYJvpdgL8MlfTS2ZtSIO3oDqTpUCwpUztdO6gVfTmyGzla5Zr3E5RNxjdlrpmkO5faOg61yWzsrZjJz7/BhcqMbKSsoJ1UkO0Ba+0rE+YpqVO7d4wlAgR/9zBCXa+WHKKjrd9TL5cUgfl5gSyjZy393Wm9+GwTZj3gIiQRj8x6Ff+5TryPU70ENbW87Q==
X-MS-TrafficTypeDiagnostic: HE1PR0701MB2265:
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2265;31:SYo2Fj/fs/F/wFu3nERx2/lzVCfbjN5PYJ/FrioOL0h9fMBphOlEWPktK09qq2IUqC7k39clPCZ/JCTz/MR9AzifMS/J9EYI/IF2UqWL0HPnNbCWnqjOTggrrQqF8FT0yNl7xq12xI96ATxTzjumEwEbvpIVREaRA6C2J3pG0vDPSNlnigY+jpVk7pVMPcvCGT84q5rZdT5vcU7uDaEnw5VwCdiUx+RRFD4MWjAih2k=;20:AoZBmQ+RRzMzHmZhrwweEzEdkJPVp1CCNq36/xlgAfDZBEUT9wxiUbNE6GLyGTVicbvWx6avFq0PGkNo7DkuCSpuqOmv2UOq881CCIQu57W0lqQp/WjgsybwcG1NPaaxs2j99xNPoi87R2BYQkOHlO+WEGbLBJC2lNX9aSdyrgiBeUxKCN1/a7Ir5kpSCPyAL5VdZ59x1//UExw1s8VmfRoXmYyaBCOGuTbVuhLGbz91SZv+lFaiCn5HVSLkbhSO5KerSp/4VMO5hf3AVRE1VNk8a0cP/9GO7USqb6uKDMgXCBShzP7TGsCUoppK65UqTLDgKoNx+ROi2xJpV6QUl74dE7ZQRkZ4fjb6JcIwjUwFnQri7/cPZ5GDOvGzqEB2FqcG7HZ1tu2BUXKxPMj/wWglbEneW9GoRceFHQlqzbiDzXFrAq/7tR0fBrMhweAppQEsRDkr6Hg2M19idJl+v7LkH7pF1u62cZQx3VrwIIQfEBj5/cENxQxneN3HAUtSKTQK2x9WPTVRszbn8OW48yhD9hi76xV4Kqlj5UZ1RlJWjgCQhW+wFsfOMWQVlzurcJ/OGqNf3vewUGEyEwupErPjdLNGZRyV/eDxTV0JMzU=
X-Microsoft-Antispam-PRVS: <HE1PR0701MB2265BD5F9ECFF55AA58505A5882E0@HE1PR0701MB2265.eurprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917)(9452136761055)(65623756079841)(82608151540597)(109105607167333)(195916259791689)(258649278758335);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231311)(11241501184)(806099)(944501410)(52105095)(93006095)(93004095)(10201501046)(6055026)(149027)(150027)(6041310)(20161123562045)(20161123564045)(20161123560045)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:HE1PR0701MB2265;BCL:0;PCL:0;RULEID:;SRVR:HE1PR0701MB2265;
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2265;4:3JTFigSqzEahHKhAnovnvWtOIa9bU+ns1WbHj5I08M/nLzmVzWPLqa52LsPaDw3qiGvTF26if7Mc2J6qCSiUPGj/zaT3/xmwLeQDjzECzatOmTXhRntPQEyw2NfWZkTz2QEg46TJAyAxjU/b/q6Xc6OJVVhH2m7pjXY4m5oBwxOA8UNlXK6rMwNn/337FvWxVx/HseiT3eFkCF7AZ/ziMhXRLUcnkeSoeaMg3/JZHt9a6fGFPqGFPhiCVfR3/fA4x+D+Hws5XvfPCbZ2BeI9nLAVaHQheNm2C88w40Ia6e8serkr2vpLaNCdWmFxLgylM1TEGZMpmjHDuBR2+8pUVk9ripeYjGe+wXXxPXyW/TVQBbf+umbfq8XWbK8UeTnbVcNpb+zKvU1nSp2+CLUEVvUGPTZW26R81o4MxQzKi3+spYSvai5jbKBtLPtVIxzRcSOPHoCbpJtjXuvyW6raJUAsD1Kah0tbndRY796kNidRbLeE7+dt9fgkzH/AVoUpZ8Ag4D1gX46/F3YMvwvLfw==
X-Forefront-PRVS: 0750463DC9
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtIRTFQUjA3MDFNQjIyNjU7MjM6d2dZdDJRUEF3emRrVC83Y2RObGljWU1D?=
 =?utf-8?B?blA4dnhsRWMyRTNsQkp4WWVQV3hQaitUTDBzUXR2TVBuakNFYzRZUzllaXd0?=
 =?utf-8?B?NGZmSWY3VWhBNEgvU1M2cWY0MEZ3Zjl4SHZiRkZoNVVjZVpvdmErQWFkZGs4?=
 =?utf-8?B?dVQ4UjB5Q3JQV2lzV2N4WjU1aU0vd3FjdVlERUNhNDhkZ25rczBaOWdzT1NO?=
 =?utf-8?B?OHQwSVNHVnY4alFCNXdjR1RjNVVtRU1nVVBXS0o5WlB0WnB3ZkpoaG1RbmNr?=
 =?utf-8?B?ZDZ2NlpWMlpTTXJML05hOGk3d3FGd01MSCtaa0ROUGR2amptWTBLb2d5NVVN?=
 =?utf-8?B?OWw1YjJ4bEhBMTBvdlJkMGkwZFhPRVRrNU1na2NtOGdSVVI4TFh2SkpSZmNx?=
 =?utf-8?B?RHZ6a000d2czK0QrOFl2YVBrUjVKMjBrRkE0RFFLWFRUSXJNT3ZhSUFpdnpE?=
 =?utf-8?B?SXdrK2YyRGFiYnUydXdIZno3V1QwVmVMUzZGem16U3JWZllGc0F0U0hZbVRY?=
 =?utf-8?B?R1dCWEFzUDYySUgwa1ZhTW42QS80eVUvODBrYTJvUU1oSVdoVmVPSnF5Ump1?=
 =?utf-8?B?dnd0NHFBK2lUWVpwUlY5SWNvaStXcVBvUWs4UWpDL2hyYWRpRGJsVVhWbDJi?=
 =?utf-8?B?cjg3Sm11RDY3RkZpT2xZTHlUZXhoelVLSmVwdGxXN3F5MkpMSktzbGpac29I?=
 =?utf-8?B?aEQxM25ESGcyUC9hTFkwSTczTEF0Tzg1clY4UW1MSlZ6eVNMamxyd2ZXZVNU?=
 =?utf-8?B?RVY1S0pjU1RTRGNrS3dOYmNYMU1UbmNva2IrQWpNNEh5amVHYUdXOW8xZlBH?=
 =?utf-8?B?RzFlcEhZdmtZTmtuS3ZvU1R2NFRLQXRtYmI0UnNXV1ZoczhueFE4blNPdmFu?=
 =?utf-8?B?cUtha3BFZmV3eUZ4eHNYdGRYVWI0Tlk4UDhRcFNDa3dFZkwva2NSOHBXY1Jl?=
 =?utf-8?B?T2l3T0JvVDBtK3UxTmY0WDhFcktEVjRpYjZWamxqNzdIQk5qTDFmMThXdWl4?=
 =?utf-8?B?N0xySThiT0diRC9ZbXI5SzZEVk5IaVZ6ZHpZemdJejRXTmUzUm0yNW91OEtq?=
 =?utf-8?B?Uk5YQlEvRWE1S1gzUnpYSlFuTnNXVStQZWNUU1hqNmNaOFRFSGtLSVF6M2VB?=
 =?utf-8?B?MEZ4L1dpek9JbEVHODZmWXdNazdvL2JWTWM1NGZCYW42RGREYm5JYnhwNHhO?=
 =?utf-8?B?R29tdjc2UGtlSTBzcHhUc1BvaWVsdGZHYkVIWXNjbDNIVFM3UmUraWEwbnFl?=
 =?utf-8?B?b3cxVDJBRC9XSXErRVlxclpqMlAzeUhXK0ZBcXJjZWZlK1JSck1WMGtSbzls?=
 =?utf-8?B?UGhOV0RkR1c4Y1FzUWlJUXhLVzVrMkF5d21CVENoSWswK3B5KzdsSmFCWVk5?=
 =?utf-8?B?QTVpSm9DWW9BQnVyNGJLRHVFVFJJN0wza3pnQ29YaHZoUmtVOEJNSDVYTW1k?=
 =?utf-8?B?czdzTTRFT3JwRDhEVHZjZkRUWWNZVittbmRIclM4cklyWjhJU2NTTkdlL2FI?=
 =?utf-8?B?UWdJK3pWVG1nY0JjMjh6bUNZeGpNWW5TREZHL09kM3BVS0ZtQ0daK1Zrb1pF?=
 =?utf-8?B?bkhNZlVsbkgvL3JTWnB2ZGpHZmpURWFVNndFbUZhVklCeExuMDBQSCtrWWla?=
 =?utf-8?B?cUIzUEprUUtsbkU4cXYxamtoLzNlVFZkN0dxWXVrbjNmZkdLZWJVbkx4OXl1?=
 =?utf-8?B?WUJCZE04MHp5WDVXZ3RIRmFFSmF0SkpPZmpOU1VQOWRTQjhrYXhFR2Y0bFhW?=
 =?utf-8?B?cUxRMGtWV1ltckhuRVAySS9qTm5IcVhZSDQwY1B4WUJ3eU1meWpNemovU0Vp?=
 =?utf-8?B?b01SSEJqaU13bExEcEsvaE52dFo2RUUzK3p0aXhHaG1vWWd3Z3FqSlM0d3VO?=
 =?utf-8?B?UEp0c3ZsQTJRYUFhaURpN2YvNTNITHJTM3dFNjBVTENzMkorRnZUSUtyeUw0?=
 =?utf-8?B?RStJTW5NSCsrK2c9PQ==?=
X-Microsoft-Antispam-Message-Info: tZFnukxT4E7N1BdbEWMrFCH3F2FouSkqmkzJU8rcKZLGNM79JWz4ED+m1m6pEqZ3WLmZ17dHt0Gux1oZO0bsK9/0wXKV5/amyLw+o1S/mX3LJMSP+5Tq2HJi7yzkjM0uWLYTkc+eupQ6APlStAB15ztw+opzn/N3/ZiKqEhcOICZLesBpk95172VviGXU2yALRovwiCwGcmIhWhbdqocx66vTgUfyE+LLlIfy8lPBXZZfYeLxlY92XcFU+kfDmK08zrAluFDY3JzsHJEqrbgUkwh3uRD0ZHoxkrPUR43sC+LNksTViDQH/nDhtgVEnRFMtK6cMQl6X4k/UDCpEtfUqgQwWF5DYMVUQt4iEUyZQw5iRWq03VwHou3WDzanM8+IMHpWXMw8aZ1p8RyyXzpsv/vAK7CKYkNzVdqNaKtU7l4BWqu7cyKGD7LRovZrkuO
X-Microsoft-Exchange-Diagnostics: 1;HE1PR0701MB2265;6:5oc4Pmb6GNOsoyIyPcCpIeXg8GYj6xfiGbBj9xPRSNhkowAKkVWw4moF62/I/od52xwrkZOKXHuDvBbeNOZwN7IxMTal2XH1fPJWb5/QHEZJYEtWZT7IP7mISA7gjMhBfOKTlA+zdpM8wAwYv0y1W1Mu3L7cwHBmtbAQpklV8tEn858HRaJi/tfsSPjXPciATir7TvkniGgoTZocKs/P+ghObMbvqb/VqbiF6rTQ0PRHBai4R29VMifc2oHDn8umXCUPV7Qqn9yVdnChtEZvI1hcDXcy3mwI0goOVeUdvczpdQbvZ6rjFtI24EI4MpEmtc9Ox456uhY8A3Ariy9ZRlLXsKYlgr5HHNXJ4KeWt/SPY3NqRXSyC9qq56H3MtTEGO1UDYkZmmXsLj3Gfih4wmrvzlmTUtz7e6+tDg8gqIBtODFa58RtkS36oJc0+Vxzt5KG2LlmzqbXXRHg8Ot15w==;5:erkOO2A666tQr9ovmlWxho4WfRs+b3WWwQBaV0lol4BanaWDQXz2dXAdjyFq6TeFd/+l60Y2CFl50/9h2J/n01CSRI7374EcbjH8hUev2TBnM9JrdtWtl7ACwHVwe9kki2N6HhDaAr74JMBOeNaNmenEI9J7Qi4WuDqFe9jYSFE=;7:g2rfppQyaW2VkHH0autNwB2LrzPqLam/Ob1d78BFik9UB2jenDI9i1xk2Axoq08jX72mM1PO7vpCgXPbjD++zLKR9dKlq+gM9U0jAIYxBXLBBHxGGyx3PcGfdTwuqwXqDK3HwvAGK2R9MxrfV5dVUmlNJFFs9SDhQlFT91BtmPNMGOHCvhXvxEJCBmCb77tInABrl1f1Tnbmh92OUY/eSIM1E1H4r7NSbT8VM+I1YbNlDCFO7Y5X9Dxj6eDlb12G
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2018 15:10:17.5883
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b3dca11-42f2-49f6-f6f8-08d5f6f7b9d2
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=5d471751-9675-428d-917b-70f44f9630b0;Ip=[131.228.2.240];Helo=[mailrelay.int.nokia.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0701MB2265
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On 31/07/18 16:29, Alexei Colin wrote:
> The top-level Kconfig entry for RapidIO subsystem is currently
> duplicated in several architecture-specific Kconfigs. This
> commit re-defines it in the driver subtree, and subsequent
> commits, one per architecture, will remove the duplicated
> definitions from respective per-architecture Kconfigs.
> 
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: John Paul Walters <jwalters@isi.edu>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Paul Burton <paul.burton@mips.com>
> Cc: Alexander Sverdlin <alexander.sverdlin@nokia.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Anvin <hpa@zytor.com>
> Cc: x86@kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-mips@linux-mips.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Alexei Colin <acolin@isi.edu>

Reviewed-by: Alexander Sverdlin <alexander.sverdlin@nokia.com>

> ---
>  drivers/rapidio/Kconfig | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/rapidio/Kconfig b/drivers/rapidio/Kconfig
> index d6d2f20c4597..98e301847584 100644
> --- a/drivers/rapidio/Kconfig
> +++ b/drivers/rapidio/Kconfig
> @@ -1,6 +1,21 @@
>  #
>  # RapidIO configuration
>  #
> +
> +config HAS_RAPIDIO
> +	bool
> +	default n
> +
> +config RAPIDIO
> +	tristate "RapidIO support"
> +	depends on HAS_RAPIDIO || PCI
> +	help
> +	  This feature enables support for RapidIO high-performance
> +	  packet-switched interconnect.
> +
> +	  If you say Y here, the kernel will include drivers and
> +	  infrastructure code to support RapidIO interconnect devices.
> +
>  source "drivers/rapidio/devices/Kconfig"
>  
>  config RAPIDIO_DISC_TIMEOUT

-- 
Best regards,
Alexander Sverdlin.
