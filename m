Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523480403-2-13302788842469018314
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
    1523480403; b=ABR6nT541GwpsxOlxqM8XYcL8YabGeTN8qKvUtO3+3xpc2iYMR
    Fx55tz23ectPGy0/zeLNAn2fZhIj+8wMMSa+CkwGZFHnojukumCt+jvci5qOf3s5
    Hetx0+g0ubTH/CIjq/1dqNBFhmi8WfLMmlEbS5rEkRnIFAnX4TIJl8hthGeBJ/5s
    XKGzQxL4gZahwNp5+ABXsSvE7Wz2DhpgopbpDqnrKJdalLxNFYtIcKB5mZa3jeem
    Iph8aa1H3YeHhnAMSt82GnAggkzoGeb3D8By7uv1SaQx/oHMD4tXCoEIYAsSLXtj
    GVs9gF2fCKNzlmcxTX9GBJJvSyctOZdeinkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480403; bh=ySo4E7MSGUKSdymr+X43e2GPB+H1IH
    LV34Rb8JLbtFM=; b=seZ75AWOcmXq0SYx7gTTsY5QYAZ94LZTlzCHoovun/Ka5T
    3JSd5yiB+fT1Pev7o/8Yw02Lww7LkkkvjgB5DE5/zM00kS01lzzf1VVQNDjLtFNP
    fvY8MG8LAo0y/BKMh1aLzproCi3lZ7qZfcNwDduvgZ1AiZzsRJvF/su7qVyw6ZTi
    FVTiBygGA5aFtcM48J6mKHXfn1fwj3/mvV54O44idrcuk4JU8bc9MwnjgOIphXF8
    Wb0rHihrtZwBlHgsiLLp13XwPoCjVONOUV4UD7WArb9MD1j64UKRx5d7aSAUF/Hm
    dcXZbQ7MOa8D8TNemCdFp2Ueg5nFEAlfXCZe7oMw==
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
X-CM-Envelope: MS4wfFRiucjJP3/tRiQ6EQ3h/RmByw0e8pbv497dVyNx0DThhmMZk7Dmw09FjnkdsZxvsDXG92A05mFVZh820CeOvtmeNG4JjYwgagvOWxACDs//dTzzR1Sd
    Z3B+QN0p7QMG3QMZ/mXFnCz9CSgFU7w6vPzrusNK2yQAYX1ARclQvYELkpVqy0XYKsFFXRZDi3T+BIpzjC8BIUW6FeEkDZmbKVrlzmm7CE8XjnPv36M87XWw
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=yPCof4ZbAAAA:8 a=fk1lIlRQAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=8EMWpIwaYYN3MEKlIKMA:9 a=QEXdDO2ut3YA:10 a=U75ogvRika4pmaD_UPO0:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932118AbeDKSny (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:43:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57684 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932069AbeDKSnq (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:43:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Corey Minyard <cminyard@mvista.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 011/190] ipmi_ssif: unlock on allocation failure
Date: Wed, 11 Apr 2018 20:34:17 +0200
Message-Id: <20180411183550.692353146@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183550.114495991@linuxfoundation.org>
References: <20180411183550.114495991@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>


[ Upstream commit cf9806f32ef63b745f2486e0dbb2ac21f4ca44f0 ]

We should unlock and re-enable IRQs if this allocation fails.

Fixes: 259307074bfc ("ipmi: Add SMBus interface driver (SSIF) ")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Corey Minyard <cminyard@mvista.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/ipmi/ipmi_ssif.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -409,6 +409,7 @@ static void start_event_fetch(struct ssi
 	msg = ipmi_alloc_smi_msg();
 	if (!msg) {
 		ssif_info->ssif_state = SSIF_NORMAL;
+		ipmi_ssif_unlock_cond(ssif_info, flags);
 		return;
 	}
 
@@ -431,6 +432,7 @@ static void start_recv_msg_fetch(struct
 	msg = ipmi_alloc_smi_msg();
 	if (!msg) {
 		ssif_info->ssif_state = SSIF_NORMAL;
+		ipmi_ssif_unlock_cond(ssif_info, flags);
 		return;
 	}
 
