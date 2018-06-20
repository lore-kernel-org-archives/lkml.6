Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EF67C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA76520874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:39:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="jwK1tkVL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA76520874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fortanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932459AbeFTSjL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:39:11 -0400
Received: from mail-eopbgr730106.outbound.protection.outlook.com ([40.107.73.106]:10339
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932255AbeFTSjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:39:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector1-fortanix-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oQTBRJ/V8EHXvR9uT0fwpHGz0tW73JLKkEHzj6zp34s=;
 b=jwK1tkVLYk6Bfq5qVK1GfwrJcsn+Sa5PklBUjd/qwX2QYcmsI+IQmQfjokgNrpzk/BngLE6qqXIY1YEjkHNdJA5FN+npWGHOwxp7wrw2Tt/zuY2AWBw3eXvlZK6eAOmgpRCbYoiM8q2Maw/M6fKi6Wp8Ye9XVNUQYKAP0DTdmzY=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
Received: from [10.198.0.221] (67.207.107.146) by
 DM2PR11MB0319.namprd11.prod.outlook.com (2a01:111:e400:3c26::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.19; Wed, 20 Jun
 2018 18:39:04 +0000
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
From:   Jethro Beekman <jethro@fortanix.com>
To:     Nathaniel McCallum <npmccallum@redhat.com>, luto@kernel.org
Cc:     Neil Horman <nhorman@redhat.com>, jarkko.sakkinen@linux.intel.com,
        x86@kernel.org, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        intel-sgx-kernel-dev@lists.01.org, hpa@zytor.com,
        dvhart@infradead.org, tglx@linutronix.de, andy@infradead.org,
        Peter Jones <pjones@redhat.com>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-14-jarkko.sakkinen@linux.intel.com>
 <CALCETrW3aZJMMm1GqgPm-cOD3p7JvKxLj7j85KJwfNW2iHTj4A@mail.gmail.com>
 <CALCETrVp1ZhrxF5bQDSaZpLucS88tErejj5JC6Jb0fB5etWRbA@mail.gmail.com>
 <20180611115255.GC22164@hmswarspite.think-freely.org>
 <CALCETrX6SD0ThNzpjkbXd7CbNTguzqiQhWMomGK+tocx_DE9XQ@mail.gmail.com>
 <20180612174535.GE19168@hmswarspite.think-freely.org>
 <CALCETrV-4D-M2ap1EFHQiQerYf_XgwLmBAx5WMvcCUefOODjOA@mail.gmail.com>
 <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
 <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com>
Message-ID: <b5c81504-83cd-8150-ebe4-41355026590f@fortanix.com>
Date:   Wed, 20 Jun 2018 11:39:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000606030002060502060906"
X-Originating-IP: [67.207.107.146]
X-ClientProxiedBy: CO2PR06CA0072.namprd06.prod.outlook.com
 (2603:10b6:104:3::30) To DM2PR11MB0319.namprd11.prod.outlook.com
 (2a01:111:e400:3c26::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6241118-79f4-4dab-cb73-08d5d6dd1a37
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:DM2PR11MB0319;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR11MB0319;3:ciDFqSFK4K1srGokb5ipE1ZA+iNVjL7UaHSvXBPYRXdmJj99JafMU1hjPqC0HZ/6/5xrqLYzR5pFxaghd8e9HIBe4mIE8oLVwQ7Bvn+pL40h9MdxLUOwskFq48Q5ceBtEBGzimHFDlSuDRbJvYwNQgyuKIXGHot3JYvGxAafAmo7Mb90giuu0vgasIUQb+F+NGQVYkwBLGeEzpsfn8Kr9JgSr+Xg2iahiyvu/9HOQiudYwNzbz208jQaTwimEiz7;25:8AMyS1l93TpBt5zv7EhYdVef1VEwiNBafA0JG5Tl56PQcXRfS4f76L6HoGf5EuEZDzMGz4yY6cxLbL5BHmlvS+vpJ/mWVIGx6HBynenfqes5XvuacBjMWbfltoTKSx9eLmjjhSx9xCikwFrELTWX19X3hIbJ45RZMqyqriuxNW9MU+bbhe4KjTyEWEsv25+FmMb2IFd00V84qkcs6gUNiqKSt/nPLINKklvk1aLB1u5ijzgEhN8lRh0+47Rd8uo0p966Ro4/hhrQ0EypEu1gs0O/5OohcF9lY8o54Tjl+7pjaF1ewgEDvAH6EGwGnTpL1VhZWzy+GAy0srd6tn9UYQ==;31:nZfzIDPvmlGbWoG/0ZYmy8R6kRw7JRN0GJlusDVswdojxgn1LjaDt/li5LTBQu8omPlQ5gbn7Ipa41wRRCjsLIu2BC9YcUF7UtM8VMnvCA0QkKMtYe3XShGQrkLUf0l2SFvvLZOsJoaVXF0YXh+/g7A1c7IrbpKWhYYp51v8iglgZnozcz3k0+RHby2dS7tY0al2qMhF37LBCK0W7HsGLpR2Co8YK3UY7MoKzDHNK/8=
X-MS-TrafficTypeDiagnostic: DM2PR11MB0319:
X-Microsoft-Antispam-PRVS: <DM2PR11MB0319D2E4ED22520867E5E76FAA770@DM2PR11MB0319.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3231254)(944501410)(52105095)(3002001)(93006095)(93001095)(149027)(150027)(6041310)(20161123560045)(2016111802025)(20161123562045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:DM2PR11MB0319;BCL:0;PCL:0;RULEID:;SRVR:DM2PR11MB0319;
X-Microsoft-Exchange-Diagnostics: 1;DM2PR11MB0319;4:NuoeEb6CxyPZFyo5sqxnd0UWK281m1vusKbNGq7YqFnpJDndUPkOtoi6Qu2oeao/BWnFtlWZLgD/51UAB7hyoqkga4xcWzpY48Wb9JQgj/iNIAANhP+/kI4H0jE2lVjYwCC3PSlgpQqlA3WMJ3e+MXj/irAbYlOdcg04GJdWNcqrlmsVWd0/ZIqctTjkITenJvkArYT7mdWn934OMaIXv2qwFpzKSFIHet+63xTmlA6nuZLOiNyuhmiJ+AZzC1w/quJJWWDrW4KdD50uMxZS4Q==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(396003)(39380400002)(376002)(39830400003)(366004)(189003)(199004)(4326008)(568964002)(3846002)(6116002)(16586007)(316002)(58126008)(25786009)(5000100001)(5890100001)(16576012)(26005)(77096007)(105586002)(106356001)(31686004)(93886005)(186003)(6246003)(66066001)(68736007)(65806001)(53936002)(16526019)(65956001)(54906003)(86362001)(6666003)(446003)(305945005)(956004)(11346002)(8936002)(65826007)(476003)(2616005)(84326002)(6486002)(76176011)(386003)(229853002)(36756003)(478600001)(97736004)(81166006)(59450400001)(81156014)(33964004)(7736002)(486006)(5660300001)(561944003)(8676002)(52116002)(31696002)(7416002)(64126003)(2906002)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:DM2PR11MB0319;H:[10.198.0.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM2PR11MB0319;23:ZahUSKSew4iBoFTcl0OwoUNDtbdilfvqW7OaEt6qt?=
 =?us-ascii?Q?Iy4rjC8LXnzb1OuIDN+zSECk6UAV03Zy0HI+o2Nj3difIIQSztlTiAgUlP58?=
 =?us-ascii?Q?LybNufNiZHQou0KJr1T22z7sQYxBJGV4wi2d/spziO74x3miraNnheItLFV0?=
 =?us-ascii?Q?VwbZm/ZtBzWFcvE8gsqJJgaEDOVFIMxvApBqUrpQZcNULZ0T+RDt/GLUCD+2?=
 =?us-ascii?Q?IGe30WyWl+abgpT3beGAUs1G7VzMgxZUlbzpLSJ086sqCz3WdA0sVEvKeIHc?=
 =?us-ascii?Q?zXC3ALqXEWR+kcPQk8TK2rHJCH892+htd6yy2KDgHeldyivDYorZ1H3IJT9I?=
 =?us-ascii?Q?Ilnz2iRVFNK/lBPAw4mWC8Fy1m1SV8LFDwJd1VLus6m31aj+D0JnYNsYaCSC?=
 =?us-ascii?Q?8ufyaFXuot7roj8mJx+bP09Q7Yj1kJ1jZIpOR5kDWIIIHBdLXf3MyXU1V53L?=
 =?us-ascii?Q?T3LZd2Pdqh4pramZKniwHEVmPkejrcRa4hXXZC/Ex0qCATP8cYh6Ubvi4c2A?=
 =?us-ascii?Q?NIcrCJ59as35m46q1FZtKH7eYozApV/JPVtwDpZnDWbn9r2NCDENsOQRLDd1?=
 =?us-ascii?Q?4W+GkWJF9K0/D0+t+FpcN62S9p4nX1KsWof+zK2siFxN1Fd5qievlb9/pjf9?=
 =?us-ascii?Q?j9gw8BadF2sY/usPgQzRb5iRoYDfBGy0hG2acA3NfCsW1BJlzZN7E4lHlrzB?=
 =?us-ascii?Q?OlcAxEs+4VYPRRf9rOHCqqi87/vgApGOprVcE/LIDFBV/VBEWl1+JSufffJo?=
 =?us-ascii?Q?FsjfYL8+YNAwW9XZAlT903obgrfKb8q/o/j6hlCTo0McgSF7CMYctZKVtTqu?=
 =?us-ascii?Q?FCZks5VDHhVz3VKe0Pa4shrZ4znvBFRHMArzjQerK0dCvaT0WlvSVcWCOybD?=
 =?us-ascii?Q?SMtoRZjAxk9vKRIVMHbZ+Y9a9dxZ0D1jo7DTrm4mgGc3lCs7RmZ0IJOiqqDR?=
 =?us-ascii?Q?qvZT2DiSO9pM39QI7PZPxHlhXwXj79KLUDOW3bnXklnmH+2Iq8boKzqGUHS8?=
 =?us-ascii?Q?YFuUl6R/DS36kSIERuzzAPFJVz889y6TLexYZfHDB4N0JxIn3H5TVdGeBsMU?=
 =?us-ascii?Q?KBDRYxOmb7DfsGCNCKmHLPisvETG5OFTDFGChgKqPgHfNUiLkULMwQSXnoqH?=
 =?us-ascii?Q?wnztHGmc9Evi3rPXZsdctgERDRgSlJXDnb6llehpkV1lhK3YkcEuAuXyHuFQ?=
 =?us-ascii?Q?VDeiMFfoxL38jUBmwZaYSy50Bx92XwdFTlrE7X59lTyWZQ+1rPlPU2rOFmqZ?=
 =?us-ascii?Q?bcxO7vUqBjIbwN61KZWBjZWTAlN8ymtFG5ze9lhY5Ey9F0JdIhFHKnq2FSx3?=
 =?us-ascii?Q?uSM1N0BLQjnxrc5v1OEwophuViHiVxwkjWHYc9cKZi1wyEVGkSY5qFaB4O7n?=
 =?us-ascii?Q?3ABA2AjnwbhbVICyr4hytU8x/VvEkoxjbhKDBR5ed6pt/0Wro4+G0JR2L0AT?=
 =?us-ascii?Q?iCrh2W9WFVbVKN6hanqNbEn7PA3ixFYU6NJDFC03XN/PBfBFdFwEC5gAzsG8?=
 =?us-ascii?Q?qK3RnxR6y9xIje7KxL6L21ndXnc4dmR/k52Dfab0V5s2b8ZW7QD+NmU?=
X-Microsoft-Antispam-Message-Info: 1EUUFuCXJEDg5yysbdDmrQ8g9jNQdafsbdORJUqUHRlFMDpstRJwF4RGAZz6JC8eExAJr/3Gpq6JAes83YG4+ZVdyJFTmjfrV/3iDBUs0eU37+4SxQj7CJxZb3jKEYqrIabDfR5Bw25VQLBnumGkAcO8Ea192+gE3uUCJbEI3Mbm1X/vv9mv+jsHASlqObR3+LvdHsijxc3RQyHD3JIgQsQE60ofq9Y8M03/I2bQJrbOPDN5CFOyLeXd92bMdqs3JDfZUTC+6XrCUn8o47KReABjBWju7e8JqLDBPwEJKGPBLMMs5J5KDjGxiJZm8Qhy
X-Microsoft-Exchange-Diagnostics: 1;DM2PR11MB0319;6:JC9vxs+257Q3PuU0ilM/LIMJitkZyyDJku4zX1HC3ORf3PxwcLOWhi8PMexfb5e40FBHl3Ef0aKWlaKLlTD6omY5Lv86HCMKozyg8KNpb2r9p0GlRCiMOVsPXor4rju+S9DFzEsyY+R93YsMxaqEHsdNZfkkXcOv3kNyXjgyzRGzjrcd5gOgBWp1y/0mFJMSUJWL1pryCwrFOr4sneVd9tk4N9IkbvRuBjQxmEf57v/hPhkVEf+ScmRiUTGzcXb6Fp3gOf0H7h7TTcrCfi0fz8FhNU1VFhbhFOdSkmdbsYX/z0Zt3jgOZ4wMCgn87WBu5YHxO+3GB8odd1SYHndi++atvWuoUbkEePjrLTFwklfD+LPk/+Xgzd30aE9Al24a602HoFscYepPze6I58sey8LJ+Mt7NKZJ/E0iDqiAi6MF/GkVKu7FYpeZbDy6S3j5gUxp1Z0G9PRAIRtNk2ZcbQ==;5:+DMZJ/Sxi5qwA9ArQLd2LhDCNyqtGaLNMDzRm+H9YVR4idFTNGFWOsqfoXsVwuQnsCSQBNSGLgMSAmVdCR+JoAoP3v4rTf2PxA5aRAmO4yohRBooeVQldVULT7M4bZWoufco6SufDMtLmr1Jpoo4xKfjnWDP934lhJKDP6kd1HU=;24:YBDgD85i9mXYw8NOIoi7orgdHnYirFvSECZCbsGvtx+29pWyxcIZkqRvYe+aMnyfZ2O+amaSKUgv/y3c1eIUgcFO/GRDAvPaRktVolU0Hhw=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM2PR11MB0319;7:L90NBWjkebQ38axDtgBz7f6teHeggNyI7VARG1JqDpDM/UP8Jj8mTyi0haBKwOxyFvaFYh7jHyOAqu3FePYqiBKUe9lFTmLbdeHHrDQcIPVEG/KloioPpjbc7Go+Im0XSwPzLb7FpVxGawaStxUbm1Id2pdltTrhalKdmIjDGiXvDk6G0U87/PQvpLwFe2KB6mYw+9NtwzItM3eZCv4I1PIEFuQJrM8Vj8rd6zApIcqKyO3XsN3E+c3DHNcFjS6n
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 18:39:04.6184 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6241118-79f4-4dab-cb73-08d5d6dd1a37
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM2PR11MB0319
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000606030002060502060906
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-06-20 11:16, Jethro Beekman wrote:
>  > This last bit is also repeated in different words in Table 35-2 and
>  > Section 42.2.2. The MSRs are *not writable* before the write-lock bi=
t
>  > itself is locked. Meaning the MSRs are either locked with Intel's ke=
y
>  > hash, or not locked at all.

Actually, this might be a documentation bug. I have some test hardware=20
and I was able to configure the MSRs in the BIOS and then read the MSRs=20
after boot like this:

MSR 0x3a 0x0000000000040005
MSR 0x8c 0x20180620aaaaaaaa
MSR 0x8d 0x20180620bbbbbbbb
MSR 0x8e 0x20180620cccccccc
MSR 0x8f 0x20180620dddddddd

Since this is not production hardware, it could also be a CPU bug of cour=
se.

If it is indeed possible to configure AND lock the MSR values to=20
non-Intel values, I'm very much in favor of Nathaniels proposal to treat =

the launch enclave like any other firmware blob.

Jethro Beekman | Fortanix


--------------ms000606030002060502060906
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
CyAwggUyMIIEGqADAgECAhEA8MVmReo60XmFXNF7R8+qGDANBgkqhkiG9w0BAQsFADCBlzEL
MAkGA1UEBhMCR0IxGzAZBgNVBAgTEkdyZWF0ZXIgTWFuY2hlc3RlcjEQMA4GA1UEBxMHU2Fs
Zm9yZDEaMBgGA1UEChMRQ09NT0RPIENBIExpbWl0ZWQxPTA7BgNVBAMTNENPTU9ETyBSU0Eg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIGFuZCBTZWN1cmUgRW1haWwgQ0EwHhcNMTcwOTE0MDAw
MDAwWhcNMTgwOTE0MjM1OTU5WjAkMSIwIAYJKoZIhvcNAQkBFhNqZXRocm9AZm9ydGFuaXgu
Y29tMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAz7i2PMd8+ac44evn+E/vAnvp
p3rSuGpPBG8a5a7TomxjN1KilgX7juFiY7LZjZZe955hCzCoou+lyNgCCSbZzcKsYuIyydkj
UBBGIcTSblxCbko21J3yyk0JwAwSoaxlZwKrsbjUTHSl/0E6SBQpybRZsAficbdSRz+s7jG7
f6DtnikAtTYof+mBxwZC30Gzxh3RQEjA0PwaSP35tXffrplfazeog099eiVWLIDYA/kSaiac
SgheMK02Wi0Iu0fGZ3Y9QMVaB2r5Bhm+hODvJv/WAjEUuZGwo3K4aR/934W79pq5bXwUReXy
/5VxE1acjz6rFnCqBJuNgrzDiGF4ywIDAQABo4IB6TCCAeUwHwYDVR0jBBgwFoAUgq9sjPjF
/pZhfOgfPStxSF7Ei8AwHQYDVR0OBBYEFH990qeqLXTAXNqiGOMUQIhUf9TWMA4GA1UdDwEB
/wQEAwIFoDAMBgNVHRMBAf8EAjAAMCAGA1UdJQQZMBcGCCsGAQUFBwMEBgsrBgEEAbIxAQMF
AjARBglghkgBhvhCAQEEBAMCBSAwRgYDVR0gBD8wPTA7BgwrBgEEAbIxAQIBAQEwKzApBggr
BgEFBQcCARYdaHR0cHM6Ly9zZWN1cmUuY29tb2RvLm5ldC9DUFMwWgYDVR0fBFMwUTBPoE2g
S4ZJaHR0cDovL2NybC5jb21vZG9jYS5jb20vQ09NT0RPUlNBQ2xpZW50QXV0aGVudGljYXRp
b25hbmRTZWN1cmVFbWFpbENBLmNybDCBiwYIKwYBBQUHAQEEfzB9MFUGCCsGAQUFBzAChklo
dHRwOi8vY3J0LmNvbW9kb2NhLmNvbS9DT01PRE9SU0FDbGllbnRBdXRoZW50aWNhdGlvbmFu
ZFNlY3VyZUVtYWlsQ0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5j
b20wHgYDVR0RBBcwFYETamV0aHJvQGZvcnRhbml4LmNvbTANBgkqhkiG9w0BAQsFAAOCAQEA
BzIiuD+ggLjwfH5xKn7eotgwkH3V6qCWD21G1++PIxuLjCzRN87rMOZcmrMa2HJkDVz4NZYe
Er98p40JKNNVabKBI8+aF79Gfl0y3Mojr53ojV+x0wt2U04EmOXONuCHdLgxv5JvReFLXo6h
bIZQoe4Cwfgj541QPLDzoSuMrMUAcNSjt6o/SIeIu+Udv84ET2YckxiBXDiKUXRfW+GWet3w
1tUYrUSfwTA7Ho2YUbZu/L4FFRrUXQD6zYrB3f0sStDxWijKsRwLrdzqKVs0hsu42wZcNR/v
YzWnJQBVuCIpr0I/rTHY4E8w5h0Hz5mPABkNxLfOYKRJ1VUMQSgHGzCCBeYwggPOoAMCAQIC
EGqb4Tg7/ytrnwHV2binUlYwDQYJKoZIhvcNAQEMBQAwgYUxCzAJBgNVBAYTAkdCMRswGQYD
VQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNP
TU9ETyBDQSBMaW1pdGVkMSswKQYDVQQDEyJDT01PRE8gUlNBIENlcnRpZmljYXRpb24gQXV0
aG9yaXR5MB4XDTEzMDExMDAwMDAwMFoXDTI4MDEwOTIzNTk1OVowgZcxCzAJBgNVBAYTAkdC
MRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNVBAcTB1NhbGZvcmQxGjAYBgNV
BAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01PRE8gUlNBIENsaWVudCBBdXRo
ZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8A
MIIBCgKCAQEAvrOeV6wodnVAFsc4A5jTxhh2IVDzJXkLTLWg0X06WD6cpzEup/Y0dtmEatrQ
PTRI5Or1u6zf+bGBSyD9aH95dDSmeny1nxdlYCeXIoymMv6pQHJGNcIDpFDIMypVpVSRsivl
JTRENf+RKwrB6vcfWlP8dSsE3Rfywq09N0ZfxcBa39V0wsGtkGWC+eQKiz4pBZYKjrc5NOpG
9qrxpZxyb4o4yNNwTqzaaPpGRqXB7IMjtf7tTmU2jqPMLxFNe1VXj9XB1rHvbRikw8lBoNoS
WY66nJN/VCJv5ym6Q0mdCbDKCMPybTjoNCQuelc0IAaO4nLUXk0BOSxSxt8kCvsUtQIDAQAB
o4IBPDCCATgwHwYDVR0jBBgwFoAUu69+Aj36pvE8hI6t7jiY7NkyMtQwHQYDVR0OBBYEFIKv
bIz4xf6WYXzoHz0rcUhexIvAMA4GA1UdDwEB/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEA
MBEGA1UdIAQKMAgwBgYEVR0gADBMBgNVHR8ERTBDMEGgP6A9hjtodHRwOi8vY3JsLmNvbW9k
b2NhLmNvbS9DT01PRE9SU0FDZXJ0aWZpY2F0aW9uQXV0aG9yaXR5LmNybDBxBggrBgEFBQcB
AQRlMGMwOwYIKwYBBQUHMAKGL2h0dHA6Ly9jcnQuY29tb2RvY2EuY29tL0NPTU9ET1JTQUFk
ZFRydXN0Q0EuY3J0MCQGCCsGAQUFBzABhhhodHRwOi8vb2NzcC5jb21vZG9jYS5jb20wDQYJ
KoZIhvcNAQEMBQADggIBAHhcsoEoNE887l9Wzp+XVuyPomsX9vP2SQgG1NgvNc3fQP7TcePo
7EIMERoh42awGGsma65u/ITse2hKZHzT0CBxhuhb6txM1n/y78e/4ZOs0j8CGpfb+SJA3GaB
Q+394k+z3ZByWPQedXLL1OdK8aRINTsjk/H5Ns77zwbjOKkDamxlpZ4TKSDMKVmU/PUWNMKS
TvtlenlxBhh7ETrN543j/Q6qqgCWgWuMAXijnRglp9fyadqGOncjZjaaSOGTTFB+E2pvOUtY
+hPebuPtTbq7vODqzCM6ryEhNhzf+enm0zlpXK7q332nXttNtjv7VFNYG+I31gnMrwfHM5td
hYF/8v5UY5g2xANPECTQdu9vWPoqNSGDt87b3gXb1AiGGaI06vzgkejL580ul+9hz9D0S0U4
jkhJiA7EuTecP/CFtR72uYRBcunwwH3fciPjviDDAI9SnC/2aPY8ydehzuZutLbZdRJ5PDEJ
M/1tyZR2niOYihZ+FCbtf3D9mB12D4ln9icgc7CwaxpNSCPt8i/GqK2HsOgkL3VYnwtx7cJU
mpvVdZ4ognzgXtgtdk3ShrtOS1iAN2ZBXFiRmjVzmehoMof06r1xub+85hFQzVxZx5/bRaTK
TlL8YXLI8nAbR9HWdFqzcOoB/hxfEyIQpx9/s81rgzdEZOofSlZHynoSMYIEODCCBDQCAQEw
ga0wgZcxCzAJBgNVBAYTAkdCMRswGQYDVQQIExJHcmVhdGVyIE1hbmNoZXN0ZXIxEDAOBgNV
BAcTB1NhbGZvcmQxGjAYBgNVBAoTEUNPTU9ETyBDQSBMaW1pdGVkMT0wOwYDVQQDEzRDT01P
RE8gUlNBIENsaWVudCBBdXRoZW50aWNhdGlvbiBhbmQgU2VjdXJlIEVtYWlsIENBAhEA8MVm
Reo60XmFXNF7R8+qGDANBglghkgBZQMEAgEFAKCCAlswGAYJKoZIhvcNAQkDMQsGCSqGSIb3
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwNjIwMTgzOTAwWjAvBgkqhkiG9w0BCQQxIgQgsOqS
pb4FFWHWKNj1H7SAj101ceLIsXWpZOI2FQFvdkYwbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvgYJKwYBBAGCNxAEMYGwMIGtMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5
hVzRe0fPqhgwgcAGCyqGSIb3DQEJEAILMYGwoIGtMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01P
RE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5hVzRe0fPqhgwDQYJKoZIhvcNAQEB
BQAEggEATB7kQEwmXnilJf622g5VcTLQo68ep+rkXGFgQAYmkNIvtuVUP2n0e010i5n7vFr8
TPMYGGMUIo8fuz3HYc/tKh/rupXA8JCvM7edjXoJKzOtU8CHiYWURVEmqcgFrtNt7dfnLS4U
NeArOgmn1gt0mservVSuxkkqMbVOsqiRxKnQozWiArrgsrkR38UfgPL69CjGLMdO8EFKvzut
Qk0kFMqYy6qhG5Qnh0zEkVBhy2wKisIR01dK9jDK1/s8e8jzoOLVGr5WQhxokJ7ZEpUP9GvE
sdk5x8DQc119ddiiHSN12CcqXb8nf9KgCSwfVjZBZ83X1OvvW5vm7fTSXobSWAAAAAAAAA==
--------------ms000606030002060502060906--
