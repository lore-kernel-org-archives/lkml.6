Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86001C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:09:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50C842133D
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 14:09:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ISP5GzIe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfAWOJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 09:09:13 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41032 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbfAWOJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 09:09:13 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id x0NE47x8058012;
        Wed, 23 Jan 2019 14:09:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=peplbcwNLEjH1seyKCwTcZ1jabGL2+yJOu6oMEUGY68=;
 b=ISP5GzIeiV8cTYi3Bw3fdMI9vf8boJ4xe5jPSa8SSWvjX3Q2jfF81HHGleR7vaa+s79F
 BI9D2JRCUNM6Z0wDjisfC0+ew1QjyggXMMFKWx2JDFqiK6TEEP58WvO4v63y/UPzDj+F
 U0y9IlYro9btg6WbLGqQhHYs2PtTGeX7XBZTBzWbmklla0cLIm3qGndbP1RPV7e/NQr3
 A4MG7vTO8BpaO9UkV5QfxNZqhh+maCngVc6T+srWxEzFlvGO77BRuHN/Xf8K/KFRSGi5
 t+8pl8hEabSKhWh4HkBnsOxQ5MN+sQalaAxSMQHSuuP9aJrdHEZ+VS1/xAMXghOtW8k8 7Q== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2120.oracle.com with ESMTP id 2q3vhrsw8g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:09:06 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x0NE94eU031802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Jan 2019 14:09:05 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x0NE94N1006064;
        Wed, 23 Jan 2019 14:09:04 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 23 Jan 2019 06:09:03 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [PATCH 1/2] mm/mmap.c: Remove redundant variable 'addr' in
 arch_get_unmapped_area_topdown()
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <affba895224614ac3f2cbafa9d4fa7be3361de9d.1547966629.git.nullptr.cpp@gmail.com>
Date:   Wed, 23 Jan 2019 07:09:02 -0700
Cc:     Andrew Morton <akpm@linux-foundation.org>, will.deacon@arm.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <919A3677-F069-4944-9590-588D366578A1@oracle.com>
References: <cover.1547966629.git.nullptr.cpp@gmail.com>
 <affba895224614ac3f2cbafa9d4fa7be3361de9d.1547966629.git.nullptr.cpp@gmail.com>
To:     Yang Fan <nullptr.cpp@gmail.com>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9144 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=946
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1901230106
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 20, 2019, at 1:13 AM, Yang Fan <nullptr.cpp@gmail.com> wrote:
> 
> The variable 'addr' is redundant in arch_get_unmapped_area_topdown(), 
> just use parameter 'addr0' directly. Then remove the const qualifier 
> of the parameter, and change its name to 'addr'.
> 
> Signed-off-by: Yang Fan <nullptr.cpp@gmail.com>

These seem similar enough I question whether they really need to be two
distinct patches, given both involve removing const keywords from the same
routine, and the shift to using the passed addr directly rather than
declaring and assigning addr from addr0 is a direct consequence of
removing the const.

I could be wrong though and easily persuaded otherwise.

