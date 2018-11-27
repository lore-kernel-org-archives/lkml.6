Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6391EC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2090720828
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:33:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kiny+nMq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2090720828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeK0L3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:29:40 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:51250 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbeK0L3k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:29:40 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id wAR0TKa9101241;
        Tue, 27 Nov 2018 00:33:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=L3qtZDcQKEJiij0iw9h/FZGfacmPzn1o6HxucdjXFew=;
 b=kiny+nMqMntic4/ICce1+OVjkt5kpWQK2SxLj2GDjQk/yjBUBS2qwD++BY0JfmUF0b9t
 YLThp2Pyd9eEZre8y9c9Gi/lMamojt3lxxbktnrY5WU6jmvY/cnWCrHthc4LUj/mkpZ/
 0U72ZDEpyaw3xeQctPanHvd/K0Y2ORd9bo5kGWtBtLV1h4Y1sNe6Y2rm2OAoe1NaNayw
 uK/Y0Jg5QQQHvZvUXjUQVkirN7tK99oZfBuFe++EHB5BNGX4C/HOVp0bW/hnprTCCuZu
 p5NVp/fn52Kg2agCMaup5o0YwY4IHaeQTTW+CbY3t1CqSCIFKd85ehU/idc00nvXlMNS 6w== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2nxy9r0yq0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 00:33:35 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id wAR0XYMX010657
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 27 Nov 2018 00:33:34 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wAR0XXep004298;
        Tue, 27 Nov 2018 00:33:34 GMT
Received: from [192.168.0.110] (/73.243.10.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 26 Nov 2018 16:33:33 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: Re: [RFC PATCH 3/3] mm, proc: report PR_SET_THP_DISABLE in proc
From:   William Kucharski <william.kucharski@oracle.com>
In-Reply-To: <20181120103515.25280-4-mhocko@kernel.org>
Date:   Mon, 26 Nov 2018 17:33:32 -0700
Cc:     linux-api@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        Michal Hocko <mhocko@suse.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0ACDD94B-75AD-4DD0-B2E3-32C0EDFBAA5E@oracle.com>
References: <20181120103515.25280-1-mhocko@kernel.org>
 <20181120103515.25280-4-mhocko@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
X-Mailer: Apple Mail (2.3445.102.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9089 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=504
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1811270001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



This determines whether the page can theoretically be THP-mapped , but =
is the intention to also check for proper alignment and/or preexisting =
PAGESIZE page cache mappings for the address range?

I'm having to deal with both these issues in the text page THP prototype =
I've been working on for some time now.

    Thanks,
         William Kucharski=
