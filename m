Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3F3DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:34:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB176206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 19:34:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="ByEg1bEq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qKUJg0Ru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfAJTe0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 14:34:26 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:51415 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728493AbfAJTeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 14:34:24 -0500
X-Greylist: delayed 405 seconds by postgrey-1.27 at vger.kernel.org; Thu, 10 Jan 2019 14:34:24 EST
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailnew.west.internal (Postfix) with ESMTP id 125DC159B;
        Thu, 10 Jan 2019 14:27:39 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 10 Jan 2019 14:27:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=61YbEqSaAqpMeHSgTpT3UZ9yaIJ
        Gzm3ha0VI1H7ZClM=; b=ByEg1bEqL/W9eKhA9ElF0uwVNqtajTYyLs4sF9W1fRb
        jeITHIGHOE3Zinihdpxjq5n6o6TyYWWmAuD2+gotylggU2V0IPXfoWc6Xlplc8fe
        sVU/5iZQEAPOSDlhelaD5ptzQV5egG/rg9hvwb/Nd2AToWYk4GSxcL5MB36J0Kj/
        +WK5lMGDWPQCaL9KLAyDCzBClO5yywjwKdImaj/+daKMwziGMB+GLxjcQags8vnz
        aDsybe7NgsFmyOrYst9QB2Sm4YVB7IRkzNSt3YiudnLFfiAbgsFjDwaVcy6eU3Hu
        o4FGHcoAW0U4FWc86BCyI/ejko19UNGftv4aIR4+5jQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=61YbEq
        SaAqpMeHSgTpT3UZ9yaIJGzm3ha0VI1H7ZClM=; b=qKUJg0RucFIiG8+6M3TvT8
        8yqsdYTw6ESmVLB/ahHlWtE7iET9QLzkuPSudDZ4XUVp07qxwMWOpn7uLK6P12ik
        1SIfKAI4cnjR0kM7Prk35mf+IxB3QVJZ1y4H+iBN3yvk5wyMWRNAi75mnYyWRtJw
        fX2ywsU7InFpjwDggha2RO/RfYQG8ZuSxqVhY7UZ/QP0BLS/GRb9xsnhptRKulfs
        tzn8wYP7OqiJxf0OjSyeRuU46tgGjpR0j+obh1/ZogtkO1KzRqsIKQYpTo3jbUB/
        j6bjz0p1jaCsAo9EmBeWpkzLwb5BtCaTiFuKRI/XxIQz1icRCHxyAPoNZeBYv28w
        ==
X-ME-Sender: <xms:qpw3XPi-mLtr10RiGJjnpd9KQA6OWMucOULNjofcW-t2jr1niw9zLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedtledrfeefgdduvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfquhhtnecuuegrihhlohhuthemucef
    tddtnecuogfuphgrmhfkphculdeftddtmdenucfjughrpeffhffvuffkfhggtggujggfse
    httdertddtredvnecuhfhrohhmpefirhgvghcumffjuceoghhrvghgsehkrhhorghhrdgt
    ohhmqeenucfkphepkeefrdekiedrkeelrddutdejnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehgrhgvgheskhhrohgrhhdrtghomhenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:qpw3XKRPsA-KBJo0ctJX0yXlDIncwPXWhWYUayqcwj0udywGJM6AWg>
    <xmx:qpw3XIM4mFcYsgqj91Poi40EQzR4nSqeAmwzwqwCnE9Q6m2607tnBA>
    <xmx:qpw3XNfr7k4fItMeSyGlHQy9kcDdfsLPBmLVb7dhsx41MNSJWYHb3Q>
    <xmx:qpw3XKLTc42rWQ8omjXAog2igtxpfSgWaDziXS_Eo9i1uVVSv3N3BvHmYdw>
Received: from localhost (5356596b.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        by mail.messagingengine.com (Postfix) with ESMTPA id D80DE100E4;
        Thu, 10 Jan 2019 14:27:37 -0500 (EST)
Date:   Thu, 10 Jan 2019 20:27:36 +0100
From:   Greg KH <greg@kroah.com>
To:     esploit <esploit@protonmail.ch>
Cc:     "dgilbert@interlog.com" <dgilbert@interlog.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "security@kernel.org" <security@kernel.org>
Subject: Re: PROBLEM: syzkaller found / pool corruption-overwrite / page in
 user-area or NULL
Message-ID: <20190110192736.GA27348@kroah.com>
References: <FTiTvUZRA5yMupEMxO6bakUBM0kgENu3iSyKzomSMpfDWnMJ-AQbx4X3GRTNzNE2ZxaMAEU3nfYARed4mpJV-xC6lBR6PR5hsWKwbvAs5II=@protonmail.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FTiTvUZRA5yMupEMxO6bakUBM0kgENu3iSyKzomSMpfDWnMJ-AQbx4X3GRTNzNE2ZxaMAEU3nfYARed4mpJV-xC6lBR6PR5hsWKwbvAs5II=@protonmail.ch>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10, 2019 at 07:05:26PM +0000, esploit wrote:
> Hi, I've been getting more into Kernel stuff lately and forged ahead
> with some syzkaller bug finding.

for syzkaller stuff, no need to cc: the security mailing list.  Just
work with the respective subsystem maintainers and developers (like you
properly cc:ed) and all should be fine.

thanks!

greg k-h
