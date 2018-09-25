Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73DFAC43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A09E20880
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 20:22:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="w5eb11kr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A09E20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726706AbeIZCbt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 22:31:49 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37489 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeIZCbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 22:31:49 -0400
Received: by mail-oi1-f193.google.com with SMTP id n1-v6so2627821oic.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 13:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+RsP1YWy/+85yH5m6ZF3EeMOB34juFDKmKvaVyR9M0=;
        b=w5eb11krjyvyLZxXZVsupg/enoWXMkhGPL4+N2qvmyHbmueJxVliQOk2XLkNCz8HhD
         FtjCVZMpwLBxUSszSY8h09ejUZtA67B2pY9r9WSquA1SqXIDI9lITkNY9SCbba2jTXLO
         zi5DKO34RzMCxbFl9qumERCH3JjP2dhiPt4QaLeBQ90Iqc8s270w4A2k/qD3wDtlSs0Y
         5fJn9yw7htchhD8pa9EfJBf+0OKALjkXofKr2QPTpxehmbB3JmEQ8FNWyZVDSgjO8HBW
         UH55WV28wuZRYLsa+sTJJlbmWxXKI/Ibw6TV/zJXAL/aPBx+n7oXBQ6A2He1n20G1WsM
         HrDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+RsP1YWy/+85yH5m6ZF3EeMOB34juFDKmKvaVyR9M0=;
        b=onXo2MS170Q5jQXJ+hgbKprFQ44bzo9OhOtgomngGFOWVdsfcX/mZz+wOPhWBQ09kv
         RIZu/oYN7fJBE5tziz8QtfmUK5/RSEgdm+1C2cAPISHpN8VrlYo1vqi/WIYgNncCf22j
         pq+NOOlAoUC/Kid4HAs29Ocj9Xn0Ai7SPBspNnqShYTvwjE89Nf0iLhkJnfCP2lZcJbe
         zVfvtSwDGjcJK+qJu45YQEgXpjXG3Yx22cxOu8BYSxT/m1JI53EKpeusawFCsDtE4+ML
         9YH+ZYkMGUU0C+VtjgYtM8b+MP//Dcke4U257q4TLTwWCbwjG/UYlya9VOuVRoWolDKI
         vVRA==
X-Gm-Message-State: ABuFfoh24lF0lP/cFpskt2ocXKwJWiftT3j5IE1Vx4R0Pz+2F3LpJL+v
        MaSbwJSGGitqGlXEYgdJLVHQZKc9+KCmya1tvyUgcw==
X-Google-Smtp-Source: ACcGV60qVuYsEUv6knl/IVV9svwlpGJlVXdXnObFVzAeSrJQ8CPSjzFdCONUHpMYDVx30a/qNY+GFm/vQZHi4fPE0Os=
X-Received: by 2002:aca:ce4c:: with SMTP id e73-v6mr1641230oig.225.1537906952298;
 Tue, 25 Sep 2018 13:22:32 -0700 (PDT)
MIME-Version: 1.0
References: <153622549721.14298.8116794954073122489.stgit@warthog.procyon.org.uk>
 <153622556444.14298.5971956747198405225.stgit@warthog.procyon.org.uk>
In-Reply-To: <153622556444.14298.5971956747198405225.stgit@warthog.procyon.org.uk>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 25 Sep 2018 13:22:21 -0700
Message-ID: <CAPcyv4jjxh955mWEubnGiENVQVeCcZ9YWv8YPBKfWMw-gh1z2w@mail.gmail.com>
Subject: Re: [PATCH 09/11] UAPI: ndctl: Fix g++-unsupported initialisation in
 headers [ver #2]
To:     David Howells <dhowells@redhat.com>
Cc:     Linux API <linux-api@vger.kernel.org>,
        linux-kbuild@vger.kernel.org,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 6, 2018 at 2:19 AM David Howells <dhowells@redhat.com> wrote:
>
> The following code in the linux/ndctl header file:
>
>         static inline const char *nvdimm_bus_cmd_name(unsigned cmd)
>         {
>                 static const char * const names[] = {
>                         [ND_CMD_ARS_CAP] = "ars_cap",
>                         [ND_CMD_ARS_START] = "ars_start",
>                         [ND_CMD_ARS_STATUS] = "ars_status",
>                         [ND_CMD_CLEAR_ERROR] = "clear_error",
>                         [ND_CMD_CALL] = "cmd_call",
>                 };
>
>                 if (cmd < ARRAY_SIZE(names) && names[cmd])
>                         return names[cmd];
>                 return "unknown";
>         }
>
> is broken in a number of ways:
>
>  (1) ARRAY_SIZE() is not generally defined.
>
>  (2) g++ does not support "non-trivial" array initialisers fully yet.
>
>  (3) Every file that calls this function will acquire a copy of names[].
>
> The same goes for nvdimm_cmd_name().
>
> Fix all three by converting to a switch statement where each case returns a
> string.  That way if cmd is a constant, the compiler can trivially reduce it
> and, if not, the compiler can use a shared lookup table if it thinks that is
> more efficient.
>
> A better way would be to remove these functions and their arrays from the
> header entirely.
>
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Dan Williams <dan.j.williams@intel.com>

Acked-by: Dan Williams <dan.j.williams@intel.com>

...again let me know if you'll take this with g++ series or want me to
carry it directly.
