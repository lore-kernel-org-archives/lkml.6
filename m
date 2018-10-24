Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6098BECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2223520831
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:08:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2223520831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=videotron.qc.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeJYIiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:38:17 -0400
Received: from alt14.smtp-out.videotron.ca ([135.19.0.27]:15133 "EHLO
        alt14.smtp-out.videotron.ca" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbeJYIiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:38:17 -0400
Received: from [192.168.122.131] ([70.81.202.49])
        by Videotron with SMTP
        id FSx6glmwgg9eoFSxSgxoqK; Wed, 24 Oct 2018 19:53:03 -0400
X-Authority-Analysis: v=2.3 cv=evbxMLhX c=1 sm=1 tr=0
 a=WHmR/RjFJjHp+qGai9ucMg==:117 a=WHmR/RjFJjHp+qGai9ucMg==:17
 a=IkcTkHD0fZMA:10 a=VwQbUJbxAAAA:8 a=8LccymvpPOanfCBx0qUA:9 a=QEXdDO2ut3YA:10
 a=AjGcO6oz07-iQ99wixmX:22
Subject: Re: [PATCH] pfn_t: force '~' to be parsed as an unary operator
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, acme@redhat.com,
        tz.stoyanov@gmail.com, Namhyung Kim <namhyung@kernel.org>,
        zwisler@kernel.org, arangradient@gmail.com,
        linux-perf-users@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20181021145939.8760-1-sebhtml@videotron.qc.ca>
 <CAPcyv4iJ_bfzOtV_GAQg_tdLLuebE_1Gp420LMG0xbR2ZQdV7g@mail.gmail.com>
 <FRrzgp7InaOtKFRs0geay1@videotron.ca>
From:   sebhtml <sebhtml@videotron.qc.ca>
Message-ID: <d48b2b1b-201a-d350-6bda-943a66f1abfb@videotron.qc.ca>
Date:   Wed, 24 Oct 2018 19:52:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <FRrzgp7InaOtKFRs0geay1@videotron.ca>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEYpD8IQosAAam0Ac8NNjp9LUuFtrsIgz16/c0a3T8eHJl9y3HMso7GYbuGZoqhfVF7T8jkalRrPlgfIONkFvZOvFzhNuXvVg9TQJbun5n2ScJSgzn74
 g3qAtJU3P8dZzNnai2gJ8dEgoXJy57SHbklTSFYTQNHoBaFRiCudGCNA38mnyjTfU/A9BTdCOf/Fm7vIH+MRoxl60ulvYTdTN5RuD/e8jHH3tbCN4kGsu16x
 PPxjYbF5SMsmu6s/3+2td5j11IlVoNfcy9F8ra2v9m7FDWOkM7lQTq1UTPN5/Fvv1dZ5GDrNQqByZjb2m56cL2pHb/95v7weUeyaTG+Lqh86/ts5ZQKKrc3a
 YlndW7Q16U4GaCR7hU75ET1IHL8h3N6oiLVc7fJcZhjKXKBVhn8c/nVdWYUgPk8ATqmtHoEBmMFQAiFse+wA+9f2dIkOtg7GalH6emW9yiTIt90kb/nBTRVd
 HQRFo8e54VhCrEGgNfvzEJKTFPdFNXxvwdrlNw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-10-24 6:43 p.m., Andrew Morton wrote:
> 
> I grabbed it, and added cc:stable.
> 
> But aren't we fixing this in the wrong place?  That's a valid
> expression and if this isn't addressed in perf then we may hit a
> similar issue elsewhere...
> 

Right.

Based on:
     git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 01aa9d518eae8a4d75cd3049defc6ed0b6d0a658

In perf, the warning
       [fs_dax:dax_pmd_insert_mapping] unknown op '~'
comes from tools/lib/traceevent/event-parse.c at line 2045:
                 do_warning_event(event, "unknown op '%s'", token);

This is in this function:

static enum tep_event_type
process_op(struct tep_event_format *event, struct tep_print_arg *arg, char **tok);

The code path to reach the good '~' case needs:
         if (arg->type == TEP_PRINT_OP && !arg->op.left) {

I assume that here arg->op.left is not NULL because of (u64) on the left.

~(((u64) ~(~(((1UL) << 12)-1)))
          ^

However, I fail to see where '~' is parsed as a binary operator though.

Any pointer would be welcome.
