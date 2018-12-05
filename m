Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A78C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A0D020989
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 22:00:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SDihTQvP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0D020989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeLEWAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 17:00:03 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38122 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727645AbeLEWAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 17:00:01 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so19799978lja.5;
        Wed, 05 Dec 2018 14:00:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvSqIZG2hS7I0DwrWLiAlEABoq1NNUqRbuoAqz+L9Tk=;
        b=SDihTQvPt945kmcS4H25DOJhUMsj9LlA9rx/wfrXJhFkk8c3Q5J/yS8FUecAz8z2WH
         K+3wbCZy6onZSmsEQWjNVb84hc49eMIHsrkb7OQU8/7X0CrotPn/PbGvqU2D16RnYU2J
         15aBfOj6CxBrKHN4M92p/6IiT+fZkzkqlREGyyHyhkgPIXx8kbNaVVislaq5qGRejAgl
         5Bo2DgyW/ETF+SV/gVNd/t3ARGx7VmFvk4IVnl3D36RXERxbUmWTksu4uK0qJFTD2V7x
         DIAyVDaZ+wA23cxHkTwqkq9/rBWRy1GYIIWr2KiJF1lnrO1w9/Vbko5h/rTjkF9vQsj+
         mYzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvSqIZG2hS7I0DwrWLiAlEABoq1NNUqRbuoAqz+L9Tk=;
        b=t9mcJqVY4Iq2yYpDtiHsj2iw9aAeEeLV5EIK881yRNCwbHWDZUtEfjjmAkWKlMsmj2
         ZWbOofK+QF4nk35w4MhMX4jJnfl+hQ2DHlhdXgcKS9zh5NV5Ta0kXsRLj32bUB4TZWcb
         ufSSN6fQyqZ97xlK3vox+fpXXsmOF1qWD8n4ScinIyTdKERsNMuXl6pfuxgjv9W57gBd
         DC8QaeE2B3/MtxCrmIQKgVk2F6LXNkjxErmCvji1yZRYq9v9aLVaW/hhnIDE8svPgrvw
         wZ5mMbhInEbznf4XoGVV2gSw81hayRSYFlamZ2wRax/Hdy8omzo0zp89oIEArB+p6d4s
         TU2g==
X-Gm-Message-State: AA+aEWY8DBx12pbMEpTmQyzPNMZsHU4Mc7yYtIS2Y5MGUAnXHbryk2us
        4+UmoGXbBleTewB+TI1vfL3pOp8ouix2pm6vOad5Nlob
X-Google-Smtp-Source: AFSGD/XacwTJRmyN07XVWlsHlGDNUw7+gitlJt2znnLpS2IfHtrLjN5BHsV9YapSVf4mHT5uEzzQsGZLGO8C/VZKLzQ=
X-Received: by 2002:a2e:744:: with SMTP id i4-v6mr14970705ljd.140.1544047199257;
 Wed, 05 Dec 2018 13:59:59 -0800 (PST)
MIME-Version: 1.0
References: <CAChUvXNO_8Frw1igaEAHSxmdtTy7MJVm8W1NpUqZ6tFD0hXwhA@mail.gmail.com>
 <0BF2A47F-7F33-4E4D-A566-23AF2F4CCD52@theinkpens.com> <CAChUvXMVHxhawLFPFzz_0+iFxjQ+dRwpTsCGo95oc8Y+7a-2DQ@mail.gmail.com>
 <AM0PR04MB3971FBCF6CB23BE778D39EED9AD80@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXPCfwfHrntJHWpsydYZE=P692Axd0pFE+GjZCXtx1fgog@mail.gmail.com>
 <CAChUvXMWZ-LYyqnczM-bt9cDP0r1XT+F1dcYuRHiVcx=QR7_Jw@mail.gmail.com>
 <AM0PR04MB3971768EA5D50D7045B462619AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXN8rZqxBaV2qbdR8uymsmZAk_Jnc2kxSUf+kBf76QHV9A@mail.gmail.com>
 <AM0PR04MB3971FFCCDAF29E7DF0F0EE159AD10@AM0PR04MB3971.eurprd04.prod.outlook.com>
 <CAChUvXNz=XR37EeVRJFnF195BGgjPgCeFv6nbjR3yV2_mQwxBQ@mail.gmail.com>
 <20181128234415.GH16830@zn.tnic> <CAChUvXPgntzMbAhcg8y2HJyyZWwaqNPe66efmpfyHLgN1JSW_w@mail.gmail.com>
 <AM0PR04MB3971D326D037CFB2497B1A559AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
In-Reply-To: <AM0PR04MB3971D326D037CFB2497B1A559AA80@AM0PR04MB3971.eurprd04.prod.outlook.com>
From:   Tracy Smith <tlsmith3777@gmail.com>
Date:   Wed, 5 Dec 2018 15:59:46 -0600
Message-ID: <CAChUvXNxcpHDOn1Rkxwp8VbuN5-k08JfrgwdbN95uvMWVh1Rwg@mail.gmail.com>
Subject: Patrol scrub questions
To:     york.sun@nxp.com
Cc:     bp@alien8.de, linux-edac@vger.kernel.org,
        util-linux@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Single-bit errors are corrected by memory controller without involving software.

Sorry for being verbose, but I need to explain the reason for the
questions below since I need to determine if a memory scrub is
required on layerscape and why.  There are multiple layers to the
problem of ECC.

First layer, there is the immediate 'correction' of a flipped bit.

This does not 'fix' the source of the error but corrects the flipped
bit for use by the processor.

Most bit flips will be due to either a transitory noise problem on the
bus, which will not be associated with any given memory cell, OR it
will be due to a cosmic-ray induced bit flip in the memory cell which
will stay 'flipped' until the location has been written to again.

The safe action is to write the ECC corrected data back to the same
'error' location in memory. Does the layerscape memory controller
without software intervention do this?

Question 1) Does the layerscape memory controller automatically
perform a write of the corrected data back to the 'error' location to
make a correction?  If not, is a patrol scrub required to do this?

Second layer, there is the risk of a double bit flip in memory.

Statistically this is very rare, but the odds significantly increase
that a double bit flip will occur in a single word when a single bit
flip goes uncorrected, giving more time for another cosmic ray induced
bit flip to occur in that word.

The layerscape memory controller can only detect a bit-flip when a
given location is read, correct?  This is different from normal DRAM
refresh routines.

If a location is not normally read, it can go 'unserviced'
indefinitely, allowing multiple bit flips to accumulate.

By periodically (once a day should be more than sufficient overkill)
reading each location in the DRAM and writing that same (automatically
ECC corrected if correction was needed) value back into the DRAM, we
drastically reduce the potential for an uncorrectable multiple bit
error to accumulate in any given word in memory.

Question 2) Again this would require the EDAC layerscape driver to do
a control scrub, correct?  If not, how is this handled by the memory
controller to avoid the need for a patrol scrub?

Third layer, there is how the memory controller handles UE errors. My
understanding is that the layerscape memory controller, can detect if
it is a single bit (correctable) error or a multi-bit error that is
not correctable. Is this the case?

An uncorrectable error in the data or the software will have
consequences ranging from negligible to critical.  From a hardware
standpoint it can't tell if it is critical so it must assume it is.

Question 3) Because the memory controller or layerscape platform must
assume a UE is critical, will a single UE on layersape cause a WDT to
be triggered and a reset to occur?

Question 4) If so, will a panic ever be called if there is a hardware
uncorrectable memory failure?
