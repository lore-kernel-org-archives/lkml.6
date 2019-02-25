Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2528C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B5FE2083D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131388;
	bh=0No+cfubOhhAgbQyTpUxU+rFSM/TJjX6zFTe6wmJbK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A8Hw/jELvlhoz5krgLpQ4hEB+C0ynoQtwoKqi1VhSzhoyNb/GdE7uCL/UOYC8+3ax
	 NyfgDBg17gxN+2/mIR+Y4zlgdyEuzrjbSDJo7u1RQxP3MTsGZwgOs9p8YG92iHtIHX
	 EngCS4Eou7e05hKQ3TkllSiVWFd3qVNBu3MR/UAw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730820AbfBYVZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:25:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:59750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730800AbfBYVZR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:25:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09F472084D;
        Mon, 25 Feb 2019 21:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129916;
        bh=0No+cfubOhhAgbQyTpUxU+rFSM/TJjX6zFTe6wmJbK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mVLAdzaTWuzXYQUTZ0zjNK6aR1/dKc2ykVhSB2cF7rD78BIP4QyG+WQW2TVc1sP7O
         d9gPW+l1KEPUv/xJaiD23a11MtSf4PaTWsOLMKPh4tZztA46rGr7wWjf9FmL56nKnA
         KG0mv0F5EQePSRmUOhBGhrJTKXzFDLlldKn3nVa0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 109/152] Revert "socket: fix struct ifreq size in compat ioctl"
Date:   Mon, 25 Feb 2019 22:11:41 +0100
Message-Id: <20190225195050.507522151@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195043.645958524@linuxfoundation.org>
References: <20190225195043.645958524@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit 63ff03ab786ab1bc6cca01d48eacd22c95b9b3eb ]

This reverts commit 1cebf8f143c2 ("socket: fix struct ifreq
size in compat ioctl"), it's a bugfix for another commit that
I'll revert next.

This is not a 'perfect' revert, I'm keeping some coding style
intact rather than revert to the state with indentation errors.

Cc: stable@vger.kernel.org
Fixes: 1cebf8f143c2 ("socket: fix struct ifreq size in compat ioctl")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/socket.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

--- a/net/socket.c
+++ b/net/socket.c
@@ -941,8 +941,7 @@ void dlci_ioctl_set(int (*hook) (unsigne
 EXPORT_SYMBOL(dlci_ioctl_set);
 
 static long sock_do_ioctl(struct net *net, struct socket *sock,
-			  unsigned int cmd, unsigned long arg,
-			  unsigned int ifreq_size)
+			  unsigned int cmd, unsigned long arg)
 {
 	int err;
 	void __user *argp = (void __user *)arg;
@@ -968,11 +967,11 @@ static long sock_do_ioctl(struct net *ne
 	} else {
 		struct ifreq ifr;
 		bool need_copyout;
-		if (copy_from_user(&ifr, argp, ifreq_size))
+		if (copy_from_user(&ifr, argp, sizeof(struct ifreq)))
 			return -EFAULT;
 		err = dev_ioctl(net, cmd, &ifr, &need_copyout);
 		if (!err && need_copyout)
-			if (copy_to_user(argp, &ifr, ifreq_size))
+			if (copy_to_user(argp, &ifr, sizeof(struct ifreq)))
 				return -EFAULT;
 	}
 	return err;
@@ -1071,8 +1070,7 @@ static long sock_ioctl(struct file *file
 			err = open_related_ns(&net->ns, get_net_ns);
 			break;
 		default:
-			err = sock_do_ioctl(net, sock, cmd, arg,
-					    sizeof(struct ifreq));
+			err = sock_do_ioctl(net, sock, cmd, arg);
 			break;
 		}
 	return err;
@@ -2752,8 +2750,7 @@ static int do_siocgstamp(struct net *net
 	int err;
 
 	set_fs(KERNEL_DS);
-	err = sock_do_ioctl(net, sock, cmd, (unsigned long)&ktv,
-			    sizeof(struct compat_ifreq));
+	err = sock_do_ioctl(net, sock, cmd, (unsigned long)&ktv);
 	set_fs(old_fs);
 	if (!err)
 		err = compat_put_timeval(&ktv, up);
@@ -2769,8 +2766,7 @@ static int do_siocgstampns(struct net *n
 	int err;
 
 	set_fs(KERNEL_DS);
-	err = sock_do_ioctl(net, sock, cmd, (unsigned long)&kts,
-			    sizeof(struct compat_ifreq));
+	err = sock_do_ioctl(net, sock, cmd, (unsigned long)&kts);
 	set_fs(old_fs);
 	if (!err)
 		err = compat_put_timespec(&kts, up);
@@ -3081,8 +3077,7 @@ static int routing_ioctl(struct net *net
 	}
 
 	set_fs(KERNEL_DS);
-	ret = sock_do_ioctl(net, sock, cmd, (unsigned long) r,
-			    sizeof(struct compat_ifreq));
+	ret = sock_do_ioctl(net, sock, cmd, (unsigned long) r);
 	set_fs(old_fs);
 
 out:
@@ -3195,8 +3190,7 @@ static int compat_sock_ioctl_trans(struc
 	case SIOCBONDSETHWADDR:
 	case SIOCBONDCHANGEACTIVE:
 	case SIOCGIFNAME:
-		return sock_do_ioctl(net, sock, cmd, arg,
-				     sizeof(struct compat_ifreq));
+		return sock_do_ioctl(net, sock, cmd, arg);
 	}
 
 	return -ENOIOCTLCMD;


