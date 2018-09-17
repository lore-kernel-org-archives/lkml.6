Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29196ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:09:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C89832146D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 21:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eifXGtmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C89832146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbeIRCi4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:38:56 -0400
Received: from mail-ot1-f49.google.com ([209.85.210.49]:44348 "EHLO
        mail-ot1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728009AbeIRCi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:38:56 -0400
Received: by mail-ot1-f49.google.com with SMTP id 36-v6so12829697oth.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 14:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:references:subject:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=A/KwgUh38TcVZgacujmNwH6jwi/OXkMN/gaXA6fQb+E=;
        b=eifXGtmtIWYLay7R2pwvDR4HCU26nGwgZi6gYFSFwwEWTSI/ZW53+SMoPKLD97eCIf
         NTV9G1puHjNScxJ08TjWpTrhBzv+Quw2pjPIOMLdruokDH/UwiQheFIwJh7/gqdm498I
         wHv6qFWqr3ekKhJUhcQwAwy4Oove0A5siXc0yPRzrVw2X/vYat4CNFzu8l+eSZn+GKgQ
         WIx1ou/hwjOTPtNzwVOHe9zb1yJ8EeFWhttt0q8Eit6XqA6CUm0YcN2JV0T9DDDU9ikj
         kkaeMyZpbObdTMDkxy9dBfToqe+cj38yhhhkoFKFvXEjxp/7reWJ3m8rmwXrNKUbaVNh
         VjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:subject:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=A/KwgUh38TcVZgacujmNwH6jwi/OXkMN/gaXA6fQb+E=;
        b=Wzphbh58XYTH3xDA5XnTZ8H5/AeBZUrleBKiGGh6GQqxjcHUCyxxu1O9s7qprXLuk1
         3fOMJj8jJ9ge0MPXOm3KwTyd/4IwK1CdBxVWF1rRYM5Zrexfvp1LWLwFIxLOp276IrIN
         /3kjYE1s7rVrJVRspcnCvwRSPkNecpP47V1rq+8xPd7P+jY0Ow9QmhhCaS1NfR7qVXb7
         SVjJLFZ8fH9hzm++fr6+R3F1WgmCKNCzFCmaZFekgI/rdwikHQoQVofPqyR67tFwy+8/
         hl+hCrUml23jcObnZsoGegj5frUSG6CYJAFdcLJCzF0NyPWXWaKYM9hUGkcuFpl0c7CA
         cmJg==
X-Gm-Message-State: APzg51D4Gzqoks9MyXD3/0OmqbLpB73A21QqsePC5p+rZiDqB8kWCnZt
        OTbHYZP2l0KNOAGvAfbZG1JCsYz0+Rk=
X-Google-Smtp-Source: ANB0VdbEvNhuGmx/owc1LNz7/kFGQyahPDIYV1jjQzq8/ppOT5huLxV2tbHvRRcpEPTk8v8YmEt2TA==
X-Received: by 2002:a9d:3d4b:: with SMTP id a69-v6mr13309792otc.334.1537218591747;
        Mon, 17 Sep 2018 14:09:51 -0700 (PDT)
Received: from a.local (ip-28-232-239-173.texas.us.northamericancoax.com. [173.239.232.28])
        by smtp.gmail.com with ESMTPSA id i132-v6sm7759807oif.20.2018.09.17.14.09.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 14:09:51 -0700 (PDT)
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org
References: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
Subject: Re: Linux 4.19-rc4 released, an apology, and a maintainership note
From:   Michael Woods <michaeljpwoods@gmail.com>
Message-ID: <93424bb0-180e-71ff-f0d6-602caa2d5883@gmail.com>
Date:   Mon, 17 Sep 2018 22:09:48 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CA+55aFy+Hv9O5citAawS+mVZO+ywCKd9NQ2wxUmGsz9ZJzqgJQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

 > The one change that stands out and merits mention is the code of
 > conduct addition...

The Code of Conflict was perfectly fine. Whomever convinced you to add 
the Code of Conduct was convincing you to give control over to a social 
justice initiative that has no interest in the kernel's core function or 
reason for existence.

"Codes of conduct are tools used by the incompetent to wrest control 
away from the people who own the project, so they can feed on the corpse 
and wear the skin of the project as a fetish play"

Examples of these people trying to introduce codes of conduct, with 
commentary on the emotions and motivations driving CoC introduction:
- LLVM: http://voxday.blogspot.com/2018/05/the-costs-of-code-of-conduct.html
- PHP: http://voxday.blogspot.com/2016/01/initial-sjw-attack-defeated.html
- PHP 2: http://voxday.blogspot.com/2016/01/a-second-sjw-attack-on-php.html
- Ruby: http://voxday.blogspot.com/2016/01/more-sjw-attacks-in-tech.html
- Ruby 2: 
http://voxday.blogspot.com/2016/01/the-sjw-war-on-ruby-continues.html
- Node.js: http://voxday.blogspot.com/2017/08/how-sjws-react-to-defeat.html
- Awesome-Django: 
http://voxday.blogspot.com/2015/10/exposing-true-face-of-sjw.html
- Go: http://voxday.blogspot.com/2015/06/you-cant-run-you-cant-hide.html

Some alternative ideas should you wish to rethink the Code of Conduct:
- Code of Merit: http://voxday.blogspot.com/2016/01/code-of-merit.html
- No Code of Conduct: 
http://voxday.blogspot.com/2016/01/no-code-of-conduct.html

 > This is my reality.  I am not an emotionally empathetic kind of person
 > and that probably doesn't come as a big surprise to anybody.  Least of
 > all me.  The fact that I then misread people and don't realize (for
 > years) how badly I've judged a situation and contributed to an
 > unprofessional environment is not good.

It has been good, this is easily proven by the quality and success of 
the Linux kernel. If you start being "nice" instead of forthright, every 
excuse in the mental health cookbook will be used to persuade you that 
emotions of the incompetent and their politics, are more important than 
improving the kernel.

 > This week people in our community confronted me about my lifetime of
 > not understanding emotions.  My flippant attacks in emails have been
 > both unprofessional and uncalled for.  Especially at times when I made
 > it personal.  In my quest for a better patch, this made sense to me.
 > I know now this was not OK and I am truly sorry.
 >
 > The above is basically a long-winded way to get to the somewhat
 > painful personal admission that hey, I need to change some of my
 > behavior, and I want to apologize to the people that my personal
 > behavior hurt and possibly drove away from kernel development
 > entirely.

You are not that bad. The incompetent and mentally ill have convinced 
you to act against your best interests, and those of the Linux kernel.

 > I am going to take time off and get some assistance on how to
 > understand people’s emotions and respond appropriately.

Don't try to understand people's emotions, it has not been necessary and 
is not necessary. It is a trap, set to weaken your resolve and standards.

 > To tie this all back to the actual 4.19-rc4 release (no, really, this
 > _is_ related!) I actually think that 4.19 is looking fairly good,
 > things have gotten to the "calm" period of the release cycle, and I've
 > talked to Greg to ask him if he'd mind finishing up 4.19 for me, so
 > that I can take a break, and try to at least fix my own behavior.

 > I know when I really look “myself in the mirror” it will be clear it's
 > not the only change that has to happen, but hey...  You can send me
 > suggestions in email.

I wish you the very best, my hope is that you recuperate & take stock, 
realise how the snakes tricked you and come back with a vengeance.

Kindest Regards,
Michael

