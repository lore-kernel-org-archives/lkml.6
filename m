Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3339499-1523480167-2-7762861529373099619
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
    1523480166; b=A9X+HYxmnkrLo5SXJw9Djllw+s37vYxia4zYYk3y8qsiBE5Yvy
    VtEiWrXYcNdY7rNaiGOGGzT48DvnIbwUmhA+wWjlwSiY53oT7OvnZUcTjdYnKuw+
    9HmR0OgQSxXEgtyndXXI7p7lHz+LaCY4Q8Id/dcc5nUvHiw5XZeGa+zwSFAfnJR8
    35I9ODgOSoYNRWQMQ5vDMOXOuJaruV2gVCIhlnpbMXgy4HA7rOHI+BwyJiPY0EjC
    uc25iEmkvZQ0LeKPypKNG7bSbWDEeWMLHNUdS5yWcoEVNcGmqtzMudBZFvguHYxX
    dUUpxvBHL0OCYssuaxhkI9DnB9lNldPHrkNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523480166; bh=5vNxwgjuZXkdJmprKl8OkU8oyH9Pyx
    WYBPGDGVxN4xM=; b=nfYW/1MehNg/gt0rzAZGrCDfCzciue1ibl7Ae4k7Lw4ze8
    xPHiK01UmQMTfSmL1vIHnTLW7wiCH0Tw5JKfQzzFP3mscZkYRVVi5NdrdavBLMp0
    GEnr5Lsl86hyjtz3F5biYfStWVGfIThG7kvFjtk3SYpX5qBjNDscwGrWeiPmBAcX
    RCp1n0TbcSGUp+3HIsg+aRHmhTod1EQVSYfcaM47UgfDb3T8yWPQRpkn5sOjqxc9
    qVA+PtQb/4c7Asbbt9Zmm1+r6FHoIHou4d2OYh3m321e8SMn5rtgOyVHU+abDB51
    nOLYGF97bisMY9Rvi7nTrYksz+ohU70XhxKVkBzQ==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
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
X-CM-Envelope: MS4wfPwucDnCYTHg4ARwl5QJxNHn6nTaX1fOqBRAl49OtjJHWHWeBF6NT1cSDpSywQ2g5NlGxhMYEs4L+/5mKYB0XOwS9aTev7eV+pM3osiyzePxpoFia2Ci
    Yy84SgDQ5FDa79KabqRXZLNMWd+pRcZx4RBgpIQIWgrH31cHBx/OBFG3ZTNliI92Qsbx8/riYNbFRgdn41j6+kNCaOuxW9hlbvy+fJRiFOYpweDkW8cuOySl
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=DfNHnWVPAAAA:8 a=J1Y8HTJGAAAA:8 a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8
    a=XsmskROauiS9Y1dqrRkA:9 a=QEXdDO2ut3YA:10 a=rjTVMONInIDnV1a_A2c_:22
    a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932213AbeDKSoo (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 14:44:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:58324 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755417AbeDKSom (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:44:42 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 023/190] netxen_nic: set rcode to the return status from the call to netxen_issue_cmd
Date: Wed, 11 Apr 2018 20:34:29 +0200
Message-Id: <20180411183551.491656553@linuxfoundation.org>
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

From: Colin Ian King <colin.king@canonical.com>


[ Upstream commit 0fe20fafd1791f993806d417048213ec57b81045 ]

Currently rcode is being initialized to NX_RCODE_SUCCESS and later it
is checked to see if it is not NX_RCODE_SUCCESS which is never true. It
appears that there is an unintentional missing assignment of rcode from
the return of the call to netxen_issue_cmd() that was dropped in
an earlier fix, so add it in.

Detected by CoverityScan, CID#401900 ("Logically dead code")

Fixes: 2dcd5d95ad6b2 ("netxen_nic: fix cdrp race condition")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
+++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_ctx.c
@@ -247,7 +247,7 @@ nx_fw_cmd_set_mtu(struct netxen_adapter
 	cmd.req.arg3 = 0;
 
 	if (recv_ctx->state == NX_HOST_CTX_STATE_ACTIVE)
-		netxen_issue_cmd(adapter, &cmd);
+		rcode = netxen_issue_cmd(adapter, &cmd);
 
 	if (rcode != NX_RCODE_SUCCESS)
 		return -EIO;
