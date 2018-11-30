Return-Path: <SRS0=bYeO=OJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A362AC04EB8
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72145206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Nov 2018 11:22:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72145206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbeK3Wbd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Nov 2018 17:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58460 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726533AbeK3Wbd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Nov 2018 17:31:33 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 64175D5717;
        Fri, 30 Nov 2018 11:22:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.12])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9E6C3101963D;
        Fri, 30 Nov 2018 11:22:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 30 Nov 2018 12:22:36 +0100 (CET)
Date:   Fri, 30 Nov 2018 12:22:33 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     =?iso-8859-1?Q?J=FCrg?= Billeter <j@bitron.ch>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] prctl: add PR_{GET,SET}_KILL_DESCENDANTS_ON_EXIT
Message-ID: <20181130112233.GC23670@redhat.com>
References: <20181127225408.7553-2-j@bitron.ch>
 <20181130080004.23635-1-j@bitron.ch>
 <20181130080004.23635-2-j@bitron.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181130080004.23635-2-j@bitron.ch>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 30 Nov 2018 11:22:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/30, Jürg Billeter wrote:
>
> This introduces a new thread group flag that can be set by calling
>
>     prctl(PR_SET_KILL_DESCENDANTS_ON_EXIT, 1, 0, 0, 0)
>
> When a thread group exits with this flag set, it will send SIGKILL to
> all descendant processes.  This can be used to prevent stray child
> processes.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

