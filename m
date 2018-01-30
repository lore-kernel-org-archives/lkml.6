Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752602AbeA3TMh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 14:12:37 -0500
Received: from mail-sn1nam01on0094.outbound.protection.outlook.com ([104.47.32.94]:45504
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752047AbeA3TMf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 14:12:35 -0500
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zi.yan@cs.rutgers.edu;
From: "Zi Yan" <zi.yan@cs.rutgers.edu>
To: "Michal Hocko" <mhocko@kernel.org>
Cc: "Andrew Morton" <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        "Hugh Dickins" <hughd@google.com>
Subject: Re: [PATCH] Lock mmap_sem when calling migrate_pages() in
 do_move_pages_to_node()
Date: Tue, 30 Jan 2018 14:12:28 -0500
X-Mailer: MailMate (2.0BETAr6103)
Message-ID: <F3D5C6AC-78B6-4443-9BE1-575831F238E2@cs.rutgers.edu>
In-Reply-To: <20180130161025.GH21609@dhcp22.suse.cz>
References: <20180130030011.4310-1-zi.yan@sent.com>
 <20180130081415.GO21609@dhcp22.suse.cz> <5A7094DA.4000804@cs.rutgers.edu>
 <20180130161025.GH21609@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_932B6DEC-4598-4B7A-9293-DFD1740C5BF5_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-Originating-IP: [128.6.36.106]
X-ClientProxiedBy: CY4PR21CA0027.namprd21.prod.outlook.com (10.175.113.141) To
 DM5PR14MB1658.namprd14.prod.outlook.com (10.171.156.16)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c925b142-5ea8-4670-47f9-08d568156a45
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(4604075)(2017052603307)(7153060)(7193020);SRVR:DM5PR14MB1658;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1658;3:sdubXkydNTC0v26eA3H+Ug4xagpnfT7z3J8kh1lr9kTJpLsEAYPnIbrVqGHFlA2i2dfEfFg2gEQ7fuHaQlPqsGZrCfQkxrBa3oyz1ev1mh4EmDsD52GAICERdnzkEkmw0iyoKtLlmcKsTaejaB+spALcow3QkPf0IChxFa/yKj2QInRw4XiV/zr7QE4eKGBcTyE27sllxRjzJYPF6oeTp3t74l4eZMyKdulvChNjY4eKc+z+uhn8Spwf2uF05kN9;25:1RsYbhp26NxVkiNSNR5AW6BStEDKiyvGLrY5oQ1AfnqKA/Ei8W/VvlqlM4ctuITsu3K5B/0o41m7VJ+uPBlYvWJFFet08djqj7V0jdiP8SdYwLydbcZJJzak25VX8NdsiGP/RElERZ3zWoIDqqVBdKLamcARiGMcpL7rpYGIBqWG3n2Fh0/G9C+LmqRFfKw1ftjU/m0nnA1cS3opwvt2KzkK2nToNThcBdvBb6LWQAm3qfAzJLrn86Ar8P4eoBurfw3a/DHbLDHYufsd+k54II/RifQMDFxZo64ONMhwUltBJc40fRGl43KkfVxVYUP1PLaMlS5cvtbOUOHfA6enSA==;31:0nqhRsTThJp5aX2yLCh/t2vv15jxxPhXRWQsez0rzt35FX0/6P+dSWyYmAAKENXc38xATWwDTBOfklsRbDR+T3FAyS53v4QJK5LpEEnv7+OjuejpbaocI/umU4/ld42lK5fkHSnpntOvbZsZ8Yq3PyijWWqKkjRz4bDf25f7cDQmb7NaMlgKmNL6w7NX9jf/CbDHQqNOLKk9kEnPFwqERTKv62U6Olt+98OUhHsl+X0=
X-MS-TrafficTypeDiagnostic: DM5PR14MB1658:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1658;20:V36LPNub8jLwjnA/qoyNiDGPDkvEzz7HzfaYrMWMniWvwAcrRXOHG0HHYF59n3WZF75i5LGIUezS+0lE7MRiAN1PHXqWzgfRgPHw0hwkVsKB/WLvRWXyjjEIa1NLlCKgjdzEh53s4FdinaISQNvYbaRK0Tk+Gl9LMzvJmcAYTn0XazK/ztR1pATnOT11MAZiwbOzc5lWzfgm8yguwewvWwqJtE6Yeg2RHSJkGDQ2F+uKeSlWUtSZ0bVRIKZwj14H1HI1dshjmxiLj9GzT3FkhDdZRwaLNdWNXDdPfSI+rVdd/+0d1djGIzTNER3q+EJXxeDI138jCXxWcPSviZkiyZ+srb4VwiCgrdUm9UZed7UMhqMH4LGH9/hUt6x7PCcMx+BCN39hCv6zLHq028vxImsWqQw/VJpYO2wVoCXRul7EZNSHn6aV/h0A1zudM/JsCUvTS46lNquiYxH40JWJX2WXjozAFjySjUjZhQrp5HCbAqOv1NStfzTyIidR3Lko;4:zJPkdtZDf86lBHbnWXx4VUaNsD2oH/xEcj6J3vhRewQP3USU8aPzJFfk48nKCpWgjF4Gz5ggXoBGKji0xpOqBYQaOfFCYl6sciq5HzmEwtSvCxWR9S4/C52+LzXjL5YwLv+Op2S0AizHo/Lx1neFH65wobtcdP63+4T8Evm5eT5T6TmmvSX+Hd8nQFBdn/QnApSVNDZRHzl6eMSzH2JbrRdsgpCKhrSTSRgSni/Ppn4BLgYuHKQuAxdvUNhkXqgcuLJssbnC2VnWNYASJ1k7roQyv30+j12oDV+rjBud1orZvKicXyumxjHZJKtEEozlFGaUGKACvscXUSdCVrEjeSUhE/I4W7fq9kavYSV/t+FFJ0VlK3OJVCLuzLkdkYIZ
X-Microsoft-Antispam-PRVS: <DM5PR14MB1658202D42D618DD51096B11A5E40@DM5PR14MB1658.namprd14.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(189930954265078)(58145275503218)(219752817060721);
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040501)(2401047)(5005006)(8121501046)(10201501046)(3002001)(93006095)(93001095)(3231101)(11241501184)(944501161)(6041288)(20161123564045)(20161123558120)(20161123562045)(20161123560045)(201703131423095)(201702281529075)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:DM5PR14MB1658;BCL:0;PCL:0;RULEID:;SRVR:DM5PR14MB1658;
X-Forefront-PRVS: 0568F32D91
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(346002)(39380400002)(366004)(39860400002)(376002)(396003)(377424004)(199004)(189003)(77096007)(2950100002)(6306002)(66066001)(81156014)(8676002)(53936002)(81166006)(86362001)(106356001)(8936002)(229853002)(50226002)(16576012)(54906003)(75432002)(16586007)(105586002)(5890100001)(33656002)(90366009)(88552002)(786003)(5660300001)(7736002)(6116002)(97736004)(568964002)(59450400001)(26005)(2906002)(76176011)(316002)(68736007)(52116002)(25786009)(6916009)(83716003)(6486002)(84326002)(4326008)(16526019)(966005)(6246003)(93886005)(3846002)(186003)(45080400002)(478600001)(82746002)(42882006)(305945005)(53546011)(386003)(6666003)(72826003);DIR:OUT;SFP:1102;SCL:1;SRVR:DM5PR14MB1658;H:[172.27.41.123];FPR:;SPF:None;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;DM5PR14MB1658;23:NW3ZYXond2ItJjqQISIYX0Rb4Uev7ZPABEWrUj6hU?=
 =?us-ascii?Q?eFIFVjXp8anCc16dVo4cCS8aYZFmuyThkLPrhdDYiKrfQU9MPd3J00Jwd59t?=
 =?us-ascii?Q?udlSt7G+mnlmcHwiVhEjHAetOeUbrrFZNenAVum3uLe403D2/kg3lxy6x/gl?=
 =?us-ascii?Q?qr0wJubnI1+dlNQfAKZwmSb5475eK/mwBiH4BOh6uaDvLkijYysfRD7LvgVN?=
 =?us-ascii?Q?bWQ+kjq3qvn/kjW6UBAGmKkC/WdYMBSQLWzz+j+9ve7kOzpO73GcAsmM4Aat?=
 =?us-ascii?Q?XrP3u4UG8T3E6Z51hoBJuTJKbJ3uRIyWS60Oj0n4Y+QFoYtyUC4tNPvwB9PC?=
 =?us-ascii?Q?YCoGMhC2G7F5bqRbd9pUiJmu/LS9YGoQePegmb+GLNS0WneZ9nB8WORavKL7?=
 =?us-ascii?Q?LLja45/qSlm02WCBYBSOEUIgxZRBxGLYxYFvvZKdCqbD1YNqPjdsWnKNzx2t?=
 =?us-ascii?Q?Gc/YOJXcnPBJ4/L9ThyX+ez5gxip9AINsiAiLtUIhOLhkEeQoCSTlrzTM60w?=
 =?us-ascii?Q?6yPnzVQS3NTJCzT2LdZ6qL68mT/0zptyw6FjC8+PDY/SybQ0bpMGlaWOi37v?=
 =?us-ascii?Q?e/qsBEUDjOagDLGRG4cTYNXsk4uWJ7XxuJQWcndgZT+yf9GcNLw4tVYKxQRc?=
 =?us-ascii?Q?RhyyIPPauI3GvUQCvfMQlsSh3XjTTaOM/RKxuMymSJ231GEo3tG9vJWjD/HE?=
 =?us-ascii?Q?RHGDYr55uUyuMoTiD30I1Lqcq2Smdq/srCWwF9O4xRaxho+o6eRZ6C9kQ6dS?=
 =?us-ascii?Q?d8GpmXX585+NlZqrClUb++o2Vrk20IIR2qs8CioKJPZdeZncL9L62g/LJrGJ?=
 =?us-ascii?Q?TeoT5QESXmL7uPQk9aqM2n2eJXE7qdGJGtSLw6ZRdERAAJPElLqRDgRYRuAh?=
 =?us-ascii?Q?PGG93Cz44l6bFiDBVH0AqI6VwirK0h+k3QEM1OHLhMjUDvNCz54G1kHUaMLM?=
 =?us-ascii?Q?nOdQBia951yqsK/LOJ6FgkHIiCI8jWieXoIdOzI6F46Qqbtkbxn9XmSv6n8a?=
 =?us-ascii?Q?bD4zPUJY/xamR23QpcX0US6rEw1wGRVa8R6nrT5ZbSdqxcehGYMr8MvAkYY5?=
 =?us-ascii?Q?QBebtRMRtHF6u9xC3G2NyPBHSUZJQnRJB+9Us2AgOIfqxvepsZji+LPhDEqU?=
 =?us-ascii?Q?4x6vINckx5XXnJCGB5UWocEQIiDqqjLXWTz2unROqwGcQYUdu1qEdjpTTjBb?=
 =?us-ascii?Q?mYCEMQeohwSD7ZBVXtnybC8C8XmUtfKWnsF7hMD2qfLtl77+74jmwXBegMa+?=
 =?us-ascii?Q?n6TMxW4iNEag/AUis+j8nJEwBrp+816n7tNBMBCJb+uYQNimbn7/0kDcDwJz?=
 =?us-ascii?Q?luBUR3guIKfXED+vRpiJ/rEDrB8QvH/HhyMy7r9RbV8Gj1YjCohXUWLkXXY2?=
 =?us-ascii?Q?Zya3D9zNsXlb/p2lgjm4DOKF0WY47JrYN6P6jIAzE513WamyUR0yswJSSLFC?=
 =?us-ascii?Q?E1EsB3vOtVbtKNE3O0bcLPIC2r3t11nCOOJ+wueruWrXkExUNIU9+xofUQA1?=
 =?us-ascii?Q?P6p4de+SAzS1g=3D=3D?=
