Return-Path: <prvs=8681c0eaee=jsorensen@fb.com>
X-Google-Smtp-Source: AB8JxZoYh5aVUWybu+WI1Mj+myvJvaOk4240HPuRmlJwPstTwARE71xQMBefNcAxm5y4z+XAMekk
ARC-Seal: i=1; a=rsa-sha256; t=1527086020; cv=none;
        d=google.com; s=arc-20160816;
        b=bXAPIyI4bVY/yRsBZil1qt8lOutx8SW+fr5vqJqRE4uMtjeuy8FXVbohjSORmeMqjk
         jaEK3/iOYftaKOTJ9e/0O3M9A0iSVppcYx+TWaDSBLAwrMhsIv/9q3fI6YXHqx+AGIev
         Fhmu42cUPNDKWLl4nP3Ig+x4xbIOjrwUvkktloUaxX924KXwj6+wqd2NAMzx69+6ObU1
         VCLmzQr/X2XAWXHwZtnwFTwuVMigE/omZd6/lV7eaLTAMpKKju4UFlaoLRLiJpxYu0iD
         JsGQYMPOEZ7O9hhjgD0Jbzi7JWsABJe/IjX2LJE4dNYVt2eCfaL0wAgKqHk/b/M9AmVT
         s6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=xmt70xA3cEFZOVwXP1rbHtybYnr+N0z0C6FrvfUOqzU=;
        b=0nWwzQZQF04Lu3ELRUtDQBlNIGmfTcvoJ5HswkQOul0aKRGI3wx7bdNDEgBU2/ORzj
         L3JkWnKFKoKKp0OuzLrLfvxRQyzGVkuV8EV4zURN1BFebHi9wLkRd6+5IG+fp/O2qVRm
         ccmBwYb+744zWrA4mWjofh3pIxopwkRPPSUzhU5gAHBmD7iVM054zZIgF8XB8crkyoty
         maWe7ydwnCYfvTbOTSl334XadV1F17j2U8EyYZOA3QqomZJqaPSxobMVTFT4CqgZsDvc
         zmIlphjYYKr1zspF67do2jXmNufpcwsY0K/NsX/3NwABcSIJy3iY9LQeB9YBYaxSSeF4
         tqdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=k1aAT2d+;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=GZfvv9Ac;
       spf=pass (google.com: domain of prvs=8681c0eaee=jsorensen@fb.com designates 67.231.145.42 as permitted sender) smtp.mailfrom=prvs=8681c0eaee=jsorensen@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=k1aAT2d+;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=GZfvv9Ac;
       spf=pass (google.com: domain of prvs=8681c0eaee=jsorensen@fb.com designates 67.231.145.42 as permitted sender) smtp.mailfrom=prvs=8681c0eaee=jsorensen@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Subject: Re: [PATCH 1/5] PCI/AER: Define and allocate aer_stats structure for
 AER capable devices
To: Matthew Wilcox <willy@infradead.org>
CC: Rajat Jain <rajatja@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
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
	<jkkm@fb.com>,
        <rajatxjain@gmail.com>
References: <20180522222805.80314-1-rajatja@google.com>
 <20180522222805.80314-2-rajatja@google.com>
 <62fae8eb-aaed-65b2-19ad-7c57b3a9bfdc@fb.com>
 <20180523142656.GE19987@bombadil.infradead.org>
From: Jes Sorensen <jsorensen@fb.com>
Message-ID: <46f0a2fa-9b48-c6d3-05ac-a75168b1998c@fb.com>
Date: Wed, 23 May 2018 10:32:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180523142656.GE19987@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c091:200::2:5b8b]
X-ClientProxiedBy: BN6PR06CA0015.namprd06.prod.outlook.com
 (2603:10b6:404:10b::25) To SN6PR1501MB1965.namprd15.prod.outlook.com
 (2603:10b6:805:d::20)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:SN6PR1501MB1965;
