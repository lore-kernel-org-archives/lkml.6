Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C8C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1642054F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 20:24:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cougarmail-collin-edu.20150623.gappssmtp.com header.i=@cougarmail-collin-edu.20150623.gappssmtp.com header.b="PHoHAA7L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B1642054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cougarmail.collin.edu
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeJ2FKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 01:10:30 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:44401 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726364AbeJ2FK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 01:10:29 -0400
Received: by mail-wr1-f47.google.com with SMTP id d17-v6so6176649wre.11
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 13:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cougarmail-collin-edu.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=78UkiBUsSmHmkFK5eZnFluH25hsjHZZ8P4543FEkDOA=;
        b=PHoHAA7LvzTW9tmocuQeJ1Lh5qkI995t22zAt6Ny/RUr01U9rnQVkj3TFygjDGWHJq
         D7iAa8tLTJq4MJUGW1o0KXHdWfx0GISRO4FHk8HYFOQMe0DiaM0okIjvALCjGe8VSHdQ
         6KfMakErnPpVyNP9j4Hw9p/PMzR8J95zDwwZcUq63OgFFLn1XRhBRc9RYFP7UBB8802e
         6OSjcMXaMCVy3chvuZdqxJFGwIGTyV36Tdxj7rUlk1ko73Aalz6Bd1H3za6ysS2FsEHu
         Z9p1P57Y1ANUKf8FW/lQvXMg6rx+MWPtf0eYhTHnisdJhpU/VUyoaU9E9kBOI1/NIaDI
         VAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=78UkiBUsSmHmkFK5eZnFluH25hsjHZZ8P4543FEkDOA=;
        b=nBKhBOq752Nh7v+2kmdyAiVZGhC/ZfnXVnhrHLjR4BZjwHlHgd1mwxQKNzZBIdxUup
         6yeXDoBWNnBlQd2//HP6G0mJrQYb+tSEJI+iWaTvsXMvGX3smmz/YmpZaTv141QFUvoy
         pFb/Kfl1QIIurb594lyVYcbA2lwcjFwsvflSXbWmtwk3G7JtPd+B5zQoBmsPHJp1WK44
         jG4jWydH5v1AzkpgNGKNfiwxNYLUXp/FVNDyogdb1OylVG5Wd2Fje+M2/Z/CDcivFD/6
         CO8yExxBMIzpPyCHCVOCXnShLTl+UO1mi0wSnBCMOpGGxYm2slG6k7jqhKmeJTAkLjH4
         NeTw==
X-Gm-Message-State: AGRZ1gKcnQdWHEjyW0pTdoofqkF6DDHwinqgO2o8AeEWWXQC2Qvw9Y8s
        2J2Npdwf5afQeIhNeX8srrn65rKhJwEvlzwAd3nhe7KlYXI=
X-Google-Smtp-Source: AJdET5cGtlNrPbRzSavD8npNhG+VeoR8/y3Hbi6/2gDjveFU+brNOX5JZ05pVIIdYRg1I72vyWWbMHiD0dguwgnfAb4=
X-Received: by 2002:adf:f68e:: with SMTP id v14-v6mr3045580wrp.261.1540758284423;
 Sun, 28 Oct 2018 13:24:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:b60e:0:0:0:0:0 with HTTP; Sun, 28 Oct 2018 13:24:43
 -0700 (PDT)
From:   Nathaniel Russell <nrussell6@cougarmail.collin.edu>
Date:   Sun, 28 Oct 2018 15:24:43 -0500
Message-ID: <CA+uPecOtCAQSW2WUCciCzvZFimKoyWOScAeRnHoA=zN6D_ax6w@mail.gmail.com>
Subject: RTL8812au driver source code A little help please?
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make[1]: Entering directory '/usr/src/linux-4.19'
  CC [M]  /tmp/rtl8812AU_8821AU_linux/os_dep/linux/os_intfs.o
/tmp/rtl8812AU_8821AU_linux/os_dep/linux/os_intfs.c:816:22: error:
initialization of =E2=80=98u16 (*)(struct net_device *, struct sk_buff *,
struct net_device *, u16 (*)(struct net_device *, struct sk_buff *,
struct net_device *))=E2=80=99 {aka =E2=80=98short unsigned int (*)(struct =
net_device
*, struct sk_buff *, struct net_device *, short unsigned int
(*)(struct net_device *, struct sk_buff *, struct net_device *))=E2=80=99}
from incompatible pointer type =E2=80=98u16 (*)(struct net_device *, struct
sk_buff *, void *, u16 (*)(struct net_device *, struct sk_buff *,
struct net_device *))=E2=80=99 {aka =E2=80=98short unsigned int (*)(struct =
net_device
*, struct sk_buff *, void *, short unsigned int (*)(struct net_device
*, struct sk_buff *, struct net_device *))=E2=80=99}
[-Werror=3Dincompatible-pointer-types]
  .ndo_select_queue =3D rtw_select_queue,
                      ^~~~~~~~~~~~~~~~
/tmp/rtl8812AU_8821AU_linux/os_dep/linux/os_intfs.c:816:22: note:
(near initialization for =E2=80=98rtw_netdev_ops.ndo_select_queue=E2=80=99)
cc1: some warnings being treated as errors
make[2]: *** [scripts/Makefile.build:306:
/tmp/rtl8812AU_8821AU_linux/os_dep/linux/os_intfs.o] Error 1
make[1]: *** [Makefile:1517: _module_/tmp/rtl8812AU_8821AU_linux] Error 2
make[1]: Leaving directory '/usr/src/linux-4.19'
make: *** [Makefile:1584: modules] Error 2


I Kinda need some help figuring out how to make this compile on kernel
source 4.19.0?
Any help would be apprectiated,
