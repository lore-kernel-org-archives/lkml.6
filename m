Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3723396-1519415109-2-2528498157430458964
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519415109; b=mR8htXWy9cOeYh9hj1CmxBwMlPannLvCjymE56Z1yb187bY
    Hx83IBD0uJAQij/8uWAIVazCzhRXn9w6keqbMLwADf+qs2OjgXJC52tFG7UYSRWu
    rvCyAqW8olb1X0/r4BQEnoP3kYMIzzrojfQcl0jNCgF1vCuIlCErp3VJFfVp6sGA
    rVZw//f+8C0AhQjBMKxbFaUwr8/RZ+KAKOwnq7KD5GVJ0vYfkI5YAj8rIdzl2xGW
    iBzjsdQj4SOXYlkyEzKJAbbPTTOG512kcF0L+kbrJevHCqnbDxjmp0QnU0SSwafm
    NKLRVvrKqlNbI65cghPipWu4aTrXI3Z92o4rhTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1519415109; bh=X6d6H9slIPfBJfxQrUFj/fBmHi
    rtlBERy75TLrvOOt0=; b=xEbKASq8HEXznCxYRouXydm0nadvcOLFfz5F9wKLay
    WgBE+G1dbjOQFDMqZjJviBm9wdnInpPHMx3I0p1IjF0NhD1Ad7rDE2PztIBasmnt
    IVnCuQgi+bm+23ZEPDqDPfNcY/USz4Ld4IvSxe9c15AktGEw82T21QexitbQ4RuK
    HFJCNASpqMqsDoERS/fGKR54VX5ICJjzjOu4ttw8AugG9OOsIWI+xrRazTQQz+TQ
    z7z1gdZw20XEhLSW0Z170DCtAkxT4QNSE9ReqN2Y6DFJqxtAPjpBEQWGnnt19cpl
    qPgWhqDDpwnWtyTqjtu6BAcJHuk2lvzTYyN25bIaBgyw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934308AbeBWSsO (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Feb 2018 13:48:14 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:44822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934018AbeBWSsM (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Feb 2018 13:48:12 -0500
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 131/145] ISDN: eicon: reduce stack size of sig_ind function
Date: Fri, 23 Feb 2018 19:27:17 +0100
Message-Id: <20180223170741.706992588@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180223170724.669759283@linuxfoundation.org>
References: <20180223170724.669759283@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnd Bergmann <arnd@arndb.de>

commit 27d807180ae0a9e50d90adf9b22573c21be904c2 upstream.

I noticed that this function uses a lot of kernel stack when the
"latent entropy" plugin is enabled:

drivers/isdn/hardware/eicon/message.c: In function 'sig_ind':
drivers/isdn/hardware/eicon/message.c:6113:1: error: the frame size of 1168 bytes is larger than 1152 bytes [-Werror=frame-larger-than=]

We currently don't warn about this, as we raise the warning limit
to 2048 bytes in mainline, but I'd like to lower that limit again
in the future, and this function can easily be changed to be more
efficient and avoid that warning, by making some of its local
variables 'const'.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/isdn/hardware/eicon/message.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/isdn/hardware/eicon/message.c
+++ b/drivers/isdn/hardware/eicon/message.c
@@ -147,7 +147,7 @@ static word plci_remove_check(PLCI *);
 static void listen_check(DIVA_CAPI_ADAPTER *);
 static byte AddInfo(byte **, byte **, byte *, byte *);
 static byte getChannel(API_PARSE *);
-static void IndParse(PLCI *, word *, byte **, byte);
+static void IndParse(PLCI *, const word *, byte **, byte);
 static byte ie_compare(byte *, byte *);
 static word find_cip(DIVA_CAPI_ADAPTER *, byte *, byte *);
 static word CPN_filter_ok(byte *cpn, DIVA_CAPI_ADAPTER *, word);
@@ -4858,7 +4858,7 @@ static void sig_ind(PLCI *plci)
 	/* included before the ESC_MSGTYPE and MAXPARMSIDS has to be incremented */
 	/* SMSG is situated at the end because its 0 (for compatibility reasons */
 	/* (see Info_Mask Bit 4, first IE. then the message type)           */
-	word parms_id[] =
+	static const word parms_id[] =
 		{MAXPARMSIDS, CPN, 0xff, DSA, OSA, BC, LLC, HLC, ESC_CAUSE, DSP, DT, CHA,
 		 UUI, CONG_RR, CONG_RNR, ESC_CHI, KEY, CHI, CAU, ESC_LAW,
 		 RDN, RDX, CONN_NR, RIN, NI, CAI, ESC_CR,
@@ -4866,12 +4866,12 @@ static void sig_ind(PLCI *plci)
 	/* 14 FTY repl by ESC_CHI */
 	/* 18 PI  repl by ESC_LAW */
 	/* removed OAD changed to 0xff for future use, OAD is multiIE now */
-	word multi_fac_id[] = {1, FTY};
-	word multi_pi_id[]  = {1, PI};
-	word multi_CiPN_id[]  = {1, OAD};
-	word multi_ssext_id[]  = {1, ESC_SSEXT};
+	static const word multi_fac_id[] = {1, FTY};
+	static const word multi_pi_id[]  = {1, PI};
+	static const word multi_CiPN_id[]  = {1, OAD};
+	static const word multi_ssext_id[]  = {1, ESC_SSEXT};
 
-	word multi_vswitch_id[]  = {1, ESC_VSWITCH};
+	static const word multi_vswitch_id[]  = {1, ESC_VSWITCH};
 
 	byte *cau;
 	word ncci;
@@ -8924,7 +8924,7 @@ static void listen_check(DIVA_CAPI_ADAPT
 /* functions for all parameters sent in INDs                        */
 /*------------------------------------------------------------------*/
 
-static void IndParse(PLCI *plci, word *parms_id, byte **parms, byte multiIEsize)
+static void IndParse(PLCI *plci, const word *parms_id, byte **parms, byte multiIEsize)
 {
 	word ploc;            /* points to current location within packet */
 	byte w;