X-Microsoft-Exchange-Diagnostics: 1;SN6PR1501MB1965;3:oKk7dnk9Xzgamh/QGNVhuTjZNfowXviS9Udij6oJmXDCOGq+hkCFseEA9mXMGVk7GLm+7sXp9SbqU03Ci4l7H9S/ciEgiKA7VP80oNO2luUPCtAU+vwVywh2YlZqM9WsT5WMmwWZqFauNNGLvp6wHv9tj0Ydw0sEXHzhmx0Ox+RMAK7udgy8LPf6cpQJHdyjmGZ0dTb6ycPE4xsLsSTdl9+lfr45zVNLwQ8cAJNJuB3SyTyz4F0/VD0KiyAvLO0d;25:7q+jUi85dCJM/m+t/txYOoSBf7sMsAWGPTIh1K0zlNq4gfCYdex7Ge0MieT6jS9dMDC22CD8BCYycCN0TAqfCZG3cbLLFBRXNZ6FC6YQLJu7mrAHoxG4mrcqbjchV+uGF7Z/AHE42myL46dymqlB2FLNjTzGEfp16cB38F1aGsIogalDV3PLHoyC7Me8DqP6sai4PxaJYoZbEld2tJPxlWFkCgI7dwDEFaU9f+fxSXjF/qtaodS0SZbTVDOVeAJY8YrXt8LcRGdkFYufqRgU72dLUpTesw6ZwCDrqiMbJxMx+iELlcc0K+XFQEaXRXhfQSLEOknJdL9pRmhRmW19WQ==;31:wr7HMw0Fcaruv3E2vjVaoQ7jLx2TqF2/Ktx2lht/Ogbd0DGxM2rAojAvivQn3xqbjsS4F8dlb3qE+VmFdfKTWq6v99V9L4pyZc0SiiBW15Sg+ePYXee8VuWk2K51knufdNGMHcRhD2SfqmkF6YV/WLxgY2vSiGksa15OiUr6wf9X5YXRtbM5zwpnRw62i8vl0s+mRgLfAXm/+Vsw4goyEZN7xGO8dnrnlhJv5PgwSU8=
X-MS-TrafficTypeDiagnostic: SN6PR1501MB1965:
X-Microsoft-Exchange-Diagnostics: 1;SN6PR1501MB1965;20:r8qIVvAdblC1PjGIeC8N/dltpUdqtYM0VfzrqVgqXBTR/itIlGYLvYJSGycVhfc44eA7nOeMl9TMZEoMz1PiNi8Qe42nDkoKWPDIEHHwNgKoz4rA7OVT/vsVWxVymt+XYZwV66r9Iu1bLomFUHtIzFuplCykj1oqWorPLXXBS7xb8FanmBmh5aXqACIP5iD7BRphLG+Iq9dv7e7MEJutksKp1eih0o4wpYsqqlGfLVNPMsfQqPbXzQWq1zg9035E7FznYJ6enyc7DWvBK/cVV5/Yg4UM0A5hbIJLRI8z4MTKbhdxWMP3Oh+aP/z5xcDLH8wDILYpWrtqFS9b9jvq2/hyqMwDQa64NxdVTqWnvZC1uqTWjNUNKESbR3HuD23nlSue9NjzCtzA60IPLTrA6eL6MFfHzZQxWC5WKUFlOPJI/2iXBeocHHgcg4MPXtMTO/uXNrMgMH5AEQoF0MG1YMbVdtBx8DSTWf8/73rO7c1lydcwtuZFd+y3Ip9bHIvO;4:z8yAnTpvZqd8Qq3OaUIcukNwOJF5DDum8l2HcEEkpXusbVBXk6gSv5mMmqY2nQLDpWXeD6YhWtxnK/jI1d1tzQrQHhkNGzuyVwRbspTnC3hgKvGY5h/AbreBPnPZ1xH0FJLvrDYQjNrdaEDgTE8zAHUXEyg97KXi2sOV7t+QmVvgam21Gnc6cCPZFkhORWnEd6s7Sm8vRAhMsfIfg5HFdcGMf2BlLRIJGSgatV2JNbDDJQ/jd/J2u/4v624+9dRFxx6TxSMiwJOh+H4xhamgng==
X-Microsoft-Antispam-PRVS: <SN6PR1501MB1965EA6A6D0A8ED28F13D2DBC66B0@SN6PR1501MB1965.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3002001)(10201501046)(3231254)(11241501184)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011)(7699016);SRVR:SN6PR1501MB1965;BCL:0;PCL:0;RULEID:;SRVR:SN6PR1501MB1965;
X-Forefront-PRVS: 06818431B9
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(39380400002)(39860400002)(366004)(346002)(376002)(199004)(189003)(6666003)(76176011)(97736004)(6116002)(2486003)(52146003)(7416002)(52396003)(23676004)(52116002)(5660300001)(65826007)(6486002)(16526019)(53546011)(386003)(229853002)(186003)(2906002)(46003)(11346002)(446003)(476003)(2616005)(478600001)(1706002)(25786009)(68736007)(486006)(36756003)(316002)(58126008)(64126003)(54906003)(31696002)(50466002)(230700001)(93886005)(47776003)(65956001)(65806001)(106356001)(105586002)(31686004)(4326008)(6246003)(39060400002)(305945005)(8676002)(8936002)(6916009)(81156014)(81166006)(86362001)(7736002)(53936002);DIR:OUT;SFP:1102;SCL:1;SRVR:SN6PR1501MB1965;H:[IPv6:2620:10d:c0a3:10fb::15b];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtTTjZQUjE1MDFNQjE5NjU7MjM6V29xR0xFaXp5aEllV3ZORlkxcDQwVU53?=
 =?utf-8?B?a3lxMzhhT292Y2NkOXhLeFF4RERPazdYWGpxa2ZwZDFOQWU3SXNlK29ROWdT?=
 =?utf-8?B?SXV3cFFGbjJ3K0NRNU9QNkxYdGtaTnh0OGNLeERoOGdrb3FFMmd6L1cxcHU3?=
 =?utf-8?B?TzVTejJaV0YzNzlreHp1aTlYTm4rUWYzdkRJTWJqOG8rQWpMS0g4V3V5cVpR?=
 =?utf-8?B?VHQ1S0ZVbW5IR0MwMTEySUJ5SUt1TldKMDkxU1M1dnZEUUZ4SStUMDhmakJO?=
 =?utf-8?B?YkVNdFNnTEVWRW00aHhBcG5zeG50dklRQms0RHZDMXJRMTlJZ0t6WE1YM05F?=
 =?utf-8?B?VEZXYnJJNkNZQnZTdE02bnc5UDNjZW52cEFDQjdpU2xIT2F4a0lDaDdSZ2pC?=
 =?utf-8?B?RHlrZ3cvZEplYmxHUXpoL1RlUzZtU2IrdTc5aHNlQ3p4ckxNS0lwcUJWNG56?=
 =?utf-8?B?MnN6WnJTK1ErbndqQldxTGt5WWdRZ3o2U09IbjhYVWdvSW1yL0MreUdFVWpF?=
 =?utf-8?B?d0wvTTBNeldtcmh5Zi9RNzhNVGR3OWxRdG1zb0djU1lGRCs3dkhvU2JRSXho?=
 =?utf-8?B?S2FWMzFaK2kxZkptQll3MlA3UWVVTWtZMFJ2UmRvRDFTNVk4aHBnQUF2MkNp?=
 =?utf-8?B?VWpnb2VCeXNlNWt4bEF1TWVMdDF5U2VNTElicnJwZUhFeERvZWk0aGFSenFE?=
 =?utf-8?B?Lzd3NWJtS0wzRkNWYVd0d2orTzlNODhYNkVoRjZZTHlXQUl4N2JhZHgvOXRH?=
 =?utf-8?B?UlRQT0JMY3krRGw2ZVFDQnVxbitiWUJRaGdSNGxFdEhGRVpLeVNTcExWdm94?=
 =?utf-8?B?bGloeS9GUlZQcWRYM1V6bjV1SEZuNzg4a3MyYW9wT3BENHJQZ29IdFo3MnJ1?=
 =?utf-8?B?WEFBTFM0MmxTK0Q3NGIxK1BuRGo0MzRYVTZMTi92ZVRyaU9ZbEczcGV5ZGYr?=
 =?utf-8?B?S2NQc2hJbmQyYVlpdmlXYUt2TG5pZnBUTWZKaC9xcTBzaWp4UkJxR3dWR2hj?=
 =?utf-8?B?cktpR1NMb3lqSC9LQVNwN2RJUGdEbW8rVG8zSUlHamFNRG9lc2J2dWRaQ09w?=
 =?utf-8?B?cjFZbnZ4NWljZnFJVlI1MU53a3JyVGU4S0hTaGJEbkNpbEdoWGM0ckppRHlP?=
 =?utf-8?B?T2kvc3BwaU05T29ndkFuVUZuL3MyM2ZqdklMSDRVNldYUUxTdjlpaUxnNXp4?=
 =?utf-8?B?bmtqTDBVMmdUQkd3Si9yT2pvOTVNVThRQlNVamtNdXVnSHJuZWxHYVptZjBI?=
 =?utf-8?B?bkJmNjB4T1FsL1dWZ1NsRjd2Wk83c3ROZjdKQ1ZQelVOQkIyTEJpUWhOVTlQ?=
 =?utf-8?B?Mjg0TDNGZ0ZJNlg0dG1NWVRXYURDd2tBZm44Zk9EcWhaMEhvVjF5SEpabXhn?=
 =?utf-8?B?MXc5MTJxVFJrVzBRUHg0WmNWNktWTExZRUNETm8wUTZzSllSQUZXcEdVMElF?=
 =?utf-8?B?dlFFVWo4eHZ5c2pINmcwQTdxamF0Y2NDYVUyZFkzNExzR3djUzhyOWdQeFVD?=
 =?utf-8?B?cUl2OUZGK1FxNEc0U0wreWFtck01clc1bU04d2Rzcko1dFduU2trVnl1UWhr?=
 =?utf-8?B?YTRHaCtxU21WVFJ0SVVYRTNPcmhiMUEyMnhDVkZjRWZMOXZkRFd1Mkh2TTRr?=
 =?utf-8?B?QlNQV0dvSkJYcldlTzhTZVRPYlpCakxtVStTVEhUbWtxa2VvQTgzcC9Rdzh1?=
 =?utf-8?B?WkJxZlpFSFFBM1BkdWIrbklsWlNHNHlyQVd6QlpVMkJzSC84Tkl3MFVzL0hC?=
 =?utf-8?B?Y21xdGRhK0l6Z2x0bitFaFdXem1jT0dkOE5YUEk4Yi9UVmc0TVdXS1MrR0lH?=
 =?utf-8?B?QlBscThVOW9kKzhBTWdnVklCN1pwVG54T0FZamhpWVhweWZNYWdWd1FubEVU?=
 =?utf-8?B?UmRvUzYrdkxDQUFiMkd1ZWRWSU1MTFZ6K3lncXdCYlQ5M2wyL2RnaWRSRHlS?=
 =?utf-8?B?ekpvaG1zOHZGNkE9PQ==?=
