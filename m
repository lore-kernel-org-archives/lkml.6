Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82BBC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6773B2171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 00:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdaBqUaM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbfABAvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Jan 2019 19:51:37 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36577 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfABAvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Jan 2019 19:51:37 -0500
Received: by mail-pl1-f193.google.com with SMTP id g9so13855915plo.3;
        Tue, 01 Jan 2019 16:51:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bAaRW1/Ei0qr9/KNwDarEc5yyN+GFrW6XRfdQ6M97UM=;
        b=bdaBqUaMkwO+8rLSlCD3n1Sdy1ftsOvgqHa35D183yJJiQwqKVxiNPz++wltqAkQC7
         XuqpJNOXA52L3IUkTcsyjPxIEv5GhSdqkubEG28hVpWHxsq5bsPp4YDBSJ6P/Hx+r6kp
         nSzP7fwwB6x16+HAemq+6yol1tSlCyHgw+vvtUz+ri88sTz9657ZhRP12lKJN4efJH6b
         AVxob8aAeJXKmJ0BKB1HBuQbv8zPFYR37KO7OoTjPcC/+Icj/Cke0nPqhGJ42bprV3q0
         k/DYo+JgCyTXJQCXVig8ZTOrd1BwRB30NjuXZy05TtshmXk/0Wf6tSa9MBOtnVIgTp+U
         3Npw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bAaRW1/Ei0qr9/KNwDarEc5yyN+GFrW6XRfdQ6M97UM=;
        b=EM8a4y5eOzrHidBKCk1SXzlXsMP2Y9WgwODQbJAs7ErpJmjS5ASilLTti0S0BHh7sW
         /Is3EuA/lhkT2xdhhSK+2guRwpOvwnt8xXlPg6198EUdnQOZpPXaP4vQ41GwqbE+zcsM
         EAOng9yow/FJh+ciLGyat/Qt0fLwFL0/1ygmtV+ODyQXIWgvRdqBV4DsD4La5WHGmC+q
         ZjlF5UQCR0lbcyRjniNu8D1Qc+NtQkzE6zSluatNkiLo4IDm62+zNSUpsvwrP8f9JbsZ
         Rnp/UAVFMQ1F7RaXmCu+qnbxLxKENBmzEMLKGFJ4GzdIRNYfdHUhsqbz8w2HYqGwL4ii
         vgSA==
X-Gm-Message-State: AJcUukey+G8Mk4BG91WFlo1tiAUDr8ELJu+rOUgqVG6bceGDj/KYh4cL
        BSq2C2W3BMN6VY2rJIiWjLU=
X-Google-Smtp-Source: ALg8bN72jlCp1eKBMompXTlW05EWROoYAVoXNXqA/GSacfoN7pyflCB4Oxx6z2dPfZWgNq4nCZq5Dw==
X-Received: by 2002:a17:902:2:: with SMTP id 2mr15074356pla.228.1546390296198;
        Tue, 01 Jan 2019 16:51:36 -0800 (PST)
Received: from localhost.localdomain ([2601:644:8201:32e0:7256:81ff:febd:926d])
        by smtp.gmail.com with ESMTPSA id 128sm76819876pfu.129.2019.01.01.16.51.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Jan 2019 16:51:35 -0800 (PST)
Date:   Tue, 1 Jan 2019 16:51:25 -0800
From:   Eduardo Valentin <edubezval@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rui Zhang <rui.zhang@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] Thermal-SoC management updates for v4.21-rc1
Message-ID: <20190102005121.GB7944@localhost.localdomain>
References: <20190101160503.GA3306@localhost.localdomain>
 <CAHk-=whXWWXSMMPpm3eGV=PL12=K5LFM3didLBuGy1Y7vUbXVg@mail.gmail.com>
 <20190101231526.GA7944@localhost.localdomain>
 <CAHk-=wiku0MygbFLmLjvCo-zzu4ygivkshdGzVVADYdwe-b57A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wiku0MygbFLmLjvCo-zzu4ygivkshdGzVVADYdwe-b57A@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 01, 2019 at 03:32:50PM -0800, Linus Torvalds wrote:
> On Tue, Jan 1, 2019 at 3:16 PM Eduardo Valentin <edubezval@gmail.com> wrote:
> >
> > > It doesn't even build cleanly.
> > >
> >
> > Do you still have have a copy of the build error?
> 
> A plain "make allmodconfig" shows a warning.

I see. I am afraid I really did not catch this. I supposed you are
referring to the warning like this:

    thermal_hwmon.h:29:1: warning: ‘thermal_remove_hwmon_sysfs’ defined but not used [-Wunused-function]

I am sending out a patch for this on thermal_hwmon.h  and will be resending the pull request
once the CIs report back.


> 
> And I refuse to add new warnings.

Fair enough. I would not expect anything different. Thanks for reporting.

> 
>                  Linus
