Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F0ECDE46
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED48E204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 19:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gognR37Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED48E204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725892AbeJ0EAL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 00:00:11 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38133 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725749AbeJ0EAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 00:00:11 -0400
Received: by mail-qt1-f194.google.com with SMTP id r22-v6so2511994qtm.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 12:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=LtZcx+CVUn7EikVnICHRi5K+TmBpVqD4Q/OjAbD6y+c=;
        b=gognR37Yl/wR9pYklgrwhENDoVkkiKTN6BNtb/wMovjk0JCZZrBd1NQh2FR1Ok+3s/
         860m0gd7ulL7bhlStIHcgOPHeszN2C94iKTniYb7foCs8a3stjiQ6P5DSIZAcap02ZVJ
         aJJQCXxNQk6DGuqD03GjuVn7/+/6WTb5IC5ICzGe5wL8eGlKynwwwG3HmGgLefYY7N09
         VfbjVtwxs/4Qp/OFgK+50oK59tpFV3MecNVlggg/adJ9pbL74iwn1ED5qAodo77OGJyf
         DtW0jEZgU2v258jHdYp9bdFOiJjsmlAg64fkExR1tYHu+I4a9dPPxu5dUprmI8kGQYk/
         wudA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=LtZcx+CVUn7EikVnICHRi5K+TmBpVqD4Q/OjAbD6y+c=;
        b=cn5AdIrcHMveAknlpfE418pPquQ6AJjLtdHZo/R1PdOcZP7lV2IXnXCZMTJIPgSZas
         1HPrS4rKbrOshXGFqEHkOtFz29JlvceoO5X8BIz0YzO+3RciDdvDkcC+1qiTdC/wA4mt
         f7cJdZYWuCX9/DKlC2s0oACF57FP2z/uIMlhVVrZjkvW55J4Y801D/yut7vwBzMA/3cK
         TYYrYeVvhVaKuUZITvkVHgtXtWfjHG99+ZUMY/xDf8wSgFYMXEFHWqFy3Otf7s2kGL4n
         eEGLTER7jFd32G0jDy5LnwzypcHTA1yXTHeriOB7+ZNvIll+DPI+k4cdwXqYZxx4GTTv
         Jcmw==
X-Gm-Message-State: AGRZ1gKqDkK2wub1BsrJFoyAc6sA5oZCZgxqiVtcdihvePosgcqRxWQ/
        zx436UnccpZIiYPGJGummLg=
X-Google-Smtp-Source: AJdET5dtoWYaB34zeJxWuPlKs56r5/6mta5G0ulxWFrxgvKHmQ/ENUfz4VAGLAaOIE9yvoIzSxmX7w==
X-Received: by 2002:aed:20e7:: with SMTP id 94-v6mr4437312qtb.296.1540581715073;
        Fri, 26 Oct 2018 12:21:55 -0700 (PDT)
Received: from smtp.gmail.com ([143.107.45.1])
        by smtp.gmail.com with ESMTPSA id t128-v6sm8307402qkh.80.2018.10.26.12.21.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Oct 2018 12:21:54 -0700 (PDT)
Date:   Fri, 26 Oct 2018 16:21:50 -0300
From:   Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
To:     Dave Airlie <airlied@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        David Airlie <airlied@linux.ie>
Cc:     virtualization@lists.linux-foundation.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
Subject: [PATCH 1/6] drm/qxl: Remove trailing whitespace
Message-ID: <fb0e2237bc505c855a0a842c081a39d524c571dc.1540579956.git.shayenneluzmoura@gmail.com>
References: <cover.1540579956.git.shayenneluzmoura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1540579956.git.shayenneluzmoura@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove extra tab and space to clean the checkpath.pl error.

ERROR: trailing whitespace

Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>
---
 drivers/gpu/drm/qxl/qxl_dumb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/qxl/qxl_dumb.c b/drivers/gpu/drm/qxl/qxl_dumb.c
index c666b89eed5d..089e5fcf80e0 100644
--- a/drivers/gpu/drm/qxl/qxl_dumb.c
+++ b/drivers/gpu/drm/qxl/qxl_dumb.c
@@ -52,7 +52,7 @@ int qxl_mode_dumb_create(struct drm_file *file_priv,
 	default:
 		return -EINVAL;
 	}
-	  
+
 	surf.width = args->width;
 	surf.height = args->height;
 	surf.stride = pitch;
-- 
2.19.1

