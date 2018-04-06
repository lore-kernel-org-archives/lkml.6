Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751570AbeDFCQ7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 22:16:59 -0400
Received: from mail-by2nam03on0098.outbound.protection.outlook.com ([104.47.42.98]:50720
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751278AbeDFCQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 22:16:57 -0400
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zi.yan@cs.rutgers.edu;
From: "Zi Yan" <zi.yan@cs.rutgers.edu>
To: "huang ying" <huang.ying.caritas@gmail.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
        "Andrew Morton" <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        "Al Viro" <viro@zeniv.linux.org.uk>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH -mm] mm, gup: prevent pmd checking race in
 follow_pmd_mask()
Date: Thu, 05 Apr 2018 22:16:46 -0400
X-Mailer: MailMate (1.11r5462)
Message-ID: <85E1A3D6-3057-462E-BA93-0B309B223B82@cs.rutgers.edu>
In-Reply-To: <CAC=cRTOjybaa+nEBcagDebGWh9Ty49TkcJkWi+BcqVcu3at2vA@mail.gmail.com>
References: <20180404032257.11422-1-ying.huang@intel.com>
 <65E6BD75-FBA6-43AC-AC5A-B952DE409BC8@cs.rutgers.edu>
 <CAC=cRTOjybaa+nEBcagDebGWh9Ty49TkcJkWi+BcqVcu3at2vA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_C3D63B1E-B77C-4852-9C0E-9DECACD459C0_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [173.63.110.204]
