Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CAAC0044C
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:43:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0832082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 12:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=icloud.com header.i=@icloud.com header.b="w1uff246"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E0832082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=icloud.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729326AbeJ2Vbr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 17:31:47 -0400
Received: from mr28p00im-ztfo03015001.me.com ([17.110.71.106]:45116 "EHLO
        mr28p00im-ztfo03015001.me.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729221AbeJ2Vbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 17:31:46 -0400
X-Greylist: delayed 3635 seconds by postgrey-1.27 at vger.kernel.org; Mon, 29 Oct 2018 17:31:46 EDT
Received: from process-dkim-sign-daemon.mr28p00im-ztfo03015001.me.com by
 mr28p00im-ztfo03015001.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) id <0PHC00200YHYPX00@mr28p00im-ztfo03015001.me.com> for
 linux-kernel@vger.kernel.org; Mon, 29 Oct 2018 11:42:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icloud.com;     s=04042017;
 t=1540813352;  bh=JL6lmXn04CV3rK96xk+NhxOuDsayYcBTQJfpJMKUrwo=;
        h=Date:From:To:Subject:Message-id:MIME-version:Content-type;
        b=w1uff246vdXxaNvFWFA5aXwhut0/IAzto8NeFdlarPqIpw4Vk3Q9tjV3Rh3ucGK/U
 0uxhA6Ts3QpYvxbirpapyXWC6ESWRGYEI3mbJ5FSFfUlYLCbeAc7WWjfI6Xdq3HX5i
 FMPzj4JPfkNg92vdYWjOD4/nQDIIL+2b5LtUe2xJS/lBcwHKMxAtqy80MrJ46Iy/fP
 U287LPLiBKuhG92DeG5vpmuv9qRJ/kPsaqSwfr5GHhAvWyhCQk4jT26uUn3tpsJLim
 MDa/Oed3SHP6ERTpNQBg5EvIwYhvQY7JBuk5loJVbVbZ68loNRSIVRWay80dyfSTMM
 RU8Flf43GMBVg==
Received: from icloud.com ([127.0.0.1]) by mr28p00im-ztfo03015001.me.com
 (Oracle Communications Messaging Server 8.0.2.2.20180531 64bit (built May 31
 2018)) with ESMTPSA id <0PHC00I56Z6QN530@mr28p00im-ztfo03015001.me.com>; Mon,
 29 Oct 2018 11:42:30 +0000 (GMT)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015 mlxscore=0
 mlxlogscore=828 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1807170000 definitions=main-1810290111
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,,
 definitions=2018-10-29_09:,, signatures=0
Date:   Mon, 29 Oct 2018 12:42:26 +0100
From:   damian <linux_dti@icloud.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: linux-next: Tree for Oct 29
Message-id: <20181029114225.GA2395@zrhn9910b>
Mail-followup-to: Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-kernel@vger.kernel.org
References: <20181029170212.4a34959f@canb.auug.org.au>
 <20181029063319.GC8104@Ubuntu-DTI> <20181029204142.7dbce8d8@canb.auug.org.au>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-disposition: inline
In-reply-to: <20181029204142.7dbce8d8@canb.auug.org.au>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29. Oct 20:41, Stephen Rothwell wrote:
> Hi Damian,
> 
> On Mon, 29 Oct 2018 07:33:19 +0100 Damian Tometzki <linux_dti@icloud.com> wrote:
> >
> > on the site isnt available the new linux-next ?
> > Only the old one. 
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
> 
> It seems to be there now (at least for me).  Maybe just mirroring delays?
> 
> -- 
> Cheers,
> Stephen Rothwell

Hello Stephen,
i tried it from diffrent localtion and different systems the same sitation. My last tag what i
see is: linux-next-next-20181019.tar.gz  

Best regards
Damian

