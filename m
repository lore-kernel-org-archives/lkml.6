Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB00C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:33:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62083218D9
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 10:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546425235;
	bh=k19IHa8lVf3i58ZGWRFTaexJagpxXxIM8FtACvCr9FM=;
	h=From:Date:Subject:To:Cc:List-ID:From;
	b=QF54G6zBY0KE6CVH6B4tqx6ar1T76SgoHQ4GcAH3wHCzQD0HvBDFxI6TWN+oPzrLX
	 2sZREJqSWH/HTHsd6un73uQ5zY8kASNpB+ceYrj9LjVvW1CaLKN9un5XXtWtqtF43x
	 VMscO+ALkf0ull/O4PZallumshb2B66RLA3jJldM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbfABKdy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 05:33:54 -0500
Received: from mail-ot1-f45.google.com ([209.85.210.45]:33939 "EHLO
        mail-ot1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbfABKdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 05:33:54 -0500
Received: by mail-ot1-f45.google.com with SMTP id t5so26407157otk.1;
        Wed, 02 Jan 2019 02:33:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=nVz3Y5yKbCZhyG1ecgROmZxZ7Zwfdv5LHTBC1fO839I=;
        b=W9hEcOXuvE5u0lpAUPXXcEipuY89K7X4GXyhbVQSN5G8Y32zmJ52CT5IWnapu2arsJ
         4A0CAV5Yzser9Pr9qyp4ReR8jFKwgleVWdACo06ILWFj+MEl4RHfIdplKW9d5H3w1v+m
         3OW/CP9WbKRJEbu5AyBUPaCHbIDk0V0z3Dpn+lxXmjU/Rh3Gb41YmV0Gn49QQAhSxsad
         CLQu4yDRG8l3toSbnJITv0UlPJk+NhVb2IdCjgJhqx1Sbf8i17ZpEjoahFai2FHsVCOZ
         oLemVf/Jxfh0McTkessnjsAm5701zzvxF75+1+FACP1ScxilZtyQGCHGGgbXwY5gRIEt
         61Hg==
X-Gm-Message-State: AJcUukea/Zv7easyv6m7Q5jhRcmwxaUrzWHJTPzbVpYQuuwOsTvySeoK
        AyGSUJo07S9q25gRdSp5r51s+rTdYzbbkUF4Tnk=
X-Google-Smtp-Source: ALg8bN7SXMDToSZDwBWgdyFvQ9oX+hYJVASlH5NLDEnld0oLamdZnXWG8z4F+Fs9oMn7+KL6wnAjcEFYyxoO4DAHNik=
X-Received: by 2002:a9d:5e8c:: with SMTP id f12mr32107498otl.343.1546425233524;
 Wed, 02 Jan 2019 02:33:53 -0800 (PST)
MIME-Version: 1.0
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Jan 2019 11:33:42 +0100
Message-ID: <CAJZ5v0h9Xj-gqYfkJFoEyVoFQKm1hBKboPtcvmPzE0OYTLu0sA@mail.gmail.com>
Subject: [GIT PULL] Device properties framework fixes for v4.21-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull from the tag

 git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
 devprop-4.21-rc1-2

with top-most commit f4747b9c68b8864cac32cddc45fdcfdfafb3397c

 drivers: base: swnode: check if swnode is NULL before dereferencing it

on top of commit d8924c0d76aaa52e4811b5c64115d9a7f36cc73a

 Merge tag 'devprop-4.21-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm

to receive device properties framework fixes for v4.21-rc1.

These fix two potential NULL pointer dereferences found by Coverity
in the software nodes code introduced recently (Colin Ian King).

Thanks!


---------------

Colin Ian King (2):
      drivers: base: swnode: check if pointer p is NULL before dereferencing it
      drivers: base: swnode: check if swnode is NULL before dereferencing it

---------------

 drivers/base/swnode.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
