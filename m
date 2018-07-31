Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B44DBC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:57:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B009208A2
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 12:57:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hkK0ws9r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B009208A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbeGaOiH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 10:38:07 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:33570 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbeGaOiH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 10:38:07 -0400
Received: by mail-ua0-f194.google.com with SMTP id i4-v6so10187547uak.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jul 2018 05:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=2QtDAhDj6ye+TTgcNsBXm/BP8zkAOj6gJk4E+XRptSk=;
        b=hkK0ws9rZ4aw3Rn125gRl5L0XDGAZBmA1z6DCRug6JOa5Rm0MlA02RTt9bzVxmEUMe
         d4hT+XX23aHZWa9UEXkCADtaVLE5vHxeCmVw8R5rz5f/aoXi3HgFQRfoZD0YJcMufinn
         PisI+UYDEbLKldeTSgLL8QWfgNMDgOZGwMIYi5KoEaADXzbOh/lkHE4V2U9LAP6JTHSo
         V+oG1aNOaZxtz+df+TCAwaJkFJM2/sX4wRaywYL7Dw3C+BGR8eR5uEesaUi1qSKIuLzz
         XAUKirU9Qc/cVm1xdUdHKaJ4mjCB8KCz7Almaxx4oR22RVPuAPvnJhuNO77RT7pJkV0Q
         TU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=2QtDAhDj6ye+TTgcNsBXm/BP8zkAOj6gJk4E+XRptSk=;
        b=cs7bQiIEDzbNkNlNF8h08+Al2qRR0K82bGZWAkakq8rvPW8V44tvVzjrGb6yFyPnSp
         ALVxobvrjG4mbZD7XATlfwxPPDgtZLZTYErvSKT1LPgn7zDLUGzu0lLOi+XdgitSmcBS
         mAvmNQclrNKfSyl/M887Gdgt4wE7k/et1cVgNgCRoXtvdbPjF6KZroGxNLQ0W4VI1x2C
         lfUsZsm7Wz8chNocXh626t0FmFrfyNOe4QaQYT7AvS8l6qNPv+Y1dpQzPfVid9Ltdyep
         8p8f4VqVaiOp9pTnfdaAodIb7vx/5cJYcADiYzxXFBsK7Wo/sGib3SIUe33JZ9bo/upS
         7TrQ==
X-Gm-Message-State: AOUpUlGWT7KEKWb37bkC7vqIOtXyoiXXHlf5uaa9D7WDtMMwDwslYp5Y
        MlROSCXz1kqU38yS+KZbY1ZddWtN5nbT9VAY1g==
X-Google-Smtp-Source: AAOMgpd67ymLBqzPTCL7afiu5NyW4TcziQBTPdMZxEKD6BPpwZjkB/ImufKBnEAuG9bDXPo1Id/+ePPbJRoCgn/f0iY=
X-Received: by 2002:a9f:3242:: with SMTP id y2-v6mr15125000uad.85.1533041874323;
 Tue, 31 Jul 2018 05:57:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:e915:0:0:0:0:0 with HTTP; Tue, 31 Jul 2018 05:57:33
 -0700 (PDT)
Reply-To: whiteheadm@acm.org
In-Reply-To: <7c274466-6d93-d1ba-8721-4d69f847b40f@redhat.com>
References: <20180730194059.5781-1-tedheadster@gmail.com> <7c274466-6d93-d1ba-8721-4d69f847b40f@redhat.com>
From:   tedheadster <tedheadster@gmail.com>
Date:   Tue, 31 Jul 2018 08:57:33 -0400
Message-ID: <CAP8WD_aP5-bh=+NrJV8a3BCMbQK_PyJD88PGRuU8Qh_exFBy9w@mail.gmail.com>
Subject: Re: [PATCH] x86: kvm: Restrict X86_FEATURE_VMMCALL to x86_64 platform
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This shouldn't be necessary; for systems that don't have virtualization
> extensions, the comment explains why setting X86_FEATURE_VMMCALL is safe.
>
> But it is also wrong, because you can run a 32-bit kernel as a guest on
> a 64-bit processor, and then it should set X86_FEATURE_VMMCALL because
> the processor has the vmmcall instruction and not Intel's vmcall.
>

Paolo,
  I'm running this on a bare metal machine (no virtualization) with a
32-bit AMD i486 class cpu. Should the feature be showing up in
/proc/cpuinfo under the 'flags' line? It does on my machine, and it
looked wrong to me.

- Matthew