X-Microsoft-Exchange-Diagnostics: 1;DM5PR14MB1658;6:xse7yM3A6beaSpAfCk2qwiKOJkqOo0jnbXUq2rHEVwO1xy/rUqlIogv0YBGJ3q7uA8Ad5KDrxjpxgaBcraCzLF76KTU7/cUsp3uquhwjtA1k+Sto7BIZ1aLNQQjigZpHsdk/a+zZeY9Ob6aDZ5EPJ7IV8F2MvV+Vvf+4choBKh6ghLMjLwZDxHnuwNXsE9nSIkV4hjNNsq7CFRzT+k2WZhB4kT11kprwpKBOg885nCW+JwZSmFAfxBFnwgytoBtN+R9WQ8rKZFC0jPwPPzKqo+LF7zTjBNoc7tnWFSzYQVm7ZFSDkobRVRT8Ecacsb//s5o8bWnE797ryMVdwWmdd6/thP/wlY1ZDn6i1FJDuE4=;5:BON8TUN95yn11HDO+Mj6QEZd3MVTDqGb1k6M5fd8LeLYpThZGJFIHpDVtPDUIvTX+NDwr6/5r/9MEkgJtEY6Hme512wwFNQtpe5u+QTUq+ixSnnGshYLUWPGV90XpfGzvF87lvtaMgE04DtUUAgWJQz8bPcIgQD6yZNvXUxv+Yg=;24:Axk/V38uLtF4IsHDDyuam5XxqOWRz+O5UL6cbQvawC4HfGv5Gcp59iOG8HEDxAkoNyyqSPD3M5AaF9NWyt9XWbqR1qBVytRHyStM+HWPYpQ=;7:W5MAy56lScDTqHFAr1933jZNgDy0Lk8NE59HqwI+pm6MB1H58baAbzO9dCT7wRYA+biZdrfmmdrieZ34Ua3AnVejJCg6X4OmMQdTd12/HN1qati2y80xcYo4f3g0fXEvP2IDTHrSGT2ey0kwlvZFtV1gqFWpEjhL0QAl6pnTASyD9Ig4YIvjLex9c/EVIfDxoZ1HIedERN+2V8OJDPGnaup663yqr9Uu1feTF2QyUVl6ECmSQjs96xPWRy0VPmsn
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: cs.rutgers.edu
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2018 19:12:32.2914
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c925b142-5ea8-4670-47f9-08d568156a45
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b92d2b23-4d35-4470-93ff-69aca6632ffe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR14MB1658
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_932B6DEC-4598-4B7A-9293-DFD1740C5BF5_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 30 Jan 2018, at 11:10, Michal Hocko wrote:

