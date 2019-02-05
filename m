Return-Path: <SRS0=cBqk=QM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6078BC282CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:53:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3B72077B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Feb 2019 21:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="N59FiNSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728188AbfBEVxy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Feb 2019 16:53:54 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:4254 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbfBEVxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Feb 2019 16:53:53 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c5a05d00000>; Tue, 05 Feb 2019 13:53:20 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 05 Feb 2019 13:53:51 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 05 Feb 2019 13:53:51 -0800
Received: from [10.110.48.28] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 5 Feb
 2019 21:53:51 +0000
Subject: Re: [PATCH 6/6] mm/gup: Documentation/vm/get_user_pages.rst,
 MAINTAINERS
To:     Mike Rapoport <rppt@linux.ibm.com>, <john.hubbard@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>, <linux-mm@kvack.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Benvenuti <benve@cisco.com>,
        Christoph Hellwig <hch@infradead.org>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Doug Ledford <dledford@redhat.com>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Tom Talpey <tom@talpey.com>,
        LKML <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>
References: <20190204052135.25784-1-jhubbard@nvidia.com>
 <20190204052135.25784-7-jhubbard@nvidia.com>
 <20190205164029.GA12942@rapoport-lnx>
From:   John Hubbard <jhubbard@nvidia.com>
X-Nvconfidentiality: public
Message-ID: <8655ea8a-4c43-c824-942b-bff06cf69a04@nvidia.com>
Date:   Tue, 5 Feb 2019 13:53:50 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190205164029.GA12942@rapoport-lnx>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL104.nvidia.com (172.18.146.11) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1549403600; bh=Gc/ra3KjxqohEuxyjSuu/9457Ston9pava1kQCW1bEI=;
        h=X-PGP-Universal:Subject:To:CC:References:From:X-Nvconfidentiality:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=N59FiNSusZgwWITszf58QJ5LATZGCLJ6mTy//vUGv9M0jLI0GYTt1KRQSJwz1plM6
         VO3nP8n8vlMcYsEzeBcmkjYkXQl/1uvd+1JxYa8z1HKL06OwZ7F1HaJsPplJUVKlxH
         fTFTItczRTD6PC3G2lNCD48OYMUs/O9fFk6HWF3Fc22lL07gVqnGjEkWeKpQiP/L13
         vMhvReGxYxga2uyS4xs7qat5EKlBXoC9S+VF2+c3CigjzeZxEzy4lepbuHSrTq85sq
         rOU535vEGOEB9qNUSQtojaxs+tQvG5niBOGoFgWmIaR0KdYalindJiojIKi1Ni4Qya
         Nb6STwlNA/beQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/5/19 8:40 AM, Mike Rapoport wrote:
> Hi John,
>=20
> On Sun, Feb 03, 2019 at 09:21:35PM -0800, john.hubbard@gmail.com wrote:
>> From: John Hubbard <jhubbard@nvidia.com>
>>
>> 1. Added Documentation/vm/get_user_pages.rst
>>
>> 2. Added a GET_USER_PAGES entry in MAINTAINERS
>>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Jan Kara <jack@suse.cz>
>> Signed-off-by: J=C3=A9r=C3=B4me Glisse <jglisse@redhat.com>
>> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
>> ---
>>  Documentation/vm/get_user_pages.rst | 197 ++++++++++++++++++++++++++++
>>  Documentation/vm/index.rst          |   1 +
>>  MAINTAINERS                         |  10 ++
>>  3 files changed, 208 insertions(+)
>>  create mode 100644 Documentation/vm/get_user_pages.rst
>>
>> diff --git a/Documentation/vm/get_user_pages.rst b/Documentation/vm/get_=
user_pages.rst
>> new file mode 100644
>> index 000000000000..8598f20afb09
>> --- /dev/null
>> +++ b/Documentation/vm/get_user_pages.rst
>=20
> It's great to see docs coming alone with the patches! :)
>=20
> Yet, I'm a bit confused. The documentation here mostly describes the
> existing problems that this patchset aims to solve, but the text here doe=
s
> not describe the proposed solution.
>=20

Yes, that's true. I'll take another pass at it with that in mind.

thanks,
--=20
John Hubbard
NVIDIA
