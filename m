Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B7BBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221622173C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 11:35:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ieI+2V8f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbeLXLfq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 06:35:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:49130 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725298AbeLXLfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 06:35:45 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wBOBXl2c001189;
        Mon, 24 Dec 2018 11:35:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=SjgmuKwbiqLkWLZ9/CSf03ose+Q5MfHQJIptqdfeUz0=;
 b=ieI+2V8fVq642DYxxQS8bs/5e1W5gDSTc81TNQr+OctTmOPloIUQO6+v2GaJ7qBHrOmA
 yKEFxk+ztpjjv95veC1+dVsF6x+BezcqG/kDFircu7S81GtugP7Q3YEfRaiY2CRrYnIj
 qwGBuN66qRPoNZd7JG72DtDkXZXvob7tNc22a8waBa+AC6SwrRN91bEEV6QWiTQVKsIy
 tV6L0C7Bc2UUFdydbrlwIh1hydaz+21G8sI2uJY1b1lkaJLc33aVmI4B5JCfa0Zoejt0
 vQ9Zjs9uOqoXDpEfLPRQKUt/OkutsZPN2ETrSJfrm5xZewJhQTl+BEnmnjGKkXQqMElo iQ== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2phasdmqnw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Dec 2018 11:35:32 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wBOBZUwP030778
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 24 Dec 2018 11:35:31 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wBOBZTOT025976;
        Mon, 24 Dec 2018 11:35:29 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 24 Dec 2018 03:35:29 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: Bug with report THP eligibility for each vma
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181224074916.GB9063@dhcp22.suse.cz>
Date:   Mon, 24 Dec 2018 04:35:28 -0700
Cc:     Paul Oppenheimer <bepvte@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Rientjes <rientjes@google.com>, Jan Kara <jack@suse.cz>,
        Mike Rapoport <rppt@linux.ibm.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <78624B4A-EA8B-4D51-B3E6-448132BB839B@oracle.com>
References: <CALouPAi8KEuPw_Ly5W=MkYi8Yw3J6vr8mVezYaxxVyKCxH1x_g@mail.gmail.com>
 <20181224074916.GB9063@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@suse.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9116 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=908
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1812240104
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 24, 2018, at 12:49 AM, Michal Hocko <mhocko@suse.com> wrote:
>=20
> [Cc-ing mailing list and people involved in the original patch]
>=20
> On Fri 21-12-18 13:42:24, Paul Oppenheimer wrote:
>> Hello! I've never reported a kernel bug before, and since its on the
>> "next" tree I was told to email the author of the relevant commit.
>> Please redirect me to the correct place if I've made a mistake.
>>=20
>> When opening firefox or chrome, and using it for a good 7 seconds, it
>> hangs in "uninterruptible sleep" and I recieve a "BUG" in dmesg. This
>> doesn't occur when reverting this commit:
>> =
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit=
/?id=3D48cf516f8c.
>> Ive attached the output of decode_stacktrace.sh and the relevant =
dmesg
>> log to this email.
>>=20
>> Thanks
>=20
>> BUG: unable to handle kernel NULL pointer dereference at =
00000000000000e8
>=20
> Thanks for the bug report! This is offset 232 and that matches
> file->f_mapping as per pahole
> pahole -C file ./vmlinux | grep f_mapping
>        struct address_space *     f_mapping;            /*   232     8 =
*/
>=20
> I thought that each file really has to have a mapping. But the =
following
> should heal the issue and add an extra care.
>=20
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index f64733c23067..fc9d70a9fbd1 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -66,6 +66,8 @@ bool transparent_hugepage_enabled(struct =
vm_area_struct *vma)
> {
> 	if (vma_is_anonymous(vma))
> 		return __transparent_hugepage_enabled(vma);
> +	if (!vma->vm_file || !vma->vm_file->f_mapping)
> +		return false;
> 	if (shmem_mapping(vma->vm_file->f_mapping) && =
shmem_huge_enabled(vma))
> 		return __transparent_hugepage_enabled(vma);

=46rom what I see in code in mm/mmap.c, it seems if vma->vm_file is =
non-zero
vma->vm_file->f_mapping may be assumed to be non-NULL; see =
unlink_file_vma()
and __vma_link_file() for two examples, which both use the construct:

	file =3D vma->vm_file;
	if (file) {
		struct address_space *mapping =3D file->f_mapping;

		[ ... ]

		[ code that dereferences "mapping" without further =
checks ]
	}

I see nothing wrong with your second check but a few extra instructions
performed, but depending upon how often transparent_hugepage_enabled() =
is called
there may be at least theoretical performance concerns.

William Kucharski
william.kucharski@oracle.com

