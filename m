Return-Path: <SRS0=vsD1=ND=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4349BC46475
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B8982075D
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Oct 2018 06:46:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="He7clDWh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B8982075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727699AbeJWPIy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Oct 2018 11:08:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34254 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJWPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Oct 2018 11:08:54 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w9N6dc9n058953;
        Tue, 23 Oct 2018 06:46:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=qrCY+6XN0rDs8BCLAWJc9SGe1hWjaQqHd3bqWMWKIQM=;
 b=He7clDWhL7WjzV/YKNGbwTQR5Md8oOtyrZOXzz+XqSWZ7Frn2FiJ0E2OC00rv6H6d1Ot
 fNjXriAKHx7SNQywHmOyOk5z7ahrb9InHYT2cPrG84gTdBiZIf/SOqmLlGLpeGRZDSb5
 KfLV6Q/SZOp9ub9RCfp7JfDs2ld5/kIphBPHI1Z0lw5wKFdHW+FJBkpbN9XxWfWm+ZCh
 cDWnke5Mgyc+udWyjpa/xPCYnIIPgQLlkUt1RyLL6vyBx7QhBWu9+RIzFmhj73bTF47m
 l3nBfwNjhT/miqnYr4c9ty7rpXl/KBzdM7vAyliXYYXqZ92RYYmoCtllA43fZUg1LW3F NA== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by userp2120.oracle.com with ESMTP id 2n7w0qjytc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 06:46:47 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w9N6kkeu009754
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Oct 2018 06:46:46 GMT
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w9N6kjqP011355;
        Tue, 23 Oct 2018 06:46:46 GMT
Received: from mwanda (/129.205.6.86)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Oct 2018 23:46:45 -0700
Date:   Tue, 23 Oct 2018 09:46:38 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Al Viro <viro@ZenIV.linux.org.uk>
Cc:     ksummit-discuss@lists.linuxfoundation.org,
        Mishi Choudhary <mishi@linux.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NeilBrown <neil@brown.name>
Subject: Re: [Ksummit-discuss] Call to Action Re: [PATCH 0/7] Code of
 Conduct: Fix some wording, and add an interpretation document
Message-ID: <20181023064638.sm6jiqtntzxew7u2@mwanda>
References: <20181020134908.GA32218@kroah.com>
 <87y3ar80ac.fsf@notabene.neil.brown.name>
 <20181021222608.GA24845@localhost>
 <875zxt919d.fsf@notabene.neil.brown.name>
 <20181022224604.GM1617@thunk.org>
 <20181023062652.yrns7n67jkuict5n@mwanda>
 <20181023064051.GX32577@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181023064051.GX32577@ZenIV.linux.org.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9054 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=414
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810230060
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2018 at 07:40:51AM +0100, Al Viro wrote:
> On Tue, Oct 23, 2018 at 09:26:52AM +0300, Dan Carpenter wrote:
> 
> > Ten years back there was a patch rejected because "F*** you, what do
> > women know about programming?"  I can't imagine it happening now, but I
> > was so shocked by it at the time also...
> 
> URL?  I would really, honestly, no kidding, like to know who had that
> been (and where had that been, while we are at it).  I would expect
> a massive (and absolutely deserved) shitstorm if that was on any
> public kernel-related lists 10 years ago, but I'm not reading all
> of them, obviously...

It was a private email and I don't know who the maintainer was.

But I heard about it from the woman at a Linux conference and she was
a competent programmer and the bug was still there at the time.

regards,
dan carpenter

