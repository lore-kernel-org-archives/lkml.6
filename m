Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3443C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:57:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC1221721
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RQNbCPCk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfBGV5i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:57:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36422 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGV5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:57:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id p6so1479782wmc.1;
        Thu, 07 Feb 2019 13:57:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=gWoW5koaP9q+iibI0nW5zt88QENkry54DzTcBCQdDWc=;
        b=RQNbCPCk1QJH34DabpF8pHT9EecHy71Xzdr+Z535uv2+BaQ8KQQb/2kWAruTXEGKIS
         vs9wQXZjCA6inFfLAI8d13ONmtXOvyuUHRo8hJ7wzJ95toKP/B143N8og5yQz57U0bZy
         gU13F/vkkBd1Urx8C9bMbe/8uvJcZG0pyAKFDBELm8ybXtKsDQReO6DelQN4ql5UmL9C
         m6gdItg8+Ipy2M0JU6/RqKapesZwULN0fo2tEUJEPT1wLGbk7uIa+3aG1MP6clcy52cY
         BeobVYel++VRV3d9eO9LmKaMmBQzgLHL9Njc2xByRQP5zdEKODB/AaGHuApkk9O5NB1x
         ekqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=gWoW5koaP9q+iibI0nW5zt88QENkry54DzTcBCQdDWc=;
        b=J5WG2AmTDHJl/j/gQF6TDcw7QyFHV7Bht9r4yV+DNs7ahUBBkbLgCh2wsPXgCMNBId
         pN4waCXFATCQNo/3W9/YShdXyJXTWp6gFIybQN+XsvQ2+VM3yFKlUN6GVkTF1CMK3lnH
         mtgq2YWPpLb5NQ3cJZw1bsKriejbGiggB7yFUFoEZG5Mn/S08hBUHHEkHc/iuz9F32ZZ
         rBA9SNje8WIXUbgnrlZON+8POulN7rKSuBAyslHV1OaEu+0CfgJToNn1vpA/Tuc5Tawf
         HGe5K/6WS/jtoOQIdHoeLcaPCJ6YFbvOR4tviBGW73AauHoDgGYubZ8ubgFEk5SvFvDu
         zGNQ==
X-Gm-Message-State: AHQUAuaECHKs3j4yTSueaAJpuGcbhdAvMndN2wjvvvRmFjbJI55C2bNf
        0VveizO7YmlNx32tjqRQ5Hn6USQbHQDVetIQ4xu1rbvTIZc=
X-Google-Smtp-Source: AHgI3IbbOZf+olbmbdxd99WzEa5w2hD/EwiDlA3yrCR6A3sbLUgN7DDCuHT7vKHT1Tr0VuCa4pN3hAFriRqXZv/QIhk=
X-Received: by 2002:a7b:c4cb:: with SMTP id g11mr9055735wmk.149.1549576655504;
 Thu, 07 Feb 2019 13:57:35 -0800 (PST)
MIME-Version: 1.0
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Thu, 7 Feb 2019 13:57:23 -0800
Message-ID: <CAKi4VALTMvOzhv=c9jVrk4d099xOXt6prUsQSh3xr3gjPsDxVA@mail.gmail.com>
Subject: [ANNOUNCE] kmod 26
To:     linux-modules <linux-modules@vger.kernel.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Rusty Russell <rusty@rustcorp.com.au>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmod 26 is out:

        https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-26.tar.xz
        https://www.kernel.org/pub/linux/utils/kernel/kmod/kmod-26.tar.sign

Now we also have a new archive for the mailing list:
        https://lore.kernel.org/linux-modules/

- Improvements
        - Add more error-checking in library functions and remove
warnings on newer
          toolchains

        - Depmod now handles parallel invocations better by protecting
the temporary
          files being used

        - Improvements to testsuite and added tests to check the behavior
          regardless of the features enabled in the kernel and
libraries we link to

        - Teach the --show-exports option to modprobe. This works similarly to
          --show-modversions, but it reports the exported symbols from
that module.
          Under the hood this reads the .symtab and .strtab sections rather than
          __versions so it shows useful data even if kernel is
configured without
          modversions (CONFIG_MODVERSIONS)

        - Teach pkcs7 parsing to modinfo by using openssl. This allows
modinfo to
          correctly parse the signature appended to a module by the kernel build
          system when configured with CONFIG_MODULE_SIG_ALL, or when externally
          signed by the distro. Traditionally modules were signed and a struct
          was appended together with the signature to the end of the module.
          This has changed on the kernel for pkcs#7 and now the structure isn't
          filled out with useful information.  So we have to parse the signature
          block in order to return useful data to the user.

          If kmod is linked with openssl we parse the signature and return the
          fields as we do for other signatures. An example of the relevant part
          on the output of modinfo is below:

          Before:
                  sig_id:         PKCS#7
                  signer:
                  sig_key:
                  sig_hashalgo:   md4
          After:
                  sig_id:         PKCS#7
                  signer:         Fedora kernel signing key
                  sig_key:
51:C4:0C:6D:7E:A5:6C:D8:8F:B4:3A:DF:91:78:4F:18:BC:D5:E4:C5
                  sig_hashalgo:   sha256

          If kmod is not linked to openssl we just start printing
"unknown" in the
          sig_hashalgo field rather than the bogus value.

Shortlog is below:

Caio Marcelo de Oliveira Filho (1):
      testsuite: add Clear's mkosi configuration

Chris Stackpole (1):
      Phrasing correction in modprobe man page

Daniel Kahn Gillmor (1):
      man: Fix typo

Jakov Simunic (1):
      build: fix wrong quotes on bootstrap

Jan Engelhardt (1):
      kmod: build: cure compiler warnings showing up externally

Luca Bruno (1):
      libkmod-module: check for NULL before accessing pointers

Lucas De Marchi (17):
      testsuite: raise arch image to 3GB
      man: depmod: remove deprecated -m option
      mkosi: allow Clear to use test modules
      testsuite: add simple test for --show-exports
      README: Add link to mailing list archive
      Remove bootstrap* scripts
      testsuite: split out function to compare outputs exactly
      testsuite: add support for testing output against regex
      testsuite: move --show-exports test to use regex
      Add semaphoreci 2.0 configuration
      testsuite: fix modinfo test without openssl
      build: enable openssl by default
      build: add openssl to CI deps
      build: check openssl version
      testsuite: mkosi: update files
      build: fix make distcheck
      kmod 26

Michal Suchanek (3):
      depmod: prevent module dependency files missing during depmod invocation
      depmod: prevent module dependency files corruption due to
parallel invocation.
      depmod: shut up gcc insufficinet buffer warning

Yauheni Kaliuta (6):
      modprobe: add --show-exports
      signature: do not report wrong data for pkc#7 signature
      testsuite: track number of descriptors instead of their state
      testsuite: factor out fd related parameters to a structure
      testsuite: add modinfo pkcs7 signature test
      libkmod-signature: implement pkcs7 parsing with openssl


-- 
Lucas De Marchi
