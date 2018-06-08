Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id GjCcH4U2Glv2cAAAmS7hNA
	; Fri, 08 Jun 2018 07:55:49 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 62E16607DC; Fri,  8 Jun 2018 07:55:49 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUC8tB+b"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id CAD14606FA;
	Fri,  8 Jun 2018 07:55:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CAD14606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbeFHHzq (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 03:55:46 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:32786 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752777AbeFHHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 03:55:45 -0400
Received: by mail-pl0-f66.google.com with SMTP id n10-v6so7827423plp.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 00:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QVzFZrRKb+uhDd7YhSdzOOvtZOCyeMAD8IHWwk27HX0=;
        b=mUC8tB+bAEtwCCXXduoBxGdhmr9vHfw9AwmeP2Q0JFPWhe1XX6OGS1c5FYGvFhH0BU
         zB4VpDOQ3MRnfeCjoslCvV2WN1YNWi/eAUUefoFk9tksg4IAlZon46krXKS43Cz0PwpL
         nMWnE18A4BJfC9Tcn7ZSEHkKVcRuccspWSUjisikdH+LVWBdBSCSGPOdvzjMAvJoILt2
         hfmlMV6EJiFovzOtxbRQdHGhkDsvdnfS3he+GFvYFkYRnnYm0FBc6jxzCElIEjABYn04
         jXEnMaZlKcxZQ7hOEa7poiAtpiHzKS43CizkdOfhIWadXltxCVklz75pjTZLyaqpvdNt
         fuNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QVzFZrRKb+uhDd7YhSdzOOvtZOCyeMAD8IHWwk27HX0=;
        b=D4oMaGBVoimTQWxjitLjDunxYXj+QoC32E8tFc8G2nJN/e4Z780zkmqVaZTBIvIN0a
         Ip0Nic2wzJcKQLIKMxCp6NsgbCeoQIBeqNJcHdwf77kCBL2Usulbc9H/+EYL+KzXBvER
         e7IHDl8WvgT5OEb/UY5veifhZcRdkRW2qpne+0wVDbdx0slcrwv1Fs/sgphy8on3gfDP
         BunGN6uR1xW7pH3ulN1g54Anxk7j+rfNbQZjOjFPar3eldMqBxOfX+QkZbZk9dOCtLej
         oIrsfHVN3kL9uZOHBf7Mj652AAPl0S5SZIYlSI33q7U7Z6tpPR8iF6d3ZGUUYxYo8GU1
         k+Hg==
X-Gm-Message-State: APt69E3YUZUJoxhj7hCXy5Tmy0YzgwqSQys2lBJ2JUjksCQE0yhtCEfO
        ip0kNoTvthnH7REBB3ZPVUQ=
X-Google-Smtp-Source: ADUXVKIOY4AJqK0lr4ECbxQnVKhz2M9PJueTHUGmQdcqnfkn/2VxPgHxGMpPStWQYaG39VljFtwVZA==
X-Received: by 2002:a17:902:6903:: with SMTP id j3-v6mr5503810plk.313.1528444545313;
        Fri, 08 Jun 2018 00:55:45 -0700 (PDT)
Received: from localhost ([175.223.35.248])
        by smtp.gmail.com with ESMTPSA id m83-v6sm46863291pfi.188.2018.06.08.00.55.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Jun 2018 00:55:44 -0700 (PDT)
Date: Fri, 8 Jun 2018 16:55:40 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+831ee52a258e90882b4d@syzkaller.appspotmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Subject: Re: possible deadlock in vprintk_emit
Message-ID: <20180608075540.GA636@jagdpanzerIV>
References: <000000000000d557e7056e1c7a01@google.com>
 <CACT4Y+aPPuC+VopRpfJj41TBiN5ke-gVdQCBvD5ohxsXmz=hbA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aPPuC+VopRpfJj41TBiN5ke-gVdQCBvD5ohxsXmz=hbA@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (06/08/18 09:50), Dmitry Vyukov wrote:
> > Hello,
> >
> > syzbot found the following crash on:
> >
> > HEAD commit:    1c8c5a9d38f6 Merge git://git.kernel.org/pub/scm/linux/kern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=131d4ddf800000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1acdf888c9d4e9
> > dashboard link: https://syzkaller.appspot.com/bug?extid=831ee52a258e90882b4d
> > compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> >
> > Unfortunately, I don't have any reproducer for this crash yet.
> >
> > IMPORTANT: if you fix the bug, please add the following tag to the commit:
> > Reported-by: syzbot+831ee52a258e90882b4d@syzkaller.appspotmail.com
> 
> 
> This is the same as that one, right?

Yes.

	-ss
