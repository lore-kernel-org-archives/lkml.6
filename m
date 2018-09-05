Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4BDC43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B2AF20659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 06:15:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2AF20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727366AbeIEKoP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 06:44:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:39183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeIEKoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 06:44:15 -0400
Received: from [172.20.10.8] ([117.136.79.147]) by mail.gmx.com (mrgmx003
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0MY86C-1gS76X21lQ-00UuMK; Wed, 05
 Sep 2018 08:13:54 +0200
Subject: Re: [Jfs-discussion] [PATCH v2 4/5] jfs: cache NULL when both
 default_acl and acl are NULL
To:     Dave Kleikamp <dave.kleikamp@oracle.com>, jack@suse.com,
        tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        yuchao0@huawei.com, shaggy@kernel.org, hubcap@omnibond.com,
        martin@omnibond.com
Cc:     jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        devel@lists.orangefs.org
References: <20180831143352.22970-1-cgxu519@gmx.com>
 <20180831143352.22970-4-cgxu519@gmx.com>
 <0e37733e-9acd-cf82-62f7-420f0fa864eb@oracle.com>
From:   cgxu519 <cgxu519@gmx.com>
Message-ID: <c231d198-7a4e-63a0-0a7d-9211ab0abfe9@gmx.com>
Date:   Wed, 5 Sep 2018 14:13:47 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <0e37733e-9acd-cf82-62f7-420f0fa864eb@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Provags-ID: V03:K1:CKkOdU/kXl6Dlyt8tOOKEzmcIy1XHYN5v6ZrVElc533kjQH9BUJ
 Wz6xClp3xpbkmJwG/YPB7w6pLK1KLMADMGcfhbd7Ch8iMBMvL+7fm2Dj5QplIXOt28962Xd
 9IDgEAflBkNB2Ufzd3in9eTc9lWWVAu9DgatgMp9t4Ly3Ynmk0FGue4+5w5GX8FMGR2qhJV
 KNUA9VntVpmVr+aYpZobg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:eEZibdoP5Wg=:aBtZFF2wZlvq+zPZoaJLeF
 qVNZrmxznGQB/DY7euSxRXr5FR4PZFw5SwRpOoy9RJirMyRCn9VbSKhMrNEqegyKSgoY+V1TH
 nsjuN5zyrf7a4JqX3i23bxo71PewtOt0g9ZLvlAqr4FWNEkyR038KnZ0LJruCw33a3aaR1EL8
 njj+ePnhjgPxbngQ2/xcqQiux1DF1OgtxhmX2PMiNPVn8YKnC32BWzqT8y8PBRrElf4QyMqII
 UnihJy2Rv9dzwIWjL6g0poiM//enzC6IIv2Xg9+W7wY5K9IajlxHbs9dPAi0x8QewL1jYUp7U
 fRB054HvI1YgJQM1qdXc3iXBZGSEd00F7O3EVctydBeqgJoC3l6XpxlHkzwalGUMr8e9BC36c
 YSpnJn0pRm2U2tdXvb/LnuZEMEfO7ii5HCQ9x7qOOZlr7EarLKXwZQLNX/Bg7zPQzndt3Too3
 3TmTZR4mlDqHehDjHBFl5CyJCDALF4MZzdf7r38r45PshmCwI2pXkWcJEIyrUj+Z/yyJyhL4l
 SPx6a9qWhAjf7BL9ItUG3Yq0/iaZaBoz33mroSBak92tKEztMr5+c1ghsb6Cxz89agTdQAGS1
 mIcn3keZeTmfbg2jvhlIcTf9OHpU8k5PJ90pwTpuTVFyM5kz7/pBgKHAZJG0+aMr7YhlTsRVj
 Ki7OYN+r6aZMU/DXeRrIXnR318yLFvOMAhhVjKau1P3q7DBer8Zq1JIyjzHYbWYWj8G9vJRKp
 ycyfDPagTSpOL4kMIhDNKmYmT8DDeFUC1SBXBgYwOUr1RSHUKDjGO71KoR7w893RqKrkuY7nI
 4tyCy0F
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/04/2018 04:34 AM, Dave Kleikamp wrote:
> Are you pushing these as a series, or would you like this patch pushed
> through the jfs tree?
I'd hope maintainers pick individual patch to their tree.

Thanks,
Chengguang

>
> On 8/31/18 9:33 AM, Chengguang Xu wrote:
>> default_acl and acl of newly created inode will be initiated
>> as ACL_NOT_CACHED in vfs function inode_init_always() and later
>> will be updated by calling xxx_init_acl() in specific filesystems.
>> Howerver, when default_acl and acl are NULL then they keep the value
>> of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
>> in this case.
>>
>> Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
> Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
>
