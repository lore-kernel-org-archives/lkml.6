Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49848C43612
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 160EA20874
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 00:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Jenv5oE1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbeLRAhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 19:37:15 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:43402 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726295AbeLRAhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 19:37:14 -0500
Received: by mail-lf1-f65.google.com with SMTP id u18so10893256lff.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vwYTHo0lnqHOWhe65fNPvti8gjLyH+tTQ6Hiz2yL+KU=;
        b=Jenv5oE17ioo7RmUV+5lWpqj8Bb3wwbDmTvtfVUCRhIFfnaExLWZ581NcoXjYizJk4
         HUSFeVVFH8aX+s4fKoChvieQOsMAPQirCL5PqQcRZkUt6Yx/a93Ss7cA/w+L+qBd+ilS
         GE7b40xsnMThQhM4TRpPxzIKgFSNyYdwZVFRc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vwYTHo0lnqHOWhe65fNPvti8gjLyH+tTQ6Hiz2yL+KU=;
        b=gmA/L7egPlRbeRJDSuNipLn+Zz2bK5MbPyyUetLEbq2oKTojqTUKKVwx1NbDd19TNJ
         fx8SxTsjyxZvvqmWNoG0gkN3x3aBZCI6rmN4Daxda8/jWZAOjj5kcveHDN3Bg80hsHms
         lqYTYN1Y8sOPHx0NCfK77KY5ulmF1fMmL/jcA18JISav2p4XGBLGKzgV5G9JZmo0YtHJ
         c2ALn35giw/sKXVqyq07xmE3lA+YG76yiQoCXeY1188mBXEfB5A8/G6krDEc2WVKVA8S
         y+jWXRraVG63bxk4pUTmMmZFOApgS7j6/MYP57lhHV7Y4LD6WfZhscFEV90KpdC9ZcU8
         A3GA==
X-Gm-Message-State: AA+aEWYm/vBx+2ijJMUfcOtB/veK1rR4jCzY6gKFaCDt3meNpkFEtRUK
        W4dCwGeCzhn8Na5SXCTG1zpxGT94EFE=
X-Google-Smtp-Source: AFSGD/UXGUEc0OM8cK8ymxFFemw2SasG/cCJLxnUwt4mH6w6kaorUa7cJX3cX7Jguw7Z15aNbc8KhA==
X-Received: by 2002:a19:c345:: with SMTP id t66mr8125634lff.55.1545093431878;
        Mon, 17 Dec 2018 16:37:11 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id r7-v6sm2782515ljc.10.2018.12.17.16.37.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 16:37:11 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id q2-v6so1523719lji.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 16:37:10 -0800 (PST)
X-Received: by 2002:a2e:2c02:: with SMTP id s2-v6mr8928017ljs.118.1545093430422;
 Mon, 17 Dec 2018 16:37:10 -0800 (PST)
MIME-Version: 1.0
References: <1545092089.4206.5.camel@linux.ibm.com>
In-Reply-To: <1545092089.4206.5.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Dec 2018 16:36:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=whEb_vShPGCK80_tspsyw12G6mHLQkMDiSP0GWWHroqqA@mail.gmail.com>
Message-ID: <CAHk-=whEb_vShPGCK80_tspsyw12G6mHLQkMDiSP0GWWHroqqA@mail.gmail.com>
Subject: Re: [PATCH] ima: cleanup the match_token policy code
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        James Morris James Morris <jmorris@namei.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 17, 2018 at 4:14 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Start the policy_tokens and the associated enumeration from zero,
> simplifying the pt macro.

I applied this directly, since I decided to just commit my own "don't
use negative Opt_err" patch for the test_and_set_bit() cases, and they
kind of go together.

There's still a -1 in security/keys/encrypted-keys/encrypted.c, and
there are also three cases of "Opt_error = -1" in the security layer.

All of which look pointless and wrong, but not actively buggy, so I'll
leave them alone.

                 Linus
