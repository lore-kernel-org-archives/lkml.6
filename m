Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF4CC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272882089F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 07:47:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OvbdUKaq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390503AbfBOHrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 02:47:37 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:52042 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbfBOHrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 02:47:37 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x1F7iADk189818;
        Fri, 15 Feb 2019 07:47:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=4pTNI4YEhu+BfKnlRVAOaDkJbJN0zf3VyvKyHmgwzMQ=;
 b=OvbdUKaqt/fq+377MoqPcUEGXDG9sHcvyVPInmN1sq0hKpM50P3N+AK9qmXv/nlMg4Zg
 lFwyQKxajTaKcL7+pT89x/TZ0tWb70310Iw+tRPgMMKyy6HTlNKXaPvWpiRFy97Svfjg
 nlzOi6wUMEk1U7ny3f4naz3MCOQmT6Jp48foAct5YpDPuBTsERVdWr4lz3NFnL6Jg41Q
 FXdxQsSbMJPQre76Y1OsTDfiFIRc5TXDWoZANO47MPz6FMN9yH8raBI7wcB8420CVtdi
 AjI3DFX1toQxE+CQRP5YtxUGPXHZkV0DxK+Ko+T1Zd+12x1/6LfOPfIKEhLuEhZBhUZM Jw== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2qhrekv9tf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 07:47:09 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id x1F7l8P2010757
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Feb 2019 07:47:08 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x1F7l7iT029859;
        Fri, 15 Feb 2019 07:47:07 GMT
Received: from kadam (/197.157.0.55)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 15 Feb 2019 07:47:07 +0000
Date:   Fri, 15 Feb 2019 10:46:58 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Chen-Yu Tsai <wens@csie.org>
Cc:     Colin King <colin.king@canonical.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        kernel-janitors@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][V2][next] regulator: axp20x: check rdev is null before
 dereferencing it
Message-ID: <20190215074658.GF2326@kadam>
References: <20181222113159.31029-1-colin.king@canonical.com>
 <CAGb2v6597uiPec=BPvTZgppxF2upTa_zKHq+QSbddyMGJAd7uA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGb2v6597uiPec=BPvTZgppxF2upTa_zKHq+QSbddyMGJAd7uA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9167 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=675 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1902150058
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 05, 2019 at 11:37:40AM +0800, Chen-Yu Tsai wrote:
> On Sat, Dec 22, 2018 at 7:32 PM Colin King <colin.king@canonical.com> wrote:
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > Currently rdev is dereferenced when assigning desc before rdev is null
> > checked, hence there is a potential null pointer dereference on rdev.
> > Fix this by null checking rdev first.
> >
> > Detected by CoverityScan, CID#1476031 ("Dereference before null check")
> >
> > Fixes: 77e3e3b165db ("regulator: axp20x: add software based soft_start for AXP209 LDO3")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> This patch somehow fell through the cracks. Sorry about that.
> 
> Both are really false positives.

I don't like when people use the word "false positive" like this.  The
code doesn't checks for NULL after a dereference so that's a nonsense
to do.  The correct thing is to remove the NULL check.

regards,
dan carpenter

