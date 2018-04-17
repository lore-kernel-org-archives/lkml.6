Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2214042-1523981124-2-14807469479375824315
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
    1523981124; b=YVZdmw1HDn/9VJCsYWbakPNmI5EPHtJJ9K1uFODY4CmsWFgoUi
    XJpJbScjG/a5FovDr13Jmu/SrpLWg3s7S/jMoVJ1JWd71E9LfgbwPe8cDRiTv9Ab
    4cASENvEVTpWAcezHO5LPjfegDIYfjl69SLNl7jDgikz0u7tdOsDY5bPfZAcrLVR
    29GA7rkVn/APqHO1fiuyxnLxRifLIIUrw3z82Z4paRHcTJJaLVhQY1EVZTJiThXB
    Qzz3P7jByTUYSADMFLeLnuog8xSRdsx3ASkn2CUxd9hz7Jx6vYA168WrFAM/5XkH
    ScSRqvO7T6fw8mDJYybfm6ilYdA4DooQ00Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523981124; bh=K+NK9NY7eYzBa4bx0Ox7VZNJ2pq/Cb
    54ROfU/bzw2sE=; b=lKxCVsWjYOPx6SaMQNkyTqDSpFW4o3j6JnIpsPPGx9xBhg
    hISt9DftpV8ykBwvBrB47bOokywYZm5qAtm5guyOzptyQuQPljDGqf5FSwOihrFR
    ZYW0p0gnYJzoftSMYNGWehl63/CV0/SXLHwHC6Y1Q22fWGYAFu6851DH+nuS2jpu
    qWn47autOMZRyCcyyf4qS3Bs5ATCGlzalwoZ8Q4NJbIirrFVNmS/osFPd2zqzhQr
    73xtRgRslo6E46u/BPHMvIUGJKZ1mxeb3aG4ayrn0Mu0Mgw0ncTanxpyWY0hpX/7
    I4i+Tb1qiazyZt0NbW2j0zh6/EMtCC7PSq6OoeKg==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
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
X-CM-Envelope: MS4wfMR6Dsvl26EDLVfG9Cm1NyySJzuUtAQT0u6YSeoGZdCDW4dy1Sr6lexvckMl4fB3iaUf9Axsqk84GVYcfPrpQ0IpJh9rPVl+ORJ/NXaRVDvBlJQ+xKrJ
    4EykkTYUUz4ymTGoh4RupKZ1tgqzTarHjgw6zb61aTFGD83VLhtiF8+QE5Fo8DNPpC0XHAiDphC7E4brnfQ0mFL92MOD3DaGk/R/3ifUUELNZNNoZfpn2CrG
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=ag1SF4gXAAAA:8
    a=dfQ2E3TAiIWzVAIqwNIA:9 a=QEXdDO2ut3YA:10 a=xXcJMSfwO6gA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753702AbeDQQFR (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:05:17 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34486 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754698AbeDQQFQ (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:05:16 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <mszeredi@redhat.com>
Subject: [PATCH 4.15 53/53] ovl: set lower layer st_dev only if setting lower st_ino
Date: Tue, 17 Apr 2018 17:59:18 +0200
Message-Id: <20180417155725.606300519@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155723.091120060@linuxfoundation.org>
References: <20180417155723.091120060@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Amir Goldstein <amir73il@gmail.com>

commit 9f99e50d460ac7fd5f6c9b97aad0088c28c8656d upstream.

For broken hardlinks, we do not return lower st_ino, so we should
also not return lower pseudo st_dev.

Fixes: a0c5ad307ac0 ("ovl: relax same fs constraint for constant st_ino")
Cc: <stable@vger.kernel.org> #v4.15
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/overlayfs/inode.c |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -110,13 +110,10 @@ int ovl_getattr(const struct path *path,
 			 * that the upper hardlink is not broken.
 			 */
 			if (is_dir || lowerstat.nlink == 1 ||
-			    ovl_test_flag(OVL_INDEX, d_inode(dentry)))
+			    ovl_test_flag(OVL_INDEX, d_inode(dentry))) {
 				stat->ino = lowerstat.ino;
-
-			if (samefs)
-				WARN_ON_ONCE(stat->dev != lowerstat.dev);
-			else
 				stat->dev = ovl_get_pseudo_dev(dentry);
+			}
 		}
 		if (samefs) {
 			/*
