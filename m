Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D753C28CF6
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1617C21736
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 03:43:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HwAZwcu9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1617C21736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeHEFqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 01:46:15 -0400
Received: from mail-lj1-f170.google.com ([209.85.208.170]:38677 "EHLO
        mail-lj1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726078AbeHEFqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 01:46:15 -0400
Received: by mail-lj1-f170.google.com with SMTP id p6-v6so7960488ljc.5
        for <linux-kernel@vger.kernel.org>; Sat, 04 Aug 2018 20:43:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AcTCol9qeCJKzxwiL3kem0qqwEefYovysQ6kIgktEDk=;
        b=HwAZwcu90n1UjHEA28yF2eC37M9be2i1CFO7c+B4ayGrN9AnB8gM0qVjClcvJExDdF
         se5EJv8t9TfH5sLZxNwj2bHXJrI9x6JRhVhtYjCRvhRPVqIkdEkosy01cqEDuRohD4+N
         h22kMlwyn5yJKIDaT8A5YiP56NuySSvDZ3ecBVyAh4OqRMX86iCl4d18nUS6hoS/qzpm
         IaQf6nxpTBldFQyMWX0DtOQOgDOkLWH5EDTNansfyhkL9A/YnRKB/bl/bKj1b6OWUne3
         Uotqy7qCnv2AN/tbxsafZ1O00+G/pyREwCWYpEx6FcUxrub9u5iVuzEdYxLIr8/rvkkx
         +BQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AcTCol9qeCJKzxwiL3kem0qqwEefYovysQ6kIgktEDk=;
        b=KAqwa1Qj9TtmGIUFJayPwCrDB2f1ZpHrhZ4KSu3UIojbUh3qrLK7PRHtYVj4kSPC5U
         0cAkje3Pruec0BMAegzr4ONI3JZVu64C5gKwUwO99/NsY8bA05jRdjNTJjICXJ6EQobk
         XMzVALOUwGJt3g8JGWvWy5GzSHvl7N5B8PnDYdZojz+PISEEynanLLiCbT/BOb70wtyH
         hcFfIAZS4uYE/IoA6/vPC+uJ7/4aP1vxiBgmy0Q+IErffD7j+Exu1DOZW8eRKxeluqpG
         H/BLO6hWdIFir8pUk/DL6uppqEB2ZAqbodq9+ZBr5Q5jChlalRk1iBTQKBQ1QEHNuMEh
         O/Ew==
X-Gm-Message-State: AOUpUlHXmoZZSSpXhaRXSomk1gNJGazZo9Dz14k+M4zz+R/RvVfljVsU
        g8v61ycKDGCZ3mkDk6WSICBIy05Bpruw6PDuUm4=
X-Google-Smtp-Source: AAOMgpfFKorvHCVXwNo9n2+DuK2myIL+SxWj+h14M2L75UqRRuDcHKU/ewiaRvb+EjDozhHqfy0ePm+MTaToMJfnNFo=
X-Received: by 2002:a2e:9c0f:: with SMTP id s15-v6mr3834674lji.97.1533440590993;
 Sat, 04 Aug 2018 20:43:10 -0700 (PDT)
MIME-Version: 1.0
References: <0d4090532f15434aa71779e9dc8a0014@BJSGEXMBX10.didichuxing.com>
In-Reply-To: <0d4090532f15434aa71779e9dc8a0014@BJSGEXMBX10.didichuxing.com>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Sun, 5 Aug 2018 11:41:50 +0800
Message-ID: <CAHCio2idn3oh55n7urkRPqkdyo+Y-0Qhg=Vc2VHXy2Wy2q1wiA@mail.gmail.com>
Subject: Re: [LKP] [mm, oom] c1e4c54f9c: BUG:KASAN:null-ptr-deref_in_d
To:     Wind Yu <yuzhoujian@didichuxing.com>
Cc:     mhocko@kernel.org, rientjes@google.com, rong.a.chen@intel.com,
        sfr@canb.auug.org.au, kirill.shutemov@linux.intel.com,
        aarcange@redhat.com, penguin-kernel@i-love.sakura.ne.jp,
        guro@fb.com, yang.s@alibaba-inc.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, lkp@01.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal and David,
AFAICS, the null pointer is the task_struct of p in the dump_header.
Why don't we just add a if before printing the victim task's
informaiton.

diff --git a/mm/oom_kill.c b/mm/oom_kill.c
--- a/mm/oom_kill.c
+++ b/mm/oom_kill.c
@@ -438,14 +438,6 @@ static void dump_header(struct oom_control *oc,
struct task_struct *p)

        cpuset_print_current_mems_allowed();
        mem_cgroup_print_oom_context(oc->memcg, p);
-       pr_cont(",task=%s,pid=%d,uid=%d\n", p->comm, p->pid,
-               from_kuid(&init_user_ns, task_uid(p)));
+      if (p)
+              pr_cont(",task=%s,pid=%d,uid=%d", p->comm, p->pid,
+                      from_kuid(&init_user_ns, task_uid(p)));
+     pr_cont("\n");
        if (is_memcg_oom(oc))
                mem_cgroup_print_oom_meminfo(oc->memcg);

Thanks
Zhoujian
