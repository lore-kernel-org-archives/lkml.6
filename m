Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273E5C43444
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2C1E206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 03:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfAND2X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 22:28:23 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37488 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbfAND2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 22:28:22 -0500
Received: by mail-io1-f66.google.com with SMTP id g8so16607890iok.4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jan 2019 19:28:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sc2ojNAdryMQgpkRfU7IeXwdIIrfg2jNPH4ut/Zpy4c=;
        b=rb/VPT1UdfxzDM6SxbUg6yeNF65EUvgfHb4tUfDmQzUomtHb5H1tywCDbQcRy95shz
         e8hYj8TBajhdb+01jGE48oJVNfIaHdk5CzT5SYw6y4H0Ckzy8ldF7RUj2FcDz+AS+5c8
         CELKV5EG4YvCEOS1Ae1PTPnPlRlzPHkVXJZVhU7Ol9kaUF1TpUAnumnNUi7l97Fcdujh
         zJDtU8pZyV4QiNQyF4Jl79Jdiub+ge8SfKGJBiqd9jucRptQeTUObZ2uZxp5+VYZxv2m
         5crope8B9ymV+algEbPFi6cDa5Aa/D97DYvw6cGUYnnXyO2NrC9bz/XT7MxsjdQo7uW9
         UFuA==
X-Gm-Message-State: AJcUukekU+ny2gP1BTrxtFNTzpXonpI1RfoLmwOMvp1vdpO53cP87FG1
        7fSJ/rmdX/MnKLt5TWpRN9ye7AmINPGdZz88K3KHdg==
X-Google-Smtp-Source: ALg8bN7ha3B6oNG8ZFkB7qT7OsrZ6JAACja7h3XxsBXio1JtpXjF31gxWtjS37++y6rjAkDqeSm8Zp017REz3I14QGs=
X-Received: by 2002:a5d:8889:: with SMTP id d9mr16280589ioo.68.1547436501917;
 Sun, 13 Jan 2019 19:28:21 -0800 (PST)
MIME-Version: 1.0
References: <20190109164824.19708-1-kasong@redhat.com> <20190109164824.19708-3-kasong@redhat.com>
 <20190111134303.GA12760@dhcp-128-65.nay.redhat.com> <1547223220.19931.471.camel@linux.ibm.com>
 <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20190113013958.GA14019@dhcp-128-65.nay.redhat.com>
From:   Kairui Song <kasong@redhat.com>
Date:   Mon, 14 Jan 2019 11:28:10 +0800
Message-ID: <CACPcB9caE8Go+MuayBe_Pzz+iHSRi0rr1-Yo1Qtbks=h5+fN1A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/2] kexec, KEYS: Make use of platform keyring for
 signature verify
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Dave Young <dyoung@redhat.com>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        jwboyer@fedoraproject.org, keyrings@vger.kernel.org,
        jmorris@namei.org, serge@hallyn.com, bauerman@linux.ibm.com,
        Eric Biggers <ebiggers@google.com>, nayna@linux.ibm.com,
        linux-integrity <linux-integrity@vger.kernel.org>,
        kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Mimi, Dave

I checked the previous patches:
https://www.spinics.net/lists/keyrings/msg03518.html
https://www.spinics.net/lists/keyrings/msg03517.html
https://www.spinics.net/lists/keyrings/msg03516.html

That the latest patched I could found that placed the platform keyring in certs/
However it didn't cc kexec list, and so I think Dave didn't receive them.

I could compose a patch to use the previous design, how do you think?


On Sun, Jan 13, 2019 at 9:40 AM Dave Young <dyoung@redhat.com> wrote:
>
> Hi,
>
> On 01/11/19 at 11:13am, Mimi Zohar wrote:
> > On Fri, 2019-01-11 at 21:43 +0800, Dave Young wrote:
> > [snip]
> >
> > > Personally I would like to see platform key separated from integrity.
> > > But for the kexec_file part I think it is good at least it works with
> > > this fix.
> > >
> > > Acked-by: Dave Young <dyoung@redhat.com>
> >
> > The original "platform" keyring patches that Nayna posted multiple
> > times were in the certs directory, but nobody commented/responded.  So
> > she reworked the patches, moving them to the integrity directory and
> > posted them (cc'ing the kexec mailing list).  It's a bit late to be
> > asking to move it, isn't it?
>
> Hmm, apologize for being late,  I did not get chance to have a look the
> old series.  Since we have the needs now, it should be still fine
>
> Maybe Kairui can check Nayna's old series, see if he can do something
> again?
>
> >
> > Mimi
> >
>
> Thanks
> Dave



--
Best Regards,
Kairui Song
