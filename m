Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997F9ECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45756206B8
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 00:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OpAFDQ+u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45756206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728948AbeIRGPZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 02:15:25 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37987 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbeIRGPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 02:15:25 -0400
Received: by mail-yw1-f67.google.com with SMTP id n21-v6so91297ywh.5
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 17:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RLTFXtCKHlXSPakm8BOXJ+hCRLLkcB5u6dQOtHaqioo=;
        b=OpAFDQ+u8r1pvUVD30z54DccG0hIGjjSaEeJGw4vktbmSKPAKbsTQI6lc270tAQezd
         qFlVdqWGsqlGhhFwDpjaIjRIN3sjVznoLmYDwR56AsLrb3ORNDjng/il24tCKcHm4MPO
         jpGz2WRTUn/r1qGhBjV+KhJFn1Brft7zFwSMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RLTFXtCKHlXSPakm8BOXJ+hCRLLkcB5u6dQOtHaqioo=;
        b=m9+gHvWSBd69Wn5qKlqg2uj/kFbMYSIe5jvKqHDQ4IOfo0TPPCUgQP5PaZsHPJsiGe
         IhIrm0j/ywLCfZXycsp3WMM1Sjx4XCMNKlM915ZJb44G49Dd6ZEeYRgTCyR38sJOozUG
         MiFs7sL/VPBk9bYBYXPdsJuWl/Emz0bY/KMMhVuNO+2rVfgoRBQ92ZLkuBYGqU9skECe
         T3rxB1VR7BOG4H7wBodhYKR4aBvTkjnM2mSa20caTZtlNhxjqFGhtMQMyGgvld9cBs1r
         mkB6rTyPkFa2OVS+na/Ij1Wd5JfSsaxnGJN6AN+u3wk8kDdmjw/2YHB+Us8vlz0cLQHA
         ChkA==
X-Gm-Message-State: APzg51CW0luzQMvGcThQqrB/maOVUhFpBx0XvnsHGi6U26PfUTP0VyFg
        3ltNNzOJcLWDufIvYezcuRe+s2YFu3g=
X-Google-Smtp-Source: ANB0VdaaUbrCcl7DF7BRAMz9BVoJ6hxw6+6mgrNGoYhzgpLLiRZ9sMRjTZQVdb0DrdCHruLpaz2Vuw==
X-Received: by 2002:a0d:e847:: with SMTP id r68-v6mr11025181ywe.17.1537231531077;
        Mon, 17 Sep 2018 17:45:31 -0700 (PDT)
Received: from mail-yw1-f51.google.com (mail-yw1-f51.google.com. [209.85.161.51])
        by smtp.gmail.com with ESMTPSA id k130-v6sm1292825ywe.29.2018.09.17.17.45.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Sep 2018 17:45:29 -0700 (PDT)
Received: by mail-yw1-f51.google.com with SMTP id l9-v6so79745ywc.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 17:45:29 -0700 (PDT)
X-Received: by 2002:a81:1194:: with SMTP id 142-v6mr11742647ywr.168.1537231529171;
 Mon, 17 Sep 2018 17:45:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:5f04:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 17:45:28
 -0700 (PDT)
In-Reply-To: <ee3b287d-95a4-db16-e3c6-fc6f6172a5ae@schaufler-ca.com>
References: <20180916003059.1046-1-keescook@chromium.org> <20180916003059.1046-17-keescook@chromium.org>
 <84e1a5a8-8997-829f-cf09-1d29895a3f99@schaufler-ca.com> <CAGXu5jK5CzXUii97q_yk3KzBTw0SOmoc=-zcm+3jAqEHe76AgQ@mail.gmail.com>
 <35b0af5b-e37e-e192-73b5-0d0b37d9e37f@schaufler-ca.com> <CAGXu5jJ71RLGh0nDgOaN3vCXFGE0poXFU2Gb9o+20aO+AEdOvw@mail.gmail.com>
 <8f0bd39b-29a6-325d-4558-d9f484249c22@schaufler-ca.com> <CAGXu5jLeTfwEXAZLz_H1PCx0ySWZcRhXQMfnE14TG8BvxY46JA@mail.gmail.com>
 <53377892-695f-6336-8574-54c7aa0a4201@schaufler-ca.com> <7ecfffc3-d2a4-3ff7-4bf5-db3029d73c59@canonical.com>
 <fbdc2a75-8364-c743-f9c3-9dcd2570c569@schaufler-ca.com> <e9292d89-12bd-2c4a-9ca2-5758de790f2f@canonical.com>
 <CAGXu5jKhZTcz_+uQpNRh6Mg34pP2+aNSo9cV=c8pC0r=oJBJog@mail.gmail.com> <ee3b287d-95a4-db16-e3c6-fc6f6172a5ae@schaufler-ca.com>
