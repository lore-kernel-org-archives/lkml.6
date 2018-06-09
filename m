Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id cB66KN8eG1vSCwAAmS7hNA
	; Sat, 09 Jun 2018 00:27:11 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 8C72D6089E; Sat,  9 Jun 2018 00:27:11 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="KFWuDB7n"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 11C67607A4;
	Sat,  9 Jun 2018 00:27:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 11C67607A4
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753207AbeFIA1I (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 20:27:08 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39811 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753094AbeFIA1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 20:27:06 -0400
Received: by mail-io0-f196.google.com with SMTP id f1-v6so17800747ioh.6;
        Fri, 08 Jun 2018 17:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nRYahOPaQtxhfVLLnuNNOxDH7Ou9eP5i7lBzzhAFGhk=;
        b=KFWuDB7nWmMxQvJOnBycKbWChnYqanPwJQFrQ21NgBJI3pOt5kIpwow7FfuHHQsrge
         0x8Fv9WbPfrSArEvbZUns9U0tH5plVjFB6Uqmts0fqhm94uVnkwMtlnG1oPILRdhv3QK
         N6DlKoDh3/VBchyUI1GrOEz2G+yg6Me52w4Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nRYahOPaQtxhfVLLnuNNOxDH7Ou9eP5i7lBzzhAFGhk=;
        b=ZT+CP2W2r92Qz6WDCt2asU3+fivujOkDpgw1LiRbN1Y2MVjYtsYlSwNuY3Klkgetk1
         EBn99IWrNmmfqHRO7den7ckyiuSoQsJTPNaBTWc4aIZlv0Kwlj+Qbruixd93KCbTzsQH
         Y5pToiZMwvLNdFH4fRguSHA3ErteURGPE053cRjzVkyeJkk7qac51DxIvxLIWg5P77hb
         yTfk5MX/JSdDY1Cv3nIqlFST153kw1BOl+PMGSWuBpfvcjwIcB5dUD9vOhkBAbvlDWwO
         xRD9BY4KjYLONFJlqz18f/f2HpaSKV8sF/FapDyuFKSifvaGmdY9og+cNHq+OyJTXIOK
         jfdA==
X-Gm-Message-State: APt69E1pn5cQeOvtkmgiUP0m6In2vBffJovReatxxHLb1795HywrPB/G
        qiqCbC2LWE35ssnMqWsqeDRbGG3NsY7m005jB4Q=
X-Google-Smtp-Source: ADUXVKJBFFH1NIqfi0HUbmeuWAQZg9Nu2umkzpVwEvT2+PkBLPIluLJu53+hndaZXVU0fXeU5YqzIr+1SKz58zlkBHo=
X-Received: by 2002:a6b:f90b:: with SMTP id j11-v6mr6302871iog.238.1528504025918;
 Fri, 08 Jun 2018 17:27:05 -0700 (PDT)
MIME-Version: 1.0
References: <1528502307.25740.14.camel@intel.com> <CA+55aFy_fiF2bwW=0gL4g8uL5099hWarL4+Q9djmDEuwRR2KKw@mail.gmail.com>
In-Reply-To: <CA+55aFy_fiF2bwW=0gL4g8uL5099hWarL4+Q9djmDEuwRR2KKw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Jun 2018 17:26:55 -0700
Message-ID: <CA+55aFyTXHxaRQhsCwgicFw6=xk80Bjw92tgfmmRP4HQ-AhSvw@mail.gmail.com>
Subject: Re: [GIT PULL] libnvdimm for 4.18
To: Dan Williams <dan.j.williams@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 5:19 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If I get stuff that looks at all complex at the end of the merge
> window, I will just cackle unpleasantly while I press the big 'D' key
> on my keyboard.

Side note: looking at what I just pulled, there was close to a D key here too.

Dammit, the top commit in your tree is a merge. And the merge message
for that merge is this:

    Merge branch 'for-4.18/mcsafe' into libnvdimm-for-next

That's it. One line. That doesn't say anything at all.

That kind of uninformative commit message wouldn't be remotely
acceptable for a regular simple one-liner patch.

WHY THE HELL DO PEOPLE CONTINUE TO THINK THAT IT'S OK FOR MERGES?

Dammit. Merges are *more* complex than random usual patches. They need
proper commit messages. Yet you have two merges there with absolutely
*no* information in the commit message.

If you can't be bothered to write an informative commit message for a
merge, you damn well shouldn't do the merge.

It really is that simple.

                     Linus