> On Tue 30-01-18 10:52:58, Zi Yan wrote:
>>
>>
>> Michal Hocko wrote:
>>> On Mon 29-01-18 22:00:11, Zi Yan wrote:
>>>> From: Zi Yan <zi.yan@cs.rutgers.edu>
>>>>
>>>> migrate_pages() requires at least down_read(mmap_sem) to protect
>>>> related page tables and VMAs from changing. Let's do it in
>>>> do_page_moves() for both do_move_pages_to_node() and
>>>> add_page_for_migration().
>>>>
>>>> Also add this lock requirement in the comment of migrate_pages().
>>>
>>> This doesn't make much sense to me, to be honest. We are holding
>>> mmap_sem for _read_ so we allow parallel updates like page faults
>>> or unmaps. Therefore we are isolating pages prior to the migration.
>>>
>>> The sole purpose of the mmap_sem in add_page_for_migration is to prot=
ect
>>> from vma going away _while_ need it to get the proper page.
>>
>> Then, I am wondering why we are holding mmap_sem when calling
>> migrate_pages() in existing code.
>> https://na01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Felix=
ir.free-electrons.com%2Flinux%2Flatest%2Fsource%2Fmm%2Fmigrate.c%23L1576&=
data=3D02%7C01%7Czi.yan%40cs.rutgers.edu%7C855d86d83cff4669d25f08d567fbfb=
8d%7Cb92d2b234d35447093ff69aca6632ffe%7C1%7C0%7C636529254319323899&sdata=3D=
Ba8F7IHIjxDRV%2FeGg7883wlRBmDHQW6pbZubAWZDNLs%3D&reserved=3D0
>
> You mean in the original code? I strongly suspect this was to not take
> it for each page.

