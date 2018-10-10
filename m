Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5FAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71E282086D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 13:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nanometrics.ca header.i=@nanometrics.ca header.b="Yz4/3Q4Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 71E282086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=nanometrics.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726791AbeJJVPP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:15:15 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:44338 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeJJVPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:15:15 -0400
Received: by mail-lj1-f195.google.com with SMTP id v6-v6so4952909ljc.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Oct 2018 06:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nanometrics.ca; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZJUBLsUUYGuCw2X3PsGelapzRpFyVfpY6Jx62WnqIE8=;
        b=Yz4/3Q4YPBRn+1tB3up2OkqdpfIlrDeDT933/ry2pXM2pkQsliKWEOtMQSIQKxvwem
         UXLZ/kugAt55Miflo3xL2An5oEsXo2fLafUoPqaHlrrg3+lrurbG//C1MW9OFZXBT3vQ
         YYJlI/mC7u5EEh371IZKrysh7MM71/L1BVSk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZJUBLsUUYGuCw2X3PsGelapzRpFyVfpY6Jx62WnqIE8=;
        b=GObfoLf3pezxEAbAbFfTZewajUGLfvibktdE20llBVcp6AL5YyyWLl5BsAmCQMIbfA
         YjIGPISsHLwV3Ds5CgcxBCoXAsjg1kGGEu0ZqookiglJOhwAyjCdhV4XY1FQUQOkjRhi
         JMnGaCAQ6FPCeOKuDGNGAUIHO5z7EvRkEAbZrPeGPOCxa35+JiTTwTLdGUi4exGhCvw0
         ihXMD0/qWje4+DETOPIkamgNSRqkX4jnurEyyyaQmoWKS0RJOMYf0rtJECIsXyOQx6XT
         GUSIAUCYV/Ai+CWTtRxfqfRZAE6dt6+lzBzOQLR/+CYg8BIjCvbuMX69kHlAYVsbqkRW
         +cKQ==
X-Gm-Message-State: ABuFfogJmrCBmZzKVzgRNQeN85MiRwOsiXLQnHqiiRxJxFqNEI0H8hFD
        /B3BahXQ+8iFnudg2e4BHGA4FALPRwY8m496O8WhtkS+zSlM0xYYTSznhkXGt722U6bXEqauSgz
        Qt923blmpHozXrGsfNTkMIH9jQ1hVND2q
X-Google-Smtp-Source: ACcGV62sD5PR1Kun4eoH3Gzj2DbDiE4GnGaBeCZ1+fhUcNO1+Usaq1cnkBEG65OqRS+Lj5XVy0juqNlDiEap1vp1PjA=
X-Received: by 2002:a2e:3101:: with SMTP id x1-v6mr18441439ljx.83.1539179575461;
 Wed, 10 Oct 2018 06:52:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1539103468.git.jamesnuss@nanometrics.ca>
 <e2b6431104a6a822840d4e7b984d7aa23048a0af.1539103468.git.jamesnuss@nanometrics.ca>
 <SN6PR04MB4925CB991DADD39F28A31D13FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
In-Reply-To: <SN6PR04MB4925CB991DADD39F28A31D13FCE00@SN6PR04MB4925.namprd04.prod.outlook.com>
From:   James Nuss <jamesnuss@nanometrics.ca>
Date:   Wed, 10 Oct 2018 09:52:44 -0400
Message-ID: <CALgcdhhqvn3YWvQjtFfo46wH1N29-4vThNDzN1B2AROLY-kovw@mail.gmail.com>
Subject: Re: [PATCH 2/7] mmc-utils: treat FIRMWARE_VERSION as binary field
 instead of string
To:     Avri.Altman@wdc.com
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 4:43 AM Avri Altman <Avri.Altman@wdc.com> wrote:
>
>
> > +++ b/mmc_cmds.c
> > @@ -1758,8 +1758,15 @@ int do_read_extcsd(int nargs, char **argv)
> >       }
> >
> >       if (ext_csd_rev >= 7) {
> > -             printf("eMMC Firmware Version: %s\n",
> > -                     (char*)&ext_csd[EXT_CSD_FIRMWARE_VERSION]);
> > +             printf("Firmware Version:
> > 0x%02x%02x%02x%02x%02x%02x%02x%02x\n",
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_7],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_6],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_5],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_4],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_3],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_2],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_1],
> > +                     ext_csd[EXT_CSD_FIRMWARE_VERSION_0]);
> ExtCSD[261:254] is an ASCII string, just add a terminating null.

Unfortunately I found two different manufacturers which put
non-printable characters in this 8-byte field. So I don't think it can
be treated as ASCII in all cases. Printing out the hex value seemed
liked the most comprehensive solution.

>
> Thanks,
> Avri
>


--

-- 
This message is intended exclusively for the individual or entity to which 
it is addressed. This communication may contain information that is 
proprietary, privileged, confidential or otherwise legally exempt from 
disclosure. If you are not the named addressee, or have been inadvertently 
and erroneously referenced in the address line, you are not authorized to 
read, print, retain, copy or disseminate this message or any part of it. If 
you have received this message in error, please notify the sender 
immediately by e-mail and delete all copies of the message.
