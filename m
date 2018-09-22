Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA3ECE560
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:38:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AED12150E
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 23:38:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RP8dllz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AED12150E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbeIWFdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 01:33:38 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41500 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbeIWFdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 01:33:38 -0400
Received: by mail-lj1-f195.google.com with SMTP id y17-v6so15150125ljy.8
        for <linux-kernel@vger.kernel.org>; Sat, 22 Sep 2018 16:38:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t4vsmcrWT914V8JL5+69GqM4sSIsQ2EBYEbRFEjx/8I=;
        b=RP8dllz44cqDoJpKJ8wcwuRwtQS9mTyHuzgB0SXdtdgsiGtVCRjgDjs+kJonZJtqK7
         rZOEDa0QB4cLq9eT20hiKeaEdd5KAph1nWUKNAGIjEIRcysGvMse77OOtrhfqXh8q4m7
         TsI1etAfzPqVHwKoBgj1esgSY+nN2DpqfskU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t4vsmcrWT914V8JL5+69GqM4sSIsQ2EBYEbRFEjx/8I=;
        b=QJu7yTZ1yRWcB/nBNkyN67I4sGam0472g3bBjVFtORDlEmSdX2NeO2t9BJHoNborvi
         IPAP5IyGmfDinTzrANZp2nJbQaf9lZTF1ofGpWdZl++Fqg8XcWE1ga8TdfhyqwzBENqL
         +ygN2PfZPcEhaYkgD8F+T/FitJIQZyvB52b7y9+z2sRcTrsrQn6hELMf4DdUwjWJlSuI
         AZ9xv0HfVxZP/mWP+zaQeg/MwKWZ0ywZVxOwRx/kqUhkgG7w3FvL+J8q1bnqu6JGu4mn
         VX4gzs4g/eI1IX0CDK/z3YgaAloa+uvSvqmVax2AG5ZJMb8SZlq+ASLtN0k2Pk7i3Rw9
         Xbrw==
X-Gm-Message-State: ABuFfojLBnhcTa+w6xGJsHrNAwgtuI9Ip5v9AwjTVjaGvsAXPwlwQFoM
        /9A9pNHQbWl7xAJc11vrRNnC9u0BsLuLYMeRqKaeEg==
X-Google-Smtp-Source: ACcGV63uH2ajeHZ4Xguu3ovKQkh/zNcAprJnMoniW7rwdqenX03WMnLtyWuGwohuxnm5CeEIgsl750Qc8cdaZls+04o=
X-Received: by 2002:a2e:901a:: with SMTP id h26-v6mr445800ljg.121.1537659496988;
 Sat, 22 Sep 2018 16:38:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180921223153.114728-1-joel@joelfernandes.org>
 <20180922011428.GU4222@linux.ibm.com> <CAEXW_YTgSFr5r3Qkr0+0_wxKGQV1KKP_8X8uQKAnHmhvem8XtA@mail.gmail.com>
 <20180922134616.GX4222@linux.ibm.com>
In-Reply-To: <20180922134616.GX4222@linux.ibm.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Sat, 22 Sep 2018 19:38:05 -0400
Message-ID: <CAEXW_YRaLjRWH9BYV_r8e4pCuBEGCzMSRdS6x7Qozc8HKoej=w@mail.gmail.com>
Subject: Re: [PATCH RFC] Documentation: RCU: Clarify comment about fanout
To:     paulmck@linux.ibm.com
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Triplett <josh@joshtriplett.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-doc@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 22, 2018 at 9:46 AM Paul E. McKenney <paulmck@linux.ibm.com> wrote:
[...]
> > I have a few more as well, I'll send them out soon.
>
> I do have on my list to update this document based on the changes in
> -rcu, which among other things eliminate the rcu_dynticks structure
> and  make it so there is only one rcu_state structure in a given
> running system.
>
> If you are crazy enough to want to make the corresponding changes,
> I would welcome the patches (and would be happy to help with editing,
> grammar, and soforth.  The potential advantage to you is familiarlzation
> with the new version of the code.
>
> This is not a small amount of work, so please give it some thought
> before saying "yes".  (In contrast, I would of course understand and
> respect an immediate "no".)

I thought about this and I'd be happy to do it as long as you don't
mind me asking questions about parts I don't understand (which
shouldn't be a problem from my past experience ;-)). I am spending
time understanding the code anyway so I'd rather update the main
documentation than my own notes for the benefit of everyone ;-) As you
said, it'll help familiarization of the code. Btw I got rid of those
extra rcu_state externs too, I'll send that patch out today and
continue working on things next week...

Thanks!

 - Joel
