Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524652883-2-1427434344989855529
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
    1524652882; b=qwiaDeKOfbj1kVXLm/OHY61MK2GlHKhsCDmfgezWklhXGe3P8v
    gsfLrs22k/ywgCwgghj4/C3wgwzMxnUP1RoZPv9mALUEQWI7f1gWwh+a1NoN0dlb
    dniT/tZku8T1VfRGQOnhvLX6P7LmUtfwM2ejd91PCJE/UwDyNpk9Axv36TBe3puk
    KSBhY9lGnaDNT5qPwEJCHv1oh7PGW8pp9QhOgXOlDqZj2uxrIctz4E523S/BQGR0
    OJ4/PYAh1lF+i4WVee/vEVPqpWcCzoN3Ez0rw9G/1iDdJlz9SNf7gXrYQ8iNoH8r
    MI3rsneiAcL17St4zhEIovUDje+A/BSBd0+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524652882; bh=2AFFkBbtcOm8I0Ox4shl404ObyF2eo
    LuBKSZBgVuxeo=; b=HdoWsXEiR7AM9Zi4ryHdIgFPFsSZ9LmqWzjenWEbnQrHwn
    bPo2leCP5as15fiaN86RHhKyyN8mtFnb2SRSbootkakQ10xEuIBiowSr5Rq0+CkN
    IE3JKn26TtZvL2hmhwdou0yOlncL5OjmgLLIFF/SiFqjYZQZTb2m51FuTu6KRUEA
    qxgrdDInmUQpHC4eM5LmuZmfK6nEAl69qdxBYZC/ZrZI7A1jNJIoDrac7QeCi7no
    fPwlIPTi3vVRYVPJbo8sYDOMPAtNHLf2twtcs4oi8AAxh7zFzPeNEj/19eBQtpjp
    HgJtrxu3LLpnXslnMt6y75pnH8U4A70c0Nmg1dFg==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx3.messagingengine.com;
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
X-CM-Envelope: MS4wfIjFUi8G8pS2WgYIdO7ayiWcZjRV8CbuLjVmkXjq+jdkEcPisYX7V0lr4YkL8JWUEdHcBzDmUK8Z/HUrh47/r9RgalBrOhJMIhbsgcIRpjVc2RF9AGtG
    CKXe3jiduoPlE1awlFGhoj5cz0XrZp8TV/WlxuI1iRi5jn2A75t18egOM4bqqXgwoOp6M1XD3ab7AYMqIKyGQ1Z7AyBOf7PsUqGz0iZtzByVy4l5UR64gGAa
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=gXLdhW2jAAAA:8 a=iLNU1ar6AAAA:8 a=QyXUC8HyAAAA:8 a=yMhMjlubAAAA:8
    a=ag1SF4gXAAAA:8 a=xvk8Vxl33gcR_2_E6qIA:9 a=FcAp_tUTiSdhoCG3:21
    a=TzxsWyajHKV6ozKl:21 a=QEXdDO2ut3YA:10 a=Dn9eIPSr_RzuO0KTJioD:22
    a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752826AbeDYKlS (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:41:18 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752074AbeDYKlP (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:41:15 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>,
        Allen Hubbe <Allen.Hubbe@dell.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Jon Mason <jdmason@kudzu.us>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 100/183] ntb_transport: Fix bug with max_mw_size parameter
Date: Wed, 25 Apr 2018 12:35:20 +0200
Message-Id: <20180425103246.483618554@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180425103242.532713678@linuxfoundation.org>
References: <20180425103242.532713678@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Logan Gunthorpe <logang@deltatee.com>


[ Upstream commit cbd27448faff4843ac4b66cc71445a10623ff48d ]

When using the max_mw_size parameter of ntb_transport to limit the size of
the Memory windows, communication cannot be established and the queues
freeze.

This is because the mw_size that's reported to the peer is correctly
limited but the size used locally is not. So the MW is initialized
with a buffer smaller than the window but the TX side is using the
full window. This means the TX side will be writing to a region of the
window that points nowhere.

This is easily fixed by applying the same limit to tx_size in
ntb_transport_init_queue().

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/ntb_transport.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -998,6 +998,9 @@ static int ntb_transport_init_queue(stru
 	mw_base = nt->mw_vec[mw_num].phys_addr;
 	mw_size = nt->mw_vec[mw_num].phys_size;
 
+	if (max_mw_size && mw_size > max_mw_size)
+		mw_size = max_mw_size;
+
 	tx_size = (unsigned int)mw_size / num_qps_mw;
 	qp_offset = tx_size * (qp_num / mw_count);
 
