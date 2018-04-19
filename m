Return-Path: <linux-api-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1625563-1524096697-2-9523828130036941677
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org', XOriginatingCountry='US'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-api-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524096696; b=lcVBTqirBWJtMQacW2iqqTHopDRGrywzhpQbqVSxYrhVRUrMpa
    kE60n15XYYUWg2W++Y45XSrcY/k0qRg4YYGDPxtDPeB2xXxtoCMZl8QWvqhabODV
    3kB0WOypO6Z5nYOaZp+r7oyTTmkLSO5AFAN+q5JT8tlyzP9tynXKuzrw/+V+0nUZ
    Gh33+gjeeOVz1ntnB9ecLHJ2HLBCGPpawkMdGAP1QeKwpbieY0xNikqt18VqtJtz
    ONmXyInIRrUZpur8p6h08IKH1887rq3mLQHM+y6hKXO1a09AND6Jz34/h+DtbpM/
    Z5aMl00/Y4sFjqo5/fpFyjd1RfhAkiS7I79w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524096696; bh=7VokH4t0BVfnZNgZ3b9QJdPUgDF3fHQvPAgiPz0Nhb
    A=; b=vV4qaQbR6k97Gw3mb584aYispjQ4ENO0bM2wJjAR9YN9TptAk6IFHZyMtE
    RVk6DA+mvGAxR4/Yw1JT5ZmCdkKTku8GV1xx4+bK8vEuDhhqdT+VKJcJnmm3Oqxn
    WHEoJkt4yCCWHbht0Av32/29raBPBBmLzmcgKUGJBKjr2EJ5Adwav98Kt65uwp/H
    iiTzpibZVsPeW9ROQc4w2dEBAjncypA1ZmCMJxMsxAHIHPq79GnUj8bx4UoCfyDO
    6vm+GawfOCUfosxsqryJKSxcQMZOj8IrVx83hDushrcpC11xhrhcv//yFZX/anrO
    9bOsq32HWBzgn3D7A7RuNSOTYlQA==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=wkxzpr3L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aYCL+GXd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b=wkxzpr3L x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=20150623;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=paul-moore.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-api-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=aYCL+GXd;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=paul-moore.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfIkZNerV/hkNzSZ9dNhS/fTvsmDe6i9WGRB5UOv3Kf9vn/PMqeFLG2rP7eSznVzACfL1/JddblLvAXsO+AtJFj3/58ta2ZrBxuCzFBnSCgYB5sgujBho
    nuS0G+VY/Io1SJIKdbXIUDvG+RX0q+gsYVf0QZ+Hc0Rg029a6sKp2PSEC/owealueonDDcZagGBEfWhxI6/2mTRYWTTt15OdbokvXdwpg2v+M3iqsHvwmzQN
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=EmDd13E5pkEA:10 a=IkcTkHD0fZMA:10
    a=Kd1tUaAdevIA:10 a=20KFwNOVAAAA:8 a=xVhDTqbCAAAA:8 a=VwQbUJbxAAAA:8
    a=ufox_Y_fPFI2tUtwYR8A:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=GrmWmAYt4dzCMttCBZOh:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752705AbeDSALe (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 20:11:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34405 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752391AbeDSALc (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 18 Apr 2018 20:11:32 -0400
X-Google-Smtp-Source: AIpwx4/733PSu7jvzfFcx9RPBffoYz8pZKuGtUagYSiDgw9FHeFkinLNZtMQZoRvw5VFxlZVLKucTJ0H0pSL70429eA=
MIME-Version: 1.0
X-Originating-IP: [108.20.156.165]
In-Reply-To: <995b77557010b2f9aed0e10435f7b8536df7a5db.1521179281.git.rgb@redhat.com>
References: <cover.1521179281.git.rgb@redhat.com> <995b77557010b2f9aed0e10435f7b8536df7a5db.1521179281.git.rgb@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 18 Apr 2018 20:11:30 -0400
Message-ID: <CAHC9VhTSfpXDGg7LeUjh3SvN_GVvAP2f89MHmYKskdzGkR8u6Q@mail.gmail.com>
Subject: Re: [RFC PATCH ghak32 V2 02/13] audit: check children and threading
 before allowing containerid
To: Richard Guy Briggs <rgb@redhat.com>
Cc: cgroups@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-api@vger.kernel.org,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        netdev@vger.kernel.org, ebiederm@xmission.com, luto@kernel.org,
        jlayton@redhat.com, carlos@redhat.com, dhowells@redhat.com,
        viro@zeniv.linux.org.uk, simo@redhat.com,
        Eric Paris <eparis@parisplace.org>, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-api-owner@vger.kernel.org
X-Mailing-List: linux-api@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 5:00 AM, Richard Guy Briggs <rgb@redhat.com> wrote:
> Check if a task has existing children or co-threads and refuse to set
> the container ID if either are present.  Failure to check this could
> permit games where a child scratches its parent's back to work around
> inheritance and double-setting policy.
>
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 4 ++++
>  1 file changed, 4 insertions(+)

I would just include this in patch 1/2 as I can't think of world where
we wouldn't this check.

> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index 29c8482..a6b0a52 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2087,6 +2087,10 @@ static int audit_set_containerid_perm(struct task_struct *task, u64 containerid)
>         /* if we don't have caps, reject */
>         if (!capable(CAP_AUDIT_CONTROL))
>                 return -EPERM;
> +       /* if task has children or is not single-threaded, deny */
> +       if (!list_empty(&task->children) ||
> +           !(thread_group_leader(task) && thread_group_empty(task)))
> +               return -EPERM;
>         /* if containerid is unset, allow */
>         if (!audit_containerid_set(task))
>                 return 0;
> --
> 1.8.3.1

-- 
paul moore
www.paul-moore.com
