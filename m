Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB3AEC43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632B020878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:17:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoSbyXia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632B020878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbeJBO7B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:59:01 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33613 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727006AbeJBO7A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:59:00 -0400
Received: by mail-wr1-f65.google.com with SMTP id e4-v6so1106794wrs.0;
        Tue, 02 Oct 2018 01:16:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=3xymGV0Fy+yTVbyIBTZbMlgPy4Q29cAgGLgkXnxjr/g=;
        b=HoSbyXiaQLqYHTfzMZ3EE4buztOCfDDHCrVKqVkJJB16srrfPDXyOFZqfEMiOJOESq
         tLqfE0Hp8IKCkcQI19Zg5NC1uf2OfbQlO7ewwuig+LpZaCMitHZECc7p6wyJ6FZixT4W
         SnPmoCT13ElHfjYCMKefpij41XnWsd71H5VfC5UVxwcqYC7GHOfeXU2RRLwwVPSMLxH3
         zf0rqfYhxbWXwhP6CvGrAqiJnKyNuOSiL6xArZ0gVQdR4+wHLP0dxnUDibyCURGz2Hm0
         QBaOeShvrfADSRnCeYOppan4/38gcJv2ZyFlzrbczh0BUQQFyn/8XIJBBs6ykuvfKW2g
         f36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=3xymGV0Fy+yTVbyIBTZbMlgPy4Q29cAgGLgkXnxjr/g=;
        b=uFbHlR3gec7fMSgR1rvVUb6R01EydPZz5MsUphMgv8Y3Vj7fhu2f3jJbqMJrjOYXQd
         O9J7VwVTP0g8St3jIQXB1hRlVSEpkAc6fiWbQiHJM5Y/Uy+85JMQnRfUTmdEnvJwNLbK
         ApWnqQsHmf7P9zGK4hLkZfg23MsWsQfRZekiF2sJjrjLrfwalmkk7R4JrhLrmI/7j6Dh
         HX32KCZ8saOji1p2j3H8ECLE+FvhEsF21osRuxYPHQcRxFwrDPayJxBXL+3sNxkCoYO3
         IOwuq63UuqFFyFSUXJuWua+4BffrdUeht7g1FZSYQl0P8vczAXFTSBEsuh+4OLdNHlJB
         RHAQ==
X-Gm-Message-State: ABuFfogGGjREdOHDijeWXH5jbIAqhXEwIbtjq8KqWVlReTD2DkMUYoWy
        hEkHZ1AeqRRdKmos7n67GA6z0Wkw
X-Google-Smtp-Source: ACcGV61BHMwmdXBa0gslBRUgx4K6RNB8oXUIlyiuMl6No5L9yAUCrTqkxGdlVsRt+Fh5cfh685atxA==
X-Received: by 2002:a5d:6490:: with SMTP id r16-v6mr5716827wru.99.1538468216331;
        Tue, 02 Oct 2018 01:16:56 -0700 (PDT)
Received: from pali ([2a02:2b88:2:1::5cc6:2f])
        by smtp.gmail.com with ESMTPSA id k1-v6sm18152420wrl.39.2018.10.02.01.16.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:16:55 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:16:54 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To:     linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        mpluskal@suse.com, base-system@gentoo.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Subject: Re: Future of dosfstools project (FAT)
Message-ID: <20181002081654.jxesr3kj62snzez5@pali>
References: <20180929084038.an6pfhnsd6tblejl@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFLxGvxfegQFh0kvk81VLhLh0AkgvpT=hWMDCJz5FmgoTUNRqA@mail.gmail.com>
 <20180929084038.an6pfhnsd6tblejl@pali>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 October 2018 22:13:41 Richard Weinberger wrote:
> On Mon, Oct 1, 2018 at 10:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
> > If the current dosfstools maintainer is non-responsive, you could always
> > fork the project in GitHub, land the critical patches into your branch,
> >  and make a release on your own.  If the maintainer surfaces again, then
> > they can pull in your patches.  If not, then you are the new maintainer.
>-
> I also recommend talking to package maintainers of major distros.
> Maybe one of them forked the project already and did what you plan to do.
>-
> In any case, let's try to avoid a drama like util-linux-ng was.

Based on Richard's comment, I'm forwarding my original email (below) to
the Fedora, Suse and Gentoo maintainers.

On Saturday 29 September 2018 10:40:38 Pali Rohár wrote:
> Hi!
> 
> Last year I did some research how Windows and Linux tools handle FAT
> labels (boot sector vs root directory) and proposed some unification.
> More in thread: https://www.spinics.net/lists/kernel/msg2640891.html
> 
> My proposed change for manipulating with FAT labels is now implemented
> in util-linux v2.33, prepared new mtools version, and also in dosfstools
> git (unreleased) https://www.spinics.net/lists/kernel/msg2645732.html
> 
> Project dosfstools contains de-facto standard Linux userspace tools for
> FAT filesystems (mkfs.fat, fsck.fat, fatlabel) and so it is quite
> important because of high usage of FAT.
> 
> But there was no new release of dosfstools since Jan 2017 and for more
> then month I'm unsuccessfully try to contact maintainer of dosfstools
> project (Andreas) about future of project itself.
> 
> I do not know what happened, if either Andreas do not have time or
> something else...
> 
> So does somebody know what is state of dosfstools project?
> 
> Also there are lot of proposed changes (with patches) for this project
> https://github.com/dosfstools/dosfstools/pulls and also more reported
> bugs https://github.com/dosfstools/dosfstools/issues
> 
> If Andreas does not have time, can somebody else at least look at pull
> requests and do some code review?
> 
> I have some other unpublished/unfinished changes for dosfstools, but I
> do not know now if it make sense to invest more time in this project
> when maintainer does not respond... if this project is active or going
> to be dead...
> 
> If dosfstools is going to be inactive/dead, there is still mtools
> project with provides FAT tools too and maintainer of it is now
> preparing new bugfix version. So at least some alternative exists.

-- 
Pali Rohár
pali.rohar@gmail.com
