Return-Path: <prvs=63297c413=Bart.VanAssche@wdc.com>
X-Google-Smtp-Source: AIpwx49GuZZBB1CQc66AvqLkrR/d9Bi+x1mfIN+zD8EcuEIC3P+y8f2Fug19QM0khViToYY7ZNAs
ARC-Seal: i=1; a=rsa-sha256; t=1523476531; cv=none;
        d=google.com; s=arc-20160816;
        b=aunCc0e2dmObF+GSdDgY56BNK96udPD3d6teFA40dIU0xcsQxA9zdGruBU8/tqRRQd
         CKFAVt1rxMfzMXiXBequzBWIOvXkjddIDJiplYbKVPj3jqK61e6b5XcdgeOMikWPsHjH
         4yQ/azlNoS34dnj6GD5vg3hmP+jHBCumIu3ARLPFXCeNKCMLoqw+XuDj6S0SouXucxpS
         ZWKfFxQaNhPRJCmV9ldfF/D2RTMHjvs1lRdrti4gCfJzS4txC+iXg+uR4V1UPcWpc+NG
         KGuTD1V1mk88VkSPFjMtqgZDp4aZ+F0GPDEkiILNW62hZupayvVcC3v4edgukhlxFYxq
         EwSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=spamdiagnosticmetadata:spamdiagnosticoutput:wdcipoutbound
         :content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:dkim-signature:arc-authentication-results;
        bh=7E8hU78FGCd5RpVVo1LjwMwKSr5DhKFjT0v+PxTZZrs=;
        b=SMfmQ3VGZ5XxUvhK3CvYohm2u27nNDWdEovdFGKQ3Q3iizNz7PwEIgz3Qrr8splt8i
         s++vKkRUtDYc6n4hsYs6y5VTAbtpjKcr2s/6Vt6gB/ZLfLyDeaVWcXA56B16+yM7HcwC
         Bjccb6H1r7uIKTAoBD0tTvK+Z002ZJY9UEQNGkECnDCTlkIwM9ZCg75aZIqb0KhUeEX8
         x7mQm4EaNSlnEIVmaeUBBrLWBV4iV9tbK1U/VpiCxnCI1AgbjJKwJ00dMrqlAkG6GbVM
         UzEA2IZHcegmcpStgSI0G4nKQWM/0nBVPqAq0iZvGaOtbfJInJrWYOHtxdp6o6TUtjXD
         M4HQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=He09vVLd;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=L6Gkcgzq;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@wdc.com header.s=dkim.wdc.com header.b=He09vVLd;
       dkim=pass header.i=@sharedspace.onmicrosoft.com header.s=selector1-wdc-com header.b=L6Gkcgzq;
       spf=pass (google.com: domain of prvs=63297c413=bart.vanassche@wdc.com designates 216.71.153.144 as permitted sender) smtp.mailfrom=prvs=63297c413=Bart.VanAssche@wdc.com
X-IronPort-AV: E=Sophos;i="5.48,437,1517846400";
   d="scan'208";a="75780835"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Bart.VanAssche@wdc.com;
Subject: Re: [PATCH v2] blk-cgroup: remove entries in blkg_tree before queue
 release
To: Alexandru Moise <00moses.alexander00@gmail.com>
Cc: "tj@kernel.org" <tj@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "nborisov@suse.com" <nborisov@suse.com>, "axboe@kernel.dk"
 <axboe@kernel.dk>, "shli@fb.com" <shli@fb.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
 "arnd@arndb.de" <arnd@arndb.de>
References: <20180407102148.GA9729@gmail.com>
 <20180409220938.GI3126663@devbig577.frc2.facebook.com>
 <20180411101242.GA2322@gmail.com>
 <20180411142019.GG793541@devbig577.frc2.facebook.com>
 <20180411142859.GB2322@gmail.com>
 <5fafe1cbf6b0111448a81005c1c16feee24a99ad.camel@wdc.com>
 <20180411190027.GA21274@gmail.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <b7809887-24e6-3ad7-e8bd-4fe7ea0927c0@wdc.com>
