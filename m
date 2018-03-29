Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1168001-1522340041-2-17837750700710123112
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522340040; b=vh7J9LPqRrJZuYLSDHaUBqH5odNvk1LfkDJ32llIDrYm24tEE7
    S8BrixTYehpnMbX4VpkHNR9lgViEnTt1czSL+5gIiYAF1b1mzpvgYU/E5IA4VQeY
    FlBD82Oka2pQveN2e/nGNwBZDDPMqIjWEHFh1MdKVyuyAX7eE9vStTbXTN/xflfY
    OO0hxyr1g4qteWo2upKZsXEGS8GyjV7Thn1vWBxZdOLeCkjOjODDfver0E8cuZlR
    hlPeNkhK1ykqKNol4l81RoReeYANEMjKPOaRi1O/xKfFkAmH1xOJJPOHPjPpitQj
    UJpPbIXJ8s1tQAYUN/iaWjjB9clyTkpx9pcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=message-id:subject:from:to:cc:date
    :in-reply-to:references:content-type:mime-version
    :content-transfer-encoding:sender:list-id; s=fm2; t=1522340040;
    bh=eMAUFiEADnPj6J4ZZptR2OfIOD6mhRcrBOsZ7YhjnaM=; b=J2At6QXS7dSC
    2EEYEIfbQtjTJrKRzTDMcY67edxJAGKaBZOsuowxgFdkBL5aDFb8G9UoGUgNw6xV
    6awDCnGr7fKsxBo4YUlZtPRErkIfaZX5VWaRaaMSfYGYu62feVduiCMICteg9wOV
    kCKSXcLZWcH+xjwP//HkBTV8txZ5vmf9wg3PSb1pXU+q1Jzm8j2gd3K54dqI/j6e
    QqMKdC4jlf0dIXtqO6QSxJ4Q8HPcmsSXivbPk/BAYA123sMrMQ3sj/sra4RJvByb
    CTRO59nj3cK8LpyY/fjtmuhiswj3fjizG56O08I7pSWaIxEGqqMIztS+nTMyliqm
    pGZlRfatRw==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=codethink.co.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=codethink.co.uk header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfH9vCY39n6CvCcTHPn5Xpm27oB3pcgMeqOBLECZOR+KqrJnmt++m03GME+curqjBnf4+Dil2RhBK0axsd1bvp6nkr1w3Kqwxz5fsOOdOeJA+iF8mjHr+
    FM9CEr5bpMzbb5MG2tkhvjOSIcorsfdOouezY1fn4tvaDrBdZ6qwqChCwcqOcn5hx4jCnOh9xomwcz3/wtEzg6KHU04Ai0rChaaU5VMNp0oQ5LcN3ULYYp62
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=v2DPQv5-lfwA:10
    a=1XWaLZrsAAAA:8 a=Lyni5Ml3Mjy5FSvaWBsA:9 a=QEXdDO2ut3YA:10
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751714AbeC2QN7 (ORCPT <rfc822;greg@kroah.com>);
        Thu, 29 Mar 2018 12:13:59 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:43532 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751223AbeC2QN6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Thu, 29 Mar 2018 12:13:58 -0400
Message-ID: <1522340036.2654.20.camel@codethink.co.uk>
Subject: Re: [PATCH 4.4 014/134] perf tools: Make
 perf_event__synthesize_mmap_events() scale
From: Ben Hutchings <ben.hutchings@codethink.co.uk>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org, Stephane Eranian <eranian@google.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Date: Thu, 29 Mar 2018 17:13:56 +0100
In-Reply-To: <20180319171851.147448695@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
         <20180319171851.147448695@linuxfoundation.org>
Organization: Codethink Ltd.
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, 2018-03-19 at 19:04 +0100, Greg Kroah-Hartman wrote:
> 4.4-stable review patch.  If anyone has any objections, please let me know.
> 
> ------------------
> 
> From: Stephane Eranian <eranian@google.com>
> 
> 
> [ Upstream commit 88b897a30c525c2eee6e7f16e1e8d0f18830845e ]
> 
> This patch significantly improves the execution time of
> perf_event__synthesize_mmap_events() when running perf record on systems
> where processes have lots of threads.
> 
> It just happens that cat /proc/pid/maps support uses a O(N^2) algorithm to
> generate each map line in the maps file.  If you have 1000 threads, then you
> have necessarily 1000 stacks.  For each vma, you need to check if it
> corresponds to a thread's stack.  With a large number of threads, this can take
> a very long time. I have seen latencies >> 10mn.
> 
> As of today, perf does not use the fact that a mapping is a stack, therefore we
> can work around the issue by using /proc/pid/tasks/pid/maps.  This entry does
> not try to map a vma to stack and is thus much faster with no loss of
> functonality.
> 
> The proc-map-timeout logic is kept in case users still want some upper limit.
> 
> In V2, we fix the file path from /proc/pid/tasks/pid/maps to actual
> /proc/pid/task/pid/maps, tasks -> task.  Thanks Arnaldo for catching this.
> 
> Committer note:
> 
> This problem seems to have been elliminated in the kernel since commit :
> b18cb64ead40 ("fs/proc: Stop trying to report thread stacks").
[...]

I don't think so.  It looks like this was fixed by commit 65376df58217
("proc: revert /proc/<pid>/maps [stack:TID] annotation") which we
already have in 4.4-stable.  But older branches (3.16, 3.18, 4.1) don't
have that and probably should do.

It looks like commit b18cb64ead40 ("fs/proc: Stop trying to report
thread stacks") is also a candidate for stable.

Ben.

-- 
Ben Hutchings
Software Developer, Codethink Ltd.
