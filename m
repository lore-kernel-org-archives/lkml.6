Return-Path: <SRS0=9pGL=NC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D64D6ECDE43
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:27:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D5D42083E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Oct 2018 01:27:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY2jfqiv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5D42083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbeJVJn0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Oct 2018 05:43:26 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:41267 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbeJVJn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Oct 2018 05:43:26 -0400
Received: by mail-qt1-f193.google.com with SMTP id l41-v6so44489889qtl.8
        for <linux-kernel@vger.kernel.org>; Sun, 21 Oct 2018 18:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Kf5sxkkwPbGMilmlQpLECHP9rYySbUKgffGiyo23RFk=;
        b=PY2jfqivIdoFLbhP+bD+RLLX/+zZG7ZUW3ELSnUE0OXEhc8dXz3uEiU5agN+wWEslt
         LHCA1E3zxYVn6Y7eEpQ60GDks89bjOukCE6BcktDHtXLReOv6gvs5BWo21xIEEZlZ0fq
         JPN/f6704NuvDKkXnHkuKKg0JgYagtocUV/9S97tSaN6LLTUzawpHqSHhDmR+42s2vP0
         s5uf5MW88jhsB2jHBl0WeCFMk+TpRDg5/C9+0QqOUny/uUvMnoCk0VMVHJ5yPQaZRdbs
         rLdndHUfQPKfyt02f5vW+3C/2AepPKRQORQKRpe4BYo7VYrsh5WTvJK+B7JCcX1Q6s2F
         5Uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Kf5sxkkwPbGMilmlQpLECHP9rYySbUKgffGiyo23RFk=;
        b=rKn0NxoE9lcuuoI6XTQnu9y87wAg8hvKDSt+jrMNynaQsQRu1iT25tS90UV/idVNZB
         8ZMf7gS/VRTXzuaJNyvNgVvFJzcJtODdudq0Q3e4Of80NhhRi/9Qb20Puyh3r7C+i8rL
         oXFENOhd4ufJ5F24Axel7zAqUCSamRfOkRmOkvuLoQT9S1cE/qG+f4QwJqO60YS7gx3D
         5tUNZwAb2oVXd9YhD5hBtWjGOdUFibhdwlUdgQwCN3fQHIv6p3hMu52xE0g6/k8SmoyQ
         XTQ1vz6RI8T1dHRW2FPbbBVwEZd4RkJC2Pf0GQhBXcM6kwT54Ha0veaoWafSASKRBb8z
         +3mw==
X-Gm-Message-State: ABuFfojYfITG76psg+cA70amO5p2p6i/23yvVpGj1vBBK0OoQx4PcY3m
        uRH7sfCBSzhdUtkY0sm8Y18=
X-Google-Smtp-Source: ACcGV60sKtzwRaq7pFHuJP+2G8Fm4Aa3S+jQ7zVZDBaONmDRpejkAATTXUvJaJJraz/KsCRnqq+Wig==
X-Received: by 2002:a0c:8ec9:: with SMTP id y9mr34419398qvb.65.1540171625717;
        Sun, 21 Oct 2018 18:27:05 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id z188-v6sm8103192qkz.66.2018.10.21.18.27.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 21 Oct 2018 18:27:04 -0700 (PDT)
Date:   Sun, 21 Oct 2018 22:27:01 -0300
From:   Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
To:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2] MAINTAINERS: Add entry for VKMS
Message-ID: <20181022012701.7a2rkmot2bj37xfb@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainers and reviewers for VKMS driver

Signed-off-by: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
---
Changes in v2:
  - Insert the section in alphabetical order

 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39c3f6682ace..56572f0968ce 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4733,6 +4733,16 @@ S:	Odd Fixes
 F:	drivers/gpu/drm/udl/
 T:	git git://anongit.freedesktop.org/drm/drm-misc
 
+DRM DRIVER FOR VIRTUAL KERNEL MODESETTING (VKMS)
+M:	Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
+R:	Haneen Mohammed <hamohammed.sa@gmail.com>
+R:	Daniel Vetter <daniel@ffwll.ch>
+T:	git git://anongit.freedesktop.org/drm/drm-misc
+S:	Maintained
+L:	dri-devel@lists.freedesktop.org
+F:	drivers/gpu/drm/vkms/
+F:	Documentation/gpu/vkms.rst
+
 DRM DRIVER FOR VMWARE VIRTUAL GPU
 M:	"VMware Graphics" <linux-graphics-maintainer@vmware.com>
 M:	Sinclair Yeh <syeh@vmware.com>
-- 
2.19.1

