Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3746915-1520706409-2-8514884642771576299
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='net', MailFrom='org'
X-Spam-charsets: to='UTF-8', plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1520706409; b=pJKrUpRdliLD91EOuXXJ2dQTYIbVDum3LXo/F53gQ4+ZoJC
    IQ6xpeK/+YKYJ+Nwx/OP+nef9V54VdS8gHD8/1UYXZVs2EVDHcA9RmYlk5Q/JIsS
    aI8iwjqF6O0nL6xc4hoQZsPk6NiGiOFf00GyOI+wUvqoieyXyRDux3O0yLwJUBG5
    zlsDFM0tHhoF8f48nEEe+VMJ7Hscj1U9xBd8WZ085Rbivm9165pP7brWW+wg4Woh
    IMvCvR8Dhro169Xr7FcziVWiDv6WT8Tru5rEHybzfxSQxevLIClf11KBNjrLNu5d
    ewlo82KnSnTWv5kpRJAQFCn8Xo156Kgt4oDvuHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:from:to:cc:references:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=arctest; t=
    1520706409; bh=cMVCCXDPkkjpYfmOtbxyRobfz2X3dZg4kPXFUPzdxnE=; b=t
    BS5N986T+HMbgt4WC4aKx5W8Mv9X8BPSL8Ox/VgRMlDGhDQlEY2DL1JcgE1hGCUF
    X7JwhkET5sYsfO06sau1wIzgyniEp3ZOvBbWpobISTyOKpgW5ZEPQD9ui4lucR5T
    ai3B47QAFyyn1/XkkGCwHnxwlKxrEpJcFBHZ7CmDkz+y/Q7pbu7UCoSm8bbvMiIh
    3cQmIEehjzviny7yxd3j9XFDzLYRHMHssQpBM+uDcqKGldlDkhZPczHojtsQ1b66
    fToUsx8OFUw7md5R+FvIxQsPn3WnxjmessDWDISG7whGGWfNDwgVscBwmbrFEfUe
    yvmSJY+s/Ye7bMmhpwWkQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=quarantine,has-list-id=yes,d=none) header.from=users.sourceforge.net;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-category=clean score=-100 state=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=users.sourceforge.net header.result=pass header_org.domain=sourceforge.net header_org.result=pass header_is_org_domain=no
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeCJS0k (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Mar 2018 13:26:40 -0500
Received: from mout.web.de ([212.227.15.3]:41561 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751901AbeCJS0i (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Sat, 10 Mar 2018 13:26:38 -0500
Subject: [PATCH 2/2] net/usb/ax88179_178a: Delete three unnecessary variables
 in ax88179_chk_eee()
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        "Andrew F. Davis" <afd@ti.com>,
        =?UTF-8?Q?Bj=c3=b8rn_Mork?= <bjorn@mork.no>,
        "David S. Miller" <davem@davemloft.net>,
        Philippe Reynes <tremyfr@gmail.com>,
        Yuval Shaia <yuval.shaia@oracle.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
Message-ID: <019cc24b-d9c0-d782-35e8-f9f8be0534db@users.sourceforge.net>
Date: Sat, 10 Mar 2018 19:26:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <b92bebdb-c1dc-a9d3-2e3a-845d8dc4998f@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:U8acntLgVdK5ukaLscY4KrMgYcr377J9qqeIJS6ivwOyEsCyH6J
 sECNZzAv5iTFu45ggHclupKidJ3M8Ah1J6afb/3LHoIVTJfQK0ZvZimJ3WzyFcd/rq8s9mz
 gfKlo64HOIfylgrc328fPy1xUxQsFTTlNZd2EAZHSLssJfXWLKjvqlrJKUO6GExq08Xl4mv
 9bvqipgX93MD9LYuwLqDg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bc+UXtXmip4=:BlFMGghN+NyqC5et/17D5s
 nh/UFZI32rNaN/dT6TC3AM5Z2cK8GlIfCzLEnhn0g5+J+Og3+8NQF7CXZZcuchDuMFFi4pijl
 qvu9mpd4Vlvu9QP6wLb6OFyM3wfO8rlcPcG0MvIQWvpQcm1tW0DV8LSKjmS/OfIEOAF1gUNYD
 UTYeZD2uzWA0MOtbqCKy4TKTlRPUsLshx8IrrVM8FfLQsXQVJmrWmyNjOGFeifI/B9ezRT5HX
 Dh0v+RnfmUvj75jf5/BcHJkU4b9o72u/5rj+uzwQ8N1v5t4Rot963RNii7cImI57yy33NX5nW
 LSU7R3/bAzH3wGTU/MPci+vag/LCA+zfUEWCBfnlDXEPuK/mXPX92TbMFUFNf5mHEtmYJErII
 6m4nQsm2puJGlfiBNXEKQWPrqgcad1J4rJjPuQ95w/dOqSLGcija7UDs06ahmdQ35BcNGcGXd
 HJds810pe4kyFfOg/Ma+tRFp0UA9hYfzXkOL6VHXEDljJdR4/oihn1/IOPJ18Kcd79NtUi8ge
 jCYephf+3YcFpjNp4AuROn52iKm2WXFK73Yg04reGgLdeuzCEdH0BDXndDilSIBDHSsDX3YRB
 +v3o8lCn5rqOpOPxXekGGbZczixhFgvvrL+mrla4DwEf/3nQ3uZZmOoxXHTZZTdlNkiHGLQpg
 poUkq+sIiiyUGGJdHbv7eKKT850NxCveMRelKiYXUVoobXrwiCc9tJgnv2xRcpcvHasXNV+F4
 ciL8DpZIU+6oXKE+NoR/HGFs8NTRWM3ro8nOPPku7xip6czQsuJJHhZMZA1jOrdvlzz9LvnVf
 JwCp/1+O237P5xagjWLO1oOT1J7lTh1ULyM/acuBOJZPXOeEXc=
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 10 Mar 2018 18:53:28 +0100

Use three values directly for a condition check without assigning them
to intermediate variables.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/net/usb/ax88179_178a.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index e4b0baa98e9a..3e83be232504 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -684,7 +684,7 @@ static int ax88179_chk_eee(struct usbnet *dev)
 
 	if (ecmd.duplex & DUPLEX_FULL) {
 		int eee_lp, eee_cap, eee_adv;
-		u32 lp, cap, adv, supported = 0;
+		u32 cap;
 
 		eee_cap = ax88179_phy_read_mmd_indirect(dev,
 							MDIO_PCS_EEE_ABLE,
@@ -708,12 +708,11 @@ static int ax88179_chk_eee(struct usbnet *dev)
 		if (eee_adv < 0)
 			goto set_inactive;
 
-		adv = mmd_eee_adv_to_ethtool_adv_t(eee_adv);
-		lp = mmd_eee_adv_to_ethtool_adv_t(eee_lp);
-		supported = (ecmd.speed == SPEED_1000) ?
-			     SUPPORTED_1000baseT_Full :
-			     SUPPORTED_100baseT_Full;
-		if (!(lp & adv & supported))
+		if (!(mmd_eee_adv_to_ethtool_adv_t(eee_lp) &
+		      mmd_eee_adv_to_ethtool_adv_t(eee_adv) &
+		      ((ecmd.speed == SPEED_1000)
+		       ? SUPPORTED_1000baseT_Full
+		       : SUPPORTED_100baseT_Full)))
 			goto set_inactive;
 
 		priv->eee_active = 1;
-- 
2.16.2

