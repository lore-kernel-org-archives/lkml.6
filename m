Return-Path: <michal.simek@xilinx.com>
X-Google-Smtp-Source: AB8JxZqpOO9B8fpQEV+kYLJSK9+gurOwMPVVn28eeQMCA+5eB1QQTuWQr2h4vXZLJwXp21PAP/oJ
ARC-Seal: i=1; a=rsa-sha256; t=1525867802; cv=none;
        d=google.com; s=arc-20160816;
        b=BrkUidbNOVZd1Jvn/xWjByIVpQGdDx/kaApRS0PpqsyVUHGmn0Z4y0Dn0G9mUuh+7R
         vb6LnliJuC3jV1aTsDNwVPLsi3eff9Bx4NfuKDoNAMY6Z9gOKt6KXhf6EiNyXG2U8y72
         TLtLUQggL8x0Sj1q6dhbyoXS+lHYI0hacEf4UIuXrSd5DlX+tlPCjVQS63Gu410j+HZU
         Ztpxg2733/zKA0lVhoVfnAf4etAslRZvcFvXLjOMxYe9NpYPmR31r1QwYqJkd9ebVhyp
         6TmtcBRqh+KmA7m5uUE8BBSh5XjsbIT23DPH2nrKd2lL9alQWUCx8m+pIRSigXrQs44x
         uOnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=FzlrPEpGWOM8nF79aliDRHm0ZrBZsV9BMBblXfATzoM=;
        b=HecaqwLmEd7yvDT47tBA2B8U+xcRJawZZh2UvXr0jgEhudE6+rmhMPF+K3PfBpWn/N
         fNdHHhnMyONWSA4z9GHBLpHZMbaga6WtMUwSD+h8StpxVYCYvgGINCXt8bl49fWhkxT0
         Sy+8BWXXxmzcgEgpC4+9cy6r4ugrESDyYYWlCP9Lkd+EFf4o7xqOhFonu4hFHDFVJ8e+
         TmgHa36Qe950BpPrnm81YKaQtwiP+lStiqLx4WCP0iQsu/rwiHQ01d6l3mx82969wWCW
         vfvsnIevKobSnQgPQpNLJpLCj8w3/Vi9Dfho96mCLCQnEhaL2d4egchoVRclwOCAhlar
         BoaQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=I+tHOX5H;
       spf=pass (google.com: domain of michal.simek@xilinx.com designates 104.47.36.83 as permitted sender) smtp.mailfrom=michal.simek@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=I+tHOX5H;
       spf=pass (google.com: domain of michal.simek@xilinx.com designates 104.47.36.83 as permitted sender) smtp.mailfrom=michal.simek@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; vanmierlo.com; dkim=none (message not signed)
 header.d=none;vanmierlo.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [RFC PATCH 0/3] serial: uartps: Add run time support for more IPs
 than hardcoded 2
To: Maarten Brock <m.brock@vanmierlo.com>, Michal Simek
	<michal.simek@xilinx.com>
CC: <linux-kernel@vger.kernel.org>, <monstr@monstr.eu>,
	<gnomes@lxorguk.ukuu.org.uk>, Alexander Graf <agraf@suse.de>,
	<devicetree@vger.kernel.org>, Jiri Slaby <jslaby@suse.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>,
	<linux-serial@vger.kernel.org>, Frank Rowand <frowand.list@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-serial-owner@vger.kernel.org>
References: <cover.1524751696.git.michal.simek@xilinx.com>
 <1d3bc2082972bb1d4abc2c15db396257@vanmierlo.com>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <b1915bcd-00c4-ce88-b50f-73815ff36755@xilinx.com>
