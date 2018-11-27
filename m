Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04555C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB7B92133F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e6x7WjVE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB7B92133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbeK1BsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:48:24 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:47276 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeK1BsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:48:24 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAREmd4P009606;
        Tue, 27 Nov 2018 14:50:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=oyccUdWIelEWKpwjvGBKca5PSCy0iL8os39pB4V7K4A=;
 b=e6x7WjVEvtRFfA0tSUmiNT0L5SnP9kIXSZrjt4r4mOIqhw54Wt9ORZbquCAssrYcl3pa
 cfTnNlFIN77rJdZ3RXSe+5CfjgSPrZPWtAwhRXkzCt6JfZjsyBNXwhkEgCMfKaLlR58p
 tyPO7FNhiW8SIjJeaTVfZx44YaaP+hWpJhd60fxCPxCh7tUg+Iz9VJtqqeqf/MRTDsM/
 jH8Dv10fMo+2N5ki1SgTQaz5ZdK/hsbPp1PKf2pqABf0s0HK2ifDNPsRolQsSpOli3ob
 yMWPKXXkfG2HCnDF0K0BIsdVfCVaP66+8Ju/JkKKg6ovXbCY8Erk8nal2k/ltGNJotQC FQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by userp2130.oracle.com with ESMTP id 2nxx2u4e35-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 14:50:10 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAREo9iu027744
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 14:50:10 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAREo9w6000653;
        Tue, 27 Nov 2018 14:50:09 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 27 Nov 2018 06:50:09 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH 3/3] mm, proc: report PR_SET_THP_DISABLE in proc
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181127131707.GW12455@dhcp22.suse.cz>
Date:   Tue, 27 Nov 2018 07:50:08 -0700
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <04647F77-FE93-4A8E-90C1-4245709B88A5@oracle.com>
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-4-mhocko@kernel.org>
 <0ACDD94B-75AD-4DD0-B2E3-32C0EDFBAA5E@oracle.com>
 <20181127131707.GW12455@dhcp22.suse.cz>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=631
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270128
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 27, 2018, at 6:17 AM, Michal Hocko <mhocko@kernel.org> wrote:
> 
> This is only about the process wide flag to disable THP. I do not see
> how this can be alighnement related. I suspect you wanted to ask in the
> smaps patch?

No, answered below.

> 
>> I'm having to deal with both these issues in the text page THP
>> prototype I've been working on for some time now.
> 
> Could you be more specific about the issue and how the alignment comes
> into the game? The only thing I can think of is to not report VMAs
> smaller than the THP as eligible. Is this what you are looking for?

Basically, if the faulting VA is one that cannot be mapped with a THP
due to alignment or size constraints, it may be "eligible" for THP
mapping but ultimately can't be.

I was just double checking that this was meant to be more of a check done
before code elsewhere performs additional checks and does the actual THP
mapping, not an all-encompassing go/no go check for THP mapping.

    Thanks,
         William Kucharski

