Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3374234-1523482069-2-14322172809121850856
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
    1523482068; b=Lo6rVBc+YuRjA8R3FGWn2KNqD0p2L8XQ39eccoXcSIEvrVeKSY
    yt9n/yP9LN5K2shv9tyi21KgPXlvb+Sc6S3Rcf4et0YCaHXGKjAVBPL9MRuFjbhC
    Vx/bGpAwdC7qYrAfKJioKziN0rTJvMQWwvPE2pCgky+3V/dn47b2yB5r2B0YMqLo
    das2rRtq0eREbRU5z8Erf9YrNQQySfL7o/75r/5DGT1au7cSPa5z90aRQuG3Ck7K
    lJkQSTSpBGjOi+6fGodpcQxjlQBzQCFf9U//7AfP/kvgDSS7MR2bk1Jm9wAHE7jd
    ddnO8P2eVNNYlp7qGBWuoJq2Vi5aLT+nRY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=fm2; t=1523482068; bh=EF1p3+YCOsVJD/KwMdQAu89Pe8ChZZ
    g6HkM/fRpkY7Y=; b=FFDEeNUa3E2Hi/bYM4eUnPwHM925rv6mgquSqszJPjRtln
    gxVwUfrdFsyPXXNDXAIOSTFNFSKlv/cY0MVcO3JsJbzAf9CGZ+KN3iebtBgR8VbF
    xgud2tAWY0SHwDF2mQt2oNmU5H5kB3LrF98GH4xrRqoeSacl3nFffyX9majZ2B12
    N6CdAUTaCQTBZiQ7Z5CSYLWA96kb42RIAnN7cCABrO8x142AMl2olu/OHNaWTaY0
    gFCL5aqgQoqalcTC6mMzb/eGqZc2E0esEO08r0D8O5aEPUrkKzzyCRlPlVKp0qNI
    8jSUCJUVT/HIfo4L/v73w5gn4sd9IMVPHHILknjg==
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
X-CM-Envelope: MS4wfGb8aNHgUNV/VQZdjiBtcOspHRHKPxmCzY7TCn6NhJZOiQ85XuGttmiuBtoUh9ZadUx3H9M1BkzfH3wfq6uXtLAv+F/n58TCEw/19/cVnT5QaYf1tI+E
    y0Ocz/gH8hGaLUoi4zdPCfZ6MYG/Mmc8Zpf4Bt6TpAD8X09w1v7hVUo64DYeB9NodqmN2PdL/vNeLWi/UQZYFivlSevu2/PBqirxkKnWp3y8RUtqBEZOMncd
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=InJrZTXqAAAA:8 a=iox4zFpeAAAA:8 a=20KFwNOVAAAA:8 a=z11f-joXAAAA:8
    a=yMhMjlubAAAA:8 a=ag1SF4gXAAAA:8 a=rgNOMHsgKtPNWFo9ZzsA:9 a=QEXdDO2ut3YA:10
    a=bo7r-k08vssA:10 a=WwJ7OKCui7YMbFU4sWpb:22 a=WzC6qhA0u3u7Ye7llzcV:22
    a=HW01NMXGnYhBHl5J0OKi:22 a=Yupwre4RP9_Eg_Bd0iYG:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754514AbeDKV1d (ORCPT <rfc822;greg@kroah.com>);
        Wed, 11 Apr 2018 17:27:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55194 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753623AbeDKSh4 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 11 Apr 2018 14:37:56 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Hannes Reinecke <hare@suse.com>,
        Doug Ledford <dledford@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Andy Grover <agrover@redhat.com>,
        David Disseldorp <ddiss@suse.de>,
        Nicholas Bellinger <nab@linux-iscsi.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 002/121] IB/srpt: Fix abort handling
Date: Wed, 11 Apr 2018 20:35:05 +0200
Message-Id: <20180411183456.330805666@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180411183456.195010921@linuxfoundation.org>
References: <20180411183456.195010921@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bart Van Assche <bart.vanassche@sandisk.com>


[ Upstream commit 55d694275f41a1c0eef4ef49044ff29bc3999490 ]

Let the target core check the CMD_T_ABORTED flag instead of the SRP
target driver. Hence remove the transport_check_aborted_status()
call. Since state == SRPT_STATE_CMD_RSP_SENT is something that really
should not happen, do not try to recover if srpt_queue_response() is
called for an I/O context that is in that state. This patch is a bug
fix because the srpt_abort_cmd() call is misplaced - if that function
is called from srpt_queue_response() it should either be called
before the command state is changed or after the response has been
sent.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Andy Grover <agrover@redhat.com>
Cc: David Disseldorp <ddiss@suse.de>
Signed-off-by: Nicholas Bellinger <nab@linux-iscsi.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/ulp/srpt/ib_srpt.c |    6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

--- a/drivers/infiniband/ulp/srpt/ib_srpt.c
+++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
@@ -2986,12 +2986,8 @@ static void srpt_queue_response(struct s
 	}
 	spin_unlock_irqrestore(&ioctx->spinlock, flags);
 
-	if (unlikely(transport_check_aborted_status(&ioctx->cmd, false)
-		     || WARN_ON_ONCE(state == SRPT_STATE_CMD_RSP_SENT))) {
-		atomic_inc(&ch->req_lim_delta);
-		srpt_abort_cmd(ioctx);
+	if (unlikely(WARN_ON_ONCE(state == SRPT_STATE_CMD_RSP_SENT)))
 		return;
-	}
 
 	dir = ioctx->cmd.data_direction;
 
