Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2322533-1523985202-2-12482321603851831015
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523985201; b=qvn9mPqhIpmKkNT6BCuPKDY75WwB8JZpwYbPx+dMSIMcbbyd0Q
    XCgf0+pKmucdW1cXWpSBN8ctOn2NcEwVhkD4QbnZq12wy/lYos1zJ28mtR+MVqtR
    XmSK5/Ystcg54dUCfQguqwl9AeSoGJ0aDSi+EWIVmIjHOo8mfpukQge2s/BeiAGP
    /jfIXx2aRhL2yHLcuLpBxOFXC7ykW9+cmsHyLBYG6yA42TDTF+wIO4U56qvXip1U
    4EnFlfzuzFeS4E0LoeCXpQRM+AqpzyQ100QTHm4j4E9S9wDeglNstxub1IsYxYhM
    1WtqP9fNYUNmRjD9ntbhm9JNNFyBpH9EX7/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523985201; bh=A9OaGrrd0/8Zjx0dgqrWeVF96EUPOL
    BxIuOqHfVCdsc=; b=Je0JrUnIv2rOkHTBCjawkexP0rqbivCw7Nj24AZsGO6Vox
    lF+sD9TngM68Rhn3Ba35Dy/4GqHSJ83EqLIySdxzwBQap3TLX2ZeD5iLtD0q56/X
    MVDLROYHeDJQxjgM014VdOZV8rIX4ltj6LU+WKJPdPQIJr1lnW3ZeyBgVgjIPwVF
    cEt8VVFCvD0KDY0pljYTg29juh6lfiRVrCGefaTtDMeNcczgr/xCM8pOjqpDMgB1
    ODyO5ipAIwVhk2ur2iJ5rKAZD4qP7ARfK/CIHSN9FMcdRhcRAb6jjcP8QdQ1KzT4
    V0ajLosOy3irnMRZIHuKFN2mO7f1fL75Z73Gp73g==
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
X-CM-Envelope: MS4wfPmJjN/a8mozcRAudviVmogmAxyx0WVlebGvGQoBp7TVGgoAeoMNGVV2kl1DxOY6wBhb568Ay1IbF/3Bj4K1irw7BvYliLcgk1I1eSnM4serGyFmSFiy
    f/HMHmx7RFWrTj9UHZOLsJ6H9WzsfEvGCrc9CrKOK3aTbB+QuALQ5NJSBYQ54bw8ipVP0/WNclK/rWCgFxp5X9S4RzQHXgRltwcO3zaoLxPyHvVxPY9b5Fk2
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=fk1lIlRQAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=Gj_NPGMNAAAA:8
    a=ag1SF4gXAAAA:8 a=3KOjD5BY3yv1Bt1V9BEA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
    a=QEXdDO2ut3YA:10 a=U75ogvRika4pmaD_UPO0:22 a=AjGcO6oz07-iQ99wixmX:22
    a=xGItau7KCEKv9uFBzOR9:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752947AbeDQQAN (ORCPT <rfc822;greg@kroah.com>);
        Tue, 17 Apr 2018 12:00:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60032 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752250AbeDQQAM (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 17 Apr 2018 12:00:12 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Corey Minyard <cminyard@mvista.com>,
        Laura Abbott <labbott@redhat.com>,
        Bill Perkins <wmp@grnwood.net>
Subject: [PATCH 4.16 14/68] ipmi: Fix some error cleanup issues
Date: Tue, 17 Apr 2018 17:57:27 +0200
Message-Id: <20180417155749.908755011@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180417155749.341779147@linuxfoundation.org>
References: <20180417155749.341779147@linuxfoundation.org>
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

From: Corey Minyard <cminyard@mvista.com>

commit cc095f0ac1f7c200e51a5c2a78a43c9f42049dbb upstream.

device_remove_group() was called on any cleanup, even if the
device attrs had not been added yet.  That can occur in certain
error scenarios, so add a flag to know if it has been added.

Also make sure we remove the dev if we added it ourselves.

Signed-off-by: Corey Minyard <cminyard@mvista.com>
Cc: stable@vger.kernel.org # 4.15
Cc: Laura Abbott <labbott@redhat.com>
Tested-by: Bill Perkins <wmp@grnwood.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/char/ipmi/ipmi_si_intf.c |   18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

--- a/drivers/char/ipmi/ipmi_si_intf.c
+++ b/drivers/char/ipmi/ipmi_si_intf.c
@@ -252,6 +252,9 @@ struct smi_info {
 	/* Default driver model device. */
 	struct platform_device *pdev;
 
+	/* Have we added the device group to the device? */
+	bool dev_group_added;
+
 	/* Counters and things for the proc filesystem. */
 	atomic_t stats[SI_NUM_STATS];
 
@@ -2027,8 +2030,8 @@ int ipmi_si_add_smi(struct si_sm_io *io)
 	if (initialized) {
 		rv = try_smi_init(new_smi);
 		if (rv) {
-			mutex_unlock(&smi_infos_lock);
 			cleanup_one_si(new_smi);
+			mutex_unlock(&smi_infos_lock);
 			return rv;
 		}
 	}
@@ -2187,6 +2190,7 @@ static int try_smi_init(struct smi_info
 			rv);
 		goto out_err_stop_timer;
 	}
+	new_smi->dev_group_added = true;
 
 	rv = ipmi_register_smi(&handlers,
 			       new_smi,
@@ -2240,7 +2244,10 @@ static int try_smi_init(struct smi_info
 	return 0;
 
 out_err_remove_attrs:
-	device_remove_group(new_smi->io.dev, &ipmi_si_dev_attr_group);
+	if (new_smi->dev_group_added) {
+		device_remove_group(new_smi->io.dev, &ipmi_si_dev_attr_group);
+		new_smi->dev_group_added = false;
+	}
 	dev_set_drvdata(new_smi->io.dev, NULL);
 
 out_err_stop_timer:
@@ -2288,6 +2295,7 @@ out_err:
 		else
 			platform_device_put(new_smi->pdev);
 		new_smi->pdev = NULL;
+		new_smi->io.dev = NULL;
 	}
 
 	kfree(init_name);
@@ -2384,8 +2392,10 @@ static void cleanup_one_si(struct smi_in
 		}
 	}
 
-	device_remove_group(to_clean->io.dev, &ipmi_si_dev_attr_group);
-	dev_set_drvdata(to_clean->io.dev, NULL);
+	if (to_clean->dev_group_added)
+		device_remove_group(to_clean->io.dev, &ipmi_si_dev_attr_group);
+	if (to_clean->io.dev)
+		dev_set_drvdata(to_clean->io.dev, NULL);
 
 	list_del(&to_clean->link);
 
