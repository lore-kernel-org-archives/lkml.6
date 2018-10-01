Return-Path: <SRS0=RFFj=MN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467BFC43143
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0EF202084C
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Oct 2018 20:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="auFBtxTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EF202084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726572AbeJBCxY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Oct 2018 22:53:24 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:41632 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbeJBCxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Oct 2018 22:53:24 -0400
Received: by mail-wr1-f54.google.com with SMTP id x12-v6so703012wru.8;
        Mon, 01 Oct 2018 13:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=szYMQy/EjPvJVu2QeCwtz+nmFuxusOigUfaQvtOos6w=;
        b=auFBtxToPbGFvDmzkblNsknsoO/PeHcFWZaqjp33TI5kvtUg7SD1TadZuzxk71Tm5d
         C8Fghgk7OBYEY5bAlgCmcZ0hPezN9NGaxqsrabBK5iBAtNDI2L8oDxz/j3fKFd7OImDv
         FaoKoJ1tCzc/oKxGixiSKZflBDKoWueuQFdWNniAUAE8UApWf2i5QEcYhr0fJCx7ufsH
         OIOV9PITNikxaMzkY4F225eBTb48AFpLtuH7WiMwN0hfGblOXUR33Dsgwa2QJJ/C6lrb
         +MG1jiLfcgXqT9VvfmFO6IKmeg4hH1lhshvCslgsfpLliBEALwIHctgnSJTlPBZS28iX
         g1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=szYMQy/EjPvJVu2QeCwtz+nmFuxusOigUfaQvtOos6w=;
        b=WRvFcazcj5nJxahqoElJE4iQDyRUvc/4M2CKeupoDDmZj751BQENFnwX8O/mgDOdbt
         wpwYA3ofriTmTtPKk6wJcb23qO9VZiVjEDS5Sf/609H9CKgbGP+b6xLSWpCVVDwu0JIf
         x7RqYCWTM2RmdTTGHAeDmLLcWX6Hk22o3fR3ZYUl4Wvxen1fxXbJDs5zhZXDp8Zx4jQ0
         b7PD92gHWh+YpMp1I6qCamfFYhTFHYyNOCLVGZ0mPKe8ca9T4pStkZvkMzaicvsnvJdy
         T1R2LH5yuVRpkPbBN2B+TgkV+0LezyZZxWC0k0hthXccEDTbXMCwdfjed3W7B5dEGxyv
         9IAA==
X-Gm-Message-State: ABuFfojGnyfMLFN0hpv+o/extL1QsvD0mI2CcyggrsB4f4NMyhLKm7um
        kBJTanGGlredkw8eS4t0crbVu1qjy6DQaCS+RhE=
X-Google-Smtp-Source: ACcGV614c+X0kczFxT52/73xydaxsd8uNx79uPJCIDMQ1nyOtlE1icx1oD6nbKGX01IWKHM5X86CWwquJYB7JOOScgM=
X-Received: by 2002:adf:dd83:: with SMTP id x3-v6mr8063706wrl.212.1538424833461;
 Mon, 01 Oct 2018 13:13:53 -0700 (PDT)
MIME-Version: 1.0
References: <20180929084038.an6pfhnsd6tblejl@pali> <404F3F76-402D-4E29-9957-429CB7D7ECFC@dilger.ca>
In-Reply-To: <404F3F76-402D-4E29-9957-429CB7D7ECFC@dilger.ca>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Mon, 1 Oct 2018 22:13:41 +0200
Message-ID: <CAFLxGvxfegQFh0kvk81VLhLh0AkgvpT=hWMDCJz5FmgoTUNRqA@mail.gmail.com>
Subject: Re: Future of dosfstools project (FAT)
To:     adilger@dilger.ca
Cc:     =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        util-linux@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        andy.shevchenko@gmail.com, Karel Zak <kzak@redhat.com>,
        aeb@debian.org, andreas.bombe@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 1, 2018 at 10:01 PM Andreas Dilger <adilger@dilger.ca> wrote:
> If the current dosfstools maintainer is non-responsive, you could always
> fork the project in GitHub, land the critical patches into your branch,
>  and make a release on your own.  If the maintainer surfaces again, then
> they can pull in your patches.  If not, then you are the new maintainer.

I also recommend talking to package maintainers of major distros.
Maybe one of them forked the project already and did what you plan to do.

In any case, let's try to avoid a drama like util-linux-ng was.

-- 
Thanks,
//richard
