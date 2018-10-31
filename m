Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8134ECDE44
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABD3B2081B
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="avEiB4Kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABD3B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeKAAEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:04:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33917 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeKAAEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:04:24 -0400
Received: by mail-qk1-f193.google.com with SMTP id a132so10014095qkg.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=yoGNBfCO1JwO7VB9ITTONXH9UmwYxniTYC7o6VC8y1Y=;
        b=avEiB4KjNCqaw3g9I9DuDiA8b7OnwUPZaSqIoi/LbHGM6z3IK2e7yLtSmYqbxZXdhl
         xEFninH32KXp5GEG+Z4275na5OzpH6lHPsg5NCig2hl+0qD3zwCv6R9KpCtsefDk7Et+
         OCQJwPsh0QZCJ+mGnGIT1qOMOCAJCSHwclrQcO/znXR7N6AE0rtN9/ym21yGZ+/oDHAO
         wtuUK4U6CeZuMSrc+gPeD+RND/ZUPrxStv74tT1hsTKLnOD5UIg8qabwBVY4RDaLAJ9Z
         gffk0CikURe6HsgNa6aTpwnlEY3pc/7ikBeUm527zdXck0c6Xqoi+LcI/Tjj5yQt4NM8
         XXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yoGNBfCO1JwO7VB9ITTONXH9UmwYxniTYC7o6VC8y1Y=;
        b=o7wi5WNSk7x3q3IiYWZuUN8EuXQtm57fjUeoIjcTdeH07LmlvjoPwXcvE8soybrsQf
         tBSO/gEWzp9XxFovlze3wECGWpqRhyNNkI2PDqVXjndmP3zqAn15v9eH22+x4Qw9SdyF
         NiRhV4xbdif02qu8frdBIj3U2psyBmKGJLOOGTH0BujLnitobjarTsgoKQdFrOELXnOy
         B2Dlr3wsn01ZXQlyK0IY7LtAeOmzWRXu9Aa5L2U5OBFh4sGxWgkDEUNXxUk/d9MvgYMN
         U8xe/tEf9zl4M6fAvQmsYZzMT13Q/3yeUdi9DTig1QtPE/kzOzCFLNAMMuVhTp3RN3JU
         1qFw==
X-Gm-Message-State: AGRZ1gIrgkT2vfTRCxHSujsDSytSL1YHOFwD8y7QK7ACYMByvbPEwFNk
        TGgXe/tfY4/t2tqrGTLgqR8=
X-Google-Smtp-Source: AJdET5eKGMuMrGNjo5/KUK1dsm54MIGCkETdepPmrcNV2wJ7H0vIfm91/0TaIOkl3+YJM1M9oZVuLw==
X-Received: by 2002:a0c:93e2:: with SMTP id g31mr3034133qvg.194.1540998356558;
        Wed, 31 Oct 2018 08:05:56 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 24-v6sm23000009qts.19.2018.10.31.08.05.54
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Oct 2018 08:05:56 -0700 (PDT)
Date:   Wed, 31 Oct 2018 12:05:51 -0300
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Thayer <michael.thayer@oracle.com>,
        devel@driverdev.osuosl.org, outreachy-kernel@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [Outreachy kernel] Re: [PATCH v2] staging: vboxvideo: Remove
 unnecessary parentheses
Message-ID: <20181031150551.kmkhqsvsy3arm4lc@smtp.gmail.com>
References: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com>
 <20181030092539.GA10009@kroah.com>
 <20181030231757.24ooubt25oykmgkt@smtp.gmail.com>
 <20181030234826.GE194472@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181030234826.GE194472@sasha-vm>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30, Sasha Levin wrote:
> On Tue, Oct 30, 2018 at 08:17:57PM -0300, Shayenne Moura wrote:
> > On 10/30, Greg Kroah-Hartman wrote:
> > > On Tue, Oct 23, 2018 at 02:43:04PM -0300, Shayenne da Luz Moura wrote:
> > > > Remove unneeded parentheses around the arguments of ||. This reduces
> > > > clutter and code behave in the same way.
> > > > Change suggested by checkpatch.pl.
> > > >
> > > > vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
> > > > crtc->x'
> > > >
> > > > Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
> > > > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > > > ---
> > > > Changes in v2:
> > > >   - Make the commit message more clearer.
> > > 
> > > This patch does not apply to the latest kernel tree at all :(
> > > 
> > > Please fix up and resend.
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > Hi Greg!
> > 
> > Sorry, I do not know what branch are expected to be used.
> > I used the drm-misc-next to create this patch and I could not
> > find any merge problem.
> > 
> > Could you please tell me the details?
> 
> Hi Shayenne,
> 
> There's an easy trick for this: the kernel tree has a script that can
> help you find both the relevant maintainers, and their development tree
> for each file in the kernel.
> 
> Simply run:
> 
> 	./scripts/get_maintainer.pl --scm -f [filename]
> 
> For example, in this case, you'd run:
> 
> 	$ ./scripts/get_maintainer.pl --scm -f drivers/staging/vboxvideo/vbox_main.c
> 	Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:STAGING SUBSYSTEM,commit_signer:10/10=100%)
> 	Hans de Goede <hdegoede@redhat.com> (commit_signer:7/10=70%,authored:6/10=60%,added_lines:31/37=84%,removed_lines:153/159=96%)
> 	Fabio Rafael da Rosa <fdr@pid42.net> (commit_signer:1/10=10%,authored:1/10=10%)
> 	Alexander Kapshuk <alexander.kapshuk@gmail.com> (commit_signer:1/10=10%,authored:1/10=10%)
> 	Nicholas Mc Guire <der.herr@hofr.at> (commit_signer:1/10=10%)
> 	Thomas Zimmermann <tzimmermann@suse.de> (authored:1/10=10%,added_lines:2/37=5%)
> 	Daniel Junho <djunho@gmail.com> (authored:1/10=10%,added_lines:2/37=5%)
> 	devel@driverdev.osuosl.org (open list:STAGING SUBSYSTEM)
> 	linux-kernel@vger.kernel.org (open list)
> 	git git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/staging.git
> 
> The list of people and mailing lists are the ones that should be the
> recipients of your patch, and the last line is the git tree on which the
> patch should be based on.
> 
> --
> Thanks,
> Sasha

Thanks Sasha!

It is a very nice tip! 

Best regards,
Shayenne
