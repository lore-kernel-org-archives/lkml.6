Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-557887-1524653160-2-9708858448202615573
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
    1524653159; b=QXo++aepr8m5BHVBsdOL34X5Jzp0T4AgIUbDwidh4Uici+wApW
    IuxusByX12SzoUeCYSFLAZDiDMq9T3mUryvMrtjEqChNUWOgGevud4Xd1U6BjQud
    Thg7HtS/7OL8+pXc9iWGDWjqOHXFCpYXQb9bdxcfplvCT2WkBhyHU5RIXUak6C+a
    OhnuwDfXFGWBPLi94bF78DNitmnFZWtmfdHOHUEXk0DONTbSmM5uFO/fjxzpzv1C
    iLUNEc/I7P8lybnKLrK6IlDs8TMEMvevJ0zri2NIEgB8n8VwmKQHK5EnH0N0A5dM
    lSKB0xNKN/is+dxJARPiI4ay+SC4CMqlx5sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1524653159; bh=ICoY/+RjJL3NQgxzCek0F/3ruoQSw6
    TYV2KCFUzzvaA=; b=j28NgL5PNSHqpss5qg/d4lGDrXZdujvuHpa4bPToaUum/9
    bvZLa9OTzxPbr6IsakPT5Dr3whj++l6daAPyTH91mih5I+UEXIwodhjY0ZtWG02F
    2aqBKI3EOya1Art3mCz0P4MSnwSdh+GsB4oTKXJDKDD3RMqisQzVf6XTMVXVdGLP
    wqehVY1f45ag8+SXOUB40cGnbrdGvWn6krtIwQTwNL6tWW74Eegl8G1ARyqkrA5y
    efNqtKUD15D9UYyLz8juemHqygGZbLRc74P7zV/KgzUYFCFQwPmsDd/VZyGC/XBQ
    yungu3An0r1b+7BJLAp6eCckcv+zgN49c9XfVc+Q==
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
X-CM-Envelope: MS4wfKiuMJgZaNXtKoULzRJ0V88LGRpAqiWiIsNHODMnXY+I/bUSqiuIyI37+tojoBx7MvMMkpN0RVl+ZXVx4HJLMLPhKOAh7w98dB9BrcOf94hK0GyeisRt
    dKgmZt6lWUEUgTs1G73Qq8gP7/2LnVAj7l+UGEEk97hW7z0iXdtmGha8u8YinrYEcsxX9MOV4SI2jmsbH8khNHlXdFQH2G7nJ9yOEa4/X8+ACrUG3/O6PP4W
X-CM-Analysis: v=2.3 cv=Tq3Iegfh c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=hSkVLCK3AAAA:8 a=QyXUC8HyAAAA:8 a=ag1SF4gXAAAA:8 a=AVgoCq2HS35BQGctNCwA:9
    a=QEXdDO2ut3YA:10 a=cQPPKAXgyycSBL8etih5:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754529AbeDYKpY (ORCPT <rfc822;greg@kroah.com>);
        Wed, 25 Apr 2018 06:45:24 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:53564 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754517AbeDYKpU (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 25 Apr 2018 06:45:20 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+70ce058e01259de7bb1d@syzkaller.appspotmail.com,
        Benjamin Beichler <benjamin.beichler@uni-rostock.de>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 4.14 183/183] mac80211_hwsim: fix use-after-free bug in hwsim_exit_net
Date: Wed, 25 Apr 2018 12:36:43 +0200
Message-Id: <20180425103249.853994921@linuxfoundation.org>
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

From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>

commit 8cfd36a0b53aeb4ec21d81eb79706697b84dfc3d upstream.

When destroying a net namespace, all hwsim interfaces, which are not
created in default namespace are deleted. But the async deletion of the
interfaces could last longer than the actual destruction of the
namespace, which results to an use after free bug. Therefore use
synchronous deletion in this case.

Fixes: 100cb9ff40e0 ("mac80211_hwsim: Allow managing radios from non-initial namespaces")
Reported-by: syzbot+70ce058e01259de7bb1d@syzkaller.appspotmail.com
Signed-off-by: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/wireless/mac80211_hwsim.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3427,8 +3427,11 @@ static void __net_exit hwsim_exit_net(st
 			continue;
 
 		list_del(&data->list);
-		INIT_WORK(&data->destroy_work, destroy_radio);
-		schedule_work(&data->destroy_work);
+		spin_unlock_bh(&hwsim_radio_lock);
+		mac80211_hwsim_del_radio(data, wiphy_name(data->hw->wiphy),
+					 NULL);
+		spin_lock_bh(&hwsim_radio_lock);
+
 	}
 	spin_unlock_bh(&hwsim_radio_lock);
 }
