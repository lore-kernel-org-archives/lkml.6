Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3340693-1520825112-2-11574074871868720902
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520825112; b=HdT/AB1kAU8A/M5NB8uU4cUy07GapzXpSNQZOr0Q8Yxlfzs
    juA9AdoCWy7Eteixq9TY5DntWueALdvan+65+o0Zl6CDo2aCm+SYLlcpBJXwJRlH
    IwgzLF1xSIUVbJVCs3d+vMtoAmaRRWQ31c6J3DBsOTisqa63jd4VwzZzM27TyzYL
    XadWpjZcOj+oWsSsSZtapakXmIziv4BQNEqsBeP/1GmLmLFI7LH51/PwfgwOB8Zm
    qStWkzb+g+ZGrdPWlNhWw3jyKungvntS7/TuV1U5X2wenrSHc5i6kslIEno+Amv0
    tF1jtkw2RalMr3qMWk5GqByVdOOep9t+N3x15wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1520825112; bh=LJCSjT3ky4/Iq4T7Hlb
    RlBpa3NMFjKMuWGK+Lsk7AaU=; b=ZIdNoSbYF+sUWxkJ03onMmk/wQ+sO62Lx91
    D934SskF/BFM96+ZSSx6YoErdu0jDoVccTJizrICSBt4tabcbNC0htqEeXhWo9Pp
    klu46gxR4ubh4Jg7YHUxHd8Cvc9jBE/8p4lzL0QsRSMwBlpzkpDXM/qpXnmnuB83
    L1FLsl+w+mJb2erYm4kanu6ib7GZ9D6+xwxE0J5w9bpmOznrkxTVrV5MeyiSVd9u
    7qvbd/Frg/SiuxZbkNCvtf74aeEdkB6ZYOqcQdqvOa1YIwP2qA0dnytFxtSnbkvz
    lf0MtqEbkjlZmwH2CfGxcl7qANrS7d7tsihW191tfJbXQcdaFEg==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932875AbeCLDYP (ORCPT <rfc822;greg@kroah.com>);
        Sun, 11 Mar 2018 23:24:15 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41239 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932688AbeCLDHn (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 11 Mar 2018 23:07:43 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Paul Bolle" <pebolle@tiscali.nl>,
        "Mauro Carvalho Chehab" <mchehab@redhat.com>
Date: Mon, 12 Mar 2018 03:03:34 +0000
Message-ID: <lsq.1520823814.541180190@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 024/104] [media] budget-av: only use t_state if
 initialized
In-Reply-To: <lsq.1520823814.606620518@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.2.101-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Bolle <pebolle@tiscali.nl>

commit cb31c7487580a0cfc6eb253e604c1e51ac8eb3c8 upstream.

Building budget-av.o triggers this GCC warning:
    In file included from drivers/media/pci/ttpci/budget-av.c:44:0:
    drivers/media/dvb-frontends/tda8261_cfg.h: In function ‘tda8261_get_bandwidth’:
    drivers/media/dvb-frontends/tda8261_cfg.h:68:21: warning: ‘t_state.bandwidth’ may be used uninitialized in this function [-Wuninitialized]
Move the printk() that uses t_state.bandwith to the location where it
should be initialized to fix this.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
Signed-off-by: Mauro Carvalho Chehab <mchehab@redhat.com>
[bwh: Backported to 3.2: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/media/dvb/frontends/tda8261_cfg.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/media/dvb/frontends/tda8261_cfg.h
+++ b/drivers/media/dvb/frontends/tda8261_cfg.h
@@ -78,7 +78,7 @@ static int tda8261_get_bandwidth(struct
 			return err;
 		}
 		*bandwidth = t_state.bandwidth;
+		printk("%s: Bandwidth=%d\n", __func__, t_state.bandwidth);
 	}
-	printk("%s: Bandwidth=%d\n", __func__, t_state.bandwidth);
 	return 0;
 }
