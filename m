Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C469FC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95034208A3
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 02:00:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95034208A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lge.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730134AbeKLLvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 06:51:15 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:45183 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729903AbeKLLvP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 06:51:15 -0500
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.53 with ESMTP; 12 Nov 2018 11:00:21 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: chanho.min@lge.com
Received: from unknown (HELO WMRRD11NA101CK) (10.178.32.163)
        by 156.147.1.151 with ESMTP; 12 Nov 2018 11:00:20 +0900
X-Original-SENDERIP: 10.178.32.163
X-Original-MAILFROM: chanho.min@lge.com
From:   "Chanho Min" <chanho.min@lge.com>
To:     "'Oleg Nesterov'" <oleg@redhat.com>
Cc:     "'Rafael J. Wysocki'" <rjw@rjwysocki.net>,
        "'Pavel Machek'" <pavel@ucw.cz>,
        "'Len Brown'" <len.brown@intel.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        "'Eric W. Biederman'" <ebiederm@xmission.com>,
        "'Christian Brauner'" <christian@brauner.io>,
        "'Anna-Maria Gleixner'" <anna-maria@linutronix.de>,
        "'Alexander Viro'" <viro@zeniv.linux.org.uk>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-fsdevel@vger.kernel.org>,
        "'Seungho Park'" <seungho1.park@lge.com>,
        "'Inkyu Hwang'" <inkyu.hwang@lge.com>,
        "'Donghwan Jung'" <donghwan.jung@lge.com>,
        "'Jongsung Kim'" <neidhard.kim@lge.com>
References: <1541752656-12857-1-git-send-email-chanho.min@lge.com> <20181109092123.GA29945@redhat.com>
In-Reply-To: <20181109092123.GA29945@redhat.com>
Subject: RE: [PATCH] exec: make de_thread() freezable
Date:   Mon, 12 Nov 2018 11:00:19 +0900
Message-ID: <073101d47a2b$7706e530$6514af90$@lge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJbWKoWsAi/1jE9HWI0IvG2z5b81gHsBy4PpC4/mqA=
Content-Language: ko
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Thanks, but please note another schedule() in "if
> (!thread_group_leader(tsk))"
> branch, we probably want to change it too?
> 
> Oleg.
Sounds right, The thread group leader might be frozen as well.
I'll prepare v2.

