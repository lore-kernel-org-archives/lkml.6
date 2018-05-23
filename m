Return-Path: <prvs=8681c0eaee=jsorensen@fb.com>
X-Google-Smtp-Source: AB8JxZpEvppYK9MOo+JStSW2ARs56si1u3HtRm2E2vleJHWArLj9NYS1vnhqKNx61+8cnj3iJthX
ARC-Seal: i=1; a=rsa-sha256; t=1527085422; cv=none;
        d=google.com; s=arc-20160816;
        b=kunA0/o/VexueENOLciJ+rFk0ekd/S+0LHA5eHhv+U64YYpmP5iWc6zxhuilyDDodY
         4/WC11xsPsPZ+KNgzi/9w9k73Evo+t9Pq05saGxJoY9WmSELtfPz/yehC5MnjQ9SVoPf
         CExfgX9GlfiO6YkEvfK/w1J+QJCZ+y/wIeOATzOfsvsI8ZZ8/NPgSJSp3Ducoai3MYJw
         p1VprIDlNtYciVhJQ2w2knmnKsa6pyD29u2T53vQL0+5ayTEZPy+DYPYrLgpIM4f6nth
         HmlKx46x6WNxcD4le+boBWIKcTiYgfgoO0HW42uySJBHeTb19eb5wQibX5kigf4E2dwn
         YJWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=qBuTGEbfYcgqR4+19PH2c+1KF6drIRHa+vBdOd/QE14=;
        b=tW0BVkuvBM8FLXzSapExEmYPBAqzAF8Hl2/gd5r51gwTbs0bokQMVxtAv1UptgChG8
         RSgejhOGctMrc0dSDRyqxyW1gxesKGLOiuQw4FGge2YrG3oZqULxdSQoAXeX51mXaA8A
         Y/WU8wgkV/DKbNABGE1+zrH5yWUvUjDRDSCWFiyTM5HpmEdYZEBsn/NegSwHPRQcMmNc
         Ru4AbPF8NWAEYAmoo8oAAAQ3BPo1C/lzfXWfVfWpkZ8hgMKbETwO7O1totPtBOPdx1H3
         fJVWTPohMVxyQ/hO58FI5bQrujEFjNzzkb248niU7B5KJsiOF5yO5ZEN4EtQEaU5+RpJ
         KOsA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=NVXAOo7P;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=U+Q6Hny9;
       spf=pass (google.com: domain of prvs=8681c0eaee=jsorensen@fb.com designates 67.231.153.30 as permitted sender) smtp.mailfrom=prvs=8681c0eaee=jsorensen@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=NVXAOo7P;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=U+Q6Hny9;
       spf=pass (google.com: domain of prvs=8681c0eaee=jsorensen@fb.com designates 67.231.153.30 as permitted sender) smtp.mailfrom=prvs=8681c0eaee=jsorensen@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
To: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner
	<tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederick Lawler <fred@fredlawl.com>,
        Oza Pawandeep <poza@codeaurora.org>,
        Keith Busch <keith.busch@intel.com>,
        Gabriele Paoloni
	<gabriele.paoloni@huawei.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Thomas Tai <thomas.tai@oracle.com>,
        "Steven Rostedt (VMware)"
	<rostedt@goodmis.org>,
        <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Kyle McMartin
	<jkkm@fb.com>
