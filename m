Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751708AbeBBAJj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 19:09:39 -0500
Received: from ozlabs.org ([103.22.144.67]:52543 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751555AbeBBAJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 19:09:31 -0500
Date: Fri, 2 Feb 2018 11:09:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alban Crequy <alban@kinvolk.io>, Dongsu Park <dongsu@kinvolk.io>,
        Jeff Layton <jlayton@redhat.com>
Subject: linux-next: manual merge of the integrity tree with Linus' tree
Message-ID: <20180202110928.0ca234ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the integrity tree got a conflict in:

  security/integrity/ima/ima_main.c

between commit:

  3b370b215f4b ("IMA: switch IMA over to new i_version API")

from Linus' tree and commit:

  d56f30ac85c0 ("ima: force re-appraisal on filesystems with FS_IMA_NO_CACHE")

from the integrity tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc security/integrity/ima/ima_main.c
index 2cfb0c714967,83edbad81f83..000000000000
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@@ -24,7 -24,7 +24,8 @@@
  #include <linux/slab.h>
  #include <linux/xattr.h>
  #include <linux/ima.h>
 +#include <linux/iversion.h>
+ #include <linux/fs.h>
  
  #include "ima.h"
  