From:   Kees Cook <keescook@chromium.org>
Date:   Mon, 17 Sep 2018 17:45:28 -0700
X-Gmail-Original-Message-ID: <CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
Message-ID: <CAGXu5jK4pa7-G8zhHE-noM4qVQGytTzcKX4BkQFkuJmEbLONaw@mail.gmail.com>
Subject: Re: [PATCH 16/18] LSM: Allow arbitrary LSM ordering
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     John Johansen <john.johansen@canonical.com>,
        James Morris <jmorris@namei.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Paul Moore <paul@paul-moore.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        "Schaufler, Casey" <casey.schaufler@intel.com>,
        LSM <linux-security-module@vger.kernel.org>,
        LKLM <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 17, 2018 at 5:24 PM, Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 9/17/2018 5:00 PM, Kees Cook wrote:
>> The legacy per-LSM
>> enable/disable ordering is the same, but ordering between
>> lsm.enable/disable and the per-LSM options is NOT ordered. i.e. the
>> precedent mentioned in the prior paragraph.
>
> That is, capability,yama,loadpin,<major>

Yeah, sorry, I didn't mean LSM order there, I meant the commandline
order of appearance of the options. If you mix them, the last
lsm.enable/disable for an LSM is the "real" setting, and the last
$LSM.enabled= setting is the last of _that_ one.

>> To support "security=", we'll still have some kind of legacy
>> LSM_FLAG_MAJOR to perform implicit disabling of the non-operational
>> other "major" LSMs. This means "security=$foo" will be a short-hand
>> for "lsm.disable=all-LSM_FLAG_MAJOR-who-are-not-$foo". This will
>> exactly match current behavior (i.e. "security=smack" and if smack
>> fails initialization, we do not then fall back to another major).
>
> Right.

Cool.

>> I think we have to support runtime ordering for the reasons John
>> specifies. Additionally, I have the sense that anything we can
>> configure in Kconfig ultimately ends up being expressed at runtime
>> too, so better to just make sure the design includes it now.
>
> Right.
>
>> What we have now:
>>
>> "first" then "order-doesn't-matter-minors" then "exclusive-major"
>>
>> - we can't change first.
>> - exclusivity-ordering only matters in the face of enable/disable
>> which we have solved now (?)
>
> I'm not sure where you get the conclusion we've solved this.
> Today I can't say "lsm.enable=smack lsm.enable=apparmor", and
> there's no mechanism to prevent that.
>
>> so, ordering can be totally arbitrary after "first" (but before some
>> future "last"). We must not allow a token for "everything else" since
>> that overlaps with enable/disable, so "everything else" stay implicit
>> (I would argue a trailing implicit ordering).
>
> There's an assumption you're making that I'm not getting. Where does
> this overlap between ordering and enable/disable come from?

Handling exclusivity means the non-active LSMs are disabled. We had
been saying "the other majors are disabled", but the concept of major
will become arbitrary. If instead we move to "first exclusive wins
among the exclusives", we still have the "the others are disabled"
case. So exclusivity begets disabling.

>> The one complication I see with ordering, then, is that if we change
>> the exclusivity over time, we change what may be present on the
>> system. For example, right now tomoyo is exclusive. Once we have
>> blob-sharing, it doesn't need to be.
>>
>> so: lsm.order=tomoyo  after this series means
>> "capability,tomoyo,yama,loadpin,integrity", but when tomoyo becomes
>> non-exclusive, suddenly we get
>> "capability,tomoyo,yama,loadpin,{selinux,smack,apparmor},integrity".
>> (i.e. if selinux is disabled then move on to trying smack, then
>> apparmor, etc.)
>
> We're missing a description of what happens at build time.
> It's hard to see what you expect to happen if I want to build in
> all the major modules and don't plan to use the boot command line
> options.
>
>> I would argue that this is a design feature (LSMs aren't left behind),
>> and order of enabled exclusive LSMs "wins" the choice for the
>> exclusivity (instead of operating "by name" the way "security="
>> works).
>
> I think I see more, but I'm guessing. At build time it looks like
> you're dropping the specification on the "major" module. We can't
> do that because I want to build kernels that run Smack by default
> but include SELinux for when I'm feeling less evil than normal.

Do we need build time _ordering_, or can we just go with build time
"first exclusive"? For the v1, I went with "first exclusive" from
CONFIG_SECURITY_DEFAULT, and left the rest of the ordering up to the
Makefile.

-Kees

-- 
Kees Cook
Pixel Security
