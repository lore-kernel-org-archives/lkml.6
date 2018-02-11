Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1431546-1518324701-2-4190983906131897120
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518324701; b=FqrZYWDOkHscJh+peH0FlIzVf5Ee3YPXRhBfTe+5cwr6HRp
    kJdpfmBRBYQkj0A5mb7KDGVgfpuQU+e77t9E7K000iFIJKn4Kg2uA0CpHpUmZod3
    LgJnZvJsOgPz+TQR56bS6WlalYdaqaVBPt41/W7gb7JD86cw/GHkR/A5EHL4JNjk
    E2jPF/R5uhUkGdtSZKXrKeXhSzsNGZUKrJljuNL94HJBHh/IMm9QQFnF30TWjDf7
    axNwJlZ0Xxq3q6wGw/fr2cRSDAck2FsRA+RObfhwuaDwBhfF4QNAMfnBONjsaFmw
    yUyHV4qB8RM3qpZinBQr+7Fh7YEeBTN+7fV4KxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1518324701; bh=0JmeN/slR1YCg/gc0S/
    1J2JZPkM37m3wMkv0bG5SvpM=; b=RGInvNA3xCVyNFhxy1Ii6xDpBYxEhUsBMUM
    EigR74ZNrbMwCS6ugRTXv3NjvihwXkplvRgTpj4ssNKDQJPra09OIv6/rQWFTDng
    ewm6SAlFCgjrxy9BuUK8cWLJhdzihMYPmPpDtR+fjFbiMTduW7gHo97mfRqt07h8
    tPBvHQRX4JuJxTgStvEkfCfYgQw3scWONKwK/LCknl6TtGoV1HmED8ltskTDiQT6
    MTEzF1QUvce2KZzOrH0lCpTNO7KGDOaslO+VTml0kYQaO3yPh1W+buybHATO9T9X
    MAt6XS1OnJrttXI8p+b8C2DnOZvJKhk0RJShaGua6uoWsqTZZ5Q==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753536AbeBKEvh (ORCPT <rfc822;greg@kroah.com>);
        Sat, 10 Feb 2018 23:51:37 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:41753 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752821AbeBKEd5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 10 Feb 2018 23:33:57 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Jesse Brandeburg" <jesse.brandeburg@intel.com>,
        "Jeff Kirsher" <jeffrey.t.kirsher@intel.com>,
        "Brian King" <brking@linux.vnet.ibm.com>,
        "Aaron Brown" <aaron.f.brown@intel.com>
Date: Sun, 11 Feb 2018 04:31:11 +0000
Message-ID: <lsq.1518323471.18249682@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 112/136] igb: Use smp_rmb rather than read_barrier_depends
In-Reply-To: <lsq.1518323469.348919605@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.54-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Brian King <brking@linux.vnet.ibm.com>

commit c4cb99185b4cc96c0a1c70104dc21ae14d7e7f28 upstream.

The original issue being fixed in this patch was seen with the ixgbe
driver, but the same issue exists with igb as well, as the code is
very similar. read_barrier_depends is not sufficient to ensure
loads following it are not speculatively loaded out of order
by the CPU, which can result in stale data being loaded, causing
potential system crashes.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Acked-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -6360,7 +6360,7 @@ static bool igb_clean_tx_irq(struct igb_
 			break;
 
 		/* prevent any other reads prior to eop_desc */
-		read_barrier_depends();
+		smp_rmb();
 
 		/* if DD is not set pending work has not been completed */
 		if (!(eop_desc->wb.status & cpu_to_le32(E1000_TXD_STAT_DD)))
