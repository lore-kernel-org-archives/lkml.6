Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7351C64EB1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 965ED214C1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 15:54:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 965ED214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bitron.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbeLFPyP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 10:54:15 -0500
Received: from nov-007-i650.relay.mailchannels.net ([46.232.183.204]:62629
        "EHLO nov-007-i650.relay.mailchannels.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbeLFPyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 10:54:15 -0500
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D58B91B6048B;
        Thu,  6 Dec 2018 15:54:09 +0000 (UTC)
Received: from srv17.tophost.ch (swiss-ingress-2.mailchannels.ch [46.232.183.6])
        by relay.mailchannels.net (Postfix) with ESMTPA id 4E23C1B6042C;
        Thu,  6 Dec 2018 15:54:05 +0000 (UTC)
X-Sender-Id: novatrend|x-authuser|juerg@bitron.ch
Received: from srv17.tophost.ch (srv17.tophost.ch [193.33.128.141])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384)
        by 0.0.0.0:2500 (trex/5.15.2);
        Thu, 06 Dec 2018 15:54:09 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: novatrend|x-authuser|juerg@bitron.ch
X-MailChannels-Auth-Id: novatrend
X-Relation-Wide-Eyed: 3b06b8b9099e243c_1544111649530_3564411419
X-MC-Loop-Signature: 1544111649530:2489107428
X-MC-Ingress-Time: 1544111649530
Received: from [80.219.231.201] (port=50240 helo=jzen.bitron.ch)
        by srv17.tophost.ch with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.91)
        (envelope-from <j@bitron.ch>)
        id 1gUvyV-00Fpfw-TX; Thu, 06 Dec 2018 16:54:03 +0100
Message-ID: <9264c60225f95cb1ca4d3d529972520be08a95b0.camel@bitron.ch>
Subject: Re: [PATCH v2 0/1] Add prctl to kill descendants on exit
From:   =?ISO-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 06 Dec 2018 16:54:03 +0100
In-Reply-To: <20181130080004.23635-1-j@bitron.ch>
References: <20181127225408.7553-2-j@bitron.ch>
         <20181130080004.23635-1-j@bitron.ch>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AuthUser: juerg@bitron.ch
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-11-30 at 08:00 +0000, Jürg Billeter wrote:
> This patch adds a new prctl to kill all descendant processes on exit.
> See commit message for details of the prctl.
> 
> This is a replacement of PR_SET_PDEATHSIG_PROC I proposed last year [1].
> In the following discussion, Oleg suggested this approach.
> 
> The motivation for this is to provide a lightweight mechanism to prevent
> stray processes. There is also a related Bugzilla entry [2].

Andrew, Eric, does this look good to you as well?

Jürg

