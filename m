Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D0AECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AFD2082B
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 07:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="T1nvellw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AFD2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728131AbeJ1Qhv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 12:37:51 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38101 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728098AbeJ1Qhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 12:37:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id k11-v6so4858750lja.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 00:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kuPtY+ZtKT0P2eAJ2ZJMRLl5qcsUtziYwBL9mBEsRyg=;
        b=T1nvellwdNlzjx449QlLB3YprrOk91Vp9PDyrfRFrL0UywbMLC2hwRGMxUOZkCamIN
         tzug/Swonu0xSR6o9c17U8sFbfc0FqRqg/EsY1YZOpPSno4ykJRce44iLTvQw7mm4MzI
         wjyUkakCnG97uhOAErIgegoAwhbv3YyvnVIuV1zS2wP4RsZaaLq+W4cugFr/9ykE+WW/
         IWvxaGTt5oSUnePXNYrWbTna3AqLuSwbT2WJISJsm+c7jTtIzVk8y3vPuaNV1yqrLGSW
         ash1wwTbmsVeAGtltRemnusrhEDW2rgMnU9mvxY2nhv4YyrrGgZailWF8eAnFIgilv0F
         U6+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kuPtY+ZtKT0P2eAJ2ZJMRLl5qcsUtziYwBL9mBEsRyg=;
        b=ZfUCu8q14Bszs2Z9hE0t/fCyxwp8AcS4WyME+p4NNUN5DBaK7sS0jjZnlSErXZu8cP
         cP9rISJoRSWvr70EIVW1kOLbJvlMDG/c2tNlaehxZuCjp1ydTEhmy7VNOVLCYTfl45RT
         Iki6sl0T/N+A40ryfoBA/2Lt9RrzOsvk40OwgmxgTAmD6+jW1CynCXlhNR+Ygcyj6Ojc
         kDD/K+C/IWxvym0uDFVltEB5g+VXu7i7oykrqFZL2vPdzvkmDJH7GLj6XgzpZyrGEEpn
         F0lIq1cQv0D5jqtFO68SsgCd5Ax2ZGbHypqNnyiM8bzTp+oXv7T6OP/Cmm0D6DaNvPD4
         JTNQ==
X-Gm-Message-State: AGRZ1gKwbL4uRN+CvKEzl6o6uFDE9tbiHu9rpoEdAOs3CJLUNPe9SfXX
        RWwERnuFHGlspBem/SJ174Cki/rF3QmiOPkd0aby
X-Google-Smtp-Source: AJdET5eBO/5ePa2M167RJ4V2QTX6l6B99k16Nc05AVNlJiC36mxTeEBw2RJFrw4+szshXVDUbcWNtC93Xo/fj2lpbP8=
X-Received: by 2002:a2e:8884:: with SMTP id k4-v6mr6271463lji.145.1540713235602;
 Sun, 28 Oct 2018 00:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533065887.git.rgb@redhat.com> <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
 <CAHC9VhSv4hWGHiaaOfuBrRQKdp2YG5RtqXQbFXg7j7LNEhO2XQ@mail.gmail.com>
 <20181024151439.lavhanabsyxdrdvo@madcap2.tricolour.ca> <CAHC9VhRF1vsxM-k0Lw-9NqS9b9rgXRRBu0tq4ajdFpMqUxiH4A@mail.gmail.com>
 <20181025004255.zl7p7j6gztouh2hh@madcap2.tricolour.ca> <20181025080638.771621a3@ivy-bridge>
 <CAHC9VhR02siURgadQs0EikcOm0d_TPAi4jJYCx4NkA=wQ5rjSA@mail.gmail.com>
 <20181025122732.4j4rbychjse3gemt@madcap2.tricolour.ca> <20181025175745.5b2b13e9@ivy-bridge>
 <20181025173830.4yklhnrydt5qvr67@madcap2.tricolour.ca> <CAHC9VhScaG8aOFYRV5hPXEKob1QRth5YFEbHNY=ZgKKAKxBBsQ@mail.gmail.com>
 <20181025235527.15a39d75@ivy-bridge> <e1d8a8cf-5013-ffbe-923b-604851de836d@schaufler-ca.com>
In-Reply-To: <e1d8a8cf-5013-ffbe-923b-604851de836d@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Sun, 28 Oct 2018 03:53:44 -0400
Message-ID: <CAHC9VhREHOMD2LrKyeN0HJLOVMPnz9kUNiv5d24omQYkXoVSBw@mail.gmail.com>
Subject: Re: [PATCH ghak90 (was ghak32) V4 03/10] audit: log container info of syscalls
To:     casey@schaufler-ca.com
Cc:     sgrubb@redhat.com, luto@kernel.org, rgb@redhat.com,
        linux-api@vger.kernel.org, containers@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        dhowells@redhat.com, carlos@redhat.com, linux-audit@redhat.com,
        netfilter-devel@vger.kernel.org, ebiederm@xmission.com,
        simo@redhat.com, netdev@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 26, 2018 at 4:13 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
> On 10/25/2018 2:55 PM, Steve Grubb wrote:
> > ...
> > And historically speaking setting audit loginuid produces a LOGIN
> > event, so it only makes sense to consider binding container ID to
> > container as a CONTAINER event. For other supplemental records, we name
> > things what they are: PATH, CWD, SOCKADDR, etc. So, CONTAINER_ID makes
> > sense. CONTAINER_OP sounds like its for operations on a container. Do
> > we have any operations on a container?
>
> The answer has to be "no", because containers are, by emphatic assertion,
> not kernel constructs. Any CONTAINER_OP event has to come from user space.
> I think.

It is very important that we do not confuse operations on the audit
container id with operations on the containers themselves.  Of course
at a higher level, e.g. audit log analysis, we want to equate the two,
and if the container runtime which manages the audit container id is
sane that should be a reasonable assumption, but in this particular
patchset AUDIT_CONTAINER_OP is referring to operations involving just
the audit container id.

If there is a need for additional container operation auditing (note
well that I did not say audit container id here) then those audit
records can, and should, be generated by the container runtime itself,
similar to what we do with libvirt for virtualization.

-- 
paul moore
www.paul-moore.com