X-ClientProxiedBy: CO1PR15CA0087.namprd15.prod.outlook.com
 (2603:10b6:101:20::31) To CY4PR14MB1736.namprd14.prod.outlook.com
 (2603:10b6:903:15b::22)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 197dc67b-4e30-4b7c-dfa2-08d59b647684
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:CY4PR14MB1736;
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1736;3:PE+nIHWyhbGGaW3veTiPFnRVkNQuwxq/jpowAIa71i4R38LyO6b0IXjD8eralKw/KFrJkQcMABK5CDwc1sgbk3IhSDQGc3rX34Uw3F98edZJ6OPaMPe6k1VhqNbcO1t0xhNCrODAEN5hTZRdkdsIS4M4stdOaGZDzzQ3kKFIQayvrOAe+lXLxonHlRn0lnk8G9KJz6QEY519QizbQIR5jcUHPZbcVZ+j0hCA+jW7TMLAlSHiRRFPnDIdaTQYVsJM;25:lKdBl9lf0zmprRGpa2RUqAIhuxiUmzekowFWqYTCXC4E/6alCJWML1g0Pj730ETR0HFQ0oZaCqb6u6vs24Jr7/YFKp0KsXI6XiYcGjJ+B9HaqRTXUvVro7ZBsjSC4tVQDwMOiQIXaBIVJXap7VBY5Jb/MzLnQ9O3YicTbXDrdsrc4dXW+VYD4KHiTwrm9x1zyMmfvevVUmTK1uhK0W/nEVF6SnXKNaqojz981zfa34LiyN8qPQUikh2YvplTm6zEy/MwH99Eiz+U4IUM8bndojG+IEEtelPpxevgKT6SwlU4+B9GABhK4ibJGgldF5xim35iY59F4oXCH52FlKsJFw==;31:RBO/ykaZDcz6xopK2mKiDXhmqtsPz/E8NFnuBpZqKDQdtp3Q5pDbv0+rcwX0wa/BzcVQrf9T1WX6t6WNfUPCmT6O9DlmgE+IBqUdhKgAlUYxWzoeTwb/NShSCXSnNukxHQzkRyBQjn2GmAnSp76VYVs/BYjmiozMT7H5FpIBFK58AYJtQU3Ms0GIMumc1rFS8Ez4vmMClLbZqIegSsFPJmhkSi/R4aUfIr4aalLEFLg=
X-MS-TrafficTypeDiagnostic: CY4PR14MB1736:
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1736;20:b47CTmHlrzlvRhR9eoSNSVm4NE18zyiRilvgSTeDV/NWl49rhQP5oKPN6dJ2qdlcxDuQ2UoRW6gExtmUj9XCukV5lTwEgkcQFPQo4Fir82kei/bf9KPKki2ewQgZCxJAiQ1/MmvWNeHGQUeo/6/CAOQoiM7aR4g8U3FCFIOdaPKj2/2GtvlDxvfnK8OekjDFIq/R/ZYZr9P3wTZ+qPo7YCsd9tndEYROYxBZnL15RxVDLtKr5/6j/GEBEixplExA+AHqh5hSFWxiLwJOqHEgekdB13psztgRL+/tCzeKZE7jgf9DDP27X7GtykaPFYur6qFQJ1KNIf0h7AXD5V1bMbxrt2HNsM/hqlqvQLwWAk2dYxMl+c4db00vHlKplXmYrgH18amBPAfS6X+Sbte3ktbHivyqA2SSxpdH9JBmHiTS2iMurYeR9HxOopsZ2v6Av5UMUS6mNjYxI+8AFA4whvUxkXrZqgxf3eT5A+jPry61x6c9shP45JH5CeXGF0fE;4:UuaW8Asf0TxKvMpExpz0e+pXCvMXmczuJaiFH2r4bfVKuXtYsBK1CaZ2zliU1hna8rdGAz1ayBjuPC9fySRY/VWwc1CqgYnjw3BGoGUSpSiviZBNJfdnBVGEjxKt2IZcpGgxaKxqIlJTa+983vWIADeJEbUg3cFoPC+nEp7atQde3YBZFKdTO2d2klEfDE9VESc+EACLXbsds2Q4WaxaX1XnpzW1SChxOwuMJ+iedjDLH4PV69TOMXrou3Fh+95OqWp76wwmJTtJxRe/qQRoauesPWA22VKBjJ8sYRqzYY7CPi7Avq8i+6v6ifEBu6pMLfz58FXL/waSYzbPRkFd4qAtjKIU+IPfoNG5DRMVmXy8QHMkZ+hWvy65pk1qL456
X-Microsoft-Antispam-PRVS: <CY4PR14MB173656F8A1A22CF158C41F09A5BA0@CY4PR14MB1736.namprd14.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(788757137089)(228905959029699)(17755550239193);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231221)(11241501184)(944501327)(52105095)(10201501046)(93006095)(93001095)(3002001)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011);SRVR:CY4PR14MB1736;BCL:0;PCL:0;RULEID:;SRVR:CY4PR14MB1736;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(366004)(396003)(376002)(39380400002)(39860400002)(199004)(189003)(50226002)(75432002)(186003)(81156014)(33656002)(81166006)(16586007)(77096007)(8936002)(26005)(54906003)(106356001)(8676002)(105586002)(53936002)(568964002)(16526019)(16576012)(316002)(82746002)(68736007)(786003)(6246003)(5890100001)(97736004)(3846002)(386003)(5660300001)(6116002)(2906002)(86362001)(39060400002)(6486002)(229853002)(88552002)(66066001)(305945005)(7736002)(4326008)(59450400001)(76176011)(83716003)(52116002)(2616005)(446003)(6666003)(486006)(11346002)(956004)(6916009)(33964004)(476003)(53546011)(478600001)(84326002)(25786009)(78286006)(72826003);DIR:OUT;SFP:1102;SCL:1;SRVR:CY4PR14MB1736;H:[169.254.150.151];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
X-Microsoft-Exchange-Diagnostics: =?utf-8?B?MTtDWTRQUjE0TUIxNzM2OzIzOlNQK3FkdGFjQk1nV1FnVXJnbTQ2bC9YS01P?=
 =?utf-8?B?cFVSRVNNVmYvZ0pKRkg0MVNHSUFqeFlkZ1I3aHM4aXFFZW1uUlhGMkk5TUNn?=
 =?utf-8?B?WlM0YTZWaHB6cmNNd3dhZFFxQVMrdUNmT0F2VEFkN0VsMDJyVmFWR0V4bmg2?=
 =?utf-8?B?amVGRFNkYnVlWThQRCt4S1h3MHArSlBaSGV4ZWJERUF3Um91K0ZaZEVrTGdJ?=
 =?utf-8?B?TUlyaU5OdTJkWG8xMzdZU0FuTlFwWkM4VVljWWZrbUxCV2VIK3BDd2JWcGp2?=
 =?utf-8?B?bEpFYm1zeDZQWFBXZzJPaHFzQkdaRVNzKzVFOVk2MVd2b3IwWkdocnY5dUJX?=
 =?utf-8?B?Mno1MEF3b2Rvcm03a2dUM0NtUXN6aW1TZHBOSW9mZmdIYjhXb2F0SU1RRXVC?=
 =?utf-8?B?d0x4Q1pZQ2czeTJuL29sZmpqcTdmcTJFazJyRWJyR3p4aHVhRUk1blNrRHJa?=
 =?utf-8?B?OUNqM0ZzRE1KMkQydy8xV2tVbFF2WVUrcjB0TVFhYVprV0gzWmg5dDIzT2Y2?=
 =?utf-8?B?TmhVbmtuYVFpK2xEV1R4d2szd2NKbitxdGUrNU1OSENRaGtZTCtqcmE2M283?=
 =?utf-8?B?UEdqQnF1MU8wVDhpWXptWjZyVE5hYXJoSzZReEtxYktvV21hT254UTZMTHR2?=
 =?utf-8?B?RTZTNGVRY0hvcTRWSklpU0V3Z0crczhvS002dmNiSWYvRmtTMGdTQ1dYMjMy?=
 =?utf-8?B?R1U5cWtTV0ZRVWpneXhlcllMQXJ2MTNKTUYyTmpOVXdvVGJkemFJUHNPMnhP?=
 =?utf-8?B?OXVjV0VSL01hUEdZWGl2c2xXWmVWa2VMelluNnR0dHNDTzUrSFpFOFB2ek1l?=
 =?utf-8?B?akN2cGhic2dGRFBVSHcxai9SL2xqVFMvREtiUHhiTnlXZ1BIdUZncUYrOGIv?=
 =?utf-8?B?SHlBcDRlSzJBbGlLaEZGRy9xL2dWMXFoRVZsaUs0SWNMT0dNc0UzR1BRakph?=
 =?utf-8?B?ajhJdWJWUEw1N01UM3crYXhJTlBhN1JrZHl6TzNhdGZsTHpEZkhTcmNTd1pR?=
 =?utf-8?B?eXdWSDBpdDZBR3M2bXhTR1IxdEpuUTVGQWRXOEpTanBRbDRSZk9BZnZVRzRD?=
 =?utf-8?B?Tnd1YXdFdk5pc3Judk0xNWxUTFF5QTFwWDd4YWxGT2F4dUtIbStXVlU3dUxW?=
 =?utf-8?B?M1ZVamVYbHAyTWZBaUczNEk0SFdjU1V2REhFVmNKeWl1eFhMMUVwUDFyMmlO?=
 =?utf-8?B?bjNZakg3UUVoS2ZhU2Z6b1F3eGdRdVZab0ZJZTFFRkJ1MTB1cS9PZnJGYjVm?=
 =?utf-8?B?YVg4c3JWdTVjSlhGZ2ZvZkhjZFhLUUlqbW9LQ3J0N0dWZGE5T1ZHMm1DODlM?=
 =?utf-8?B?OTRiMWl0VEV3NU4rVEpyb1NtemNlZUt3UVpMVnVPcllXN1RIdmk5VnBhbEVS?=
 =?utf-8?B?S0k4Ky9KcHNDVDhyZTRoN0N0MGpQRGtxbDVrd1hsVE1nZklIRHZ4T1lYUkhC?=
 =?utf-8?B?UnVJSkkwb3JaVmFjUWQ5ODg4azQ1bktDbm5mTnRMTERqM2k4dzlWYmU3Q2Nr?=
 =?utf-8?B?VjFJZmFja29CTWhKU2tLMmp0SXRIV3lIMUlUVmZVWEdaSzZYUGVMVzUwQWN5?=
 =?utf-8?B?REJJM2tPcEV5cmtqZ05OZzZsTXloYWNrcFdkUDlFMXdsbmFYOGlZbEl2cGtM?=
 =?utf-8?B?SmxybkhIajI4YllVRnpmb0d6M3ZzRHdmeXRaZXBSMVNSbHpXMjZOV3crcFRF?=
 =?utf-8?B?ZVh2K1MvRHdhMzJTZU5xMDlLR3RPNXkyRmNHbUwrSk9IWXEzbGpiS2FBOHlK?=
 =?utf-8?B?dzBCYlptc1VTSXJNQlNlbytUcG96eHJoRnhZK0FUY3hGTGtlUGNpNU40WU1L?=
 =?utf-8?B?Zzh2WHc2djhDVHE5M09mem5zMythNVNmcjJKRVdhRENPQjdJUGtFanA5TXh4?=
 =?utf-8?B?SnhnQmpjOWRqZ1R2RDRCY2ZvdEhrd3JDaDFjSEpqT3Nvblp5ekdLT2VMdjlN?=
 =?utf-8?B?ZkxrQ3gyayt4MzhTQ3VFMXEyYkh3VG1nOVBrT21ENTFmRXl0ejZ2d2JVWU9D?=
 =?utf-8?B?UmRiV1FYd3ZmZE1NUDJjMHpNaGM1OE0xTGFMZz09?=
