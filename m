Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B386FC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 609A023C7C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 03:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WHsUKTNH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 609A023C7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934300AbeFVDOK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 23:14:10 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36385 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934084AbeFVDOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 23:14:09 -0400
Received: by mail-qt0-f181.google.com with SMTP id o9-v6so4841675qtp.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 20:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=tTXIwhWHFbAvaM44qyh0BVhiDsk77f0PSkQ2ZIL2VNI=;
        b=WHsUKTNHl91OJKHWjfisv2JdiMboJEe6rprGG1GLyv1KZ9nDqhypWwfydgEo5XhOZJ
         kLi3KfxFqTambYYmt4rkrw27S2zXVuPaetRp+BATn/Vktw9tO7c7XqRi2sW21d9tlB33
         gpaga9YKIpy5t3HXE8Rcu1xx/3kfBadd+pz+GU4rSTo/2qUi4YIs5UvpGvU9eCiWY/uK
         18rDycrJOfPzHNe40NIdDDtagGr7rs17EELHeU5XgYJ2xwyMBQNuNbRkOrSMGqUU1cws
         4q4fm2Cc+15rIWmonLiVkOXO18EGJHbksDm7PosaMyAR7qMqXCVUqeAivdWwumKqJl1s
         fMog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=tTXIwhWHFbAvaM44qyh0BVhiDsk77f0PSkQ2ZIL2VNI=;
        b=pqAv1lazG2Ler8WMdD3w5+vwVJNfgrKqbXJVNh9Ep5i3Rd4Z821lr/bTKa3kYcd9T0
         xdL7GwjjiStvaSS4COCD/mHR3o3a0tfblMkEEwti0X48wnSYNWsZolBV5LjN8UTt6giC
         qZxPjGLE7o5BXjPBlJMBOFcMpSmgWSyBu3UscNzKnuIPiYphmKtG24Ptsl5SKQAkZLn2
         V8eauWFcxZLIZwnxdTQkM/GmHz8STUc5gzlu2qbVqzp27zgulTlZRHeeJ0i2nXjomdEU
         MfimtIatKVL9DjABF1YflbCWRJ/+MNuaGiLOka5VIsH5qtO9jT9/WIkqcKJqjJKe+Riz
         elmQ==
X-Gm-Message-State: APt69E2Devp/2ImHOtnkcaeX8rN5Zdm8lXFkQZlgZTT0ifblUtU7n027
        C5LZoVPrf+nOzKpFvVm6N6jeQvxBiSIDIfCJeWc=
X-Google-Smtp-Source: ADUXVKKefaECIwighJ3TiheKkBGRjdDIPk3Tf2s4h3+qbBAYUycY3zLO1uiQmaIM0kcXjusoYVeUhnn3Tw5j03tOzTc=
X-Received: by 2002:a0c:bd0e:: with SMTP id m14-v6mr25019134qvg.164.1529637248347;
 Thu, 21 Jun 2018 20:14:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:3f3d:0:0:0:0:0 with HTTP; Thu, 21 Jun 2018 20:14:07
 -0700 (PDT)
From:   Dave Airlie <airlied@gmail.com>
Date:   Fri, 22 Jun 2018 13:14:07 +1000
Message-ID: <CAPM=9ty1xJiPH+TyQSWC2NXYVSEmHF_=3pMVoHoSHXbkwiBPmQ@mail.gmail.com>
Subject: new location for the drm-fixes tree.
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

drm-fixes is now in the same tree as drm-next

git://git.freedesktop.org/git/drm/drm drm-fixes.

Please update,
Thanks,
Dave.
