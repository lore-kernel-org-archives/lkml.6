Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33405C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB202208B7
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 21:31:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwROLiid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB202208B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbeH1BUS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 21:20:18 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:33942 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbeH1BUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 21:20:17 -0400
Received: by mail-pg1-f196.google.com with SMTP id d19-v6so115115pgv.1;
        Mon, 27 Aug 2018 14:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GbfSIyImydTFGymOdqY0NAd+XMaAWMng9Weh3FNmmeg=;
        b=WwROLiidpded6Cpt7016km0BomkK5Jdg/epWeOic6zde81JPWf4pBPmFzKeNB6aqgN
         ZgsbO1Azr9NRXQpFhxEMsf8zjEZyApS1xwCPpOamzK81cnAHURL8vxdmbCq3ZTfhV3RY
         CyI6MVzYvpPThNN2p0N2LmUSorNM9pQFTgveZmxZ1MuCCQxb1xSt8BiRxP0IH6ZR6Wk1
         WRxmK7AE+mx778nCWQ3amvk6nChd7bUw+XsBuCqQBeaVqhVlJepwcUiQP1wkvBXzOdTx
         bz6Sis+zOI5g4tkQEq/Xs/AhJrVJR5OCBdkCWDVOcbZhhUNTx9At3bDT0sZfIDXL0gRt
         hMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GbfSIyImydTFGymOdqY0NAd+XMaAWMng9Weh3FNmmeg=;
        b=HEm3mpWjRuOuA70zdQmSpNL5qfnjgkeux/kKNkNcuZcAjU7wpZL2GbjyCFB+S1Pycd
         tR/f9YyaLKOgKdE37Pa98ogXGcaq9lusXc/33v6ib82OPbx6rBQrY8Mv1FA/eaPWCAD/
         wEsClfxPaeWBLzmk2FxYLfZmdNo33V3G83usQPRaifCbOrosEkLr0cSiPG862M/2iA97
         wfHMzQV2lRU4IuVEFFXPUTstLaWBtFBRmW3iEBJ72tEkey1FQAXTeU32BMbSqgDROwvN
         Nu6bXJuQLtsd215srYGtuXC1eHfvuJHFkfhWl6YIBg8T7ORkeWo2KUNjbquwm9BVNeZj
         CfEQ==
X-Gm-Message-State: APzg51A19RTYFhQY8L0wY5Lo0ynhK828F721W7fSKsiQP+YjZ051C7xq
        vPPOW06Ymge8mSHUH2JZRiAW210D7QL88G4YfopK1HIW
X-Google-Smtp-Source: ANB0VdbV7X6Hvk2M7DIkGKiWp1Qx3xKQXtSTpOkt3OkPJhOemKVtUthz4bNRj8c2ivsiD5tU4O8BA3/2Gr0ibwjQ1z0=
X-Received: by 2002:a63:e14a:: with SMTP id h10-v6mr13684814pgk.358.1535405512755;
 Mon, 27 Aug 2018 14:31:52 -0700 (PDT)
MIME-Version: 1.0
References: <20180826055801.GA42063@beast> <20180826061534.GT6515@ZenIV.linux.org.uk>
 <CAGXu5jK7VzayzZTcxgZBf-+YHWO+Hv7s8utj2rzTc3gFtA8pFQ@mail.gmail.com>
 <20180826173236.GU6515@ZenIV.linux.org.uk> <20180826225749.GY6515@ZenIV.linux.org.uk>
 <cb9d4e74-3498-48bd-45e0-05e925dbdb5b@mojatatu.com>
In-Reply-To: <cb9d4e74-3498-48bd-45e0-05e925dbdb5b@mojatatu.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Mon, 27 Aug 2018 14:31:41 -0700
Message-ID: <CAM_iQpVEyq9hR3bbOtLFKoLo6nHCtiL6A__uEz3JdDO79GF_8A@mail.gmail.com>
Subject: Re: [PATCH] net: sched: Fix memory exposure from short TCA_U32_SEL
To:     Jamal Hadi Salim <jhs@mojatatu.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Pirko <jiri@resnulli.us>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Network Developers <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 4:58 AM Jamal Hadi Salim <jhs@mojatatu.com> wrote:
>
> On 2018-08-26 6:57 p.m., Al Viro wrote:
> > On Sun, Aug 26, 2018 at 06:32:37PM +0100, Al Viro wrote:
> >
> >> As far as I can tell, the solution is
> > [snip long and painful reasoning]
> >> pointers, and not in provably opaque fashion.  Theoretically, the three tcf_...
> >> inlines above need another look; fortunately, they don't use ->next at all, not to
> >> mention not being used anywhere outside of net/sched/*.c
> >>
> >>      The 80 lines above prove that we only need to grep net/sched/*.c for
> >> tcf_proto_ops method calls.  And only because we don't have (thank $DEITY)
> >> anything that could deconstruct types - as soon as some bastard grows means
> >> to say "type of the second argument of the function pointed to by p", this
> >> kind of analysis, painful as it is, goes out of window.  Even as it is,
> >> do you really like the idea of newbies trying to get through the exercises
> >> like the one above?
> >
> > BTW, would there be any problem if we took the definitions of tcf_proto and
> > tcf_proto_ops to e.g. net/sched/tcf_proto.h (along with the three inlines in
> > in pkt_cls.h), left forwards in sch_generic.h and added includes of "tcf_proto.h"
> > where needed in net/sched/*.c?
> >
>
> I cant think of any challenges. Cong/Jiri? Would it require development
> time classifiers/actions/qdiscs to sit in that directory (I suspect you
> dont want them in include/net).
> BTW, the idea of improving grep-ability of the code by prefixing the
> ops appropriately makes sense. i.e we should have ops->cls_init,
> ops->act_init etc.

Hmm? Isn't struct tcf_proto_ops used and must be provided
by each tc filter module? How does it work if you move it into
net/sched/* for out-of-tree modules? Are they supposed to
include "..../net/sched/tcf_proto.h"?? Or something else?

BTW, we need some grep tool that really understands C syntax,
not making each variable friendly to plain grep.
