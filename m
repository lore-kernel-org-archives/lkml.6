Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932104AbeCIOfl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:35:41 -0500
Received: from smtprelay0242.hostedemail.com ([216.40.44.242]:33975 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751102AbeCIOfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:35:40 -0500
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,:::::::::::::::::::::,RULES_HIT:41:355:379:541:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1373:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3868:3870:3871:3872:3874:4037:4321:5007:10004:10400:10848:11026:11232:11658:11914:12438:12740:12895:13069:13311:13357:13439:13894:14659:21080:21451:21627:30029:30054:30090:30091,0,RBL:47.151.150.235:@perches.com:.lbl8.mailshell.net-62.8.0.100 64.201.201.201,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:fn,MSBL:0,DNSBL:neutral,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: farm56_13f842341ac37
X-Filterd-Recvd-Size: 1979
Message-ID: <1520606135.26370.9.camel@perches.com>
Subject: Re: [PATCH 3/4] crypto: bcm: Constify *hash_alg_name[]
From: Joe Perches <joe@perches.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
        =?ISO-8859-1?Q?Hern=E1n?= Gonzalez <hernan@vanguardiasur.com.ar>
Cc: davem@davemloft.net, steven.lin1@broadcom.com,
        arvind.yadav.cs@gmail.com, colin.king@canonical.com,
        raveendra.padasalagi@broadcom.com, ray.jui@broadcom.com,
        scott.branden@broadcom.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 09 Mar 2018 06:35:35 -0800
In-Reply-To: <20180309142954.GA12852@gondor.apana.org.au>
References: <1519768888-19866-1-git-send-email-hernan@vanguardiasur.com.ar>
         <1519768888-19866-3-git-send-email-hernan@vanguardiasur.com.ar>
         <20180309142954.GA12852@gondor.apana.org.au>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.26.1-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-09 at 22:29 +0800, Herbert Xu wrote:
> On Tue, Feb 27, 2018 at 07:01:27PM -0300, Hernán Gonzalez wrote:
> > Note: This is compile only tested.
> > No gain from this except some self-documenting.
[]
> > diff --git a/drivers/crypto/bcm/spu.c b/drivers/crypto/bcm/spu.c
[]
> > @@ -23,8 +23,9 @@
> >  #include "cipher.h"
> >  
> >  /* This array is based on the hash algo type supported in spu.h */
> > -char *hash_alg_name[] = { "None", "md5", "sha1", "sha224", "sha256", "aes",
> > -	"sha384", "sha512", "sha3_224", "sha3_256", "sha3_384", "sha3_512" };
> > +char const * const hash_alg_name[] = { "None", "md5", "sha1", "sha224",
> 
> Please make that
> 
> 	const char *const
> 
> Ditto with patch 4.
> 
> Thanks,

and likely, as this is a global name, it should
be something like crypto_hash_alg_name
