Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0ADC43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3754724158
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 11:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VGyRc1B/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3754724158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932170AbeFVLlJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 07:41:09 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:43742 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751000AbeFVLlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 07:41:08 -0400
Received: by mail-lf0-f66.google.com with SMTP id l15-v6so1807055lfc.10
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jun 2018 04:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=S1zF2DXhw0CBTg+MRVflO5OfRtBBzi4iCO3JHfpmOSU=;
        b=VGyRc1B/+8qKednTHBmebc3PplqpxP/3aGUf2TqLa7IKA4mWHfsTnmaONKg4U7Y+ov
         W9KOyldpUf7JTShmQHf+7K+q+PGqtiJtFX/G/yVq4zPIHBQDd5CPETnxAgwp5VrLsHJQ
         coCqZi4RNXAg3I+9L1tNAgZkbFB1pkhlv7q9nXb5lZ7u9b9rRwwETw8qQDQuxCPJxlR9
         g/TNT3eX29oeqeAdl5wNyl6z+x63iJF26emOho0JLW21FJ4UEcRjBP+psUlTPLhUhFR9
         XjRMpMIdk+8YaLM2DfwbM1dbwuTIqMHHASXig5GV/czn8W6ZAji/ch71dViS/bG8+BB0
         QtAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=S1zF2DXhw0CBTg+MRVflO5OfRtBBzi4iCO3JHfpmOSU=;
        b=dC/uAZEWNxcvk6hbhGfoZHewUQU33wM6+zUStvuKsbzRzbRJRs99xe1bO1ilUqsW4r
         5yU6+Sj2xtW2550dzKJzaDkHzTOTXPD7RHHoJ930vYL1KQC9c+J8B/FyOZsm4Zxiyk0g
         qKOzVGXAiXWJMdlYjfrNzcdZeDkqg9mPJlQaI8ojU0OGjFcwHvmBFe0U5Ygm2Qxmsxm4
         QfELpeqzgmecPBVlov+BTarnOyyzJ4H4OnWetk7CZZWP2q+vL8e8Fj5pqHApeo0OcVKn
         HfJZUkO/qdEz69bXozFUTdTvC7Ky1k4C9qEJry3bxcKGATwGktdnMqNO8spuaPR2WkBz
         QteQ==
X-Gm-Message-State: APt69E3WePnhOY5P8yMe2uIYPFCw3X3XrWc5EdWHMDbCeKhO1aX69B6R
        YCwtvjObl6NLvjTw3JMvXhn5LLEBW1PKvsCRaXY=
X-Google-Smtp-Source: ADUXVKLhZmVD1Emf0IIYV7gwdlv1L8nnpuDlpxsi/HZaDYzidBU9Qw/J2iV7maw2WM69cb9AECRbNg3M85oK6ZE6Wt0=
X-Received: by 2002:a2e:12dc:: with SMTP id 89-v6mr1010623ljs.63.1529667666873;
 Fri, 22 Jun 2018 04:41:06 -0700 (PDT)
MIME-Version: 1.0
References: <1529056341-16182-1-git-send-email-ufo19890607@gmail.com>
 <20180622083949.GR10465@dhcp22.suse.cz> <CAHCio2jkE2FGc2g48jm+ddvEbN3hEOoohBM+-871v32N2i2gew@mail.gmail.com>
 <20180622104217.GV10465@dhcp22.suse.cz>
In-Reply-To: <20180622104217.GV10465@dhcp22.suse.cz>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Fri, 22 Jun 2018 19:40:54 +0800
Message-ID: <CAHCio2j-z5y8sQrZ9ENLH2sOzuoH=vsC+q9Nj5DbSXUnQK-uPw@mail.gmail.com>
Subject: Re: [PATCH v9] Refactor part of the oom report in dump_header
To:     mhocko@kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal
> You misunderstood my suggestion. Let me be more specific. Please
> separate the whole new oom_constraint including its _usage_.

Sorry for misunderstanding your words. I think you want me to separate
enum oom_constraint and static const char * const
oom_constraint_text[] to two parts, am I right ?
Michal Hocko <mhocko@kernel.org> =E4=BA=8E2018=E5=B9=B46=E6=9C=8822=E6=97=
=A5=E5=91=A8=E4=BA=94 =E4=B8=8B=E5=8D=886:42=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri 22-06-18 17:33:12, =E7=A6=B9=E8=88=9F=E9=94=AE wrote:
> > Hi Michal
> > > diff --git a/include/linux/oom.h b/include/linux/oom.h
> > > index 6adac113e96d..5bed78d4bfb8 100644
> > > --- a/include/linux/oom.h
> > > +++ b/include/linux/oom.h
> > > @@ -15,6 +15,20 @@ struct notifier_block;
> > >  struct mem_cgroup;
> > >  struct task_struct;
> > >
> > > +enum oom_constraint {
> > > +     CONSTRAINT_NONE,
> > > +     CONSTRAINT_CPUSET,
> > > +     CONSTRAINT_MEMORY_POLICY,
> > > +     CONSTRAINT_MEMCG,
> > > +};
> > > +
> > > +static const char * const oom_constraint_text[] =3D {
> > > +     [CONSTRAINT_NONE] =3D "CONSTRAINT_NONE",
> > > +     [CONSTRAINT_CPUSET] =3D "CONSTRAINT_CPUSET",
> > > +     [CONSTRAINT_MEMORY_POLICY] =3D "CONSTRAINT_MEMORY_POLICY",
> > > +     [CONSTRAINT_MEMCG] =3D "CONSTRAINT_MEMCG",
> > > +};
> >
> > > I've suggested that this should be a separate patch.
> > I've separate this part in patch v7.
> >
> > [PATCH v7 1/2] Add an array of const char and enum oom_constraint in
> > memcontrol.h
> > On Sat 02-06-18 19:58:51, ufo19890607@gmail.com wrote:
> > >> From: yuzhoujian <yuzhoujian@didichuxing.com>
> > >>
> > >> This patch will make some preparation for the follow-up patch: Refac=
tor
> > >> part of the oom report in dump_header. It puts enum oom_constraint i=
n
> > >> memcontrol.h and adds an array of const char for each constraint.
> >
> > > I do not get why you separate this specific part out.
> > > oom_constraint_text is not used in the patch. It is almost always
> > > preferable to have a user of newly added functionality.
> >
> > So do I need to separate this part ?
>
> You misunderstood my suggestion. Let me be more specific. Please
> separate the whole new oom_constraint including its _usage_.
> --
> Michal Hocko
> SUSE Labs
