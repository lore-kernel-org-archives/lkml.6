Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F8BC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F5EB204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498767;
	bh=Vhce3c6QbE3Of8SMeCai8zqIg+f4IFZB1ylfHMILmFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mvNHkvE8CFXu0dDxkbnvAerkjlXOV+tvlvZnkKg0VU3x1gTyU8cKK9EqShfGNs+zV
	 DKdIUDEDu6Kyxd98qhFjLbTneByocvUbiW8H+U8zCdjaAycsd6c0zIWhQm+Sphwr7N
	 dmv/+Lm1Oci+ekDdyCXb652uZn1LcncEGS1l+F90=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390326AbfBROGF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:06:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:49038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390313AbfBROGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:06:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92E4D21908;
        Mon, 18 Feb 2019 14:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498762;
        bh=Vhce3c6QbE3Of8SMeCai8zqIg+f4IFZB1ylfHMILmFw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j50rxc2yQuGXnacZcSHPAOMwErk4JjCv/ze3WL0jEDHWqYql1GakogshgialTYe5j
         emcUPwIto/zoFFlJ/1w5gkfLFsG0mo/KDFBye0bGm38c4lYjC2+j+zhc8XwHni8UP+
         MItqLFMoNyvwgh2HiipjlJtXLImIi5IPHN3yAOME=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "zhangyi (F)" <yi.zhang@huawei.com>,
        Steve French <stfrench@microsoft.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 113/143] Revert "cifs: In Kconfig CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)"
Date:   Mon, 18 Feb 2019 14:44:01 +0100
Message-Id: <20190218133533.150455176@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133529.099444112@linuxfoundation.org>
References: <20190218133529.099444112@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This reverts commit 60da90b224ba77a934decbb8129dabc861edd526 which is
commit 6e785302dad32228819d8066e5376acd15d0e6ba upstream.

Yi writes:
	I notice that 4.4.169 merged 60da90b224ba7 ("cifs: In Kconfig
	CONFIG_CIFS_POSIX needs depends on legacy (insecure cifs)") add
	a Kconfig dependency CIFS_ALLOW_INSECURE_LEGACY, which was not
	defined in 4.4 stable, so after this patch we are not able to
	enable CIFS_POSIX anymore. Linux 4.4 stable didn't merge the
	legacy dialects codes, so do we really need this patch for 4.4?

So revert this patch.

Reported-by: "zhangyi (F)" <yi.zhang@huawei.com>
Cc: Steve French <stfrench@microsoft.com>
Cc: Pavel Shilovsky <pshilov@microsoft.com>
Cc: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/cifs/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -111,7 +111,7 @@ config CIFS_XATTR
 
 config CIFS_POSIX
         bool "CIFS POSIX Extensions"
-        depends on CIFS && CIFS_ALLOW_INSECURE_LEGACY && CIFS_XATTR
+        depends on CIFS_XATTR
         help
           Enabling this option will cause the cifs client to attempt to
 	  negotiate a newer dialect with servers, such as Samba 3.0.5


