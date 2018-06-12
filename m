Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 5B7A4C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0366C208B4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 20:31:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OIM9ip0K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0366C208B4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934094AbeFLUbp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 16:31:45 -0400
Received: from mail-ot0-f181.google.com ([74.125.82.181]:42296 "EHLO
        mail-ot0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932787AbeFLUbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 16:31:44 -0400
Received: by mail-ot0-f181.google.com with SMTP id 92-v6so349435otw.9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jun 2018 13:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=OIM9ip0Km4Q88qJcwwk3IQ689jE5P9zpXmEpwXvJG4knvq8RaDOQc01h43wpt7uuS1
         myb4pcGJ2UcyQ94RPzKJh1+dCKyjZgJ829L+bFQ+gROtJv/gVhgRrDrp6UFqOQzPGXLK
         rhaH4+X4ezegQdMfYTAux5At2ADbQhm2dh9Awjv1oR01ELXQe5jENGfnVgu3fxsEvZjq
         QmvCVvFtVQZMlMLWVXKwXbADs4059ZX9rGufrqU5fh16RjlkWQI571sfl+Mw35G9yq9L
         9cUL+Jl3kq3nZg0at0VGchvdUcpql6RHiVnm4CvJoLHD1NH/ipEwcpcOeIoD0ejV6Tkv
         uc8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=H7TfWuJuxniQYZUFW9bvII5Vr1rgNmizaa/XrNQwKLo=;
        b=mCYWDCvqFK0Ws52jksE7btNySmYjAZTecOmqLQN24wWfvyM6DkgS3wWUbhbBo6lLt/
         URNvUmGOyxWDYBA4uvR9//0R1Mmta6RyXTKKbma0wyAqXnqivJ7OGv07oTiGpD4e0Ypl
         884WzEUNWfKzvOTu+hAiuskGQ28KHiBetijMaT8ZGSQlcCjpTR+y1khkJb51of5fnX1x
         3fF923t7SXOq6yHyWzqxJFjqQxpjlZoSilBXutUvF8k9uHqQRoo+5k/WVkFrZufEjjfY
         aYxV7YmbapzXsofEYxK/PlTEyW/cHCG+pGDY3qAGrmPUvQlOL6FRb9IZY4gFyrt/l33X
         k1gQ==
X-Gm-Message-State: APt69E0xYwFgsxAU0Y7YloegroeAPdQacMS/Y376XX8abbFBjjOcBwzB
        3hN3kgVA6DoQq+Z1R7DEstdPhFlJfkqDw0JAiXE=
X-Google-Smtp-Source: ADUXVKIpAwCPE+pmQSmGRIHvYNMvVyJM0acylqggQ8FYiWjU2Cq1SfuA4a86WGRJ4q9YLj2Bd69+Fd7lgJkntigoqW0=
X-Received: by 2002:a9d:1c1:: with SMTP id e59-v6mr1429003ote.134.1528835503975;
 Tue, 12 Jun 2018 13:31:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:f92:0:0:0:0:0 with HTTP; Tue, 12 Jun 2018 13:31:43 -0700 (PDT)
From:   "R.F. Burns" <burnsrf@gmail.com>
Date:   Tue, 12 Jun 2018 16:31:43 -0400
Message-ID: <CABG1boNJirPD1bh5PyETz8jVSV6PyMwPYfhhVQWyztp8W-XjRg@mail.gmail.com>
Subject: PC speaker
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Is it possible to write a kernel module which, when loaded, will blow
the PC speaker?
