Return-Path: <SRS0=eDXJ=JC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=BODY_8BITS,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5952BC5CFC0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10BA5208B5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Jun 2018 12:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pkCkDU4G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10BA5208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932931AbeFPMqm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Jun 2018 08:46:42 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43248 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932741AbeFPMqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jun 2018 08:46:39 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5GCj9X1089845;
        Sat, 16 Jun 2018 12:46:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 content-transfer-encoding : in-reply-to; s=corp-2017-10-26;
 bh=wHFt3zJoUf4lMoI8jg/IAaLChb/mwo48LzoF8Bc4SrU=;
 b=pkCkDU4GrWtNdLV1mbA4bOKPJ+maPVUpta1HwhdoF6to5+yXz16VrzjxW1kgMLDlyOyU
 V1dHe2g7e3NrDmQflNFaABjjJqfNN1rLxeWEu//wzz48KgeCUSYE4tJaEKblz1b+Ch8s
 gkIydE6GvKe6j/KSB3oZIceuthoX+oA5NPIFYbOtkmxlXyMUBPGOZ2LhNpYGADUTVp16
 awAmHaO/HDkPYZsvxlYTEuKMPNowRz7jiCdVmT+Fx/VMMXVA/gxmolgo8dzORsGkFKVT
 i7N9sTPdn7whYXnOLG0+8ISZZDEaaytLl7DFc61iMivlCxxF3Hb2vzhUvtUytZ0W8KoO 0w== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by userp2120.oracle.com with ESMTP id 2jmu6xggtg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jun 2018 12:46:32 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5GCkWGH031137
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 16 Jun 2018 12:46:32 GMT
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w5GCkVvk021180;
        Sat, 16 Jun 2018 12:46:31 GMT
Received: from mwanda (/41.202.241.23)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 16 Jun 2018 05:46:30 -0700
Date:   Sat, 16 Jun 2018 15:46:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     =?utf-8?B?6rmA7KSA7ZmY?= <spilit464@gmail.com>
Cc:     alan@linux.intel.com, sakari.ailus@linux.intel.com,
        mchehab@kernel.org, devel@driverdev.osuosl.org,
        Greg KH <gregkh@linuxfoundation.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, linux-media@vger.kernel.org
Subject: Re: [PATCH] media: staging: atomisp: add a blank line after
 declarations
Message-ID: <20180616124621.onqmaamidzjdyzlj@mwanda>
References: <2750553.3y1WJKmnP5@joonhwan-virtualbox>
 <20180616090609.s5s4q2ri7e2x24oo@mwanda>
 <CAO-p-6CXp1LNMciC2WsT4S-+oubh6SLYHs+4rfmQP9m88F12iA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAO-p-6CXp1LNMciC2WsT4S-+oubh6SLYHs+4rfmQP9m88F12iA@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8925 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806160155
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 16, 2018 at 07:20:54PM +0900, 김준환 wrote:
> Thank you for attention :)
> 
> I knew what I forgot before doing contribute
> 
> I updated it 'TODAY' and I'll never repeat this mistake again!
> 

No rush.

This is a tiny mistake and doesn't affect runtime at all and we're all
human.  The thing to do is figure out which are avoidable mistakes,
right?

Like for me, when I was starting out I wrote some patches that added
some allocations but I forgot to add the kfree().  So then I made a QC
script that runs some static checkers over my patches and if I add any
line with "alloc" in it then my QC script asks me:

if git diff $fullname | grep ^+ | grep -qi alloc ; then
    qc "Have you freed all your mallocs?"
    qc "Have you checked all your mallocs for NULL returns?"
fi

And a couple weeks ago, I accidentally introduced a bug, which someone
caught during review, because I removed a cast that I thought was
unnecessary.

	for (i = 0; i < (int)limit; i++) {

I thought limit couldn't be negative but I was wrong.  So I wrote a
static checker test for that so I'll never do it again.  And I found
some similar bugs in other people's code and fixed those.  Static
analysis is sort of my thing but anyone could do it really.  Or ask
Julia and I to write a check.  But most people have the hardware and
could write a test program to trigger the bug and add it to their QC
process.

So making mistakes is fine and it's part of learning.  You should
definitely take the time to figure out where you went wrong and if it's
preventable.  But no one really gets annoyed about mistakes because it's
just part of life and being human.

regards,
dan carpenter

