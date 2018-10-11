Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 982BFC67814
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B1D320835
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 19:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DxiJQMiw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B1D320835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727460AbeJLD0R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 23:26:17 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41612 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbeJLD0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 23:26:16 -0400
Received: by mail-ed1-f68.google.com with SMTP id x31-v6so9406735edd.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 12:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sY8lFgNHzVTBnpKwTIuGqrzOlN3CmfaWsXk48v4OqQg=;
        b=DxiJQMiwIY8BSbK0GzpZLbvN+3ltkjaE6HKIufpJrb0dwgja4ETFDwZR8cIhnjRNNV
         a3c0NAI68w4bA5f+JuMSOIsBp+5+6L4js/sufeGTS3OBYyNP4GsucMRl73oBjNbUzcQp
         W3KUru/5isZgm64cx0/3poXSrB2goawD1Fx4Eatw0VmJcz8Q9rb4pro4e4gUk2T+yBR9
         HRN1jGap7eEDNGYPzH5Ld+IpLvCOJxUKVcs4BkoPEeio8X8J0jHWI513wWJCz2cdlzUl
         Z6VPm6JnSattgoB+R0F5y5DmsZwb9Kd1FEjuOgErMLtBH1je6/aGgoQEPxdzYe87ipuP
         1x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sY8lFgNHzVTBnpKwTIuGqrzOlN3CmfaWsXk48v4OqQg=;
        b=q9wq+c0uRjqCS6eVxFQLlAVwookUkAEG1dxV9Lc+UhZuNx6Z5ne8N4wjSOOtxOgAQK
         SOfEsY3+2LrnR6bqIXuyTlV3SbfE/+PRF2e5T0umfh+KWO+rTS3XYeHY8iZ43DrctVyl
         i0TyWqZBypj1IOqkxrCebMIh+Zpp9pZjq3fzgaSeelmlR0OottkTPzdsgalwnXRRWJHT
         Qu3TFl5Z2rRCVMvvwandgyREN09s6cAjhkXOyyP/4Eg0gsFhQ3iN7doR5/tYZqE5MPQ7
         0EktmAN3cvqq0cg1ya737FLFdVGDt7fTtr0rajMAJdX59i7GZUMtyIO9WaPEuR8bjtFf
         kqlQ==
X-Gm-Message-State: ABuFfogAmrfI9bi5Yu5ontkyhH5hRyQPeSc1zh8XaLQzQtJXdIddZVt4
        bSO0sKoLsNGbaUaxy57MZe0=
X-Google-Smtp-Source: ACcGV61tFo0F/pWlvbJvld16e9cPZTC18E6/5jE7+kCskS8y1zYxNt5xJqBaFifxreFCcTyAwCIOXw==
X-Received: by 2002:a50:c191:: with SMTP id m17-v6mr4842745edf.123.1539287848375;
        Thu, 11 Oct 2018 12:57:28 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:85c0:57c8:8569:71c8:6dba:bb41])
        by smtp.gmail.com with ESMTPSA id k22-v6sm919408eja.23.2018.10.11.12.57.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 12:57:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/8] staging: rtl8188eu: cleanup alignment issue
Date:   Thu, 11 Oct 2018 21:57:07 +0200
Message-Id: <20181011195712.1472-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011195712.1472-1-straube.linux@gmail.com>
References: <20181011195712.1472-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clear a 'Alignment should match open parenthesis'
checkpatch issue.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 07b6e680377f..4a2921d8c862 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -863,9 +863,9 @@ s32 rtw_txframes_pending(struct adapter *padapter)
 	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
 
 	return (!list_empty(&pxmitpriv->be_pending.queue) ||
-			!list_empty(&pxmitpriv->bk_pending.queue) ||
-			!list_empty(&pxmitpriv->vi_pending.queue) ||
-			!list_empty(&pxmitpriv->vo_pending.queue));
+		!list_empty(&pxmitpriv->bk_pending.queue) ||
+		!list_empty(&pxmitpriv->vi_pending.queue) ||
+		!list_empty(&pxmitpriv->vo_pending.queue));
 }
 
 s32 rtw_txframes_sta_ac_pending(struct adapter *padapter, struct pkt_attrib *pattrib)
-- 
2.19.1

