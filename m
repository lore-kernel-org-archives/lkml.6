Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C4BECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:09:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB27F208E4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o8OkNCHa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB27F208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727323AbeJRFGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 01:06:50 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:44387 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbeJRFGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 01:06:50 -0400
Received: by mail-oi1-f194.google.com with SMTP id u74-v6so22264384oia.11
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxgrTIhoN/DAtGA/IJl1rvpfp4eQj0tJuWjkVpM6oys=;
        b=o8OkNCHatoCd6tGdlumTHzLyE/1mwEmCnin0sUrJVhzePu8neQim1uv1G7T4HaYm7V
         4a+3t59lIPUlEYPhQRAudqz7Zo2OWFNdUi8snHNQfGaUptuXNOegBH2SfS3QOrpDJb5A
         PS0KphUEe0fnVGbIr6EOwivnJzpF+JthyMwWSNHFbTXIb13SWNOpm7THWmMC/YkGxoGk
         DYoXQ/XJ7jWZR3MKxNVE9V6lcE0I6F9RFtBC/pWpPlXc8PFfJbTjNr+p907xGSOqEwyc
         18V4fig3tEuxh7B/ONTAeZKs+CiBRX9iA4fI2gh9kWUws/MuZtKo1pl2A5RtCbI3LaZ+
         zQ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxgrTIhoN/DAtGA/IJl1rvpfp4eQj0tJuWjkVpM6oys=;
        b=UJH2/xO5Y/efHh3kizqPtq0XCj6a12lZTTOe1zmCE7LS+jDa2CmUozJO1Mn6E2rAGA
         qnoHa6tRKAbb9WV5R25/98xkPIjppePhubmZ8iogM86CoIbVzWZ6Px1U94cTJkCbD6Km
         jXJymn20e4lRVPFkPndazc380mrIukqyuGcRbve4PVCh7JI6MBZGOV6EmLdt6T5VjByD
         eM8Q4LlUbmc9K9XAn2VpU01aSD8VDaepAJs89hY7StryZ0KKuM+4hmerNqZlPxYDJjKO
         wTDkBs2+2pzg7ZyZxAVeVY8h6cCQQIx0S5E6aHBa2y7rPgFgO/Ul4dumuCiODgn2Cs6j
         7XHg==
X-Gm-Message-State: ABuFfoihpqy7bQGIUIlTxo3CpmObu2WBjQqxx0clRElMExP+3DTA0Acb
        8oHr7LWjkRvzXtvPZjY/GDqupXeA9QNlLroTZ3IW9w==
X-Google-Smtp-Source: ACcGV61d3e3Mc9Qmis+PgC2e0uvbDQzQQaQZI+9zZGyc2tNO+6cbpaEA/MClaTERe8fj1XOgUWUrPO3RFJKS4p4Hmck=
X-Received: by 2002:a54:4e8d:: with SMTP id c13-v6mr14122139oiy.238.1539810558456;
 Wed, 17 Oct 2018 14:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
 <20181016235120.138227-7-brendanhiggins@google.com> <f0d64a0a-7914-f390-c0b5-dc7626b45476@ideasonboard.com>
 <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
In-Reply-To: <ECADFF3FD767C149AD96A924E7EA6EAF8052436B@USCULXMSG01.am.sony.com>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Wed, 17 Oct 2018 14:09:06 -0700
Message-ID: <CAFd5g45owvjnVh633_kqf9DKeWQDYdGNi9j1crNZC3k02r=v1A@mail.gmail.com>
Subject: Re: [RFC v1 06/31] arch: um: enabled running kunit from User Mode Linux
To:     Tim.Bird@sony.com
Cc:     kieran.bingham@ideasonboard.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@google.com>, mcgrof@kernel.org,
        shuah@kernel.org, Joel Stanley <joel@jms.id.au>,
        mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, khilman@baylibre.com,
        Julia Lawall <julia.lawall@lip6.fr>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 17, 2018 at 10:52 AM <Tim.Bird@sony.com> wrote:
> >
> > It might be of interest to the automated testing mailing list too ? (Tim?)
>
>  I think this is interesting to groups doing automated testing of the kernel
> (including myself) as another set of tests to run.  Right now I don't see it
> as having any special attributes related to automation.  But I could be wrong.

Pardon my ignorance, but by automated testing you mean a CI server
with presubmits, nightlys, and things of the sort?

If that's the case, KUnit could be helpful because of the low resource
cost in running them and the speed at which they run. There are some
other features we would like to add which would help with that goal as
well like test isolation. We actually have a presubmit server
internally for running KUnit tests that can usually respond to patches
with test results within a couple minutes. Would something like that
be interesting?
