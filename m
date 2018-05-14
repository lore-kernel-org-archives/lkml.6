Return-Path: <michal.simek@xilinx.com>
X-Google-Smtp-Source: AB8JxZoeuB10xZngKHLbPK0iz2ZRZAqRhO91OZ2029dp021jMg//UmxR7tqTUDPdHdD5uUfcdIKy
ARC-Seal: i=1; a=rsa-sha256; t=1526301914; cv=none;
        d=google.com; s=arc-20160816;
        b=NhL9EuhrvbBqGQqz7xxrHM36KSrcCEaqqnp5e8srdw9iV8PUT4+SYqS9tbrqawJTOR
         cG5+3FVlcim/sIjr5RxQ1i1vkpmfwLyJjk9N//kTig1iGqMFen8UGajDva5R79JUzALf
         ANpCNkHDs7pygB+UiQFB80vMG6up6EoTu81Gdul8h0d7oQhz/oSITZ3K/FYiTkZotIb2
         xZIAXxaR7sLyGUYim0ImfZRIEHP31IB7qNpp76+vdukZXlG4hXheWJwEBB4TahZ4BZ7P
         2jLqSa2zIYk9B4+299I6x2HXDLfZrVklAwWXBs55XXCsGUF+jF+yKnrd0MIvRLu6QIap
         3toQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=szqCstdEO1CRkO+w0E5MWkggj+4t8+gQl1gKkpMous8=;
        b=pDkjU7M0dw1fIbdovwkT3EoqZDaBbNtj0/2ck91oYGGlqcYS8eRvQ/KcJH1pU43qjN
         EVNf0Z37IDDWm/9jL/5DT94/WA0WTGc97Q/+wxqzQDv0g0MUdLb5ZZ1CtrjPpqa3olod
         Sda/d8CPY9p2PvLW1d7dANnwm0z5FlZ6jebVDp0/hDnSvD2BR+G8rlkQmj/XpeR0eBiW
         4VCrbwgB2M1KdW7FIIdYPv6VMDoBgANTYCdJrOC45+d8QDCZh+aJwUTex42kYa8EF+8M
         EaRMhKCXUXVqk/aMziiwalqyZV0zdsnP5I04Ok83amfPf8nwushjBXoqwTZ2NIt5Swgi
         QoWQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=0DUme3s7;
       spf=pass (google.com: domain of michal.simek@xilinx.com designates 104.47.38.70 as permitted sender) smtp.mailfrom=michal.simek@xilinx.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@xilinx.onmicrosoft.com header.s=selector1-xilinx-com header.b=0DUme3s7;
       spf=pass (google.com: domain of michal.simek@xilinx.com designates 104.47.38.70 as permitted sender) smtp.mailfrom=michal.simek@xilinx.com
Authentication-Results: spf=pass (sender IP is 149.199.60.100)
 smtp.mailfrom=xilinx.com; siemens.com; dkim=none (message not signed)
 header.d=none;siemens.com; dmarc=bestguesspass action=none
 header.from=xilinx.com;
Subject: Re: [RFC PATCH] driver core: make deferring probe forever optional
To: Alexander Graf <agraf@suse.de>, Linus Walleij <linus.walleij@linaro.org>
CC: Bjorn Andersson <bjorn.andersson@linaro.org>, Rob Herring
	<robh@kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE
 TREE BINDINGS" <devicetree@vger.kernel.org>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Grant Likely <grant.likely@arm.com>, Mark Brown
	<broonie@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	<boot-architecture@lists.linaro.org>, Linux ARM
	<linux-arm-kernel@lists.infradead.org>, Michal Simek
	<michal.simek@xilinx.com>, Jan Kiszka <jan.kiszka@siemens.com>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
 <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
 <c6655f84-747f-c08b-7b9c-f76ff8857567@suse.de>
