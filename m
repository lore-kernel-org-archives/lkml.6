Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2727985-1519127909-2-15524421183646946972
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: 
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519127909; b=u2DpFEmAgF0MgQ06Jlr4+P+PXz6N+Vk5YZ8/h0iHdBNx5Vc
    pXNm6EIBXqx0ojPSz08CgpPev3sPVsg0JXHdwqXsTzGMObAZCkvtTfmX51ZqalUD
    ZvhbCBoexeH8YFx43fEyNNBk7ZP/GkEibc+eZiaG/N5TlGRiKZ4QKK/QY/zW8XRK
    N32CXMIVEhKOmlMIxXLwkE3Qe+DMVQ64ZPOZEa9sRG5wb+gylBcfwhh3S0NORLUq
    Sjw0QKSXawKu8vRpKbBBTnNP4cDL4EPC2zYqyhdRlVzmMFH1HYl5ji+4D4ULACL6
    NtiuJ51BkRSQKXeNKqdxjIysPu8fyOUfSDT/PtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=arctest; t=1519127909;
    bh=bDJS72b2GdfqrDhVpqZEctYOxr5ZlWwzAm1XQx8YQv4=; b=K1K7U5yE6Qa/
    cBl6ql/J43h6+Rv7t5yTJFGJyi9dhEleE72r7KBUKyWN/WhgGGYkzyZEGBsoCat4
    l/D7E4cymLcLUsrdNOOyXmVQtwXbGGarr+5cqcnmjYSSiAL2E8ONnxgEzRf2n8hk
    eetLUSRGO9N3eaacGblp9VHcnB1xQ2ltEqQIYT04dhavL6ZHGPQCDEMrNUEpbkNe
    Bd5a1BOei8stcYW/n8ogvIpnLR5OeBHbI4PEsv28iARrgfnVzwnyAK55NgTb2TK3
    belyv281psLqUaLaWMA9hA4fGZHIZ77BCXnVCJ80QvA/CIpUw6+C7vedyRyev632
    P15kGW4s3A==
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
        id S1751446AbeBTL60 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 20 Feb 2018 06:58:26 -0500
Received: from mout.kundenserver.de ([212.227.17.10]:45911 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751474AbeBTL6Y (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 20 Feb 2018 06:58:24 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: stable@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "James E.J. Bottomley" <JBottomley@odin.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [4.4-stable 08/22] ncr5380: shut up gcc indentation warning
Date: Tue, 20 Feb 2018 12:54:55 +0100
Message-Id: <20180220115527.1806578-9-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180220115527.1806578-1-arnd@arndb.de>
References: <20180220115527.1806578-1-arnd@arndb.de>
X-Provags-ID: V03:K0:RUU1clkYfgsUVnw1Lk3LddoZBmZfF0wyYU3cxDFccCW5k7Z70TV
 T2YzoVx7MGmX+Dlfga6HAoI7oUFKznNfZZtN+qrkLJaS9ty2tlr5LFJCJl6wOPx9eaO/AIe
 +5clOYYuzLAVVU24dJU2uVH99ZkVDpxsH73MhnOd2a1HOSHYgbtQByJ2LivRw0pYKyzTII4
 r+EaYKKRKpxo4+ON2kWYA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:diMIuK4UFDY=:W89rTGggwEetSBNA+xw74n
 tSQpsokqeK6dX7Ol/fK7oxsR8U7fLg4vBtiNFgcT5u1gzan9k08G60b574kZjOX5HfGB8BxEg
 LcLsl3jdLYIsOZd5GRJcf/xtcDchYiI6vWQbPfi85GEb8UCvkRxcKhkzDSOcpidKw1pRaItLF
 dZfTxP5pikAg6P6nxnozcIClZxCnoPkLlPaYtFF0Pn25qkz8AEk0mMk6Cwq8fY0W3OMyA8BY2
 RS/0diKg6VYx2xNucrLkuBDHXvaYdTTZWxkWRyv2/DePDbqLmCRSEB9oAfWkku+uy47qzq7xc
 ca1cUsnP2grgQFCsLoE0DtNWB3xDj+CXdGQKKFNzJe9iOJDrjjOjhgerG9OE+AFsbEH1NzPmi
 FjyocWu0s9rQEzVAGiByge3S6kZlUbTkOxwXkEiKeIbOXZ58O+KJ7u90V7D95EACgcqCZb1mF
 sQVrMrQu9v2CMd66ZsyUWwjzWN9gMYu7EVeSbNTs5lVOmZsuHMZstfE1QGiJCjnmuONjE63zD
 vkXT7M1NjgTOTOXzdh4HIFbGUUH9wcnjEzrJMG4atIte+k7+e+ADshbHx7C4aS7D+hlqCgEJV
 BB26wmj0JBVV0jiVr88A2uwzYQmcq0FbIB/lSWBOK1LnGU2nE5IcbpOg+KHw1GsyK1PLvBaIV
 8dJ5NrwtQRaTTMblUQNViWNengnQLuick1IrWGhekkJEMnPP6ZsEq4aPfVS0i5dEsCevIO+58
 crSMzfJZKOGYCxNcmH9YH7QO5pVsDnWWtdbkpg==
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

gcc-6 and higher warn about the way some loops are written in
the ncr5380 driver:

drivers/scsi/g_NCR5380.c: In function 'generic_NCR5380_pread':
drivers/scsi/g_NCR5380.c:541:3: error: this 'while' clause does not guard... [-Werror=misleading-indentation]
   while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY);
   ^~~~~
drivers/scsi/g_NCR5380.c:544:3: note: ...this statement, but the latter is misleadingly indented as if it is guarded by the 'while'

This was addressed in mainline kernels as part of a rework on commit
12150797d064 ("ncr5380: Use runtime register mapping"). We don't
want the entire patch backported to stable kernels, but we can
backport one hunk to get rid of the warning.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Finn Thain <fthain@telegraphics.com.au>
---
 drivers/scsi/g_NCR5380.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/g_NCR5380.c b/drivers/scsi/g_NCR5380.c
index f8d2478b11cc..87e081f8a386 100644
--- a/drivers/scsi/g_NCR5380.c
+++ b/drivers/scsi/g_NCR5380.c
@@ -538,7 +538,10 @@ static inline int NCR5380_pread(struct Scsi_Host *instance, unsigned char *dst,
 			printk(KERN_ERR "53C400r: Got 53C80_IRQ start=%d, blocks=%d\n", start, blocks);
 			return -1;
 		}
-		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY);
+		while (NCR5380_read(C400_CONTROL_STATUS_REG) & CSR_HOST_BUF_NOT_RDY)
+		{
+			// FIXME - no timeout
+		}
 
 #ifndef SCSI_G_NCR5380_MEM
 		{
-- 
2.9.0