Right. The original code gathers 169 pages, whose information (struct pag=
e_to_node, 24bytes)
fits into a 4KB page, then migrates them at a time. So mmap_sem is not he=
ld for long
in the original code, because of this design.

I think the question is whether we need to hold mmap_sem for migrate_page=
s(). Hugh
also agrees it is not necessary on a separate email. But it is held in th=
e original code.

--
Best Regards
Yan Zi

--=_MailMate_932B6DEC-4598-4B7A-9293-DFD1740C5BF5_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - https://gpgtools.org

iQEcBAEBCgAGBQJacMOdAAoJEEGLLxGcTqbM1YIH/iv7+2aqTWmpTb2mKhI7ntYW
cpg8gYQ7d4xd+hu0LYloy6nC2qU94op3T30W3sN7HYLuQFPGDdM2R3s1AdbEG7nC
PKEVb7GqmhseDSsKPMc2oHIod3nKgasiwMn/S9C8j/53+5y2dNeN9ss3g4JTdRSq
MFbTKf6XhGJ+HUcCz2iRSd6RBeF9S/O16FlSXGwI/asGHDZPX3yTzyoyKGEtUhbR
VHUF5wluLUsRcyLpiPX3s/xFh8DvJbPxgaFBY7xFQklWBge+ktAadWbUuNlRPi/C
68wJrk5igVp0Bte3TXKOhQfavdjTUWvmsDFIB/ukffnx2+QxlF3bxb053DlCT3A=
=yPR7
-----END PGP SIGNATURE-----

--=_MailMate_932B6DEC-4598-4B7A-9293-DFD1740C5BF5_=--
