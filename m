Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0392EC6778C
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:46:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B062F27BD4
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 18:45:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL9f/JTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B062F27BD4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936499AbeF2Sp6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 14:45:58 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33278 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936395AbeF2Spt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 14:45:49 -0400
Received: by mail-qt0-f195.google.com with SMTP id l10-v6so8735710qtj.0;
        Fri, 29 Jun 2018 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ip9LIWen+iCG3pcA8RMplWbY2p3LQq1Q66yY2FCOEIA=;
        b=YL9f/JTtissbMjUk8orLZq188Jkjh7iuLA79WtbzzXC56wocGJPpt8sBn06QRqOiAo
         AthowcWa+0mbE0qTdRQPnoGs9X6xFAFAoYtvs4c78UbCqmsjcQdJW3JDFqYJ7N6NcvRg
         Ly1dCqipWdMpfIpDawJBZ2nqdfCOH6NjU+THi1pCDC0YbPGk+Q0qFGvdghn9gmnLzXy3
         4iD6wFpx8xXNW6NxYSskAGIdD0O3ORRWZP0KrTSwG8+T3jSWWvFwxk1AmD2bA/FUCWy9
         isXWx4fv+4RCQSvCbvDEeSbQ4ulJC9i6qC1Uk86G1HmfQoy6ND/EcLdINKFS0TmeoPRP
         2yXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ip9LIWen+iCG3pcA8RMplWbY2p3LQq1Q66yY2FCOEIA=;
        b=DKuh4/ZhtcDT0lGIFeoAOp4dhRtrfnDeodC7lnli/6cg7MwnnJ23oBGDMfGX730cIl
         7+7TEWgh2GFN7SyiBMf6I+3LOkUsc7agGjmvlgZ7tUjDIu0GW7lpIM1TtcE9s/dIO8nB
         lv5Jf5WwONS4sKiM/LKlmE7FJaNr73/1hqwypJtGG6k65ZG2t4HrAtzy2omT9FgQUQ5f
         6GxzH4fF0FhtBLoDXOExAZOsTb++aQTQiDrbPbZCx32Ff9sClLRaGHuPazsXRN4gsk9V
         uu6JAlEnZODFS0BHpVy7fk8qMJkhYdRevCGmkyuR/RfH0LhHxkCvYbVkmya4vNnHTxzn
         KBNQ==
X-Gm-Message-State: APt69E3cJ4eEoEkAtYuBVlVJgwU2pshNYj84Pm3ALAD8Y86TzwhIwj+X
        jO+N+3CQBeIZyTlZMLFw5Qs=
X-Google-Smtp-Source: AAOMgpeCx+T0A9XZgC/wSwjjgS0fd7d585flUbENKpbK2iAxSryRUdNUhIy0nJlXYBfeiv+4h+ZBhQ==
X-Received: by 2002:ac8:38ac:: with SMTP id f41-v6mr14768792qtc.190.1530297948241;
        Fri, 29 Jun 2018 11:45:48 -0700 (PDT)
Received: from eaf ([181.47.179.0])
        by smtp.gmail.com with ESMTPSA id n21-v6sm8824477qkl.34.2018.06.29.11.45.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 29 Jun 2018 11:45:47 -0700 (PDT)
Date:   Fri, 29 Jun 2018 15:45:43 -0300
From:   Ernesto =?utf-8?Q?A=2E_Fern=C3=A1ndez?= 
        <ernesto.mnd.fernandez@gmail.com>
To:     Anatoly Trosinenko <anatoly.trosinenko@gmail.com>
Cc:     pavel@ucw.cz, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Subject: Re: Mounting corrupted HFS+ causes kernel NULL pointer dereference
Message-ID: <20180629184542.jwxhruxgp5xv2abt@eaf>
References: <CAE5jQCfP1Z0oTBz_V0QkFwFqtJgekUMD2HZR=qA2oWxPvZrzsQ@mail.gmail.com>
 <20180603184955.zrowxp4y3ij66y5n@eaf>
 <20180608152557.GB11958@amd>
 <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE5jQCeCOK5zoH4KbyP+hiMKp4MpkjJN1efzquoXCfPPXoj9Nw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again:

A patch for your original report has already been added to the -mm tree.

On Tue, Jun 12, 2018 at 09:43:26PM +0300, Anatoly Trosinenko wrote:
> Now, when mounting the attached hfsplus_16mb_segv to /mnt and
> performing `dd if=/dev/zero of=/mnt/xyz bs=567879 count=1` I get
> 
> [    1.646451] BUG: unable to handle kernel NULL pointer dereference
> at 0000000000000043

I just sent you a patch for this second report. It's really simple, so
it would be great if you could take a look at it and review it yourself.
Otherwise it's not very likely to get picked up.

Thanks,
Ernest
