Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E40C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:16:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE40208B0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 05:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FlTcav8W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DDE40208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755663AbeFSFQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 01:16:40 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35819 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751777AbeFSFQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 01:16:38 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so28099860lfc.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jun 2018 22:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=qOMOKnra0qcIKpa0rykziN8tqL9QbaMubxcc/OuzRcA=;
        b=FlTcav8WfXFIpPfJ4xeGKfrA/hXcl48EBWC/NNeI+antUhcrSAzqMmsno+oZFZ4G3W
         CeBWkaxLnlyOXE7BxqIfWhSGwB6YbvX40NlrCWG2VkBMSa1PmGe36LWFFQAfIUYjIAnV
         zxPh6ikMFLr0iTIdUIr1pG4pXBYZKk3s3XjmAuQKbqHuBpHn7692o5xjWJgo2QpbBNo4
         sfhB/pJHLeaiC5eTyxyqaWKxRpDuHhXanoO4mIR5sHYcQAR2rttfide0rPmz4yFFyol3
         L95aC5ME32giMMIn2HwXBbCoM2DvJjXRzCSfDUXuBqSD+61aZafx9zOlLxJ2mwuNFDOZ
         zxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=qOMOKnra0qcIKpa0rykziN8tqL9QbaMubxcc/OuzRcA=;
        b=iK6V9dz3NEZjFemFpytZKEVkZJyNt4pPzugsBp0o8ebizfLMElqWtf8CI+dRVW+U2n
         NO9mqPZ+Y7EZYEUv1hFIsVL+71seIgWCGuzOCEqjhsig/pUfU84vWS+SEnD5PPsSDtCs
         QJ6zWjMBS5XLsQuJpPokuIPOL8siEqEzreliGY9H5/YnIOpfoLbbIrCne1h+RcuRlNSX
         fLnzJHD3fXV6urBNiEYqe9hz42KXCqUb0ocWG+fTRR3GsGnpy3hAjF4G3O82l7JMXeOz
         Eo37xtDLf9ki+6WEdZPYnP0uMHLCVRqZizuALKRc3fKdvBAaid6jSGJ8x0AcPkYGLPuj
         wLqA==
X-Gm-Message-State: APt69E0aDnWqkidxSHNW74n3eMUr+Ye0fH5D8QMTE94A6hstpmsUimmN
        jw30mCphZGSK1723VXWYgsiA1oUO5zDbarHRbTQ=
X-Google-Smtp-Source: ADUXVKKL2w2WXOLtJlpRWA7/41hXVHdkjh4wQELix1rJc3CDWTugZxFAWUV0zULJ0OMwvU3VxZfus6CaUfI0XSKDlgw=
X-Received: by 2002:a19:7707:: with SMTP id s7-v6mr2862386lfc.8.1529385396641;
 Mon, 18 Jun 2018 22:16:36 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:44ec:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 22:16:36
 -0700 (PDT)
In-Reply-To: <20180618174203.4a1b4cf0@gandalf.local.home>
References: <1529297889-24551-1-git-send-email-byungchul.park@lge.com>
 <1529297889-24551-3-git-send-email-byungchul.park@lge.com> <20180618174203.4a1b4cf0@gandalf.local.home>
From:   Byungchul Park <max.byungchul.park@gmail.com>
Date:   Tue, 19 Jun 2018 14:16:36 +0900
Message-ID: <CANrsvROOfkPw265ObAPJ_H2epP2SJJsV64xcAGvOCbqHgwny1w@mail.gmail.com>
Subject: Re: [RESEND PATCH v12 2/2] sched/rt: Add support for
 SD_PREFER_SIBLING on find_lowest_rq()
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Byungchul Park <byungchul.park@lge.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dario Faggioli <raistlin@linux.it>,
        linux-kernel@vger.kernel.org, Juri Lelli <juri.lelli@gmail.com>,
        bristot@redhat.com, kernel-team@lge.com,
        Joel Fernandes <joel@joelfernandes.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 6:42 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Mon, 18 Jun 2018 13:58:09 +0900
> Byungchul Park <byungchul.park@lge.com> wrote:
>
>> Hello Steven,
>>
>> I've changed the code a little bit to avoid a compile warning caused by
>> 'const' args of find_cpu(). Can I keep your Reviewed-by?
>>
>> BEFORE:
>> static int find_cpu(const struct cpumask *mask,
>>                   const struct sched_domain *sd,
>>                   const struct sched_domain *prefer)
>>
>> AFTER:
>> static int find_cpu(const struct cpumask *mask,
>>                   struct sched_domain *sd,
>>                   struct sched_domain *prefer)
>>
>> (I temporarily removed the Reviewed-by you gave me.)
>> Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
>
> I would fix sched_domain_span() to take a constant and keep the
> previous patch.

Right. I also considered it like you and asked it here:

   https://lkml.org/lkml/2018/1/11/106

But I didn't get any answer so tried to keep sched_domain_span()
unchanged conservatively.

Peterz, what's your opinion?

>
> -- Steve

-- 
Thanks,
Byungchul
