Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3BAEC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:56:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 890F3261A4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 21:56:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vZApHJeB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 890F3261A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754129AbeFYV4q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 17:56:46 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:46907 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752291AbeFYV4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 17:56:44 -0400
Received: by mail-ot0-f194.google.com with SMTP id v24-v6so16765147otk.13;
        Mon, 25 Jun 2018 14:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=AvuT6ab/tTy/yDfgL1E3Kd2sYOUL7oqWR5awkfLPKRU=;
        b=vZApHJeBqOIfPoDa6QCmGuqWeU53N3GIfEeBIZmdsvQjWQncOU81vPD19gL+yKbJ9B
         0Xmn+NLvm2ZiooTyIaL0ncYSgtovabs7N8dOc+irWuAIad64331BLToThBTKy7iuB60X
         KnW0se9KQ+JR5Lr+POF+2GUjG1UZaD2nLOrBPEA1bplcSKA8tIPIXHuR8689kBts3eH6
         /+x/jU/eG86gDsra2io/ii2GU3+tAkrq6FR9qzowsE9sVMY7K4GYZryJBz5e+ONzVXM8
         yA1Llz77zH4gPjAMPdnvNLPVSjRs5Wx2TVQf63g3pXn9UTEqVvWpKaViyR2CxmF0STJi
         U6WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=AvuT6ab/tTy/yDfgL1E3Kd2sYOUL7oqWR5awkfLPKRU=;
        b=E+eOtqnNHnMbblAtslMckrrUyH81PjZCii1ZdYWasjEMbWSSq672c5ZFhLfDTdqc3c
         BA7RwyRCNP6ewgt7+dwzyDxHokIOJ8i9kNFJAuj5Lx1KNkx5s18jSP1ygj/nwnsqVmt0
         LilCqEuvLKDiMosH5RAAcIFF62Mvz80+y3Rvuy7H1kUpdaR738vw+uGHmJkef43u3FEO
         ukVsc1LrOOlA6W0FWno+vxDYYv/JuGCRkfMMpy+Zz9UbtLnrJ2y1WVSwxx8/WVe6Zioc
         BNhN4e4u+4lhI7rhBNfBhqeLwBZGZfm3Q8YWvgtmSlvsFo4KYejTsJJHZcTbildIblRh
         ZLxQ==
X-Gm-Message-State: APt69E0eqLvFe6F/N8UT1d52hSA4GW/5eAWEK9iGYRq7TQSRm+Xjb+tq
        j0Rq+jDoqVd1pRqbRjKOUwMX27G0jDlHmVGCC2o=
X-Google-Smtp-Source: AAOMgpduUyxAN3fCmlqFkeG4r/tnXzZjSDMiQ/Gz+V8IEWZiAZbH0PtjIdwQpKbHQDTHxzdsB2rvZFI2ZmVfRIieNn8=
X-Received: by 2002:a9d:1dbc:: with SMTP id y57-v6mr7861674otd.370.1529963803619;
 Mon, 25 Jun 2018 14:56:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:1429:0:0:0:0:0 with HTTP; Mon, 25 Jun 2018 14:56:43
 -0700 (PDT)
In-Reply-To: <20180625115405.GB17001@amd>
References: <cover.1529486870.git.yu.c.chen@intel.com> <78af30838d0bac69bdd6e138b659bcbb8464fd13.1529486870.git.yu.c.chen@intel.com>
 <20180621090142.GB21807@amd> <CAJZ5v0hDhsxwU4X6_dCqc7P5GaTtpBeMUeJTHo9YJ8QtWinYfg@mail.gmail.com>
 <20180621190401.GA14623@amd> <CAJZ5v0jQQ7neWDc_cy5ZJPVJp155BLF7fQFmeNJ3Nn0Jho7AeA@mail.gmail.com>
 <20180625115405.GB17001@amd>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 25 Jun 2018 23:56:43 +0200
X-Google-Sender-Auth: pznTT-PfGX7IZj9foMHdrKNMli8
Message-ID: <CAJZ5v0jBh_0Uz54-Y2-qwdJNeD+KMpGEsH7q0XOdbCq5VCP1Ng@mail.gmail.com>
Subject: Re: [PATCH 3/3][RFC] tools: create power/crypto utility
To:     Pavel Machek <pavel@ucw.cz>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Chen Yu <yu.c.chen@intel.com>, "Ted Ts'o" <tytso@mit.edu>,
        Len Brown <len.brown@intel.com>,
        "Lee, Chun-Yi" <jlee@suse.com>, Borislav Petkov <bp@alien8.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Stephan Mueller <smueller@chronox.de>,
        Eric Biggers <ebiggers3@gmail.com>,
        Denis Kenzior <denkenz@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 25, 2018 at 1:54 PM, Pavel Machek <pavel@ucw.cz> wrote:
> Hi!
>
>> >> > It can already do encryption. If you see problems there, patches will
>> >> > be gladly accepted to fix them.
>> >>
>> >> By whom?
>> >
>> > By me.
>>
>> Well, OK
>>
>> Where's the repository the patches will go to when you accept them?
>
> On sourceforge.

No, it's not there or at least it's outdated AFAICS.

>> >> > If you want to maintain uswsusp in kernel tree, I guess that would be
>> >> > an option, too.
>> >>
>> >> No, it isn't an option due to the dependencies on crypto libraries.
>> >
>> > Why not?
>>
>> You need a specific set of devel libraries for the utilities to build
>> and that need not be present on all systems I suppose?
>>
>> Besides, s2disk is currently tangled with s2ram which is obsolete, so
>> I'd rather not.
>
> Its not tangled.

Yes, it is.
