Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB739C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9684B206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 21:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lXYit3oI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730389AbfAHVnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 16:43:02 -0500
Received: from mail-vs1-f41.google.com ([209.85.217.41]:36208 "EHLO
        mail-vs1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729838AbfAHVnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 16:43:02 -0500
Received: by mail-vs1-f41.google.com with SMTP id v205so3470194vsc.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Scq86pte8Z5RyR2O4cAO6a/A5LpVDQKkkYRPfFQbRc=;
        b=lXYit3oICRErA1kEeIkG4VZjcFi1gZZI+7oFqZRUIp9+ads9hui++Y6sunTN8lC2Xr
         TWfNCOsBhnHU22K0U3dU2pL8gih8ONEnF6NjUCBXulucT54FF1hvxm4Cc6/rBM5JU/o+
         loVJ95YxjRJKyoAnaWkpBn7xCS4oNZTpzlufg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Scq86pte8Z5RyR2O4cAO6a/A5LpVDQKkkYRPfFQbRc=;
        b=cOosUm5l4HegxhjOCQ9MHu1Ynhh5QXcBGda2BCswHPgx7SDJV3Z5NC5eG7XiLK51ke
         E6hbOzGqMDxGulbYyM/hxKzO6SKCFTQcbOZbu3O1IcSwL5L6a1y1+Y94g0eGowGgjUUZ
         VKuIhlHjmQ3HangWE6sujFaJT7voGb6nHOCpgkCDxhFCl5S1Nu3CZfy8TUfj28nzMedO
         E8oVoicwXtWt9tTQ6OdFI0PclWoEteNmVpeSdkxCZkRqZ37bhxls1wTj8fSJCwstNcwL
         sT8i78Lzx90QXyDykC2Zyeq/FpJScB6hszSwU8uV4JCYwpeaU5TVJ/PKASAiREaFf+71
         bZ2g==
X-Gm-Message-State: AJcUukfKTiTHI+DyPDWBbCLpYCctLCiMxdbC9gTAOH5fAecfFQi6IGNf
        a2jmTDSA1igpt9/6sEo4VQc7M9PmXRI=
X-Google-Smtp-Source: ALg8bN7hSoTd2ZbZHCa4Tno5uj+2i9fPLlYR7vufKoXmnQdEcJh3lrsTuSqPJuUu4faAxdoNzvbn0g==
X-Received: by 2002:a67:cb9b:: with SMTP id h27mr1405954vsl.227.1546983780694;
        Tue, 08 Jan 2019 13:43:00 -0800 (PST)
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com. [209.85.217.49])
        by smtp.gmail.com with ESMTPSA id l13sm56038443vka.16.2019.01.08.13.42.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 13:43:00 -0800 (PST)
Received: by mail-vs1-f49.google.com with SMTP id x1so3446268vsc.10
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 13:42:59 -0800 (PST)
X-Received: by 2002:a67:e199:: with SMTP id e25mr1444048vsl.188.1546983779474;
 Tue, 08 Jan 2019 13:42:59 -0800 (PST)
MIME-Version: 1.0
References: <50db058a-7dde-441b-a7f9-f6837fe8b69f@schaufler-ca.com>
 <CAGXu5jLUJYM3nDDhFeBOKkTnyCR-tXAv-rteBJFMBn_J7kVkqA@mail.gmail.com>
 <alpine.LRH.2.21.1812120556040.11653@namei.org> <CAGXu5j+bx7nJBMdFYigYnJFRyCvz0NAxfiWF8yP9EhRESLnn+Q@mail.gmail.com>
 <CAGXu5jJOGKAFrFF7HSPnqLpLz0no2Ae_z0TkWPeRt1WWqhqFOA@mail.gmail.com>
 <alpine.LRH.2.21.1901090805121.24546@namei.org> <2cd724a9-3735-1be3-4a42-facb264e70dc@schaufler-ca.com>
In-Reply-To: <2cd724a9-3735-1be3-4a42-facb264e70dc@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 8 Jan 2019 13:42:47 -0800
X-Gmail-Original-Message-ID: <CAGXu5jLQ8z8+oNcT=dTKHewC_bBPa9LuFuS1w1EejYh92vsvXA@mail.gmail.com>
Message-ID: <CAGXu5jLQ8z8+oNcT=dTKHewC_bBPa9LuFuS1w1EejYh92vsvXA@mail.gmail.com>
Subject: Re: [PATCH v5 00/38] LSM: Module stacking for SARA and Landlock
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     James Morris <jmorris@namei.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        SE Linux <selinux@tycho.nsa.gov>,
        John Johansen <john.johansen@canonical.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Salvatore Mesoraca <s.mesoraca16@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 1:37 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> On 1/8/2019 1:05 PM, James Morris wrote:
> > On Mon, 7 Jan 2019, Kees Cook wrote:
> >
> >> On Tue, Dec 11, 2018 at 1:19 PM Kees Cook <keescook@chromium.org> wrote:
> >>> On Tue, Dec 11, 2018 at 10:57 AM James Morris <jmorris@namei.org> wrote:
> >>>> On Tue, 4 Dec 2018, Kees Cook wrote:
> >>>>
> >>>>> On Mon, Nov 26, 2018 at 3:22 PM Casey Schaufler <casey@schaufler-ca.com> wrote:
> >>>>>> v5: Include Kees Cook's rework of the lsm command
> >>>>>>     line interface. Stacking is not conditional.
> >>>>> Can you resend this series with corrected "From:" lines in the body, etc?
> >>>>>
> >>>>> Beyond that, I obviously like it. James, what's needed for this to move forward?
> >>>> If there are no outstanding issues, I plan to merge this for 4.21.
> >>> Yeah, it looks good to me. (Excepting getting the authorship sorted.)
> >> I didn't see this actually get merged? Was there something that needed
> >> fixing? Should I send you a direct pull request for v5.1?
> > Yep, please send a new pull request.
>
> Do you want it as is or rebased on 5.0-rc1?

I've rebased to 5.0-rc1, did some light (re)testing, and sent a pull request...

-- 
Kees Cook
