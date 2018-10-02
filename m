Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A921C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D2092064E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 08:35:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jJQ7gA5U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D2092064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727569AbeJBPRI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 11:17:08 -0400
Received: from mail-wm1-f49.google.com ([209.85.128.49]:54831 "EHLO
        mail-wm1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727343AbeJBPRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 11:17:08 -0400
Received: by mail-wm1-f49.google.com with SMTP id r63-v6so1320690wma.4;
        Tue, 02 Oct 2018 01:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8ODF5/urQnJO9t7LqbbHFgfbHbVIchNIA/BmFAhuY+8=;
        b=jJQ7gA5UvwbyD/mvEnSZwaEI+KiSbJHtTIMTpUjAFji63QPC0mV7p5+nmSHGgJEByP
         LdCsnmTYt8RE54tWoQirWgz+aqqqkpIs0ehIU/6/LdXOuqjcegBjOr+ilUm6dowhVOyN
         r6ZLu9aveWow38XQxW7mbTrVvhNnJaZ7KRbo4KrkhonBbO+HLfXv2BYqoRk6f3Qk/1ZB
         CWsHXFs5Rf7jd7hbznER6v8MBaoJNVwOj6i1esfzG6llSU0U4/J80djH6XYXpmN4ECD6
         U3ZjzpBX8Tc3uFBnz3oFxUjUtwPFSSZHfEwMPJna8XOLVvnNOsbWS25rv5mUKYey/WUc
         Wd6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=8ODF5/urQnJO9t7LqbbHFgfbHbVIchNIA/BmFAhuY+8=;
        b=hP6HRkqrKeAgajqW/VZlqZROnhZkmILwmTkJz32vBpu3cNtdq4RkGBaYIZtMUAqDga
         AfWIw/iL3NaPH3rPJxx41P1wHoI+Q5DIEbhbEWscfpEH4vM4ttFZ4YQ3VJPMFjUd+4ZD
         QB7xq6GSZ1oZj1pVoDZU8wnMI+jaBuFw7AYQSUMo6mcq0SStPNy1xx4QVjbMvUI+FYcT
         uSTEt8Zn+cd/FmlWfH+B6k+uXsERRFaSasWPwtlJ9KDTAvFIIZUwHB3z0jwJ4jZsA+us
         Tru5RMzQlZtmkHW2d2vR+DjWqyQ13lkKcp3vDErNR0h0mFJqH9igPz6hsrBv0C9Lo2x2
         32HQ==
X-Gm-Message-State: ABuFfoiXp8D/1oyu+yQUQppNRUjwa6rwlK1ZOWW+lPuWeyCUGy9lL9G+
        YDG/Mp9F6j7nAVUbuAz39PEmcJiG
X-Google-Smtp-Source: ACcGV62ig0OoXika6UducLbA0dsxU+pu5P9pWSNHSwzRBRrzFZlzptgXUhbnBhRgcCd/9R+In9TmWQ==
X-Received: by 2002:a1c:8f0e:: with SMTP id r14-v6mr1076552wmd.79.1538469299353;
        Tue, 02 Oct 2018 01:34:59 -0700 (PDT)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
        by smtp.gmail.com with ESMTPSA id t14-v6sm10122395wmi.35.2018.10.02.01.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 02 Oct 2018 01:34:58 -0700 (PDT)
Date:   Tue, 2 Oct 2018 10:34:56 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-efi@vger.kernel.org, Aaron Ma <aaron.ma@canonical.com>,
        Alistair Strachan <astrachan@google.com>,
        Ben Hutchings <ben@decadent.org.uk>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ivan Hu <ivan.hu@canonical.com>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        Peter Robinson <pbrobinson@redhat.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [GIT PULL 00/11] EFI updates for v4.20
Message-ID: <20181002083456.GB120270@gmail.com>
References: <20180927085039.8391-1-ard.biesheuvel@linaro.org>
 <7c25a402-0fc8-fe70-ac95-348a93f4fe69@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c25a402-0fc8-fe70-ac95-348a93f4fe69@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Marc Zyngier <marc.zyngier@arm.com> wrote:

> Hi all,
> 
> On 27/09/18 09:50, Ard Biesheuvel wrote:
> > Thomas, Ingo,
> > 
> > Please pull/cherry-pick the below. Note that the first three patches will
> > be depended upon by an irqchip series that Marc Zyngier has sent out last
> > week, and that targets the next release as well. So please advise how to
> > proceed with that: we could simply apply those patches first and use the
> > resulting commit in tip.git as a stable branch, I suppose, but I'll let
> > Marc chime in in case he has any other ideas.
> 
> A stable branch with these three patches would be great. The irqchip code
> will also end-up in tip, so it should all be quite easy to manage anyway.

Yeah - nevertheless, to keep it all separated nicely, I've created a new
topic tree for this: tip:efi/irqchip (2e3ac98133a3), with just these three
patches on top of latest -git.

That way it can then all be iterated separately.

Does this approach work for you?

Thanks,

	Ingo
