Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DAEC6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D4ED24BBD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 13:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gR48ANz0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D4ED24BBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753377AbeGCNAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 09:00:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59296 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752494AbeGCNAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 09:00:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w63CwVO7006043;
        Tue, 3 Jul 2018 13:00:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2017-10-26;
 bh=NaUA/FnOoQaZqv9f2fXWUCRsyDmSiB8esHiCe4r87oM=;
 b=gR48ANz0u5oSplptI8xWjaLJN9L6YVlAr/zlh3EdW/GtHMdYWIiAMOPzBWFKchADE0AS
 9z601SGuyl7whqAKzdEIKase9EYyrpMO48EEdxBAkILPpfXHKByW8+F71ZsPux1gVE4V
 gtG8Mqoh9dGOAQS86/Zk1mmZD3IH+gS/XxErwlCSmM8y3APJyqMiKiRmHTW8L8bmgbRk
 Mf3Lg4MqxjX2up2KrJBu/KccnmIOodiZiN86P8jFsRDSQDHT/+R1D0nK5dZMpNLDv60l
 9NlDktzo2mR/ETmEwu+a3ys8KP5QMPOhgWRRckrejxwfbHN09PACcLCsn0cvso6atw9e Yw== 
Received: from userv0022.oracle.com (userv0022.oracle.com [156.151.31.74])
        by aserp2120.oracle.com with ESMTP id 2jx1tp0djv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 03 Jul 2018 13:00:34 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w63D0XdT025332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Jul 2018 13:00:34 GMT
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w63D0WEt012416;
        Tue, 3 Jul 2018 13:00:33 GMT
Received: from mwanda (/197.157.0.57)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 03 Jul 2018 06:00:32 -0700
Date:   Tue, 3 Jul 2018 16:00:24 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     Joe Perches <joe@perches.com>, linux-usb@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH 0/3] cast sizeof to int for comparison
Message-ID: <20180702091834.etunideivmb6p2sf@mwanda>
References: <1530466325-1678-1-git-send-email-Julia.Lawall@lip6.fr>
 <653914f26dc8433a3f682b5e7eb850ab94bd431d.camel@perches.com>
 <alpine.DEB.2.20.1807012050530.2494@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1807012050530.2494@hadrien>
User-Agent: NeoMutt/20170609 (1.8.3)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8942 signatures=668704
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=535
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807030149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 01, 2018 at 08:51:55PM +0200, Julia Lawall wrote:
> 
> 
> On Sun, 1 Jul 2018, Joe Perches wrote:
> 
> > On Sun, 2018-07-01 at 19:32 +0200, Julia Lawall wrote:
> > > Comparing an int to a size, which is unsigned, causes the int to become
> > > unsigned, giving the wrong result.
> > >
> > > The semantic match that finds this problem is as follows:
> > > (http://coccinelle.lip6.fr/)
> >
> > Great, thanks.
> >
> > But what about the ones in net/smc like:
> >
> > > net/smc/smc_clc.c:
> > >
> > >         len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
> > >                              sizeof(struct smc_clc_msg_decline));
> > >         if (len < sizeof(struct smc_clc_msg_decline))
> >
> > Are those detected by the semantic match and ignored?
> 
> I wasn't sure how to justify that kernel_sendmsg returns a negative value.
> If it is the case, I can send the patch.  I only found this in one file,
> but there were multiple occurrences.
> 

In theory, Smatch is supposed to know return values but kernel_sendmsg()
is too complicated for Smatch.  It's a tricky thing...  That particular
check is correct and deliberate, but there is another check which is
wrong.

net/smc/smc_clc.c
   369          len = kernel_sendmsg(smc->clcsock, &msg, &vec, 1,
   370                               sizeof(struct smc_clc_msg_decline));
   371          if (len < sizeof(struct smc_clc_msg_decline))
   372                  smc->sk.sk_err = EPROTO;
   373          if (len < 0)
   374                  smc->sk.sk_err = -len;

If it's invalid we set an error code, if it's already an error we
preserve the error code.

   375          return sock_error(&smc->sk);

[ snip ]

   442          /* due to the few bytes needed for clc-handshake this cannot block */
   443          len = kernel_sendmsg(smc->clcsock, &msg, vec, i, plen);
   444          if (len < sizeof(pclc)) {
   445                  if (len >= 0) {
                            ^^^^^^^^
This is always true.

   446                          reason_code = -ENETUNREACH;
   447                          smc->sk.sk_err = -reason_code;
   448                  } else {
   449                          smc->sk.sk_err = smc->clcsock->sk->sk_err;
   450                          reason_code = -smc->sk.sk_err;
   451                  }
   452          }

The other two checks are not type promoted so they also work as
intended.

This is an interesting sort of bug I've written a Smatch script inspired
by your work here.  One for the type promotion and one for the
impossible condition.  I'll let you know how it goes.

regards,
dan carpenter

