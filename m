Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D0AC3279B
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:15:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A91DE22434
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 02:15:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="gY9aTb5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A91DE22434
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753770AbeGCCPq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Jul 2018 22:15:46 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:42381 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753495AbeGCCPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jul 2018 22:15:45 -0400
Received: by mail-io0-f196.google.com with SMTP id r24-v6so322258ioh.9
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jul 2018 19:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q9RTHi6ExQjHfzU7Cdf+oZdHMWCPSxw+aCVq7MAHLso=;
        b=gY9aTb5UlLe/NiP8Q+iVYdqf8U9UPWC+GF2yt9uthx/i+hBYYpugk4PH+YYuQ8a5vm
         pKpiN8tu3pVovYCItzBVK7kwIhrCFiTmeOCelrjYj4GTU2nIROnUsL5KB/LCs9rMkYIH
         V5wijHwx/xMLhjC6InQGVSJpjOJcTceVAJvnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q9RTHi6ExQjHfzU7Cdf+oZdHMWCPSxw+aCVq7MAHLso=;
        b=iW/bUNgT3VtMcmyreePRLdfX6EcfjjI4KtPlQRsJ4dO296o5h246sCLojaBpslBKXl
         B02uPJC0AJrj668koTf7YH40NaMjAoJpiGQwB+emHgDXdzYJVx00zq2w1CFfJg5fhYTm
         9biKtWXCdx73Mw/ycEE6mPjhBraOvbTE+UYz+h0xWzuYcJaI2/KqLIWEZHfqbxyqbYRw
         v5ih0SHpSb/k+C/UqkIecGG66wxN0aTdqRriKntyMjEjHDe3tSSf6acsKUbEbPFim2Le
         iu8VuAmtCi8iOZe3zFZb2hgF3rjPQwH6er65UyP1jNt/Zku0jNT2O9VG5igjq2dAW047
         XOgg==
X-Gm-Message-State: APt69E24sN313lIt1JxWtIs7K4RxOm3pogyszeaL4xeYFIopJ6j2pzV4
        jL2XfXWDB2nvFes6ZCsuO4rJF+FzGBgpAReqf4w=
X-Google-Smtp-Source: AAOMgpf1vBJH6btcrqqb0vpiOWM+jMDFSktWmN4lgBqdsQMi76kxrWe7PLuhGPZ1054vAWD6rx/2S/69yTYnevxLc0A=
X-Received: by 2002:a6b:980e:: with SMTP id a14-v6mr18727894ioe.238.1530584144544;
 Mon, 02 Jul 2018 19:15:44 -0700 (PDT)
MIME-Version: 1.0
References: <c40fe912fe008b1b531a3867e8784ed79d68023e.camel@kernel.crashing.org>
 <CA+55aFxR0qg0yY-NWnH0DDruVWw8qRqp8=CRLq13p=TyxosJKw@mail.gmail.com>
 <edc7b03b9550ddcf1291ebf5a6dafd24f4455c23.camel@kernel.crashing.org>
 <CA+55aFxS7OVEN5XrxceC5ibz780mhn-qRa50w1gVFjsz2JjMbw@mail.gmail.com>
 <7eb06b499f2be366cf68c6b6588b16c603e6a567.camel@kernel.crashing.org>
 <CA+55aFyS1bdmETHUYEejecOcG5MAjGCAbkr-M5iphJYfrj2oLA@mail.gmail.com>
 <675c0752ea41c9dc52c2a4b69f09fb9746207de3.camel@kernel.crashing.org>
 <CA+55aFxqUyACDPBL4trTfGyJudg8P7YGazVGUW7-UaNFJiwZRQ@mail.gmail.com>
 <36fb9c9f873629abb7bf3758033cce00e463f768.camel@kernel.crashing.org>
 <CA+55aFzUhe7j+6XL_BB+gvSnCvMCOePZhanTBk5tq=zqvFFWSw@mail.gmail.com>
 <d56f1c255f7caa913ad77a174e1e3bde08043ac0.camel@kernel.crashing.org>
 <0dc3c0632b1821bd07abdf0224ccd9f32a4f250d.camel@kernel.crashing.org>
 <CA+55aFyzYXSTTuVoGfVeC574-7i0zp3q39RTsiPn3GoRceuwAQ@mail.gmail.com> <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
In-Reply-To: <213dd8fa77629e04277e68552068581da881e7e4.camel@kernel.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 2 Jul 2018 19:15:33 -0700
Message-ID: <CA+55aFy927VYjFDwe9Zy_M+XFNxSFh2HLFcQ25pm8AMNXBUoQA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drivers: core: Remove glue dirs from sysfs earlier
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Joel Stanley <joel@jms.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 2, 2018 at 5:57 PM Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> I'll have a look see if I can find a way to check that the sysfs dir is
> empty without adding that childcount, that would at least alleviate
> some of your objection, and would probably make the patch
> smaller/simpler.

That would definitely make me happier.

Right now we already remove the actual device node sysfs associations
synchronously with "kobject_del()" (even if it still then stays around
as a kobject), and that does the remove for the object itself - just
not the glue directory.

If we then just did a "if glue dir is empty, delete the glue dir too"
in cleanup_glue_dir(), at least ther patch would be prettier.

I *think* that should be easy. Maybe. Something almost, but not quite,
entirely unlike the below UNTESTED hack?

It's whitespace-damaged on purpose. It's probably broken shit. DO NOT
USE UNDER ANY CIRCUMSTANCES.  Think of it more as a "something like
this might work, but probably doesn't". Maybe it gives you an idea,
although that idea might be "Linus has finally lost it".

I suspect it's broken because kernfs has this notion of inactive
nodes, so just testing for the rbtree being empty is probably wrong. I
think maybe it needs to test for there not being any active nodes, but
then you'd need the kernfs_mutex etc, so that would make things much
worse.

I really haven't touched the kernfs code much, thus the "this may be
complete and utter garbage" warning.

Adding Tejun to the participants, he should know. Or Greg, who has
been silent, presumably because he's still getting over his crazy
travels.

                Linus

---

    --- a/drivers/base/core.c
   +++ b/drivers/base/core.c
   @@ -1585,6 +1585,12 @@ static inline struct kobject
*get_glue_dir(struct device *dev)
        return dev->kobj.parent;
    }

   +static inline bool has_children(struct kobject *dir)
   +{
   +    struct kernfs_node *kn = dir->sd;
   +    return kn && kn->dir.children.rb_node;
   +}
   +
    /*
     * make sure cleaning up dir as the last step, we need to make
     * sure .release handler of kobject is run with holding the
   @@ -1597,6 +1603,10 @@ static void cleanup_glue_dir(struct device
*dev, struct kobject *glue_dir)
                return;

        mutex_lock(&gdp_mutex);
   -    kobject_put(glue_dir);
   +    if (has_children(glue_dir))
   +            kobject_put(glue_dir);
   +    else
   +            kobject_del(glue_dir);
        mutex_unlock(&gdp_mutex);
    }
