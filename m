Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 54485C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:59:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 081E3208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 13:59:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XCXDuafp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 081E3208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935715AbeFMN7l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 09:59:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52576 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934436AbeFMN7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 09:59:40 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5DDmYEq078662;
        Wed, 13 Jun 2018 13:59:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=is66ZiQij79oMdufmRXYbHRaNYpIIXksX19GzVCONHo=;
 b=XCXDuafp9tK8eJ/25FhzQE6bj8XH0hG2gD8fjUYJE7CCAqqq5Lsq9+S+vo4h5JcFTihZ
 AdZpF/0u7oJnlQ+MGNXLtxAUqi3CP7n8346swKCIiQJCERBFEkAJzdzE5UFkLhohAATZ
 Rmoc9d24iUIwI/1c9ORWKg9SXIs8mzuXNFuyajYOB+CiMs2IWcbC9otA5hLUq4QXjvak
 oObxBSM1g0x7YPPzB42Alb71fPVpRhGu4Y9+b9ev4QRqeWAf9mwvNw4kb7PY2nu60RTX
 rmaIhiuabGj0vVnuXlewhoEHCO+72PRMnEdmxzZwjSiyokfNi5FersHmJ2K9O5k0qahl zg== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2130.oracle.com with ESMTP id 2jk0xr8u6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 13:59:04 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5DDx4sw000832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 13 Jun 2018 13:59:04 GMT
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5DDx3l0020882;
        Wed, 13 Jun 2018 13:59:03 GMT
Received: from mwanda (/197.157.34.169)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 13 Jun 2018 06:59:03 -0700
Date:   Wed, 13 Jun 2018 16:58:55 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: Smatch check for Spectre stuff
Message-ID: <20180613135855.p5mrabx3dcbltahd@mwanda>
References: <20180419051510.GA21898@mwanda>
 <20180608161219.q3lwvlydvs4l2gxa@treble>
 <20180613131049.sf7abp6wwrnpy5ct@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180613131049.sf7abp6wwrnpy5ct@mwanda>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8922 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=493
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806130149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 13, 2018 at 04:10:49PM +0300, Dan Carpenter wrote:
> Also it turns out that mem_section[] is declared in mm/sparse.c and
> Smatch is supposed to be able to figure out the size of it but
> apparently there is a bug...  :(  I'll take a look at that.

Oh.  I have CONFIG_SPARSEMEM_EXTREME enabled so the size ends up
depending on cpu_feature_enabled(X86_FEATURE_LA57) which is tricky.
Meaning that I can detect that everything higher than 127 is masked off
but it doesn't help me since I don't know that the array has 128
elements.

regards,
dan carpenter

