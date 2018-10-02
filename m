Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8DFC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:44:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E90A20684
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:44:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E90A20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727411AbeJBP0U convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:26:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51518 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726508AbeJBP0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:26:20 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CE942308212C;
        Tue,  2 Oct 2018 08:44:10 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB57C2010CEF;
        Tue,  2 Oct 2018 08:44:10 +0000 (UTC)
Received: from zmail22.collab.prod.int.phx2.redhat.com (zmail22.collab.prod.int.phx2.redhat.com [10.5.83.26])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 7CED81809546;
        Tue,  2 Oct 2018 08:44:10 +0000 (UTC)
Date:   Tue, 2 Oct 2018 04:44:10 -0400 (EDT)
From:   Jaroslav Skarvada <jskarvad@redhat.com>
To:     Pali =?utf-8?Q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Message-ID: <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com>
In-Reply-To: <20181002081654.jxesr3kj62snzez5@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali> <20181002081654.jxesr3kj62snzez5@pali>
Subject: Re: Future of dosfstools project (FAT)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.43.7.166, 10.4.195.20]
Thread-Topic: Future of dosfstools project (FAT)
Thread-Index: sjMSYP9oasQnW4UnwK55WDa9X3Hb4w==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.25
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Tue, 02 Oct 2018 08:44:10 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message -----
> On Monday 01 October 2018 22:13:41 Richard Weinberger wrote:
> > On Mon, Oct 1, 2018 at 10:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
> > > If the current dosfstools maintainer is non-responsive, you could always
> > > fork the project in GitHub, land the critical patches into your branch,
> > >  and make a release on your own.  If the maintainer surfaces again, then
> > > they can pull in your patches.  If not, then you are the new maintainer.
> >-
> > I also recommend talking to package maintainers of major distros.
> > Maybe one of them forked the project already and did what you plan to do.
> >-
> > In any case, let's try to avoid a drama like util-linux-ng was.
> 
> Based on Richard's comment, I'm forwarding my original email (below) to
> the Fedora, Suse and Gentoo maintainers.
> 
> On Saturday 29 September 2018 10:40:38 Pali Rohár wrote:
> > Hi!
> > 
> > Last year I did some research how Windows and Linux tools handle FAT
> > labels (boot sector vs root directory) and proposed some unification.
> > More in thread: https://www.spinics.net/lists/kernel/msg2640891.html
> > 
> > My proposed change for manipulating with FAT labels is now implemented
> > in util-linux v2.33, prepared new mtools version, and also in dosfstools
> > git (unreleased) https://www.spinics.net/lists/kernel/msg2645732.html
> > 
> > Project dosfstools contains de-facto standard Linux userspace tools for
> > FAT filesystems (mkfs.fat, fsck.fat, fatlabel) and so it is quite
> > important because of high usage of FAT.
> > 
> > But there was no new release of dosfstools since Jan 2017 and for more
> > then month I'm unsuccessfully try to contact maintainer of dosfstools
> > project (Andreas) about future of project itself.
> > 
> > I do not know what happened, if either Andreas do not have time or
> > something else...
> > 
> > So does somebody know what is state of dosfstools project?
> > 
> > Also there are lot of proposed changes (with patches) for this project
> > https://github.com/dosfstools/dosfstools/pulls and also more reported
> > bugs https://github.com/dosfstools/dosfstools/issues
> > 
> > If Andreas does not have time, can somebody else at least look at pull
> > requests and do some code review?
> > 
> > I have some other unpublished/unfinished changes for dosfstools, but I
> > do not know now if it make sense to invest more time in this project
> > when maintainer does not respond... if this project is active or going
> > to be dead...
> > 
> > If dosfstools is going to be inactive/dead, there is still mtools
> > project with provides FAT tools too and maintainer of it is now
> > preparing new bugfix version. So at least some alternative exists.
> 
> --
> Pali Rohár
> pali.rohar@gmail.com
> 

Hi,

I am downstream maintainer of dosfstools in Fedora/RHEL. My personal opinion
with such kind of projects is that one or two years without activity doesn't
mean the project is dead. I don't know what happened with Andreas, but
in case of no response my +1 for the GitHub fork. I think it's non offensive
solution which can be easily reverted if needed. Please let me know if you do it

thanks & regards

Jaroslav
