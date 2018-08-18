Return-Path: <SRS0=Se0q=LB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41740C4321D
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:07:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D284F217BB
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Aug 2018 15:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D284F217BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbeHRSPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Aug 2018 14:15:55 -0400
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:37428 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726265AbeHRSPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Aug 2018 14:15:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id E4C8A180A813A;
        Sat, 18 Aug 2018 15:07:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: shame10_7f0700412821f
X-Filterd-Recvd-Size: 2719
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 18 Aug 2018 15:07:52 +0000 (UTC)
Message-ID: <be9df4884fec35affd282dd2405c4333d76d2192.camel@perches.com>
Subject: Re: [PATCH] staging: rtl8188eu: Type cast function argument
From:   Joe Perches <joe@perches.com>
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>,
        zhong jiang <zhongjiang@huawei.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org
Date:   Sat, 18 Aug 2018 08:07:51 -0700
In-Reply-To: <20180818145851.GA20128@Gentoo-PC>
References: <20180818142409.GA17122@Gentoo-PC> <5B782E3B.7030001@huawei.com>
         <20180818145851.GA20128@Gentoo-PC>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-08-18 at 20:28 +0530, Bhaskar Singh wrote:
> On Sat, Aug 18, 2018 at 10:33:31PM +0800, zhong jiang wrote:
> > On 2018/8/18 22:24, Bhaskar Singh wrote:
> > > This patch might suppress some warrning.
> > > 
> > > The function prototype of rtw_malloc2d is
> > > 
> > > void *rtw_malloc2d(int h, int w, int size)
> > > 
> > > This patch also resolves the checkpatch.pl warning
> > > 
> > > WARNING: line over 80 characters

Please look deeper at the code than checkpatch.

This function is used exactly once and could
likely be removed and coded inline instead to
improve readability.

> > > Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
> > > ---
> > >  drivers/staging/rtl8188eu/core/rtw_efuse.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > > index 0fd306a808c4..735d654b2844 100644
> > > --- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > > +++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
> > > @@ -91,7 +91,8 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
> > >  	if (!efuseTbl)
> > >  		return;
> > >  
> > > -	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E, EFUSE_MAX_WORD_UNIT, sizeof(u16));
> > > +	eFuseWord = (u16 **)rtw_malloc2d(EFUSE_MAX_SECTION_88E,
> > > +			EFUSE_MAX_WORD_UNIT, (int)sizeof(u16));
> > >  
> > 
> >   You should be align with left parenthesis.
> > 
> >  Thanks,
> >  zhong jiang
> > > 	if (!eFuseWord) {
> > >  		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
> > >  		goto eFuseWord_failed;
> > 
> > 
> 
> why post-commit doesn't give some warrning about that (because commits are checked by
> post-commit script)?
> Do I need to resend the patch?
> 
