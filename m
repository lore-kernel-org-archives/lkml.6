Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF8AC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:10:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2AF4214C4
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 02:10:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uJ5B2Cxx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AF4214C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbeHPFFo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 01:05:44 -0400
Received: from mail-pf1-f170.google.com ([209.85.210.170]:41341 "EHLO
        mail-pf1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731034AbeHPFFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 01:05:44 -0400
Received: by mail-pf1-f170.google.com with SMTP id y10-v6so1281658pfn.8;
        Wed, 15 Aug 2018 19:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=niriNrNKbzF8IjjLOKh2YdIi99OoU54/ADjk/iIuLo4=;
        b=uJ5B2CxxXfGS9zE/sY7Q8kufXskDmNCJs2dNqVwVN1ehOrwE42rC99S8cdQDwHaC9W
         s5DC0V+rUDKQp4VmSw3aWdsCOL5nJDc/5hr9BJ4MCZUB6a68GpU7yj1asu3+yWexIIWi
         sZWyC9P7Ml8C+3BbYzyyx6dpJGQh4owYEtSCx/yMDGSD0AinuSaLyn82grDeuZMM4CGb
         wIIsSlVGtHKSxsAZMMPTKrgran57L9xPXU3bVFHcCo0/3bOEcyCNSulS5BJ4hF1KL8mm
         2jQ+FjKr31oYAMaxEV2U7GWkgO6IUhr0+xw/FBUskyxTr1daMyrb1GH67SX9roR1yIJd
         rP/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=niriNrNKbzF8IjjLOKh2YdIi99OoU54/ADjk/iIuLo4=;
        b=Nol0jUF12E9RhLMsAW8lAx1eyrUg6dJ36bmEK2SV8GtMH8DycjsTMJAP1jxQ6uSShT
         1bGIpNghIxj8yTCGT/gbZv+YUdcZkieEVa7w93cu+MfDFP8lYbXBgOHDH3tVqrYTxw/Y
         Oc+gfaCxas7kg4TlAIgV0mwtfgpldjsvNPWff3QMCWl+Zf5g1fncZq7wcfRpKXi92Q7W
         SaQJ/WyY30muVZU3C1HR+ZGTva947+nBeY8i9NQDo/c40U9RPXDijosg2Jn5G05aDS3+
         3dwXzxNI4QDfvkQupoCP55WtZQm6SubBQg+Y1eSS9ykz/FXJijWxnoaLD3avD9qJPEhH
         Z79g==
X-Gm-Message-State: AOUpUlFmqrjX2JQug0nBtvagxAv1IjT2dH101ExfxzJoYzcA4gwLvHrS
        BtarzhLIxUi+f7SSeSa8rTEnZRtY
X-Google-Smtp-Source: AA+uWPzHCXvp++7n+5oRVYAQcqHwt7jetU7Gix0o2M0H5RZ1twWLCBzsVzBGnYPflsHxbfAJbYu/ew==
X-Received: by 2002:a62:d417:: with SMTP id a23-v6mr4562875pfh.144.1534385441580;
        Wed, 15 Aug 2018 19:10:41 -0700 (PDT)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:180::1:184a])
        by smtp.gmail.com with ESMTPSA id 143-v6sm39559803pfy.156.2018.08.15.19.10.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Aug 2018 19:10:40 -0700 (PDT)
Date:   Wed, 15 Aug 2018 19:10:38 -0700
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Andrew Lutomirski <luto@kernel.org>
Cc:     dhowells@redhat.com,
        Linus Torvalds <torvalds@linux-foundation.org>, ast@kernel.org,
        Laura Abbott <labbott@fedoraproject.org>,
        linux-kernel@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        Kernel Fedora <kernel@lists.fedoraproject.org>,
        daniel@iogearbox.net
Subject: Re: Kernel lockdown patch & IPAddressAllow/IPAddressDeny systemd
 feature with Secure Boot
Message-ID: <20180816021037.6yxi5rqolhqxipza@ast-mbp.dhcp.thefacebook.com>
References: <20180807212531.25161.63476@mailman01.phx2.fedoraproject.org>
 <CALeDE9ORLoyiUcf8Bmwr2rPyo7-3d8Fo54WuPGWtv4ByE_JG=Q@mail.gmail.com>
 <CAObL_7GOOQ01NPf4y1MqRJh4S=CYV8NPmEGTbkrTcjrfUKc5LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAObL_7GOOQ01NPf4y1MqRJh4S=CYV8NPmEGTbkrTcjrfUKc5LA@mail.gmail.com>
User-Agent: NeoMutt/20180223
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 14, 2018 at 07:14:00AM -0700, Andrew Lutomirski wrote:
> [Removed Fedora devel list because it's subscriber-only]
> 
> > On Aug 8, 2018, at 12:29 AM, Peter Robinson <pbrobinson@gmail.com> wrote:
> >
> > Probably a good idea to cc: this to the kernel list :-)
> >
> > I suspect it's intentional but with the planned changes for iptables
> > etc to be backed by bpf in the upstream kernel sometime in the future
> > it's likely going to need to be reviewed.
> >
> 
> I thought this got covered in review. I think this part of lockdown
> needs to get reverted or fixed ASAP.

I don't see lockdown in Linus's tree. Is this fedora only issue?

> (I definitely brought up multiple issues with the bpf lockdown stuff.
> It's clearly extremely broken right now in the "new kernel breaks
> *current* Linux distro" sense.)

+1

