Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13146C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA18520883
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 08:14:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA18520883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbeGKIRL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 04:17:11 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:44233 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726299AbeGKIRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 04:17:10 -0400
Received: from unknown (HELO lgemrelse7q.lge.com) (156.147.1.151)
        by 156.147.23.51 with ESMTP; 11 Jul 2018 17:14:04 +0900
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
Received: from unknown (HELO sejong) (10.177.227.17)
        by 156.147.1.151 with ESMTP; 11 Jul 2018 17:14:03 +0900
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date:   Wed, 11 Jul 2018 17:14:01 +0900
From:   Namhyung Kim <namhyung@kernel.org>
To:     Janne Huttunen <janne.huttunen@nokia.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jaroslav =?utf-8?B?xaBrYXJ2YWRh?= <jskarvad@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@lge.com
Subject: Re: [PATCH v2] perf script python: Fix dict reference counting
Message-ID: <20180711081401.GA25373@sejong>
References: <20180709094159.GA7615@krava>
 <1531133990-17485-1-git-send-email-janne.huttunen@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1531133990-17485-1-git-send-email-janne.huttunen@nokia.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hell,

On Mon, Jul 09, 2018 at 01:59:50PM +0300, Janne Huttunen wrote:
> The dictionaries are attached to the parameter tuple that steals
> the references and takes care of releasing them when appropriate.
> The code should not decrement the reference counts explicitly.
> E.g. if libpython has been built with reference debugging enabled,
> the superfluous DECREFs will trigger this error when running perf
> script:
> 
>   Fatal Python error: Objects/tupleobject.c:238 object at
>   0x7f10f2041b40 has negative ref count -1
>   Aborted (core dumped)
> 
> If the reference debugging is not enabled, the superfluous DECREFs
> might cause the dict objects to be silently released while they are
> still in use. This may trigger various other assertions or just
> cause perf crashes and/or weird and unexpected data changes in the
> stored Python objects.
> 
> Signed-off-by: Janne Huttunen <janne.huttunen@nokia.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung
