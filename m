Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3216147-1523476441-2-14581655008422974501
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523476441; b=aHvQQyqEAB0kUAk9yfTQW8o9jOjXUIw9bdqKf5fQkTET+c0iX/
    XZMvCsCojh7VIRWyLgqNf3axoXvzvjdarILQtlb7HKzreakTyD6xDHI93ieLGMaJ
    hO0E7EkPaeuW8EJL0VwzSRP60QQya/c3YLpbEkyTmYsS2Zwa8rAnyBmlZ/QVF5Jl
    h4spMnw7LKwG6bEmsEV4o0yh4AVuhNhU+JaPzeAWI6Bx5yCaphWq3i3ZiSXBe0Xc
    QMfX4jAIGNz3mYL26p1iFGLkcwRzIQSzxEfK6FIHZaD5zoGwf4/GnNasnsnPemsM
    unkUjc//YqKaMunMUgAkDo0puuJGsyIQHkXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523476441; bh=WnjSSUyh3HmBJlBVxJFq95aW/j6RO9
    fSgXqYSwla2JQ=; b=h1hJ8zJ4TKpys/J0tjmxKgrxuXY+Z97lGk8BKip8mEun9T
    WyV0h/e1djSJ0r0JFEjBCjKvXuZduiVqkH4p+LIwHbD0WeicAMx2VOJpTgiSKhMk
    GJY+layP+vpTQa1OUkm7g14fX1vKuuMfXCTN631IDYf8HLYTIZl4kct5NhLkkKkb
    417RbATTfzOI5vy5k3mzSla8mFNxNCY9+QgEL2w+DeNXLaCnc38WQSKuFE3G3GB6
    1LQ9zKZp+P8RnnUzWH8YRuhAeXIuqWF18yIA2Tneoh8WYTAkyqTQmk8NJufRgUPl
    wO+WpCxpEA2r1S3jvXhxkJCx3XOIkFZ/jZfp5E7A==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfInzP+qRSoSi9aIBlGeUpKFEs+k/59FyKeyCJbqFMNo+AQcGA0TL9rBDfj1GpxON3Dm+xk4HyzVwBYZXpL77T7oLKccU4pv+YaTYj5deV2ezn1H8AA7+
    MIHN7qrUjGbBjGbrChvFBhic9dCVgqJtwaU4w3j0/6gHQu+6+Yb3ecu5QHOqSHoLhUm+5naI3uWLI3DbaXE5Om9MAbpm6NKqR3xw5B1trV+vAj5IspVXFL+h
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=pGLkceISAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=c3k9iIRU9D_56J-XrdMA:9 a=QEXdDO2ut3YA:10 a=pioyyrs4ZptJ924tMmac:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756490AbeDKS5w (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:57:52 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:36430 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756465AbeDKS5q (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:57:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jordan Crouse <jcrouse@codeaurora.org>,
        Rob Clark <robdclark@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 118/310] drm/msm: Take the mutex before calling msm_gem_new_impl
Date: Wed, 11 Apr 2018 20:34:17 +0200
Message-Id: <20180411183627.242365299@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183622.305902791@linuxfoundation.org>
References: <20180411183622.305902791@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jordan Crouse <jcrouse@codeaurora.org>


[ Upstream commit 90dd57de4a043f642179b1323a31ca3ced826611 ]

Amongst its other duties, msm_gem_new_impl adds the newly created
GEM object to the shared inactive list which may also be actively
modifiying the list during submission.  All the paths to modify
the list are protected by the mutex except for the one through
msm_gem_import which can end up causing list corruption.

Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
[add extra WARN_ON(!mutex_is_locked(&dev->struct_mutex))]
Signed-off-by: Rob Clark <robdclark@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/msm/msm_gem.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/drivers/gpu/drm/msm/msm_gem.c
+++ b/drivers/gpu/drm/msm/msm_gem.c
@@ -770,6 +770,8 @@ static int msm_gem_new_impl(struct drm_d
 	unsigned sz;
 	bool use_vram = false;
 
+	WARN_ON(!mutex_is_locked(&dev->struct_mutex));
+
 	switch (flags & MSM_BO_CACHE_MASK) {
 	case MSM_BO_UNCACHED:
 	case MSM_BO_CACHED:
@@ -863,7 +865,11 @@ struct drm_gem_object *msm_gem_import(st
 
 	size = PAGE_ALIGN(dmabuf->size);
 
+	/* Take mutex so we can modify the inactive list in msm_gem_new_impl */
+	mutex_lock(&dev->struct_mutex);
 	ret = msm_gem_new_impl(dev, size, MSM_BO_WC, dmabuf->resv, &obj);
+	mutex_unlock(&dev->struct_mutex);
+
 	if (ret)
 		goto fail;
 
