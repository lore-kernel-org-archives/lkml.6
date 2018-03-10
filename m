Return-Path: <prvs=6607fd51d8=ast@fb.com>
X-Google-Smtp-Source: AG47ELuFofZw2BzHOHk9VjGNjih5J13OXfvVtsAtX5u4bKL42Y0gGIrBRdyNoby3NTuiDalV1ZSF
ARC-Seal: i=1; a=rsa-sha256; t=1520646232; cv=none;
        d=google.com; s=arc-20160816;
        b=wrlmCoTZ4CK2CDR6n8AoZDmvft8qLuUJiT5BA9bNcHv47fLvYv6BX8h3tUA2uVGHMx
         yX77rpXvM95HGZffsIfnz8q9A/IHe2HxC5A2b7llR4Jdt/c8SW9GYXZOXfLtIA/2a7mY
         jGFx2JyR+JF8s9VvLvClB9yGhLl6qIQPrbENWxc8tqk3ymDxE0pSvVT8XOuwdfbgO5Qu
         uU7SHl4Qr+yPGFCRcK6wilUJt9qqWNmp4qInIUJzkULgTdPUXZuoP0vHBFliIGT7Yt3G
         WDF/RJoDUVOmTt+td+pDQsQ9K8m3yuCtZaupYbsYzcNP20Xtfk29DbmPCj2QS1J4QbnQ
         OYBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput
         :content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:dkim-signature
         :dkim-signature:arc-authentication-results;
        bh=A2lQKeOLqZx14TQVoKSq8J8IddrQwsTk4Tn14ljD2Cs=;
        b=UwjYizGbD0y/Cc9QpyEKngjMeB94kKUs91hzHl6658BgwMWqVrjGL2uHe5i5y3vOqJ
         6j3FMjeXwAU6KuY4D5QiqTiw5LpE6NhbzflSbBaS4fCF/ir5PElGtokoZ2bYwFqRISnO
         HwgOI3QoyNTS4V056d1AAVrXDnZu3t/CB7NXvjipsWZZD0IG5seJxL3Bxl++OejsAchI
         bPTzN0DAvIZf4LYr+2lo7Zjwx37oqfKGoks03a3+Rg5imvr5lmqAyv52uvosxSPuGije
         UOw2ryY4y9K8nfD34Vcd8Ay/6Ydrv/KIdwLZak/8z5gyQ9dyfq+CMCZpHq7jwnMPgGq1
         2Tkw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=ffp8mI81;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=cNS0FV8G;
       spf=pass (google.com: domain of prvs=6607fd51d8=ast@fb.com designates 67.231.145.42 as permitted sender) smtp.mailfrom=prvs=6607fd51d8=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@fb.com header.s=facebook header.b=ffp8mI81;
       dkim=fail header.i=@fb.onmicrosoft.com header.s=selector1-fb-com header.b=cNS0FV8G;
       spf=pass (google.com: domain of prvs=6607fd51d8=ast@fb.com designates 67.231.145.42 as permitted sender) smtp.mailfrom=prvs=6607fd51d8=ast@fb.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=fb.com
Subject: Re: [PATCH net-next] modules: allow modprobe load regular elf
 binaries
To: Andy Lutomirski <luto@kernel.org>, David Miller <davem@davemloft.net>
References: <20180309181527.GA15803@kroah.com>
 <E622B120-3C3A-4A15-8E1B-6F7649038623@amacapital.net>
 <74e26cc0-9e72-f03b-5396-f3480921f234@fb.com>
 <20180309.135550.385837861865623769.davem@davemloft.net>
 <CALCETrWYDfByh7=xiO9T7_fFGMwMvZxUu40bkMdO9HE3E6=1VQ@mail.gmail.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
        Linus Torvalds
	<torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexei
 Starovoitov <ast@kernel.org>,
        Djalal Harouni <tixxdz@gmail.com>, Al Viro
	<viro@zeniv.linux.org.uk>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Luis R.
 Rodriguez" <mcgrof@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel-team <kernel-team@fb.com>,
        Linux
 API <linux-api@vger.kernel.org>