X-Microsoft-Antispam-Message-Info: JNjk+SeGlD+bZRQJ8m5kyBQbbuGOX8rnCJtQEU/XRhHG70v2zfJQvqE10nEiVpN7dFJkMz/3TC6eFYFm+IggjUVqzDkBX+Ld1BnTZicUd48wCFGmoVFBNQm3X8jG7bCHHWNV6iMMjfZ/7G2ZEQFEOgOggmfB3Z2S6Sh2BI/wno2RLQQGP2rzQu4TzzLuGsPb
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1736;6:W1i/uRSamB4uKD3X8HBcd8qPJ7Pb1z5Kx+xPJex1s2w3fikW7m43CANXKtlwnCQCLb7XFsWmlxWS8M6IeexpVfS0JP9Z25rVeKZ7wO0jEtnmjo4Fdg8jOQ6Qj26jxcE+RWt0JmJ4WtABuY+mMp7o3XR/cHuqSL8j2r3VgNBJB+BVKo3FiFLbkBzeSvfCaXl/ecHzwPXfXjqfp1AYlbJAUiJED5bzzrQZMpDeUQBdNgRXgBQtqI97c+AHdpEmwesbSu0UkjcaFAQimssmpbQAZLPotGxMV64hPdyNSH0acsC3owg2Q64b0fYlc/qfNM896GLQUhkrZFleWc/tlulgMu8F3p8oiOyz0yqFD/4XHjLF12sqa7Dsx89JW6pgBcvES82CNPQzcXzP8Be8v30QsVG5PVmPE4u7ALJ+WR+miiol745e7rweu6CPg2pqK/9zxidPnfnkUz7z3FWWXfS3Eg==;5:llq4iMUnDlBxOz1l/bMn3EFZh57rNpg6ZhOH6DlzIdyCJoIfre5XBgXExNc3crymf1dYdYOxoxQRW0X3tciIs2F8xDzOsMl4UfB/TZ5bWX5kVe6DPv4ieFSW9LUAA45x0XRLw78as8yUYIGKHJyQc4bgqUaedVmej7hJH52myBA=;24:/kS+B2V1gxIdO/tWqPOLxq+fnaSl/9V1cjz7nWJZ7L7yk4SU3LBhaWyUvlw1SZVrmHihKbfWFQWnw3eY5m8F6enK0RjV4NHMQjp2e0WMEUY=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;CY4PR14MB1736;7:4Afqb8OzAmKsqRfxKWdzxnXKEaWP7pZMTghOCnPs2n/t0+cVIWVyrpoUw1n1HYxmJ7zgb6MuTHEfuV50TUDoC0VHxTKchvBlS11/Py/W8PHtDo79GVjgEepr7lv8fnXbj8CMPgGBE64beCju8U1VhkEGaRQWSBP4Z6NBBJnN5tldz/Hl5HczvkBCwet/E1zdZymaZ1iFBMFRRhjOGhBDIl8HjsAqeUwAKA6hSc7Jp0p/Q7NCvk9kefwZPvkL1dYE
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 02:16:51.7278
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 197dc67b-4e30-4b7c-dfa2-08d59b647684
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR14MB1736
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_C3D63B1E-B77C-4852-9C0E-9DECACD459C0_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5 Apr 2018, at 21:57, huang ying wrote:

