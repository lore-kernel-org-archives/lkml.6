Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23108C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0BCE21A4A
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 21:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbfBPVmY convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 16:42:24 -0500
Received: from shiva145.upmc.fr ([134.157.0.145]:52562 "EHLO shiva145.upmc.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727170AbfBPVmY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 16:42:24 -0500
X-Greylist: delayed 593 seconds by postgrey-1.27 at vger.kernel.org; Sat, 16 Feb 2019 16:42:22 EST
Received: from shiva145.upmc.fr (localhost [127.0.0.1])
        by shiva145.upmc.fr (Postfix) with ESMTP id 05ECD15A171;
        Sat, 16 Feb 2019 22:32:28 +0100 (CET)
Received: from courriel.upmc.fr (courriel2.reseau.jussieu.fr [134.157.0.193])
        by shiva145.upmc.fr (Postfix) with ESMTP id ECC5815A125;
        Sat, 16 Feb 2019 22:32:27 +0100 (CET)
X-CIds: courriel2
Received: from draws-f6bvp (astlambert-652-1-155-71.w92-151.abo.wanadoo.fr [92.151.34.71]) (authentified, mech=LOGIN)
          by courriel.upmc.fr (8.14.5/jtpda-5.5pre1) with ESMTP id x1GLWRQM042485 (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
          ; Sat, 16 Feb 2019 22:32:27 +0100 (CET) (envelope-from f6bvp@free.fr)
Date:   Sat, 16 Feb 2019 22:32:25 +0100
From:   f6bvp <f6bvp@free.fr>
To:     linux-kernel@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>
Subject: ax25: fix possible use-after-free
Message-ID: <20190216223225.788b8ae7@draws-f6bvp>
Organization: http://radiotelescope-lavillette.fr
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; arm-unknown-linux-gnueabihf)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch applied successfully on Linux draws-f6bvp 4.14.79-v7+ #1159 SMP Sun Nov 4 17:50:20 GMT 2018 armv7l GNU/Linux

However ax25_route_lock_use and ax25_route_lock_unuse() are not declared and compile failed.

make : on entre dans le répertoire « /usr/src/linux-headers-4.14.79-v7+ »
  CC [M]  /usr/src/linux-4.14.y/net/ax25/ax25_ip.o
/usr/src/linux-4.14.y/net/ax25/ax25_ip.c: In function ‘ax25_ip_xmit’:
/usr/src/linux-4.14.y/net/ax25/ax25_ip.c:117:2: error: implicit declaration of function ‘ax25_route_lock_use’ [-Werror=implicit-function-declaration]
  ax25_route_lock_use();
  ^~~~~~~~~~~~~~~~~~~
/usr/src/linux-4.14.y/net/ax25/ax25_ip.c:211:2: error: implicit declaration of function ‘ax25_route_lock_unuse’ [-Werror=implicit-function-declaration]
  ax25_route_lock_unuse();
  ^~~~~~~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors
scripts/Makefile.build:328 : la recette pour la cible « /usr/src/linux-4.14.y/net/ax25/ax25_ip.o » a échouée
make[1]: *** [/usr/src/linux-4.14.y/net/ax25/ax25_ip.o] Erreur 1
Makefile:1527 : la recette pour la cible « _module_/usr/src/linux-4.14.y/net/ax25 » a échouée
make: *** [_module_/usr/src/linux-4.14.y/net/ax25] Erreur 2
make : on quitte le répertoire « /usr/src/linux-headers-4.14.79-v7+ »


Bernard, f6bvp

