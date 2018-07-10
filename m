Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85F4C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:24:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 573022087C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rDSuK7Dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 573022087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933138AbeGJLYT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:24:19 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52206 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751427AbeGJLYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:24:18 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6ABJN4R120643;
        Tue, 10 Jul 2018 11:21:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : in-reply-to :
 references : mime-version : content-type : content-transfer-encoding :
 subject : to : cc : from : message-id; s=corp-2018-07-02;
 bh=fQ6ffRcaXNpbCEL6X/gy6KloxSIWnjg9xCQBU4vq+G8=;
 b=rDSuK7DkS64HYP/IE8gHHqwsx4J/QUuAegMGhH4Tff3qmkrTQNw86w2HirHc9CSIU+63
 4qyFsZhI37szcEQQ5ZKuLyaJ4fwqrZPh+U+eq7+SDXG9EHZKTiO6OVJCX4RtqFa++DI/
 UsL6eJOP/vNL6Eo4iVwJQl1b0xAcD0UQSHM72rp9QR48eJxkRlhpc5yGHuFGluF5AaUt
 Xnsa3lNRhdBbsRTozdIbRo+MpeGjdci8Qm65wu3OCF+KEMoAxPWhEMuDiadibUw7HZAf
 6oafwxzIjNNmnLrJnaVgMwoxQmFO0Sb2VOKYQ72rizoHpF73P/mT8YnzOBRqwGarys/U Ag== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2130.oracle.com with ESMTP id 2k2p761fhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 11:21:49 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6ABLkqK024308
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Jul 2018 11:21:47 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6ABLjs1023470;
        Tue, 10 Jul 2018 11:21:46 GMT
Received: from [192.168.86.24] (/209.6.200.48)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 10 Jul 2018 04:21:45 -0700
Date:   Tue, 10 Jul 2018 07:21:41 -0400
User-Agent: K-9 Mail for Android
In-Reply-To: <20180710104910.3xpiniksptpby4fo@kshutemo-mobl1>
References: <20180626142245.82850-1-kirill.shutemov@linux.intel.com> <20180626142245.82850-14-kirill.shutemov@linux.intel.com> <20180709182055.GI6873@char.US.ORACLE.com> <20180710104910.3xpiniksptpby4fo@kshutemo-mobl1>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCHv4 13/18] x86/mm: Allow to disable MKTME after enumeration
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
CC:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Message-ID: <82032424-C255-44A5-8C62-9AC883AD875C@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8949 signatures=668705
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=650
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807100125
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 10, 2018 6:49:10 AM EDT, "Kirill A=2E Shutemov" <kirill@shutemov=2E=
name> wrote:
>On Mon, Jul 09, 2018 at 02:20:55PM -0400, Konrad Rzeszutek Wilk wrote:
>> On Tue, Jun 26, 2018 at 05:22:40PM +0300, Kirill A=2E Shutemov wrote:
>> > The new helper mktme_disable() allows to disable MKTME even if it's
>> > enumerated successfully=2E MKTME initialization may fail and this
>> > functionality allows system to boot regardless of the failure=2E
>> >=20
>> > MKTME needs per-KeyID direct mapping=2E It requires a lot more
>virtual
>> > address space which may be a problem in 4-level paging mode=2E If the
>> > system has more physical memory than we can handle with MKTME=2E
>>=20
>> =2E=2E then what should happen?
>
>We fail MKTME initialization and boot the system=2E See next sentence=2E

Perhaps you can then remove the "=2E" and join the sentences=20
>
>> > The feature allows to fail MKTME, but boot the system successfully=2E
>> >=20
>> > Signed-off-by: Kirill A=2E Shutemov <kirill=2Eshutemov@linux=2Eintel=
=2Ecom>
>> > ---
>> >  arch/x86/include/asm/mktme=2Eh | 2 ++
>> >  arch/x86/kernel/cpu/intel=2Ec  | 5 +----
>> >  arch/x86/mm/mktme=2Ec          | 9 +++++++++
>> >  3 files changed, 12 insertions(+), 4 deletions(-)
>> >=20
>> > diff --git a/arch/x86/include/asm/mktme=2Eh
>b/arch/x86/include/asm/mktme=2Eh
>> > index 44409b8bbaca=2E=2Eebbee6a0c495 100644
>> > --- a/arch/x86/include/asm/mktme=2Eh
>> > +++ b/arch/x86/include/asm/mktme=2Eh
>> > @@ -6,6 +6,8 @@
>> > =20
>> >  struct vm_area_struct;
>> > =20
>> > +void mktme_disable(void);
>> > +
>> >  #ifdef CONFIG_X86_INTEL_MKTME
>> >  extern phys_addr_t mktme_keyid_mask;
>> >  extern int mktme_nr_keyids;
>> > diff --git a/arch/x86/kernel/cpu/intel=2Ec
>b/arch/x86/kernel/cpu/intel=2Ec
>> > index efc9e9fc47d4=2E=2E75e3b2602b4a 100644
>> > --- a/arch/x86/kernel/cpu/intel=2Ec
>> > +++ b/arch/x86/kernel/cpu/intel=2Ec
>> > @@ -591,10 +591,7 @@ static void detect_tme(struct cpuinfo_x86 *c)
>> >  		 * Maybe needed if there's inconsistent configuation
>> >  		 * between CPUs=2E
>> >  		 */
>> > -		physical_mask =3D (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>> > -		mktme_keyid_mask =3D 0;
>> > -		mktme_keyid_shift =3D 0;
>> > -		mktme_nr_keyids =3D 0;
>> > +		mktme_disable();
>> >  	}
>> >  #endif
>> > =20
>> > diff --git a/arch/x86/mm/mktme=2Ec b/arch/x86/mm/mktme=2Ec
>> > index 1194496633ce=2E=2Ebb6210dbcf0e 100644
>> > --- a/arch/x86/mm/mktme=2Ec
>> > +++ b/arch/x86/mm/mktme=2Ec
>> > @@ -13,6 +13,15 @@ static inline bool mktme_enabled(void)
>> >  	return static_branch_unlikely(&mktme_enabled_key);
>> >  }
>> > =20
>> > +void mktme_disable(void)
>> > +{
>> > +	physical_mask =3D (1ULL << __PHYSICAL_MASK_SHIFT) - 1;
>> > +	mktme_keyid_mask =3D 0;
>> > +	mktme_keyid_shift =3D 0;
>> > +	mktme_nr_keyids =3D 0;
>> > +	static_branch_disable(&mktme_enabled_key);
>> > +}
>> > +
>> >  int page_keyid(const struct page *page)
>> >  {
>> >  	if (!mktme_enabled())
>> > --=20
>> > 2=2E18=2E0
>> >=20
>>=20

