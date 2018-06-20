Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FAFFC43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:37:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2C20846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 16:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tQlh2XcB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9A2C20846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754551AbeFTQh2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 12:37:28 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:44843 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754144AbeFTQh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 12:37:26 -0400
Received: by mail-lf0-f68.google.com with SMTP id p23-v6so243899lfh.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 09:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=nJcNDxCq3Jvbo07CQanbrW4MTWCXgui9hH4v0Tbg/Fw=;
        b=tQlh2XcBWO01eG0xpCrmn7sIPPg611xajwaT5Z3Em3VbjCfCit9OmSU06rWYNi/YcC
         dWG0uCE8kBMIkBd+dpo/ejuGU1/LwRwGf/HfX/U95M9DpiFVUOavlpM5dwQLFBqUvrwT
         P+ydtO4Iafhr+UEy8JA4/jzMESMtwhbDBaY+he3e0ckUBtVz/KcNbMZ3zPiuax3TlyEE
         CkLsyGxFgE1LJSldNponiPPl3AJx3yLs4ZC4Q/rsMUCgB6cZKoISRNwy9Kq3sJTT/QDN
         1yVMvZNq2GhxRjo2Wo/zrwDOAk6RLm11kCOevcvy568LcvuzD8KLg8HjpZfCpxDxiqah
         yuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=nJcNDxCq3Jvbo07CQanbrW4MTWCXgui9hH4v0Tbg/Fw=;
        b=alTJ3Nw/Zjs5oADmsxgchNmI4xVLGr4yUQMFrCTaWQJ5pklEnSPdITX/HEPvydsvw7
         DNu5bvQhKoUKLSflTOn5RdXMwRJcGJ7dDr3f9gNRKrtsP2gSsgsL3uL2Vw6rXWh1fyt9
         aDQHqSYdhXr+/fJ+H7Rwjhoyb9zITyPMRMY/Ixb2O2wNnnKBKQ7w41evaxOyYmj1XmFb
         ikvVI+1h33aHtwa65EB+xAAguAFeYmeIbVTP4Qhx6HNGNPFeFYoFx5T/7UIQiagrv7kQ
         e3GESCPKwpiJw0vIjYbUIIMBP7eIuij0/xPImVq9oNE97/NPLIRT4vhB34sAtERz6hMQ
         18cQ==
X-Gm-Message-State: APt69E3mBGqD8ap8TuXbb0HcuquVBEkqTDXlh4gllMPQxQ2wFDOuOR2M
        TSJHZj1ycxzxOzqHjzVf7yNFovBHPPgU5zTsBPI=
X-Google-Smtp-Source: ADUXVKLJJyImjTDmVsRQOuGwPvvFtS6XZZVSFiR+zI+8o4JTUILftyUqTrccThYH1Soz00RrGjxHOMkPuQCiGOQjtKc=
X-Received: by 2002:a2e:419:: with SMTP id 25-v6mr14346952lje.146.1529512645051;
 Wed, 20 Jun 2018 09:37:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:44ec:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 09:37:24
 -0700 (PDT)
In-Reply-To: <20180620121450.31724b69@gandalf.local.home>
References: <1529484440-20634-1-git-send-email-byungchul.park@lge.com>
 <20180620145058.GP3593@linux.vnet.ibm.com> <20180620114335.7a314642@gandalf.local.home>
 <20180620155658.GU3593@linux.vnet.ibm.com> <CANrsvRMW_LF1W3-OerHbXm1nqPBLGhQYP6ZsTMapGnfiT7-W3w@mail.gmail.com>
 <20180620121450.31724b69@gandalf.local.home>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Thu, 21 Jun 2018 01:37:24 +0900
Message-ID: <CANrsvRNJdP4z-5HD5sSC3xb972SHzFKViGdBaC0NGD2nxXrVXQ@mail.gmail.com>
Subject: Re: [RFC 1/2] rcu: Do prepare and cleanup idle depending on in_nmi()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Byungchul Park <byungchul.park@lge.com>,
        jiangshanlai@gmail.com, josh@joshtriplett.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        linux-kernel@vger.kernel.org, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 21, 2018 at 1:14 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Thu, 21 Jun 2018 01:11:36 +0900
> Byungchul Park <max.byungchul.park@gmail.com> wrote:
>
>> > Byungchul, is there any reason to make this change other than preparation
>> > for your second patch?
>>
>> Sorry again I didn't explain it fully in advance. The only reason is to
>> prepare for the 2nd. It was harder to read the patch when I made them
>> into one. But I can make them into one if you don't think so.
>
> Please keep them as separate patches. It's fine to say in one patch
> that it is needed for a following patch. Not exactly in those words
> though.
>
> Each patch should be a stand alone patch, such that a git blame comes
> to it, we don't need to go searching further to see why a change was
> made.
>
> What a change log should say is something like.
>
> "In order to do X, we need to do Y, because of Z" Where X is a
> description of what is to come, Y is a description of what the current
> commit is doing, and Z is the rational for that change.

Very good comment and tip. You're helping me remind a good way
to describe a change log.

From now on, I wanna try my best to write change logs in the form:

   "In order to do X, we need to do Y, because of Z"

I will. Thanks a lot, Steve.

>
> Thanks,
>
> -- Steve

-- 
Thanks,
Byungchul
