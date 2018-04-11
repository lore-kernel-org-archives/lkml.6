Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523480217-2-17284155388654083504
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
    1523480216; b=BUiSnIrJaQHgP3WAnNmqBB7xV9sEQ9rSvV+q5GZHcn3+Ig1EPQ
    c+DdeRNYWFowAdQ2RzUF+jE7UyaLBYiRLK08NIkBA3GZk3j3HWvoJ5ZlDWUySCYq
    LU/JT+VwKfVMKwTiwLvFd6uQHPoje9aSsUTn/CCyYH6oztF/NEwsmFeBmrTvqxvY
    TvUpHvgEI+el6rbw39Q6bCKqhalu1q/zdwi4fJdyTh9ffghHaBJIamDL0VDcxMOD
    XmqFSiflTrsA3MB4GILeiIrdNXd8whEHUCKdpCwdZi/SESQaJzy3hKaPAfG97ffu
    3josUSxqcyGPzAfSbcKiU1n66HQexw+W3rew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480216; bh=EnuBwpKYq1PQHRppAi13xgtxxUqVzw
    cH21Vpwp+I0O0=; b=TkFkImuD76tWlRrJLhhSdO2l5r/mFugh2TI2uwIdR9e12Z
    iidycOo+OAoKS3TsAktybSBK/cpvJ7DH3Z18jBzKP24frcsqjOo4hHXFoH3ttv3q
    qhQJc41/qNo5A7Hy1HFsUul3W5pFVmUrxi+3t9bUMxTzeDEg0ArqFa/+CzQXDdLC
    7ZXoWuUXAUsj0aAS3174VhPVhUFDYBP/gpN1QkhPA6w+0xciRxbF94Z06rV5xhr1
    6QNxmPCcIlQlzMh3zFlc4ZcUffb1Qgh7N4XM54euyf5/R5wAI+10UTOMCB3oHo38
    rVwBRqZb6hXk/l495IWKHd7V089BRR23YOUIdgBg==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
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
X-CM-Envelope: MS4wfH7y5NpquX0sMR+UHhU12ldHgHlflihYlwDeiMV703TLlo0hl7Pl29P8wRNbTYmzYeReKISnbmPhG4jIhgzwe39HxJUo5K/ohoLgwp+216ZrjwVhmwoQ
    71oXh2/Vwn6hO7t0s8GsB6ERNDr8RcH/VOsk/eXa18w69XTDCKoWJ/YHmcjxoUgkK/iM9mOAPMfpI/me/iq6wEKeGrXqmhXNANNUTNN+b2CY2y458UiJWC7/
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=cm27Pg_UAAAA:8 a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=Bz2UWhLJlFZaMJpv9z8A:9 a=QEXdDO2ut3YA:10
    a=xmb-EsYY8bH0VWELuYED:22 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755714AbeDKU4n (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 16:56:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58290 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754827AbeDKSoh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:37 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Micay <danielmicay@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 009/190] bna: Avoid reading past end of buffer
Date: Wed, 11 Apr 2018 20:34:15 +0200
Message-Id: <20180411183550.595606178@linuxfoundation.org>
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

From: Kees Cook <keescook@chromium.org>


[ Upstream commit 9e4eb1ce472fbf7b007f23c88ec11c37265e401c ]

Using memcpy() from a string that is shorter than the length copied means
the destination buffer is being filled with arbitrary data from the kernel
rodata segment. Instead, use strncpy() which will fill the trailing bytes
with zeros.

This was found with the future CONFIG_FORTIFY_SOURCE feature.

Cc: Daniel Micay <danielmicay@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/brocade/bna/bfa_ioc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/brocade/bna/bfa_ioc.c
+++ b/drivers/net/ethernet/brocade/bna/bfa_ioc.c
@@ -2845,7 +2845,7 @@ bfa_ioc_get_adapter_optrom_ver(struct bf
 static void
 bfa_ioc_get_adapter_manufacturer(struct bfa_ioc *ioc, char *manufacturer)
 {
-	memcpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
+	strncpy(manufacturer, BFA_MFG_NAME, BFA_ADAPTER_MFG_NAME_LEN);
 }
 
 static void
