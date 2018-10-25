Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1D47C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ACC22083E
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 06:13:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore-com.20150623.gappssmtp.com header.i=@paul-moore-com.20150623.gappssmtp.com header.b="WTdskzKt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ACC22083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=paul-moore.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbeJYOo3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 10:44:29 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55744 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbeJYOo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 10:44:28 -0400
Received: by mail-wm1-f68.google.com with SMTP id s10-v6so211303wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 23:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:date:message-id:in-reply-to:references:user-agent
         :subject:mime-version:content-transfer-encoding;
        bh=TMF1WecmC4fdwHeof+RHLJnx3futXU4PQmc4Hc5cFrU=;
        b=WTdskzKtzlOzJnQASNdBHvoaEiUmEOxd/IHSLfY6cO0+Njy2Nui4xBRVyi9bKDocku
         RJ12b3OnSrDfbNDYQ3RXKRyc+WX4Czk5/zumBCZcMcp/NQbYnoO2bOatKRKZs6joulXt
         1BxPqLB5r12G3ayqUIctp78gBofyzXBvIZXttMXeoVQG7couXOWtJVF/wxjYaMcFThAV
         anvJbNUYQyDniUr3QIS3EdDP0+zolk/GFiE2R7ehwhzH8uS5IG4ompJBWKUKmeCAeHIV
         f+aitDx39eHurrQgQLaZ+JAEqKpOws0qMFZG4ehz+AA29HnuIWOoGwvTuXh3zYTU96Og
         gvqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:subject:mime-version
         :content-transfer-encoding;
        bh=TMF1WecmC4fdwHeof+RHLJnx3futXU4PQmc4Hc5cFrU=;
        b=UDDfcTnjyUvfYzQAH+mPACfQbtIgmDlpb1yhsuWVSNYhRlZI3UCs1Oy62bpz3tViUq
         j5oOceeZ6C2SJPBjMenj3mfa4r8azQjMwEMZwD4oJPZmyGtDAeGuA5ul+L4+SXMeG+Aj
         8vmleaotvrKPQNQLq+26vcXsK2PojcstGjXkfgu9w5suD0ogoHKIP+46RXIASQevQrCJ
         xhBRACn5jbV1NpWiGHFFq8us4DCjUpAxjNP83XJJXyH3oBlRV32rfwEzz5jtmjk20DJn
         v9Ho8KSJeMXQ4LHfNULOV4ec6FVsJXhdSCOSt+G12CptbXJ++TPyxJaH0ppEn8hsEaxF
         Z3kg==
X-Gm-Message-State: AGRZ1gKf3MM5hxfNbt5Fux4jwwTFMW6qd7zU8xZXDIKyAPtoQX8FY6tV
        dcdpY0Sw+iQCkMSsamlLYiYG
X-Google-Smtp-Source: AJdET5d0dGtBhI4oarSE5y9BU/V3eA7TcOwr+VLSvWjZymHvSci2DYbZe+xJs6oq6nkS0vgJM9cm4g==
X-Received: by 2002:a1c:2c87:: with SMTP id s129-v6mr316012wms.127.1540447991131;
        Wed, 24 Oct 2018 23:13:11 -0700 (PDT)
Received: from [172.20.9.39] ([167.98.65.38])
        by smtp.gmail.com with ESMTPSA id z13sm7110394wrw.15.2018.10.24.23.13.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Oct 2018 23:13:10 -0700 (PDT)
From:   Paul Moore <paul@paul-moore.com>
To:     Richard Guy Briggs <rgb@redhat.com>
CC:     <containers@lists.linux-foundation.org>,
        <linux-api@vger.kernel.org>, <linux-audit@redhat.com>,
        <linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <netfilter-devel@vger.kernel.org>,
        <ebiederm@xmission.com>, <luto@kernel.org>, <carlos@redhat.com>,
        <dhowells@redhat.com>, <viro@zeniv.linux.org.uk>,
        <simo@redhat.com>, Eric Paris <eparis@parisplace.org>,
        Serge Hallyn <serge@hallyn.com>
Date:   Thu, 25 Oct 2018 07:13:07 +0100
Message-ID: <166a9dae538.280e.85c95baa4474aabc7814e68940a78392@paul-moore.com>
In-Reply-To: <20181025004255.zl7p7j6gztouh2hh@madcap2.tricolour.ca>
References: <cover.1533065887.git.rgb@redhat.com>
 <34017c395d03a213d6b0d49b9964429bd32b283d.1533065887.git.rgb@redhat.com>
 <CAHC9VhSv4hWGHiaaOfuBrRQKdp2YG5RtqXQbFXg7j7LNEhO2XQ@mail.gmail.com>
 <20181024151439.lavhanabsyxdrdvo@madcap2.tricolour.ca>
 <CAHC9VhRF1vsxM-k0Lw-9NqS9b9rgXRRBu0tq4ajdFpMqUxiH4A@mail.gmail.com>
 <20181025004255.zl7p7j6gztouh2hh@madcap2.tricolour.ca>
User-Agent: AquaMail/1.17.0-1318 (build: 101700009)
Subject: Re: [PATCH ghak90 (was ghak32) V4 03/10] audit: log container info of syscalls
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On October 25, 2018 1:43:16 AM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-10-24 16:55, Paul Moore wrote:
>> On Wed, Oct 24, 2018 at 11:15 AM Richard Guy Briggs <rgb@redhat.com> wro=
te:
>>> On 2018-10-19 19:16, Paul Moore wrote:
>>>> On Sun, Aug 5, 2018 at 4:32 AM Richard Guy Briggs <rgb@redhat.com> wro=
te:
>

...

>
>>>> However, I do care about the "op" field in this record.  It just
>>>> doesn't make any sense; the way you are using it it is more of a
>>>> context field than an operations field, and even then why is the
>>>> context important from a logging and/or security perspective?  Drop it
>>>> please.
>>>
>>> I'll rename it to whatever you like.  I'd suggest "ref=3D".  The reason=
 I
>>> think it is important is there are multiple sources that aren't always
>>> obvious from the other records to which it is associated.  In the case
>>> of ptrace and signals, there can be many target tasks listed (OBJ_PID)
>>> with no other way to distinguish the matching audit container identifie=
r
>>> records all for one event.  This is in addition to the default syscall
>>> container identifier record.  I'm not currently happy with the text
>>> content to link the two, but that should be solvable (most obvious is
>>> taret PID).  Throwing away this information seems shortsighted.
>>
>> It would be helpful if you could generate real audit events
>> demonstrating the problems you are describing, as well as a more
>> standard syscall event, so we can discuss some possible solutions.
>
> If the auditted process is in a container and it ptraces or signals
> another process in a container, there will be two AUDIT_CONTAINER
> records for the same event that won't be identified as to which record
> belongs to which process or other record (SYSCALL vs 1+ OBJ_PID
> records).  There could be many signals recorded, each with their own
> OBJ_PID record.  The first is stored in the audit context and additional
> ones are stored in a chained struct that can accommodate 16 entries each.
>
> (See audit_signal_info(), __audit_ptrace().)
>
> (As a side note, on code inspection it appears that a signal target
> would get overwritten by a ptrace action if they were to happen in that
> order.)

As requested above, please respond with real audit events generated by this=
 patchset so that we can discuss possible solutions.

--
paul moore
www.paul-moore.com