> On Wed, Apr 4, 2018 at 11:02 PM, Zi Yan <zi.yan@cs.rutgers.edu> wrote:
>> On 3 Apr 2018, at 23:22, Huang, Ying wrote:
>>
>>> From: Huang Ying <ying.huang@intel.com>
>>>
>>> mmap_sem will be read locked when calling follow_pmd_mask().  But thi=
s
>>> cannot prevent PMD from being changed for all cases when PTL is
>>> unlocked, for example, from pmd_trans_huge() to pmd_none() via
>>> MADV_DONTNEED.  So it is possible for the pmd_present() check in
>>> follow_pmd_mask() encounter a none PMD.  This may cause incorrect
>>> VM_BUG_ON() or infinite loop.  Fixed this via reading PMD entry again=

>>> but only once and checking the local variable and pmd_none() in the
>>> retry loop.
>>>
>>> As Kirill pointed out, with PTL unlocked, the *pmd may be changed
>>> under us, so read it directly again and again may incur weird bugs.
>>> So although using *pmd directly other than pmd_present() checking may=

>>> be safe, it is still better to replace them to read *pmd once and
>>> check the local variable for multiple times.
>>
>> I see you point there. The patch wants to provide a consistent value
>> for all race checks. Specifically, this patch is trying to avoid the i=
nconsistent
>> reads of *pmd for if-statements, which causes problem when both if-con=
dition reads *pmd and
>> the statements inside "if" reads *pmd again and two reads can give dif=
ferent values.
>> Am I right about this?
>
> Yes.
>
>> If yes, the problem can be solved by something like:
>>
>> if (!pmd_present(tmpval =3D *pmd)) {
>>     check tmpval instead of *pmd;
>> }
>>
>> Right?
>
> I think this isn't enough yet.  we need
>
> tmpval =3D READ_ONCE(*pmd);
>
> To prevent compiler to generate code to read *pmd again and again.
> Please check the comments of pmd_none_or_trans_huge_or_clear_bad()
> about barrier.