Date: Wed, 11 Apr 2018 13:55:25 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180411190027.GA21274@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.225.201.71]
X-ClientProxiedBy: CY4PR0101CA0018.prod.exchangelabs.com
 (2603:10b6:910:3c::31) To DM5PR04MB1196.namprd04.prod.outlook.com
 (2603:10b6:3:a3::16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(48565401081)(2017052603328)(7153060)(7193020);SRVR:DM5PR04MB1196;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR04MB1196;3:YV07HYWnZuGGbbq+fiAmfkotF53JXMHHgAJFqBqCrZGWcosOfUZXki/qRPdPNQeA6vDkmOl0TNx2a+PmKRmTWIScXb2uGOz2XqtHqSWV+q2lLd39UAUwvffE3PYsXxpOjmD/ATPg9Prs383XHDJlUOBCiu+Qh3J8yUCQ2LpArQbMzMD5jOPzqPb1DtOu3Xk0RAwBiMjbKdDo3niwlilQb4s2+yhoi3K3xRBK5xAntS09ExxViMhNxsxnew9bw0ls;25:EJF3KCW4uSuFKZKxhiGDHymxI3PvvuBDl0q2txI+7OR1SRoveuBaEie4Ulg6Soq63CcxoU3u9yfMgxoFbJyvdxXIvi63RX3P2B/zY8pIu0fGti15ero49nobjCm7cH1U0zon7nALFIxYuDfgEZf4O6eWHXxv2SQ1XR0fDiZJ/Eyf+ysiN2APIa9BrO1f8FllQ/3AwrFmeOLKsSDztny3iZ+3fm6KvYnWjIKjwivqjtLpgmNIHCnKkWctAF4uOH+11o8KqxQA8kloPuoq4L4LGp7r4PAWaptmssZHtYNwva/tTiGCXsR65NaDKY/IXxEuAmd6MOVLD0HQv/IyrQkwTw==;31:QGuivKj3aK3EdA8+O5o7rzWOt5SJcPdJEu0i68I/gWnHY6/wvhHfpLqAgbeFWQpfS+isx830k8qbn9EEOrmZ65BHLFnG24jluCofo88f5aCeXEuJ8ZGvptOgCj5Z7h6IIUo+EsNorlFhqUZPgtAAP2gTxgUTJ62o7/Rwa3bwpH4G2JzTYc1e/7ORYCx0JnzSr7PH0/KkFDCIFeDuMxhsnzD0oN5Zc5VqXLGXymFam+Q=
X-MS-TrafficTypeDiagnostic: DM5PR04MB1196:
WDCIPOUTBOUND: EOP-TRUE
X-Microsoft-Exchange-Diagnostics: 1;DM5PR04MB1196;20:pg+TqldmsPgSK6Ic4D69Syu0NhZM4gCCMg3iUZ42yj+t3fnAukJqAJINX42Ns7pvCifE8I866tP9T69RYEkrXMTKwIaQgPbRi7x3yuw8MsozYBsd6ZPcwXmzoxPcO55Xj9DlBLxLcR7iIr/CNMM0G3ymy5urJth1ftnF8DvtT+bw2DZIYrfnSaM6hf+iVg9BSEVUW0771Sq9KEKN4Npk2Z+x42/fRdoGEE5aOpiFaaZYK0726aZ/DzAvqovlIIRlbsCeoL4CroeECqUtv5sahJTOCp2s7OaJt1jZmBEiLK08fTpIou8guaEW+U/8c8e4TG200c8t4m2U2dO/vvRZhpY70DwnKTHX9aezqpEhBFHCLnitHVZMPuF06P16PWSrZjPNs1q2qGaermnLHpJxnGIBdLvAuoGoKGq7MBXWedP6TBm0H1jT8cX4clfEDMgyEQbL114OctxcO+8xfdGN0+KyeaNB8Mp7OmcLpxVSnD1vUpNrRBkn3JSVciwk/XsE;4:Zn8zQ+gROl0kiRC4Z1oqYi1bMyeeSqdvOAm+o4aBACZlpfGhS9s4WnucmJr2H0zud4b2JctPN2GEpRNNPGD2GEiPLuwn+Rys7DJ7ouLesQdoYoYeZ8UlLL0Mp4M3qwxVw4x4/b0Uc8puEB6MDJEnyv4clNA1TMG3Ldi4VUnE2QR/XLqAKduuub3EgrKsIhSwShd/xpN1z2JGY6qGrL1DrvXze70P8VZSyVz8qizwAB8eVU128dVcexzIz7rR//vWBrqEkHa4F7tRowGeyycIVw==
X-Microsoft-Antispam-PRVS: <DM5PR04MB11966A910CE5F5C8CF9D741798BD0@DM5PR04MB1196.namprd04.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231221)(944501327)(52105095)(3002001)(10201501046)(93006095)(93001095)(6055026)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123562045)(20161123560045)(20161123564045)(6072148)(201708071742011);SRVR:DM5PR04MB1196;BCL:0;PCL:0;RULEID:;SRVR:DM5PR04MB1196;
X-Forefront-PRVS: 0639027A9E
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(346002)(376002)(366004)(39380400002)(39860400002)(199004)(189003)(23676004)(486006)(54906003)(5660300001)(6916009)(53546011)(39060400002)(52116002)(956004)(316002)(50466002)(26005)(476003)(16576012)(64126003)(7736002)(6246003)(65826007)(2616005)(11346002)(386003)(16526019)(2486003)(105586002)(6666003)(106356001)(58126008)(31686004)(76176011)(6486002)(36756003)(186003)(59450400001)(93886005)(86362001)(52146003)(8936002)(2906002)(68736007)(4326008)(6116002)(3846002)(81156014)(81166006)(478600001)(230700001)(77096007)(446003)(47776003)(67846002)(305945005)(25786009)(53936002)(229853002)(7416002)(72206003)(8676002)(65806001)(31696002)(97736004)(65956001)(66066001);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR04MB1196;H:[172.21.0.229];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtETTVQUjA0TUIxMTk2OzIzOnhJY2puL2xnclVpTjRvUURKZEVaWWtXeDM5?=
 =?utf-8?B?b3M2SzF3Z2JBU2cwdkVOVnRmYVJqSzVTdnl2Y0xvYnpkWjBwa0Frdm0xMktj?=
 =?utf-8?B?dXFOc2JQOElTWGtiSUs0VHFjQVo3OHpnclJ0eUtUTW9yWHM0aUtVQVNNd1RJ?=
 =?utf-8?B?K3Blc3IrcDZuM3hZWmIzNjllZzhxK0Zqd1FZZDczcnF6b1BPeTIwWmZlcVdJ?=
 =?utf-8?B?ai8xNFV1ek1jRlo3SlRHNlZxYVJITUxDd1JlckZIMGJFYkJaOUhCL1h4VDlT?=
 =?utf-8?B?MWFmZDg0WDNPZkkrcCtmYmNMY1N0MGNLNnFJaklTaEtBWHJYQ291L0lYN2FN?=
 =?utf-8?B?bE1tRjNWL2luZ0cxYzFyRVloSW81L0pGNlYzcGdNVFNjS0hzYU1VZnlNaVoz?=
 =?utf-8?B?Sk1ua1FZUW92aEx1NWdrQ2tnb2NSamE5WU9pMU5BVlptSkYwMHNiNGU3Rzha?=
 =?utf-8?B?R2VvamxiRzRQRVV5UDA1ei95OWlnc3VwQkRtRnR3dC9FOTZ6TnhJNEYvZUxJ?=
 =?utf-8?B?YzFrZjZOY3cyZFdFU21pTitSTVUrOHpTRHVRZjBUMVNRSm8zNHdRc3VSYXY0?=
 =?utf-8?B?VUVsUlBGRDZKOGxsWk9iTUhzNG1LUVhIMWI1bXB6VzRKS1pGKzREeVRIbnk4?=
 =?utf-8?B?dkpTcmx3SGpmOE1TMUNTUGtxSk04RFc2WlNlRENYckNsbWs2L0xsWFBObnM2?=
 =?utf-8?B?b0JpSlB4Ry9UWGRuSm9URUMxWEdYdFlxdmx1a1I4aFNacEdUVTBESHNJTFow?=
 =?utf-8?B?TTFDSC95MkhvYWhxWXpNZVRVdEF5U3NtT2xDVGpjUVN2c0NjR1hsU0RBbnQ2?=
 =?utf-8?B?cjlBQWVIWFB5K1Evd3NiNUVOSzdBQ1FRUWVCSUtRT0pOeHhadUQ0eldxdjlV?=
 =?utf-8?B?RzlFdE1JOVloQm5NN1l2TzgybThOeTlyRWtWbDdxZmtOempKcVJQVlhNRFd5?=
 =?utf-8?B?WG5BTjBFRjBXdWxHQWVGZ0pIVWFaaGc4VDcxVFNlUUZFdFB2dVcrQUJlUUZB?=
 =?utf-8?B?SGM0WlplQ25kVDVPYWZDK0I0ZnhyZEpPbFc0dVI0Vi9YbXQ4eDhMV1IzZHdK?=
 =?utf-8?B?ejI3V3owRlEzNnNJVC9TRCtXZUVGOHhXSWZnbXdmOThKaEdVVFhhWE5zRFBa?=
 =?utf-8?B?UnczUExldWRXVWNJc3lOT2xTbmFaeXoxTXJMdVdQTVRMcEdSbzRsdkxZMmR0?=
 =?utf-8?B?MFgwMGpIaC84cWxycGdVYzNFNElvMW1GejlHTGdsVkRaaEdmYWE0eW9iaFNU?=
 =?utf-8?B?cHZ1U1JrbG9FQUg1YmJXNjdFRGRZNXpjaGhrSUYyc0w0blI2Mm1ES1BtaGl1?=
 =?utf-8?B?bmdUZjBPV0l6TUYxM05BWXY0bVdicndWTHFqZmw5NVZYbzZPVzZ4UUhiVDBz?=
 =?utf-8?B?VEMrYzBQLzduMjkrdnJ1MGpub1hkOHlxdFJwbSsxWExPTTVDbXpVRURiM09x?=
 =?utf-8?B?TFVKQkJkWEEydTJCdjUrbTFuUm9PVEZoRTZrQjNhUllrMWl4dXAySm1wL3h5?=
 =?utf-8?B?T1VlSWZRVTBQajQySXJSRXVkSmVtcVVJVDJPY0ljOTQzc29DdFByZGFhQ1pw?=
 =?utf-8?B?dElEYVRnaUU3RlJQZXBieXdPSncxcUdueXZvMlJQY2xNY056eDVqc09HR09t?=
 =?utf-8?B?eFZXSk1DcHdnczlTZUJsTkNYTTdmMU9mcm1IekRaNHRaZjUwSFh0Q3dNRi94?=
 =?utf-8?B?a1NPQy9UUS9mNHRjdjVtS1NEMnhwekxLTmNrNTgzcG1wcmxkSG9seGhjVVM2?=
 =?utf-8?B?LzltdDRlTDhOYXFjcGNQWFd2WnBHTitKNWFtam5qbXg1ZE5iUGVuN2QrQ2lJ?=
 =?utf-8?B?Y3BPUFozZG5hcWtoWjRmNG1zU2RQZ2R0SFoydXEvWDBFeWJWcldBdU5hNExw?=
 =?utf-8?B?L3czaVhoWCtrZTJRaGs2RENGT1o5SlhUeUs2MHhxLzF1R00zYnV3d3hkMWJV?=
 =?utf-8?B?OWdDNXhzYmpXMFBBQURiS2VURXMvWmprTDJkODhWTFNJbUpIZDlqcVl5OWpm?=
 =?utf-8?B?SUdKZlYwRnJKQU5Ibmw5SlZjQ0pXMFRJR2tHdTJTTjdrWHgwY2xBdldpVUEw?=
 =?utf-8?B?b1RJYm9YcTk2Wk1RTUoxa1pkR2I0cVVndDhTcHFuRk1YRW5lTllXKzNwa0Zo?=
 =?utf-8?Q?k0xT3QjT1J6b/DvD3QxtL54=3D?=
