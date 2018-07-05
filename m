Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B41FFC6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:23:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6396720878
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:23:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbWGUweH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6396720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754060AbeGELXg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:23:36 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46703 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753719AbeGELXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:23:34 -0400
Received: by mail-lj1-f194.google.com with SMTP id u6-v6so6370246lju.13
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jul 2018 04:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/6gi2DtTVvLWYzs2tr9WhhuhZDUKUiuBOPbyTZXhNMY=;
        b=hbWGUweHCYFtglpqucZJ+hdix84UJW18D3znU10ORT0zkgvd1BWe7JG4EIREqegzJ2
         XOcQxS3aIBBzu72uTCdCnMBkzcO6EupNNFA9Cl8rP67CGszcMQOi8ES0JnleEypC/wOC
         ZRhS/vbjgCrIJSjMgAQVMBWy+p1xA4H+1gYdlmayOl85klZK/JfDpLZZzoHidgsdSdrv
         uCfKRbt59YtrklH7YMchzxfQqlbwD0QoBAzLxu+M4zSdhMguN3jF5J/lA7AO3UjKOXnr
         alLR1mKvZZj/uRhjJLM8lITh3UeGIShORj9QzXnfqdiSREy/Y/7zYLuv6dHXg7rcWrRZ
         EDHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/6gi2DtTVvLWYzs2tr9WhhuhZDUKUiuBOPbyTZXhNMY=;
        b=XEipnx9Blg4UOpCEscR3lNvPQuLtT33ebSQy3faOs+rAAUalN0slEL07f3LgVcssku
         S0VYgsvHW7jOr/cAcnFtiKKAC9ZmM6v6eI8NxEpwrxG4c5RZUF+uji+VHNRlnPyPNRE7
         bBrLrMuSqYBnrYiC35ZhWSFjudGtsbW3rQ0pVrFojOZXm0WnrV7EpzNCkOjsKqwS6Xko
         ows97WdrqMhn7d+bHmMPaif24SIWsLlgSCR9OFeU9/hwq1eGjZuOYTgy8sl1WJ1ZYcjA
         bueqby4A3QOHA9/lbIp379v183fHOTvOIjyEvPmtEDaqDWpFroNAyalK+7gdDLOg50iD
         8rkw==
X-Gm-Message-State: APt69E2XYUkQlUjEA2Hyyq02mCFi0GyEkWuLPdT66GQB6tfBw3CHk57U
        FLZpNNXi3sWAvNJiN9In1+mzGTgLea836zPgSKk=
X-Google-Smtp-Source: AAOMgpceHYFVG+8/UFnhM032nNZ+fvPS5f36V/hQhjcD7OodJksE7PGWbdaodCjTY96jWad9hteGlVJaKvr7ZjeKSFE=
X-Received: by 2002:a2e:1d50:: with SMTP id d77-v6mr3813749ljd.104.1530789813432;
 Thu, 05 Jul 2018 04:23:33 -0700 (PDT)
MIME-Version: 1.0
References: <1530376739-20459-1-git-send-email-ufo19890607@gmail.com>
 <CAHp75VdaEJgYFUX_MkthFPhimVtJStcinm1P4S-iGfJHvSeiyA@mail.gmail.com>
 <CAHCio2jv-xtnNbJ8beokueh-VQ6zZgF1hAFBJKHCNyuOuz2KxA@mail.gmail.com> <20180704081710.GH22503@dhcp22.suse.cz>
In-Reply-To: <20180704081710.GH22503@dhcp22.suse.cz>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Thu, 5 Jul 2018 19:23:22 +0800
Message-ID: <CAHCio2hf-kfmVgz=KCvE9L4nPZxEVcFrxv2R1Y11etG=KvyBwg@mail.gmail.com>
Subject: Re: [PATCH v11 1/2] Refactor part of the oom report in dump_header
To:     mhocko@kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        akpm@linux-foundation.org, rientjes@google.com,
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

Hi Michal and Andy
The enum oom_constraint  will be added in the struct oom_control.  So
I still think I should define it in oom.h.
Michal Hocko <mhocko@kernel.org> =E4=BA=8E2018=E5=B9=B47=E6=9C=884=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=884:17=E5=86=99=E9=81=93=EF=BC=9A
>
> On Wed 04-07-18 10:25:30, =E7=A6=B9=E8=88=9F=E9=94=AE wrote:
> > Hi Andy
> > The const char array need to be used by the new func
> > mem_cgroup_print_oom_context and some funcs in oom_kill.c in the
> > second patch.
>
> Just declare it in oom.h and define in oom.c
> --
> Michal Hocko
> SUSE Labs
