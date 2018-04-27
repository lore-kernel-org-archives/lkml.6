Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-298528-1524839427-2-881755322684603847
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
    1524839427; b=CzZfR1YqUSrOkSRMPYF1D+UVq7XT9uxFMIOf2pOiC+E7tsv0+D
    TS2w/SjZbC6ANZZwj8OvDRf3oRIWVCcd5gV+BPbCakbNegkppjRPt44xnx6GIHWb
    yVXxtAHHnRh5FNz0W83zhNtGBJ+zr1kIhXEBXsWiq3ISqnxlVmXoivZQF5wjcizF
    ueMTqhsqaz5+WHwzbUBksYFO3VEoOSyyPGNhzpIv4Zj5TMtWTWCF/EoJdCEk2FeV
    WJWBenD3YkR7ctgIwN0Kb+oMO03R8jEbvSP0kJ56Jrpq7/Pkgt23kRg1g9CN0Rh4
    lmD99IUdIHYrmuq67mBv/+HyWQg8eWsCmJ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524839427; bh=2zhiM/F4fA4NVQrmPt7YBMDn88HDEB
    HtYReeSR2Frwg=; b=gSKKavolmbbk2V2g7++Wz8QePl5e1igfOmMQsfwIq12SlE
    z0RdoVFwd/qrjjMsGg/BxlkdjKnYhp17gjn/ZOWz0WHgJXTWzKHra7Wf6Hrn4BcF
    PHhPF76KOukuKypak8dDLsTbb+oive5oL9Wihs9S+3dJU21OuwOeROZVMHV5TVQS
    Lx/V31FfZGW3xrRjjCVDcJQwThIylKmLrx6hIDUqnqBiER6EnB33q4KlraYLWl2B
    RPFfjDkjy5xGkdbOl3N/26FTMIZQXO7l95Tt0giqTT9xzWReR9E5+3lsaWXeJgnV
    VQ1qDpmOYDiLYkSS54L2nlJXC7itw88GP+W2XEEw==
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
X-CM-Envelope: MS4wfMqvs0MKU4e1YsUdi2Si4DqR/vKKGXkXZLyYhTOzW0yJLAKARuYpQmDzcXtgen173d234xFC1ddoqDvsF6TPK9Yia4/CsDQ9oPn11+RT1vZrrWEjkC4N
    ijAPNebeknlBk86TJs0gP/WYRluJbuDbxrsXxHaSvmajMHgfJqbF9lmlDg02DnGYXJIGQRd3jIVok18Y6mvM6irxquU6Umj2lkuvOOOxM+wNHEhweRsgdp+7
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=J1Y8HTJGAAAA:8 a=ag1SF4gXAAAA:8 a=SEywYUugevPGjAXIiEEA:9
    a=QEXdDO2ut3YA:10 a=y1Q9-5lHfBjTkpIzbSAN:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934617AbeD0OLB (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 10:11:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:55946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934466AbeD0OLA (ORCPT <rfc822;stable@vger.kernel.org>);
        Fri, 27 Apr 2018 10:11:00 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1808218A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xin Long <lucien.xin@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.16 08/81] bonding: do not set slave_dev npinfo before slave_enable_netpoll in bond_enslave
Date: Fri, 27 Apr 2018 15:58:10 +0200
Message-Id: <20180427135743.710353486@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180427135743.216853156@linuxfoundation.org>
References: <20180427135743.216853156@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xin Long <lucien.xin@gmail.com>


[ Upstream commit ddea788c63094f7c483783265563dd5b50052e28 ]

After Commit 8a8efa22f51b ("bonding: sync netpoll code with bridge"), it
would set slave_dev npinfo in slave_enable_netpoll when enslaving a dev
if bond->dev->npinfo was set.

However now slave_dev npinfo is set with bond->dev->npinfo before calling
slave_enable_netpoll. With slave_dev npinfo set, __netpoll_setup called
in slave_enable_netpoll will not call slave dev's .ndo_netpoll_setup().
It causes that the lower dev of this slave dev can't set its npinfo.

One way to reproduce it:

  # modprobe bonding
  # brctl addbr br0
  # brctl addif br0 eth1
  # ifconfig bond0 192.168.122.1/24 up
  # ifenslave bond0 eth2
  # systemctl restart netconsole
  # ifenslave bond0 br0
  # ifconfig eth2 down
  # systemctl restart netconsole

The netpoll won't really work.

This patch is to remove that slave_dev npinfo setting in bond_enslave().

Fixes: 8a8efa22f51b ("bonding: sync netpoll code with bridge")
Signed-off-by: Xin Long <lucien.xin@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/bonding/bond_main.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1660,8 +1660,7 @@ int bond_enslave(struct net_device *bond
 	} /* switch(bond_mode) */
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-	slave_dev->npinfo = bond->dev->npinfo;
-	if (slave_dev->npinfo) {
+	if (bond->dev->npinfo) {
 		if (slave_enable_netpoll(new_slave)) {
 			netdev_info(bond_dev, "master_dev is using netpoll, but new slave device does not support netpoll\n");
 			res = -EBUSY;