X-Microsoft-Antispam-Message-Info: P54lGJS1FmmEnel92q1TerQ3CzOOe0oWK01iUC8CIRevb1Q3ap/M/MGzyFl7z2/gaTXW65/zrauGHQbBImRVA5PSIiJquyRawxMmMoT/5Ld2G/U1zr1JC2n2r0UdJUHN0wmiiahkoPEFQdsCVFz7vdTPcW7somIAq11OPzTllv9zdoHafxYu4IvZuNAqzSFk
X-Microsoft-Exchange-Diagnostics: 1;DM5PR04MB1196;6:hbpuEPjX42vPY5zHjqN0dagPjpLCOx4EfhCz/rwI6unhiIcKai7XmZ+UpuJaLi9L39vJqpgZuzpqb88h/JMJDPymDsT2CECksvpSDKpgFQdyltn76ZBqYogrpL4zhECkmxXOa4eQAJ/J3rSS0hBii70NOSlKDHIlI+K6P8vYHXOi7m9qq3a+Hn86TXK/DW/eKgsIlo3Uc44iL3B9RMzt6nR2u2+5f/nCg0r88HyOmeU+d03TRI9eGHAkoJdOS7vM+vGKfN9e2vs0Sy2ePe+2gmXHLiWM+3TVwbtlfe2OOnW/Tm0XGn0UHb/tLaTPDj5r/yBnuewRpmeeVOL4hH+FOQr+AIXUWHLzQtZZl7Cth4SuSV0awDqw1zjDfQOrIiUUGott3Bim2Sq7cPpRhMmuq60cA3j9UgB9kRpJhfxwgsM8eVCei0tfemWwWw4JgdFGAihsLJ+MJV3lTKrMqGLcYw==;5:liSSUEieELv4K1cX0ENDciUr22ztiUcOMb/rO0Cz8WtvCL4lWwoKoq/UXr89lv9EIiPxPpfIm7ewcSt0n6fuHRlCVuXgCMhjqROtb/GqAgtC69tV7oXmJV97Lm2CoXE69FV0jgI3THKKZCjumLmyJMNKqjsQIKWniJJU1Y9R7Ls=;24:pQuRLKgjaJIuffHgggQb/sLDggyzs133PCQJ244K8UPAFTrVRI+pkDc2RkQuocaIF1LWFIixOPnRizdtk1eiL3mh8A4D8HYzZjsFhQKvotE=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR04MB1196;7:WEyp3Xen8jbaLrYLc81FkEok6ilMuvGuljoIPAqMDWrdslP97VsEfeLDolmN0TIMR8ZeRGFRQASElvQxj2SRXpiD1ceELE3Hntrs6MNJMhwU4ol3Z/jTXqkiMxfj3spBTUXvyTAqUqmCAtoomq4H61sYneOoL90JpqWBFY2CggmMXa4nPHkAg9rx2pPx/6mB/FxadLz8mGwqvhq20vpjeldeQBuv+NJsjVFHArRi2DiJIaavg1DeWW9MYmgPYx3e;20:rdYGef+4AvAJ6lnbHOkFUBhfAp5vd0eBz5vFINd3RyXdKobyL0lmPXJXJMg/Vl6OF0mn/Xm11Ahy+wKs6NdzjypSJlNV9PBm/bstf2L0Cdmde8Vy6rhVPyxA83hdh9BqsOs8D2/cPyruRZeV6luTKyWuECCBbZxgZdjFQjXLjJU=
X-MS-Office365-Filtering-Correlation-Id: 2263faca-8889-4c8e-6701-08d59fe62ce1
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2018 19:55:28.3932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2263faca-8889-4c8e-6701-08d59fe62ce1
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR04MB1196
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597082451728716242?=
X-GMAIL-MSGID: =?utf-8?q?1597480927318117036?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/18 13:00, Alexandru Moise wrote:
> But the root cause of it is in blkcg_init_queue() when blkg_create() returns
> an ERR ptr, because it tries to insert into a populated index into blkcg->blkg_tree,
> the entry that we fail to remove at __blk_release_queue().

Hello Alex,

Had you considered something like the untested patch below?

Thanks,

Bart.


diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 1c16694ae145..f2ced19e74b8 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1191,14 +1191,17 @@ int blkcg_init_queue(struct request_queue *q)
  	if (preloaded)
  		radix_tree_preload_end();

-	if (IS_ERR(blkg))
-		return PTR_ERR(blkg);
+	if (IS_ERR(blkg)) {
+		ret = PTR_ERR(blkg);
+		goto destroy_all;
+	}

  	q->root_blkg = blkg;
  	q->root_rl.blkg = blkg;

  	ret = blk_throtl_init(q);
  	if (ret) {
+destroy_all:
  		spin_lock_irq(q->queue_lock);
  		blkg_destroy_all(q);
  		spin_unlock_irq(q->queue_lock);
