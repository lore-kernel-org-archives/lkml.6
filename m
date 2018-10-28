Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6DE4C2BC61
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83CFD2082D
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 19:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hns+uBIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83CFD2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727427AbeJ2EOj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 00:14:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39127 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbeJ2EOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 00:14:39 -0400
Received: by mail-wm1-f66.google.com with SMTP id y144-v6so5932189wmd.4;
        Sun, 28 Oct 2018 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7G8bUXdfiSJ9jXpJxKn0RnUIGyllqJB5atX8/kgDc2A=;
        b=Hns+uBIKmAHMvAelmPK8HI1ypg+2iiZjwX8VRW1MAyafjT4hbVFnpFS/CLzYEX8Klh
         BO30ItOARxzvea9p68HmiF0IVj8tgKQx8HnIP09sWEwalpGC0+//p+P19APbmw6aPoUT
         b4rUCcJh4wBQ4ZA+kN74oy+D7UBMbNBx7yPYVQznBa2WsSzg/CZvN4ULDtN1r/WECrDR
         pRyZj/e1EUFBHCCsTh5z5KWDqpRtRwwiTFLbBe9Jpj0GyK/B8VGl1To8Yvi0FEFPcego
         N1nZowjZM34GLvQMIn5ZtJOBxExeU7fXC+FLI17IUnwN2NIDn26BkG0ECgWAXvMtLACp
         /ZRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=7G8bUXdfiSJ9jXpJxKn0RnUIGyllqJB5atX8/kgDc2A=;
        b=LgqTdqbbLJBSBlNeS7EgJ4AaEqanWw1rqASf1D22A36XPZt37e7RLE9ho3roRVry+j
         qcpF/96Favk/7rKQbmDxzJ5PXKKH58dg73Y5wA96Ri2Aa1C8WdByxsVrfipGlEb2mbS7
         D3k4xjdUz32C11N6iMOuA4KPFbsxqINmpGnLDQzfWjXb1TyiIQOq+/3FKc/RJUfVBWQ5
         uzZEhoHDduhG8yyvQ50Epmx2PUpQsvR+9DQTAHKOVdYw9IWAmBe9rvO/Q0Vg8mxd4INx
         4M+OorDPJ06DtKJEgNsQZXb4L2tcY76a2wkq2mP4NVnciGBTQ4znIsOIcd2jK6jB+3+A
         wQWA==
X-Gm-Message-State: AGRZ1gJAhIfgN+y4hSTjkmkX829VL49c+T8wB2Fuysg86Cw7lU2rjrRu
        ve8bOsgACfLzWEqfNW1fTIs=
X-Google-Smtp-Source: AJdET5cx010ExiyDOMW1caa5wjJsaHQha/RRLLjtEE4mSYIS9MrDapY3bvWzRWe4e4Se6pbkTaiD3g==
X-Received: by 2002:a1c:e15:: with SMTP id 21-v6mr12025977wmo.35.1540754941232;
        Sun, 28 Oct 2018 12:29:01 -0700 (PDT)
Received: from joris.fritz.box (p200300CF83C0B500C714D115E7850A75.dip0.t-ipconnect.de. [2003:cf:83c0:b500:c714:d115:e785:a75])
        by smtp.gmail.com with ESMTPSA id t77-v6sm21650076wme.18.2018.10.28.12.29.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 12:29:00 -0700 (PDT)
From:   Joris Gutjahr <joris.gutjahr@gmail.com>
To:     corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joris Gutjahr <joris.gutjahr@gmail.com>
Subject: [PATCH] doc-guide:kernel-doc.rst: Reference to foobar
Date:   Sun, 28 Oct 2018 20:28:28 +0100
Message-Id: <20181028192827.19136-1-joris.gutjahr@gmail.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the Function documentation Section of kernel-doc.rst
there is a function_name() function as an example for
how to make a comment about a function.

But at the end of that example there is a reference to foobar 
instead of function_name.

I think that should rather be function_name, because that
was the placeholder the whole example was using.

Signed-off-by: Joris Gutjahr <joris.gutjahr@gmail.com>
---
 Documentation/doc-guide/kernel-doc.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/doc-guide/kernel-doc.rst b/Documentation/doc-guide/kernel-doc.rst
index 8db53cdc225f..51be62aa4385 100644
--- a/Documentation/doc-guide/kernel-doc.rst
+++ b/Documentation/doc-guide/kernel-doc.rst
@@ -77,7 +77,7 @@ The general format of a function and function-like macro kernel-doc comment is::
    * Context: Describes whether the function can sleep, what locks it takes,
    *          releases, or expects to be held. It can extend over multiple
    *          lines.
-   * Return: Describe the return value of foobar.
+   * Return: Describe the return value of function_name.
    *
    * The return value description can also have multiple paragraphs, and should
    * be placed at the end of the comment block.
-- 
2.19.1

