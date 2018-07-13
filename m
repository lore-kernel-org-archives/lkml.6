Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528AEECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F070920873
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 11:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvlVZyWz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F070920873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729667AbeGMLku (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 07:40:50 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41403 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727608AbeGMLku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 07:40:50 -0400
Received: by mail-ed1-f65.google.com with SMTP id s24-v6so8131011edr.8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 04:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DgihCiuBRyYUA8Fuahjb9brYp7p4SjC+XqLGv15b4qw=;
        b=UvlVZyWz/fDwGD4cIEK8PbhKIrFmjwFciVx7rrYbYjcDpwAuyBHuknArp4iIeuSCyq
         CCtxu2X50iS+QKD2nBjmqYglyCKkA8vUJIrwoalscIA9DXrK4tLCvdr8oTEx1smyuvgM
         oqUgLPfRoj+G8qsUIu6bxStm2z7+sIWHyV/DOqOqImNdMo1r0EA4Zk28aQP3vn8HuNDt
         18tH0lMHXyFADbfAs2Y7MqikWpVwQdT1+hKvSNpEzOwZ0uQW4VRpkdoz2lGQTRp1g/cj
         4uqqlptlctw9ILssNRIBDwA3JzZoJvd4x3cgIb7zZWlYMTnV+FpTPHs/6QdnNKbqyhG4
         KByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=DgihCiuBRyYUA8Fuahjb9brYp7p4SjC+XqLGv15b4qw=;
        b=AaK6rrqOj2XxreSBOH3Ki3jMiSLbEVwUId4Muqwdl/ZYHGu+wAUJl6SqvOg0pndhyE
         zmL//7u4s8Ndo47BlOY4O9cydVxm4ok7rVg0xmkTHDYFqFs90zAy05+tuOROqE1PVjdk
         +iqmPOFDx4uR0NXWZ0DAJqt/J6qqcgrAfiRGRPhdgs4XlQGoE0PfFl2kQsLor9ca3osl
         3M3o4rtD7Z5pbX3NgyZIhzcA2zNpKj3vJ8VbkOyoVgfGvjTpjgSyxUlTHx9qGEQiu0lQ
         1r4IKqEi8G7semD1j6H1iUH2NSfOyfuu/MchFBnMrLURjWSP4tejIy6jqVoOzWNuzspU
         MNmw==
X-Gm-Message-State: AOUpUlHsjN42bmlQpLKV8dsYkgas2g5guPCsL0kjbD4w9i4qnpgqGwxO
        NBXUcaf/ayWcz21Eb1D22Us=
X-Google-Smtp-Source: AAOMgpe0E/kZzZwJquvURQMKwrG348qv4KalbbtwEXuM3pZQri/bNY7u6yBJARiKUe0B+frvH3Z1hg==
X-Received: by 2002:a50:8b8c:: with SMTP id m12-v6mr6580909edm.165.1531481193605;
        Fri, 13 Jul 2018 04:26:33 -0700 (PDT)
Received: from xux707-tw ([109.78.208.2])
        by smtp.gmail.com with ESMTPSA id d15-v6sm488683edm.66.2018.07.13.04.26.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 13 Jul 2018 04:26:32 -0700 (PDT)
Date:   Fri, 13 Jul 2018 12:26:30 +0100
From:   John Whitmore <arigead@gmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Whitmore <johnfwhitmore@gmail.com>,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        kstewart@linuxfoundation.org, keescook@chromium.org,
        aastha.gupta4104@gmail.com, pombredanne@nexb.com,
        tglx@linutronix.de
Subject: Re: [PATCH 04/10] staging:rtl8192u: Rename file macro to avoid camel
 case - Coding Style
Message-ID: <20180713112628.GA656@xux707-tw>
References: <20180711192149.21621-1-johnfwhitmore@gmail.com>
 <20180711192149.21621-5-johnfwhitmore@gmail.com>
 <20180713093938.GA19286@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713093938.GA19286@kroah.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 11:39:38AM +0200, Greg KH wrote:
> On Wed, Jul 11, 2018 at 08:21:43PM +0100, John Whitmore wrote:
> > Simple rename of the preprosessor switch, protecting against multiple
> > inclusion of the header file. Change to clear the checkpatch coding style
> > issue.
> > 
> > Signed-off-by: John Whitmore <johnfwhitmore@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r8192U.h b/drivers/staging/rtl8192u/r8192U.h
> > index a653a51f7b90..86cf3ef3a970 100644
> > --- a/drivers/staging/rtl8192u/r8192U.h
> > +++ b/drivers/staging/rtl8192u/r8192U.h
> > @@ -15,8 +15,8 @@
> >   * project Authors.
> >   */
> >  
> > -#ifndef R819xU_H
> > -#define R819xU_H
> > +#ifndef R819U_H
> > +#define R819U_H
> 
> Shouldn't this be R8192U_H?
> 
> thanks,
> 
> greg k-h

Yes definately. I had another series of minor changes ready to go, so I just
tacked this change onto the end again.

jwhitmore
