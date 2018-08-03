Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC79C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:04:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7710E2175E
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 12:04:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pVk8gcxI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7710E2175E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbeHCOAm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 10:00:42 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37375 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727291AbeHCOAl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 10:00:41 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so4765926ioh.4;
        Fri, 03 Aug 2018 05:04:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=IWZFpt2v+ZJeRjcN1DdHflvJmkseiyOFn7IpefOwjdQ=;
        b=pVk8gcxIQphmIBWYzf83zJ2rOBrMcczwmNYa6y4Gs6qLcgwHuRAwv4LsYnfSXQX99o
         ZVvagq4vJjKma227i+2KfrUNrcvQ+tNJ5Zk7tnYm1hdXF7o7xA10llHQKD2I41W1bc/K
         o3qpv+O4QjP55nWtOM5vKgtDY7wwV/SohRgePlO9/AdDH6ffqSXb/crVOVW3iCzLdW46
         GJyyek7oeMtqwXFAvlak7pjtKLz8+yqTb9CDYG5sScpzBuCWEdnZVV8/i6fQUbr5TwUi
         LHXCyge7qpMbeoC17CG6DyHrfBQZ1pr1sbZeaWDVQjUfaO3dzQhVS8rlbo/+8YpR8DR2
         FvbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=IWZFpt2v+ZJeRjcN1DdHflvJmkseiyOFn7IpefOwjdQ=;
        b=B2zbnkjg27NKRhncLRoVQOJAWSTP0F3mX169elQzvKLd1TK8ud7vU6+aey5IZwxIVz
         CDJstyA8r43Obog6kMxHNdKwHD0Ftl+xmrSRYznVNM5m5E3i0xDTIDAdJBvT9dGU5XgH
         bMlZO9ZCSZWqcTeShUgWRCpEVVKNQnHGA3zncxShjNnRe3Oq5uvgHJTRb3yufLl1l/oc
         aSnEUjluKJy3D1KO4rRNtohQxzx8q2aDnMmhjsigcl+cF/3FWQmrdB4nI6M3IYW3UKo3
         2YN5xddTdYF67LMWw7q0D2FvQc9wwQ91zObVgv333e5R5LOTpJBJQnZc6JOxfGFl4Or5
         e2oQ==
X-Gm-Message-State: AOUpUlEY03wTJ3sPf2KRuYiNBnwmP2ZVYX+76oV2NyCy2uA4C3vCVzQ+
        /s6CwVcLkj7cTdMoo3jKaVAJUfKgPeenh93XYqKI0w==
X-Google-Smtp-Source: AAOMgpclWfnyE6UQoqv3rnvmFOQgacxJS3zCU+RbMoxDLTPexGn2PBMpUUz6xPC0qmKyX06Odq/KJGC5RkgBa6J/+mY=
X-Received: by 2002:a6b:f40b:: with SMTP id i11-v6mr5666577iog.162.1533297878843;
 Fri, 03 Aug 2018 05:04:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ad5:40cb:0:0:0:0:0 with HTTP; Fri, 3 Aug 2018 05:04:38 -0700 (PDT)
In-Reply-To: <CAGXu5jJ+mZyqq0WoNNuw96X9ukOuaHaEqX4PJL31PuSecZZDwQ@mail.gmail.com>
References: <20180629184818.GA37439@beast> <20180629212047.GH24526@jcrouse-lnx.qualcomm.com>
 <CAGXu5jJ+mZyqq0WoNNuw96X9ukOuaHaEqX4PJL31PuSecZZDwQ@mail.gmail.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 3 Aug 2018 08:04:38 -0400
Message-ID: <CAF6AEGtDbi05iM3ubqCNHzXKd=rLscfpVrj9SwygVcAsJdqZpw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/adreno: Remove VLA usage
To:     Kees Cook <keescook@chromium.org>
Cc:     Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 2, 2018 at 7:24 PM, Kees Cook <keescook@chromium.org> wrote:
> On Fri, Jun 29, 2018 at 2:20 PM, Jordan Crouse <jcrouse@codeaurora.org> wrote:
>> On Fri, Jun 29, 2018 at 11:48:18AM -0700, Kees Cook wrote:
>>> In the quest to remove all stack VLA usage from the kernel[1], this
>>> switches to using a kasprintf()ed buffer. Return paths are updated
>>> to free the allocation.
>>>
>>> [1] https://lkml.kernel.org/r/CA+55aFzCG-zNmZwX4A2FQpadafLfEzK6CC=qPXydAacU1RqZWA@mail.gmail.com
>>
>> Thanks for doing this.
>>
>> Acked-by: Jordan Crouse <jcrouse@codeaurora.org>
>
> Hi Rob,
>
> Is this something you can take via your tree?
>

Oh, sorry, I missed this one, I'll pick it up shortly..

BR,
-R