From: Michal Simek <michal.simek@xilinx.com>
Message-ID: <45eca00d-57f5-21b5-1f6e-b5f3f60ad276@xilinx.com>
Date: Mon, 14 May 2018 14:44:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c6655f84-747f-c08b-7b9c-f76ff8857567@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-Product-Ver: IMSS-7.1.0.1224-8.2.0.1013-23620.005
X-TM-AS-User-Approved-Sender: Yes;Yes
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:149.199.60.100;IPV:NLI;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(376002)(346002)(39860400002)(39380400002)(396003)(2980300002)(438002)(199004)(189003)(31696002)(106002)(476003)(47776003)(86362001)(2616005)(8936002)(9786002)(2486003)(106466001)(81166006)(81156014)(23676004)(336012)(5660300001)(8676002)(426003)(65826007)(7416002)(356003)(58126008)(44832011)(486006)(110136005)(11346002)(446003)(54906003)(126002)(316002)(64126003)(230700001)(65956001)(36386004)(305945005)(65806001)(6246003)(2906002)(4326008)(50466002)(36756003)(31686004)(63266004)(186003)(93886005)(478600001)(53546011)(229853002)(77096007)(59450400001)(26005)(76176011)(6666003)(107986001)(5001870100001);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR02MB2615;H:xsj-pvapsmtpgw02;FPR:;SPF:Pass;LANG:en;PTR:unknown-60-100.xilinx.com,xapps1.xilinx.com;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: 1;CY1NAM02FT054;1:/LSuZAG65YkOoDYNiBdBUooJA8Mdnlv7X6kSnrJXhnozGfz3toBC3ZUp/3p8rfGVLgUm6yl7FrTJX2v2oezecGzrwTRGd/oudUfQIY6YHk45Cqpq/p3HRYZIU+EoULMW
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4608076)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060);SRVR:CY4PR02MB2615;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2615;3:OmceOPhJqlL11a73s+GDCQTX7+43kHtgqjSkV0cx6YsgOgMymdJYjTMRvNEvd7/b0BsILIkCn3EcYGfNlfbrUZoijoAcbXXFtgvg2NlO67BOCZq7xgV+WRkeKhIhELdjvmkS+WAocU5mFQzfe17M1P17/I1CUHy+rLoXTZDcf3L9b2VfS1ymKFwXgjSazwW2J4rrdPVuO6s6iovE6bZok0UkxpEkVO2bwMEDfkHODdKsnpv7euO6M0kOg0ZQqa+NbX6QxfKsacXt9I+A/wEwQJ2SDwek0q28i8hS1G/ey8BpPdajLhTu2+ABtFn5LGR1fAO8UeHufTKFmgrbeVXguaBZROXylefezOdgDZWCb8Y=;25:wmetxSeWtTGBzIVs9YC1xz6HDLQ3NI9NBjeK86FeE6BbeeaVlXKukX3N2w25QPDWru8H50EOifVnuWWnteMdl13fKFUJk83bEAOXeMYazffRwibUZSmymXflSGi2n5vIkOBk2/aBTgcGtARK8HiNKYOCNHu7NOKLkrI9SrBvco0NIa/lBgmoOFn5O5zSP1zliDhTi6RmtTCOOypjQU6sTvrFIJog+4Y6DIPJKbJRH8lUOtAXJOE92Gi8kb6hMLlT+FC6QH3eH3rsm3PjfyJLQStXGFcxDLmTwPfjMovKfTSpyGLOYNJWzCE4zxNDHYKdgSVqYi6lcjnAtpNgz5z7mg==
X-MS-TrafficTypeDiagnostic: CY4PR02MB2615:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2615;31:aZpr7CYV/7n5YyGe7eSDf7rMqDNF1hqgZ/1Gmn+ufuIUttfVphpGSTk69FVNO+MIgnBChJE2R8ojT1y1dRHpk8vd5UM1NPXmu+fyR7W+nubKFDW2mVLq3fwB5my1mIk2PK9+3QkqOz1kc5PSJLhaUgAx8YibSA3QPbBHciPYfUcB5MmkllSyI3sZlNRj67rnQq5rJEDhV35WtD9BEp0KeBcx0Tnqhwl09i+sPGSY7A0=;20:NgQ7qTtJz59g3GgekwPIdD/UipFqaXUt5kCmTn7tx5DOH+dOitVuYXRur+1ZmItCN0jQDfrlDuEvdL7o/Uhb7N2zOvHwSbTirtzDqxqY3kbQsLc/ad6wvFeyzSxr7u69NBSh2GMk0A4sOinIlIQVRO/cFExOvN8YiWuxHlTZd5PJWk4gouOfzN7X0Wz1S2K4TqLHx/R1OlGWUrgP3oidW1EZP37S7E8GgLmYZDAZr67bNgW9AOolgokylIY1YSfxS6i7lbXUlESUSsCran0kx8c06fxYhuuP3qSsLJUsmx/IAAbxCK4a+y0ECVJbFLzgvPgK0ySMGoQrm1YSXsHGDXhobd7KPE1X9a/feEpyxHwOTmrYCi3MDZUWOnBs3/XcCzxR1EJ28L5pZRkwYpCtq2DywcpbhYVW+1fAzWvy+sViRUNMg/Ezzyn+yilDbX4cjLZFkZRPfbkYLH3y9pH+rbLIICTjswmxwywhZzFIPxl5vvT3B/gKJ8cWwxNmLJQI
X-Microsoft-Antispam-PRVS: <CY4PR02MB2615428651820F3B456E88F3E29C0@CY4PR02MB2615.namprd02.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(192374486261705);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93004095)(3002001)(3231254)(944501410)(52105095)(10201501046)(6055026)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123558120)(20161123560045)(6072148)(201708071742011);SRVR:CY4PR02MB2615;BCL:0;PCL:0;RULEID:;SRVR:CY4PR02MB2615;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2615;4:voiFwH1IfVNoMgTNqCdAsCV1E7a0FDKJGvvST2a74CYcHcwOZ3mgBd6hY+Cq/CaZewoACYwPf+aKYRbmkz1mIaz3SeuRR9fCmnKED7n3SXKfbl6PHdQqaDuA8x7y4NBD4uAH506FBBv5zFlCRsc0UHbIzrtkKff5rw3ScX77k1wwVhuB3NZXoPp7bcRhdplhq3oG9t3FDf+hie/GXfsacVy1be2R8q5Cgavp7BQO5orLHFyGKZRmVQCXcnt+thW8F+GYh/ivvaYS60Cz04sRBzl3w8hpxdlBBhrt1JLLMC3Z+OJK1VqmOMcOt17Jtbq/
X-Forefront-PRVS: 067270ECAF
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjAyTUIyNjE1OzIzOm9hOFZkS0krcVpXNGlscHZkQVZrbFdvbzh4?=
 =?utf-8?B?T2xSSnlTbXE3Q2xOMDlpbXNMYjRaKzdTbGhyWjN5T2VCU3M2YXM2WFBvcFhJ?=
 =?utf-8?B?enVtczlUWGNMeVUvUGRqT1IrcjY5a1ZPek1yLzJnSjk4MnNKRUFSMGc3MnRt?=
 =?utf-8?B?dy9DQnk5STJWYzBsZDFRbjRCTmlOV2J6RGZxZ3NabURFZmVPY0lxWG5QUWZZ?=
 =?utf-8?B?L2prSERRcGtoZHpPSDlEV1FhNWpRS1ZGWkRMTGlKVVNLbUNGUDRWOXllMlJ6?=
 =?utf-8?B?ZGM5U3RIc2xRQzJvVTRRY1IzbGJJL2JOdjlHdk5hT21uL3dDa0dkWFlPcmFN?=
 =?utf-8?B?dE1rcHRQaUJSZlNHTXpVT1N1NkxUU2lzZHdybkxTaWxGZmNsSGpNeHpyZlNF?=
 =?utf-8?B?Q0xPOUI3b212a1pCMkJzbFZzVzMrclR4ZFdZQ2szREoydWhCaU50d1k1aVhP?=
 =?utf-8?B?L2MwVGx0UHZsUjJMYlNFZEtIM01YTTY0U1VWZ1VVcDQ0YnB3V2NtYkRkNGNL?=
 =?utf-8?B?ZkVIZmQwdG5sV2hwOGJtQ2JCZmpDVnFiM1hSRWtiRnRsQVdmNVlZNWw1Ymdi?=
 =?utf-8?B?dDdOckkwZWxGb1dYeWdlamYxbHJ0QVhtNTZrQVR3WE8rY0lHOXY3dlFDamQ0?=
 =?utf-8?B?aVVjZGxTS0N1cCttZXhmYkF2bklaVW9xTnNkcG9VRkhvQ0hDUzROUmlrRFlW?=
 =?utf-8?B?R3ZIWDhmOGZGK1V6TmFqaXg1VFdMSzhvSElFOEt0MlZwS1pvVmdVaGhTbVZY?=
 =?utf-8?B?QmxSUW5xMGR2b0RaTGNTNmtTamVxc2FiTDhVSVY2WVNYNHA2WEprRXRMZmFo?=
 =?utf-8?B?NmdzWEZNUWd2eUh0U1ZnbVo2SjQrREJwOWFtSlRXQS81VXJrNzlQeGxDd2RZ?=
 =?utf-8?B?c0M1MFp4cjRNeEFuTFJvWStxSXFNaVZmMk0zMXlVWCtVbU96UXdmVkU1S2Ix?=
 =?utf-8?B?REczMXRsUzg2ZzB2bXVXWUhMOU4waWVnUEZtSFZCUUlMS1doTGdBaExWWnJ6?=
 =?utf-8?B?SW5SUkJOejBVSmV5eU5Ia2dKdGd6UEZ6TzJMZHNvdllMalZNQWZDcmZhMGwr?=
 =?utf-8?B?QUtuK0hOc0VSWUhNMG1SdXFMWUNXT3d3RStnUzlER3l3OVV3OXF5OXNoRmZB?=
 =?utf-8?B?OGN5TUd4NWhIQlRUQ0VLS1NDZS9oK0tiSlRpbUJSMFUwa25nU3RtSHNkbVRR?=
 =?utf-8?B?bUF1clp2cXZWYTMwWlNRcU4zbHNGb2NhaHljZjBPSkN0UzVhWW5uR3Z5MzRp?=
 =?utf-8?B?Uno2aVFBWjhWUHdlUnY0UEtGc01reWdlVDgxWEpJVDdENXlFRzBwY05Jc2ZR?=
 =?utf-8?B?dXFKTUdqemJlZEdCOW1xNDVVbG0xRHBTdU12UG9wZXVUQldRcithOVZ1MFVC?=
 =?utf-8?B?TEFTaVFCQ0VtcUtoNk1ZUndJNVpMdnlQM0dkY2pyOWNyTGxJamRnSzQreGZz?=
 =?utf-8?B?NkRtWHdRbVRzZUYxclZyTUN1Q1lMamJmWVMzQnBnMzUyVHRBZlRaQXJRaUNM?=
 =?utf-8?B?QzdmTzNCazd1SzY1VjdXWDRlWHRaSWp1ZzJyL1kyOTZJWHBQU0lCREU5U3Rq?=
 =?utf-8?B?WFVzOCtyV3FNYytMSHcxSStTUmVKSWlhMVM0SHFONDBQcUgzNk11VFpxb3di?=
 =?utf-8?B?SjNRNmk5WSsydjhzaGErcWg2QWFCYXVCR0R0K2QvNWhCU3A3eDJDVU1HV3pk?=
 =?utf-8?B?elVWSzRyTGQrMjVRNFREQS9CNWxaNndLSExkZHlwNVpDUVZkVzJKbVVLVHI5?=
 =?utf-8?B?b3NZRW1NOEt5U0t0ZlhWNzNGVUlGZERoQm8wOTMzdnlIY2d2aVRMYWZQdlM3?=
 =?utf-8?B?RHpocFp5ZHFSUk5XS3pGSko3U29VdStENDh0VFlvTFk4alNRVi9RRVprcUhy?=
 =?utf-8?Q?S6anU2sTJQuYtNaSbJ5U7mnJwL2Sz73g?=