Date: Wed, 9 May 2018 14:09:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1d3bc2082972bb1d4abc2c15db396257@vanmierlo.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-RCIS-Action: ALLOW
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(346002)(39840400004)(39380400002)(396003)(376002)(2980300002)(438002)(377424004)(189003)(199004)(6306002)(478600001)(76176011)(6246003)(426003)(316002)(2616005)(11346002)(305945005)(36756003)(476003)(446003)(9786002)(50466002)(336012)(65956001)(65806001)(186003)(39060400002)(54906003)(229853002)(2486003)(23676004)(110136005)(47776003)(106002)(77096007)(26005)(58126008)(356003)(6666003)(59450400001)(53546011)(36386004)(81166006)(81156014)(4326008)(8936002)(966005)(2870700001)(126002)(2906002)(86362001)(64126003)(31696002)(8676002)(7416002)(106466001)(65826007)(5660300001)(31686004)(63266004)(114624004)(486006)(44832011)(107986001)(5001870100001)(217873001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR02MB2740;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: 1;SN1NAM02FT004;1:RwDKcaWORPwHjjxmPx78+R2KUYFIeY2xKKY5Ttw7gZ3jmlyPklWl6JhQ2nnsNb6SH6FDPyQMa8J5HSd3wq03eoBUhvd9yazmvNG095Kx05jjVETHw0PSuCrgLn8mLcWx
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4608076)(2017052603328)(7153060);SRVR:BN6PR02MB2740;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2740;3:QGH8QY2mbk4xHx3fEyR+SKfu6RRChFUAUNu4xLyfdgpJ+XUnnLOqX2h4kHKx+G0cbtVtJSBafOD77KNjBJee8ix9kiZbspo6bK4kz7XP4+krEr3yEGVlUJp7MpPRREovGfkebMirdgjE569RmQj7TcBu/t9fwtiwjTees95Sl/TBjb4r4cEZ8D6D7q51zeEUU4ZynF2q5nAl0GV0JXdVKxXPp4+2dxzteKBab+txekPRHLobTbRtYOYjsoZD3ht2zECouSaRsWUlidhh0vpKT0EgYPwLT4ntMXnXnIP3s8IL2q6x3ZGE1ilztV8mk4kbwvyqaSFYZni+eGM3w+gGYLsr1KMrCe4egjGmAuzbhfg=;25:NrFRBTObUgM/TMnxqvzNrnG8Z6QGoD3ZsyR1/qOkp5m2u9N0P6hM7kUQ6LxDClLBP0tVfjm6tK7mbl/xkXNQ4fueYvLybWBNcqtkzcOCupsxMJp3ZW6oD6+PYg5o8241m6pv40DBJA0DxN8QIzdLZftqdU6uDbOaFLgJ6Dl6WJp1CiCyzXtvmgWu3q6vPWK0eaoOadfeICC7EGT9sHhipNDT0+j+BiijbdwPA6IKtEVsDILp6YX/ctyVpYu9+NWclNaLZjs75UNli7Q2V721/MNpHOrhsTA+C2GKJfYx8bY5w1+CL8B+ErjR9E3kCwyRnfuvKXhpUW0TB3GjR2kJmA==
X-MS-TrafficTypeDiagnostic: BN6PR02MB2740:
X-LD-Processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2740;31:c1QrJxGUTq1Qkfrae4ZqO4KIt8b3aI4hqSE+2EFOGN2KAP6IJ7Vmrft1Nd+XSnlzPCyXej1KxKQOt9UMQxj+PxUoxPNjusQ0YMbC10V9DTacSPxCl75DWl6iNkewyE+K0KM2b2b779OpTevJzPcPt6LXupHwRXs9Bg/+QhtW/xl8pnoig8h84+2AYST3DIVdUHXlTxhu2+s4kod9nZdDiG0361/dxQS7LMVoWvUCEIw=;20:Cv+RkpTD42BcYZP6I7/WYqdXx0Q0AnXCzr54teCKUK5Oyh8mZYPVO8amOet9dnvxuuKCc2Ja4C9RboWFsML8xAm5N6w9oIRBZbFRzSTlqCzdumrJAqiZAf0DDLGJibTvgJJ8P4+b0u7u5Pu5/pMIp6hII94rGXK/AxJ7SY2kXPxk2pqRyYXtQafawHqJI8qTS1Q0Pt83J8q4+x3Z0lseeMm8hpti+822NjQJCokEg8TPd+wmp3fPNt2QtBF0RDCwBo0jIX8RMwloSjmqqfDmJxI8BvR1OGeUCdPT+2OVq7OTox4NpLcTfycDs063Ua1pj8Zt0lg1DvlYOMbS796NPDllgMR216tYntAx78V33jbBelFjRuywZBNVY2txqh+AASp/pPmZc+p7CHmzOQYjr75ViKRrBqy5+LziKwTJFxgXL8Sh2f8aBN9NwzpGlzHUJVkRl/6FoLAcqPs171KU3sYxwnZKoLltd+dnLbRdL+MmCY21JMDIJuLFHpEzIgWs
X-Microsoft-Antispam-PRVS: <BN6PR02MB27405A22C8522CB50C10FC18E2990@BN6PR02MB2740.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(35073007944872);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93004095)(3002001)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123564045)(20161123560045)(6072148)(201708071742011);SRVR:BN6PR02MB2740;BCL:0;PCL:0;RULEID:;SRVR:BN6PR02MB2740;
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2740;4:7BPoEEvGGOZY7Njy+Y6E0Yk3VRH6vbB3vJohmXZcsi0R9Cna6o6b9VG+e+AY0koMpGcG3I91oPWxZyBdXById+VOKXK+QBi2/WNlfYNl/ts/kxyhM+4TV1XVnmR809PAm2aOXIKetLElSm9igXgB1FQWlEJ/WcV2cyv+laoshE6bZXZY9JVK4vDlrgc7X29787NPZPO3y1jTepEpPiBiRUHMBxVPSpX480DiC/PoRB4B4HLEyCGmjx/QbgkxijUZSbKaAqNxXJw7iJiLTt23dKC/mOHS/A0dQ+M07vC4edD1sovXBdHjL5ygT+dqlbTb
X-Forefront-PRVS: 0667289FF8
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtCTjZQUjAyTUIyNzQwOzIzOlNJeEJIeG5pSkoxOGxjdWJTSkgreHdySmEz?=
 =?utf-8?B?My82cmhpc1AwSkZNdGJ5SU9iR2FsZ3M5YjJFdVNxRW5acWRKMjM5dklOK2tm?=
 =?utf-8?B?ZFBtbXpVellVNjlWNjEvdjdPdnRBUkxLY1dsTGlPS2g2WFlwOFZ4cTd0WkRS?=
 =?utf-8?B?ZVFBbGVNSkV5b3FrTnd2anovRG4vT1RWOTJFU3NJNkw4WlczNlRzb1ZFdXp5?=
 =?utf-8?B?bjZJdFBlM1hHU3lGQU9nMnZkb0cvYXJoOUtrVklCK3VXV2lxV2RIaEZ3T2tS?=
 =?utf-8?B?K2VpeXVGSkJ5cnMvMTRHMmh0a3hjbjhVYm9icGwrMU03TklZc2hkQWxxa0Jr?=
 =?utf-8?B?aldPeFNhU2FIRDRpMGNod3hWMWl2bjlhVEpSdklEeTlySG1OMmIwV2lpNXl4?=
 =?utf-8?B?TjhvUll2VjZtOVZwV09vN1JjVU9aWGRSMWVxdTFweHBLT1pPaGlwZTg2UHdB?=
 =?utf-8?B?bHlnWVFOSmNXbHhod1JDUkI5dm9DU2g0VUowQ1VWcHFmaWdCKzVMWSsvSnAy?=
 =?utf-8?B?d1JkZ2phMGJuaXZ5MW9MZ3RVaEZtZlE4Z3FuUkZGbTJkL21GT0I5WnlwN25v?=
 =?utf-8?B?MzMxc3RieWs5Y280T2Vjd1kxSWtDYjN3Yy9hYUxEdGlwYlJzWTgrQnJsS1pV?=
 =?utf-8?B?YlpORnNtcGdtUkFtWkViTWpKbk1USzM2am1URnd4d1BZckxtYzZNSzA4MGZn?=
 =?utf-8?B?V1FwelRGNTZmWjZzdTlENklOdVI3WTM4VVA4UE8xWjdTWlJnUDA4MUR5R0Rv?=
 =?utf-8?B?WWRHZXk5V3JMZFFXdzJRdGtNUXR3bURSU1hVT3BqN2FqcWRXM0dSUzZtRXEr?=
 =?utf-8?B?U1FzOHJBOWI5TDRvOGtkRm9SMDhOOGEvVmJGOWtiRzUwNzFSY3htYVAzVllp?=
 =?utf-8?B?UkxOc3lQZ2FDYStiVU5uNlJDWW9VY1BzK0wzTU5UNHZNVXJkNEd4dzdnTUsy?=
 =?utf-8?B?VHNraGJDQTg1M204Z1FjOFlkWFZUbVRJUHlHRHluZHlSM3Qxb3ROaG5BaTVt?=
 =?utf-8?B?WW4vUzlDMFFBQlQ0M1FzZWwyNkZGVDdocTl6K2dnYVZ1S0hCMmJRWXUzNlR3?=
 =?utf-8?B?V29GYzczVU9MK0V3RkNhYllXWERjYjBoVHdXcHZlWmFyTCtYMmhBbnU4Rnpz?=
 =?utf-8?B?akZXVWF1NkNQdVRIU3VZazRwRkovSDVpVDdxQnMydkpPR2dGdTZaNjM0SDZW?=
 =?utf-8?B?bVUrTUlLeVpnY2pMR1Jqd0ltRGw4bklsdldLSTBLWVJKclRaeS9CT3J6S1pw?=
 =?utf-8?B?aDZlMHJtRmQ0TDJuOUR3elRzSUo2MVpoUVRtWGFqL09ZVEtubncwQjl3TWFV?=
 =?utf-8?B?WTB6WGNNTjFyQ3llUU5KQXp5b3lScnk4T00yNlBkYU9mV3ViZnM1REwzMWNU?=
 =?utf-8?B?MFExYWJDZUUzWHhlWHJmUEQzUjNZbzBFd281Z2tQTnNmZDJuWlh0UmxYSDQ5?=
 =?utf-8?B?NTFzL093OHhKRE5BTXROZVViUWdERlprZGJlTnV2NUplRGREOW40NklZaE9o?=
 =?utf-8?B?cWdleUJ3MWZUOUxvR0xqSVJlVUdOZ1cram9xRFB5bkNUN0ZZT2FWZ1FSWmdE?=
 =?utf-8?B?Uy9YQ25Db3BHN3NaajZkQ0E4bHhMcTlWMXNhYUJDdlZiWjFWTW5zNFZzYmxZ?=
 =?utf-8?B?RVR4dk52QzR1TUtVL1lNK1dLS2hwUmc3eFA5VWx1UWpGRXVYL2tEYUNNWjJk?=
 =?utf-8?B?SFkvWHVQTHNVcGhFVEtTTldiZXlPWGpaZmJIQ0VOeDhrL0tRYjdXcmFLODgy?=
 =?utf-8?B?L1hmUk41Ly9FSXEvWXREakFlWHNmRkFyTHpjZkFqN2xjWG1scmRvMlpnWTgx?=
 =?utf-8?B?MUxEaUxobmVBbWI1cWhVZmFDNzVPNUpaTTl2NklqUDU4ZkNSMXdHOVlGL0x4?=
 =?utf-8?B?WU5iNzRFY3RTeUlwUUkzbTZZTzFEUS9GSDFZd1E1Sk9KSHQwSnpJblNJUnlN?=
 =?utf-8?B?TnFWaVViT0tMZGVreDltcmgrWld3QTZFcUEvbEk2T1A4Sm9BMWRzZlBOdk9Y?=
 =?utf-8?B?aUFYWnlDVHBteUJIdlFEdlR1Z3FKTEhqa1VJWWtCTndyYnFNbElMNnpUcmZW?=
 =?utf-8?Q?7+Is13j4MoODan7gccOgy6Vm+?=