Got it. And if there is a barrier (implicit or explicit) inside if-statem=
ent, like
pmd_migrationt_entry_wait(mm, pmd), we need to update tmpval with READ_ON=
CE() after the barrier.

The patch looks good to me. Thanks.

Reviewed-by: Zi Yan <zi.yan@cs.rutgers.edu>

=E2=80=94
Best Regards,
Yan Zi

--=_MailMate_C3D63B1E-B77C-4852-9C0E-9DECACD459C0_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQFKBAEBCgA0FiEEOXBxLIohamfZUwd5QYsvEZxOpswFAlrG2I4WHHppLnlhbkBj
cy5ydXRnZXJzLmVkdQAKCRBBiy8RnE6mzFrTB/9SQANqE2gS7RDqLZn8VaaR4URi
M23TPiG6Sruk2AaR1TVMI4MbjdPXJc24sHo1OrVGmpJes8oSOopt5JcOUB+oK+LY
0KACPjKFNjUvBlEaQdcglL757oNWBRd88icNPaXmK7QCZaDs1l6K+idvz/7bOv7D
bhnk/sayjmPKXnw7eJbyKzfay0R3DjG8xBZCMzl7kzw5rNrFcmLSknOhprjqpsme
WeL7Zooi8qdcrKdAsb0VJBQM1tHaMsj1reNnxgCFU7CU5dLXTD6GGxAmyVG+mBr2
9rLQAQDT2uuhZjltQXTblhN9tMV+YRYjSOsrv9aqTWALsY+IJu2a3oTfbLUu
=V7Tj
-----END PGP SIGNATURE-----

--=_MailMate_C3D63B1E-B77C-4852-9C0E-9DECACD459C0_=--
