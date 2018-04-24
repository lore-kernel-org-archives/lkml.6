Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2889372-1524569232-2-8411519279954760290
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: 
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524569232; b=dqgHa0xFv0TKYmOAZg8IktwdrsVYyJlm2OtGkrm/Q0RxwQM0eL
    e1BQba8fFXUZ+bu3EAIfQzardN+RIoKmKuE4N2/Mla4bxXob1iEmkNP8ZTj+PnGK
    DJjC7/ClhiD712ZmAWrRuzK71iozgUwzNoZDhP/KTDVlNCkWuFzeFNv5dZMJtr/9
    PulW+MD+ks8Y5VeUcStmelQc6m9SGPvSlAdCKZDjVw2wrkpJG/OnBfIldfifJ5Sz
    eHaUBio6Y7dwup8GkdHTyv2LFomWi+JNGnq2LV496ha1RF416T4GLTD6+rMUokRy
    IpItFFBO2xgRL2puGmARd+7wDnhm4aKqnUmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1524569232; bh=
    Hqjs5F2JIRYTxItVUEPwLt2bLfyqe7BXH9ckyPVo/SI=; b=bJp9xIn+NXZORFky
    ZBBgHspd4nfm/JUhqJWgPaEa9wAbk974zb91bhPRwXtZdAV1MwJCKolpQs6T3EwM
    STCJENiYCkvFA8tRc/HFyXwIsA7DQMxawYT+pAdZkkAjzmxxSBSyZLci13XLEpDx
    YnwbdS/63ynOhchkOVvIV4W0Kk1eC42IJdAKAJ3SoKq4rX08OUaLEzIRWSnLeBC3
    JstWAz0qYLLQphK4Z0SGwH8zHQTbNF3lYiliwOk0g0CIfZPIe3jSRDsYiirRN/G0
    cAzDHwyybrPek+N3H4mdKETHqbq3JmyWGoNqZmISZmyCJq7qmCa128HYs9K1AjKm
    +frD2g==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=redhat.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=redhat.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOS4Su9Gy8wj53qs8SnHlzVckwYqil2YIsuoxADvf3q8clSwPszBvPqvLZcvF+x1oFIo8IzRNrxqXpgjlWlyOiNwpgSic04xIbo5PQ2vyF6+9oI1SNlT
    7vLIFuId4WbGgKddmfyeO4nwqTM8zWIOmwyHo+bqKAlk7Zx8LBfPK2zNHz1ECJI2kjbGNlmSKqjKFTkyT93FS/67SEWWZqsVCUO1Co2Rzwva2y7jhzfOfhW8
X-CM-Analysis: v=2.3 cv=NPP7BXyg c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=Kd1tUaAdevIA:10 a=VnNF1IyMAAAA:8
    a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=-JsJ4L0Hno9BBFMgH3UA:9
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755915AbeDXL1J (ORCPT <rfc822;greg@kroah.com>);
        Tue, 24 Apr 2018 07:27:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38374 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754914AbeDXL1B (ORCPT <rfc822;stable@vger.kernel.org>);
        Tue, 24 Apr 2018 07:27:01 -0400
From: Cornelia Huck <cohuck@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Halil Pasic <pasic@linux.vnet.ibm.com>, stable@vger.kernel.org,
        Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] vfio: ccw: fix cleanup if cp_prefetch fails
Date: Tue, 24 Apr 2018 13:26:56 +0200
Message-Id: <20180424112656.10243-2-cohuck@redhat.com>
In-Reply-To: <20180424112656.10243-1-cohuck@redhat.com>
References: <20180424112656.10243-1-cohuck@redhat.com>
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Halil Pasic <pasic@linux.vnet.ibm.com>

If the translation of a channel program fails, we may end up attempting
to clean up (free, unpin) stuff that never got translated (and allocated,
pinned) in the first place.

By adjusting the lengths of the chains accordingly (so the element that
failed, and all subsequent elements are excluded) cleanup activities
based on false assumptions can be avoided.

Let's make sure cp_free works properly after cp_prefetch returns with an
error by setting ch_len of a ccw chain to the number of the translated
CCWs on that chain.

Cc: stable@vger.kernel.org #v4.12+
Acked-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20180423110113.59385-2-bjsdjshi@linux.vnet.ibm.com>
[CH: fixed typos]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 2c7550797ec2..dce92b2a895d 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -715,6 +715,10 @@ void cp_free(struct channel_program *cp)
  * and stores the result to ccwchain list. @cp must have been
  * initialized by a previous call with cp_init(). Otherwise, undefined
  * behavior occurs.
+ * For each chain composing the channel program:
+ * - On entry ch_len holds the count of CCWs to be translated.
+ * - On exit ch_len is adjusted to the count of successfully translated CCWs.
+ * This allows cp_free to find in ch_len the count of CCWs to free in a chain.
  *
  * The S/390 CCW Translation APIS (prefixed by 'cp_') are introduced
  * as helpers to do ccw chain translation inside the kernel. Basically
@@ -749,11 +753,18 @@ int cp_prefetch(struct channel_program *cp)
 		for (idx = 0; idx < len; idx++) {
 			ret = ccwchain_fetch_one(chain, idx, cp);
 			if (ret)
-				return ret;
+				goto out_err;
 		}
 	}
 
 	return 0;
+out_err:
+	/* Only cleanup the chain elements that were actually translated. */
+	chain->ch_len = idx;
+	list_for_each_entry_continue(chain, &cp->ccwchain_list, next) {
+		chain->ch_len = 0;
+	}
+	return ret;
 }
 
 /**
-- 
2.14.3
