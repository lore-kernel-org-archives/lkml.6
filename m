Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Hni+CzyFG1s/RgAAmS7hNA
	; Sat, 09 Jun 2018 07:43:56 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 129ED607E7; Sat,  9 Jun 2018 07:43:56 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=CAVIUMNETWORKS.onmicrosoft.com header.i=@CAVIUMNETWORKS.onmicrosoft.com header.b="NVxynNlH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,MAILING_LIST_MULTI,T_DKIMWL_WL_MED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6E1BA601D3;
	Sat,  9 Jun 2018 07:43:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E1BA601D3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=caviumnetworks.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753243AbeFIHnw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sat, 9 Jun 2018 03:43:52 -0400
Received: from mail-eopbgr710050.outbound.protection.outlook.com ([40.107.71.50]:16530
        "EHLO NAM05-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751581AbeFIHnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jun 2018 03:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=CAVIUMNETWORKS.onmicrosoft.com; s=selector1-cavium-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mkmvr1be+xR18zTMudkBWmMlZ/MY094v4+yTwAWlB/Q=;
 b=NVxynNlHeMIvKlZ7ixLVKguXRxY/sSQlVmjAbBOSRfeZt1zx16gxAqeGmP5xS7bDYNjhFFmwSxQ3TYu4gjSx+Ceydrrq7sdmRpaG2+ZRZ+oGxx1TApT4eRXteY1wRFvFPlhz6KkAuCj6sYuVA3aKfKkKG+717++cxKhFKTKT5TE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Yuri.Norov@cavium.com;
Received: from localhost (188.169.253.180) by
 BYAPR07MB4375.namprd07.prod.outlook.com (2603:10b6:a02:c0::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.841.17; Sat, 9 Jun 2018 07:43:43 +0000
Date: Sat, 9 Jun 2018 10:43:28 +0300
From: Yury Norov <ynorov@caviumnetworks.com>
To: Palmer Dabbelt <palmer@sifive.com>
Cc: catalin.marinas@arm.com, Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, szabolcs.nagy@arm.com,
        heiko.carstens@de.ibm.com, philipp.tomsich@theobroma-systems.com,
        joseph@codesourcery.com, sellcey@caviumnetworks.com,
        Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, agraf@suse.de,
        bamv2005@gmail.com, geert@linux-m68k.org, Dave.Martin@arm.com,
        kilobyte@angband.pl, manuel.montezelo@gmail.com,
        james.hogan@imgtec.com, cmetcalf@mellanox.com, pinskia@gmail.com,
        linyongting@huawei.com, klimov.linux@gmail.com, broonie@kernel.org,
        maxim.kuvyrkov@linaro.org, fweimer@redhat.com,
        Nathan_Lynch@mentor.com, james.morse@arm.com,
        ramana.gcc@googlemail.com, schwidefsky@de.ibm.com,
        davem@davemloft.net, christoph.muellner@theobroma-systems.com
Subject: Re: [PATCH 04/24] 32-bit userspace ABI: introduce ARCH_32BIT_OFF_T
 config option
Message-ID: <20180609074327.GA32578@yury-thinkpad>
References: <20180608173207.nwoi25jee52gpdwy@armageddon.cambridge.arm.com>
 <mhng-e1922456-a05b-46f9-8644-d45ad70a55e5@palmer-si-x1c4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mhng-e1922456-a05b-46f9-8644-d45ad70a55e5@palmer-si-x1c4>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [188.169.253.180]
X-ClientProxiedBy: VI1PR08CA0116.eurprd08.prod.outlook.com
 (2603:10a6:800:d4::18) To BYAPR07MB4375.namprd07.prod.outlook.com
 (2603:10b6:a02:c0::18)
X-MS-PublicTrafficType: Email
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:BYAPR07MB4375;
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;3:HrRuigoAiT5Z6DKBKiZO3ROSypR39EGdrt7uvwg5FPWwXpR4SgsQTKQgue/g7eVVzQxj50P1MZwJsXQjyDQ6u7gJbv5WSzod4GmvOLHRdZERHG1zEhjUaEC9K6i+nG1OoTakbK9L40X/iL6cywPEyZluaDRYBL8cf/vR1oInf5QhAGf8WQaDuc64PO5G+siKn9x9nz1V1zJa39ysy8Um3Lp24neqAW8bVvYNFC3u+dkYIgcQG2Hh8yeZwslk8HT+;25:N8SnKspDL1l2hiijaxVyRjRdw4V30yMbXKuvghEFrIqLOoYKLNLz4SUM/ocUcV764cCrDkUsQ21PhBgFeHtRbrGTPqdxgV85bCvsFRHVAz4MN5u5ovjq6zPr8l4QeMa05LXD0Eu09aZQ3j3XhMegVRYsKYQzfGGrtGel1pLeiUBfNeKdDNQEmRJYwKOTet/hs31ShY4A8uzLA2e1jWYcGUtfSoc9V5qrvfCy93uK/T1bPKolcNwnM8lFiYZLCvqLL+0m83d2e0UjuPnCkvryq3CZTOARbP5W7/cTe43PaOi8Jan8DF9BEwPoyZYA0DHW/k9GQrDu0mSEqCkbdPYXkw==;31:5WmE8dwwehz+K9v6S0BAg01qO/6LQBpE44WcAEJODfXoPai9/ynfFZ34GsF8QDvp3BLlqh8qukqgEN9mQdBZjFI2/OAFJTNU50cH6+eAnO4pTylPigNIJhu7VSBGGM9d7W7jJo38xb8fcZtZg+Ig3ggQ2Tho7HyiNW/DolRZZV0D8XBCIWbVp+BDRSQMwko/f5u8onF/ldpJhljQFbOH08EDvBTzRLpxxK0nL4p3b/M=
X-MS-TrafficTypeDiagnostic: BYAPR07MB4375:
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;20:nCJwPawgejTDjOYMgQMtYX9apaWSxhldyxVbxxa5fVSuVltRYMVvoQlDMJofycG5Sny0JuebdRYpks2kA5yKm3McAru1MyfD4kE+B4ch7qcT3roUksQn+ym8lr+UVtBE8z37t3ekC2WCe0SIO1ZQdEBXEmH+WADk8knGLSh/oSYxvtu+jVniCrl0qsNwMylSg1pssrRQuhROFKNm2S19R3blmYCgWAvRh+7MLCBZWTRyKdXOIzQ6Yzu5UDhofMyNpxLOAWvovt7uAwwhRGTEj838PCAWgHjYR9Q8m13/eOIVR3WUTPyvkl/wmwa4qMp974oOziZpwHr00uM8ZCAvpW2SKjSH9Hh1suWlHkgpXQm212U+rR3prCj3HZjcxbJBsMn5eUlOuDnOGv98FESEjeSR3cRyHoK8RQo4DgK7owgJFVeUO34ARpBAwLM2UwSabQfUwq2KCITQG4BofPp1acR90VMsabRP5X3UA9l/ClZhvgerlwLjWBB0avNZuuv0qn7fZPMnBRNlDk6wBcZ8r2ZTyJ1dj1e3SUgPUgcBjh679xtRPRAPUAyM0bUpz57f6nF0u6SjTTjpWwgiUy6hNBOW57oP2MDnrMGZq/vnVz4=;4:I2odOFTNYXFSGmpbKZyyJPAd9HZZywm7o9IeBqXOxOKuYpKOly6Ka1I7EfR9ZVWm5oFp+1dMyILUQzoNfwFrbA8OK1JREqrczu81VqUkRuQvRS4apPzK5v4LtPZiQdhqPSri8vdUa4w0pCsifYaOdGdGUbWhvRT76OXj+ydF1gbInUBxsMScKM8axYH2laghN6Cv8DIMSbJWTjpBXgykMpIIuE1FS4G7mkAkbO6ooTEJbvcc6DO+QHZnxBllzi+1eJJlEyosNYcUTWVED0oLAd7KS0gwlIsVjalWZH6XccT6RxxUdaEDMEGNsx5SnSjj
X-Microsoft-Antispam-PRVS: <BYAPR07MB4375478FCE5E2C29973767B7E37A0@BYAPR07MB4375.namprd07.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:(180628864354917);
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(10201501046)(93006095)(3002001)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:BYAPR07MB4375;BCL:0;PCL:0;RULEID:;SRVR:BYAPR07MB4375;
X-Forefront-PRVS: 06989017E3
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(6069001)(7916004)(39850400004)(366004)(396003)(376002)(346002)(39380400002)(189003)(199004)(7736002)(105586002)(486006)(6246003)(53936002)(26005)(6916009)(66066001)(305945005)(6666003)(6486002)(106356001)(186003)(16526019)(1076002)(446003)(23726003)(76506005)(8676002)(97736004)(42882007)(229853002)(476003)(81166006)(81156014)(575784001)(956004)(8936002)(15760500003)(6116002)(386003)(4326008)(68736007)(50466002)(25786009)(72206003)(58126008)(7406005)(7416002)(5660300001)(16586007)(3846002)(39060400002)(11346002)(33716001)(316002)(33896004)(47776003)(33656002)(76176011)(6496006)(2906002)(52116002)(478600001)(9686003)(18370500001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR07MB4375;H:localhost;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: cavium.com does not designate
 permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1;BYAPR07MB4375;23:XXYNjfOQMuGIOOoJXZbMCg6OTgZ21KCzPZ9ysi68/?=
 =?us-ascii?Q?Drx9bAvWJ7QumEM1QNjq8umd5O/b3uE/vkSl5vkZq5ZkCoqubyNifAxZOQep?=
 =?us-ascii?Q?7PxnFbkMD6IU1Mxk7C+TKrMHPFok9XJWi7jF2w4aRI9j6ScH6n8gQ1ovWGEf?=
 =?us-ascii?Q?JOGnCsYsuKlpxOovmE3RniLsE5j8tD8C5hMXvLqs7Tc2PNqLI3M7Cd1N1m0r?=
 =?us-ascii?Q?eBzqA8IYTjUPhedQu1FOSOk1Jyu6I759rhcZvA9nZQWvyMf8+BJJ8YWHw7HW?=
 =?us-ascii?Q?HnQ/e9lTynr6b8SLS8HhIfqX0eby80n1oYhBnkro1UKyvLq3se+oQm1qaGqC?=
 =?us-ascii?Q?GkkMkIGnuufI4jNvwce+bKA4AWdQrn9nlaCuh8t1OlPL6VXiVJTzKG+lrf4f?=
 =?us-ascii?Q?JHN9UxqStzGp+1mKAkAkQgrAiXXQxKHTGwcSGnRnEEd0cpLdYBgZpiXkO/PM?=
 =?us-ascii?Q?QHMv2M9i5ZS2ip4Je4berfyviCEWsmcvRifD96pvc1rd/1BgUVTE91zLJdB5?=
 =?us-ascii?Q?mKbWN263Gt3jzdBGYo1V+0gbO2AU3e9NtUbtZ2n49M2dkjt2FkAcFonu5eZr?=
 =?us-ascii?Q?wGg6nthbd2ppWFGliZCrZiC39JCwkT1DWTGoDHQtPWwi2/ZT7aH9dZzi3rTz?=
 =?us-ascii?Q?Ab4EsQ7bUXq8iaiapDCFkQLD7FFBAWKup1zfyiQPb5JxvKNP/nGN30zz8S4p?=
 =?us-ascii?Q?NIOcnAwUOww8mm+BsuckJSSSBZ/f61/qmv/R1mXO2QKtbBHnV+Xnwe8Y3ZBf?=
 =?us-ascii?Q?sUTv61Vr83+d07+Pk+84/r9f8CYUE4YhQIsAqcCQmCG9kuWZ9ZJ7nIdmMvaW?=
 =?us-ascii?Q?TAdw6OvpHIl+qGF7b6SzNaOKUIOVkkbr9S0PgY2reqnq537dUgujG0fdcY0o?=
 =?us-ascii?Q?tPgVJE1QitTyqeL4y2eq4fmBE/BWfSfAj2Zrf9JbuU3h64TSr83m1obd/9EJ?=
 =?us-ascii?Q?+YRhlAY0w7qSKZ4GoBTxDTUDE2ha55kYONs83GKoJjj55xjA/zyUUDhezim5?=
 =?us-ascii?Q?uJDir05OFePr3HTmn0uylNeYrYVyHI1tkNCrXnfmw84LvnlM7c2G6ImxJdp0?=
 =?us-ascii?Q?5mOYaPkl5v5grgRwTxaChF5z1VAFlI7CnnbvKCmRZptRzDnyHbiU+ruAS0wO?=
 =?us-ascii?Q?nKacxJW4f92dhOD0w+Tkt2B84otROScm5Yge5RYWuTIlUVfzdQwresuPFX2X?=
 =?us-ascii?Q?JtjAieUCbQO2PJ4rzkljNSXbAxRYUOu4Yw5wgoANtfkuwbDKDtoRgUOCRqLM?=
 =?us-ascii?Q?5xOkD+ON3Q1Da0r7jA8OVm4ZpdwYhr4Z5u8ECKq5aiaWbGJjlg4EWtwiuIYh?=
 =?us-ascii?Q?GvBfPDI4vnHBFBnaByLl5Y6B6dHWls4eGcTFiWW2S6BdN0sQBfhTgl+9r0a3?=
 =?us-ascii?Q?6GS2JBRZpDN1h8bhyqbjyvb7u7RE3bp71C+3vrSJS9x+MHVRletSxxUvqYBp?=
 =?us-ascii?Q?xULmO6qJAAVOl0pndCxzTMmdqxjfSbSYYIsCJxVEnCaDanl14qZ?=
X-Microsoft-Antispam-Message-Info: r5u1/RjbSaYhq0aj4mw2PYr49KAEMakGfvGuDYcBMy0a+Cdm2UweAXBBJb50eurD/tlZT+gtjLKtJeZHqTgoLGfypvwpser9EDRsJOMU8SX80OIvCt8qjo0W7mhLz0XOs8EMdX51US53t1uvP5zozZtgAHz1rrXqZm9gcSH46vnK/fTKUDcIejFwUmRRaWs5
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;6:3RdALRBg6t8kUBEZvPMWj/u2YsU1Z1ju1sF4JO/11hhdZC22TK4ETfeVi8iRB1q+Dt8qRJFGeTpOUzg+WGbzPAscMfWL+meKf4F3D4NX8UAeC2RC5Mpv7CSEtDKOwmLUVsO4bhnY/IKcuOTxi1Qf1Xd6iuugdSNVUtbvyN3ZjSp7aeJ6Fr+WOE0nECS/XZ8RKz7d7YSISy+Odrl8Y+NgR8MZJFqPb7qSJNEMLe5r3Cn3IW8cAjhwbCNZszHE1iagbj9s/EgJtcAdfup9euL3f6K8KF6rTPw+AZk+ghXbrsIFZdUdTCeN+In4LODjGTDVoGCm6bVdIcuQlRqrZqjGljtxUxmBHp4DTqcnLnpMhsplZL3iqgSa8ae7Rfz4F9zM9mBk7bXQyS1wE3w9cWhAiexQ8uoT0M2Dis4TZ4Frk4KgkdYhThX6w0KXFystilOBQ5xtDMbyS1z8KU88jjnXnw==;5:vq3JdBUcD4SjnBK8Y1i1UxY1MIxxdJKAg4O5GD6/1eSABnkmqzLgOv1NSkzLeNZdTgNsjvmLTnvpnYovsMXgylVQAt+K9gM2HCrnLv5V6X4zr/LiPdaN3Q3zkRDMpmccnOz4rgxPQvZwJ7DpGbqA68VEB/nULlRzqgvPk40jePM=;24:ApNRs/apjkpeaxlp6Qy8p1jVyl7uq+QI3H8hGBmTi66BonLZWRSknZ2yU5og965e0hpFXNTJWvaDZvQ3l8/fL1hZWlNwFwnKcgpe/ITzqms=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;BYAPR07MB4375;7:oGD4s9NTlM5XsPG76Oby+ptSxsCx5ojVbgZEGDn+IbWV243mwp14Al7hISZy4UcAj0A4YhDfUtmCKzBL2Zlld7nDRXtup6O3DikBYPiSbNgSlabzwI5eh5COLid17fAX1E4ypNAjKpfS2ysYT8CbPzw7/lBgbE4k16ZT8ZHjfinx20NY5Iv+r7+ubLV5wXj3zbz76vTv6f8dY1yTWewuvg8+MrqigI6HXiQ9foTiHbpob0ALYpU9UakJrsHfgrqR
X-MS-Office365-Filtering-Correlation-Id: 06f91172-9d17-40ce-1245-08d5cddcba21
X-OriginatorOrg: caviumnetworks.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2018 07:43:43.1614 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f91172-9d17-40ce-1245-08d5cddcba21
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 711e4ccf-2e9b-4bcf-a551-4094005b6194
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB4375
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 08, 2018 at 03:33:51PM -0700, Palmer Dabbelt wrote:
> On Fri, 08 Jun 2018 10:32:07 PDT (-0700), catalin.marinas@arm.com wrote:
> > On Wed, May 16, 2018 at 11:18:49AM +0300, Yury Norov wrote:
> > > diff --git a/arch/Kconfig b/arch/Kconfig
> > > index 76c0b54443b1..ee079244dc3c 100644
> > > --- a/arch/Kconfig
> > > +++ b/arch/Kconfig
> > > @@ -264,6 +264,21 @@ config ARCH_THREAD_STACK_ALLOCATOR
> > >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> > >  	bool
> > > 
> > > +config ARCH_32BIT_OFF_T
> > > +	bool
> > > +	depends on !64BIT
> > > +	help
> > > +	  All new 32-bit architectures should have 64-bit off_t type on
> > > +	  userspace side which corresponds to the loff_t kernel type. This
> > > +	  is the requirement for modern ABIs. Some existing architectures
> > > +	  already have 32-bit off_t. This option is enabled for all such
> > > +	  architectures explicitly. Namely: arc, arm, blackfin, cris, frv,
> > > +	  h8300, hexagon, m32r, m68k, metag, microblaze, mips32, mn10300,
> > > +	  nios2, openrisc, parisc32, powerpc32, score, sh, sparc, tile32,
> > > +	  unicore32, x86_32 and xtensa. This is the complete list. Any
> > > +	  new 32-bit architecture should declare 64-bit off_t type on user
> > > +	  side and so should not enable this option.
> > 
> > Do you know if this is the case for riscv and nds32, merged in the
> > meantime? If not, I suggest you drop this patch altogether and just
> > define force_o_largefile() for arm64/ilp32 as we don't seem to stick to
> > "all new 32-bit architectures should have 64-bit off_t".
> 
> We (RISC-V) don't have support for rv32i in glibc yet, so there really isn't
> a fixed ABI there yet.  From my understanding the rv32i port as it currently
> stands has a 32-bit off_t (via __kernel_off_t being defined as long), so
> this change would technically be a kernel ABI break.
> 
> Since we don't have rv32i glibc yet I'm not fundamentally opposed to an ABI
> break.  Is there a concrete advantage to this?

One obvious advantage is manipulating large files - if file is greater than
2G, you cannot easily mmap(), lseek() etc with 32-bit offset.

Another point is unification of layuots for structures like struct
stat between 32- and 64-bit worlds.

On glibc side it helps to unify 32-bit and 64-bit versions of syscalls.
Refer, for example this commit:
3c7f1f59cd161 (Consolidate lseek/lseek64/llseek implementations).

Yury
