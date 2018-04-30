Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1878097-1525117052-2-12382485312720458536
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
    1525117051; b=MUitYB8yLDmXWGHI8UUspcUPE9WX0bjxoamj+BjLJSp3RCmTEp
    pMKyrnXVMK2HuGLar9y45AN9k/HsclU60brNO2jtvfz7kNPi7NePhdIe2kAScC6Y
    u2yWMzWScQQtMdCVgsVogiJlKITL+5muUOgeS/TnZbgzHaSXHJU/k0gXjND7RRm1
    k8gVYpf+F32DMVScppjl3j5mM79qb3anC+IrL99NAc2zqfcFs7yveoKaKXwrro0f
    tpKPFbvlSmCzAGMhMvSi7QN6LIrdWZTmjKrT+gDdqSXq3wZaEaUuxtqa5SnedX9f
    qhWNNII1eV/Zl6Q/pI/O/9Mbugoy/Rj0s72w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1525117051; bh=5OQUQKx5ZRMW15Uw1ZS9XZyhnXI2E4
    c3nla5ar/eLgI=; b=mt3T7dYBC9BtPvKdcxjVd4LeBrILNPztg0plJx+9UqGSlZ
    yaHNR/O3QcsigRm0IFH9LVicHV9TuvT6TuKjbFlr9nRw9CNMC6Fzx5feKI6SvGUc
    EBah03yL+ztEjDAMq/MVqsOXdMZzIztSUOlNeOUouS3Z8mzBRFLGudgXkoosyV2K
    8o8MXpde52tQkwTb6l/yl82GCJ+MdNu4ZGH/PvMqV6qhzvUF0pbCWoiPvydx2Y5h
    gXjPB7BlH8+FuAEdMRHJnS0c52g0iDFEh8RXEYw908Ao8g8H9kTMqBL5UbzDfmoN
    Cm5X/9Z4kd26wal9clIfG8Q+L2i372Jy+Gz9CEsg==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
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
X-CM-Envelope: MS4wfPfmf5wMzxvGmo0CCks55uLzX44h3J+apuFRfhwGsSkzmtqDwuuAZASnRE4LrTgvu/XqXcTQruL1hffB+1Uyqw0Rz7TfLVCrnd8MyR0maYuxL7qS1lGf
    jXeoq4wkbCO3LBcaiiildlhum7qZaMs6XY2nT+My2odbdtayt1xWpiG4Sd6EKWU6pSCKFLLwM892rbPgt6QxutJMRkXl05POxG/9lZqXumKRO55r+RFGzFR/
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=VwQbUJbxAAAA:8 a=4u6H09k7AAAA:8 a=20KFwNOVAAAA:8
    a=ag1SF4gXAAAA:8 a=0FwFE5uvc5YHtiZ2uk0A:9 a=QEXdDO2ut3YA:10
    a=AjGcO6oz07-iQ99wixmX:22 a=5yerskEF2kbSkDMynNst:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756402AbeD3T2n (ORCPT <rfc822;greg@kroah.com>);
        Mon, 30 Apr 2018 15:28:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:36686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756381AbeD3T2l (ORCPT <rfc822;stable@vger.kernel.org>);
        Mon, 30 Apr 2018 15:28:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8135122DAC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=fail smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ilya Dryomov <idryomov@gmail.com>,
        Jason Dillaman <dillaman@redhat.com>
Subject: [PATCH 4.16 087/113] libceph: reschedule a tick in finish_hunting()
Date: Mon, 30 Apr 2018 12:24:58 -0700
Message-Id: <20180430184018.874669650@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180430184015.043892819@linuxfoundation.org>
References: <20180430184015.043892819@linuxfoundation.org>
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

From: Ilya Dryomov <idryomov@gmail.com>

commit 7b4c443d139f1d2b5570da475f7a9cbcef86740c upstream.

If we go without an established session for a while, backoff delay will
climb to 30 seconds.  The keepalive timeout is also 30 seconds, so it's
pretty easily hit after a prolonged hunting for a monitor: we don't get
a chance to send out a keepalive in time, which means we never get back
a keepalive ack in time, cutting an established session and attempting
to connect to a different monitor every 30 seconds:

  [Sun Apr 1 23:37:05 2018] libceph: mon0 10.80.20.99:6789 session established
  [Sun Apr 1 23:37:36 2018] libceph: mon0 10.80.20.99:6789 session lost, hunting for new mon
  [Sun Apr 1 23:37:36 2018] libceph: mon2 10.80.20.103:6789 session established
  [Sun Apr 1 23:38:07 2018] libceph: mon2 10.80.20.103:6789 session lost, hunting for new mon
  [Sun Apr 1 23:38:07 2018] libceph: mon1 10.80.20.100:6789 session established
  [Sun Apr 1 23:38:37 2018] libceph: mon1 10.80.20.100:6789 session lost, hunting for new mon
  [Sun Apr 1 23:38:37 2018] libceph: mon2 10.80.20.103:6789 session established
  [Sun Apr 1 23:39:08 2018] libceph: mon2 10.80.20.103:6789 session lost, hunting for new mon

The regular keepalive interval is 10 seconds.  After ->hunting is
cleared in finish_hunting(), call __schedule_delayed() to ensure we
send out a keepalive after 10 seconds.

Cc: stable@vger.kernel.org # 4.7+
Link: http://tracker.ceph.com/issues/23537
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Jason Dillaman <dillaman@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 net/ceph/mon_client.c |    1 +
 1 file changed, 1 insertion(+)

--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -1133,6 +1133,7 @@ static void finish_hunting(struct ceph_m
 		monc->hunting = false;
 		monc->had_a_connection = true;
 		un_backoff(monc);
+		__schedule_delayed(monc);
 	}
 }
 
