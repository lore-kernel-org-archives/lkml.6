Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id M7t7IiLJGluUUwAAmS7hNA
	; Fri, 08 Jun 2018 18:22:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0249B607DC; Fri,  8 Jun 2018 18:22:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="Cs4AV567"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 37F0C605A2;
	Fri,  8 Jun 2018 18:22:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 37F0C605A2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=fortanix.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752904AbeFHSV6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 14:21:58 -0400
Received: from mail-eopbgr690093.outbound.protection.outlook.com ([40.107.69.93]:2349
        "EHLO NAM04-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751574AbeFHSVz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 14:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector1-fortanix-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FNQOBw6hmkCvbOpFQK9BrRzO9BGPZMEuy8pSISmPCQ=;
 b=Cs4AV5672IqriXV4uNqYe2p6aPOyA4XiIBGpaPRMSqbwdI8g2uo1y1HG9PUwj4vh5xgrLkT5ycLYC13n/+4Ov0e2SXaUfim0xsXYWy6aRRqgpOOuXIUrrvm3emZc1dPhPP/ALNc2BAL7kxcL1K7IfrCaQOyj96WxhgQMCYW0Sks=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com;
Received: from [10.198.0.221] (67.207.107.146) by
 CY1PR11MB0313.namprd11.prod.outlook.com (2a01:111:e400:4c54::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.820.15; Fri, 8 Jun
 2018 18:21:51 +0000
Subject: Re: [PATCH v11 09/13] x86, sgx: basic routines for enclave page cache
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, x86@kernel.org,
        platform-driver-x86@vger.kernel.org
Cc: dave.hansen@intel.com, sean.j.christopherson@intel.com,
        nhorman@redhat.com, npmccallum@redhat.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)"
        <linux-kernel@vger.kernel.org>,
        "open list:INTEL SGX" <intel-sgx-kernel-dev@lists.01.org>
References: <20180608171216.26521-1-jarkko.sakkinen@linux.intel.com>
 <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
From: Jethro Beekman <jethro@fortanix.com>
Message-ID: <78982a32-c589-48e2-9a83-fd36903b5588@fortanix.com>
Date: Fri, 8 Jun 2018 11:21:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180608171216.26521-10-jarkko.sakkinen@linux.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000702040404050307070406"
X-Originating-IP: [67.207.107.146]
X-ClientProxiedBy: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
 To CY1PR11MB0313.namprd11.prod.outlook.com (2a01:111:e400:4c54::23)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(5600026)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(2017052603328)(7153060)(7193020);SRVR:CY1PR11MB0313;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR11MB0313;3:AptSW5asL9m38KQA2G1CFkAv2uyNi+12dDiJ5V5CZ38p/1mgC0z6ZHmb2stMh6PDGhI2OZukMRfvhu4wTZyCcrdkeBlLCEwTtUohHFmlr84IEArn4Vl7UUnt40slNKLa6c0clzBpEHPGI8ZF7z/Dqn9yXrx9fjbgp8GMYGt03jKuLoXxK9nMgKouJSiIsSBb8T8L8S3gmA4ME/nA73ZUxh9xLr+rEyMzaUg0wZ4PGLwy5SAIcfG7Ck7uyex5P0A3;25:bXxi5Z9DCW8kWQgY2NeYEL6X+Qv04gyOY5GTH+Yh+HLFjRY47c5+jVy7KKnUMARe1Fnobsk/FAwFgI5wuKlCOi1+73GSOiyHzhkTVIg4SGpy+LDtJwpdhUXyoiwrT/apqBlzjf9IwofOupTetgRFLZehdvRNw5hhq3JDf78ALqySQddTy9hXIpuwJ5+QO3IfkCTCCCqinx/RnHiCsekG0VJm3n5Ry0b5zTJyMEsE4aPTS67tIcj42INBWnDXK/3D/kkzUnVH6xJ6HMv5C/zmDy7iexhKlcgbGGbnZpKsWhs6Q3jPNtHaAjHdjpX3asAxOkFequ6TbgCq4TaW3PYRJg==;31:w5NXOEmEAVGnqGUYZTu6Mrdh9rk6FVvq7l3Pg/9qHgb27gdezQoGpCVblibOf/F5icXEAUhJImE4ed4rllz6em4jT0f5Ao/3Shoz0r/RnhE9796lgyqorYQDd0NKSb8feBQXe6ArMBw8qe/QhGuan6Zr4jsU+xPU9Rr8z0jwc6uiDhSkF+U0ToCq9QejBh4UepGR5F18Dht9x6IWL2STQd80TJbQ4m9bOquf/j0II6U=
X-MS-TrafficTypeDiagnostic: CY1PR11MB0313:
X-Microsoft-Antispam-PRVS: <CY1PR11MB03131A56F9ABA6E278B8FC5CAA7B0@CY1PR11MB0313.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(93001095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6043046)(6072148)(201708071742011)(7699016);SRVR:CY1PR11MB0313;BCL:0;PCL:0;RULEID:;SRVR:CY1PR11MB0313;
X-Microsoft-Exchange-Diagnostics: 1;CY1PR11MB0313;4:dopbwwa38oHyf9fnvpPsGtsMlsK4cVcexhg3p2CMqjxcCYH/Biam72LqQiaAqAkCJJf9dzAUakyiUQQjLhwuFWuRoDxCTo4gxxHuDCmWiiPgjSxf5g4rKRZCOtKABTkUU4eEblaYZvTrZXX+SGuK0EGgN0fCRiZHksKRgVD/GAuZkTMPNzrbQwT/4V9qPXPIXmbxFK6FnVOQvs8twYtSqP+HrcxDvxttamJrgxOAzuNu+ivbbY8shjLqkfm76mBa+aIn6nZPu1O3KGSi4wxzrw==
X-Forefront-PRVS: 06973FFAD3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(396003)(376002)(366004)(39840400004)(39380400002)(346002)(199004)(189003)(64126003)(568964002)(36756003)(316002)(5660300001)(65826007)(6666003)(106356001)(4326008)(6246003)(3846002)(25786009)(68736007)(5890100001)(31686004)(26005)(16586007)(58126008)(305945005)(97736004)(7736002)(53936002)(16576012)(84326002)(77096007)(54906003)(65806001)(66066001)(76176011)(6486002)(81166006)(33964004)(446003)(53546011)(2616005)(956004)(486006)(81156014)(65956001)(8936002)(52116002)(229853002)(476003)(31696002)(11346002)(8676002)(7416002)(105586002)(6116002)(186003)(386003)(478600001)(16526019)(86362001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:CY1PR11MB0313;H:[10.198.0.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;CY1PR11MB0313;23:6+C49qeQAeYIzQozuZLIW5k37mVSaX1FJpuRUBydK?=
 =?us-ascii?Q?s7PABR3RgLq3DoTzxI52kPoF9B50jTJ7JJJsuUl9LtRF1f8FAFiDqSCDMvlI?=
 =?us-ascii?Q?7L1+g0gMJ1AgMxcYX7ezVgmNHzgubZXEDTbWLOU2jtPtXGbFGYGmrqZQmE3l?=
 =?us-ascii?Q?Js6S905PWUFXRdqxaM8yOXS3Uq5gLNTRsk2r6RcPKqPAtHFlB/IjZuxYcAxG?=
 =?us-ascii?Q?awVHr82uJ30XUv63vxhRs7i7VPDj9WHMx36n2kqVmXYDtyVXqZ13jrDtEKxH?=
 =?us-ascii?Q?3+AMKaUDDUa6fFA98P+Wv6d5yexLyx510D4OWqivM3CD4ytlKIaLXCpETpnd?=
 =?us-ascii?Q?/hwwmyYaLEh5JkBqQcuIQLe0D5G8HtmrM+zGWS0PSh6V8a6c1GPSO0gYIYSa?=
 =?us-ascii?Q?pZturN/emiy7pqUOB24IYJKLmM0uPvrv5oLUiQhdfDCeV7WI23pE0Z6RPP1V?=
 =?us-ascii?Q?gE4SFxhIL8EsszTVn2jUIHy9ieaQHEU4YtjxWkrrH0Gzta9KdOBbWzOIFy5B?=
 =?us-ascii?Q?3jpdjVh4JBdDqSSMg3ewUIOWs0FPiLSlb79j/0hW1EwckODVhg52zOQLXcD0?=
 =?us-ascii?Q?ZnGt6GeF/he7+QGQzVsqWPwewDTh0QaGwg4uIyqy7S5KYTJi01EzcbWB49F8?=
 =?us-ascii?Q?EIS2EETF4ByGhCns8gjSDAnMbAxmhomtTK5Shy+36FLOb0E1meNnOq5YwZin?=
 =?us-ascii?Q?tW1SzUpB30+L2gKOXk1gkGVMcmJeV8xqSMtYJnfBmotCAQR4dSxI/L9Hij0N?=
 =?us-ascii?Q?QeT+qoSRN/EcMRELHZbg3dr6aH2VwQY2r8jBEJySvuVun1QKzas7gPBuodgF?=
 =?us-ascii?Q?NsekOEKUIBWvK77T7YuSY2Wl+YQEnP6SPiAWUr202qDF8bbc1ViYNzJWMkQf?=
 =?us-ascii?Q?VBWyIn3J4h1eDBy9SMtOUOQQpSoPkHfFeiNkN/G/E/+YpJaWDjz2xK5jIQY4?=
 =?us-ascii?Q?bpMcB/SH2qx2dzTY3WIsNVBWM6ygj+7zgfbHF9l38uJCz+BBGTg+8yQRfSff?=
 =?us-ascii?Q?lqHdlXoA/rqMaoD3eRsV2EVciyF5mXJAywjloUX64vwGRkUPd1L9VqE/6AHj?=
 =?us-ascii?Q?K98sfXO6iiKGLxV2Z7xm4z1G5QNhcpOAVh9rwgdMpvWB7TDMW3SfAYBpXeGj?=
 =?us-ascii?Q?1yiRw5pUlh2S/UceJCShAtB6TT3sI6vI9I4xnYbDs7PRA33rye/WhtIGaNKV?=
 =?us-ascii?Q?e/ZRnxvF2fTJwpRBjCcWONYTQh5THbkbO5XO5RqidsKkj8TwpR08ngID5CiF?=
 =?us-ascii?Q?+Bud+jesO0Are8pctm2YE+mmg6UjPz4XPj/Yh/on06hmmrvjhggF1eekwqaN?=
 =?us-ascii?Q?9/w3+H49ZHrU07QsBN4zUlm35O4oyx+7l5a6b3B0obSzX9QKbDsl4H17m6HF?=
 =?us-ascii?Q?Z/FMBYSlFruP344+hsm/H240UByjOGbkYw99wstUJa44C8Ncb7mQfyc4qEQl?=
 =?us-ascii?Q?uYi2Juxwg=3D=3D?=
X-Microsoft-Antispam-Message-Info: Rtsqvpc2RkIlJxngXzpU1vF4dhSHthP82uQ52+JC0A3Yz82MGLQ0FpS9/iCkrr89rhdH8gV60DNdxSne4wj1e3GUSedQ4Nalgz7X5Zqy0ynEwSh2hyDqzC5et0fNFXbDdxigX0nppdGiVwP6zsJ5ziLDExDzQ8dZcSFyN8fDeHaNdEZRrbQHMkvOSlp7PyIh
X-Microsoft-Exchange-Diagnostics: 1;CY1PR11MB0313;6:VSsiENZL3Lz/4v35Yi172kk3+ogJdEjWoL3OGhYCSZOio971pXqTNPucBc+WvgrYwISq40r8sVH/5xOLs5/c+U5Hx52XBRskSyv3VDs/T5rrpIwXNNBgV8W3rqw5CnE+nfSPymsyLxvKqkS/po0O4vWr1quwVG7YRz521N9CsGfXxDaydb+8rvuyTqN4vQIDeYCw5fdJxxEWFdE/USP8TKkBNRnXc+OMtKJJ8j5O61ni13/lyJJ8XPX++BE7E3R2lRf1QLgfEDR8Z3CiUPCXqaGvXnkaur8Al7fQv+atI+CknPcZZOLxzYxWvLpiyg8G+pA9IJelRgp2A/qORz4s1qbBjZ7DI5u1LN36c6zk+dKk6+IEoWKw+IknBo9ck5ji/pKvJPzwcF/mPYf0A+av02OKev2Jv5IaG4MAC8eWywu5JVdAZaSexUZj0zLqXEr4jmdIpI1lRb0dyBDCQpPejg==;5:GVBQuHdD0R3Z/Nh01RREDU93aVSay8D5g5uLRe6sijDS8wqYuGsJ0RnJ43CpBJDwfrUhb/l5WeCCNafS8Og4c1SLor6SchFiYaC2kbNgjw4RPvCgxZpohlgtLgOJtSrKppYsiRDNGE2t5hkVhMk2sCuYYNioSPJYI2HWdVBCkDk=;24:oPY0MhsuWwClLt02gV0EQvnysu22M4wCTCpzqQZ9/HHSPj2HhWO/CvVEUtYFwl/so74NC/tuAPeWIAM5SQudvoY8dno7vxXYz98gr5QvCr0=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY1PR11MB0313;7:AijccyFACb4BwattIOev2A8KrQKlSc2ixmieWkL81Ztju3KsK2PcP+ooHjDCjbcZ5D1gis0JqXxI+Ekch2g88XHADa9rfWSmRU5eoi8WDE9Dd8MyfldMm2qzrDRlMvtlNTboL0GeuCuDrFYAQ9R29MM7Ohm7UaHavSg6O7kpOEmRz4cNNerOqIPx/qIPZ9BOQcRoNxhoJWL367oQDpOPNOb1AWzZQfOLBmRRyn8CVPuCUxYtiHeKqdiZ/VchFvYa
X-MS-Office365-Filtering-Correlation-Id: bb413c6d-1656-4ed5-90b1-08d5cd6cb5c6
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2018 18:21:51.6550 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb413c6d-1656-4ed5-90b1-08d5cd6cb5c6
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR11MB0313
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000702040404050307070406
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-06-08 10:09, Jarkko Sakkinen wrote:
> +/*
> + * Writing the LE hash MSRs is extraordinarily expensive, e.g.
> + * 3-4x slower than normal MSRs, so we use a per-cpu cache to
> + * track the last known value of the MSRs to avoid unnecessarily
> + * writing the MSRs with the current value.  Because most Linux
> + * kernels will use an LE that is signed with a non-Intel key,

I don't think you can predict what most Linux kernels will be doing. I=20
think not initializing the cache to the CPU's initial value is fine, but =

this particular argument shouldn't appear in the rationale.

> + * i.e. the first EINIT will need to write the MSRs regardless
> + * of the cache, the cache is intentionally left uninitialized
> + * during boot as initializing the cache would be pure overhead
> + * for the majority of systems.  Furthermore, the MSRs are per-cpu
> + * and the boot-time values aren't guaranteed to be identical
> + * across cpus, so we'd have to run code all all cpus to properly
> + * init the cache.  All in all, the complexity and overhead of
> + * initializing the cache is not justified.
> + */
> +static DEFINE_PER_CPU(u64 [4], sgx_le_pubkey_hash_cache);

--=20
Jethro Beekman | Fortanix


--------------ms000702040404050307070406
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwNjA4MTgyMTQ4WjAvBgkqhkiG9w0BCQQxIgQgsJKW
gpW6nTIFf6zKj2N1pym/W64sYwOGK/pYLQxyQY8wbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvgYJKwYBBAGCNxAEMYGwMIGtMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5
hVzRe0fPqhgwgcAGCyqGSIb3DQEJEAILMYGwoIGtMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01P
RE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5hVzRe0fPqhgwDQYJKoZIhvcNAQEB
BQAEggEAwoVsQXcTTM+Ym94UJ03Soi0Yf6f958yJtvXEW7p+881zGbTz3PrYtQyrDDoirebU
eiWeT5VXOCu8ADSJ8MJhEtP1YtMm+Tmzgc/IVlBNUX+e/WiPnwjlYh7oAW+gEr/Tmk5OKYJL
huDULeDB5Gjk3MHAL63F4xsBilS+IL9bGLNOxe4g/ewX1vKGvvWWkZl059QrMEqIstZwX5M+
rqwO20qsCYGijSSkyjGsYnKTaonHuVwL7ggxwVOZb20ZVt3VeZ4dDY+tz0Fm++gYNSpWDrcS
Mt7/Hy0kR9MQ9k/ksmU91Zz/rjIEMPkJmBWWbmEoXjBkQcJa0qPDS8Czh8WkQAAAAAAAAA==
--------------ms000702040404050307070406--