CC: <rajatxjain@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
From: Jes Sorensen <jsorensen@fb.com>
Message-ID: <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
Date: Wed, 23 May 2018 10:20:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522222805.80314-2-rajatja@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:200::2:5b8b]
X-ClientProxiedBy: BN6PR0101CA0006.prod.exchangelabs.com
 (2603:10b6:405:2a::19) To DM5PR1501MB1958.namprd15.prod.outlook.com
 (2603:10b6:4:a1::24)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM5PR1501MB1958;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1501MB1958;3:VMhA8vuA5tDvWQd6iCpa4ARBB6AjiAGxtS49UcnOvRouLj7aSFZehhby+fbbbZGw34s7FQ8IT05mS7hxDcJNmmfVHZhpj3fW4syDbw9dae+4JkdDGaFxSUKjba2D9xvlwh5q1xd/w2XYvKMXcVEZJz3+2dL4R0cjaLZa/neBkq/SvqqxdBLWue/+Fr+viR/F7Ttjt5MmpDMOshP5tetvh3XkhexSgBs+DqRldNrjDTXihs66Qbk/Jewbk0IwEhoH;25:u1g4gv6VtI4vfG2Zg+Evc4M8Vz2is5UzIvN4bxkOflQgybPIt+sMoY47J3HzxgovepOoPKmvpsKcyQNtzgYyy7QriDCCNhcXJmF0DHO37nnMRLvdKSc9MWaG5Xerb7yyBWJ7ObqLi0JN3PjpVREZ1b7HeitA6QDUyYrqg9nVQpOp3s5sLo7AIg8U5puRI0egSTh00t2Qga7Gj+rwtj3kkTID5Osax8PXwT/gpwfGVeKVup4I0Gk0LXdRJkJyMGy2WGSujbEBdg6pKvP3qOExE5NdntSRNzWxv36bG8/WT3xzYOV3ngVTu0M7Xj0iWBzGw+Ss+f3TIO2sumKSjPg+tg==;31:ggt904ldHEZVZT3q8ezMSAtLlJy0X2tiT5vyiwHOMr5xa1u4cR1JEUirIUYvWT0bYrDZAt3HKqGj46HtnyAf8qTsgtt/PZNqrPpi91M1ckx85oSTsWEvW011VkS3DcmUvZ2MoKPGHI9nhruBz7LeQesYUWCHoKbrGilos2ISE+C0MBA9a06EeSuFKgmYUffWvck/+MW6Z33hEWfo9MsfobDVw1pCuZaG0AcpKrDFbt0=
