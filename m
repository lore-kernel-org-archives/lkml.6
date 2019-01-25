Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E292C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40CE4218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 18:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="ZprbfHj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729223AbfAYS1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 13:27:22 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35972 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfAYS1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 13:27:22 -0500
Received: by mail-lf1-f67.google.com with SMTP id a16so7617775lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 10:27:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5j3SrTDqjrzJUVHWaWDZVgyT6+oEkJNhO80FgEy0HCU=;
        b=ZprbfHj7/QDQ4ynJh3seZZUkzS06hw3ptK9Uz4fzmONraUpLrsaw3UANNKtSYXkKZG
         zjB0nnYVo9V4jwNsgsfuwYADmYrf383xOHacQQOlYbyTwEfI3kYaxcx/P0LiORX9c5yH
         TSuw1iEgQVxy4F+zbBg96F1MAMSpKvcEl2LkuLUAdo4AJS7WjDXtlkyG7ZUs2FvCfih7
         cKie06UFfzdXopsykaizJnMfVgU/GxXXocAGwJUcGWndywO8BhUNTnvAyNV7ZhPGdqLq
         rwgBtKDHoDK/uk3KtjHtzxyh5fAT2R9WOHpJKM483VKGiN/7O279OYTnnf9sB2dbY2PO
         3ZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5j3SrTDqjrzJUVHWaWDZVgyT6+oEkJNhO80FgEy0HCU=;
        b=M6w0dPdvfz6eV9YEB8h3DKxbZeqrVoxJMv58A+/n3tWi1Kolwrwks5j2aybT/V/1xl
         PyELhveNk9eEx9RrmX5uoeenJ5Y2aw0tMG1vO9EHJK10LlavujemoVH5qwX4WrwJ2qUZ
         sNcg+zv4aFdmeOUOk2uXUuA1EeIFmG0vC2tX9DvmIvm9VGR/JsM3p0yj7g0lL3LwLFn7
         IfZFv7zzkYpKx3l73oyWXZjCeQT+ZM840UQLUOkogNRtwgSBLk9xApM8S1dhj46uEJtq
         3wBrXlcB8Qvdb95olaTtBXyNpYO1xTxg55fJ7NDCn+rJ1OSJXYaz48E4aOuRHqollTAn
         DLdg==
X-Gm-Message-State: AJcUuke3/2OJY5nnL/rTp0RM4g2nbJ9x6cAivHbz9SpgLZgIpOFhEbWc
        NMHKoZ6DO2AiN4PXiWv6AHRKpbcGRWNVAAaGENo5
X-Google-Smtp-Source: ALg8bN7YAV6epRN3j4RJx9iJ3QI0/OIvMSjglNd2PgcWNmQ6R/FW77MEqr5lEwdMfge+6x2nUCMAAXNuydGYnPWFb9M=
X-Received: by 2002:a19:c995:: with SMTP id z143mr9201551lff.79.1548440839997;
 Fri, 25 Jan 2019 10:27:19 -0800 (PST)
MIME-Version: 1.0
References: <77df427bbfd22e0d901a9a0b2674e8d617b0c8c0.1548192726.git.rgb@redhat.com>
In-Reply-To: <77df427bbfd22e0d901a9a0b2674e8d617b0c8c0.1548192726.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 25 Jan 2019 13:27:08 -0500
Message-ID: <CAHC9VhScR5xLD11n0gHTx-RFjbO9-Su+_aiL7hPMxJ+65AzN1Q@mail.gmail.com>
Subject: Re: [PATCH ghak104 V1] audit: move loginuid and sessionid from
 CONFIG_ AUDITSYSCALL to AUDIT
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Eric Paris <eparis@redhat.com>, Steve Grubb <sgrubb@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 5:07 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> loginuid and sessionid (and audit_log_session_info) should be part of
> CONFIG_AUDIT scope and not CONFIG_AUDITSYSCALL since it is used in
> CONFIG_CHANGE, ANOM_LINK, FEATURE_CHANGE (and INTEGRITY_RULE), none of
> which are otherwise dependent on AUDITSYSCALL.
>
> Please see github issue
> https://github.com/linux-audit/audit-kernel/issues/104
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  fs/proc/base.c        |  6 ++--
>  include/linux/audit.h | 42 +++++++++++++------------
>  include/linux/sched.h |  2 +-
>  init/init_task.c      |  2 +-
>  kernel/audit.c        | 85 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/auditsc.c      | 84 --------------------------------------------------
>  6 files changed, 113 insertions(+), 108 deletions(-)

Looks good, merged.

-- 
paul moore
www.paul-moore.com
