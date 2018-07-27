Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82ABC67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:38:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5667320897
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 18:38:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="PQF7g7rJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5667320897
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389041AbeG0UBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 16:01:10 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:37786 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388344AbeG0UBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 16:01:10 -0400
Received: by mail-io0-f195.google.com with SMTP id z19-v6so4912603ioh.4;
        Fri, 27 Jul 2018 11:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3Ep0eJSLf7BRATQtzcmT+q1xkX4WfeOxWkIzzcvt3hA=;
        b=PQF7g7rJaaCKvuusYWOMMphIQRwm3uyw3bhurJMeUf+KMOnG1xGzA77uJc282VwGMb
         nBFMXkb2LqiXYE7NZD/dv30mT155yHU+JC0NTBqVNrJuhvdYzQkmU14Nnk3AuGUpP02d
         atDg94l8PYbOpJabXU+CSqSPkBfAWtAkkBAa0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3Ep0eJSLf7BRATQtzcmT+q1xkX4WfeOxWkIzzcvt3hA=;
        b=BLKha+i0nM8PR9FzasFP8lAASg3AN2KJvXQfgTZvya/vX0XHqYBm8rvvso7JfQbHNb
         S26AE9uDSbn0Cy2Evyzy1Gt4Y2XfMm/B6tmG85p4JYOMTHCr2j+GrXK9M+H348J4uQEF
         hqKxAiQbYdNA/F3+2xuJSD4qkweDfIextkrgg+pIePi+VWQzU+S1L/KD8JmpJ0O4roH8
         5+ED+jaGo0/5aa24WEWnQOkK7DawzyPrfUcg8AJ9ftPQKEAsKnkhYc0Cef//kap7atJX
         JbA+58TbnOLoCM5acb7H8TOJ9ufiPfuTXPshcGaNjT8n+cwb4UzHaPxdXDaau6VHRc7K
         74iQ==
X-Gm-Message-State: AOUpUlGb3sWi4qlXIXfIFPBkFGusMDiNYCeF2Wzy83IUxnT1qppPY4vB
        Gcmhgdw5mtMURVH2NDsFBAoFb4azUaBYRoiFNms=
X-Google-Smtp-Source: AAOMgpfjFQxVbfLSr5InkUiwZ4xToHBrCgZj0hdW1N6Ebi0BQ/gyOLD2THhZog2qShsL0srbESWUEi3N0yXA2mBWIPo=
X-Received: by 2002:a6b:fc0c:: with SMTP id r12-v6mr5774500ioh.203.1532716681907;
 Fri, 27 Jul 2018 11:38:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i=npm4hTb6M2cC=mDOhvnhmcsFPEGywhfuHchi20uwmQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 27 Jul 2018 11:37:51 -0700
Message-ID: <CA+55aFx0SEn1AUspujpr-TDGgJkphrRJz_oL_R+XVxUUWV4pkg@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fix for v4.18-rc7
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

My XPS13 laptop is unhappy with something recent.

As of yesterday, I get this at bootup:

  ACPI: Added _OSI(Module Device)
  ACPI: Added _OSI(Processor Device)
  ACPI: Added _OSI(3.0 _SCP Extensions)
  ACPI: Added _OSI(Processor Aggregator Device)
  ACPI: Added _OSI(Linux-Dell-Video)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI Error: Result stack is empty! State=(____ptrval____)
(20180531/dswstate-65)
  ACPI Error: AE_AML_NO_RETURN_VALUE, Missing or null operand
(20180531/dsutils-612)
  ACPI Error: AE_AML_NO_RETURN_VALUE, While creating Arg 0
(20180531/dsutils-727)
  ACPI: 9 ACPI AML tables successfully acquired and loaded

It does *not* happen in

    Linux version 4.18.0-rc6-00110-g6e77b267723c

but it *does* happen in

    Linux version 4.18.0-rc6-00152-gcd3f77d74ac3

and while I didn't bisect it, I'm assuming it's due to 73c2a01c52b6
("ACPICA: AML Parser: ignore dispatcher error status during table
load")

Ideas?

Note only the errors are new. On older kernels, I just get:

  ACPI: Added _OSI(Module Device)
  ACPI: Added _OSI(Processor Device)
  ACPI: Added _OSI(3.0 _SCP Extensions)
  ACPI: Added _OSI(Processor Aggregator Device)
  ACPI: Added _OSI(Linux-Dell-Video)
  ACPI: 9 ACPI AML tables successfully acquired and loaded

without the big slew of errors.

          Linus