X-MS-TrafficTypeDiagnostic: DM5PR1501MB1958:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1501MB1958;20:TOu1LeR0ddoKhhvT9CwZxqAiUM2gDHqTMhD+hGfu0OXkF1VE6WxZafrQgdov+cVF9t6ibweyRQ548oltvJLFPuLQEWOV2L5uD/VXvJ/Rsvgv9yem9AVgycMHBD9WCRd6Nq2D5+9GRqKzVPiJJK/0b6fY9kSvuEn1A3eF3zj058hEA5VHBHHMjw0srW/6Kxad/7mJK3adRh1DcojoEG+6KPL+M/sy9Uby/IsPH9Y15IKEn+OWC6heAiXCbuqlWcmIxrXVcU01hhuzKE7uW87WcoavW0DfWqXMwdeSmKoha8CY57L3buSBjYQ06wlqskodPAnc/rTFJs8Fk6xcx4k0Ucbruf2X8FAA0j4XHrI05BBi29XeJ9A23abKIuNFLyDeww4wtYOjVuq6p3kou3eEzdS1Sq2R8QSpmOA3EjtjKquQUAEj/m9OGM1A3LYcBFh3yU17b86IuMPIRQw+GXwt1q+7RK9fz6FSgLwdyciFF2pArdojvXSoN5p7q8UJbtko;4:5cODjwo7ohClOc2IgZBaGvrGrjwxEp25cmxL0GaGbKTGUFwRg2l8uuUzDxDlIXrSRXto1MuQG9pgbbSm6u0UaK8kta3p4HYggx2DLVtK6EbsjL76sJFQfSpatjGXIussZCo4HuEjPay+t6nE38lqKh8hjEph7ydmx6ezWGE0lNc+oeKYimiVQySnb1TNI6gAOdrIu8wtkDTLl6qPhbBpldZSd6QTWrk0tjH1Qy3Dttw2AGB2F/t7bUwCzl+plbqEDYOzOXaJRe9HMabm1Wma0pRDpxtIP49W3FI36jeNtpvdvYjpkdlz2bMNFl2rkS40qoCF1xor+UaZtaH1zA0kPY+NgKy67UcovEqvzbWc+/A=
X-Microsoft-Antispam-PRVS: <DM5PR1501MB1958ED701A1A337E51C2D1CAC66B0@DM5PR1501MB1958.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(211936372134217)(153496737603132);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:DM5PR1501MB1958;BCL:0;PCL:0;RULEID:;SRVR:DM5PR1501MB1958;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(346002)(39380400002)(366004)(39860400002)(376002)(396003)(189003)(199004)(64126003)(316002)(6246003)(186003)(65806001)(476003)(11346002)(5660300001)(53936002)(65826007)(36756003)(39060400002)(7416002)(110136005)(446003)(16526019)(4326008)(65956001)(97736004)(2616005)(47776003)(46003)(58126008)(6636002)(86362001)(305945005)(7736002)(31686004)(25786009)(31696002)(478600001)(76176011)(230700001)(6486002)(50466002)(105586002)(23676004)(2486003)(386003)(8936002)(6116002)(106356001)(486006)(81166006)(52116002)(52396003)(8676002)(68736007)(81156014)(59450400001)(1706002)(2906002)(53546011)(52146003)(229853002)(921003)(1121003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR1501MB1958;H:[IPv6:2620:10d:c0a3:10fb::15b];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjE1MDFNQjE5NTg7MjM6MjJkcXBOU2UvK3gxK2k0eVRVYllSSHdP?=
 =?utf-8?B?aVF2d29ON25IWUhIbldwRjBNbGJqZStkOVpKRFUzcEVUUUpvVTl6SGliSzli?=
 =?utf-8?B?SmNWdFJIRXFSRXVOR2srdVFSOGNzOXZXdTg5YUtHYWI1dEQrVkhyRmN5RkZs?=
 =?utf-8?B?VjVUK0wraEdMdlFZcFVWNnptZGkyQ0dGNS9PY3FXdVlZNHQ1Vno2anBRS2FX?=
 =?utf-8?B?THdHMURXd0ExOVVOWTB1cVlBZXRMK0hETWRBZEVJa2FkSy9yOEUxWDk4L3Ja?=
 =?utf-8?B?SkZCd29vVmpiMktsaGxPSWwvUUV1d2JCY29ndDhWaGJ1dUlENHQxWWVGUEFq?=
 =?utf-8?B?VlZEZE9hbEY5M3VZUUMrMjN1cXhvd2I0ZmtnK29hVE1yTkZiYUg5K3ArZlhR?=
 =?utf-8?B?OTdhM0VSMVNkdzJmSSt6aS9qazFndnlaaytaMGgzcnJseXdZeXRnRzZhazk1?=
 =?utf-8?B?cHNjbWhHNTRzbHhyYVpoM3lKWTdVOWZnWEJWWXRNdHVsSldWbnIxWXZTaDZE?=
 =?utf-8?B?YlVDRnp3b0ZFL21naVNOWi9TYlhyWjJaVzcwWFFBYWtzYVM4RG4xV2NTRFV6?=
 =?utf-8?B?Nm1TVWpZZ3VNclA2Wmk0RTB0ZHJEUnNtR0hWekRRSW43d0dRblNZOHUrM0RP?=
 =?utf-8?B?S0ZFYVc1cytHWGZnL0lqRzZrU1d4Tjc2ditOZ3hpVHlKUlo2NVM1alBMQ280?=
 =?utf-8?B?UmdXV3VqaUJjZlplTUYrd1JZcWoxeHFPWTJRL3FCNWpMcDU1UDhTeWZYQnlt?=
 =?utf-8?B?b1FRdDVCQVNTdXBSdWQxTEdCMTFmTE9lT003N1lLbTlyZjBETmkrUGdweGZw?=
 =?utf-8?B?bkRLUVVEZ05sRFc0dCtWWExDcFIrN0ZWVmJjTkpYUzhzRmVHaVJZTlMzT1lk?=
 =?utf-8?B?Q0ZZWnUvM29MWFZiM3NUNlN6OXZ1RVh6T1dFK1dYSkFsb0x5Y2tzbEtTOUJj?=
 =?utf-8?B?NmVERlpjYno3NUdKRGhIVFltNHdUanNPeXA1eU9SV0pFbERFWE1pbnhFN0Fj?=
 =?utf-8?B?MkFORGFUMzRaOVlxMFVRTG8veXJCWTlUbEVVMmVQNSt0cWtmR1M1TXRBQThn?=
 =?utf-8?B?RWZkYmk4Q05tZm51d0k1cFlyb050OGRHK2hVTDhhMTVBMFRSOGQ2R3FmQU82?=
 =?utf-8?B?Ull4ZXUxYWdDOEJQMWQ5SlVmT012dHFnbWRpdjB6ZUVGZDdoUHE0aFE5OXJY?=
 =?utf-8?B?Nld6TTlEd2FjWkF4Nng1RlBPUUFDRFJldGpDc3BqR0Z6aFUwMjBPZVVTZW5G?=
 =?utf-8?B?MVpyaFU2dVBMWHRxTzZxejBOMnd4aE9XUEpyWXozQWRleGs1bkNwaU5JcUwx?=
 =?utf-8?B?N1NsSjFQWlZ0c0swMzd5dy8vQWRzaEhnQ0NzWTNQcUJ3bnhTTEluMDhGRC82?=
 =?utf-8?B?b3A4TS8yVzN1dno3a0NIVUNVRUg0dXVnZTJsVTUwOUdQYjAreXVxQjAwRWc5?=
 =?utf-8?B?dU1vV0NRMDcyYWxuNjQrTGs4TENHbmxHZTlOMys1QW8xZm5oSWpqaFdHbUpS?=
 =?utf-8?B?YjNnTjdDNW4rdEFJd1RaV2svY2phMi9iQldCMm1MTnpaV3dUSVlKdFFBOGFM?=
 =?utf-8?B?REtCUEZDcXVuL243SXd1cDZMaEE5M3QwSGV2RFJVRkpNa3NTL3JodEtoYVU0?=
 =?utf-8?B?cmpBa1daS1hNMmlRZVZmY3BOdXVmb1NlWGo2aTRleW9BMlRCdXdHdWpvVjRu?=
 =?utf-8?B?T0VPM2t0dlFWNnZzRnQrUFJUU1pBdXljNW56cjNmaTUvd3kzZXg2SEgvVVdX?=
 =?utf-8?B?SnNaZGNpK2pBMU5KVXJaeEFsYktpM3lVTkc2anZGbWROUVZHRUJoaUJEd2RY?=
 =?utf-8?B?dU9CZ21TdkFxS0oxbk41alZjVzNPV0NxTnMwWVNhNnNnSklIMkx0UU9QSFhP?=
 =?utf-8?B?bVBjVnZVTHBJQ1hwWmNaRldYUHZ0N3NmazdEWFNsTTd3Y3dvbU5odEs3UTVN?=
 =?utf-8?Q?cK/ywUJT05uMUJ0N0fmuQSnHrqb+zkyQ=3D?=
X-Microsoft-Antispam-Message-Info: ufd9ZmdD7Q8Fa1ChMefbuhbyILerz34vVc4nEJnfRIlGOc+wA7BAMBOl5kCPe6KqVgRmVSDX+YLsdfbcRcpoEqprDqeVIJPQ5heJKkwIlQ9J4b0QWYc5MvsDomsMRlFOhoFAYNnjNA+d4MX0rJdkSsw28bFBg4TLWixcnCPI4yRaH8lOTe6Fus/0RkOx6fID
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1501MB1958;6:k7PanmcJo8FfyL7IZ8pDZ8eUVG33wXN7lhMTPgBIjNsXjKzHdUBfQoMlhcwNCdkQG2G4/TrHnHUH3R8dJE0uKEObII+vjZE2amq3Bw3DlOxEhkCLpbgcDajVqLMpdZUP6DQGqSe1/5N/GaYMAv/tt/wRpAhWm4Rmfsn8MrrxCJJk7DdWUqwOPRHpUvmivfmUqHVATQHSq6C0HcDHLbK/N3iFaDOOp+Jx8+yUuWGwyBrXIZ0xCjhlZP9+tIgn0J4mZZzrjINZqXyveDLS/Qmq15H6HO+9PMnJhnu1e2PyOTNelDKcPnYTeGw98mKg954phwHSvbfuvxKspAae1HCdpoItDUzzCgy4ZVko9+U01CMnO+7heiIuLJM4oC7tvrkO4Wz9i7vvWDInB9J0B62CkeHp4+6/UUzf2Nc2Km3OPlZ/eV5ALMc4Z0S2XCqDAZDIr7CjufzEmzKf5t5Ii38fgg==;5:v58pIaKYuoT0cPfjQ7rwSiboLUUkNbsdXi1OTEjWYpkJDEPFb2zs6gd3ZQ9s6kk+evRkAmLnpFcfk4a4KTEmRJ75kzAXMdZmRneb160hb/84doTwF78YmLtnhp9FM4HNdLIVEDkDJxVri9ZdKUNNoS4sLmYXDWxLFs/upSFSH+Y=;24:pGZLY+2J2pOz66J0E54ewXVLqjoepdRRjsvixe9qDwYxEzJjxfJ8TT9Uo4y3NKG8A22yHpFoZlFQblmPnw9WY4BPJzG+JZezSfzLj27iGfA=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR1501MB1958;7:tG5S7ixO/9oJRwO5VJruwwYcaWWx+6T5EYKZeUefJp4SZLWoavy5hmOx1S7bIA/zwu+Uv0o0GmdtI/LT6JLXcqzCYyda30qB0I2NwQW7dtvd5/XSzFx3yz0xOYkh3Z0ngBhE3Rbm9k8yNpv5l4sphuOqzSiE0znQC3m5Q2txlAd7FGtKgxmbm/Kccgd9SUx2TAzh66Fk+syvG11dj7Cv7KR4ISrO3x0wqOdcOm1C4SCqhKOQZ+1N6HERxaArMBGe;20:+7WgcAc6sY28dmb7kypV6kwpSJsOsi853InBUS+XVTzxf4wZu0qLYqPT5o7RGQlz9R/+O4rjxYek5GJUqfMdCWQ2u8xv3kQLZ3QIyjagpswztpvzr9UBUsgvkgNcbyQQ3Ux5g7zZJRpCCH+M3ZoI/3cZe3cPTGpOwn/8Op/7+yk=
X-MS-Office365-Filtering-Correlation-Id: a43e26d7-03b5-458e-e31d-08d5c0b84de7
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 14:20:13.9476 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a43e26d7-03b5-458e-e31d-08d5c0b84de7
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB1958
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205015185558067?=
X-GMAIL-MSGID: =?utf-8?q?1601265123287104127?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/22/2018 06:28 PM, Rajat Jain wrote:
> Define a structure to hold the AER statistics. There are 2 groups
> of statistics: dev_* counters that are to be collected for all AER
> capable devices and rootport_* counters that are collected for all
> (AER capable) rootports only. Allocate and free this structure when
> device is added or released (thus counters survive the lifetime of the
> device).
> 
> Add a new file aerdrv_stats.c to hold the AER stats collection logic.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
>  drivers/pci/pcie/aer/Makefile       |  2 +-
>  drivers/pci/pcie/aer/aerdrv.h       |  6 +++
>  drivers/pci/pcie/aer/aerdrv_core.c  |  9 ++++
>  drivers/pci/pcie/aer/aerdrv_stats.c | 64 +++++++++++++++++++++++++++++
>  drivers/pci/probe.c                 |  1 +
>  include/linux/pci.h                 |  3 ++
>  6 files changed, 84 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pcie/aer/aerdrv_stats.c
> 
> diff --git a/drivers/pci/pcie/aer/Makefile b/drivers/pci/pcie/aer/Makefile
>  
> -aerdriver-objs := aerdrv_errprint.o aerdrv_core.o aerdrv.o
> +aerdriver-objs := aerdrv_errprint.o aerdrv_core.o aerdrv.o aerdrv_stats.o
>  aerdriver-$(CONFIG_ACPI) += aerdrv_acpi.o
>  
>  obj-$(CONFIG_PCIEAER_INJECT) += aer_inject.o
> diff --git a/drivers/pci/pcie/aer/aerdrv.h b/drivers/pci/pcie/aer/aerdrv.h
> index b4c950683cc7..d8b9fba536ed 100644
> --- a/drivers/pci/pcie/aer/aerdrv.h
> +++ b/drivers/pci/pcie/aer/aerdrv.h
> @@ -33,6 +33,10 @@
>  					PCI_ERR_UNC_MALF_TLP)
>  
>  #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
> +
> +#define AER_MAX_TYPEOF_CORRECTABLE_ERRS 16	/* as per PCI_ERR_COR_STATUS */
> +#define AER_MAX_TYPEOF_UNCORRECTABLE_ERRS 26	/* as per PCI_ERR_UNCOR_STATUS*/
> +
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
> @@ -81,6 +85,8 @@ void aer_isr(struct work_struct *work);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>  void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info);
>  irqreturn_t aer_irq(int irq, void *context);
> +int pci_aer_stats_init(struct pci_dev *pdev);
> +void pci_aer_stats_exit(struct pci_dev *pdev);
>  
>  #ifdef CONFIG_ACPI_APEI
>  int pcie_aer_get_firmware_first(struct pci_dev *pci_dev);
> diff --git a/drivers/pci/pcie/aer/aerdrv_core.c b/drivers/pci/pcie/aer/aerdrv_core.c
> index 36e622d35c48..42a6f913069a 100644
> --- a/drivers/pci/pcie/aer/aerdrv_core.c
> +++ b/drivers/pci/pcie/aer/aerdrv_core.c
> @@ -95,9 +95,18 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
>  int pci_aer_init(struct pci_dev *dev)
>  {
>  	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> +
> +	if (!dev->aer_cap || pci_aer_stats_init(dev))
> +		return -EIO;
> +
>  	return pci_cleanup_aer_error_status_regs(dev);
>  }
>  
> +void pci_aer_exit(struct pci_dev *dev)
> +{
> +	pci_aer_stats_exit(dev);
> +}
> +
>  /**
>   * add_error_device - list device to be handled
>   * @e_info: pointer to error info
> diff --git a/drivers/pci/pcie/aer/aerdrv_stats.c b/drivers/pci/pcie/aer/aerdrv_stats.c
> new file mode 100644
> index 000000000000..b9f251992209
> --- /dev/null
> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0

Fix the formatting please - that gross // gibberish doesn't belong there.

Jes
