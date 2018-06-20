Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6487C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:16:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69AB020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 18:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=fortanix.onmicrosoft.com header.i=@fortanix.onmicrosoft.com header.b="l5gl56Ha"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69AB020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fortanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754558AbeFTSQo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 14:16:44 -0400
Received: from mail-eopbgr710111.outbound.protection.outlook.com ([40.107.71.111]:33872
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754504AbeFTSQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 14:16:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fortanix.onmicrosoft.com; s=selector1-fortanix-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bGnn2lcHPmjwY70RPlBB5kpQM93+0i/Zz6CNoqlx2U=;
 b=l5gl56HaKhq1ML62CFyNCqCnguse9Jp4PQyLNUIF3oB2qwtvvyVfDi+I2actPF0hAodo9Esq/h6l8mRdwyrjGSBfMZfW1n5GyW+6AwKsndOlcnsiYxCbOkZ+77c3W7am5rzhA1NS+Lf3n+1A5XTL5d5ryDhAGlAY9CA4TF6HqW4=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=jethro@fortanix.com; 
Received: from [10.198.0.221] (67.207.107.146) by
 BY1PR11MB0311.namprd11.prod.outlook.com (2a01:111:e400:5013::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.863.17; Wed, 20 Jun
 2018 18:16:38 +0000
Subject: Re: [intel-sgx-kernel-dev] [PATCH v11 13/13] intel_sgx: in-kernel
 launch enclave
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
From:   Jethro Beekman <jethro@fortanix.com>
Message-ID: <e3f8e5b9-aa1e-20da-37ac-3c3caafa66bc@fortanix.com>
Date:   Wed, 20 Jun 2018 11:16:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAOASepN9t3jF4ajfKLG_odTZddOvXjY_DqLQhRPWhJ-imtjkgg@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms000002030503000706070309"
X-Originating-IP: [67.207.107.146]
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To BY1PR11MB0311.namprd11.prod.outlook.com
 (2a01:111:e400:5013::21)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04c0f9cb-bfaf-44b8-9c64-08d5d6d9f753
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(7021125)(4534165)(7022125)(4603075)(4627221)(201702281549075)(7048125)(7024125)(7027125)(7028125)(7023125)(5600026)(711020)(2017052603328)(7153060)(7193020);SRVR:BY1PR11MB0311;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR11MB0311;3:86sMBuFIOprHLuVX8k0rrx33QUuR19C/Gno1ImC+5yPjZTjvGxxK+w8z8lNouK1q2OfX3G4jV/KtnADu/9+rF4SIjP08983I87XpyM5EMH3o/sMmpErphAgYerhnnN494pPqXjiV398TAoxFUZHx0MZScTEND5hgl0hE3BfMk9GJyuhSwt1pYZKWNHMlJ4I9AHnD0jVqLBPBY5c6EcW242THjdEU0xIy3NnYI8I6Qsx9InRTkuo+dqNgAp9hK915;25:knj8vzDBVC2ihuzN+9XXBywl61NBYFAMQ+pvxTwwVLw/+JWI7DAJNGxaHKqqz+pWwkuJ+V8UCBUXKTrHwr4c09lnWYsex2GNeo3kYWPQ8CjKRoyrz71DdQgzj6yOPrt0+5JVY6OadmkKg/zr7+UEDeQIwt+kncuNcdCsyeIohH+dy+H7QYcFrsP3aXohsW/2RA5rAOIC8rhVyIiNPogxOsCqmdRka5Y3mRg8gV8LIbAgu7Fi8aHxg4h3qReWMfIO7r1TiENeYx3+bhnWZ8p2rbOaGMRiS7C5UTLLquHX+YPehv8asO1M83WYUaQE2liFEkSSRC1phcYXylAEyW/mrQ==;31:3+Ojx5wn8OiBEtODsrf4LpQ8jAdUeQLXrHQzl3iVASNW9vkk7r4hQFBryfFuELLYxlgQromJD4fJgCXYKNZNWD9PWgzdVtU6ICBxTF59xw0Jt9Xz7QtD1Zd88yg4Ue+7JrKUPHTmNF4hREot/dpCvxrwM1QHtMFGG4vP7EY03jA/yQNzdNAdhIROsEcpMW0KjvweF+LukZDinPe6s5cMaxzZvP7JCT8m9dYDJGMpy1o=
X-MS-TrafficTypeDiagnostic: BY1PR11MB0311:
X-Microsoft-Antispam-PRVS: <BY1PR11MB03114210471AB809C9E5D7F9AA770@BY1PR11MB0311.namprd11.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123562045)(20161123558120)(20161123564045)(6072148)(6043046)(201708071742011)(7699016);SRVR:BY1PR11MB0311;BCL:0;PCL:0;RULEID:;SRVR:BY1PR11MB0311;
X-Microsoft-Exchange-Diagnostics: 1;BY1PR11MB0311;4:H1RGSIf7+pn0nTd4CXLxpWH0YV8fQpP3Av1bAJnwf0QR05/wIespFlOJbg9OQk+RW9+sWupJnA0KpWHNHjfT7g+lhyJgm/2pELNTkEeNCAEpfyRoByeuLmLMn/ylmVnMBxGzx7HqZLVHVcxwBRDhwowhR7cLT1lG1/SrNBweVdmBYwaEoq2FpwJplBcVduk1nhOeRg3CGrndtr5bPcUqr/x6cQrz5bYBWXOxUCVT684SKs9+HQjPVQCDLYK+IYT6DndchTvM6MCCVhpyqeyT2A==
X-Forefront-PRVS: 070912876F
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(6049001)(39830400003)(39380400002)(366004)(376002)(396003)(346002)(199004)(189003)(36756003)(65806001)(386003)(81166006)(66066001)(81156014)(8936002)(65956001)(8676002)(53546011)(76176011)(106356001)(93886005)(105586002)(52116002)(59450400001)(7416002)(31686004)(305945005)(5890100001)(7736002)(4326008)(33964004)(25786009)(3846002)(6246003)(6486002)(486006)(229853002)(6116002)(65826007)(86362001)(446003)(2616005)(6666003)(97736004)(956004)(77096007)(68736007)(568964002)(478600001)(31696002)(16526019)(2906002)(84326002)(58126008)(54906003)(53936002)(64126003)(316002)(16586007)(16576012)(186003)(11346002)(561944003)(476003)(5660300001)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BY1PR11MB0311;H:[10.198.0.221];FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: fortanix.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BY1PR11MB0311;23:0qGhH7NzL1BRIzXUaHH3XqjIDJXB1ftaG8AvFVZuw?=
 =?us-ascii?Q?CipVVbf4jLd6FRm015ZrUoQf5S4GQcjgbesbKQDYVkduwh37RTq5fjjR25To?=
 =?us-ascii?Q?wANBOy65Cfl0VFpEYm1a+sQYX1IPeSs9kHb+Xttv2DeLvpEdSCdnr9eTia+f?=
 =?us-ascii?Q?cHsYj4QgAnG3PX63qpnj7+j6dq4pQvD4sIXftmqt1PygGaB2wd4cRpwcxq8O?=
 =?us-ascii?Q?rQfe2gWMp6bM55CQLoi2ikAzoEdEgftroP+w5mhW3SbbpdvWPO4e9phzMXXh?=
 =?us-ascii?Q?zBOPfNlDQ3xAh6mudyoqq/vQ33RxloUV4B3Ra7IR8bpIG/ZHDrAcxhIowHJ6?=
 =?us-ascii?Q?7ASTfejXp9KtXnof24JD+JtT6VAQgLIpfBUNYHiPgl8Lk8GtGY8btiu0yrS0?=
 =?us-ascii?Q?Q3PaNJ0FIgNwQC4nM1EpUS82bevyzrf8pf7jhQxcFgqBLm++NutIaNoD4S2/?=
 =?us-ascii?Q?C/0K8Cc4QtcjA0tRWBIWx1yeQSYl8XslFhcG699TBk8rkKE3GR3UMwH2r3Sw?=
 =?us-ascii?Q?x4qIUk47qZ2FDmbBYW9Wv4cg/3q+jpRX/NRzeFSgTr8R5KVnARQwCYi8zl4n?=
 =?us-ascii?Q?ANR2yEyQVbfdMltDNhqA+DQQYHa+8Bj6tnqHqfe6m/QAdWdNQPYU5tuIEfUp?=
 =?us-ascii?Q?fdEYERW6v1EZi3xSjjRVSyiV+eru3N3obeK5a7p24jZeNLr+GoyYh3XIutti?=
 =?us-ascii?Q?0RAuxXBRztvOoM7db0iJamGJLRSvB628TJ0xWq771vQ9QQQ3NKH/tIqi4A6c?=
 =?us-ascii?Q?ApHxjql6f/YYVvE6gSB2B3d/zn/b0LnWADOPa5ZWG/8sEm0p3TDk5IiRElnW?=
 =?us-ascii?Q?R5ejmG3e1aNZNhVU2pEeiOhbgspQtreT7iD39LaImLKfyoAvJfyXvlcumrsr?=
 =?us-ascii?Q?I/LgQk+A9eT22M9OzWnA3aD58mAh+3IdJ4f4odcU3b/YjpKkg1tQecigV6fU?=
 =?us-ascii?Q?lxQjJJNbx2j+H4DZXKNlNAELZHpuItv6K5qSYfzDvhZu6YLEZ/SuvRRPQq6W?=
 =?us-ascii?Q?IdLqUgf+PAKF/ovRhgv+j2Q4Al4GImUlQyWx/QCE7GCnRRogjEg8gNpjxQYX?=
 =?us-ascii?Q?eCGpLjeLppnHwYrs/WPJ4cYcLsUIKXF2qD//yAL7GV6i65Y6mIszy3Tdm/6q?=
 =?us-ascii?Q?26sUcfjFIROMsWoeYtoK2oP/QwM7q/uyWBTPT9d2YYF+jbf8HwnVgNxvtWSs?=
 =?us-ascii?Q?9jpdF5j5ep/ARc4exMd/r+hTuG4RD2apzR+40oLYEtIuP+WbAP3HS7lOc8OP?=
 =?us-ascii?Q?9QYv50W9xUmGppVyFqavsATN595GljcHGwR9BQPPwlj9driGNpopN0uNYshv?=
 =?us-ascii?Q?DSPXN9PUpwhwllig4V3nS5nJn2UZw2LnOmzdfgOMWVrzT58YH4tRhckk9m9U?=
 =?us-ascii?Q?SCCiFdNw9k0buxIJjNgIjyH0GwJtvSPBgF3Dt6PlC5L/0ew6Qlmr+xO9q92T?=
 =?us-ascii?Q?XpSK6bz/319NV8CTEu73pdbXDiIWp98q0h8VaKLh/WuXn9OaZPIaHXy/Rhfc?=
 =?us-ascii?Q?8R2EouxnO+vwA=3D=3D?=
X-Microsoft-Antispam-Message-Info: maM7ZSwIMYDjLBTEBvotd5VceXIaE0Or7bIpMvOdSJ6UP8fO0H6Z8qP9OqMhPaXCIsVZJTYhNiuzBTMoLNQ1nvZB0kW2zeZXPCM8Wmxp54tyUyFw2I9xhkju1SALkUXJM9hDHV3QsL8Y0nh0h6gkdQUWNuYV2mxlHu1hxUAJkaLcu+siERq9uEmyG6BZCoTLtfe18gEk1Oc/5MHSUuov4WjYtPLJkIL1koS3tsVHKyY0EuMwLagZP37jKEtFTCWSwFZQ7bisvHk08oRI8WizcJCNXAft/ku+CKlvgyKoXjkqhLdJsffpKyHrXgfyVMdb
X-Microsoft-Exchange-Diagnostics: 1;BY1PR11MB0311;6:G5baUmRGmCUUetjqnZm0OOM3iuoa34jzUrWLgg8JyKj4QTblJEDTlVp5wdFBXUGayHbUi05qOI3RIri39V472sGxKJuTzJ8Yj1c5gMWLEe2psrA1229btORHCgcrveuGMIYHufOTixSe+Ojkfsy2mNdImmiYbxXviMX4/uqYTCT+yFTiQ2T0HPWjBUoFssEWXa8yTuaC7Tj+sxNn4rV52mG1y8qWLnokcsClPJ8d7WvNlmdxPCSoKbP5fkRKzvRbo4BTjzuS2Y2Sbh/0o/CrTy0ak+z/+QwCL5xTYcC+danWdhas814sqhZ1BB7NfIANKVVbaArG8h91i4sApfsrsB1lVq1JgeB+S5BVrQJvXNjnSTtJCEZ75MeWWaLmZZzyuGp3F0t8qwLbhCYJ9xdhO6n885EsK3a/Q/F4QgfJBOz1Jwr3hLj3XOGNn7TwbX+5gQf/vbh2Dm5LGHiEenyS1w==;5:Nd8RhY9Cn8EkUjVnAdF2P52clrFbEzH08vz8FN5BgA/e7IJNZ3HDYpi7u7Vot0Bz428AZQlmmPXKmOtlGj7TV3R8KljtVM+7SoThPtlEge+3rqZGnG1+VNcax31+i+KKHazqdyTOuNhvBuY1X7dcxX3c58CxxMBux7zTfxYY6IA=;24:l7f5zdOwLtOeW0JQBXnzstMwrk6RcjIi4Ymoko3FCbV3KG7RaKvTMmWCAkFF+xNy40q+C1LLivLjDbYHHXZLdnyOLbTyWz0JKt0EtgCppZc=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BY1PR11MB0311;7:4eZ1XXBgpy1TEbGrvYJcu0YekHhGsLqEDCMZgj7qhRCMwS5tSohM2d4uANkK24STwUljR0aj1nbBqTl7jbvwRttA1WoKsnfmbuH85peR7Nye/+2LX7MFwABCyb6jyMCYOTGdqP5W+wJsxowyHShfx7JfrwSHYU9bNcOkkuMVPkJ99439OSTHojuuttarkRHuHzURAgms1p+FfXV0s9p4uAEEJB1P1nk0f/ZTYlmQe+y+sE3Nlj9M8SHpodgi/nQN
X-OriginatorOrg: fortanix.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2018 18:16:38.6461 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04c0f9cb-bfaf-44b8-9c64-08d5d6d9f753
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: de7becae-4883-43e8-82c7-7dbdbb988ae6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB0311
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms000002030503000706070309
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2018-06-20 09:28, Nathaniel McCallum wrote:
> As I understand it, the current policy models under discussion look lik=
e this:
>=20
> 1. SGX w/o FLC (not being merged) looks like this:
>    Intel CPU =3D> (Intel signed) launch enclave =3D> enclaves

I think you mean:

      Intel CPU =3D> kernel =3D> (Intel signed) launch enclave =3D> encla=
ves

>=20
> 2. SGX w/ FLC, looks like this:
>    Intel CPU =3D> kernel =3D> launch enclave =3D> enclaves
>=20
> 3. Andy is proposing this:
>    Intel CPU =3D> kernel =3D> enclaves
>=20
> This proposal is based on the fact that if the kernel can write to the
> MSRs then a kernel compromise allows an attacker to run their own
> launch enclave and therefore having an independent launch enclave adds
> only complexity but not security.
>=20
> Is it possible to restrict the ability of the kernel to change the
> MSRs? For example, could a UEFI module manage the MSRs? Could the
> launch enclave live entirely within that UEFI module?

On 2017-03-17 09:15, Jethro Beekman wrote:
 > While collecting my thoughts about the issue I read through the
 > documentation again and it seems that it will not be possible for a
 > platform to lock in a non-Intel hash at all. From Section 39.1.4 of th=
e
 > latest Intel SDM:
 >
 >  > IA32_SGXLEPUBKEYHASH defaults to digest of Intel=E2=80=99s launch e=
nclave
 >  > signing key after reset.
 >  >
 >  > IA32_FEATURE_CONTROL bit 17 controls the permissions on the
 >  > IA32_SGXLEPUBKEYHASH MSRs when CPUID.(EAX=3D12H, ECX=3D00H):EAX[0] =
=3D 1.
 >  > If IA32_FEATURE_CONTROL is locked with bit 17 set,
 >  > IA32_SGXLEPUBKEYHASH MSRs are reconfigurable (writeable). If either=

 >  > IA32_FEATURE_CONTROL is not locked or bit 17 is clear, the MSRs are=

 >  > read only.
 >
 > This last bit is also repeated in different words in Table 35-2 and
 > Section 42.2.2. The MSRs are *not writable* before the write-lock bit
 > itself is locked. Meaning the MSRs are either locked with Intel's key
 > hash, or not locked at all.

>=20
> 4. I am suggesting this:
>    Intel CPU =3D> UEFI module =3D> enclaves
>=20
> Under this architecture, the kernel isn't involved in policy at all
> and users get exactly the same freedoms they already have with Secure
> Boot. Further, the launch enclave can be independently updated and
> could be distributed in linux-firmware. The UEFI module can also be
> shared across operating systems. If I want to have my own enclave
> policy, then I can build the UEFI module myself, with my
> modifications, and I can disable Secure Boot. Alternatively,
> distributions that want to set their own policies can build their own
> UEFI module and sign it with their vendor key.

Jethro Beekman | Fortanix


--------------ms000002030503000706070309
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
DQEHATAcBgkqhkiG9w0BCQUxDxcNMTgwNjIwMTgxNjMwWjAvBgkqhkiG9w0BCQQxIgQgdMNK
yo1e6IZtTbBTUywrkGgtuFdmzAqJM4CHEWdldU0wbAYJKoZIhvcNAQkPMV8wXTALBglghkgB
ZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDANBggqhkiG
9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBvgYJKwYBBAGCNxAEMYGwMIGtMIGX
MQswCQYDVQQGEwJHQjEbMBkGA1UECBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdT
YWxmb3JkMRowGAYDVQQKExFDT01PRE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJT
QSBDbGllbnQgQXV0aGVudGljYXRpb24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5
hVzRe0fPqhgwgcAGCyqGSIb3DQEJEAILMYGwoIGtMIGXMQswCQYDVQQGEwJHQjEbMBkGA1UE
CBMSR3JlYXRlciBNYW5jaGVzdGVyMRAwDgYDVQQHEwdTYWxmb3JkMRowGAYDVQQKExFDT01P
RE8gQ0EgTGltaXRlZDE9MDsGA1UEAxM0Q09NT0RPIFJTQSBDbGllbnQgQXV0aGVudGljYXRp
b24gYW5kIFNlY3VyZSBFbWFpbCBDQQIRAPDFZkXqOtF5hVzRe0fPqhgwDQYJKoZIhvcNAQEB
BQAEggEAS/mFVWLqwb8VAFzjfNdYeklLcjKevUEh7BYWalltq2JLdvlzgVf9vfHX6IZWAkNS
MLO+0oTa3e7SvqeapmaonVk1IH5KYG86Rf/jNbLROEz38Yzdv180ugNsvBGYjuqrrdSufzfv
bWcUgP9tvBLgsyjOjWZsGwlNC3oYCVR3yZNx+qXs5mTn96Lyi4HfTk8dvZpwQ7t3tpOxbsZ7
sJPNgtN6ezp6kLK4FMwPN0E7Hu8htLGnF0GiXjh/fK1rzuOas8U5l9pCCX4frL+rN7Tv7xEz
nDe7PgY0PzE/DA31SK7bHJ7FYJCT4PFrCsHqVU2Gytb73G4AHwJX6qeTjEA6UQAAAAAAAA==
--------------ms000002030503000706070309--