X-Microsoft-Antispam-Message-Info: SmDQ8TlhRIC/lXB5qL/q/qEDhx0UBDozZr4FTNuwJUqDv3v6anV1kHfQMJEvqz10SsOlAIfkoSN+UrUgI57sJXJPxsXS9VYp7CANwRED21JGu0cOFFGxo1DI7eY6Xv9yt6sbC4yDVFv1BzjWekzMHRUwWWeByN/p0zoQZDcIdt4VGqbaeEPNNUZ3AwCk+vBj
X-Microsoft-Exchange-Diagnostics: 1;SN6PR1501MB1965;6:ZTF9axy5XGpKsW+vUuy2P5fc+yN8bC4qhYZ5TOnL4ug8EO+8YFUwDYXEDv3Cqf38d2/jeoctr80RJYG9hSzaECDeXzQ1jWo+QRdL+kMLHMO5CSW1zAQzFOfCtNYHU/eWTY6blVTH3yJEvJ9VOgunXK0vahk07NDplMqf21ag2uMMo4MxjvpWfnQgmMTvdCWm/1CUJDOVGPGUZbwOPLHithJ/07lHbDuKqwkJtoICKJuSt9mxLPfa/IeOigyoCUWz9iACdNCdvAMz5Acj0Q5YhWiAkpCPkD4G7zUEIHQZL7/TcBPrH/5Z5TKIzg0PYlEbnCXyRNRTEVpkHPgWdbH9jWJFXCeVXqO+VfHyT4hpgbAMewEgsKtgkO3MZbO1YJkvX3fMGIishO4FQv/p8Q79E/HOJmXxPXqdme4Wm8XoaKBtmnu3um8UQ1R/E4Jvl17bs472ZaHVYUOkj4j9om6tMQ==;5:6Yl5/HaH3O3l6XbYx9C33uFTjeZfNpMwDJeHfCkpQkOEJWzmXso5aP66zxTR9xsWaiR26sY4LB7TqRZMx2S3Q9FaPxgzqhBN7sVBTFIem+2u1STnbu8tHMU0M9Swj6NsVDGj/wWHsb7yCRv0N4aA6kq3pfFa4n4UhRvOfkUw1uY=;24:+efEzwGT06AhDd+kFg1wQKgNumjEOIWrK/NpH/avda42i/OMavkWapuOYpcO7svSgaUPhSgFSGzWQKDvDQrdMw6jO2wSXEpZFxaXngGQI04=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;SN6PR1501MB1965;7:Jb1RT52smAu4vxEripmMHYWfP6Op0ViZlHUcCyMx/IAEsaaec38bESQlG4kOdLIGzMFOLYgZNoziFTrWMPHdsZUXHUXz2VthEs1WpVjTx9S8k3+mVO1VC59ayKsOF/Df+AsfQGgGg9Ozfm2ypeV3nUFdTiBl4Fa0W3Pia1ZdrrynpRj1CFMMNpTl31yYQ9wdg4wzyT93F4ZpmmgxHTFJgzWgnbGB92l1aoIThfwarvmwmjI44H9mTwKLC9ckTT2Y;20:8LUaw7/hu6qpHjHUrErmErveEiBhbzOFmx63SQ4Gqon+Vxz3M8Dr8DH2SYNbmxywDz3n408sZi0rGxmEQz/7LGGQlaTJq6q04Z6vOhnX6iY6ni2Ahzd/E37gavKO7EqWSXDdWd1Qa5ypCiRsblzx0/GutjTaB237zF+5PBxlpvg=
X-MS-Office365-Filtering-Correlation-Id: 641ca1cd-4d08-4eed-4cbd-08d5c0ba0386
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2018 14:32:28.2751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 641ca1cd-4d08-4eed-4cbd-08d5c0ba0386
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB1965
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-23_06:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601205015185558067?=
X-GMAIL-MSGID: =?utf-8?q?1601265750884653702?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/23/2018 10:26 AM, Matthew Wilcox wrote:
> On Wed, May 23, 2018 at 10:20:10AM -0400, Jes Sorensen wrote:
>>> +++ b/drivers/pci/pcie/aer/aerdrv_stats.c
>>> @@ -0,0 +1,64 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>
>> Fix the formatting please - that gross // gibberish doesn't belong there.
> 
> Sorry, Jes.  The Chief Penguin has Spoken, and that's the preferred
> syntax:
> 
> 2. Style:
> 
>    The SPDX license identifier is added in form of a comment.  The comment
>    style depends on the file type::
> 
>       C source: // SPDX-License-Identifier: <SPDX License Expression>
> 
> (you can dig up the discussion around this on the mailing list if you
> like.  Linus actually thinks that C++ single-line comments are one of
> the few things that language got right)

Well I'll agree to disagree with Linus on this one. It's ugly as fsck
and allows for ambiguous statements in the code.

Jes