X-Microsoft-Antispam-Message-Info: hHg+p3wzliJNNZfoj2s1Brb1Wy9Y4svvR8Qln0pqmQPDElXnnFQCWOwG0GBl+DqpR2oA9YDnlD2VlMNJMsEVIz4gJSVC2Kr7r2+AZluxIqdpUoe1t3wZTX9dgMO4ShglhFOstANZnnbgHuXAngOB3bBQ5KGRaJmiuYuUvHAjDxI+EGOO/h9uf9RQlCPaCegv
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2740;6:+m3BHBsz1oAbevG4tFCXtWg0zsTt6hYNC3CQVStHfo23uBAQK8PjjlhyLP3BAYXGcIpfTLQF+DBV+Faz97qRoXGR46WuupRJv8lgFuDB3aA89gMSXgs4ST2w+tJuw+IeWrMIi/PYqu6LK0Sf+J+K7iFiT3J/Au84bO+k675HMJ5T2fHROTaTGXKZABwBVsfZ24LpL/Wkdxnto0xtZzWXFFxPtDlE9Y8cclxkEtHWrTEf5HWmlJAS6OmfCeDIPHVuQR7ilx2BwwD5X++za6HVc+iqMENTMj3HVIWFbg5+W6DNydCmaJoVFkLFaynyuojDF3iRwIY4+9PLAts1lPPD01ipVSGbmj+TyfWWRReGSv/8u1yzdhjR8yZ1Ry6VVQh8FIXI93AS0LaXZrQTLpYpyXCUNcdChTR76aPtOP6HiSBL+3nsJbapdl3XmZ0Myjf3d1J2pH9EbCZFQZqAdN6dyg==;5:0WpCX1j5DyjIREjkKU3J3o0dGHAoipgkut6FM0OGTPidMkB61qoNGRWLtAkhSBLwKammuzbfQXRPZe/nNmSdGJP6AuWyhnjrCsPnDdJ/mMLeJ0xJm9zU7JdvKzh+7uEn78OMQdVJYrTpCluUR+gmycpXUoMxllzjwti+5qTMqjw=;24:uzWuthqa4EG12stnNQY84aDKg0RMK+UxQBClUWTMXEKhV0NbFbMa0g3fl3nMvXfXSEfrRKuy6SSq3PFZOwZi2gmaiDtExjHBCJmq7dokZ94=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BN6PR02MB2740;7:HbEzO++wi1YvpC14hp7uwXnbpBw6t74caeIRJKgwF6kneJdyBBBDKbSvIC5mB8zqIebuZ7aFSpN2anND2BjWQh6ftJxSWk1kupA3Ddt/H0TAbs0i54AcAoyevdXkj9VeySfqTUobOA1m+yNzkaO/SV35R9YvQJPc9DD7vzS7D7AntSfbBWT6AFMIH5mmAjJvZO7Zf7d0X0VR2GaZP7M/gZSBK1vx26F2+PscsbI/yd9qyf02f+A9dEFGm2Lm5lU7
X-MS-Office365-Filtering-Correlation-Id: 62d843c1-2572-4826-e941-08d5b5a5c887
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2018 12:09:57.6062
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62d843c1-2572-4826-e941-08d5b5a5c887
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2740
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598818045319868155?=
X-GMAIL-MSGID: =?utf-8?q?1599988356965227252?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 5.5.2018 15:10, Maarten Brock wrote:
> On 2018-04-26 16:08, Michal Simek wrote:
>> Hi,
>>
>> this series is trying to address discussion I had with Alan in past
>> https://patchwork.kernel.org/patch/9738445/.
>>
>> It is moving uart_register_driver() to probe function like it is done in
>> pl011 driver.
>> And also introducing new function for alias compatibility checking to
>> resolve cases where some IPs have alias and some of them not.
>> This case is detected in pl011_probe_dt_alias() but not properly solved.
>>
>> Also keep status of free ids/minor numbers in bitmap to know what's the
>> next unallocated number.
>>
>> The same solution can be used in pl011, uart16550 and uartlite to really
>> get unified kernel.
>>
>> Tested on these use cases:
>> Notes:
>> ff000000 is the first PS uart listed in dtsi
>> ff010000 is the second PS uart listed in dtsi
>>
>> Standard zcu102 setting
>>         serial0 = &uart0;
>>         serial1 = &uart1;
>> [    0.196628] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
>> base_baud = 6250000) is a xuartps
>> [    0.642542] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
>> base_baud = 6250000) is a xuartps
>>
>> Swapped zcu102 setting
>>         serial0 = &uart1;
>>         serial1 = &uart0;
>> [    0.196472] ff000000.serial: ttyPS1 at MMIO 0xff000000 (irq = 33,
>> base_baud = 6250000) is a xuartps
>> [    0.196824] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
>> base_baud = 6250000) is a xuartps
>>
>> uart0 on alias higher then MAX uart ports
>>         serial0 = &uart1;
>>         serial200 = &uart0;
>> [    0.176793] ff000000.serial: ttyPS200 at MMIO 0xff000000 (irq = 33,
>> base_baud = 6250000) is a xuartps
>> [    0.177288] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
>> base_baud = 6250000) is a xuartps
>>
>> Both uarts on higher aliases
>>         serial1 = &uart1;
>>         serial2 = &uart0;
>> [    0.196470] ff000000.serial: ttyPS2 at MMIO 0xff000000 (irq = 33,
>> base_baud = 6250000) is a xuartps
>> [    0.196823] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
>> base_baud = 6250000) is a xuartps
>>
>> uart0 not listed but it is probed first that's why should be ttyPS0 but
>> there is uart1 via alias
>>         serial0 = &uart1;
>> [    0.176656] xuartps ff000000.serial: No serial alias passed. Using
>> the first free id
>> [    0.176671] xuartps ff000000.serial: Validate id 0
>> [    0.176680] xuartps ff000000.serial: The empty id is 0
>> [    0.176692] xuartps ff000000.serial: ID 0 already taken - skipped
>> [    0.176701] xuartps ff000000.serial: Validate id 1
>> [    0.176710] xuartps ff000000.serial: The empty id is 1
>> [    0.176719] xuartps ff000000.serial: Selected ID 1 allocation passed
>> [    0.176760] ff000000.serial: ttyPS1 at MMIO 0xff000000 (irq = 33,
>> base_baud = 6250000) is a xuartps
>> [    0.177104] ff010000.serial: ttyPS0 at MMIO 0xff010000 (irq = 34,
>> base_baud = 6250000) is a xuartps
>>
>> uart0 not listed but it is probed first that's why should be ttyPS0
>>         serial1 = &uart1;
>> [    0.176661] xuartps ff000000.serial: No serial alias passed. Using
>> the first free id
>> [    0.176676] xuartps ff000000.serial: Validate id 0
>> [    0.176686] xuartps ff000000.serial: The empty id is 0
>> [    0.176696] xuartps ff000000.serial: Selected ID 0 allocation passed
>> [    0.176737] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
>> base_baud = 6250000) is a xuartps
>> [    0.177069] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
>> base_baud = 6250000) is a xuartps
>>
>> uarts not listed in aliases list
>> [    0.176673] xuartps ff000000.serial: No serial alias passed. Using
>> the first free id
>> [    0.176687] xuartps ff000000.serial: Validate id 0
>> [    0.176697] xuartps ff000000.serial: The empty id is 0
>> [    0.176707] xuartps ff000000.serial: Selected ID 0 allocation passed
>> [    0.176746] ff000000.serial: ttyPS0 at MMIO 0xff000000 (irq = 33,
>> base_baud = 6250000) is a xuartps
>> [    0.177057] xuartps ff010000.serial: No serial alias passed. Using
>> the first free id
>> [    0.177070] xuartps ff010000.serial: Validate id 0
>> [    0.177079] xuartps ff010000.serial: The empty id is 0
>> [    0.177089] xuartps ff010000.serial: Selected ID 0 allocation failed
>> [    0.177098] xuartps ff010000.serial: Validate id 1
>> [    0.177107] xuartps ff010000.serial: The empty id is 1
>> [    0.177116] xuartps ff010000.serial: Selected ID 1 allocation passed
>> [    0.177149] ff010000.serial: ttyPS1 at MMIO 0xff010000 (irq = 34,
>> base_baud = 6250000) is a xuartps
>>
>> Thanks,
>> Michal
> 
> Hello Michal,
> 
> How will this interact with ns16550 based UARTs?
> 
> Can we have both /dev/ttyS0 and /dev/ttyPS0?
> Currently we can't unless we create *no* serialN alias for the ns16550.
> And there is no other means to lock the /dev/ttySx name to a device either.
> 
> Or will the xuartps driver eventually use /dev/ttySx as well?

I am not changing any current behavior in this case. uartps is using
ttyPS. ns16550 is using ttyS and on xilinx devices we are using also
ttyUL for uartlite. Other drivers are using different names.

Thanks,
Michal