From: Alexei Starovoitov <ast@fb.com>
Message-ID: <64a80f5e-25db-5413-ab50-fb122bc22d8c@fb.com>
Date: Fri, 9 Mar 2018 17:43:12 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:45.0)
 Gecko/20100101 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrWYDfByh7=xiO9T7_fFGMwMvZxUu40bkMdO9HE3E6=1VQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:180::1:7688]
X-ClientProxiedBy: BN6PR06CA0014.namprd06.prod.outlook.com
 (2603:10b6:404:10b::24) To DM6PR15MB2508.namprd15.prod.outlook.com
 (2603:10b6:5:8f::10)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f1756220-db66-44d2-4e43-08d586284e3c
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:DM6PR15MB2508;
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;3:BQFuuROWVh2hI10rjghZYzfMCH411mV61bury3MX+R+VfDIPMn5V9hzsEdGuU/o1sjoKd7BPwe6D+tm2qop5MVWkqY95Wz2g6ual3WYhp/CcOCR/j2K8D7kDL//9GDAavZOOa0ELxijmByxaTG7K/Qwfu/DPyctdgamwvXwKkjUj4mEC4B138S1gyMdJFsjdkidp77bubfSLimDJpH/JVUh7/eK32y7oGhAQoMwPTCvSdylmH5+2pAukzjklAp/7;25:5frsRTjgqWmKMJaCTZ97nAeKE0HqozvbPZeO6hyBEJ38JUHgYufc7h0UK4GAAfh7E9+dpqgP+WaYIr86AvJZ7+qY5sC5EaYr/aLDER3SnT8lIrUuLMurORR3qLTmW4xrPtV3OcruJIIyqZCpWsSjUifvS62t93+9onuCsMLnnX/OyL1ghVQvAd6Ugzd9Pe0xB0/J7kyt58GWB3VM/7khMkwdpjnofkjpS7Dj9uoNG1NOuJhbtiMHLQXlg9kEVY7XNMBWa8Io8583JpIVlXwqc/MhH6lILN+jYIy01J3yYdOwRp0rLeK8mLB7q2R/lOVJ7adBOixx+oOYrjJHyswi/Q==;31:3VQJo8h0Wwj2OQ4AmGFQf+HL83184JNGaGyGq4Vju8+FhHZ+sopNRl0zepSGgCF/wpZWf6r5N9jFS3D0SF9qX7FTzBAnMVWGktmdTWcqgHO87cQr5i48DtFSGMIa57DxYdPh4e5UHjGacH8vRLph0IodUy5DXSKI5xryY5EEpcmEfRe85wI6PYSdH1go4ygYpTVN/F/COu5fabrVkkVrEaOaICuuct/7S8kOlm+/eh8=
X-MS-TrafficTypeDiagnostic: DM6PR15MB2508:
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;20:lW+kHUEBjcCP48wEmrU3B51S4+KMkCs5kK1ZopSearJreWRxyIWt7uGIN2R/+VTN/AA/JqkEHXasbpr/pUEm08Uue3tIFZ+iceLcPXMOsvhDcki9ReiOqii3x8i4XcWmSUF3EJ92JFQ+mYOKwbxlm2snQiwhYiHLIn9fwL23aiKXpJVzPT1GUIx5pySbI5XFsOp4S90EP0Ai2BP8qXDXzTGSTAAH3dSxazhrpFW5EYDtTo8eMW3bKTEsn1r4j9sQi51pnPAoXFgUXGdEN0nggas+mAaEyPtrR6ld8w3dM7ew49MTfocbZQPvo1omhaXT1u/672anCmg2r/nB7FarunIqfPQSf2PLe+qqayadXTg+R6nF80jYwV4sJJud5eSU9l2lHEPue23kNNwlMiOoNVY+KiWWV7RHvcCP0oOs4vj1DG//MteQW7O36y3vLmH+2Ossl8SvNL2ecIbC9jvYdyGkBq/BG5CJWynCVEur4xCuUhsvA4dHvjq5DmayxXoh;4:o31MLUym2koTKSuzca0Ps3rMVd9wQX2n5U+8xrY9SZithpHPcxrXgvngIwyUIfDvQgjRF/k5mlNZcdqTPAdYnGaS25LjLTf7Y5GcEXKhuNMaFw/tJTB1MVz4pEET7vnr4wvufO6pXlfURE5WS1iUhy73VOAYDSNXiXYGlqivkdOCyijXodk6mVYPXMqy3oz9M2mL2WjMTXm4KofMOzbFlmzrvgWjQPejNzDKtVnVBnLDOFVjmfQlQ5jeGKa/7ZPQk3wiFP1IfNCApZSr2ESoTFaIs3I9PFZ1CV7EbpBGQPFykUlgdVldpicxlN04Nm2b
X-Microsoft-Antispam-PRVS: <DM6PR15MB2508AA1B142368733F1D522DD7DD0@DM6PR15MB2508.namprd15.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(67672495146484);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(93006095)(93001095)(10201501046)(3002001)(3231220)(11241501184)(944501244)(52105095)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:DM6PR15MB2508;BCL:0;PCL:0;RULEID:;SRVR:DM6PR15MB2508;
X-Forefront-PRVS: 06070568C5
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(396003)(366004)(39860400002)(376002)(346002)(39380400002)(189003)(199004)(2906002)(76176011)(50466002)(65806001)(5660300001)(52116002)(186003)(16526019)(64126003)(65956001)(305945005)(68736007)(31696002)(47776003)(7736002)(23676004)(2486003)(36756003)(6116002)(52146003)(7416002)(53546011)(106356001)(59450400001)(229853002)(67846002)(52396003)(93886005)(386003)(1706002)(58126008)(8676002)(97736004)(54906003)(4326008)(65826007)(25786009)(6246003)(110136005)(31686004)(39060400002)(81156014)(2950100002)(8936002)(86362001)(53936002)(316002)(6666003)(105586002)(230700001)(478600001)(6486002)(81166006)(46003)(42262002);DIR:OUT;SFP:1102;SCL:1;SRVR:DM6PR15MB2508;H:[IPv6:2620:10d:c081:1131::12d1];FPR:;SPF:None;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTZQUjE1TUIyNTA4OzIzOmIreWdTUW9SZVM4VDk0RUEyeXB5TlVxVW5s?=
 =?utf-8?B?ckNoeGVtNitqNWxOTVMzaHNWMGJTOUFzTHpJUUhqK0dpMkh3SGNDdmo3NG9X?=
 =?utf-8?B?YUhhTkcvYWlZZTFCNU9ZbEJ1RDRCZ2I4a3VVaUtValFvVzRoSEFNZUFyZGpJ?=
 =?utf-8?B?NW9FelJLbTR2SHlRQ0kxVU5aa1F1eThPZC81UEk2OVdIcXB4R1FQaWZPV1Jh?=
 =?utf-8?B?MGZyYnhxUng5N1RpQVMreG4xbnhYQ2VhZ2ZzY2ViNlhNUzRoYXF3WjU3VmxF?=
 =?utf-8?B?akRhMndRblNXOHE5WFpuY2RIUXJKRUFiczZEZi9wTmk0RUdrcWV5a052MTJO?=
 =?utf-8?B?aTIxcVVBcW1OTHpscFlvdXlDdnNDOUt3N3dGNUY1akNLempCYkJuSGNxQ3Vl?=
 =?utf-8?B?Tk9MNHBuSkpaVmoxc3R0T1RpR0tCdWJkQ3AzZEhsNjBxUk90L2Fya3hOYnlj?=
 =?utf-8?B?Q1Z0MmY0MEc1bC92M2pXU0VEb3FRWDdCTDg4cnNDMTN4SDVrYm5aTGV3QU9Y?=
 =?utf-8?B?ZHN4Tkd4VTFlY3Q2M2FrZUE3MkE0TjRVcWI2VzJ3R3JhN1dtcytmVjdEMVBP?=
 =?utf-8?B?Wmk3YmlqQ3JDRUZxTVlKT0Y2K0k4cGtoaVRvYmNTOWlWa3dvLy82MWV3aUZt?=
 =?utf-8?B?Yk9teGZvVDVxbDVNbFdWbEh1WVlqdnk0UzVHQXRZNVpIOVA4QS91clY3WnBa?=
 =?utf-8?B?QUkwa0Y1cG42eEtLNitQaE9mNEwyWDAyZGVacXJvM1MwSnVLbXJIVzl5UWVY?=
 =?utf-8?B?MUozSkF2NCtFK3YzUlpaaWxaaUhvU1BtTVJpVEU4TDBRdFN6Q1AzbFo2YVl4?=
 =?utf-8?B?dTUwblJaZzVndjNwYm50WVU0Y3V1c0hBQ2VSMTV0WTBOcXczM2N3QUFraU1K?=
 =?utf-8?B?OGEyZjh0a1RqQ0JXTExxR0hzU0prUUtqRjExdUZnYk5kNnZ3UDY2NU5BaFRO?=
 =?utf-8?B?UHZHM3pvNnpUWG5uQXVCMWZMUFN6TXZnbUhRZm1zRm96VUl5ZWVteDlNR3VJ?=
 =?utf-8?B?UnA5N3g1U3c4bVZLdXdiektwS290RmVhVHFSeks3b25Vdks2bmdkSE5hZUtF?=
 =?utf-8?B?YlFqWWozazIwZUcwUnVPUnoyYzlsd0xPM2JIc00xajI3cGZnTnlJaU1YVG81?=
 =?utf-8?B?ZklyVmkvZnZWcXh4VU9lLzlQSW92eFJkV0V5UXlVVFdrZEZ6MDdZTFgrMlFE?=
 =?utf-8?B?MmFVZVBjWkRDUTU3T0JqNUE2NTJVbGtNeDhVc1R4eDVxcHpqb0pHV1pjYloz?=
 =?utf-8?B?dE1KNitnZFBkY0ptZ3A0NWFVZ0F3VFljYlpwY1pWRjNEYmZWb2FVdlM3eXNP?=
 =?utf-8?B?M1gxcC9ucytxY2xQb2FTdHZUb0VQK2M4b2d5Q1ZKZTRUTFRYQU1CdE9maHMw?=
 =?utf-8?B?RC9wamI4TGZNdU00WHlCQmVSV3hibTAwTmhob1pzZjczWUViNmlSZXF4NkRt?=
 =?utf-8?B?MzhLaU9OeFdJdHhHb2N4VGFYMDJGUzNRaEFGbnkrRmdMdXVsemw1NlZReXVt?=
 =?utf-8?B?KzRGaE1kbGFPZlp4ejRXaHd6RFJSZ205L01SeG92T21XUm11OGEweHFmRi9L?=
 =?utf-8?B?RHVBK1VjYTE0SkVKM2hBUFFZeHRHOU9zclVhdytxNldVNzhDLzVJZG1ERVpt?=
 =?utf-8?B?S0tsS3AzcHN0SElKb1plakd6NmdqekhWSEM4S2p5U0xiRWhsZVF1WHA2Y004?=
 =?utf-8?B?VDVwc2FkbW9ZdkNrZS9YSkFybVdsbThmYjdqaUtEQ0VBTlNIMTAyNFpnZEtH?=
 =?utf-8?B?Y0UrT2hvamQ4dTJtWlY0K0dXcWFlZ0JNWU9Rbm9HNHVySkRVTGhybENCeHY4?=
 =?utf-8?B?Y1JydVNOMFhYQkpzeEFoOGdIVXpPVzluemRCVjYrMFRrUlY2UzIvL29BWDQx?=
 =?utf-8?B?bTJPdG8zWVRRMUxQWVNBWjVxNFpqaDlaTEVQR3VrRXU0S2IvMTNPaGd4dzAr?=
 =?utf-8?Q?g/Xqcm1YacjRoPvWhzsuzm12CPVGEw=3D?=
