Return-Path: <Vijendar.Mukunda@amd.com>
X-Google-Smtp-Source: AB8JxZq7UuuRMi1b3M0+Pvt/OuzfLCuMNU2KGwNblyPrfUjlfO2hL5GUat7RwmrBHNNU4jjq67zY
ARC-Seal: i=1; a=rsa-sha256; t=1525076124; cv=none;
        d=google.com; s=arc-20160816;
        b=BJrBNjG4/JUk+6HhzaTpUZneP0GAe+tNjvr6BrwNh02Dnn4O+V9swy4RNdxcz3KPKR
         gXh6M43JlNntHLIwYjcFzLjJT4BpIBVBG3GAiaR5lqdvqgktGTcslwtPDZ/FQKFfeZ/W
         rKmBJIywSb8ri2eVoyWxOiUhq8pHezMh30E5xDVxKyk3qrKJUWolfdoFkIcQ6sZqAsnn
         QjXxh3gPPSC1FkDjph2wZTAkp+zcgdR5QQcjXmhVaAcFQPVIYiBgm5qkEvG6juu66WX7
         ooDwbweDkfL4ndXql27M95DmnaEzV0alAsWIHhbym84GgpwQbGaDtHnL4/Tf7ezgIriy
         724Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=uxM3ZRWUxPM50BVqFo+mxg5ypSv8wehsGjmvFwastpA=;
        b=eKayppnhiyH5DkQRKCrwSZH2KP9aJJIbgM1vGTPQB4tYXJFR9MiXZ9pPYcagK+KfAG
         /TCbZHIQ/3dJ0G97oCkVnJcv4CPQSgI+fylEZFL8rMMRqX10Wu7oMGIV4OYxsYVeH8Yz
         SyWm4OszkYRRQ5SmA68bJUUWz6T/18Dx1TWRUxlE7TqQJekBOsnYjbfwaifmn4LU+DfA
         9ZmH/uvkPxeyEODG5z3imefjwAyE3n5P/HKgAZ0ihOTp4zOXIkJe+QZA8QimGrZ5IZ0p
         FNaqmaI9XzH/PT7QdY3LKh4Q+RKVqdWbKP3t4kMKuihhPI8cb4DxDFpjjQV2nfoI4NCh
         q0rQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=aQvS0TuV;
       spf=neutral (google.com: 104.47.37.85 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@amdcloud.onmicrosoft.com header.s=selector1-amd-com header.b=aQvS0TuV;
       spf=neutral (google.com: 104.47.37.85 is neither permitted nor denied by best guess record for domain of vijendar.mukunda@amd.com) smtp.mailfrom=Vijendar.Mukunda@amd.com
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Vijendar.Mukunda@amd.com;
Subject: Re: [PATCH 06/11] ASoC: amd: sram bank update changes
To: Daniel Kurtz <djkurtz@chromium.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
 Akshu Agrawal <akshu.agrawal@amd.com>, jclinton@chromium.org,
 Guenter Roeck <linux@roeck-us.net>, kstewart@linuxfoundation.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com>
 <1524741374-13523-6-git-send-email-Vijendar.Mukunda@amd.com>
 <CAGS+omCG+=UL-ZFA6STjnDrnG2L5jqwUGjcE+Db2P+VYyzFL9A@mail.gmail.com>
From: "Mukunda,Vijendar" <vijendar.mukunda@amd.com>
Message-ID: <61752418-ad49-adf7-4ea4-e420e21d0492@amd.com>
Date: Mon, 30 Apr 2018 13:47:48 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAGS+omCG+=UL-ZFA6STjnDrnG2L5jqwUGjcE+Db2P+VYyzFL9A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [125.21.194.1]
X-ClientProxiedBy: MA1PR0101CA0048.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:22::34) To DM2PR12MB0315.namprd12.prod.outlook.com
 (2a01:111:e400:50d0::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(48565401081)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM2PR12MB0315;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;3:9QNYSPyjuT5PgWi3J9RSXizgzmfhiX0LNIsvunQpKRo0jMZmUqTQW483bEV1fprqQHJjZmh6RWvtES4MPNp/kpM+3QZ0rX+fnOtnmKbIAnat9oQpnhSQmL9nApjTPwtZX0mD1NRxWWNo4JpkA0a/Mr//Gqhyuv+bZ3DUUpX5Y8nILyLIkQLc0BuIrS7tNKqOLgAI7hLuxZXvwfP6ny9eNlToj2dSgjEAexFJG1tm4l7/CBGJpIsukzkMKhWlkyzV;25:7+3L8/Ih9zqEFwWB0K8azUtW+m+KMwxneaZCSLsU8ibjmIuJBFoDI/F4ZPiTuy/bZ/MT+nipo3hC9e7dupJWdnhLKT6Ja2oF3dHmYY/Fbj53IagKLbrMZsCNVqXWXtjfXPDpzD5ujLIRmWjZI4J+OaBQ70KvFAm1tTdbj1+FhC5jnqYma1061mre5mgrtHA0DQup+1Up5t23X4QEjF2OpbdocNsJ9BXE45LYELzlD4YSpkmidC3TkeGd3SxxZyUW+U+i+W/Srkp/tOo9pDSJW7uV15Bc58nGSe92Em2EJQ1WOjXg/H8xK+77fpRZ1Jx3YTCECTdLAC0hMalWOjvLAQ==;31:1jOPTt6GsxwSwsSR+I6mIxzshaBzS97FZDFEixPgzY/tX+U1jYzK0gPAOAPjolE7BG2ws0cXY6iArdUOsxmPsvYx+Oj8BZT9agU/zLCKP8bOdQkAJtsXn6KwaaSU4x8VbB4uSZidUSedg9VRibeXSpwh9igjDoqJqan6Iw1oiIAgAdol3QDNpT/eGZ57NlkeIjKYLIocqogLI2lBRAGLyBX6gvImF5wbp1+K46AIR+c=
X-MS-TrafficTypeDiagnostic: DM2PR12MB0315:
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;20:hkwgBff6FZ6PxG/Z90d8e+h4sgQRuIbZu/rYrcjH2BNcUZ6pZ2CHTUhGx+aVbpfM0YGiUXWCoDstFHb5HHWOG9/apb1O/mcWGyJVLn1tSITwa3qcLA1BS+/ThZsFG4yEwzodEc01+WsJ4izBFzIDvFJ1A4k0wBJqGBcnheYcT6+/nrUUUCJJnMkjdNYuifDWUzTEUeEtSh5vv81sO/jr2tXGN9SxyPesKTGyNz8gY2U44Ksnxi5Cc4PR1oBR+0rI7ykZnrf5/d9kaZq9mSDTZzuU8F/Iba5TPYoG9rza1x8h0fJkGEddNTFAC8ZiVgUSWOiFMHTPGMOBslwecBpUl04KDYHFx6ikoI+NR1vyv5OdPkj+D1Rv68cXXBM3fhQ0LFXjNK/tjE4HlKVVJsqgFbdzZ7MfmAgjkTptNTFn+5kLTZNztSIJKY3Eg7Z8s/x9koWPYQhZs8xFoKMUs46gmJ4AChz/0wlNMpIDOQwelha3RxzvePaVJ3TSHKb4qJKp;4:ePSqnK6Zbg1lVf1uPgWgvnEmAx/eIns7twOBbDRlNt0WoFfoQcMYoXZ/bvYU2ZmwuTr03UwNg3Zu9uLQswTOmu1sVqxNJCl1QvTDWrLx/XO0n1qhCKKQzL+sKw9ycbNFavDaKJj+a4v+Nkh0LB5d3q2PPHHVdObMGSUA25+ssWe8MyhVXv+DP97NEqSkB2KDQdQJv8Htvl8nrZzryCG+RzB29yNdzbim9nZFteER8NyIkN66uFuQaQok7JZFcGM40sqs7RHpw9cdEuvpMOQ4FChDFnfEPeXTZTWpMFSUF7olrpA/2pbrFrzTnR1x8f0P
X-Microsoft-Antispam-PRVS: <DM2PR12MB031567FBD1D1CCC700FFEEA097820@DM2PR12MB0315.namprd12.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(767451399110);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(3002001)(10201501046)(3231254)(944501410)(52105095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123562045)(20161123564045)(20161123558120)(6072148)(201708071742011);SRVR:DM2PR12MB0315;BCL:0;PCL:0;RULEID:;SRVR:DM2PR12MB0315;
X-Forefront-PRVS: 0658BAF71F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6049001)(39860400002)(376002)(39380400002)(366004)(346002)(396003)(199004)(189003)(47776003)(305945005)(66066001)(15650500001)(97736004)(6916009)(486006)(23676004)(2906002)(52146003)(65806001)(65956001)(229853002)(2486003)(230700001)(16576012)(8936002)(316002)(36756003)(72206003)(58126008)(6486002)(105586002)(956004)(478600001)(6666003)(7736002)(2616005)(446003)(476003)(11346002)(54906003)(186003)(386003)(16526019)(76176011)(53936002)(4326008)(6246003)(50466002)(67846002)(81166006)(31686004)(106356001)(31696002)(7416002)(52116002)(81156014)(64126003)(77096007)(65826007)(68736007)(5660300001)(26005)(86362001)(25786009)(39060400002)(6116002)(3846002)(53546011)(8676002)(172123003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM2PR12MB0315;H:[10.129.12.246];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTJQUjEyTUIwMzE1OzIzOk8vVXZqeWlFYzUxS2JBelVRelFFdytxdGEw?=
 =?utf-8?B?UHVWK1BCczhNMjliWCtXOGZteGtGS01ITGFpN1R3UDJuc3AwbkJlWHF1L3l0?=
 =?utf-8?B?NXlFTU5yUStiVEdhQmNNbFd3bXdYUUFwc1VPNktYUUVsMXg5UlBiczFSS3o1?=
 =?utf-8?B?T2RrNVNKR3MySGtOUExGR21QZEp2TERuVjdmdkEzY0lqb0E2YlZmOTFtNGhm?=
 =?utf-8?B?bUhtSVF1cGF4djRJOFB0NzZaOWkxSm9RcnVrMVhMeXdMcUxxMmo5Zm9mU2s1?=
 =?utf-8?B?Z2ltUGxGNTF5ZjFrclZLOXhwSjdHUmhpOWtXbUFldTNZWTc1VTNVUC9Gd0do?=
 =?utf-8?B?Uk5SWEJUK1AweXJCT3Y0cTR4RUx1U0ZVSzYzSXYxVERtYW1tdFE3b3g4Sm9V?=
 =?utf-8?B?bHhYK0NNSkFMakdqTGd1MDB3NXhONmFjTlEwZGpQWStqanJtcFJuMllqWGJI?=
 =?utf-8?B?MG1oSkVKWmlOVHdUSHYyN2NnTXp0VWxOcmhEYkNSSGtZTmlKVnNuR2JvSFhk?=
 =?utf-8?B?REpvWXhVSlNTOUQ0c1FxQ0RPOHAva3ZDeW1MaXh0NldKWGNvbjNybzBPbHpi?=
 =?utf-8?B?eGV5eHk1cE5KTVFtSDJHUmhFTlphWVROWThKcFd3ZFhNRlJDR01OaGNpdHlC?=
 =?utf-8?B?b0dzM2RkdzRVNjhGZ1BDL0dlMlpsQ2QwUXBGalp0RzU4ZEs4TXd2SHExL0pZ?=
 =?utf-8?B?WkV3V09URmdCQy9MM1VwZzNrK3RKTzZSV2QxQnJZbmhQN0FjNERWNHg3VTN5?=
 =?utf-8?B?cS9RcGxveTA0dVFVQk5xQ003Y3JyWWJFTFphUU10eGh6bkxtUnJ4NERqNldD?=
 =?utf-8?B?cnE2SllNSVRGMjVUbEpmOWRSelJxSEE1RHp5Q1Fob0xmUHVIUDhlYmd5QUhI?=
 =?utf-8?B?VEUrMzhnYko1THBvU1hDcWgwaGo0VFJZYncza3NxMisydys4Q1NhVkVFQ05G?=
 =?utf-8?B?TStoM0xrY1I5NXZXeVM0MURXb25nV242K0ZKV2p5U0xhNU52akJndkhBNVBF?=
 =?utf-8?B?N2kvZEwyQnQ5NGhadmVJZVgxOHp4dzRPTUlST3FndTdBWFp3cXViYVVUS0tZ?=
 =?utf-8?B?czdHY0lSSVUrbndleGhLVVlmVnVNMWVpdlcyYWg3OE1OTTlST1FKNDFNR1V2?=
 =?utf-8?B?Ykw0QTRsMUEwbTE0V3dPT2FSU2JHeldHUFdhWlRrdUFQQkFxK1pUK2FDUVJL?=
 =?utf-8?B?T3RhSXZXWEx1NHFTbndsY1NoaklFTFRGaGJ3ZkZGTTIyd29uMmFpaDE1TGdn?=
 =?utf-8?B?SHp3Mzk0b2ZSVks2YUZYNXlQd3BDT3V1ZWRqOHVOV2kyWnBuY2VOcTIwZm1x?=
 =?utf-8?B?OEtLS1IzNE5KdFdiMTlZRDEyMnVNcWlKNUYyeHlSbWZJUk9KTWRxamhlKzBQ?=
 =?utf-8?B?MjNNWWdsWXhCR2xLWHo3MGF1QkdXR3VHNDRuOTlBVHFZN0NhZDlyRHZCTERU?=
 =?utf-8?B?eTJadm9URWltaGV6djNjTjhUeVdhZkp2ZmpqeTV1Q3o0dXdaU1NqbStFdzlK?=
 =?utf-8?B?NVZDUHRhbUVTNTRPQXNIS0JreEhKdDZ5TlFvUC9aeFpoT3AvQkxoZ1lqRmRG?=
 =?utf-8?B?bjdGS0llYVdzQzdIbDFGN1ZNOWphVndDSjJyYUhIZ2puVGNURDltOTd0b3NF?=
 =?utf-8?B?M0paeExTdmQycHk1dldIU1NLTmprZHRYMUllK2FYZmhhMUJVbEdRd0gydDRF?=
 =?utf-8?B?RzE4eWgrV1FuQkRsaUp1ZE1iL3NKcnpHNUt5VW10MHlKZzhNc3NiaEFGNDR5?=
 =?utf-8?B?bmZSZ0dpZmhQcUtQeG9icFRiQlFHcjdYZS8vQlRZUW1YR0x0bk1PajZYeVNh?=
 =?utf-8?B?RWc2a0M0UWh3a2ljbm9LMWM3UlhtVDdZek9LazdJVzdmS0VkRVd0NEg1aVRO?=
 =?utf-8?B?MDFLdzFMcW9NbG1nTU1UNnJlOWwybCt1TGRWQjdoRmY0Qk1uUFJGRkhhMkJo?=
 =?utf-8?B?c3N1dXRQVkJtWUwremttdlZoWW9xbG0wNlpzejVxQXp1UEp0WGRmVGM3WlRv?=
 =?utf-8?B?UGNwZVhHUElEd0l3U2xlQ2JBSWIyYVpvQ24wM1hUbmlENkNpcVU0SnRhM1Bm?=
 =?utf-8?B?QTB2aW1Xem5FR3FoRnFvcC9hVVErOGJMaVBlVUwvQ0s0bnJUOUZJTW12VVNh?=
 =?utf-8?Q?uwVQ5oomI0VmZ8SybfalvLQ=3D?=
X-Microsoft-Antispam-Message-Info: WELLdWr33l3zpV39JXVD2ojP8v7yLYOCEVZLPjeV8BAGa3X3wrBz5XPDLyI2xYUzU4Fk3/6Qi7ELn4441mn1bc8nKNjyjSlsyJviX9HsphCVewvZOJoQzY72yFCcfptBIGwkPUeFZWOH/HSDtuTATxfgG/jainxvZCSge2ykdai6PAEABuHzXpG/K2+HSaf0
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;6:kEeMFs5GbkaVl/eGvp7Vq0nbEiwnW+NOQlt3ELhfuiWyijF2b+8/x8U3zlX5MSrSDVEHz565D1nhWs0WTGlMwGDfg8Jm/7+eiv6IaviMtzVsf5xzprJoybZ93VKHYMdOPJCB24/Mv97oCENNeb3QHgxBJoCDUhL2A0ojS6Fq8PU3WaKGxe+RD8k+kBlwV7FkrTypt8BiWeMJvdgUQZup160TG6kii/B+cFYgHXU3NnX8o4g1vKPPGkzwReNPL/aP9aIitFrBsKC+NAX2qpxR190piRifbMliNuhJ8+Aj67ffPBNdtVbl3dk4KS6h5MJgwIOS3jkHohw1Y78gUc5JS23xCaA5m/0ooEaY7+apTbPaJRyAaUTWcKBdDV7rjW+X/Del9PVtXMvfJ4ipZX01Fu7gH+l8/S0X7HvIw+NBYL9eP6LKuYXyozEJIr/E8sp2UaimZMzpem7ErMGLs/IDYA==;5:Rq2IuE2C/AWHakSp1u1VlLtLoMAX8WkBSRFek6VaZzat5C3UGGOUbKHejM+medfqLElZyI1aT43COqQrTvVsSoP/1U9SrDPcx+C05iHBKuQWnp/dRRxdH8rClMzcC2Hz1i7f5dMu5SdHH29KfKZp7PCn0xSHD3E3FK/dQUuVSBY=;24:geNvq3NDIJsSyPF2vsQupczzdSZQU5ftZ9HUZlU348iBExvNpFJJU6ku9+4310AF/vzBU/ChvVM60fTqW+zx1NEYhFzJqzsZgnqRY8cIrgg=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR12MB0315;7:K7pGMv+RedaWUzUJGPDbruRUtlcOTZe5nPmvhKbN1afDtBtZNA9MZOx9f34JF27FdByGQOvjduUXe4ulM40GtezxbvkJ2mpDu9dFhcPIuG9rv+GOhEJv6lVY9se1PEFrdPFDC1zF1ECc4fXDdSjZBulvaDDedj6/u1W6d3u5Q6Hosk1CNik9R49cD8FaICVdDzrC8sPmxg32xHNBN+ZTXUunyax9PLp+/oNrZiEA/MZaOYFQY+XPwK4EdGTZw5gZ;20:qqHIN4oHpqKkJkbzcUWCwd2Qnir80tzadFb5Ubcat8Xu0LiY0k8oAGY5otRq94LEwMJ5YaRVcpXy17Sk/tnqbhJdT31byPCG0etDQeZRI84qqS4ojl5zKFJR889rQZPjKGhjoID+47WDnUB8/8kd2Lefgcdoq2WMIYFihH+C09lhAh1ScpE5w8vGANRzr/IxR4f1FXiCGgIPYLwtYvwmoyq5s5swDjkcQ0HjsjUduTCL/6dMSKaZEvMpPX+4/mXw
X-MS-Office365-Filtering-Correlation-Id: 674d2373-a727-4411-10cd-08d5ae728417
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2018 08:15:16.9808 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 674d2373-a727-4411-10cd-08d5ae728417
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR12MB0315
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598807235933868204?=
X-GMAIL-MSGID: =?utf-8?q?1599158222490190510?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On Monday 30 April 2018 03:17 AM, Daniel Kurtz wrote:
> On Thu, Apr 26, 2018 at 5:16 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> wrote:
> 
>> Added sram bank variable to audio_substream_data structure.
> 
>> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
> 
> Move initialization to acp_dma_open(), otherwise this is:
> Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

As explained in Patch 2 review comments, initialization part  we moved 
to acp_dma_hw_params() callback.

> 
>> ---
>>    sound/soc/amd/acp-pcm-dma.c | 20 +++++---------------
>>    sound/soc/amd/acp.h         | 20 ++++++++++++++------
>>    2 files changed, 19 insertions(+), 21 deletions(-)
> 
>> diff --git a/sound/soc/amd/acp-pcm-dma.c b/sound/soc/amd/acp-pcm-dma.c
>> index cb22653..b7bffc7 100644
>> --- a/sound/soc/amd/acp-pcm-dma.c
>> +++ b/sound/soc/amd/acp-pcm-dma.c
>> @@ -320,29 +320,16 @@ static void config_acp_dma(void __iomem *acp_mmio,
>>                              struct audio_substream_data *rtd,
>>                              u32 asic_type)
>>    {
>> -       u32 sram_bank;
>> -
>> -       if (rtd->direction == SNDRV_PCM_STREAM_PLAYBACK)
>> -               sram_bank = ACP_SHARED_RAM_BANK_1_ADDRESS;
>> -       else {
>> -               switch (asic_type) {
>> -               case CHIP_STONEY:
>> -                       sram_bank = ACP_SHARED_RAM_BANK_3_ADDRESS;
>> -                       break;
>> -               default:
>> -                       sram_bank = ACP_SHARED_RAM_BANK_5_ADDRESS;
>> -               }
>> -       }
>>           acp_pte_config(acp_mmio, rtd->pg, rtd->num_of_pages,
>>                          rtd->pte_offset);
>>           /* Configure System memory <-> ACP SRAM DMA descriptors */
>>           set_acp_sysmem_dma_descriptors(acp_mmio, rtd->size,
>>                                          rtd->direction, rtd->pte_offset,
>> -                                      rtd->ch1, sram_bank,
>> +                                      rtd->ch1, rtd->sram_bank,
>>                                          rtd->dma_dscr_idx_1, asic_type);
>>           /* Configure ACP SRAM <-> I2S DMA descriptors */
>>           set_acp_to_i2s_dma_descriptors(acp_mmio, rtd->size,
>> -                                      rtd->direction, sram_bank,
>> +                                      rtd->direction, rtd->sram_bank,
>>                                          rtd->destination, rtd->ch2,
>>                                          rtd->dma_dscr_idx_2, asic_type);
>>    }
>> @@ -795,6 +782,7 @@ static int acp_dma_hw_params(struct snd_pcm_substream
> *substream,
>>                   }
>>                   rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>>                   rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> +               rtd->sram_bank = ACP_SRAM_BANK_1_ADDRESS;
>>                   rtd->destination = TO_ACP_I2S_1;
>>                   rtd->dma_dscr_idx_1 = PLAYBACK_START_DMA_DESCR_CH12;
>>                   rtd->dma_dscr_idx_2 = PLAYBACK_START_DMA_DESCR_CH13;
>> @@ -805,9 +793,11 @@ static int acp_dma_hw_params(struct
> snd_pcm_substream *substream,
>>                   switch (adata->asic_type) {
>>                   case CHIP_STONEY:
>>                           rtd->pte_offset = ACP_ST_CAPTURE_PTE_OFFSET;
>> +                       rtd->sram_bank = ACP_SRAM_BANK_2_ADDRESS;
>>                           break;
>>                   default:
>>                           rtd->pte_offset = ACP_CAPTURE_PTE_OFFSET;
>> +                       rtd->sram_bank = ACP_SRAM_BANK_5_ADDRESS;
>>                   }
>>                   rtd->ch1 = SYSRAM_TO_ACP_CH_NUM;
>>                   rtd->ch2 = ACP_TO_I2S_DMA_CH_NUM;
>> diff --git a/sound/soc/amd/acp.h b/sound/soc/amd/acp.h
>> index 2f48d1d..62695ed 100644
>> --- a/sound/soc/amd/acp.h
>> +++ b/sound/soc/amd/acp.h
>> @@ -19,12 +19,19 @@
> 
>>    #define ACP_PHYSICAL_BASE                      0x14000
> 
>> -/* Playback SRAM address (as a destination in dma descriptor) */
>> -#define ACP_SHARED_RAM_BANK_1_ADDRESS          0x4002000
>> -
>> -/* Capture SRAM address (as a source in dma descriptor) */
>> -#define ACP_SHARED_RAM_BANK_5_ADDRESS          0x400A000
>> -#define ACP_SHARED_RAM_BANK_3_ADDRESS          0x4006000
>> +/*
>> + * In case of I2S SP controller instance, Stoney uses SRAM bank 1 for
>> + * playback and SRAM Bank 2 for capture where as in case of BT I2S
>> + * Instance, Stoney uses SRAM Bank 3 for playback & SRAM Bank 4 will
>> + * be used for capture. Carrizo uses I2S SP controller instance. SRAM
> Banks
>> + * 1, 2, 3, 4 will be used for playback & SRAM Banks 5, 6, 7, 8 will be
> used
>> + * for capture scenario.
>> + */
>> +#define ACP_SRAM_BANK_1_ADDRESS                0x4002000
>> +#define ACP_SRAM_BANK_2_ADDRESS                0x4004000
>> +#define ACP_SRAM_BANK_3_ADDRESS                0x4006000
>> +#define ACP_SRAM_BANK_4_ADDRESS                0x4008000
>> +#define ACP_SRAM_BANK_5_ADDRESS                0x400A000
> 
>>    #define ACP_DMA_RESET_TIME                     10000
>>    #define ACP_CLOCK_EN_TIME_OUT_VALUE            0x000000FF
>> @@ -95,6 +102,7 @@ struct audio_substream_data {
>>           u16 dma_dscr_idx_1;
>>           u16 dma_dscr_idx_2;
>>           u32 pte_offset;
>> +       u32 sram_bank;
>>           u32 byte_cnt_high_reg_offset;
>>           u32 byte_cnt_low_reg_offset;
>>           uint64_t size;
>> --
>> 2.7.4