X-Microsoft-Antispam-Message-Info: f5GZa1GchZ6tn5PAs6CDAfWeqEIl79ybjxqx9KI3ZFsO1w/G25BeHbdDDJOrJysjE2YbG5+wk2z/1kQ843Fx9G0WBCswaxYaQyrpg8Nmj4RDQrGhEyrfjxChUyfpWYB3v39bN9e/4IJrDQhw3AvXSk37/Oof5peTahRNQLzT+fJD8WM2WV4NuhNuDUuao7Ni
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2615;6:OH6QB1nnSucRPX+lADED0XvaTiZHN4hAC30Gp9b5jNt+3ppU5drTIDAE95Mx7VeKBxm0JwKz1lSFjlV3PgoYUbmHJ+iWHkuuXD6+hwj0mdPO3x615ocAreOVuPDgGTRluGbuO5rSWXJ/U03AaT6mZPXM576G/Z7aG1ucbJdOmXqEx/zWqQ9M/aOsO901ZW+T+u0+OFa1/tOlnNGctEK+h8TH7Fjvd5Phdc3iWWZ8Yc1XRh57ADSX8nV8rmxIxvqY+z+tXEzTjIfJS+8wLvle/lZ6E/jlTQ4uEWx8uaVZOuQEhMw7lxkTU+JVJUB8g8kwp56HTbP41+8z3TauXcJ12yH3asZg9G1pamknq3O/a2YVvpfZ6AKzTGN88r79H8HffeGo5ajwFX//iGyVZNsypRdPmSb+llHCvJb3eNaWj+vDgPXom3KJIunEHrWqnJeQTwk0KwIWHgTatGi9ZlPFLg==;5:Axyb2VlwrvZAL5EhigYNFl9nOozz354LJoNfTvJ+i/X52vG51AmZWUhwwUyAYx80QDCae25jM44vxzwfqO7KpWevdCvGg2be52c6CdPwh6u8kCO3qe8DUcXJ6IEGk27Uw7hdnjyhRJnCpjMg+Xi3mN62eDJJ6tZumWFGFDX/2fA=;24:0srYgFqCDX333WUqdOCZuOSFZVkhAADluPyZmBsqKWtCyyRtMlu8UGJ8hZdxT4+ZBNuNfXIDLBee6q4CMWDgtSgUShUZMXoAaUWmSo7QMYI=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR02MB2615;7:3wYdFGS3TbyVZiCC2eYrE02+Ml94KqJpP2BM5shrMD/SDTmndJ+oHVTQg6ftVFabhrRpSYRt8BozFMOJx7ma0+zRAXjbpa1XqFYA2C3WRQyX7+73t+IqFhd5fry47dHpeBCY0yqOjbAqfcObMKjQGWbi54XW0QOJstkIzTg0SmfgbjSUWVtbYR7nbzVtVhl7qAurw2BoqA0VEGA807ZAjgeiZerRWNXvS8sxDvJFyEdalfpbGN+AvujRepUA20SR
X-MS-Office365-Filtering-Correlation-Id: 1e6a37fb-57fb-4c51-1f61-08d5b998882a
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2018 12:45:10.4047
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6a37fb-57fb-4c51-1f61-08d5b998882a
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.60.100];Helo=[xsj-pvapsmtpgw02]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2615
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599298891509345819?=
X-GMAIL-MSGID: =?utf-8?q?1600443556724127302?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14.5.2018 09:37, Alexander Graf wrote:
> 
> On 05/14/2018 12:01 AM, Linus Walleij wrote:
>> On Wed, May 9, 2018 at 11:44 AM, Alexander Graf <agraf@suse.de> wrote:
>>> On 05/07/2018 08:31 PM, Bjorn Andersson wrote:
>>>> Can you please name platform that has enough support for Alexander to
>>>> care about backwards and forwards compatibility but lacks a pinctrl
>>>> driver.
>>> ZynqMP is one example that immediately comes to my mind. I'm sure
>>> there are
>>> others too.
>> Why isn't that using drivers/pinctrl/pinctrl-zynq.c?
>>
>> How is it so very different from (old) Zynq as it is already using
>> the same GPIO driver?
> 
> That one is very simple: ZynqMP is usually an AMP system where Linux
> doesn't have full knowledge of the overall system. IIUC they have a tiny
> microblaze (PMU) that does the actual full system configuration for
> peripherals that may interfere with each other. This architecture also
> allows for safety critical code to run alongside a (less safe) Linux
> system.

Linux is running in non secure world that's why Linux can't have full
system visibility and Linux should ask firmware. It doesn't matter if
firmware is running on specific unit or just secure SW in EL3/EL1-S, EL0-S.
You can also configure ZynqMP to protect these address ranges not to be
accessible from NS sw.
If you don't care about security you can use normal read/write accesses
at least for gpio case. Pinctrl/clk will be driven via firmware interface.

On Zynq we have never finished running Linux in NS and having firmware
to handle it that's why only read/write is used there.

Thanks,
Michal
