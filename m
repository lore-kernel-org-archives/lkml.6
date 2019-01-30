Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3BDC282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBA02207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 16:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kN/V8Cez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731738AbfA3QFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 11:05:32 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40754 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731526AbfA3QFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 11:05:31 -0500
Received: by mail-qk1-f196.google.com with SMTP id y16so18283qki.7
        for <linux-kernel@vger.kernel.org>; Wed, 30 Jan 2019 08:05:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=xG2q6zSVLb/CKjj0ZyUrp1UNP3hIVTU/EMKwAvw/5O8=;
        b=kN/V8CeztBoDiFk/nmjpSqZ1AOa2zDXFnBX3x93cdc9jhT3wmihGPBmVFbH4PMEc/d
         dS+UUWSbt92PdequSaRcxrZm4gVMMf9RFgUTFiGRtKnY8OMcLpFQm7YVFyxl2c9nvvU4
         umjnHxqXn7sCal80irNynDx+V32UOkdNaCWxfipoS1WJWqxIYIBuwCra7bp/BSnVPP0V
         hCoUokaz2luZ/Z3tCM4OOLw0HNXSQohJ8NkCgkO1xCffC+p/RTqocOGt8zYo8f21tYxL
         PhulOOHjH66mKww4hjjDMD57RT6lMNwQE/ulIeWtuCRT6N24+cBVfRX1usVFotJBd6Kq
         jCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=xG2q6zSVLb/CKjj0ZyUrp1UNP3hIVTU/EMKwAvw/5O8=;
        b=ZXY+zy5B/kemi7f9dj9qh2kf5jEd83SKmAREFkUjyj3P5q9JtJeDpD2TSAUwJU+qbF
         JL9/uAzronRH6+G1ol0PqFZLqN5iC3g0ebZK0SvE/6TRT5L5WTS2ZLuSWOCRnV50h/ZI
         JADTjHIXRaKTlsohPKdzGxdWwf4hdi/duSgUML6BxOw7tS+onlkLQAJUJqZVc/VWPmim
         WmG2FMDms0Xd5wuG4aRBwBnq6MR7gKnZhlQGDZVSWrmDHXk+mVZwRfSt2gLwgWd+xOSL
         QBUAzWsJmrJIFAos6UPo8mwLlRef0+q+ZSvOVl576l2KvQ6S4AIHFLFNvxb7rgyFU2nU
         TWPA==
X-Gm-Message-State: AJcUukdWIK8DiUbRrVuUhzdH847xDzC2jcQBpvUmtaHWBM1ByIbn7Q4M
        NsRqdRjCpoJJU7XBIrcuDzQ=
X-Google-Smtp-Source: ALg8bN68zzAmj1aFILMap1jsCPDwOFFW8NAHTploxW5Jbznb48amDLzWFF6awuIJ6K00MlyAEHfwuA==
X-Received: by 2002:a37:a0c3:: with SMTP id j186mr28407928qke.18.1548864330656;
        Wed, 30 Jan 2019 08:05:30 -0800 (PST)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id o129sm1552498qke.5.2019.01.30.08.05.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 08:05:30 -0800 (PST)
Date:   Wed, 30 Jan 2019 14:05:26 -0200
From:   Shayenne Moura <shayenneluzmoura@gmail.com>
To:     Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        Haneen Mohammed <hamohammed.sa@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] drm/vkms: Bugfix for igt-tests
Message-ID: <cover.1548856186.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset contains patches to fix the extra frame bug on kms_flip 
igt-test. First patch solves the extra vblank frame that breaks many
tests on kms_flip and second patch solves the race condition caused
by the solution added in the first one.

Shayenne Moura (2):
  drm/vkms: Bugfix extra vblank frame
  drm/vkms: Bugfix racing hrtimer vblank handle

 drivers/gpu/drm/vkms/vkms_crtc.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

-- 
2.17.1

