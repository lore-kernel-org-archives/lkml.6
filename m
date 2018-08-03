Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64777C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 106562172B
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AwqSLeGZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106562172B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbeHCIyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:54:38 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:35580 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbeHCIyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:54:38 -0400
Received: by mail-ed1-f66.google.com with SMTP id e6-v6so1781887edr.2;
        Thu, 02 Aug 2018 23:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BToqHnruEFWzF4KUHIKkhBWJXabmmXG2JItTBWoDE9A=;
        b=AwqSLeGZK5m5u6wncTr1E+8DhwEtdc576vD/l3XObqxvhipo8UUR0ESryVfoR2ud5p
         uKJYUmM9+W7XYlG5B2tOnFa3EG6kzS+CLneYRp6g+374oP6u8hKtUcVCcq51WBUFoo5l
         2rBT9Cg4gS5+rEQp7aC3irbuPnVmsgOWmIDKVuDkf32Ej4ckdomSC4MmHmdBR3KcisJW
         RVrl5dV4Wlltwz6NR0Qpj0CWc+ytG/JNT4veT5yRqxxxxQIN5tWeCxVpP3hRqdwE4ugA
         RtD4F6pwkggYk/q+lXBOjQ6/8lZ1WWbuLqQXILFbFuFuUTE6GxIR941H5kUpF/dK9e+1
         OsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BToqHnruEFWzF4KUHIKkhBWJXabmmXG2JItTBWoDE9A=;
        b=GxVaP25kdTyxvDI2rzvQm9x1k0f5xGSXr0TvRelhmXL4KhysAYfioPBQep7IxN1ALv
         G/3o/WtpDTupZCuK8KCcCGGXOyzpHIaYzYxagqG78iD1LfZIBRCPjoCkgo/t6loYDJP0
         YIVLiPxF5oy0AfVdmO2OVUjlGUKHqbEXmo6YjayDsXiysFkqTeDvOTC158/xLFC/wIcH
         jWPfTfexOml1JWWGL9Syatob8/HuNujaeco77saw+J0QplW1ihT/xZi0N3kfcagsWkAV
         KiII7t3Mzh92yWOuL1ku+U8Ss48o2RLvyV3GDXBM7CKXlh6R33YZOV26gRcQUKz47QkT
         eH5g==
X-Gm-Message-State: AOUpUlGA0wDvBGPq3Pt5ecnf0eV5T0xDshIOzvOgXZ4uwrPioOTuH/Nr
        EpLYVV3Z6hqJa5xdakgFQzxmWAUZtMQJbEfEyO8=
X-Google-Smtp-Source: AAOMgpcHpQfJwqU9T1sZV8hccDKeJYw0oblaj5Vld5bxtS/EvtxDpf/VzEoXjZoDFFlgBBwL066w12C9S4oo5vv8j2w=
X-Received: by 2002:a50:f4aa:: with SMTP id s39-v6mr6146169edm.262.1533279585238;
 Thu, 02 Aug 2018 23:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <1533275285-12387-1-git-send-email-zhaoyang.huang@spreadtrum.com>
 <CAGWkznE_Z+eJ+81eZN_KT7KXSFyCxfoafeMFSzirT7OaL+vbRA@mail.gmail.com> <20180803061817.GC27245@dhcp22.suse.cz>
In-Reply-To: <20180803061817.GC27245@dhcp22.suse.cz>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 3 Aug 2018 14:59:34 +0800
Message-ID: <CAGWkznHV44vxsnB9rmKO_k-orhTvupeJhk_cTKP128boM=6Egw@mail.gmail.com>
Subject: Re: [PATCH v1] mm:memcg: skip memcg of current in mem_cgroup_soft_limit_reclaim
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        cgroups@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-patch-test@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 3, 2018 at 2:18 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Fri 03-08-18 14:11:26, Zhaoyang Huang wrote:
> > On Fri, Aug 3, 2018 at 1:48 PM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
> > >
> > > for the soft_limit reclaim has more directivity than global reclaim, we40960
> > > have current memcg be skipped to avoid potential page thrashing.
> > >
> > The patch is tested in our android system with 2GB ram.  The case
> > mainly focus on the smooth slide of pictures on a gallery, which used
> > to stall on the direct reclaim for over several hundred
> > millionseconds. By further debugging, we find that the direct reclaim
> > spend most of time to reclaim pages on its own with softlimit set to
> > 40960KB. I add a ftrace event to verify that the patch can help
> > escaping such scenario. Furthermore, we also measured the major fault
> > of this process(by dumpsys of android). The result is the patch can
> > help to reduce 20% of the major fault during the test.
>
> I have asked already asked. Why do you use the soft limit in the first
> place? It is known to cause excessive reclaim and long stalls.

It is required by Google for applying new version of android system.
There was such a mechanism called LMK in previous ANDROID version,
which will kill process when in memory contention like OOM does. I
think Google want to drop such rough way for reclaiming pages and turn
to memcg. They setup different memcg groups for different process of
the system and set their softlimit according to the oom_adj. Their
original purpose is to reclaim pages gentlely in direct reclaim and
kswapd. During the debugging process , it seems to me that memcg maybe
tunable somehow. At least , the patch works on our system.
> --
> Michal Hocko
> SUSE Labs
