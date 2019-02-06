Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81493C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:17:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50E7F218B0
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 23:17:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FVCVVDcM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726610AbfBFXRM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 18:17:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51070 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbfBFXRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 18:17:12 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x16N8te3076565;
        Wed, 6 Feb 2019 23:17:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=3tN+6sM1Y5C7Phzd+ZuyOB0l6s0BdHAA8y3EbxjeqxE=;
 b=FVCVVDcM/n6lWb70ndb3fyRl3eeV2zbPR6HWEqwMCHoDPnUAOJNROf/YkNnXqPFl+Smk
 58Igacwt8aV0ZP4f0dxTrUgoE32xucrxj9QPRHtn5SQ5aGNJceJEAd17dPshIn+dKMh0
 jcD+DlreZPqcekiFv8zsoDMkS8M4zTYvPVtziRiSx8ZN2koNFNOrxvq6muYcuK/cl6IP
 uDMNaA7uCT/MakTZVwRysWmtDYUKSVaO1MXx8QgjGO/6MBx6YK0nmPtWEv2JcVl2Xu6w
 Mba40tRqIihg3/R+a1OU/OphRukSMAQtIrVgGX/Qy4mZx3ear3JtEJYcLS3keY6MUXgi FA== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2130.oracle.com with ESMTP id 2qd97f40ue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Feb 2019 23:17:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x16NH8en007223
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Feb 2019 23:17:09 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x16NH8D1009889;
        Wed, 6 Feb 2019 23:17:08 GMT
Received: from ubuette (/75.80.107.76)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 06 Feb 2019 15:17:08 -0800
Date:   Wed, 6 Feb 2019 15:17:06 -0800
From:   Larry Bassel <larry.bassel@oracle.com>
To:     linux-nvdimm@lists.01.org
Cc:     linux-kernel@vger.kernel.org
Subject: question about mmap MAP_PRIVATE on PMEM/DAX/fs files
Message-ID: <20190206231706.GB23860@ubuette>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9159 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1031
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=332 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902060172
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is mmaping a PMEM/DAX/fs file MAP_PRIVATE supported? Is it something
that people are likely to want to do?

If it is supported, suppose I open a file in PMEM/DAX/fs, mmap it
MAP_PRIVATE, read from the memory mapped file (with memory accesses,
not the read syscall) and take a page fault which the kernel satisfies.

At this time do my page tables for the private mmaped page(s) point to the
PMEM corresponding to the file and the kernel will wait until
the page(s) is/are altered (either by me or someone else) to
copy on write and give me a different page/mapping?

Or does the kernel avoid this by always mapping a copy of the
page(s) involved in the private mmap in the first place?

In either case, is my private copy going to come from PMEM or is it
an "ordinary" page, or is this "random"? Does the program have
any choice in this (i.e. suppose I want to make sure my copied
page is persistent)?

Thanks.

Larry
