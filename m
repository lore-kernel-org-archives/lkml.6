Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1098017-1521804027-2-6169059953992736163
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1521804027; b=GUX27dX6ONDMjKn1cVBFfxi9a93KA72UY4Qo5yBysb6kFMi
    2DPviIsxOwffw1UNPMeNKZGDVmCcTDaWPmyUXDFZ2oL6B1nSKAvPo+yJ/aJVkXgu
    Ol9s2JS5DS2VPWl1F5iJCrLQYIHY8hkaf3VBL33OkcuUenkyfvQ3XiZuTs8DfJh+
    BoOs9jGnqJEeQ99kXjDjVGXTjLePhH8HtOsZ9XWfltaoDg6Xfx3reGAYGxMzR7My
    uzNXI5dpQu1eNllKKc6Ydo2nY+7GqR84TNjc4tsAQZBuo2dJb2omn8Us1mZDBq1a
    NyAkd10XRyZKUIiZDZwxvB/n3X0twhrtNnSPvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:mime-version:content-type:sender
    :list-id; s=arctest; t=1521804027; bh=Pr1tQsgWSPLZ5W+13NrbHFD9ei
    2cpJvashbmZ6/Yf5k=; b=Fmk5ge43k4+22rXWJxyEvZYnHe+ZKTQYyIhW/oS/HY
    hu82GRLWCANjG2C88tST7dKw0F0zeFKi/s92fkIu9ebUfMJZgAErvT9jUkkOumuo
    GcnzyLljGJenKMYoqVxOkHiws0NLJa8Ye+jM1zitUY6Ce0xE6Fnq19zmvoj6s6fu
    ZOMU9IEQJg89qFsJnpizu3uzUxw20KfLQCQTdU/d7rr1y1LIjidfC2h3rc5UQG19
    2IfcaYDjcb2MmD1vxlmEie95r3jkjvAg41LmMZ4SI6VtOg+hPoKA3c5MdQPvkZjj
    s9KIyi9i0FZcHIlmdzCZAO0GUsH+oElLbqMLqBwiY3pw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755265AbeCWLUN (ORCPT <rfc822;greg@kroah.com>);
        Fri, 23 Mar 2018 07:20:13 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41800 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755610AbeCWKIp (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 23 Mar 2018 06:08:45 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Emil Tantilov <emil.s.tantilov@intel.com>,
        Andrew Bowers <andrewx.bowers@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 103/177] ixgbevf: fix size of queue stats length
Date: Fri, 23 Mar 2018 10:53:51 +0100
Message-Id: <20180323094209.825464411@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180323094205.090519271@linuxfoundation.org>
References: <20180323094205.090519271@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Emil Tantilov <emil.s.tantilov@intel.com>


[ Upstream commit f87fc44770f54ff1b54d44ae9cec11f10efeca02 ]

IXGBEVF_QUEUE_STATS_LEN is based on ixgebvf_stats, not ixgbe_stats.

This change fixes a bug where ethtool -S displayed some empty fields.

Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/intel/ixgbevf/ethtool.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/ixgbevf/ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbevf/ethtool.c
@@ -80,7 +80,7 @@ static struct ixgbe_stats ixgbevf_gstrin
 #define IXGBEVF_QUEUE_STATS_LEN ( \
 	(((struct ixgbevf_adapter *)netdev_priv(netdev))->num_tx_queues + \
 	 ((struct ixgbevf_adapter *)netdev_priv(netdev))->num_rx_queues) * \
-	 (sizeof(struct ixgbe_stats) / sizeof(u64)))
+	 (sizeof(struct ixgbevf_stats) / sizeof(u64)))
 #define IXGBEVF_GLOBAL_STATS_LEN ARRAY_SIZE(ixgbevf_gstrings_stats)
 
 #define IXGBEVF_STATS_LEN (IXGBEVF_GLOBAL_STATS_LEN + IXGBEVF_QUEUE_STATS_LEN)
