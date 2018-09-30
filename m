Return-Path: <SRS0=A0hX=MM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B485AC004D2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 60E732082A
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Sep 2018 09:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dwuFkoX8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60E732082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727992AbeI3PdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Sep 2018 11:33:08 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:42482 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727862AbeI3PdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Sep 2018 11:33:07 -0400
Received: by mail-yb1-f193.google.com with SMTP id p74-v6so4415244ybc.9
        for <linux-kernel@vger.kernel.org>; Sun, 30 Sep 2018 02:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dp1EPl6E1YaA9KJlXMxFyYBiqqHx1DOzErCtNm3n3jk=;
        b=dwuFkoX8IHszyH6aPIjl/RJ06nEhgEtEpqM2jK9acBwmKNXHuqch3qzsteuZFU79DY
         TQoXZ8WPH6ZsRi2MZRzcxcYqoWtQimr2xtrCZev2QXJvvijVPCq2haBqDjJw3xuPdCX3
         DekyRE6cNX/Bwv84tCd7g5//+ZG3tCRSCjqqcwFivMcF0lfg4XFtbQz0fmaXDLQmswyx
         sWO6G2BrYZNapKTCVg8RW2Yk6IRvwi4zh3MWO3aMWnWqe6R7jbcP9zmbGQL0N2bDLV4M
         7BSth2BQlPHwKQB2JUGmiYI+h//vyvfM7/quToWm3EjMgMaWUmfHy1HJBS9HblacNxSm
         Glvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dp1EPl6E1YaA9KJlXMxFyYBiqqHx1DOzErCtNm3n3jk=;
        b=o+H3wHy/nsOltb+hhR15gR1zrgVO07xWwOiXnVkoSKWlGzORsSQI+OTKTxWnwp6z2x
         RlHztqrsadRCduW2OCVTjzJ346lFsaFri8D23fpuhFXbUNDiRlQcMIM5uu+Ubn2+K/dd
         v3XWCCkT1b+mdOa7Pr7QP6ZAxfvBIIZ4qTSPw9lfZVdKMWc3DYHukUsGz6T9uPr/bcu3
         B/SixR3hUT2KWh+hw53Rq8DrIRgGXNhfYQM8pP44F46qUDoRKzpGbVvv6I3/8cAIQ8tl
         EiCWYsDGmhNLvLP7sTOBG+stt8I5NGdmWy8T5u9hEvEuiPzwOrNmY2nUR3A4DQiKffrz
         QCGg==
X-Gm-Message-State: ABuFfogjC6kKZXadz25mkgaBfjnJKFea1pwxRmqYTzG6LaOdMFRcD/2k
        jPgoIQhsxT1P0aTdKiBoHWbhF6mx7MthpCspDGnE5qqX
X-Google-Smtp-Source: ACcGV62GEGSE0L9KfG08pio5maHGBAYhMmpTlV655PPRVe4G8K1vFYgNyHy9tmnlwbUnY9IrqUl795lfrE5t1q2j4+8=
X-Received: by 2002:a25:2ad1:: with SMTP id q200-v6mr3184399ybq.462.1538298058330;
 Sun, 30 Sep 2018 02:00:58 -0700 (PDT)
MIME-Version: 1.0
References: <20180930065100.GL15893@shao2-debian>
In-Reply-To: <20180930065100.GL15893@shao2-debian>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 30 Sep 2018 12:00:46 +0300
Message-ID: <CAOQ4uxiHkufAtt87bMs9n-0sFxJSHsBxDX6jn8v28vkvy=a_qQ@mail.gmail.com>
Subject: Re: [LKP] [fsnotify] 60f7ed8c7c: will-it-scale.per_thread_ops -5.9% regression
To:     rong.a.chen@intel.com
Cc:     Jan Kara <jack@suse.cz>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>, LKP <lkp@01.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 30, 2018 at 9:50 AM kernel test robot <rong.a.chen@intel.com> wrote:
>
> Greeting,
>
> FYI, we noticed a -5.9% regression of will-it-scale.per_thread_ops due to commit:
>
>
> commit: 60f7ed8c7c4d06aeda448c6da74621552ee739aa ("fsnotify: send path type events to group with super block marks")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>
> in testcase: will-it-scale
> on test machine: 88 threads Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz with 64G memory
> with following parameters:
>
>         nr_task: 16
>         mode: thread
>         test: unlink2
>         cpufreq_governor: performance
>
> test-description: Will It Scale takes a testcase and runs it from 1 through to n parallel copies to see if the testcase will scale. It builds both a process and threads based test in order to see any differences between the two.
> test-url: https://github.com/antonblanchard/will-it-scale
>
>
>
> Details are as below:
> -------------------------------------------------------------------------------------------------->
>
>
> To reproduce:
>
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         bin/lkp install job.yaml  # job file is attached in this email
>         bin/lkp run     job.yaml
>
> =========================================================================================
> compiler/cpufreq_governor/kconfig/mode/nr_task/rootfs/tbox_group/test/testcase:
>   gcc-7/performance/x86_64-rhel-7.2/thread/16/debian-x86_64-2018-04-03.cgz/lkp-bdw-ep3d/unlink2/will-it-scale
>
> commit:
>   1e6cb72399 ("fsnotify: add super block object type")
>   60f7ed8c7c ("fsnotify: send path type events to group with super block marks")
>

I have to admit this looks strange.
All this commit does is dereference mnt->mnt.mnt_sb and then
sb->s_fsnotify_mask/sb->s_fsnotify_marks to find that they are zero.
AFAICT there should be no extra contention added by this commit and it's
hard to believe that parallel unlink workload would suffer from this change.

I will try to install lkp-tests to verify this on my own system, but
until proven
otherwise I will regard this as false positive.

Thanks,
Amir.
