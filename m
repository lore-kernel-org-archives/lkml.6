Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2727985-1519128221-2-10885499885692666865
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES endaro,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519128221; b=b1Ot5Shmci2kIp3mL4QgliUfJaor/58nKflEmySQX4cXR74
    UmDVcOnoa22zrWTzZ9UyT2lwuDMkfKP9QrhTkh6lmstmYvp68OJkxaH5oNAtoQM9
    6YrvdxrRtIa92yLd8vmmGr66MVEzZHZbopLhi7CfCgw9GbC1SoGVQzjPyKBAcCRo
    q4PmvW2jsv7mml/JnwJTTzWj/2MHwjF9/HFf6q8WZvzoeFzDRzYgH0knInA+HGdD
    /GiLdmCVZLQF/AuCpttDmg8pZg4KU6zCfTOB8rwuFI7hSeG8Fi/qPQW4h0Ou2NJv
    vcADhKnOylzgK1Yop9WeS9eaAKCczo4cGjzuk3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519128221;
    bh=c6/JVI9PhrCZHdU5WmS9+nCrygsQ9kRFEVYVAW3urAg=; b=d082FPwPDWdl
    7GVrKGrl/E/Me/szrvwx/6zk+8Pu/Y+h45LeJVgLaHlenjo3FSAI0Y4xqQg1bOT3
    m1z6QPIZjQ3S1MniW5rS7kyxe5dHKlkzJmX5osvEjLbACLKT1xf6Yz2onlHaAPXw
    oDv82UeIOKRCKbo+VeI+Ad19awTxVihYwbjDCVQ9h3q8eLLO4BcHO2T/wTSeRDmB
    vV9MlxzDmJjSuprYDXJfqHA9chvwjHSlJ4zOw6vKpxlrp2K7j8Ia5dloCGGvWbg/
    jLF/r+0DgULiC6x9VQNQR5ys/q5eGrXSaJGVtUoktpm3gjHA1Nwk/t4jkzVQrxut
    swxLK85/OQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=arndb.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=arndb.de header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751694AbeBTMAJ (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 07:00:09 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:44449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751643AbeBTMAH (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 07:00:07 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Miklos Szeredi <mszeredi@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Petr Vandrovec <petr@vandrovec.name>
Subject: [4.4-stable 20/22] ncpfs: fix unused variable warning
Date: Tue, 20 Feb 2018 12:55:07 +0100
Message-Id: <20180220115527.1806578-21-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:bbYuVB2S+qrU85V94CfEFI8zD4MD28pQXW4ZMgrRb25k4vuexxf
 fvom2gUWMzSx4b0IVrHfFy4JoIydVxzCPwHYYWnLB4pB9AN9yLBE15oh3ZXtfEoFvOKyZGI
 YbNsd0/QZ/QqjnlC0isrZNZTZkjY7/Y5sMJnfg5K6l/uY5g8opA9GGawr0faNcJxFY5NiBD
 uNSSyl4bukkUYTe0BOfSg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Kxz6P+lxgHg=:l5QX0ZO1ML6npbSlYr8RhF
 +NcUbSdqvgoZad5+n05En2gMNbD/gwhh9sIQPwinNKmjJCbBSeFTq8dLSj3EXae2GdkU8Zc94
 Eo/GbwpDFrmLpUoIXNfakiAXmVmB4rFIMzyUeRZnTAceDTSKpyyDPrEJ06dRtNJ8d3Lab3HI8
 HNxfcv+05CPXuvmrHauA1r6uH1MkzbETHZrXAVObK4Ni53DLUgyhU8w2MV+u5MSJWdANp4SCo
 bivAWpa+Kiv2SjOccJLrrP3gKD8k5BfbPAbjyBlqT4SeXwmACcTjasUMhnUXzIvNwnPiBAXmd
 VlNrkMSQJp6/mL2j/1fRcUd0gKqGLWuJfsqggrOZ7lMYLPwqkUoCBm/DBW+1Q8V5yimI/hoKw
 48Br0m8OcFaeCFzqzbR67zTad+uRimZmzrtP5dSHKLR8k3x74meuOOUd9tPzt2htnJNDzkcrj
 M6FAYa0MtaiPbhMHhWZJDSh9TzScOPrjCPDxFiV20qbuEq1puFr4PLmh7TZPuBausIwTf2Jgz
 lxWWjskjqd6zBdXRvazLqMfe9y6BEM41RWMMx5rFnIC7n9afEy/p1dCz2gbz9cSmHV5sC5/bs
 T/UqIeDbX+sbY+kuNTxYIBNTc5FkvlAkQtqy3KGP9x1sl5XX7PU5uElPzwtGGUmm1bR3XQsN1
 3tjVZJdpdaqrTD7zDbCKgCxaqgO1yY3w5kkINtwxSRBugW/XDVEQ4cnSanD+OQpr+sTpD2qTB
 NAVVvJo5rwyojRIsntEeFiO01yBPngheO2YUng==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Miklos Szeredi <mszeredi@redhat.com>

commit 9a232de4999666b2e8ea6775b2b0e3e4feb09b7a upstream.

Without CONFIG_NCPFS_NLS the following warning is seen:

fs/ncpfs/dir.c: In function 'ncp_hash_dentry':
fs/ncpfs/dir.c:136:23: warning: unused variable 'sb' [-Wunused-variable]
   struct super_block *sb = dentry->d_sb;

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
[arnd: rebased to 4.4]
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ncpfs/dir.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ncpfs/dir.c b/fs/ncpfs/dir.c
index 03446c5a3ec1..4e1144512522 100644
--- a/fs/ncpfs/dir.c
+++ b/fs/ncpfs/dir.c
@@ -133,12 +133,11 @@ ncp_hash_dentry(const struct dentry *dentry, struct qstr *this)
 		return 0;
 
 	if (!ncp_case_sensitive(inode)) {
-		struct super_block *sb = dentry->d_sb;
 		struct nls_table *t;
 		unsigned long hash;
 		int i;
 
-		t = NCP_IO_TABLE(sb);
+		t = NCP_IO_TABLE(dentry->d_sb);
 		hash = init_name_hash();
 		for (i=0; i<this->len ; i++)
 			hash = partial_name_hash(ncp_tolower(t, this->name[i]),
-- 
2.9.0
