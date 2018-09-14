Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B56C04AB8
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A63F820853
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 03:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="TTahYRLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A63F820853
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbeINIbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 04:31:36 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46063 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728165AbeINIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 04:31:36 -0400
Received: by mail-lf1-f65.google.com with SMTP id r4-v6so6580500lff.12
        for <linux-kernel@vger.kernel.org>; Thu, 13 Sep 2018 20:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+oQBPFQL5yhYvpb4wkuYUrkpAF1+l3FJ553n5YPcP1I=;
        b=TTahYRLUHrwM6FoOkW0e4RrexmaRxzDOjiSFOkwGMLnwdLFhqI27UNlfR8KkAeG8VW
         +hc8S2C/vEMugbNZpMDiXDRHpyY7AXYsN1Zf8E1r2aUImiFjqGdaKzFGhRawCPHU3DZN
         K7/t1uB3idzJ1Xy5G7LSiQoQPgK0Al1wWjQBNZhrUIW+cd8ybHc8BoUlR+lq+lXBoFTq
         jObddaF5pRpTNsKIAjYnbdZpQKc8vbBfm2ZD0C2ZaucfJNW3T4cEGB9nBdQvMdMvFjCf
         woN197wy0+w2WaIGRVLb5GVbP2P2Fe00N+6qfA3PWgmbKbB4eQlyv7QPVSP99LqaRDbp
         kzoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+oQBPFQL5yhYvpb4wkuYUrkpAF1+l3FJ553n5YPcP1I=;
        b=d4QP0Ivujr860fz5SSeJ+aDQVu3ij8uOa4J0a/2jfywZf+uTz9qmhoT23Vj0Nm+jWS
         PlAhqxpSR69qilu2Y7SqMhtQe6jYH+zAJTYXM40Hi/p5XwSPMPQWIh+m+CXoJ35WxVAn
         cTdbt7RuFmcWU1Hlr9FgBzkirV3RyMxsfp4nWq0IwdpntjzoolClqYn3Cde9qp01PMhC
         MWjNdIRtygDRUK6cgElDRsQy9Yci65hV8+JiaELYiSJi4eAZkoJVRqoaHGDbbHmhJFR5
         fhJ2hr3bA7Wty5t+I+Z2jVC10ozzK+NdNlrgAAF9Fmj4J/zNGPRVUKZdMJHf0kFGVVn8
         /ePg==
X-Gm-Message-State: APzg51D9HAVJbFg5f3pl21LNrA7O1wtjsyMiZ0C4CVXh9bONfRxTYybX
        CHohMEAzIMA9g/45SW/5hmB0/SgLDfgvyv8W5dWC
X-Google-Smtp-Source: ANB0VdbSI/P3Dr/314K/QFo/Hno4dHDMO8PQMJzFwQG8pHc1mfdRPsReaj7C73DqVmSrFr2EtAGzXp3ixnW0j1X4D+g=
X-Received: by 2002:a19:d78d:: with SMTP id q13-v6mr6765614lfi.27.1536895148076;
 Thu, 13 Sep 2018 20:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
In-Reply-To: <20180824120001.20771-2-omosnace@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 13 Sep 2018 23:18:56 -0400
Message-ID: <CAHC9VhTZkrmgt7rxNYWTgYvm+TVGgRD6iFu9dDtZ7eYNXBKqHQ@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     omosnace@redhat.com
Cc:     linux-audit@redhat.com, rgb@redhat.com, sgrubb@redhat.com,
        mlichvar@redhat.com, john.stultz@linaro.org, tglx@linutronix.de,
        sboyd@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 8:00 AM Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This patch adds two auxiliary record types that will be used to annotate
> the adjtimex SYSCALL records with the NTP/timekeeping values that have
> been changed.
>
> Next, it adds two functions to the audit interface:
>  - audit_tk_injoffset(), which will be called whenever a timekeeping
>    offset is injected by a syscall from userspace,
>  - audit_ntp_adjust(), which will be called whenever an NTP internal
>    variable is changed by a syscall from userspace.
>
> Quick reference for the fields of the new records:
>     AUDIT_TIME_INJOFFSET
>         sec - the 'seconds' part of the offset
>         nsec - the 'nanoseconds' part of the offset
>     AUDIT_TIME_ADJNTPVAL
>         op - which value was adjusted:
>             offset - corresponding to the time_offset variable
>             freq   - corresponding to the time_freq variable
>             status - corresponding to the time_status variable
>             adjust - corresponding to the time_adjust variable
>             tick   - corresponding to the tick_usec variable
>             tai    - corresponding to the timekeeping's TAI offset

I understand that reusing "op" is tempting, but the above aren't
really operations, they are state variables which are being changed.
Using the CONFIG_CHANGE record as a basis, I wonder if we are better
off with something like the following:

 type=TIME_CHANGE <var>=<value_new> old=<value_old>

... you might need to preface the variable names with something like
"ntp_" or "offset_".  You'll notice I'm also suggesting we use a
single record type here; is there any reason why two records types are
required?

>         old - the old value
>         new - the new value
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/audit.h      | 21 +++++++++++++++++++++
>  include/uapi/linux/audit.h |  2 ++
>  kernel/auditsc.c           | 15 +++++++++++++++
>  3 files changed, 38 insertions(+)

A reminder that we need tests for these new records and a RFE page on the wiki:

* https://github.com/linux-audit/audit-testsuite
* https://github.com/linux-audit/audit-kernel/wiki

-- 
paul moore
www.paul-moore.com
