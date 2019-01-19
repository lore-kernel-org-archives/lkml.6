Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CF5C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:43:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E4EA205C9
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 16:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ulcA8epk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbfASQny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 11:43:54 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33463 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfASQny (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 11:43:54 -0500
Received: by mail-qt1-f195.google.com with SMTP id l11so18758622qtp.0;
        Sat, 19 Jan 2019 08:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=hF7k0nTGQNqsoFCEbK6IUDmQw1ADijrNutmuy9I2hcA=;
        b=ulcA8epkZrC6uD819T9Xqam65HeMkhnAiR4EyTxeeU244o9WarywFiFSgQlwa7T/cA
         QYKqInfuuIO1QkdmOmYRB/vKxpnEqBwWG5udUQhu4Kn0ZNfHv/ttS3HCGFz02GyeHmjZ
         sFeUlSNn/hsGlVRNLzvcG42mWxaDBFmTycANeylXBEqoanXXjYRWFtIzw+y7mrPpk9Wi
         E4hvr5ZvW0dvTbyWvc9BjxxuHGaA4n5naFqxqFfy2IEAXkGGB6T0zBfdDM+0P1A3M8l9
         gJlzm7PwwEYMM+7AvgmKjq0CV+gqYZ4r3A9JTe+JdICdTIbbijR9HEHaV+CQx9/iGTQf
         MixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=hF7k0nTGQNqsoFCEbK6IUDmQw1ADijrNutmuy9I2hcA=;
        b=DS06PyCCx22+W/jyZ9ZopEgsCwOgSpc9LnLYpFd1FaPZt7M9x2JZehShVkDJqSRM8g
         bqt5GdCDtp6ClKu1RFKXISdwpuGM852vBcNqDVfx9gcHeiyv10+IlVGzKtIRcsKQtZhT
         pjriZwvGxqRtC8+pwa94f8+HIhLj58P/QOk45glUkZ4o+P5x6FrZgZ1+wwIUQsGbdLYU
         JFdFX5sUkOlNx816AAIEgJH+HAo4Js85q2eD8Ou92YktqShVsSu3UAWqYa6eDKcnSSG6
         N7csu0ex6+oLvoKZEtT3mODT67ibs2SmbsOYpNkUhU2nNHZvluuAbNRRuu5/Mf3cL+Gh
         /EiA==
X-Gm-Message-State: AJcUukeMGFKPL731RkDPfXXQzXzb/rS/1O0SGnwse7ivlznVcpmW99yk
        DG1NxovBTnWShx+U4ZZ/SJQQ7YksM1OpBenNbUKjEkM=
X-Google-Smtp-Source: ALg8bN4NVWSZscGQ8mlTxb2TfnxUVshP7Pdbj7lWpSY6o4V1BZZK/HO4PN37G/ltUgJ1JP7LUDSS0UcuWLXOQIGS338=
X-Received: by 2002:ac8:1712:: with SMTP id w18mr20307673qtj.76.1547916233281;
 Sat, 19 Jan 2019 08:43:53 -0800 (PST)
MIME-Version: 1.0
From:   Rob Herring <robherring2@gmail.com>
Date:   Sat, 19 Jan 2019 10:43:42 -0600
Message-ID: <CAL_JsqKbma-kw0hrdBa2e7CLzSBsEy7dJZwvj+BrLjqzhuCPQA@mail.gmail.com>
Subject: [GIT PULL] Devicetree fix for 5.0-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull one more DT fix.

Rob

The following changes since commit 3705add0b783e0deeb6646ba0311bf214fe52b0a:

  dt-bindings: reset: meson-axg: fix SPDX license id (2019-01-16 12:50:27 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git
tags/devicetree-fixes-for-5.0-2

for you to fetch changes up to 75a080cde08d2dcba19ee864f9732094d93fab41:

  powerpc: chrp: Use of_node_is_type to access device_type (2019-01-19
10:35:42 -0600)

----------------------------------------------------------------
A single build fix for powerpc due to device_node.type removal

----------------------------------------------------------------
Rob Herring (1):
      powerpc: chrp: Use of_node_is_type to access device_type

 arch/powerpc/platforms/chrp/setup.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