X-Microsoft-Antispam-Message-Info: qamL8vSvx8NurWOPDHf2vU3vuJpI64zOXiIyKx4AjYPyTLzynXa/mHut99AsT4UICH2lyc2ZtcXEZhryl3BWCOE6Aj9INbkOdiw5U/FkK9tIfwPHwcbsxFv0Xs/LkFAXS+EwOmpoUiOtlgwrq15FulWc9y18Prv1vE06Ow5rBd/9cpo8SjOj6kdWIgJ4JhN7
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;6:FoY3dNlw27ZEUgxUzJ1qK1b0Q0KID/S70wfYLwgvAlic7Mt/chjKQtHk5k892nh98kVcS01e3DmmZulcgXA+hzeQ7+JNIIlkan/M/KRWyLI32qUy6Xra3MTRm3bTbTEUM9ooKQE/w8W47MFXHlcMAw+iq6c7h2N3wcAtmu/rsIy0XuAvOgCGfrVLnEMIjwEbQ0f9f2YAYs+G2oyFzRRf5Rp164xPDNsNaspSqbW6mwLzDHOhst4eNdHwaRP3QtCBRlTVRfjKolAXGQY+W6f9kYPQSJKB6a3oJkugk2Bl3ACraxGsw4Au7lEwk7d6tTOgRo3UEDdq4CwqWE/1kWcgCB/lTNr1WsDtrV7xkOMrPQc=;5:md0hOJREr0QFzqZB4Ept97mgJIYsm9wXdQ3vgo96M+dIPOzhDWjk/tfYdjHHh6TlwPvJHuMHEuV5afjOWR1OvmeDZmCQozdTl4tZiG3Pw9EpwdM4RgtW1ssu9pLjeOp6zKLGidZQivkTLrVX1wjGaBZOQiHwsyWcv9z/mOLHaQw=;24:qfRNHjuePM/Er74Gqri2Uv/v3Ip8tbO7y6P2/hVpci3WU37FM7lLiaJcFMVrfnXGqg5lbz6yyldAY9gvx2/fcrWhhIp4QD0hETnbVt0eW9Y=;7:G8LUQ0sb6Jv6UPiBQGae6jg8NLJnIyD72oxy5p+8hA1F9C8qLANjnvJLmJN+ST+VnYHGHsWVl+jcW6eZPMQz4bUK5Y2onarLB83HxdVxArnvEUHtm531c5nwoR2LzRjMYw84W14DMc+8WT1UibSvFKZaJnj+Rf+oZx8Wpbe4Cs4/kTaoXExBI8DFYnkNexhKgVjMINwhJhZaIElV5xuzmPYbCUXEO4a6HnJDP1zoHx1iz6pamv64VIafYM1NgBzz
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM6PR15MB2508;20:Q8BwjZzPQNfR2Y8zo++L8BL/lqMAriwhtbI9WVFDccJIrh15qEe/qgX2smSn+x9e9Iy2jAz5pDVHJYJ9OARdSjrcjo5LJPkdf8PgQOxuVJuSfav7AbKCVhb/iiCy8yyrDKoOyAiopoH70eimTRv8q8SYAzwN/xcJTOZRGWEg9Dk=
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2018 01:43:18.8744 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1756220-db66-44d2-4e43-08d586284e3c
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB2508
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_11:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594150201283124044?=
X-GMAIL-MSGID: =?utf-8?q?1594513144106736173?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 3/9/18 11:37 AM, Andy Lutomirski wrote:
> On Fri, Mar 9, 2018 at 6:55 PM, David Miller <davem@davemloft.net> wrote:
>> From: Alexei Starovoitov <ast@fb.com>
>> Date: Fri, 9 Mar 2018 10:50:49 -0800
>>
>>> On 3/9/18 10:23 AM, Andy Lutomirski wrote:
>>>> It might not be totally crazy to back it by tmpfs.
>>>
>>> interesting. how do you propose to do it?
>>> Something like:
>>> - create /umh_module_tempxxx dir
>>> - mount tmpfs there
>>> - copy elf into it and exec it?
>>
>> I think the idea is that it's an internal tmpfs mount that only
>> the kernel has access too.
>
> That's what I was imagining.  There's precedent.  For example, there's
> a very short piece of code that does it in
> drivers/gpu/drm/i915/i915_gemfs.c.

I can do "monkey see monkey do" approach which will look like:
type = get_fs_type("tmpfs");
fs = kern_mount(type);

/* for each request_umh("foo") */
file = shmem_file_setup_with_mnt(fs, "umh_foo");
do {
   pagecache_write_begin(file,...);
   memcpy()
   pagecache_write_end();
} while (umh_elf_size);
do_execve_file(file);
fput(file);

while keeping fs mounted forever?
is there better way?
