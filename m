Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7B6C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:53:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33D7320854
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:53:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33D7320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728118AbeJEDs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:48:27 -0400
Received: from mail-pl1-f173.google.com ([209.85.214.173]:41033 "EHLO
        mail-pl1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727536AbeJEDs0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:48:26 -0400
Received: by mail-pl1-f173.google.com with SMTP id q17-v6so5748829plr.8;
        Thu, 04 Oct 2018 13:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=TpabJRGbBcS4XfHdBIjwrj6zPMW0iqHFp2GfXLCImaY=;
        b=DtO9j1tn3M7X66O0VU1FFWRSQaqr+bDUmPr+2FN1Nc0mffMe0K/DJsg32U2hIZ+NJf
         hdYNFGrNuxX2hQYWqQMzgfHRPGYqMeWck8WdX6G2CLbcPRCIM92rIUQWLeO2S1FuqsM2
         5B+nzZYdr43Nk+SyF7PbK5/HkeEWurrizOKVXaFMHum6UQhve935w46CXgcIvGetT3Kz
         MzyrepTEePVGYMu370utM4seKDDMXt9BOqHnpIhuvcG2z2brGtLRE18cORXr2MSWioF/
         mKqj6Auxs1103UCRp9Ys5p2CAxa5B/0lGVb8IyY/1h8HKp0F3lvdDjCbWKtRnQD5DNMd
         QwWg==
X-Gm-Message-State: ABuFfoi9DFVMMEZIHw99doRuFuJBl2+VVvA8tDcrZ/Quh182lnx8D4VC
        QAHVadSLeEI5JeCMjPjLw5k=
X-Google-Smtp-Source: ACcGV607wZSmi4nC614uljP416iwDgha+gzo0LDlfM48mcdG/wVYyPuLBX2iimOZ/AVON6gJO6tgMg==
X-Received: by 2002:a17:902:9047:: with SMTP id w7-v6mr8435536plz.291.1538686403845;
        Thu, 04 Oct 2018 13:53:23 -0700 (PDT)
Received: from garbanzo.do-not-panic.com (c-73-71-40-85.hsd1.ca.comcast.net. [73.71.40.85])
        by smtp.gmail.com with ESMTPSA id t85-v6sm8269506pfi.73.2018.10.04.13.53.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Oct 2018 13:53:22 -0700 (PDT)
Received: by garbanzo.do-not-panic.com (sSMTP sendmail emulation); Thu, 04 Oct 2018 13:53:19 -0700
Date:   Thu, 4 Oct 2018 13:53:19 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-kbuild@vger.kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Sam Ravnborg <sam@ravnborg.org>, Petr Vorel <pvorel@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Johannes Berg <johannes@sipsolutions.net>,
        Valentin Rothberg <valentinrothberg@gmail.com>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        Felix Fietkau <nbd@nbd.name>, kconfig-sat@googlegroups.com
Subject: Re: [kconfig-sat] [ANN] init-kconfig - easy way to embrace Linux's
 kconfig
Message-ID: <20181004205319.GO5238@garbanzo.do-not-panic.com>
References: <20181004200249.GL5238@garbanzo.do-not-panic.com>
 <20181004200859.GA10237@localhost>
 <20181004203950.GN5238@garbanzo.do-not-panic.com>
 <20181004204117.GA10640@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181004204117.GA10640@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 04, 2018 at 01:41:18PM -0700, Josh Triplett wrote:
> I would *love* to see Kconfig in Linux evolved to be more easily reused.

This *can* happen. Let me itemize a few things off of my head I think
would need to be done as its at least fresh in my head now:

All we need from scripts/Kbuild.include is filechk and kecho (what I
have in my scripts/Kbuild.include). This could be moved to
scripts/Kbuild.basic, and so would make sync'ing easier.

The scripts/kconfig/Makefile would need a respective modifications to
make it work independently, see my scripts/kconfig/Makefile. Perhaps
the biggest pain was resolving the target for
scripts/kconfig/.mconf-cfg. If somehow we end up with a file which could
work for both environments we're set.

Other than this we'd need a simple script, say scripts/copy-kconfig.sh
which would copy over only those files I took from scripts/kconfig.

There's a few things to consider for a split copy / demo:

  * versioning *is not* part of kconfig
  * object building *is not* part of kconfig

But the problem I faced was that to demo kconfig I had to use *something*
for versioning and object building. The object building is simple, and
the versioning scheme was just copied from Linux.

What I ended up with the smallest demo I could come up with.

  Luis
