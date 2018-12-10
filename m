Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1B4C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:47:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42FDB2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 09:47:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="sA3Y49Rh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kKW3CHCH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42FDB2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kroah.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbeLJJrP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 04:47:15 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:39985 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726136AbeLJJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 04:47:14 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id E54E021C6B;
        Mon, 10 Dec 2018 04:47:10 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 10 Dec 2018 04:47:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=DJdTaTtOkt6Ns79KYaJ1+KscWcU
        gxpoRZMSY0rrYm3E=; b=sA3Y49Rhjr9zel5HEOiOd7VHapgD2/vmRoDD8GhyVGz
        qzekbmtxIN/BPMQPLQkx2US7BtCbjEYOTA9UwkCR3+lI4N5j6jRLwTCP9gYWNHuL
        w6AmS8TQNhx2i1hrUoG0TPSm0Z2t85PEq2RbjenAmosluWAQzy4RAIjxkIRpv2xC
        RARfO1aiqviLfV2+yy2t+iOL40EsRhSQ0tEreMU0sbpjn9JC3KNwPD4imeBNJjnq
        m7+Xhiei0vs1Y71aY8s9/nYmB1ck1gj7U6ki+dIoSWuP6RiohrsAa92GoypN4nhp
        QaklQ6FKeIoFw/TJoaSx0298nXLO98z5xWJAWj89Wpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=DJdTaT
        tOkt6Ns79KYaJ1+KscWcUgxpoRZMSY0rrYm3E=; b=kKW3CHCHsGEiBE7ZTSusXA
        l+9rLqY89788+YkjMnoHeVzVqLY+3w3GjAio33spPtYUPXBMiWhyh61KaYNjprw8
        DPLrKpRHQeKxQiVfSmRKsBVVPXUnwKmG9cmxILgA35tEQNwomL7oj+Y5Ws0Y6Jc+
        uKYfZPHN2CBANnA36TlQ0a55aSlU9E0gBxruQRq7ZUm7GiPVY695d23yKfGA+1ZN
        B8v1I6bFd5nlv+oDBsyFqJQ3Dvd/6TO+TsmPFwJaAWPFUijTKLNVpOmHcwTETP5V
        THKrruNd1HdPVMvwaa8AByJv57x3V2tIKoVgS1gC8bKi3b+zRZ7oyWaPg4XL4O/g
        ==
X-ME-Sender: <xms:HTYOXKwRUBab3JAcUxye7QletGON-k7y14ohaFFU9ZiESnGqzmwdXw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtkedrudeghedgtdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkfh
    ggtggujggfsehttdertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehk
    rhhorghhrdgtohhmqeenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigv
    pedt
X-ME-Proxy: <xmx:HTYOXFG27Pnbdgp3UhFE-vr9QY4pMgjB4PrC9mSL1RJI89uzf4Hecg>
    <xmx:HTYOXKhci5pxyUtSmep3smV_zkUYS-0NI9gKsgAdNKYoZodfoT_Zbg>
    <xmx:HTYOXI-sT0XoycLos8P0N-xYP_uFDPS5fzWZgfSorKa--7YCJw-Yug>
    <xmx:HTYOXJpwjxfekrkw-g7zMkYwXvRLyDRJZ99_Gi0NxRDt96hJ9as9sQ>
    <xmx:HTYOXP84zd6EoaB-a1SbMfEZgGbU3rtpHK89T64RjhC81-QeWiBc6w>
    <xmx:HjYOXJdiQEMpXHTyYTecBoGzP_uFk5f-jERxgazyIny3KChe3oMybg>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B5E5103C6;
        Mon, 10 Dec 2018 04:47:09 -0500 (EST)
Date:   Mon, 10 Dec 2018 10:47:07 +0100
From:   Greg KH <greg@kroah.com>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        KY Srinivasan <kys@microsoft.com>
Subject: Re: linux-next: manual merge of the char-misc tree with the
 char-misc.current tree
Message-ID: <20181210094707.GA22095@kroah.com>
References: <20181204153513.1e799336@canb.auug.org.au>
 <20181204074241.GB27141@kroah.com>
 <PU1P153MB01699DCE042ACB59AADCC8D3BFAF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PU1P153MB01699DCE042ACB59AADCC8D3BFAF0@PU1P153MB0169.APCP153.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.11.1 (2018-12-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2018 at 08:46:41AM +0000, Dexuan Cui wrote:
> > From: Greg KH <greg@kroah.com>
> > Sent: Monday, December 3, 2018 11:43 PM
> > On Tue, Dec 04, 2018 at 03:35:13PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > >
> > > Today's linux-next merge of the char-misc tree got a conflict in:
> > >
> > >   drivers/hv/channel_mgmt.c
> > >
> > > between commit:
> > >
> > >   37c2578c0c40 ("Drivers: hv: vmbus: Offload the handling of channels to
> > two workqueues")
> > >
> > > from the char-misc.current tree and commit:
> > >
> > >   4d3c5c69191f ("Drivers: hv: vmbus: Remove the useless API
> > vmbus_get_outgoing_channel()")
> > >
> > > from the char-misc tree.
> > >
> > > I fixed it up (I used the former version where they conflicted) and can
> > > carry the fix as necessary. This is now fixed as far as linux-next is
> Hi Stephen, 
> Thank you! I can confirm your rebase for next-20181204 is correct:
> 37c2578c0c40 ("Drivers: hv: vmbus: Offload the handling of channels to two workqueues")
> 
> > > concerned, but any non trivial conflicts should be mentioned to your
> > > upstream maintainer when your tree is submitted for merging.  You may
> > > also want to consider cooperating with the maintainer of the conflicting
> > > tree to minimise any particularly complex conflicts.
> > 
> > Yeah, this is a mess, I'll wait for the hyper-v developers to send me a
> > fixup patch for handling this merge issue, as they know it is happening
> > :(
> > 
> > greg k-h
> 
> Since Stephen has fixed the merge issue correctly, I guess I may not need to send a fixup
> patch for linux-next.git. If I didn't get it right, please let me know which tree/branch I
> should work on to send a fixup patch.
> 
> It looks the conflict here happened because the two related patches, which modify
> the same functions, went into different branches of char-misc.git. I didn't realize this
> could happen... Sorry. The lesson I learnt is that I should not submit an urgent fix
> with an unimportant clean-up patch at the same time, when they can cause a conflict.

I have done the merge in my char-misc-next branch, can you verify that I
got it correct?

thanks,

greg k-h
