Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A88C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:07:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E72320817
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TdWAGPY7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E72320817
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbeK1EFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:05:34 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:53236 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726338AbeK1EFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:05:34 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wARGxNa4100612;
        Tue, 27 Nov 2018 17:06:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=mlkkGRoytDJ6YxBGRBOcQebLVqTm3iDI+Rn0tva/uA4=;
 b=TdWAGPY75tcg+PBApJhssfIC53BTA1m9hHWveqX73fDoO8Stp8sN3nZLb+yKVrl4EQ4Y
 6fxnc0jrX9AuUr4lc0NU2d8qetJmUsqZuer2sIL8Lns3Cj+slE2bKpo5+XACpmuAgDL/
 sjWGY50o3yC2Z7OQ8udDpW/YXJS02JQGUKsSvY6qRKzPTBITU7Ilr/O3j9PGh2Rev928
 pam8DYdnJXIUn4MZ5wDru4JiUfsV/SlsOc4mqYvlZfo9GvHeutWqG/Fd6Ip8Xfzzc6FJ
 DMwbcszhGplkhOnVz/f3RiXSImdp6eSyRzvG3v3O6jR7GF+KdruVoDYfuBfrJyZrZ0Xo Qg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2120.oracle.com with ESMTP id 2nxxkqdb1w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 17:06:53 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wARH6q0Z018028
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 17:06:52 GMT
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id wARH6qI8009065;
        Tue, 27 Nov 2018 17:06:52 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 09:06:52 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH 3/3] mm, proc: report PR_SET_THP_DISABLE in proc
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <283f38d9-1142-60b6-0b84-7129b7f9781e@suse.cz>
Date:   Tue, 27 Nov 2018 10:06:50 -0700
Cc:     Michal Hocko <mhocko@kernel.org>, linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5CB5F808-ECA8-4A4E-B942-7D69522E3FA4@oracle.com>
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-4-mhocko@kernel.org>
 <0ACDD94B-75AD-4DD0-B2E3-32C0EDFBAA5E@oracle.com>
 <20181127131707.GW12455@dhcp22.suse.cz>
 <04647F77-FE93-4A8E-90C1-4245709B88A5@oracle.com>
 <283f38d9-1142-60b6-0b84-7129b7f9781e@suse.cz>
To:     Vlastimil Babka <vbabka@suse.cz>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9090 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=824
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270145
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2018, at 9:50 AM, Vlastimil Babka <vbabka@suse.cz> wrote:
>=20
> On 11/27/18 3:50 PM, William Kucharski wrote:
>>=20
>> I was just double checking that this was meant to be more of a check =
done
>> before code elsewhere performs additional checks and does the actual =
THP
>> mapping, not an all-encompassing go/no go check for THP mapping.
>=20
> Yes, the code doing the actual mapping is still checking also =
alignment etc.

Thanks, yes, that is what I was getting at.


