Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCB2C6778A
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB5F20BEC
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 03:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kzxQ2UJz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB5F20BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732465AbeGKDlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 23:41:55 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37908 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732419AbeGKDlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 23:41:55 -0400
Received: by mail-lj1-f195.google.com with SMTP id p6-v6so18291347ljc.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jul 2018 20:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MjmFwkbo3ChkFFstgaC428NnuNyXRaBj9zzqvDVpaIw=;
        b=kzxQ2UJzkwUpQ7iBr9dp2kvLbRA4D0+VhRdafplvEhlU+8C52IhK+qEfhKoPIIfkz3
         QXMWbyPSeNsumB1fk4OmbnDZZ7k+YxzTbYhDYHLFCozMNCrhC6a8PKBGm47h73p1AinN
         uD5DM5o1bnb4pwagpTJLgY0Su5WU3jQ9drcXeXVOhNKIfZLUqNFL6vzBqBganvkZLKgZ
         Sl/sGyJUNFgTM8AOf1RpizbneHFTrFMDtqHh6r2FmTsVga5IwYSLrtLuOLaWbFVvsM2a
         mLOSZsleWL/MvmrOCuuX50z9CHbWPpip7tqb/TH3YxDff6VpFgTDRXKssJ3xdlYH0Kau
         YUyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MjmFwkbo3ChkFFstgaC428NnuNyXRaBj9zzqvDVpaIw=;
        b=q/H1gKr0qVI+wDGoYr2eeHolKKIKZEW8UuJm0r8LmOTMfYIIpg52Zaa/6seaK97THH
         NEUPz+NGVBk4WeK7QTptzFzVySfCHLM4loxANBxScRb9w9kpTcYKxTLNhWLB4xm4aEd7
         cZgnPX1Y1F3StXVBoinIJsVaoOUDdJVxniGbBigM8KdGFVRmSIqSzrMeOtQZUMedAsIm
         6z5xZ+U0u0Q/sPIbWhbON7P80UBny4eE51wlUfbdTMXZ+3iOrVQCloDrxDiXeth61M7d
         K12eIMMK0q8w/WTDn5mbKWXuXm3RnDqqlT3SWV7ooN4WDc2BYb1YbZLhcBDupX9PiuIa
         nT8w==
X-Gm-Message-State: APt69E1riueXPA+c/rU2UGQeoF/pmE3EJb5weEDwn/VPoe4fnIglVVRG
        Q/pdjkdvv6lqAjZElIQm7py9lY8VehREG+rp+FI=
X-Google-Smtp-Source: AAOMgpcPU/IGQ0I5qHR4Z/PzHXPIM8p+4fEz+PAfXqGuIGHfZF0Tyl+BRC08QAVrjxCcDb+FpNZ0jEWxUQlwrjcyH3k=
X-Received: by 2002:a2e:9941:: with SMTP id r1-v6mr17718930ljj.53.1531280380855;
 Tue, 10 Jul 2018 20:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <1531217988-33940-1-git-send-email-ufo19890607@gmail.com>
 <1531217988-33940-2-git-send-email-ufo19890607@gmail.com> <20180710120816.GJ14284@dhcp22.suse.cz>
In-Reply-To: <20180710120816.GJ14284@dhcp22.suse.cz>
From:   =?UTF-8?B?56a56Iif6ZSu?= <ufo19890607@gmail.com>
Date:   Wed, 11 Jul 2018 11:39:29 +0800
Message-ID: <CAHCio2jQO58+npS269Ufyg17unHUeKDRpVjS4-ggBEV8xFMMqQ@mail.gmail.com>
Subject: Re: [PATCH v13 2/2] Add oom victim's memcg to the oom context information
To:     mhocko@kernel.org
Cc:     akpm@linux-foundation.org, rientjes@google.com,
        kirill.shutemov@linux.intel.com, aarcange@redhat.com,
        penguin-kernel@i-love.sakura.ne.jp, guro@fb.com,
        yang.s@alibaba-inc.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Wind Yu <yuzhoujian@didichuxing.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michal
Sorry , I l forget to update the changlog for the second patch, but
the cpuset information is not missing.  Do I still need to make the
v14  or just update the changelog for v13?

Thanks
