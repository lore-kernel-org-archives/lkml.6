Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0009C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:40:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8371A208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYL411YV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8371A208B0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932695AbeFTIkU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:40:20 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:35385 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752121AbeFTIkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:40:17 -0400
Received: by mail-lf0-f68.google.com with SMTP id i15-v6so3691639lfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 01:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Ri2vzKKVX71DdFGp7vrqcg4G0uK5XdKZzGKaxSOdDM0=;
        b=CYL411YVh/LR5r0J5ev3cO3OFnyY7qDiEa362BSMxxV+nC1eoWeUqQSrJtqd70Q5mj
         z/CNf2Syedk7ztsOlaFG86Gb4YwISVeqE5JFDGfX9yoZg/BZtAoRBju1ZUSH1yc/ruyc
         z00bBRk6LheckMj0OoQe/rhNgVhLCBg8tt7FWkSPVSuXrV6BKrOB0/aum70Wyk7Gajjg
         nNaawSidP+P47umWKRFKYlMvyRtUh9FRLIn2IV7YU5mK9novrabk4lBYrXz7w+HuOPOy
         mcA2UOyMTh4R7YAgIcQU8kRGoElTIHZHOny/zdBhqaqkFoU96vyl+virDjnAZY6eeipu
         a9Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Ri2vzKKVX71DdFGp7vrqcg4G0uK5XdKZzGKaxSOdDM0=;
        b=EG5Rhkz+XzQJNccZQYRJCsXQcOMxBYpwtlmXGmW/7KMEO0blFNYvE7AzcgqplkBF26
         vIf3vj60MMR9Q3lZaE8YmZJFe1karBFiTbjT94Lx6uSsiqJa6vEVce9E/OqTcH50ozwx
         Hbz0MK15qxVPY1SHoL3tautrMDnZJw0WJGQoV6nc+dQL6wpb9B1x1HWviewlzY0sAquz
         M8LuijZ+zCnm47BWZjRRd6xuYBOpcLDaOdEUJvT2kswpK4HZOhksKxVBBEpk7rmo3+dM
         NUawbkSEtQXv38EvDGkYtyPPd2g24GCdPfo8tDDzDenhBtMDZtwqUN2AnpEXea3BL06q
         mS1A==
X-Gm-Message-State: APt69E2LrWqrNaK9V0LkAcCe1nZjxsBrvQbZjA1n4Wb57CG/M0sQgZrc
        mRJrAswanjsj2Lf6w0HW0rbEVFruVTps+qJIQhhalw==
X-Google-Smtp-Source: ADUXVKKxLVP1pc1yXWJ+ZOEklLr4ONY0QS4Dl8uFNN/FcE6wPKF2veRa4gvk/P5yeD3L4CZ6Cwt+vzNTysf2b2xh/BU=
X-Received: by 2002:a19:97cb:: with SMTP id z194-v6mr12992184lfd.17.1529480362486;
 Wed, 20 Jun 2018 00:39:22 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Wed, 20 Jun 2018 00:39:21
 -0700 (PDT)
In-Reply-To: <20180619215202.zniqq3py3hqjeudv@merlin>
References: <20180619155826.4106487-1-arnd@arndb.de> <20180619171407.yoncg72ed2vncf62@merlin>
 <CAK8P3a0Mcm+AxBPxouMZJKXfbEyX-UD3=_speEj7bsW9nmnjzA@mail.gmail.com> <20180619215202.zniqq3py3hqjeudv@merlin>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Jun 2018 09:39:21 +0200
X-Google-Sender-Auth: LO8dZKlDincZrpIGDejqtAFZn34
Message-ID: <CAK8P3a2CVxTioR0s9xX3T_q+wR6mxHXTyw1U5vWaPeabNQrR0Q@mail.gmail.com>
Subject: Re: [Ocfs2-devel] [PATCH] ocfs2: dlmglue: clean up timestamp handling
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Eric Ren <zren@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2018 at 11:52 PM, Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
> On 06-19 21:11, Arnd Bergmann wrote:
>> On Tue, Jun 19, 2018 at 7:14 PM, Goldwyn Rodrigues <rgoldwyn@suse.de> wrote:
>> > On 06-19 17:58, Arnd Bergmann wrote:

>> Here, setting a timestamp before 1970 or after 2514 will get wrapped
>> around in unpatched kernels, but will be clamped to the minimum
>> and maximum times after the patch.
>>
>> It is extremely rare for correct code to need timestamps outside of that
>> range, but it is also trivial to trigger that with a manual 'touch' command
>> from user space.
>>
>> If the change is a problem, I can resend the patch without that one
>> line change.
>>
>
> I think you should keep the change, but incrment OCFS2_LVB_VERSION.

Won't that cause additional incompatibilities? I don't know how this
macro gets used, but normally we don't use version numbers in
kernel interfaces if that prevents us from using old user space code
with newer kernels.

      Arnd
